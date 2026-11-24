### fix firefox lock grey icon `about:config`

1. create autoconfig.js inside `/usr/lib/firefox/defaults/pref/` add:

   ```
   pref("general.config.filename", "firefox.cfg");
   pref("general.config.obscure_value", 0);
   ```

2. create firefox.cfg in `/usr/lib/firefox/`
   ```
   unlockPref("preference.name.here");
   ```
