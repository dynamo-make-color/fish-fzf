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
set --query FZF_PREVIEW_BINARY_FILE_CMD; or set -gx FZF_PREVIEW_BINARY_FILE_CMD "file -b"

# Default command to preview folder
set --query FZF_PREVIEW_DIR_CMD
or if type -q exa
  set -gx FZF_PREVIEW_DIR_CMD "exa --color=always -l"
else
  set -gx FZF_PREVIEW_DIR_CMD "ls --color=always -l"
end

# Default command to git diff file
if not set --query FZF_GIT_DIFF_FILE_CMD
  set -gx FZF_GIT_DIFF_FILE_CMD "git diff -- \$file"
  if type -q delta
    set -gx FZF_GIT_DIFF_FILE_CMD "$FZF_GIT_DIFF_FILE_CMD | delta"
  elif type -q diff-so-fancy
    set -gx FZF_GIT_DIFF_FILE_CMD "$FZF_GIT_DIFF_FILE_CMD | diff-so-fancy"
  end
end

# Default command to git show commit
if not set --query FZF_GIT_SHOW_CMD
  set -gx FZF_GIT_SHOW_CMD "git show --color=always --date=relative --abbrev-commit \$commit"
  if type -q delta
    set -gx FZF_GIT_SHOW_CMD "$FZF_GIT_SHOW_CMD | delta"
  elif type -q diff-so-fancy
    set -gx FZF_GIT_SHOW_CMD "$FZF_GIT_SHOW_CMD | diff-so-fancy"
  end
end

# Default command to git log
if not set --query FZF_GIT_LOG_CMD
  set -gx FZF_GIT_LOG_CMD "git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative --color=always \$branch"
  if type -q emojify
    set -gx FZF_GIT_LOG_CMD "$FZF_GIT_LOG_CMD | emojify"
  end
end

# Default command to git get URL of remote
set --query FZF_GIT_REMOTE_URL_CMD; or set -gx FZF_GIT_REMOTE_URL_CMD "git remote get-url \$remote"

# Default command to git show stash
set --query FZF_GIT_STASH_SHOW_CMD; or set -gx FZF_GIT_STASH_SHOW_CMD "git stash show -p --color=always \$stash"

if not set --query fzf_fish_custom_keybindings
  # Tab for completion
  __fzf_binding \t '__fzf_complete'
  # Ctrl+R for search history
  __fzf_binding \cr '__fzf_search_history'
end
