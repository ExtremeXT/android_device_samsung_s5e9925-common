#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/s5e9925-common',
    'hardware/samsung',
    'hardware/samsung_slsi-linaro/codec2',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'hardware/samsung_slsi-linaro/interfaces',
    'hardware/samsung_slsi-linaro/sgpu',
    'vendor/samsung/s5e9925-common',
]

blob_fixups: blob_fixups_user_type = {
    (
        'vendor/bin/hw/android.hardware.security.keymint-service.samsung',
        'vendor/lib64/lib_android_keymaster_skeymint_utils.so',
        'vendor/lib64/libskeymint.so',
        'vendor/lib64/libskeymint10device.so',
        'vendor/lib64/libskeymint_cli.so',
    ): blob_fixup()
        .replace_needed('android.hardware.security.keymint-V1-ndk_platform.so',
            'android.hardware.security.keymint-V1-ndk.so')
        .replace_needed('android.hardware.security.secureclock-V1-ndk_platform.so',
            'android.hardware.security.secureclock-V1-ndk.so')
        .replace_needed('android.hardware.security.sharedsecret-V1-ndk_platform.so',
             'android.hardware.security.sharedsecret-V1-ndk.so')
        .add_needed('android.hardware.security.rkp-V3-ndk.so')
        .replace_needed('libcrypto.so', 'libcrypto-tm.so')
        .add_needed('libshim_crypto.so')
        .add_needed('libbase_shim.so')
        .replace_needed('libkeymint.so', 'libskeymint.so')
        .replace_needed('lib_android_keymaster_keymint_utils.so',
            'lib_android_keymaster_skeymint_utils.so')
        .replace_needed('libkeymaster_portable.so',
            'libkeymaster_portable.samsung.so'),
    'vendor/etc/init/android.hardware.security.keymint-service.samsung.rc': blob_fixup()
        .regex_replace('android\\.hardware\\.security\\.keymint-service\n',
            'android.hardware.security.keymint-service.samsung\n'),
    'vendor/lib64/vendor.samsung.hardware.keymint-V1-ndk_platform.so': blob_fixup()
        .replace_needed('android.hardware.security.keymint-V1-ndk_platform.so',
            'android.hardware.security.keymint-V1-ndk.so')
        .add_needed('android.hardware.security.rkp-V3-ndk.so'),
    (
        'vendor/lib/hw/sound_trigger.primary.s5e9925.so',
        'vendor/lib/hw/audio.primary.s5e9925.so',
        'vendor/lib/libalsautils_sec.so',
        'vendor/lib/libaudioparamupdate.so',
        'vendor/lib/libaudioroute_samsung.so',
        'vendor/lib/soundfx/libaudioeffectoffload.so',
        'vendor/lib/libaboxpcmdump.so',
    ): blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute_samsung.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_samsung.so'),
    'vendor/lib/libaudioproxy2.so': blob_fixup()
        .remove_needed('libhwbinder.so')
        .replace_needed('libaudioroute.so', 'libaudioroute_samsung.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_samsung.so'),
    'vendor/lib/hw/vendor.samsung_slsi.hardware.ExynosA2DPOffload@3.0-impl.so': blob_fixup()
        .remove_needed('libhidltransport.so'),
    (
        'vendor/lib/hw/vulkan.samsung.so',
        'vendor/lib64/hw/vulkan.samsung.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getId')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
    'vendor/lib64/libSGPUOpenCL.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
    'vendor/lib64/egl/libGLESv2_samsung.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('ANativeWindow_getFormat'),
    'vendor/lib/libSGPUOpenCL.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
    'vendor/lib/egl/libGLESv2_samsung.so': blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('ANativeWindow_getFormat'),
    (
        'vendor/lib/hw/hwcomposer.s5e9925.so',
        'vendor/lib/libexynosdisplay.so',
        'vendor/lib/libExynosHWCService.so',
        'vendor/lib64/hw/hwcomposer.s5e9925.so',
        'vendor/lib64/libeis_core.so',
        'vendor/lib64/libexynosdisplay.so',
        'vendor/lib64/libExynosHWCService.so',
    ): blob_fixup()
        .add_needed('libutils-v32.so')
        .binary_regex_replace(b'_ZN7android6Thread3runEPKcim', b'_ZN7utils326Thread3runEPKcim'),
    'vendor/bin/hw/android.hardware.memtrack-service.exynos': blob_fixup()
        .replace_needed('android.hardware.memtrack-V1-ndk_platform.so', 'android.hardware.memtrack-V1-ndk.so'),
    (
        'vendor/lib/libsensorlistener.so',
        'vendor/lib/libvdis_core.so',
        'vendor/lib64/libsensorlistener.so',
        'vendor/lib64/libvdis_core.so',
    ): blob_fixup()
        .add_needed('libshim_sensorndkbridge.so')
        .add_needed('libutils-v32.so')
        .binary_regex_replace(b'_ZN7android6Thread3runEPKcim', b'_ZN7utils326Thread3runEPKcim'),
    'vendor/lib64/libwvhidl.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-lite-3.9.1.so', 'libprotobuf-cpp-full-3.9.1.so'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-full-21.7.so', 'libprotobuf-cpp-full-21.12.so')
        .sig_replace(
            '0E 40 F9 E1 03 16 AA 82 0C 80 52 E3 03 15 AA',
            '0E 40 F9 E1 03 16 AA 82 0c 80 52 03 00 80 D2'),
}  # fmt: skip

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libuuid': lib_fixup_vendor_suffix,
    'libvibrator': lib_fixup_vendor_suffix,
}

module = ExtractUtilsModule(
    's5e9925-common',
    'samsung',
    namespace_imports=namespace_imports,
    lib_fixups=lib_fixups,
    blob_fixups=blob_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
