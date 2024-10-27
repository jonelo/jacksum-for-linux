#!/bin/bash

WIN_INSTALLER_VER=2.9.0
LINUX_INSTALLER_VER=2.9.0

JACKSUM_VER=3.7.0
HASHGARTEN_VER=0.18.0
FLATLAF_VER=3.5.2

# ------ no change required after this point ---- #

# Init
TARGET="/tmp/jacksum-for-linux"
rm -Rf "$TARGET"
mkdir -p "$TARGET"
cd "${TARGET}"

# Download latest jacksum-for-windows release
curl -L -o temp.zip "https://github.com/jonelo/jacksum-for-windows/releases/download/v${WIN_INSTALLER_VER}/jacksum-${JACKSUM_VER}-hashgarten-${HASHGARTEN_VER}-for-windows-${WIN_INSTALLER_VER}.zip"

# Extract all .jar files
unzip temp.zip "*.exe"
7z x "*.exe" "*.jar"
rm temp.zip
rm *.exe
cd -

# Create a new Linux tarball
TARBALL="jacksum-${JACKSUM_VER}-hashgarten-${HASHGARTEN_VER}-for-linux-${LINUX_INSTALLER_VER}.tar"
rm /tmp/${TARBALL}.bz2
cp jacksum-for-linux.sh "$TARGET"
cp ../docs/* $TARGET
cd /tmp
tar cfv "$TARBALL" "jacksum-for-linux"
bzip2 "$TARBALL"
cd -

# Check again
printf "Done.\n"
ls -la "/tmp/${TARBALL}.bz2"
bunzip2 < "/tmp/${TARBALL}.bz2" | tar tvf -
