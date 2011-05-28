name stepper_motor
page
title stepper motor in left and right by N step

.model small
.stack 64
.data
.code
        mov ax,@data
        mov ds,ax
        mov al,82h
        mov dx,123h
        out dx,al
        mov al,88h
        mov cx,200
lp1:    mov dx,120h
        out dx,al
        call delay
        rol al,01
        dec cx
        jnz lp1
        mov al,88h
        mov cx,200
lp2:    mov dx,120h
        out dx,al       
        call delay
        ror al,01
        dec cx
        jnz lp2
        mov ah,4ch
        int 21h

delay proc
        push ax
        push cx
        mov ax,0cffh
lp4:    mov cx,0ffffh
lp3:    dec cx
        jnz lp3
        dec ax
        jnz lp4
        pop cx
        pop ax
        ret
delay endp
end


