.eqv A 0x0A
.eqv N 5

.data
V:	.word N, 0x00150010, 0x010000C0, 0x00C700B3, 0x001500C0, 0x010A0011

.text
	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrw tp,utvec 		# seta utvec para o endereço tp
 	csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)
	
	jal ORDENA
 	jal DESENHA_POLIGONO
 	j FIM

ORDENA:	la t0, V		# endereço do vetor de coordenadas
	li t2, 1		# indice
	lw s8, 0(t0)
EXTREMOS:
	slli t4, t2, 2
	add t4, t0, t4
	lw t3, 0(t4)		# le par de coordenadas
	srli s4, t3, 16		# inicia a primeira coordenada como a mais esquerda
	addi s5, s4, 0		# inicia a primeira coordenada como a mais direita
	addi t2, t2, 1
EXTREMOS_LOOP:
	bge t2, s8, SEPARA_AREAS
	slli t4, t2, 2
	addi t2, t2, 1
	add t4, t0, t4
	lw t3, 0(t4)		# le par de coordenadas
	srli t6, t3, 16		# le a coordenada x
	blt t6, s4, EXTREMO_ESQUERDA
	ble t6, s5, EXTREMOS_LOOP
	mv s5, t6
	j EXTREMOS_LOOP
EXTREMO_ESQUERDA:
	mv s4, t6
	j EXTREMOS_LOOP
SWAP:	slli t1, a1, 2
	add t1, a0, t1
	lw t0, 0(t1)
	lw t2, 4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret
SORT:	addi sp, sp, -24	# reserva espaço para 5 palavras na pilha
	sw s8, 20(sp)
	sw ra, 16(sp)
	sw s3, 12(sp)
	sw s2, 8(sp)
	sw s1, 4(sp)
	sw s0, 0(sp)
	li s8, 1		# 1
	mv s2, t0		# endereço vetor
	li s3, N		# qtd elementos
	li s0, 1		# indice
FOR1:	bge s0, s3, FIM_SORT1
	addi s1, s0, -1
FOR2:	blt s1, s8, FIM_SORT2
	slli t1, s1, 2
	add t2, s2, t1		# indexação
	lw t3, 0(t2)		# V[i]
	srli t3, t3, 16		# le a coordenada x[i]
	lw t4, 4(t2)		# V[i+1]
	srli t4, t4, 16		# le a coordenada x[i+1]
	mv a0, s4
	mv a1, s5
	lw a2, 4(t2)
	jal ACIMA_DA_LINHA
	beqz a0, S_DEC
	bge t4, t3, FIM_SORT2
S_DEC:	blt t4, t3, FIM_SORT2
	mv a0, s2
	mv a1, s1
	jal SWAP
	addi s1, s1, -1
	j FOR2
FIM_SORT2:
	addi s0, s0, 1
	j FOR1
FIM_SORT1:
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
	la s0, V		# endereco de V
	lw s1, 0(s0)		# numero de itens
	addi s0, s0, 4
	li t0, 0		# indice
SA_L1:	bge t0, s1, SA_L2
	add s2, s0, zero
	lw t1, 0(s0)
	beq t1, s4, SA_PP	# se o ponto for o extremo à esquerda
	beq t1, s5, SA_PP	# se o ponto for o extremo à direita
	mv a0, s4
	mv a1, s5
	mv a2, t1
	jal ACIMA_DA_LINHA	# retorna 1 se estiver acima da linha
	bnez a0, SA_PP
	addi sp, sp, -4
	sw t0, 0(sp)
SA_L1_LOOP:
	addi t0, t0, 1
	bge t0, s1, SA_F_L1_LOOP
	addi s2, s2, 4
	lw a2, 0(s2)
	mv a0, s4
	mv a1, s5
	jal ACIMA_DA_LINHA
	beqz a0, SA_L1_LOOP
	mv t6, t1		# Troca
	lw a2, 0(s0)
	lw t6, 0(s2)
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
	j SORT
ACIMA_DA_LINHA:			# verifica se ponto C está acima da linha AB
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
 	 	
DESENHA_POLIGONO:
	la t0, V		# endereço do vetor de coordenadas
	lw t1, 0(t0)		# quantidade de arestas
	li t2, 1		# indice vetor
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
	li a4, A		# define a cor da linha
	li a5, 0		# define frame
	li a7, 47		# desenha linha
	ecall
	addi t2, t2, 1
	j DESENHA_LINHA
FECHA:	mv a0, a2		# coordenada origem x
	mv a1, a3		# coordenada origem y
	lw t3, 4(t0)		# le primeiro par de coordenadas do vetor
	srli a2, t3, 16		# coordenada destino x
	lhu a3, 4(t0)		# coordenada destino y
	ecall
	ret			# sai do procedimento DESENHA_POLIGONO
	
FIM:	li a7, 10
	ecall

.include "../SYSTEMv17b.s"
		
