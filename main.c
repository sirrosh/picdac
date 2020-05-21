
#define NO_BIT_DEFINES
#include <pic14regs.h>
#include <stdint.h> 
#include "sine.h"

__code uint16_t __at (_CONFIG) __configword = _INTRC_OSC_NOCLKOUT & _WDTE_OFF & _LVP_OFF;

#define LED_PORT PORTAbits.RA0
#define LED_TRIS TRISAbits.TRISA0

void MCUInit(void)
{
	TRISB = 0;
	
//	LED_TRIS = 0; // Pin as output
//	LED_PORT = 0; // LED off

}

// Uncalibrated delay, just waits a number of for-loop iterations
void delay(uint16_t iterations)
{
	uint16_t i;
	for (i = 0; i < iterations; i++) {
		// Prevent this loop from being optimized away.
		__asm nop __endasm;
	}
}

void main(void)
{
	uint8_t i = 0;

MCUInit();

	
	while (1) {
		/*
		LED_PORT = 1; // LED On
		delay(30000); // ~500ms @ 4MHz
		LED_PORT = 0; // LED Off
		delay(30000); // ~500ms @ 4MHz
		*/
		PORTB = sine_wave_8[i];
		i++;
	}
}
