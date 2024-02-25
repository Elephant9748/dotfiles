### stop autostart nextcloud
'usr/share/applications/com.nextcloud.desktopclient.nextcloud.desktop'
<br>
comment out or delete this line: 
```
Implements=org.freedesktop.CloudProviders

[org.freedesktop.CloudProviders]
BusName=com.nextcloudgmbh.Nextcloud
ObjectPath=/com/nextcloudgmbh/Nextcloud
```

reference:
https://github.com/nextcloud/desktop/issues/1982
https://github.com/nextcloud/desktop/issues/2613
