section .data
    A dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    lenA equ ($ - A) / 4
    
    B dd 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
    lenB equ ($ - B) / 4
    
    msgA db "Array A: ", 0
    msgB db "Array B: ", 0
    msgC db "Array C (sum): ", 0
    format db "%d ", 0
    newline db 10, 0

section .bss
    C resd 12
    lenC equ 12

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp
    
    push msgA
    call printf
    add esp, 4
    
    mov ecx, lenA
    mov esi, A
printA:
    push ecx
    push dword [esi]
    push format
    call printf
    add esp, 8
    add esi, 4
    pop ecx
    loop printA
    
    push newline
    call printf
    add esp, 4
    
    push msgB
    call printf
    add esp, 4
    
    mov ecx, lenB
    mov esi, B
printB:
    push ecx
    push dword [esi]
    push format
    call printf
    add esp, 8
    add esi, 4
    pop ecx
    loop printB
    
    push newline
    call printf
    add esp, 4
    
    mov ecx, lenC
    mov esi, A
    mov edi, B
    mov ebx, C
    
sum_loop:
    mov eax, [esi]
    add eax, [edi]
    mov [ebx], eax
    
    add esi, 4
    add edi, 4
    add ebx, 4
    
    loop sum_loop
    
    push msgC
    call printf
    add esp, 4
    
    mov ecx, lenC
    mov esi, C
printC:
    push ecx
    push dword [esi]
    push format
    call printf
    add esp, 8
    add esi, 4
    pop ecx
    loop printC
    
    push newline
    call printf
    add esp, 4
    
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret
