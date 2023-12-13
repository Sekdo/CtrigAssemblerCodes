function UnitPatch()

DoActions(FP,{
	SetInvincibility(Enable, "Any unit", P9, "Anywhere");
	SetInvincibility(Enable, "Any unit", P10, "Anywhere");
	SetInvincibility(Enable, "Any unit", P11, "Anywhere");
})

SpellcasterPatch = {}
    function SetUnitAdvFlag(UnitID,Value,Mask)
        table.insert(SpellcasterPatch,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
    end
    for i = 0, 227 do
        SetUnitAdvFlag(i,0x200000,0x200000)
    end
    SetUnitAdvFlag(204,0,0x200000) -- 204 이팩트유닛 제외
DoActions2(FP,SpellcasterPatch,{}) -- 마나유닛패치

BuildingArr = {106,126,127,130,147,148,151,154,162,168,173,174,175,190,200,201}
HeroArr = {3,5,8,9,70,17,19,21,22,23,25,71,28,30,32,52,58,60,61,63,64,65,66,68,74,75,76,77,78,79,80,81,86,87,88,93,98,102,162} -- 38

CIfOnce(FP,{NDeaths(FP,Exactly,1,LvlJump)})

CMov(FP,0x6509B0,19025+19)
NWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,5,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			CAdd(FP,0x6509B0,6)
			Call_SaveCp() -- Save EPD 25
				for i = 1 , #BuildingArr do
					CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,BuildingArr[i],0,0xFF)},{ -- Set BID Cloacked
						TSetMemoryX(_Add(BackupCp,30),SetTo,0xB00,0xB00);
						TSetMemoryX(_Add(BackupCp,12),SetTo,0,0xFF0000);
						TSetMemoryX(_Add(BackupCp,32),SetTo,0,0xFFFFFFFF);
					},{Preserved})
				end
			Call_LoadCp() -- EPD 25
			CSub(FP,0x6509B0,6) -- EPD 19
		CIfEnd()
		
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,8,0,0xFF),DeathsX(CurrentPlayer,AtMost,10,0,0xFF)})
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,8,0,0xFF)},{SetNVar(HPlayer,SetTo,5),SetNVar(Pre_HPlayer,SetTo,8)},{Preserved})
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,9,0,0xFF)},{SetNVar(HPlayer,SetTo,6),SetNVar(Pre_HPlayer,SetTo,9)},{Preserved})
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,10,0,0xFF)},{SetNVar(HPlayer,SetTo,7),SetNVar(Pre_HPlayer,SetTo,10)},{Preserved})
		
			CAdd(FP,0x6509B0,6)
			Call_SaveCp() -- Save EPD 25
			for i = 1, #HeroArr do
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,HeroArr[i],0,0xFF)})
					f_Read(FP,_Sub(BackupCp,15),HPosXY) -- Save HeroPosition
					CMov(FP,HPosX,_Mov(HPosXY,0xFFFF))
					CMov(FP,HPosY,_Div(_Mov(HPosXY,0xFFFF0000),65536))
					Simple_SetLocX(FP,91,_Sub(HPosX,16),_Sub(HPosY,16),_Add(HPosX,16),_Add(HPosY,16))
                SetNextptr()
					CDoActions(FP,{  -- Replace Hero
						TModifyUnitEnergy(1,HeroArr[i],Pre_HPlayer,"CLoc91",0);
						TRemoveUnitAt(1,HeroArr[i],"CLoc91",Pre_HPlayer);
						TCreateUnit(1,HeroArr[i],"CLoc91",HPlayer);
						TModifyUnitEnergy(1,HeroArr[i],HPlayer,"CLoc91",100);
                        TSetMemoryX(Vi(Nextptr[2],9),SetTo,1*65536,0xFF0000); -- 영작플래그 설치
						SetMemoryX(0x664080 + 162*4,SetTo,0x0,0x1); -- Set Photon Canon Rank
					})
				CIfEnd()
			end
			Call_LoadCp() -- EPD 25
			CSub(FP,0x6509B0,6) -- EPD 19
		CIfEnd()
	CAdd(FP,0x6509B0,84)
NWhileEnd()

CMov(FP,0x6509B0,FP) -- RecoverCp

CIfEnd()

end
