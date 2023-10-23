TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard Preferences
ARCHS = arm64 arm64e
SYSROOT = $(THEOS)/sdks/iPhoneOS14.2.sdk
DEBUG = 1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCPowerMenu
CCPowerMenu_BUNDLE_EXTENSION = bundle
CCPowerMenu_FILES = CCPowerMenu.m CCPowerMenuViewController.xm CCPowerMenuListController.m
CCPowerMenu_CFLAGS = -fobjc-arc
CCPowerMenu_FRAMEWORKS = UIKit
CCPowerMenu_PRIVATE_FRAMEWORKS = ControlCenterUIKit Preferences
CCPowerMenu_INSTALL_PATH = /Library/ControlCenter/Bundles

include $(THEOS_MAKE_PATH)/bundle.mk
SUBPROJECTS += userspace-reboot
# SUBPROJECTS += ccpowermenuprovider
include $(THEOS_MAKE_PATH)/aggregate.mk
