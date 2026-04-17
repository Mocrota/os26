     1                                  section .data
     2 00000000 010000000200000003-         A dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
     2 00000009 000000040000000500-
     2 00000012 000006000000070000-
     2 0000001B 000800000009000000-
     2 00000024 0A0000000B0000000C-
     2 0000002D 000000             
     3                                      lenA equ ($ - A) / 4
     4                                      
     5 00000030 0C0000000B0000000A-         B dd 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
     5 00000039 000000090000000800-
     5 00000042 000007000000060000-
     5 0000004B 000500000004000000-
     5 00000054 030000000200000001-
     5 0000005D 000000             
     6                                      lenB equ ($ - B) / 4
     7                                      
     8 00000060 417272617920413A20-         msgA db "Array A: ", 0
     8 00000069 00                 
     9 0000006A 417272617920423A20-         msgB db "Array B: ", 0
     9 00000073 00                 
    10 00000074 417272617920432028-         msgC db "Array C (sum): ", 0
    10 0000007D 73756D293A2000     
    11 00000084 25642000                    format db "%d ", 0
    12 00000088 0A00                        newline db 10, 0
    13                                  
    14                                  section .bss
    15 00000000 <res 30h>                   C resd 12
    16                                      lenC equ 12
    17                                  
    18                                  section .text
    19                                      extern printf
    20                                      global main
    21                                  
    22                                  main:
    23 00000000 55                          push ebp
    24 00000001 89E5                        mov ebp, esp
    25                                      
    26 00000003 68[60000000]                push msgA
    27 00000008 E8(00000000)                call printf
    28 0000000D 81C404000000                add esp, 4
    29                                      
    30 00000013 B90C000000                  mov ecx, lenA
    31 00000018 BE[00000000]                mov esi, A
    32                                  printA:
    33 0000001D 51                          push ecx
    34 0000001E FF36                        push dword [esi]
    35 00000020 68[84000000]                push format
    36 00000025 E8(00000000)                call printf
    37 0000002A 81C408000000                add esp, 8
    38 00000030 81C604000000                add esi, 4
    39 00000036 59                          pop ecx
    40 00000037 E2E4                        loop printA
    41                                      
    42 00000039 68[88000000]                push newline
    43 0000003E E8(00000000)                call printf
    44 00000043 81C404000000                add esp, 4
    45                                      
    46 00000049 68[6A000000]                push msgB
    47 0000004E E8(00000000)                call printf
    48 00000053 81C404000000                add esp, 4
    49                                      
    50 00000059 B90C000000                  mov ecx, lenB
    51 0000005E BE[30000000]                mov esi, B
    52                                  printB:
    53 00000063 51                          push ecx
    54 00000064 FF36                        push dword [esi]
    55 00000066 68[84000000]                push format
    56 0000006B E8(00000000)                call printf
    57 00000070 81C408000000                add esp, 8
    58 00000076 81C604000000                add esi, 4
    59 0000007C 59                          pop ecx
    60 0000007D E2E4                        loop printB
    61                                      
    62 0000007F 68[88000000]                push newline
    63 00000084 E8(00000000)                call printf
    64 00000089 81C404000000                add esp, 4
    65                                      
    66 0000008F B90C000000                  mov ecx, lenC
    67 00000094 BE[00000000]                mov esi, A
    68 00000099 BF[30000000]                mov edi, B
    69 0000009E BB[00000000]                mov ebx, C
    70                                      
    71                                  sum_loop:
    72 000000A3 8B06                        mov eax, [esi]
    73 000000A5 0307                        add eax, [edi]
    74 000000A7 8903                        mov [ebx], eax
    75                                      
    76 000000A9 81C604000000                add esi, 4
    77 000000AF 81C704000000                add edi, 4
    78 000000B5 81C304000000                add ebx, 4
    79                                      
    80 000000BB E2E6                        loop sum_loop
    81                                      
    82 000000BD 68[74000000]                push msgC
    83 000000C2 E8(00000000)                call printf
    84 000000C7 81C404000000                add esp, 4
    85                                      
    86 000000CD B90C000000                  mov ecx, lenC
    87 000000D2 BE[00000000]                mov esi, C
    88                                  printC:
    89 000000D7 51                          push ecx
    90 000000D8 FF36                        push dword [esi]
    91 000000DA 68[84000000]                push format
    92 000000DF E8(00000000)                call printf
    93 000000E4 81C408000000                add esp, 8
    94 000000EA 81C604000000                add esi, 4
    95 000000F0 59                          pop ecx
    96 000000F1 E2E4                        loop printC
    97                                      
    98 000000F3 68[88000000]                push newline
    99 000000F8 E8(00000000)                call printf
   100 000000FD 81C404000000                add esp, 4
   101                                      
   102 00000103 B800000000                  mov eax, 0
   103 00000108 89EC                        mov esp, ebp
   104 0000010A 5D                          pop ebp
   105 0000010B C3                          ret
