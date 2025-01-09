.section .data
    battery_path:    .string "/sys/class/power_supply/battery/capacity"
    charger_path:    .string "/sys/devices/platform/charger/bypass_charger"
    buffer:          .skip 16
    one:            .string "1"
    zero:           .string "0"
    timespec:
        tv_sec:     .quad 1800     // 30 minutes = 1800 seconds
        tv_nsec:    .quad 0        // nanoseconds

.section .text
.global main
.type main, %function

main:
    // Setup stack frame
    stp x29, x30, [sp, #-16]!
    mov x29, sp

1:  // Main loop
    // Open battery capacity file
    mov x0, xzr                     // AT_FDCWD
    adr x1, battery_path           // Path to battery capacity
    mov x2, #0                     // O_RDONLY
    mov x3, #0                     // mode (not used for O_RDONLY)
    mov x8, #56                    // openat syscall
    svc #0
    
    mov x19, x0                    // Save file descriptor
    
    // Read battery value
    mov x0, x19                    // File descriptor
    adr x1, buffer                // Buffer for reading
    mov x2, #16                   // Read up to 16 bytes
    mov x8, #63                   // read syscall
    svc #0
    
    // Close battery file
    mov x0, x19
    mov x8, #57                   // close syscall
    svc #0
    
    // Convert ASCII to integer
    adr x1, buffer
    mov x19, #0                   // Result
    mov x20, #10                  // Multiplier

2:  // Conversion loop
    ldrb w2, [x1], #1
    cmp w2, #'\n'
    beq 3f
    cmp w2, #'0'
    blt 2b
    cmp w2, #'9'
    bgt 2b
    sub w2, w2, #'0'
    mul x19, x19, x20
    add x19, x19, x2
    b 2b

3:  // Compare with threshold (100)
    cmp x19, #100
    
    // Open charger bypass file
    mov x0, xzr                    // AT_FDCWD
    adr x1, charger_path          // Charger bypass path
    mov x2, #0x241                // O_WRONLY | O_CREAT | O_TRUNC
    mov x3, #0644                 // Mode (rw-r--r--)
    mov x8, #56                   // openat syscall
    svc #0
    
    mov x19, x0                   // Save file descriptor
    
    blt 4f                        // If less than threshold, jump to write 0
    
    // Write 1 to bypass
    mov x0, x19                   // File descriptor
    adr x1, one                   // "1"
    mov x2, #1                    // Length
    b 5f
    
4:  // Write 0 to bypass
    mov x0, x19                   // File descriptor
    adr x1, zero                  // "0"
    mov x2, #1                    // Length
    
5:  // Write to file
    mov x8, #64                   // write syscall
    svc #0
    
    // Close charger file
    mov x0, x19
    mov x8, #57                   // close syscall
    svc #0
    
    // Sleep for 30 minutes
    adr x0, timespec             // First timespec struct (request)
    add x1, x0, #0              // Second timespec struct (remaining, can be same)
    mov x8, #101                // nanosleep syscall
    svc #0
    
    b 1b                          // Loop back

    // Return (shouldn't reach here)
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret

.size main, .-main