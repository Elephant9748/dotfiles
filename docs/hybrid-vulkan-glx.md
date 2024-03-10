## Hybrid

Hybrid graphics mode uses both the integrated GPU and the discrete NVIDIA GPU. Applications will use the integrated GPU unless explicitly requested to use the discrete GPU.

# Vulkan applications must be launched with this command to be rendered on the dGPU (NVIDIA):
```
__NV_PRIME_RENDER_OFFLOAD=1 <application>
```
# GLX applications must be launched with this command to be rendered on the dGPU (NVIDIA):
```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia <application>
```
Hybrid graphics mode is available on 19.10 and later.
