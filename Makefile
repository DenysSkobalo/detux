ASM = nasm
ASMFLAGS = -f bin

CC = i386-elf-gcc
CFLAGS = -Wall -m32 -ffreestanding -fno-pic -nostdlib -g

QEMU = qemu-system-i386
QEMUFLAGS = -drive format=raw,file=bootloader.bin

BOOT = boot/bootloader.asm
BOOT_BIN = bootloader.bin

KERNEL_SRC = $(wildcard kernel/src/*.c)
KERNEL_OBJ = $(KERNEL_SRC:.c=.o)
KERNEL_BIN = kernel.bin

all: $(BOOT_BIN)

# Bootloader
$(BOOT_BIN): $(BOOT)
	$(ASM) $(ASMFLAGS) $< -o $@

# Kernel 
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(KERNEL_OBJ)
	$(CC) $(CFLAGS) -T linker.ld -o $@ $^

# Run in QEMU
run: $(BOOT_BIN)
	$(QEMU) $(QEMUFLAGS)

# Clean
clean:
	rm -f $(BOOT_BIN) $(KERNEL_OBJ) $(KERNEL_BIN)
