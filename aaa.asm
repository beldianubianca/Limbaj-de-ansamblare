;4. Sa se afiseze ora sistem curenta sub forma hh:mm si sa se specifice
; cu sirul 'AM' sau 'PM' daca este antemeridian sau postmeridian.

assume cs:code, ds:data
data segment
	h db ?
	hh db ?
	m db ?
	mm db ?
	mesaj db 'AM $'
	mesaj1 db 'PM $'
	mesaj2 db ':$'
	ora db ?
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah,2Ch 						;calculam timpul  (in ch=ora , in cl=minutele)
	int 21h
	
	cmp ch, 12					;comparam ora cu 12 si in functie punem PM sau AM 
	jge adaugare
	mov ah, 09h
	mov dx, offset mesaj
	int 21h
	jmp sfarsit
	adaugare:
		mov ah, 09h
		mov dx, offset mesaj1
		int 21h
		
	maiMare:
		mov al,ch
		sub al,12
		mov ah, 0
		mov bl, 10 	
		div bl
		mov dl, al
		add dl, '0'
		mov h, dl
		mov dl, ah
		add dl,'0'
		
		mov hh, dl
		mov dl, h
		mov ah, 02h
		int 21h
		
		mov dl, hh
		mov ah, 02h
		int 21h
		jmp sari
	sfarsit:
	


	mov al, ch						;punem ora in al 
	mov ah, 0
	mov bl, 10 	
	div bl
	mov dl, al
	add dl, '0'
	mov h, dl						;in h punem prima cifra din ora
	mov dl, ah
	add dl,'0'
	mov hh, dl						;hh=a doua cifra din ora
	mov dl, h
	mov ah, 02h
	int 21h
	mov dl, hh
	mov ah, 02h
	int 21h
	
	sari:
	mov ah, 09h					   ;afisam ':'
	mov dx, offset mesaj2
	int 21h
	
	
	mov al, cl					;la fel facem si cu minutele
	mov ah, 0
	mov bl, 10
	div bl
	mov dl, al
	add dl, '0'
	mov m, dl
	mov dl, ah
	add dl,'0'
	mov mm, dl
	mov dl, m
	mov ah, 02h
	int 21h
	mov dl, mm
	mov ah, 02h
	int 21h

	mov ax, 4C00h
    int 21h
code ends
end start