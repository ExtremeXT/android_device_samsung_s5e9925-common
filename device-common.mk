#
# Copyright (C) The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit generic products. Most specific first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

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
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
	android.hardware.soundtrigger@2.3-impl \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usbv2.default \
	SamsungDAP \
    audio_effects.xml \
    audio_policy_configuration.xml \
	mixer_paths.xml

TARGET_EXCLUDES_AUDIOFX := true

# Configstore
PRODUCT_PACKAGES += \
    disable_configstore

# Charger
PRODUCT_PACKAGES += \
    charger_res_images_vendor

# Codec2
PRODUCT_PACKAGES += \
    samsung.hardware.media.c2-service \
    libExynosC2H264Dec \
    libExynosC2H264Enc \
    libExynosC2HevcDec \
    libExynosC2HevcEnc \
    libExynosC2Vp8Dec \
    libExynosC2Vp8Enc \
    libExynosC2Vp9Dec \
    libExynosC2Vp9Enc \
    libExynosC2Av1Dec \
    media_codecs_c2.xml \
    media_codecs_performance_c2.xml \
    media_profiles_V1_0.xml

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider-service.samsung

$(call soong_config_set_bool,samsungCameraVars,usage_64bit,true)

# Doze
PRODUCT_PACKAGES += \
    SamsungDoze

# DRM
PRODUCT_PACKAGES += \
    com.android.hardware.drm.clearkey

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# EPIC
PRODUCT_PACKAGES += \
	libepicoperator

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung \
    init.fingerprint.rc

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.composer.hwc3-service.slsi \
    android.hardware.graphics.allocator@4.0-service-sgr \
    android.hardware.graphics.mapper@4.0-impl-sgr \
    android.hardware.memtrack-service.exynos \
	libdrm_sgpu \
    vendor.samsung_slsi.hardware.SbwcDecompService@1.0-service

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.samsung \
    android.hardware.health-service.samsung-recovery \
    vendor.lineage.health-service.default

$(call soong_config_set_bool,lineage_health,charging_control_charging_bypass,true)
$(call soong_config_set_bool,lineage_health,charging_control_charging_deadline,false)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,1)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/charging_enabled)
$(call soong_config_set_bool,lineage_health,charging_control_charging_toggle,true)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/sec/switch/afc_disable)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,0)
$(call soong_config_set,lineage_health,fast_charge_value_none,1)

# HIDL
PRODUCT_PACKAGES += \
    vndservicemanager

# Init
PRODUCT_PACKAGES += \
    fstab.s5e9925 \
	init.recovery.s5e9925.rc \
    init.s5e9925.rc \
	init.samsung.rc \
    ueventd.s5e9925.rc

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/init/fstab.s5e9925:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.s5e9925 \
	$(LOCAL_PATH)/configs/init/fstab.s5e9925:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.s5e9925

# Kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true
PRODUCT_ENABLE_UFFD_GC := true

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# Linker
PRODUCT_PACKAGES += \
    public.libraries.txt

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay-service.samsung-exynos

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp \
    android.hardware.secure_element-service.nxp \
    com.android.nfc_extras \
    libchrome.vendor \
    Tag \
    init.nfc.samsung.rc \
    libese-nxp.conf \
    libnfc-nxp.conf \
    libnfc-nxp_RF.conf

# OTA
AB_OTA_UPDATER := false
PRODUCT_SOONG_NAMESPACES += bootable/deprecated-ota

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.satellite.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

PRODUCT_PACKAGES += \
    android.hardware.audio.low_latency.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml \
    android.hardware.camera.concurrent.prebuilt.xml \
    android.hardware.camera.flash-autofocus.prebuilt.xml \
    android.hardware.camera.full.prebuilt.xml \
    android.hardware.camera.raw.prebuilt.xml \
    android.hardware.fingerprint.prebuilt.xml \
    android.hardware.hardware_keystore_V3.xml \
    android.hardware.location.gps.prebuilt.xml \
    android.hardware.nfc.hce.prebuilt.xml \
    android.hardware.nfc.prebuilt.xml \
    android.hardware.se.omapi.ese.prebuilt.xml \
    android.hardware.se.omapi.uicc.prebuilt.xml \
    android.hardware.sensor.barometer.prebuilt.xml \
    android.hardware.sensor.compass.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.hifi_sensors.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml \
    android.hardware.sensor.stepcounter.prebuilt.xml \
    android.hardware.sensor.stepdetector.prebuilt.xml \
    android.hardware.telephony.gsm.prebuilt.xml \
    android.hardware.usb.accessory.prebuilt.xml \
    android.hardware.usb.host.prebuilt.xml \
    android.hardware.vulkan.compute-0.prebuilt.xml \
    android.hardware.vulkan.level-1.prebuilt.xml \
    android.hardware.vulkan.version-1_3.prebuilt.xml \
    android.hardware.wifi.direct.prebuilt.xml \
    android.hardware.wifi.passpoint.prebuilt.xml \
    android.hardware.wifi.prebuilt.xml \
    android.software.ipsec_tunnels.prebuilt.xml \
    android.software.opengles.deqp.level-2021-03-01.prebuilt.xml \
    android.software.vulkan.deqp.level-2021-03-01.prebuilt.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr \
    powerhint.json

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.samsung

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat

# RIL
PRODUCT_PACKAGES += \
    cbd \
    secril_config_svc \
    sehradiomanager \
    sehradiomanager.conf

$(call soong_config_set,cbd,protocol,sipc)

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.samsung-multihal \
    hals.conf

# Shipping API level
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel \
	hardware/samsung \
    hardware/samsung_slsi-linaro/exynos/cpboot_v3

# TEEgris
PRODUCT_PACKAGES += \
    init.s5e9925.tee.rc \
    tee.sh

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.pixel \
    thermal_info_config.json \
    thermal_symlinks

# TSP
PRODUCT_PACKAGES += \
    init.tsp.rc \
    vendor.lineage.touch-service.samsung


# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.samsung \
    android.hardware.usb.gadget-service.samsung \
    init.s5e9925.usb.rc

$(call soong_config_set,samsungUsbGadgetVars,gadget_name,10b00000.dwc3)

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.samsung

# Call the proprietary setup
$(call inherit-product, vendor/samsung/s5e9925-common/s5e9925-common-vendor.mk)

# Call Samsung LSI board support package makefiles
$(call inherit-product, hardware/samsung_slsi-linaro/graphics/base/hwcomposer_property.mk)
$(call inherit-product, hardware/samsung_slsi-linaro/config/config.mk)
