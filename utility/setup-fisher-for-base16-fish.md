# base16-fish
[Base16](http://chriskempson.com/projects/base16/) theme switcher for [fish](https://fishshell.com) shell

## Installation
1. If you have [fisher](https://github.com/jorgebucaran/fisher),
```
$ fisher install tomyun/base16-fish
```

2. Run your choice of `base16-*` function
```
$ base16-oceanicnext
```

## Screenshot
![Screenshot](https://media.giphy.com/media/VboA2lb7ZJs4OgHjcH/giphy.gif)

## FAQ
1. Why not just use [base16-shell](https://github.com/chriskempson/base16-shell)?

`base16-shell` is great for bash/zsh, but unable to support [syntax highlighting colors](https://fishshell.com/docs/current/index.html#variables-color) in fish that ends up with incorrect coloring of texts typed in the prompt. `base16-fish` fixes this problem by explicitly setting color variables in native fish shell scripts. With that, no separate helper required in `config.fish`. No configuration file (`.base16_theme`) stored in your home directory. Theme switching commands (`base16-*`) are now fish functions that work more nicely with tab completetion.




# Switching to fish?

If you wish to use fish (or any other shell) as your default shell, you need to enter your new shell's executable /usr/local/bin/fish in two places:

    add /usr/local/bin/fish to /etc/shells
    change your default shell with chsh -s to /usr/local/bin/fish

You can use the following commands for this:
Add the fish shell /usr/local/bin/fish to /etc/shells with:

which fish
```
echo /usr/local/bin/fish | sudo tee -a /etc/shells
```
hange your default shell to fish with:
```
chsh -s /usr/local/bin/fish
```
