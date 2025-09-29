ENTRY(_start) 
/* 
 * Define the entry point of the kernel.
 * The symbol `_start` must exist in one of the input object files (typically in start.S).
 */

SECTIONS 
{
  . = 1M;
  /* 
   * Set the starting virtual address of the kernel to 1 MiB (0x00100000).
   * This is the conventional location where GRUB loads Multiboot-compliant kernels.
   */

  .text : {
    *(.multiboot)   /* Multiboot header must be within the first 8 KiB */
    *(.text)        /* All executable code */
  }

  .rodata : {
    *(.rodata*)     /* Read-only data (e.g., strings, consts) */
  }

  .data : {
    *(.data)        /* Initialized writable data */
  }

  .bss : {
    *(.bss)         /* Uninitialized data (zero-filled at runtime) */
    *(COMMON)       /* Common symbols shared between multiple files */
  }
}
