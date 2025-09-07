global main
extern printf
extern scanf
extern system

section .data
    input db "Enter a number: ", 0
    fmt db "%d", 0
    msg db "Fibonacci sequence up to the %d-th number:", 10, 0
    fib db "%lld ", 0 
    newline db 10, 0
    cmd db "pause", 0

section .bss
    n resd 1

section .text
main:
    sub rsp, 40

    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel n]
    call scanf

    lea rcx, [rel msg]
    mov edx, [rel n]
    call printf

    mov rbx, 0
    mov rsi, 1
    xor rdi, rdi

    lea rcx, [rel fib]
    mov rdx, rbx
    call printf

.fib_loop:
    lea rcx, [rel fib]
    mov rdx, rsi
    call printf

    mov rax, rsi
    add rsi, rbx 
    mov rbx, rax

    inc rdi
    cmp edi, [rel n]
    jl .fib_loop

    lea rcx, [rel newline]
    call printf

    lea rcx, [rel cmd]
    call system

    add rsp, 40
    xor eax, eax
    ret