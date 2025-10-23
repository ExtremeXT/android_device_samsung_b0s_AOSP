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

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

# DTS
BOARD_DTB_CFG := device/samsung/b0s/configs/kernel/dts/dtb.cfg
BOARD_DTBO_CFG := device/samsung/b0s/configs/kernel/dts/dtbo.cfg
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_KERNEL_SEPARATED_DTBO := true

# Display
TARGET_SCREEN_DENSITY := 600
TARGET_USES_VULKAN := true

# Filesystem
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_ODM := odm

-include vendor/lineage/config/BoardConfigReservedSize.mk

# Boot Image
BOARD_BOOTCONFIG := buildtime_bootconfig=enable
BOARD_BOOT_HEADER_VERSION := 4
BOARD_CUSTOM_BOOTIMG := true
BOARD_DTB_OFFSET := 0x11f00000
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := bootconfig
BOARD_KERNEL_OFFSET := 0x10008000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x14000000
BOARD_RAMDISK_USE_LZ4 := true
BOARD_RECOVERY_DTB_OFFSET := 0x00000000
BOARD_RECOVERY_HEADER_VERSION := 2
BOARD_TAGS_OFFSET := 0x10000000

BOARD_COMMON_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE)
BOARD_COMMON_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_COMMON_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_COMMON_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_COMMON_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_COMMON_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)

BOARD_RECOVERY_MKBOOTIMG_ARGS := $(BOARD_COMMON_MKBOOTIMG_ARGS)
BOARD_RECOVERY_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_RECOVERY_DTB_OFFSET)
BOARD_RECOVERY_MKBOOTIMG_ARGS += --header_version $(BOARD_RECOVERY_HEADER_VERSION)

BOARD_MKBOOTIMG_ARGS := $(BOARD_COMMON_MKBOOTIMG_ARGS)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1 LLVM_IAS=1 TARGET_SOC=s5e9925 BRANCH=android12-5.10 KMI_GENERATION=9
TARGET_KERNEL_NO_GCC := true
TARGET_KERNEL_SOURCE := kernel/samsung/s5e9925
TARGET_KERNEL_CONFIG := s5e9925_defconfig b0s.config

## Kernel Modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat device/samsung/b0s/configs/kernel/modules/ramdisk))
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
BOARD_VENDOR_KERNEL_MODULES_LOAD := sec_debug_coredump.ko fingerprint.ko fingerprint_sysfs.ko input_booster_lkm.ko dhd.ko

BOARD_VENDOR_RAMDISK_FRAGMENTS := dlkm
BOARD_VENDOR_RAMDISK_FRAGMENT.dlkm.KERNEL_MODULE_DIRS := top

# Partitions - Classic
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 367001600
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 100663296
BOARD_ROOT_EXTRA_FOLDERS := efs
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 12981370880
BOARD_USES_METADATA_PARTITION := true
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 33554432

# Partitions - Dynamic
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    product \
    system \
    system_dlkm \
    system_ext \
    vendor \
    vendor_dlkm \
    odm

BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := $(shell echo $$(( $(BOARD_SUPER_PARTITION_SIZE) - 4 * 1024**2 )))

$(call soong_config_set,cbd,protocol,sipc)

# Properties
TARGET_PRODUCT_PROP += device/samsung/b0s/configs/props/product.prop
TARGET_VENDOR_PROP += device/samsung/b0s/configs/props/vendor.prop

# Ramdisks
BOARD_RAMDISK_USE_LZ4 := true
BOARD_VENDOR_RAMDISK_FRAGMENTS := dlkm
BOARD_VENDOR_RAMDISK_FRAGMENT.dlkm.MKBOOTIMG_ARGS := --ramdisk_type DLKM

# Recovery
BOARD_RECOVERY_MKBOOTIMG_ARGS := --header_version 2 --cmdline ""
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/configs/init/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/b0s

# SELinux
include device/lineage/sepolicy/exynos/sepolicy.mk
BOARD_SEPOLICY_TEE_FLAVOR := teegris
include device/samsung_slsi/sepolicy/sepolicy.mk

# USB
$(call soong_config_set,samsungUsbGadgetVars,gadget_name,10b00000.dwc3)

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS := --flags 3
BOARD_AVB_RECOVERY_ALGORITHM := NONE
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    device/samsung/b0s/configs/vintf/compatibility_matrix.device.xml \
    hardware/samsung/vintf/samsung_framework_compatibility_matrix.xml
DEVICE_MANIFEST_FILE := device/samsung/b0s/configs/vintf/manifest.xml

$(call soong_config_set,samsungCameraVars,usage_64bit,true)

# Wi-Fi
BOARD_WLAN_DEVICE                             := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER                   := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB              := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER                          := NL80211
BOARD_HOSTAPD_PRIVATE_LIB                     := lib_driver_cmd_bcmdhd
CONFIG_IEEE80211AX                            := true
WIFI_AVOID_IFACE_RESET_MAC_CHANGE             := true
WIFI_FEATURE_HOSTAPD_11AX                     := true
WIFI_HIDL_FEATURE_AWARE                       := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE              := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION                        := VER_0_8_X
$(call soong_config_set,wpa_supplicant_8,board_wlan_bcmdhd_sae,true)

# Bluetooth
BOARD_CUSTOM_BT_CONFIG := device/samsung/b0s/bluetooth/libbt_vndcfg.txt
BOARD_HAVE_BLUETOOTH_BCM := true

-include vendor/samsung/b0s/BoardConfigVendor.mk
