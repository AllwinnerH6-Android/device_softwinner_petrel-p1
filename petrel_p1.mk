$(call inherit-product, device/softwinner/petrel-common/petrel-common.mk)
$(call inherit-product-if-exists, device/softwinner/petrel-p1/modules/modules.mk)
$(call inherit-product, device/google/atv/products/atv_base.mk)
$(call inherit-product-if-exists, device/softwinner/petrel-p1/tv_base.mk)
$(call inherit-product, device/softwinner/petrel-p1/hal.mk)
$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/petrel-p1/overlay \
                           $(DEVICE_PACKAGE_OVERLAYS)
# enable property split
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

GAPPS_VARIANT := tvmini

# set product shipping(first) api level
PRODUCT_SHIPPING_API_LEVEL := 28

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Enable DM file preopting to reduce first boot time
PRODUCT_DEX_PREOPT_GENERATE_DM_FILES :=true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify

# secure config
BOARD_HAS_SECURE_OS := false

PRODUCT_PACKAGES += \
AppDrawer \
SmartYouTubeTV \
RootExp

# drm config
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3

# camera hal config
# USE_CAMERA_HAL_3_4 := true
USE_CAMERA_HAL_1_0 := true

# Load BOARD_BLUETOOTH_VENDOR Settings from BoardConfig.mk
$(eval $(shell grep "^\s*BOARD_BLUETOOTH_VENDOR\s*:*=" device/softwinner/petrel-p1/BoardConfig.mk))

# common vendor will build all vendor's libbt-vendor
ifeq ($(BOARD_BLUETOOTH_VENDOR),common)
PRODUCT_PACKAGES += \
	wireless_hwinfo \
	libbt-xradio \
	libbt-broadcom \
	libbt-realtek
endif

# Copy permission files only for supported vendor
ifneq (,$(findstring $(BOARD_BLUETOOTH_VENDOR),broadcom realtek xradio common))
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml
endif

PRODUCT_PACKAGES += \
    TelephonyProvider \
    rild \
    DocumentsUI \

############################### 3G Dongle Support ###############################
# Radio Packages and Configuration Flie
$(call inherit-product-if-exists, vendor/aw/public/prebuild/lib/librild/radio_common.mk)

# Reduces GC frequency of foreground apps by 50% (not recommanded for 512M devices)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += dalvik.vm.foreground-heap-growth-multiplier=2.0

PRODUCT_COPY_FILES += \
    device/softwinner/petrel-p1/kernel:kernel \
    device/softwinner/petrel-p1/fstab.sun50iw6p1:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sun50iw6p1 \
    device/softwinner/petrel-p1/init.device.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.device.rc \
    device/softwinner/petrel-p1/init.recovery.sun50iw6p1.rc:root/init.recovery.sun50iw6p1.rc \
    device/softwinner/petrel-p1/modules/modules/sunxi-ir-rx.ko:recovery/root/sunxi-ir-rx.ko \
    vendor/aw/homlet/binary/mount.exfat:recovery/root/sbin/mount.exfat \

PRODUCT_COPY_FILES += \
    device/softwinner/common/config/tv_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tv_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.software.pppoe.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.pppoe.xml \

PRODUCT_COPY_FILES += \
	device/softwinner/petrel-p1/configs/excluded-input-devices.xml:system/etc/excluded-input-devices.xml \

PRODUCT_COPY_FILES += \
	device/softwinner/petrel-p1/configs/sunxi-keyboard.kl:system/usr/keylayout/sunxi-keyboard.kl \

PRODUCT_COPY_FILES += \
    device/softwinner/petrel-p1/configs/camera.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/camera.cfg \
    device/softwinner/petrel-p1/configs/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \

PRODUCT_COPY_FILES += \
    hardware/aw/camera/1_0/libstd/libstdc++.so:$(TARGET_COPY_OUT_VENDOR)/lib/libstdc++.so

# root
PRODUCT_COPY_FILES += \
    device/softwinner/petrel-p1/su:system/xbin/su \
    device/softwinner/petrel-p1/supolicy:system/xbin/supolicy \
    device/softwinner/petrel-p1/daemonsu:system/xbin/daemonsu \
    device/softwinner/petrel-p1/libsupol.so:system/lib/libsupol.so \
    device/softwinner/petrel-p1/rootsudaemon.sh:system/bin/rootsudaemon.sh    

# preferred activity
PRODUCT_COPY_FILES += \
    device/softwinner/petrel-p1/configs/preferred-apps/custom.xml:system/etc/preferred-apps/custom.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/by-name/frp

ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_DEBUG := true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.usb.config=mtp,adb \
    ro.adb.secure=0
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.usb.config=mtp \
    ro.adb.secure=1
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# limit dex2oat threads to improve thermals
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.boot-dex2oat-threads=4 \
    dalvik.vm.dex2oat-threads=3 \
    dalvik.vm.image-dex2oat-threads=4

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-flags=--no-watch-dog \
    dalvik.vm.jit.codecachesize=0

PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot=verify-at-runtime \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

# display
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.display.smart_backlight=1 \
    persist.display.enhance_mode=0 \
    persist.display.policy=2 \
    persist.disp.device_config.hdmi \
    persist.disp.margin.hdmi \
    persist.disp.dataspace.hdmi \
    persist.disp.pixelformat.hdmi \
    persist.disp.aspectratio.hdmi \
    persist.disp.device_config.cvbs \
    persist.disp.margin.cvbs \
    persist.disp.dataspace.cvbs \
    persist.disp.pixelformat.cvbs \
    persist.disp.aspectratio.cvbs

# miracast
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    wfdsink.use.local_player=true

# Inits
PRODUCT_PACKAGES += \
    init.lineage.atv.rc \
    init.safailnet.rc

#disable rotation
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	ro.sf.disablerotation = 1

#booevent true=enable bootevent,false=disable bootevent
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.bootevent=true

PRODUCT_CHARACTERISTICS := tv

PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_BRAND := Allwinner
PRODUCT_NAME := petrel_p1
PRODUCT_DEVICE := petrel-p1
# PRODUCT_BOARD must equals the board name in kernel
PRODUCT_BOARD := petrel-p1-axpdummy
PRODUCT_MODEL := petrel-p1
PRODUCT_MANUFACTURER := Allwinner

$(call inherit-product-if-exists, vendor/aw/public/tool.mk)
