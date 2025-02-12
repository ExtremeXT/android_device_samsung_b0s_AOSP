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

## Inherit from e1s device
$(call inherit-product, device/samsung/e1s/device.mk)

# Branding
PRODUCT_NAME := lineage_e1s
PRODUCT_DEVICE := e1s
PRODUCT_MODEL := e1s

# GMS
BUILD_FINGERPRINT := samsung/e1sxxx/e1s:14/UP1A.231005.007/S921BXXU5AYA5:user/release-keys
