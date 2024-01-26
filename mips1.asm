.data
a: .word 0
b: .word 0
result_perfect_square: .word 0
result_not_perfect: .word 0
v1: .word 0

.text
main:
    # Leitura do valor de a
    li $v0, 5           # código do syscall para leitura de inteiro
    syscall
    sw $v0, a           # armazena o valor de a na posição de memória 'a'

    li $t0, 0           # inicializa i = 0
    li $t1, 10          # condição do loop: i != 10
    li $t2, 1           # b = 1

for_loop:
    # Verifica se ii == a
    mul $t3, $t0, $t0   # i i
    lw $t4, a           # carrega o valor de 'a'
    bne $t3, $t4, end_loop   # branch para 'end_loop' se ii != a

    # Se ii == a, então b = 1 e guarda a em result_perfect_square
    sw $t2, b           # b = 1
    sw $t4, result_perfect_square  # guarda a em result_perfect_square
    lw $t7, result_perfect_square
    sw $t0, 9  #finalizar o loop

end_loop:
    addi $t0, $t0, 1    # incrementa i
    bne $t0, $t1, for_loop   # se i != 10, repete o loop

    # Verifica se a == 0, se verdadeiro, guarda 1 em v1
    lw $t4, a
    beq $t4, $zero, store_v1
    j exit

store_v1:
    li $t5, 1
    sw $t5, v1

exit:
    # Verifica se b == 0, se verdadeiro, guarda a em result_not_perfect
    lw $t2, b
    beqz $t2, bebe
    j fora

bebe:
    lw $t6, a
    sw $t6, result_not_perfect
fora: