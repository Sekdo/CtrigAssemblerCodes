function Install_FBoss()
--------< BulletVar / Ccodes >--------
PhaseNumber, WaitTimer, PhaseClear, InvTimer, SetBossHP, BWaitTimer, PreSaveCache, CheckPhaseNumber,PH5_Stage, BossEnd = CreateCcodes(10)
CB_Shapes, CB_WaitTimer, CB_DataIndex = CreateVars(3,FP) -- CBCAPlotVars
Nextptr, FBossPtr, FBossHP, FBossHP2 = CreateVars(4,FP) -- Init BossVars
CBTimer, CBTimer2, CBAngleX, CBAngle2X, CBSW, CBLock, BulletAngle, VColor = CreateVars(8,FP) -- BulletVars
W, X, Y, Z = CreateVars(4,FP) -- PH3 Vars
CA_AngleX, CA_AngleY, CA_AngleZ, CA_Angle2, PerAngle, CA_Angle3, PH4_Timer, PH4_CBAngle, PH4_SW = CreateVars(9,FP) -- PH4 Vars
MPosX, MPosY, MPosA, MPosA2, MPosA3, TempX ,TempY = CreateVars(7,FP)  -- MarPos Vars
CAX, PH5_Timer, BTimer = CreateVars(3,FP) -- PH5 Vars

Cur_DataIndex, Pre_DataIndex = CreateVars(2,FP) -- HPSprite


function SetNextptr()
	f_Read(FP,0x628438,nil,Nextptr)
end

function CreateEffect(Player,Variable,Color,ScriptID,Height,UnitID,Loc,Owner)
	SetNextptr()
		CTrigger(Player,{NVar(Variable,AtLeast,19025),NVar(Variable,AtMost,161741)},{
			SetMemoryB(0x669E28+ScriptID,SetTo,Color);
			SetMemoryB(0x663150+UnitID,SetTo,Height);
			TCreateUnit(1,UnitID,Loc,Owner);
			TSetDeathsX(Vi(Variable[2],72),SetTo,255*256,0,0xFF00);
			TSetDeathsX(Vi(Variable[2],55),SetTo,0x200104,0,0x300104);
			TSetDeaths(Vi(Variable[2],57),SetTo,0,0)},{Preserved})
end

function SetLabel(Index)
	Trigger {
		players = {FP},
		conditions = {
				Label(Index);
			},
	}
end

function ReadPosXY(VarX,VarY)
	f_Read(FP,0x58DC60+20*7+0x0,VarX)
	f_Read(FP,0x58DC60+20*7+0x4,VarY)
end

function CalcAngle(VarA,VarX,VarY)
	f_Atan2(FP,_Neg(_iSub(VarY,1920-64)),_Neg(_iSub(VarX,2048)),VarA) -- X값 -64평행이동 계산
	f_Mul(FP,VarA,256)
	f_Div(FP,VarA,360)
	CAdd(FP,VarA,64)
end

--]]
-- BGM --

BGMV = CreateVar(FP)

IBGM_EPD(FP,{Force1,Force5},BGMV,{
	{1,"staredit\\wav\\FBoss3.ogg",248*1000},
	{2,"staredit\\wav\\Entrance2.ogg",301*1000}
	})
DoActionsX(FP,{
	SetNVar(BGMV,SetTo,1);
	SetMemory(0x657470+4*0,SetTo,224); -- 보스전 일마사거리증가
	SetMemory(0x657470+4*1,SetTo,224); -- 보스전 영마사거리증가
})


--------< Save FBossEPD >--------
CIfOnce(FP)
	f_Read(FP,0x628438,nil,Nextptr)
	DoActions(FP,SetImageColor(135,12))
	CMov(FP,FBossPtr,Nextptr) -- Save FBossPtr
		CDoActions(FP,{
			CreateUnit(1,174,"FBossN",P8);
			SetInvincibility(Enable, 68, P8, "FBossN");
			GiveUnits(1,174,P8,"FBossN",P12);
			TSetMemory(Vi(Nextptr[2],2),SetTo,256*8000000);
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0xA00000,0xA00000);
		})
	CMov(FP,FBossHP,Nextptr,2) -- Save FBossHP
	DoActions(FP,SetImageColor(135,0))
CIfEnd()


