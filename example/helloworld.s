global	start

			section	.text

start:		mov		rax, 0x2000004			;syscall for write
			mov		rdi, 1					;first write syscall parameter (first is rdi register)
			mov		rsi, message			;second parameter(second param is rsi register)
			mov		rdx, 14					;third parameter(third param is rdx register) -> is determined by Unix.
			syscall							;invoke operation system routine to do write
			mov		rax, 0x2000001			;syscall for exit
			xor		rdi, rdi				;set exit code 0
			syscall							;invoke operation system routine to exit

			section	.data					; start data section
message:	dq		'Hello, World',10		; 10 == '\n' so, "Hello, World\n"
