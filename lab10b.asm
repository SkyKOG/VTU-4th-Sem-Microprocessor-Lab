name key_closure
page 104
title scan 3*8 keypad for key closure and display on screen

initds macro
        mov ax,@data
        mov ds,ax
endm

init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
endm

disp_msg macro msg
        lea dx,msg
        mov ah,9
        int 21h
endm

outpc macro
        mov dx,pc
        out dx,al
endm

inpa macro
        mov dx,pa
        in al,dx
endm

.model small
.stack
.data
        pa equ 120h
        pb equ 121h
        pc equ 122h
        cr equ 123h
        m1 db 10,13,10,13,"entered key is : $"
        m2 db 10,13,10,13,"row number is :$"
        m3 db 10,13,10,13,"column number is:$"
        m4 db 10,13,10,13,"press 'C' from system keyboard to continue $"
        m5 db 10,13,10,13,"press any key from KB_INTERFACE $"
        row db ?
        col db ?
        cw db 90h
.code
        initds
        init8255
        disp_msg m5
start:  mov al,80h
        mov row,1
        mov col,1
        mov ch,0
        mov bl,3
nextrow:rol al,1
        mov bh,al
        outpc
        mov cl,8
        inpa
nextcol:ror al,1
        jc display
        inc ch
        inc col
        dec cl
        jnz nextcol
        mov col,1
        inc row
        mov al,bh
        dec bl
        jnz nextrow
start1: jmp start
display:disp_msg m1
        mov dl,ch
        cmp dl,0ah
        jc digit
        add dl,07h
digit:  add dl,30h
        call disp_char
        add row,30h
        add col,30h
        disp_msg m2
        mov dl,row
        call disp_char
        disp_msg m3
        mov dl,col
        call disp_char
        disp_msg m4
        mov ah,8
        int 21h
        push ax
        disp_msg m5
        pop ax
        cmp al,'c'
        jz start1
        mov ah,4ch
        int 21h

disp_char proc
        mov ah,2
        int 21h
        ret
disp_char endp
end
