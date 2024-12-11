#include <stdint.h>
#include <stddef.h>

// Memory size and page table
#define MEMORY_SIZE 0x10000000 // 256MB memory for example
#define PAGE_SIZE 4096

uint8_t memory_map[MEMORY_SIZE / PAGE_SIZE / 8]; // Bitmap to track memory usage

void init_memory(){
	for(int i = 0; i < sizeof(memory_map); i++) {
		memory_map[i] = 0; // Mark all memory as free
	}
}

int is_page_free(uint32_t page){
	return (memory_map[page / 8] & (1 << (page % 8))) == 0;
}

void* alloc_page(){
	for(uint32_t i = 0; i < MEMORY_SIZE / PAGE_SIZE; i++) {
		if(is_page_free(i)) {
			memory_map[i / 8] |= (1 << (i % 8)); // Markup the page as used
			return (void*)(i * PAGE_SIZE);
		}
	}
	return NULL; // If there no free pages
}

void free_page(void* page){
	uint32_t page_num = (uint32_t)page / PAGE_SIZE;
	memory_map[page_num / 8] &= ~(1 << (page_num % 8));
}