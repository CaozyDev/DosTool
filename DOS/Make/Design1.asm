assume cs:codesg,ds:data,es:table
data segment
        db '1975', '1976', '1977', '1978', '1979', '1980', '1981'
        db '1982', '1983', '1984', '1985', '1986', '1987', '1988'
        db '1989', '1990', '1991', '1992', '1993', '1994', '1995'

        dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479
        dd 140417, 197514, 345980, 590827, 803530, 1183000, 1843000
        dd 2759000, 3753000, 4649000, 5937000

        dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258
        dw 2793, 4037, 5635, 8226, 11542, 14430, 15257, 17800
data ends

table segment
        db 21 dup ('year summ ne ?? ')
table ends

monitor segment
    db 21 dup ('year numbers human average')
monitor ends

codesg segment
start:
        mov ax,data
        mov ds,ax

        mov ax,table
        mov es,ax

        mov bx,0
        mov si,0
        mov cx,21
    s:  mov ax,[si]
        mov es:[bx+0],ax
        mov ax,[si+1]
        mov es:[bx+1],ax
        mov ax,[si+2]
        mov es:[bx+2],ax
        mov ax,[si+3]
        mov es:[bx+3],ax
        add si,4
        add bx,16
        loop s

        mov bx,0
        mov si,0
        mov cx,21
    s0: mov ax,[84+si+2]
        mov es:[bx+5],ax
        mov ax,[84+si]
        mov es:[bx+7],ax
        add si,4
        add bx,16
        loop s0

        mov bx,0
        mov si,0
        mov cx,21
    s1: mov ax,[168+si]
        mov word ptr es:[bx+10],ax
        add bx,16
        add si,2
        loop s1

        mov si,0
        mov cx,21
    s2: mov ax,es:[si+5]
        mov dx,ax
        mov ax,es:[si+7]
        mov bx,es:[si+10]
        div bx
        mov es:[si+13],ax
        add si,16
        loop s2

        mov ax,monitor
        mov es,ax

        mov ax,table
        mov ds,ax

        mov cx,21
        mov bx,0
    s3: mov ax,[bx+5]
        mov dx,[bx+7]
        mov bp,5
        call to_str
        loop s3



        mov ax,4c00h
        int 21h

to_str: push ax
        push bx
        push cx
        push dx
        push si
        push di     ;寄存器入栈

        mov si,0
    t0: mov bx,10
        mov di,dx
        mov dx,0
        div bx
        mov cx,dx
        jcxz t1
        inc si
        push ax
        jmp short t0

    t1: mov ax,di
        mov dx,0
        mov bx,10
        div bx
        mov cx,dx
        jcxz ok
        inc si
        push ax
        jmp short t1

    ok: mov di,0
        mov cx,si
    t2: pop ax
        mov es:[bp+di],AL
        inc di
        loop t2
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret

codesg ends
end start