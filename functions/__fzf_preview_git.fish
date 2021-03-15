function __fzf_preview_git -d 'preview git file/folders in completion widget.
  argv[1] is the currently command that need to selected preview
  argv[2] is the currently selected candidate in fzf
  argv[3] is a string containing the rest of the output produced by `complete -Ccmd`
  '
  set -l cmd $argv[1]
  set -l selected $argv[2]
  set -l information $argv[3..]

  if not __fish_is_git_repository
    return 1
  end

  if test -n $information
    if string match -qr '^[[:alpha:]]+ file$' $information
    and test $information != 'Untracked file'
      set -l file (string escape $selected)
      eval $FZF_GIT_DIFF_FILE_CMD
      return
    else if string match -qr '^[[:alpha:]]+ Branch$' $information; or test $information = 'Head'
      set -l branch $selected
      eval $FZF_GIT_LOG_CMD
      return
    else if test $information = 'Remote'
      set -l remote $selected
      eval $FZF_GIT_REMOTE_URL_CMD
      return
    else if string match -qr '^Commit.*$' $information; or test $information = 'Tag'
      set -l commit $selected
      eval $FZF_GIT_SHOW_CMD
      return
    else if string match -qr '^Stash.*$' $information
      set -l stash $selected[2..-1]
      eval $FZF_GIT_STASH_SHOW_CMD
      return
    end
  end

  return 1
end
