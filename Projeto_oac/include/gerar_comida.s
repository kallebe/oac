.text
GERAR_COMIDA:	
	bne s3, zero, FIM_COMIDA
	la t0, orig_top_esq
	lw t1, 0(t0) #endereço inicial
	
SORTEAR_COORDENADA:
	#Mapear coordenadas X
	li a7, 41 #Gera um valor aleatorio que será usado para  a coordenada X e armazena em a0
	ecall
	li t2, 320 #Valor maximo para coordenadas X
	remu t2, a0, t2 #recupera o resto da divisão para certificar que o valor aleatorio gerado está no intervalo valido para as coordenadas X
	#Mapear coordenadas Y
	li a7, 41 #Gera um valor aleatorio que será usado para  a coordenada Y e armazena em a0
	ecall
	li t3, 240 #Valor maximo para coordenadas Y
	remu t3, a0, t3 #recupera o resto da divisão para certificar que o valor aleatorio gerado está no intervalo valido para as coordenadas Y
	mul t4, t2 t3 # Multiplica os valores gerados
	add t4, t1, t4
	################## VERIFICAR SE O NUMERO GERADO É VALIDO
	la t3, orig_top_dir
	lw t2, 0(t3)
	addi t2, t2, 320
	bleu t4, t2, SORTEAR_COORDENADA
	la t3, orig_bot_esq
	lw t2, 0(t3)
	addi t2, t2, -320
	bgeu t4, t2, SORTEAR_COORDENADA 
	li t3, 4
	remu t3, t4, t3
	bne t3, zero, SORTEAR_COORDENADA #verifica se o endereço gerado é divisivel por 4
	lw t2, 0(t4)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 4 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -960 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -964 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -640 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -636 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -320 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -316 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 320 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 324 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 640 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 644 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 960 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, 964 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da 
	addi t1, t4, 1280 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
	addi t1, t4, -1280 #pintar uma coluna pra direita
	lw t2, 0(t1)
	beq t5, t2, SORTEAR_COORDENADA #verifica se o ponto é uma borda ou parte do corpo da cobra
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
