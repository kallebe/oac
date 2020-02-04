.text
MAIN_GOMOS:
	li t2, 0
	mv t3,sp
	
PINTAR_GOMOS:
	beq t2, s0 FIM_GOMOS
	lw t0,0(t3)
	mv t1, t0
	sw t5, 0(t1)
	addi t1, t0, 4 #pintar uma coluna pra direita
	sw t5, 0(t1)
	addi t1, t0, -960 #pintar gomo 2 linhas acima
	sw t5, 0(t1)
	addi t1, t0, -956 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t5, 0(t1)
	addi t1, t0, -640 #pintar gomo 2 linhas acima
	sw t5, 0(t1)
	addi t1, t0, -636 #pintar gomo 2 linhas acima e uma coluna pra direita
	sw t5, 0(t1)
	addi t1, t0, -320 #pintar gomo 1 linha acima
	sw t5, 0(t1)
	addi t1, t0, -316 #pintar gomo 1 linha acima e uma coluna pra direit
	sw t5, 0(t1)
	addi t1, t0, 320 #pintar gomo 1 linha abaixo
	sw t5, 0(t1)
	addi t1, t0, 324 #pintar gomo 1 linha abaixo e uma coluna pra direita
	sw t5, 0(t1)
	addi t1, t0, 640 #pintar gomo 2 linhas abaixo
	sw t5, 0(t1)
	addi t1, t0, 644 #pintar gomo 2 linhas abaixo e uma coluna pra direita
	sw t5, 0(t1)
	addi t1, t0, 960 #pintar gomo 3 linhas abaixo
	sw t5, 0(t1)
	addi t1, t0, 964 #pintar gomo 3 linhas abaixo e uma coluna pra direita
	sw t5, 0(t1)
	addi t2, t2, 1
	addi t3, t3, 4
	j PINTAR_GOMOS
	
FIM_GOMOS:
	ret
	
.include"error.s"
