function __fzf_complete_preview -d 'generate preview for completion widget.
  argv[1] is the currently command that need to selected preview
  argv[2] is the currently selected candidate in fzf
  argv[3] is a string containing the rest of the output produced by `complete -Ccmd`
  '
  set -l cmd $argv[1]
  set -l selected $argv[2]
  set -l information $argv[3]

  # show aditional data
  if test -n $information
    echo $information\n
  end

  if test "$cmd" = "env"
    # show environment variables current value
    set -l evar (echo $selected | cut -d= -f1)
    echo $$evar
  end

  __fzf_preview_git "$cmd" "$selected" "$information"; and return
  __fzf_preview_file "$selected"; and return

  # if fish knows about it, let it show info
  string match -qr ".*\s.*" "$cmd"; and return
  type -q "$selected" 2>/dev/null; and type -a "$selected"
end
