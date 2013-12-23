
#pragma used+
sfrb PINA=0;
sfrb DDRA=1;
sfrb PORTA=2;
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb PINE=0xc;
sfrb DDRE=0xd;
sfrb PORTE=0xe;
sfrb PINF=0xf;
sfrb DDRF=0x10;
sfrb PORTF=0x11;
sfrb PING=0x12;
sfrb DDRG=0x13;
sfrb PORTG=0x14;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb TIFR3=0x18;
sfrb TIFR4=0x19;
sfrb TIFR5=0x1a;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0X21;   
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb OCDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb RAMPZ=0x3b;
sfrb EIND=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
#endasm

typedef signed char int8_t;
typedef unsigned char uint8_t;

typedef short int16_t;
typedef unsigned short uint16_t;

typedef long int32_t;
typedef unsigned long uint32_t;

typedef short intptr_t;
typedef unsigned short uintptr_t;

typedef short flash_intptr_t;
typedef unsigned short flash_uintptr_t;

typedef short eeprom_intptr_t;
typedef unsigned short eeprom_uintptr_t;

#pragma used+
interrupt [6] void ext_int4_isr(void);

void uvtronInit();
void uvtronOn();
void uvtronOff();
_Bool uvtronScan(unsigned int time);

#pragma used-

#pragma used+

void forward(uint16_t tick);
void backward(uint16_t tick);
void moveEncoder(int8_t pwmL, int8_t pwmR, uint16_t cm);
void stop();
void pause();
void turnRight(uint16_t tick);
void turnLeft(uint16_t tick);
void alignRight(int8_t speed);
void alignLeft(int8_t speed);
void turnCW(uint16_t angle);
void turnCCW(uint16_t angle);
void sonarAlign();
void homeAlign();
void forwardUntilSonar();
void rightWallAlign();
void motorStop(int8_t pwmL, int8_t pwmR);

void  motorTest();
void encoderTest();

void startLocationIdentification();
uint8_t getRoom();

void room_to_room_lorong_v2();
void room_to_room_lorong_kiri_v2();

void matikanApiKiri();
void matikanApiKanan();
void cekFireInJuringKanan();
void cekFireInJuringKiri();

void backHome();

void jauh_garis_kanan();
void jauh_garis_kiri();

void tesNavSpeedControl();

#pragma used-

#pragma used+
void i2c_init(void);
unsigned char i2c_start(void);
void i2c_stop(void);
unsigned char i2c_read(unsigned char ack);
unsigned char i2c_write(unsigned char data);
#pragma used-

#pragma used+

void _lcd_ready(void);
void _lcd_write_data(unsigned char data);

void lcd_write_byte(unsigned char addr, unsigned char data);

unsigned char lcd_read_byte(unsigned char addr);

void lcd_gotoxy(unsigned char x, unsigned char y);

void lcd_clear(void);
void lcd_putchar(char c);

void lcd_puts(char *str);

void lcd_putsf(char flash *str);

unsigned char lcd_init(unsigned char lcd_columns);

void lcd_control (unsigned char control);

#pragma used-
#pragma library lcd.lib

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

#pragma used+

unsigned char cabs(signed char x);
unsigned int abs(int x);
unsigned long labs(long x);
float fabs(float x);
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);

