section .data
    msg db "Hello world", 0xA  
    len equ $ - msg           


section .text
    global _start


_start:
    mov eax, 4
    mov ebx, 1 
    mov ecx, msg
    mov edx, len
    int 0x80 

    mov eax, 1
    xor ebx, ebx
    int 0x80 



;   Detailed Explanation of Each Keyword
;   Keyword	                Meaning	                    Notes
;   -------------------------------------------------------------------------------------------------------------------------
;   section .data	        Data section	            Stores initialized variables (strings, numbers, etc.)
;   db	                    Define Byte	                Allocates 1 byte per character (e.g., "Hello" = 5 bytes)
;   0xA	                    ASCII Line Feed	            Newline character in Linux (\n). DOS uses 0Dh, 0Ah (\r\n).
;   equ	                    Constant definition	        Similar to #define in C. len equ $ - msg calculates string length.
;   $	                    Current memory address	    Used to compute lengths (e.g., $ - msg = bytes from msg to now).
;   section .text	        Code section	            Contains executable instructions.
;   global _start	        Makes _start visible	    Tells the linker where the program starts.
;   _start:	                Entry point	                Like main() in C. Execution begins here.
;   mov	                    Move data	                Copies values between registers/memory (e.g., mov eax, 4).
;   eax, ebx, ecx, edx	    32-bit registers	        Used for syscalls:
;                                                           - eax = syscall number
;                                                           - ebx, ecx, edx = arguments
;   int 0x80	            Software interrupt	        Calls the Linux kernel to execute a syscall.
;   xor ebx, ebx	        Clear EBX	                Sets ebx = 0 (exit code 0 = success).



;   Syscalls Used
;   Syscall	        EAX	    EBX	                            ECX	                EDX	     Purpose
;   ------------------------------------------------------------------------------------------------------------
;   sys_write	    4	    File descriptor (1 = stdout)	Pointer to string	Length	 Prints a message
;   sys_exit	    1	    Exit code (0 = success)	        -	                -	     Terminates the program



;   General-Purpose Registers (32-bit)
;   Register    Extended Name	        Primary Use	                                    Key Details
;   -------------------------------------------------------------------------------------------------
;   EAX	        Accumulator Register	Arithmetic operations, function return values	- Stores results of multiplication/division
;                                                                                       - Syscall number in Linux (int 0x80)
;   EBX	        Base Register	        Data pointer (memory addressing)	            - Often used as base address for arrays/structures
;                                                                                       - Preserved across function calls
;   ECX	        Counter Register	    Loop counters (e.g., rep instructions)	        - Automatically decrements in loop instructions
;                                                                                       - Used for string operations
;   EDX	        Data Register	        Secondary I/O for operations (extends EAX)	    - Stores remainder in division
;                                                                                       - Upper 32 bits in 64-bit multiplicati