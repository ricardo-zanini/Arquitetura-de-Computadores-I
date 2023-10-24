
;;==============================================
;;================ Declarações =================
;;==============================================
.model small
.stack 1000h

;;==============================================
;;==================== Data ====================
;;==============================================
.data
		;; --------- Minúsculas ---------
		LETRA_f					equ 102					;; Letra f
		LETRA_o					equ 111					;; Letra o
		LETRA_n					equ 110					;; Letra n
		LETRA_a					equ 97					;; Letra a
		LETRA_t					equ 116					;; Letra t
		LETRA_c					equ 99					;; Letra c
		LETRA_g					equ 103					;; Letra g

		;; --------- Maiúsculas ---------
		LETRA_A_M				equ 65					;; Letra A
		LETRA_T_M				equ 84					;; Letra T
		LETRA_C_M				equ 67					;; Letra C
		LETRA_G_M				equ 71					;; Letra G

		;; --------- Caracteres e Valores ---------
		CARACTER_TRACO			equ 45					;; Caractér "-"
		CARACTER_MAIS			equ 43					;; Caractér "+"
		CARACTER_ESPACO			equ 32					;; Caractér espaço
		CR						equ		13				;; Carriage Return
		LF						equ		10				;; Line Feed
		VALOR_DEZ				db 10					;; 10

		;; --------- Strings de Erro ---------
		STRING_ERRO				db "ERRO: (00"
		STRING_ERRO_MSG			db 100 dup (0) 			;; String de Informação de erro

		;; --------- String da Linha de Comando ---------
		STRING_DIGITADA_INI 	db 150 dup (0)			;; Guarda Início da String digitada
		STRING_AUXILIAR			db 500 dup (0)			;; Auxiliar para Strings
		STRING_AUXILIAR_2		db 500 dup (0)
		STRING_AUXILIAR_TAM		dw 0

		sw_n	dw	0
		sw_f	db	0
		sw_m	dw	0

		;; --------- Variáveis editadas pelas opções ---------
		VAR_NOME_ARQUIVO_IN 	db 50 dup (0)			;; Guarda o Nome do arquivo de entrada
		VAR_NOME_ARQUIVO_OUT 	db "a.out",45 dup (0)	;; Guarda o Nome do arquivo de saída
		VAR_TAMANHO_GRUPOS		dw 0					;; Guarda o tamaho dos grupos a serem analisados no arquivo

		VAR_A_ATIVO				db 0					;; Guarda informação se deve ser armazenado os dados de A
		VAR_T_ATIVO				db 0					;; Guarda informação se deve ser armazenado os dados de T
		VAR_C_ATIVO				db 0					;; Guarda informação se deve ser armazenado os dados de C
		VAR_G_ATIVO				db 0					;; Guarda informação se deve ser armazenado os dados de G
		VAR_MAIS_ATIVO			db 0					;; Guarda informação se deve ser armazenado os dados de “A+T” e “C+G”

		VAR_OPCAO_ATCG_ATIVA	db 0					;; Apenas informa se existe algum valor guardado para ATCG

		
		;; --------- Classificações de Erros ---------
		ERRO_01					db 1					;; Arquivo de entrada não existe
		ERRO_02					db 2					;; Quantidade de letras no arquivo de entrada é muito pequeno para ser processado
		ERRO_03					db 3					;; Opções informadas na linha de comando não são suficientes para processar os dados do arquivo
		ERRO_04					db 4					;; Alguma opção existente na linha de comando é inválida
		ERRO_05					db 5					;; Alguma opção existente na linha de comando contém parâmetros inválidos
		ERRO_06					db 6					;; Arquivo muito grande
		ERRO_07					db 7					;; Foi encontrado no arquivo de entrada uma letra inválida

		ERRO_ESP_01				db 8					;; Não foi digitado um TRAÇO quando deveria haver um
		ERRO_ESP_02				db 9					;; Não foi digitado um ESPAÇO quando deveria haver um
		ERRO_ESP_03				db 10					;; Erro na leitura do arquivo
		
		MSG_ERRO_01				db 'O Arquivo de Entrada nao existe',LF,'- O nome de arquivo fornecido foi:',0
		MSG_ERRO_02				db 'Numero de letras insuficientes no arquivo de entrada',LF,'- O numero minimo de letras eh de: ',0,0

		MSG_ERRO_03				db 'As opcoes informadas nao sao suficientes. As opcoes que faltam sao:',0
		MSG_ERRO_03_f			db '- "f" para nome do arquivo de entrada',LF,0
		MSG_ERRO_03_o			db '- "o" para nome do arquivo de saída',LF,0
		MSG_ERRO_03_n			db '- "n" ou o parametro eh igual a zero',LF,0
		MSG_ERRO_03_atcg		db '- "atcg+" para quais dados devem ser armazenados no arquivo de saida',LF,0

		MSG_ERRO_04				db 'Opcao na linha de comando invalida',LF,'- A opcao invalida eh: ',0,0
		MSG_ERRO_05				db 'Parametro de opcao na linha de comando eh invalido',LF,'- A opcao eh: n ',LF,'- O parametro eh: ',0,0
		MSG_ERRO_06				db 'O arquivo possui mais de 10000 bases nitrogenadas',0
		
		MSG_ERRO_07				db 'Foi encontrado um caractere invalido dentro do arquivo',LF,0
		MSG_ERRO_07_linha		db '- O erro foi encontrado na linha: ',0
		MSG_ERRO_07_letra		db '- O caractere incorreto eh: ',0,0

		MSG_ERRO_ESP_01			db 'Nao foi encontrado um caractere "-" no local esperado',LF,'- O caractere encontrado foi: ',0,0
		MSG_ERRO_ESP_02			db 'Nao foi encontrado um caractere ESPACO no local esperado',LF,'- O caractere encontrado foi: ',0,0
		MSG_ERRO_ESP_03 		db 'Ocorreu um erro na leitura do arquivo',0

		MSG_SUCESSO             db 'SUCESSO: O Arquivo foi processado com sucesso!',LF,LF,'----------======== Informacoes das Opcoes ========----------',0
		MSG_SUCESSO_ARQ_IN      db '- O arquivo de entrada eh: ', 0
		MSG_SUCESSO_ARQ_OUT     db '- O arquivo de saida eh: ', 0
		MSG_SUCESSO_TAM_GP      db '- O tamanho dos grupos analisados eh de: ', 0
		MSG_SUCESSO_BASES       db '- As bases analisadas foram: ', 0
		MSG_SUCESSO_P2          db '----------======== Informacoes do Arquivo de Entrada ========----------',0
		MSG_SUCESSO_N_BASES     db '- O numero de bases encontradas foi de: ',0
		MSG_SUCESSO_N_GRUPOS    db '- O numero de grupos analisados foi de: ',0
		MSG_SUCESSO_N_LINHAS    db '- O numero de linhas que contem bases nitrogenadas eh de: ',0



		CARACTERE_ERRADO		db 0

		;; --------- Variáveis de Arquivos ---------
		ARQ_CAB_A						db 'A;',0
		ARQ_CAB_T						db 'T;',0
		ARQ_CAB_C						db 'C;',0
		ARQ_CAB_G						db 'G;',0
		ARQ_CAB_MAIS					db 'A+T;C+G;',0

		ARQ_TAMANHO						dw 0
		ARQ_CONTADOR_LINHAS				dw 0
		ARQ_CONTADOR_LINHAS_COM_BASES	dw 0
		
		ARQ_CONTADOR_BASES				dw 0
		ARQ_CONTADOR_BASES_LOOP			dw 0

		ARQ_CONTADOR_GRUPOS				dw 0
		ARQ_CONTADOR_CR_LF				dw 0

		ARQ_CONTADOR_A					dw 0
		ARQ_CONTADOR_T					dw 0
		ARQ_CONTADOR_C					dw 0
		ARQ_CONTADOR_G					dw 0

		ARQ_HANDLE						dw 0
		ARQ_BUFFER						db 11000 dup (0)

