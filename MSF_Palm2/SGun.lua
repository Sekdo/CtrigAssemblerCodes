function Install_SGun()


CereText =  "\x13\x1F─━┫ \x1FT\x04rinity 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
NexusText =  "\x13\x1F─━┫ \x1FS\x04kyscraper 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
OverText =  "\x13\x1F─━┫ \x1FO\x04vermind 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
PrisonText =  "\x13\x1F─━┫ \x1FD\x04iversity 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
CenterText =  "\x13\x1F─━┫ \x1FC\x04enter 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
GeneText =  "\x13\x1F─━┫ \x1FC\x04ore 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
CocoonText =  "\x13\x1F─━┫ \x1FC\x04ocoon 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
IonText =  "\x13\x1F─━┫ \x1FM\x04agnetic 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
-----------< CD & Vars >-----------
GunMaxAmount = 30
SCD = CreateCcodeArr(3*GunMaxAmount)
SGVar = CreateVarArr(5*GunMaxAmount)

Gun_UnitA, Gun_UnitB, Gun_UnitC, OverAngle, CenterAngle1, CenterAngle2, CenterAngle3, Gun_Angle, Gun_Angle2, Gun_Angle3 = CreateVars(10,FP)
SideUnitCode = CreateCcode()
LoopCheck = CreateCcode()
CacheFlag = CreateCcode()

-----------< ShapeData >-----------
-- Cerebrate --
CereA = CSMakePolygon(4,60,0,CS_Level("Polygon",4,2),1)
CereB = CSMakePolygon(4,60,0,CS_Level("Polygon",4,3),CS_Level("Polygon",4,2))
CereC = CSMakePolygon(4,60,0,CS_Level("Polygon",4,4),CS_Level("Polygon",4,3))
CereD = CSMakePolygon(4,60,0,CS_Level("Polygon",4,5),CS_Level("Polygon",4,4))
CereE = CSMakePolygon(4,60,0,CS_Level("Polygon",4,5),1)

CereA2 = CSMakePolygon(5,60,0,CS_Level("Polygon",5,2),1)
CereB2 = CSMakePolygon(5,60,0,CS_Level("Polygon",5,3),CS_Level("Polygon",5,2))
CereC2 = CSMakePolygon(5,60,0,CS_Level("Polygon",5,4),CS_Level("Polygon",5,3))
CereD2 = CSMakePolygon(5,60,0,CS_Level("Polygon",5,5),CS_Level("Polygon",5,4))
CereE2 = CSMakePolygon(5,60,0,CS_Level("Polygon",5,5),1)

CereA3 = CSMakeCircle(6,60,0,CS_Level("Circle",6,2),1)
CereB3 = CSMakeCircle(6,60,0,CS_Level("Circle",6,3),CS_Level("Circle",6,2))
CereC3 = CSMakeCircle(6,60,0,CS_Level("Circle",6,4),CS_Level("Circle",6,3))
CereD3 = CSMakeCircle(6,60,0,CS_Level("Circle",6,5),CS_Level("Circle",6,4))
CereE3 = CSMakeCircle(6,60,0,CS_Level("Circle",6,5),1)

CereA4 = CSMakeStar(4,135,60,0,CS_Level("Star",4,2),1)
CereB4 = CSMakeStar(4,135,60,0,CS_Level("Star",4,3),CS_Level("Star",4,2))
CereC4 = CSMakeStar(4,135,60,0,CS_Level("Star",4,4),CS_Level("Star",4,3))
CereD4 = CSMakeStar(4,135,60,0,CS_Level("Star",4,5),CS_Level("Star",4,4))
CereE4 = CSMakeStar(4,135,60,0,CS_Level("Star",4,5),1)

-- Nexsus --
function Sort_X1BFunc(R,A)
	return {math.abs((512+128*2)/2-R)} -- 2차정렬
end
function Sort_X1CFunc(R,A)
	return {math.abs((512+128*3)/2-R)} -- 2차정렬
end

function SHBF(Y) return Y end

SH_N1A = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*2},90,64,"SHBF",0),180),"Sort_X1BFunc",nil,1)
SH_N1B = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*3},90,64,"SHBF",0),180),"Sort_X1CFunc",nil,1)
SH_SPA1 = CS_MoveXY(CSMakeSpiral(3, 1024, 0.5, 96, 0, CS_Level("Spiral",3,20), 0),-128*4,-128*3)
SH_SPB1 = CS_MoveXY(CSMakeSpiral(4, 1024, 0.5, 96, 0, CS_Level("Spiral",4,20), 0),-128*4,-128*3)

SH_N2A = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*3},90,64,"SHBF",0),270),"Sort_X1BFunc",nil,1)
SH_N2B = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*4},90,64,"SHBF",0),270),"Sort_X1CFunc",nil,1)
SH_SPA2 = CS_MoveXY(CSMakeSpiral(4, 1024, 0.5, 96, 0, CS_Level("Spiral",4,20), 0),128*3,-128*3)
SH_SPB2 = CS_MoveXY(CSMakeSpiral(5, 1024, 0.5, 96, 0, CS_Level("Spiral",5,20), 0),128*3,-128*3)

SH_N3A = CS_RatioXY(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*4},90,80,"SHBF",0),270),"Sort_X1BFunc",nil,1),0.7,0.7)
SH_N3B = CS_RatioXY(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*5},90,80,"SHBF",0),270),"Sort_X1CFunc",nil,1),0.7,0.7)
SH_SPA3 = CS_MoveXY(CSMakeSpiral(5, 1024, 0.5, 96, 0, CS_Level("Spiral",5,15), 0),128*3,-128*3)
SH_SPB3 = CS_MoveXY(CSMakeSpiral(6, 1024, 0.5, 96, 0, CS_Level("Spiral",6,15), 0),128*3,-128*3)

SH_N4A = CS_RatioXY(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*4},90,80,"SHBF",0),90),"Sort_X1BFunc",nil,1),0.7,0.7)
SH_N4B = CS_RatioXY(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*5},90,80,"SHBF",0),90),"Sort_X1CFunc",nil,1),0.7,0.7)
SH_SPA4 = CS_MoveXY(CSMakeSpiral(5, 1024, 0.5, 96, 0, CS_Level("Spiral",5,15), 0),-128*3,128*3)
SH_SPB4 = CS_MoveXY(CSMakeSpiral(6, 1024, 0.5, 96, 0, CS_Level("Spiral",6,15), 0),-128*3,128*3)

function OverCAFunc()
    local CB = CAPlotCreateArr
    CA_Rotate(OverAngle)
end

