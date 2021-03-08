function __fzfcmd -d "Default command for fzf"
  test -n "$FZF_TMUX"; or set FZF_TMUX 0
  if test "$FZF_TMUX" -eq 1
    echo "fzf-tmux $FZF_TMUX_OPTS $FZF_DEFAULT_OPTS "
  else
    echo "fzf $FZF_DEFAULT_OPTS "
  end
end
