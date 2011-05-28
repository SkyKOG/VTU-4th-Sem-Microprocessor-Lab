name search
page
title search a substring in a main string
.model small
.stack
.data
        str db "love is god,god is love"
        con1 dw $-str
        sub_str db "lov"
        con2 dw $-sub_str
        msg1 db "string found $"
        msg2 db "string not found $"
.code
        mov ax,@data
        mov ds,ax
        mov es,ax
        mov cx,con1
        mov bx,con2
        lea si,sub_str
        lea di,str
        cld
next:   mov al,[si]
        repnz scasb
        inc si
        mov dx,cx
        dec bx
        sub cx,bx
        jb stop
        mov cx,bx
        repz cmpsb
        jnz not_found
        lea dx,msg1
        mov ah,09h
        int 21h
end_all:mov ah,4ch
        int 21h
stop:   lea dx,msg2
        mov ah,09h
        int 21h
        jmp end_all
not_found:mov cx,dx
        lea si,sub_str
        mov bx,con2
        jmp next
end