function CenterCAFunc()
    local CB = CAPlotCreateArr
    CA_Rotate3D(CenterAngle1,CenterAngle2,CenterAngle3)
end
-- Overmind --

SH_OMA = CSMakeLineX(1,60,0,9,1)
SH_OMB = CSMakeLineX(1,60,0,11,1)
SH_OMC = CSMakeLineX(1,60,0,13,1)
SH_OMMain1 = CSMakeCircleX(6,80,0,CS_Level("CircleX",6,3),0)
SH_OMMain2 = CS_MoveXY(CS_InvertXY(CS_FillGradA(0,{0,512},270,18,"SHBF",0),270),-500,0)

-- Prison --

SH_PrisonA = CSMakePolygon(6,80,0,CS_Level("Polygon",6,6),0) -- XUnit
SH_PrisonB = CSMakePolygon(6,80,0,CS_Level("Polygon",6,5),0) -- HUnit
SH_PrisonC = CSMakeLine(6,128,0,12+1,0) -- GUnit

-- Center --

function HyperCycloidA(T) return {4*math.cos(T) + math.cos(4*T), 4*math.sin(T) - math.sin(4*T)} end
HCA0 = CSMakeGraphT({32,32},"HyperCycloidA",0,0,12,12,70)
HCA = CS_RatioXY(CS_RemoveStack(HCA0,10,0),1.5,1.5) -- 원본

function HyperCycloidB(T) return {4*math.cos(T) + 2*math.cos(4*T), 4*math.sin(T) - 2*math.sin(4*T)} end
HCB0 = CSMakeGraphT({32,32},"HyperCycloidB",0,0,12,12,120)
HCB = CS_RatioXY(CS_RemoveStack(HCB0,12,0),1.5,1.5)

function HyperCycloidE(T) return {6*math.cos(T) - 2*math.cos(6*T), 6*math.sin(T) - 2*math.sin(6*T)} end
HCE0 = CSMakeGraphT({24,24},"HyperCycloidE",0,0,1,1,90)
HCE = CS_RatioXY(CS_RemoveStack(HCE0,20,0),1.5,1.5)

function HyperCycloidF(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
HCFF = CSMakeGraphT({12,12},"HyperCycloidF",0,0,2,2,51) 
HCF0 = CS_Rotate(HCFF,180)
HCF = CS_RatioXY(CS_RemoveStack(HCF0,15,0),1.5,1.5)

-- Generator --

BaseA = CS_RemoveStack(CS_FillRA(1,{0,512},{0,135},128,15),10)
BaseB =  CS_RemoveStack(CS_FillRA(1,{0,768},{0,135},128,15),10)

SH_GeneA1 = CS_Rotate(BaseA,90)
SH_GeneA2 = CS_Rotate(BaseA,180)
SH_GeneA3 = CS_Rotate(BaseA,270)
SH_GeneA4 = CS_OverlapX(BaseA,CS_Rotate(BaseA,180))

SH_GeneB1 = CS_Rotate(BaseB,90)
SH_GeneB2 = CS_Rotate(BaseB,180)
SH_GeneB3 = CS_Rotate(BaseB,270)
SH_GeneB4 = CS_OverlapX(BaseB,CS_Rotate(BaseB,180))

-- Ion --

SH_Ion = CS_RatioXY(CS_RemoveStack(HCF0,15,0),1.25,1.25)

-- CoCoon --
function Cos_FuncY(X) return math.sin(X) end
WaveShapeA = CSMakeGraphX({256,256},"Cos_FuncY",0,0,0.2,nil,87) -- y= math.cos(x)
WaveShapeC = CSMakeGraphX({256,256},"Cos_FuncY",0,0,0.4,nil,43) -- y= math.cos(x)
WaveShapeE = CSMakeGraphX({256,256},"Cos_FuncY",0,0,0.8,nil,21) -- y= math.cos(x)

function Cos_FuncX(Y) return math.sin(Y) end
WaveShapeB = CSMakeGraphY({256,256},"Cos_FuncX",0,1,0.2,nil,87) -- y= math.cos(x)
WaveShapeD = CSMakeGraphY({256,256},"Cos_FuncX",0,1,0.4,nil,43) -- y= math.cos(x)
WaveShapeF = CSMakeGraphY({256,256},"Cos_FuncX",0,1,0.8,nil,21) -- y= math.cos(x)

SH_CoonA = CS_SortR(CS_OverlapX(WaveShapeA,WaveShapeB),1)
SH_CoonB = CS_SortR(CS_OverlapX(WaveShapeA,WaveShapeB),0)
SH_CoonC = CS_SortR(CS_OverlapX(WaveShapeC,WaveShapeD),1)
SH_CoonD = CS_SortR(CS_OverlapX(WaveShapeC,WaveShapeD),0)
SH_CoonE = CS_SortR(CS_OverlapX(WaveShapeE,WaveShapeF),1)
SH_CoonF = CS_SortR(CS_OverlapX(WaveShapeE,WaveShapeF),1)


-----------< CFunctions & CAPlot >----------- 
CallCereCAPlot = InitCFunc(FP)
CFunc(CallCereCAPlot)
    CereShapeArr = {CereA,CereB,CereC,CereD,CereE,CereA2,CereB2,CereC2,CereD2,CereE2,
        CereA3,CereB3,CereC3,CereD3,CereE3,CereA4,CereB4,CereC4,CereD4,CereE4}
        CAPlot(CereShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,600,Gun_DataIndex},nil,FP,nil
            ,{SetNext("X",0x2003),SetNext(0x2004,"X",1)},nil)
CFuncEnd()

CallNexusCAPlot = InitCFunc(FP)
CFunc(CallNexusCAPlot)
    NexusShapeArr = {SH_N1A,SH_N1B,SH_SPA1,SH_SPB1,SH_N2A,SH_N2B,SH_SPA2,SH_SPB2,
            SH_N3A,SH_N3B,SH_SPA3,SH_SPB3,SH_N4A,SH_N4B,SH_SPA4,SH_SPB4}
        CAPlot(NexusShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},nil,FP,nil
            ,{SetNext("X",0x2005),SetNext(0x2006,"X",1)},nil)
CFuncEnd()

CallOverMindCAPlot = InitCFunc(FP)
CFunc(CallOverMindCAPlot)
    OverShapeArr = {SH_OMA,SH_OMB,SH_OMC,SH_OMMain1,SH_OMMain2}
    CAPlot(OverShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},"OverCAFunc",FP,nil
            ,{SetNext("X",0x2005),SetNext(0x2006,"X",1)},nil)
CFuncEnd()

