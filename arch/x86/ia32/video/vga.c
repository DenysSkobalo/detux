// SPDX-License-Identifier: MIT
// arch/x86/ia32/video/vga.c - VGA text output implementation for Detux kernel

#include "../include/vga.h"

/**
 * @brief Write a string to VGA text mode video memory.
 *
 * This function writes each character from the null-terminated string `str`
 * into VGA video memory pointed to by `vidmem`, with the given color attribute.
 * Each character is written to every second byte (even index), while the
 * attribute is written to the following byte (odd index).
 *
 * This implementation writes linearly starting at the beginning of the
 * video memory (top-left corner of the screen) and does not handle:
 * - line wrapping
 * - scrolling
 * - cursor management
 *
 * @param str     Null-terminated string to be displayed.
 * @param vidmem  Pointer to VGA video memory (typically VGA_TEXT_MODE).
 * @param attr    VGA color attribute (foreground + background).
 */
void vga_write(const char *str, volatile char *vidmem, uint8_t attr) {
  for (int i = 0; str[i] != '\0'; i++) {
    vidmem[i * 2] = str[i];   // ASCII character
    vidmem[i * 2 + 1] = attr; // Attribute byte
  }
}
