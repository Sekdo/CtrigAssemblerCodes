function Install_MGun()


    LText =  "\x13\x1F─━┫ \x1FL\x04air 를 파괴했습니다. \x19+20,000\x04ⓟⓣⓢ  \x1F┣━─"
    HText =  "\x13\x1F─━┫ \x1FH\x04ive 를 파괴했습니다. \x19+30,000\x04ⓟⓣⓢ  \x1F┣━─"

    GunMaxAmount = 43 -- 최대건작갯수 ( 넘어가면 컴파일오류 )

    -- 데스,변수 설정 // CAPlot 공통변수설정 -- 
    CD = CreateCcodeArr(3*GunMaxAmount)
    GVar = CreateVarArr(4*GunMaxAmount)
    
    GPosX, GPosY, Gun_LoopLimit, Gun_DataIndex, Gun_Shape, Gun_Unit, Gun_Player, ShapeNum = CreateVars(8,FP)
    UV = CreateVarArr(16)
    ShapeVar = CreateVarArr(12)
    -- 도형데이터 -- 
    -- Lair --
    SH_A = CSMakePolygon(5,80,0,CS_Level("Polygon",5,3),0)
    SH_B = CSMakePolygon(5,80,0,CS_Level("Polygon",5,4),0)
    SH_C = CSMakePolygon(5,80,0,CS_Level("Polygon",5,5),0)
    SH_D = CSMakePolygon(6,80,0,CS_Level("Polygon",6,3),0)
    SH_E = CSMakePolygon(6,80,0,CS_Level("Polygon",6,4),0)
    SH_F = CSMakePolygon(6,80,0,CS_Level("Polygon",6,5),0)

    -- Hive --
    SH_A2 = CSMakePolygon(5,80,0,CS_Level("Polygon",5,3),0)
    SH_B2 = CSMakePolygon(5,80,0,CS_Level("Polygon",5,4),0)
    SH_C2 = CSMakePolygon(5,80,0,CS_Level("Polygon",5,5),0)
    SH_D2 = CSMakePolygon(6,80,0,CS_Level("Polygon",6,3),0)
    SH_E2 = CSMakePolygon(6,80,0,CS_Level("Polygon",6,4),0)
    SH_F2 = CSMakePolygon(6,80,0,CS_Level("Polygon",6,5),0)
    -- Hive2 --
    SH_A3 = CSMakeLine(4,100,0,4*3+1,0)
    SH_B3 = CSMakePolygon(5,80,0,CS_Level("Polygon",5,4),0)
    SH_C3 = CSMakePolygon(5,80,0,CS_Level("Polygon",5,5),0)
    SH_D3 = CSMakeLine(6,100,0,6*3+1,0)
    SH_E3 = CSMakePolygon(6,80,0,CS_Level("Polygon",6,4),0)
    SH_F3 = CSMakePolygon(6,80,0,CS_Level("Polygon",6,5),0)

    CAShapeArr = {SH_A,SH_B,SH_C,SH_D,SH_E,SH_F,SH_A2,SH_B2,SH_C2,SH_D2,SH_E2,SH_F2,SH_A3,SH_B3,SH_C3,SH_D3,SH_E3,SH_F3}
    ----< CAFunc , CAPlot CFunc >----
    CallCAPlot = InitCFunc(FP)
    CFunc(CallCAPlot)
        CAPlot(CAShapeArr,P2,193,"CLoc91",{GPosX,GPosY},1,16,{Gun_Shape,0,0,0,600,Gun_DataIndex},nil,FP,nil
        ,{SetNext("X",0x2001),SetNext(0x2002,"X",1)},nil)
        --[[ PerAction 부분 (현재트리거의 Next트리거를 0x2001로 설정 // 0x2002의 Next트리거를 현재트리거의 다음트리거로 설정)
    작동순서 : 193유닛생성(로케만이동) -> PerActions(다음트리거 0x2001로설정) -> CJump(0x100)~CJumpEnd(0x100) 단락으로 진입후 유닛생성 -> 0x2002
                -> 트리거0x2002의 Next를 CAPlot트리거로 설정 -> 점 다찍힐때까지 위 과정반복 -> CAPlot 종료
        ]]--
    CFuncEnd()
    ----< 유닛생성단락 >----
    CJump(FP,0x100)
    SetLabel(0x2001) -- CAPlot PerActions 도착지점
        CDoActions(FP,{ -- 유닛생성단락
            TCreateUnit(1,Gun_Unit,"CLoc91",Gun_Player);
        })
    
    SetLabel(0x2002)
    CJumpEnd(FP,0x100)

TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{SetNVar(ShapeNum,SetTo,1)},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{SetNVar(ShapeNum,SetTo,2)},{Preserved})
    
