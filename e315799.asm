;;EDUARDO EUGÊNIO KUSSLER
;;CARTÃO: 00315799


;;BUGS: 
;nao le arquivo sem .par


.model small
.stack

.data
CR equ 13
LF equ 10
;cores
preto equ 0h
azul equ 1h
verde equ 2h
ciano equ 3h
vermelho equ 4h
magenta equ 5h
marrom equ 6h
cinzaClaro equ 7h
cinzaEscuro equ 8h
azulClaro equ 9h
verdeClaro equ 0ah
cianoClaro equ 0bh
vermelhoClaro equ 0ch
magentaClaro equ 0dh
amarelo equ 0eh
branco equ 0fh

;cores ASCII
pretoAsc equ '0'
azulAsc equ '1'
verdeAsc equ '2'
cianoAsc equ '3'
vermelhoAsc equ '4'
magentaAsc equ '5'
marromAsc equ '6'
cinzaClaroAsc equ '7'
cinzaEscuroAsc equ '8'
azulClaroAsc equ '9'
verdeClaroAsc equ 'a'
cianoClaroAsc equ 'b'
vermelhoClaroAsc equ 'c'
magentaClaroAsc equ 'd'
amareloAsc equ 'e'
brancoAsc equ 'f'

verdeClaroAscMaiusc equ 'A'
cianoClaroAscMaiusc equ 'B'
vermelhoClaroAscMaiusc equ 'C'
magentaClaroAscMaiusc equ 'D'
amareloAscMaiusc equ 'E'
brancoAscMaiusc equ 'F'
tamanhoBuffer equ 22
;variaveis
tamanhoQuad dw 24
larguraDisp equ 624
alturaDisp equ 360
resTmp dw 0
testeArquivo db ".\teste.rel",0
inicioParedeX equ 8
inicioParedeY equ 25
crlf db CR,LF,0
cabecalho db "************ Autor: Eduardo Eugenio Kussler ********* Matricula: 315799 *******",CR,LF,0
tamanho dw ? ;é usada como o parametro pra funcoes de desenho de linhas
tamanhoLadoV dw ?
tamanhoLadoH dw ?
xInicio dw ?
yInicio dw ?
xInicioQuad dw ?
yInicioQuad dw ?
corQuad db ?
strErroCria db "Erro ao criar arquivo .rel",0
pedeNomeArquivo db "Digite o nome do arquivo: ",0
fimDoApp db "Voce decidiu fechar o programa. Ate mais!", 0
arquivoInexistente db "Arquivo Inexistente",CR,LF, 0
totLadrStr db " - Total de ladrilhos por cor:",0
arqStr db "Arquivo ",0
nomeArquivo db 20 dup(?)
nomeArquivoPrint db 20 dup(?)
nomeArquivoSaida db 20 dup(?)
bufferTeclado db 20 dup(?)
stringErro db CR,LF,"Erro ",0
stringErroCod db 6 dup(0)
contador db 0
ponteiroA dw 0
ponteiroB dw 0
tamanhoNomeArquivo db ?
largura dw 0
altura dw 0
fimArquivoFlag dw 0
totCor db 5 dup(?)
strTeste db 20 dup(0)
alturaStr db 10
larguraStr db 10


resultadoMult dw 0

bufferArq db 10 dup(0)
;usadas na conversao de numero pra string
sw_n	dw	0
sw_f	db	0
sw_m	dw	0

teste db "5",0
handleTemp dw 0;armazena dados temporarios 
endTemp dw 0;armazena um endereco temporario
larguraTemp dw 0
alturaTemp dw 0
corTemp db 0
alturaTemp1 dw ?

fimProgramaFlag dw ?
linha db 28 dup(?);o numero maximo de ladrilhos por linha eh 26, mais 2 bytes para o CR LF
totPreto dw ?
totAzul dw ?
totVerde dw ?
totCiano dw ?
totVermelho dw ?
totMagenta dw ?
totMarrom dw ?
totCinzaClaro dw ?
totCinzaEscuro dw ?
totAzulClaro dw ?
totVerdeClaro dw ?
totCianoClaro dw ?
totVermelhoClaro dw ?
totMagentaClaro dw ?
totAmarelo dw ?
erro dw ?
handleArqPar dw ?
handleArqRel dw ?
;POSICOES X dos quadrados de Legenda
posXQuadPreto dw 20
posXQuadAzul dw 60
posXQuadVerde dw 100
posXQuadCiano dw 140
posXQuadVermelho dw 180
posXQuadMagenta dw 220
posXQuadMarrom dw 260
posXQuadCinzaClaro dw 300
posXQuadCinzaEscuro dw 340
posXQuadAzulClaro dw 380
posXQuadVerdeClaro dw 420
posXQuadCianoClaro dw 460
posXQuadVermelhoClaro dw 500
posXQuadMagentaClaro dw 540
posXQuadAmarelo dw 580


;Posicoes Y dos quadrados de legenda e do texto
posYQuadLegenda dw 435
posYTextLegenda db 29
;Posicoes X dos textos de legenda
posXTextQuadPreto db 3
posXTextQuadAzul db 8
posXTextQuadVerde db 13
posXTextQuadCiano db 18
posXTextQuadVermelho db 23
posXTextQuadMagenta db 28
posXTextQuadMarrom db 33
posXTextQuadCinzaClaro db 38
posXTextQuadCinzaEscuro db 43
posXTextQuadAzulClaro db 48
posXTextQuadVerdeClaro db 53
posXTextQuadCianoClaro db 58
posXTextQuadVermelhoClaro db 63
posXTextQuadMagentaClaro db 68
posXTextQuadAmarelo db 73
corRet db ?


