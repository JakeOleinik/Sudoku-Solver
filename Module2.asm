.386
PUBLIC _isSafe@16
.model flat

.code

EXTRN _UsedInRow@12 :proc
EXTRN _UsedInCol@12 :proc


_UsedInBox@16 proc
	push ebp
	mov ebp,esp
	mov edi,[ebp+8]		;grid
	;mov boxStartRow,[ebp+12]
	;mov boxStartCol,[ebp+16]	
	;mov number,[ebp+20]		;number to find
	xor EDX,EDX
	mov eax,[ebp+16]
	mov ecx,4
	mul ecx
	add EDI,EAX
	xor EDX,EDX
	mov EAX,[ebp+12]
	mov ECX,36
	mul ECX
	add EDI,EAX
	xor EAX,EAX
	mov EDX,[ebp+20]
	mov ecx,2
checkBoxOuter:
	cmp ecx,0
	jl xztOuter
	mov ebx,2
	checkBoxInner:
	cmp ebx,0
	jl xztInner
		cmp [EDI+4*EBX],EDX
			jne cont
			mov EAX,1
			jmp xztOuter
			cont:
		dec EBX
		jmp checkBoxInner
		xztInner:
		dec ECX
		add EDI,36
		jmp checkBoxOuter
		xztOuter:
	pop EBP
	ret 16
_UsedInBox@16 endp

_isSafe@16 proc
	push ebp
	mov ebp,esp
	mov edi,[ebp+8]		;grid
	;mov eax,[ebp+12]	;row num
	;mov ebx,[ebp+16]	;number to find
	mov ECX,1
;//1
	push [ebp+20]
	push [ebp+12]
	push [ebp+8]
	call _UsedInRow@12
	cmp EAX,1
	jne cont1
		mov ECX,0
		jmp xzt
	cont1:

	push [ebp+20]
	push [ebp+16]
	push [ebp+8]
	call _UsedInCol@12
	cmp EAX,1
	jne cont2
		mov ECX,0
		jmp xzt
	cont2:
	
	push [ebp+20]
	mov EAX,[ebp+16]
	mov EBX,3
	xor EDX,EDX
	div EBX
	mov EAX,[ebp+16]
	sub EAX,EDX
	push EAX
	mov EAX,[ebp+12]
	mov EBX,3
	xor EDX,EDX
	div EBX
	mov EAX,[ebp+12]
	sub EAX,EDX
	push EAX
	push [ebp+8]
	call _UsedInBox@16
	cmp EAX,1
	jne xzt
		mov ECX,0
	xzt:
	mov EAX,ECX
	pop EBP
	ret 16
_isSafe@16 endp

end