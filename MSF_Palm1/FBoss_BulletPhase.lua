function Install_BulletPhase()
CIf(FP,{CDeaths("X",Exactly,0,PhaseClear)})
--------< FBoss Phase 1 >--------

CIfOnce(FP,{CDeaths("X",Exactly,1,PhaseNumber)})
	--TriggerX(FP,{Bring(Force1,AtLeast,1,111,"Anywhere"),Bring(Force1,AtMost,2,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,3)})
	--TriggerX(FP,{Bring(Force1,AtLeast,3,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,4)})
	DoActionsX(FP,{SetNVar(FBossHP2,SetTo,3)})
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,1,PhaseNumber),CDeaths("X",Exactly,0,WaitTimer)})
	TriggerX(FP,{},{
		SetCDeathsX("X",SetTo,1,CheckPhaseNumber,0xFF);
		SetNVar(Cur_DataIndex,SetTo,1);
		SetNVar(Pre_DataIndex,SetTo,0);
	})
BulletImage = 975
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage,395,16,60000,10,7,2,0,3,{10,10,10},0) -- Type Lurker
BulletImage2 = 210
BulletScript2 = 242
BulletColor2 = 0
BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,60000,10,7,2,0,3,{96,96,96},0)
BulletImage3 = 925
BulletScript3 = 395
BulletColor3 = 0
BulletInitSetting(FP,{196,124,285},88,207,515,BulletImage3,BulletScript3,BulletColor3,60000,10,7,2,0,3,{15,15,15},0)
DoActionsX(FP,SetNVar(CBTimer,Subtract,1))
	CIf(FP,NVar(CBLock,Exactly,0,0xFF))
		CFor(FP,0,256*256,128*256)
			local CBAngle = CForVariable()
				CIf(FP,{NVar(CBSW,Exactly,1)},{SetNVar(CBAngle2X,Add,1*256),SetImageColor(BulletImage,0)})
						CAdd(FP,CBAngle2X,CBAngle)
						CreateBullet(FP,P8,195,3,CBAngle2X,700,192,{"FBoss",2048,1920})
				CIfEnd()
				CIf(FP,{NVar(CBSW,Exactly,2)},{SetNVar(CBAngle2X,Add,-1*256),SetImageColor(BulletImage,16)})
						CAdd(FP,CBAngle2X,CBAngle)
						CreateBullet(FP,P8,195,3,CBAngle2X,700,192,{"FBoss",2048,1920})
				CIfEnd()
		CForEnd()
	TriggerX(FP,{NVar(CBTimer2,Exactly,0)},{SetNVar(CBSW,SetTo,1)},{Preserved})
	TriggerX(FP,{NVar(CBTimer2,Exactly,85*1)},{SetNVar(CBSW,SetTo,2)},{Preserved})
	TriggerX(FP,{NVar(CBTimer2,Exactly,85*2)},{SetNVar(CBSW,SetTo,1)},{Preserved})
	TriggerX(FP,{NVar(CBTimer2,Exactly,85*3)},{SetNVar(CBSW,SetTo,2)},{Preserved})
	TriggerX(FP,{NVar(CBTimer2,Exactly,85*4)},{SetNVar(CBSW,SetTo,1)},{Preserved})
	DoActionsX(FP,{SetNVar(CBTimer,Subtract,1),SetNVar(CBTimer2,Add,1)})
	CTrigger(FP,{NVar(CBTimer2,AtLeast,85*5)},{
			TSetNVar(CBAngle2X,SetTo,_Mul(_Mod(_Rand(),64),256*4)); -- Random Init Bullet Angle
			SetNVar(CBTimer2,SetTo,0); -- Reset BulletTimer
			SetNVar(CBLock,SetTo,1,0xFF); -- SetWait
			SetNVar(CBSW,SetTo,3); -- Lock
			SetNVar(CBTimer,SetTo,34*8); -- SetWaitTimer
		},{Preserved})
	CIfEnd()
	TriggerX(FP,{NVar(CBLock,Exactly,1,0xFF),NVar(CBTimer,Exactly,34*0)},{SetNVar(CBLock,SetTo,0,0xFF),SetNVar(CBSW,SetTo,0)},{Preserved})
CIfEnd()

-- Set CFunc & Shapes,Vars --

WarpShape1 = CS_FillXY(1, {-192*3,192*3}, {-192*3,192*3}, 192*1, 192*1)
WarpShape2 = CS_FillXY(1, {-192*3,192*3}, {-192*3,192*3}, 192*2, 192*2)
WarpShape3 = CS_FillXY(1, {-192*2,192*2}, {-192*2,192*2}, 192*2, 192*2)

CBShapeA_PH2 = CS_Merge(WarpShape2,WarpShape3)
CBShapeB_PH2 = CS_Subtract(WarpShape1,CBShapeA_PH2,64)
CBShapeC_PH2 = CS_MoveXY(CS_FillXY(1, {-192*3,192*4}, {-192*3,192*4}, 192*1, 192*1),-96,-96)

