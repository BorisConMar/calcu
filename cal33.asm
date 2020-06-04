page    65,132
title         operaciones_mult_div_con interfaz_grafica


;------------------------------------------------------------------
;                           Segmento de pila
;                           ----------------
pilaseg       segment para stack 'stack'
              dw      32   dup(?)
pilaseg       ends
;------------------------------------------------------------------
;                           Segmento de datos
;                           -----------------
;graficamos caracter por caracter la calculadora en la pantalla
datoseg       segment para 'data'
          
  interfaz         db      5 dup(20h),201,47 dup(205),187,13,10
				   db      5 dup(20h),186,42 dup(20h),'SALIR',186,13,10
				   db      5 dup(20h),186,20h,201,43 dup(205),187,20h,186,13,10
				   db      5 dup(20h),186,20h,186,43 dup(20h),186,20h,186,13,10
				   db      5 dup(20h),186,20h,186,43 dup(20h),186,20h,186,13,10
				   db      5 dup(20h),186,20h,186,43 dup(20h),186,20h,186,13,10
				   db      5 dup(20h),186,20h,186,43 dup(20h),186,20h,186,13,10
				   db      5 dup(20h),186,20h,186,43 dup(20h),186,20h,186,13,10
				   db      5 dup(20h),186,20h,200,43 dup(205),188,20h,186,13,10
				   ;db      5 dup(20h),186,47 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(201,205,205,205,187,20h),20 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),186,20h,31h,20h,186,20h,186,20h,32h,20h,186,20h,186,20h,33h,20h,186,20h,186,41h,4Eh,53h,186,20h,20 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(200,205,205,205,188,20h),20 dup(20h),186,13,10
				   ;db      5 dup(20h),186,47 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(201,205,205,205,187,20h),201,18 dup(205),187,186,13,10
				   db      5 dup(20h),186,3 dup(20h),186,20h,34h,20h,186,20h,186,20h,35h,20h,186,20h,186,20h,36h,20h,186,20h,186,20h,2ah,20h,186,20h,186,18 dup(20h),186,186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(200,205,205,205,188,20h),186,18 dup(20h),186,186,13,10	
				   ;db      5 dup(20h),186,47 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(201,205,205,205,187,20h),186,18 dup(20h),186,186,13,10
				   db      5 dup(20h),186,3 dup(20h),186,20h,37h,20h,186,20h,186,20h,38h,20h,186,20h,186,20h,39h,20h,186,20h,186,20h,2fh,20h,186,20h,186,18 dup(20h),186,186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(200,205,205,205,188,20h),200,18 dup(205),188,186,13,10		
				   ;db      5 dup(20h),186,47 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(201,205,205,205,187,20h),20 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),186,20h,43h,20h,186,20h,186,20h,30h,20h,186,20h,186,20h,3dh,20h,186,20h,186,20h,20h,20h,186,21 dup(20h),186,13,10
				   db      5 dup(20h),186,3 dup(20h),4 dup(200,205,205,205,188,20h),20 dup(20h),186,13,10		
				   db      5 dup(20h),200,47 dup(205),188,13,10,'$'	
       ;lonu1	   dw      061fh
	   fila        db      0
	   columna     db      0 
	   pohora        dw      ?         ;Posicion Hor. del raton
       povera        dw      ?         ;Posicion Ver. del raton
       esra          dw      ?         ;Estado del raton

       x1            db      ?         ;definici¢n
       y1            db      ?         ;de la zona
       x2            db      ?         ;de un
       y2            db      ?         ;boton
       Bandera       db      ?         ;si Bandera=1 raton sobre boton
	   menu2         db      "prueba 2$"
	   botonesascii  db      '123','a','456','*','789','/',08h,'0',0dh,02h   
	   aux           db      0,'$'         ;boton
	   aux2          dw      botonesascii 
;------------------------------------------------------------------
       datoseg       ends
	   codigoseg     segment para 'code'

;                           programa principal
;                           ------------------
;------------------------------------------------------------------
programa      proc    far
              assume  ss:pilaseg,ds:datoseg,cs:codigoseg,es:datoseg
              push    ds
              sub     ax,ax
              push    ax
              mov     ax,datoseg
              mov     ds,ax
              mov     es,ax
;------------------------------------------------------------------
              call    BoPan      ;borramos pantalla
			  call    Bopan1
			  call    Bopan2
			  call    Bopan3
;graficamos la calculadora
              lea     dx,interfaz    ;menu1 contiene a la calculadora en forma de cadena de carac.
              call    interfaz_u
			  
			  call    IniRaton
              call    ZoDeRaton
              call    DeCuRaton
			  ;zona de boton
salir:			  
	          mov     x1,9    ;;limite columna          ;Boton2
              mov     y1,9    ;;;limite fila
              mov     x2,13
              mov     y2,12
              mov     Bandera,0
              call    ZoBoton
              cmp     Bandera,1
              jne     salir
              call    Boton2
              			  
;************************verifica_boton*************
    salir2:  
	          lea  si,botonesascii
			  mov  cx,4
              mov  y1,9			  
	bot2:	  push cx
			  mov  cx,4
	    	  mov  x1,9
	bot1:
      		  mov   Bandera,0
			  call  ZoBoton
              cmp   Bandera,0
              je    sali4
			  mov   al,[si]
			  mov   aux,al
			  call  mensaje4
	sali4:
			  inc   si
			  mov   al,x1
	          add   al,6
              mov   x1,al 
              loop  bot1
              mov   al,y1
              add   al,3
              mov   y1,al 
	          pop   cx
			  loop  bot2	
              
			  
			  ;mov     dx,boton
              ;call    PoCur
    		  
			  call    tedo
			  ;mov 	  ah,01h  ;servicio 01h de int 21h para entrada de caracter
			  ;int     21h
			  cmp     al,255
			  jne     salir2
			  mov 	  ah,01h  ;servicio 01h de int 21h para entrada de caracter
			  int     21h
			  
			 
			 
			  mov     aux,al
			  ;inc     x1
			  ;inc     con
              
			  ; mov ah,aux
              ;cmp ah,31
              ;jne  her 			  
			  ;call mensaje
			  ;her:
			  ;cmp ah,39
			  ;je salir0
			  
			  jmp salir2
			    
