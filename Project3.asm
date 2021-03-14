; Author: Wenzhuo Fan
; Date: 10/09/2020
; Description: read a value from an array, and then place this value in another 
; array with the location shifted by a certain amount.
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data 
    shift dword 3 
    input byte 5,0ah,3,6,0ch 
    output byte lengthof input dup(?)
.code
    main proc
            mov eax, 0
            mov ebx, lengthof input
            sub ebx, shift
            mov ecx, shift
            mov esi,0
            
        l1: 
            mov al, input[ebx] ;Move the value from input into al 
            mov output[esi], al ;Move the value from al into output                            
            inc esi ;Increment the input index        
            inc ebx ;Increment the output index
        loop l1
            mov ebx, shift ;This loop will iterate shift times
            mov esi, 0 ;Start writing at index 0
            mov ecx, lengthof input ;Start reading at index length - shift.  
            ;(this loop will place the 'wrapped' values)
        l2: 
            mov al, input[esi] ;Move the value from input into al 
            mov output[ebx], al ;Move the value from al into output                    
            inc esi ;Increment the input index         
            inc ebx ;Increment the output index
        loop l2
        
        invoke ExitProcess, 0
    main endp
end main