CBShape_PH3 = CSMakeCircleX(3,900,0,1,0)

CBShapeA_PH4 = CSMakeCircle(5, 64, 0, 1, 0)
CBShapeB_PH4 = CSMakeCircle(5, 64, 0, 6, 0)

CBShapeA_PH5 = CSMakeLineX(4,64,0,4*20,4*3)
CBShapeB_PH5 = CS_MoveXY(CSMakeLine(2,64,0,22,0),-1024,0)
CBShapeC_PH5 = CS_MoveXY(CSMakeLine(2,64,0,22,0),1024,32)
CBShapeD_PH5 = CS_MoveXY(CSMakeLine(2,64,90,22,0),0,-1024)
CBShapeE_PH5 = CS_MoveXY(CSMakeLine(2,64,90,22,0),32,1024)


CBShapesArr = {CBShapeA_PH2,CBShapeB_PH2,CBShapeC_PH2,CBShape_PH3,CBShapeA_PH4,CBShapeB_PH4,
						CBShapeA_PH5,CBShapeB_PH5,CBShapeC_PH5,CBShapeD_PH5,CBShapeE_PH5}

function CB_CAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CIfX(FP,CDeaths("X",Exactly,3,PhaseNumber))
				CA_Rotate(BulletAngle)
		CElseIfX({CDeaths("X",Exactly,4,PhaseNumber)})
			CMov(FP,CB_DataIndex,V(CA[6]))
			CIf(FP,NVar(CB_Shapes,Exactly,6))
				CA_Rotate3D(CA_AngleX,CA_AngleY,CA_AngleZ)
				CA_MoveXY(-128,0)
				CA_Rotate(_Add(CA_Angle2,PerAngle))
				CA_MoveXY(-64,0)
				CA_Rotate(CA_Angle3)
			CIfEnd()
			CIf(FP,NVar(CB_Shapes,Exactly,5))
				CA_MoveXY(-64,0)
				CA_Rotate(CA_Angle3)
			CIfEnd()
		CElseIfX({CDeaths("X",Exactly,5,PhaseNumber)})
			CIf(FP,{NVar(CB_Shapes,Exactly,7)})
				CA_Rotate(_Add(CBAngleX,BulletAngle))
				CMov(FP,CB_DataIndex,V(CA[6]))
			CIfEnd()
		CIfXEnd()
end


CB_CAPlot = InitCFunc(FP)
CFunc(CB_CAPlot)
	CAPlot(CBShapesArr,P8,193,"CLoc12",{2048,1920},1,32,
		 {CB_Shapes,0,0,0,600,0},"CB_CAFunc",FP,nil,{SetNext("X",0x1001),SetNext(0x1002,"X",1)},1)
CFuncEnd()


CJump(FP,0x100)
SetLabel(0x1001)

