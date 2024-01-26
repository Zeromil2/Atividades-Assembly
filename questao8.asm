.data
	meuArray: .word 1, 3, 5, 8, 9, 12, 15 # array ordenado
	tamanhoArray: .word 8 # tamanho do array
	procurado: .word 4 # n�mero procurado
.text
main:
	la $a0, meuArray # endere�o do array
	lw $a2, tamanhoArray # carrega o tamanho do array, a2 ser� o end
	lw $a1, procurado # carrega o elemento procurado
	mul $a2, $a2, 4 # multiplica por 4 porque � do tipo word (int)
	sub $a2, $a2, 4 # subtrai 4 pra saber a posi��o certa do �ltimo valor na mem�ria
	move $a3, $zero # a3 � o start
	
	jal buscaBinaria
	j exit
	
	buscaBinaria:
	sub $sp, $sp, 12 # separando espa�o para 3 registradores na stack
	sw $ra, 8($sp) # guarda endere�o de retorno
	sw $a3, 4($sp) # guarda o valor do start
	sw $a2, 0($sp) # guarda o valor do end
	
	bgt $a3, $a2, naoAchou # se o start for maior que o end, n�o achou
	
	div $t1, $a3, 4 # vai pegar o indice padrao do start
	div $t2, $a2, 4 # vai pegar o indice padrao do end
	add $t0, $t1, $t2 # (start + end)
	div $t0, $t0, 2 # middle = (start + end) / 2, � o �ndice central
	mul $t0, $t0, 4 # indice do middle em assembly (considerando que � do tipo word)
	
	lw $t3, meuArray($t0) # pega o valor do array no indice t0
	bgt $a1, $t3, procuraPraBaixo # se o n�mero procurado for maior que o valor central
	blt $a1, $t3, procuraPraCima # se o n�mero procurado for menor que o valor central
	# N�MERO ENCONTRADO
	li $v0, 1 # armazena 1 no registrador v0
	move $v1, $t0 # num�ro foi encontrado e o seu �ndice vai para v1
	lw $ra, 8($sp) 
	lw $a3, 4($sp) 
	lw $a2, 0($sp) 
	add $sp, $sp, 12 
	jr $ra
	
	procuraPraBaixo:
	add $a3, $t0, 4 # o start recebe o valor de middle + 4
	jal buscaBinaria # realiza a recurs�o com o novo valor de start
	#Ponto de retorno da chamada recursiva: (momento em que desempilha)
	lw $ra, 8($sp) # recupera o endere�o de retorno
	lw $a3, 4($sp) # recupera o valor de start
	lw $a2, 0($sp) # recupera o valor do end
	add $sp, $sp, 12 # liberta o espa�o de 3 vari�veis
	jr $ra # faz o retorno pra onde foi chamado pela �ltima vez
	
	procuraPraCima:
	sub $a2, $t0, 4 # o end recebe o valor de middle - 4
	jal buscaBinaria
	lw $ra, 8($sp) 
	lw $a3, 4($sp) 
	lw $a2, 0($sp) 
	add $sp, $sp, 12 
	jr $ra
	
	naoAchou:
	li $v0, 2 # se n�o achar, registra o valor 2 em v0
	lw $ra, 8($sp) 
	lw $a3, 4($sp) 
	lw $a2, 0($sp) 
	add $sp, $sp, 12 # liberta o espa�o da stack antes de retornar
	jr $ra # faz o retorno do caso base
	
	exit:
	