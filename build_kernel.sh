#!/bin/bash
OUT_DIR=out 
COMMON_ARGS="-C $(pwd) O=$(pwd)/${OUT_DIR} ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android" 
export PATH=/home/${USER}/aarch64build/bin:$PATH export ARCH=arm64
KBUILD_BUILD_VERSION="LuckyKernel-1.0-MSM8917"
export KBUILD_BUILD_VERSION
export KBUILD_BUILD_USER=GalaxyBuildMeow
export KBUILD_BUILD_HOST=LuckyKernel-MSM8917 
[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR} 
mkdir ${OUT_DIR} 
make clean ${OUT_DIR} && make mrproper ${OUT_DIR} 
make ${COMMON_ARGS} j6primelte_defconfig 
#make ${COMMON_ARGS} nconfig 
make -j$(nproc --all) ${COMMON_ARGS} 
#cp ${OUT_DIR}/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
