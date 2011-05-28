name elevator
page 86
title drive a elevator from ground to top and vice versa

outpa macro
        mov dx,pa
        out dx,al
endm

inpb macro
        mov dx,pb
        in al,dx
endm
.model small
.stack 64
.data
        pa equ 120h
        pb equ 121h
        cr equ 123h
        msg db 10,13,"press any key to exit $"
        floor db 00h,03h,06h,09h,0e0h,0d3h,0b6h,79h
.code
        mov ax,@data
        mov ds,ax
        mov al,82h
        mov dx,cr
        out dx,al
        lea dx,msg
        mov ah,9
        int 21h
        mov bl,0
loop1:  mov al,bl
        or al,0f0h
        outpa
        lea si,floor
loop2:  call kbhit
        inpb
        or al,0f0h
        mov cl,al
        sub al,0ffh
        jz loop2
loop3:  mov al,cl
        ror al,1
        mov cl,al
        jnc decide
        inc si
        jmp loop3
decide: call delay
        mov al,[si]
        sub al,bl
        js down
        jz reset
up:     inc bl
        mov al,bl
        or al,0f0h
        outpa
        jmp decide
down:   dec bl
        mov al,bl
        or al,0f0h
        outpa
        jmp decide
reset:  add si,4
        mov al,[si]
        outpa
        jmp loop1
kbhit:  mov ah,1
        int 16h
        jnz exit
        ret
exit:   mov ah,4ch
        int 21h

delay proc
        push cx
        push bx
        mov bx,05ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        pop bx
        pop cx
        ret
delay endp
end
    