CallPrisonCAPlot = InitCFunc(FP)
CFunc(CallPrisonCAPlot)
    PrisonShapeArr = {SH_PrisonA,SH_PrisonB,SH_PrisonC}
    CAPlot(PrisonShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},nil,FP,nil
            ,{SetNext("X",0x2007),SetNext(0x2008,"X",1)},nil)
CFuncEnd()

CallGeneCAPlot = InitCFunc(FP)
CFunc(CallGeneCAPlot)
    GeneShapeArr = {SH_GeneA1,SH_GeneA2,SH_GeneA3,SH_GeneA4,SH_GeneB1,SH_GeneB2,SH_GeneB3,SH_GeneB4}
    CAPlot(GeneShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},nil,FP,nil
         ,{SetNext("X",0x2009),SetNext(0x2010,"X",1)},nil)
CFuncEnd()

CallCenterCAPlot = InitCFunc(FP)
CFunc(CallCenterCAPlot)
    CenterShapeArr = {HCA,HCB,HCE,HCF}
    CAPlot(CenterShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},"CenterCAFunc",FP,nil
         ,{SetNext("X",0x2011),SetNext(0x2012,"X",1)},nil)
CFuncEnd()

CycleLength = 360
SH_Warp = CS_RatioXY(CS_FillXY({1,1},256,256,64,64),1.3,1.3)
VT1, VNull, IXY, IYZ, IZX, VTimeline = CreateVars(7,FP)
function RetSH(Shape)
	return CS_InputVoid(Shape[1])
end

function Ion_CBFunc()
    ISC1 = CB_InitCache(CycleLength,SH_Ion[1],0x80000000) -- CycleLength : 120 
            Vptr1 = CB_InitVShape(2)
            CB_LoadCache(ISC1,VTimeline,Vptr1)
            CB_GetNumber(2,VNull)
                CIf(FP,{NVar(VNull,Exactly,0x80000000)})
                    CB_Rotate3D(IXY, IYZ, IZX, 1, 2)
                    CB_SaveCache(ISC1,VTimeline,Vptr1)
                CIfEnd()
end

function Ion_CBFunc2()
    ISC2 = CB_InitCache(CycleLength,SH_Ion[1],0x80000000) -- CycleLength : 120 
            Vptr2 = CB_InitVShape(2)
            CB_LoadCache(ISC2,VTimeline,Vptr2)
            CB_GetNumber(2,VNull)
                CIf(FP,{NVar(VNull,Exactly,0x80000000)})
                    CB_Rotate3D(IXY, IYZ, IZX, 1, 2)
                    CB_SaveCache(ISC2,VTimeline,Vptr2)
                CIfEnd()
end

CallIonCAPlot = InitCFunc(FP)
CFunc(CallIonCAPlot)
    CBPlot({SH_Ion,RetSH(SH_Ion)},nil,P8,193,"CLoc91",{1526,1605},1,16,{2,0,0,0,600,0},nil,"Ion_CBFunc",FP,nil
        ,{SetNext("X",0x2013),SetNext(0x2014,"X",1)},1)
CFuncEnd()

CallIonCAPlot2 = InitCFunc(FP)
CFunc(CallIonCAPlot2)
    CBPlot({SH_Ion,RetSH(SH_Ion)},nil,P8,193,"CLoc91",{2583,2516},1,16,{2,0,0,0,600,0},nil,"Ion_CBFunc2",FP,nil
        ,{SetNext("X",0x2013),SetNext(0x2014,"X",1)},1)
CFuncEnd()

CallCoonCAPlot = InitCFunc(FP)
CFunc(CallCoonCAPlot)
    CoonShapeArr = {SH_CoonA,SH_CoonB,SH_CoonC,SH_CoonD,SH_CoonE,SH_CoonF}
    CAPlot(CoonShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},nil,FP,nil
         ,{SetNext("X",0x2015),SetNext(0x2016,"X",1)},nil)
CFuncEnd()

-----------< Cerebrate >-----------
CJump(FP,0x101)
SetLabel(0x2003)
    CTrigger(FP,{CDeaths("X",Exactly,0,SideUnitCode)},{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
        TCreateUnit(1,Gun_UnitB,"CLoc91",Gun_Player);
        CreateUnit(1,84,"CLoc91",P5);
    },{Preserved})
    CTrigger(FP,{CDeaths("X",Exactly,1,SideUnitCode)},{
        TCreateUnit(1,Gun_UnitC,"CLoc91",Gun_Player);
        CreateUnit(1,84,"CLoc91",P5);
    },{Preserved})
SetLabel(0x2004)
-----------< Nexus & Overmind >-----------
SetLabel(0x2005)
    CTrigger(FP,{CDeaths("X",Exactly,0,SideUnitCode)},{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
    },{Preserved})
    CTrigger(FP,{CDeaths("X",Exactly,1,SideUnitCode)},{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
        TCreateUnit(1,Gun_UnitB,"CLoc91",Gun_Player);
    },{Preserved})
SetLabel(0x2006)
-----------< Prison >-----------
SetLabel(0x2007)
    CDoActions(FP,{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
    })
SetLabel(0x2008)
-----------< Generator >-----------
SetLabel(0x2009)
    CDoActions(FP,{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
        TCreateUnit(1,Gun_UnitB,"CLoc91",Gun_Player);
    })
SetLabel(0x2010)
-----------< Center >-----------
SetLabel(0x2011)
    CDoActions(FP,{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
    })
SetLabel(0x2012)
-----------< Ion >-----------
SetLabel(0x2013)
    TriggerX(FP,{CDeathsX("X",Exactly,1,CacheFlag,0xFF)},{CreateUnit(1,204,"CLoc91",P5)},{Preserved})
SetLabel(0x2014)
-----------< CoCoon >-----------
SetLabel(0x2015)
    CDoActions(FP,{
        TCreateUnit(1,Gun_UnitA,"CLoc91",Gun_Player);
    })
SetLabel(0x2016)
CJumpEnd(FP,0x101)


function SetCerebrate(Player,GIndex,GunLevel,X,Y,Loc,UnitA1,UnitA2,UnitA3,UnitA4,UnitA5,UnitA6,UnitB1,UnitB2,UnitB3,UnitB4,UnitB5,UnitB6)

CStage = SCD[3*GIndex-2] -- 타이머1
CTimer = SCD[3*GIndex-1] -- 타이머2
COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
CUnitTypeC = SGVar[5*GIndex-1] -- 유닛변수
CShapeType = SGVar[5*GIndex] -- 도형데이터변수

