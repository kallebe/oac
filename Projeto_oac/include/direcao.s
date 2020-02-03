# Define a direçao de onde a cobra vai
.text
DEFINE_DIRECAO:
	li, t1, 0 #contador
	li t0, 97		# ascii a
	beq t2, t0, ESQUERDA
	li t0, 100		# ascii d
	beq t2, t0, DIREITA
	li t0, 115		# ascii s
	beq t2, t0, BAIXO
	li t0, 119		# ascii w
	beq t2, t0, CIMA
	ret
	
ESQUERDA:
	lw t2, 0(sp)
	addi t2, t2, -4
	jal MOVER_COBRA
	
DIREITA:
	lw t2, 0(sp)
	addi t2, t2, 4
	jal MOVER_COBRA
	
CIMA:
	lw t2, 0(sp)
	addi t2, t2, -320
	jal MOVER_COBRA
	
BAIXO:
	lw t2, 0(sp)
	addi t2, t2, 320
	jal MOVER_COBRA

#percorre toda a cobra atualizando as coordenadas de cada gomo	
MOVER_COBRA:
	bge t1, s0, FIM_DIRECAO #verifica o contador da pilha
	sw t2, (sp) # salva a coordenada em sp
	addi sp, sp, 4
	addi t1, t1, 4
	j MOVER_COBRA

FIM_DIRECAO:
	ret #saindo de define direcao
