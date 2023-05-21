#!/bin/bash

# Export ARGS, OUTPUT FOLDER, ANDROID MAJOR VERSION
OUT_DIR=out 
export ANDROID_MAJOR_VERSION=p
COMMON_ARGS="-C $(pwd) O=$(pwd)/${OUT_DIR} ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android" 

# Export toolchain
export PATH=/home/${USER}/aarch64build/bin:$PATH export ARCH=arm64

# Set defaults directory's
ROOT_DIR=$(pwd)
OUT_DIR=$ROOT_DIR/out
KERNEL_DIR=$ROOT_DIR
DATE=$(date +"%m-%d-%y")
BUILD_START=$(date +"%s")

# Export ARCH and SUBARCH <arm, arm64, x86, x86_64>
export ARCH=arm64
export SUBARCH=arm64

# Set kernel name and defconfig
# export VERSION=
DEF=j6primelte_lucky_defconfig
export DEFCONFIG=$DEF

# Keep it as is
export LOCALVERSION=$VERSION

# Export Kernel Version
export KBUILD_BUILD_VERSION="LuckyKernel-1.3-Development-MSM8917"

# Export Username and machine name
export KBUILD_BUILD_USER=mahirodev
export KBUILD_BUILD_HOST=blueskychan-server
export KBUILD_BUILD_HOST=LuckyKernel-Project 
# // i told you, luckykernel developer is just watching onimai i'm now your sister too much and this happens xD

# Color definition
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

clear
echo "Making everything is clean..."
make clean
make mrproper 
make clean ARCH=arm64
make mrproper ARCH=arm64
rm -rf out
echo "let make menuconfig!"
make menuconfig
clear
echo -e "*****************************************************"
echo    "        Compiling kernel using android toolchan       "
echo -e "*****************************************************"
echo -e "-----------------------------------------------------"
echo    " Project: LuckyKernel (MSM8917)                       "
echo    " Architecture: $ARCH                                 "
echo    " Output directory: $OUT_DIR                          "
echo    " Kernel version: $VERSION                            "
echo	" Defconfig: $DEF				      "
echo    " Build user: $KBUILD_BUILD_USER                      "
echo    " Build machine: $KBUILD_BUILD_HOST                   "
echo    " Build started on: $BUILD_START                      "
echo    " Toolchain: Android Toolchan (GCC)                   "
echo -e "-----------------------------------------------------"
[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR} 
mkdir ${OUT_DIR} 
make mrproper ${OUT_DIR} 
make ${COMMON_ARGS} j6primelte_lucky_defconfig 
#make ${COMMON_ARGS} nconfig 
make -j$(nproc --all) ${COMMON_ARGS} 
#cp ${OUT_DIR}/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
