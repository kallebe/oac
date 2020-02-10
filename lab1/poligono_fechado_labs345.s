.eqv A 0xFF

.data
V: .word 12, 0x00E6001C, 0x00A40052, 0x00A00042, 0x007B006D, 0x00760061, 0x004C007F, 0x003200D3, 0x005C00CB, 0x0080008C, 0x008600A4, 0x00A80068, 0x00AD007D
#SPACE:	.string " "

.text
	la tp,exceptionHandling	# carrega em tp o endere?o base das rotinas do sistema ECALL
 	csrw tp, utvec 		# seta utvec para o endere?o tp
 	csrsi ustatus, 1 	# seta o bit de habilita??o de interrup??o em ustatus (reg 0)

#-------------------------------------------------- Poligono Aleatorio ------------------------------------------------------#
#	li s0, 3		# simula o numero de items na lista
#	li s3, 20		# numero m?ximo
#MAIN_LOOP:
#	bgt s0, s3, FIM
#	li t1, 0 		# s1 serve como o contador e ? iniciado em 0
#	addi t0, s0, 1
#	slli t0, t0, 2		# multiplica o numero de items por 4
#	sub sp, sp, t0		# aloca memoria para pilha
#	mv s11, sp
#	addi s1, s11, 4		# avan?a para o proximo endere?o de s1
#	jal SORTEIA
#	sw s0, 0(s11)
	#jal DESENHA_POLIGONO	# poligono n?o ordenado
#	jal ORDENA
#	li a0, 0xFF
#	li a1, 0
#	li a7, 148		# limpa a tela com branco
#	ecall
#	jal DESENHA_POLIGONO	# poligono ordenado
#	addi s0, s0, 1
#	jal DESEMPILHA_V
#	j MAIN_LOOP

#-------------------------------------------------- A partir de V ------------------------------------------------------#
	li s9, 10		# numero de iterações
	li s7, 0		# indice
	li s10, 0
LOOP_V:	bge s7, s9, FIM_V
	li s8, 0xff200700	# endereço tempo exec
	la s11, V
	lw s0, 0(s11)		# simula o numero de items na lista
	lw s6, 0(s8)
	jal ORDENA
	lw t0, 0(s8)
	sub s6, t0, s6	# t exec ORDENA
	li a0, 0xFF
	li a1, 0
	li a7, 148		# limpa a tela com branco
	ecall
	lw t0, 0(s8)
	jal DESENHA_POLIGONO	# poligono ordenado
	lw t1, 0(s8)
	sub t1, t1, t0		# t exec POLIGONO
	add s6, s6, t1	
	add s10, s10, s6	# t exec ORDENA + POLIGONO
	addi s7, s7, 1		# incrementa indice loop
	j LOOP_V
FIM_V:	j FIM

SORTEIA:
	bge t1, s0, EXIT_SORTEIA
	# Mapear coordenadas X
	li a7, 141		# Gera um valor aleatorio que ser? usado para  a coordenada X e armazena em a0
	ecall
	li t2, 320 		# Valor maximo para coordenadas X
	remu t2, a0, t2 	# recupera o resto da divis?o para certificar que o valor aleatorio gerado est? no intervalo valido para as coordenadas X
	slli t2, t2, 16		# Desloca a palavra 16 bits a esquerda
	# Mapear coordenadas Y
	li a7, 141		# Gera um valor aleatorio que ser? usado para  a coordenada Y e armazena em a0
	ecall
	li t3, 240		# Valor maximo para coordenadas Y
	remu t3, a0, t3		# recupera o resto da divis?o para certificar que o valor aleatorio gerado est? no intervalo valido para as coordenadas Y
	slli t3, t3, 16 	# Desloca a palavra 16 bits a esquerda
	srli t3, t3, 16 	# Desloca a palavra 16 bits a direita para zerar os valores a esquerda no momento de fazer o OR
	or t4, t2 t3		# junta as coordenadas na palavra
	sw t4, (s1)		# salva a coordenada em sp
	addi s1, s1, 4		# move sp para a proxima posicao na memoria
	addi t1, t1, 1		# incrementa o contador
	j SORTEIA
EXIT_SORTEIA: ret	

ORDENA:	addi sp, sp, -4
	sw s8, 0(sp)
	mv t0, s11		# endere?o do vetor de coordenadas
	li t2, 1		# indice
	lw s8, 0(t0)
EXTREMOS:
	slli t4, t2, 2
	add t4, t0, t4
	li s4, 0x01410141	# inicia a coordenada mais esquerda - GLOBAL
	li s5, 0			# inicia a coordenada mais direita  - GLOBAL
	#addi t2, t2, 1
