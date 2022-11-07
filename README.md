# fzf
Integrate [fzf](https://github.com/junegunn/fzf) (command-line fuzzy finder) functionality into [fish](https://github.com/fish-shell/fish-shell).

## Installation

### System Requirements

- [fzf](https://github.com/junegunn/fzf)
- [fish](https://github.com/fish-shell/fish-shell)
- [fisher](https://github.com/jorgebucaran/fisher)

Install by following command:
```fish
fisher install dynamo-make-color/fish-fzf
```

Add these line after your PATH setup in your ~/.config/fish/config.fish:
```fish
if test -e $HOME/.config/fish/conf.d/fzf.fish
  __fzf_setup
end
```

### Other tools

You can install following command tools to give more performance of your shell:

- [bat](https://github.com/sharkdp/bat): Show files in fzf preview, replacement for `cat` with some robust features
- [exa](https://github.com/ogham/exa): Show folder in fzf preview, replacement for `ls`
- [delta](https://github.com/dandavison/delta) or [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy): Show git diff with human readable in fzf preview
- [emojify](mrowa44/emojify): Show emoji in fzf preview


## Quickstart
| Key bindings | Remarks |
|--------------|---------|
| Ctrl + R | Search through command history from all interactive sessions of Fish |
| Ctrl + F | Search files |
