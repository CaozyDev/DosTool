assume cs:code
stack segment
        db 128 dup (0)
stack ends

code segment
start:
        mov ax,stack
        mov ss,ax
        mov sp,128

        mov ax,0
        mov ds,ax
        cli
        push ds:[9*4]
        pop ds:[200h]
        push ds:[9*4+2]
        pop ds:[200h+2]
        sti

        mov ax,cs
        mov ds,ax
        mov si,offset int9

        mov ax,0
        mov es,ax
        mov di,204h

        mov cx,offset pro_end - offset int9
        cld
        rep movsb

        mov word ptr es:[9*4],200h
        mov word ptr es:[9*4+2],0

        mov ax,4c00h
        int 21h

;----------以下为新的int9中断例程----------
int9:
        in al,60h

        pushf
        call dword ptr cs:[200h]

        cmp al,9eh
        je show_a

        mov ax,4c00h
        int 21h
        iret

show_a:
        ;该子程序功能为显示满屏幕的“A”
        push ax
        push ds
        push cx
        push si

        mov ax,0b800h
        mov ds,ax
        mov si,0
        mov cx,80*25
    s:  mov byte ptr [si],'A'
        add si,2
        loop s

        pop si
        pop cx
        pop ds
        pop ax
        
        mov ax,4c00h
        int 21h
        iret
pro_end:
        nop

code ends
end start