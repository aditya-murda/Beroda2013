/**
@author: vektor dewanto
@ver: 12 Jan 10
@desc:
    srf08 setting 
        set max range:150
        analog gain:5
        srf08 read till distance 129 cm for echo 1
*/  
#include "srf08.h"

bool sonarRange(uint8_t address){
   i2c_start();         // send start sequence
   i2c_write(address);  // SRF08 I2C address with R/W bit: clear = W
   i2c_write(0);        // SRF08 command register address
   i2c_write(0x51);     // command to start ranging in cm
   i2c_stop();          // send stop sequence
   
   return true;
}//end range_order

uint16_t sonarGetRange(uint8_t addr,uint8_t reg){     
   uint8_t hi=0,lo=0,temp=0;
   uint16_t range=0;
   
   //(1) wait till data is available,
   do{                                         
      i2c_start();              // send start sequence
      i2c_write(addr);          // SRF08 I2C address with R/W bit:clear = W
      i2c_write(1);             //write register number:1 
      
      i2c_start();              // send a restart sequence
      i2c_write(addr|1);       // SRF08 I2C address with R/W bit: set = R 
      temp=i2c_read(0);         // get the 1st reg nums and send NO acknowledge            
      i2c_stop();     
   }while(temp == 0xFF);        //the I2C data line (SDA) is pulled high if nothing is driving it
      
   //(2) get data available
   i2c_start();                 // send start sequence
   i2c_write(addr);             // SRF08 I2C address with R/W bit:clear = W
   i2c_write(reg);              //write register number
   i2c_start();                 // send a restart sequence
   i2c_write(addr|1);           // SRF08 I2C address with R/W bit: set = R 
   hi = i2c_read(1);            // get the high byte of the range and send acknowledge; regNumber = reg
   lo = i2c_read(0);            // get low byte of the range;regNumber = reg+1;Note: NO acknowledgement is sent   
   i2c_stop();                  // send stop sequence                                            
   
   range=hi;
   range<<=8;
   range|=lo;
   
   return range;      
}

uint16_t sonarGetRangeEcho(uint8_t echoNum, uint8_t addr){
    return sonarGetRange(addr,(echoNum*2));
} 

uint16_t sonarGet(uint8_t addr){
    uint16_t range;
    range = sonarGetRange(addr,2);
    if(range==0)
      range=50; 
    return range;
}

bool sonarSetRange(uint8_t addr,uint16_t rangeMili){ 

   //NOTE: *)The range is ((Range Register x 43mm) + 43mm)
   //      *)The range is set to maximum every time the SRF08 is powered-up.       
   i2c_start();
   i2c_write(addr);
   i2c_write(2);
   i2c_write(
               ceil(
                     (float)(rangeMili-43)/43
                    )
            );    
   i2c_stop();
   
   return true;
}  


bool sonarSetGain(uint8_t addr,uint8_t gain){ 
   
   i2c_start();
   i2c_write(addr); 
   i2c_write(1);   
   i2c_write(gain);              
   i2c_stop();   
     
   return true;
}

 
uint8_t sonarGetLight(uint8_t addr){                                                     
   uint8_t light=0,temp=0;
   
   //(1) wait till data is available,
   do
   {                                         
      i2c_start();// send start sequence
      i2c_write(addr);// SRF08 I2C address with R/W bit:clear = W
      i2c_write(1);//write register number:1 
      
      i2c_start();// send a restart sequence
      i2c_write(addr|1);   // SRF08 I2C address with R/W bit: set = R 
      temp=i2c_read(0);       // get the soft rev nums and send NO acknowledge            
      i2c_stop();     
   }while(temp == 0xFF);//the I2C data line (SDA) is pulled high if nothing is driving it

   //(2) get Data
   i2c_start();            // send start sequence
   i2c_write(addr);     // SRF08 I2C address with R/W bit:clear = W
   i2c_write(1);         //write register number
   i2c_start();            // send a restart sequence
   i2c_write(addr|1);   // SRF08 I2C address with R/W bit: set = R 
   light = i2c_read(0);       
   i2c_stop();  
   
   return light;
}      

//addr for the old address, target for new address
bool srf08Addressing(unsigned char addr, unsigned char target){
   i2c_start();		// send start sequence
   i2c_write(addr);	// accsess SRF08 in address 0xE0   
   i2c_write(0); 	// SRF08 command register address
   i2c_write(0xA0);	// 1st in sequence to change I2C address
   
   i2c_start();		// send start sequence
   i2c_write(addr);	// accsess SRF08 in address 0xE0
   i2c_write(0);	// SRF08 command register address
   i2c_write(0xAA);	// 2nd in sequence to change I2C address
   
   i2c_start();		// send start sequence
   i2c_write(addr);	// accsess SRF08 in address 0xE0
   i2c_write(0);	// SRF08 command register address
   i2c_write(0xA5);	// 3rd in sequence to change I2C address
   
   i2c_start();//send start sequence
   i2c_write(addr);	// accsess SRF08 in address 0xE0  
   i2c_write(0);	// SRF08 command register address
   i2c_write(target);	// change I2C address, choose the target address
   
   i2c_stop();		// send stop sequence
   
   return true;   
}//end srf08Addressing