CIfX(FP,{CDeaths("X",Exactly,2,PhaseNumber)})
	CreateBullet(FP,P8,197,0,32,0,42*2,"CLoc12",{NVar(CB_Shapes,AtMost,2)},nil,1)
	--CreateBullet(FP,P8,196,1,32,0,42+1,"FBoss",{NVar(Y,Exactly,3)}) -- Vertex

	CElseIfX({CDeaths("X",Exactly,3,PhaseNumber)})
		CFor(FP,0,256*256,128*256)
			local CBAngle = CForVariable()
				TriggerX(FP,{NVar(CBAngle,Exactly,128*256)},{SetImageColor(BulletImage,16)},{Preserved})
				TriggerX(FP,{NVar(CBAngle,Exactly,256*256)},{SetImageColor(BulletImage,13)},{Preserved})
				CAdd(FP,CBAngleX,CBAngle)
				CreateBullet(FP,P8,195,3,CBAngleX,768,200,"CLoc12")
		CForEnd()

	CElseIfX({CDeaths("X",Exactly,4,PhaseNumber)})
		CIf(FP,{NVar(CB_Shapes,Exactly,5)},{SetSpriteImage(385, 925)})
			CreateEffect(FP,Nextptr,6,925,20,204,"CLoc12",P8)
			CreateEffect(FP,Nextptr,16,925,19,204,"CLoc12",P8)
			CIf(FP,{NVar(PH4_Timer,Exactly,0),Bring(Force1,AtLeast,1,"Men","BZone")},{CreateUnit(1,84,"CLoc12",P8)})
				CreateBullet(FP,P8,196,3,MPosA,960,255,"CLoc12")
			CIfEnd()
		CIfEnd()

		CIf(FP,NVar(CB_Shapes,Exactly,6)) -- 3각 회전대칭일때
			CIf(FP,{NVar(CB_DataIndex,Exactly,1)},{SetSpriteImage(385,382)}) -- 중심점
				CreateEffect(FP,Nextptr,6,382,20,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,16,382,19,204,"CLoc12",P8)
			CIfEnd()
			CIf(FP,{NVar(CB_DataIndex,AtLeast,2)},{SetSpriteImage(385,213),SetImageScript(213,60)}) -- 원주
				CreateEffect(FP,Nextptr,17,213,19,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,13,213,18,204,"CLoc12",P8)
					CIf(FP,{NVar(PH4_Timer,Exactly,0),Bring(Force1,AtLeast,1,"Men","BZone")},{CreateUnit(1,84,"CLoc12",P8)})
						CreateBullet(FP,P8,195,3,MPosA,960,255,"CLoc12")
					CIfEnd()
			CIfEnd()
		CIfEnd()
	CElseIfX({CDeaths("X",Exactly,5,PhaseNumber)})
		CIf(FP,{NVar(CB_Shapes,Exactly,7)})
			CIfX(FP,{NVar(CB_DataIndex,AtMost,4)},{SetSpriteImage(385,101)}) -- 중심부일때
				CreateEffect(FP,Nextptr,6,101,19,204,"CLoc12",P8)
				CreateEffect(FP,Nextptr,16,101,18,204,"CLoc12",P8)
				CreateStorm(FP,P8,195,3,0,370,2,"CLoc12")
			CElseX() -- 외각일때
				CreateStorm(FP,P8,195,3,0,370,2,"CLoc12")
			CIfXEnd()
		CIfEnd()
		CIf(FP,{NVar(CB_Shapes,AtLeast,8)})
			TriggerX(FP,{NVar(CB_Shapes,Exactly,8)},{SetImageColor(541,6)},{Preserved})
			TriggerX(FP,{NVar(CB_Shapes,Exactly,9)},{SetImageColor(541,10)},{Preserved})

			TriggerX(FP,{NVar(CB_Shapes,Exactly,10)},{SetImageColor(541,10)},{Preserved})
			TriggerX(FP,{NVar(CB_Shapes,Exactly,11)},{SetImageColor(541,6)},{Preserved})

			CreateBullet(FP,P8,197,3,Z,2048,W,"CLoc12")
		CIfEnd()
		
CIfXEnd()

SetLabel(0x1002)
CJumpEnd(FP,0x100)
CJump(FP,0x101)
SetLabel(0x1003)

f_Atan2(FP,_Neg(TempY),_Neg(TempX),MPosA3)

f_Mul(FP,MPosA3,256) -- 256각도계로 변환
f_Div(FP,MPosA3,360) -- 256각도계로 변환
CAdd(FP,MPosA3,64+128)

f_Mul(FP,MPosA3,256)

CIf(FP,{Bring(Force1,AtLeast,1,"Men","BZone")})
	CreateBullet(FP,P8,197,3,MPosA3,1024,255,"FBoss")
CIfEnd()

SetLabel(0x1004)
CJumpEnd(FP,0x101)
--------< FBoss Phase 2 >--------
CIfOnce(FP,{CDeaths("X",Exactly,2,PhaseNumber)})
	DoActionsX(FP,{
		SetNVar(CBAngle2X,SetTo,0);
		SetNVar(CB_Shapes,SetTo,1);
		SetCDeathsX("X",SetTo,2,CheckPhaseNumber,0xFF);
		SetImageColor(440,12); -- Grenade Hit
		SetImageColor(441,12); -- Grenade Shot Smokes
	})
	--TriggerX(FP,{Bring(Force1,AtLeast,1,111,"Anywhere"),Bring(Force1,AtMost,2,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,3)})
	--TriggerX(FP,{Bring(Force1,AtLeast,3,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,4)})
	DoActionsX(FP,{SetNVar(FBossHP2,SetTo,3)})
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,2,PhaseNumber),CDeaths("X",Exactly,0,WaitTimer)})

TriggerX(FP,{},{ -- Init Value
	SetNVar(Z,SetTo,1);
	SetNVar(VColor,SetTo,1);
	SetNVar(Cur_DataIndex,SetTo,2);
	SetNVar(Pre_DataIndex,SetTo,1);
	SetCDeathsX("X",SetTo,2,CheckPhaseNumber,0xFF);
}) 

BulletImage2 = 210
BulletScript2 = 242
BulletColor2 = 0
BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,60000,0,7,2,0,3,{96,96,96},0)
BulletImage3 = 925
BulletScript3 = 395
BulletColor3 = 0
BulletInitSetting(FP,{196,124,285},88,207,515,BulletImage3,BulletScript3,BulletColor3,60000,10,7,2,0,3,{15,15,15},0)

