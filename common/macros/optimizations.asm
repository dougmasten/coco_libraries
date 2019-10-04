; optimizations.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_OPTIMIZE_DEFS  ; Load macros only once


; space savings macros
skip_byte           macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_word           macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


; increment memory word by +1
inc_word            macro
                    inc \1+1                ; increment LSB
                    bne a@
                    inc \1                  ; increment MSB
a@                  equ *
                    endm


; faster long branch instructions if branch is not taken (same cycles otherwise but with one extra byte)
long_bcc            macro
                    bcs a@
                    jmp \1
a@                  equ *
                    endm

long_bcs            macro
                    bcc a@
                    jmp \1
a@                  equ *
                    endm

long_beq            macro
                    bne a@
                    jmp \1
a@                  equ *
                    endm

long_bmi            macro
                    bpl a@
                    jmp \1
a@                  equ *
                    endm

long_bne            macro
                    beq a@
                    jmp \1
a@                  equ *
                    endm

long_bpl            macro
                    bmi a@
                    jmp \1
a@                  equ *
                    endm

long_bvc            macro
                    bvs a@
                    jmp \1
a@                  equ *
                    endm

long_bvs            macro
                    bvc a@
                    jmp \1
a@                  equ *
                    endm


; faster push and pop of a single register using SMC (Self modifying code)
store_a             macro
                    sta \1
                    endm

load_a              macro
                    lda #$ff
\1                  equ *-1
                    endm

store_b             macro
                    stb \1
                    endm

load_b              macro
                    ldb #$ff
\1                  equ *-1
                    endm

store_d             macro
                    std \1
                    endm

load_d              macro
                    ldd #$ffff
\1                  equ *-2
                    endm

store_e             macro
                    ste \1
                    endm

load_e              macro
                    lde #$ff
\1                  equ *-1
                    endm

store_f             macro
                    stf \1
                    endm

load_f              macro
                    ldf #$ff
\1                  equ *-1
                    endm

store_u             macro
                    stu \1
                    endm

load_u              macro
                    ldu #$ffff
\1                  equ *-2
                    endm

store_w             macro
                    stw \1
                    endm

load_w              macro
                    ldw #$ffff
\1                  equ *-2
                    endm

store_x             macro
                    stx \1
                    endm

load_x              macro
                    ldx #$ffff
\1                  equ *-2
                    endm

store_y             macro
                    sty \1
                    endm

load_y              macro
                    ldy #$ffff
\1                  equ *-2
                    endm


MACROS_OPTIMIZE_DEFS equ 1                  ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
