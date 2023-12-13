function Install_FBoss()

	
	
	SetIgnoreTile = InitCFunc(FP)
	CFunc(SetIgnoreTile)
		CMov(FP,0x6509B0,19025+25)
			CWhile(FP,{Memory(0x6509B0,AtMost,19025+25 + (84*1699))})
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,20,0,0xFFFF)})
					CAdd(FP,0x6509B0,30)
						Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0x40000,0,0x40000)},{SetDeathsX(CurrentPlayer,SetTo,0,0,0x40000)},{Preserved})
					CSub(FP,0x6509B0,30)
				CIfEnd()
				CAdd(FP,0x6509B0,84)
			CWhileEnd()
		CMov(FP,0x6509B0,FP) -- RecoverCp
	CFuncEnd()
	
	----------------------------< Vars >----------------------------
	TempDataIndex, FB_VNull, FB_NukePosXY = CreateVars(3,FP)
	FUV = CreateVarArr(16,FP) -- 유닛변수
	FB_BulletTimer, FB_BulletTimer2, CacheEnd, FB_PhaseNumber, FB_WaitTimer, FB_STimer, FB_Stage, FBossHP, SideUnitSetting, FB_Dash = CreateCcodes(10)
	
	PH_Stage, PH_Timer = CreateCcodes(2)
	FB_ClearPattern, CheckPH3 = CreateCcodes(2)
	FB_RandShape, FB_RandIndex, FB_PreHP, FB_CheckHP = CreateVars(4,FP)
	FB_TempCA1, FB_TempCA5, FB_TempCA6 = CreateVars(3,FP)
	
	-- CFunc --
	TempPosX, TempPosY, FBPosX, FBPosY, CPosX, CPosY, RCos, RSin = CreateVars(8,FP) -- 보스위치,이펙트 변수
	FB_BulletAngle, FB_BulletSpeed, FB_BulletPosX, FB_BulletPosY, FBossEPD = CreateVars(5,FP)
	
	EFImage = 381
	EFImage2 = 213
	EFImage3 = 215
	TriggerX(FP,{CDeaths("X",Exactly,1,CacheEnd)},{
		RemoveUnit(204,P8),SetSpriteImage(385,EFImage),
		SetImageScript(EFImage,131),
		SetSpriteImage(385,EFImage),
		SetImageScript(EFImage,131)
	},{Preserved})

	FB_CurEnergy = CreateVars(1,FP)
	BulletImage2 = 541
	BulletScript2 = 247
	BulletColor2 = 17
		BulletInitSetting(FP,{194,122,283},87,199,493,BulletImage2,BulletScript2,BulletColor2,500,0,60,1,4,3,{4,4,4},0)
		BulletInitSetting(FP,{195,123,284},88,199,493,BulletImage2,BulletScript2,BulletColor2,500,0,60,1,4,3,{12,12,12},0)
		BulletInitSetting(FP,{196,124,285},89,199,493,BulletImage2,BulletScript2,BulletColor2,500,0,60,1,4,3,{32,32,32},0)
		BulletInitSetting(FP,{197,122,283},90,199,493,BulletImage2,BulletScript2,BulletColor2,500,0,60,1,4,3,{48,48,48},0)
	
CFunc1 = InitCFunc(FP)
Para = CFunc(CFunc1)
	
	f_Lengthdir(FP,96,Para[1],RCos,RSin)
		NIfX(FP,NVar(Para[2],Exactly,0)) -- UFunc
			CAdd(FP,RSin,Para[6]) -- YMax
			CFuncReturn({RSin})
		NElseX()  -- DFunc
			CAdd(FP,RSin,Para[7]) -- YMin
			CFuncReturn({RSin})
		NIfXEnd()
	CFuncEnd()
	
	CFunc2 = InitCFunc(FP)
	Para = CFunc(CFunc2)
	
	f_Lengthdir(FP,96,Para[1],RCos,RSin)
		NIfX(FP,NVar(Para[2],Exactly,2)) -- LFunc
			CAdd(FP,RCos,Para[3]) -- XMax
			CFuncReturn({RCos})
		NElseX() -- RFunc
			CAdd(FP,RCos,Para[4]) -- XMin
			CFuncReturn({RCos})
		NIfXEnd()
CFuncEnd()
	
--< Nuke Trigs >--
	SH_FBNuke1 = CSMakeCircle(6,192,0,CS_Level("Circle",6,1),0)
	SH_FBNuke2 = CSMakeCircle(6,192,0,CS_Level("Circle",6,2),CS_Level("Circle",6,1))
	SH_FBNuke3 = CSMakeCircle(6,192,0,CS_Level("Circle",6,3),CS_Level("Circle",6,2))
	SH_FBNuke4 = CSMakeCircle(6,192,0,CS_Level("Circle",6,4),CS_Level("Circle",6,3))
	
	FB_NukeShape, FB_NukeDataIndex, FB_LoopLimit = CreateVars(3,FP)
	FB_NukeWaitTimer = CreateCcode()
	
FBossNukeCAPlot = InitCFunc(FP)
	
CFunc(FBossNukeCAPlot)
	TriggerX(FP,{
		CDeaths("X",Exactly,0,FB_STimer);
		CDeaths("X",Exactly,0,FB_Stage);
	},{
		SetCDeaths("X",SetTo,34,FB_STimer);
		SetCDeaths("X",SetTo,1,FB_Stage);
		SetNVar(FB_NukeShape,SetTo,4);
		SetNVar(FB_NukeDataIndex,SetTo,1);
		SetNVar(FB_LoopLimit,SetTo,600);
	},{Preserved})
	
	TriggerX(FP,{
		CDeaths("X",Exactly,0,FB_STimer);
		CDeaths("X",Exactly,1,FB_Stage);
	},{
		SetCDeaths("X",SetTo,34,FB_STimer);
		SetCDeaths("X",SetTo,2,FB_Stage);
		SetNVar(FB_NukeShape,SetTo,3);
		SetNVar(FB_NukeDataIndex,SetTo,1);
		SetNVar(FB_LoopLimit,SetTo,600);
	},{Preserved})
	
	TriggerX(FP,{
		CDeaths("X",Exactly,0,FB_STimer);
		CDeaths("X",Exactly,2,FB_Stage);
	},{
		SetCDeaths("X",SetTo,34,FB_STimer);
		SetCDeaths("X",SetTo,3,FB_Stage);
		SetNVar(FB_NukeShape,SetTo,2);
		SetNVar(FB_NukeDataIndex,SetTo,1);
		SetNVar(FB_LoopLimit,SetTo,600);
	},{Preserved})
	
	TriggerX(FP,{
		CDeaths("X",Exactly,0,FB_STimer);
		CDeaths("X",Exactly,3,FB_Stage);
	},{
		SetCDeaths("X",SetTo,34,FB_STimer);
		SetCDeaths("X",SetTo,4,FB_Stage);
		SetCDeaths("X",SetTo,34*7,FB_WaitTimer);
		SetCDeaths("X",Add,1,FB_PhaseNumber);
		SetNVar(FB_NukeShape,SetTo,1);
		SetNVar(FB_NukeDataIndex,SetTo,1);
		SetNVar(FB_LoopLimit,SetTo,600);
	},{Preserved})
	CIf(FP,{CDeaths("X",Exactly,34,FB_STimer)})
		CAPlot({SH_FBNuke1,SH_FBNuke2,SH_FBNuke3,SH_FBNuke4},P8,193,"CLoc144",{FBPosX,FBPosY},1,32,
			{FB_NukeShape,0,0,0,FB_LoopLimit,FB_NukeDataIndex},nil,FP,nil,{SetNext("X",0x4002),SetNext(0x4003,"X",1)})
	CIfEnd()
