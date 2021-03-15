function __fzf_preview_file -d 'preview file/folders in completion widget.
  argv[1] is currently selected candidate in fzf
  '
  set -l path (string replace "~" $HOME -- $argv[1])

  # list directories on preview
  if test -d "$path"
    echo "Folder"\n
    eval $FZF_PREVIEW_DIR_CMD (string escape $path)
    return
  end

  # print content of file or show mime type on preview
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

  return 1
end
