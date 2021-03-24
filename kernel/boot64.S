#include "kernel.h"
#include "sizes.h"
#include "multiboot2.h"


#define KERNEL_VMA   0xffff800000000000

.code64

.section .text
.global _start64h
_start64h:

    // Setup segment selectors
    movw $0, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    movw %ax, %ss

	movq $KERNEL_VMA, %rax
	addq %rax, %rsp

	movq   $0x0, p4_table
	invlpg 0

	call InitPIT

	call InitPIC

	call cmain

    // Should never reach here
    cli
    hlt
1:
    jmp 1b


InitPIT:
    mov $(1<<2)|(3<<4), %al
    out %al, $0x43

    mov $11931,%ax
    out %al, $0x40
    mov %ah,%al
    out %al, $0x40
	ret

InitPIC:
    mov $0x11,%al
    out %al, $0x20
    out %al, $0xa0

    mov $32,%al
    out %al, $0x21
    mov $40,%al
    out %al, $0xa1

    mov $4,%al
    out %al, $0x21
    mov $2,%al
    out %al, $0xa1

    mov $1,%al
    out %al, $0x21
    out %al, $0xa1

    mov $0b11111110,%al
    out %al, $0x21
    mov $0b11111111,%al
    out %al, $0xa1

    ret



