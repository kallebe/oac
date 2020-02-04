.text
VERIFICAR_LIMITES:
	lw t4, 0(t1)
  	beq t4, t5, ERROR
  	ret
