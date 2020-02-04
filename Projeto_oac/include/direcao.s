# Define a direçao de onde a cobra vai
.text
DEFINE_DIRECAO:
	li t3, 0x00000000
	mv t2, sp
	li t0, 97		# ascii a
	beq s2, t0, ESQUERDA
	li t0, 100		# ascii d
	beq s2, t0, DIREITA
	li t0, 115		# ascii s
	beq s2, t0, BAIXO
	li t0, 119		# ascii w
	beq s2, t0, CIMA
	j FIM_DIRECAO
	
ESQUERDA:
	lw t0, 0(sp)# t0 contem a nova coordenada da cabeça da cobra considerando a direçao escolhida
	addi t0, t0, -4
	j MOVER_COBRA
	
DIREITA:
	lw t0, 0(sp)# t0 contem a nova coordenada da cabeça da cobra considerando a direçao escolhida
	addi t0, t0, 4
	j MOVER_COBRA
	
CIMA:
	lw t0, 0(sp)
	addi t0, t0, -320
	j MOVER_COBRA
	
BAIXO:
	lw t0, 0(sp)
	addi t0, t0, 320
	j MOVER_COBRA

#percorre toda a cobra atualizando as coordenadas de cada gomo	
MOVER_COBRA:	
	addi t4, s0, -1
	beq t4, zero, SO_CABECA
	slli t4, t4, 2	#offset da pilha
	add t2, t2, t4  # salva o novo endereço na cauda da pilha
	lw t1, 0(t2)
	mv t2, t1
	#################################################################
	#pinta o antigo endereço de preto
	sw t3, 0(t1)
	addi t1, t2, 4 #pintar uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -960 #pintar gomo 2 linhas acima
	sw t3, 0(t1)
	addi t1, t2, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -640 #pintar gomo 2 linhas acima
	sw t3, 0(t1)
	addi t1, t2, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -320 #pintar gomo 1 linha acima
	sw t3, 0(t1)
	addi t1, t2, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	sw t3, 0(t1)
	addi t1, t2, 320 #pintar gomo 1 linha abaixo
	sw t3, 0(t1)
	addi t1, t2, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, 640 #pintar gomo 2 linhas abaixo
	sw t3, 0(t1)
	addi t1, t2, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, 960 #pintar gomo 3 linhas abaixo
	sw t3, 0(t1)
	addi t1, t2, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	sw t3, 0(t1)
	######################################################################
	sw t0, 0(t2)
	j FIM_DIRECAO

#s0 começa em 1 é necessario verificar se a cobra tem só um gomo
#caso a cobra so tenha um gomo
SO_CABECA:
	lw t1, 0(sp)
	mv t2, t1
	#################################################################
	#pinta o antigo endereço de preto
	sw t3, 0(t1)
	addi t1, t2, 4 #pintar uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -960 #pintar gomo 2 linhas acima
	sw t3, 0(t1)
	addi t1, t2, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -640 #pintar gomo 2 linhas acima
	sw t3, 0(t1)
	addi t1, t2, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, -320 #pintar gomo 1 linha acima
	sw t3, 0(t1)
	addi t1, t2, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	sw t3, 0(t1)
	addi t1, t2, 320 #pintar gomo 1 linha abaixo
	sw t3, 0(t1)
	addi t1, t2, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, 640 #pintar gomo 2 linhas abaixo
	sw t3, 0(t1)
	addi t1, t2, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	sw t3, 0(t1)
	addi t1, t2, 960 #pintar gomo 3 linhas abaixo
	sw t3, 0(t1)
	addi t1, t2, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	sw t3, 0(t1)
	######################################################################
	sw t0, 0(sp) #salva o novo enderaço no inicio da pilha
	
FIM_DIRECAO:
	ret #saindo de define direcao
