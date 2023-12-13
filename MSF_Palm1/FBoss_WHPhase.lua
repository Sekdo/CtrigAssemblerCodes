function Install_WHPhase()
FP = P8
--------< WHVar / Ccodes >--------
Temp_DataIndex, VTimeLine, VNull, CDistance, UnitPos, MulRatio,
WH_Angle, WH_LoopMax, WH_Shape, WH_DataIndex, WH_Unit, WH_Player, WH_AUnit1, WH_AUnit2, WH_GUnit1, WH_GUnit2, WH_Inside, WH_Outside = CreateVars(18,FP)
WH_CenterSW, WH_CenterTimer, WH_Timer, WH_WaitTimer, LockCWhile, WH_Stage, InvTimer, Pattern, ResetBulletTimer, BrightSW = CreateCcodes(11)

ST1 = NBag(FP,1,48) -- 11*4
NBagPtr = CreateVar(FP)

function RetSH(Shape)
	return CS_InputVoid(Shape[1])
end

CJump(FP,0x102)
SetLabel(0x1005)

CIf(FP,{CDeaths("X",Exactly,0,PreSaveCache),Memory(0x628438,AtLeast,1)})

CIfX(FP,{CDeaths("X",Exactly,1,PhaseNumber)})
	CIf(FP,{NVar(WH_Shape,Exactly,1)}) -- UnitShape
		SetNextptr()
		CTrigger(FP,{NVar(Temp_DataIndex,Exactly,0)},{
			CreateUnit(1,21,"CLoc12",P8);
			TSetMemory(Vi(Nextptr[2],13),SetTo,1280);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,48,0xFFFF);
			SetInvincibility(Enable, 21, P8, "CLoc12");
		},{Preserved})
		CTrigger(FP,{NVar(Temp_DataIndex,Exactly,1)},{
			CreateUnit(1,80,"CLoc12",P8);
			TSetMemory(Vi(Nextptr[2],13),SetTo,1280);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,48,0xFFFF);
			SetInvincibility(Enable, 80, P8, "CLoc12");
		},{Preserved})
		CTrigger(FP,{NVar(Temp_DataIndex,Exactly,2)},{
			CreateUnit(1,58,"CLoc12",P8);
			TSetMemory(Vi(Nextptr[2],13),SetTo,1280);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,48,0xFFFF);
			SetInvincibility(Enable, 58, P8, "CLoc12");
		},{Preserved})
		CTrigger(FP,{NVar(Temp_DataIndex,Exactly,3)},{
			CreateUnit(1,98,"CLoc12",P8);
			TSetMemory(Vi(Nextptr[2],13),SetTo,1280);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,48,0xFFFF);
			SetInvincibility(Enable, 98, P8, "CLoc12");
		},{Preserved})
	CIfEnd()
	CIf(FP,{NVar(WH_Shape,Exactly,3)}) -- OrderDest Shape
		TriggerX(FP,{NVar(Temp_DataIndex,Exactly,0)},{Order(21,P8,"Anywhere",Move,"CLoc12")},{Preserved})
		TriggerX(FP,{NVar(Temp_DataIndex,Exactly,1)},{Order(80,P8,"Anywhere",Move,"CLoc12")},{Preserved})
		TriggerX(FP,{NVar(Temp_DataIndex,Exactly,2)},{Order(58,P8,"Anywhere",Move,"CLoc12")},{Preserved})
		TriggerX(FP,{NVar(Temp_DataIndex,Exactly,3)},{Order(98,P8,"Anywhere",Move,"CLoc12")},{Preserved})
	CIfEnd()
CElseIfX({CDeaths("X",Exactly,2,PhaseNumber)})
	SetNextptr()
		CDoActions(FP,{
			TCreateUnit(1,WH_Unit,"CLoc12",WH_Player);
			TSetMemory(Vi(Nextptr[2],13),SetTo,CDistance);
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,CDistance,0xFFFF);
			TOrder(WH_Unit,WH_Player,"CLoc12",Attack,"FBossFixed");
		})
CElseIfX({CDeaths("X",Exactly,3,PhaseNumber)})
	DoActionsX(FP,{SetCDeaths("X",SetTo,0,Pattern),SetNVar(WH_Unit,SetTo,28)}) -- Set InvUnit

	TriggerX(FP,{NVar(Temp_DataIndex,Exactly,5)},{SetCDeaths("X",SetTo,1,Pattern),SetNVar(WH_Unit,SetTo,9)},{Preserved}) -- Set PointUnit
	TriggerX(FP,{NVar(Temp_DataIndex,Exactly,5+12)},{SetCDeaths("X",SetTo,1,Pattern),SetNVar(WH_Unit,SetTo,9)},{Preserved}) -- Set PointUnit
	TriggerX(FP,{NVar(Temp_DataIndex,Exactly,5+24)},{SetCDeaths("X",SetTo,1,Pattern),SetNVar(WH_Unit,SetTo,9)},{Preserved}) -- Set PointUnit
	TriggerX(FP,{NVar(Temp_DataIndex,Exactly,5+36)},{SetCDeaths("X",SetTo,1,Pattern),SetNVar(WH_Unit,SetTo,9)},{Preserved}) -- Set PointUnit

	CIfX(FP,{CDeathsX("X",Exactly,1*65536,WH_Timer,0xFF0000)}) -- Inv Pattern
		SetNextptr()
			CIf(FP,{CDeaths("X",Exactly,0,Pattern)}) -- ( 중점 제외 )
				NAppend(FP,ST1,Nextptr)
			CIfEnd()
				CDoActions(FP,{
					TCreateUnit(1,WH_Unit,"CLoc12",P8);
					TSetMemory(Vi(Nextptr[2],2),SetTo,256*6666666);
					TSetMemory(Vi(Nextptr[2],13),SetTo,0);
					TSetMemoryX(Vi(Nextptr[2],18),SetTo,1,0xFFFF);
					TOrder(WH_Unit,P8,"CLoc12",Attack,"FBossFixed");
				})
	CElseIfX({CDeathsX("X",Exactly,0*65536,WH_Timer,0xFF0000)}) -- Fatal Pattern
		SetNextptr()
			CDoActions(FP,{
				CreateUnit(1,9,"CLoc12",P8);
				TSetMemory(Vi(Nextptr[2],2),SetTo,256*6666666);
				TSetMemory(Vi(Nextptr[2],13),SetTo,0);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,1,0xFFFF);
				Order(9,P8,"CLoc12",Attack,"FBossFixed");
			})
	CIfXEnd()
