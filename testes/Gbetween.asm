global main
extern printf
extern scanf

section .data
    prompt db "Type-in a number: ", 0
    prompt_in db "%d", 0
    msg db "The biggest number between %d, %d and %d is %d", 10, 0

section .text
main:
    sub rsp, 48
    
    xor rsi, rsi

.read_loop:
    lea rcx, [rel prompt]
    xor rax, rax
    call printf

    lea rcx, [rel prompt_in]
    lea rdx, [rsp+32+rsi*4]
    xor rax, rax
    call scanf

    inc rsi
    cmp rsi, 3
    jl .read_loop

    mov eax, dword [rsp+32]
    mov ebx, dword [rsp+36]
    mov ecx, dword [rsp+40]

    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, ecx
    cmovl eax, ecx

    lea rcx, [rel msg]
    mov edx, dword [rsp+32]
    mov r8d, dword [rsp+36] 
    mov r9d, dword [rsp+40] ;TODO fix ts bc it only outputs the 1st input
    xor rax, rax
    call printf

    add rsp, 56
    xor eax, eax
    ret