            global      start               ; Exporting Symbols to Other Modules
            section     .text               ; text(code) section
start:      mov         rax, 0x02000004     ; set system call for write
            mov         rdi, 1              ; set first argument for write function, stdout
            mov         rsi, message        ; set second argument for wirte function, address of string to c++
            mov         rdx, 13             ; set third argument for write function, number of bytes
            syscall                         ; invoke operating system to do the write
            mov         rax, 0x02000001     ; set system call for exit
            xor         rdi, rdi            ; set exit code 0;
            syscall                         ; invoke operation system to exit
            section     .data               ; data section
message:    db          "Hello, World", 10  ; "Hello, World\n"