EXTREMOS_LOOP:
	bgt t2, s8, FIM_EXTREMOS
	slli t4, t2, 2
	addi t2, t2, 1
	add t4, t0, t4
	lw t3, 0(t4)		# le par de coordenadas
	srli t6, t3, 16		# le a coordenada x
	srli t1, s4, 16
	srli t5, s5, 16
	blt t6, t1, EXTREMO_ESQUERDA
	ble t6, t5, EXTREMOS_LOOP
	mv s5, t3
	slli a0, s8, 2
	add a0, s11, a0
	lw a1, 0(a0)
	sw t3, 0(a0)
	sw a1, 0(t4)
	j EXTREMOS_LOOP
EXTREMO_ESQUERDA:
	mv s4, t3
	lw a0, 4(s11)
	sw t3, 4(s11)
	sw a0, 0(t4)
	j EXTREMOS_LOOP
FIM_EXTREMOS:
	lw s8, 0(sp)
	addi sp, sp, 4
	j SEPARA_AREAS

SWAP:	slli t1, a1, 2
	add t1, a0, t1
	lw t0, 0(t1)
	lw t2, 4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret
	
SORT_A:	addi sp, sp, -24	# reserva espa?o para 6 palavras na pilha
	sw s8, 20(sp)
	sw ra, 16(sp)
	sw s3, 12(sp)
	sw s2, 8(sp)
	sw s1, 4(sp)
	sw s0, 0(sp)
	li s0, 1#0		# indice
FOR1A:	bgt s0, s3, FIM_SORT1A
	addi s1, s0, -1
FOR2A:	blt s1, zero, FIM_SORT2A
	slli t1, s1, 2
	add t2, s2, t1		# indexa??o
	lw t3, 0(t2)		# V[i]
	srli t3, t3, 16		# le a coordenada x[i]
	lw t4, 4(t2)		# V[i+1]
	srli t4, t4, 16		# le a coordenada x[i+1]
S_ASC:	bge t4, t3, FIM_SORT2A
	j TRA
TRA:	mv a0, s2
	mv a1, s1
	jal SWAP
	addi s1, s1, -1
	j FOR2A
FIM_SORT2A:
	addi s0, s0, 1
	j FOR1A
FIM_SORT1A:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw ra, 16(sp)
	lw s8, 20(sp)
	addi sp, sp, 24		# desempilha items
	ret

SORT_D:	addi sp, sp, -24	# reserva espa?o para 5 palavras na pilha
	sw s8, 20(sp)
	sw ra, 16(sp)
	sw s3, 12(sp)
	sw s2, 8(sp)
	sw s1, 4(sp)
	sw s0, 0(sp)
	li s0, 0#1		# indice
FOR1D:	bge s0, s3, FIM_SORT1D#t
	addi s1, s0, -1
FOR2D:	blt s1, zero, FIM_SORT2D
	slli t1, s1, 2
	add t2, s2, t1		# indexa??o
	lw t3, 0(t2)		# V[i]
	srli t3, t3, 16		# le a coordenada x[i]
	lw t4, 4(t2)		# V[i+1]
	srli t4, t4, 16		# le a coordenada x[i+1]
	blt t4, t3, FIM_SORT2D
TRD:	mv a0, s2
	mv a1, s1
	jal SWAP
	addi s1, s1, -1
	j FOR2D
FIM_SORT2D:
	addi s0, s0, 1
	j FOR1D
FIM_SORT1D:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw ra, 16(sp)
	lw s8, 20(sp)
	addi sp, sp, 24		# desempilha items
	ret
	
SEPARA_AREAS:			# separa vetor de coordenadas: primeiro pontos acima da linha
	addi sp, sp, -24
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw t0, 12(sp)
	sw s2, 16(sp)
	sw t1, 20(sp)
	mv s0, s11			# endereco de V
	lw s1, 0(s0)		# numero de itens
	addi s0, s0, 4
	li t0, 1#0		# indice
SA_L1:	bge t0, s1, SA_L2
	add s2, s0, zero
	lw t1, 0(s0)
	#beq t1, s4, SA_PP	# se o ponto for o extremo ? esquerda
	#beq t1, s5, SA_PP	# se o ponto for o extremo ? direita
	mv a0, s4
	mv a1, s5
	mv a2, t1
	jal ACIMA_DA_LINHA	# retorna 1 se estiver acima da linha
	bnez a0, SA_PP
	addi sp, sp, -4
	sw t0, 0(sp)
SA_L1_LOOP:
	addi t0, t0, 1
	bge t0, s1, SA_F_L1_LOOP#t
	addi s2, s2, 4
	lw a2, 0(s2)
	mv a0, s4
	mv a1, s5
	jal ACIMA_DA_LINHA
	beqz a0, SA_L1_LOOP
	mv t6, t1		# Troca
	sw a2, 0(s0)
	sw t6, 0(s2)
SA_F_L1_LOOP:
	lw t0, 0(sp)
	addi sp, sp, 4
SA_PP:	addi s0, s0, 4
	addi t0, t0, 1
	j SA_L1
