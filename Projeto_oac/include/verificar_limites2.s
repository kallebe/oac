.text
VERIFICAR_LIMITES:
	addi t1, t0, 4 #pintar uma coluna pra direita
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -960 #pintar gomo 2 linhas acima
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -640 #pintar gomo 2 linhas acima
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -320 #pintar gomo 1 linha acima
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, -316 #pintar gomo 1 linha acima e uma coluna pra direita
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, 320 #pintar gomo 1 linha abaixo
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, 640 #pintar gomo 2 linhas abaixo
	lw t4, 0(t1)
  	beq t4, t5, ERROR
	addi t1, t0, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	lw t4, 0(t1) 
	beq t4, t5, ERROR
	addi t1, t0, 960 #pintar gomo 3 linhas abaixo
	lw t4, 0(t1) 
	beq t4, t5, ERROR
	addi t1, t0, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	lw t4, 0(t1) 
	beq t4, t5, ERROR