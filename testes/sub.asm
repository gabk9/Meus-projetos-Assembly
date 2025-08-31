global main
extern printf

section .data
    msg db "%d - %d = %d", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 10
    mov rbx, 4
    sub rax, rbx

    lea rcx, [rel msg]
    mov rdx, 10
    mov r8, 4
    mov r9, rax
    call printf

    add rsp, 40
    xor eax, eax
    ret