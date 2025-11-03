#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/samsung/s5e9925-common

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := universal9925
TARGET_BOOTLOADER_BOARD_NAME := s5e9925
TARGET_SOC := s5e9925
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Security
VENDOR_SECURITY_PATCH := 2025-09-01

# VINTF
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/configs/vintf/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(COMMON_PATH)/configs/vintf/compatibility_matrix.device.xml \
    hardware/samsung/vintf/samsung_framework_compatibility_matrix.xml

# Call the proprietary setup
include vendor/samsung/s5e9925-common/BoardConfigVendor.mk