CFuncEnd()
	
	-- FB_Shapes -- 
	function Heart(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
	FB_PH3A = CSMakeStarX(5,108,96,0,CS_Level("StarX",5,3),CS_Level("StarX",5,2)) -- 딜 O
	FB_PH3B = CS_Rotate(CSMakeGraphT({12,12},"Heart",0,0,2,2,50),180) -- 하트 -- 딜 X
	FB_PH3C = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,4),CS_Level("PolygonX",4,3))
	FB_PH3D = CSMakeCircleX(6,108,0,CS_Level("CircleX",6,3),CS_Level("CircleX",6,2))
	
	FB_3A = CS_RatioXY(FB_PH3A,2.5,2.5)
	FB_3B = CS_RatioXY(FB_PH3B,2.5,2.5)
	FB_3C = CS_RatioXY(FB_PH3C,2.5,2.5)
	FB_3D = CS_RatioXY(FB_PH3D,2.5,2.5)
	
	FB_5A = CSMakeCircleX(6,512,0,6,0)
	FB_5B = CS_Rotate3D(CSMakeCircleX(24,512,0,24,0),0,30,0)
	FB_5C = CSMakeCircleX(24,1024,0,24,0) -- Last CraeteUnit
	
	D5Path = CSMakePath({64-1024,64-4096},{64-1024,64+4096},{64+1024,64+4096},{64+1024,64-4096})
	FB_5D = CS_ConnectPathX(D5Path,128,1)
	
	
	FB_ShapeArr = {FB_PH3A,FB_PH3B,FB_PH3C,FB_PH3D,FB_3A,FB_3B,FB_3C,FB_3D,FB_5A,FB_5B,FB_5C,FB_5D}
	FB_Shape, FB_DataIndex, FB_LoopMax, FB_Angle, FB_Ratio, TempXY, FPlayer = CreateVars(7,FP)
	
	function FB_CAFunc()
		local PlayerID = CAPlotPlayerID
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
			CMov(FP,TempDataIndex,V(CA[6])) -- 데이터인덱스 임시저장
				CIf(FP,{NVar(FB_Shape,Exactly,9)})
					CA_Rotate(FB_Angle)
				CIfEnd()
				CIf(FP,{NVar(FB_Shape,Exactly,10)})
					CA_RatioXY(FB_Ratio,68,FB_Ratio,68)
				CIfEnd()
	end
	function LastCAFunc()
		local PlayerID = CAPlotPlayerID
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
			CMov(FP,TempXY,V(CA[8])) -- Input Cord X
				TriggerX(FP,{NVar(TempXY,AtLeast,0),NVar(TempXY,AtMost,0x7FFFFFFF)},{SetNVar(FPlayer,SetTo,6)},{Preserved})
				TriggerX(FP,{NVar(TempXY,AtLeast,0x80000000)},{SetNVar(FPlayer,SetTo,5)},{Preserved})
	end
	FB_CAPlot = InitCFunc(FP)
	
	CFunc(FB_CAPlot)
		CAPlot(FB_ShapeArr,P8,193,"FBLoc1",nil,1,32,{FB_Shape,0,0,0,FB_LoopMax,FB_DataIndex}
			,"FB_CAFunc",FP,nil,{SetNext("X",0x4004),SetNext(0x4005,"X",1)})
	CFuncEnd()
	
	LastCAPlot = InitCFunc(FP)
	
	CFunc(LastCAPlot)
		CAPlot({FB_5D},P8,193,"FBLoc2",{1024,4096},1,16,{1,0,0,0,600,FB_DataIndex}
			,"LastCAFunc",FP,nil,{SetNext("X",0x4006),SetNext(0x4007,"X",1)})
	CFuncEnd()
	--< CAFunc , CBFunc >--
	
	CycleLength = 360
	function WH_CAFunc3()
		local PlayerID = CAPlotPlayerID
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
			CMov(FP,TempDataIndex,V(CA[6])) -- 데이터인덱스 임시저장
			CAdd(FP,V(CA[8]),_iSub(FBPosX,1024))
			CAdd(FP,V(CA[9]),_iSub(FBPosY,4096))
	end
	
	CycleLength = 360
	SH_Warp = CS_RatioXY(CS_FillXY({1,1},256,256,64,64),1.3,1.3)
	VT1 = CreateVar(FP)
	
	
	function WH_CBFunc3()
		FSC1 = CB_InitCache(CycleLength,SH_Warp[1],0x80000000) -- CycleLength : 120 
				Vptr3 = CB_InitVShape(2)
				CB_LoadCache(FSC1,VT1,Vptr3)
				CB_GetNumber(2,FB_VNull)
					CIf(FP,{NVar(FB_VNull,Exactly,0x80000000)})
						CB_Warping(CFunc1,CFunc1,CFunc2,CFunc2,{CPosX,CPosY},1,2)
						CB_SaveCache(FSC1,VT1,Vptr3)
					CIfEnd()
	end
	
CIf(FP,{CDeaths("X",Exactly,1,CacheEnd)})
	CIfOnce(FP,{CVar("X",GMode,AtMost,2)})
		f_Read(FP,0x628438,nil,FBossEPD)
			CDoActions(FP,{ -- rhegb 소환
				SetImageColor(925,8);
				CreateUnit(1,11,"FBossInit",P8);
				TSetMemory(Vi(FBossEPD[2],2),SetTo,256*4000000);
				TSetMemory(Vi(FBossEPD[2],13),SetTo,1024);
				TSetMemoryX(Vi(FBossEPD[2],18),SetTo,67,0xFFFF);
				TSetMemoryX(Vi(FBossEPD[2],55),SetTo,0xA00000,0xA00000); -- No Collide, Gathering
				SetInvincibility(Enable, 11, P8, "FBossInit");
				SetSpriteImage(309,422); -- 핵미사일 엔진변경
			})
	CIfEnd()
	CIfOnce(FP,{CVar("X",GMode,Exactly,3)})
		f_Read(FP,0x628438,nil,FBossEPD)
			CDoActions(FP,{ -- rhegb 소환
				SetImageColor(925,8);
				CreateUnit(1,11,"FBossInit",P8);
				TSetMemory(Vi(FBossEPD[2],2),SetTo,256*4000000);
				TSetMemory(Vi(FBossEPD[2],13),SetTo,1280);
				TSetMemoryX(Vi(FBossEPD[2],18),SetTo,144,0xFFFF);
				TSetMemoryX(Vi(FBossEPD[2],55),SetTo,0xA00000,0xA00000); -- No Collide, Gathering
				SetInvincibility(Enable, 11, P8, "FBossInit");
				SetSpriteImage(309,422); -- 핵미사일 엔진변경
			})
	CIfEnd()
	DoActionsX(FP,{
		MoveLocation("FBLoc1",11,P8,"Anywhere"); -- 상시로 따라다니는 로케
		MoveLocation("CLoc135",11,P8,"Anywhere"); -- CB_Warping 이팩트 로케
		MoveLocation("CLoc134",11,P8,"Anywhere"); -- 위치계산 로케
		RemoveUnitAt(all,213,"CLoc135",P8);
		KillUnit(84,P8);
	})
	TriggerX(FP,{CVar("X",GMode,AtLeast,2)},{
		KillUnitAt(all,0,"CLoc135",Force1);
		KillUnitAt(all,7,"CLoc135",Force1);
		KillUnitAt(all,20,"CLoc135",Force1);
		KillUnitAt(all,124,"CLoc135",Force1);
		KillUnitAt(all,125,"CLoc135",Force1);
	},{Preserved})
		f_Read(FP,0x58DC60+134*0x14+0,FBPosX) -- Index 134 로케
		f_Read(FP,0x58DC60+134*0x14+4,FBPosY) -- Index 134 로케
CIfEnd()

CIf(FP,{Deaths(P8,Exactly,0,11)})
	CTrigger(FP,{
		TMemory(Vi(FBossEPD[2],2),AtMost,256*999999);
		CVar("X",GMode,AtMost,2);
		CDeaths("X",AtLeast,1,FBossHP);
	},{
		TSetMemory(Vi(FBossEPD[2],2),SetTo,256*4000000);
		SetCDeaths("X",Subtract,1,FBossHP);
		SetCDeaths("X",SetTo,1,SideUnitSetting); -- Create SideUnits
	},{Preserved})
	CTrigger(FP,{
		TMemory(Vi(FBossEPD[2],2),AtMost,256*999999);
		CVar("X",GMode,Exactly,3);
		CDeaths("X",AtLeast,1,FBossHP);
	},{
		TSetMemory(Vi(FBossEPD[2],2),SetTo,256*5000000);
		SetCDeaths("X",Subtract,1,FBossHP);
		SetCDeaths("X",SetTo,1,SideUnitSetting); -- Create SideUnits
	},{Preserved})
	
	
CBPlot({SH_Warp,RetSH(SH_Warp)},nil,P8,193,"CLoc135",{1024,4096},1,32,{2,0,0,0,999,0}
			,"WH_CAFunc3","WH_CBFunc3",FP,nil,{SetNext("X",0x4000),SetNext(0x4001,"X",1)},1)
	CIf(FP,{CDeaths("X",Exactly,1,CacheEnd)},{SetSpriteImage(385,EFImage),SetImageScript(EFImage,131)})
		CreateEffect(FP, Nextptr, 16, EFImage, 0, 204, "FBLoc1", P8)
		CreateEffect(FP, Nextptr, 6, EFImage, 1, 204, "FBLoc1", P8)
	CIfEnd()
CIfEnd()

CIf(FP,{CVar("X",GMode,AtLeast,2),CDeaths("X",Exactly,1,CacheEnd)})
	TriggerX(FP,{CDeathsX("X",Exactly,35,FB_Dash,0xFFFF),CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,28,FB_Dash,0xFFFF),CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,21,FB_Dash,0xFFFF),CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,14,FB_Dash,0xFFFF),CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,7,FB_Dash,0xFFFF),CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	
	CTrigger(FP,{ -- Dash On
		CVar("X",GMode,Exactly,2);
		CDeathsX("X",Exactly,0,FB_Dash,0xFFFF);
		CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)
	},{
		SetCDeathsX("X",SetTo,34*2,FB_Dash,0xFFFF);
		SetCDeathsX("X",SetTo,1*65536,FB_Dash,0xFF0000);
		SetMemory(0x657470+4*99,SetTo,1); -- 최대사거리 1
		TSetMemory(Vi(FBossEPD[2],13),SetTo,2048+512); -- MaxSpeed
		TSetMemoryX(Vi(FBossEPD[2],18),SetTo,1024,0xFFFF); -- Accel
		CreateUnit(1,84,"FBLoc1",P8);
	},{Preserved})
	CTrigger(FP,{ -- Dash On
		CVar("X",GMode,Exactly,3);
		CDeathsX("X",Exactly,0,FB_Dash,0xFFFF);
		CDeathsX("X",Exactly,0,FB_Dash,0xFF0000)
	},{
		SetCDeathsX("X",SetTo,34*2.5,FB_Dash,0xFFFF);
		SetCDeathsX("X",SetTo,1*65536,FB_Dash,0xFF0000);
		SetMemory(0x657470+4*99,SetTo,1); -- 최대사거리 1
		TSetMemory(Vi(FBossEPD[2],13),SetTo,2048+512+256); -- MaxSpeed
		TSetMemoryX(Vi(FBossEPD[2],18),SetTo,1024+256,0xFFFF); -- Accel
		CreateUnit(1,84,"FBLoc1",P8);
	},{Preserved})
	
	CTrigger(FP,{ -- Dash Off
		CDeathsX("X",Exactly,0,FB_Dash,0xFFFF);
		CDeathsX("X",Exactly,1*65536,FB_Dash,0xFF0000);
	},{
		SetCDeathsX("X",SetTo,34*20,FB_Dash,0xFFFF);
		SetCDeathsX("X",SetTo,0*65536,FB_Dash,0xFF0000);
		SetMemory(0x657470+4*99,SetTo,256); -- 최대사거리 256
		TSetMemory(Vi(FBossEPD[2],13),SetTo,1024); -- MaxSpeed
		TSetMemoryX(Vi(FBossEPD[2],18),SetTo,67,0xFFFF); -- Accel
		CreateUnit(1,84,"FBLoc1",P8);
	},{Preserved})
	
	TriggerX(FP,{CDeathsX("X",Exactly,1*65536,FB_Dash,0xFF0000)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
	
	DoActionsX(FP,{SetCDeathsX("X",Subtract,1,FB_Dash,0xFFFF)}) -- Reset
	
CIfEnd()


	----------------------------< Trigs >----------------------------
	
CJump(FP,0x402)
SetLabel(0x4000) -- 이팩트단락
	
NIf(FP,{Memory(0x628438,AtLeast,1),CDeaths("X",Exactly,1,CacheEnd)},{SetSpriteImage(385,EFImage2),SetImageScript(EFImage2,131)})
	CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",AtLeast,1,FB_PhaseNumber)})
		CreateEffect(FP, Nextptr, 17, EFImage2, 20, 204, "CLoc135", P8)
		--DoActions(FP,{CreateUnit(1,84,"CLoc135",P8)})
	CIfEnd()

	CIf(FP,{CVar("X",GMode,Exactly,2)})
		CIfX(FP,{CDeaths("X",Exactly,1,FB_PhaseNumber)})
			CIf(FP,{TNVar(TempDataIndex,AtMost,FB_CurEnergy)})
				CreateEffect(FP, Nextptr, 16, EFImage2, 20, 204, "CLoc135", P8)
			CIfEnd()
			CIf(FP,{TNVar(TempDataIndex,AtLeast,_Add(FB_CurEnergy,1))})
				CreateEffect(FP, Nextptr, 17, EFImage2, 20, 204, "CLoc135", P8)
			CIfEnd()
		CElseIfX({CDeaths("X",AtLeast,2,FB_PhaseNumber)})
			CreateEffect(FP, Nextptr, 17, EFImage2, 20, 204, "CLoc135", P8)
		CIfXEnd()
	CIfEnd()

	CIf(FP,{CVar("X",GMode,Exactly,3)},{SetSpriteImage(385,EFImage2),SetImageScript(EFImage2,131)})
		CIfX(FP,{CDeaths("X",Exactly,1,FB_PhaseNumber)})
			CIf(FP,{TNVar(TempDataIndex,AtMost,FB_CurEnergy)})
				CreateEffect(FP, Nextptr, 17, EFImage2, 20, 204, "CLoc135", P8)
			CIfEnd()
			CIf(FP,{TNVar(TempDataIndex,AtLeast,_Add(FB_CurEnergy,1))})
				CreateEffect(FP, Nextptr, 16, EFImage2, 20, 204, "CLoc135", P8)
			CIfEnd()
		CElseIfX({CDeaths("X",AtLeast,2,FB_PhaseNumber)})
			CreateEffect(FP, Nextptr, 16, EFImage2, 20, 204, "CLoc135", P8)
		CIfXEnd()
	CIfEnd()

	CIf(FP,{CDeaths("X",Exactly,1,SideUnitSetting),CVar("X",GMode,AtLeast,2)})
		CDoActions(FP,{
			TCreateUnit(1,FUV[1],"CLoc135",P8);TCreateUnit(1,FUV[2],"CLoc135",P8);CreateUnit(1,25,"CLoc135",P8);
		})
	CIfEnd()
NIfEnd()
	
SetLabel(0x4001)
SetLabel(0x4002)
	
NIf(FP,{Memory(0x628438,AtLeast,1)})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{CreateUnit(1,13,"CLoc144",P8)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{CreateUnit(1,30,"CLoc144",P8),CreateUnit(1,69,"CLoc144",P8)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{CreateUnit(1,69,"CLoc144",P8),CreateUnit(1,13,"CLoc144",P8)},{Preserved})

NIfEnd()
	
SetLabel(0x4003)
SetLabel(0x4004)
CIf(FP,{CDeaths("X",Exactly,3,FB_PhaseNumber)})
		TriggerX(FP,{CDeaths("X",Exactly,1,PH_Stage)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved})
		TriggerX(FP,{CDeaths("X",Exactly,1,FB_ClearPattern)},{
			CreateUnit(1,69,"FBLoc1",P8);
			CreateUnit(1,25,"FBLoc1",P8);
			CreateUnit(1,27,"FBLoc1",P8);
			Order(27,P8,"Anywhere",Patrol,"CLoc134")
		},{Preserved})
CIfEnd()
	
CIf(FP,{CDeaths("X",Exactly,5,FB_PhaseNumber)})
		TriggerX(FP,{CDeaths("X",Exactly,0,PH_Stage)},{CreateUnit(1,213,"FBLoc1",P8)},{Preserved}) -- 이팩트
		TriggerX(FP,{CDeaths("X",Exactly,1,PH_Stage)},{CreateUnit(1,84,"FBLoc1",P8)},{Preserved}) -- 이팩트
CIfEnd()
SetLabel(0x4005)
SetLabel(0x4006)
	
NIf(FP,{Memory(0x628438,AtLeast,1)})
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
			TCreateUnit(1,FUV[9],"FBLoc2",FPlayer); -- 5페이즈 외곽유닛
			TSetMemory(Vi(Nextptr[2],13),SetTo,1920);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,144,0xFFFF);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
		},{Preserved})
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
			TCreateUnit(1,FUV[10],"FBLoc2",FPlayer); -- 5페이즈 외곽유닛
			TSetMemory(Vi(Nextptr[2],13),SetTo,1280);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,72,0xFFFF);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
		},{Preserved})
