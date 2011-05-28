name stepper_motor
page 51
title stepper motor in clock wise direction by N step

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
.stack 64
.data
        pa equ 120h
        cr equ 123h
        step_size db 50
        cw db 80h
.code
        initds
        init8255
        mov bl,step_size
        mov al,88h
back:   outpa
        call delay
        ror al,1
        dec bl
        jnz back
        mov ah,4ch
        int 21h

delay proc
        push bx
        mov bx,01ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        pop bx
        ret
delay endp
end


