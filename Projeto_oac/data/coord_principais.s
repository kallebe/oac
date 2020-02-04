.data
	# cor_vermelha   0x07070707
	# cor_verde      0x62626262
	
	orig_top_esq: .word 0xFF000140 #representa o topo a esquerda
	orig_top_dir: .word 0XFF00063C#representa o topo a direita
	orig_bot_esq: .word 0xFF0125C0 #representa o topo a esquerda
	orig_bot_dir: .word 0xFF012BFC #representa o topo a direita
	
	teto_cobra_esq: .word 	0xFF00B99C
	teto_cobra_dir: .word 	0xFF010AE4	
	chao_cobra_esq: .word 	0xFF0114DC	
	chao_cobra_dir: .word 	0xFF0114E4
	
	comida_centro1: .word 	0xFF00B99C
	comida_centro2: .word 	0xff010ae0
	comida_centro3: .word 	0xff010c20
	comida_centro4: .word 	0xff010c1c
	teste: .word 0xFF012ABC