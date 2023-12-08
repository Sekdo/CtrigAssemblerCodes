from eudplib import *
from os.path import getsize
def onPluginStart():
	global file_size, file
	Player = [0,0,0,0,0,0,0,0,0,0,0,0]
	Check = []
	for k, v in settings.items():
		if k.lower() == "tbl":
			file = v
		elif k.lower() == "player":
			Players = [p.strip() for p in v.split(",")]
			for pid in Players:
				if pid.lower() == "p1":
					Player[0] = 1
					Check.append("P1")
				elif pid.lower() == "p2":
					Player[1] = 1
					Check.append("P2")
				elif pid.lower() == "p3":
					Player[2] = 1
					Check.append("P3")
				elif pid.lower() == "p4":
					Player[3] = 1
					Check.append("P4")
				elif pid.lower() == "p5":
					Player[4] = 1
					Check.append("P5")
				elif pid.lower() == "p6":
					Player[5] = 1
					Check.append("P6")
				elif pid.lower() == "p7":
					Player[6] = 1
					Check.append("P7")
				elif pid.lower() == "p8":
					Player[7] = 1
					Check.append("P8")
				elif pid.lower() == "ob1":
					Player[8] = 1
					Check.append("Ob1")
				elif pid.lower() == "ob2":
					Player[9] = 1
					Check.append("Ob2")
				elif pid.lower() == "ob3":
					Player[10] = 1
					Check.append("Ob3")
				elif pid.lower() == "ob4":
					Player[11] = 1
					Check.append("Ob4")

	file_size = getsize(file)
	TBLchk = Db(open(file, 'rb').read())
	PChk = EUDVariable()
	for i in range(12):
		if i <= 7:
			if Player[i] == 1:
				RawTrigger(conditions=[Memory(0x512684,Exactly,i)],actions=[PChk.SetNumber(1)])
		else:
			if Player[i] == 1:
				RawTrigger(conditions=[Memory(0x512684,Exactly,i+120)],actions=[PChk.SetNumber(1)])
	if EUDIf()(PChk == 0):
		f_memcpy(0x19184660,TBLchk,file_size)
	EUDEndIf()
	
	print(
		"[CopyTBL] stat_txt.tbl : {} Loaded. ({} Bytes, {} Excluded)".format(
			file, file_size, Check
		)
	)