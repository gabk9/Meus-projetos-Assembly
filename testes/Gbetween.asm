global main
extern printf
extern scanf

section .data
    prompt db "Type-in a number: ", 0
    prompt_in db "%d", 0
    msg db "The biggest number between %d, %d and %d is %d", 10, 0

section .bss
    numbers resd 3

section .text
main:
    sub rsp, 32

    xor rsi, rsi

.read_loop:
    lea rcx, [rel prompt]
    xor rax, rax
    call printf

    lea rcx, [rel prompt_in]
    mov r8, rsi
    imul r8, 4
    lea rdx, [rel numbers]
    add rdx, r8
    xor rax, rax
    call scanf

    inc rsi
    cmp rsi, 3
    jl .read_loop

    mov eax, dword [rel numbers]
    mov ebx, dword [rel numbers+4]
    mov ecx, dword [rel numbers+8]

    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, ecx
    cmovl eax, ecx

    sub rsp, 8
    mov dword [rsp], eax
    lea rcx, [rel msg]
    mov edx, dword [rel numbers]
    mov r8d, dword [rel numbers+4]
    mov r9d, dword [rel numbers+8]
    xor rax, rax
    call printf
    add rsp, 8

    add rsp, 32
    xor eax, eax
    ret
