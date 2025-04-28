org 0x7c00
bits 16

%define ENDL 0x00, 0x0a

; FILE SYSTEM
jmp short start
nop
bdb_oem:                        db 'MSWIN4.1'
bdb_bytes_per_sector:           dw 512
bdb_sectors_per_cluster:        db 1
bdb_reserved_sectors:           dw 1
bdb_fat_count:                  db 2
bdb_dir_entries_count:          dw 0e0h
bdb_total_sectors:              dw 2880
bdb_media_desccriptor_type:     db 0f0h
bdb_sectors_per_fat:            dw 9
bdb_sectors_per_track:          dw 18
bdb_heads:                      dw 2
bdb_hidden_sectors:             dd 0
bdb_large_sector_count:         dd 0


; extended boot recors
ebr_dribe_number:               db 0
                                db 0

ebr_signature:                  db 29h
ebr_volume_id:                  db 12h, 34h, 56h, 78h
ebr_volume_label:               db ' C. O. S. '
ebr_system_id:                  db 'FAT 12'

;  CODE
start:
    jmp main

puts:
    push si
    push ax
    push bx

.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

main:
    mov ax, 0x0000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    mov si, msg
    call puts
    hlt


.halt:
    jmp .halt


; DISK ROUTINES

; Converts LBA address to CHS
; Parameters:
;    -ax: LBA address
; Returns:
;    -cx [bits 0-5]  : sector number
;    -cx [bits 6-15] : cylinder
;    -dh             : head
;

lba_to_chs:
    push ax
    push dx


    xor dx, dx                           ; dx = 0
    div word [bdb_sectors_per_track]     ; ax = LBA / sectors_per_track
                                         ; dx = LBA % sectors_per_track

    inc dx                               ; dx = (LBA % sectors_per_track +1) = sector
    mov cx, dx                           ; cx = sector

    xor dx,dx                            ; dx = 0
    div word [bdb_heads]                 ; ax = (LBA / sectors_per_track) / heads = cylinder 
                                         ; dx = (LBA / sectors_per_track) % heads = head

    mov dh, dl                           ; dh = head
    mov ch, al                           ; ch = cylinder (lower * bits)
    shl ah, 6
    or cl, ah                            ; put upper 2 bits of a cylinder in cl

    pop ax
    mov dl, al                            ; RESTORE dl
    pop dx
    ret

;
; Reads sectors from a disk
;Parameters:
;  - ax: LBA address
;  - cl: number o fsectors to read (up to 128)
;  - dl: drive number
;  - es: bx: memory address where to store read data
;
disk_read:
    


msg: db "[ C. O. S. ]",0x0a,"Hello, user!",ENDL, 0


times 510-($-$$) db 0
dw 0xaa55

