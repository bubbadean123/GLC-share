%include "macros.asm"
section .data ;Data segment
   userMsg db 'Please enter text up to 255 characters: ' ;Ask the user to enter a number
   lenUserMsg equ $-userMsg ;The length of the message
   dispMsg db 'You have entered: '
   lenDispMsg equ $-dispMsg                 

section .bss ;Uninitialized data
   text resb 256
	
section .text ;Code Segment
   global _start
	
_start: ;User prompt
    write_string userMsg,lenUserMsg

   ;Read and store the user input
   read_string text,255
	
   ;Output the message 'You have entered: '
   write_string dispMsg,lenDispMsg 

   ;Output the text entered
   write_string text,255
   ;clear the text
   clear_var text,256
   jmp _start