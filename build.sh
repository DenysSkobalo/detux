#!/bin/bash
set -e

echo "[+] Building detux.iso in Docker..."

docker run --rm \
  -v "$(pwd)":/detux \
  -w /detux \
  detux \
  make

if [ -f iso/detux.iso ]; then
  echo "[✓] ISO built successfully: iso/detux.iso"
else
  echo "[✗] Build failed: iso/detux.iso not found"
  exit 1
fi
