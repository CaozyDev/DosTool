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
    mov di,RESET
    mov cx,4
s0:
    push cx
    mov cx,16
s1: mov al,es:[di]
    mov ds:[si],al
    add si,2
    inc di
    loop s1

    add si,128
    pop cx

    loop s0


scanf:
    mov ah,0
    int 16h

    cmp al,'1'
    je reset
    cmp al,'2'
    je start_system
    cmp al,'3'
    je clock
    cmp al,'4'
    je setcl
    
    jmp short scanf


reset:
    jmp 0x0f12c0

start_system:
    mov ax,0
    mov es,ax
    mov bx,7c00h

    mov ah,2
    mov al,1
    mov ch,0
    mov cl,1
    mov dh,0
    mov dl,80h
    int 13h

    jmp 0x7c00
    ret
clock:
    ret
setcl:
    ret


    RESET db '<1> Reset PC    '
    SRART db '<2> Start System'
    CLOCK db '<3> Clock       '
    SETCL db '<4> Set Clock   '

    times 510-($-$$) db 0
    db 0x55,0xaa