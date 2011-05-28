name half_rectifier
page
title half rectifier sine wave using a DAC

initds macro
        mov ax,@data
        mov ds,ax
endm
init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
endm
outpa macro
        mov dx,pa
        out dx,al
endm

.model small
.stack
.data
        pa equ 120h
        pb equ 121h
        cr equ 123h
        cw db 82h
        table db 96h,0abh,0c0h,0d2h,0e2h,0eeh,0f8h,0feh,0ffh
              db 0feh,0f8h,0eeh,0e2h,0d2h,0c0h,0abh,96h
        msg db 10,13,"press any key to exit $"
.code
        initds
        init8255
        lea dx,msg
        mov ah,9
        int 21h
start:  mov cx,11h
        lea si,table
back:   mov al,[si]
        outpa
        call delay
        inc si
        loop back
        call toff
        mov ah,1
        int 16h
        jz start
        mov ah,4ch
        int 21h

delay proc
        mov bx,0ffffh
l2:     dec bx
        jnz l2
        ret
delay endp

toff proc
        mov cx,09fffh
b1:     loop b1
        ret
toff endp
end