CElseIfX({CDeaths("X",Exactly,4,PhaseNumber)})
	CIf(FP,{NVar(WH_Shape,Exactly,10)})
		CIf(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)})
			TriggerX(FP,{
				CDeathsX("X",Exactly,0*65536,WH_Stage,0xFF0000);
				CDeathsX("X",Exactly,0*16777216,WH_Stage,0xFF000000);
			},{
				SetCDeathsX("X",SetTo,1*65536,WH_Stage,0xFF0000);
				SetCDeathsX("X",SetTo,1*16777216,WH_Stage,0xFF000000);
				SetNVar(WH_Player,SetTo,7);
			},{Preserved})
			TriggerX(FP,{
				CDeathsX("X",Exactly,1*65536,WH_Stage,0xFF0000);
				CDeathsX("X",Exactly,0*16777216,WH_Stage,0xFF000000);
			},{
				SetCDeathsX("X",SetTo,2*65536,WH_Stage,0xFF0000);
				SetCDeathsX("X",SetTo,1*16777216,WH_Stage,0xFF000000);
				SetNVar(WH_Player,SetTo,7);
			},{Preserved})
			TriggerX(FP,{
				CDeathsX("X",Exactly,2*65536,WH_Stage,0xFF0000);
				CDeathsX("X",Exactly,0*16777216,WH_Stage,0xFF000000);
			},{
				SetCDeathsX("X",SetTo,0*65536,WH_Stage,0xFF0000);
				SetCDeathsX("X",SetTo,1*16777216,WH_Stage,0xFF000000);
				SetNVar(WH_Player,SetTo,7);
			},{Preserved})
			DoActionsX(FP,{SetCDeathsX("X",Subtract,1*16777216,WH_Stage,0xFF000000)})
		CIfEnd()
			--120 ( 젤중앙 : 0~11 (12) // 12~)
		CIfX(FP,{NVar(Temp_DataIndex,AtLeast,0),NVar(Temp_DataIndex,AtMost,12-1)},{SetSpriteImage(385, 380),SetImageScript(380, 131)})
			CreateEffect(FP, Nextptr, 6, 380, 19, 204, "CLoc12", P8)
			CreateEffect(FP, Nextptr, 16, 380, 18, 204, "CLoc12", P8)
			CTrigger(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)},{TCreateUnit(1,WH_Inside,"CLoc12",WH_Player)},{Preserved})

		CElseIfX({NVar(Temp_DataIndex,AtLeast,12),NVar(Temp_DataIndex,AtMost,12*5-1)},{SetSpriteImage(385, 213),SetImageScript(213, 131)})
			CreateEffect(FP, Nextptr, 17, 213, 19, 204, "CLoc12", P8)
			CTrigger(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)},{
				TCreateUnit(1,WH_AUnit1,"CLoc12",WH_Player);
				TCreateUnit(1,WH_GUnit1,"CLoc12",WH_Player);
			},{Preserved})

		CElseIfX({NVar(Temp_DataIndex,AtLeast,12*5),NVar(Temp_DataIndex,AtMost,12*8-1)},{SetSpriteImage(385, 545),SetImageScript(545, 131)})
			CreateEffect(FP, Nextptr, 17, 545, 19, 204, "CLoc12", P8)
			CTrigger(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)},{
				TCreateUnit(1,WH_AUnit2,"CLoc12",WH_Player);
				TCreateUnit(1,WH_GUnit2,"CLoc12",WH_Player);
			},{Preserved})

		CElseX({SetSpriteImage(385, 975),SetImageScript(975, 131)})
			CreateEffect(FP, Nextptr, 16, 975, 18, 204, "CLoc12", P8)
			CTrigger(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)},{TCreateUnit(1,WH_Outside,"CLoc12",WH_Player)},{Preserved})
		CIfXEnd()
	CIfEnd()
	CIf(FP,{NVar(WH_Shape,Exactly,12)})
		BulletImage2 = 210
		BulletScript2 = 242
		BulletColor2 = 10
		BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,1,1,7,1,2,3,{1,1,1},0)
			CIfX(FP,{CDeathsX("X",Exactly,0*65536,BrightSW,0xFF0000)})
				CreateBullet(FP,P8,197,0,0,0,32+16,"CLoc12")
			CElseX() -- CDeathsX("X",Exactly,0*65536,BrightSW,0xFF0000)
				CFor(FP,0,3,1)
					CreateBullet(FP,P8,197,0,0,0,255,"CLoc12")
				CForEnd()
			CIfXEnd()
	CIfEnd()
	DoActions(FP,{SetImageScript(213, 142)})
CElseIfX({CDeaths("X",Exactly,5,PhaseNumber)})

	CIf(FP,{NVar(WH_Shape,Exactly,11)}) -- TraceShape
		DoActions(FP,{SetSpriteImage(385, 545),SetImageScript(545, 131)})
		--CTrigger(FP,{TNVar(Temp_DataIndex,Exactly,UnitPos)},{MoveUnit(1,174,P8,"Anywhere","CLoc12")},{Preserved}) -- Move BossPos
		CreateEffect(FP, Nextptr, 17, 545, 13, 204, "CLoc12", P8) -- Create Trace Effect
	CIfEnd()

	CIfX(FP,{NVar(WH_Shape,Exactly,13)})
		CDoActions(FP,{
			TCreateUnit(1,WH_GUnit1,"CLoc12",P8);
			TCreateUnit(1,WH_AUnit1,"CLoc12",P8);
			TOrder(WH_GUnit1,P8,"CLoc12",Attack,"FBossFixed");
			TOrder(WH_AUnit1,P8,"CLoc12",Attack,"FBossFixed");
		})
	CElseIfX({NVar(WH_Shape,Exactly,14)})
		CDoActions(FP,{
			TCreateUnit(1,WH_GUnit2,"CLoc12",P8);
			TCreateUnit(1,WH_AUnit2,"CLoc12",P8);
			TOrder(WH_GUnit2,P8,"CLoc12",Attack,"FBossFixed");
			TOrder(WH_AUnit2,P8,"CLoc12",Attack,"FBossFixed");
		})
	CElseIfX({NVar(WH_Shape,Exactly,15)})
		CDoActions(FP,{
			TCreateUnit(1,WH_Outside,"CLoc12",P8);
			TOrder(WH_Outside,P8,"CLoc12",Attack,"FBossFixed");
		})
	CElseIfX({NVar(WH_Shape,Exactly,18)})
		CDoActions(FP,{
			TCreateUnit(1,WH_GUnit1,"CLoc12",P8);
			TCreateUnit(1,WH_AUnit1,"CLoc12",P8);
		})
	CElseIfX({NVar(WH_Shape,Exactly,19)})
		CDoActions(FP,{
			TCreateUnit(1,WH_GUnit2,"CLoc12",P8);
			TCreateUnit(1,WH_AUnit2,"CLoc12",P8);
		})
	CIfXEnd()
CElseIfX({CDeaths("X",Exactly,6,PhaseNumber)})
	CIf(FP,{NVar(WH_Shape,Exactly,17)})
		DoActions(FP,{CreateUnit(1,84,"CLoc12",P8)})
	CIfEnd()
CIfXEnd()

CIfEnd() -- PreSaveCache

SetLabel(0x1006)
CJumpEnd(FP,0x102)

function WH_CAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CMov(FP,Temp_DataIndex,V(CA[6])) -- Save DataIndex
			CIf(FP,{CDeaths("X",Exactly,2,PhaseNumber)})
				f_Sqrt(FP, CDistance, _Div(_Add(_Square(V(CA[8])),_Square(V(CA[9]))),5)) -- Calc Distance ( Div 5 = 오차범위 최소화)
			CIfEnd()
end


SH_Arc1 = CS_CompassA({128,0},{0,0},{256,0},0,18)
SH_Arc2 = CS_CompassA({64,0},{0,0},{128,0},0,9)
SH_Arc3 = CS_CompassA({192,0},{128,0},{256,0},1,9)
SH_ArcM = CS_OverlapX(SH_Arc3,SH_Arc2,SH_Arc1)
SH_Temp = CS_OverlapX(SH_ArcM,CS_FillPathXY(SH_ArcM,0,32,32,0))

