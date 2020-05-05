#!/bin/bash
OUT_DIR=out 
COMMON_ARGS="-C $(pwd) O=$(pwd)/${OUT_DIR} ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android" 
export PATH=/home/kapmino269/65/aarch64-linux-android-4.9/bin:$PATH export ARCH=arm64 
[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR} 
mkdir ${OUT_DIR} 
make clean ${OUT_DIR} && make mrproper ${OUT_DIR} 
make ${COMMON_ARGS} j4plus_kali_defconfig 
#make ${COMMON_ARGS} nconfig 
make -j$(nproc --all) ${COMMON_ARGS} 
#cp ${OUT_DIR}/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
