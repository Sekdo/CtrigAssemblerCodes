function Install_Climax()

MainTimeLineArr = {748,1380,1850,2400,3000,3808,4600,5500,6200,6800,7800,8400}
--------------< Shape >--------------
E_Base = CSMakeCircle(6,60,0,91,61)
EllipseN = CS_RemoveStack(CS_MoveXY(CS_Distortion(E_Base,{5,0},{5,0},nil,nil),1600,0),20)
E_Num = EllipseN[0] -- 타원 점의수
EllipseArr = {EllipseN,CS_Rotate(EllipseN,30),CS_Rotate(EllipseN,60),CS_Rotate(EllipseN,90),CS_Rotate(EllipseN,120)
        ,CS_Rotate(EllipseN,150),CS_Rotate(EllipseN,180),CS_Rotate(EllipseN,210),CS_Rotate(EllipseN,240)
        ,CS_Rotate(EllipseN,270),CS_Rotate(EllipseN,300),CS_Rotate(EllipseN,330)}
function EllipseOverlapX()
local X
    for i = 1, #EllipseArr do
        X = CS_OverlapX(X,EllipseArr[i])
    end
return X
end

SH_Flower = EllipseOverlapX() -- E_Num  : 각타원의 총 점의수마다 유닛타입변경
ClimaxShapeArr = {SH_Flower}
function HyperCycloid(T) return {2.1*math.cos(T) - math.cos(2.1*T), 2.1*math.sin(T) - math.sin(2.1*T)} end
Hp0 = CSMakeGraphT({192,192},"HyperCycloid",0,0,10,10,200)
Hp1 = CS_RemoveStack(Hp0,10)

CRadius = 128
DotNum = 12

A_Arc = CS_OverlapX(CS_MoveXY(CS_CompassC({0,0},2*CRadius,-90,120-90-10,0,DotNum),0,-3*CRadius),CS_MoveXY(CSMakeCircleX(DotNum,2*CRadius,0,DotNum,0),0,-4*CRadius))
SH_ArcA = CS_SymmetryA(A_Arc,5,0,360)
B_Arc = CS_MoveXY(CS_CompassC({0,0},2*CRadius,-90-15,90+15,0,DotNum+2),1,128)
SH_ArcB = CS_Rotate(CS_SymmetryA(B_Arc,5,0,360),30)
WH_Main = CS_RemoveStack(CS_OverlapX(SH_ArcB,SH_ArcA),10)

-- Variables --
WHShape, WHLoopLimit, WHDataIndex, WHTempDataIndex, WHTimeLine, TempDataIndex = CreateVars(6,FP)
WHTimer, CenterShape, CenterSW = CreateCcodes(3)
WHSpeed = 1000/29
--< Start >--
StartTimeLine = 4.8
local MainTimeLine = {44.3,61.5,79.1,96.5,114.0,133.7,151.1,186.0,205.6,223.0}
--< Intro Phase >--
local IntroPhaseArr = {9.1,11.3,13.5,15.7,17.3,17.9,20.1,22.3,24.5,26.7,28.9,31.1,33.3,34.9,35.5,37.7,39.9,42.1,43.7}
for i = 1, #IntroPhaseArr do
	TriggerX(FP,{CDeaths("X",Exactly,WHSpeed*IntroPhaseArr[i],WHTimer)},{SetCDeaths("X",SetTo,1,CenterSW)})
end
TriggerX(FP,{CDeaths("X",Exactly,WHSpeed*IntroPhaseArr[1],WHTimer)},{SetCDeaths("X",SetTo,1,CenterSW)})
--< Vol Up 1 >--
local CenterVolUp1 = {43.6,44.0} -- 1503, 1517

--< Phase 1 >--
local CenterArrT1 = {}
for i = 0, 30 do
	table.insert(CenterArrT1,43.7+0.55*i)
