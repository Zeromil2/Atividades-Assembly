.data
result: .word 0
remainder: .word 0

.text
main:
	#pegando os inputs
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	move $t2, $zero #variável que será utilizada para obter o quociente
	
	bgez $t0, t0positivo
	bltz $t1, transformaPositivos #ambos são negativos (e irão virar positivos)
	j DivisaoNegativoPositivo #dividendo negativo e divisor positivo
	
	t0positivo:
	bgez $t1, DivisaoMesmoSinal #ambos são positivos
	j DivisaoPositivoNegativo #dividendo positivo e divisor negativo
	
	transformaPositivos:
	abs $t0, $t0
	abs $t1, $t1
	j DivisaoMesmoSinal
	
	#subtrai o valor do dividendo, até o seu valor absoluto for menor que o valor absoluto do divisor
	DivisaoMesmoSinal:
	blt $t0, $t1, exit
	sub $t0, $t0, $t1
	addi $t2, $t2, 1 #incrementa em 1 o valor do quociente
	j DivisaoMesmoSinal
	
	DivisaoNegativoPositivo:
	abs $t3, $t0 #vai assumir o valor absoluto do dividendo
	blt $t3, $t1, casoEspecial
	add $t0, $t0, $t1
	subi $t2, $t2, 1
	j DivisaoNegativoPositivo
	
	DivisaoPositivoNegativo:
	abs $t3, $t1 #vai assumir o valor absoluto do divisor
	blt $t0, $t3, exit
	add $t0, $t0, $t1
	subi $t2, $t2, 1
	j DivisaoPositivoNegativo
	
	exit:
	sw $t2, result
	sw $t0, remainder
	li $v0, 10
	syscall
	
	casoEspecial:
	sw $t2, result
	sw $t3, remainder
	li $v0, 10
	syscall
	