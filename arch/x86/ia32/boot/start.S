    .section .text # Start of executable code section
    .globl _start # Declare the global entry point (visible to the linker)
    .extern start_kernel # Reference to the C function defined elsewhere

_start:
    call start_kernel # Call the C entry point of the kernel

hang:
    jmp hang # Infinite loop in case start_kernel returns