end
local CenterArrS1 = {44.25,46.45,48.65,50.85,53.05,55.25,57.45,59.65}
for i = 1, #CenterArrS1 do
	TriggerX(FP,{NVar(WHTimer,Exactly,WHSpeed*CenterArrS1[i])},{SetCDeaths("X",SetTo,2,CenterSW)}) -- Sub2
end
	TriggerX(FP,{NVar(WHTimer,AtLeast,WHSpeed*CenterArrS1[1])},{},{Preserved}) -- Main1

--< Build Up Phase >--
local BuildUp1Arr = {61.02,61.16,61.3,61.44,61.54}

--< Phase 2 >--
local CenterArrT2 = {}
for i = 0, 11 do
	table.insert(CenterArrT2,61.65+0.55*i)
	table.insert(CenterArrT2,70.45+0.55*i)
end
local CenterArrT2A = {68.25,68.8,69.35,69.9,77.05,77.6,78.15,78.7}
local CenterArrS2 = {61.65,63.85,66.05,68.25,70.45,72.65,74.85,77.05}

--< Phase 3 >--
local CenterArrT3 = {}
for i = 0, 11 do
	table.insert(CenterArrT3,79.25+0.55*i)
	table.insert(CenterArrT3,88.05+0.55*i)
end
local CeneterArrT3A = {85.85,86.4,86.95,87.5,94.65,95.2,95.75}
local CenterArrS3 = {79.25,81.45,83.65,85.85,88.05,90.25,92.45,94.65}

--< Phase 4 >--
local CenterArrT4 = {}
for i = 0, 28 do
	table.insert(CenterArrT4,96.6+0.55*i)
end
local CenterArrS4 = {96.6,98.8,101,103.2,105.4,107.6,109.8,112}

--< Phase 5 >--
local CenterArrT5 = {}
for i = 0, 28 do
	table.insert(CenterArrT5,114+0.55*i)
end
local CenterArrS5 = {114,116.2,118.4,120.6,122.8,125,127.2,129.4}

--< Phase 6 >--
local CenterArrT6 = {}
for i = 0, 28 do
	table.insert(CenterArrT6,133.7+0.55*i)
end
local CenterArrS6 = {133.7,135.9,138.1,140.3,142.5,144.7,146.9,149.1}

--< Phase 7 >--
local CenterArrT7 = {}
for i = 0, 63 do
	table.insert(CenterArrT7,151.45+0.55*i)
end
--< Phase 8 >--
local CenterArrT8 = {}
for i = 0, 31 do
	table.insert(CenterArrT8,186.1+0.55*i)
end
local CenterArrS8 = {186.1,187.6,188.3,189.9,190.5,192.1,192.7,193.7,194.2,194.8,196.4,197,198.6,199.2,200.8,201.4,202.4,202.9}
--< FadeOut ~ FadeIn >--
local FadeOutArr = {203.4,204.7}
local FadeInArr = {204.7,205.5}

--< Phase 9 >--
local CenterArrT9 = {}
for i = 0, 28 do
	table.insert(CenterArrT9,205.7+0.55*i)
end
local CenterArrS9 = {205.7,207.9,210.1,212.3,214.5,216.7,218.9,221.1}
--< Vol Up 2 >--
local CenterVolUp2 = {222.7,223.1}

--< Phase 10 >--
local CenterArrT10 = {}
for i = 0, 28 do
	table.insert(CenterArrT10,223.1+0.55*i)
end
local CenterArrS10 = {223.1,225.3,227.5,229.7,231.9,234.1,236.6,238.5,239.5}

--< Vol Up 3 >--
local CenterVolUp3 = {240,240.4}

--< Last Phase >--
local LastPhaseArr = {}
for i = 0, 30 do
	table.insert(LastPhaseArr,241.15+0.55*i)
end

--< Center CreateUnit >--
CJump(FP,0x107)
SetLabel(0x3000)



SetLabel(0x3001)
CJumpEnd(FP,0x107)

