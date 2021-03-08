# If FZF_DEFAULT_OPTS is not set, then set some sane defaults. This also affects fzf outside of this plugin.
# cycle allows jumping between the first and last results, making scrolling faster
# layout=reverse lists results top to bottom, mimicking the familiar layouts of git log, history, and env
# preview-window=wrap wraps long lines in the preview window, making reading easier
# marker="*" changes the multi-select marker
# prompt=" " changes the prompt to have powerline
# pointer="=>" changes the pointer
set --query FZF_DEFAULT_OPTS; or set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --preview-window=wrap --marker="*" --prompt=" " --pointer="=>"'

# If FZF_TMUX_OPTS is not set, then set some sane defaults.
# -p to set popup window instead of split plane by default
set --query FZF_TMUX_OPTS; or set -gx FZF_TMUX_OPTS "-p"

# Default command to preview file
set --query FZF_PREVIEW_TEXT_FILE_CMD
or if type -q bat
  set -gx FZF_PREVIEW_TEXT_FILE_CMD "bat --color=always --style='numbers,changes' --pager='less -FR'"
else
  set -gx FZF_PREVIEW_TEXT_FILE_CMD "cat"
end
set --query FZF_PREVIEW_BINARY_FILE_CMD; or set -gx FZF_PREVIEW_BINARY_FILE_CMD "file -i"

# Default command to preview folder
set --query FZF_PREVIEW_DIR_CMD
or if type -q exa
  set -gx FZF_PREVIEW_DIR_CMD "exa --color=always -l"
else
  set -gx FZF_PREVIEW_DIR_CMD "ls --color=always -l"
end

if not set --query fzf_fish_custom_keybindings
  # Tab for completion
  __fzf_binding \t '__fzf_complete'
  # Ctrl+R for search history
  __fzf_binding \cr '__fzf_search_history'
end
