global main
extern printf

section .data
    msg db "Number: %d", 10, "Factorial: %llu", 10, 0
    
    zer db "The number %d is negative, please enter positive values", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 5
    mov r10, rax
    mov rbx, 1

    cmp rax, 0
    jg do_factorial
    jz is_zero
    jl is_negative

is_negative:
    lea rcx, [rel zer]
    mov rdx, r10
    
    call printf
    jmp endif

is_zero:
    lea rcx, [rel msg]
    mov rdx, r10
    mov r8, rbx

    call printf
    jmp endif    

do_factorial:
.loop:
    imul rbx, rax
    dec rax
    jnz .loop

    lea rcx, [rel msg]
    mov rdx, r10
    mov r8, rbx
    
    call printf

endif:
    add rsp, 40
    xor eax, eax
    ret