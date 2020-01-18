.eqv A 0x0A

.data
V:	.word 3, 0x00150010, 0x010000C0, 0x001500C0

.text
	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrw tp,utvec 		# seta utvec para o endereço tp
 	csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)

 	jal DESENHA_POLIGONO
 	j FIM
 	 	
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
	
FIM:	li a7,10
	ecall

.include "../SYSTEMv17b.s"
		
