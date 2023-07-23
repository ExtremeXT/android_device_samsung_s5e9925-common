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
    audio.primary.s5e9925 \
    audio.r_submix.default \
    audio.usbv2.default \
    SamsungDAP \
    audio_effects.xml \
    audio_policy_configuration.xml

TARGET_EXCLUDES_AUDIOFX := true

$(call soong_config_set_bool,exynos_audio,support_direct_multi_channel_stream,true)
$(call soong_config_set_bool,exynos_audio,use_camcorder_quad_mic,true)
$(call soong_config_set_bool,exynos_audio,use_offload_effect_library,true)
$(call soong_config_set_bool,exynos_audio,use_quad_mic,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_dynamic_nrec,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_samsungrecord,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_support_gamechat_spk_aec,true)
$(call soong_config_set_bool,exynos_audio,use_sec_audio_support_listenback_dspeffect,true)
$(call soong_config_set_bool,exynos_audio,use_soundtrigger_hal,true)
$(call soong_config_set_bool,exynos_audio,use_usb_offload,true)
$(call soong_config_set,exynos_audio,proxy_header,//$(LOCAL_PATH):audio_proxy_headers)
$(call soong_config_set,exynos_audio,sec_resampler_library,//vendor/samsung/s5e9925-common:libSamsungPostProcessConvertor)

# Codec2
PRODUCT_PACKAGES += \
    samsung.hardware.media.c2-service \
    libExynosC2Av1Dec \
    libExynosC2H264Dec \
    libExynosC2H264Enc \
    libExynosC2HevcDec \
    libExynosC2HevcEnc \
    libExynosC2Vp8Dec \
    libExynosC2Vp8Enc \
    libExynosC2Vp9Dec \
    libExynosC2Vp9Enc \
    media_codecs_c2.xml \
    media_codecs_performance_c2.xml \
    media_profiles_V1_0.xml

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider-service.samsung

$(call soong_config_set_bool,samsungCameraVars,usage_64bit,true)

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.composer.hwc3-service.slsi \
    android.hardware.graphics.allocator-aidl-service-sgr \
    android.hardware.graphics.mapper@4.0-impl-sgr \
    android.hardware.memtrack-service.exynos \
    libdrm_sgpu \
    vendor.samsung_slsi.hardware.SbwcDecompService-service

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.samsung \
    android.hardware.health-service.samsung-recovery \
    vendor.lineage.health-service.default

$(call soong_config_set_bool,lineage_health,charging_control_charging_bypass,true)
$(call soong_config_set_bool,lineage_health,charging_control_charging_deadline,false)
$(call soong_config_set_bool,lineage_health,charging_control_charging_toggle,true)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,1)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/charging_enabled)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/sec/switch/afc_disable)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,0)
$(call soong_config_set,lineage_health,fast_charge_value_none,1)

# HIDL
PRODUCT_PACKAGES += \
    vndservicemanager

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

# Linker
PRODUCT_PACKAGES += \
    public.libraries.txt

# OTA
AB_OTA_UPDATER := false

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \

PRODUCT_PACKAGES += \
    android.hardware.audio.low_latency.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml \
    android.hardware.camera.concurrent.prebuilt.xml \
    android.hardware.camera.flash-autofocus.prebuilt.xml \
    android.hardware.camera.full.prebuilt.xml \
    android.hardware.camera.raw.prebuilt.xml \
    android.hardware.hardware_keystore_V3.xml \
    android.hardware.sensor.barometer.prebuilt.xml \
    android.hardware.sensor.compass.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.hifi_sensors.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml \
    android.hardware.sensor.stepcounter.prebuilt.xml \
    android.hardware.sensor.stepdetector.prebuilt.xml \
    android.hardware.usb.accessory.prebuilt.xml \
    android.hardware.usb.host.prebuilt.xml \
    android.hardware.vulkan.compute-0.prebuilt.xml \
    android.hardware.vulkan.level-1.prebuilt.xml \
    android.hardware.vulkan.version-1_3.prebuilt.xml \
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
    bootable/deprecated-ota \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/samsung \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1 \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1/proxy

# TEEgris
PRODUCT_PACKAGES += \
    init.s5e9925.tee.rc \
    tee.sh

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.pixel \
    thermal_info_config.json \
    thermal_symlinks

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
