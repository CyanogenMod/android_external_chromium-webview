#
# Copyright (C) 2014 The Android Open Source Project
# Copyright (C) 2016 The CyanogenMod Project
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

# Install the prebuilt webview apk.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := webview
LOCAL_MODULE_CLASS := APPS
LOCAL_MULTILIB := both
LOCAL_CERTIFICATE := $(DEFAULT_SYSTEM_DEV_CERTIFICATE)
LOCAL_REQUIRED_MODULES := \
        libwebviewchromium_loader \
        libwebviewchromium_plat_support

LOCAL_MODULE_TARGET_ARCH := arm arm64 mips x86 x86_64
my_src_arch := $(call get-prebuilt-src-arch,$(LOCAL_MODULE_TARGET_ARCH))

LOCAL_PREBUILT_JNI_LIBS_arm := @lib/armeabi-v7a/libwebviewchromium.so
LOCAL_PREBUILT_JNI_LIBS_arm64 := @lib/arm64-v8a/libwebviewchromium.so
LOCAL_PREBUILT_JNI_LIBS_mips := @lib/mips/libwebviewchromium.so
LOCAL_PREBUILT_JNI_LIBS_x86 := @lib/x86/libwebviewchromium.so
LOCAL_PREBUILT_JNI_LIBS_x86_64 := @lib/x86_64/libwebviewchromium.so

ifeq ($(LOCAL_WEBVIEW),true)
LOCAL_SRC_FILES := prebuilt/$(my_src_arch)/webview.apk
include $(BUILD_PREBUILT)
else

LOCAL_MAVEN_REPO := https://maven.cyanogenmod.org/artifactory/webview_prebuilts
LOCAL_MAVEN_GROUP := org.cyanogenmod
LOCAL_MAVEN_VERSION := 1
LOCAL_MAVEN_ARTIFACT := webview
LOCAL_MAVEN_CLASSIFIER := $(my_src_arch)
LOCAL_MAVEN_PACKAGING := apk

include $(BUILD_MAVEN_PREBUILT)
endif
