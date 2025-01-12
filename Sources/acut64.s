.global main

.section .rodata
    dumpsys_cmd:    .string "dumpsys battery\0"
    grep_cmd:       .string "grep level:\0"
    awk_cmd:        .string "awk '{print $2}'\0"
    charger_path:   .string "/sys/devices/platform/charger/bypass_charger\0"
    one:            .string "1\n\0"
    zero:           .string "0\n\0"
    mode:           .string "w+\0"

.text
main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

main_loop:
    adr     x0, dumpsys_cmd
    bl      system

    mov     w1, #100
    cmp     w0, w1
    b.lt    disable_bypass

enable_bypass:
    adr     x0, charger_path
    adr     x1, mode
    bl      fopen
    
    mov     x1, x0
    adr     x0, one
    bl      fputs
    
    b       sleep_delay

disable_bypass:
    adr     x0, charger_path
    adr     x1, mode
    bl      fopen
    
    mov     x1, x0
    adr     x0, zero
    bl      fputs

sleep_delay:
    mov     x0, #1800    // 30 minutes = 1800 seconds
    bl      sleep
    
    b       main_loop

exit:
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret