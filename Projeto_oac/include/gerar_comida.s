.text
GERAR_COMIDA:	
	la t0, comida_centro1
	lw t0, 0(t0)
	sw t5, 0(t0)
	la t0, comida_centro2
	lw t0, 0(t0)
	sw t5, 0(t0)
	la t0, comida_centro3
	lw t0, 0(t0)
	sw t5, 0(t0)
	la t0, comida_centro4
	lw t0, 0(t0)
	sw t5, 0(t0)
	mv ra, s5
	ret
	