;;==============================================
;;==================== Code ====================
;;==============================================
.code

;;==============================================
;;================== Startup ===================
;;==============================================
.startup

	;; --------- Pega Input do Usuário ---------
	copia_string_input:
		PUSH ds 											;; salva as informações de segmentos
		PUSH es

		MOV ax,ds 											;; troca DS <-> ES, para poder usa o MOVSB
		MOV bx,es
		MOV ds,bx
		MOV es,ax

		MOV si,80h 											;; obtém o tamanho do string e coloca em CX
		MOV ch,0
		MOV cl,[si]

		MOV si,81h 											;; inicializa o ponteiro de origem
		LEA di, STRING_DIGITADA_INI 						;; inicializa o ponteiro de destino

		REP movsb

		POP es 												;; retorna as informações dos registradores de segmentos
		POP ds

		LEA bx, STRING_DIGITADA_INI							;; BX recebe o endereco de início da String		

	inicio_processamento:
		MOV dl, [bx]
		CMP dl, CARACTER_ESPACO
		JNE inicio_processamento_p2
		INC bx
		JMP inicio_processamento							;; Pula espaços entre 2 comandos

	inicio_processamento_p2:
		MOV dl, [bx]
		CMP dl, 0
		JE inicio_analise_de_dados
		CMP dl, CARACTER_TRACO								;; Verifica se o valor no endereco de BX é um traço
		JE loop_processamento								;; Se for um traço faz a verificacao das letras

		MOV al, ERRO_ESP_01									;; Se não for um traço, há um erro na linha de comando
		CALL	ERRO										;; Pula para o Erro

	loop_processamento:
		INC BX
		MOV dl, [bx]

	verificacao_letra_f:
		CMP dl, LETRA_f										;; Testa se o parâmetro é F
		JNE verificacao_letra_o
		CALL CASO_LETRA_f
		JMP inicio_processamento

	verificacao_letra_o:
		CMP dl, LETRA_o										;; Testa se o parâmetro é O
		JNE verificacao_letra_n
		CALL CASO_LETRA_o
		JMP inicio_processamento

	verificacao_letra_n:
		CMP dl, LETRA_n										;; Testa se o parâmetro é N
		JNE verificacao_letra_actg_a
		CALL CASO_LETRA_n
		JMP inicio_processamento


	verificacao_letra_actg_a:
		CMP dl, LETRA_a										;; Testa se o parâmetro é ATCG+
		JNE verificacao_letra_actg_t
		CALL CASO_ATCG
		JMP inicio_processamento

	verificacao_letra_actg_t:
		CMP dl, LETRA_t
		JNE verificacao_letra_actg_c
		CALL CASO_ATCG
		JMP inicio_processamento

	verificacao_letra_actg_c:
		CMP dl, LETRA_c
		JNE verificacao_letra_actg_g
		CALL CASO_ATCG
		JMP inicio_processamento

	verificacao_letra_actg_g:
		CMP dl, LETRA_g
		JNE verificacao_letra_actg_mais
		CALL CASO_ATCG
		JMP inicio_processamento

	verificacao_letra_actg_mais:
		CMP dl, CARACTER_MAIS
		JNE letra_erro
		CALL CASO_ATCG
		JMP inicio_processamento

	letra_erro:
		MOV al, ERRO_04										;; Se não for nenhuma das opcões possíveis ocorreu erro
		CALL	ERRO
	
	inicio_analise_de_dados:

		CMP VAR_OPCAO_ATCG_ATIVA, 1							;; Algum parametro de ATCG foi declarado?
		JE verifica_f
		MOV al, ERRO_03
		CALL	ERRO

		verifica_f:
		CMP VAR_NOME_ARQUIVO_IN, 0							;; Arquivo de entrada foi declarado?
		JNE verifica_o
		MOV al, ERRO_03
		CALL	ERRO

		verifica_o:
		CMP VAR_NOME_ARQUIVO_OUT, 0							;; Arquivo de saída está declarado?
		JNE verifica_n
		MOV al, ERRO_03
		CALL	ERRO

		verifica_n:											;; O tamanho dos grupos n é maior que 0?
		CMP VAR_TAMANHO_GRUPOS, 0
		JNE fim_verificacao_funcoes
		MOV al, ERRO_03
		CALL	ERRO

		;; ------------------- Abertura do Arquivo -------------------
		fim_verificacao_funcoes:							;; Fim dos casos de verificação
		MOV ah, 3Dh
		MOV al, 0
		LEA dx, VAR_NOME_ARQUIVO_IN							;; Faz a abertura do arquivo de Entrada
		INT 21H
		JNC sem_erro_abertura_arquivo

		MOV al, ERRO_01										;; Arquivo de entrada não existe
		CALL	ERRO

		;; ------------------- Loop de leitura do arquivo, salvando na memória (PARA VALIDAÇÃO) -------------------
		
		sem_erro_abertura_arquivo:

		MOV ARQ_HANDLE, ax									;; Move o handle do arquivo gerado para a variacel que conterá o handle

		MOV bx, ax 											;; BX recebe o handle do arquivo salvo pela abertura do arquivo
		MOV cx, 11000
		LEA dx, ARQ_BUFFER
		MOV ah, 3Fh
		INT 21H
		JNC sem_erro_na_leitura
		MOV al, ERRO_ESP_03									;; Erro na leitra do arquivo
		CALL	ERRO

		sem_erro_na_leitura:

		CMP ax, 11000										;; Verifica se o arquivo possui 11000 caracteres
		JL sem_erro_tamanho_arquivo
		MOV al, ERRO_07									
		CALL	ERRO

		sem_erro_tamanho_arquivo:

		MOV ARQ_TAMANHO, ax
		LEA bx, ARQ_BUFFER									;; Movo o ponteiro para bx
		MOV cl, [bx]										;; Movo o valor para cl

		inicio_loop_verificacao:
		
		CMP cl, 0
		JE fim_verificacao_caracteres_arquivo

		caso_CR:
		CMP cl, CR
		JNE caso_LF
		JMP caso_CR_ou_LF

		caso_LF:
		CMP cl, LF
		JNE caso_A

		caso_CR_ou_LF:
		INC ARQ_CONTADOR_LINHAS
		;------------------------
		verifica_se_comecou_com_CR:
		LEA ax, ARQ_BUFFER
		CMP bx, ax
		JE caso_primeiro_caracter_CR

		DEC bx
		MOV cl, [bx]
		INC bx
		CMP cl, 65
		JGE soma_linha_com_base
		JMP caso_primeiro_caracter_CR

		soma_linha_com_base:
		INC ARQ_CONTADOR_LINHAS_COM_BASES
		JMP caso_primeiro_caracter_CR
		
		caso_primeiro_caracter_CR:
		JMP fim_loop_verificacao
		;---------------------

		caso_A:
		CMP cl, LETRA_A_M
		JNE caso_T
		INC ARQ_CONTADOR_BASES
		JMP fim_loop_verificacao

		caso_T:
		CMP cl, LETRA_T_M
		JNE caso_C
		INC ARQ_CONTADOR_BASES
		JMP fim_loop_verificacao

		caso_C:
		CMP cl, LETRA_C_M
		JNE caso_G
		INC ARQ_CONTADOR_BASES
		JMP fim_loop_verificacao

		caso_G:
		CMP cl, LETRA_G_M
		JNE caso_caracter_incorreto
		INC ARQ_CONTADOR_BASES
		JMP fim_loop_verificacao

		caso_caracter_incorreto:
		MOV CARACTERE_ERRADO, cl
		MOV al, ERRO_07											;; Arquivo possui caracter incorreto
		CALL	ERRO

		fim_loop_verificacao:

		INC bx
		MOV cl, [bx]
		JMP inicio_loop_verificacao


		;; ------------------- Fim do loop de validação e início do salvamento no arquivo de saída, daqui pra frente só tristeza ._. -------------------
		fim_verificacao_caracteres_arquivo:

		DEC bx
		MOV cl, [bx]
		CMP cl, 65
		JL verificacao_numero
		INC ARQ_CONTADOR_LINHAS_COM_BASES
		INC bx

		verificacao_numero:

		CMP ARQ_CONTADOR_BASES, 10000							;; Verifica se existem mais de 10000 bases nitrogenadas no arquivo
		JLE sem_erro_numero_de_bases
		MOV al, ERRO_06									
		CALL	ERRO

		sem_erro_numero_de_bases:

		MOV ax, ARQ_CONTADOR_BASES
		CMP ax, VAR_TAMANHO_GRUPOS								;; O arquivo precisa ter no mínimo "n" bases nitrogenadas, com n tamanho de grupo
		JGE sem_erro_tamanho_grupos
		MOV al, ERRO_02									
		CALL	ERRO

		sem_erro_tamanho_grupos:

		MOV bx, ARQ_HANDLE										;; Move o handle para bx
		MOV ah, 3EH
		INT 21H													;; Fecha o arquivo de entrada

		;; ------------------- Cria\Zera o arquivo de saída -------------------

		MOV cx, 0												;; Pode ler e escrever
		LEA dx, VAR_NOME_ARQUIVO_OUT							;; Nome do arquivo de saída
		MOV ah, 3CH												;; Código para criação de arquivo
		INT 21H

		MOV ARQ_HANDLE, ax										;; Move o handle do arquivo para a var de handle


		;; ------------------- Escrita do CABEÇALHO -------------------

		LEA bx, STRING_AUXILIAR

		;; ---- A ATIVO
		caso_a_ativo:
		CMP VAR_A_ATIVO, 1
		JNE caso_t_ativo
		
		LEA si, ARQ_CAB_A
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		;; ---- T ATIVO
		caso_t_ativo:
		CMP VAR_T_ATIVO, 1
		JNE caso_c_ativo

		LEA si, ARQ_CAB_T
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		;; ---- C ATIVO
		caso_c_ativo:
		CMP VAR_C_ATIVO, 1
		JNE caso_g_ativo

		LEA si, ARQ_CAB_C
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		;; ---- G ATIVO
		caso_g_ativo:
		CMP VAR_G_ATIVO, 1
		JNE caso_mais_ativo

		LEA si, ARQ_CAB_G
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		;; ---- MAIS ATIVO
		caso_mais_ativo:
		CMP VAR_MAIS_ATIVO, 1
		JNE fim_insercao_cabecalho

		LEA si, ARQ_CAB_MAIS
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		fim_insercao_cabecalho:
		DEC bx
		MOV [bx], 0

		CALL VERIFICA_TAMANHO_AUXILIAR

		MOV cx, STRING_AUXILIAR_TAM
		LEA dx, STRING_AUXILIAR
		MOV bx, ARQ_HANDLE
		MOV ah, 40H
		INT 21H

		LEA bx, ARQ_BUFFER										;; Move o handle para BX

		;; -------------------------------------------- INÍCIO DA INSERÇÃO DE DADOS NO ARQUIVO ----------------------------------
		;; ----------------------------------------------------------------------------------------------------------------------

		;;================ LOOP EXTERNO ================
		inicio_loop_insercao_externo:
		MOV cl, [bx]											;; Move o valor de bx para cl
		
		MOV ARQ_CONTADOR_BASES_LOOP, 0                          ;; Limpa variáveis
		MOV ARQ_CONTADOR_CR_LF, 0
		MOV ARQ_CONTADOR_A, 0
		MOV ARQ_CONTADOR_T, 0
		MOV ARQ_CONTADOR_C, 0
		MOV ARQ_CONTADOR_G, 0

		CMP cl, 0												;; Caso seja 0 deve finalizar a execução
		JE resumo_de_tela
		CMP cl, 65												;; Caso seja um CR ou LF deve verificar se antes havia uma base, e após pular para o próximo caracter
		JGE entrada_loop_insercao_interno

		INC bx
		JMP inicio_loop_insercao_externo

		entrada_loop_insercao_interno:
		INC ARQ_CONTADOR_GRUPOS

		;;================ LOOP INTERNO ================
		inicio_loop_insercao_interno:
		MOV cl, [bx]
		
		CMP cl, 0
		JE resumo_de_tela

        ;; ------------ caso CR
		caso_CR_out:
		CMP cl, CR
		JNE caso_LF_out
		INC ARQ_CONTADOR_CR_LF
		JMP fim_reconhecimento_caracter_out

        ;; ------------ caso LF
		caso_LF_out:
		CMP cl, LF
		JNE caso_A_out
		INC ARQ_CONTADOR_CR_LF
		JMP fim_reconhecimento_caracter_out

		;; ------------ caso A
		caso_A_out:
		CMP cl, LETRA_A_M
		JNE caso_T_out
		INC ARQ_CONTADOR_A
		INC ARQ_CONTADOR_BASES_LOOP
		JMP fim_reconhecimento_caracter_out

		;; ------------ caso T
		caso_T_out:
		CMP cl, LETRA_T_M
		JNE caso_C_out
		INC ARQ_CONTADOR_T
		INC ARQ_CONTADOR_BASES_LOOP
		JMP fim_reconhecimento_caracter_out

		;; ------------ caso C
		caso_C_out:
		CMP cl, LETRA_C_M
		JNE caso_G_out
		INC ARQ_CONTADOR_C
		INC ARQ_CONTADOR_BASES_LOOP
		JMP fim_reconhecimento_caracter_out

		;; ------------ caso G
		caso_G_out:
		INC ARQ_CONTADOR_G
		INC ARQ_CONTADOR_BASES_LOOP
		
		fim_reconhecimento_caracter_out:

		MOV ax, VAR_TAMANHO_GRUPOS
		CMP ax, ARQ_CONTADOR_BASES_LOOP
		JE fim_leitura_grupo
		
		INC bx
		JMP inicio_loop_insercao_interno

		;; ------------------- Aqui deve ser feita a impressão no arquivo de saída -------------
		;; -------------------------------------------------------------------------------------
		
		fim_leitura_grupo:

		PUSH bx
		LEA bx, STRING_AUXILIAR
		MOV [bx], CR
		INC bx 

		;; ---- A ATIVO
		caso_a_ativo_LINHA:
		CMP VAR_A_ATIVO, 1
		JNE caso_t_ativo_LINHA
		
        PUSH bx
		MOV		ax, ARQ_CONTADOR_A
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx

		;; ---- T ATIVO
		caso_t_ativo_LINHA:
		CMP VAR_T_ATIVO, 1
		JNE caso_c_ativo_LINHA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_T
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx


		;; ---- C ATIVO
		caso_c_ativo_LINHA:
		CMP VAR_C_ATIVO, 1
		JNE caso_g_ativo_LINHA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_C
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx

		;; ---- G ATIVO
		caso_g_ativo_LINHA:
		CMP VAR_G_ATIVO, 1
		JNE caso_mais_ativo_LINHA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_G
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx

		;; ---- MAIS ATIVO
		caso_mais_ativo_LINHA:
		CMP VAR_MAIS_ATIVO, 1
		JNE fim_insercao_cabecalho_LINHA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_A
		ADD     ax, ARQ_CONTADOR_T
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx

		PUSH bx
		MOV		ax, ARQ_CONTADOR_C
		ADD     ax, ARQ_CONTADOR_G
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2								
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], ';'
		INC bx

		fim_insercao_cabecalho_LINHA:
		DEC bx
		MOV [bx], 0


		CALL VERIFICA_TAMANHO_AUXILIAR
		MOV cx, STRING_AUXILIAR_TAM
		LEA dx, STRING_AUXILIAR
		MOV bx, ARQ_HANDLE
		MOV ah, 40H
		INT 21H

		POP bx

		SUB bx, ARQ_CONTADOR_CR_LF
		SUB bx, ARQ_CONTADOR_BASES_LOOP
		INC bx
		INC bx
		JMP inicio_loop_insercao_externo

        ;; --------------------------------------------------- RESUMO EM TELA ---------------------------------------------------
		;; ----------------------------------------------------------------------------------------------------------------------
		resumo_de_tela:

		;; ----------------------------------------------------------------------------------------------------------------------

		printa_resumo_em_tela:
        LEA bx, STRING_AUXILIAR
		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx
		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_ARQ_IN
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		LEA si, VAR_NOME_ARQUIVO_IN
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_ARQ_OUT
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		LEA si, VAR_NOME_ARQUIVO_OUT
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_TAM_GP
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		MOV		ax, VAR_TAMANHO_GRUPOS
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx

        LEA si, MSG_SUCESSO_BASES
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

        printa_a:
        CMP VAR_A_ATIVO, 1
		JNE printa_t
		LEA si, ARQ_CAB_A
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		printa_t:
		CMP VAR_T_ATIVO, 1
		JNE printa_c
		LEA si, ARQ_CAB_T
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		printa_c:
		CMP VAR_C_ATIVO, 1
		JNE printa_g
		LEA si, ARQ_CAB_C
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		printa_g:
		CMP VAR_G_ATIVO, 1
		JNE printa_mais
		LEA si, ARQ_CAB_G
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		printa_mais:
		CMP VAR_MAIS_ATIVO, 1
		JNE fim_printa
		LEA si, ARQ_CAB_MAIS
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		fim_printa:
		DEC bx
		MOV [bx], LF
		INC bx
		MOV [bx], LF
		INC bx

        LEA si, MSG_SUCESSO_P2
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx
		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_N_BASES
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_BASES
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_N_GRUPOS
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		DEC ARQ_CONTADOR_GRUPOS
		MOV		ax, ARQ_CONTADOR_GRUPOS
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF
		INC bx

		LEA si, MSG_SUCESSO_N_LINHAS
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		MOV		ax, ARQ_CONTADOR_LINHAS_COM_BASES
		LEA		bx, STRING_AUXILIAR_2
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR_2
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], LF

		LEA		bx, STRING_AUXILIAR	
		CALL	PRINTF_S