-- WH Shapes --
--ArcA = CS_CompassC({0,0},1920,45-22,180-22,0,48)
WH_A1 = CSMakeCircleX(4,3600,180,4,0) -- CreatUnitShape (Rad 1800)
WH_A2 = CSMakeCircleX(4,1200,0,4,0) -- OrderShape (Rad 600)

WH_B1a = CS_MoveXY(CSMakePolygonX(4,192,45,400,324+38),-384,-384)
WH_B1b = CS_OverlapX(WH_B1a,CS_Rotate(WH_B1a,180))
WH_B1a = CS_Rotate(WH_B1b,90)
WH_B1c = CS_OverlapX(WH_B1a,CS_Rotate(WH_B1a,180))
WH_B1d = CS_Rotate(WH_B1b,90)

WH_C = CS_SortA(CS_OverlapX(
	CSMakeLineX(3,60,0+20*0,33,18),CSMakeLineX(3,60,0+20*1,33,18),CSMakeLineX(3,60,0+20*2,33,18) -- Side Dot = 15
	,CSMakeLineX(3,60,0+20*3,33,18),CSMakeCircleX(6,50,0,24,0)),0)
WH_C1 = CS_MoveXY(WH_C,1440,1440) -- 15*4+24
WH_C2 = CS_MoveXY(WH_C,1440,-1440) -- 15*4+24
WH_C3 = CS_MoveXY(WH_C,-1440,1440) -- 15*4+24
WH_C4 = CS_MoveXY(WH_C,-1440,-1440) -- 15*4+24
WH_Main1 = CS_RatioXY(CS_Rotate3D(CS_RemoveStack(CS_SymmetryA(SH_Temp,4,0,360),5),30,60,0),3,3) -- 221


CrossA = CS_MoveXY(CSMakeLine(2,64,0,8,0),0,-64)
CrossB = CSMakeLine(2,64,90,5,0)

SH_Cross0 = CS_SortY(CS_RemoveStack(CS_OverlapX(CrossA,CrossB),32),0)

WH_D1 = CS_OverlapX(CS_MoveXY(SH_Cross0,-128*3,0),CS_MoveXY(SH_Cross0,128*3,0),CS_MoveXY(SH_Cross0,0,128*3),CS_MoveXY(SH_Cross0,0,-128*3))
WH_D2 = CS_OverlapX(WH_D1,CS_RatioXY(CSMakeCircleX(12,192,0,12,0),1,0.75))

function HyperCycloid1(T) return {2.1*math.cos(T) - math.cos(2.1*T), 2.1*math.sin(T) - math.sin(2.1*T)} end
WH_Main2 = CS_RatioXY(CS_SortR(CSMakeSpiralX(12, 1024, 1, 128, 0, CS_Level("SpiralX",12,14), CS_Level("SpiralX",12,4)),0),1.1,1.1)

function Parafunc(T) return RegularPolygonGraphT(T,{2.5,2.5,5},1,0.8,1) end
TempGraph = CSMakeGraphT2("Parafunc",0,0,0.4,121,10,0.2,82)
WH_Main3 = CS_RatioXY(TempGraph,128,128) -- 82

FloorShape = CS_FillXY(1, {-192*4,192*4}, {-192*3,192*3}, 192*1, 192*1)

WH_E1 = CS_RatioXY(CSMakePolygonX(4,128,0,CS_Level("PolygonX",4,5),CS_Level("PolygonX",4,4)),0.8,1.4)
WH_E2 = CS_RatioXY(CSMakePolygonX(4,128,90,CS_Level("PolygonX",4,5),CS_Level("PolygonX",4,4)),1.4,0.8)
WH_E3 = CS_OverlapX(CS_CompassC({0,0},2000,45-22,180-22,0,32),CS_CompassC({0,0},1900,180+45-22,180+180-22,0,32))
WH_E4 = CS_RatioXY(CSMakePolygonX(4,224,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2)),0.9,1.3)
WH_E5 = CS_RatioXY(CSMakePolygonX(4,224,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2)),1.3,0.9)

