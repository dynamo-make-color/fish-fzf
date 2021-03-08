function __fzf_complete_options -d 'Show default options of fzf when using Tab completion'
  echo --info=inline
  echo --no-multi
  echo --bind tab:down,btab:up
  # TODO: Multiselect with some commands: echo --multi
  set -l file (status -f)
  set -l cmd (string escape --no-quoted (__fzf_complete_command))
  set -l full_cmd (commandline -co) (commandline -ct)
  if test $full_cmd[1] = "env"
    set cmd "env"
  end
  echo --delimiter=\\t --with-nth=1 --preview-window=right:wrap --preview="fish\ '$file'\ __fzf_complete_preview\ '$cmd'\ '{1}'\ '{2..}'"
end

test "$argv[1]" = "__fzf_complete_preview"; and __fzf_complete_preview $argv[2..4]
