# Define a direçao de onde a cobra vai
.text
DEFINE_DIRECAO:
  	lw t0,4(t1)  			# le o valor da tecla tecla
	mv a1, sp 		#salvar a cauda da cobra em a1
#	mv t2, sp
#	addi t1, s0, -1	
#	slli t1, t1, 2  	#calcular offset do fim da pilha
#	add t1, t1, t2		# t0 contem a nova coordenada da cauda da cobra considerando a direçao escolhida
#	mv a1, t1 		#salvar a cauda da cobra em a1
	#################VERIFICAR DIRECAO###############################################
	li t1, 97		# ascii a
	beq t0, t1, IS_A
	li t1, 100		# ascii d
	beq t0, t1, IS_D
	li t1, 115		# ascii s
	beq t0, t1, IS_S
	li t1, 119		# ascii w
	beq t0, t1, IS_W
	j FIM_DIRECAO
	####VERIFICAR DI-RECAO###############################################
	
IS_A:
	li t2, 100
	beq s2, t2, DIREITA	
  	mv s2, t0
	j ESQUERDA
IS_D:
	li t2, 97
	beq s2, t2, ESQUERDA
  	mv s2, t0
	j DIREITA
IS_S:
	li t2, 119
	beq s2, t2, CIMA	
  	mv s2, t0
	j BAIXO
IS_W:
	li t2, 115
	beq s2, t2, BAIXO	
  	mv s2, t0
	j CIMA
	

ESQUERDA:
	lw t0, 0(a1)
	addi t0, t0, -4
	addi t3, t0, 960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	addi t3, t0, -960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	
	j VERIFICAR_COLISAO_ESQUERDA
	
DIREITA:
	lw t0, 0(a1)
	addi t0, t0, 4
	addi t3, t0, 960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	addi t3, t0, -960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	j VERIFICAR_COLISAO_DIREITA
	
CIMA:
	lw t0, 0(a1)
	addi t0, t0, -960
	addi t3, t0, 960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	addi t3, t0, -960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	j VERIFICAR_COLISAO_CIMA
	
BAIXO:
	lw t0, 0(a1)
	addi t0, t0, 960
	addi t3, t0, 960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	addi t3, t0, -960
	la t2, orig_top_dir
	lw t1, 0(t2)
	bleu t3, t1, REINICIAR_JOGO
	la t2, orig_bot_esq
	lw t1, 0(t2)
	bgeu t0, t1, REINICIAR_JOGO
	j VERIFICAR_COLISAO_BAIXO
	
	
VERIFICAR_COLISAO_ESQUERDA:
	mv t1, t0
	addi t1, t1, -4
	mv a2, t1 # salvando a proxima coordenada alem do ponto
	lw t1, 0(a2)
	beq t1, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -4	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada represen
	addi t2, a2, -316	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 324	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -956	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 964	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -636	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 644	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	j MOVER_COBRA
	
VERIFICAR_COLISAO_DIREITA:
	mv t1, t0
	addi t1, t1, 4
	mv a2, t1 # salvando a proxima coordenada alem do ponto
	lw t1, 0(a2)
	beq t1, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -4	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada represen
	addi t2, a2, -316	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 324	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -956	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 964	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -636	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 644	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	j MOVER_COBRA
	
VERIFICAR_COLISAO_CIMA:
	mv t1, t0
	addi t1, t1, -320
	mv a2, t1 # salvando a proxima coordenada alem do ponto
	lw t1, 0(a2)
	beq t1, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -4	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada represen
	addi t2, a2, -316	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 324	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -956	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 964	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -636	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 644	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	j MOVER_COBRA
	
VERIFICAR_COLISAO_BAIXO:
	mv t1, t0
	addi t1, t1, 320
	mv a2, t1 # salvando a proxima coordenada alem do ponto
	lw t1, 0(a2)
	beq t1, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -4	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada represen
	addi t2, a2, -316	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 320	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 324	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -956	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 960	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 964	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, -636	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 640	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	addi t2, a2, 644	#mover coordenada da comida pra t2	
	beq t2, t5, REINICIAR_JOGO #verifica se a coordenada gerada representa um valor de colisao
	j MOVER_COBRA
  	
