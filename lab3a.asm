name bubble_sort
page 27
title sort n number using bubble sort
.model small
.stack
.data
        a db 23h,45h,25h,58h,19h
        size1 dw ($-a)
.code
        mov ax,@data
        mov ds,ax
        mov bx,size1
        dec bx
outloop:mov cx,bx
        mov si,00h
inloop: mov al,a[si]
        inc si
        cmp al,a[si]
        jb next
        xchg al,a[si]
        mov a[si-1],al
next:   loop inloop
        dec bx
        jnz outloop
        int 3
        align 16
end