SA_L2:	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw t0, 12(sp)
	lw s2, 16(sp)
	lw t1, 20(sp)
	addi sp, sp, 24
	j LIMIAR
LIMIAR:	addi sp, sp, -16
	sw ra, 12(sp)
	sw s2, 8(sp)
	sw s3, 4(sp)
	sw s9, 0(sp)
	mv s2, s11
	lw s9, 0(s2)		# N de elementos
	addi s2, s2, 4		# 1o endereco
	li t6, 1#0
LM_L1:	bgt t6, s9, LM_F#e
	slli t5, t6, 2
	addi t6, t6, 1		# i++
	add t5, t5, s2
	mv a0, s4
	mv a1, s5
	lw a2, 0(t5)
	jal ACIMA_DA_LINHA
	bnez a0, LM_L1
	addi s3, t6, -2		# indice ultimo elemento acima da linha
LM_F:	jal SORT_A
	addi s3, s3, 1
	slli s3, s3, 2
	add s2, s2, s3
	addi t6, t6, -1#
	sub s3, s9, t6
	jal SORT_D
	lw ra, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s9, 0(sp)
	addi sp, sp, 16
	ret
	
ACIMA_DA_LINHA:			# verifica se ponto C est? acima da linha AB
	addi sp, sp, -24
	sw t0, 20(sp)
	sw t1, 16(sp)
	sw t2, 12(sp)
	sw t3, 8(sp)
	sw t4, 4(sp)
	sw t5, 0(sp)
	srli t0, a0, 16		# coordenada x do ponto A
	slli t1, a0, 16
	srli t1, t1, 16		# coordenada y do ponto A
	srli t2, a1, 16		# coordenada x do ponto B
	slli t3, a1, 16
	srli t3, t3, 16		# coordenada y do ponto B
	srli t4, a2, 16		# coordenada x do ponto C
	slli t5, a2, 16
	srli t5, t5, 16		# coordenada y do ponto C
	sub t2, t2, t0		# bx - ax
	sub t5, t5, t1		# cy - ay
	mul t2, t2, t5		# (bx - ax)*(cy - ay)
	sub t3, t3, t1		# by - ay
	sub t4, t4, t0		# cx - ax
	mul t3, t3, t4		# (by- ay)*(cx - ax)
	sgt a0, t2, t3
	lw t5, 0(sp)
	lw t4, 4(sp)
	lw t3, 8(sp)
	lw t2, 12(sp)
	lw t1, 16(sp)
	lw t0, 20(sp)
	addi sp, sp, 24		# desempilha
	ret

SORTEIA_COR:
	addi sp, sp, -4
	sw t2, 0(sp)
	li a7, 141		# Gera um valor aleatorio que ser? usado para a cor da linha
	ecall
	li t2, 0xfe 		# Valor maximo para a cor
	remu a0, a0, t2 	# recupera o resto da divis?o para certificar que o valor aleatorio gerado est? no intervalo valido
	lw t2, 0(sp)
	addi sp, sp, 4
	ret
 	 	
DESENHA_POLIGONO:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw t0, 4(sp)
	mv t0, s11		# endere?o do vetor de coordenadas
	lw t1, 0(t0)		# quantidade de arestas
	li t2, 1		# indice vetor
#-------------------------------------------------- Poligono Aleatorio ------------------------------------------------------#
#	jal SORTEIA_COR		# sorteia cor da linha
#	mv a4, a0
#----------------------------------------------------- A Partir de V --------------------------------------------------------#
	li a4, 0x07
DESENHA_LINHA:
	bge t2, t1, FECHA	# verifica se todo o vetor foi percorrido
	slli t4, t2, 2		# incrementa indice
	add t4, t0, t4
	lw t3, 0(t4)		# le par de coordenadas de origem
	srli a0, t3, 16		# le a coordenada x
	lhu a1, 0(t4)		# le a coordenada y
	lw t3, 4(t4)		# le par de coordenadas de destino
	srli a2, t3, 16		# le a coordenada x
	lhu a3, 4(t4)		# le a coordenada y
	li a5, 0		# define frame
	li a7, 147		# desenha linha
	ecall
	addi t2, t2, 1
	j DESENHA_LINHA
FECHA:	mv a0, a2		# coordenada origem x
	mv a1, a3		# coordenada origem y
	lw t3, 4(t0)		# le primeiro par de coordenadas do vetor
	srli a2, t3, 16		# coordenada destino x
	lhu a3, 4(t0)		# coordenada destino y
	ecall
	lw ra, 0(sp)
	lw t0, 4(sp)
	addi sp, sp, 8
	ret			# sai do procedimento DESENHA_POLIGONO

DESEMPILHA_V:
	lw t0, 0(s11)
	addi t0, t0, 1
	slli t0, t0, 2
	add sp, sp, t0		# desempilha array
	ret

FIM:	li a7, 10
	ecall

.include "SYSTEMv17b.s"