strPreto db "Pretos - ",0
strAzul db "Azuis - ",0
strVerde db "Verdes - ",0
strCiano db "Cianos - ",0
strVermelho db "Vermelhos - ",0
strMagenta db "Magentas - ",0
strMarrom db "Marrons - ",0
strCinzaClaro db "Cinzas Claros - ",0
strCinzaEscuro db "Cinzas Escuros - ",0
strAzulClaro db "Azuis Claros - ",0
strVerdeClaro db "Verdes Claros - ",0
strCianoClaro db "Cianos Claros - ",0
strVermelhoClaro db "Vermelhos Claros - ",0
strMagentaClaro db "Magentas Claros - ",0
strAmarelo db "Amarelos - ",0

strPrimeiraLinha db "O arquivo ",0
strPrimeiraLinha1 db " contem a seguinte quantidade de ladrilhos:",cr,lf,0
.code
.startup
comecoApp:
    mov ax, 0
    mov fimProgramaFlag, ax
    mov fimArquivoFlag, ax
    call alteraModoTexto
    ;exibe a primeira linha com nome e matricula
    lea bx, cabecalho
    call printf_s
    lea bx, totCor
    mov al, 5
    call zeraArray
pedeNome:
    mov erro, 0
    call zeraAcumuladores
    mov ax, 0
    mov handleArqPar, ax
    mov handleArqRel, ax
    lea bx, pedeNomeArquivo;coloca a mensagem pedindo o nome do arquivo
    call printf_s

    lea bx, bufferTeclado
    mov al, tamanhoBuffer
    call limpaTecBuffer;zera o buffer de teclado

    lea dx, bufferTeclado;le o nome do arquivo
    call leTeclado
    
    ;limpa o array que guarda o nome do arquivo
    lea bx, nomeArquivo
    mov al, 20
    call zeraArray


    lea bx, bufferTeclado;move o conteudo de buffer teclado
    lea ax, nomeArquivo
    call copiaBufferTeclado;para o nome do arquivo
    mov ax, fimProgramaFlag
    cmp ax, 1
    je acabouPrograma

    lea bx, nomeArquivoSaida
    mov ax, 20
    call zeraArray;zera o array que guarda o nome do arquivo de saída

    call pulaLinha
   
    ;abre o arquivo
    mov handleArqPar, 0
    lea bx, handleArqPar
    lea dx, nomeArquivo
    call abreArquivo
    ;testa se houve erro
    mov ax, erro
    cmp ax, 0
    jz trocaExtensao1
    jmp testaExtensao
    ;se não houve erro, testa se falta a extensao no nome do arquivo
testaExtensao:
    
    lea bx, nomeArquivo
    lea ax, nomeArquivoSaida
    mov dl, tamanhoNomeArquivo;copia o nome do arquivo para a string de saida
    call copiaString


    ;lea bx, nomeArquivo
    ;call adicionaExtensao

    lea bx, nomeArquivoSaida
    ;call colocaExtensaoSaida

    

    mov ah, tamanhoNomeArquivo
    add ah, 4
    mov tamanhoNomeArquivo, ah ;adiona ao tamanho do arquivo os 4 carecteres '.par'
    

    lea bx, handleArqPar
    lea dx, nomeArquivo
    call abreArquivo
    ;testa se houve erro
    mov ax, erro
    cmp ax, 0
    jz continua
    cmp ax, 2
    je arquivoNaoExiste
    jmp mostraErro
testaErro:
    ;se o handle esta em 0, testa se houve erro
    mov ax, erro
    cmp ax, 0
    jmp mostraErro ;se houve erro printa o erro
    ;se houve erro, novamente, printa o erro e volta para o começo
mostraErro:
    call printaErro
    jmp pedeNome

arquivoNaoExiste:
    call pulaLinha
    lea bx, arquivoInexistente
    call printf_s
    jmp pedeNome


trocaExtensao1:
    lea bx, nomeArquivo
    lea ax, nomeArquivoSaida
    mov dl, tamanhoNomeArquivo
    call copiaString

    lea bx, nomeArquivoSaida
    call trocaExtensao

    jmp continua

continua:
    mov ax, 0
    call alteraModoGrafico


    lea dx, nomeArquivoSaida
    call criaArquivo
    mov ax, erro
    cmp ax, 0 ;testa se houve erro
    jne deuErro
    

    ;exibe a primeira linha com nome e matricula
    lea bx, cabecalho
    call printf_s

    ;desenha o retangulo em volta da parede
    mov cx, 0
    mov dx, 20
    mov al, amarelo
    mov bx, 639
    mov tamanhoLadoH, bx
    mov bx, 371
    mov tamanhoLadoV, bx
    call retangulo

    mov dl, 0
    mov dh, 25
    call setCursor


    ;printa "Arquivo <nome_do_arquivo> - Total de Ladrilhos por cor"
    lea bx, arqStr
    call printf_s
    lea bx, nomeArquivo
    call printf_s
    lea bx, totLadrStr
    call printf_s

    ;desenha um quadrado preto na area de legenda
    mov cx, posXQuadPreto
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0h
    call quadradoCol

    ;desenha um quadrado Azul na area de legenda
    mov cx, posXQuadAzul
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 1h
    call quadradoCol

