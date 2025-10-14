#
# Copyright 2014 The Android Open-Source Project
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
COMMON_PATH := device/samsung/b0s

# All components inherited here go to system image
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# All components inherited here go to system_ext image
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

# All components inherited here go to product image
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# All components inherited here go to vendor image
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Inherit proprietary files
$(call inherit-product, vendor/samsung/b0s/b0s-vendor.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)


# API Levels
PRODUCT_SHIPPING_API_LEVEL := 31

# Branding
PRODUCT_BRAND := Android
PRODUCT_MANUFACTURER := samsung

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

AB_OTA_UPDATER := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

TARGET_SCREEN_HEIGHT := 3088
TARGET_SCREEN_WIDTH := 1440

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    bootable/deprecated-ota \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/qcom-caf/wlan \
    hardware/samsung_slsi-linaro/exynos/cpboot_v3 \
    hardware/samsung

# AVF
$(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)

# Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_with_le_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

PRODUCT_PACKAGES += \
    SamsungDAP \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usbv2.default \
    audio_effects.xml \
    audio_policy_configuration.xml

TARGET_EXCLUDES_AUDIOFX := true

$(call soong_config_set, android_hardware_audio, run_64bit, true)

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider-service.samsung \
    libhypervintf \
    libsensorndkbridge

# DRM
PRODUCT_PACKAGES += com.android.hardware.drm.clearkey

# Display
$(call inherit-product, $(SRC_TARGET_DIR)/product/angle_default.mk)

PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service

PRODUCT_COPY_FILES += \
    vendor/samsung/b0s/proprietary/recovery/root/lib/firmware/sgpu/vangogh_lite_unified.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/firmware/sgpu/vangogh_lite_unified.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/wez02_b0_c3.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/wez02_b0_c3.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/wez02_b0_c2.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/wez02_b0_c2.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/wez02_b0_c1.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/wez02_b0_c1.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/wez02_b0_c0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/wez02_b0_c0.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/w9020_b0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/w9020_b0.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/b0_vl53l5.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/b0_vl53l5.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/b0_00_generic_xtalk_shape.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/b0_00_generic_xtalk_shape.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/tsp_stm/fts2ba61y_b0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/tsp_stm/fts2ba61y_b0.bin \
    vendor/samsung/b0s/proprietary/recovery/root/vendor/firmware/tsp_stm/fts2ba61y_b0_fake.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/tsp_stm/fts2ba61y_b0_fake.bin \
    

PRODUCT_PACKAGES += \
    hdr_samsung_mx.key \
    libshim_ui

# Fastbootd
PRODUCT_PACKAGES += fastbootd

# Fingerprint
PRODUCT_PACKAGES += android.hardware.biometrics.fingerprint-service.samsung

# General
PRODUCT_PACKAGES += vndservicemanager

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

# Init
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/init/recovery.fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/etc/recovery.fstab \
    $(COMMON_PATH)/configs/init/fstab.s5e9925:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.s5e9925 \
    $(COMMON_PATH)/configs/init/fstab.s5e9925:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.s5e9925 \
    $(COMMON_PATH)/configs/init/init.debug.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.debug.rc

PRODUCT_PACKAGES += fstab.s5e9925
PRODUCT_PACKAGES += ueventd.s5e9925.rc

# VNDK
PRODUCT_PACKAGES += libutils-v32

# HIDL
PRODUCT_PACKAGES += \
   libhidltransport \
   libhidltransport.vendor \
   libhwbinder \
   libhwbinder.vendor

# Input
PRODUCT_PACKAGES += init.input.rc

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl:64 \
    android.hardware.gatekeeper@1.0-service

# Kernel Modules
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    null \
    toolbox.vendor_ramdisk

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Linker
PRODUCT_PACKAGES += public.libraries.txt

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp \
    android.hardware.secure_element-service.nxp \
    com.android.nfc_extras \
    libchrome.vendor \
    Tag

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
    android.hardware.nfc.hce.prebuilt.xml \
    android.hardware.nfc.prebuilt.xml \
    android.hardware.se.omapi.ese.prebuilt.xml \
    android.hardware.se.omapi.uicc.prebuilt.xml \
    android.hardware.sensor.barometer.prebuilt.xml \
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
    android.software.opengles.deqp.level-latest.prebuilt.xml \
    android.software.vulkan.deqp.level-2023-03-01.prebuilt.xml \
    handheld_core_hardware.prebuilt.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr \
    powerhint.json

# RIL
PRODUCT_PACKAGES += \
    secril_config_svc \
    cbd \
    sehradiomanager \
    sehradiomanager.conf \
    android.hardware.radio@1.4.vendor:64 \
    android.hardware.radio.config@1.2.vendor:64 \
    android.hardware.radio.deprecated@1.0.vendor:64

PRODUCT_PACKAGES += \
    libdsms_vendor:64

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.samsung-multihal \
    hals.conf

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

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.samsung

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    WifiOverlay
