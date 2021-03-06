if not set --query fzf_fish_custom_keybindings
  # Tab for completion
  __fzf_binding \t '__fzf_complete'
  # Ctrl+R for search history
  __fzf_binding \cr '__fzf_search_history'
  # Ctrl+F for search files and folders
  __fzf_binding \cr '__fzf_search_file'
end

function _fzf_uninstall -e fzf_uninstall
  bind --user | string replace --filter --regex -- "bind (.+)( '?__fzf.*)" 'bind -e $1' | source
  set --names | string replace --filter --regex '(^FZF)' 'set --erase $1' | source
  functions --erase _fzf_uninstall
end