;desenha um quadrado Verde na area de legenda
    mov cx, posXQuadVerde
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 2h
    call quadradoCol

    ;desenha um quadrado Ciano na area de legenda
    mov cx, posXQuadCiano
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 3h
    call quadradoCol

    ;desenha um quadrado Vermelho na area de legenda
    mov cx, posXQuadVermelho
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 4h
    call quadradoCol

    ;desenha um quadrado Magenta na area de legenda
    mov cx, posXQuadMagenta
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 5h
    call quadradoCol

    ;desenha um quadrado Marrom na area de legenda
    mov cx, posXQuadMarrom
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 6h
    call quadradoCol

    ;desenha um quadrado CinzaClaro na area de legenda
    mov cx, posXQuadCinzaClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 7h
    call quadradoCol

    ;desenha um quadrado CinzaEscuro na area de legenda
    mov cx, posXQuadCinzaEscuro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 8h
    call quadradoCol

    ;desenha um quadrado AzulClaro na area de legenda
    mov cx, posXQuadAzulClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 9h
    call quadradoCol

    ;desenha um quadrado VerdeClaro na area de legenda
    mov cx, posXQuadVerdeClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0ah
    call quadradoCol


    ;desenha um quadrado CianoClaro na area de legenda
    mov cx, posXQuadCianoClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0bh
    call quadradoCol

    ;desenha um quadrado VermelhoClaro na area de legenda
    mov cx, posXQuadVermelhoClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0ch
    call quadradoCol

    ;desenha um quadrado MagentaClaro na area de legenda
    mov cx, posXQuadMagentaClaro
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0dh
    call quadradoCol

    ;desenha um quadrado Amarelo area de legenda
    mov cx, posXQuadAmarelo
    mov dx, posYQuadLegenda
    mov bx, 24
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov al, 0eh
    call quadradoCol

    ;le a primeiraLinha
    call lePrimeiraLinha
    
    
    lea bx, bufferArq
    mov al, 10
    call zeraArray
    ;ler cores
    mov ax, 0
    mov alturaTemp, ax
    mov larguraTemp, ax   
    
leLinha:
    mov ax, alturaTemp
    cmp ax, altura
    je mostraContadores
    lea dx, bufferArq
    mov bx, handleArqPar
    call leCores
    inc alturaTemp
    jmp leLinha


mostraContadores:
    ;coloca a primeira linha do arquivo de texto de saida
    lea dx, strPrimeiraLinha
    mov bx, handleArqRel
    call escreveArquivo
    ;coloca o nome do arquivo
    lea dx, nomeArquivo
    mov bx, handleArqRel
    call escreveArquivo
    ;coloca o resto da primeira linha
    lea dx, strPrimeiraLinha1
    mov bx, handleArqRel
    call escreveArquivo
    call printaTotalizadores
    lea dx, bufferTeclado
    ;fecha o arquivo com as informações da parede
    mov bx, handleArqPar
    call fechaArquivo
    ;fecha o arquivo com o relatorio da parede
    mov bx, handleArqRel
    call fechaArquivo
    call esperaTecla
    jmp comecoApp

acabouPrograma:
    mov ax, 0
    call alteraModoGrafico;tem o efeito de limpara a tela
    mov ax, 0
    call alteraModoTexto
    ;exibe a primeira linha com nome e matricula
    lea bx, cabecalho
    call printf_s
    call pulaLinha
    lea bx, fimDoApp ;coloca a mensagem indicando que o usuario decidiu fechar o programa
    call printf_s
    mov bx, handleArqPar
    call fechaArquivo
    .exit 0
deuErro: 
    mov dl, 0
    mov dh, 0
    call alteraModoTexto
    call setCursor
    lea bx, cabecalho
    call printf_s
    call pulaLinha
    lea bx, strErroCria
    call printf_s
    call esperaTecla
    
    mov bx, handleArqPar
    call fechaArquivo
    jmp comecoApp   
    

;altera para o modo texto
alteraModoTexto proc near
    push ax
    
    mov ah, 0h
    mov al, 07h ;;altera o modo de video para texto
    int 10h     
    pop ax
    ret
alteraModoTexto endp

;altera para o modo grafico 640x480
alteraModoGrafico proc near
    push ax
    mov ah, 0h
    mov al, 12h ;;altera o modo de video para grafico
    int 10h
    pop ax
    ret
alteraModoGrafico endp
;recebe em bx o endereço para o string terminado em '\0'
;codigo adaptado dos slides
printf_s	proc	near
	mov		dl,[bx]
	cmp		dl,0
	je		fimString

	push	bx
	mov		ah,2
	int		21H
	pop		bx

	inc		bx
	jmp		printf_s
		
fimString:
	ret
	
printf_s	endp

;imprime o CRLF pulando para a proximalinha
pulaLinha proc near
    push bx
    lea bx, crlf
    call printf_s
    pop bx
    ret
pulaLinha endp
;DESENHA UMA LINHA HORIZONTAL
;recebe em al a cor da linha
;cx o x de inicio
;dx o y de inicio
;recebem em Tamanho o tamanho da linha
drawLineH proc near
    push bx
    mov bh, 0
    mov bx, tamanho
testaBlDrawLineH:
    cmp bx, 0
    je acabouDrawH;testa se a linha já esta com o tamanho desejado
    mov bx, 0 ;deixar a pagina de graficos na 0 e o desenho ser visivel
    mov ah, 0ch ;chama a função para ligar um pixel
    int 10h
    dec tamanho
    mov bx, tamanho
    inc cx ; altera o x
    jmp testaBlDrawLineH

acabouDrawH:
    pop bx
    ret
drawLineH endp
;DESENHA UMA LINHA VERTICAL
;recebe em al a cor da linha
;cx o x de inicio
;dx o y de inicio
;recebem em Tamanho o tamanho da linha
drawLineV proc near
    push bx
    mov bh, 0
    mov bx, tamanho
