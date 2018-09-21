#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Platform
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_BRAND := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Call the proprietary setup
$(call inherit-product, vendor/samsung/s5e9925-common/s5e9925-common-vendor.mk)

# Call Samsung LSI board support package makefiles
$(call inherit-product, hardware/samsung_slsi-linaro/config/config.mk)
$(call inherit-product, hardware/samsung_slsi-linaro/graphics/base/hwcomposer_property.mk)
