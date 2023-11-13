section .data
section .text

global _add

_add:
    push ebp
    mov ebp, esp
    mov eax, 0            ; Initialize the sum to 0
    mov ecx, [ebp+8]      ; Load the array pointer
    mov edx, [ebp+12]     ; Load the number of elements

loop_start:
    cmp edx, 0            ; Check if we have reached the end of the array
    je loop_end

    add eax, [ecx]        ; Add the current array element to the sum
    add ecx, 4            ; Move to the next element (assuming 4-byte integers)
    sub edx, 1            ; Decrement the loop counter
    jmp loop_start

loop_end:
    pop ebp
    ret