CIf(FP,{NVar(X,Exactly,0),NVar(CB_Shapes,AtMost,3)},{SetNVar(W,Add,1)})
	CallCFuncX(FP, CB_CAPlot)
	TriggerX(FP,{NVar(CB_Shapes,Exactly,1)},{SetNVar(CB_Shapes,SetTo,3),SetNVar(Z,SetTo,2)},{Preserved})
	TriggerX(FP,{NVar(CB_Shapes,Exactly,2)},{SetNVar(CB_Shapes,SetTo,3),SetNVar(Z,SetTo,1)},{Preserved})
	TriggerX(FP,{NVar(CB_Shapes,Exactly,3),NVar(W,Exactly,2)},{SetNVar(CB_Shapes,SetTo,4),SetNVar(W,SetTo,0)},{Preserved})

CIfEnd()

DoActionsX(FP,{SetNVar(X,Subtract,1)})
TriggerX(FP,{NVar(CB_Shapes,Exactly,4),NVar(Z,Exactly,1)},{SetNVar(X,SetTo,42*2),SetNVar(CB_Shapes,SetTo,1)},{Preserved})
TriggerX(FP,{NVar(CB_Shapes,Exactly,4),NVar(Z,Exactly,2)},{SetNVar(X,SetTo,42*2),SetNVar(CB_Shapes,SetTo,2)},{Preserved})

BulletImage = 245
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage,395,0,60000,10,7,2,0,3,{6,6,6},0) -- Type Lurker
	CIf(FP,{NVar(CBLock,Exactly,0*256,0xFF00)})
		CIf(FP,{NVar(CBLock,Exactly,0,0xFF)})
			CIf(FP,{NVar(CBSW,Exactly,0)},{SetNVar(CBSW,SetTo,1),SetNVar(CBTimer,Add,1*256,0xFF00)})
				--f_Mul(FP,CBAngle2X,_Add(_Mod(_Rand(),6),3),256) --Range 3~8 degree
				CAdd(FP,CBAngle2X,6*256)
			CIfEnd()
			CFor(FP,0,256*256,16*256)
				TriggerX(FP,{NVar(VColor,Exactly,1)},{SetImageColor(BulletImage,16)},{Preserved})
				TriggerX(FP,{NVar(VColor,AtLeast,2)},{SetImageColor(BulletImage,9)},{Preserved})
				local CBAngle = CForVariable()
					CAdd(FP,CBAngle2X,CBAngle)
					CreateBullet(FP,P8,195,3,CBAngle2X,2000,100,{"FBoss",2048,1920})
			CForEnd()
		CIfEnd()
	CIfEnd()
	TriggerX(FP,{NVar(CBLock,Exactly,0,0xFF),NVar(CBTimer,Exactly,8,0xFF)},{SetNVar(CBLock,SetTo,1,0xFF)},{Preserved})
		TriggerX(FP,{NVar(VColor,Exactly,1)},{SetNVar(VColor,SetTo,2)},{Preserved})
		TriggerX(FP,{
			NVar(CBLock,Exactly,1,0xFF);
			NVar(CBTimer,Exactly,8*3,0xFF)
		},{
			SetNVar(CBLock,SetTo,0,0xFF);
			SetNVar(CBTimer,SetTo,0,0xFF);
			SetNVar(CBSW,SetTo,0);
			SetNVar(VColor,SetTo,1);
		},{Preserved})
		DoActionsX(FP,{SetNVar(CBTimer,Add,1,0xFF)})
	TriggerX(FP,{ -- Lock CB, Reset Timer
		NVar(CBLock,Exactly,0*256,0xFF00);
		NVar(CBTimer,Exactly,16*256,0xFF00);
	},{
		SetNVar(CBLock,SetTo,1*256,0xFF00);
		SetNVar(CBTimer,SetTo,0,0xFFFF);
	},{Preserved})

	TriggerX(FP,{NVar(CBLock,Exactly,1*256,0xFF00)},{SetNVar(CBTimer2,Add,1)},{Preserved})

	TriggerX(FP,{ -- UnLock CB
		NVar(CBLock,Exactly,1*256,0xFF00);
		NVar(CBTimer2,Exactly,34*10);
	},{
		SetNVar(CBLock,SetTo,0*256,0xFF00);
		SetNVar(CBTimer2,SetTo,0);
		SetNVar(CBTimer,SetTo,0,0xFFFF);
		SetNVar(VColor,SetTo,1);
	},{Preserved})

CIfEnd()


--------< FBoss Phase 3 >--------

CIfOnce(FP,{CDeaths("X",Exactly,3,PhaseNumber)})
	DoActionsX(FP,{
		SetNVar(CB_Shapes,SetTo,4); -- CAShapes
		SetNVar(CB_WaitTimer,SetTo,0);
		SetNVar(CB_DataIndex,SetTo,600);
	})
	--TriggerX(FP,{Bring(Force1,AtLeast,1,111,"Anywhere"),Bring(Force1,AtMost,2,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,2)})
	--TriggerX(FP,{Bring(Force1,AtLeast,3,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,3)})
	DoActionsX(FP,{SetNVar(FBossHP2,SetTo,2)})
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,3,PhaseNumber),CDeaths("X",Exactly,0,WaitTimer)})
	TriggerX(FP,{},{
		SetCDeathsX("X",SetTo,3,CheckPhaseNumber,0xFF);
		SetNVar(Cur_DataIndex,SetTo,3);
		SetNVar(Pre_DataIndex,SetTo,2);
	})
