#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    void* brk0 = sbrk(0);
    printf("\nHEAP брейк0-адрес: %p\n", brk0);
    
    if (argc > 1)
    {
        int h_size = atoi(argv[1]);
        printf("Размер = %d единиц\n", h_size);
        
        // ПЕРВЫЙ МАССИВ
        double* ptr = (double*)malloc(h_size * sizeof(double));
        printf("Адрес первого массива: %p\n", (void*)ptr);
        
        void* brk1 = sbrk(0);
        printf("HEAP брейк1: %p (прирост: %ld байт)\n", brk1, (long)((char*)brk1 - (char*)brk0));
        
        // Заполнение
        for (int i = 0, j = 12; i < 10; i++, j += 5)
            *(ptr + i) = j + 0.43;
        
        for (int i = 9; i >= 0; i--)
            printf("ptr[%d] = %.3f\n", i, *(ptr + i));
        
        // ВТОРОЙ МАССИВ
        printf("\n=== ВТОРОЙ МАССИВ (int) ===\n");
        int* ptr2 = (int*)malloc(h_size * sizeof(int));
        printf("Адрес второго массива: %p\n", (void*)ptr2);
        
        void* brk1_5 = sbrk(0);
        printf("HEAP брейк1.5: %p (прирост: %ld байт)\n", brk1_5, (long)((char*)brk1_5 - (char*)brk1));
        
        for (int i = 0; i < 10; i++)
            ptr2[i] = i * i;
        
        for (int i = 0; i < 10; i++)
            printf("ptr2[%d] = %d\n", i, ptr2[i]);
        
        free(ptr2);
        free(ptr);
        
        void* brk2 = sbrk(0);
        printf("\nHEAP брейк2: %p\n", brk2);
        printf("Итоговая разница: %ld байт\n", (long)((char*)brk2 - (char*)brk0));
    }
    else
    {
        printf("Использование: %s <размер>\n", argv[0]);
        printf("Пример: %s 100\n", argv[0]);
    }
    
    return 0;
}
