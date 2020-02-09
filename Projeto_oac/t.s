.text
	li s0, 3
	addi sp, sp, -12  #alocar espaï¿½o na pilha
	## DESLOCAR s0 pra alocar espaï¿½o na pilha
	la t0, teste2
	lw t0, 0(t0)
	sw t0, 0(sp)
	
	la t0, teste
	lw t0, 0(t0)
	sw t0, 4(sp)
	
	la t0, teto_cobra_esq
	lw t0, 0(t0)
	sw t0, 8(sp)
	addi sp, sp, -12  #alocar espaï¿½o na pilha
	## DESLOCAR s0 pra alocar espaï¿½o na pilha
	la t0, teste2
	lw t0, 0(t0)
	sw t0, 0(sp)
	
	la t0, teste
	lw t0, 0(t0)
	sw t0, 4(sp)
	
	la t0, teto_cobra_esq
	lw t0, 0(t0)
	sw t0, 8(sp)
	
	addi t1, s0, -1	
	slli t1, t1, 2  	#calcular offset do fim da pilha
	add t1, t1, sp		# t0 contem a nova coordenada da cauda da cobra considerando a direçao escolhida	
	ret
	
	
	
.include "data/coord_principais.s"