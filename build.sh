#!/bin/bash

set -e

echo "[+] Building detux.iso in Docker..."

docker run --rm -it \
  --platform linux/amd64 \
  -v "$PWD:/detux" \
  -w /detux \
  detux make make-iso

if [ -f iso/detux.iso ]; then
    echo "[✓] ISO created: iso/detux.iso"
else
    echo "[✗] Build failed: iso/detux.iso not found"
    exit 1
fi
