#!/system/bin/sh
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

if strings /dev/block/sda17 | grep -Eq "FYI3|GZD7"; then
    setprop vendor.firmware_flashable true
fi
