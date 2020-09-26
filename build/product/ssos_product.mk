#
# Copyright (C) 2020 Raphielscape LLC. and Haruka LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This makefile is the basis of a generic system image for a handheld device.
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Inherit ssos products.
$(call inherit-product, vendor/ssos/build/product/handheld_system.mk)
$(call inherit-product, vendor/ssos/config/common_telephony.mk)

# Shared java libs
PRODUCT_PACKAGES += \
    com.android.nfc_extras

# Framework overlays
PRODUCT_PACKAGES += \
    frameworks-base-overlays

# Debug framework overlays
PRODUCT_PACKAGES_DEBUG += \
    frameworks-base-overlays-debug

# Applications
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PartnerBookmarksProvider \
    PresencePolling \
    QuickAccessWallet \
    RcsService \
    SafetyRegulatoryInfo \
    Stk \
    TimeZoneUpdater

# Binaries
PRODUCT_PACKAGES += llkd

# OTA support
PRODUCT_PACKAGES += \
    recovery-refresh \
    update_engine \
    update_verifier

# Wrapped net utils for /vendor access.
PRODUCT_PACKAGES += netutils-wrapper-1.0

# Charger images
PRODUCT_PACKAGES += charger_res_images

# system_other support
PRODUCT_PACKAGES += \
    cppreopts.sh \
    otapreopt_script

# Bluetooth libraries
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.hearing_aid.default

# For ringtones that rely on forward lock encryption
PRODUCT_PACKAGES += libfwdlockengine

# System libraries commonly depended on by things on the system_ext or product partitions.
# These lists will be pruned periodically.
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.radio@1.0 \
    android.hardware.radio@1.1 \
    android.hardware.radio@1.2 \
    android.hardware.radio@1.3 \
    android.hardware.radio@1.4 \
    android.hardware.radio.config@1.0 \
    android.hardware.radio.deprecated@1.0 \
    android.hardware.secure_element@1.0 \
    android.hardware.wifi@1.0 \
    libaudio-resampler \
    libaudiohal \
    libdrm \
    liblogwrap \
    liblz4 \
    libminui \
    libnl \
    libprotobuf-cpp-full

# These libraries are empty and have been combined into libhidlbase, but are still depended
# on by things off /system.
# TODO(b/135686713): remove these
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder

PRODUCT_PACKAGES_DEBUG += \
    avbctl \
    bootctl \
    tinyplay \
    tinycap \
    tinymix \
    tinypcminfo \
    update_engine_client

PRODUCT_HOST_PACKAGES += \
    tinyplay

# Include all zygote init scripts. "ro.zygote" will select one of them.
PRODUCT_COPY_FILES += \
    system/core/rootdir/init.zygote32.rc:system/etc/init/hw/init.zygote32.rc \
    system/core/rootdir/init.zygote64.rc:system/etc/init/hw/init.zygote64.rc \
    system/core/rootdir/init.zygote32_64.rc:system/etc/init/hw/init.zygote32_64.rc \
    system/core/rootdir/init.zygote64_32.rc:system/etc/init/hw/init.zygote64_32.rc

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := en_US

# Enforce RRO targetsd
PRODUCT_ENFORCE_RRO_TARGETS := *

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_default.mk)
