.text
main:
	# pegando os inputs
	li $v0, 5
	syscall
	move $a0, $v0 # dividendo
	
	li $v0, 5
	syscall
	move $a1, $v0 # divisor
	
	bltz $a0, casoEspecial # caso em que o dividendo é negativo
	bltz $a1, divisorNegativo # vai pra parte em que o divisor é negativo
	
	jal moduloPositivo # vai para o mod em que o divisor é positivo 
	j exit # encerra o código
	
	divisorNegativo:
	jal moduloNegativo # vai para o mod em que o divisor é negativo
	j exit #encerra o código
	
	moduloPositivo:
	sub $sp, $sp, 8 # ajusta a stack reservando espaço para 2 itens
	sw $ra, 4($sp) # guarda endereço de retorno
	sw $a0, 0($sp) # guarda o argumento (dividendo)
	
	bge $a0, $a1, L1 # se o dividendo for maior ou igual ao divisor, ainda não é o caso base
	
	move $v1, $a0 # o registrador v1 recebe o resto da divisão
	add $sp, $sp, 8 # liberta o espaço da stack antes de retornar
	jr $ra # faz o retorno do caso base
	
	L1:
	sub $a0, $a0, $a1 # realiza a subtração entre dividendo e divisor
	jal moduloPositivo # faz a chamada recursiva da função
	#Ponto de retorno da chamada recursiva: (momento em que desempilha)
	lw $ra, 4($sp) # recupera o endereço de retorno
	lw $a0, 0($sp) # recupera o argumento passado
	add $sp, $sp, 8 # liberta o espaço da pilha
	jr $ra # faz o retorno do caso geral
	
	moduloNegativo:
	sub $sp, $sp, 8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	mul $t0, $a1, -1 # registrador temporário vai receber o valor positivo do divisor
	
	bgt $a0, $t0, L2 # se o dividendo for maior que o divisor, ele não estará no caso base
	
	sub $v1, $a0, $t0 # o registrador v1 recebe o resto da divisão
	add $sp, $sp, 8
	jr $ra
	
	L2:
	add $a0, $a0, $a1 # o dividendo vai ser somado com o divisor negativo
	jal moduloNegativo
	lw $ra, 4($sp) 
	lw $a0, 0($sp) 
	add $sp, $sp, 8
	jr $ra
	
	exit:
	li $v0, 10
	syscall
	
	#caso em que a0 é negativo
	casoEspecial:
	li $v1, 1
	li $v0, 10
	syscall
	