CIf(FP,{Bring(Player,Exactly,0,151,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)},{CreateUnit(1,84,Loc,P5)})
    TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(CereText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,100000,Kills);
        SetNVar(BGMVar[1],SetTo,5);
        SetNVar(BGMVar[2],SetTo,5);
        SetNVar(BGMVar[3],SetTo,5);
        SetNVar(BGMVar[4],SetTo,5);
        SetNVar(BGMVar[5],SetTo,5);
        SetNVar(OB_BGMVar,SetTo,5);
    }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
        SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);
        SetNVar(UV[4],SetTo,UnitA4);SetNVar(UV[5],SetTo,UnitA5);SetNVar(UV[6],SetTo,UnitA6);
    },{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
        SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);
        SetNVar(UV[4],SetTo,UnitB4);SetNVar(UV[5],SetTo,UnitB5);SetNVar(UV[6],SetTo,UnitB6);
    },{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
    -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)

TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})
CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[1]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[3]); -- Main Air
    SetNVar(CShapeType,SetTo,5*GunLevel-4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,2,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,80,CTimer);
    SetCDeaths("X",SetTo,3,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[3]); -- Main Air
    SetNVar(CShapeType,SetTo,5*GunLevel-3);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,4,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,80,CTimer);
    SetCDeaths("X",SetTo,5,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[1]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[3]); -- Main Air
    SetNVar(CShapeType,SetTo,5*GunLevel-2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,6,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,6,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,80,CTimer);
    SetCDeaths("X",SetTo,7,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,7,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[3]); -- Main Air
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,8,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,8,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,56,CTimer);
    SetCDeaths("X",SetTo,9,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,9,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,6,CTimer);
    SetCDeaths("X",SetTo,10,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,10,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-3);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,6,CTimer);
    SetCDeaths("X",SetTo,11,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,11,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,6,CTimer);
    SetCDeaths("X",SetTo,12,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,12,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeC,SetTo,UV[6]); -- Side
    SetNVar(CShapeType,SetTo,5*GunLevel-1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,6,CTimer);
    SetCDeaths("X",SetTo,13,CStage);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,13,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main
    TSetNVar(CUnitTypeB,SetTo,UV[5]); -- Main
    SetNVar(CShapeType,SetTo,5*GunLevel);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetCDeaths("X",SetTo,14,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더

CMov(FP,Gun_UnitA,CUnitTypeA) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_UnitB,CUnitTypeB) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_UnitC,CUnitTypeC) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_Shape,CShapeType) -- 공통변수에 각 건작변수값 대입 ( Shape )
CMov(FP,Gun_DataIndex,CDataIndex) -- 공통변수에 각 건작변수값 대입 ( DataIndex )
CMov(FP,Gun_Player,CPlayer) -- 공통변수에 각 건작변수값 대입 ( Player )

OrderLocSize = 256+256
    CallCFuncX(FP,CallCereCAPlot) -- CAPlot 호출
    Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
    Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
    CDoActions(FP,{
        TOrder(CUnitTypeA,CPlayer,"CLoc92",Attack,"HZ");
        TOrder(CUnitTypeB,CPlayer,"CLoc92",Attack,"HZ");
        TOrder(CUnitTypeC,CPlayer,"CLoc92",Attack,"HZ");
    })
CIfEnd()

DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})

CIfEnd()
end

LevelLoopLimit = CreateVar(FP)

function SetNexus(Player,GIndex,GunLevel,X,Y,Loc,DestLoc,UnitA1,UnitA2,UnitA3,UnitA4,UnitA5,UnitB1,UnitB2,UnitB3,UnitB4,UnitB5,LoopLimit,CX,CY)

CStage = SCD[3*GIndex-2] -- 타이머1
CTimer = SCD[3*GIndex-1] -- 타이머2
COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
CShapeType = SGVar[5*GIndex] -- 도형데이터변수

CIf(FP,{Bring(Player,Exactly,0,154,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
    TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(NexusText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,100000,Kills);
        SetNVar(BGMVar[1],SetTo,4);
        SetNVar(BGMVar[2],SetTo,4);
        SetNVar(BGMVar[3],SetTo,4);
        SetNVar(BGMVar[4],SetTo,4);
        SetNVar(BGMVar[5],SetTo,4);
        SetNVar(OB_BGMVar,SetTo,4);
    }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
        SetNVar(LevelLoopLimit,SetTo,LoopLimit);
        SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);
        SetNVar(UV[4],SetTo,UnitA4);SetNVar(UV[5],SetTo,UnitA5);
    },{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
        SetNVar(LevelLoopLimit,SetTo,LoopLimit+1);
        SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);
        SetNVar(UV[4],SetTo,UnitB4);SetNVar(UV[5],SetTo,UnitB5);
    },{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y)})
    -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)
TriggerX(FP,{CDeaths("X",AtMost,4,CStage)},{SetNVar(CDataIndex,SetTo,999)},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})

CIfX(FP,{CDeaths("X",Exactly,1,GMode)})
    CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[1]); -- Main Ground
        SetNVar(CShapeType,SetTo,4*GunLevel-3);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,2,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[2]); -- Main Ground
        SetNVar(CShapeType,SetTo,4*GunLevel-3);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,3,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[3]); -- Main Ground
        SetNVar(CShapeType,SetTo,4*GunLevel-3);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,4,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
        --SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
    })
    CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main Ground
        TSetNVar(CUnitTypeB,SetTo,UV[5]); -- Main Air
        SetNVar(CShapeType,SetTo,4*GunLevel-1);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,Add,LoopLimit); -- 데이터인덱스 초기화
        TSetNVar(CLoopLimit,SetTo,LevelLoopLimit);
        SetCDeaths("X",SetTo,5,CStage);
        --SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
    })
    CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",AtLeast,1,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main Ground
        TSetNVar(CUnitTypeB,SetTo,UV[5]); -- Main Air
        SetNVar(CShapeType,SetTo,4*GunLevel-1);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,Add,1); -- 데이터인덱스 초기화
        TSetNVar(CLoopLimit,SetTo,LevelLoopLimit);
    },{Preserved})
CElseX()

CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[1]); -- Main Ground
    SetNVar(CShapeType,SetTo,4*GunLevel-2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,2,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]); -- Main Ground
    SetNVar(CShapeType,SetTo,4*GunLevel-2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,3,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[3]); -- Main Ground
    SetNVar(CShapeType,SetTo,4*GunLevel-2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,4,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
    --SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})
CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[5]); -- Main Air
    SetNVar(CShapeType,SetTo,4*GunLevel);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    TSetNVar(CLoopLimit,SetTo,LevelLoopLimit);
    SetCDeaths("X",SetTo,1,SideUnitCode);
    SetCDeaths("X",SetTo,34*5,CTimer);
    SetCDeaths("X",SetTo,5,CStage);
    --SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})
CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",AtLeast,1,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[5]); -- Main Air
    SetNVar(CShapeType,SetTo,4*GunLevel);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,Add,LoopLimit+1); -- 데이터인덱스 초기화
    TSetNVar(CLoopLimit,SetTo,LevelLoopLimit);
    SetCDeaths("X",SetTo,1,SideUnitCode);
},{Preserved})
CIfXEnd()

CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})


CMov(FP,Gun_UnitA,CUnitTypeA) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_UnitB,CUnitTypeB) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_LoopLimit,CLoopLimit) -- 공통변수에 각 건작변수값 대입 ( UnitID )
CMov(FP,Gun_Shape,CShapeType) -- 공통변수에 각 건작변수값 대입 ( Shape )
CMov(FP,Gun_DataIndex,CDataIndex) -- 공통변수에 각 건작변수값 대입 ( DataIndex )
CMov(FP,Gun_Player,CPlayer) -- 공통변수에 각 건작변수값 대입 ( Player )

CallCFuncX(FP,CallNexusCAPlot) -- CAPlot 호출

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
OrderLocSize = 512+512
OrderLocPosX = CX
OrderLocPosY = CY
    Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
    Simple_CalcLocX(FP,"CLoc92",OrderLocPosX,OrderLocPosY,OrderLocPosX,OrderLocPosY) -- 로케 복사
    Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
    CDoActions(FP,{
        TOrder(CUnitTypeA,CPlayer,"CLoc92",Attack,DestLoc);
        TOrder(CUnitTypeB,CPlayer,"CLoc92",Attack,DestLoc);
    })
CIfEnd()
DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})
CIfEnd()
end

function SetOvermind(Player,GIndex,X,Y,Loc,UnitA1,UnitA2,UnitA3,UnitA4,UnitA5,UnitA6,UnitA7,UnitA8,
        UnitB1,UnitB2,UnitB3,UnitB4,UnitB5,UnitB6,UnitB7,UnitB8)

    CStage = SCD[3*GIndex-2] -- 타이머1
    CTimer = SCD[3*GIndex-1] -- 타이머2
    COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
    CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
    CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
    CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
    CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
    CShapeType = SGVar[5*GIndex] -- 도형데이터변수
    
CIf(FP,{Bring(Player,Exactly,0,148,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
    TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(OverText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,100000,Kills);
        SetNVar(BGMVar[1],SetTo,5);
        SetNVar(BGMVar[2],SetTo,5);
        SetNVar(BGMVar[3],SetTo,5);
        SetNVar(BGMVar[4],SetTo,5);
        SetNVar(BGMVar[5],SetTo,5);
        SetNVar(OB_BGMVar,SetTo,5);
    }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
        SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);SetNVar(UV[4],SetTo,UnitA4);
        SetNVar(UV[5],SetTo,UnitA5);SetNVar(UV[6],SetTo,UnitA6);SetNVar(UV[7],SetTo,UnitA7);SetNVar(UV[8],SetTo,UnitA8);
    },{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
        SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);SetNVar(UV[4],SetTo,UnitB4);
        SetNVar(UV[5],SetTo,UnitB5);SetNVar(UV[6],SetTo,UnitB6);SetNVar(UV[7],SetTo,UnitB7);SetNVar(UV[8],SetTo,UnitB8);
    },{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
        -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)

TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})

for i = 1, 12 do
    CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[1]); -- Main Air
        SetNVar(CShapeType,SetTo,1);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetNVar(OverAngle,SetTo,30*i);
        SetCDeaths("X",SetTo,4,CTimer);
        SetCDeaths("X",SetTo,i+1,CStage);
    })
end
CTrigger(FP,{CDeaths("X",Exactly,13,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]); -- Main Ground
    SetNVar(CShapeType,SetTo,4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(OverAngle,SetTo,30*0);
    SetCDeaths("X",SetTo,34*12,CTimer);
    SetCDeaths("X",SetTo,14,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
for i = 14, 25 do
    CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[3]); -- Main Air
        SetNVar(CShapeType,SetTo,2);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetNVar(OverAngle,SetTo,-30*(i-13));
        SetCDeaths("X",SetTo,4,CTimer);
        SetCDeaths("X",SetTo,i+1,CStage);
    })
end
CTrigger(FP,{CDeaths("X",Exactly,26,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[4]); -- Main Ground
    SetNVar(CShapeType,SetTo,4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(OverAngle,SetTo,30*0);
    SetCDeaths("X",SetTo,34*12,CTimer);
    SetCDeaths("X",SetTo,27,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
for i = 27, 38 do
    CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[5]); -- Main Air
        SetNVar(CShapeType,SetTo,3);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetNVar(OverAngle,SetTo,30*(i-26));
        SetCDeaths("X",SetTo,4,CTimer);
        SetCDeaths("X",SetTo,i+1,CStage);
    })
end
CTrigger(FP,{CDeaths("X",Exactly,39,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[6]); -- Main Ground
    SetNVar(CShapeType,SetTo,4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(OverAngle,SetTo,30*0);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,40,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,40,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[7]); -- Main Ground
    TSetNVar(CUnitTypeB,SetTo,UV[8]); -- Main Ground
    SetNVar(CShapeType,SetTo,5);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(OverAngle,SetTo,30*0);
    SetCDeaths("X",SetTo,1,SideUnitCode); -- Last
    SetCDeaths("X",SetTo,41,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})

CTrigger(FP,{CDeaths("X",Exactly,42,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})

CDoActions(FP,{ -- 공통변수 삽입
    TSetNVar(Gun_UnitA,SetTo,CUnitTypeA);
    TSetNVar(Gun_UnitB,SetTo,CUnitTypeB);
    TSetNVar(Gun_LoopLimit,SetTo,CLoopLimit);
    TSetNVar(Gun_Shape,SetTo,CShapeType);
    TSetNVar(Gun_DataIndex,SetTo,CDataIndex);
    TSetNVar(Gun_Player,SetTo,CPlayer);
    TSetNVar(Gun_Angle,SetTo,OverAngle);
})

CallCFuncX(FP,CallOverMindCAPlot) -- CAPlot 호출

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    OrderLocSize = 512
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{
            TOrder("Men",CPlayer,"CLoc92",Attack,"HZ");
        })
CIfEnd()
    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})
CIfEnd()

end

function SetPrison(Player,GIndex,X,Y,Loc,UnitA1,UnitA2,UnitA3,UnitA4,UnitA5,UnitA6,UnitA7,UnitA8,
    UnitB1,UnitB2,UnitB3,UnitB4,UnitB5,UnitB6,UnitB7,UnitB8)

