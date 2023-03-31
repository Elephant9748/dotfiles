###Switching to fish ?
Add the fish shell /usr/local/bin/fish to /etc/shells with:
```
echo /usr/local/bin/fish | sudo tee -a /etc/shells
```

Change your default shell to fish with:
```
chsh -s /usr/local/bin/fish
```



