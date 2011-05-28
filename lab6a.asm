name string_compare
page 93
title check whether two strings are equal or not
.model small
.stack
.data
        str1 db 50 dup ('$')
        str2 db 50 dup ('$')
        c1 db 10,13,"enter string1:$"
        c2 db 10,13,"enter string2:$"
        strlen1 db 10,13," the length of string 1 is:","$"
        strlen2 db 10,13," the length of string 2 is:","$"
        len1 db ?
        len2 db ?
        equal db 10,13,"the string are equal $"
        noteq db 10,13,"the strings are not equal $"
.code
        mov ax,@data
        mov ds,ax
        mov es,ax
        lea dx,c1
        mov ah,09h
        int 21h
        xor cx,cx
        lea si,str1
lp1:    mov ah,01h
        int 21h
        cmp al,0dh
        je nxt
        inc cl
        mov [si],al
        inc si
        jmp lp1
nxt:    mov len1,cl
        lea dx,c2
        mov ah,09h
        int 21h
        xor cx,cx
        lea si,str2
lp2:    mov ah,01h
        int 21h
        cmp al,0dh
        je nxt1
        inc cl
        mov [si],al
        inc si
        jmp lp2
nxt1:   mov len2,cl
        mov cl,len1
        mov bl,len2
        cmp cl,bl
        jnz note
        cld
        xor cx,cx
        mov cl,len1
        lea si,str1
        lea di,str2
        repe cmpsb
        jnz note
        lea dx,equal
        mov ah,09h
        int 21h
        jmp leg
note:   lea dx,noteq
        mov ah,09h
        int 21h
leg:    lea dx,strlen1
        mov ah,09h
        int 21h
        mov dl,len1
        cmp dl,09h
        jle add1
        sub dl,0ah
        add al,41h
        jmp printno
add1:   add dl,30h
printno:mov ah,02h
        int 21h
        lea dx,strlen2
        mov ah,09h
        int 21h
        mov dl,len2
        cmp dl,09h
        jle add2
        sub dl,0ah
        add dl,41h
        jmp printno1
add2:   add dl,30h
printno1:mov ah,02h
        int 21h
false:  mov ah,4ch
        int 21h
end

    

