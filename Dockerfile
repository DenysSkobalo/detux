FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    xorriso \
    grub-pc-bin \
    mtools \
    qemu-system-x86 \
    nasm \
    git \
    gcc \
    make \
    binutils \
    gcc-multilib \
    libc6-dev-i386

WORKDIR /detux
CMD ["make"]
