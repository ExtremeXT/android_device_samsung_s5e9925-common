#!/bin/env python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import common
import re

def FullOTA_Assertions(info):
    OTA_Assertions(info)

def FullOTA_InstallEnd(info):
    OTA_InstallEnd(info)
    return

def IncrementalOTA_Assertions(info):
    OTA_Assertions(info)

def IncrementalOTA_InstallEnd(info):
    info.input_zip = info.target_zip
    OTA_InstallEnd(info)
    return

def AddImage(info, basename, dest):
    data = info.input_zip.read("IMAGES/" + basename)
    common.ZipWriteStr(info.output_zip, basename, data)
    info.script.Print("Patching {} image unconditionally...".format(dest.split('/')[-1]))
    info.script.AppendExtra('package_extract_file("%s", "%s");' % (basename, dest))

def OTA_Assertions(info):
    info.script.AppendExtra('if getprop("vendor.firmware_flashable") != "true" then')
    info.script.AppendExtra('abort("E3004: This package requires S90*BXXSIFYI3|S90*BXXSNGZD7 firmware");')
    info.script.AppendExtra('endif;')
    pass

def OTA_InstallEnd(info):
    AddImage(info, "dtbo.img", "/dev/block/by-name/dtbo")
    AddImage(info, "vbmeta.img", "/dev/block/by-name/vbmeta")
    AddImage(info, "vendor_boot.img", "/dev/block/by-name/vendor_boot")
    return
