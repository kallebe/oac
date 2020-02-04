.text

ERROR:	
	la t0, orig_top_esq
	la t1, orig_bot_dir
	li t4, 0x07070707
	lw t2, 0(t0)
	lw t3, 0(t1)

LOOP_ERROR:
	bge t2, t3, FIM_ERROR
	sw t4, 0(t2)
	addi t2, t2, 4
	j LOOP_ERROR
	
FIM_ERROR:
	mv ra, zero
	ret
	