function SetLairGun(Player,GIndex,X,Y,GLoc,UnitA1,UnitA2,UnitB1,UnitB2,UnitC1,UnitC2,UnitD1,UnitD2) -- Normal(A,B) // Hard(C,D)
    ----< 데스, 변수 할당 >----
    CStage = CD[3*GIndex-2] -- 타이머1
    CTimer = CD[3*GIndex-1] -- 타이머2
    COrder = CD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
    CDataIndex = GVar[4*GIndex-3] -- 데이터인덱스변수
    CUnitType = GVar[4*GIndex-2] -- 유닛변수
    CShapeType = GVar[4*GIndex-1] -- 도형데이터변수
    CPlayer = GVar[4*GIndex] -- 플레이어변수
    ----< 건작제어 단락 >----
    CIf(FP,{Bring(Player,Exactly,0,132,GLoc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
    TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(LText,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,20000,Kills);
        SetNVar(BGMVar[1],SetTo,1);
        SetNVar(BGMVar[2],SetTo,1);
        SetNVar(BGMVar[3],SetTo,1);
        SetNVar(BGMVar[4],SetTo,1);
        SetNVar(BGMVar[5],SetTo,1);
        SetNVar(OB_BGMVar,SetTo,1);
    }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
    TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
        SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitB1);SetNVar(UV[4],SetTo,UnitB2);
        SetNVar(ShapeVar[1],SetTo,2);SetNVar(ShapeVar[2],SetTo,2);SetNVar(ShapeVar[3],SetTo,1);SetNVar(ShapeVar[4],SetTo,1);SetNVar(ShapeVar[5],SetTo,2);
        SetNVar(ShapeVar[6],SetTo,2);SetNVar(ShapeVar[7],SetTo,2);SetNVar(ShapeVar[8],SetTo,1);SetNVar(ShapeVar[9],SetTo,1);SetNVar(ShapeVar[10],SetTo,2);
    },{Preserved})
    TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
        SetNVar(UV[1],SetTo,UnitC1);SetNVar(UV[2],SetTo,UnitC2);SetNVar(UV[3],SetTo,UnitD1);SetNVar(UV[4],SetTo,UnitD2);
        SetNVar(ShapeVar[1],SetTo,5);SetNVar(ShapeVar[2],SetTo,5);SetNVar(ShapeVar[3],SetTo,4);SetNVar(ShapeVar[4],SetTo,4);SetNVar(ShapeVar[5],SetTo,5);
        SetNVar(ShapeVar[6],SetTo,5);SetNVar(ShapeVar[7],SetTo,5);SetNVar(ShapeVar[8],SetTo,4);SetNVar(ShapeVar[9],SetTo,4);SetNVar(ShapeVar[10],SetTo,5);
    },{Preserved})
    DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
        -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)
    
    TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,1,CStage);
    })
    CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[1]);
        TSetNVar(CShapeType,SetTo,ShapeVar[1]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,2,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,104);
        TSetNVar(CShapeType,SetTo,ShapeVar[2]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,3,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,53);
        TSetNVar(CShapeType,SetTo,ShapeVar[3]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,4,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,54);
        TSetNVar(CShapeType,SetTo,ShapeVar[4]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,5,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[2]);
        TSetNVar(CShapeType,SetTo,ShapeVar[5]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,6,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,6,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[3]);
        TSetNVar(CShapeType,SetTo,ShapeVar[6]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,7,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,7,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,51);
        TSetNVar(CShapeType,SetTo,ShapeVar[7]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,8,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,8,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,53);
        TSetNVar(CShapeType,SetTo,ShapeVar[8]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,9,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,9,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,48);
        TSetNVar(CShapeType,SetTo,ShapeVar[9]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,10,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,10,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[4]);
        TSetNVar(CShapeType,SetTo,ShapeVar[10]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,11,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    TriggerX(FP,{CDeaths("X",Exactly,11,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetCDeaths("X",SetTo,12,CStage);
        SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
    })
    CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    
    CMov(FP,Gun_Unit,CUnitType) -- 공통변수에 각 건작변수값 대입 ( UnitID )
    CMov(FP,Gun_Shape,CShapeType) -- 공통변수에 각 건작변수값 대입 ( Shape )
    CMov(FP,Gun_DataIndex,CDataIndex) -- 공통변수에 각 건작변수값 대입 ( DataIndex )
    CMov(FP,Gun_Player,CPlayer) -- 공통변수에 각 건작변수값 대입 ( Player )
    
    OrderLocSize = 256+128
        CallCFuncX(FP,CallCAPlot) -- CAPlot 호출
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{TOrder(CUnitType,CPlayer,"CLoc92",Attack,"HZ")})
    CIfEnd()
    
    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF)})
    
    CIfEnd()
