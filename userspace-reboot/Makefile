TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
SYSROOT = $(THEOS)/sdks/iPhoneOS14.2.sdk

include $(THEOS)/makefiles/common.mk

TOOL_NAME = userspace-reboot

userspace-reboot_FILES = main.m
userspace-reboot_CFLAGS = -fobjc-arc
userspace-reboot_CODESIGN_FLAGS = -Sentitlements.plist
userspace-reboot_INSTALL_PATH = /usr/libexec

include $(THEOS_MAKE_PATH)/tool.mk

internal-stage::
	$(ECHO_NOTHING)chmod 6755 $(THEOS_STAGING_DIR)/usr/libexec/$(TOOL_NAME)$(ECHO_END)