function Heart(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
Shape4 = CSMakeGraphT({16,16},"Heart",0,0,1,1,100) -- 하트
Shape4A = CSMakeGraphT({12,12},"Heart",0,0,2,2,50) -- 하트2
Shape4B = CSMakeGraphT({6,6},"Heart",0,0,4,4,35) -- 하트3
ShapeHeart = CS_RemoveStack(CS_Rotate(Shape4,180),10)
ShapeHeartA = CS_RemoveStack(CS_Rotate(Shape4A,180),10)
ShapeHeartB = CS_RemoveStack(CS_Rotate(Shape4B,180),10)
WH_F1 = CS_RatioXY(ShapeHeartA,0.65,0.65)

WH_BossSHArr = {WH_A1,WH_A2,RetSH(WH_A1),WH_B1a,WH_B1b,WH_D1,WH_D2,WH_Main2,WH_Main3,RetSH(WH_Main2),RetSH(WH_Main3),FloorShape,WH_E1,WH_E2,WH_E3,
				WH_F1,RetSH(WH_F1),WH_E4,WH_E5}
--[[

WH_A1 = 1
WH_A2 = 2
RetSH(WH_A1) = 3
WH_B1a = 4
WH_B1b = 5
WH_D1 = 6
WH_D2 = 7
WH_Main2 = 8
WH_Main3 = 9
RetSH(WH_Main2) = 10
RetSH(WH_Main3) = 11
FloorShape = 12
WH_E1 = 13
WH_E2 = 14
WH_E3 = 15
WH_F1 = 16
RetSH(WH_F1) = 17
WH_E4 = 18
WH_E5 = 19
]]--
----< WH_BossEff >----

function WH_CBFunc()
	CIfX(FP,{CDeaths("X",Exactly,1,PreSaveCache)}) -- 캐시메모리저장 단락
		CIfX(FP,{NVar(WH_Shape,Exactly,10)})
			SC1 = CB_InitCache(360,WH_Main2[1],0x80000000) -- CycleLength : 360 /  Dot : 194
			Vptr1 = CB_InitVShape(10)
			CB_LoadCache(SC1,VTimeLine,Vptr1)
			CB_GetNumber(10,VNull)
				CIf(FP,{NVar(VNull,Exactly,0x80000000)})
					CB_Rotate3D(WH_Angle,60,30,8,10)
					CB_SaveCache(SC1,VTimeLine,Vptr1)
				CIfEnd()
		CElseIfX({NVar(WH_Shape,Exactly,11)})
			SC2 = CB_InitCache(180,WH_Main3[1],0x80000000) -- CycleLength : 180 /  Dot : 82
			Vptr2 = CB_InitVShape(11)
			CB_LoadCache(SC2,VTimeLine,Vptr2)
			CB_GetNumber(11,VNull)
				CIf(FP,{NVar(VNull,Exactly,0x80000000)})
					CB_Rotate3D(WH_Angle,60,0,9,11)
					CB_SaveCache(SC2,VTimeLine,Vptr2)
				CIfEnd()
		CElseIfX({NVar(WH_Shape,Exactly,17)})
			SC3 = CB_InitCache(180,WH_F1[1],0x80000000) -- CycleLength : 180 /  Dot : 82
			Vptr3 = CB_InitVShape(17)
			CB_LoadCache(SC3,VTimeLine,Vptr3)
			CB_GetNumber(17,VNull)
				CIf(FP,{NVar(VNull,Exactly,0x80000000)})
					CB_Ratio(MulRatio,810,MulRatio,810,16,17)
					CB_SaveCache(SC3,VTimeLine,Vptr3)
				CIfEnd()
		CIfXEnd()

	CElseX() -- 캐시메모리로드 단락
		CIf(FP,{NVar(WH_Shape,Exactly,10)})
			CB_LoadCache(SC1,VTimeLine,Vptr1)
		CIfEnd()
		CIf(FP,{NVar(WH_Shape,Exactly,11)})
			CB_LoadCache(SC2,VTimeLine,Vptr2)
		CIfEnd()
		CIf(FP,{NVar(WH_Shape,Exactly,17)})
			CB_LoadCache(SC3,VTimeLine,Vptr3)
		CIfEnd()
	CIfXEnd()

	CIf(FP,{CDeaths("X",Exactly,1,PhaseNumber)})
		CB_Rotate(WH_Angle,1,3)
	CIfEnd()
end
WH_CBPlot = InitCFunc(FP)
CFunc(WH_CBPlot)
	CBPlot(WH_BossSHArr,nil,P8,193,"CLoc12",{2048,1920},1,32,{WH_Shape,0,0,0,WH_LoopMax,WH_DataIndex}
		,"WH_CAFunc","WH_CBFunc",FP,nil,{SetNext("X",0x1005),SetNext(0x1006,"X",1)})
CFuncEnd()

--------< FBoss PreSaveCache Trig >--------
SaveCacheFunc = InitCFunc(FP)
CFunc(SaveCacheFunc)

CIf(FP,CDeaths("X",Exactly,1,PreSaveCache)) -- 360 tik
	DoActionsX(FP,{SetNVar(WH_DataIndex,SetTo,600)})
		CIf(FP,{CDeathsX("X",Exactly,0,LockCWhile,0xFF)},{SetNVar(WH_Shape,SetTo,10),SetNVar(WH_LoopMax,SetTo,600),SetNVar(WH_DataIndex,SetTo,0)})
			CallCFuncX(FP,WH_CBPlot)
			DoActionsX(FP,{SetNVar(VTimeLine,Add,1),SetNVar(WH_Angle,Add,1)})
			TriggerX(FP,{NVar(VTimeLine,AtLeast,360)},{
				SetCDeathsX("X",SetTo,1,LockCWhile,0xFF);
				SetNVar(VTimeLine,SetTo,0);
				SetNVar(WH_Angle,SetTo,0)})
		CIfEnd()
		CIf(FP,{CDeathsX("X",Exactly,1,LockCWhile,0xFF)},{SetNVar(WH_Shape,SetTo,11),SetNVar(WH_LoopMax,SetTo,600),SetNVar(WH_DataIndex,SetTo,0)})
			CallCFuncX(FP,WH_CBPlot)
			DoActionsX(FP,{SetNVar(VTimeLine,Add,1),SetNVar(WH_Angle,Add,2)})
			TriggerX(FP,{NVar(VTimeLine,AtLeast,180)},{
				SetCDeathsX("X",SetTo,2,LockCWhile,0xFF);
				SetNVar(VTimeLine,SetTo,0);
				SetNVar(WH_Angle,SetTo,0)})
		CIfEnd()
		CIf(FP,{CDeathsX("X",Exactly,2,LockCWhile,0xFF)},{SetNVar(WH_Shape,SetTo,17),SetNVar(WH_LoopMax,SetTo,600),SetNVar(WH_DataIndex,SetTo,0)})
			CallCFuncX(FP,WH_CBPlot)
			DoActionsX(FP,{SetNVar(VTimeLine,Add,1),SetNVar(MulRatio,Add,18)})
			TriggerX(FP,{NVar(VTimeLine,AtLeast,180)},{
				SetCDeathsX("X",SetTo,3,LockCWhile,0xFF);
				SetCDeaths("X",SetTo,0,PreSaveCache); -- Lock PreSaveCache
				SetNVar(VTimeLine,SetTo,0);
				SetNVar(MulRatio,SetTo,0);
			})
		CIfEnd()
CIfEnd()

CFuncEnd()

------------------------< FBoss WH Phase 1 ~ 5 >------------------------

CIf(FP,{CDeaths("X",Exactly,1,PhaseClear)})

--------< FBoss WH Phase 1 >--------
TriggerX(FP,{CDeaths("X",Exactly,0,PhaseNumber)},{
	SetCDeaths("X",Add,1,PhaseNumber);
	SetCDeaths("X",SetTo,34*20,WH_WaitTimer);
	CopyCpAction({
		RunAIScript("Turn ON Shared Vision for Player 6"),
		RunAIScript("Turn ON Shared Vision for Player 7"),
		RunAIScript("Turn ON Shared Vision for Player 8")},{P1,P2,P3,P4,P5},FP)
})

CIf(FP,{CDeaths("X",Exactly,1,PhaseNumber),CDeaths("X",Exactly,0,WH_WaitTimer)},{SetCDeathsX("X",SetTo,7,CheckPhaseNumber,0xFF)})
TriggerX(FP,{},{ -- Init CBPlot Setting
	SetInvincibility(Enable, 174, P8, "FBossFixed");
	SetInvincibility(Disable, 1, P1, "Anywhere");
	SetInvincibility(Disable, 10, P2, "Anywhere");
	SetInvincibility(Disable, 16, P3, "Anywhere");
	SetInvincibility(Disable, 99, P4, "Anywhere");
	SetInvincibility(Disable, 100, P5, "Anywhere");
	SetInvincibility(Disable, 0, Force1, "Anywhere");
	SetCDeaths("X",SetTo,650,WH_CenterTimer);
	SetNVar(WH_LoopMax,SetTo,600);
	SetNVar(Cur_DataIndex,SetTo,1);
	SetNVar(Pre_DataIndex,SetTo,0);
})
	CIf(FP,{CDeaths("X",AtLeast,1,WH_CenterTimer)})
		CIf(FP,{CDeaths("X",Exactly,0,WH_Timer)},{SetCDeaths("X",SetTo,8,WH_Timer),SetNVar(WH_Shape,SetTo,1),SetNVar(WH_DataIndex,SetTo,0)})
			CallCFuncX(FP,WH_CBPlot) -- CreateUnit
		CIfEnd()
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,3),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot) -- Order

		DoActionsX(FP,{
			SetCDeaths("X",Subtract,1,WH_Timer);
			SetNVar(WH_Angle,Add,1);
			SetCDeaths("X",Subtract,1,WH_CenterTimer);
			SetPlayerColor(P8, Add, 1);
			SetMinimapColor(P8, Add, 1);
		})
	CIfEnd()