REINICIAR_JOGO:
	slli t0, s0, 2
	add sp, sp, t0 # desalocar espacos na pilha
	#mv ra, zero 
	li s7, 0 #reiniciar jogo
	ret
	
MOVER_COBRA:
	#a2 contem o novo endereço de movimento e a5 a cor branca
	lw t1, 0(a2)
	beq t1, a5, COMER
	addi t2, a2, -4	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -320	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -316 #mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 320 #mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 324 #mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -960	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -956	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 960	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 964	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -640	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, -636	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 640	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	addi t2, a2, 644	#mover coordenada da comida pra t2	
	lw t1, 0(t2)
	beq t1, a5, COMER
	#################### SWAP CABEÇA-CAUDA #############################
	li t1, 1
	beq t1, s0, SO_CABECA
	li t1, 0
	mv t3, a2
	j SWAP_DIRECAO
	
SO_CABECA:
	lw t2, 0(a1)		#guardar antigo inicio da pilha  --- CABEÇA ANTIGA
	sw a2, 0(a1)
	j PINTAR_PRETO
	
SWAP_DIRECAO:
	beq t1, s0, PINTAR_PRETO 
	lw t2, 0(a1)
	sw t3, 0(a1)
	mv t3, t2
	addi t1, t1, 1
	addi a1, a1, 4		# t0 contem a nova coordenada da cauda da cobra considerando a direçao escolhida
	#t2 é usado para preencher a antiga cauda de preto
	j SWAP_DIRECAO
	
COMER:
	addi sp, sp, -4 #adicionar mais 4 espaços a pilha mais 4 para o ra
	mv a1, sp
	sw a2, 0(a1)
	addi s0, s0, 1 #incrementar a cobra
	addi s4, s4, 1 #incrementar os pontos
	li s3, 0 	#setar comida como inativa
	mv t2, s1	#mover coordenada da comida pra t2	
	#t2 é usado para preencher a antiga cauda de preto
	addi sp, sp, -4
	sw ra, 0(sp)
	jal IMPRIMIR_PONTUACAO
	lw ra, 0(sp)
	addi sp, sp, 4
	j PINTAR_PRETO

IMPRIMIR_PONTUACAO:
	addi sp, sp, -20
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	sw a4, 16(sp)
	mv a0, s4	# pontos para imprimir
	li a1, 160	# coluna para pontuação
	li a2, 228	# linha para pontuação
	li a3, 0x00FF	# cor da pontuação
	li a4, 0	# frame
	li a7, 136
	ecall
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	lw a4, 16(sp)
	addi sp, sp, 20
	ret
	
PINTAR_PRETO:
	#############################################PINTAR COMIDA################################
	#a4 = cor preta
	#  t2 recuperar coordenada pra ser pintada
	sw a4, 0(t2)
	addi t1, t2, 4 #pintar uma coluna pra direita
	sw a4, 0(t1)
	addi t1, t2, -960 #pintar gomo 2 linhas acima
	sw a4, 0(t1)
	addi t1, t2, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw a4, 0(t1)
	addi t1, t2, -640 #pintar gomo 2 linhas acima
	sw a4, 0(t1)
	addi t1, t2, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw a4, 0(t1)
	addi t1, t2, -320 #pintar gomo 1 linha acima
	sw a4, 0(t1)
	addi t1, t2, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	sw a4, 0(t1)
	addi t1, t2, 320 #pintar gomo 1 linha abaixo
	sw a4, 0(t1)
	addi t1, t2, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	sw a4, 0(t1)
	addi t1, t2, 640 #pintar gomo 2 linhas abaixo
	sw a4, 0(t1)
	addi t1, t2, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	sw a4, 0(t1)
	addi t1, t2, 960 #pintar gomo 3 linhas abaixo
	sw a4, 0(t1)
	addi t1, t2, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	sw a4, 0(t1)
	#############################################PINTAR COMIDA################################
	j FIM_DIRECAO
	
FIM_DIRECAO:
	ret #saindo de define direcao
