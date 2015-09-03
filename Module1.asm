.386
PUBLIC _UsedInRow@12
PUBLIC _UsedInCol@12
.model flat

.code
_UsedInRow@12 proc
	push ebp
	mov ebp,esp
	mov edi,[ebp+8]		;grid
	mov eax,[ebp+12]	;row num
	mov ebx,[ebp+16]	;number to find
	mov ecx,36
	mul ecx
	add edi,eax
	mov ecx,9
	xor EAX,EAX
checkRow:
		push ECX
		dec ECX
		cmp [EDI+ECX*4],EBX
			jne cont
			mov EAX,1
			pop ECX
			jmp xzt
			cont:
		pop ECX
		loop checkRow
		xzt:
	pop EBP
	ret 12
_UsedInRow@12 endp

_UsedInCol@12 proc
	push ebp
	mov ebp,esp
	mov edi,[ebp+8]		;grid
	mov eax,[ebp+12]	;col num
	mov ebx,[ebp+16]	;number to find
	mov ecx,4
	mul ecx
	mov EDX,EAX
	mov ecx,9
	xor EAX,EAX
checkCol:
		cmp [EDI+EDX],EBX
			jne cont
			mov EAX,1
			jmp xzt
			cont:
			add EDI,36
		loop checkCol
		xzt:
	pop EBP
	ret 12
_UsedInCol@12 endp

end