TriggerX(FP,{CDeaths("X",Exactly,0,WH_CenterTimer)},{
	GiveUnits(all,21,P8,"Anywhere",P6);
	GiveUnits(all,80,P8,"Anywhere",P6);
	GiveUnits(all,58,P8,"Anywhere",P6);
	GiveUnits(all,98,P8,"Anywhere",P6);
	SetInvincibility(Disable, 21, P6, "Anywhere");
	SetInvincibility(Disable, 80, P6, "Anywhere");
	SetInvincibility(Disable, 58, P6, "Anywhere");
	SetInvincibility(Disable, 98, P6, "Anywhere");
	SetCDeaths("X",SetTo,34*10,WH_WaitTimer);
	SetCDeaths("X",SetTo,0,WH_Timer); -- Reset
	SetCDeaths("X",SetTo,2,PhaseNumber);
	SetPlayerColor(P7, SetTo, 128);
	SetMinimapColor(P7,	SetTo, 128);
	SetPlayerColor(P8, SetTo, 85);
	SetMinimapColor(P8,	SetTo, 85);
	SetPlayerColor(P6, SetTo, 127);
	SetMinimapColor(P6,	SetTo, 127);
	CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")}, {P6}, FP);
})
CIfEnd()

--------< FBoss WH Phase 2 >--------

WH_PH2Time = 34*3

CIf(FP,{CDeaths("X",Exactly,2,PhaseNumber),CDeaths("X",Exactly,0,WH_WaitTimer)},{{SetCDeathsX("X",SetTo,8,CheckPhaseNumber,0xFF)}})
	DoActionsX(FP,{
		SetNVar(WH_DataIndex,SetTo,600);
		SetNVar(WH_LoopMax,SetTo,600);
		SetNVar(Cur_DataIndex,SetTo,2);
		SetNVar(Pre_DataIndex,SetTo,1);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,0,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,1,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,4); -- WH_B1
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,6);
		SetNVar(WH_Unit,SetTo,80);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,1,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,2,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,5);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,7);
		SetNVar(WH_Unit,SetTo,80);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,2,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,3,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,4);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,6);
		SetNVar(WH_Unit,SetTo,21);
        
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,3,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,4,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,5);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,7);
		SetNVar(WH_Unit,SetTo,21);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,4,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,5,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,4);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,6);
		SetNVar(WH_Unit,SetTo,86);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,5,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,6,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,5);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,7);
		SetNVar(WH_Unit,SetTo,86);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,6,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,7,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,4);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,6);
		SetNVar(WH_Unit,SetTo,96);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,7,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,8,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,5);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,7);
		SetNVar(WH_Unit,SetTo,96);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,8,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,9,WH_Stage);
		SetCDeaths("X",SetTo,WH_PH2Time,WH_Timer);
		SetNVar(WH_Shape,SetTo,4);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,6);
		SetNVar(WH_Unit,SetTo,98);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,9,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,10,WH_Stage);
		SetCDeaths("X",SetTo,34*15,WH_Timer);
		SetNVar(WH_Shape,SetTo,5);
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Player,SetTo,7);
		SetNVar(WH_Unit,SetTo,98);
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,10,WH_Stage);
		CDeaths("X",Exactly,0,WH_Timer);
	},{
		SetCDeaths("X",SetTo,11,WH_Stage);
		SetCDeaths("X",SetTo,0,WH_Timer); -- Reset Timer
		SetInvincibility(Disable, 174, P8, "Anywhere");
		SetNVar(FBossHP2,SetTo,3); -- Regen FBossHP
	})
	TriggerX(FP,{
		CDeaths("X",Exactly,11,WH_Stage);
		NVar(FBossHP2,AtMost,2); -- Remain FBossHP
	},{
		SetInvincibility(Enable,174,P8,"Anywhere");
		CreateUnit(1,84,"FBossFixed",P8);
		KillUnit(84,P8);
		SetNVar(FBossHP2,SetTo,3);
		SetCDeaths("X",SetTo,3,PhaseNumber);
		SetCDeaths("X",SetTo,34*10,WH_WaitTimer);
	})
	CIf(FP,{CDeaths("X",AtMost,10,WH_Stage)})
		CallCFuncX(FP,WH_CBPlot)
	CIfEnd()
DoActionsX(FP,{SetCDeaths("X",Subtract,1,WH_Timer)})
CIfEnd() -- WH2 End

--------< FBoss WH Phase 3 >--------

AngleTemp, AngleSW, RangeRand, WH_BulletAngle = CreateVars(4,FP)

CIf(FP,{CDeaths("X",Exactly,3,PhaseNumber),CDeaths("X",Exactly,0,WH_WaitTimer)},{{SetCDeathsX("X",SetTo,9,CheckPhaseNumber,0xFF)}})

BulletImage2 = 973 -- 533
BulletScript2 = 242
BulletColor2 = 16
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage2,BulletScript2,BulletColor2,150,10,7,1,2,3,{12,12,12},0)
--CSPlot(WH_Main1,P1,1,"FBossFixed",nil,1,32,FP) -- Test
TriggerX(FP,{},{ -- Init CBPlot Setting
		SetNVar(WH_DataIndex,SetTo,600);
		SetNVar(WH_LoopMax,SetTo,600);
		SetNVar(FBossHP2,SetTo,10); -- Regen FBossHP
		SetImageColor(441, 12); -- Invisible Image
		SetCDeaths("X",SetTo,0,WH_Timer);
		SetCDeaths("X",SetTo,0,WH_Stage);
		SetNVar(Cur_DataIndex,SetTo,3);
		SetNVar(Pre_DataIndex,SetTo,2);
		MoveUnit(1,174,P8,"Anywhere","FBossFixed");
	})
TriggerX(FP,{NVar(AngleSW,Exactly,0)},{SetNVar(AngleTemp,Add,2*256)},{Preserved})
TriggerX(FP,{NVar(AngleSW,Exactly,1)},{SetNVar(AngleTemp,Add,-2*256)},{Preserved})

-- WH_Timer ( 0xFFFF : InvUnitTimer // 0xFF0000 : PatternType // 0xFF000000 : BulletColor )

TriggerX(FP,{CDeathsX("X",Exactly,0*16777216,WH_Timer,0xFF000000)},{SetImageColor(440,0),SetImageColor(BulletImage2,0)},{Preserved}) -- Yellow
TriggerX(FP,{CDeathsX("X",Exactly,1*16777216,WH_Timer,0xFF000000)},{SetImageColor(440,16),SetImageColor(BulletImage2,16)},{Preserved}) -- Blue
TriggerX(FP,{CDeathsX("X",Exactly,2*16777216,WH_Timer,0xFF000000)},{SetImageColor(440,13),SetImageColor(BulletImage2,13)},{Preserved}) -- Green

CDoActions(FP,{
	TSetNVar(RangeRand,SetTo,_Add(_Mod(_Rand(),128),64)); -- RangeRandom
	SetCDeathsX("X",Add,1*16777216,WH_Timer,0xFF000000);
})

SpreadBullet = InitCFunc(FP)

CFunc(SpreadBullet)
	CreateBullet(FP,P8,195,3,WH_BulletAngle,768,RangeRand,{"FBoss",2048,1900})
CFuncEnd()
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,0*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,21*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,43*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,64*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,85*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,107*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,128*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,149*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,171*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,192*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,213*256))})
	CallCFuncX(FP,SpreadBullet)
	CDoActions(FP,{TSetNVar(WH_BulletAngle,SetTo,_Add(AngleTemp,235*256))})
	CallCFuncX(FP,SpreadBullet)