testaBlDrawLineV:
    cmp bx, 0
    je acabouDrawV;testa se a linha já esta com o tamanho desejado
    mov bx, 0;deixar a pagina de graficos na 0 e o desenho ser visivel
    mov ah, 0ch ;chama a função para ligar um pixel
    int 10h
    dec tamanho
    mov bx, tamanho
    inc dx ; altera o x
    jmp testaBlDrawLineV

acabouDrawV:
    pop bx
    ret
drawLineV endp


;recebe em bx o endereço para o buffer
;recebe em al o numero de bytes que o buffer tem
limpaTecBuffer proc near
        push cx
        mov cx, 0
        mov [bx], al ;coloca na posicao 0 do array, o maximo de caracteres que podem ser lidos
        inc bx
        mov [bx],cl
loopLimpatec: 
        cmp al, 0
        je fimLimpaTec ;testa se todo o buffer foi limpo
        mov [bx],  cl;zera o buffer na posicao atual
        inc bx;atualiza o ponteiro para o buffer apontar para a nova posicao
        dec al
        jmp loopLimpatec


fimLimpaTec:    
            pop cx
            ret

limpaTecBuffer endp

;recebe em bx o endereco para o buffer de teclado
;recebem em ax o endereco para o array que guardara as informacoes
copiaBufferTeclado proc near
    push cx
    push dx
    mov cl, CR
    inc bx
    mov dl, BYTE PTR [bx];coloca em contador, o numero de bytes lidos
    mov contador, dl
    cmp dl, 0 ;se contador igual a 0, indica que só foi lido o CR, logo a string esta vazia
    je fimPrograma
    inc contador ;pois a funcao não considera o CR
    inc dl ;salva o tamanho do arquivo numa variavel
    mov tamanhoNomeArquivo, dl
    inc  bx ;altera o ponteiro do buffer de teclado para apontar para
                ;a primeira informação do nome do arquivo
    mov ponteiroA, ax
    mov ponteiroB, bx
comecaCopia:
    cmp contador, 0;se contador for 0, copiou tudo
    je fimCopiaBuffer
    cmp cl, [bx]
    je  move0h;se for o CR, coloca o '\0' no lugar para indicar que a string acabou
    mov dl, BYTE PTR [bx];move o conteudo do buffer pra qual bx aponta para dl
    mov ponteiroB, bx;salva o ponteiro de bx
    mov bx, ponteiroA;carrega o ponteiro para o array de destino
    mov [bx], dl;coloca ocaractere que esteva em src para dest
    inc ponteiroA ;atualiza os ponteiros
    inc ponteiroB
    mov bx, ponteiroB
    dec contador ;atualiza o contador
    jmp comecaCopia
move0h: mov bx, ponteiroA
    mov dl, 0h
    mov [bx], dl
fimCopiaBuffer:
    pop dx
    pop cx
    ret

fimPrograma:
    mov ax, 1
    mov fimProgramaFlag, ax
    pop dx
    pop cx
    ret
copiaBufferTeclado endp


;recebe em bx o endereço para o array
;recebe em al o numero de bytes que o array tem
zeraArray proc near
loopZeraArray: 
        cmp al, 0
        je fimZeraArray ;testa se todo o buffer foi limpo
        mov [bx],  0;zera o buffer na posicao atual
        inc bx;atualiza o ponteiro para o buffer apontar para a nova posicao
        dec al
        jmp loopZeraArray

fimZeraArray:    
            ret

zeraArray endp

;zera os acumuladores dos totais de cada cor
zeraAcumuladores proc near
    mov totPreto, 0
    mov totAzul, 0
    mov totVerde, 0
    mov totCiano, 0
    mov totVermelho, 0 
    mov totMagenta, 0 
    mov totMarrom, 0
    mov totCinzaClaro, 0
    mov totCinzaEscuro, 0
    mov totAzulClaro, 0
    mov totVerdeClaro, 0
    mov totCianoClaro, 0
    mov totVermelhoClaro, 0
    mov totMagentaClaro, 0
    mov totAmarelo, 0
    ret
zeraAcumuladores endp



;recebe em bx o endereco para o array fonte
;recebe em ax o endereco para o array destino
;recebe em dl o tamanho do array
copiaString proc near
    push cx
    push dx
    mov cl, 0
    mov ch, 1
    mov contador, dl
    mov ponteiroA, ax
    mov ponteiroB, bx
comecaCopiaString:
    cmp contador, ch;se contador for 1, copiou tudo
    je moveZero
    cmp cl, [bx]
    je  moveZero ;se for o 0, coloca o '\0' no lugar para indicar que a string acabou
    mov dl, BYTE PTR [bx];move o conteudo do buffer pra qual bx aponta para dl
    mov ponteiroB, bx;salva o ponteiro de bx
    mov bx, ponteiroA;carrega o ponteiro para o array de destino
    mov [bx], dl;coloca ocaractere que esteva em src para dest
    inc ponteiroA ;atualiza os ponteiros
    inc ponteiroB
    mov bx, ponteiroB
    dec contador ;atualiza o contador
    jmp comecaCopiaString
moveZero: mov bx, ponteiroA
    mov dl, 0h; coloca o '\0' indicando que o string acabou
    mov [bx], dl
fimCopiaString:
    pop dx
    pop cx
    ret

copiaString endp

;abre o arquivo cujo nome esta em dx
;recebe em bx, o endereco do handle
abreArquivo proc near
    push cx
    mov ah, 3dh ;indica que é para abrir o arquivo
    mov al, 0h ;indica que é somente leitura
    int 21h
    
    jnc movHandleArq ;CF = 0, abertura feita com sucesso
    ;senao, move o erro pra erro
    mov erro ,ax
    ret 
