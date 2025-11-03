#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/samsung/s5e9925-common

# OTA
TARGET_OTA_ASSERT_DEVICE := $(TARGET_DEVICE)

# Security
VENDOR_SECURITY_PATCH := 2025-11-01

# Call the proprietary setup
include vendor/samsung/s5e9925-common/BoardConfigVendor.mk
