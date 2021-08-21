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
			xor		rdx, rdx
			mov		al, BYTE[rdi + rcx]
			mov		dl, BYTE[rsi + rcx]
			cmp		rax, rdx
			jb		plus
			jl		minus
			je		equal

plus:
			sub		rax, rdx
			ret

minus:
			sub		rdx, rax
			mov		rax, rdx
			neg		rax
			ret
equal:
			xor		rax, rax
			ret
