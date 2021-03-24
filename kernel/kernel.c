#include "multiboot2.h"
//#include "stdarg.h"
#include "print.h"
#include "trap.h"
//#include "utils.h"

int cmain(unsigned long addr, unsigned long magic)
{

	init_idt();
	asm volatile ("int $0x3");
//	asm volatile ("int $0x4"); 

	printk("\nAll Systems Online");

	while(1);
}