--------< Marine Stacking Trig >--------
Player_S = CreateVarArr(5,FP)
Player_0x18 = CreateVarArr(5,FP)
Player_0x4D = CreateVarArr(5,FP)
Player_0x58 = CreateVarArr(5,FP)
Player_0x5C = CreateVarArr(5,FP)
Player_T = CreateVarArr(5,FP)
Player_C = CreateVarArr(5,FP)

MarID = {1,10,16,99,100}

CIf(FP,{CDeaths("X",Exactly,0,PhaseClear)})
for i= 0, 4 do
	Player_0x4DTemp = Player_0x4D[i+1]
		CIf(FP,{PlayerCheck(i,1)})
			f_Read(P6,0x6284E8+(0x30*i),"X",Player_S[i+1],0xFFFFFF)
			CIf(FP,Memory(0x6284E8+(0x30*i),AtLeast,1))
				CMov(FP,Player_0x4D[i+1],_ReadF(_Add(Player_S[i+1],0x4C/4),0xFF00),nil,0xFF00)
				CMov(FP,Player_0x18[i+1],_ReadF(_Add(Player_S[i+1],0x18/4)))
				CMov(FP,Player_0x58[i+1],_ReadF(_Add(Player_S[i+1],0x58/4)))
				CMov(FP,Player_0x5C[i+1],_ReadF(_Add(Player_S[i+1],0x5C/4)))
				CIf(FP,{CVar(FP,Player_0x4DTemp[2],AtLeast,256)})
					CMov(FP,Player_C[i+1],1)
					Player_CTemp = Player_C[i+1]
					CWhile(FP,{CVar(FP,Player_CTemp[2],AtMost,11)})
						CIf(FP,{TDeaths(_Add(Player_C[i+1],EPDF(0x6284E8+(0x30*i))),AtLeast,1,0)})
							CMov(FP,Player_T[i+1],_EPD(_ReadF(_Add(Player_C[i+1],EPDF(0x6284E8+(0x30*i))))))
							CTrigger(FP,{
								TDeaths(_Add(Player_T[i+1],0x8/4),AtLeast,256,0),
								TDeathsX(_Add(Player_T[i+1],0x4C/4),AtLeast,1*256,0,0xFF00)
								},
							{
								TSetDeathsX(_Add(Player_T[i+1],0x4C/4),SetTo,Player_0x4D[i+1],0,0xFF00),
								TSetDeaths(_Add(Player_T[i+1],0x18/4),SetTo,Player_0x18[i+1],0),
								TSetDeaths(_Add(Player_T[i+1],0x58/4),SetTo,Player_0x58[i+1],0),
								TSetDeaths(_Add(Player_T[i+1],0x5C/4),SetTo,Player_0x5C[i+1],0)
								},1)
						CIfEnd()
						CAdd(FP,Player_C[i+1],1)
					CWhileEnd()
				CIfEnd()
			CIfEnd()
		CIfEnd()
end

CMov(FP,0x6509B0,19025+25)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+25 + (84*1699)))
    for i = 1, 5 do
		CIf(FP,DeathsX(CurrentPlayer,Exactly,MarID[i],0,0xFFFF))
			DoActions(FP,{
				MoveCp(Add,30*4);
				SetDeathsX(CurrentPlayer,SetTo,0xA00000,0,0xA00000);
				MoveCp(Subtract,30*4);
			})
		CIfEnd()
    end
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
CMov(FP,0x6509B0,FP) -- RecoverCp

DoActions(FP,SetInvincibility(Enable, "Men", Force1, "Anywhere"))
for i = 0, 4 do
    Trigger2(FP,{Bring(i,AtLeast,1,"Men","BZone")},{SetInvincibility(Disable, "Men", i, "Disable")},{Preserved}) -- 보스존 진입시 무적해제
end

CIfEnd() -- PhaseClearEnd

TriggerX(FP,{Bring(P8,Exactly,0,174,"FBoss")},{
	SetCDeaths("X", SetTo, 34*30, WaitTimer);
	SetCDeaths("X", SetTo, 34*40, InvTimer);
	SetCDeaths("X", SetTo, 1, PhaseNumber);
	SetCDeaths("X", SetTo, 1, PreSaveCache); -- 캐시메모리 저장 (1틱)
	MoveUnit(1,174,P12,"FBossN","FBoss");
	GiveUnits(1,174,P12,"FBoss",P8);
	SetInvincibility(Disable, 174, P8, "FBoss");
	--SetMemoryW(0x657678+2*1,SetTo,92); -- 보스전 공 1.5배
})