#pragma used-
#pragma library stdlib.lib

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float ftrunc(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
int printf(char flash *fmtstr,...);
int sprintf(char *str, char flash *fmtstr,...);
int vprintf(char flash * fmtstr, va_list argptr);
int vsprintf(char *str, char flash * fmtstr, va_list argptr);

char *gets(char *str,unsigned int len);
int snprintf(char *str, unsigned int size, char flash *fmtstr,...);
int vsnprintf(char *str, unsigned int size, char flash * fmtstr, va_list argptr);

int scanf(char flash *fmtstr,...);
int sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

#pragma used+
int tpaGetMaxValueTemp(int a[]);
_Bool tpaSetServo2(unsigned char pos2);
_Bool tpaSetServo(uint8_t address, unsigned char pos); 

unsigned int tpaGetPixelNumTemp(unsigned char pixelNum);
unsigned int tpaGetAmbientTemp();     
_Bool displayTpaAmbientTempLCD();
uint16_t displayTpaAmbientTempDebugging();
uint16_t displayTpaPixelNumTempDebugging();
_Bool displayTpaPixelNumTempLCD();
void displayTpa81();
unsigned int tpaRead(unsigned char address, unsigned char pixelNum);
int max_val(int a[]);
int getTpa81(uint8_t address);
_Bool tpa81Addressing(unsigned char addr, unsigned char target);    

void tpaServoScan();   

_Bool tpaCheckKanan(); 
_Bool tpaCheckKiriPintu();  
void tesServoTpa();
#pragma used-              

#pragma used+
void soundInit();
void soundWait();
void PlayMusic(flash int* pMusicNotes, uint8_t tempo);
#pragma used-                        

#pragma used+

extern uint8_t konstVelo,nav_velo,arahApi,loopApi;
extern _Bool looping2;

extern uint16_t prevSonar;
extern uint16_t sonarCount;

extern uint8_t counter_room;
extern uint8_t robotStatus;
extern uint8_t to_room;
extern uint8_t from_room;
extern eeprom uint8_t to_room_eeprom[];
extern eeprom uint8_t to_room_fire;

extern uint8_t interruptTimer;
extern uint8_t roomDetect;
extern uint8_t photon;
extern _Bool finish;

extern flash int starwars[];

extern _Bool pulang;
extern uint8_t pintu1;

extern int counterHayo;

extern int ka, ki, right0, right1, right2, left0, left1, left2, front,deviasi,fe,back,to_pid;
extern int last_left0,last_left1,last_left2,last_right0,last_right1,last_right2;
extern eeprom int offset_mkanan, offset_mkiri,R,L;
extern int signwf;

extern float error1, PV1, i1, delta1, last_error1, MV1;
extern float SP1;
extern eeprom int kp1, kd1, ki1;

extern float error2, PV2, i2, delta2, last_error2, MV2;
extern eeprom int SP2;
extern eeprom int kp2, kd2, ki2;

extern float error3, PV3, i3, delta3, last_error3, MV3;
extern eeprom int SP3;
extern eeprom int kp3, kd3, ki3;

extern _Bool adaAnjing;
extern int right0;
extern _Bool adaAnjingTengah;

extern _Bool fireKill;
extern _Bool gotHome;
extern _Bool mungkinApi;
extern _Bool apiMati;
extern _Bool juringHome;
extern _Bool apiKiri;

extern int lineRoom;
extern _Bool inRoom;

extern _Bool masukRoom2;
extern uint8_t kenaGaris;
extern _Bool masukJuring;

#pragma used-

void uvtronInit()
{
DDRD.7 = 0;
PORTD.7 = 1;

}

void uvtronOn()
{

(*(unsigned char *) 0x69)=0x00;
(*(unsigned char *) 0x6a)=0x02;
EIMSK=0x10;
EIFR=0x10;
}

void uvtronOff()
{

(*(unsigned char *) 0x69)=0x00;
(*(unsigned char *) 0x6a)=0x00;
EIMSK=0x00;

}

_Bool uvtronScan(unsigned int time)
{
char lcd[15];

photon=0;
uvtronOn();
delay_ms(time); 
uvtronOff();  
lcd_clear();    

if(photon>3){

itoa(photon,lcd);
lcd_gotoxy(0,0);
lcd_puts(lcd);

return 1;
} 
else {

itoa(photon,lcd);
lcd_gotoxy(0,0);
lcd_puts(lcd);

return 0;
}

}

interrupt [6] void ext_int4_isr(void)
{

photon++;

}