BulletImage = 213
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage,395,0,60000,10,7,2,0,3,{11,11,11},0)
BulletImage2 = 60
BulletInitSetting(FP,{196,124,285},88,207,515,BulletImage2,395,0,60000,10,7,2,0,3,{8,8,8},0)

	CIf(FP,{NVar(CBTimer,Exactly,0)},{SetNVar(CBTimer,SetTo,3),SetNVar(CBAngle,SetTo,0)})
		CallCFuncX(FP,CB_CAPlot)
	CIfEnd()

	CIf(FP,NVar(CBTimer2,Exactly,0))
		CFor(FP,0,256*256,32*256)
			local CBAngle2 = CForVariable()
				CAdd(FP,CBAngle2X,CBAngle2)
				CreateBullet(FP,P8,196,3,CBAngle2X,1024,144,{"CLoc4",1536,1920},nil,nil,1)
				CreateBullet(FP,P8,196,3,CBAngle2X,1024,144,{"CLoc4",2560,1920},nil,nil,1)
		CForEnd()
		DoActionsX(FP,{SetNVar(CBTimer2,SetTo,34),SetNVar(CBAngle2,SetTo,0)})
	CIfEnd()

DoActionsX(FP,{
	SetNVar(BulletAngle,Add,3);
	SetNVar(CBAngleX,Add,256*4);
	SetNVar(CBTimer,Subtract,1);
	SetNVar(CBAngle2X,Add,256*6);
	SetNVar(CBTimer2,Subtract,1);
})
CIfEnd()

--------< FBoss Phase 4 >--------

CIfOnce(FP,{CDeaths("X",Exactly,4,PhaseNumber)})
	--TriggerX(FP,{Bring(Force1,AtLeast,1,111,"Anywhere"),Bring(Force1,AtMost,2,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,3)})
	--TriggerX(FP,{Bring(Force1,AtLeast,3,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,4)})
	DoActionsX(FP,{SetNVar(FBossHP2,SetTo,3)})
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,4,PhaseNumber),CDeaths("X",Exactly,0,WaitTimer)})
	TriggerX(FP,{},{
		SetCDeathsX("X",SetTo,4,CheckPhaseNumber,0xFF);
		SetNVar(Cur_DataIndex,SetTo,4);
		SetNVar(Pre_DataIndex,SetTo,3);
	})
BulletImage = 543
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage,395,16,65535,10,7,2,0,3,{10,10,10},0)
BulletImage2 = 211
BulletInitSetting(FP,{196,124,285},88,207,515,BulletImage2,395,0,65535,10,7,2,0,3,{20,20,20},0)
BulletImage3 = 962
BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage3,395,16,65535,10,7,2,0,3,{14,14,14},0)

