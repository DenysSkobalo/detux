[bits 16]
[org 0x7C00]

start:
    ; Setup segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 ; stack pointer

    ; Print message
    mov si, msg
    call print_string

.done_print:
    ; Load kernel (1 sector at 0x1000)
    mov ah, 0x02 ; BIOS read sector
    mov al, 0x10 ; sectors to read
    mov ch, 0  ; cylineder 0
    mov dh, 0 ; head 0
    mov cl, 2 ; sector 2 (first sector is bootloader)
    mov bx, 0x1000 ; offset for load
    mov es, ax ; es=0
    int 0x13 ; BIOS call

    jc disk_error

    ; Jump to kernel
    jmp 0x0000:0x1000
	
disk_error:
    mov si, disk_msg
    call print_string
    jmp $

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; Data
msg db "Booting kernel...", 0
disk_msg db "Disk error!", 0

; Boot sector padding
times 510 - ($ - $$) db 0
dw 0xAA55 ; boot signature