;;==============================================
;;==================== Exit ====================
;;==============================================
.exit

	;; ============================ Exibe String na tela ============================
	;; ==============================================================================
	PRINTF_S	proc	near

		mov		dl,[bx]
		cmp		dl,0
		je		ps_1

		push	bx
		mov		ah,2
		int		21H
		pop		bx

		inc		bx
			
		jmp		PRINTF_S
			
	PS_1:
		ret
	PRINTF_S	endp

	;; ============================ Tratamento de Erros ============================
	;; =============================================================================
	ERRO	proc	near
		CALL INSERE_NUMERO_ERRO


		;; ------------------- ERRO 01 -------------------
		;; Arquivo de entrada não existe
		caso_ERRO_01:
		CMP al, ERRO_01
		JNE caso_ERRO_02

		LEA si, MSG_ERRO_01
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		LEA si, VAR_NOME_ARQUIVO_IN
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA
		
		JMP fim_listagem_erro

		;; ------------------- ERRO 02 -------------------
		;; Quantidade de letras no arquivo de entrada é muito pequeno para ser processado
		caso_ERRO_02:
		CMP al, ERRO_02
		JNE caso_ERRO_03

		LEA si, MSG_ERRO_02
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		MOV		ax, VAR_TAMANHO_GRUPOS						;; Atoi inverso
		LEA		bx, STRING_AUXILIAR
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR								;; Joga String gerada para msg de erro
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		JMP fim_listagem_erro

		;; ------------------- ERRO 03 -------------------
		;; Opções informadas na linha de comando não são suficientes para processar os dados do arquivo
		caso_ERRO_03:
		CMP al, ERRO_03
		JNE caso_ERRO_04

		LEA si, MSG_ERRO_03
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		CMP VAR_OPCAO_ATCG_ATIVA, 1						;; Algum parametro de ATCG foi declarado?
		JE erro_verifica_f
		LEA si, MSG_ERRO_03_atcg
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		erro_verifica_f:
		CMP VAR_NOME_ARQUIVO_IN, 0						;; Arquivo de entrada foi declarado?
		JNE erro_verifica_o
		LEA si, MSG_ERRO_03_f
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		erro_verifica_o:
		CMP VAR_NOME_ARQUIVO_OUT, 0						;; Arquivo de saída está declarado?
		JNE erro_verifica_n
		LEA si, MSG_ERRO_03_o
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		erro_verifica_n:								;; O tamanho dos grupos n é maior que 0?
		CMP VAR_TAMANHO_GRUPOS, 0
		JNE erro_fim_verificacao_funcoes
		LEA si, MSG_ERRO_03_n
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		erro_fim_verificacao_funcoes:
		DEC bx
		JMP fim_listagem_erro

		;; ------------------- ERRO 04 -------------------
		;; Alguma opção existente na linha de comando é inválida
		caso_ERRO_04:
		CMP al, ERRO_04
		JNE caso_ERRO_05

		LEA si, MSG_ERRO_04
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], dl
		INC bx
		JMP fim_listagem_erro
		
		;; ------------------- ERRO 05 -------------------
		;; Alguma opção existente na linha de comando contém parâmetros inválidos
		caso_ERRO_05:
		CMP al, ERRO_05
		JNE caso_ERRO_06

		LEA si, MSG_ERRO_05
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], dl
		INC bx
		JMP fim_listagem_erro

		;; ------------------- ERRO 06 -------------------
		;; Arquivo muito grande
		caso_ERRO_06:
		CMP al, ERRO_06
		JNE caso_ERRO_07

		LEA si, MSG_ERRO_06
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		JMP fim_listagem_erro

		;; ------------------- ERRO 07 -------------------
		;; Foi encontrado no arquivo de entrada uma letra inválida
		caso_ERRO_07:
		CMP al, ERRO_07
		JNE caso_ERRO_ESP_01
		MOV dl, cl

		LEA si, MSG_ERRO_07									;; Salva mensagem Inicial
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		LEA si, MSG_ERRO_07_linha							;; Salva mensagem sobre linha do erro
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		PUSH bx
		INC ARQ_CONTADOR_LINHAS                             ;; Incremento pois começa a contar do 0
		MOV		ax, ARQ_CONTADOR_LINHAS						;; Atoi inverso
		LEA		bx, STRING_AUXILIAR
		CALL	SPRINTF_W
		POP bx

		LEA si, STRING_AUXILIAR								;; Joga String gerada para msg de erro
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV dl, LF											;; Gera Line Feed
		MOV [bx], dl

		INC bx

		LEA si, MSG_ERRO_07_letra							;; Joga mensagem de erro do caractere
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV dl, CARACTERE_ERRADO							;; Insere caractere incorreto na mensagem de erro	
		MOV [bx], dl
		INC bx

		JMP fim_listagem_erro

		;; -------------- ERRO ESPECIAL 01 ---------------
		;; Não foi digitado um TRACO quando deveria haver um
		caso_ERRO_ESP_01:
		CMP al, ERRO_ESP_01
		JNE caso_ERRO_ESP_02

		LEA si, MSG_ERRO_ESP_01
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		MOV [bx], dl
		INC bx
		JMP fim_listagem_erro

		;; -------------- ERRO ESPECIAL 02 ---------------
		;; Não foi digitado um ESPACO quando deveria haver um
		caso_ERRO_ESP_02:
		CMP al, ERRO_ESP_02
		JNE caso_ERRO_ESP_03

		LEA si, MSG_ERRO_ESP_02
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA
		CMP dl, 0
		JE fim_listagem_erro
		MOV [bx], dl
		INC bx
		JMP fim_listagem_erro

		;; -------------- ERRO ESPECIAL 02 ---------------
		;; Erro na leitura de Arquivo
		caso_ERRO_ESP_03:
		CMP al, ERRO_ESP_03
		JNE fim_listagem_erro

		LEA si, MSG_ERRO_ESP_03
		MOV di, bx
		CALL INSERE_STRING_SIMPLIFICADA

		;; -------------- Fim dos casos de Erro ---------------
		fim_listagem_erro:
		MOV dl, LF
		MOV [bx], dl

		LEA		bx, STRING_ERRO							;; Printa o Erro com a mensagem na tela
		CALL	PRINTF_S
		.exit
	ERRO	endp

	;; 1 - Recebe SI e DI
	;; 2 - Descobre o tamanho da array SI e joga em CX
	;; 3 - Copia string SI para DI
	;; 4 - BX = DI + CX ----> BX recebe o endereco de destino + o tamanho da string inserida
	INSERE_STRING_SIMPLIFICADA	proc	near
		PUSH ax	
		PUSH cx
		PUSH dx
		
		MOV cx, 0										;; Zero cx
		MOV bx, si										;; Crio cópia do source em bx
		
		descobre_tamanho_si:							;; Descobre o tamanho da string em si
		MOV dl, [bx]
		CMP dl, 0
		JE fim_descobre_tamanho_si
		INC cx
		INC bx
		JMP descobre_tamanho_si

		fim_descobre_tamanho_si:						;; Fim do loop de  contagem
		PUSH es
		MOV ax, ds
		MOV es, ax
		CLD
		REP movsb										;; Joga source em destination
		pop es

		MOV bx, di
		ADD bx, cx

		POP dx
		POP cx
		POP ax
		RET
	INSERE_STRING_SIMPLIFICADA endp
	
	INSERE_NUMERO_ERRO	proc	near
		PUSH ax
		PUSH cx
		PUSH dx

		MOV ah, 0
		MOV cl,10										;; Executa divisao AL/CL
		DIV cl

		ADD ah, 48										;; Soma para gerar ASCII
		ADD al, 48										;; Soma para gerar ASCII

		LEA bx, STRING_ERRO_MSG
		MOV [bx], al									;; Joga valores no Array de mensagem de erro
		INC bx
		MOV [bx], ah
		INC bx
		MOV [bx], ")"
		INC bx
		MOV [bx], CARACTER_ESPACO
		INC bx

		POP dx
		POP cx
		POP ax
		RET
	INSERE_NUMERO_ERRO endp

	;; ============================ Caso da Letra "F" ============================
	;; ===========================================================================
	CASO_LETRA_f	proc	near
		INC bx											;; Pula para o caracter de espaço
		MOV dl, [bx]				
		CMP dl, CARACTER_ESPACO							;; Verifica se esse caractere é um espaço, se não for ocorreu erro
		JE sem_erro_espaco_f							;; Caso espaco
		MOV al, ERRO_ESP_02
		CALL	ERRO

		sem_erro_espaco_f:
		MOV cx, 0										;; Zero o CX

		INC bx				
		MOV si, bx										;; Define Source
		DEC bx

		LEA di, VAR_NOME_ARQUIVO_IN						;; Define Destino

		loop_letra_f:
		INC bx											;; Incrementa BX a cada LOOP
		
		MOV dl, [bx]
		CMP dl, CARACTER_ESPACO							;; Verifica se o caracter é vazio ou espaço
		JE fim_loop_letra_f
		CMP dl, 0
		JE fim_loop_letra_f

		INC cx
		JMP loop_letra_f
		
		fim_loop_letra_f:								;; Executa a cópia da String
		PUSH es
		MOV ax, ds
		MOV es, ax
		CLD
		REP movsb
		pop es
		
		LEA ax, VAR_NOME_ARQUIVO_IN  					;; Posição VAR_NOME_ARQUIVO_IN + cx + 1 é Zerada
		ADD ax, cx
		INC ax
		MOV ax, 0


		ret
	CASO_LETRA_f	endp

	;; ============================ Caso da Letra "O" ============================
	;; ===========================================================================
	CASO_LETRA_o	proc	near
		INC bx											;; Pula para o caracter de espaço
		MOV dl, [bx]				
		CMP dl, CARACTER_ESPACO							;; Verifica se esse caractere é um espaço, se não for ocorreu erro
		JE sem_erro_espaco_o							;; Caso espaco
		MOV al, ERRO_ESP_02
		CALL	ERRO
		
		sem_erro_espaco_o:
		MOV cx, 0										;; Zero o CX

		INC bx				
		MOV si, bx										;; Define Source
		DEC bx

		LEA di, VAR_NOME_ARQUIVO_OUT					;; Define Destino

		loop_letra_o:
		INC bx											;; Incrementa BX a cada LOOP
		
		MOV dl, [bx]
		CMP dl, CARACTER_ESPACO							;; Verifica se o caracter é vazio ou espaço
		JE fim_loop_letra_o
		CMP dl, 0
		JE fim_loop_letra_o

		INC cx
		JMP loop_letra_o
		
		fim_loop_letra_o:								;; Executa a cópia da String
		PUSH es
		MOV ax, ds
		MOV es, ax
		CLD
		REP movsb
		pop es

		LEA ax, VAR_NOME_ARQUIVO_OUT  					;; Posição VAR_NOME_ARQUIVO_OUT + cx + 1 é Zerada
		ADD ax, cx
		INC ax
		MOV ax, 0

		RET
	CASO_LETRA_o	endp

	;; ============================ Caso da Letra "N" ============================
	;; ===========================================================================
	CASO_LETRA_n	proc	near
		INC bx											;; Pula para o caracter de espaço
		MOV dh, [bx]				
		CMP dh, CARACTER_ESPACO							;; Verifica se esse caractere é um espaço, se não for ocorreu erro
		JE sem_erro_espaco_n							;; Caso espaco
		
		MOV dl, dh
		MOV al, ERRO_ESP_02								;; Caso não haja espaço no local esperado
		CALL	ERRO
		
		sem_erro_espaco_n:
		MOV cl, 0

		loop_letra_n:
		INC bx											;; Incrementa BX a cada LOOP
		MOV dh, [bx]
		CMP dh, CARACTER_ESPACO							;; Verifica se o caracter é vazio ou espaço
		JE fim_loop_letra_n
		CMP dh, 0
		JE fim_loop_letra_n

		CMP dh, 48										;; Verifica se está abaixo de 48, se sim, ocorreu erro
		JGE continua_verificacao
		MOV dl, dh
		MOV al, ERRO_05
		CALL	ERRO

		continua_verificacao:							;; Verifica se está acima de 57, se sim, ocorreu erro
		CMP dh, 57
		JLE fim_verificacao
		MOV dl, dh
		MOV al, ERRO_05
		CALL	ERRO

		fim_verificacao:								;; Soma CL e continua LOOP
		INC cl
		JMP loop_letra_n

		;; ------------------

		fim_loop_letra_n:
		DEC bx											;; Decrementa BX pois ele estará numa posição de espaço ou vazia, então retorno para posição válida
		MOV dh, [bx]									;; Seto o dh novamente para trabalhar com valor de [bx]
		MOV ch, cl										;; Crio uma cópia de CL em CH, servirá para gardar valor original
		MOV ah, 0

		descubro_numero:
		CMP cl, 0
		JE fim_caso_letra_n

		MOV dl, ch										;; dl = ch - cl ----- Ex: 1 = 10 - 9
		SUB dl, cl										;; DL: número de vezes para multiplicar por 10

		MOV al, dh										;; al = dh - 48
		SUB al, 48										;; AL: Número efetivo

		loop_valor_casa_decimal_numero:
		CMP dl, 0
		JE fim_loop_criacao_numero
		MUL VALOR_DEZ
		DEC dl
		JMP loop_valor_casa_decimal_numero

		fim_loop_criacao_numero:
		PUSH cx

		MOV	cx, VAR_TAMANHO_GRUPOS
		ADD cx, ax
		MOV VAR_TAMANHO_GRUPOS, cx

		POP cx

		DEC bx
		MOV dh, [bx]
		DEC cl
		JMP descubro_numero
		
		fim_caso_letra_n:

		volta_ponteiro_bx_ao_normal:
		CMP ch, 0
		JE fim_volta_ponteiro_bx_ao_normal
		INC bx
		DEC ch
		JMP volta_ponteiro_bx_ao_normal

		fim_volta_ponteiro_bx_ao_normal:
		INC bx
		RET
	CASO_LETRA_n	endp

	;; ============================ Caso "ACTG+" ============================
	;; ======================================================================
	CASO_ATCG	proc	near

		inicio_CASO_ATCG_verificacao:

		;; --- Caso Fim de String ---
		CMP dl, CARACTER_ESPACO
		JE fim_CASO_ATCG
		CMP dl, 0
		JE fim_CASO_ATCG

		;; --- Caso T ---
		CASO_ATCG_verificacao_letra_actg_a:
		CMP dl, LETRA_a
		JNE CASO_ATCG_verificacao_letra_actg_t
		MOV VAR_A_ATIVO, 1
		JMP fim_CASO_ATCG_verificacao
		
		;; --- Caso T ---
		CASO_ATCG_verificacao_letra_actg_t:
		CMP dl, LETRA_t
		JNE CASO_ATCG_verificacao_letra_actg_c
		MOV VAR_T_ATIVO, 1
		JMP fim_CASO_ATCG_verificacao

		;; --- Caso C ---
		CASO_ATCG_verificacao_letra_actg_c:
		CMP dl, LETRA_c
		JNE CASO_ATCG_verificacao_letra_actg_g
		MOV VAR_C_ATIVO, 1
		JMP fim_CASO_ATCG_verificacao

		;; --- Caso G ---
		CASO_ATCG_verificacao_letra_actg_g:
		CMP dl, LETRA_g
		JNE CASO_ATCG_verificacao_letra_actg_mais
		MOV VAR_G_ATIVO, 1
		JMP fim_CASO_ATCG_verificacao

		;; --- Caso + ---
		CASO_ATCG_verificacao_letra_actg_mais:
		CMP dl, CARACTER_MAIS
		JE CASO_ATCG_verificacao_letra_actg_mais_p2
		MOV al, ERRO_04
		CALL	ERRO

		CASO_ATCG_verificacao_letra_actg_mais_p2:
		MOV VAR_MAIS_ATIVO, 1

		fim_CASO_ATCG_verificacao:
		MOV VAR_OPCAO_ATCG_ATIVA, 1							;; Salva a informacao de que alguma das opcoes foi salva
		INC bx
		MOV dl, [bx]
		JMP inicio_CASO_ATCG_verificacao

		fim_CASO_ATCG:
		RET
	CASO_ATCG	endp

	VERIFICA_TAMANHO_AUXILIAR	proc	near
		PUSH bx
		PUSH ax

		MOV STRING_AUXILIAR_TAM, 0
		LEA bx, STRING_AUXILIAR

		inicio_verificacao_tam_aux:
		CMP [bx], 0
		JE fim_verificacao_tam_aux
		INC STRING_AUXILIAR_TAM
		INC bx
		JMP inicio_verificacao_tam_aux

		fim_verificacao_tam_aux:
		POP ax
		POP bx
		RET

	VERIFICA_TAMANHO_AUXILIAR	endp

	SPRINTF_W	proc	near
		PUSH cx
		
		mov		sw_n,ax
		mov		cx,5
		mov		sw_m,10000
		mov		sw_f,0
		sw_do:
		mov		dx,0
		mov		ax,sw_n
		div		sw_m
		cmp		al,0
		jne		sw_store
		cmp		sw_f,0
		je		sw_continue
		sw_store:
		add		al,'0'
		mov		[bx],al
		inc		bx
		mov		sw_f,1
		sw_continue:
		mov		sw_n,dx
		mov		dx,0
		mov		ax,sw_m
		mov		bp,10
		div		bp
		mov		sw_m,ax
		dec		cx
		cmp		cx,0
		jnz		sw_do
		cmp		sw_f,0
		jnz		sw_continua2
		mov		[bx],'0'
		inc		bx
		sw_continua2:
		mov		byte ptr[bx],0	

		POP cx

		ret
	SPRINTF_W	endp
end

; Finalmente acabei isso aqui :)