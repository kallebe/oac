.text
MAIN:
	la tp,exceptionHandling	# carrega em tp o endere?o base das rotinas do sistema ECALL	
	li s0, 1		# contador do tamanho da cobra
	li s2, 119		# s2 Igual a tecla pressionada -- Começando como w
	li s3, 0		# Representa se a comida esta ativa --- 0 = sem comida --- 1 = com comida
	li s4, 0		# pontos
	mv s5, ra		#s5 salva ra
	
	add sp, sp, s0  #alocar espaço na pilha
	la sp, teto_cobra_esq
	li t5, 0x62626262	#definir cor da borda --- t5 representa o pixel de cor nesse jogo
	
	jal ra, PREENCHER_BORDAS
	jal ra, LOOP_JOGO
	ret  #retorno principal
	
LOOP_JOGO:
	jal GERAR_COMIDA
	jal MAIN_GOMOS
	jal VERIFICAR_TECLA
	j LOOP_JOGO			# volta ao loop	
	
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
	
### Verifica se há tecla pressionada	
VERIFICAR_TECLA:	
	li t1,0xFF200000		# carrega o endere?o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se n?o h? tecla pressionada ent?o vai para FIM
  	lw s2,4(t1)  			# le o valor da tecla tecla
  	j DEFINE_DIRECAO
  	
FIM:
	ret #retornar
	
.include"SYSTEMv17b.s"
.include "include/direcao.s"
.include "include/pintar_gomo.s"
.include "include/gerar_comida.s"
.include "include/verificar_limites.s"

.include "data/coord_principais.s"
