### Disabling locked toolkit.telemetry.enabled
1. add line `[firefox_install_dir]/defaults/pref/channel-prefs.js` with:
```
// control logpref
pref("general.config.obscure_value", 0);
pref("general.config.filename", "firefoxdeveloperedition.js");
```

2. create file `[firefox_install_dir]/firefoxdeveloperedition.js` 
```
//
lockPref("toolkit.telemetry.enabled", false);
```

ref: [KOLANICH](https://github.com/The-OP/Fox/issues/156)
bugzilla: [bug](https://bugzilla.mozilla.org/show_bug.cgi?id=1422689)
