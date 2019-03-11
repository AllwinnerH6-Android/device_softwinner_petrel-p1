# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

include device/softwinner/petrel-common/BoardConfigCommon.mk

# Enable dex-preoptimization to speed up first boot sequence
WITH_DEXPREOPT := true
DONT_DEXPREOPT_PREBUILTS := false

BOARD_KERNEL_CMDLINE := selinux=1 androidboot.selinux=enforcing androidboot.dtbo_idx=0,1,2
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736
BOARD_VENDORIMAGE_PARTITION_SIZE := 251658240
BOARD_CACHEIMAGE_PARTITION_SIZE := 671088640
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
#prebuilt dtbo
BOARD_PREBUILT_DTBOIMAGE := device/softwinner/petrel-p1/dtbo.img

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_RECOVERY_FSTAB := device/softwinner/petrel-p1/recovery.fstab

#Reserve0
BOARD_ROOT_EXTRA_FOLDERS += Reserve0

# Enable SquashFS for /system
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
#BOARD_SYSTEMIMAGE_SQUASHFS_COMPRESSOR := lz4
#BOARD_SYSTEMIMAGE_SQUASHFS_BLOCK_SIZE := 65536
#BOARD_SYSTEMIMAGE_SQUASHFS_COMPRESSOR_OPT := -Xhc

# # Enable SquashFS for /vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
#BOARD_VENDORIMAGE_SQUASHFS_COMPRESSOR :=  lz4
#BOARD_VENDORIMAGE_SQUASHFS_BLOCK_SIZE := 65536
#BOARD_VENDORIMAGE_SQUASHFS_COMPRESSOR_OPT := -Xhc
TARGET_COPY_OUT_VENDOR := vendor

# build & split configs
PRODUCT_ENFORCE_RRO_TARGETS := framework-res
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current


#time for health alarm
BOARD_PERIODIC_CHORES_INTERVAL_FAST := 86400
BOARD_PERIODIC_CHORES_INTERVAL_SLOW := 86400

# Enable SVELTE malloc
MALLOC_SVELTE := false

# recovery touch high threshold
TARGET_RECOVERY_UI_TOUCH_HIGH_THRESHOLD := 200
# recovery fs table
TARGET_RECOVERY_FSTAB := device/softwinner/petrel-p1/recovery.fstab

DEVICE_MANIFEST_FILE := device/softwinner/petrel-p1/configs/manifest.xml
DEVICE_MATRIX_FILE := device/softwinner/petrel-p1/configs/compatibility_matrix.xml

# When PRODUCT_SHIPPING_API_LEVEL >= 27, TARGET_USES_MKE2FS must be true
TARGET_USES_MKE2FS := true

# wifi and bt configuration
# 1. Wifi Configuration

BOARD_WIFI_VENDOR := xradio

# 1.1 broadcom wifi configuration
# BOARD_USR_WIFI: ap6181/ap6210/ap6212/ap6330/ap6335
ifeq ($(BOARD_WIFI_VENDOR), broadcom)
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    WPA_SUPPLICANT_VERSION      := VER_0_8_X
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
    BOARD_WLAN_DEVICE           := bcmdhd
    WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"

    BOARD_USR_WIFI := ap6255
    include hardware/broadcom/wlan/bcmdhd/firmware/$(BOARD_USR_WIFI)/device-bcm.mk
endif

# 1.2 realtek wifi configuration
ifeq ($(BOARD_WIFI_VENDOR), realtek)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl
    include hardware/realtek/wlan/config/config.mk
    BOARD_WLAN_DEVICE           := realtek
    WIFI_DRIVER_MODULE_NAME     := "88x2bs"
    WIFI_DRIVER_MODULE_PATH     := "/vendor/modules/88x2bs.ko"
    WIFI_DRIVER_MODULE_ARG      := "ifname=wlan0 if2name=p2p0"
endif

# 1.3 eagle wifi configuration
ifeq ($(BOARD_WIFI_VENDOR), eagle)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_eagle
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_eagle

    BOARD_USR_WIFI := esp8089
    BOARD_WLAN_DEVICE := esp8089
    include hardware/espressif/wlan/firmware/esp8089/device-esp.mk
endif

#1.4 xradio wifi config
ifeq ($(BOARD_WIFI_VENDOR), xradio)
    # WiFi Configuration
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_xr
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_xr

    BOARD_WLAN_DEVICE           := xradio
    BOARD_USR_WIFI              := xr819

    WIFI_DRIVER_MODULE_PATH     := "/system/vendor/modules/xradio_wlan.ko"
    WIFI_DRIVER_MODULE_NAME     := "xradio_wlan"
    WIFI_DRIVER_MODULE_ARG      := ""

    include hardware/xradio/wlan/kernel-firmware/xradio-wlan.mk
endif

ifeq ($(TARGET_PLATFORM),homlet)
    PRODUCT_BOOT_JARS += softwinner.audio
endif

# 2. Bluetooth Configuration
# make sure BOARD_HAVE_BLUETOOTH is true for every bt vendor

#BOARD_BLUETOOTH_VENDOR := realtek

# 2.1 broadcom bt configuration
# BOARD_HAVE_BLUETOOTH_NAME: ap6210/ap6212/ap6330/ap6335
ifeq ($(BOARD_BLUETOOTH_VENDOR), broadcom)
    BOARD_HAVE_BLUETOOTH := true
    BOARD_HAVE_BLUETOOTH_BCM := true
    BOARD_HAVE_BLUETOOTH_NAME := ap6255
    BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(TOP_DIR)device/softwinner/$(basename $(TARGET_DEVICE))/configs/bluetooth/
endif

# 2.2 realtek bt configuration
ifeq ($(BOARD_BLUETOOTH_VENDOR), realtek)
    BOARD_HAVE_BLUETOOTH := true
    BOARD_HAVE_BLUETOOTH_RTK := true
    BOARD_HAVE_BLUETOOTH_RTK_COEX := true
    BOARD_HAVE_BLUETOOTH_NAME := rtl8822bs
    BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(TOP_DIR)device/softwinner/$(basename $(TARGET_DEVICE))/configs/bluetooth/
    include hardware/realtek/bluetooth/firmware/rtlbtfw_cfg.mk
endif

