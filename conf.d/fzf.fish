# not used in non-interactive mode
if not status is-interactive
  exit
end

function _fzf_init -v fish_key_bindings
  if not set --query fzf_fish_custom_keybindings
    # Tab for completion
    __fzf_binding \t '__fzf_complete'
    # Ctrl+R for search history
    __fzf_binding \cr '__fzf_search_history'
    # Ctrl+F for search files
    __fzf_binding \cf '__fzf_search_file'
    # Ctrl+T for cd into subfolders
    __fzf_binding \ct '__fzf_cd'
  end
end

function _fzf_uninstall -e fzf_uninstall
  bind --user | string replace --filter --regex -- "bind (.+)( '?__fzf.*)" 'bind -e $1' | source
  set --names | string replace --filter --regex '(^FZF)' 'set --erase $1' | source
  functions --erase _fzf_uninstall
end

_fzf_init