bool sonarTest(uint8_t addr){
   char lcd[15];    
   //lcd_clear();
   //lcd_gotoxy(0,0);
   sonarRange(addr);
   sonarSetRange(addr,3000);   
   //mengganti echo menjadi dua namppil awal langsung 50, tampaknya ditambah gitu
   ltoa(sonarGetRangeEcho(2,addr),lcd); 
   lcd_puts(lcd);
   delay_ms(300);
   lcd_clear();
   
   //itoa(sonarGetLight(addr),lcd);
   //lcd_gotoxy(11,1);lcd_puts(lcd);
   
   //printf("%d ", sonarGetRangeEcho(1,addr));
   
   //printf("light: %d\n", sonarGetLight(addr));            
   return true;
}

uint8_t range(uint8_t addr)
{  
   sonarRange(addr);
   return sonarGet(addr);
} 


void displayAllSonar()
{  

        /*    
        WindWire's Sonar Location       
                     __
                   _|__|_____
                 //          \\SONAR RIGHTDIAG
                 /            \
                |              |
               ||              ||
                |              |
                |              |
               ||______________||
                      |__|
        
        
        */
char lcd[16];

sonarRange(SONAR_FRONT);
itoa(sonarGet(SONAR_FRONT),lcd);
lcd_gotoxy(0,0);
lcd_puts(lcd);

sonarRange(SONAR_RIGHTDIAG);
itoa(sonarGet(SONAR_RIGHTDIAG),lcd);
lcd_gotoxy(3,0);
lcd_puts(lcd);


sonarRange(SONAR_RIGHTFRONT);
itoa(sonarGet(SONAR_RIGHTFRONT),lcd);
lcd_gotoxy(6,0);
lcd_puts(lcd);


sonarRange(SONAR_RIGHTBACK);
itoa(sonarGet(SONAR_RIGHTBACK),lcd);
lcd_gotoxy(9,0);
lcd_puts(lcd);

sonarRange(SONAR_BACK);
itoa(sonarGet(SONAR_BACK),lcd);
lcd_gotoxy(12,0);
lcd_puts(lcd);

sonarRange(SONAR_LEFTBACK);
itoa(sonarGet(SONAR_LEFTBACK),lcd);
lcd_gotoxy(0,1);
lcd_puts(lcd);

sonarRange(SONAR_LEFTFRONT);
itoa(sonarGet(SONAR_LEFTFRONT),lcd);
lcd_gotoxy(3,1);
lcd_puts(lcd);

sonarRange(SONAR_LEFTDIAG);
itoa(sonarGet(SONAR_LEFTDIAG),lcd);
lcd_gotoxy(6,1);
lcd_puts(lcd);

delay_ms(200);
lcd_clear();  
}

void displayAllSonarLight()
{  

        /*    
        WindWire's Sonar Location       
                     __
                   _|__|_____
                 //          \\SONAR RIGHTDIAG
                 /            \
                |              |
               ||              ||
                |              |
                |              |
               ||______________||
                      |__|
        
        
        */
char lcd[16];

sonarRange(SONAR_FRONT);
itoa(sonarGetLight(SONAR_FRONT),lcd);
lcd_gotoxy(0,0);
lcd_puts(lcd);

sonarRange(SONAR_RIGHTDIAG);
itoa(sonarGetLight(SONAR_RIGHTDIAG),lcd);
lcd_gotoxy(4,0);
lcd_puts(lcd);

sonarRange(SONAR_RIGHTFRONT);
itoa(sonarGetLight(SONAR_RIGHTFRONT),lcd);
lcd_gotoxy(8,0);
lcd_puts(lcd);

sonarRange(SONAR_RIGHTBACK);
itoa(sonarGetLight(SONAR_RIGHTBACK),lcd);
lcd_gotoxy(12,0);
lcd_puts(lcd);

sonarRange(SONAR_BACK);
itoa(sonarGetLight(SONAR_BACK),lcd);
lcd_gotoxy(0,1);
lcd_puts(lcd);

sonarRange(SONAR_LEFTBACK);
itoa(sonarGetLight(SONAR_LEFTBACK),lcd);
lcd_gotoxy(4,1);
lcd_puts(lcd);

sonarRange(SONAR_LEFTFRONT);
itoa(sonarGetLight(SONAR_LEFTFRONT),lcd);
lcd_gotoxy(8,1);
lcd_puts(lcd);

sonarRange(SONAR_LEFTDIAG);
itoa(sonarGetLight(SONAR_LEFTDIAG),lcd);
lcd_gotoxy(12,1);
lcd_puts(lcd);

delay_ms(200);
lcd_clear();  
}
