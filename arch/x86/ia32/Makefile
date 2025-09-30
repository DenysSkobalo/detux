# ==========================================
# Makefile for Detux ia32 kernel subsystem
# ==========================================
# This is the part that actually builds things. No wildcards, no guessing.
# If you add a file, list it. Computers aren’t mind readers.

BUILD_DIR ?= build

# 32-bit, freestanding. Complain loudly when you screw up.
# The include path is local on purpose. Keep arch headers arch-local.
CFLAGS  := -m32 -ffreestanding -O2 -Wall -Wextra -Iinclude
ASFLAGS := -m32 -ffreestanding
# The linker script decides the layout. Not your linker’s guesswork.
LDFLAGS := -m elf_i386 -T boot/linker.ld

# Put outputs under $(BUILD_DIR). Keep sources where they belong.
C_OBJS := \
	$(BUILD_DIR)/init/main.o \
	$(BUILD_DIR)/arch/x86/ia32/video/vga.o

ASM_OBJS := \
	$(BUILD_DIR)/arch/x86/ia32/boot/start.o \
	$(BUILD_DIR)/arch/x86/ia32/boot/multiboot_header.o

# Order matters. Multiboot bits first so GRUB doesn’t throw a tantrum.
OBJS := $(ASM_OBJS) $(C_OBJS)

# You typed “make”? You get a kernel. Shocking simplicity.
all: $(BUILD_DIR)/kernel.elf

# main.c lives outside the arch dir. Cope with it like an adult.
# (from arch/x86/ia32 -> ../../../init/main.c)
$(BUILD_DIR)/init/main.o: ../../../init/main.c
	mkdir -p $(dir $@)
	gcc $(CFLAGS) -c $< -o $@

# Text-mode VGA. Because printf requires… you know… an output.
$(BUILD_DIR)/arch/x86/ia32/video/vga.o: video/vga.c include/vga.h
	mkdir -p $(dir $@)
	gcc $(CFLAGS) -c $< -o $@

# Bootstrap assembly. This runs before anything else can even spell “C”.
$(BUILD_DIR)/arch/x86/ia32/boot/%.o: boot/%.S
	mkdir -p $(dir $@)
	gcc $(ASFLAGS) -c $< -o $@

# Link with the script, not with wishful thinking. Layout is explicit.
$(BUILD_DIR)/kernel.elf: $(OBJS)
	mkdir -p $(dir $@)
	ld $(LDFLAGS) -o $@ $(OBJS)

# Clean means clean. If you keep stale objects around, that’s on you.
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