--< Main CreateUnit >--
CJump(FP,0x108)
SetLabel(0x3002)



SetLabel(0x3003)
CJumpEnd(FP,0x108)

--< Sub CreateUnit >--
CJump(FP,0x109)
SetLabel(0x3004)



SetLabel(0x3005)
CJumpEnd(FP,0x109)
--< CAFunc / CBFunc >--
CycleLength = 360
CenterCord = {1024,4114}

SH_Star = CSMakeStarX(5,108,96,0,CS_Level("StarX",5,3),0)
SH_Warp = CS_FillXY({1,1},256,256,32,32)
SH_Sub = CSMakePath({640-1024,3824-4114},{640-1024,4464-4114},{1408-1024,3824-4114},{1408-1024,4464-4114})
SH_SubIn = CSMakePolygonX(3,256,0,3,0)

function WH_CAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CMov(FP,TempDataIndex,V(CA[6])) -- 데이터인덱스 임시저장
end

CycleLength = 360

function WH_CBFunc()
	SC1 = CB_InitCache(CycleLength,SH_Star[1],0x80000000) -- CycleLength : 360 
			Vptr1 = CB_InitVShape(3)
			CB_LoadCache(SC1,VTimeLine,Vptr1)
			CB_GetNumber(3,VNull)
				CIf(FP,{NVar(VNull,Exactly,0x80000000)})
					CB_Rotate3D(AngleXY,30,0,1,2)
					CB_Warping(CFunc1,nil,nil,nil,{CPosX,CPosY},2,3)
					CB_SaveCache(SC1,VTimeLine,Vptr1)
				CIfEnd()
end




------< CFunc >------------------------------------------
CPosX, CPosY, RCos, RSin, Rad1, Rad2 = CreateVars(6,FP)

CFunc1 = InitCFunc(FP)
Para = CFunc(CFunc1)

f_Lengthdir(FP,Rad1,Para[1],RCos,RSin)
	NIfX(FP,NVar(Para[2],Exactly,0)) -- UFunc
		CAdd(FP,RSin,Para[6])
		CFuncReturn({RSin})
	NElseX()  -- DFunc
		CAdd(FP,RSin,Para[7])
		CFuncReturn({RSin})
	NIfXEnd()
CFuncEnd()

CFunc2 = InitCFunc(FP)
Para = CFunc(CFunc2)

f_Lengthdir(FP,Rad1,Para[1],RCos,RSin)
	NIfX(FP,NVar(Para[2],Exactly,2)) -- LFunc
		CAdd(FP,RCos,Para[3])
		CFuncReturn({RCos})
	NElseX() -- RFunc
		CAdd(FP,RCos,Para[4])
		CFuncReturn({RCos})
	NIfXEnd()
CFuncEnd()


WHMain_CBPlot = InitCFunc(FP)
CFunc(WHMain_CBPlot)

CFuncEnd()
WHSub_CBPlot = InitCFunc(FP)
CFunc(WHSub_CBPlot)

CFuncEnd()

WHCenter_CBPlot = InitCFunc(FP)
WHCenterShapeArr = {WH_Main,RetSH(WH_Main),SH_Sub,SH_SubIn,CS_InputVoid(SH_Sub[1]*SH_SubIn[1])}
CFunc(WHCenter_CBPlot)
	CBPlot(WHCenterShapeArr,nil,P8,193,"CLoc106",{1024,4096},1,32,{WHShape,0,0,0,WHLoopLimit,WHDataIndex}
		,"WH_CAFunc","WH_CBFunc",FP,nil,{SetNext("X",0x3000),SetNext(0x3001,"X",1)})
CFuncEnd()

TriggerX(FP,{},{ -- Init CB_Warping Setting
	SetNVar(CPosX,SetTo,1);SetNVar(CPosY,SetTo,1);
	SetNVar(Rad1,SetTo,96);SetNVar(Rad2,SetTo,96);
})


end