salir0:
              cmp     al,1bh			  
			  call    BoPan
              ret
programa      endp
;------------------------------------------------------------------
;------------------------------------------------------------------
;                           Poner cursor
PoCur         proc
              mov     ah,2
              mov     bh,0
              int     10h
              ret
PoCur         endp
;------------------------------------------------------------------
;                      Despliega en pantalla
;                      ---------------------
Mensaje       proc
              mov     ah,9
              int     21h 
		      ;inc     lonu1	
              ret
Mensaje       endp
;------------------------------------------------------------------
;                       Borra la pantalla
;                       -----------------
BoPan         proc
              mov     ah,06
              mov     al,0
              mov     bh,7
              mov     cx,0
              mov     dx,184fh
              int     10h
              ret
BoPan         endp
;*******************************************************************
;		DIBUJA LA INTERFAZ DEL USUARIO EN MODO TEXTO
;*******************************************************************
interfaz_u	proc
		      mov		fila,0		; fila=0
		      mov		columna,0	; columna=0
		      mov       dx,0000h
			  call	    pocur		
		      lea		dx,interfaz			; pone a dx la direccion de la variable interfaz
		      mov		ah,09				; servicio que imprime un caracter por pantalla
		      int		21h					; interrupcion a usar		
		      ret
interfaz_u	endp
;------------------------------------------------------------------
;                    Inicializa driver del raton
;                    ---------------------------
IniRaton      proc
              mov     ax,0
              int     33h
              ret
IniRaton      endp
;------------------------------------------------------------------
;                  Despliega el cursor del raton
;                  -----------------------------
DeCuRaton     proc
              mov     ax,1
              int     33h
              ret
DeCuRaton     endp
;------------------------------------------------------------------
;                   Oculta el cursor del raton
;                   --------------------------
OcCuRaton     proc
              mov     ax,2
              int     33h
              ret
OcCuRaton     endp
;------------------------------------------------------------------
;              Lee la posicion y el estado del raton
;              -------------------------------------
PyERaton      proc
              mov     ax,3
              int     33h
              ret
pyERaton      endp
;------------------------------------------------------------------
;            Define la Zona de desplazamiento del raton
;            ------------------------------------------
ZoDeRaton     proc
              mov     ax,7      ;horizontal
              mov     cx,0
              mov     dx,79*8
              int     33h
              mov     ax,8      ;vertical
              mov     cx,0
              mov     dx,24*8
              int     33h
              ret
ZoDeRaton     endp
;---------------------
;------------------------------------------------------------------
;                Verifica si el raton esta sobre un boton
;                ----------------------------------------
ZoBoton       proc
              push cx
              call    PyERaton       ;Posicion y estado del raton
              mov     esra,bx        ;se guardan
              mov     pohora,cx
              mov     povera,dx
              mov     cx,3
              shr     pohora,cl      ;divide entre 8 para tener
              shr     povera,cl      ;posiciones de pantalla
              ;********************
			  mov     al,x1 
			  add     al,4
			  mov     x2,al
			  mov     al,y1 
			  add     al,2
			  mov     y2,al
              ;*****************
			  mov     ax,pohora      ;Convierte la
              xchg    ah,al          ;posicion del
              mov     bx,povera      ;raton
              mov     al,bl          ;de word a byte

              cmp     ah,x1          ;compara zona de raton
              jl      ZoBo2          ;en bytes
              cmp     ah,x2          ;para ver si esta
              jg      ZoBo2          ;sobre
              cmp     al,y1          ;el boton
              jl      ZoBo2
              cmp     al,y2
              jg      ZoBo2
              cmp     esra,1
              jne     ZoBo2
              mov     Bandera,1
              
ZoBo2:        pop cx
              ret
ZoBoton       endp

;------------------------------------------------------------------
;                           Funcion del boton2
;                           ------------------
Boton2        proc
              mov     dx,050ah
              call    PoCur
              lea     dx,menu2
              call    mensaje

              ret
Boton2        endp
;****************************************************************8
;                           Funcion del boton2
;                           ------------------
mensaje4        proc
              mov     dx,050ah
              call    PoCur
              lea     dx,aux
              mov     ah,9
              int     21h 
		      ;inc     lon
              ret
mensaje4        endp
;*****************************************************************
;------------------------------------------------------------------
BoPan2        proc
              mov     ah,06
              mov     al,0
              mov     bh,17h
              mov     cx,0207h
              mov     dx,0833h
              int     10h
              ret
BoPan2        endp
;------------------------------------------------------------------
BoPan3        proc
              mov     ah,06
              mov     al,0
              mov     bh,27h
              mov     cx,0c21h
              mov     dx,1134h
              int     10h
              ret
BoPan3        endp
;------------------------------------------------------------------
BoPan1        proc
              mov     ah,06
              mov     al,0
              mov     bh,67h
              mov     cx,0006h
              mov     dx,1435h
              int     10h
              ret
BoPan1        endp
;******************************************************************
;------------------------------------------------------------------
;                       Estado del Teclado
;                       ------------------
tedo	proc
		mov ah,0bh
		int 21h
		ret
tedo	endp
;-------------------------------------------- 
codigoseg     ends
              end     programa