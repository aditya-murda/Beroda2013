/**
@auth:grafika j
@lastUpdate: 22 mar
@desc:
*/
#include "uvtron.h"
//#include "tpa81.h"
//#include "main_master.h"                                                

#include <lcd.h>
#include <delay.h>
#include <stdlib.h>

unsigned char lcd[15];
int photon;

void uvtronInit()
{
   DDRD.7 = 0;
   PORTD.7 = 1;
}
  
void uvtronOn()
{
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: On
// INT4 Mode: Falling Edge
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x02;
EIMSK=0x10;
EIFR=0x10;
}

void uvtronOff()
{
 // External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;
 
}
// this function use for waiting the pulse from UVTRON
bool uvtronScan(unsigned int time)
{
    char lcd[15];


   photon=0;
   uvtronOn();
   delay_ms(time); 
   uvtronOff();  
   lcd_clear();    
   
   if(photon>3){
            
        lcd_putsf("  ADA API");
        delay_ms(500);        
        //photon=0;   
        uvtronOff();
       itoa(photon,lcd);
       lcd_gotoxy(0,0);
       lcd_puts(lcd);
       //photon=0;
       
       return 1;
   } 
   else {
            
       lcd_putsf("  TIDAK ADA API");
       delay_ms(500);
       //photon=0;
        itoa(photon,lcd);
       lcd_gotoxy(0,0);
       lcd_puts(lcd);
       //photon=0;
         
        return 0;
  }
   
}

// External Interrupt 4 service routine
interrupt [EXT_INT4] void ext_int4_isr(void)
{
// Place your code here
     
       
        photon++;
        uvtronOn();
        
}


