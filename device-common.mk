#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# All components inherited here go to system image
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# All components inherited here go to system_ext image
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

# All components inherited here go to product image
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# All components inherited here go to vendor image
$(call inherit-product, $(SRC_TARGET_DIR)/product/media_vendor.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_with_le_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usbv2.default \
    audio_effects.xml \
    audio_policy_configuration.xml

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# Init
PRODUCT_PACKAGES += \
    fstab.s5e9925 \
    fstab.s5e9925.vendor_ramdisk \
    init.recovery.s5e9925.rc \
    init.s5e9925.rc \
    init.samsung.rc \
    ueventd.s5e9925.rc

# Kernel
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# OTA
AB_OTA_UPDATER := false

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Permissions
PRODUCT_PACKAGES += \
    handheld_core_hardware.prebuilt.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore_V3.xml

# Platform
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_BRAND := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    bootable/deprecated-ota

# TEEgris
PRODUCT_PACKAGES += \
    init.s5e9925.tee.rc \
    tee.sh

# Call the proprietary setup
$(call inherit-product, vendor/samsung/s5e9925-common/s5e9925-common-vendor.mk)

# Call Samsung LSI board support package makefiles
$(call inherit-product, hardware/samsung_slsi-linaro/config/config.mk)
$(call inherit-product, hardware/samsung_slsi-linaro/graphics/base/hwcomposer_property.mk)
