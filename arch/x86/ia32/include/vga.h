// SPDX-License-Identifier: MIT
// arch/x86/ia32/include/vga.h - VGA text mode interface for Detux kernel

#ifndef _ARCH_X86_IA32_VGA_H
#define _ARCH_X86_IA32_VGA_H

#include <stdint.h>

/**
 * @def VGA_TEXT_MODE
 * @brief Base memory address for VGA text mode (80x25 characters)
 *
 * Each character cell takes 2 bytes:
 * - 1 byte for the ASCII character
 * - 1 byte for the color attribute (foreground + background)
 */
#define VGA_TEXT_MODE ((volatile char *)0xB8000)

/**
 * @def VGA_COLOR_WHITE_ON_BLACK
 * @brief VGA color attribute for white text on black background
 */
#define VGA_COLOR_WHITE_ON_BLACK 0x0F

/**
 * @brief Write a null-terminated string to VGA text mode video memory.
 *
 * Writes characters from the provided string `str` into the VGA text mode
 * buffer pointed to by `vidmem`, using the given attribute `attr`.
 *
 * @param str     Null-terminated ASCII string to display.
 * @param vidmem  Pointer to the VGA video memory (e.g., VGA_TEXT_MODE).
 * @param attr    VGA color attribute byte.
 */
void vga_write(const char *str, volatile char *vidmem, uint8_t attr);

#endif /* _ARCH_X86_IA32_VGA_H */
