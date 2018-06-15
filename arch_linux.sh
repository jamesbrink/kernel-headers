#!/usr/bin/env bash

# Variables
SRC=$(mktemp -d)
DEST=/
REPO_URL="https://archive.archlinux.org/packages/l/linux-headers"
VERSION=$(uname -r|sed 's/\-ARCH//g')
ARCH=$(uname -m)
PACKAGE_NAME=linux-headers-$VERSION-$ARCH
FILE_NAME=$PACKAGE_NAME.pkg.tar.xz

# Download and extract package.
echo "Downloading Arch linux package: $PACKAGE_NAME"
echo "Saving file to: $SRC/$FILE_NAME"
curl "$REPO_URL/$FILE_NAME" --output "$SRC/$FILE_NAME"
echo "Decompressing: $SRC/$FILE_NAME"
xz -fd "$SRC/$FILE_NAME"
mkdir -p $DEST
echo "Extracting: $SRC/$PACKAGE_NAME.pkg.tar => $DEST"
tar xf "$SRC/$PACKAGE_NAME.pkg.tar" --exclude=.PKGINFO --exclude=.MTREE --exclude=.BUILDINFO -C $DEST

# Cleanup
echo "Removing: $SRC/$PACKAGE_NAME.pkg.tar"
rm "$SRC/$PACKAGE_NAME.pkg.tar"
echo "Removing directory: $SRC"
rmdir "$SRC"
