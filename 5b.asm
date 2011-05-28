name char_rolling
page 83
title display 12 character in roling fashion on 7 segment display

initds  macro
        mov ax,@data
        mov ds,ax
endm

init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
endm

outpb macro
        mov dx,pb
        out dx,al
endm

outpc macro
        mov dx,pc
        out dx,al
endm

.model small
.stack
.data
        pb equ 0c401h
        pc equ 0c402h
        cr equ 0c403h
        cw db 80h
        m1 db 10,13,"press any key to exit $"
        ssc db 80h,0c0h,80h,92h,0ffh,0cfh,88h,92h,80h,0c0h,80h,82h

.code
        initds
        init8255
        lea dx,m1
        mov ah,9
        int 21h

start:  lea si,ssc
        mov cx,12
next_char: mov al,[si]
        call disp_char
        call delay
        call kbhit
        inc si
        loop next_char
        jmp start

kbhit proc
        mov ah,1
        int 16h
        jnz exit
        ret
exit:   mov ah,4ch
        int 21h
kbhit endp


disp_char proc
        mov bl,8
nxtbit: rol al,1
        outpb
        push ax
        mov al,00h
        outpc
        mov al,11h
        outpc
        pop ax
        dec bl
        jnz nxtbit
        ret
disp_char endp


delay proc
        mov bx,07ffh
b2:     mov di,0ffffh
b1:     dec di
        jnz b1
        dec bx
        jnz b2
        ret
delay endp
end

