#!/bin/bash

# Export ARGS, OUTPUT FOLDER, ANDROID MAJOR VERSION
OUT_DIR=out 
export ANDROID_MAJOR_VERSION=p
COMMON_ARGS="-C $(pwd) O=$(pwd)/${OUT_DIR} ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android" 

# Export toolchain
export PATH=/home/${USER}/BuildDrive/Toolchain/aarch64-linux-android-4.9/bin/:$PATH export ARCH=arm64

# Just checking...
which aarch64-linux-android-gcc

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
# For J4+, change to j4primelte_defconfig
DEF=j6primelte_defconfig
export DEFCONFIG=$DEF

# Tell me a project/kernel name
export ProjectName="LuckyKernel for Samsung Galaxy J4+/J6+"

# Use make kernelversion to get kernel source version
export VERSION=$(make kernelversion)

# Export Kernel Version
export KBUILD_BUILD_VERSION="DEVELOPMENT STAGES"

# Export Username and machine name
export KBUILD_BUILD_USER=${USER}
export KBUILD_BUILD_HOST=$(uname -n)
# export KBUILD_BUILD_HOST=LuckyKernel-Project 
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
echo "===Making everything is clean...==="
echo "This maybe won't take too long..."
make clean
make mrproper 
make clean ARCH=arm64
make mrproper ARCH=arm64
rm -rf out
clear
echo "let make menuconfig :D"
make menuconfig ARCH=arm64
clear
echo -e "*****************************************************"
echo    "        Compiling kernel using android toolchan       "
echo -e "*****************************************************"
echo -e "-----------------------------------------------------"
echo    " Project: $ProjectName                               "
echo    " Architecture: $ARCH                                 "
echo    " Output directory: $OUT_DIR                          "
echo    " Kernel version: $VERSION                            "
echo	" Defconfig: $DEF				      "
echo    " Build user: $KBUILD_BUILD_USER                      "
echo    " Build machine: $KBUILD_BUILD_HOST                   "
echo    " Build started on: $BUILD_START                      "
echo    " Toolchain: Android Toolchan (GCC)                   "
echo    " All processors units: $(nproc --all)                "
echo -e "-----------------------------------------------------"
[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR} 
mkdir ${OUT_DIR} 
make mrproper ${OUT_DIR} 
make ${COMMON_ARGS} $DEF 
#make ${COMMON_ARGS} nconfig 
time make -j$(nproc --all) ${COMMON_ARGS} 
#cp ${OUT_DIR}/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
