# for PPPoE
PRODUCT_PACKAGES += \
    libpppoe-jni \
    pppoe \
    pppoe-service

PRODUCT_SYSTEM_SERVER_JARS += \
    pppoe-service

#$(call inherit-product, device/softwinner/petrel-p1/media/sounds/AudioPackage.mk)
