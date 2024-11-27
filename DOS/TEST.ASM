        org 0x1000

        mov ax,cs
        mov ss,ax
        mov sp,0x7c00
        
        mov ax,cs
        mov es,ax
        mov bp,str1
        mov al,1
        mov bl,111b
        mov bh,0
        mov cx,str2-str1
        mov dx,0
        mov ah,13h
        int 10h

s:
        in al,60h
        cmp al,'y'
        jne s
        in al,92h
        or al,1
        out al,92h
        
fin:    
        cli
        hlt

        str1 db 'Would you like to reboot the system? Y/n'
        str2 db 'The system will reboot later'

        times 510-($-$$) db 0
        db 0x55,0xaa