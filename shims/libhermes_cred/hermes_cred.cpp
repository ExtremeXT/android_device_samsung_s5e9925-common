/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

namespace android::hardware {
template <typename>
struct hidl_vec {};
}  // namespace android::hardware

using android::hardware::hidl_vec;

unsigned int hermes_put_persistent_cred(hidl_vec<unsigned char>&, hidl_vec<unsigned char>&) {
    return 1000;  // "hermes_cred", "!@ %s(%d) cannot put persistent cred hal"
}