CTrigger(FP,{ -- Regene FBossHP Before PH5
	TMemory(FBossHP,AtMost,256*1000000);
	NVar(FBossHP2,AtLeast,2);
	CDeathsX("X",Exactly,0,BossEnd,0xFF);
},{
	TSetMemory(FBossHP,SetTo,256*8000000);
	SetNVar(FBossHP2,Subtract,1);
	SetCDeaths("X",SetTo,1,PH5_Stage);
},{Preserved})

CTrigger(FP,{ -- Regene FBossHP After PH5
	TMemory(FBossHP,AtMost,256*1000000);
	NVar(FBossHP2,AtLeast,1);
	CDeathsX("X",Exactly,1,BossEnd,0xFF);
},{
	TSetMemory(FBossHP,SetTo,256*8000000);
	SetNVar(FBossHP2,Subtract,1);
},{Preserved})

DoActionsX(FP,{
	SetCDeaths("X", Subtract, 1, WaitTimer);
	SetCDeaths("X", Subtract, 1 ,InvTimer);
	RemoveUnit(204, P8);
	KillUnit(84,P8);
})

TriggerX(FP,{ -- 탄막 페이즈 리셋
	CDeaths("X",Exactly,0,PhaseClear);
	CDeaths("X",Exactly,0,WaitTimer);
	CDeaths("X",AtMost,5,PhaseNumber);
	NVar(FBossHP2,Exactly,1);
},{
	SetImageScript(215, 144);
	CreateUnit(1,84,"FBossFixed",P8);
	KillUnit(84,P8);
	SetImageScript(215, 144);
	SetCDeaths("X",Add,1,PhaseNumber);
	SetCDeaths("X",SetTo,34*10,WaitTimer);
	SetCDeaths("X",SetTo,34*20,InvTimer);
	SetNVar(CBLock,SetTo,0,0xFF);
	SetNVar(CBSW,SetTo,0);
	SetNVar(CBTimer,SetTo,0);
	SetNVar(CBTimer2,SetTo,0);
},{Preserved})

CTrigger(FP,{CDeaths("X",AtLeast,1,InvTimer)},{TSetMemory(FBossHP,SetTo,256*8000000)},{Preserved})

CIfOnce(FP,{CDeaths("X",Exactly,1,PhaseClear)},{
    MoveUnit(all,"Men",P1,"Anywhere","Generator 1");
    MoveUnit(all,"Men",P2,"Anywhere","Generator 2");
    MoveUnit(all,"Men",P3,"Anywhere","Generator 3");
    MoveUnit(all,"Men",P4,"Anywhere","Generator 4");
    MoveUnit(all,"Men",P5,"Anywhere","Generator 5");
})
	CMov(FP,0x6509B0,19025+25)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+25 + (84*1699)))
        for i = 1, 5 do
			CIf(FP,DeathsX(CurrentPlayer,Exactly,MarID[i],0,0xFFFF))
				DoActions(FP,{
					MoveCp(Add,30*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xA00000);
					MoveCp(Subtract,30*4);
				})
			CIfEnd()
        end
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
	CMov(FP,0x6509B0,FP) -- RecoverCp
CIfEnd() -- CIfOnceEnd()

DoActions(FP,{SetImageColor(530,12)}) -- 탄막 폭발이미지 숨김

Install_WHPhase() -- Second ( PreSaveCache operate first )
Install_BulletPhase() -- First

CallCFuncX(FP,SaveCacheFunc)

-- HPSprite --

HPCircle = CSMakeCircleX(5,144,0,5,0)

HPSpriteIndex = 983

CJump(FP,0x103)
SetLabel(0x1007)
DoActions(FP,{SetSpriteImage(385, HPSpriteIndex)})

