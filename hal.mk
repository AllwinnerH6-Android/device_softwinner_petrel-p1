
# Gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl

# HW Composer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    hwcomposer.petrel \
    gralloc.petrel
# Audio
PRODUCT_PACKAGES += \
    audio.primary.petrel \
    sound_trigger.primary.petrel \
    android.hardware.audio@2.0-service \
    android.hardware.audio@4.0-impl \
    android.hardware.audio.effect@4.0-impl \
    android.hardware.soundtrigger@2.0-impl

# keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# CAMERA
PRODUCT_PACKAGES += \
    camera.device@3.2-impl \
    android.hardware.camera.provider@2.4-service \
    android.hardware.camera.provider@2.4-impl \
    libcamera \
    camera.petrel
# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.petrel \
    memtrack.default

# drm
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.1-service.widevine \
    android.hardware.drm@1.1-service.clearkey

# ION
PRODUCT_PACKAGES += \
    libion

# Wi-Fi Pakages
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    libwpa_client \
    wpa_supplicant \
    hostapd \
    wificond \
    wifilogd \
    wpa_supplicant.conf

# Light Hal
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl \
    lights.petrel

# new gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    libgatekeeper \
    gatekeeper.petrel

#power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service \
    android.hardware.power@1.0-impl \
    power.petrel

# usb
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

#health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service \
    android.hardware.health@2.0-impl
#configstore
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth@1.0-service.rc \
    android.hidl.memory@1.0-impl \
    Bluetooth \
    libbt-vendor \
    audio.a2dp.default
