.text
PREENCHER_BORDAS:
	mv s5, ra #salvar ra em s0
	#preencher Topo
	la t0, orig_top_esq
	la t1, orig_top_dir
	lw t0,0(t0)
	lw t1,0(t1)
	jal ra, PREENCHER_BORDAS_TOP
	#preencher Bottom
	la t0, orig_bot_esq
	la t1, orig_bot_dir
	lw t0,0(t0)
	lw t1,0(t1)
	jal ra, PREENCHER_BORDAS_BOT
	#preencher lateral esquerda
	la t0, orig_top_esq
	la t1, orig_bot_esq
	lw t0,0(t0)
	lw t1,0(t1)
	jal ra, PREENCHER_BORDAS_LEFT
	#preencher lateral direita
	la t0, orig_top_dir
	la t1, orig_bot_dir
	lw t0,0(t0)
	lw t1,0(t1)
	jal ra, PREENCHER_BORDAS_RIGHT
	mv ra, s5
	ret
	
PREENCHER_BORDAS_TOP:
	beq t0, t1, FIM
	sw t5, 0(t0)
	addi t0, t0, 4
	j PREENCHER_BORDAS_TOP
	
PREENCHER_BORDAS_BOT:
	beq t0, t1, FIM
	sw t5, 0(t0)
	addi t0, t0, 4
	j PREENCHER_BORDAS_BOT
	
PREENCHER_BORDAS_LEFT:
	beq t0, t1, FIM
	sw t5, 0(t0)
	addi t0, t0, 320
	j PREENCHER_BORDAS_LEFT
	
PREENCHER_BORDAS_RIGHT:
	beq t0, t1, FIM
	sw t5, 0(t0)
	addi t0, t0, 320
	j PREENCHER_BORDAS_RIGHT