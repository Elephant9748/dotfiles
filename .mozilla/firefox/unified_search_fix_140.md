### unifiedSearchButton fix firefox 140
edit ``about:config``
```
browser.urlbar.unifiedSearchButton.always = true 
```
or in ``userChrome.css``
```
#urlbar-searchmode-switcher { position: static !important; }
```
