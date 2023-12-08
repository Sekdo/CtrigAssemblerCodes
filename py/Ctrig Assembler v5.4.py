from eudplib import *
from eudx import *
import math

PRT_SetInliningRate(0)

NSQCASM = EUDVariable()
EUDRegisterObjectToNamespace("NSQCASM", NSQCASM)

def f_maskread_epdZ(targetplayer, mask, _readerdict={}):

	if mask in _readerdict:
		readerf = _readerdict[mask]
	else:
		def bits(n):
			while n:
				b = n & (~n+1)
				yield b
				n ^= b

		@EUDFunc
		def readerf(targetplayer):

			f_setcurpl(targetplayer)

			ret = EUDVariable()
			ret << -1452249

			# Fill flags
			for i in bits(mask):
				RawTrigger(
					conditions=[
						DeathsX(CurrentPlayer, Exactly, i, 0, i)
					],
					actions=[
						ret.AddNumber(i//4)
					]
				)

			return ret

		_readerdict[mask] = readerf

	return readerf(targetplayer)

def f_maskread_epdY(targetplayer, mask, _readerdict={}):

	if mask in _readerdict:
		readerf = _readerdict[mask]
	else:
		def bits(n):
			while n:
				b = n & (~n+1)
				yield b
				n ^= b

		@EUDFunc
		def readerf(targetplayer):

			f_setcurpl(targetplayer)

			ret = EUDVariable()
			ret << 0

			# Fill flags
			for i in bits(mask):
				RawTrigger(
					conditions=[
						DeathsX(CurrentPlayer, Exactly, i, 0, i)
					],
					actions=[
						ret.AddNumber(i)
					]
				)

			return ret

		_readerdict[mask] = readerf

	return readerf(targetplayer)


def f_maskread_epdX(mask, _readerdict={}):

	if mask in _readerdict:
		readerf = _readerdict[mask]
	else:
		def bits(n):
			while n:
				b = n & (~n+1)
				yield b
				n ^= b

		@EUDFunc
		def readerf():

			ret = EUDVariable()
			ret << 0

			# Fill flags
			for i in bits(mask):
				RawTrigger(
					conditions=[
						DeathsX(CurrentPlayer, Exactly, i, 0, i)
					],
					actions=[
						ret.AddNumber(i)
					]
				)

			return ret

		_readerdict[mask] = readerf

	return readerf()

def bits(n):
	while n:
		b = n & (~n+1)
		yield b
		n ^= b

def onPluginStart(): # Ctrig Assembler v5.3 for Tep Made by Ninfia
	global NSQCASM
	global Prohibited_Label 
	Prohibited_Label = 0xFFE0
	CtrigLoop = EUDVariable()
	CurrentTrig_1 = EUDVariable()
	CurrentTrig_1EPD = EUDVariable()
	CurrentTrig_1Index = EUDVariable()
	CurrentTrig_1Next = EUDVariable()
	ptr_1 = EUDVariable()
	ptrloopend_1 = EUDVariable()

	CurrentTrig_2 = EUDVariable()
	CurrentTrig_2EPD = EUDVariable()
	CurrentTrig_2Index = EUDVariable()
	CurrentTrig_2Next = EUDVariable()
	ptr_2 = EUDVariable()
	ptrloopend_2 = EUDVariable()

	# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	Table = Db(0x400000)
	TableNext = Db(0x400000)
	Tableptr = EUDVariable()
	TableNextptr = EUDVariable()
	Tableptr << EPD(Table)
	TableNextptr << EPD(TableNext)
	TableAdd = EUDVariable()

	PrevCp = EUDVariable()
	PrevCp << f_getcurpl()

	StartIndex1, StartIndex2 = Forward(), Forward()

	if EUDWhile()((CtrigLoop <= 7)): 

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 1
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 2
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 3
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 4
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 5
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 0,f_playerexist(6) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 6
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 0,f_playerexist(6) == 0,f_playerexist(7) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 7
		EUDEndIf()

		Tableptr << EPD(Table) + CtrigLoop * 0x20000
		TableNextptr << EPD(TableNext) + CtrigLoop * 0x20000

		CurrentTrig_1 << f_maskread_epd(EPD(0x51A280 + 0x8 + 0xC * CtrigLoop), 0x7FFFFFFF)

		if EUDWhile()((CurrentTrig_1Index != 0xFFFF)): # 1st Loop -- Create Table

			DoActions(ptr_1.AddNumber(1))

			if EUDIf()((ptr_1 <= 3)): # Check Label
				CurrentTrig_1 << f_maskread_epd(EPD(CurrentTrig_1 + 0x4),0x7FFFFFFF)
				CurrentTrig_1EPD << EPD(CurrentTrig_1)
				f_setcurpl(CurrentTrig_1EPD+5)
			if EUDElse()():
				RawTrigger(actions=[CurrentTrig_1.AddNumber(0x970),CurrentTrig_1EPD.AddNumber(0x970//4),SetMemory(0x6509B0,Add,0x970//4)])
			EUDEndIf()

			if EUDIf()((DeathsX(CurrentPlayer,Exactly,0xFE*16777216,0,0xFF000000))): # Check Label (CurrentTrig_1EPD+5)
				StartIndex1 << RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])

				if EUDIf()((Deaths(CurrentPlayer,Exactly,0xFFFB,0))):
					RawTrigger(actions=[SetMemory(0x6509B0,Add,8)])
					Trigger(conditions=[Deaths(CurrentPlayer,Exactly,CtrigLoop,0)],actions=[NSQCASM.SetNumber(CurrentTrig_1EPD+87-604*7),SetDeaths(EPD(StartIndex1)+1,SetTo,StartIndex2,0),SetMemory(0x6509B0,Subtract,8)])
				EUDEndIf()
				StartIndex2 << NextTrigger()										

				if EUDIf()((Deaths(CurrentPlayer,AtLeast,1,0))): # (CurrentTrig_1EPD+4)
					CurrentTrig_1Index << f_maskread_epdX(0x1FFFF) # (CurrentTrig_1EPD+4)
					DoActions([SetDeaths(Tableptr+CurrentTrig_1Index,SetTo,CurrentTrig_1,0),SetDeaths(TableNextptr+CurrentTrig_1Index,SetTo,CurrentTrig_1+0x970,0)])
				EUDEndIf()
				RawTrigger(actions=[SetMemory(0x6509B0,Add,1)])
			EUDEndIf()

		EUDEndWhile()

		CtrigLoop << CtrigLoop + 1
		ptr_1 << 0
		ptrloopend_1 << 0
		CurrentTrig_1Index << 0

		if EUDIf()((f_playerexist(1) == 0,CtrigLoop == 1)): # Remove Error
			CtrigLoop << 2
		EUDEndIf()

		if EUDIf()((f_playerexist(2) == 0,CtrigLoop == 2)): # Remove Error
			CtrigLoop << 3
		EUDEndIf()

		if EUDIf()((f_playerexist(3) == 0,CtrigLoop == 3)): # Remove Error
			CtrigLoop << 4
		EUDEndIf()

		if EUDIf()((f_playerexist(4) == 0,CtrigLoop == 4)): # Remove Error
			CtrigLoop << 5
		EUDEndIf()

		if EUDIf()((f_playerexist(5) == 0,CtrigLoop == 5)): # Remove Error
			CtrigLoop << 6
		EUDEndIf()

		if EUDIf()((f_playerexist(6) == 0,CtrigLoop == 6)): # Remove Error
			CtrigLoop << 7
		EUDEndIf()

		if EUDIf()((f_playerexist(7) == 0,CtrigLoop == 7)): # Remove Error
			CtrigLoop << 8
		EUDEndIf()

	EUDEndWhile() 
	
	# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	CondLoop = EUDVariable()
	ActLoop = EUDVariable()
	CondIndex = EUDVariable()
	CondPlayer = EUDVariable()
	Targetptr = EUDVariable()
	TableEPD = EUDVariable()
	TableNextEPD = EUDVariable()
	CurTableptr = EUDVariable()
	CurTableNextptr = EUDVariable()
	ActIndex1 = EUDVariable()
	ActIndex2 = EUDVariable()
	ActPlayer1 = EUDVariable()
	ActPlayer2 = EUDVariable()
	CurTableptr1 = EUDVariable()
	CurTableptr2 = EUDVariable()
	CurTableNextptr1 = EUDVariable()
	CurTableNextptr2 = EUDVariable()
	Targetptr1 = EUDVariable()
	Targetptr2 = EUDVariable()

	Tableptr << EPD(Table)
	TableNextptr << EPD(TableNext)
	TableEPD << EPD(Table)
	TableNextEPD << EPD(TableNext) 
	CtrigLoop << 0

	if EUDWhile()((CtrigLoop <= 7)): 

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 1
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 2
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 3
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 4
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 5
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 0,f_playerexist(6) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 6
		EUDEndIf()

		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 0,f_playerexist(5) == 0,f_playerexist(6) == 0,f_playerexist(7) == 1,CtrigLoop == 0)): # Remove Error
			CtrigLoop << 7
		EUDEndIf()
		
		Tableptr << EPD(Table) + CtrigLoop * 0x20000
		TableNextptr << EPD(TableNext) + CtrigLoop * 0x20000

		CurrentTrig_2 << f_maskread_epd(EPD(0x51A280 + 0x8 + 0xC * CtrigLoop), 0xFFFFFFFF)
		
		if EUDWhile()((CurrentTrig_2Index != 0xFFFF)): # 2nd Loop -- Patch Ctrig

			DoActions(ptr_2.AddNumber(1))

			if EUDIf()((ptr_2 <= 3)): # Check Label
				CurrentTrig_2 << f_maskread_epd(EPD(CurrentTrig_2 + 0x4),0xFFFFFFFF)
				CurrentTrig_2EPD << EPD(CurrentTrig_2)
				f_setcurpl(CurrentTrig_2EPD+5)
			if EUDElse()():
				RawTrigger(actions=[CurrentTrig_2.AddNumber(0x970),CurrentTrig_2EPD.AddNumber(0x970//4),SetMemory(0x6509B0,Add,0x970//4)])
			EUDEndIf()

			#----------------------------------------------------------------------------------------

			if EUDIf()((DeathsX(CurrentPlayer,Exactly,0xFE*16777216,0,0xFF000000))): # Check Label (CurrentTrig_2EPD+5)

				DoActions([SetDeathsX(CurrentPlayer,SetTo,0x0F*16777216,0,0xFF000000)]) # Clear Label (CurrentTrig_2EPD+5)

				RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])
				if EUDIf()((Deaths(CurrentPlayer,AtLeast,1,0))): # (CurrentTrig_2EPD+4)
					CurrentTrig_2Index << f_maskread_epdX(0x1FFFF) # Check CtrigEnd (CurrentTrig_2EPD+4)
				EUDEndIf()

			#----------------------------------------------------------------------------------------
				f_setcurpl(CurrentTrig_2EPD+10)
				RawTrigger(actions=[CondLoop.SetNumber(10)]) # Condition Patch
							
				if EUDWhile()((CondLoop <= 80,DeathsX(CurrentPlayer,AtLeast,0x01*16777216,0,0xFF000000))): # (CurrentTrig_2EPD+CondLoop) +10 per+5

					 #CondEPD = (CurrentTrig_2EPD+CondLoop-3)

					if EUDIf()((DeathsX(CurrentPlayer,Exactly,0xFF*16777216,0,0xFF000000))): # Check Cond Type CondEPD3 = CurrentTrig_2EPD+CondLoop
						
						RawTrigger(actions=[SetDeathsX(CurrentPlayer,SetTo,0x0F*16777216,0,0xFF000000),SetMemory(0x6509B0,Add,1)]) # Cond Type CondEPD3

						#RawTrigger(conditions=[DeathsX(CurrentPlayer,Exactly,0x20,0,0x20)],actions=[SetDeathsX(CurrentPlayer,SetTo,0x43530000,0,0xFFFF0000)]) # Mflag - eudx CondEPD4 CondEPD4

						if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x40,0,0x40))): # Cflag CondEPD4
							CondIndex << Prohibited_Label
							DoActions([SetDeaths(Tableptr+Prohibited_Label,SetTo,CurrentTrig_2,0)]) 
							DoActions([SetDeaths(TableNextptr+Prohibited_Label,SetTo,CurrentTrig_2+0x970,0)]) 
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF),SetMemory(0x6509B0,Add,1)]) # Index CondEPD3
						if EUDElse()():
							CondIndex << 0
							RawTrigger(conditions=[DeathsX(CurrentPlayer,Exactly,0x80,0,0x80)],actions=[CondIndex.SetNumber(0x10000)]) # CondEPD4
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])
							for i in bits(0xFFFF): # CondIndex << f_maskread_epdX(0xFFFF)  # Index CondEPD3
								RawTrigger(
									conditions=[
										DeathsX(CurrentPlayer, Exactly, i, 0, i)
									],
									actions=[
										CondIndex.AddNumber(i)
									]
								)
							RawTrigger(actions=[SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF),SetMemory(0x6509B0,Add,1)]) # Index CondEPD3
						EUDEndIf()

						if EUDIf()((DeathsX(CurrentPlayer,Exactly,0,0,0xF))): # Pflag CondEPD4
							CurTableptr << Tableptr
							CurTableNextptr << TableNextptr
						if EUDElse()(): # ExCtrig
							CondPlayer << (f_maskread_epdX(0xF) - 1) * 0x20000 # CondEPD4
							CurTableptr << TableEPD + CondPlayer
							CurTableNextptr << TableNextEPD + CondPlayer
						EUDEndIf()

						if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x10,0,0x10))): # Nflag CondEPD4
							Targetptr << f_maskread_epdZ(CurTableNextptr+CondIndex,0xFFFFFFFC) # Nextptr EPD()
							DoActions([SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+CondLoop-2),SetDeaths(CurrentPlayer,Add,Targetptr,0),SetMemory(0x6509B0,Add,3)]) # CondEPD1
						if EUDElse()():
							Targetptr << f_maskread_epdZ(CurTableptr+CondIndex,0xFFFFFFFC) # ptr EPD()
							DoActions([SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+CondLoop-2),SetDeaths(CurrentPlayer,Add,Targetptr,0),SetMemory(0x6509B0,Add,3)]) # CondEPD1
						EUDEndIf()

						RawTrigger(actions=[SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),SetMemory(0x6509B0,Subtract,1)]) # Clear Cond CondEPD4

					EUDEndIf()

					RawTrigger(actions=[CondLoop.AddNumber(5),SetMemory(0x6509B0,Add,5)])

				EUDEndWhile()

				#----------------------------------------------------------------------------------------
				f_setcurpl(CurrentTrig_2EPD+88)
				RawTrigger(actions=[ActLoop.SetNumber(88)]) # Action Patch
				
				if EUDWhile()((ActLoop <= 592,DeathsX(CurrentPlayer,AtLeast,0x01*65536,0,0xFF0000))): # (CurrentTrig_2EPD+ActLoop) +88 per+8

					 #ActEPD = (CurrentTrig_2EPD+ActLoop-6)

					if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x5*65536,0,0xFF0000))): # Check Act Type ActEPD6

						RawTrigger(actions=[SetDeathsX(CurrentPlayer,SetTo,0x2D*65536,0,0xFF0000),SetMemory(0x6509B0,Subtract,3)]) # Act Type ActEPD6

						# Mflag ActEPD3
						#RawTrigger(conditions=[DeathsX(CurrentPlayer,Exactly,0x40,0,0x40)],actions=[SetMemory(0x6509B0,Add,4),SetDeathsX(CurrentPlayer,SetTo,0x43530000,0,0xFFFF0000),SetMemory(0x6509B0,Subtract,4)]) # eudx	ActEPD7

						if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x80,0,0x80))): # Cflag2 ActEPD3
							ActIndex2 << Prohibited_Label
							DoActions([SetDeaths(Tableptr+Prohibited_Label,SetTo,CurrentTrig_2,0)])
							DoActions([SetDeaths(TableNextptr+Prohibited_Label,SetTo,CurrentTrig_2+0x970,0)])
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])
						if EUDElse()():
							RawTrigger(actions=[SetMemory(0x6509B0,Add,3)])
							ActIndex2 << f_maskread_epdX(0xFFFF) # Index2 ActEPD6
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,4)])
							RawTrigger(conditions=[DeathsX(CurrentPlayer,Exactly,0x80,0,0x80)],actions=[ActIndex2.AddNumber(0x10000)]) # Xflag2 ActEPD2
						EUDEndIf()

						if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x20,0,0x20))): # Cflag1 ActEPD2
							ActIndex1 << Prohibited_Label
							DoActions([SetDeaths(Tableptr+Prohibited_Label,SetTo,CurrentTrig_2,0)])
							DoActions([SetDeaths(TableNextptr+Prohibited_Label,SetTo,CurrentTrig_2+0x970,0)])
						if EUDElse()():
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])
							ActIndex1 << f_maskread_epdX(0xFFFF) # Index1 ActEPD1
							RawTrigger(actions=[SetMemory(0x6509B0,Add,1)])
							RawTrigger(conditions=[DeathsX(CurrentPlayer,Exactly,0x40,0,0x40)],actions=[ActIndex1.AddNumber(0x10000)]) # Xflag1 ActEPD2
						EUDEndIf()

						if EUDIf()((ActIndex1 >= 1)): # Patch EPD

							if EUDIf()((DeathsX(CurrentPlayer,Exactly,0,0,0xF))): # Pflag1 ActEPD2
								CurTableptr1 << Tableptr
								CurTableNextptr1 << TableNextptr
							if EUDElse()(): # ExSetCtrig
								ActPlayer1 << (f_maskread_epdX(0xF) - 1) * 0x20000 #ActEPD2
								CurTableptr1 << TableEPD + ActPlayer1
								CurTableNextptr1 << TableNextEPD + ActPlayer1
							EUDEndIf()

							if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x10,0,0x10))): # Nflag1 ActEPD2
								Targetptr1 << f_maskread_epdZ(CurTableNextptr1+ActIndex1,0xFFFFFFFC) # Nextptr1 EPD()
								Trigger(actions=[SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+ActLoop-2),SetDeaths(CurrentPlayer,Add,Targetptr1,0),SetMemory(0x6509B0,Subtract,2)]) #ActEPD4
							if EUDElse()():
								Targetptr1 << f_maskread_epdZ(CurTableptr1+ActIndex1,0xFFFFFFFC) # ptr1 EPD()
								Trigger(actions=[SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+ActLoop-2),SetDeaths(CurrentPlayer,Add,Targetptr1,0),SetMemory(0x6509B0,Subtract,2)]) #ActEPD4
							EUDEndIf()

						EUDEndIf()

						if EUDIf()((ActIndex2 >= 1)): # Patch Value

							RawTrigger(actions=[SetMemory(0x6509B0,Add,1)])
							if EUDIf()((DeathsX(CurrentPlayer,Exactly,0,0,0xF))): # Pflag2 ActEPD3
								CurTableptr2 << Tableptr
								CurTableNextptr2 << TableNextptr
							if EUDElse()(): # ExSetCtrig
								ActPlayer2 << (f_maskread_epdX(0xF) - 1) * 0x20000 #ActEPD3
								CurTableptr2 << TableEPD + ActPlayer2
								CurTableNextptr2 << TableNextEPD + ActPlayer2
							EUDEndIf()

							if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x10,0,0x10))): # Nflag2 ActEPD3
								Targetptr2 << f_maskread_epdY(CurTableNextptr2+ActIndex2,0xFFFFFFFF) # Nextptr2 Value()
								DoActions([SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+ActLoop-3)])
								if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x20,0,0x20))): # Eflag2 ActEPD3
									DoActions([SetMemory(0x6509B0,Add,2),SetDeaths(CurrentPlayer,Add,EPD(Targetptr2),0),SetMemory(0x6509B0,Subtract,2)]) #ActEPD5
								if EUDElse()():
									DoActions([SetMemory(0x6509B0,Add,2),SetDeaths(CurrentPlayer,Add,Targetptr2,0),SetMemory(0x6509B0,Subtract,2)])  #ActEPD5
								EUDEndIf()
							if EUDElse()():
								Targetptr2 << f_maskread_epdY(CurTableptr2+ActIndex2,0xFFFFFFFF) # ptr2 Value()
								DoActions([SetMemory(0x6509B0,SetTo,CurrentTrig_2EPD+ActLoop-3)])
								if EUDIf()((DeathsX(CurrentPlayer,Exactly,0x20,0,0x20))): # Eflag2 ActEPD3
									DoActions([SetMemory(0x6509B0,Add,2),SetDeaths(CurrentPlayer,Add,EPD(Targetptr2),0),SetMemory(0x6509B0,Subtract,2)])  #ActEPD5
								if EUDElse()():
									DoActions([SetMemory(0x6509B0,Add,2),SetDeaths(CurrentPlayer,Add,Targetptr2,0),SetMemory(0x6509B0,Subtract,2)])  #ActEPD5
								EUDEndIf()
							EUDEndIf()
							RawTrigger(actions=[SetMemory(0x6509B0,Subtract,1)])

						EUDEndIf()

						RawTrigger(actions=[SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF), # Clear Act ActEPD2
									SetMemory(0x6509B0,Subtract,1),
									SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF), # ActEPD1
									SetMemory(0x6509B0,Add,2),
									SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF), # ActEPD3
									SetMemory(0x6509B0,Add,3),
									SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF)]) #ActEPD6

					EUDEndIf()

					DoActions([ActLoop.AddNumber(8),SetMemory(0x6509B0,Add,8)]) 

				EUDEndWhile()

				f_setcurpl(CurrentTrig_2EPD+5)
			EUDEndIf()

		EUDEndWhile()

		CtrigLoop << CtrigLoop + 1
		ptr_2 << 0
		ptrloopend_2 << 0
		CurrentTrig_2Index << 0

		if EUDIf()((f_playerexist(1) == 0,CtrigLoop == 1)): # Remove Error
			CtrigLoop << 2
		EUDEndIf()

		if EUDIf()((f_playerexist(2) == 0,CtrigLoop == 2)): # Remove Error
			CtrigLoop << 3
		EUDEndIf()

		if EUDIf()((f_playerexist(3) == 0,CtrigLoop == 3)): # Remove Error
			CtrigLoop << 4
		EUDEndIf()

		if EUDIf()((f_playerexist(4) == 0,CtrigLoop == 4)): # Remove Error
			CtrigLoop << 5
		EUDEndIf()

		if EUDIf()((f_playerexist(5) == 0,CtrigLoop == 5)): # Remove Error
			CtrigLoop << 6
		EUDEndIf()

		if EUDIf()((f_playerexist(6) == 0,CtrigLoop == 6)): # Remove Error
			CtrigLoop << 7
		EUDEndIf()

		if EUDIf()((f_playerexist(7) == 0,CtrigLoop == 7)): # Remove Error
			CtrigLoop << 8
		EUDEndIf()

	EUDEndWhile() 

	f_setcurpl(PrevCp)
