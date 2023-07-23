#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import tempfile

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
    run_cmd,
)

from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    DEFAULT_PATCHELF_VERSION,
    patchelf_version_path_map,
)

namespace_imports = [
    'device/samsung/s5e9925-common',
    'hardware/samsung',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'hardware/samsung_slsi-linaro/sgpu',
    'vendor/samsung/s5e9925-common',
]


def rename_dynamic_symbol(
    _ctx: BlobFixupCtx,
    _file: File,
    file_path: str,
    old_name: str,
    new_name: str,
    **_kwargs,
):
    with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8') as tmp:
        tmp.write(f'{old_name} {new_name}')
        tmp.flush()
        run_cmd(
            [
                patchelf_version_path_map[DEFAULT_PATCHELF_VERSION],
                '--rename-dynamic-symbols',
                tmp.name,
                file_path,
            ]
        )


blob_fixups: blob_fixups_user_type = {
    'vendor/bin/hermesd': blob_fixup()
        .binary_regex_replace(b'security.securehw.available', b'vendor.s.securehw.available')
        .binary_regex_replace(b'security.securenvm.available', b'vendor.s.securenvm.available'),
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
        .add_needed('libbase_shim.so')
        .replace_needed('libkeymint.so', 'libskeymint.so')
        .replace_needed('lib_android_keymaster_keymint_utils.so',
            'lib_android_keymaster_skeymint_utils.so')
        .replace_needed('libkeymaster_portable.so',
            'libkeymaster_portable.samsung.so'),
    (
        'vendor/lib64/libskeymint10device.so',
        'vendor/lib64/libskeymint_cli.so',
    ): blob_fixup()
        .call(rename_dynamic_symbol, 'OPENSSL_sk_new_null', 'sk_new_null')
        .call(rename_dynamic_symbol, 'OPENSSL_sk_num', 'sk_num')
        .call(rename_dynamic_symbol, 'OPENSSL_sk_push', 'sk_push')
        .call(rename_dynamic_symbol, 'OPENSSL_sk_value', 'sk_value'),
    'vendor/etc/init/android.hardware.security.keymint-service.samsung.rc': blob_fixup()
        .regex_replace('-service', '-service.samsung'),
    'vendor/lib64/vendor.samsung.hardware.keymint-V1-ndk_platform.so': blob_fixup()
        .replace_needed('android.hardware.security.keymint-V1-ndk_platform.so',
            'android.hardware.security.keymint-V1-ndk.so')
        .add_needed('android.hardware.security.rkp-V3-ndk.so'),
    (
        'vendor/lib64/hw/vulkan.samsung.so',
        'vendor/lib64/libSGPUOpenCL.so',
        'vendor/lib64/egl/libGLESv2_samsung.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getId')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('ANativeWindow_getFormat'),
    'vendor/lib64/libsensorlistener.so': blob_fixup()
        .add_needed('libshim_sensorndkbridge.so')
        .add_needed('libutils-v32.so')
        .binary_regex_replace(b'_ZN7android6Thread3runEPKcim', b'_ZN7utils326Thread3runEPKcim'),
    'vendor/lib64/libwvhidl.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-lite-3.9.1.so', 'libprotobuf-cpp-full-3.9.1.so'),
}  # fmt: skip

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libuuid': lib_fixup_vendor_suffix,
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
