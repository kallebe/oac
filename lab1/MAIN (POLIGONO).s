.text

	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrw tp,utvec 		# seta utvec para o endereço tp
 	csrsi ustatus,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)

	li a0,4			#seta um valor n de pontos
	mv s3,a0		#s3=n
	mv t0,s3		#t0=n
	
#------------------------------------------>GERACAO DOS PONTOS ALEATORIOS QUE SERAO UTILIZADOS<------------------------------------------
	
REC:	beq t0,zero, FIMaleatorio    #se o t0==0 vai pra FIMale (final da geracao de aleatorios)
	
	li a1,319		#limite x aleatorio
	li a7,42		#calcula um numero aleatorio pro x
	ecall
	mv t1, a0		
	add s4,s4,t1		#s3=soma dos xs , pra calcular o ponto medio posteriormente
	
	li a1,239		#limite y aleatorio
	li a7, 42		#calcula um numero aleatorio pro y
	ecall
	mv t2, a0
	add s5,s5,t2		#s4=soma dos ys , pra calcular o ponto medio posteriormente

	addi sp,sp,-8		#reserva espaço na pilha
	sw t1,0(sp)    		#armanzena x
	sw t2,4(sp)		#armazena y
	
	addi t0,t0,-1		#n--
	j REC
		
#------------------------------------------>DESENHANDO AS LINHAS DO POLIGONO<------------------------------------------

FIMaleatorio: mv t0,s3		#t0=n novamente
	addi t0,t0,-1		#n--
	
ORDENA:	mv s11,sp		#salva valor inicial da pilha pra esvazia-la depois
	mv s2,sp		#salva outro ponteiro pra pilha para percorrer-la livremente
	
DESENHA:beq t0,zero,ULTIMO	#enquanto t0!=0 desenha linha
	
 	lw a0,0(s2) 		#desenha uma linha
	lw a1,4(s2)
	lw a2,8(s2)
	lw a3,12(s2)
	li a5,0
	li a4,0x38
	
	li a7,47
	ecall
	
	addi s2,s2,8		#leva o s2 para o proximo ponto, para desenhar proxima linha
	addi t0,t0,-1		#n--
	j DESENHA
	
ULTIMO:	lw a0,0(s2) 		#desenha a ultima linha entre o ultimo ponto e o primeiro
	lw a1,4(s2)
	lw a2,0(sp)
	lw a3,4(sp)
	li a5,0
	li a4,0x38
	
	li a7,47
	ecall	
			
FIM:	li a7,10		#EXIT
	ecall
	
.include "SYSTEMv17b.s"	
	

