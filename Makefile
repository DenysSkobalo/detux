# === Toolchain Configuration ===
CC = gcc                      # C compiler
LD = ld                       # Linker
NASM = nasm                   # Assembler for multiboot header
GRUB_MKRESCUE = grub-mkrescue # Tool to generate bootable ISO with GRUB
QEMU = qemu-system-x86_64     # QEMU emulator

# === Compilation and Linking Flags ===
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra      # 32-bit mode, freestanding, optimize, show all warnings
LDFLAGS = -m elf_i386 -T linker.ld                  # Use 32-bit ELF format and custom linker script

# === Directory and File Definitions ===
BUILD_DIR = build
ISO_DIR = iso
KERNEL = $(BUILD_DIR)/kernel.elf

# === Source Files ===
SRC_C = kernel/kernel.c
SRC_S = boot/multiboot_header.S
OBJ = $(BUILD_DIR)/kernel.o $(BUILD_DIR)/multiboot_header.o

# === Phony Targets ===
.PHONY: all clean make-iso qemu docker build-iso

# === Default Target: Build kernel and ISO ===
all: $(KERNEL) $(ISO_DIR)/detux.iso

# === Compile kernel C code into object file ===
$(BUILD_DIR)/kernel.o: $(SRC_C)
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# === Assemble multiboot header into object file ===
$(BUILD_DIR)/multiboot_header.o: $(SRC_S)
	mkdir -p $(BUILD_DIR)
	$(NASM) -f elf32 $< -o $@

# === Link all object files into final ELF kernel ===
$(KERNEL): $(OBJ) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJ)

# === Create a bootable ISO with GRUB config and kernel ===
$(ISO_DIR)/detux.iso: $(KERNEL)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	echo 'menuentry "detux" { multiboot /boot/kernel.elf }' > $(ISO_DIR)/boot/grub/grub.cfg
	$(GRUB_MKRESCUE) -o $@ $(ISO_DIR)

# === Explicit ISO build target ===
make-iso: $(ISO_DIR)/detux.iso
	@echo "[✓] ISO built successfully at $<"

# === Build ISO in Docker (via script) ===
build-iso:
	./build.sh

# === Run ISO in QEMU with GUI output ===
qemu: $(ISO_DIR)/detux.iso
	$(QEMU) -cdrom $< -m 512M -vga std

# === Run ISO in QEMU with terminal output ===
docker: $(ISO_DIR)/detux.iso
	docker run --rm -it \
		  -v "$(PWD)":/detux \
		  -w /detux \
		  detux \
		  $(QEMU) -cdrom $< -m 512M -curses

# === Build docker container ===
dc: 
	 docker build -t detux .

ddc: 
	docker rmi detux

# === Clean build and iso folders ===
clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR)
