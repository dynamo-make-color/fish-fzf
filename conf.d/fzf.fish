# If FZF_DEFAULT_OPTS is not set, then set some sane defaults. This also affects fzf outside of this plugin.
if not set --query FZF_DEFAULT_OPTS
  # cycle allows jumping between the first and last results, making scrolling faster
  # layout=reverse lists results top to bottom, mimicking the familiar layouts of git log, history, and env
  # preview-window=wrap wraps long lines in the preview window, making reading easier
  # marker="*" changes the multi-select marker
  # prompt=" " changes the prompt to have powerline
  # pointer="=>" changes the pointer
  set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --preview-window=wrap --marker="*" --prompt=" " --pointer="=>"'
end

# If FZF_TMUX_OPTS is not set, then set some sane defaults.
if not set --query FZF_TMUX_OPTS
  # -p to set popup window instead of split plane by default
  set -gx FZF_TMUX_OPTS "-p"
end

if not set --query fzf_fish_custom_keybindings
  # Ctrl+R for search history
  bind \cr '__fzf_search_history'

  if test "$fish_key_bindings" = fish_vi_key_bindings
    bind -M insert \cr '__fzf_search_history'
  end
end
