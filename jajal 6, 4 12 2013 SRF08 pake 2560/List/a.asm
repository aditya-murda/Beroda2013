
;CodeVisionAVR C Compiler V2.04.4a Advanced
;(C) Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega2560
;Program type             : Application
;Clock frequency          : 11.059200 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega2560
	#pragma AVRPART MEMORY PROG_FLASH 262144
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _jarak=R3
	.DEF __lcd_x=R6
	.DEF __lcd_y=R5
	.DEF __lcd_maxx=R8

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x202005F:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G101
	.DW  _0x202005F*2

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x2000)
	LDI  R25,HIGH(0x2000)
	LDI  R26,LOW(0x200)
	LDI  R27,HIGH(0x200)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

	OUT  EIND,R24

;GPIOR0 INITIALIZATION
	LDI  R30,0x00
	OUT  GPIOR0,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x21FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x21FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xA00)
	LDI  R29,HIGH(0xA00)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;/*****************************************************
;
;Chip type               : ATmega2560
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 2048
;*****************************************************/
;
;#include <mega2560.h>
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
;#include "srf08.h"
;#include <delay.h>
;
;// I2C Bus functions
;#asm
   .equ __i2c_port=0x0E ;PORTE
   .equ __sda_bit=2
   .equ __scl_bit=3
; 0000 0014 #endasm
;#include <i2c.h>
;
;// Alphanumeric LCD Module functions
;#asm
   .equ __lcd_port=0x08 ;PORTC
