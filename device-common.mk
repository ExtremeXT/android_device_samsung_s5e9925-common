#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_TARGETS := *

# Shipping API level
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)

# Call the proprietary setup
$(call inherit-product, vendor/samsung/s5e9925-common/s5e9925-common-vendor.mk)