movHandleArq:
            mov [bx], ax
            mov cx, 0
            mov erro, cx;zera a variavel que guarda o erro
            pop cx
            ret
abreArquivo endp



;cria o arquivo cujo nome esta apontado por DX
criaArquivo proc near
    push cx
    mov cx, 0;tipo do arquivo = normal
    mov ax, 0;limpa o ax
    mov ah, 3ch ;chama a interrupção correta
    int 21h

    jnc criadoComSucesso;testa se houve erro

    mov erro, ax ;coloca o erro na variave de nome erro
    jmp saiCriaArquivo

criadoComSucesso:
    mov cx, 0
    mov erro, cx ;zera o erro
    mov handleArqRel, ax ;move o handle para a variavel adequada
       
    
saiCriaArquivo:
    pop cx
    ret 
criaArquivo endp
;recebe em bx o handle do arquivo
;em dx o ponteiro para o buffer de leitura
leArquivo proc near
    push cx
    push ax
    mov cx, 1 ;le 1 byte
    mov ax, 0
    mov ah, 3fh
    int 21H
    cmp cx, ax
    jne fimArquivo
    pop ax
    pop cx
    ret
fimArquivo:
    mov cx, 1
    mov fimArquivoFlag, cx
    pop ax
    pop cx
    ret
leArquivo endp

;recebe em bx o handle do arquivo
fechaArquivo proc near
    push ax
    mov ax, 0
    mov ah, 3eh
    int 21h
    pop ax
    ret
fechaArquivo endp

;em dx recebe a string a ser escrita no arquivo
;em bx o handle do arquivo
escreveArquivo proc near
    push cx
    push ax
    mov endTemp, dx
    mov handleTemp, bx;coloca o handle em uma variavel temporaria
    mov cx, 1
escreveChar:
    mov bx, endTemp
;testa se a posicao atual é '\0'
    cmp BYTE PTR [bx], ch
    je fimEscreve
    mov cx, 1 ;sempre escreve 1 byte por vez
    mov dx, bx ;coloca o endereço atual da string em dx
    mov bx, handleTemp ;restaura o handle para fazer a interrupção
    mov ax, 0
    mov ah, 40h
    int 21H
    jc erroEscreveArq
    mov ax, 0
    mov erro, ax
    inc endTemp ;atualiza a posicao do ponteiro
    jmp escreveChar
erroEscreveArq:
    mov erro, ax
fimEscreve:
    pop ax
    pop cx
    ret
escreveArquivo endp

;recebe o endereço do array com o nome do arquivo por bx
;o nome deve terminar com '\0'
adicionaExtensao proc near
                push ax
                push cx
                mov ah, tamanhoNomeArquivo
                mov cl, 0
procuraBarraZero: 
                cmp ah, 5;se ah tiver 5 espacos significa que o caracter atual é '\0'
                mov al, [bx]
                cmp al, cl
                je achouBarraZero
                inc bx
                dec ah
                jmp procuraBarraZero
achouBarraZero: ;quando achar o '\0', adiciona 
                ;a extensao .par ao nome do arquivo
                mov al , '.'
                mov [bx], al
                inc bx
                mov al, 'p'
                mov [bx], al
                inc bx
                mov al, 'a'
                mov [bx], al
                inc bx
                mov al, 'r'
                mov [bx], al
                inc bx
                mov al, 0h
                mov [bx], al
                pop ax
                pop cx

                ret
adicionaExtensao endp

;printa o erro que esta na variavel erro
printaErro proc near
        lea bx, stringErro
        call printf_s
        mov ax, erro
        lea bx, stringErroCod
        call sprintf_w
        lea bx, stringErroCod
        call printf_s
        call pulaLinha
        ret
printaErro endp


;conversao de numero de 16bits para string
;codigo retirado dos slides
;entra numero em ax
;entra em bx o endereço pro string de saida
sprintf_w	proc	near

;void sprintf_w(char *string, WORD n) {
	mov		sw_n,ax

;	k=5;
	mov		cx,5
	
;	m=10000;
	mov		sw_m,10000
	
;	f=0;
	mov		sw_f,0
	
;	do {
sw_do:

;		quociente = n / m : resto = n % m;	// Usar instru��o DIV
	mov		dx,0
	mov		ax,sw_n
	div		sw_m
	
;		if (quociente || f) {
;			*string++ = quociente+'0'
;			f = 1;
;		}
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
	
;		n = resto;
	mov		sw_n,dx
	
;		m = m/10;
	mov		dx,0
	mov		ax,sw_m
	mov		bp,10
	div		bp
	mov		sw_m,ax
	
;		--k;
	dec		cx
	
;	} while(k);
	cmp		cx,0
	jnz		sw_do

;	if (!f)
;		*string++ = '0';
	cmp		sw_f,0
	jnz		sw_continua2
	mov		[bx],'0'
	inc		bx
sw_continua2:


;	*string = '\0';
	mov		byte ptr[bx],0
		
;}
	ret
		
sprintf_w	endp

;recebe o endereco do string em bx
colocaExtensaoSaida proc near
                        push ax
procuraBarraZero1: 
                cmp BYTE PTR [bx], 0h
                je achouBarraZero1
                inc bx
                jmp procuraBarraZero1
achouBarraZero1: ;quando achar o '\0', adiciona 
                ;a extensao .par ao nome do arquivo
                mov al , '.'
                mov [bx], al
                inc bx
                mov al, 'r'
                mov [bx], al
                inc bx
                mov al, 'e'
                mov [bx], al
                inc bx
                mov al, 'l'
                mov [bx], al
                inc bx
                mov al, 0h
                mov [bx], al
                pop ax
                ret