TriggerX(FP,{NVar(AngleSW,Exactly,0),NVar(AngleTemp,AtLeast,4*255*256)},{SetNVar(AngleSW,SetTo,1)},{Preserved}) -- SetDecreasing
TriggerX(FP,{NVar(AngleSW,Exactly,1),NVar(AngleTemp,Exactly,0*256)},{SetNVar(AngleSW,SetTo,0)},{Preserved}) -- SetIncreasing

TriggerX(FP,{CDeathsX("X",Exactly,3*16777216,WH_Timer,0xFF000000)},{SetCDeathsX("X",SetTo,0*16777216,WH_Timer,0xFF000000)},{Preserved}) -- ResetColor

DoActionsX(FP,{SetNVar(WH_DataIndex,SetTo,600)})

CIf(FP,{CDeathsX("X",Exactly,0,WH_Timer,0xFFFF),CDeathsX("X",Exactly,1*65536,WH_Timer,0xFF0000)})
	NReset(FP,ST1)
	TriggerX(FP,{Bring(P8,AtLeast,1,9,"Anywhere")},{ -- Fatal Pattern
		SetNVar(WH_DataIndex,SetTo,0);
		SetNVar(WH_Shape,SetTo,7);
		SetCDeathsX("X",SetTo,34*2,WH_Timer,0xFFFF);
		SetCDeathsX("X",SetTo,0*65536,WH_Timer,0xFF0000);
		KillUnit(28,P8);
		KillUnit(9,P8);
		SetInvincibility(Enable, 174, P8, "FBossFixed");
	},{Preserved})
	TriggerX(FP,{Bring(P8,Exactly,0,9,"Anywhere")},{ -- Jump Fatal Pattern
		SetNVar(WH_Shape,SetTo,7);
		SetCDeathsX("X",SetTo,34*15,WH_Timer,0xFFFF);
		SetCDeathsX("X",SetTo,0*65536,WH_Timer,0xFF0000);
		KillUnit(28,P8);
		KillUnit(9,P8);
		SetInvincibility(Disable, 174, P8, "FBossFixed");
	},{Preserved})
CIfEnd()

TriggerX(FP,{
	CDeathsX("X",Exactly,0,WH_Timer,0xFFFF);
	CDeathsX("X",Exactly,0*65536,WH_Timer,0xFF0000);
},{
	SetNVar(WH_DataIndex,SetTo,0);
	SetNVar(WH_Shape,SetTo,6);
	SetCDeathsX("X",SetTo,34*20,WH_Timer,0xFFFF);
	SetCDeathsX("X",SetTo,1*65536,WH_Timer,0xFF0000); -- Set Inv Pattern
	KillUnit(9,P8);
	SetInvincibility(Enable, 174, P8, "FBossFixed");
},{Preserved})

CallCFuncX(FP,WH_CBPlot)

CIf(FP,{CDeathsX("X",Exactly,1*65536,WH_Timer,0xFF0000)})
	NBagLoop(FP,ST1,{NBagPtr})
		CDoActions(FP,{TSetMemory(Vi(NBagPtr[2],2),SetTo,256*6666666)})
	NBagLoopEnd()
CIfEnd()

TriggerX(FP,{
	NVar(FBossHP2,AtMost,2); -- Remain FBossHP
},{
	SetInvincibility(Enable,174,P8,"Anywhere");
	CreateUnit(1,84,"FBossFixed",P8);
	KillUnit(84,P8);
	SetNVar(FBossHP2,SetTo,3);
	SetCDeaths("X",SetTo,4,PhaseNumber);
	SetCDeaths("X",SetTo,34*10,WH_WaitTimer);
})

DoActionsX(FP,{SetCDeathsX("X",Subtract,1,WH_Timer,0xFFFF)})

CIfEnd() -- PH3 End

CIf(FP,{CDeaths("X",Exactly,4,PhaseNumber),CDeaths("X",Exactly,0,WH_WaitTimer)},{{SetCDeathsX("X",SetTo,10,CheckPhaseNumber,0xFF)}}) -- PH4

function SetBrightness(Type,Value)
	return SetMemory(0x657A9C,Type,Value)
end
function Brightness(Type,Value)
	return Memory(0x657A9C,Type,Value)
end

