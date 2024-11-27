assume cs:code
data segment
        db 'Hello, Da Duan Duan!',0
data ends
stack segment
        dw 0,0,0,0,0,0,0,0
stack ends
code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,data
        mov ds,ax
        mov si,0

        mov dh,11       ;行号
        mov dl,25       ;列号
        mov cl,2        ;颜色
        call show_str

        mov ax,4c00h
        int 21h
show_str:
        mov ax,0b800h
        mov es,ax
        mov bx,0
s:      push cx
        mov ch,0
        mov cl,[si]
        jcxz ok
        pop cx

        mov al,160
        mul dh
        mov di,ax
        push dx
        mov dh,0
        add di,dx
        add di,dx
        pop dx

        mov al,[si]
        mov byte ptr es:[di+bx],al
        inc bx
        mov byte ptr es:[di+bx],cl
        inc bx
        inc si
        jmp short s

ok:     ret

code ends

end start