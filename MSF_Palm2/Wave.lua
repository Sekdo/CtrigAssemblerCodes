function Install_Wave()
WTimer, WFlag, WLevel, WType = CreateCcodes(4)
WUnitA, WUnitB, WUnitC, WUnitD, WUnitE, WUnitF = CreateVars(6,FP)

SH_A = CSMakePolygon(5,80,0,CS_Level("Polygon",5,4),0)
SH_B = CSMakePolygon(5,80,0,CS_Level("Polygon",5,5),0)
SH_C = CSMakePolygon(5,80,0,CS_Level("Polygon",5,6),0)
SH_D = CSMakePolygon(6,80,0,CS_Level("Polygon",6,4),0)
SH_E = CSMakePolygon(6,80,0,CS_Level("Polygon",6,5),0)
SH_F = CSMakePolygon(6,80,0,CS_Level("Polygon",6,6),0)
function SetWaveTrig(Time,UnitA,UnitB,UnitC,UnitD)
    TriggerX(FP,{NVar(RTimer, Exactly, 60*Time)},{
        SetNVar(WUnitA,SetTo,UnitA);SetNVar(WUnitB,SetTo,UnitB);
        SetNVar(WUnitC,SetTo,UnitC);SetNVar(WUnitD,SetTo,UnitD);
        SetNVar(GPosX,SetTo,3383);SetNVar(GPosY,SetTo,3715);
        SetCDeaths("X",SetTo,1,WFlag);SetNVar(Gun_Shape,SetTo,5);
    })
end

function CenterWaveTrig(Time,UnitA,UnitB,UnitC,UnitD)
    TriggerX(FP,{NVar(RTimer, Exactly, 60*Time)},{
        SetNVar(WUnitA,SetTo,UnitA);SetNVar(WUnitB,SetTo,UnitB);
        SetNVar(WUnitC,SetTo,UnitC);SetNVar(WUnitD,SetTo,UnitD);
        SetNVar(GPosX,SetTo,2048);SetNVar(GPosY,SetTo,2048);
        SetCDeaths("X",SetTo,1,WFlag);SetNVar(Gun_Shape,SetTo,6);
    })
end

Call_WaveCAPlot = InitCFunc(FP)

CFunc(Call_WaveCAPlot)
    WaveShapeArr = {SH_A,SH_B,SH_C,SH_D,SH_E,SH_F}
    CAPlot(WaveShapeArr,P8,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,Gun_LoopLimit,Gun_DataIndex},nil,FP,nil
            ,{SetNext("X",0x4001),SetNext(0x4002,"X",1)},nil)
CFuncEnd()

RTimer = CreateVar(FP)
CMov(FP,RTimer,_Div(_Mul(_ReadF(0x57F23C),42),1000)) -- 실제시간

CJump(FP,0x400)
SetLabel(0x4001)

CDoActions(FP, { -- A,B 공중 C,D 지상
    TCreateUnit(1,WUnitA,"CLoc91",P8),TCreateUnit(1,WUnitB,"CLoc91",P8);
    TCreateUnit(1,WUnitC,"CLoc91",P8),TCreateUnit(1,WUnitD,"CLoc91",P8);
})

SetLabel(0x4002)
CJumpEnd(FP,0x400)

CIfX(FP,{CDeaths("X",Exactly,1,GMode)})
    SetWaveTrig(1,55,56,53,48);SetWaveTrig(5,55,56,53,48);SetWaveTrig(10,55,56,51,104);SetWaveTrig(15,55,56,51,104);
    SetWaveTrig(20,62,80,74,93);SetWaveTrig(27,56,80,74,93);SetWaveTrig(34,80,21,77,78);SetWaveTrig(41,80,21,77,78);
    CenterWaveTrig(48,28,21,19,17);CenterWaveTrig(55,28,21,19,17);CenterWaveTrig(62,28,21,79,75);CenterWaveTrig(70,28,21,79,75);
    CenterWaveTrig(78,86,28,63,76);CenterWaveTrig(86,86,28,63,76);CenterWaveTrig(94,70,86,81,5);CenterWaveTrig(102,70,86,81,5);
    CenterWaveTrig(110,70,86,52,32);CenterWaveTrig(118,70,86,52,32);CenterWaveTrig(126,28,21,81,5);CenterWaveTrig(136,28,21,81,5);
    CenterWaveTrig(146,28,21,79,75);CenterWaveTrig(156,28,21,79,75);CenterWaveTrig(166,28,21,79,75);CenterWaveTrig(176,28,21,79,75);
    CenterWaveTrig(196,28,21,79,75);CenterWaveTrig(216,28,21,79,75);CenterWaveTrig(240,28,21,79,75);CenterWaveTrig(300,28,21,79,75);
CElseX()
    SetWaveTrig(1,55,56,53,48);SetWaveTrig(5,55,56,53,48);SetWaveTrig(10,55,56,51,104);SetWaveTrig(15,55,56,51,104);
    SetWaveTrig(20,62,80,74,93);SetWaveTrig(27,56,80,74,93);SetWaveTrig(34,80,21,77,78);SetWaveTrig(41,80,21,77,78);
    CenterWaveTrig(48,28,21,19,17);CenterWaveTrig(55,28,21,19,17);CenterWaveTrig(62,28,21,79,75);CenterWaveTrig(70,28,21,79,75);
    CenterWaveTrig(78,86,28,63,76);CenterWaveTrig(86,86,28,63,76);CenterWaveTrig(94,70,86,81,5);CenterWaveTrig(102,70,86,81,5);
    CenterWaveTrig(110,70,86,52,32);CenterWaveTrig(118,70,86,52,32);CenterWaveTrig(126,28,21,81,5);CenterWaveTrig(136,28,21,81,5);
    CenterWaveTrig(146,28,21,79,75);CenterWaveTrig(156,28,21,79,75);CenterWaveTrig(166,28,21,79,75);CenterWaveTrig(176,28,21,79,75);
    CenterWaveTrig(196,28,21,79,75);CenterWaveTrig(216,28,21,79,75);CenterWaveTrig(240,28,21,79,75);CenterWaveTrig(300,28,21,79,75);
CIfXEnd()

CIf(FP,{CDeaths("X",Exactly,1,WFlag)},{SetCDeaths("X",SetTo,0,WFlag)})
    DoActionsX(FP,{
        SetNVar(Gun_DataIndex,SetTo,0);
        SetNVar(Gun_LoopLimit,SetTo,600);
        CopyCpAction({
            PlayWAVX('sound\\Protoss\\ARCHON\\PArYes02.wav');PlayWAVX('sound\\Protoss\\ARCHON\\PArYes02.wav');
            PlayWAVX('sound\\Protoss\\ARCHON\\PArYes02.wav');PlayWAVX('sound\\Protoss\\ARCHON\\PArYes02.wav');
        }, {Force1}, FP);
    })
    CallCFuncX(FP,Call_WaveCAPlot)
    OrderLocSize = 512
    Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
    Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
    CDoActions(FP,{
        TOrder(WUnitA,P8,"CLoc92",Attack,"HZ");
        TOrder(WUnitB,P8,"CLoc92",Attack,"HZ");
        TOrder(WUnitC,P8,"CLoc92",Attack,"HZ");
        TOrder(WUnitD,P8,"CLoc92",Attack,"HZ");
    })
    
CIfEnd()



end