TriggerX(FP,{},{ -- Init CBPlot Setting
		SetNVar(WH_DataIndex,SetTo,600);
		SetNVar(WH_LoopMax,SetTo,600);
		SetNVar(FBossHP2,SetTo,10); -- Regen FBossHP
		SetImageColor(440,12); -- Set Invisible Grenade Hit
		SetImageColor(441,12); -- Set Invisible Smoke
		SetCDeaths("X",SetTo,0,WH_Timer); -- Reset Timer
		SetCDeaths("X",SetTo,0,WH_Stage);
		SetNVar(Cur_DataIndex,SetTo,4);
		SetNVar(Pre_DataIndex,SetTo,3);
		SetNVar(WH_Unit,SetTo,0);
		MoveUnit(1,174,P8,"Anywhere","FBossFixed");
	})
	-- BrightSW : 0xFF = 밝기증감 // 0xFF00 : 극소값 횟수 // 0xFF0000 : 밝기조절 on/off

	CIf(FP,{CDeathsX("X",Exactly,0*65536,BrightSW,0xFF0000)})
		TriggerX(FP,{CDeathsX("X",Exactly,0,BrightSW,0xFF)},{SetBrightness(Subtract,2)},{Preserved})
		TriggerX(FP,{CDeathsX("X",Exactly,1,BrightSW,0xFF)},{SetBrightness(Add,2)},{Preserved})
		TriggerX(FP,{Brightness(Exactly,1)},{SetCDeathsX("X",SetTo,1,BrightSW,0xFF),SetCDeathsX("X",Add,1*256,BrightSW,0xFF00)},{Preserved})
		TriggerX(FP,{Brightness(Exactly,31)},{SetCDeathsX("X",SetTo,0,BrightSW,0xFF)},{Preserved})

		CIf(FP,{CDeathsX("X",Exactly,1,BrightSW,0xFF),Brightness(Exactly,1)})
			DoActionsX(FP,{
				SetNVar(WH_Shape,SetTo,12); -- FloorShape
				SetNVar(WH_DataIndex,SetTo,0); -- Reset
			})
			CallCFuncX(FP,WH_CBPlot)
		CIfEnd()

		TriggerX(FP,{CDeathsX("X",Exactly,3*256,BrightSW,0xFF00),Brightness(Exactly,1)},{SetCDeathsX("X",SetTo,1*65536,BrightSW,0xFF0000)})
	CIfEnd()

	CIf(FP,{CDeathsX("X",Exactly,1*65536,BrightSW,0xFF0000)})
		Trigger2(FP,{Brightness(AtMost,30)},{SetBrightness(Add, 2)},{Preserved})
		DoActionsX(FP,{
			SetNVar(WH_Shape,SetTo,10); -- WH_Main2
			SetNVar(WH_DataIndex,SetTo,0); -- Reset
			RemoveUnit(204,P8);
		})
		-- WH_Stage : 0xFF = 유닛생성단계 / 0xFF00 = 유닛생성플래그 / 0xFF0000 플레이어변수체크

		TriggerX(FP,{ -- 4페이즈 초기 대기시간 50초
			CDeathsX("X",Exactly,0,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,1,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,0*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*50,WH_Timer);
		})
		TriggerX(FP,{ -- 4-1
			CDeathsX("X",Exactly,1,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,2,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*20,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,80);
			SetNVar(WH_GUnit1,SetTo,65);
			SetNVar(WH_AUnit2,SetTo,21);
			SetNVar(WH_GUnit2,SetTo,78);
			SetNVar(WH_Inside,SetTo,64);
			SetNVar(WH_Outside,SetTo,25);
		})
		TriggerX(FP,{ -- 4-2
			CDeathsX("X",Exactly,2,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,3,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*20,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,21);
			SetNVar(WH_GUnit1,SetTo,66);
			SetNVar(WH_AUnit2,SetTo,80);
			SetNVar(WH_GUnit2,SetTo,77);
			SetNVar(WH_Inside,SetTo,64);
			SetNVar(WH_Outside,SetTo,25);
		})
		TriggerX(FP,{ -- 4-3
			CDeathsX("X",Exactly,3,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,4,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*30,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,88);
			SetNVar(WH_GUnit1,SetTo,3);
			SetNVar(WH_AUnit2,SetTo,8);
			SetNVar(WH_GUnit2,SetTo,52);
			SetNVar(WH_Inside,SetTo,90);
			SetNVar(WH_Outside,SetTo,25);
		})
		TriggerX(FP,{ -- 4-4
			CDeathsX("X",Exactly,4,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,5,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*30,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,8);
			SetNVar(WH_GUnit1,SetTo,5);
			SetNVar(WH_AUnit2,SetTo,88);
			SetNVar(WH_GUnit2,SetTo,81);
			SetNVar(WH_Inside,SetTo,90);
			SetNVar(WH_Outside,SetTo,25);
		})
		TriggerX(FP,{ -- 4-5
			CDeathsX("X",Exactly,5,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,6,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*30,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,60);
			SetNVar(WH_GUnit1,SetTo,87);
			SetNVar(WH_AUnit2,SetTo,98);
			SetNVar(WH_GUnit2,SetTo,79);
			SetNVar(WH_Inside,SetTo,27);
			SetNVar(WH_Outside,SetTo,30);
		})
		TriggerX(FP,{ -- 4-6
			CDeathsX("X",Exactly,6,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,7,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*30,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,98);
			SetNVar(WH_GUnit1,SetTo,61);
			SetNVar(WH_AUnit2,SetTo,60);
			SetNVar(WH_GUnit2,SetTo,75);
			SetNVar(WH_Inside,SetTo,27);
			SetNVar(WH_Outside,SetTo,30);
		})
		TriggerX(FP,{ -- 4-7
			CDeathsX("X",Exactly,7,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,8,WH_Stage,0xFF);
			SetCDeathsX("X",SetTo,1*256,WH_Stage,0xFF00);
			SetCDeaths("X",SetTo,34*40,WH_Timer);
			SetNVar(WH_AUnit1,SetTo,58);
			SetNVar(WH_GUnit1,SetTo,76);
			SetNVar(WH_AUnit2,SetTo,89);
			SetNVar(WH_GUnit2,SetTo,81);
			SetNVar(WH_Inside,SetTo,9);
			SetNVar(WH_Outside,SetTo,68);
		})
		TriggerX(FP,{
			CDeathsX("X",Exactly,8,WH_Stage,0xFF);
			CDeaths("X",Exactly,0,WH_Timer);
		},{
			SetCDeathsX("X",SetTo,9,WH_Stage,0xFF);
			SetNVar(FBossHP2,SetTo,8);
			SetInvincibility(Disable, 174, P8, "Anywhere");
		})
		TriggerX(FP,{
			CDeathsX("X",Exactly,9,WH_Stage,0xFF);
			NVar(FBossHP2,AtMost,2); -- Remain FBossHP
		},{
			SetInvincibility(Enable,174,P8,"Anywhere");
			CreateUnit(1,84,"FBossFixed",P8);
			KillUnit(84,P8);
			SetNVar(FBossHP2,SetTo,3);
			SetCDeaths("X",SetTo,5,PhaseNumber);
			SetCDeaths("X",SetTo,34*10,WH_WaitTimer);
		})

		TriggerX(FP,{NVar(VTimeLine,AtLeast,360)},{SetNVar(VTimeLine,SetTo,0)},{Preserved}) -- 캐시메모리 인덱스 초기화 ( 주기 180틱 )
		CallCFuncX(FP,WH_CBPlot)

		BulletImage2 = 210
		BulletScript2 = 242
		BulletColor2 = 10
		BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,1,1,7,1,2,3,{1,1,1},0)

		DoActionsX(FP,{
			SetNVar(WH_Shape,SetTo,12); -- FloorShape
			SetNVar(WH_DataIndex,SetTo,0); -- Reset
		})
		CIf(FP,{CDeathsX("X",Exactly,0,ResetBulletTimer,0xFF)},{SetCDeathsX("X",SetTo,255,ResetBulletTimer,0xFF)})
			CallCFuncX(FP,WH_CBPlot)
		CIfEnd()
		TriggerX(FP,{CDeathsX("X",Exactly,1*256,WH_Stage,0xFF00)},{Order("Men",Force2,"Anywhere",Attack,"FBossFixed")},{Preserved})
		DoActionsX(FP,{
			SetCDeathsX("X",Subtract,1,ResetBulletTimer,0xFF);
			SetCDeathsX("X",SetTo,0*256,WH_Stage,0xFF00);
			SetCDeaths("X",Subtract,1,WH_Timer);
			SetNVar(VTimeLine,Add,1);
		})
	CIfEnd() -- Brightness End
CIfEnd() -- PH4 End

CIf(FP,{CDeaths("X",Exactly,5,PhaseNumber),CDeaths("X",Exactly,0,WH_WaitTimer)},{{SetCDeathsX("X",SetTo,11,CheckPhaseNumber,0xFF)}}) -- PH5
	TriggerX(FP,{},{ -- Init CBPlot Setting
		SetNVar(WH_DataIndex,SetTo,600);
		SetNVar(WH_LoopMax,SetTo,600);
		SetNVar(FBossHP2,SetTo,10); -- Regen FBossHP
		SetNVar(WH_Shape,SetTo,11);
		SetCDeaths("X",SetTo,0,WH_Timer); -- Reset Timer
		SetCDeaths("X",SetTo,0,WH_Stage);
		SetCDeaths("X",SetTo,0,PH5_Stage);
		SetNVar(WH_Unit,SetTo,0);
		SetNVar(Cur_DataIndex,SetTo,5);
		SetNVar(Pre_DataIndex,SetTo,4);
		MoveUnit(1,174,P8,"Anywhere","FBossFixed");
		SetInvincibility(Disable,174,P8,"Anywhere");
	})

-- PH5 BossTrace --

DoActionsX(FP,{SetNVar(WH_DataIndex,SetTo,0),SetNVar(WH_Shape,SetTo,11)})
CallCFuncX(FP,WH_CBPlot)
DoActionsX(FP,{SetNVar(VTimeLine,Add,1),SetNVar(UnitPos,Add,1)})
TriggerX(FP,{NVar(VTimeLine,AtLeast,180)},{SetNVar(VTimeLine,SetTo,0)},{Preserved}) -- 캐시메모리 인덱스 초기화 ( 주기 180틱 )
TriggerX(FP,{NVar(UnitPos,AtLeast,WH_Main3[1])},{SetNVar(UnitPos,SetTo,0)},{Preserved}) -- Reset FBossPos

