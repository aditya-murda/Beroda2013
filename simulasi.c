/* ****************************************************************
| Saripudin 2010
| Eyesim Code Template
| dedicated for better AI TRUI ;)
| ini buatan bang pudin, belum diutak atik. gw ga tau kenapa eyesim ga jalan di laptop gw,
| mungkin karena 64 bit
* *****************************************************************/

#include "eyebot.h"

QuadHandle encoderLeft, encoderRight;
MotorHandle mLeft, mRight;
PSDHandle pBack, pLeftBack, pLeftFront, pRightBack, pRightFront, pRightDiag, pLeftDiag, pFront;


void rPwm(int speedLeft, int speedRight)
{
	MOTORDrive(mLeft, speedLeft);
	MOTORDrive(mRight, speedRight);
}

int main ()
{
	int front, back, encLeftTick;
//	int	leftFront, rightFront;
	
	mLeft = MOTORInit(MOTOR_LEFT);
	mRight = MOTORInit(MOTOR_RIGHT);
	
	encoderLeft = QUADInit(QUAD_LEFT);
	encoderRight = QUADInit(QUAD_RIGHT);
	
	pFront = PSDInit(PSD_FRONT);
	pBack = PSDInit(PSD_BACK);
    
    /*pLeftFront= PSDInit (PSD_LEFTFRONT);
    pRightFront= PSDInit (PSD_RIGHTFRONT);*/

	
	PSDStart(pFront|pBack, TRUE); 
  // PSDStart (pLeftFront|pRightFront, TRUE);	
	while(1)
	{	
		rPwm(30,30);
		front = PSDGet(pFront);
		back = PSDGet(pBack);
		//leftFront = PSDGet(pLeftFront);
		//rightFront = PSDGet(pRightFront);	
	 
     	/*if (front < 200){
                  rPwm(50, -50);
                  //OSWait(50);
                  
                  } */
        encLeftTick = QUADRead(encoderLeft);
		LCDPrintf("Depan: %d\n", front);
		LCDPrintf("Belakang: %d\n", back);
		LCDPrintf("Encoder: %d\n", encLeftTick);
		
        OSWait(10);
		LCDClear();
	}
    return 0;
}

