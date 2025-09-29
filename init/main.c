// SPDX-License-Identifier: MIT
// Detux Kernel Initialization — Entry point of the kernel

#include "../arch/x86/ia32/include/platform.h"
#include "../arch/x86/ia32/include/vga.h"

// Forward declaration of the main kernel logic */
void kernel_main(void);

/**
 * Entry point called after bootloader hands over control to kernel.
 *
 * This is invoked from start.S after early platform setup.
 * It immediately jumps to `kernel_main`, where kernel logic begins.
 */
void start_kernel(void) { kernel_main(); }

/**
 * Main function of the Detux kernel.
 *
 * Initializes basic subsystems (currently: VGA output),
 * and enters an infinite HLT loop to halt the CPU until next interrupt.
 */
void kernel_main(void) {
  vga_write("Hello from Detux", VGA_TEXT_MODE, VGA_COLOR_WHITE_ON_BLACK);

  // Idle loop to halt the CPU (saves power while doing nothing)
  while (1) {
    __asm__ __volatile__("hlt");
  }
}