CStage = SCD[3*GIndex-2] -- 타이머1
CTimer = SCD[3*GIndex-1] -- 타이머2
COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
CShapeType = SGVar[5*GIndex] -- 도형데이터변수

CIf(FP,{Bring(Player,Exactly,0,168,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
TriggerX(FP,{},{
    CopyCpAction({DisplayTextX(PrisonText,4)},{Force1,Force5},FP);
    SetScore(Force1,Add,100000,Kills);
    SetNVar(BGMVar[1],SetTo,3);
    SetNVar(BGMVar[2],SetTo,3);
    SetNVar(BGMVar[3],SetTo,3);
    SetNVar(BGMVar[4],SetTo,3);
    SetNVar(BGMVar[5],SetTo,3);
    SetNVar(OB_BGMVar,SetTo,3);
}) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
    SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);SetNVar(UV[4],SetTo,UnitA4);
    SetNVar(UV[5],SetTo,UnitA5);SetNVar(UV[6],SetTo,UnitA6);SetNVar(UV[7],SetTo,UnitA7);SetNVar(UV[8],SetTo,UnitA8);
},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
    SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);SetNVar(UV[4],SetTo,UnitB4);
    SetNVar(UV[5],SetTo,UnitB5);SetNVar(UV[6],SetTo,UnitB6);SetNVar(UV[7],SetTo,UnitB7);SetNVar(UV[8],SetTo,UnitB8);
},{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
    -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)

TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})

TriggerX(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,56); -- 잡몹
    SetNVar(CShapeType,SetTo,1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,2,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,51); -- 잡몹
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,3,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[1]); -- 영웅지상
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,4,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]); -- 영웅공중
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,5,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,56); -- 잡몹
    SetNVar(CShapeType,SetTo,1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,6,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,6,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,51); -- 잡몹
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,7,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,7,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[3]); -- 영웅지상
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,8,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,8,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[4]); -- 영웅공중
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,9,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,9,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,56); -- 잡몹
    SetNVar(CShapeType,SetTo,1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,10,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,10,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,51); -- 잡몹
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,11,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,11,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[5]); -- 영웅지상
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,12,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,12,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[6]); -- 영웅공중
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,13,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,13,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,56); -- 잡몹
    SetNVar(CShapeType,SetTo,1);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,14,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
TriggerX(FP,{CDeaths("X",Exactly,14,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetNVar(CUnitTypeA,SetTo,51); -- 잡몹
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,15,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,15,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[7]); -- 영웅지상
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,16,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CTrigger(FP,{CDeaths("X",Exactly,16,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[8]); -- 영웅공중
    SetNVar(CShapeType,SetTo,2);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,17,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})

TriggerX(FP,{CDeaths("X",Exactly,17,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})

CDoActions(FP,{ -- 공통변수 삽입
    TSetNVar(Gun_UnitA,SetTo,CUnitTypeA);
    TSetNVar(Gun_LoopLimit,SetTo,CLoopLimit);
    TSetNVar(Gun_Shape,SetTo,CShapeType);
    TSetNVar(Gun_DataIndex,SetTo,CDataIndex);
    TSetNVar(Gun_Player,SetTo,CPlayer);
})

CallCFuncX(FP,CallPrisonCAPlot) -- CAPlot 호출

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    OrderLocSize = 512
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        --Simple_CalcLocX(FP,"CLoc92",OrderLocPosX,OrderLocPosY,OrderLocPosX,OrderLocPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{
            TOrder(CUnitTypeA,CPlayer,"CLoc92",Attack,"HZ");
        })
    CIfEnd()
    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})
CIfEnd()

end

function SetCenter(Player,GunLevel,GIndex,X,Y,Loc,UnitA1,UnitA2,UnitB1,UnitB2)

CStage = SCD[3*GIndex-2] -- 타이머1
CTimer = SCD[3*GIndex-1] -- 타이머2
COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
CShapeType = SGVar[5*GIndex] -- 도형데이터변수

CIf(FP,{Bring(Player,Exactly,0,106,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
TriggerX(FP,{},{
    CopyCpAction({DisplayTextX(CenterText,4)},{Force1,Force5},FP);
    SetScore(Force1,Add,100000,Kills);
    SetNVar(BGMVar[1],SetTo,4);
    SetNVar(BGMVar[2],SetTo,4);
    SetNVar(BGMVar[3],SetTo,4);
    SetNVar(BGMVar[4],SetTo,4);
    SetNVar(BGMVar[5],SetTo,4);
    SetNVar(OB_BGMVar,SetTo,4);
}) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
    SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);
},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
    SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);
},{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
    -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)

TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})

for i = 1, 6 do
CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[1]);
    SetNVar(CShapeType,SetTo,GunLevel);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(CenterAngle1,SetTo,30*i);
    SetNVar(CenterAngle2,SetTo,15*i);
    SetNVar(CenterAngle3,SetTo,8*i);
    SetCDeaths("X",SetTo,120,CTimer);
    SetCDeaths("X",SetTo,i+1,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
end

for i = 7, 12 do
CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[2]);
    SetNVar(CShapeType,SetTo,GunLevel);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetNVar(CenterAngle1,SetTo,30*i);
    SetNVar(CenterAngle2,SetTo,15*i);
    SetNVar(CenterAngle3,SetTo,8*i);
    SetCDeaths("X",SetTo,120,CTimer);
    SetCDeaths("X",SetTo,i+1,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
end

TriggerX(FP,{CDeaths("X",Exactly,13,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})

CDoActions(FP,{ -- 공통변수 삽입
    TSetNVar(Gun_UnitA,SetTo,CUnitTypeA);
    TSetNVar(Gun_LoopLimit,SetTo,CLoopLimit);
    TSetNVar(Gun_Shape,SetTo,CShapeType);
    TSetNVar(Gun_DataIndex,SetTo,CDataIndex);
    TSetNVar(Gun_Player,SetTo,CPlayer);
})

CallCFuncX(FP,CallCenterCAPlot) -- CAPlot 호출

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    OrderLocSize = 512
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{
            TOrder(CUnitTypeA,CPlayer,"CLoc92",Attack,"C2");
        })
CIfEnd()
    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})
CIfEnd()

end

function SetGenerator(Player,GIndex,X,Y,Loc,UnitA1,UnitA2,UnitA3,UnitA4,UnitB1,UnitB2,UnitB3,UnitB4)

CStage = SCD[3*GIndex-2] -- 타이머1
CTimer = SCD[3*GIndex-1] -- 타이머2
COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
CShapeType = SGVar[5*GIndex] -- 도형데이터변수