; 0000 001A #endasm
;#include <lcd.h>
;
;// Declare your global variables here
;char lcd[16];
;unsigned int jarak;
;
;void main(void)
; 0000 0022 {

	.CSEG
_main:
; 0000 0023 // Declare your local variables here
; 0000 0024 
; 0000 0025 // Crystal Oscillator division factor: 1
; 0000 0026 #pragma optsize-
; 0000 0027 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0028 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0029 #ifdef _OPTIMIZE_SIZE_
; 0000 002A #pragma optsize+
; 0000 002B #endif
; 0000 002C 
; 0000 002D // Input/Output Ports initialization
; 0000 002E // Port A initialization
; 0000 002F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0030 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0031 PORTA=0x00;
	OUT  0x2,R30
; 0000 0032 DDRA=0x00;
	OUT  0x1,R30
; 0000 0033 
; 0000 0034 // Port B initialization
; 0000 0035 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0036 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0037 PORTB=0x00;
	OUT  0x5,R30
; 0000 0038 DDRB=0x00;
	OUT  0x4,R30
; 0000 0039 
; 0000 003A // Port C initialization
; 0000 003B // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 003C // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 003D PORTC=0x00;
	OUT  0x8,R30
; 0000 003E DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x7,R30
; 0000 003F 
; 0000 0040 // Port D initialization
; 0000 0041 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0042 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0043 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0044 DDRD=0x00;
	OUT  0xA,R30
; 0000 0045 
; 0000 0046 // Port E initialization
; 0000 0047 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0048 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0049 PORTE=0x00;
	OUT  0xE,R30
; 0000 004A DDRE=0x00;
	OUT  0xD,R30
; 0000 004B 
; 0000 004C // Port F initialization
; 0000 004D // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 004E // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 004F PORTF=0x00;
	OUT  0x11,R30
; 0000 0050 DDRF=0x00;
	OUT  0x10,R30
; 0000 0051 
; 0000 0052 // Port G initialization
; 0000 0053 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0054 // State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0055 PORTG=0x00;
	OUT  0x14,R30
; 0000 0056 DDRG=0x00;
	OUT  0x13,R30
; 0000 0057 
; 0000 0058 // Port H initialization
; 0000 0059 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005B PORTH=0x00;
	STS  258,R30
; 0000 005C DDRH=0x00;
	STS  257,R30
; 0000 005D 
; 0000 005E // Port J initialization
; 0000 005F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0060 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0061 PORTJ=0x00;
	STS  261,R30
; 0000 0062 DDRJ=0x00;
	STS  260,R30
; 0000 0063 
; 0000 0064 // Port K initialization
; 0000 0065 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0066 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0067 PORTK=0x00;
	STS  264,R30
; 0000 0068 DDRK=0x00;
	STS  263,R30
; 0000 0069 
; 0000 006A // Port L initialization
; 0000 006B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006D PORTL=0x00;
	STS  267,R30
; 0000 006E DDRL=0x00;
	STS  266,R30
; 0000 006F 
; 0000 0070 // Timer/Counter 0 initialization
; 0000 0071 // Clock source: System Clock
; 0000 0072 // Clock value: Timer 0 Stopped
; 0000 0073 // Mode: Normal top=FFh
; 0000 0074 // OC0A output: Disconnected
; 0000 0075 // OC0B output: Disconnected
; 0000 0076 TCCR0A=0x00;
	OUT  0x24,R30
; 0000 0077 TCCR0B=0x00;
	OUT  0x25,R30
; 0000 0078 TCNT0=0x00;
	OUT  0x26,R30
; 0000 0079 OCR0A=0x00;
	OUT  0x27,R30
; 0000 007A OCR0B=0x00;
	OUT  0x28,R30
; 0000 007B 
; 0000 007C // Timer/Counter 1 initialization
; 0000 007D // Clock source: System Clock
; 0000 007E // Clock value: Timer1 Stopped
; 0000 007F // Mode: Normal top=FFFFh
; 0000 0080 // OC1A output: Discon.
; 0000 0081 // OC1B output: Discon.
; 0000 0082 // OC1C output: Discon.
; 0000 0083 // Noise Canceler: Off
; 0000 0084 // Input Capture on Falling Edge
; 0000 0085 // Timer1 Overflow Interrupt: Off
; 0000 0086 // Input Capture Interrupt: Off
; 0000 0087 // Compare A Match Interrupt: Off
; 0000 0088 // Compare B Match Interrupt: Off
; 0000 0089 // Compare C Match Interrupt: Off
; 0000 008A TCCR1A=0x00;
	STS  128,R30
; 0000 008B TCCR1B=0x00;
	STS  129,R30
; 0000 008C TCNT1H=0x00;
	STS  133,R30
; 0000 008D TCNT1L=0x00;
	STS  132,R30
; 0000 008E ICR1H=0x00;
	STS  135,R30
; 0000 008F ICR1L=0x00;
	STS  134,R30
; 0000 0090 OCR1AH=0x00;
	STS  137,R30
; 0000 0091 OCR1AL=0x00;
	STS  136,R30
; 0000 0092 OCR1BH=0x00;
	STS  139,R30
; 0000 0093 OCR1BL=0x00;
	STS  138,R30
; 0000 0094 OCR1CH=0x00;
	STS  141,R30
; 0000 0095 OCR1CL=0x00;
	STS  140,R30
; 0000 0096 
; 0000 0097 // Timer/Counter 2 initialization
; 0000 0098 // Clock source: System Clock
; 0000 0099 // Clock value: Timer2 Stopped
; 0000 009A // Mode: Normal top=FFh
; 0000 009B // OC2A output: Disconnected
; 0000 009C // OC2B output: Disconnected
; 0000 009D ASSR=0x00;
	STS  182,R30
; 0000 009E TCCR2A=0x00;
	STS  176,R30
; 0000 009F TCCR2B=0x00;
	STS  177,R30
; 0000 00A0 TCNT2=0x00;
	STS  178,R30
; 0000 00A1 OCR2A=0x00;
	STS  179,R30
; 0000 00A2 OCR2B=0x00;
	STS  180,R30
; 0000 00A3 
; 0000 00A4 // Timer/Counter 3 initialization
; 0000 00A5 // Clock source: System Clock
; 0000 00A6 // Clock value: Timer3 Stopped
; 0000 00A7 // Mode: Normal top=FFFFh
; 0000 00A8 // OC3A output: Discon.
; 0000 00A9 // OC3B output: Discon.
; 0000 00AA // OC3C output: Discon.
; 0000 00AB // Noise Canceler: Off
; 0000 00AC // Input Capture on Falling Edge
; 0000 00AD // Timer3 Overflow Interrupt: Off
; 0000 00AE // Input Capture Interrupt: Off
; 0000 00AF // Compare A Match Interrupt: Off
; 0000 00B0 // Compare B Match Interrupt: Off
; 0000 00B1 // Compare C Match Interrupt: Off
; 0000 00B2 TCCR3A=0x00;
	STS  144,R30
; 0000 00B3 TCCR3B=0x00;
	STS  145,R30
; 0000 00B4 TCNT3H=0x00;
	STS  149,R30
; 0000 00B5 TCNT3L=0x00;
	STS  148,R30
; 0000 00B6 ICR3H=0x00;
	STS  151,R30
; 0000 00B7 ICR3L=0x00;
	STS  150,R30
; 0000 00B8 OCR3AH=0x00;
	STS  153,R30
; 0000 00B9 OCR3AL=0x00;
	STS  152,R30
; 0000 00BA OCR3BH=0x00;
	STS  155,R30
; 0000 00BB OCR3BL=0x00;
	STS  154,R30
; 0000 00BC OCR3CH=0x00;
	STS  157,R30
; 0000 00BD OCR3CL=0x00;
	STS  156,R30
; 0000 00BE 
; 0000 00BF // Timer/Counter 4 initialization
; 0000 00C0 // Clock source: System Clock
; 0000 00C1 // Clock value: Timer4 Stopped
; 0000 00C2 // Mode: Normal top=FFFFh
; 0000 00C3 // OC4A output: Discon.
; 0000 00C4 // OC4B output: Discon.
; 0000 00C5 // OC4C output: Discon.
; 0000 00C6 // Noise Canceler: Off
; 0000 00C7 // Input Capture on Falling Edge
; 0000 00C8 // Timer4 Overflow Interrupt: Off
; 0000 00C9 // Input Capture Interrupt: Off
; 0000 00CA // Compare A Match Interrupt: Off
; 0000 00CB // Compare B Match Interrupt: Off
; 0000 00CC // Compare C Match Interrupt: Off
; 0000 00CD TCCR4A=0x00;
	STS  160,R30
; 0000 00CE TCCR4B=0x00;
	STS  161,R30
; 0000 00CF TCNT4H=0x00;
	STS  165,R30
; 0000 00D0 TCNT4L=0x00;
	STS  164,R30
; 0000 00D1 ICR4H=0x00;
	STS  167,R30
; 0000 00D2 ICR4L=0x00;
	STS  166,R30
; 0000 00D3 OCR4AH=0x00;
	STS  169,R30
; 0000 00D4 OCR4AL=0x00;
	STS  168,R30
; 0000 00D5 OCR4BH=0x00;
	STS  171,R30
; 0000 00D6 OCR4BL=0x00;
	STS  170,R30
; 0000 00D7 OCR4CH=0x00;
	STS  173,R30
; 0000 00D8 OCR4CL=0x00;
	STS  172,R30
; 0000 00D9 
; 0000 00DA // Timer/Counter 5 initialization
; 0000 00DB // Clock source: System Clock
; 0000 00DC // Clock value: Timer5 Stopped
; 0000 00DD // Mode: Normal top=FFFFh
; 0000 00DE // OC5A output: Discon.
; 0000 00DF // OC5B output: Discon.
; 0000 00E0 // OC5C output: Discon.
; 0000 00E1 // Noise Canceler: Off
; 0000 00E2 // Input Capture on Falling Edge
; 0000 00E3 // Timer5 Overflow Interrupt: Off
; 0000 00E4 // Input Capture Interrupt: Off
; 0000 00E5 // Compare A Match Interrupt: Off
; 0000 00E6 // Compare B Match Interrupt: Off
; 0000 00E7 // Compare C Match Interrupt: Off
; 0000 00E8 TCCR5A=0x00;
	STS  288,R30
; 0000 00E9 TCCR5B=0x00;
	STS  289,R30
; 0000 00EA TCNT5H=0x00;
	STS  293,R30
; 0000 00EB TCNT5L=0x00;
	STS  292,R30
; 0000 00EC ICR5H=0x00;
	STS  295,R30
; 0000 00ED ICR5L=0x00;
	STS  294,R30
; 0000 00EE OCR5AH=0x00;
	STS  297,R30
; 0000 00EF OCR5AL=0x00;
	STS  296,R30
; 0000 00F0 OCR5BH=0x00;
	STS  299,R30
; 0000 00F1 OCR5BL=0x00;
	STS  298,R30
; 0000 00F2 OCR5CH=0x00;
	STS  301,R30
; 0000 00F3 OCR5CL=0x00;
	STS  300,R30
; 0000 00F4 
; 0000 00F5 // External Interrupt(s) initialization
; 0000 00F6 // INT0: Off
; 0000 00F7 // INT1: Off
; 0000 00F8 // INT2: Off
; 0000 00F9 // INT3: Off
; 0000 00FA // INT4: Off
; 0000 00FB // INT5: Off
; 0000 00FC // INT6: Off
; 0000 00FD // INT7: Off
; 0000 00FE EICRA=0x00;
	STS  105,R30
; 0000 00FF EICRB=0x00;
	STS  106,R30
; 0000 0100 EIMSK=0x00;
	OUT  0x1D,R30
; 0000 0101 // PCINT0 interrupt: Off
; 0000 0102 // PCINT1 interrupt: Off
; 0000 0103 // PCINT2 interrupt: Off
; 0000 0104 // PCINT3 interrupt: Off
; 0000 0105 // PCINT4 interrupt: Off
; 0000 0106 // PCINT5 interrupt: Off
; 0000 0107 // PCINT6 interrupt: Off
; 0000 0108 // PCINT7 interrupt: Off
; 0000 0109 // PCINT8 interrupt: Off
; 0000 010A // PCINT9 interrupt: Off
; 0000 010B // PCINT10 interrupt: Off
; 0000 010C // PCINT11 interrupt: Off
; 0000 010D // PCINT12 interrupt: Off
; 0000 010E // PCINT13 interrupt: Off
; 0000 010F // PCINT14 interrupt: Off
; 0000 0110 // PCINT15 interrupt: Off
; 0000 0111 // PCINT16 interrupt: Off
; 0000 0112 // PCINT17 interrupt: Off
; 0000 0113 // PCINT18 interrupt: Off
; 0000 0114 // PCINT19 interrupt: Off
; 0000 0115 // PCINT20 interrupt: Off
; 0000 0116 // PCINT21 interrupt: Off
; 0000 0117 // PCINT22 interrupt: Off
; 0000 0118 // PCINT23 interrupt: Off
; 0000 0119 PCMSK0=0x00;
	STS  107,R30
; 0000 011A PCMSK1=0x00;
	STS  108,R30
; 0000 011B PCMSK2=0x00;
	STS  109,R30
; 0000 011C PCICR=0x00;
	STS  104,R30
; 0000 011D 
; 0000 011E // Timer/Counter 0 Interrupt(s) initialization
; 0000 011F TIMSK0=0x00;
	STS  110,R30
; 0000 0120 // Timer/Counter 1 Interrupt(s) initialization
; 0000 0121 TIMSK1=0x00;
	STS  111,R30
; 0000 0122 // Timer/Counter 2 Interrupt(s) initialization
; 0000 0123 TIMSK2=0x00;
	STS  112,R30
; 0000 0124 // Timer/Counter 3 Interrupt(s) initialization
; 0000 0125 TIMSK3=0x00;
	STS  113,R30
; 0000 0126 // Timer/Counter 4 Interrupt(s) initialization
; 0000 0127 TIMSK4=0x00;
	STS  114,R30
; 0000 0128 // Timer/Counter 5 Interrupt(s) initialization
; 0000 0129 TIMSK5=0x00;
	STS  115,R30
; 0000 012A 
; 0000 012B // Analog Comparator initialization
; 0000 012C // Analog Comparator: Off
; 0000 012D // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 012E ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 012F ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0130 
; 0000 0131 // I2C Bus initialization
; 0000 0132 i2c_init();
	CALL _i2c_init
; 0000 0133 
; 0000 0134 // LCD module initialization
; 0000 0135 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _lcd_init
; 0000 0136 
; 0000 0137 sonarSetRange(0xE0, 50);  // setting range maks (address, nilai maks adc)
	LDI  R30,LOW(224)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _sonarSetRange
; 0000 0138 while (1)
_0x3:
; 0000 0139       {
; 0000 013A       sonarRange(0xE0); //set range
	LDI  R30,LOW(224)
	ST   -Y,R30
	RCALL _sonarRange
; 0000 013B       jarak = sonarGet(0xE0); //minta nilai
	LDI  R30,LOW(224)
	ST   -Y,R30
	RCALL _sonarGet
	__PUTW1R 3,4
; 0000 013C       itoa(jarak, lcd);
	ST   -Y,R4
	ST   -Y,R3
	LDI  R30,LOW(_lcd)
	LDI  R31,HIGH(_lcd)
	ST   -Y,R31
	ST   -Y,R30
	CALL _itoa
; 0000 013D       lcd_puts(lcd);
	LDI  R30,LOW(_lcd)
	LDI  R31,HIGH(_lcd)
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 013E       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 013F       lcd_clear();
	CALL _lcd_clear
; 0000 0140       };
	RJMP _0x3
; 0000 0141 }
_0x6:
	RJMP _0x6
