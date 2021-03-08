function __fzf_complete_preview -d 'generate preview for completion widget.
  argv[1] is the currently command that need to selected preview
  argv[2] is the currently selected candidate in fzf
  argv[3] is a string containing the rest of the output produced by `complete -Ccmd`
  '
  set -l cmd $argv[1]
  set -l selected $argv[2]
  set -l information $argv[3]

  set -l path (string replace "~" $HOME -- $selected)

  # show aditional data
  if test -n $information
    echo $information\n
  end

  if test "$cmd" = "env"
    # show environment variables current value
    set -l evar (echo $selected | cut -d= -f1)
    echo $$evar
  end

  # list directories on preview
  if test -d "$path"
    echo "Folder"\n
    eval $FZF_PREVIEW_DIR_CMD (string escape $path)
    return
  end

  # show ten lines of non-binary files preview
  if test -f "$path"
    if grep -qI . "$path"
      echo "Text file"\n
      eval $FZF_PREVIEW_TEXT_FILE_CMD (string escape $path)
    else
      echo "Binary file"\n
      eval $FZF_PREVIEW_BINARY_FILE_CMD (string escape $path)
    end
    return
  end

  # if fish knows about it, let it show info
  string match -qr ".*\s.*" "$cmd"; and return
  type -q "$selected" 2>/dev/null; and type -a "$selected"
end
