name palindrome
page 44
title to check given string is palindrome or not
.model small
.stack 64
.data
        m1 db 10,13,"enter the string: $"
        m2 db 10,13,"the string is a palindrome $"
        m3 db 10,13,"the string is not a palindrome $"
        buff db 80
.code
start:  mov ax,@data
        mov ds,ax
        lea dx,m1
        mov ah,09h
        int 21h
        mov ah,0ah
        lea dx,buff
        int 21h
        lea bx,buff+2
        mov ch,00h
        mov cl,buff+1
        mov di,cx
        dec di
        shr cl,1
        mov si,00h
back:   mov al,[bx+di]
        mov ah,[bx+si]
        cmp al,ah
        jnz last
        dec di
        inc si
        dec cl
        jnz back
        lea dx,m2
        mov ah,09h
        int 21h
        jmp ter
last:   mov ah,09h
        mov dx,offset m3
        int 21h
ter:    mov ah,4ch
        int 21h
end

