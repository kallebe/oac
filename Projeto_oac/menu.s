.data

.include "MENU5.data"

NUM: .word 13
NOTAS: 55,300,56,300,54,300,56,300,59,300,59,300,66,300,74,300,66,300,59,600,55,300,66,300,54,59,600,59,300,56,300,74,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,89,300,66,300,74,300,66,300,59,600,85,300,66,300,54,300,56,300,59,600,59,300,66,300,54,300,66,300,59,600,55,300,66,300,54,300,56,300,59,600,59,300,66,300,74,300,66,300,59,600,55,300,56,300,54,300,56,300,59,600,59,300,66,300,54,300,56,300,59,600


.text
# Carrega a imagem
MENU:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,MENU5		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1			# volta a verificar

############################################################################################################################
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
								
FIM:	
	j TOCAR_NOTAS
	li a7,10		
	ecall
