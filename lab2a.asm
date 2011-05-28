name read_disp
page 37
TITLE prog 2a
.model small
.stack 40
.data
        str db 50 dup ('$')
        msg db 10,13,'enter the string: $'
        disp db 10,13, 'display the string : $'
.code
        mov ax,@data
        mov ds,ax
        include c:\masm\read.mac
        include c:\masm\display.mac
        lea dx,msg
        mov ah,09h
        int 21h
        lea si,str
        xor cx,cx
  lp:   read
        cmp al,0dh
        jz stop
        mov [si],al
        inc si
        inc cx
        jmp lp
 stop:  lea dx,disp
        mov ah,09h
        int 21h
        lea si,str
 lp2:   mov dl,[si]
        display
        inc si
        dec cx
        jnz lp2
        mov ah,4ch
        int 21h
 end

