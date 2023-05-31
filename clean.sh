echo "===Clean all build output==="
echo "Included: .config, output, etc..."
make clean
make mrproper
make clean ARCH=arm64
make mrproper ARCH=arm64
rm -rf out
