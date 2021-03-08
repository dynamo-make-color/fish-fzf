function __fzf_search_history -d "Search command history. Replace the command line with the selected command."
  # history merge incorporates history changes from other fish sessions
  builtin history merge
  set command_with_timestamp (
    builtin history -z --show-time="%H:%M:%S %d-%m | " |
      eval (__fzfcmd) "--read0 --print0 \
        --tiebreak=index \
        --preview='echo At {1..2}\nCommand: {4..}' \
        -q '"(commandline)"'" |
      string collect
  )

  if test $status -eq 0
    set command_selected (string split --max 1 " | " $command_with_timestamp)[2]
    commandline -- $command_selected
  end

  commandline -f repaint
end
