.data
nao_existe: .asciiz "not"
equilatero: .asciiz "eq"
isosceles: .asciiz "iso"
escaleno: .asciiz "esc"
.text
main:
	#pegando os inputs
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	#testando se o triangulo existe, parte 1
	add $t3, $t1, $t2 #criando uma terceira variável para realizar comparacoes
	
	blt $t0, $t3, triangulo_parte2 #se ele for menor que a soma dos outros dois lados, continua
	#se nao for menor, ele diz que nao existe e encerra o programa
	li $v0, 4 
	la $a0, nao_existe
	syscall
	j exit
	
	#testando se o triangulo existe, parte 2
	triangulo_parte2:
	add $t3, $t0, $t2
	
	blt $t1, $t3, triangulo_parte3
	li $v0, 4
	la $a0, nao_existe
	syscall
	j exit
	
	#testando se o triangulo existe, parte 3
	triangulo_parte3:
	add $t3, $t0, $t1
	
	blt $t2, $t3, eh_triangulo
	li $v0, 4
	la $a0, nao_existe
	syscall
	j exit
	
	#analisando o tipo de triangulo
	eh_triangulo:
	beq $t0, $t1, nao_escaleno1
	#a partir daqui ele ja nao eh mais equilatero
	beq $t0, $t2, eh_isosceles
	beq $t1, $t2, eh_isosceles
	#se nenhuma dessas comparacoes for verdade, entao ele eh escaleno
	li $v0, 4 
	la $a0, escaleno
	syscall
	j exit
	
	nao_escaleno1:
	beq $t1, $t2, eh_equilatero
	#se nao forem iguais, entao eh isosceles
	li $v0, 4 
	la $a0, isosceles
	syscall
	j exit
	
	eh_isosceles:
	li $v0, 4 
	la $a0, isosceles
	syscall
	j exit
	
	eh_equilatero:
	li $v0, 4 
	la $a0, equilatero
	syscall
	j exit
	
	exit:
	li $v0, 10
	syscall
	
