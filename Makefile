CC = gcc
CFLAGS = -Wall -m32 -ffreestanding -fno-pic -nostdlib -g
LDFLAGS = -T linker.ld

SRC = kernel/src/main.c kernel/src/memory.c
OBJ = $(SRC:.c=.o)
KERNEL = kernel.bin

# Compiler kernel
$(OUT): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

# Building object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Cleaning
clean:
	rm -f $(OBJ) $(KERNEL)

