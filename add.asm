section .data
    message db "value %d", 10, 13, 0
    debug db "%d ", 0, 13, 0
    NEWLINE db "", 10, 13, 0
    tests db "hello world", 10, 13, 0
    half_window dd 0 
    max_y dd 0 
    max_x dd 0
    x dd 0
    y dd 0
    half_window_negative dd 0
    max_z dd 0
    total dd 0
    i dd 0
    j dd 0
    offsetIndex dd 0


section .text
    global _add
    extern _printf

_add:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+8]       ; Load the array pointer
    mov edx, [ebp+12]      ; Load the second array pointer

    ; GET HALF WINDOW [ FOR SAMPLING WINDOW ] 
    mov eax, [ebp+24]
    mov edx, 0
    mov ebx, 2
    idiv ebx
    mov [half_window], eax

    ; GET NEGATIVE HALF WINDOW [ USED FOR SURROUNDING INDICES OF TARGET]
    mov edx, -1
    IMUL eax, edx
    mov [half_window_negative], eax

    ; GET POSITIVE HALF WINDOW + 1 [ USED FOR SURROUNDING INDICES OF TARGET ]
    IMUL eax, edx
    add eax, 1
    mov [max_z], eax

    ; Compute Max X
    mov eax, [ebp+16]
    sub eax, [half_window]
    mov [max_x], eax


    ; Compute Max Y
    mov eax, [ebp+20]
    sub eax, [half_window]
    mov [max_y], eax

    mov eax, [half_window]
    mov ebx, [max_y]

    mov esi, ecx
    ; LOOP THROUGH COLUMNS CONTAINING ELEMENTS WE WILL COMPUTE THE AVERAGE OF
    loop1:
        ; Preservation 1
        mov [y], eax ; retain y counter for loop1
        mov eax, [half_window]
        mov ebx, [max_x]

        loop2:
            ; RESET total
            mov DWORD [total], 0
        
            ; COMPUTE FOR AVERAGE 
            ; Preservation 2
            mov [x], eax ; retain x counter for loop1
            mov eax, [half_window_negative]
            mov ebx, [max_z]
            
            loop3:
                ;loop body

                ; Preservation 3
                mov [i], eax ; retain i counter for loop1
                mov eax, [half_window_negative]
                loop4:

                    ; LOOP BODY   
                    ; Preservation 4
                    mov [j], eax ; retain j counter 
                    mov eax, 0
                    mov ebx, 0

                    ; Local Body
                    mov eax, [y]
                    add eax, [i]

                    mov ebx, [x]
                    add ebx, [j]

                    imul eax, [ebp+16]
                    add eax, ebx

                    mov [offsetIndex], eax
                    imul eax, 4
                    
                    ; ACCESS ELEMENT
                    add esi, eax

                    ; STORE ELEMENT VALUE
                    mov edi, [esi]

                    ; REVERSE OFFSET
                    sub esi, eax

                    ; add to total
                    mov eax, [total]
                    add eax, edi
                    mov [total], eax
                    
                    ; Retrieve 4
                    mov eax, [j]
                    mov ebx, [max_z]

                    ; LOOP CONDITION4: -HALF WINDOW < HALF_WINDOW + 1
                    inc eax
                    cmp eax, ebx
                    jl loop4

                ; RETRIEVE LOOP VARIABLES 3
                mov eax, [i]

                ; LOOP CONDITION3: -HALF WINDOW < HALF_WINDOW + 1
                inc eax
                cmp eax, ebx
                jl loop3
            
            ; GET TOTAL
            mov eax, [total]

            ; GET DIVISOR
            mov ebx, [ebp+24]
            imul ebx, ebx
            
            mov ecx,ebx
            shr ecx,1

            add eax,ecx

            ;mov ecx,ebx

            ; Divide
            mov edx, 0
            idiv ebx

            push eax
            push debug
            call _printf
            pop eax
            pop eax

            ; Store the average into the second array
            mov edx, [y]
            imul edx, dword [ebp+16]
            add edx, [x]

            ; Debug print after calculating the index
            ;push edx
            ;push debug
            ;call _printf
            ;add esp, 8

            ;push eax
            ;push debug
            ;call _printf
            ;add esp,8

            mov ebx, [ebp+12]  ; Get the base address of arr2
            mov [ebx + edx*4], eax  ; Store the average into arr2

            push edx
            push debug
            call _printf
            add esp, 8

            ;push eax
            ;push debug
            ;call _printf
            ;add esp, 8

            sub edx, edx


            ; RETRIEVE LOOP VARIABLES 2
            mov eax, [x]
            mov ebx, [max_x] 


            ; LOOP CONDITION2: HALF WINDOW < IMAGE_SIZE_X - HALF_WINDOW
            inc eax
            cmp eax, ebx
            jl loop2

        ; RETRIEVE LOOP VARIABLES 1
        mov eax, [y]
        mov ebx, [max_y] 
        
        ; LOOP CONDITION1: HALF WINDOW < IMAGE_SIZE_Y - HALF_WINDOW
        inc eax
        cmp eax, ebx
        jl loop1


    
    pop ebp
    ret
