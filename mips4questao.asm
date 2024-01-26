.data
    seed:   .word 0
    mult_constant:  .word 1664525
    add_constant:   .word 1013904223

.text
    main:
        li $v0, 30
        syscall
        sw $v0, seed

        li $t0, 0
    loop:
        lw $t1, seed
        lw $t2, mult_constant
        mulu $t1, $t1, $t2

        lw $t3, add_constant
        addu $t1, $t1, $t3

        sw $t1, seed

        move $a0, $t1
        li $v0, 1
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        addi $t0, $t0, 1
        bne $t0, 10, loop

        li $v0, 10
        syscall

.data
    newline:    .asciiz "\n"
