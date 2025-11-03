#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/samsung/s5e9925-common

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := s5e9925
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)
TARGET_SOC := $(TARGET_BOARD_PLATFORM)
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Security
VENDOR_SECURITY_PATCH := 2026-02-01

# VINTF
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/configs/vintf/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(COMMON_PATH)/configs/vintf/compatibility_matrix.device.xml \
    hardware/samsung/vintf/samsung_framework_compatibility_matrix.xml
