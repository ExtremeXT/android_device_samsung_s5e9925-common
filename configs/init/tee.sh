#!/vendor/bin/sh

# A ROM called "BeyondROM" has mandated their users to update the firmware to the latest One UI 8 release (except sboot.bin).
# Users cannot flash the required (One UI 7) firmware anymore, hence we have to dynamically select the proper firmware blobs. 
# We cannot use ro.bootloader as it comes from the old sboot.bin, but we can check in "radio".
# If they don't, a system property will be set which will be used later to bind mount the correct TEEgris folder.
if ! strings /dev/block/by-name/radio | grep -q FYI3; then
    setprop dev.teegris.model new
fi
