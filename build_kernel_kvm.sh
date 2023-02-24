#!/bin/bash
OUT_DIR=out 
export ANDROID_MAJOR_VERSION=p
COMMON_ARGS="-C $(pwd) O=$(pwd)/${OUT_DIR} ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android" 
export PATH=/home/kokomail/UltraDisk/Tools/aarch64-linux-android-4.9/bin:$PATH export ARCH=arm64
KBUILD_BUILD_VERSION="LuckyKernel-1.0-MSM8917-KVM"
export KBUILD_BUILD_VERSION 
[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR} 
mkdir ${OUT_DIR} 
make mrproper ${OUT_DIR} 
make ${COMMON_ARGS} j6primelte_kvm_defconfig 
#make ${COMMON_ARGS} nconfig 
make -j$(nproc --all) ${COMMON_ARGS} 
#cp ${OUT_DIR}/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
