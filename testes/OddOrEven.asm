global main
extern printf
extern scanf

section .data
    prompt db "Type-in a number: ", 0
    prompt_in db "%d", 0
    
    odd db "%d is an odd number", 10, 0
    evn db "%d is an even number", 10, 0
    zer db "The number is %d, which is neutral", 10, 0

section .text
main:
    sub rsp, 44

    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel prompt_in]
    lea rdx, [rsp + 44]
    call scanf

    mov rax, [rsp + 44]
    test rax, rax
    jz rax_is_zero

    test rax, 1
    jnz is_odd
    jmp is_even

is_odd:
    lea rcx, [rel odd]
    mov rdx, rax
    call printf
    jmp endif

is_even:
    lea rcx, [rel evn]
    mov rdx, rax
    call printf
    jmp endif

rax_is_zero:
    lea rcx, [rel zer]
    mov rdx, rax
    call printf

endif:
    add rsp, 44
    xor eax, eax
    ret
