.data

    hello: 
        .asciz "Hello, "
        length = . - hello

    name:
        .asciz "%s"
        size_of_buffer = 32

    end_str:
        .ascii "\n"


# static memory for name
.bss
    .lcomm buffer, size_of_buffer

.text
    .global _start

_start:
    # read name
    movq $name, %rdi
    movq $buffer, %rsi
    call scanf 

    # write "Hello, "
    movq $1, %rax
    movq $1, %rdi
    movq $hello, %rsi
    movq $length, %rdx
    syscall

    # write name
    movq $1, %rax
    movq $1, %rdi
    movq $buffer, %rsi
    movq $size_of_buffer, %rdx
    syscall

    # go to next line
    movq $1, %rax
    movq $1, %rdi
    movq $end_str, %rsi
    movq $1, %rdx
    syscall

    # exit
    movq $60, %rax
    movq $0, %rdi
    syscall
