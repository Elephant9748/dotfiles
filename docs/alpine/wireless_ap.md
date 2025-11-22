## eth0(internet) -> wlan0
   packages:
   ```
   sudo apk add hostapd dnsmasq wireless-tools wpa_supplicant iptables
   ```

  1. Enable IP Forwarding
        
       edit ``/etc/sysctl.conf`` and uncomment: ``net.ipv4.ip_forward=1``

       Apply:
       ```
       sudo sysctl -p
       ```
  2. Network Configuration
       ```
       auto lo
       iface lo inet loopback

       auto eth0
       iface eth0 inet dhcp

       auto wlan0
       iface wlan0 inet static
           address 192.168.20.1
           netmask 255.255.255.0
       ```
       * need ``rc-service networking restart`` to get an ip wlan0

   3. Configure the Access Point
       /etc/hostapd/hostapd.conf
       ```
       interface=wlan0
       logger_syslog=-1
       logger_syslog_level=2
       logger_stdout=-1
       logger_stdout_level=2
       ctrl_interface=/var/run/hostapd
       ctrl_interface_group=0
       hw_mode=g
       channel=7
       beacon_int=100
       dtim_period=2
       max_num_sta=25
       rts_threshold=2347
       fragm_threshold=2346
       macaddr_acl=0
       auth_algs=3
       ignore_broadcast_ssid=0
       442  wmm_enabled=1
       wmm_ac_bk_cwmin=4
       wmm_ac_bk_cwmax=10
       wmm_ac_bk_aifs=7
       wmm_ac_bk_txop_limit=0
       wmm_ac_bk_acm=0
       wmm_ac_be_aifs=3
       wmm_ac_be_cwmin=4
       wmm_ac_be_cwmax=10
       wmm_ac_be_txop_limit=0
       wmm_ac_be_acm=0
       wmm_ac_vi_aifs=2
       wmm_ac_vi_cwmin=3
       wmm_ac_vi_cwmax=4
       wmm_ac_vi_txop_limit=94
       wmm_ac_vi_acm=0
       wmm_ac_vo_aifs=2
       wmm_ac_vo_cwmin=2
       wmm_ac_vo_cwmax=3
       wmm_ac_vo_txop_limit=47
       wmm_ac_vo_acm=0
       eapol_key_index_workaround=0
       eap_server=0
       own_ip_addr=127.0.0.1
       wpa_passphrase=YOUR_PASSPHRASE
       wpa=3
       wpa_key_mgmt=WPA-PSK WPA-PSK-SHA256
       wpa_pairwise=TKIP CCMP
       ssid=earendel_wifi
       ```
       Manually ``sudo hostapd /etc/hostapd/hostapd.conf``

       Enable hostapd ``rc-update add hostapd default``

       Enable when boot``rc-update add hostapd default``

       *Optional generate passphrase psk ``wpa_passphrase "SSID" "PSK"``, ucomment wpa_passphrase replace with:
       ```
       wpa_psk=VALUE OF PSK
       ```

  4. Set up NAT with iptables
       ```
       sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
       sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
       sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
       ```
       Enable iptables when boot ``sudo rc-update add iptables default``

       Make current iptables entries persistent ``sudo rc-service iptables save``

  5. Dnsmasq Configuration
       Edit ``/etc/dnsmasq.conf`` **if need some internet from eth0**
       ```
       local-service

       interface=wlan0
       dhcp-range=192.168.20.2,192.168.20.50,255.255.255.0,24h
       dhcp-option=option:router,192.168.20.1
       dhcp-option=option:dns-server,192.168.20.1,194.242.2.4

       conf-dir=/etc/dnsmasq.d/,*.conf

       ```
       Enable dnsmasq ``sudo rc-service dnsmasq start``

       Enable when boot ``sudo rc-update add dnsmasq default``

