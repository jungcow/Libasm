section		.text
			global	_ft_strcmp

_ft_strcmp:
			mov		rcx, 0
			jmp		loop

loop:
			cmp		BYTE[rdi + rcx], 0
			je		break
			cmp		BYTE[rsi + rcx], 0
			je		break
			mov		al, BYTE[rsi + rcx]
			cmp		BYTE[rdi + rcx], al
			jne		break
			inc		rcx
			jmp		loop

break:
			xor		rax, rax
			xor		rbx, rbx
			mov		al, BYTE[rdi + rcx]
			mov		bl, BYTE[rsi + rcx]
			cmp		rax, rbx
			jb		plus
			jl		minus
			je		equal

plus:
			sub		rax, rbx
			ret

minus:
			sub		rbx, rax
			mov		rax, rbx
			neg		rax
			ret
equal:
			xor		rax, rax
			ret