PSW, LockTarget, TargetType = CreateVars(3,FP)
VertexArr = {{1280,1152},{1280,2560},{2816,2560},{2816,1152}} -- {4,3,2,1} 사분면
SetPriority = InitCFunc(FP)
CFunc(SetPriority)
	CIfX(FP,{NVar(TargetType,Exactly,1)}) -- 우트
		for i = 63, 0, -1 do
			TriggerX(FP,{NVar(PSW,Exactly,0)},{
				Simple_SetLoc("CheckLoc",1280+24*i,1152,1280+24*(i+1),2560); -- Priority Target
				RemoveUnitAt(1,84,"CheckLoc",P12);
			},{Preserved})
			TriggerX(FP,{
				NVar(PSW,Exactly,0);
				Bring(Force1,AtLeast,1,"Men","CheckLoc")
			},{
				SetNVar(PSW,SetTo,1); -- Lock SW
				MoveLocation("TargetLoc","Men",Force1,"CheckLoc"); -- Set Target Loc
				CreateUnit(1,84,"TargetLoc",P8);
			},{Preserved})
		end
	CElseIfX({NVar(TargetType,Exactly,2)}) -- 좌트
		for i = 0, 63 do
			TriggerX(FP,{NVar(PSW,Exactly,0)},{
				Simple_SetLoc("CheckLoc",1280+24*i,1152,1280+24*(i+1),2560); -- Priority Target
				RemoveUnitAt(1,84,"CheckLoc",P12);
			},{Preserved})
			TriggerX(FP,{
				NVar(PSW,Exactly,0);
				Bring(Force1,AtLeast,1,"Men","CheckLoc")
			},{
				SetNVar(PSW,SetTo,1); -- Lock SW
				MoveLocation("TargetLoc","Men",Force1,"CheckLoc"); -- Set Target Loc
				CreateUnit(1,84,"TargetLoc",P8);
			},{Preserved})
		end
	CElseIfX({NVar(TargetType,Exactly,3)}) -- 아래트
		for i = 63, 0, -1 do
			TriggerX(FP,{NVar(PSW,Exactly,0)},{
				Simple_SetLoc("CheckLoc",1280,1152+22*i,2816,1152+22*(i+1)); -- Priority Target
				RemoveUnitAt(1,84,"CheckLoc",P12);
			},{Preserved})
			TriggerX(FP,{
				NVar(PSW,Exactly,0);
				Bring(Force1,AtLeast,1,"Men","CheckLoc")
			},{
				SetNVar(PSW,SetTo,1); -- Lock SW
				MoveLocation("TargetLoc","Men",Force1,"CheckLoc"); -- Set Target Loc
				CreateUnit(1,84,"TargetLoc",P8);
			},{Preserved})
		end
	CElseIfX({NVar(TargetType,Exactly,4)}) -- 위트
		for i = 0, 63 do
			TriggerX(FP,{NVar(PSW,Exactly,0)},{
				Simple_SetLoc("CheckLoc",1280,1152+22*i,2816,1152+22*(i+1)); -- Priority Target
				RemoveUnitAt(1,84,"CheckLoc",P12);
			},{Preserved})
			TriggerX(FP,{
				NVar(PSW,Exactly,0);
				Bring(Force1,AtLeast,1,"Men","CheckLoc")
			},{
				SetNVar(PSW,SetTo,1); -- Lock SW
				MoveLocation("TargetLoc","Men",Force1,"CheckLoc"); -- Set Target Loc
				CreateUnit(1,84,"TargetLoc",P8);
			},{Preserved})
		end
	CIfXEnd()
CFuncEnd()

DoActionsX(FP,{
	SetNVar(CA_AngleX,Add,4);
	SetNVar(CA_AngleY,Add,1);
	SetNVar(CA_AngleZ,Add,-1);
	SetNVar(CA_Angle2,Add,1);
	SetNVar(CA_Angle3,Add,2);
	SetNVar(PH4_Timer,Subtract,1);
})

CIf(FP,{NVar(PH4_Timer,Exactly,0),Bring(Force1,AtLeast,1,"Men","BZone")})
	CAdd(FP,TargetType,1) -- Range 1~4
	CallCFuncX(FP,SetPriority)

	f_Read(FP,0x58DC60+20*210+0x0,MPosX)
	f_Read(FP,0x58DC60+20*210+0x4,MPosY)

	--f_Atan2X
	f_Atan2(FP,_Neg(_iSub(MPosY,1920-64)),_Neg(_iSub(MPosX,2048)),MPosA) -- X값 -64평행이동 계산
	CAdd(FP,MPosA2,MPosA,180) -- 반대각 저장
	f_Mul(FP,MPosA,256) -- 256각도계로 변환
	f_Div(FP,MPosA,360) -- 256각도계로 변환
	CAdd(FP,MPosA,64)
	
	f_Mul(FP,MPosA,256)
CIfEnd()

DoActionsX(FP,{SetImageScript(925,131),SetNVar(CB_Shapes,SetTo,5),SetNVar(PerAngle,SetTo,120*0)}) -- Inside
CallCFuncX(FP,CB_CAPlot)
DoActionsX(FP,{SetNVar(CB_Shapes,SetTo,6),SetNVar(PerAngle,SetTo,120*0)}) -- Outside
CallCFuncX(FP,CB_CAPlot)
DoActionsX(FP,SetNVar(PerAngle,SetTo,120*1))
CallCFuncX(FP,CB_CAPlot)
DoActionsX(FP,SetNVar(PerAngle,SetTo,120*2))
CallCFuncX(FP,CB_CAPlot)

SHBCircle = CSMakeCircleX(64,1024+512,-45,16,0)

function CB_CAFunc2()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CIf(FP,{CDeaths("X",Exactly,4,PhaseNumber)})
			CA_Rotate(_iSub(MPosA2,90))
			CMov(FP,TempX,V(CA[8]))
			CMov(FP,TempY,V(CA[9]))
		CIfEnd()
end


CAPlot(SHBCircle,P8,193,"FBoss",{2048,1920},1,32,
		 {1,0,34*3,0,600,0},"CB_CAFunc2",FP,nil,{SetNext("X",0x1003),SetNext(0x1004,"X",1)},1)


TriggerX(FP,{NVar(PH4_Timer,Exactly,0)},{
	SetNVar(PH4_Timer,SetTo,34*6);
	SetNVar(PSW,SetTo,0);
	SetNVar(PH4_SW,SetTo,0);
},{Preserved})
TriggerX(FP,{NVar(TargetType,AtLeast,4)},{SetNVar(TargetType,SetTo,0)},{Preserved})
CIfEnd()
--------< FBoss Phase 5 >--------
RandV1, RandV2, RandV3, RandV4, BType = CreateVars(5,FP)

