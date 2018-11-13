#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

// LED Peripheral
#define REG_DATA_OFFSET 1
#define ENCODER_0_BASE 0x121000

int main(void){
  unsigned int led = 0;
  unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_0_BASE;
  int *p_encoder = (int *) ENCODER_0_BASE;

  printf("Embarcados++ \n");

  while(1){
          usleep(50000); // remover durante a simulação
          printf("%d \n", *(p_encoder+REG_DATA_OFFSET));
  }
  return 0;
}