NIfEnd()
SetLabel(0x4007)
CJumpEnd(FP,0x402)
	
DoActionsX(FP,{
		SetNVar(VT1,Add,1);
		SetNVar(CPosX,Add,1); -- 360
		SetNVar(CPosY,Add,1); -- 180
	})
	
TriggerX(FP,{NVar(VT1,AtLeast,360)},{SetNVar(VT1,SetTo,0),SetCDeaths("X",SetTo,1,CacheEnd)},{Preserved})
	
	
CIf(FP,{CDeaths("X",Exactly,1,CacheEnd)})
		TriggerX(FP,{},{SetNVar(FBPosX,SetTo,1024),SetNVar(FBPosY,SetTo,640)}) -- InitPosXY
		CallCFuncX(FP,FBossNukeCAPlot)
CIfEnd()
	
------------< Phase 1 >--------------

NormalShape = CSMakePolygon(5,96,0,CS_Level("Polygon",5,5),CS_Level("Polygon",5,2))

CIf(FP,{CDeaths("X",Exactly,1,FB_PhaseNumber),CDeaths("X",Exactly,0,FB_WaitTimer)})

TriggerX(FP,{},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,4,FBossHP),SetImageColor(925,10);}) -- HP Setting 200*3 ( 600m )

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(FUV[1],SetTo,86);SetNVar(FUV[2],SetTo,76);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(FUV[1],SetTo,58);SetNVar(FUV[2],SetTo,66);
})

CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",Exactly,1,SideUnitSetting)})
	CSPlot(NormalShape,P6,80,"FBLoc1",nil,1,32,FP,nil,nil,1)
	CSPlot(NormalShape,P7,77,"FBLoc1",nil,1,32,FP,nil,nil,1)
	--CSPlot(NormalShape,P8,25,"FBLoc1",nil,1,32,FP,nil,nil,1)
	DoActions(FP,{Order("Men",Force2,"Anywhere",Patrol,"CLoc134")})
CIfEnd()

	CIf(FP,{CVar("X",GMode,AtLeast,2)})
		TriggerX(FP,{NVar(FB_CurEnergy,Exactly,SH_Warp[1]+1)},{ -- Fatal
			SetBulletDamage(87, SetTo, 60000);SetBulletSplash25(87, SetTo, 96);SetBulletSplash50(87, SetTo, 96);SetBulletSplash100(87, SetTo, 96);
			SetBulletDamage(88, SetTo, 60000);SetBulletSplash25(88, SetTo, 96);SetBulletSplash50(88, SetTo, 96);SetBulletSplash100(88, SetTo, 96);
			SetBulletDamage(89, SetTo, 60000);SetBulletSplash25(89, SetTo, 80);SetBulletSplash50(89, SetTo, 80);SetBulletSplash100(89, SetTo, 80);
			SetBulletDamage(90, SetTo, 60000);SetBulletSplash25(90, SetTo, 64);SetBulletSplash50(90, SetTo, 64);SetBulletSplash100(90, SetTo, 64);
			SetImageColor(542,16);
			SetImageColor(544,16);
			SetNVar(FB_CurEnergy,SetTo,0);
			--SetCDeaths("X",SetTo,1,SideUnitSetting);
		},{Preserved})
		CIfX(FP,{CVar("X",GMode,Exactly,2)})
			CIf(FP,{CDeaths("X",Exactly,0,FB_BulletTimer),CDeaths("X",Exactly,1,CacheEnd)},{SetCDeaths("X",SetTo,34*2,FB_BulletTimer),SetNVar(FB_CurEnergy,Add,2)})
				CFor(FP,0,256*256,8*256)
				local BAngle = CForVariable()
					CreateBullet(FP,P8,194,4,BAngle,4096,5,"FBLoc1")
					CreateBullet(FP,P8,195,4,BAngle,4096,10,"FBLoc1")
					CreateBullet(FP,P8,196,4,BAngle,4096,15,"FBLoc1")
					CreateBullet(FP,P8,197,4,BAngle,4096,20,"FBLoc1")
				CForEnd()
			CIfEnd()
		CElseIfX({CVar("X",GMode,Exactly,3)})
			CIf(FP,{CDeaths("X",Exactly,0,FB_BulletTimer),CDeaths("X",Exactly,1,CacheEnd)},{SetCDeaths("X",SetTo,34*1,FB_BulletTimer),SetNVar(FB_CurEnergy,Add,2)})
				CFor(FP,0,256*256,8*256)
				local BAngle = CForVariable()
					CreateBullet(FP,P8,194,4,BAngle,4096,5,"FBLoc1")
					CreateBullet(FP,P8,195,4,BAngle,4096,10,"FBLoc1")
					CreateBullet(FP,P8,196,4,BAngle,4096,15,"FBLoc1")
					CreateBullet(FP,P8,197,4,BAngle,4096,20,"FBLoc1")
				CForEnd()
			CIfEnd()
		CIfXEnd()
			
		TriggerX(FP,{NVar(FB_CurEnergy,Exactly,2)},{ -- Recover
			SetBulletDamage(87, SetTo, 1000);SetBulletSplash25(87, SetTo, 4);SetBulletSplash50(87, SetTo, 4);SetBulletSplash100(87, SetTo, 4);
			SetBulletDamage(88, SetTo, 1000);SetBulletSplash25(88, SetTo, 12);SetBulletSplash50(88, SetTo, 12);SetBulletSplash100(88, SetTo, 12);
			SetBulletDamage(89, SetTo, 1000);SetBulletSplash25(89, SetTo, 32);SetBulletSplash50(89, SetTo, 32);SetBulletSplash100(89, SetTo, 32);
			SetBulletDamage(90, SetTo, 1000);SetBulletSplash25(90, SetTo, 48);SetBulletSplash50(90, SetTo, 48);SetBulletSplash100(90, SetTo, 48);
			SetImageColor(542,0);
			SetImageColor(544,0);
		},{Preserved})
	CIfEnd()
		TriggerX(FP,{ -- PhaseClear
			CDeaths("X",Exactly,1,FBossHP);
		},{
			CopyCpAction({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
			SetCDeaths("X",SetTo,34*7,FB_WaitTimer);
			SetCDeaths("X",SetTo,0,FB_STimer); -- Reset
			SetCDeaths("X",SetTo,0,FB_Stage); -- Reset
			SetCDeaths("X",SetTo,0,FB_BulletTimer);
			SetCDeaths("X",SetTo,0,FB_BulletTimer2);
			SetInvincibility(Enable, 11, P8, "Anywhere")})
CIfEnd() -- Phase1 End

------------< Phase 2 >--------------

CIf(FP,{CDeaths("X",Exactly,2,FB_PhaseNumber),CDeaths("X",Exactly,0,FB_WaitTimer)})
	
TriggerX(FP,{},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,4,FBossHP)}) -- 200*3 ( 600m )
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(FUV[1],SetTo,58);SetNVar(FUV[2],SetTo,3);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(FUV[1],SetTo,98);SetNVar(FUV[2],SetTo,87);
})

CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",Exactly,1,SideUnitSetting)})
	CSPlot(NormalShape,P6,21,"FBLoc1",nil,1,32,FP,nil,nil,1)
	CSPlot(NormalShape,P7,19,"FBLoc1",nil,1,32,FP,nil,nil,1)
	--CSPlot(NormalShape,P8,25,"FBLoc1",nil,1,32,FP,nil,nil,1)
	DoActions(FP,{Order("Men",Force2,"Anywhere",Patrol,"CLoc134")})
CIfEnd()

CIf(FP,{CVar("X",GMode,Exactly,2)})
		CIf(FP,{CDeaths("X",Exactly,0,FB_BulletTimer2),CDeaths("X",Exactly,1,CacheEnd)},{SetCDeaths("X",SetTo,128+34*2,FB_BulletTimer2),RemoveUnit(37,P8),RemoveUnit(38,P8)})
		BulletImage3 = 78
		BulletScript3 = 242
		BulletColor3 = 0
		BulletInitSetting(FP,{198,123,284},92,196,496,BulletImage3,BulletScript3,BulletColor3,50000,0,7,1,3,3,{48,48,48},0)
			NLoopX(FP,10)
				CDoActions(FP,{
					TSetNVar(FB_BulletPosX,SetTo,_Add(_Mod(_Rand(),512),_Sub(FBPosX,256))); -- Range_X : -256 ~ 256
					TSetNVar(FB_BulletPosY,SetTo,_Add(_Mod(_Rand(),512),_Sub(FBPosY,256))); -- Range_Y : -256 ~ 256
				})
				Simple_SetLocX(FP,"FBLoc1",_Sub(FB_BulletPosX,16),_Sub(FB_BulletPosY,16),_Add(FB_BulletPosX,16),_Add(FB_BulletPosY,16))
				CreateBullet(FP,P8,198,4,0,0,128,"FBLoc1")
			NWhileXEnd()
		CIfEnd()
CIfEnd() -- 하드이상
CIf(FP,{CVar("X",GMode,Exactly,3)})
		CIf(FP,{CDeaths("X",Exactly,0,FB_BulletTimer2),CDeaths("X",Exactly,1,CacheEnd)},{SetCDeaths("X",SetTo,64+34*2,FB_BulletTimer2),RemoveUnit(37,P8),RemoveUnit(38,P8)})
		BulletImage3 = 78
		BulletScript3 = 242
		BulletColor3 = 16
		BulletInitSetting(FP,{198,123,284},92,196,496,BulletImage3,BulletScript3,BulletColor3,50000,0,7,1,3,3,{48,48,48},0)
			NLoopX(FP,15)
				CDoActions(FP,{
					TSetNVar(FB_BulletPosX,SetTo,_Add(_Mod(_Rand(),512),_Sub(FBPosX,256))); -- Range_X : -256 ~ 256
					TSetNVar(FB_BulletPosY,SetTo,_Add(_Mod(_Rand(),512),_Sub(FBPosY,256))); -- Range_Y : -256 ~ 256
				})
				Simple_SetLocX(FP,"FBLoc1",_Sub(FB_BulletPosX,16),_Sub(FB_BulletPosY,16),_Add(FB_BulletPosX,16),_Add(FB_BulletPosY,16))
				CreateBullet(FP,P8,198,4,0,0,64,"FBLoc1")
			NWhileXEnd()
		CIfEnd()
CIfEnd() -- 하드이상
	
	TriggerX(FP,{ -- PhaseClear
		CDeaths("X",Exactly,1,FBossHP);
	},{
		CopyCpAction({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
		SetCDeaths("X",SetTo,34*20,FB_WaitTimer);
		SetCDeaths("X",SetTo,0,FB_STimer); -- Reset
		SetCDeaths("X",SetTo,0,FB_Stage); -- Reset
		SetCDeaths("X",SetTo,0,FB_BulletTimer);
		SetCDeaths("X",SetTo,0,FB_BulletTimer2);
		SetInvincibility(Enable, 11, P8, "Anywhere")})
	
	DoActionsX(FP,{SetNVar(VT1,Add,1)})
CIfEnd() -- Phase2 End
	
------------< Phase 3 >--------------
	
CIf(FP,{CDeaths("X",Exactly,3,FB_PhaseNumber),CDeaths("X",Exactly,0,FB_WaitTimer)})
	
TriggerX(FP,{},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,3,FBossHP)}) -- 200*3 ( 600m )

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(FUV[1],SetTo,88);SetNVar(FUV[2],SetTo,52);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(FUV[1],SetTo,28);SetNVar(FUV[2],SetTo,61);
})

CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",Exactly,1,SideUnitSetting)})
	CSPlot(NormalShape,P6,86,"FBLoc1",nil,1,32,FP,nil,nil,1)
	CSPlot(NormalShape,P7,3,"FBLoc1",nil,1,32,FP,nil,nil,1)
	--CSPlot(NormalShape,P8,25,"FBLoc1",nil,1,32,FP,nil,nil,1)
	DoActions(FP,{Order("Men",Force2,"Anywhere",Patrol,"CLoc134")})
CIfEnd()

