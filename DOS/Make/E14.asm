assume cs:code
data segment
        db 9,'-',8,'-',7,'-',4,'-',2,'-',0,'-'
data ends
code segment
        mov ax,data
        mov ds,ax

        mov si,0
        mov di,0
        mov cx,6
    s:  mov al,[di]
        out 70h,al
        in al,71h
        mov ah,al
        push cx
        mov cl,4
        shr ah,cl
        and al,00001111b
        pop cx

        add ah,30h
        add al,30h

        mov bx,0b800h
        mov es,bx
        
        mov es:[si+160*10+30*2],ah
        mov es:[si+160*10+30*2+2],al
        mov al,[di+1]
        mov es:[si+160*10+30*2+4],al

        add si,6
        add di,2

        loop s

        mov ax,4c00h
        int 21h

code ends
end