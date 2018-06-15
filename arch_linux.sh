#!/usr/bin/env bash

# Variables
SRC=./src
DEST=/
REPO_URL="https://archive.archlinux.org/packages/l/linux-headers"
VERSION=$(uname -r|sed 's/\-ARCH//g')
ARCH=$(uname -m)
PACKAGE_NAME=linux-headers-$VERSION-$ARCH
FILE_NAME=$PACKAGE_NAME.pkg.tar.xz

# Download and extract package.
echo "Downloading Arch linux package: $FILE_NAME"
curl "$REPO_URL/$FILE_NAME" --output "$SRC/$FILE_NAME"
xz -fd "$SRC/$FILE_NAME"
mkdir -p $DEST
tar xf "$SRC/$PACKAGE_NAME.pkg.tar" -C $DEST

# Cleanup
rm "$SRC/$PACKAGE_NAME.pkg.tar"
rm "$DEST/.PKGINFO"
rm "$DEST/.MTREE"
rm "$DEST/.BUILDINFO"
