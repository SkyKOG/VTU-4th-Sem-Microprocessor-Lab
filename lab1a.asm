Name binarysearch
Title binary search
page
.model small
.stack 100
.data
        array dw 1122h,2345h,3333h,4455h,6666h
        len dw ($-array)/2
        srch equ 2345h
        sucmsg db 'element found at position : '
        result db ?, '$'
        failmsg db 'element not found $'
.code
binsrch:       mov ax,@data
                mov ds,ax
                mov bx,1
                mov dx,len
                mov cx,srch
   again:       cmp bx,dx
                ja failure
                mov ax,bx
                add ax,dx
                shr ax,1
                mov si,ax
                dec si
                add si,si
                cmp cx,array[si]
                jae bigger
                dec ax
                mov dx,ax
                jmp again
   bigger:      je success
                inc ax
                mov bx,ax
                jmp again
   success:      add al,'0'
                mov result,al
                lea dx,sucmsg
                jmp display
   failure:     lea dx,failmsg
   display:     mov ah,09h
                int 21h
                mov ah,4ch
                int 21h
                align 16
end




