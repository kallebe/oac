# Define a direçao de onde a cobra vai
.text
DEFINE_DIRECAO:
	li, t1, 0 #contador
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
	sw t0, 0(t2) #escreve o novo endereço
	addi t2, t2, 4 #t2 representa o endereço na pilha
	lw t3, 0(t2) # salva o proximo valor da pilha
	blt t1, s0, FIM_DIRECAO #verifica o contador da pilha
	mv t0, t3
	addi t1, t1, 1
	j MOVER_COBRA

FIM_DIRECAO:
	ret #saindo de define direcao
