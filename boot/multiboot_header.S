section .multiboot
align 4
    dd 0x1BADB002     ; magic
    dd 0              ; flags
    dd - (0x1BADB002 + 0) ; checksum

extern kmain
global _start

section .text
global _start
_start:
    call kmain
    hlt
.hang:
    jmp .hang
