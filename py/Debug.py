from eudplib import *
from eudx import *
import math

def beforeTriggerExec(): # Input : BaseOffset + 0x30

	Temp2 = EUDVariable()
	Temp = EUDVariable()
	Num = EUDVariable()
	Num2 = EUDVariable()
	Off = EUDVariable()
	Line1 = EUDVariable()
	Line2 = EUDVariable()
	Line3 = EUDVariable()
	Line4 = EUDVariable()
	Type1 = EUDVariable()
	Type2 = EUDVariable()
	Type3 = EUDVariable()
	Type4 = EUDVariable()

	Line5 = EUDVariable()
	Type5 = EUDVariable()
	ReadV1 = EUDVariable()
	ReadV2 = EUDVariable()
	ReadV3 = EUDVariable()
	ReadV4 = EUDVariable()
	V1 = EUDVariable()
	V2 = EUDVariable()
	V3 = EUDVariable()
	V4 = EUDVariable()
	VTemp1 = EUDVariable()
	VTemp2 = EUDVariable()
	VTemp3 = EUDVariable()
	VTemp4 = EUDVariable()
	VTemp5 = EUDVariable()
	VTemp6 = EUDVariable()
	VTemp7 = EUDVariable()
	VTemp8 = EUDVariable()

	global BaseOffset
	BaseOffset = 0x58F450
	global BaseOffset2
	BaseOffset2 = 0x58F480
		
	Check = EUDVariable()
	Line = EUDVariable()
	Time = EUDVariable()
	CLine = EUDVariable()
	CType = EUDVariable()
	Remain = EUDVariable()
	CurEPD = EUDVariable()

	if EUDIf()((MemoryX(0x58F448,Exactly,0x1,0x1))):
		
		# print 13 -------------------------------
		Nextptr = EUDVariable()

		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(0) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P1),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(1) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P2),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(2) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P3),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(3) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P4),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(4) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P5),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(5) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P6),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(6) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P7),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		Nextptr << f_maskread_epd(EPD(0x628438), 0xFFFFFFFF)
		if EUDIf()((Nextptr != 0,f_playerexist(7) == 1)):
			DoActions([SetMemory(0x628438,SetTo,0),CreateUnit(1, 0,"Anywhere", P8),SetMemory(0x628438,SetTo,Nextptr)])
		EUDEndIf()
		# Convert to STR --------------------------

		
		DoActions([SetMemory(0x641598 + 12*0, SetTo, 0x0D0D2008)])
		DoActions([SetMemory(0x641598 + 12*1, SetTo, 0x0D0D200E)])
		DoActions([SetMemory(0x641598 + 12*2, SetTo, 0x0D0D200F)])
		DoActions([SetMemory(0x641598 + 12*3, SetTo, 0x0D0D2010)])
		DoActions([SetMemory(0x641598 + 12*4, SetTo, 0x0D0D2011)])
		DoActions([SetMemory(0x641598 + 12*5, SetTo, 0x0D0D2015)])
		DoActions([SetMemory(0x641598 + 12*6, SetTo, 0x0D0D2016)])
		DoActions([SetMemory(0x641598 + 12*7, SetTo, 0x0D0D2017)])
		DoActions([SetMemory(0x641598 + 12*8, SetTo, 0x0D0D2018)])
		DoActions([SetMemory(0x641598 + 12*9, SetTo, 0x0D0D2019)])
		DoActions([SetMemory(0x641598 + 12*10, SetTo, 0x0D0D201B)])
		DoActions([SetMemory(0x641598 + 12*11, SetTo, 0x0D0D201C)])

		DoActions([SetMemory(0x64159C + 12*0, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*0, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*1, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*1, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*2, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*2, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*3, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*3, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*4, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*4, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*5, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*5, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*6, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*6, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*7, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*7, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*8, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*8, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*9, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*9, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*10, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*10, SetTo, 0x20202020)])
		DoActions([SetMemory(0x64159C + 12*11, SetTo, 0x20202020)])
		DoActions([SetMemory(0x6415A0 + 12*11, SetTo, 0x20202020)])

		Num << 0
		Off << 0
		if EUDWhile()((Num < 48)): 
			
			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA,0xF))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF) - 0x9
				Temp2 << 0x40 + Temp
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF)
				Temp2 << 0x30 + Temp
			EUDEndIf()
			DoActions([SetMemoryX(0x6415A0 + Off, SetTo, Temp2*16777216,0xFF000000)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA0,0xF0))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0) - 0x90
				Temp2 << 0x40 + Temp//0x10
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0)
				Temp2 << 0x30 + Temp//0x10
			EUDEndIf()
			DoActions([SetMemoryX(0x6415A0 + Off, SetTo, Temp2*65536,0xFF0000)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA00,0xF00))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF00) - 0x900
				Temp2 << 0x40 + Temp//0x100
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF00)
				Temp2 << 0x30 + Temp//0x100
			EUDEndIf()
			DoActions([SetMemoryX(0x6415A0 + Off, SetTo, Temp2*256,0xFF00)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA000,0xF000))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF000) - 0x9000
				Temp2 << 0x40 + Temp//0x1000
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF000)
				Temp2 << 0x30 + Temp//0x1000
			EUDEndIf()
			DoActions([SetMemoryX(0x6415A0 + Off, SetTo, Temp2,0xFF)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA0000,0xF0000))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0000) - 0x90000
				Temp2 << 0x40 + Temp//0x10000
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0000)
				Temp2 << 0x30 + Temp//0x10000
			EUDEndIf()
			DoActions([SetMemoryX(0x64159C + Off, SetTo, Temp2*16777216,0xFF000000)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA00000,0xF00000))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF00000) - 0x900000
				Temp2 << 0x40 + Temp//0x100000
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF00000)
				Temp2 << 0x30 + Temp//0x100000
			EUDEndIf()
			DoActions([SetMemoryX(0x64159C + Off, SetTo, Temp2*65536,0xFF0000)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA000000,0xF000000))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF000000) - 0x9000000
				Temp2 << 0x40 + Temp//0x1000000
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF000000)
				Temp2 << 0x30 + Temp//0x1000000
			EUDEndIf()
			DoActions([SetMemoryX(0x64159C + Off, SetTo, Temp2*256,0xFF00)])

			if EUDIf()((MemoryX(BaseOffset + Num,AtLeast,0xA0000000,0xF0000000))): 
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0000000) - 0x90000000
				Temp2 << 0x40 + Temp//0x10000000
			if EUDElse()():
				Temp << f_maskread_epd(EPD(BaseOffset + Num), 0xF0000000)
				Temp2 << 0x30 + Temp//0x10000000
			EUDEndIf()
			DoActions([SetMemoryX(0x64159C + Off, SetTo, Temp2,0xFF)])

			Num << Num + 4
			Off << Off + 12
		EUDEndWhile()
		
	EUDEndIf()

	if EUDIf()((MemoryX(0x58F448,Exactly,0x2,0x2))):
		PID = EUDVariable()
		PID << f_maskread_epd(EPD(0x512684), 0xF)
		DoActions(SetCurrentPlayer(PID))

		Line << f_maskread_epd(EPD(0x640B58), 0xF)
		Line1 << Line
		Check << 0
		Trigger(conditions=[MemoryX(0x640B58,Exactly,0,1),Check == 0],actions=[Type1.SetNumber(0),Check.SetNumber(1),DisplayText("\x0E\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1C\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1F\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x02\x0D\x0D00000000 \x0D\x0D\x0D00000000",4)])
		Trigger(conditions=[MemoryX(0x640B58,Exactly,1,1),Check == 0],actions=[Type1.SetNumber(1),Check.SetNumber(1),DisplayText("\x0D\x0D\x0E\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1C\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1F\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x02\x0D\x0D00000000 \x0D\x0D\x0D00000000",4)])
		Line2 << f_maskread_epd(EPD(0x640B58), 0xF)
		Check << 0
		Trigger(conditions=[MemoryX(0x640B58,Exactly,0,1),Check == 0],actions=[Type2.SetNumber(0),Check.SetNumber(1),DisplayText("\x18\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x0F\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x07\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1D\x0D\x0D00000000 \x0D\x0D\x0D00000000",4)])
		Trigger(conditions=[MemoryX(0x640B58,Exactly,1,1),Check == 0],actions=[Type2.SetNumber(1),Check.SetNumber(1),DisplayText("\x0D\x0D\x18\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x0F\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x07\x0D\x0D00000000 \x0D\x0D\x0D00000000 \x1D\x0D\x0D00000000 \x0D\x0D\x0D00000000",4)])
		Line3 << f_maskread_epd(EPD(0x640B58), 0xF)
		Check << 0
		Trigger(conditions=[MemoryX(0x640B58,Exactly,0,1),Check == 0],actions=[Type3.SetNumber(0),Check.SetNumber(1),DisplayText("\x03\x0D\x0D00000000 \x17\x0D\x0D00000000 \x19\x0D\x0D00000000 \x04\x0D\x0D00000000 \x15\x0D\x0D00000000 \x11\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x04\x0D\x0D00000000",4)])
		Trigger(conditions=[MemoryX(0x640B58,Exactly,1,1),Check == 0],actions=[Type3.SetNumber(1),Check.SetNumber(1),DisplayText("\x0D\x0D\x03\x0D\x0D00000000 \x17\x0D\x0D00000000 \x19\x0D\x0D00000000 \x04\x0D\x0D00000000 \x15\x0D\x0D00000000 \x11\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x04\x0D\x0D00000000",4)])
		Line4 << f_maskread_epd(EPD(0x640B58), 0xF)
		Check << 0
		Trigger(conditions=[MemoryX(0x640B58,Exactly,0,1),Check == 0],actions=[Type4.SetNumber(0),Check.SetNumber(1),DisplayText("\x06\x0D\x0D00000000 \x08\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x04\x0D\x0D00000000 \x10\x0D\x0D00000000 \x1E\x0D\x0D00000000 \x02\x0D\x0D00000000 \x05\x0D\x0D00000000",4)])
		Trigger(conditions=[MemoryX(0x640B58,Exactly,1,1),Check == 0],actions=[Type4.SetNumber(1),Check.SetNumber(1),DisplayText("\x0D\x0D\x06\x0D\x0D00000000 \x08\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x04\x0D\x0D00000000 \x10\x0D\x0D00000000 \x1E\x0D\x0D00000000 \x02\x0D\x0D00000000 \x05\x0D\x0D00000000",4)])
		
		if EUDIf()((MemoryX(0x58F448,Exactly,0x10,0x10))): 
			Line5 << f_maskread_epd(EPD(0x640B58), 0xF)
			Check << 0
			Trigger(conditions=[MemoryX(0x640B58,Exactly,0,1),Check == 0],actions=[Type5.SetNumber(0),Check.SetNumber(1),DisplayText("\x0E\x0D\x0D00000000 \x1C\x0D\x0D00000000 \x1F\x0D\x0D00000000 \x0F\x0D\x0D00000000 \x1D\x0D\x0D00000000 \x04\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x05\x0D\x0D00000000",4)])
			Trigger(conditions=[MemoryX(0x640B58,Exactly,1,1),Check == 0],actions=[Type5.SetNumber(1),Check.SetNumber(1),DisplayText("\x0D\x0D\x0E\x0D\x0D00000000 \x1C\x0D\x0D00000000 \x1F\x0D\x0D00000000 \x0F\x0D\x0D00000000 \x1D\x0D\x0D00000000 \x04\x0D\x0D00000000 \x1B\x0D\x0D00000000 \x05\x0D\x0D00000000",4)])
		EUDEndIf()

		DoActions([SetMemory(0x640B58,SetTo,Line)])
		 
		Time << 0
		if EUDWhile()((Time < 4)): 
			Num << 0
			Off << 0
			Trigger(conditions=[Time == 0],actions=[Num2.SetNumber(0),CType.SetNumber(Type1),CLine.SetNumber(Line1)])
			Trigger(conditions=[Time == 1],actions=[Num2.SetNumber(32),CType.SetNumber(Type2),CLine.SetNumber(Line2)])
			Trigger(conditions=[Time == 2],actions=[Num2.SetNumber(64),CType.SetNumber(Type3),CLine.SetNumber(Line3)])
			Trigger(conditions=[Time == 3],actions=[Num2.SetNumber(96),CType.SetNumber(Type4),CLine.SetNumber(Line4)])
			if EUDWhile()((Num < 32)): 
				
				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA,0xF))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF) - 0x9
					Temp2 << 0x40 + Temp
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF)
					Temp2 << 0x30 + Temp
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0,0xF0))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0) - 0x90
					Temp2 << 0x40 + Temp//0x10
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0)
					Temp2 << 0x30 + Temp//0x10
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA00,0xF00))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00) - 0x900
					Temp2 << 0x40 + Temp//0x100
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00)
					Temp2 << 0x30 + Temp//0x100
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*1,0xFF)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA000,0xF000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000) - 0x9000
					Temp2 << 0x40 + Temp//0x1000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000)
					Temp2 << 0x30 + Temp//0x1000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0000,0xF0000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000) - 0x90000
					Temp2 << 0x40 + Temp//0x10000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000)
					Temp2 << 0x30 + Temp//0x10000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA00000,0xF00000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00000) - 0x900000
					Temp2 << 0x40 + Temp//0x100000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00000)
					Temp2 << 0x30 + Temp//0x100000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA000000,0xF000000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000000) - 0x9000000
					Temp2 << 0x40 + Temp//0x1000000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000000)
					Temp2 << 0x30 + Temp//0x1000000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0000000,0xF0000000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000000) - 0x90000000
					Temp2 << 0x40 + Temp//0x10000000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000000)
					Temp2 << 0x30 + Temp//0x10000000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B60 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B62 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])

				Num << Num + 4
				Off << Off + 12
				Num2 << Num2 + 4
			EUDEndWhile()
			Time << Time + 1
		EUDEndWhile()

		if EUDIf()((MemoryX(0x58F448,Exactly,0x10,0x10))): 

			if EUDIf()((V1 != 0)): 
				ReadV1 << f_maskread_epd(EPD(V1),0xFFFFFFFF)
			EUDEndIf()
			if EUDIf()((V2 != 0)): 
				ReadV2 << f_maskread_epd(EPD(V2),0xFFFFFFFF)
			EUDEndIf()
			if EUDIf()((V3 != 0)): 
				ReadV3 << f_maskread_epd(EPD(V3),0xFFFFFFFF)
			EUDEndIf()
			if EUDIf()((V4 != 0)): 
				ReadV4 << f_maskread_epd(EPD(V4),0xFFFFFFFF)
			EUDEndIf()

			VTemp1 << f_maskread_epd(EPD(0x58F500),0xFFFFFFFF)
			VTemp2 << f_maskread_epd(EPD(0x58F504),0xFFFFFFFF)
			VTemp3 << f_maskread_epd(EPD(0x58F508),0xFFFFFFFF)
			VTemp4 << f_maskread_epd(EPD(0x58F50C),0xFFFFFFFF)
			VTemp5 << f_maskread_epd(EPD(0x58F510),0xFFFFFFFF)
			VTemp6 << f_maskread_epd(EPD(0x58F514),0xFFFFFFFF)
			VTemp7 << f_maskread_epd(EPD(0x58F518),0xFFFFFFFF)
			VTemp8 << f_maskread_epd(EPD(0x58F51C),0xFFFFFFFF)

			DoActions([
				SetMemory(0x58F500,SetTo,V1),
				SetMemory(0x58F504,SetTo,ReadV1),
				SetMemory(0x58F508,SetTo,V2),
				SetMemory(0x58F50C,SetTo,ReadV2),
				SetMemory(0x58F510,SetTo,V3),
				SetMemory(0x58F514,SetTo,ReadV3),
				SetMemory(0x58F518,SetTo,V4),
				SetMemory(0x58F51C,SetTo,ReadV4),
			])

			Num << 0
			Off << 0 
			Num2 << 128
			CType << Type5
			CLine << Line5

			if EUDWhile()((Num < 32)): 
				
				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA,0xF))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF) - 0x9
					Temp2 << 0x40 + Temp
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF)
					Temp2 << 0x30 + Temp
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0,0xF0))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0) - 0x90
					Temp2 << 0x40 + Temp//0x10
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0)
					Temp2 << 0x30 + Temp//0x10
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA00,0xF00))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00) - 0x900
					Temp2 << 0x40 + Temp//0x100
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00)
					Temp2 << 0x30 + Temp//0x100
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B68 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B6A + CLine*218 + Off, SetTo, Temp2*1,0xFF)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA000,0xF000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000) - 0x9000
					Temp2 << 0x40 + Temp//0x1000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000)
					Temp2 << 0x30 + Temp//0x1000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0000,0xF0000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000) - 0x90000
					Temp2 << 0x40 + Temp//0x10000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000)
					Temp2 << 0x30 + Temp//0x10000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*65536,0xFF0000)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA00000,0xF00000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00000) - 0x900000
					Temp2 << 0x40 + Temp//0x100000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF00000)
					Temp2 << 0x30 + Temp//0x100000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*256,0xFF00)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA000000,0xF000000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000000) - 0x9000000
					Temp2 << 0x40 + Temp//0x1000000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF000000)
					Temp2 << 0x30 + Temp//0x1000000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B64 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B66 + CLine*218 + Off, SetTo, Temp2*1,0xFF)])

				if EUDIf()((MemoryX(BaseOffset2 + Num2,AtLeast,0xA0000000,0xF0000000))): 
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000000) - 0x90000000
					Temp2 << 0x40 + Temp//0x10000000
				if EUDElse()():
					Temp << f_maskread_epd(EPD(BaseOffset2 + Num2), 0xF0000000)
					Temp2 << 0x30 + Temp//0x10000000
				EUDEndIf()
				Trigger(conditions=[CType == 0],actions=[SetMemoryX(0x640B60 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])
				Trigger(conditions=[CType == 1],actions=[SetMemoryX(0x640B62 + CLine*218 + Off, SetTo, Temp2*16777216,0xFF000000)])

				Num << Num + 4
				Off << Off + 12
				Num2 << Num2 + 4
			EUDEndWhile()

			DoActions([
				SetMemory(0x58F500,SetTo,VTemp1),
				SetMemory(0x58F504,SetTo,VTemp2),
				SetMemory(0x58F508,SetTo,VTemp3),
				SetMemory(0x58F50C,SetTo,VTemp4),
				SetMemory(0x58F510,SetTo,VTemp5),
				SetMemory(0x58F514,SetTo,VTemp6),
				SetMemory(0x58F518,SetTo,VTemp7),
				SetMemory(0x58F51C,SetTo,VTemp8),
			])
		EUDEndIf()
	EUDEndIf()

	if EUDIf()((MemoryX(0x58F448,Exactly,0x4,0x24))):
		Line << 0
		if EUDWhile()((Line < 11)): 
			Off << 0
			if EUDWhile()((Off < 16)): 
				Remain << (0x640B64 + Line*218 + Off)%4
				CurEPD << EPD(0x640B64+Line*218+Off)

				if EUDIf()((Remain == 0)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x7C*257,0,0xFFFF))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF0000) - 0x400000)*0x10 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF0000) - 0x300000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x40000000)//0x100 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x30000000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x1000 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000) + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)//0x1000 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)*0x100000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)*0x100 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)//0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x10000 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)//0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x100000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)
						EUDEndIf()

						if EUDIf()((Temp >= 0x500000, Temp < 0x700000)): 
							DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x05*257,0,0xFFFF)])
						EUDEndIf()
					EUDEndIf()
				if EUDElseIf()((Remain == 1)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x7C*65792,0,0xFFFF00))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x40000000)//0x10 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x30000000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x10000 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x10 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)//0x100 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x100000 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)*0x1000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000) + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x100000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)//0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x10000 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)//0x100
						EUDEndIf()

						if EUDIf()((Temp >= 0x500000, Temp < 0x700000)): 
							DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x05*65792,0,0xFFFF00)])
						EUDEndIf()
					EUDEndIf()
				if EUDElseIf()((Remain == 2)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x7C*16842752,0,0xFFFF0000))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x100000 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x100 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)//0x10 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x10000 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x10 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)//0x100
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)*0x10 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x1000000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x1000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x1000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000) + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)//0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()

						if EUDIf()((Temp >= 0x500000, Temp < 0x700000)): 
							DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x05*16842752,0,0xFFFF0000)])
						EUDEndIf()
					EUDEndIf()
				if EUDElseIf()((Remain == 3)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x7C*16777216,0,0xFF000000),DeathsX(CurEPD+1,Exactly,0,0x7C*1,0xFF))): # ||ABCDEF 12345678
						
						Temp << 0
						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x1000 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000) + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x1000 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x100 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)//0x10 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x10000000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x10000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x10000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)*0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000) + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x1000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()

						if EUDIf()((Temp >= 0x500000, Temp < 0x700000)): 
							DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x05*16777216,0,0xFF000000),SetDeathsX(CurEPD+1,SetTo,0x05,0,0xFF)])
						EUDEndIf()
					EUDEndIf()
				EUDEndIf()
				Off << Off + 1
			EUDEndWhile()
			Line << Line + 1
		EUDEndWhile()
	EUDEndIf()

	if EUDIf()((MemoryX(0x58F448,Exactly,0x24,0x24))):
		Line << 0
		if EUDWhile()((Line < 11)): 
			Off << 0
			if EUDWhile()((Off < 16)): 
				Remain << (0x640B63 + Line*218 + Off)%4
				CurEPD << EPD(0x640B63+Line*218+Off)

				if EUDIf()((Remain == 0)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x23*257,0,0xFFFF))): # ##ABCDEF90 12345678 

						Temp << 0
						if EUDIf()((DeathsX(CurEPD,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF0000) - 0x400000)*0x1000 + 0x90000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF0000) - 0x300000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x40000000) + 0x9000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x30000000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x100000 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x100 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)//0x10 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x10000 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x10 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)//0x100
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)*0x10 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x1000000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x1000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x1000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000) + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)//0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()

						DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x9286,0,0xFFFF),SetDeathsX(CurEPD-1,SetTo,0xE2022000,0,0xFFFFFF00)])
					EUDEndIf()

					if EUDIf()((DeathsX(CurEPD,Exactly,0x40*257,0,0xFFFF))): # @@ReadV1 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)*0x100000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)*0x100 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)//0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x10000 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)//0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x100000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)
						EUDEndIf()

						Trigger(conditions=[Temp==1],actions=[V1.SetNumber(Temp2)])
						Trigger(conditions=[Temp==2],actions=[V2.SetNumber(Temp2)])
						Trigger(conditions=[Temp==3],actions=[V3.SetNumber(Temp2)])
						Trigger(conditions=[Temp==4],actions=[V4.SetNumber(Temp2)])
						DoActions([SetDeathsX(CurEPD,SetTo,0x9486,0,0xFFFF),SetDeathsX(CurEPD-1,SetTo,0xE2042000,0,0xFFFFFF00)])
					EUDEndIf()
				if EUDElseIf()((Remain == 1)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x23*65792,0,0xFFFF00))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x40000000)*0x10 + 0x90000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD, 0xFF000000) - 0x30000000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x1000000 + 0x9000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x1000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x1000 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000) + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x1000 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x100 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)//0x10 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()


						Temp2 << 0

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x10000000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x10000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x10000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)*0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000) + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x1000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()

						DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x9286E2,0,0xFFFFFF),SetDeathsX(CurEPD-1,SetTo,0x02200000,0,0xFFFF0000)])
					EUDEndIf()

					if EUDIf()((DeathsX(CurEPD,Exactly,0x40*65792,0,0xFFFF00))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)*0x1000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000) + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x100000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)//0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x10000 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)//0x100
						EUDEndIf()

						Trigger(conditions=[Temp==1],actions=[V1.SetNumber(Temp2)])
						Trigger(conditions=[Temp==2],actions=[V2.SetNumber(Temp2)])
						Trigger(conditions=[Temp==3],actions=[V3.SetNumber(Temp2)])
						Trigger(conditions=[Temp==4],actions=[V4.SetNumber(Temp2)])
						DoActions([SetDeathsX(CurEPD,SetTo,0x9486E2,0,0xFFFFFF),SetDeathsX(CurEPD-1,SetTo,0x04200000,0,0xFFFF0000)])
					EUDEndIf()
				if EUDElseIf()((Remain == 2)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x23*16842752,0,0xFFFF0000))): # ||ABCDEF 12345678

						Temp << 0
						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x40)*0x10000000 + 0x90000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF) - 0x30)*0x10000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x10000 + 0x9000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)*0x10 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x100 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x1000 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000) + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)//0x1000 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()


						Temp2 << 0

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x100000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)*0x100 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x10000 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)*0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x40000000)//0x100000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x30000000)//0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+5,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF) - 0x30)
						EUDEndIf()

						DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD,SetTo,0x9286E202,0,0xFFFFFFFF),SetDeathsX(CurEPD-1,SetTo,0x20000000,0,0xFF000000)])
					EUDEndIf()

					if EUDIf()((DeathsX(CurEPD,Exactly,0x40*16842752,0,0xFFFF0000))): # ||ABCDEF 12345678

						Temp << 0

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)//0x100
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)*0x10 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x1000000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x1000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x1000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000) + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x100 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)//0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()

						Trigger(conditions=[Temp==1],actions=[V1.SetNumber(Temp2)])
						Trigger(conditions=[Temp==2],actions=[V2.SetNumber(Temp2)])
						Trigger(conditions=[Temp==3],actions=[V3.SetNumber(Temp2)])
						Trigger(conditions=[Temp==4],actions=[V4.SetNumber(Temp2)])
						DoActions([SetDeathsX(CurEPD,SetTo,0x9486E204,0,0xFFFFFFFF),SetDeathsX(CurEPD-1,SetTo,0x20000000,0,0xFF000000)])
					EUDEndIf()
				if EUDElseIf()((Remain == 3)):
					if EUDIf()((DeathsX(CurEPD,Exactly,0x23*16777216,0,0xFF000000),DeathsX(CurEPD+1,Exactly,0,0x23*1,0xFF))): # ||ABCDEF 12345678
						
						Temp << 0
						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x4000)*0x100000 + 0x90000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF00) - 0x3000)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x400000)*0x100 + 0x9000000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF0000) - 0x300000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+1,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x40000000)//0x10 + 0x900000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+1, 0xFF000000) - 0x30000000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x40)*0x10000 + 0x90000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF) - 0x30)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x4000,0,0xFF00))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x4000)*0x10 + 0x9000
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF00) - 0x3000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)//0x100 + 0x900
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x40000000,0,0xFF000000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x40000000)//0x100000 + 0x90
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF000000) - 0x30000000)//0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp << Temp + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40) + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)
						EUDEndIf()


						Temp2 << 0

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)*0x1000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000) + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x100000 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x100000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000)*0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)*0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x10 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x40000000)//0x10000 + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x30000000)//0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+5,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF) - 0x40)*0x10 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF) - 0x30)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+5,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF00) - 0x4000)//0x100 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+5, 0xFF00) - 0x3000)//0x100
						EUDEndIf()

						DoActions([SetMemory(Temp,SetTo,Temp2),SetDeathsX(CurEPD+1,SetTo,0x92,0,0xFF),SetDeathsX(CurEPD,SetTo,0x86E20220,0,0xFFFFFFFF)])
					EUDEndIf()
					if EUDIf()((DeathsX(CurEPD,Exactly,0x40*16777216,0,0xFF000000),DeathsX(CurEPD+1,Exactly,0,0x40*1,0xFF))): # ||ABCDEF 12345678
						
						Temp << 0
						if EUDIf()((DeathsX(CurEPD+2,AtLeast,0x400000,0,0xFF0000))): 
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x400000)//0x10000 + 0x9
						if EUDElse()():
							Temp << Temp + (f_maskread_epd(CurEPD+2, 0xFF0000) - 0x300000)//0x10000
						EUDEndIf()


						Temp2 << 0
						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x40)*0x10000000 + 0x90000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF) - 0x30)*0x10000000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x4000)*0x10000 + 0x9000000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF00) - 0x3000)*0x10000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x400000)*0x10 + 0x900000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF0000) - 0x300000)*0x10
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+3,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x40000000)//0x100 + 0x90000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+3, 0xFF000000) - 0x30000000)//0x100
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40,0,0xFF))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x40)*0x1000 + 0x9000
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF) - 0x30)*0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x4000,0,0xFF00))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x4000) + 0x900
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF00) - 0x3000)
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x400000,0,0xFF0000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x400000)//0x1000 + 0x90
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF0000) - 0x300000)//0x1000
						EUDEndIf()

						if EUDIf()((DeathsX(CurEPD+4,AtLeast,0x40000000,0,0xFF000000))): 
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x40000000)//0x1000000 + 0x9
						if EUDElse()():
							Temp2 << Temp2 + (f_maskread_epd(CurEPD+4, 0xFF000000) - 0x30000000)//0x1000000
						EUDEndIf()

						Trigger(conditions=[Temp==1],actions=[V1.SetNumber(Temp2)])
						Trigger(conditions=[Temp==2],actions=[V2.SetNumber(Temp2)])
						Trigger(conditions=[Temp==3],actions=[V3.SetNumber(Temp2)])
						Trigger(conditions=[Temp==4],actions=[V4.SetNumber(Temp2)])
						DoActions([SetDeathsX(CurEPD+1,SetTo,0x94,0,0xFF),SetDeathsX(CurEPD,SetTo,0x86E20420,0,0xFFFFFFFF)])
					EUDEndIf()
				EUDEndIf()
				Off << Off + 1
			EUDEndWhile()
			Line << Line + 1
		EUDEndWhile()
	EUDEndIf()
