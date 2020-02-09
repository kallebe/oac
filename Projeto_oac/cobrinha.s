.data

NUM: .word 13
NOTAS: 55,300,56,300,54,300,56,300,59,300,59,300,66,300,74,300,66,300,59,600,55,300,66,300,54,59,600,59,300,56,300,74,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,89,300,66,300,74,300,66,300,59,600,85,300,66,300,54,300,56,300,59,600,59,300,66,300,54,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,59,300,66,300,74,300,66,300,59,600,55,300,56,300,54,300,56,300,59,600,59,300,66,300,54,300,56,300,59,600

.text
##############################################################################################################
##############################################################################################################
# Carrega a imagem
MENU:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,MENU5		# endereço dos dados da tela na memoria
	li s6, 10000		# modo easy como default
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,TOCAR_NOTAS		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1			# volta a verificar

##########################################################################################################
#NOTAS SÃO TOCADAS
TOCAR_NOTAS:	
	la s0,NUM		# define o endereço do número de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,NOTAS		# define o endereço das notas
	li t0,0			# zera o contador de notas
	li a2,45			# define o instrumento
	li a3,127		# define o volume

LOOP_NOTAS:	
	beq t0,s1, FIM_NOTAS	# contador chegou no final? então  vá para FIM_NOTAS
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a duração da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,8		# incrementa para o endereço da próxima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP_NOTAS		# volta ao loop
	
FIM_NOTAS:
	li a0,50		# define a nota
	li a1,1800		# define a duração da nota em ms
	li a2,16		# define o instrumento
	li a3,150		# define o volume
	li a7,33		# define o syscall
	ecall			# toca a nota			
#############################################################################################
PEGA_SELECAO_MENU:
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_SELECAO_MENU   	   	# Se n�o h� tecla pressionada ent�o vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	
	li t0,52 		#4 em ASCI
	beq  t2,t0,PREENCHE_PRETO
	li t0,49 		#1 em ASCI
	beq  t2,t0, EASY
	li t0,50		#2 em ASCI
	beq  t2,t0, MEDIUM
	li t0,51 		#3 em ASCI
	beq  t2,t0, HARD
	
FIM_SELECAO_MENU:
	j PEGA_SELECAO_MENU
	
############################################ DEFINIR NIVEL $#########################################
EASY:
	li s6, 10000
	j PEGA_SELECAO_MENU 

MEDIUM:
	li s6, 5000
	j PEGA_SELECAO_MENU 

HARD:
	li s6, 1000	
	j PEGA_SELECAO_MENU 	

############################################################################################################
# Preenche a tela de preto
PREENCHE_PRETO:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0x00000000	# cor preta
LOOP: 	beq t1,t2,MAIN		# Se for o �ltimo endere�o ent�o sai do loop
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	j LOOP			# volta a verificar
##############################################################################################################
##############################################################################################################
MAIN:
	la tp,exceptionHandling	# carrega em tp o endere?o base das rotinas do sistema ECALL	
	li s0, 1		# contador do tamanho da cobra
	li s1, 0		# s1 representa a coordenada da comida
	li s2, 0		# s2 Igual a tecla pressionada -- Come�ando como w
	li s3, 0		# Representa se a comida esta ativa --- 0 = sem comida --- 1 = com comida
	li s4, 0		# s4 representa os pontos no jogo
	#li s6, 10000		s6 define dificuldade
	li s7, 1		#marcador de reinicializa��o do jogo 1 = nao reinicia -- 0 reinicia
	mv s5, ra		#s5 salva ra
	
	## DESLOCAR s0 pra alocar espa�o na pilha
	slli t1, s0, 2
	li t0, -1
	mul t0, t1, t0
	add sp, sp, t0  #alocar espa�o na pilha
	## DESLOCAR s0 pra alocar espa�o na pilha
	la t0, teto_cobra_esq
	lw t0, 0(t0)
	sw t0, 0(sp)
	li t5, 0x62626262	#definir cor da borda e da cobra --- t5 representa o pixel de cor nesse jogo
	li a5, 0xffffffff 	#cor da comida
	li a4, 0x00000000 	#cor de fundo
	
	jal ra, PREENCHER_BORDAS
	jal ra, LOOP_JOGO
	ret  #retorno principal
		
LOOP_JOGO:
	jal GERAR_COMIDA
	jal MAIN_GOMOS
	li t3, 1
	jal VERIFICAR_TECLA
	beq s7, zero, MENU
	j LOOP_JOGO	
	
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
	
### Verifica se h� tecla pressionada	
VERIFICAR_TECLA:	
	li t1,0xFF200000		# carrega o endere?o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
 	bne t0,zero, TECLA_PRESSIONADA
	addi t3, t3, 1
	bne s6 ,t3, VERIFICAR_TECLA	
 	j FINALIZAR_DIRECAO
 	
TECLA_PRESSIONADA:
	lw t0,4(t1)
	beq t0, s2, FIM
	j FINALIZAR_DIRECAO
 	
FINALIZAR_DIRECAO:
  	j DEFINE_DIRECAO
  	j FIM
 

FIM:
	ret #retornar
	
	
.include"SYSTEMv17b.s"

.include "include/direcao.s"
.include "include/pintar_gomo.s"
.include "include/gerar_comida.s"

.include "data/coord_principais.s"
.include "data/MENU5.data"
###
