.text
GERAR_COMIDA:	
	bne s3, zero, FIM_COMIDA
	la t0, orig_top_esq
	lw t1, 0(t0) #endereço inicial
	li s3, 1
	
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
	bleu t4, t2, SORTEAR_COORDENADA
	la t3, orig_bot_esq
	lw t2, 0(t3)
	bgeu t4, t2, SORTEAR_COORDENADA
	li t3, 4
	remu t3, t4, t3
	bne t3, zero, SORTEAR_COORDENADA
	############################################
	sw t4, 0(t0)
	
PINTAR_COMIDA:
	li t4, 0xffffffff
	lw t2, 0(t0)
	sw t4, 0(t2)
	addi t1, t2, 4 #pintar uma coluna pra direita
	sw t4, 0(t1)
	addi t1, t2, -960 #pintar gomo 2 linhas acima
	sw t4, 0(t1)
	addi t1, t2, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t4, 0(t1)
	addi t1, t2, -640 #pintar gomo 2 linhas acima
	sw t4, 0(t1)
	addi t1, t2, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t4, 0(t1)
	addi t1, t2, -320 #pintar gomo 1 linha acima
	sw t4, 0(t1)
	addi t1, t2, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	sw t4, 0(t1)
	addi t1, t2, 320 #pintar gomo 1 linha abaixo
	sw t4, 0(t1)
	addi t1, t2, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	sw t4, 0(t1)
	addi t1, t2, 640 #pintar gomo 2 linhas abaixo
	sw t4, 0(t1)
	addi t1, t2, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	sw t4, 0(t1)
	addi t1, t2, 960 #pintar gomo 3 linhas abaixo
	sw t4, 0(t1)
	addi t1, t2, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	sw t4, 0(t1)
	
FIM_COMIDA:
	ret