end

function SetHiveGun(Player,GIndex,X,Y,GLoc,UnitA1,UnitA2,UnitB1,UnitB2,UnitC1,UnitC2,UnitD1,UnitD2)
      ----< 데스, 변수 할당 >----
    CStage = CD[3*GIndex-2] -- 타이머1
    CTimer = CD[3*GIndex-1] -- 타이머2
    COrder = CD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
    CDataIndex = GVar[4*GIndex-3] -- 데이터인덱스변수
    CUnitType = GVar[4*GIndex-2] -- 유닛변수
    CShapeType = GVar[4*GIndex-1] -- 도형데이터변수
    CPlayer = GVar[4*GIndex] -- 플레이어변수
    ----< 건작제어 단락 >----
    CIf(FP,{Bring(Player,Exactly,0,133,GLoc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
        TriggerX(FP,{},{
            CopyCpAction({DisplayTextX(HText,4)},{Force1,Force5},FP);
            SetScore(Force1,Add,30000,Kills);
            SetNVar(BGMVar[1],SetTo,1);
            SetNVar(BGMVar[2],SetTo,1);
            SetNVar(BGMVar[3],SetTo,1);
            SetNVar(BGMVar[4],SetTo,1);
            SetNVar(BGMVar[5],SetTo,1);
            SetNVar(OB_BGMVar,SetTo,1);
        }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
    
    TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
        SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitB1);SetNVar(UV[4],SetTo,UnitB2);
        SetNVar(ShapeVar[1],SetTo,2);SetNVar(ShapeVar[2],SetTo,2);SetNVar(ShapeVar[3],SetTo,1);SetNVar(ShapeVar[4],SetTo,1);SetNVar(ShapeVar[5],SetTo,2);
        SetNVar(ShapeVar[6],SetTo,3);SetNVar(ShapeVar[7],SetTo,3);SetNVar(ShapeVar[8],SetTo,1);SetNVar(ShapeVar[9],SetTo,1);SetNVar(ShapeVar[10],SetTo,3);
    },{Preserved})
    TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
        SetNVar(UV[1],SetTo,UnitC1);SetNVar(UV[2],SetTo,UnitC2);SetNVar(UV[3],SetTo,UnitD1);SetNVar(UV[4],SetTo,UnitD2);
        SetNVar(ShapeVar[1],SetTo,5);SetNVar(ShapeVar[2],SetTo,5);SetNVar(ShapeVar[3],SetTo,4);SetNVar(ShapeVar[4],SetTo,4);SetNVar(ShapeVar[5],SetTo,5);
        SetNVar(ShapeVar[6],SetTo,6);SetNVar(ShapeVar[7],SetTo,6);SetNVar(ShapeVar[8],SetTo,4);SetNVar(ShapeVar[9],SetTo,4);SetNVar(ShapeVar[10],SetTo,6);
    },{Preserved})

    DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
        -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)
    
    TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,1,CStage);
    })
    CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[1]);
        TSetNVar(CShapeType,SetTo,ShapeVar[1]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,2,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,104);
        TSetNVar(CShapeType,SetTo,ShapeVar[2]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,3,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,53);
        TSetNVar(CShapeType,SetTo,ShapeVar[3]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,4,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,54);
        TSetNVar(CShapeType,SetTo,ShapeVar[4]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,5,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[2]);
        TSetNVar(CShapeType,SetTo,ShapeVar[5]); -- 2,5
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,6,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,6,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[3]);
        TSetNVar(CShapeType,SetTo,ShapeVar[6]); -- 3,6
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,7,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,7,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,51);
        TSetNVar(CShapeType,SetTo,ShapeVar[7]); -- 3,6
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,8,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,8,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,53);
        TSetNVar(CShapeType,SetTo,ShapeVar[8]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,9,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,9,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetNVar(CUnitType,SetTo,48);
        TSetNVar(CShapeType,SetTo,ShapeVar[9]); -- 1,4
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,1,CTimer);
        SetCDeaths("X",SetTo,10,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    CTrigger(FP,{CDeaths("X",Exactly,10,CStage),CDeaths("X",Exactly,0,CTimer)},{
        TSetNVar(CUnitType,SetTo,UV[4]);
        TSetNVar(CShapeType,SetTo,ShapeVar[10]); -- 3,6
        SetNVar(CPlayer,SetTo,Player);
        SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
        SetCDeaths("X",SetTo,34*10,CTimer);
        SetCDeaths("X",SetTo,11,CStage);
        SetCDeathsX("X",SetTo,1,COrder,0xFF);
    })
    TriggerX(FP,{CDeaths("X",Exactly,11,CStage),CDeaths("X",Exactly,0,CTimer)},{
        SetCDeaths("X",SetTo,12,CStage);
        SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
    })
    CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
    
    CMov(FP,Gun_Unit,CUnitType) -- 공통변수에 각 건작변수값 대입 ( UnitID )
    CMov(FP,Gun_Shape,CShapeType) -- 공통변수에 각 건작변수값 대입 ( Shape )
    CMov(FP,Gun_DataIndex,CDataIndex) -- 공통변수에 각 건작변수값 대입 ( DataIndex )
    CMov(FP,Gun_Player,CPlayer) -- 공통변수에 각 건작변수값 대입 ( Player )
    
    OrderLocSize = 256+256
        CallCFuncX(FP,CallCAPlot) -- CAPlot 호출
        Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
        Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
        CDoActions(FP,{TOrder(CUnitType,CPlayer,"CLoc92",Attack,"HZ")})
    CIfEnd()
    
    DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF)})
    
    CIfEnd()