colocaExtensaoSaida endp


;recebe o endereco do string em bx
trocaExtensao proc near
        push ax
        mov ah, tamanhoNomeArquivo
testaTamanho:
        cmp ah, 4 ;se ax for 3, significa que resta os caracteres par'\0' no array
        je colocaRel
        inc bx
        dec ah
        jmp testaTamanho

colocaRel:
        mov al, 'r' ;coloca o r no string, no lugar do p
        mov [bx], al
        inc bx
        mov al, 'e'
        mov [bx], al
        inc bx
        mov al, 'l'
        mov [bx], al
        inc bx
        mov al, 0
        mov [bx], al
        pop ax
        ret
trocaExtensao endp


;DESENHA UM RETANGULO
;recebe em al a cor da linha
;cx o x de inicio
;dx o y de inicio
;recebem em TamanhoLadoH o tamanho dos lados horizontais
;e em tamanhoLadoV o tamanho dos lados verticais
retangulo proc near
    push bx
    ;salva os parametros de entrada
    mov bx, tamanhoLadoH
    mov tamanho, bx
    mov xInicio, cx
    mov yInicio, dx
    mov corRet, al

    call drawLineH ;desenha a linha superior horizontal

    mov bx, tamanhoLadoV
    mov tamanho, bx
    mov cx, xInicio
    mov dx, yInicio
    mov al, corRet
    call drawLineV ;desenha a linha vertical a esquerda

    mov bx, tamanhoLadoV
    mov tamanho, bx
    mov cx, xInicio
    mov dx, yInicio
    mov al, corRet
    add cx, tamanhoLadoH
    call drawLineV ;desenha a linha vertical a direita

    mov bx, tamanhoLadoH
    mov tamanho, bx
    mov cx, xInicio
    mov dx, yInicio
    mov al, corRet
    add dx, tamanhoLadoV
    call drawLineH ;desenha a linha hotizonal inferior
    pop bx
    ret
retangulo endp


;recebe o string em bx ponteiro para o string de origem
;saida em AX
;retirado dos slides
atoi	proc near

		; A = 0;
		mov		ax,0
		
atoi_2:
		; while (*S!='\0') {
		cmp		byte ptr[bx], 0
		jz		atoi_1

		; 	A = 10 * A
		mov		cx,10
		mul		cx

		; 	A = A + *S
		mov		ch,0
		mov		cl,[bx]
		add		ax,cx

		; 	A = A - '0'
		sub		ax,'0'

		; 	++S
		inc		bx
		
		;}
		jmp		atoi_2

atoi_1:
		; return
		ret

atoi	endp

;seta o cursor na posicao dada em
;dl a posicao x
;dh a posicao y

setCursor proc near
    mov bh, 0
    mov ax, 0
    mov ah, 02
    int 10h
    ret

setCursor endp

;desenha um quadrado com borda branca e cor passada por al
;recebe em al a cor da linha
;cx o x de inicio
;dx o y de inicio
;recebem em TamanhoLadoH o tamanho dos lados horizontais
;e em tamanhoLadoV o tamanho dos lados verticais
quadradoCol proc near
    push bx
    mov xInicioQuad, cx
    mov yInicioQuad, dx
    mov corQuad, al
    mov al, 0fh ;sempre desenha um quadrado com borda branca
    call retangulo
    dec tamanhoLadoH ;altera para que as linhas sejam desenhadas com 22 pixels
     ;para a borda ficar à mostra
    inc xInicioQuad
alteraTamanho:
    ;altera a altura das linhas que pintarao o quadrado
    inc yInicioQuad

    dec tamanhoLadoV
    mov bx, tamanhoLadoV
    cmp bx, 0 ;testa se já pintou todo o quadrado
    je acabouQuadradoCol

    ;coloca os parametros para chamar a drawline
    mov bx, tamanhoLadoH
    mov tamanho, bx
    mov cx, xInicioQuad
    mov dx, yInicioQuad
    mov al, corQuad
    call drawLineH
    jmp alteraTamanho
    
    
acabouQuadradoCol:
    pop bx
    ret
quadradoCol endp


;recebe o endereço do buffer em bx
;testa se o buffer de leitura tem uma virgula
;retorna 1 em ax se tinha a virgula e 0 senao
testaVirgula proc near
    mov ah, 2
testaVirgula1:
    mov al, ','
    cmp [bx], al
    je temVirgula
    inc bx
    dec ah
    cmp ah, 0
    je saiTestaVirgula
    jmp testaVirgula1

temVirgula:
    mov ax, 1

    ret
saiTestaVirgula:
    mov ax, 0
    ret 
testaVirgula endp 

;recebe em bx o endereço do buffer
;testa se tem CR no buffer de leitura
;retorna em ax 1 se tiver CR e 0 senao
testaCR proc near
    mov ah, 2
testaCR1:
    mov al, CR
    cmp [bx], al
    je temCR
    inc bx
    dec ah
    cmp ah, 0
    je saiTestaCR
    jmp testaCR1

temCR:
    mov ax, 1
    ret

saiTestaCR:
    mov ax, 0
    ret

testaCR endp

;le ate o lf da primeira linha
;sempre le para bufferArq
;nao recebe nada de entrada
;e sempre usa como handle o handleArqPar
lePrimeiraLinha proc near
    mov ax, 0 ;vai ser o que ajusta a posicao do buffer
    mov ch, ','
