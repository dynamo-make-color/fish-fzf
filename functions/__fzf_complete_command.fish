function __fzf_complete_command -d 'Get exactly command for Tab completion'
  # As of 2.6, fish's "complete" function does not understand
  # subcommands. Instead, we use the same hack as __fish_complete_subcommand and
  # extract the subcommand manually.
  set -l cmd (commandline -co) (commandline -ct)

  switch $cmd[1]
    case env sudo
      for i in (seq 2 (count $cmd))
        switch $cmd[$i]
          case '-*'
          case '*=*'
          case '*'
            set cmd $cmd[$i..-1]
            break
        end
      end
  end

  echo (string join -- ' ' $cmd)
end
