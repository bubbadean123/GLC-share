%macro write_string 2 
   mov   eax, 4
   mov   ebx, 1
   mov   ecx, %1
   mov   edx, %2
   int   80h
%endmacro
%macro read_string 2 
   mov   eax, 3
   mov   ebx, 2
   mov   ecx, %1
   mov   edx, %2
   int   80h
%endmacro
%macro clear_var 2 
   mov  eax,%2      ;number bytes to clear 
   mov  ecx,%1      ;ECX will point to the current element to clear
   loop:
   mov edx,0
   mov [ecx],edx
   add  ecx,1      ;move pointer to next element
   dec  eax        ;decrement counter
   jnz  loop        ;if counter not 0, then loop again
%endmacro