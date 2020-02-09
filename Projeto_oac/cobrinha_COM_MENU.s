.data

NUM: .word 13
NOTAS: 55,300,56,300,54,300,56,300,59,300,59,300,66,300,74,300,66,300,59,600,55,300,66,300,54,59,600,59,300,56,300,74,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,89,300,66,300,74,300,66,300,59,600,85,300,66,300,54,300,56,300,59,600,59,300,66,300,54,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,59,300,66,300,74,300,66,300,59,600,55,300,56,300,54,300,56,300,59,600,59,300,66,300,54,300,56,300,59,600

.text
##############################################################################################################
##############################################################################################################
# Carrega a imagem
MENU:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,MENU5		# endere√ßo dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa√ß√µes de nlin ncol
LOOP1: 	beq t1,t2,TOCAR_NOTAS		# Se for o √∫ltimo endere√ßo ent√£o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem√≥ria VGA
	addi t1,t1,4		# soma 4 ao endere√ßo
	addi s1,s1,4
	j LOOP1			# volta a verificar

##########################################################################################################
#NOTAS S√ÉO TOCADAS
TOCAR_NOTAS:	
	la s0,NUM		# define o endere√ßo do n√∫mero de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,NOTAS		# define o endere√ßo das notas
	li t0,0			# zera o contador de notas
	li a2,45			# define o instrumento
	li a3,127		# define o volume

LOOP_NOTAS:	
	beq t0,s1, FIM_NOTAS	# contador chegou no final? ent√£o  v√° para FIM_NOTAS
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura√ß√£o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,8		# incrementa para o endere√ßo da pr√≥xima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP_NOTAS		# volta ao loop
	
FIM_NOTAS:
	li a0,50		# define a nota
	li a1,1800		# define a dura√ß√£o da nota em ms
	li a2,16		# define o instrumento
	li a3,150		# define o volume
	li a7,33		# define o syscall
	ecall			# toca a nota			
#############################################################################################
 PEGA_SELECAO_MENU:
	li t1,0xFF200000		# carrega o endereÁo de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_SELECAO_MENU   	   	# Se n„o h· tecla pressionada ent„o vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	
	li t0,52
	beq  t2,t0,PREENCHE_PRETO
FIM_SELECAO_MENU:
	j PEGA_SELECAO_MENU 
############################################################################################################
# Preenche a tela de preto
PREENCHE_PRETO:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0x00000000	# cor preta
LOOP: 	beq t1,t2,MAIN		# Se for o ˙ltimo endereÁo ent„o sai do loop
	sw t3,0(t1)		# escreve a word na memÛria VGA
	addi t1,t1,4		# soma 4 ao endereÁo
	j LOOP			# volta a verificar
##############################################################################################################
##############################################################################################################
MAIN:
	la tp,exceptionHandling	# carrega em tp o endere?o base das rotinas do sistema ECALL	
	li s0, 1		# contador do tamanho da cobra
	li s2, 119		# s2 Igual a tecla pressionada -- ComeÁando como w
	li s3, 0		# Representa se a comida esta ativa --- 0 = sem comida --- 1 = com comida
	li s4, 0		# pontos
	mv s5, ra		#s5 salva ra
	
	add sp, sp, s0  #alocar espaÁo na pilha
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
	
### Verifica se h· tecla pressionada	
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
###
###
.include "data/MENU5.data"
###
###