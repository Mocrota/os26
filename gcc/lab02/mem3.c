#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    void* brk0 = sbrk(0);
    printf("\nHEAP брейк0: %p\n", brk0);
    
    if (argc > 1)
    {
        int h_size = atoi(argv[1]);
        printf("Размер = %d единиц\n", h_size);
        
        // ПЕРВЫЙ МАССИВ
        double* ptr = (double*)malloc(h_size * sizeof(double));
        void* brk1 = sbrk(0);
        printf("После 1-го malloc: %p (+%ld)\n", brk1, (long)((char*)brk1 - (char*)brk0));
        
        for (int i = 0, j = 12; i < 10; i++, j += 5)
            *(ptr + i) = j + 0.43;
        
        for (int i = 9; i >= 0; i--)
            printf("ptr[%d] = %.3f\n", i, *(ptr + i));
        
        // ВТОРОЙ МАССИВ (БЕЗ free - УТЕЧКА!)
        printf("\n=== ВТОРОЙ МАССИВ (УТЕЧКА) ===\n");
        int* ptr2 = (int*)malloc(h_size * sizeof(int));
        
        void* brk2 = sbrk(0);
        printf("После 2-го malloc: %p (+%ld)\n", brk2, (long)((char*)brk2 - (char*)brk1));
        printf("ОБЩАЯ УТЕЧКА: %ld байт\n", (long)((char*)brk2 - (char*)brk0));
        
        for (int i = 0; i < 10; i++)
            ptr2[i] = i * i;
        
        for (int i = 0; i < 10; i++)
            printf("ptr2[%d] = %d\n", i, ptr2[i]);
        
        // ⚠️ НЕТ free() - УТЕЧКА ПАМЯТИ!
        
        void* brk3 = sbrk(0);
        printf("\nИТОГОВАЯ УТЕЧКА: %ld байт\n", (long)((char*)brk3 - (char*)brk0));
    }
    return 0;
}