CIfOnce(FP,{CDeaths("X",Exactly,5,PhaseNumber)})
	DoActionsX(FP,{
		SetNVar(CB_Shapes,SetTo,7); -- Init ShapeType
		SetNVar(BulletAngle,SetTo,0);
		SetNVar(X,SetTo,1);
		SetNVar(Y,SetTo,0);
		SetNVar(Z,SetTo,0);
		SetNVar(W,SetTo,0);
		SetNVar(CBAngleX,SetTo,0);
		SetNVar(CBLock,SetTo,0,0xFFFF);
		SetNVar(CBLock,SetTo,1*256,0xFF00);
		SetNVar(CBTimer2,SetTo,0);
		SetNVar(BType,SetTo,1);
	})
	--TriggerX(FP,{Bring(Force1,AtLeast,1,111,"Anywhere"),Bring(Force1,AtMost,2,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,4)})
	--TriggerX(FP,{Bring(Force1,AtLeast,3,111,"Anywhere")},{SetNVar(FBossHP2,SetTo,5)})
	DoActionsX(FP,{SetNVar(FBossHP2,SetTo,3)})
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,5,PhaseNumber),CDeaths("X",Exactly,0,WaitTimer)})
	TriggerX(FP,{},{
		SetCDeathsX("X",SetTo,5,CheckPhaseNumber,0xFF);
		SetNVar(Cur_DataIndex,SetTo,5);
		SetNVar(Pre_DataIndex,SetTo,4);
	})
BulletImage = 370
BulletInitSetting(FP,{195,123,284},87,208,516,BulletImage,236,17,65535,10,7,2,0,3,{15,15,15},0) -- Type Storm

BulletImage2 = 541
BulletScript2 = 395
BulletColor2 = 10
BulletInitSetting(FP,{197,122,283},89,199,493,BulletImage2,BulletScript2,BulletColor2,65535,10,7,2,0,3,{5,5,5},0)

CIf(FP,{NVar(CBLock,Exactly,0,0xFF)},{SetNVar(CB_Shapes,SetTo,7)})

TriggerX(FP,{NVar(CBAngleX,AtMost,44)},{SetNVar(CBSW,SetTo,0)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,45),NVar(CBAngleX,AtMost,45+27)},{SetNVar(CBSW,SetTo,1)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,45+28),NVar(CBAngleX,AtMost,89)},{SetNVar(CBSW,SetTo,2)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,90),NVar(CBAngleX,AtMost,134)},{SetNVar(CBSW,SetTo,0)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,135),NVar(CBAngleX,AtMost,179)},{SetNVar(CBSW,SetTo,2)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,180)},{SetNVar(CBAngleX,SetTo,0),SetNVar(CBLock,SetTo,1,0xFF)},{Preserved})

TriggerX(FP,{NVar(CBTimer,AtLeast,2)},{SetNVar(CBTimer,SetTo,0),SetNVar(CBAngleX,Add,1)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,45),NVar(CBAngleX,AtMost,89)},{SetNVar(CBTimer,Add,1)},{Preserved})
TriggerX(FP,{NVar(CBAngleX,AtLeast,135),NVar(CBAngleX,AtMost,179)},{SetNVar(CBAngleX,Add,3)},{Preserved})
DoActionsX(FP,{SetNVar(CBTimer,Add,1)})

	CIf(FP,{NVar(CBSW,AtMost,1)})
		CallCFuncX(FP,CB_CAPlot) -- 정회전
	CIfEnd()

	CIf(FP,{NVar(CBSW,AtLeast,1)})
		CNeg(FP,CBAngleX)
		CallCFuncX(FP,CB_CAPlot) -- 역회전
		CNeg(FP,CBAngleX) -- 정회전함수 복구
	CIfEnd()
CIfEnd()

TriggerX(FP,{NVar(BType,Exactly,1)},{SetNVar(RandV1,SetTo,127);SetNVar(RandV2,SetTo,255);SetNVar(RandV3,SetTo,255);SetNVar(RandV4,SetTo,127)},{Preserved})
TriggerX(FP,{NVar(BType,Exactly,2)},{SetNVar(RandV1,SetTo,127);SetNVar(RandV2,SetTo,255);SetNVar(RandV3,SetTo,127);SetNVar(RandV4,SetTo,255)},{Preserved})
TriggerX(FP,{NVar(BType,Exactly,3)},{SetNVar(RandV1,SetTo,255);SetNVar(RandV2,SetTo,127);SetNVar(RandV3,SetTo,255);SetNVar(RandV4,SetTo,127)},{Preserved})
TriggerX(FP,{NVar(BType,Exactly,4)},{SetNVar(RandV1,SetTo,255);SetNVar(RandV2,SetTo,127);SetNVar(RandV3,SetTo,127);SetNVar(RandV4,SetTo,255)},{Preserved})

