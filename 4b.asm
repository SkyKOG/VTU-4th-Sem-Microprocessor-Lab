name segent_fire
page
title display FIRE and HELP on 7 segment display

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
        msg1 db 86h,0afh,0cfh,8eh
        msg2 db 8ch,0c7h,86h,89h

.code
        initds
        init8255
        lea dx,m1
        mov ah,9
        int 21h

start:  lea si,msg1
        call disp_msg
        call delay

        lea si,msg2
        call disp_msg
        call delay

        mov ah,1
        int 16h
        jz start

        mov ah,4ch
        int 21h


disp_msg proc
        mov cx,4
next_char: mov bl,8
        mov al,[si]
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
        inc si
        loop next_char
        ret
disp_msg endp


delay proc
        mov bx,01ffh
b2:     mov cx,0ffffh
b1:     loop  b1
        dec bx
        jnz b2
        ret
delay endp
end




        
