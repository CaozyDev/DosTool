assume cs:code
code segment
install:
        mov ax,cs
        mov ds,ax
        mov si,offset start

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset ending - offset start
        cld
        rep movsb

        cli
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0
        sti

        mov ax,4c00h
        int 21h
start:
        jmp short set
        table dw offset pro0 - offset start + 200h
              dw offset pro1 - offset start + 200h
              dw offset pro2 - offset start + 200h
              dw offset pro3 - offset start + 200h

set:    mov bx,0
        mov bl,al

        mov al,ah
        mov ah,0
        cmp ax,3
        ja return
        add ax,ax
        mov si,ax
        call word ptr cs:[si+202h]

return: 
        iret

pro0:
        push ax
        push ds
        push si
        push cx

        mov ax,0b800h
        mov ds,ax
        mov si,0
        mov cx,80*25
    s0: mov byte ptr [si],' '
        add si,2
        loop s0

        pop cx
        pop si
        pop ds
        pop ax

        ret

pro1:
        push ax
        push ds
        push cx
        push si

        mov ax,0b800h
        mov ds,ax
        mov si,1
        mov cx,80*25
    s1: mov al,[si]
        and al,11111000b
        or al,bl
        mov [si],al
        add si,2
        loop s1

        pop si
        pop cx
        pop ds
        pop ax
        ret

pro2:   push ax
        push ds
        push cx
        push si

        mov ax,0b800h
        mov ds,ax
        mov si,1
        mov cx,80*25
    s2: mov al,[si]
        and al,10001000b
        push cx
        mov cl,4
        shl bl,cl
        or al,bl
        mov [si],al
        pop cx
        add si,2
        loop s2

        pop si
        pop cx
        pop ds
        pop ax
        ret

pro3:   push ax
        push ds
        push si
        push bx

        mov ax,0b800h
        mov ds,ax
        mov es,ax
        mov si,160
        mov di,0
        mov cx,24
    s3: push cx
        mov cx,160
        cld
        rep movsb
        pop cx

        loop s3

        mov si,0
        mov cx,80
    s3_1:
        mov byte ptr [160*24+si],' '
        add si,2
        loop s3_1

        pop bx
        pop si
        pop ds
        pop ax
        ret
ending:
        nop
code ends
end install