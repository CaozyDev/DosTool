    BaseOfStack equ 0x7c00

    org 0x7c00
    jmp start
    
    OEMName     db 'HILTCZY '
    BytesPerSec dw 512
    SecPerClus  db 1
    RsvdSecCnt  dw 1
    NumFATs     db 2
    RootEntCnt  dw 224
    TotSec16    dw 2880
    Media       db 0xf0
    FATSz16     dw 9
    SecPerTrk   dw 18
    NumHeads    dw 2
    HiddSec     dw 0,0
    TotSec32    dw 0,0
    DrvNum      db 0
    Reservedl   db 0
    BootSig     db 0x29
    VolId       dw 0,0
    VolLab      db 'boot loader'
    FileSysType db 'FAT12   '
start:
    mov ax,cs
    mov ss,ax
    mov sp,BaseOfStack
show_str:
    mov ax,0b800h
    mov ds,ax
    mov si,0
    mov ax,cs
    mov es,ax
    mov di,LINE1
    mov cx,2
s0:
    push cx
    mov cx,53
s1: mov al,es:[di]
    mov ds:[si],al
    add si,2
    inc di
    loop s1

    add si,54
    pop cx

    loop s0


    mov ax,0b800h
    mov ds,ax
    mov si,320
scanf:
    mov ah,0
    int 16h
    cmp ah,0eh
    jne show

    cmp si,0
    je show
    sub si,2
    mov byte [ds:si],' '
    jmp short scanf

show:
    mov [ds:si],al
    add si,2
    jmp short scanf



    LINE1 db 'This is a program that made by Cao Ziyang.           '
    LINE2 db 'You can use your keyboard to type in some characters.'

    times 510-($-$$) db 0
    db 0x55,0xaa