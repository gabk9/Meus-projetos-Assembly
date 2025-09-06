global main
extern printf
extern scanf
extern system

section .data
    tittle db "======Calculator======", 10, 0
    options db "[1] Multiplication", 10, "[2] Division", 10, "[3] Addition", 10, "[4] Subtraction" ,10, "[0] Exit program", 10, 0

    choice db "Choose an option: ", 0
    choice_in db "%d", 0

    err db 10, "Error: Operation not permitted!", 10, 0
    end db 10, "Terminating program, bye!!", 10, 0
    cmd db "pause", 0
    cmd2 db "cmd.exe /c cls", 0

    n db "Type-in a number: ", 0
    n_in db "%d", 0

    div_or db 10, "or", 10, 0
    div_err db 10, "Cant divide by 0!!", 10, 0
    
    multi db 10, "%d x %d = %d", 10, 0
    division db 10, "%.2f / %.2f = %.2f", 10, 0
    division2 db 10, "%d / %d = %d with remainder: %d", 10, 0
    sum db 10, "%d + %d = %d", 10, 0 
    min db 10, "%d - %d = %d", 10, 0
    endline db 10, 0

section .bss
    num1 resd 1 
    num2 resd 1
    op resd 1

section .text
main:
    sub rsp, 40

main_menu:
    sub rsp, 32
    lea rcx, [rel tittle]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel options]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel choice]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel choice_in]
    lea rdx, [rel op]
    call scanf
    add rsp, 32

    mov eax, dword [rel op]

    cmp eax, 1
    je multiplication_menu
    cmp eax, 2
    je division_menu2
    cmp eax, 3
    je addition_menu
    cmp eax, 4
    je Subtraction_menu
    cmp eax, 0
    je endif
    jmp invalid_option

questions:
    sub rsp, 32
    lea rcx, [rel n]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel n_in]
    lea rdx, [rel num1]
    call scanf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel n]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel n_in]
    lea rdx, [rel num2]
    call scanf
    add rsp, 32
    ret

Subtraction_menu:
    call questions

    mov eax, dword [rel num1]
    mov ebx, dword [rel num2]
    sub eax, ebx
    
    sub rsp, 32
    lea rcx, [rel min]
    mov edx, dword [rel num1]
    mov r8d, dword [rel num2]
    mov r9d, eax
    call printf
    add rsp, 32

    call newline
    jmp main_menu

addition_menu:
    call questions

    mov eax, dword [rel num1]
    mov ebx, dword [rel num2]
    add eax, ebx
    
    sub rsp, 32
    lea rcx, [rel sum]
    mov edx, dword [rel num1]
    mov r8d, dword [rel num2]
    mov r9d, eax
    xor rax, rax
    call printf
    add rsp, 32

    call newline
    jmp main_menu

division_menu1:
    ; TODO implement float division
    jmp main_menu

division_menu2:
    call questions

    mov eax, [rel num1]
    cdq
    mov ebx, [rel num2]
    test ebx, ebx
    jz is_zero
    idiv ebx

    sub rsp, 32
    mov [rsp + 32], edx
    lea rcx, [rel division2]
    mov edx, [rel num1]
    mov r8d, [rel num2]
    mov r9d, eax 
    call printf
    add rsp, 32

    call newline
    jmp main_menu

is_zero:
    sub rsp, 32
    lea rcx, [rel div_err]
    call printf

    lea rcx, [rel cmd]
    xor rax, rax
    call system
    add rsp, 32

    call newline
    jmp main_menu

multiplication_menu:
    call questions

    mov eax, dword [rel num1]
    mov ebx, dword [rel num2]
    imul eax, ebx
    
    sub rsp, 32
    lea rcx, [rel multi]
    mov edx, dword [rel num1]
    mov r8d, dword [rel num2]
    mov r9d, eax
    xor rax, rax
    call printf
    add rsp, 32

    call newline
    jmp main_menu

newline:
    sub rsp, 32
    lea rcx, [rel endline]
    xor rax, rax
    call printf
    add rsp, 32
    ret

invalid_option:
    sub rsp, 32
    lea rcx, [rel err]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel cmd]
    call system
    add rsp, 32

    jmp main_menu
endif:
    sub rsp, 32
    lea rcx, [rel end]
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel cmd]
    call system
    add rsp, 32

    add rsp, 40
    xor eax, eax
    ret
