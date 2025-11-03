#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Shipping API level
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)

# Call the proprietary setup
$(call inherit-product, vendor/samsung/s5e9925-common/s5e9925-common-vendor.mk)
