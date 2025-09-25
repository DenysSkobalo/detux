void kmain(void) {
  const char *str = "Hello from Detux!> ";
  char *vidmem = (char *)0xb8000;
  for (int i = 0; str[i] != '\0'; i++) {
    vidmem[i * 2] = str[i];
    vidmem[i * 2 + 1] = 0x07;
  }

  while (1) {
    __asm__ __volatile__("hlt");
  }
}
