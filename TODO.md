# TODO – Minimal OS Project Roadmap

This document outlines the steps to build a minimal operating system from scratch.  
The goal: bootloader + kernel + basic text output, then expand (memory, file system, shell...).

---

## ✅ Stage 1: Bootloader
- [ ] Write a 16-bit bootloader (`bootloader.asm`) that:
  - [ ] Prints a boot message (done: "Hella")
  - [ ] Loads the kernel from disk (using BIOS `int 0x13`)
  - [ ] Jumps to the kernel entry point (e.g., 0x1000)

---

## ✅ Stage 2: Kernel Skeleton
- [ ] Create a minimal C kernel (`kernel.c`):
  - [ ] Define `kernel_main()` (no `stdio.h`, freestanding C)
  - [ ] Implement a VGA text mode driver (`vga.c` / `vga.h`)
  - [ ] Print a message: "Booting kernel..." and "Hello from kernel!"

- [ ] Write a simple `linker.ld`:
  - [ ] Place kernel at 0x1000
  - [ ] Define entry symbol (`_start` or `kernel_entry`)

---

## ✅ Stage 3: Build System
- [ ] Update `Makefile`:
  - [ ] Assemble `bootloader.asm` → `bootloader.bin`
  - [ ] Compile kernel C files with `-ffreestanding -m32 -nostdlib`
  - [ ] Link kernel using `linker.ld`
  - [ ] Concatenate bootloader + kernel into `os-image.bin`
  - [ ] Add `make run` → launch with QEMU

---

## ✅ Stage 4: Memory Management
- [ ] Port existing `memory.c` into kernel:
  - [ ] Replace `printf` with VGA print
  - [ ] Test `alloc_page()` and `free_page()` inside `kernel_main`

---

## ✅ Stage 5: Extended Features (later)
- [ ] Implement keyboard input (using PS/2 interrupts)
- [ ] Implement paging (virtual memory)
- [ ] Implement a very basic filesystem (FAT12 or custom)
- [ ] Implement a simple shell interface
- [ ] Add user programs (ELF loader)

---

## 🚀 End Goal
A minimal OS that:
- Boots from BIOS with a custom bootloader
- Loads a C kernel
- Supports memory allocation
- Prints messages to screen
- Provides a shell-like interface (Arch Linux style inspiration)
