function __fzf_complete -d 'fzf completion and print selection back to commandline'
  set -l cmd (__fzf_complete_command)
  set -l cmd_last_word (string split ' ' -- $cmd)[-1]

  set -l initial_query ''
  test -n "$cmd_last_word"; and set initial_query --query="$cmd_last_word"

  set -l complete_list (complete -C$cmd)
  set -l result

  # do nothing if there is nothing to select from
  test -z "$complete_list"; and return

  set -l complete_list_count (echo $complete_list | wc -w)
  if test $complete_list_count -eq 1
    # if there is only one option dont open fzf
    set result "$complete_list"
  else
    set -l query
    string join -- \n $complete_list |
      eval (__fzfcmd) (string escape --no-quoted -- $initial_query) --print-query (__fzf_complete_options) |
      cut -f1 |
      while read -l r
        # first line is the user entered query
        if test -z "$query"
          set query $r
          # rest of lines are selected candidates
        else
          set result $result $r
        end
      end

    # exit if user canceled
    if test -z "$query" ;and test -z "$result"
      commandline -f repaint
      return
    end

    # if user accepted but no candidate matches, use the input as result
    if test -z "$result"
      set result $query
    end
  end

  set prefix (string sub -s 1 -l 1 -- (commandline -t))
  for i in (seq (count $result))
    set -l r $result[$i]
    switch $prefix
      case "'"
        commandline -t -- (string escape -- $r)
      case '"'
        if string match '*"*' -- $r >/dev/null
          commandline -t --  (string escape -- $r)
        else
          commandline -t -- '"'$r'"'
        end
      case '~'
        commandline -t -- (string sub -s 2 (string escape -n -- $r))
      case '*'
        commandline -t -- $r
    end
    [ $i -lt (count $result) ]; and commandline -i ' '
  end

  commandline -f repaint
end
