section		.text

			global	_ft_strcpy

_ft_strcpy:
			mov		rcx, 0
			jmp		loop

loop:
			cmp		BYTE[rsi], 0
			je		end

			mov		ah, BYTE [rsi]
			mov		BYTE[rdi], ah

			inc		rdi
			inc		rsi
			inc		rcx

			jmp		loop

end:	
			mov		BYTE[rdi], 0
			sub		rdi, rcx
			mov		rax, rdi
			ret