CIf(FP,{CVar("X",GMode,AtLeast,2)})
	CIf(FP,{CDeaths("X",Exactly,0,PH_Stage),CDeaths("X",Exactly,0,PH_Timer)},{SetCDeaths("X",SetTo,1,PH_Stage),SetCDeaths("X",SetTo,0,FB_ClearPattern)})
		CMov(FP,FB_RandShape,_Add(_Mod(_Rand(),4),1)) -- 도형랜덤설정
		CMov(FP,FB_RandIndex,_Mod(_Rand(),4)) -- 컬러랜덤설정
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,1,PH_Stage)}) -- 예고이팩트
		TriggerX(FP,{NVar(FB_RandIndex,Exactly,0)},{SetImageColor(214,9)},{Preserved})
		TriggerX(FP,{NVar(FB_RandIndex,Exactly,1)},{SetImageColor(214,10)},{Preserved})
		TriggerX(FP,{NVar(FB_RandIndex,Exactly,2)},{SetImageColor(214,13)},{Preserved})
		TriggerX(FP,{NVar(FB_RandIndex,Exactly,3)},{SetImageColor(214,17)},{Preserved})
		CDoActions(FP,{
			TSetNVar(FB_Shape,SetTo,FB_RandShape);
			SetNVar(FB_LoopMax,SetTo,1);
			SetNVar(FB_DataIndex,Add,1);
		})
		CallCFuncX(FP,FB_CAPlot)
	
	CIf(FP,{CDeaths("X",AtMost,1,CheckPH3)})
		TriggerX(FP,{NVar(FB_RandShape,Exactly,1),NVar(FB_DataIndex,AtLeast,FB_PH3A[1]+1)
				},{SetNVar(FB_DataIndex,SetTo,0),SetCDeaths("X",Add,1,CheckPH3)},{Preserved})
		TriggerX(FP,{NVar(FB_RandShape,Exactly,2),NVar(FB_DataIndex,AtLeast,FB_PH3B[1]+1)
				},{SetNVar(FB_DataIndex,SetTo,0),SetCDeaths("X",Add,1,CheckPH3)},{Preserved})
		TriggerX(FP,{NVar(FB_RandShape,Exactly,3),NVar(FB_DataIndex,AtLeast,FB_PH3C[1]+1)
				},{SetNVar(FB_DataIndex,SetTo,0),SetCDeaths("X",Add,1,CheckPH3)},{Preserved})
		TriggerX(FP,{NVar(FB_RandShape,Exactly,4),NVar(FB_DataIndex,AtLeast,FB_PH3D[1]+1)
				},{SetNVar(FB_DataIndex,SetTo,0),SetCDeaths("X",Add,1,CheckPH3)},{Preserved})
	CIfEnd()
	
	TriggerX(FP,{CDeaths("X",Exactly,2,CheckPH3)},{SetCDeaths("X",SetTo,2,PH_Stage),SetCDeaths("X",SetTo,0,CheckPH3)},{Preserved})
	
	CIfEnd()
	
	CTrigger(FP,{ -- 패턴예고이팩트후 현재체력저장 & 측정체력세팅
		CDeaths("X",Exactly,2,PH_Stage); -- Stage2
		CDeaths("X",Exactly,0,PH_Timer);
	},{
		TSetNVar(FB_PreHP,SetTo,_Read(_Add(FBossEPD,2)));
		TSetMemory(Vi(FBossEPD[2],2),SetTo,256*8000000); -- 측정체력을 현재체력으로 저장
		SetImageColor(214,9);
		SetCDeaths("X",SetTo,3,PH_Stage);
		SetCDeaths("X",SetTo,34*6,PH_Timer);
	},{Preserved})
	
	CTrigger(FP,{ -- 최대측정딜700만 오버플로우방지
		TMemory(Vi(FBossEPD[2],2),AtMost,999999);
		CDeaths("X",Exactly,3,PH_Stage); -- Stage3
		CDeaths("X",AtLeast,1,PH_Timer);
	},{
		TSetMemory(Vi(FBossEPD[2],2),SetTo,1200000);
	},{Preserved})
	
	CIf(FP,{CDeaths("X",Exactly,3,PH_Stage),CDeaths("X",Exactly,0,PH_Timer)},{SetCDeaths("X",SetTo,4,PH_Stage)}) -- 딜측정타이머 0일때
		CSub(FP,FB_CheckHP,_Mov(256*8000000),_Read(_Add(FBossEPD,2)))  -- 6초동안 넣은 딜 저장
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,4,PH_Stage)},{SetCDeaths("X",SetTo,5,PH_Stage)})
		CDoActions(FP,{TSetMemory(Vi(FBossEPD[2],2),SetTo,FB_PreHP)}) -- 현재체력을 저장체력으로 변경
			CTrigger(FP,{NVar(FB_RandShape,Exactly,1),NVar(FB_CheckHP,AtLeast,256*100000)},{ -- 딜 X ( 오각별 )
					SetNVar(FB_TempCA1,SetTo,5);
					SetNVar(FB_TempCA6,SetTo,1);
					SetNVar(FB_TempCA5,SetTo,1);
					SetCDeaths("X",SetTo,1,FB_ClearPattern) -- Not Passed
				},{Preserved})
			CTrigger(FP,{NVar(FB_RandShape,Exactly,2),NVar(FB_CheckHP,AtMost,256*400000)},{ -- 딜 O ( 하트 )
					SetNVar(FB_TempCA1,SetTo,6);
					SetNVar(FB_TempCA6,SetTo,1);
					SetNVar(FB_TempCA5,SetTo,1);
					SetCDeaths("X",SetTo,1,FB_ClearPattern) -- Not Passed
				},{Preserved})
			CTrigger(FP,{NVar(FB_RandShape,Exactly,3),NVar(FB_CheckHP,AtLeast,256*125000)},{ -- 딜 X ( 정사각형 )
					SetNVar(FB_TempCA1,SetTo,7);
					SetNVar(FB_TempCA6,SetTo,1);
					SetNVar(FB_TempCA5,SetTo,1);
					SetCDeaths("X",SetTo,1,FB_ClearPattern) -- Not Passed
				},{Preserved})
			CTrigger(FP,{NVar(FB_RandShape,Exactly,4),NVar(FB_CheckHP,AtMost,256*200000)},{ -- 딜 O ( 원 )
					SetNVar(FB_TempCA1,SetTo,8);
					SetNVar(FB_TempCA6,SetTo,1);
					SetNVar(FB_TempCA5,SetTo,1);
					SetCDeaths("X",SetTo,1,FB_ClearPattern) -- Not Passed
				},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,5,PH_Stage)},{SetCDeaths("X",SetTo,6,PH_Stage),SetCDeaths("X",SetTo,34*25,PH_Timer)})
	
		CIf(FP,{CDeaths("X",Exactly,0,FB_ClearPattern),CDeaths("X",Exactly,34*25,PH_Timer)})
			DoActionsX(FP,{
				CreateUnit(1,84,"FBLoc1",P8);
				CopyCpAction({MinimapPing("FBLoc1"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP)
			})
		CIfEnd()
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,6,PH_Stage)})
		CIf(FP,{CDeaths("X",Exactly,1,FB_ClearPattern)})
			CDoActions(FP,{
					TSetNVar(FB_Shape,SetTo,FB_TempCA1);
					TSetNVar(FB_LoopMax,SetTo,FB_TempCA5);
					TSetNVar(FB_DataIndex,SetTo,FB_TempCA6);
				})
			CallCFuncX(FP,FB_CAPlot) -- 유닛 생성단락진입
			DoActionsX(FP,{SetNVar(FB_TempCA6,Add,1)})
		CIfEnd()
	CIfEnd()
	
	TriggerX(FP,{CDeaths("X",Exactly,6,PH_Stage),CDeaths("X",Exactly,0,PH_Timer)},{ -- Reset
	   SetCDeaths("X",SetTo,0,PH_Stage),SetCDeaths("X",SetTo,0,FB_ClearPattern)},{Preserved})
CIfEnd() --  하드이상

	TriggerX(FP,{ -- PhaseClear
	   CDeaths("X",Exactly,1,FBossHP);
	},{
	   CopyCpAction({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
	   SetCDeaths("X",SetTo,34*7,FB_WaitTimer);
	   SetCDeaths("X",SetTo,0,FB_STimer); -- Reset
	   SetCDeaths("X",SetTo,0,FB_Stage); -- Reset
	   SetCDeaths("X",SetTo,0,PH_Timer);
	   SetCDeaths("X",SetTo,0,PH_Stage);
	   SetInvincibility(Enable, 11, P8, "Anywhere")})
	
	DoActionsX(FP,{SetNVar(VT1,Add,2),SetCDeaths("X",Subtract,1,PH_Timer)})
CIfEnd() -- Phase3 End
	
------------< Phase 4 >--------------
	
FB4_Deaths = CreateCcode()
FBoss6_EPD, FBoss7_EPD = CreateVars(2,FP)
	
CIf(FP,{CDeaths("X",Exactly,4,FB_PhaseNumber),CDeaths("X",Exactly,0,FB_WaitTimer)})
	
TriggerX(FP,{},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,3,FBossHP)}) -- 200*3 ( 600m )

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(FUV[1],SetTo,60);SetNVar(FUV[2],SetTo,65);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(FUV[1],SetTo,99);SetNVar(FUV[2],SetTo,23);
})

CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",Exactly,1,SideUnitSetting)})
	CSPlot(NormalShape,P6,98,"FBLoc1",nil,1,32,FP,nil,nil,1)
	CSPlot(NormalShape,P7,52,"FBLoc1",nil,1,32,FP,nil,nil,1)
	--CSPlot(NormalShape,P8,25,"FBLoc1",nil,1,32,FP,nil,nil,1)
	DoActions(FP,{Order("Men",Force2,"Anywhere",Patrol,"CLoc134")})
CIfEnd()