end

function SetHiveGun2(Player,GIndex,X,Y,GLoc,UnitA1,UnitA2,UnitB1,UnitB2,UnitC1,UnitC2,UnitD1,UnitD2)
    ----< 데스, 변수 할당 >----
  CStage = CD[3*GIndex-2] -- 타이머1
  CTimer = CD[3*GIndex-1] -- 타이머2
  COrder = CD[3*GIndex] -- 0xFF ( 오더 & CallCFuncX ) // 0xFF00 ( 건작잠금 ) 
  CDataIndex = GVar[4*GIndex-3] -- 데이터인덱스변수
  CUnitType = GVar[4*GIndex-2] -- 유닛변수
  CShapeType = GVar[4*GIndex-1] -- 도형데이터변수
  CPlayer = GVar[4*GIndex] -- 플레이어변수
  ----< 건작제어 단락 >----
  CIf(FP,{Bring(Player,Exactly,0,133,GLoc),CDeathsX("X",Exactly,0*256,COrder,0xFF00)})
      TriggerX(FP,{},{
          CopyCpAction({DisplayTextX(HText,4)},{Force1,Force5},FP);
          SetScore(Force1,Add,30000,Kills);
          SetNVar(BGMVar[1],SetTo,2);
          SetNVar(BGMVar[2],SetTo,2);
          SetNVar(BGMVar[3],SetTo,2);
          SetNVar(BGMVar[4],SetTo,2);
          SetNVar(BGMVar[5],SetTo,2);
          SetNVar(OB_BGMVar,SetTo,2);
      }) -- 대충여따가 건작텍스트 브금변수 한번만 실행
  
  TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{
      SetNVar(UV[1],SetTo,UnitA1);SetNVar(UV[2],SetTo,UnitA2);SetNVar(UV[3],SetTo,UnitB1);SetNVar(UV[4],SetTo,UnitB2);
      SetNVar(ShapeVar[1],SetTo,12+1);SetNVar(ShapeVar[2],SetTo,12+2);SetNVar(ShapeVar[3],SetTo,12+1);SetNVar(ShapeVar[4],SetTo,12+1);SetNVar(ShapeVar[5],SetTo,12+2);
        SetNVar(ShapeVar[6],SetTo,12+1);SetNVar(ShapeVar[7],SetTo,12+3);SetNVar(ShapeVar[8],SetTo,12+1);SetNVar(ShapeVar[9],SetTo,12+1);SetNVar(ShapeVar[10],SetTo,12+2);
  },{Preserved})
  TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{
      SetNVar(UV[1],SetTo,UnitC1);SetNVar(UV[2],SetTo,UnitC2);SetNVar(UV[3],SetTo,UnitD1);SetNVar(UV[4],SetTo,UnitD2);
      SetNVar(ShapeVar[1],SetTo,12+4);SetNVar(ShapeVar[2],SetTo,12+5);SetNVar(ShapeVar[3],SetTo,12+6);SetNVar(ShapeVar[4],SetTo,12+6);SetNVar(ShapeVar[5],SetTo,12+5);
        SetNVar(ShapeVar[6],SetTo,12+4);SetNVar(ShapeVar[7],SetTo,12+5);SetNVar(ShapeVar[8],SetTo,12+6);SetNVar(ShapeVar[9],SetTo,12+6);SetNVar(ShapeVar[10],SetTo,12+5);
  },{Preserved})

  DoActionsX(FP,{SetNVar(GPosX,SetTo,X),SetNVar(GPosY,SetTo,Y),SetNVar(CDataIndex,SetTo,999)})
      -- ↑↑건작좌표 상시세팅 // 데이터인덱스999고정 ( 유닛안나오게설정)
  
  TriggerX(FP,{CDeaths("X",Exactly,0,CTimer),CDeaths("X",Exactly,0,CStage)},{
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,1,CStage);
  })
  CTrigger(FP,{CDeaths("X",Exactly,1,CStage),CDeaths("X",Exactly,0,CTimer)},{
      TSetNVar(CUnitType,SetTo,UV[1]);
      TSetNVar(CShapeType,SetTo,ShapeVar[1]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,2,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,2,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,104);
      TSetNVar(CShapeType,SetTo,ShapeVar[2]); -- 2,5
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,3,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,3,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,53);
      TSetNVar(CShapeType,SetTo,ShapeVar[3]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,4,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,4,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,54);
      TSetNVar(CShapeType,SetTo,ShapeVar[4]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,5,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,5,CStage),CDeaths("X",Exactly,0,CTimer)},{
      TSetNVar(CUnitType,SetTo,UV[2]);
      TSetNVar(CShapeType,SetTo,ShapeVar[5]); -- 2,5
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,34*13,CTimer);
      SetCDeaths("X",SetTo,6,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,6,CStage),CDeaths("X",Exactly,0,CTimer)},{
      TSetNVar(CUnitType,SetTo,UV[3]);
      TSetNVar(CShapeType,SetTo,ShapeVar[6]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,7,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,7,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,51);
      TSetNVar(CShapeType,SetTo,ShapeVar[7]); -- 3,6
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,8,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,8,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,53);
      TSetNVar(CShapeType,SetTo,ShapeVar[8]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,9,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,9,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetNVar(CUnitType,SetTo,48);
      TSetNVar(CShapeType,SetTo,ShapeVar[9]); -- 1,4
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,1,CTimer);
      SetCDeaths("X",SetTo,10,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  CTrigger(FP,{CDeaths("X",Exactly,10,CStage),CDeaths("X",Exactly,0,CTimer)},{
      TSetNVar(CUnitType,SetTo,UV[4]);
      TSetNVar(CShapeType,SetTo,ShapeVar[10]); -- 3,6
      SetNVar(CPlayer,SetTo,Player);
      SetNVar(CDataIndex,SetTo,1); -- 데이터인덱스 초기화
      SetCDeaths("X",SetTo,34*13,CTimer);
      SetCDeaths("X",SetTo,11,CStage);
      SetCDeathsX("X",SetTo,1,COrder,0xFF);
  })
  TriggerX(FP,{CDeaths("X",Exactly,11,CStage),CDeaths("X",Exactly,0,CTimer)},{
      SetCDeaths("X",SetTo,12,CStage);
      SetCDeathsX("X",SetTo,1*256,COrder,0xFF00); -- 건작잠금
  })
  CIf(FP,{CDeathsX("X",Exactly,1,COrder,0xFF)},{SetCDeathsX("X",SetTo,0,COrder,0xFF)}) -- CAPlot / 오더
  
  CMov(FP,Gun_Unit,CUnitType) -- 공통변수에 각 건작변수값 대입 ( UnitID )
  CMov(FP,Gun_Shape,CShapeType) -- 공통변수에 각 건작변수값 대입 ( Shape )
  CMov(FP,Gun_DataIndex,CDataIndex) -- 공통변수에 각 건작변수값 대입 ( DataIndex )
  CMov(FP,Gun_Player,CPlayer) -- 공통변수에 각 건작변수값 대입 ( Player )
  
  OrderLocSize = 256+256
      CallCFuncX(FP,CallCAPlot) -- CAPlot 호출
      Simple_SetLocX(FP,"CLoc92",GPosX,GPosY,GPosX,GPosY) -- 로케 복사
      Simple_CalcLocX(FP,"CLoc92",-OrderLocSize,-OrderLocSize,OrderLocSize,OrderLocSize) -- 로케크기설정
      CDoActions(FP,{TOrder(CUnitType,CPlayer,"CLoc92",Attack,"HZ")})
  CIfEnd()
  
  DoActionsX(FP,{SetCDeaths("X",Subtract,1,CTimer),SetCDeathsX("X",Subtract,1,COrder,0xFF)})
  
  CIfEnd()
end


-----------< 우측라인 건작 >-----------
SetLairGun(P6,1,3839,746,"L1",40,55,40,56, 93,55,93,56)
SetLairGun(P6,2,3681,1194,"L2",51,55,51,56, 74,55,74,56)
SetHiveGun(P6,3,3857,1315,"H1",40,55,51,56, 93,56,74,56)

SetLairGun(P6,4,3904,2158,"L3",93,55,93,56, 77,55,77,56)
SetLairGun(P6,5,3709,2288,"L4",74,55,74,56, 78,55,78,56)
SetHiveGun(P6,6,3850,2411,"H2",93,56,74,56, 77,56,78,56)

SetLairGun(P6,7,3836,2691,"L5",77,55,77,56, 79,55,79,56)
SetLairGun(P6,8,3950,2868,"L6",78,55,78,56, 75,55,75,56)
SetHiveGun(P6,9,3781,3068,"H3",77,56,78,56, 79,56,75,56)

SetLairGun(P6,10,3427,3538,"L7",79,55,79,56, 17,55,17,56)
SetLairGun(P6,11,3713,3593,"L8",75,55,75,56, 19,55,19,56)
SetHiveGun(P6,12,3393,3920,"H4",79,56,75,56, 17,56,19,56)

SetLairGun(P6,13,2812,3589,"L9",17,55,17,56, 76,55,76,56)
SetLairGun(P6,14,3006,3707,"L10",19,55,19,56, 63,55,63,56)
SetHiveGun(P6,15,2860,3856,"H5",17,56,19,56, 76,56,63,56)

-----------< 좌측라인 건작 >-----------
SetLairGun(P7,16,1368,3591,"L11",76,56,76,56, 81,56,81,56)
SetLairGun(P7,17,1129,3740,"L12",63,56,63,56, 5,56,5,56)
SetHiveGun(P7,18,976,3927,"H6",76,56,63,21, 81,56,5,80)

SetLairGun(P7,19,636,3837,"L13",81,56,81,56, 25,56,25,56)
SetLairGun(P7,20,380,3801,"L14",5,56,5,56, 30,56,30,56)
SetHiveGun(P7,21,255,3488,"H7",81,56,5,80, 25,56,30,56)

SetLairGun(P7,22,388,3239,"L15",25,56,25,56, 32,56,32,28)
SetLairGun(P7,23,144,3126,"L16",30,56,30,56, 32,56,32,22)
SetHiveGun(P7,24,381,2964,"H8",25,56,30,56, 32,28,32,22)

SetLairGun(P7,25,290,2523,"L17",32,56,32,28, 52,56,52,86)
SetLairGun(P7,26,510,2431,"L18",32,56,32,22, 52,58,52,58)
SetHiveGun(P7,27,301,2220,"H9",32,28,32,22, 52,86,52,58)

SetLairGun(P7,28,391,2013,"L19",52,56,52,86, 3,56,3,98)
SetLairGun(P7,29,172,1771,"L20",52,56,52,58, 3,56,3,64)
SetHiveGun(P7,30,415,1665,"H10",52,86,52,58, 3,64,3,98)

SetLairGun(P7,31,171,1421,"L21",3,56,3,98, 65,56,65,8)
SetLairGun(P7,32,353,1284,"L22",3,56,3,64, 65,56,65,88)
SetHiveGun(P7,33,217,1098,"H11",3,98,3,64, 65,8,65,88)

SetHiveGun2(P7,34,315,643,"H12",65,80,65,88, 66,88,66,22)
SetHiveGun2(P7,35,230,291,"H13",66,80,66,88, 87,88,87,22)
SetHiveGun2(P7,36,635,123,"H14",87,21,87,8, 61,8,61,22)
SetHiveGun2(P7,37,1052,309,"H15",61,21,61,8, 23,8,23,22)

-----------< 중앙라인 건작 >-----------

SetHiveGun2(P8,38,2121,3207,"H16",65,80,102,86, 65,88,102,60)
SetHiveGun2(P8,39,2753,2843,"H17",66,80,102,86, 66,88,102,60)
SetHiveGun2(P8,40,1274,2814,"H18",87,21,102,86, 87,8,102,64)
SetHiveGun2(P8,41,2816,1277,"H19",61,21,102,58, 61,8,71,64)
SetHiveGun2(P8,42,1339,1249,"H20",23,28,102,58, 23,22,71,98)
SetHiveGun2(P8,43,1858,848,"H21",68,28,102,58, 68,22,9,98)

end