leituraAltura:
    lea dx, bufferArq
    add dx, ax;atualiza a posiçao do buffer
    mov bx,handleArqPar
    call leArquivo
    lea bx , bufferArq ;testa se o caractere lido é ','
    add bx, ax
    cmp BYTE PTR [bx], ch
    je achouVirgula
    inc ax ;ajusta a posicao do buffer
    jmp leituraAltura

achouVirgula:
    mov [bx], BYTE PTR 0;apaga a virgula lida
    lea bx, bufferArq
    call atoi ;converte o ASCII para decimal
    mov altura, ax;armazena em altura a altura encontrada no arquivo 
    lea bx, bufferArq
    mov al, 10
    call zeraArray ;zera o array buffer pro arquivo
    jmp testaLargura

testaLargura:
    mov ax, 0
    mov ch, CR
leituraLargura:
    lea dx, bufferArq
    add dx, ax ;atualiza a posicao do buffer
    mov bx, handleArqPar
    call leArquivo
    lea bx, bufferArq ;testa se o caractere lido é CR
    add bx, ax
    cmp BYTE PTR [bx], ch
    je achouCR
    inc ax
    jmp leituraLargura

achouCR:
    mov [bx], BYTE PTR 0 ;apaga o CR do buffer
    lea bx, bufferArq
    call atoi
    mov largura, ax ;salva o valor da largura em largura
    
    lea dx, bufferArq
    mov bx, handleArqPar
    call leArquivo
    ;le o LF para pular de linha
    lea bx, bufferArq
    mov al, 10
    call zeraArray ;zera o buffer
    call calcTamanho
    ret


lePrimeiraLinha endp

;dx: endereco pro buffer
;bx: o handle do arquivo
;LargurTemp: largura
leCores proc near
    mov handleTemp, bx
    mov endTemp, dx
    mov ax, 0
    mov larguraTemp, ax
testaLarguraLida:
    mov ax, larguraTemp
    cmp ax, largura ;testa se toda a linha ja foi lida
    je leCRLF

    ;le a cor
    mov dx, endTemp
    mov bx, handleTemp
    call leArquivo ;le um byte
    
    ;compara qual cor foi lida
    mov bx, endTemp
    mov al, BYTE PTR [bx] ;coloca em al o byte lido
    
    cmp al, pretoAsc
    je soma1Preto

    cmp al, azulAsc
    je soma1Azul

    cmp al, verdeAsc
    je soma1Verde

    cmp al, cianoAsc
    je soma1Ciano

    cmp al, vermelhoAsc
    je soma1Vermelho
    
    cmp al, magentaAsc
    je soma1Magenta

    cmp al, marromAsc
    je soma1Marrom

    cmp al, cinzaClaroAsc
    je soma1CinzaClaro

    cmp al, cinzaEscuroAsc
    je soma1CinzaEscuro

    cmp al, azulClaroAsc
    je soma1AzulClaro

    cmp al, verdeClaroAsc
    je soma1VerdeClaro

    cmp al, verdeClaroAscMaiusc
    je soma1VerdeClaro
    
    cmp al, cianoClaroAsc
    je soma1CianoClaro

    cmp al, cianoClaroAscMaiusc
    je soma1CianoClaro

    cmp al, vermelhoClaroAsc
    je soma1VermelhoClaro

    cmp al, vermelhoClaroAscMaiusc
    je soma1VermelhoClaro

    cmp al, magentaClaroAsc
    je soma1MagentaClaro

    cmp al, magentaClaroAscMaiusc
    je soma1MagentaClaro

    cmp al, amareloAsc
    je soma1Amarelo

    cmp al, amareloAscMaiusc
    je soma1Amarelo



soma1Amarelo:
    inc totAmarelo
    mov al, amarelo
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1Azul:
    inc totAzul
    mov al, azul
    mov cx, larguraTemp
    mov dx,  alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida
       
soma1AzulClaro:
    inc totAzulClaro
    mov al, azulClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida


soma1Ciano:
    inc totCiano
    mov al, ciano
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1CianoClaro:
    inc totCianoClaro
    mov al, cianoClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida
     
soma1CinzaClaro:
    inc totCinzaClaro
    mov al, cinzaClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida
  
soma1CinzaEscuro:
    inc totCinzaEscuro
    mov al, cinzaEscuro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida
    
soma1Magenta:
    inc totMagenta
    mov al, magenta
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida
    
soma1MagentaClaro:
    inc totMagentaClaro
    mov al, magentaClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1Marrom:
    inc totMarrom
    mov al, marrom
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1Preto:
    inc totPreto
    mov al, preto
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1Verde:
    inc totVerde
    mov al, verde
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1VerdeClaro:
    inc totVerdeClaro
    mov al, verdeClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1Vermelho:
    inc totVermelho
    mov al, vermelho
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida

soma1VermelhoClaro:
    inc totVermelhoClaro
    mov al, vermelhoClaro
    mov cx, larguraTemp
    mov dx, alturaTemp
    call ajeitaPosicaoQuad ;posiciona o quadrado no local adequado
    inc larguraTemp
    jmp testaLarguraLida


leCRLF:
    mov dx, endTemp
    mov bx, handleTemp
    call leArquivo ;le um byte
    mov dx, endTemp
    mov bx, handleTemp
    call leArquivo ;le um byte
    ret
leCores endp

