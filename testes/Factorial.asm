global main
extern printf
extern scanf

section .data
prompt db "Type-in a number: ", 0
prompt_in db "%d", 0
msg db "Number: %d", 10, "Factorial: %llu", 10, 0
zer db "The number %d is negative, please enter positive values", 10, 0

section .bss
    number resq 1

section .text
main:
    sub rsp, 32

    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel prompt_in]
    lea rdx, [rel number]
    call scanf

    mov rax, [rel number]
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
    add rsp, 32
    xor eax, eax
    ret