CIf(FP,{CVar("X",GMode,AtLeast,2)})
	CIf(FP,{CDeaths("X",Exactly,0,PH_Stage),CDeaths("X",Exactly,0,PH_Timer)},{SetCDeaths("X",SetTo,1,PH_Stage),SetInvincibility(Enable, 11, P8, "Anywhere")})
	
	f_Read(FP,0x628438,nil,FBoss6_EPD)
		CDoActions(FP,{ -- rhegb 소환
			SetImageColor(925,16);
			CreateUnit(1,11,"CLoc134",P6);
			TSetMemory(Vi(FBoss6_EPD[2],2),SetTo,256*3000000);
			TSetMemory(Vi(FBoss6_EPD[2],13),SetTo,512);
			TSetMemoryX(Vi(FBoss6_EPD[2],18),SetTo,67,0xFFFF);
			TSetMemoryX(Vi(FBoss6_EPD[2],55),SetTo,0xA00000,0xA00000); -- No Collide, Gatheringg
			TSetMemoryX(Vi(FBoss6_EPD[2],72),SetTo,255*256,0xFF00);
			SetMemory(0x6509B0,SetTo,5);
			CreateUnit(1,22,"CLoc134",P6);
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "FBLoc1");
			SetMemory(0x6509B0,SetTo,7);
		})
	f_Read(FP,0x628438,nil,FBoss7_EPD)
		CDoActions(FP,{ -- rhegb 소환
			SetImageColor(925,16);
			CreateUnit(1,11,"CLoc134",P7);
			TSetMemory(Vi(FBoss7_EPD[2],2),SetTo,256*3000000);
			TSetMemory(Vi(FBoss7_EPD[2],13),SetTo,512);
			TSetMemoryX(Vi(FBoss7_EPD[2],18),SetTo,67,0xFFFF);
			TSetMemoryX(Vi(FBoss7_EPD[2],55),SetTo,0xA00000,0xA00000); -- No Collide, Gatheringg
			TSetMemoryX(Vi(FBoss7_EPD[2],72),SetTo,255*256,0xFF00);
			SetMemory(0x6509B0,SetTo,6);
			CreateUnit(1,22,"CLoc134",P6);
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "FBLoc1");
			SetMemory(0x6509B0,SetTo,7);
		})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,1,PH_Stage)}) -- While Puppets Alive // CreateBullet
		TriggerX(FP,{Deaths(P6,Exactly,1,11)},{
			SetCDeaths("X",SetTo,2,PH_Stage);SetCDeaths("X",SetTo,1,FB4_Deaths),SetDeaths(P6,SetTo,0,11)},{Preserved})
		TriggerX(FP,{Deaths(P7,Exactly,1,11)},{
			SetCDeaths("X",SetTo,2,PH_Stage);SetCDeaths("X",SetTo,1,FB4_Deaths),SetDeaths(P7,SetTo,0,11)},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,2,PH_Stage)})
		TriggerX(FP,{CDeaths("X",Exactly,1,FB4_Deaths)},{SetCDeaths("X",Add,1,PH_Timer)},{Preserved}) -- 시간측정시작
		TriggerX(FP,{Deaths(P6,Exactly,1,11)},{ -- PH_Timer End, Execution Pattern
			   SetCDeaths("X",SetTo,3,PH_Stage),SetCDeaths("X",SetTo,2,FB4_Deaths),SetDeaths(P6,SetTo,0,11)},{Preserved})
		TriggerX(FP,{Deaths(P7,Exactly,1,11)},{ -- PH_Timer End, Execution Pattern
			SetCDeaths("X",SetTo,3,PH_Stage),SetCDeaths("X",SetTo,2,FB4_Deaths),SetDeaths(P7,SetTo,0,11)},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,3,PH_Stage)})
		TriggerX(FP,{
			CDeaths("X",AtMost,34*3,PH_Timer);
			CDeaths("X",Exactly,3,PH_Stage);
		},{
			SetCDeaths("X",SetTo,34*25,PH_Timer); -- PH_Timer Reset
			SetCDeaths("X",SetTo,5,PH_Stage);
			SetInvincibility(Disable, 11, P8, "Anywhere");
			CreateUnit(1,84,"FBLoc1",P8);
			CopyCpAction({MinimapPing("FBLoc1"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP)
		},{Preserved})
		TriggerX(FP,{
			CDeaths("X",AtLeast,34*3+1,PH_Timer);
			CDeaths("X",Exactly,3,PH_Stage);
		},{
			SetCDeaths("X",SetTo,34*2,PH_Timer); -- PH_Timer Reset
			SetCDeaths("X",SetTo,4,PH_Stage); -- 패턴파훼 실패시 PH_Stage 값 4로 Set
		},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,4,PH_Stage)},{SetCDeaths("X",SetTo,5,PH_Stage)}) --    패턴파훼 실패시 진입단락
	
	DoActionsX(FP,{
		SetBulletDamage(87, SetTo, 60000);SetBulletSplash25(87, SetTo, 96);SetBulletSplash50(87, SetTo, 96);SetBulletSplash100(87, SetTo, 96);
		SetBulletDamage(88, SetTo, 60000);SetBulletSplash25(88, SetTo, 96);SetBulletSplash50(88, SetTo, 96);SetBulletSplash100(88, SetTo, 96);
		SetBulletDamage(89, SetTo, 60000);SetBulletSplash25(89, SetTo, 80);SetBulletSplash50(89, SetTo, 80);SetBulletSplash100(89, SetTo, 80);
		SetBulletDamage(90, SetTo, 60000);SetBulletSplash25(90, SetTo, 64);SetBulletSplash50(90, SetTo, 64);SetBulletSplash100(90, SetTo, 64);
		SetImageColor(542,16);
		SetImageColor(544,16);
	})
	TriggerX(FP,{CVar("X",GMode,Exactly,3)},{CreateUnit(12,13,"FBLoc1",P8)},{Preserved})
	CFor(FP,0,256*256,8*256)
		local BAngle = CForVariable()
			CreateBullet(FP,P8,194,4,BAngle,4096,5,"FBLoc1")
			CreateBullet(FP,P8,195,4,BAngle,4096,10,"FBLoc1")
			CreateBullet(FP,P8,196,4,BAngle,4096,15,"FBLoc1")
			CreateBullet(FP,P8,197,4,BAngle,4096,20,"FBLoc1")
	CForEnd()
	
	CIfEnd()
	
	TriggerX(FP,{CDeaths("X",Exactly,5,PH_Stage)},{SetCDeaths("X",Subtract,1,PH_Timer)},{Preserved})
	TriggerX(FP,{CDeaths("X",Exactly,5,PH_Stage),CDeaths("X",Exactly,0,PH_Timer)},{SetCDeaths("X",SetTo,0,PH_Stage)},{Preserved})
CIfEnd()

	TriggerX(FP,{ -- PhaseClear
		CDeaths("X",Exactly,1,FBossHP);
	},{
		CopyCpAction({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
		SetCDeaths("X",SetTo,34*7,FB_WaitTimer);
		SetCDeaths("X",SetTo,0,FB_STimer); -- Reset
		SetCDeaths("X",SetTo,0,FB_Stage); -- Reset
		SetCDeaths("X",SetTo,0,PH_Timer);
		SetCDeaths("X",SetTo,0,PH_Stage);
		SetInvincibility(Enable, 11, P8, "Anywhere")})
	
	DoActionsX(FP,{SetNVar(VT1,Add,3)})
CIfEnd() -- Phase4 End
	
------------< Phase 5 >--------------
	BlastAngle, BlastAngle2 = CreateVars(2,FP)
	PH5_Side = CreateCcode()
	
	
CIf(FP,{CDeaths("X",Exactly,5,FB_PhaseNumber),CDeaths("X",Exactly,0,FB_WaitTimer)})
	
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,3,FBossHP)}) -- 200*3 ( 600m )
TriggerX(FP,{CVar("X",GMode,AtLeast,2)},{SetInvincibility(Disable, 11, P8, "Anywhere"),SetCDeaths("X",SetTo,3,FBossHP)}) -- 200*3 ( 600m )

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(FUV[1],SetTo,69);SetNVar(FUV[2],SetTo,2);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(FUV[1],SetTo,9);SetNVar(FUV[2],SetTo,68);
})

CIf(FP,{CVar("X",GMode,Exactly,1),CDeaths("X",Exactly,1,SideUnitSetting)})
	CSPlot(NormalShape,P6,27,"FBLoc1",nil,1,32,FP,nil,nil,1)
	CSPlot(NormalShape,P7,16,"FBLoc1",nil,1,32,FP,nil,nil,1)
	--CSPlot(NormalShape,P8,25,"FBLoc1",nil,1,32,FP,nil,nil,1)
	DoActions(FP,{Order("Men",Force2,"Anywhere",Patrol,"CLoc134")})
CIfEnd()