CIfX(FP,{CDeaths("X",Exactly,0,PhaseClear)}) -- 탄막페이즈 체력바

	CIfX(FP,{CDeathsX("X",Exactly,0,CheckPhaseNumber,0xFF)}) 
		CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
		CreateEffect(FP,Nextptr,16,HPSpriteIndex,19,204,"CLoc12",P8)
	CElseIfX({CDeathsX("X",Exactly,1,CheckPhaseNumber,0xFF)}) -- N = 1 일때

		CIfX(FP,{TNVar(Temp_DataIndex,Exactly,Cur_DataIndex)}) -- 1번째 점일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)

			CIfX(FP,{CDeathsX("X",AtMost,17*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이하
				CreateEffect(FP,Nextptr,16,HPSpriteIndex,19,204,"CLoc12",P8)
			CElseIfX({CDeathsX("X",AtLeast,18*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이상
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
			CIfXEnd()

		CElseX() -- 2번째점 이상일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,16,HPSpriteIndex,19,204,"CLoc12",P8)
		CIfXEnd()

	CElseIfX({CDeathsX("X",AtLeast,2,CheckPhaseNumber,0xFF)}) -- N >= 2 일때

		CIfX(FP,{TNVar(Temp_DataIndex,AtMost,Pre_DataIndex)}) -- N-1번째점 이하일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)

		CElseIfX({TNVar(Temp_DataIndex,Exactly,Cur_DataIndex)}) -- N번째 점일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)

			CIfX(FP,{CDeathsX("X",AtMost,17*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이하
				CreateEffect(FP,Nextptr,16,HPSpriteIndex,19,204,"CLoc12",P8)
			CElseIfX({CDeathsX("X",AtLeast,18*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이상
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
			CIfXEnd()

		CElseX() -- N+1번째점 이상일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,16,HPSpriteIndex,19,204,"CLoc12",P8)
		CIfXEnd()
	CIfXEnd()
CElseX() -- WH페이즈 체력바
	CIfX(FP,{CDeathsX("X",Exactly,6,CheckPhaseNumber,0xFF)})
		CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
		CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
		CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)

	CElseIfX({CDeathsX("X",Exactly,7,CheckPhaseNumber,0xFF)}) -- N = 1 일때

		CIfX(FP,{TNVar(Temp_DataIndex,Exactly,Cur_DataIndex)}) -- 1번째 점일때

			CIfX(FP,{CDeathsX("X",AtMost,17*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이하
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
			CElseIfX({CDeathsX("X",AtLeast,18*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이상
				CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)
			CIfXEnd()

		CElseX() -- 2번째점 이상일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
		CIfXEnd()

	CElseIfX({CDeathsX("X",AtLeast,8,CheckPhaseNumber,0xFF)}) -- N >= 2 일때

		CIfX(FP,{TNVar(Temp_DataIndex,AtMost,Pre_DataIndex)}) -- N-1번째 점일때
			CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)

		CElseIfX({TNVar(Temp_DataIndex,Exactly,Cur_DataIndex)}) -- N번째 점일때
			
			CIfX(FP,{CDeathsX("X",AtMost,17*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이하
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
			CElseIfX({CDeathsX("X",AtLeast,18*256,CheckPhaseNumber,0xFF00)}) -- 0.5초 이상
				CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,10,HPSpriteIndex,20,204,"CLoc12",P8)
			CIfXEnd()

		CElseX() -- N+1번째 점일때
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,6,HPSpriteIndex,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,17,HPSpriteIndex,19,204,"CLoc12",P8)
		CIfXEnd()
	CIfXEnd()
CIfXEnd()

SetLabel(0x1008)
CJumpEnd(FP,0x103)



function HPSpriteFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CMov(FP,Temp_DataIndex,V(CA[6])) -- Save DataIndex
end

CIf(FP,{CDeaths("X",AtMost,1,PhaseClear)})
	DoActionsX(FP,{SetCDeathsX("X",Add,1*256,CheckPhaseNumber,0xFF00),SetImageScript(HPSpriteIndex,131)})

	CAPlot(HPCircle,P8,193,"CLoc12",{2048,1920},1,16,
		{1,0,0,0,600,0},"HPSpriteFunc",FP,nil,{SetNext("X",0x1007),SetNext(0x1008,"X",1)},1)
	TriggerX(FP,{CDeathsX("X",AtLeast,34*256,CheckPhaseNumber,0xFF00)},{SetCDeathsX("X",SetTo,0*256,CheckPhaseNumber,0xFF00)},{Preserved})
	DoActionsX(FP,{SetCDeathsX("X",Add,1*256,0xFF00),SetImageScript(HPSpriteIndex,393)})
CIfEnd()

CIf(FP,{Bring(P8,AtLeast,1,174,"Anywhere")},{SetSpriteImage(385, 928),SetImageScript(928, 131)})
	CreateEffect(FP,Nextptr,6,928,2,204,"FBossFixed",P8)
	CreateEffect(FP,Nextptr,6,928,2,204,"FBossFixed",P8)
	CreateEffect(FP,Nextptr,17,928,1,204,"FBossFixed",P8)
DoActions(FP,{SetImageScript(928, 368),SetImageColor(928,16)})
CIfEnd()

end