
assume cs:code
code segment
copy:
        mov ax,cx
        mov ds,ax
        mov si,offset start

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset ending - offset start
        cld
        rep movsb

        mov ax,0
        mov ds,ax

        mov word ptr ds:[7ch*4+2],0
        mov word ptr ds:[7ch*4],200h
        
        mov ax,4c00h
        int 21h
start:
        cmp ah,0
        je read
        cmp ah,1
        je write

        iret
read:   mov ah,2        ;读扇区
        mov al,1        ;读取的扇区数

        call caculator

        int 13h

        mov ax,4c00h
        int 21h

write:  mov ah,3        ;写扇区
        mov al,1        ;写入的扇区数

        call caculator

        int 13h

        mov ax,4c00h
        int 21h

caculator:
        push ax
        push bx

        mov ax,dx
        mov dx,0
        mov bx,1440
        div bx
        mov ah,0
        mov dh,al       ;磁头号

        mov ax,dx
        mov ah,18
        div ah
        mov ch,al       ;磁道号

        add ah,1
        mov cl,ah       ;扇区号

        mov dl,0        ;驱动器号

        pop bx
        pop ax

        ret

ending: nop

code ends
end copy