;/**
;@author: vektor dewanto
;@ver: 12 Jan 10
;@desc:
;    srf08 setting
;        set max range:150
;        analog gain:5
;        srf08 read till distance 129 cm for echo 1
;*/
;#include "srf08.h"
;
;bool sonarRange(uint8_t address){
; 0001 000C _Bool sonarRange(uint8_t address){

	.CSEG
_sonarRange:
; 0001 000D    i2c_start();         // send start sequence
;	address -> Y+0
	CALL _i2c_start
; 0001 000E    i2c_write(address);  // SRF08 I2C address with R/W bit: clear = W
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
; 0001 000F    i2c_write(0);        // SRF08 command register address
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_write
; 0001 0010    i2c_write(0x51);     // command to start ranging in cm
	LDI  R30,LOW(81)
	ST   -Y,R30
	CALL _i2c_write
; 0001 0011    i2c_stop();          // send stop sequence
	CALL _i2c_stop
; 0001 0012 
; 0001 0013    return true;
	JMP  _0x20C0002
; 0001 0014 }//end range_order
;
;uint16_t sonarGetRange(uint8_t addr,uint8_t reg){
; 0001 0016 uint16_t sonarGetRange(uint8_t addr,uint8_t reg){
_sonarGetRange:
; 0001 0017    uint8_t hi=0,lo=0,temp=0;
; 0001 0018    uint16_t range=0;
; 0001 0019 
; 0001 001A    //(1) wait till data is available,
; 0001 001B    do{
	CALL __SAVELOCR6
;	addr -> Y+7
;	reg -> Y+6
;	hi -> R17
;	lo -> R16
;	temp -> R19
;	range -> R20,R21
	LDI  R17,0
	LDI  R16,0
	LDI  R19,0
	__GETWRN 20,21,0
_0x20004:
; 0001 001C       i2c_start();              // send start sequence
	CALL SUBOPT_0x0
; 0001 001D       i2c_write(addr);          // SRF08 I2C address with R/W bit:clear = W
; 0001 001E       i2c_write(1);             //write register number:1
	LDI  R30,LOW(1)
	CALL SUBOPT_0x1
; 0001 001F 
; 0001 0020       i2c_start();              // send a restart sequence
; 0001 0021       i2c_write(addr|1);       // SRF08 I2C address with R/W bit: set = R
; 0001 0022       temp=i2c_read(0);         // get the 1st reg nums and send NO acknowledge
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R19,R30
; 0001 0023       i2c_stop();
	CALL _i2c_stop
; 0001 0024    }while(temp == 0xFF);        //the I2C data line (SDA) is pulled high if nothing is driving it
	CPI  R19,255
	BREQ _0x20004
; 0001 0025 
; 0001 0026    //(2) get data available
; 0001 0027    i2c_start();                 // send start sequence
	CALL SUBOPT_0x0
; 0001 0028    i2c_write(addr);             // SRF08 I2C address with R/W bit:clear = W
; 0001 0029    i2c_write(reg);              //write register number
	LDD  R30,Y+6
	CALL SUBOPT_0x1
; 0001 002A    i2c_start();                 // send a restart sequence
; 0001 002B    i2c_write(addr|1);           // SRF08 I2C address with R/W bit: set = R
; 0001 002C    hi = i2c_read(1);            // get the high byte of the range and send acknowledge; regNumber = reg
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R17,R30
; 0001 002D    lo = i2c_read(0);            // get low byte of the range;regNumber = reg+1;Note: NO acknowledgement is sent
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
; 0001 002E    i2c_stop();                  // send stop sequence
	CALL _i2c_stop
; 0001 002F 
; 0001 0030    range=hi;
	MOV  R20,R17
	CLR  R21
; 0001 0031    range<<=8;
	MOV  R21,R20
	CLR  R20
; 0001 0032    range|=lo;
	MOV  R30,R16
	LDI  R31,0
	__ORWRR 20,21,30,31
; 0001 0033 
; 0001 0034    return range;
	MOVW R30,R20
	CALL __LOADLOCR6
	ADIW R28,8
	RET
; 0001 0035 }
;
;uint16_t sonarGetRangeEcho(uint8_t echoNum, uint8_t addr){
; 0001 0037 uint16_t sonarGetRangeEcho(uint8_t echoNum, uint8_t addr){
; 0001 0038     return sonarGetRange(addr,(echoNum*2));
;	echoNum -> Y+1
;	addr -> Y+0
; 0001 0039 }
;
;uint16_t sonarGet(uint8_t addr){
; 0001 003B uint16_t sonarGet(uint8_t addr){
_sonarGet:
; 0001 003C     uint16_t range;
; 0001 003D     range = sonarGetRange(addr,2);
	ST   -Y,R17
	ST   -Y,R16
;	addr -> Y+2
;	range -> R16,R17
	LDD  R30,Y+2
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL _sonarGetRange
	MOVW R16,R30
; 0001 003E     if(range==0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x20006
; 0001 003F       range=50;
	__GETWRN 16,17,50
; 0001 0040     return range;
_0x20006:
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20C0003
; 0001 0041 }
;
;bool sonarSetRange(uint8_t addr,uint16_t rangeMili){
; 0001 0043 _Bool sonarSetRange(uint8_t addr,uint16_t rangeMili){
_sonarSetRange:
; 0001 0044 
; 0001 0045    //NOTE: *)The range is ((Range Register x 43mm) + 43mm)
; 0001 0046    //      *)The range is set to maximum every time the SRF08 is powered-up.
; 0001 0047    i2c_start();
;	addr -> Y+2
;	rangeMili -> Y+0
	CALL _i2c_start
; 0001 0048    i2c_write(addr);
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _i2c_write
; 0001 0049    i2c_write(2);
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _i2c_write
; 0001 004A    i2c_write(
; 0001 004B                ceil(
; 0001 004C                      (float)(rangeMili-43)/43
; 0001 004D                     )
; 0001 004E             );
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,43
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x422C0000
	CALL __DIVF21
	CALL __PUTPARD1
	CALL _ceil
	CALL __CFD1U
	ST   -Y,R30
	CALL _i2c_write
; 0001 004F    i2c_stop();
	CALL _i2c_stop
; 0001 0050 
; 0001 0051    return true;
	LDI  R30,LOW(1)
	JMP  _0x20C0003
; 0001 0052 }
;
;
;bool sonarSetGain(uint8_t addr,uint8_t gain){
; 0001 0055 _Bool sonarSetGain(uint8_t addr,uint8_t gain){
; 0001 0056 
; 0001 0057    i2c_start();
;	addr -> Y+1
;	gain -> Y+0
; 0001 0058    i2c_write(addr);
; 0001 0059    i2c_write(1);
; 0001 005A    i2c_write(gain);
; 0001 005B    i2c_stop();
; 0001 005C 
; 0001 005D    return true;
; 0001 005E }
;
;
;uint8_t sonarGetLight(uint8_t addr){
; 0001 0061 uint8_t sonarGetLight(uint8_t addr){
; 0001 0062    uint8_t light=0,temp=0;
; 0001 0063 
; 0001 0064    //(1) wait till data is available,
; 0001 0065    do
;	addr -> Y+2
;	light -> R17
;	temp -> R16
; 0001 0066    {
; 0001 0067       i2c_start();// send start sequence
; 0001 0068       i2c_write(addr);// SRF08 I2C address with R/W bit:clear = W
; 0001 0069       i2c_write(1);//write register number:1
; 0001 006A 
; 0001 006B       i2c_start();// send a restart sequence
; 0001 006C       i2c_write(addr|1);   // SRF08 I2C address with R/W bit: set = R
; 0001 006D       temp=i2c_read(0);       // get the soft rev nums and send NO acknowledge
; 0001 006E       i2c_stop();
; 0001 006F    }while(temp == 0xFF);//the I2C data line (SDA) is pulled high if nothing is driving it
; 0001 0070 
; 0001 0071    //(2) get Data
; 0001 0072    i2c_start();            // send start sequence
; 0001 0073    i2c_write(addr);     // SRF08 I2C address with R/W bit:clear = W
; 0001 0074    i2c_write(1);         //write register number
; 0001 0075    i2c_start();            // send a restart sequence
; 0001 0076    i2c_write(addr|1);   // SRF08 I2C address with R/W bit: set = R
; 0001 0077    light = i2c_read(0);
; 0001 0078    i2c_stop();
; 0001 0079 
; 0001 007A    return light;
; 0001 007B }
;
;//addr for the old address, target for new address
;bool srf08Addressing(unsigned char addr, unsigned char target){
; 0001 007E _Bool srf08Addressing(unsigned char addr, unsigned char target){
; 0001 007F    i2c_start();		// send start sequence
;	addr -> Y+1
;	target -> Y+0
; 0001 0080    i2c_write(addr);	// accsess SRF08 in address 0xE0
; 0001 0081    i2c_write(0); 	// SRF08 command register address
; 0001 0082    i2c_write(0xA0);	// 1st in sequence to change I2C address
; 0001 0083 
; 0001 0084    i2c_start();		// send start sequence
; 0001 0085    i2c_write(addr);	// accsess SRF08 in address 0xE0
; 0001 0086    i2c_write(0);	// SRF08 command register address
; 0001 0087    i2c_write(0xAA);	// 2nd in sequence to change I2C address
; 0001 0088 
; 0001 0089    i2c_start();		// send start sequence
; 0001 008A    i2c_write(addr);	// accsess SRF08 in address 0xE0
; 0001 008B    i2c_write(0);	// SRF08 command register address
; 0001 008C    i2c_write(0xA5);	// 3rd in sequence to change I2C address
; 0001 008D 
; 0001 008E    i2c_start();//send start sequence
; 0001 008F    i2c_write(addr);	// accsess SRF08 in address 0xE0
; 0001 0090    i2c_write(0);	// SRF08 command register address
; 0001 0091    i2c_write(target);	// change I2C address, choose the target address
; 0001 0092 
; 0001 0093    i2c_stop();		// send stop sequence
; 0001 0094 
; 0001 0095    return true;
; 0001 0096 }//end srf08Addressing
;
;bool sonarTest(uint8_t addr){
; 0001 0098 _Bool sonarTest(uint8_t addr){
; 0001 0099    char lcd[15];
; 0001 009A    //lcd_clear();
; 0001 009B    //lcd_gotoxy(0,0);
; 0001 009C    sonarRange(addr);
;	addr -> Y+15
;	lcd -> Y+0
; 0001 009D    sonarSetRange(addr,3000);
; 0001 009E    //mengganti echo menjadi dua namppil awal langsung 50, tampaknya ditambah gitu
; 0001 009F    ltoa(sonarGetRangeEcho(2,addr),lcd);
; 0001 00A0    lcd_puts(lcd);
; 0001 00A1    delay_ms(300);
; 0001 00A2    lcd_clear();
; 0001 00A3 
; 0001 00A4    //itoa(sonarGetLight(addr),lcd);
; 0001 00A5    //lcd_gotoxy(11,1);lcd_puts(lcd);
; 0001 00A6 
; 0001 00A7    //printf("%d ", sonarGetRangeEcho(1,addr));
; 0001 00A8 
; 0001 00A9    //printf("light: %d\n", sonarGetLight(addr));
; 0001 00AA    return true;
; 0001 00AB }
;
;uint8_t range(uint8_t addr)
; 0001 00AE {
; 0001 00AF    sonarRange(addr);
;	addr -> Y+0
; 0001 00B0    return sonarGet(addr);
; 0001 00B1 }
;
;
;void displayAllSonar()
; 0001 00B5 {
; 0001 00B6 
; 0001 00B7         /*
; 0001 00B8         WindWire's Sonar Location
; 0001 00B9                      __
; 0001 00BA                    _|__|_____
; 0001 00BB                  //          \\SONAR RIGHTDIAG
; 0001 00BC                  /            \
; 0001 00BD                 |              |
; 0001 00BE                ||              ||
; 0001 00BF                 |              |
; 0001 00C0                 |              |
; 0001 00C1                ||______________||
; 0001 00C2                       |__|
; 0001 00C3 
; 0001 00C4 
; 0001 00C5         */
; 0001 00C6 char lcd[16];
; 0001 00C7 
; 0001 00C8 sonarRange(SONAR_FRONT);
;	lcd -> Y+0
; 0001 00C9 itoa(sonarGet(SONAR_FRONT),lcd);
; 0001 00CA lcd_gotoxy(0,0);
; 0001 00CB lcd_puts(lcd);
; 0001 00CC 
; 0001 00CD sonarRange(SONAR_RIGHTDIAG);
; 0001 00CE itoa(sonarGet(SONAR_RIGHTDIAG),lcd);
; 0001 00CF lcd_gotoxy(3,0);
; 0001 00D0 lcd_puts(lcd);
; 0001 00D1 
; 0001 00D2 
; 0001 00D3 sonarRange(SONAR_RIGHTFRONT);
; 0001 00D4 itoa(sonarGet(SONAR_RIGHTFRONT),lcd);
; 0001 00D5 lcd_gotoxy(6,0);
; 0001 00D6 lcd_puts(lcd);
; 0001 00D7 
; 0001 00D8 
; 0001 00D9 sonarRange(SONAR_RIGHTBACK);
; 0001 00DA itoa(sonarGet(SONAR_RIGHTBACK),lcd);
; 0001 00DB lcd_gotoxy(9,0);
; 0001 00DC lcd_puts(lcd);
; 0001 00DD 
; 0001 00DE sonarRange(SONAR_BACK);
; 0001 00DF itoa(sonarGet(SONAR_BACK),lcd);
; 0001 00E0 lcd_gotoxy(12,0);
; 0001 00E1 lcd_puts(lcd);
; 0001 00E2 
; 0001 00E3 sonarRange(SONAR_LEFTBACK);
; 0001 00E4 itoa(sonarGet(SONAR_LEFTBACK),lcd);
; 0001 00E5 lcd_gotoxy(0,1);
; 0001 00E6 lcd_puts(lcd);
; 0001 00E7 
; 0001 00E8 sonarRange(SONAR_LEFTFRONT);
; 0001 00E9 itoa(sonarGet(SONAR_LEFTFRONT),lcd);
; 0001 00EA lcd_gotoxy(3,1);
; 0001 00EB lcd_puts(lcd);
; 0001 00EC 
; 0001 00ED sonarRange(SONAR_LEFTDIAG);
; 0001 00EE itoa(sonarGet(SONAR_LEFTDIAG),lcd);
; 0001 00EF lcd_gotoxy(6,1);
; 0001 00F0 lcd_puts(lcd);
; 0001 00F1 
; 0001 00F2 delay_ms(200);
; 0001 00F3 lcd_clear();
; 0001 00F4 }
;
;void displayAllSonarLight()
; 0001 00F7 {
; 0001 00F8 
; 0001 00F9         /*
; 0001 00FA         WindWire's Sonar Location
; 0001 00FB                      __
; 0001 00FC                    _|__|_____
; 0001 00FD                  //          \\SONAR RIGHTDIAG
; 0001 00FE                  /            \
; 0001 00FF                 |              |
; 0001 0100                ||              ||
; 0001 0101                 |              |
; 0001 0102                 |              |
; 0001 0103                ||______________||
; 0001 0104                       |__|
; 0001 0105 
; 0001 0106 
; 0001 0107         */
; 0001 0108 char lcd[16];
; 0001 0109 
; 0001 010A sonarRange(SONAR_FRONT);
;	lcd -> Y+0
; 0001 010B itoa(sonarGetLight(SONAR_FRONT),lcd);
; 0001 010C lcd_gotoxy(0,0);
; 0001 010D lcd_puts(lcd);
; 0001 010E 
; 0001 010F sonarRange(SONAR_RIGHTDIAG);
; 0001 0110 itoa(sonarGetLight(SONAR_RIGHTDIAG),lcd);
; 0001 0111 lcd_gotoxy(4,0);
; 0001 0112 lcd_puts(lcd);
; 0001 0113 
; 0001 0114 sonarRange(SONAR_RIGHTFRONT);
; 0001 0115 itoa(sonarGetLight(SONAR_RIGHTFRONT),lcd);
; 0001 0116 lcd_gotoxy(8,0);
; 0001 0117 lcd_puts(lcd);
; 0001 0118 
; 0001 0119 sonarRange(SONAR_RIGHTBACK);
; 0001 011A itoa(sonarGetLight(SONAR_RIGHTBACK),lcd);
; 0001 011B lcd_gotoxy(12,0);
; 0001 011C lcd_puts(lcd);
; 0001 011D 
; 0001 011E sonarRange(SONAR_BACK);
; 0001 011F itoa(sonarGetLight(SONAR_BACK),lcd);
; 0001 0120 lcd_gotoxy(0,1);
; 0001 0121 lcd_puts(lcd);
; 0001 0122 
; 0001 0123 sonarRange(SONAR_LEFTBACK);
; 0001 0124 itoa(sonarGetLight(SONAR_LEFTBACK),lcd);
; 0001 0125 lcd_gotoxy(4,1);
; 0001 0126 lcd_puts(lcd);
; 0001 0127 
; 0001 0128 sonarRange(SONAR_LEFTFRONT);
; 0001 0129 itoa(sonarGetLight(SONAR_LEFTFRONT),lcd);
; 0001 012A lcd_gotoxy(8,1);
; 0001 012B lcd_puts(lcd);
; 0001 012C 
; 0001 012D sonarRange(SONAR_LEFTDIAG);
; 0001 012E itoa(sonarGetLight(SONAR_LEFTDIAG),lcd);
; 0001 012F lcd_gotoxy(12,1);
; 0001 0130 lcd_puts(lcd);
; 0001 0131 
; 0001 0132 delay_ms(200);
; 0001 0133 lcd_clear();
; 0001 0134 }
;
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

	.CSEG

	.CSEG
_itoa:
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret

	.DSEG

	.CSEG

	.CSEG
_ftrunc:
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
_ceil:
	CALL SUBOPT_0x2
	CALL __PUTPARD1
	CALL _ftrunc
	CALL __PUTD1S0
    brne __ceil1
__ceil0:
	CALL SUBOPT_0x2
	RJMP _0x20C0004
__ceil1:
    brts __ceil0
	CALL SUBOPT_0x2
	__GETD2N 0x3F800000
	CALL __ADDF12
_0x20C0004:
	ADIW R28,4
	RET
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G103:
    ldi   r31,15
__lcd_delay0:
    dec   r31
    brne  __lcd_delay0
	RET
__lcd_ready:
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
    cbi   __lcd_port,__lcd_rs     ;RS=0
__lcd_busy:
	RCALL __lcd_delay_G103
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G103
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G103
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G103
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
__lcd_write_nibble_G103:
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G103
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G103
	RET
__lcd_write_data:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G103
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G103
    sbi   __lcd_port,__lcd_rd     ;RD=1
	JMP  _0x20C0001
__lcd_read_nibble_G103:
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G103
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G103
    andi  r30,0xf0
	RET
_lcd_read_byte0_G103:
	CALL __lcd_delay_G103
	RCALL __lcd_read_nibble_G103
    mov   r26,r30
	RCALL __lcd_read_nibble_G103
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
_lcd_gotoxy:
	CALL __lcd_ready
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R30,R26
	ST   -Y,R30
	CALL __lcd_write_data
	LDD  R6,Y+1
	LDD  R5,Y+0
	ADIW R28,2
	RET
_lcd_clear:
	CALL __lcd_ready
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(12)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(0)
	MOV  R5,R30
	MOV  R6,R30
	RET
_lcd_putchar:
    push r30
    push r31
    ld   r26,y
    set
    cpi  r26,10
    breq __lcd_putchar1
    clt
	CP   R6,R8
	BRLO _0x2060004
	__lcd_putchar1:
	INC  R5
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R5
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2060004:
	INC  R6
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
    ld   r26,y
    st   -y,r26
    rcall __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	JMP  _0x20C0001
_lcd_puts:
	ST   -Y,R17
_0x2060005:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2060007
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2060005
_0x2060007:
	LDD  R17,Y+0
_0x20C0003:
	ADIW R28,3
	RET
__long_delay_G103:
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
__lcd_init_write_G103:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	CALL __lcd_write_nibble_G103
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x20C0001
_lcd_init:
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R8,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	CALL SUBOPT_0x3
	CALL SUBOPT_0x3
	CALL SUBOPT_0x3
	RCALL __long_delay_G103
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_init_write_G103
	RCALL __long_delay_G103
	LDI  R30,LOW(40)
	CALL SUBOPT_0x4
	LDI  R30,LOW(4)
	CALL SUBOPT_0x4
	LDI  R30,LOW(133)
	CALL SUBOPT_0x4
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	CALL _lcd_read_byte0_G103
	CPI  R30,LOW(0x5)
	BREQ _0x206000B
	LDI  R30,LOW(0)
	RJMP _0x20C0001
_0x206000B:
	CALL __lcd_ready
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL _lcd_clear
_0x20C0002:
	LDI  R30,LOW(1)
_0x20C0001:
	ADIW R28,1
	RET

	.CSEG

	.CSEG

	.DSEG
_lcd:
	.BYTE 0x10
__seed_G101:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	CALL _i2c_start
	LDD  R30,Y+7
	ST   -Y,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_start
	LDD  R30,Y+7
	ORI  R30,1
	ST   -Y,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	CALL __long_delay_G103
	LDI  R30,LOW(48)
	ST   -Y,R30
	JMP  __lcd_init_write_G103

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	CALL __lcd_write_data
	JMP  __long_delay_G103


	.CSEG
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,18
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,37
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xACD
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
