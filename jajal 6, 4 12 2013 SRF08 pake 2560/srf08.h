#ifndef _SRF08_INCLUDED_
#define _SRF08_INCLUDED_

#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <i2c.h>
#include <stdlib.h>
#include <math.h>
#include <delay.h>
#include <lcd.h>

// SONAR_MAX_RANGE 1500 untuk pengambilan data
// SONAR_MAX_RANGE 500 untuk navigasi
#define SONAR_MAX_RUN 500
#define SONAR_MAX_IDEN 1500



//SONAR NAME
#define SONAR_FRONT 0xEE
#define SONAR_RIGHTDIAG 0xE2
#define SONAR_RIGHTFRONT 0xE8
#define SONAR_RIGHTBACK 0xE4
#define SONAR_BACK 0xEC
#define SONAR_LEFTBACK 0xE6
#define SONAR_LEFTFRONT 0xE0
#define SONAR_LEFTDIAG 0xEA
 
#pragma used+
   bool sonarRange(uint8_t address);   //ambil nilai range  sonar
   uint16_t sonarGetRange(uint8_t addr,uint8_t reg);
   uint16_t sonarGetRangeEcho(uint8_t echoNum, uint8_t addr);
   bool sonarSetRange(uint8_t addr,uint16_t rangeMili);
   bool sonarSetGain(uint8_t addr,uint8_t gain);
   bool sonarSetAddr(uint8_t addr, uint8_t target);
   uint8_t sonarGetLight(uint8_t addr);
   bool sonarTest(uint8_t addr);  
   bool srf08Addressing(unsigned char addr, unsigned char target); //addr alamat lama, target alamat barunya
   uint16_t sonarGet(uint8_t addr); 
   uint8_t range(uint8_t addr);
   void displayAllSonar(); 
   void displayAllSonarLight();
#pragma used-

#endif