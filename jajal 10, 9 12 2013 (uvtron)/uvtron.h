/**
@auth:saripudin
ver: 25 Feb 2010

*/
#ifndef _UVTRON_INCLUDED_
#define _UVTRON_INCLUDED_

#include <mega2560.h>
#include <stdint.h>
#include <stdbool.h>

#pragma used+
interrupt [EXT_INT4] void ext_int4_isr(void);

void uvtronInit();
void uvtronOn();
void uvtronOff();
bool uvtronScan(unsigned int time);


#pragma used-
#endif