-- PH5 Bullet --
VTimer = CreateCcode()
BulletImage2 = 363
BulletScript2 = 235
BulletColor2 = 16
BulletInitSetting(FP,{194,122,283},90,199,493,BulletImage2,BulletScript2,BulletColor2,150,10,7,1,2,3,{16,16,16},0)
BulletInitSetting(FP,{195,123,284},87,199,493,BulletImage2,BulletScript2,BulletColor2,150,10,7,1,2,3,{24,24,24},0)
BulletInitSetting(FP,{196,124,285},88,199,493,BulletImage2,BulletScript2,BulletColor2,150,10,7,1,2,3,{32,32,32},0)
BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,150,10,7,1,2,3,{40,30,40},0)

DoActions(FP,{
	SetImageColor(BulletImage2, BulletColor2),SetImageColor(440, BulletColor2)
	,SetImageColor(441, 12),SetImageColor(148, 12),SetImageColor(427,17)})

CIf(FP,{CDeathsX("X",Exactly,0,VTimer,0xFF)},{SetCDeathsX("X",SetTo,34*3,VTimer,0xFF),SetCDeathsX("X",Add,1*256,VTimer,0xFF00)})
	CFor(FP,0,256*256,4*256)
		local CBAngle = CForVariable()
		CreateBullet(FP,P8,194,4,CBAngle,1000,44,"CForBulletLoc")
		CreateBullet(FP,P8,195,4,CBAngle,1000,66,"CForBulletLoc")
		CreateBullet(FP,P8,196,4,CBAngle,1000,88,"CForBulletLoc")
		CreateBullet(FP,P8,197,4,CBAngle,1000,110,"CForBulletLoc")
	CForEnd()
	TriggerX(FP,{CDeathsX("X",Exactly,0*256,VTimer,0xFF00)},{SetImageColor(BulletImage2,16)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,1*256,VTimer,0xFF00)},{SetImageColor(BulletImage2,9)},{Preserved})
	TriggerX(FP,{CDeathsX("X",Exactly,2*256,VTimer,0xFF00)},{SetCDeathsX("X",SetTo,0*256,VTimer,0xFF00)},{Preserved})
CIfEnd()

DoActionsX(FP,{SetNVar(WH_DataIndex,SetTo,600)})

CIf(FP,{CDeaths("X",Exactly,1,PH5_Stage)},{SetCDeaths("X",Add,1,WH_Stage),SetCDeaths("X",SetTo,0,PH5_Stage)})
	TriggerX(FP,{CDeaths("X",Exactly,1,WH_Stage)},{
		SetNVar(WH_GUnit1,SetTo,65);SetNVar(WH_GUnit2,SetTo,66);SetNVar(WH_AUnit1,SetTo,88);SetNVar(WH_AUnit2,SetTo,86),SetNVar(WH_Outside,SetTo,96)})
	TriggerX(FP,{CDeaths("X",Exactly,2,WH_Stage)},{
		SetNVar(WH_GUnit1,SetTo,3);SetNVar(WH_GUnit2,SetTo,52);SetNVar(WH_AUnit1,SetTo,8);SetNVar(WH_AUnit2,SetTo,90),SetNVar(WH_Outside,SetTo,96)})
	TriggerX(FP,{CDeaths("X",Exactly,3,WH_Stage)},{
		SetNVar(WH_GUnit1,SetTo,87);SetNVar(WH_GUnit2,SetTo,61);SetNVar(WH_AUnit1,SetTo,60);SetNVar(WH_AUnit2,SetTo,98),SetNVar(WH_Outside,SetTo,22)})
	TriggerX(FP,{CDeaths("X",Exactly,4,WH_Stage)},{
		SetNVar(WH_GUnit1,SetTo,23);SetNVar(WH_GUnit2,SetTo,25);SetNVar(WH_AUnit1,SetTo,102);SetNVar(WH_AUnit2,SetTo,64),SetNVar(WH_Outside,SetTo,22)})
	TriggerX(FP,{CDeaths("X",Exactly,5,WH_Stage)},{
		SetNVar(WH_GUnit1,SetTo,68);SetNVar(WH_GUnit2,SetTo,30);SetNVar(WH_AUnit1,SetTo,27);SetNVar(WH_AUnit2,SetTo,9),
		SetInvincibility(Enable, 174, P8, "Anywhere"),SetCDeathsX("X",SetTo,1,BossEnd,0xFF)})
	CIfX(FP,{CDeaths("X",AtMost,4,WH_Stage)})
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,13),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot)
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,14),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot)
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,15),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot)
	CElseIfX({CDeaths("X",Exactly,5,WH_Stage)})
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,18),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot)
		DoActionsX(FP,{SetNVar(WH_Shape,SetTo,19),SetNVar(WH_DataIndex,SetTo,0)})
		CallCFuncX(FP,WH_CBPlot)
	CIfXEnd()
CIfEnd()

TriggerX(FP,{CDeaths("X",Exactly,5,WH_Stage)},{MoveUnit(1,174,P8,"Anywhere","FBossFixed")})
Trigger2(FP,{Bring(P8,Exactly,0,68,"BZone"),Bring(P8,Exactly,0,9,"BZone")},{SetInvincibility(Disable, 174, P8, "Anywhere")},{Preserved})

TriggerX(FP,{
	Bring(P8,Exactly,0,174,"Anywhere");
	CDeathsX("X",Exactly,1,BossEnd,0xFF);
},{
	SetCDeaths("X",SetTo,6,PhaseNumber);
	SetCDeaths("X",SetTo,34*20,WH_WaitTimer);
	CopyCpAction({DisplayTextX("\r\n\r\n\r\n\r\n\r\n\x13\x04·\x1B·\x08·\x06- \x04“ \x08Final \x06Boss \x04:: \x08「 \x08Ｎ\x1Bｉｎｆｉａ 」\x04를 쓰러트렸습니다. \x04“ \x06-\x08·\x1B·\x04· \r\n\r\n\r\n\r\n\r\n", 4),
	PlayWAVX("staredit\\wav\\ClearFBoss.ogg")}, {P1,P2,P3,P4,P5}, FP)
})

DoActionsX(FP,{
	SetCDeathsX("X",Subtract,1,VTimer,0xFF)})

CIfEnd() -- PH5 End

CIf(FP,{CDeaths("X",Exactly,6,PhaseNumber),CDeathsX("X",Exactly,1,BossEnd,0xFF)})
DoActionsX(FP,{		
	SetNVar(WH_Shape,SetTo,17);
	SetNVar(WH_DataIndex,SetTo,0)
})
	CallCFuncX(FP,WH_CBPlot)
	DoActionsX(FP,{SetNVar(VTimeLine,Add,1)})
	TriggerX(FP,{NVar(VTimeLine,AtLeast,180)},{
		SetNVar(VTimeLine,SetTo,0);
		SetCDeathsX("X",SetTo,2,BossEnd,0xFF);
		SetCDeaths("X",SetTo,2,PhaseClear);
		SetSwitch("Switch 100",Set);
	}) -- 캐시메모리 인덱스 초기화 ( 주기 720틱 ) // 보스엔딩
CIfEnd()

DoActionsX(FP,{SetCDeaths("X",Subtract,1,WH_WaitTimer)}) -- WaitTimer Control

CIfEnd() -- WHPhase End
end