# ======= Root Makefile for Detux =======
# This is the top-level kickstarter. It does two things:
#  (1) tells the arch Makefile to build the kernel,
#  (2) shoves the result into a GRUB ISO so you can actually boot it.
# If you want auto-discovery fairy dust, go use something else.

BUILD_DIR := build
ISO_DIR   := iso
KERNEL    := $(BUILD_DIR)/kernel.elf
QEMU 	  := qemu-system-i386

# Default: build something you can run. Shocking, I know.
all: $(ISO_DIR)/detux.iso

# Don’t duplicate logic here. The arch layer owns the build. Keep it there.
$(KERNEL):
	$(MAKE) -C arch/x86/ia32 BUILD_DIR=$(abspath $(BUILD_DIR))

# Take the kernel, put it where GRUB expects it, write the tiniest config,
# and produce an ISO. Nothing clever, because clever breaks.
$(ISO_DIR)/detux.iso: $(KERNEL)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	echo 'menuentry "detux" { multiboot /boot/kernel.elf }' > $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $@ $(ISO_DIR)

# If this fails, it’s not QEMU’s fault. Fix your kernel.
qemu:
	$(QEMU) -cdrom $(ISO_DIR)/detux.iso -m 512M -vga std

# Remove the junk you created. Yes, *all* of it.
clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR)
	$(MAKE) -C arch/x86/ia32 clean

.PHONY: all qemu clean