CIf(FP,{Bring(Player,Exactly,0,200,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
TriggerX(FP,{},{
    CopyCpAction({DisplayTextX(GeneText,4)},{Force1,Force5},FP);
    SetScore(Force1,Add,100000,Kills);
    SetNVar(BGMVar[1],SetTo,4);
    SetNVar(BGMVar[2],SetTo,4);
    SetNVar(BGMVar[3],SetTo,4);
    SetNVar(BGMVar[4],SetTo,4);
    SetNVar(BGMVar[5],SetTo,4);
    SetNVar(OB_BGMVar,SetTo,4);
}) -- 대충여따가 건작텍스트 브금변수 한번만 실행
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
    SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);SetNVar(UV[4],SetTo,UnitA4);
},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
    SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);SetNVar(UV[4],SetTo,UnitB4);
},{Preserved})
DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
    -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)

TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
    SetCDeaths("X",SetTo,1,CTimer);
    SetCDeaths("X",SetTo,1,CStage);
})
CIfX(FP,{CDeaths("X",Exactly,1,GMode)})
for i = 1, 3 do
    CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[1]);
        TSetNVar(CUnitTypeB,SetTo,UV[2]);
        SetNVar(CShapeType,SetTo,i);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,i+1,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
end
CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[3]);
    TSetNVar(CUnitTypeB,SetTo,UV[4]);
    SetNVar(CShapeType,SetTo,4);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,5,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CElseX()
for i = 1, 3 do
    CTrigger(FP,{CDeaths("X",Exactly,i,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitTypeA,SetTo,UV[1]);
        TSetNVar(CUnitTypeB,SetTo,UV[2]);
        SetNVar(CShapeType,SetTo,i+4);
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetNVar(CLoopLimit,SetTo,600);
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,i+1,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
end
CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
    TSetNVar(CUnitTypeA,SetTo,UV[3]);
    TSetNVar(CUnitTypeB,SetTo,UV[4]);
    SetNVar(CShapeType,SetTo,8);
    SetNVar(CPlayer,SetTo,Player);
    SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
    SetNVar(CLoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,34*10,CTimer);
    SetCDeaths("X",SetTo,5,CStage);
    SetCDeathsX("X",SetTo,1,COrder,0xFF);
})
CIfXEnd()


TriggerX(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
})

CDoActions(FP,{ -- 공통변수 삽입
    TSetNVar(Gun_UnitA,SetTo,CUnitTypeA);
    TSetNVar(Gun_UnitB,SetTo,CUnitTypeB);
    TSetNVar(Gun_LoopLimit,SetTo,CLoopLimit);
    TSetNVar(Gun_Shape,SetTo,CShapeType);
    TSetNVar(Gun_DataIndex,SetTo,CDataIndex);
    TSetNVar(Gun_Player,SetTo,CPlayer);
})

CallCFuncX(FP,CallGeneCAPlot) -- CAPlot 호출

CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    OrderLocSize = 1024
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        --Simple_CalcLocX(FP,"CLoc92",OrderLocPosX,OrderLocPosY,OrderLocPosX,OrderLocPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{
            TOrder("Men",CPlayer,"CLoc92",Attack,"WH");
        })
CIfEnd()

    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF),SetCDeaths("X",Subtract,1,SideUnitCode)})
CIfEnd()

end

function PreSaveCache()

CIf(FP,{CDeathsX("X",Exactly,0,CacheFlag,0xFF)})
    DoActionsX(FP,{
        SetNVar(Gun_DataIndex,SetTo,600);
        SetNVar(VTimeline,Add,1);
        SetNVar(IXY,Add,3);SetNVar(IYZ,Add,4);SetNVar(IZX,Add,5);
    })
    TriggerX(FP,{NVar(VTimeline,AtLeast,360)},{SetNVar(VTimeline,SetTo,0),SetCDeathsX("X",SetTo,1,CacheFlag,0xFF)})
    CallCFuncX(FP,CallIonCAPlot)
    CallCFuncX(FP,CallIonCAPlot2)
CIfEnd()

end

function SetIonUp(Player,GIndex,Loc)
    CStage = SCD[3*GIndex-2] -- 타이머1
    CTimer = SCD[3*GIndex-1] -- 타이머2
    COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
    CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
    CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
    CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
    CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
    CShapeType = SGVar[5*GIndex] -- 도형데이터변수
CIf(FP,{Bring(Player,Exactly,0,127,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(IonText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,100000,Kills);
        SetNVar(BGMVar[1],SetTo,4);
        SetNVar(BGMVar[2],SetTo,4);
        SetNVar(BGMVar[3],SetTo,4);
        SetNVar(BGMVar[4],SetTo,4);
        SetNVar(BGMVar[5],SetTo,4);
        SetNVar(OB_BGMVar,SetTo,4);
    })
DoActionsX(FP,{
    SetNVar(CShapeType,Add,1);
    SetSpriteImage(385, 975);SetImageScript(975, 131);SetImageColor(975,17)
})
TriggerX(FP,{NVar(CShapeType,AtLeast,360)},{SetNVar(CShapeType,SetTo,0)},{Preserved})

CMov(FP,VTimeline,CShapeType)
CallCFuncX(FP,CallIonCAPlot)

DoActionsX(FP,{SetCDeaths("X",Add,1,CTimer),Order("Men", Force2, "Anywhere", Move, Loc)})
TriggerX(FP,{CDeaths("X",AtLeast,1700,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00);
    CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere")},{Force2},FP);
})
CIfEnd()
end

function SetIonDown(Player,GIndex,Loc)
    CStage = SCD[3*GIndex-2] -- 타이머1
    CTimer = SCD[3*GIndex-1] -- 타이머2
    COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
    CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
    CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
    CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
    CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
    CShapeType = SGVar[5*GIndex] -- 도형데이터변수
CIf(FP,{Bring(Player,Exactly,0,127,Loc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(IonText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,100000,Kills);
        SetNVar(BGMVar[1],SetTo,4);
        SetNVar(BGMVar[2],SetTo,4);
        SetNVar(BGMVar[3],SetTo,4);
        SetNVar(BGMVar[4],SetTo,4);
        SetNVar(BGMVar[5],SetTo,4);
        SetNVar(OB_BGMVar,SetTo,4);
    })
DoActionsX(FP,{
    SetNVar(CShapeType,Add,1);
    SetSpriteImage(385, 975);SetImageScript(975, 131);SetImageColor(975,17)
})
TriggerX(FP,{NVar(CShapeType,AtLeast,360)},{SetNVar(CShapeType,SetTo,0)},{Preserved})

CMov(FP,VTimeline,CShapeType)
CallCFuncX(FP,CallIonCAPlot2)

DoActionsX(FP,{SetCDeaths("X",Add,1,CTimer),Order("Men", Force2, "Anywhere", Move, Loc)})
TriggerX(FP,{CDeaths("X",AtLeast,1700,CTimer)},{
    SetCDeathsX("X",SetTo,1*256,COrder,0xFF00);
    CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere")},{Force2},FP);
})
CIfEnd()
end

-- function SetCocoon(Player,GIndex,X,Y,Loc)
--     CStage = SCD[3*GIndex-2] -- 타이머1
--     CTimer = SCD[3*GIndex-1] -- 타이머2
--     COrder = SCD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
--     CDataIndex = SGVar[5*GIndex-4] -- 데이터인덱스변수
--     CUnitTypeA = SGVar[5*GIndex-3] -- 유닛변수
--     CUnitTypeB = SGVar[5*GIndex-2] -- 유닛변수
--     CLoopLimit = SGVar[5*GIndex-1] -- 루프리미트
--     CShapeType = SGVar[5*GIndex] -- 도형데이터변수
-- TriggerX(FP,{},{
--         CopyCpAction({DisplayTextX(CocoonText,4)},{Force1,Force5},FP);
--         SetScore(Force1,Add,100000,Kills);
--         SetNVar(BGMVar[1],SetTo,4);
--         SetNVar(BGMVar[2],SetTo,4);
--         SetNVar(BGMVar[3],SetTo,4);
--         SetNVar(BGMVar[4],SetTo,4);
--         SetNVar(BGMVar[5],SetTo,4);
--         SetNVar(OB_BGMVar,SetTo,4);
--     })
-- TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
--     SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitA3);SetNVar(UV[4],SetTo,UnitA4);
--     },{Preserved})
-- TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
--      SetNVar(UV[1],SetTo,UnitB1);SetNVar(UV[2],SetTo,UnitB2);SetNVar(UV[3],SetTo,UnitB3);SetNVar(UV[4],SetTo,UnitB4);
--     },{Preserved})
-- DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})

-- TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
--     SetCDeaths("X",SetTo,1,CTimer);
--     SetCDeaths("X",SetTo,1,CStage);
-- })
-- CIf(FP,{CDeaths("X",Exactly,1,GMode)})
--     TriggerX(FP,{
--         CDeaths("X",Exactly,0,CTimer);
--         CDeaths("X",Exactly,1,CStage);
--     },{
--         SetCDeaths("X",SetTo,1,CTimer);
--         SetCDeaths("X",SetTo,2,CStage);
--     })
--     TriggerX(FP,{
--         CDeaths("X",Exactly,0,CTimer);
--         CDeaths("X",Exactly,1,CStage);
--     },{
--         SetCDeaths("X",SetTo,1,CTimer);
--         SetCDeaths("X",SetTo,2,CStage);
--     })
-- CElseX()

-- CIfEnd()


-- end
-----------< Ion Cache >-----------
PreSaveCache()
-----------< Cerebrate >-----------

SetCerebrate(P6,1,1,3758,1764,"C1",77,93,80,78,21,25, 78,74,80,79,28,30)
SetCerebrate(P6,2,2,3707,3331,"C2",78,74,80,78,21,25, 79,75,80,19,86,30)
SetCerebrate(P7,3,2,1370,3806,"C3",17,19,86,76,28,25, 76,63,86,81,58,30)
SetCerebrate(P7,4,3,313,2811,"C4",76,63,58,81,58,30, 5,30,86,32,12,30)
SetCerebrate(P7,5,3,324,895,"C5",5,32,58,81,58,8, 52,3,98,32,98,64)
SetCerebrate(P7,6,4,1461,549,"C6",65,66,88,87,58,8, 87,61,88,68,22,8)

-----------< Nexus >-----------
SetNexus(P6,7,1,4018,4036,"N1","HZ",80,21,80,28,25 ,28,25,28,70,30 ,3,CS_GetXCntr(SH_N1B),CS_GetYCntr(SH_N1B))
SetNexus(P7,8,2,76,4033,"N2","HZ",28,25,28,70,30 ,58,70,22,70,64 ,4,CS_GetXCntr(SH_N2B),CS_GetYCntr(SH_N2B))
SetNexus(P8,9,3,1225,2497,"N3","HZ",58,70,22,70,64 ,98,58,98,64,60 ,5,CS_GetXCntr(SH_N3B),CS_GetYCntr(SH_N3B))
SetNexus(P8,10,4,2872,1598,"N4","HZ",98,58,98,64,60 ,88,8,88,71,60 ,5,CS_GetXCntr(SH_N4B),CS_GetYCntr(SH_N4B))
-----------< Overmind >-----------
SetOvermind(P6,11,3632,3816,"O1",80,75,21,79,28,19,25,86, 21,76,28,63,86,19,25,58)
SetOvermind(P7,12,509,3697,"O2",28,76,58,63,98,19,25,58, 58,5,98,81,70,32,58,98)
SetOvermind(P7,13,620,425,"O3",58,32,98,52,70,3,58,98, 8,52,88,3,64,66,60,22)
-----------< Prison >-----------
SetPrison(P8,14,1815,2828,"Prison1",80,77,86,78,86,19,28,75, 88,76,8,5,22,25,70,30)
SetPrison(P8,15,2270,1242,"Prison2",88,76,8,5,22,25,70,30, 88,5,8,32,60,52,64,3)
-----------< Center >-----------
SetCenter(P8,1,16,2466,3049,"CenterA",80,88,28,98)
SetCenter(P8,2,17,1220,2147,"CenterB",21,8,22,60)
SetCenter(P8,3,18,2906,1888,"CenterC",28,58,98,88)
SetCenter(P8,4,19,1640,1035,"CenterD",86,98,60,64)
-----------< Generator >-----------
SetGenerator(P8,20,2377,2337,"G1",21,76,8,32, 8,76,98,3)
SetGenerator(P8,21,1729,2340,"G2",80,79,88,74, 88,74,98,52)
SetGenerator(P8,22,1484,2041,"G3",28,63,22,5, 22,65,60,65)
SetGenerator(P8,23,2628,2068,"G4",58,17,70,65, 70,3,60,66)
SetGenerator(P8,24,1735,1757,"G5",22,78,86,81, 98,5,64,87)
SetGenerator(P8,25,2356,1754,"G6",60,19,64,3, 60,52,102,61)
-----------< Ion >-----------
SetIonUp(P8,26,"Ion1")
SetIonDown(P8,27,"Ion2")
-----------< CoCoon >-----------

-----------< I.Center >-----------

-----------< Temple >-----------

end