CIf(FP,{NVar(CBLock,Exactly,1,0xFF)})
	CIf(FP,NVar(BTimer,Exactly,0))
		CTrigger(FP,{NVar(Y,Exactly,0)},{SetNVar(CB_Shapes,SetTo,8),SetNVar(Z,SetTo,193*256),TSetNVar(W,SetTo,RandV1)},{Preserved})
		CTrigger(FP,{NVar(Y,Exactly,1)},{SetNVar(CB_Shapes,SetTo,9),SetNVar(Z,SetTo,63*256),TSetNVar(W,SetTo,RandV2),SetNVar(BTimer,SetTo,8)},{Preserved})
		CallCFuncX(FP,CB_CAPlot)

		DoActionsX(FP,SetNVar(Y,Add,1))
		TriggerX(FP,{NVar(Y,Exactly,2)},{SetNVar(Y,SetTo,0),SetNVar(PH5_Timer,Add,1)},{Preserved})
	CIfEnd()
DoActionsX(FP,SetNVar(BTimer,Subtract,1))
TriggerX(FP,{NVar(PH5_Timer,AtLeast,32)},{SetNVar(PH5_Timer,SetTo,0),SetNVar(CBLock,SetTo,2,0xFF)},{Preserved})
CIfEnd()

CIf(FP,{NVar(CBLock,Exactly,2,0xFF)})
	CIf(FP,NVar(BTimer,Exactly,0))
		CTrigger(FP,{NVar(Y,Exactly,0)},{SetNVar(CB_Shapes,SetTo,10),SetNVar(Z,SetTo,0*256),TSetNVar(W,SetTo,RandV3)},{Preserved})
		CTrigger(FP,{NVar(Y,Exactly,1)},{SetNVar(CB_Shapes,SetTo,11),SetNVar(Z,SetTo,127*256),TSetNVar(W,SetTo,RandV4),SetNVar(BTimer,SetTo,8)},{Preserved})
		CallCFuncX(FP,CB_CAPlot)

		DoActionsX(FP,SetNVar(Y,Add,1))
		TriggerX(FP,{NVar(Y,Exactly,2)},{SetNVar(Y,SetTo,0),SetNVar(PH5_Timer,Add,1)},{Preserved})
	CIfEnd()
DoActionsX(FP,SetNVar(BTimer,Subtract,1))
TriggerX(FP,{NVar(PH5_Timer,AtLeast,32)},{SetNVar(PH5_Timer,SetTo,0),SetNVar(CBLock,SetTo,3,0xFF)},{Preserved})
CIfEnd()

TriggerX(FP,{NVar(CBLock,Exactly,3,0xFF)},{SetNVar(CBTimer2,Add,1)},{Preserved})
CTrigger(FP,{
	NVar(CBLock,Exactly,3,0xFF);
	NVar(CBTimer2,AtLeast,34*10)
},{
	SetNVar(CBLock,SetTo,0,0xFF);
	SetNVar(CBTimer2,SetTo,0);
	SetNVar(BType,Add,1);
	TSetNVar(BulletAngle,SetTo,_Mul(_Mod(_Rand(),9),10)); -- Init
},{Preserved})
TriggerX(FP,{NVar(BType,AtLeast,5)},{SetNVar(BType,SetTo,1)},{Preserved})
CIfEnd()

TriggerX(FP,{CDeaths("X",Exactly,6,PhaseNumber)},{ -- Reset & Preparing WHPhase
	SetCDeaths("X",SetTo,1,PhaseClear);
	SetCDeaths("X",SetTo,0,PhaseNumber);
	SetInvincibility(Enable, 174, P8, "Anywhere");
	SetInvincibility(Enable, "Men", Force1, "Anywhere");
	SetImageScript(975,390);SetImageColor(975,9);
	SetImageScript(210,193);SetImageColor(210,0);
	SetImageScript(925,365);SetImageColor(925,0);
	SetImageScript(213,142);SetImageColor(213,9);
	SetImageScript(214,143);SetImageColor(214,9);
	SetImageScript(215,144);SetImageColor(215,9);
	SetImageScript(60,34);SetImageColor(60,0);
	SetImageScript(543,314);SetImageColor(543,9);
	SetImageScript(211,191);SetImageColor(211,9);
	SetImageScript(962,381);SetImageColor(962,0);
	SetImageScript(370,308);SetImageColor(370,1);
	SetImageScript(541,247);SetImageColor(541,0);
	SetImageScript(245,83);SetImageColor(245,17);
	SetNVar(Cur_DataIndex,SetTo,1);
	SetNVar(Pre_DataIndex,SetTo,0);
	SetCDeathsX("X",SetTo,6,CheckPhaseNumber,0xFF);
})

CIfEnd()
end