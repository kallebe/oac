
.text
GERAR_COMIDA:	
	bne s3, zero, FIM_COMIDA
	la t0, INICIAL
	lw t1, 0(t0) #endere?o inicial
	li s9, 10 #s9 
	
SORTEAR_COORDENADA:
	li s9, 10 #s9 
	li a7, 41 #Gera um valor aleatorio que ser? usado para  a coordenada X e armazena em a0
	ecall
	li t2, 17200 #Valor maximo para coordenadas X
	remu t2, a0, t2 #recupera o resto da divis?o para certificar que o valor aleatorio gerado est? no intervalo valido para as coordenadas X
	slli t2, t2, 4
	add t4, t1, t2
	j VERIFICAR_COORDENADA

INCREMENTA_COORD:
	li t3, 1400
	add t4, t4, t3
	j VERIFICAR_COORDENADA

DECREMENTA_COORD:
	li t3, -68800
	add t4, t4, t3
	j VERIFICAR_COORDENADA
	
VERIFICAR_COORDENADA:
################# VERIFICAR SE O NUMERO GERADO ? VALIDO
	addi s9, s9, -1
	li t3, 4
	remu t3, t4, t3
	bne t3, zero, SORTEAR_COORDENADA #verifica se o endere?o gerado ? divisivel por 4
	la t3, orig_top_dir
	lw t2, 0(t3)
	addi t2, t2, 960
	bleu t4, t2, INCREMENTA_COORD
	la t3, orig_bot_esq
	lw t2, 0(t3)
	addi t2, t2, -960
	bgeu t4, t2, DECREMENTA_COORD
	lw t2, 0(t4)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 4 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -960 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -964 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -640 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -636 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -320 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, -316 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 320 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 324 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 640 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 644 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 960 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da cobra
	addi t1, t4, 964 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto ? uma borda ou parte do corpo da 
	############################################
	sw t4, 0(t0)
	mv t2, t4
	mv s1, t2 #salva a coordenada principal da comida no registrador
	j PINTAR_COMIDA
	
PINTAR_COMIDA:
	li t4, 0xffffffff
	sw t4, 0(t2)
	#addi t1, t2, 4 #pintar uma coluna pra direita
	#sw t4, 0(t1)
	#addi t1, t2, -960 #pintar gomo 2 linhas acima
	#sw t4, 0(t1)
	#addi t1, t2, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	#sw t4, 0(t1)
	#addi t1, t2, -640 #pintar gomo 2 linhas acima
	#sw t4, 0(t1)
	#addi t1, t2, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	#sw t4, 0(t1)
	addi t1, t2, -320 #pintar gomo 1 linha acima
	sw t4, 0(t1)
	#addi t1, t2, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	#sw t4, 0(t1)
	addi t1, t2, 320 #pintar gomo 1 linha abaixo
	sw t4, 0(t1)
	#addi t1, t2, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	#sw t4, 0(t1)
	#addi t1, t2, 640 #pintar gomo 2 linhas abaixo
	#sw t4, 0(t1)
	#addi t1, t2, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	#sw t4, 0(t1)
	li s3, 1 #seta a comida como ativa
	
FIM_COMIDA:
	ret