CIf(FP,{CVar("X",GMode,AtLeast,2)})
	CalcAngle = InitCFunc(FP)
	
	CFunc(CalcAngle)
		f_Read(FP,_Add(FBossEPD,8),BlastAngle2,nil,0xFF00)
		CAdd(FP,BlastAngle,BlastAngle2,128*256)
	CFuncEnd()
	
	CIf(FP,{CDeaths("X",Exactly,0,PH_Stage)})
		CallCFuncX(FP,CalcAngle)
		BulletImage2 = 959
		BulletScript2 = 395
		BulletColor2 = 0
		BulletInitSetting(FP,{194,122,283},87,199,493,BulletImage2,BulletScript2,BulletColor2,1,0,60,1,4,3,{1,1,1},0)
		CreateBullet(FP,P8,194,3,BlastAngle,12000,20,"FBLoc1") -- 예고선
		DoActionsX(FP,{SetNVar(FB_Angle,Add,3),SetNVar(FB_Shape,SetTo,9),SetNVar(FB_DataIndex,SetTo,1),SetNVar(FB_LoopMax,SetTo,600)})
		CallCFuncX(FP,FB_CAPlot)
		TriggerX(FP,{CDeaths("X",Exactly,34*4,PH_Timer)},{SetCDeaths("X",SetTo,1,PH_Stage),SetCDeaths("X",SetTo,0,PH_Timer)},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,1,PH_Stage)})
		DoActionsX(FP,{SetNVar(FB_Shape,SetTo,10),SetNVar(FB_DataIndex,SetTo,1),SetNVar(FB_LoopMax,SetTo,600),SetNVar(FB_Ratio,Add,2)})
		CallCFuncX(FP,FB_CAPlot)
		TriggerX(FP,{NVar(FB_Ratio,AtLeast,68*2)},{SetNVar(FB_Ratio,SetTo,0),SetCDeaths("X",SetTo,2,PH_Stage)},{Preserved})
	CIfEnd()
	
	CIf(FP,{CDeaths("X",Exactly,2,PH_Stage)})
		CallCFuncX(FP,CalcAngle)
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
				BulletImage3 = 210
				BulletScript3 = 395
				BulletColor3 = 17
				BulletInitSetting(FP,{198,123,284},92,196,496,BulletImage3,BulletScript3,BulletColor3,50000,0,7,1,3,3,{64,64,64},0)
					CreateBullet(FP,P8,198,3,BlastAngle,12000,10,"FBLoc1") -- 즉사
			CElseX()
				BulletImage3 = 210
				BulletScript3 = 395
				BulletColor3 = 16
				BulletInitSetting(FP,{198,123,284},92,196,496,BulletImage3,BulletScript3,BulletColor3,50000,0,7,1,3,3,{64,64,64},0)
					CreateBullet(FP,P8,198,3,BlastAngle,12000,15,"FBLoc1") -- 즉사
					CreateBullet(FP,P8,198,3,BlastAngle2,12000,15,"FBLoc1") -- 즉사
			CIfXEnd()
		TriggerX(FP,{CDeaths("X",Exactly,34*3,PH_Timer)},{SetCDeaths("X",SetTo,3,PH_Stage),SetCDeaths("X",SetTo,0,PH_Timer)},{Preserved})
	CIfEnd()
	
	TriggerX(FP,{CDeaths("X",Exactly,3,PH_Stage),CDeaths("X",Exactly,34*12,PH_Timer)}
		,{SetCDeaths("X",SetTo,0,PH_Stage),SetCDeaths("X",SetTo,0,PH_Timer)},{Preserved})
	
	CIf(FP,{CDeaths("X",Exactly,1,SideUnitSetting)},{SetCDeaths("X",Add,1,PH5_Side)})
		DoActionsX(FP,{SetNVar(FB_Shape,SetTo,11),SetNVar(FB_DataIndex,SetTo,1),SetNVar(FB_LoopMax,SetTo,600)})
		CallCFuncX(FP,FB_CAPlot)
		DoActionsX(FP,{SetNVar(FB_Shape,SetTo,12),SetNVar(FB_DataIndex,SetTo,1),SetNVar(FB_LoopMax,SetTo,600)})
		
		CIf(FP,{CVar("X",GMode,Exactly,2)})
			TriggerX(FP,{CDeaths("X",Exactly,1,PH5_Side)},{SetNVar(FUV[9],SetTo,80),SetNVar(FUV[10],SetTo,21)},{Preserved})
			TriggerX(FP,{CDeaths("X",Exactly,2,PH5_Side)},{SetNVar(FUV[9],SetTo,12),SetNVar(FUV[10],SetTo,86)},{Preserved})
			TriggerX(FP,{CDeaths("X",Exactly,3,PH5_Side)},{SetNVar(FUV[9],SetTo,98),SetNVar(FUV[10],SetTo,70)},{Preserved})
		CIfEnd()
		CIf(FP,{CVar("X",GMode,Exactly,3)})
			TriggerX(FP,{CDeaths("X",Exactly,1,PH5_Side)},{SetNVar(FUV[9],SetTo,88),SetNVar(FUV[10],SetTo,8)},{Preserved})
			TriggerX(FP,{CDeaths("X",Exactly,2,PH5_Side)},{SetNVar(FUV[9],SetTo,98),SetNVar(FUV[10],SetTo,58)},{Preserved})
			TriggerX(FP,{CDeaths("X",Exactly,3,PH5_Side)},{SetNVar(FUV[9],SetTo,60),SetNVar(FUV[10],SetTo,27)},{Preserved})
		CIfEnd()

		CallCFuncX(FP,LastCAPlot)
		DoActions(FP,{Order("Men",P6,"Anywhere",Patrol,"CLoc134"),Order("Men",P7,"Anywhere",Patrol,"CLoc134")})
	CIfEnd()
CIfEnd() -- 하드이상

FBossTxt2 = "\x13\x1B─━┫ \x08Ｆｉｎａｌ \x03Ｂｏｓｓ \x04:: \x08Ｒ\x04ｈｅｇｂ 를 \x06처치\x04하였습니다. \x1B┣━─"

	TriggerX(FP,{ -- FBossClear
		Deaths(P8,Exactly,1,11)
	},{
		RemoveUnit("Men",Force2);
		RemoveUnit(213,P8);
		CopyCpAction({
			PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),
			PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),
			DisplayTextX(FBossTxt2,4);
		},{Force1,Force5},FP);
		SetCDeaths("X",SetTo,6,FB_PhaseNumber);
		SetCDeaths("X",SetTo,2,Ending1); -- 엔딩단락
		
	})
	
	DoActionsX(FP,{SetNVar(VT1,Add,4),SetCDeaths("X",Add,1,PH_Timer)})
CIfEnd() -- Phase5 End
	

TriggerX(FP,{CDeaths("X",Exactly,1,SideUnitSetting)},{
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere")},{P8},FP)
	},{Preserved})
	DoActionsX(FP,{ -- Recover
		SetImageScript(EFImage,143);
		SetImageScript(EFImage2,142);
		SetImageScript(EFImage3,144);
		SetCDeaths("X",Subtract,1,FB_BulletTimer);
		SetCDeaths("X",Subtract,1,FB_BulletTimer2);
		SetCDeaths("X",Subtract,1,FB_WaitTimer);
		SetCDeaths("X",Subtract,1,FB_STimer);
		SetCDeaths("X",Subtract,1,SideUnitSetting);
		Order(213,P8,"Anywhere",Move,"CLoc134");
	})
	TriggerX(FP,{CVar("X",GMode,Exactly,2),CDeaths("X",Exactly,1,CacheEnd)},{
		SetNVar(OB_BGMVar,SetTo,18);
		SetNVar(BGMVar[1],SetTo,18);
		SetNVar(BGMVar[2],SetTo,18);
		SetNVar(BGMVar[3],SetTo,18);
		SetNVar(BGMVar[4],SetTo,18);
		SetNVar(BGMVar[5],SetTo,18);
	},{Preserved})
	TriggerX(FP,{CVar("X",GMode,Exactly,3),CDeaths("X",Exactly,1,CacheEnd)},{
		SetNVar(OB_BGMVar,SetTo,19);
		SetNVar(BGMVar[1],SetTo,19);
		SetNVar(BGMVar[2],SetTo,19);
		SetNVar(BGMVar[3],SetTo,19);
		SetNVar(BGMVar[4],SetTo,19);
		SetNVar(BGMVar[5],SetTo,19);
	},{Preserved})
	
	
	CallCFuncX(FP,SetIgnoreTile)

end