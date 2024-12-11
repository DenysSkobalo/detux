#include <stdio.h>
#include "memory.h"

void test_memory() {
    init_memory();

    void* page1 = alloc_page();
    if (page1 != NULL) {
        printf("Page 1 allocated at: %p\n", page1);
    } else {
        printf("Memory allocation failed.\n");
    }

    void* page2 = alloc_page();
    if (page2 != NULL) {
        printf("Page 2 allocated at: %p\n", page2);
    }

    free_page(page1);
    free_page(page2);
    printf("Pages freed.\n");
}

int main() {
    test_memory();  
    return 0;
}