;recebe em al a cor
;em cx a larguraAtual
;em dx a alturaAtual
ajeitaPosicaoQuad proc near
    mov alturaTemp1, dx;salva a altura atual em uma var temporaria pra poder zerar dx
    mov bx, tamanhoQuad
    mov tamanhoLadoH, bx
    mov tamanhoLadoV, bx
    mov corTemp, al
    mov dx, 0;zera a parte mais significativa dos 32bits
    mov ax, tamanhoQuad ;coloca pra multiplicar pelo tamanho do quadrado   
    imul cx
    mov resultadoMult, ax
    mov cx, resultadoMult ;coloca o resultado em cx
    add cx, inicioParedeX;altera o x para ser no comeco do retangulo de desenho
    mov ax, tamanhoQuad
    mov dx, 0
    imul alturaTemp1
    mov resultadoMult, ax
    mov dx, resultadoMult ;coloca o resultado em dx
    add dx, inicioParedeY; altera o y para ser no comeco do retangulo de desenho
    mov al, corTemp ;coloca a cor em al
    call quadradoCol
    ret
ajeitaPosicaoQuad endp 


printaTotalizadores proc near
    ;Escreve o total de quadrados pretos da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadPreto
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totPreto
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos pretos pra ascii
    lea dx, strPreto
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo

    lea bx, totCor
    call printf_s

;Escreve o total de quadrados azuis da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadAzul
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totAzul
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos azuis pra ascii
    lea dx, strAzul
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados verdes da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadVerde
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totVerde
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos verdes pra ascii
    lea dx, strVerde
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

;Escreve o total de quadrados cianos da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadCiano
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totCiano
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos cianos pra ascii
    lea dx, strCiano
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

;Escreve o total de quadrados vermelhos da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadVermelho
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totVermelho
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos vermelhos pra ascii
    lea dx, strVermelho
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados magenta da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadMagenta
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totMagenta
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos magenta pra ascii
    lea dx, strMagenta
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s


    ;Escreve o total de quadrados marrons da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadMarrom
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totMarrom
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos marrons pra ascii
    lea dx, strMarrom
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados cinza claro da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadCinzaClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totCinzaClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos cinza claro pra ascii
    lea dx, strCinzaClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados cinza escuro da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadCinzaEscuro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totCinzaEscuro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos cinza escuro pra ascii
    lea dx, strCinzaEscuro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados azuis claros da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadAzulClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totAzulClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos azuis claros pra ascii
    lea dx, strAzulClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados verdes claros da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadVerdeClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totVerdeClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos verdes claros pra ascii
    lea dx, strVerdeClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados ciano claro da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadCianoClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totCianoClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos ciano claros pra ascii
    lea dx, strCianoClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados vermelho claros da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadVermelhoClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totVermelhoClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos vermelho claros pra ascii
    lea dx, strVerdeClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados magenta claros da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadMagentaClaro
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totMagentaClaro
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos magenta claros pra ascii
    lea dx, strMagentaClaro
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ;Escreve o total de quadrados amarelos da parede
    mov dh, posYTextLegenda
    mov dl, posXTextQuadAmarelo
    call setCursor ;coloca o cursor na posicao correta
    mov ax, totAmarelo
    lea bx, totCor
    call sprintf_w ;converte o total de ladrilhos amarelos pra ascii
    lea dx, strAmarelo
    call escreveTotalizadores ;coloca no arquivo
    lea dx, crlf
    mov bx, handleArqRel ;coloca o crlf para pular a linha
    call escreveArquivo
    lea bx, totCor
    call printf_s

    ret
printaTotalizadores endp
;calcula o tamanho que o quadrado pode ter
calcTamanho proc near
    push ax
    push bx
    mov ax, alturaDisp
    mov bx,  altura
    cmp bx, 0
    je testaLargura0
    mov dx, 0 ;zera parte mais significativa dos 32bits
    idiv bx;divide 360(altura max disponivel para desenho) pelo numero de linhas
    mov resTmp, ax
    jmp testaLargura1
testaLargura0:
    mov ax, larguraDisp
    mov bx, largura
    cmp bx, 0
    je move24
    mov dx, 0 ;zera parte mais significativa dos 32bits
    idiv bx;divide 624(largura max disponivel pra desenho) pelo numero de colunas
testaLargura1:
    mov ax, larguraDisp
    mov bx, largura
    cmp bx, 0
    je moveAlt
    mov dx, 0 ;zera parte mais significativa dos 32bits
    idiv bx;divide 624(largura max disponivel pra desenho) pelo numero de colunas

cmpLargAlt:
    cmp ax, resTmp
    jbe moveLarg
    jmp moveAlt
fimCalcTamanho:
    pop bx
    pop ax
    ret

moveAlt:
    mov ax, resTmp
    mov tamanhoQuad, ax
    
    jmp fimCalcTamanho
moveLarg:
    mov tamanhoQuad, ax
    jmp fimCalcTamanho

move24:
    mov ax, 24
    mov tamanhoQuad, ax
    jmp fimCalcTamanho
calcTamanho endp
;recebe o endereço do buffer por dx
leTeclado proc near
    mov ah, 0ah
    int 21h
    ret
leTeclado endp
;espera uma tecla e, quando pressionada, volta pro inicio do programa
esperaTecla proc near
    
    lea bx, bufferTeclado
    mov al, tamanhoBuffer
    call limpaTecBuffer ;limpa o buffer de teclado
    lea dx, bufferTeclado
    call leTeclado
    ret
esperaTecla endp

;recebe em dx, a string com o nome da cor
;recebe por totCor o total de ladrilhos daquela cor
;sempre usa o handleArqRel
escreveTotalizadores proc near
    ;escreve o nome da cor e o total de ladrilhos
    mov bx, handleArqRel
    call escreveArquivo
    lea dx, totCor
    mov bx, handleArqRel ;escreve o numero de ladrilhos
    call escreveArquivo
    ret
escreveTotalizadores endp
end
