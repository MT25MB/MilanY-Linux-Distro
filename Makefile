# milanY linux makefile
# build and package management

.PHONY: all build clean install iso help

# variables
VERSION = 1.0.0
DISTRO = milanY
BUILD_DIR = build
ISO_NAME = $(DISTRO)-$(VERSION).iso

# default target
all: build

# help
help:
	@echo "milanY linux build system"
	@echo ""
	@echo "targets:"
	@echo "  build    - build the distro"
	@echo "  iso      - create bootable iso"
	@echo "  install  - install dependencies"
	@echo "  clean    - clean build files"
	@echo "  help     - show this help"

# install build dependencies
install:
	@echo "installing build dependencies..."
	pacman -S --needed --noconfirm archiso git squashfs-tools libisoburn

# build the distro
build:
	@echo "building $(DISTRO) linux v$(VERSION)..."
	chmod +x build.sh
	./build.sh

# create iso only
iso:
	@echo "creating iso $(ISO_NAME)..."
	chmod +x scripts/create_iso.sh
	scripts/create_iso.sh rootfs $(ISO_NAME)

# clean build artifacts
clean:
	@echo "cleaning build files..."
	rm -rf $(BUILD_DIR)
	rm -f $(ISO_NAME)
	rm -rf rootfs

# dev targets
dev-setup:
	@echo "setting up development environment..."
	chmod +x scripts/*.sh
	chmod +x usr/local/bin/*
	chmod +x install.sh

# test build
test: dev-setup
	@echo "running test build..."
	./build.sh --test

# release build
release: clean build
	@echo "creating release..."
	@echo "$(ISO_NAME) ready for distribution"
