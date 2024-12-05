### :small_blue_diamond: using android as webcam

**load module to kernel**

```
sudo modprobe v4l2loopback video_nr=2 card_label=android_webcam exclusive_caps=1
```

**list v4l2 available**

```
v4l2-ctl --list-devices
```

**connecting adb devices to network**

initiate using usb:
```
adb tcpip [port]
```
connect adb to network
```
adb connect [ip android][port]
```

**run webcam**

front camera:
```
scrcpy --video-source=camera --camera-size=720x480 --camera-facing=front --camera-fps=30 --orientation=90 --no-audio --v4l2-sink=/dev/video2
```
back camera:
```
scrcpy --video-source=camera --camera-size=720x480 --camera-facing=back --camera-fps=30 --orientation=90 --no-audio --v4l2-sink=/dev/video2
```
default fps android ``30fps``

list camera available on android:
```
scrcpy --list-cameras
```

valid camera capture sizes:
```
scrcpy --list-camera-sizes
```


**unload module from kernel**

```
sudo modprobe -r v4l2loopback
```

