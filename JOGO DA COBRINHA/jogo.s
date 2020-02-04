.data
	teto_cobra_esq: .word 	0xFF010ADC
	teto_cobra_dir: .word 	0xFF010AE4	
	chao_cobra_esq: .word 	0xFF0114DC	
	chao_cobra_dir: .word 	0xFF0114E4
	
.text
#desenha cobra
DESENHA_COBRA:
		la t1,teto_cobra_esq		#carrega a parte esquerda de cima da cobra
		lw t1,0(t1)
		la t2,teto_cobra_dir		#carrega a parte direita de cima da cobra
		lw t2,0(t2)
		la t3,chao_cobra_esq		#carrega a parte esquerda de baixo da cobra
		lw t3,0(t3)
		la t4,chao_cobra_dir		#carrega a parte direita de baixo da cobra
		lw t4,0(t4)
		li t5 0X62626262	

LOOP_DESENHA_COBRA:
		beq t1,t4, FIM_DESENHA_COBRA
		beq t1,t2, PROX_LINHA_COBRA
		sw t5, 0(t1)
		addi t1,t1,4
		j LOOP_DESENHA_COBRA
PROX_LINHA_COBRA:
		addi t1,t1,-8
		addi t1,t1,320
		addi t2,t2,320
		j LOOP_DESENHA_COBRA
		
FIM_DESENHA_COBRA:
		ret	
.include"SYSTEMv17b.s"