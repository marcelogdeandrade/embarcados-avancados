#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "sys/alt_irq.h"
#include <unistd.h>
#include "altera_avalon_pio_regs.h"
#include <io.h> /* Leitura e escrita no Avalon */

volatile int edge_capture;
volatile int edge_capture2;
int enable = 0;
unsigned led_speed = 50000;
alt_u32 speed_multiplier;

void init_button_pio();
void handle_button_interrupts(void* context, alt_u32 id);

int main(void){
  unsigned int led = 0;


  init_button_pio();
  init_keys_pio();

  while(1){
	  if (!enable){
		  led_speed = 50000 * (speed_multiplier + 1);
		  if (led <= 5){
			  IOWR_32DIRECT(LEDS_PIO_BASE, 0, 0x01 << led++);
			  usleep(led_speed);
		  }
		  else{
			  led = 0;
		  }
	  }
  };

  return 0;
}

void handle_keys_interrupts(void* context, alt_u32 id)
{
	/* Cast context to edge_capture's type. It is important that this be
	 * declared volatile to avoid unwanted compiler optimization.
	 */
	volatile int* edge_capture_ptr2 = (volatile int*) context;
	/* Store the value in the Button's edge capture register in *context. */
	*edge_capture_ptr2 = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEYS_PIO_BASE);
	 speed_multiplier = IORD_32DIRECT(KEYS_PIO_BASE, 0);
     /* Reset the Button's edge capture register. */
     IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEYS_PIO_BASE, 0);
}

void handle_button_interrupts(void* context, alt_u32 id)
{
	/* Cast context to edge_capture's type. It is important that this be
	 * declared volatile to avoid unwanted compiler optimization.
	 */
	volatile int* edge_capture_ptr = (volatile int*) context;
	/* Store the value in the Button's edge capture register in *context. */
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE);
     enable = !enable;
     /* Reset the Button's edge capture register. */
     IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE, 0);
}


void init_button_pio()
{
	printf("Init pio");
	/* Recast the edge_capture pointer to match the alt_irq_register() function
	 * prototype. */
	void* edge_capture_ptr = (void*) &edge_capture;
	/* Enable first four interrupts. */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTON_PIO_BASE, 0x1);
	/* Reset the edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE, 0x0);
	/* Register the interrupt handler. */
	alt_irq_register( BUTTON_PIO_IRQ, edge_capture_ptr,
					 handle_button_interrupts );
}

void init_keys_pio()
{
	/* Recast the edge_capture pointer to match the alt_irq_register() function
	 * prototype. */
	void* edge_capture_ptr2 = (void*) &edge_capture2;
	/* Enable first four interrupts. */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(KEYS_PIO_BASE, 0xf);
	/* Reset the edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEYS_PIO_BASE, 0x0);
	/* Register the interrupt handler. */
	alt_irq_register( KEYS_PIO_IRQ, edge_capture_ptr2,
					 handle_keys_interrupts );
}
