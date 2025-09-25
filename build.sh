#!/bin/bash

echo "[+] Building detux.iso in Docker..."

docker run --rm -it \
  -v "$PWD:/detux" \
  -w /detux \
  detux

if [ -f iso/detux.iso ]; then
    echo "[✓] ISO created: detux.iso"
else
    echo "[✗] Build failed: iso/detux.iso not found"
    exit 1
fi
