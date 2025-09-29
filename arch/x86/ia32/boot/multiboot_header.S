    .section .multiboot # Define a new section for the Multiboot header
    .align 4 # Ensure 4-byte alignment (required by Multiboot)

    # Multiboot magic number
    .long 0x1BADB002 # Magic number required by the Multiboot spec

    # Multiboot flags (0 = no extra requirements)
    .long 0x0

    # Checksum = -(magic + flags)
    # GRUB checks: magic + flags + checksum == 0
    .long -(0x1BADB002 + 0)
