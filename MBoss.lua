function Install_MBoss()

------<  Functions  >---------------------------------------------
function CreateUnit3(UnitID,Location,NeutralPlayer)
	local X = {}
		table.insert(X,{CreateUnit(1,UnitID,Location,P8),GiveUnits(1,UnitID,P8,Location,NeutralPlayer)})
	return X
end
    

function SetKillScore(UnitID,Value)
    return SetMemoryW(0x663EB8 + 2*UnitID, SetTo, Value)
end

function SetUnitWeapon(UnitID,WeaponID)
    return SetMemoryB(0x6636B8 + UnitID, SetTo, WeaponID)
end

function SetMB_VFlags(Variable,Variable256)
    CIf(FP,{CVar("X",GMode,AtLeast,2),NVar(Variable,Exactly,0),NVar(Variable256,Exactly,0)})
        CDoActions(FP,{
            TSetNVar(Variable,SetTo,VFlag);
            TSetNVar(Variable256,SetTo,VFlag256);
        })
    CIfEnd()
end

function MB_CAFunc()
    local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
        CMov(FP,Temp_DataIndex,V(CA[6]))
end

function MB_CBFunc()
    CIf(FP,{CDeathsX("X",Exactly,3*16777216,MB_Stage,0xFF000000),NVar(MB_Shape,AtLeast,11)})
        MB3_Cache = CB_InitCache(128,MB3_Circle[1],0x80000000) -- CycleLength : 128 /  Dot : MB3_Circle[1]
        MB3Vptr1 = CB_InitVShape(13)
        CB_LoadCache(MB3_Cache,MB_VTimeLine,MB3Vptr1)
        CB_GetNumber(13,VNull)
            CIf(FP,{NVar(VNull,Exactly,0x80000000)})
                CB_Ratio(MBRatio,1024,MBRatio,1024,11,12) -- 16 / tik
                CB_Rotate(AngleXY,12,13)
                CB_SaveCache(MB3_Cache,MB_VTimeLine,MB3Vptr1)
            CIfEnd()
    CIfEnd()
end

------<  Texts  >---------------------------------------------

WarpTxt = "\x13\x1F─━┫ \x10B\x04eyond \x08D\x04imension 를 파괴했습니다. \x19+66,666\x04ⓟⓣⓢ \x1F┣━─"
MB1Txt = "\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1B─━┫\x04 Ｂｏｓｓ \x08Ⅰ \x10『 \x08Μ\x04αλφασ \x10』 \x04가 활성화되었습니다. \x1B┣━─\x04\n\n\n\x13\x04--------------------------------------------------------------------------"
MB2Txt = "\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1B─━┫\x04 Ｂｏｓｓ \x11Ⅱ \x10『 \x08Χ\x04αλφασ \x10』 \x04가 활성화되었습니다. \x1B┣━─\x04\n\n\n\x13\x04--------------------------------------------------------------------------"
MB3Txt = "\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1B─━┫\x04 Ｂｏｓｓ \x17Ⅲ \x10『 \x08Β\x04αλακ \x10』 \x04가 활성화되었습니다. \x1B┣━─\x04\n\n\n\x13\x04--------------------------------------------------------------------------"
MB4Txt = "\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1B─━┫\x04 Ｂｏｓｓ \x18Ⅳ \x10『 \x08Γ\x04λασιαλαμπολασ \x10』 \x04가 활성화되었습니다. \x1B┣━─\x04\n\n\n\x13\x04--------------------------------------------------------------------------"
--MB5Txt = "\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1B─━┫\x04 Ｂｏｓｓ \x0EⅤ \x10『 \x08Ε\x04λιγοσ \x10』 \x04가 활성화되었습니다. \x1F┣━─\x04\n\n\n\x13\x04--------------------------------------------------------------------------"

ClearMB1Txt = "\x13\x1B─━┫ \x04 Ｂｏｓｓ \x08Ⅰ \x04:: \x08Μ\x04αλφασ \x04를 \x08처치\x04하였습니다. \x19+200,000 \x04ⓟⓣⓢ \x1B┣━─\n\x13\x1B─━ \x06D\x04eath Count －１０ \x1B━─"
ClearMB2Txt = "\x13\x1B─━┫ \x04 Ｂｏｓｓ \x11Ⅱ \x04:: \x08Χ\x04αλφασ \x04를 \x08처치\x04하였습니다. \x19+400,000 \x04ⓟⓣⓢ \x1B┣━─\n\x13\x1B─━ \x06D\x04eath Count －１０ \x1B━─"
ClearMB3Txt = "\x13\x1B─━┫ \x04 Ｂｏｓｓ \x17Ⅲ \x04:: \x08Β\x04αλακ \x04를 \x08처치\x04하였습니다. \x19+600,000 \x04ⓟⓣⓢ \x1B┣━─\n\x13\x1B─━ \x06D\x04eath Count －２０ \x1B━─"
ClearMB4Txt = "\x13\x1B─━┫ \x04 Ｂｏｓｓ \x18Ⅳ \x04:: \x08Γ\x04λασιαλαμπολασ \x04를 \x08처치\x04하였습니다. \x19+800,000 \x04ⓟⓣⓢ \x1B┣━─\n\x13\x1B─━ \x06D\x04eath Count －２０ \x1B━─"
--ClearMB5Txt = "\x13\x1B─━┫ \x04 Ｂｏｓｓ \x0EⅤ \x04:: \x08Ε\x04λιγοσ \x04를 \x08처치\x04하였습니다. \x19+1,000,000 \x04ⓟⓣⓢ \x1B┣━─"

------<  Init  >---------------------------------------------

MBLocX, MBLocY, MB_Shape, MB_DataIndex, MB_LoopMax, MB_BulletAngle, Temp_DataIndex, CurEnergy, WeaponV, MB_TUnit, DamagePerHP = CreateVars(11,FP)

Nextptrs, NextEPD, MB_VTimeLine, VNull = CreateVars(4,FP)
AngleXY, MBRatio = CreateVar2s(2,{0,1},FP)
NukePosXY, NukePosX, NukePosY, NukeShape, NukeDataIndex, NukeNumber = CreateVars(6,FP)
MB_WaitTimer, MB_Stage, MB_HP, NukeType = CreateCcodes(4) -- 중보 공용데스값

MB4Deaths = CreateCcode()
-- MB1 Ccodes & Vars --
MB1_EPD = CreateVars(1,FP)
MB1_SW, MB1_STimer = CreateCcodes(2)
-- MB2 Ccodes & Vars --
MB2_EPD, MB2_VFlag, MB2_VFlag256 = CreateVars(3,FP)
MB2_SW, MB2_STimer = CreateCcodes(2)
-- MB3 Ccodes & Vars --
MB3_EPD, RandPattern, MB3_VFlag, MB3_VFlag256 = CreateVars(4,FP)
MB3_SW, MB3_STimer, MB3Cache, PatternTimer, LockSW, PatternSW = CreateCcodes(6)
-- MB4 Ccodes & Vars --
MB4_EPD = CreateVars(1,FP)
MB4_SW, MB4_STimer = CreateCcodes(2)
-- MB5 Ccodes & Vars --
--MB5_EPD = CreateVars(1,FP)
--MB5_SW, MB5_STimer = CreateCcodes(2)


MBID = {89,57,96,71}
MBLoc = {"MB1","MB2","MB3","MB4"}
MBossEPD = {MB1_EPD,MB2_EPD,MB3_EPD,MB4_EPD}

CIfOnce(FP,Memory(0x628438,AtLeast,1))
DoActions(FP,{SetImageScript(42,362),SetImageColor(940,8)})
    for i = 1, 3 do
	f_Read(FP,0x628438,nil,MBossEPD[i])
		CDoActionsX(FP,{
			CreateUnit3(MBID[i],MBLoc[i],P12);
			TSetMemory(Vi(MBossEPD[i][2],2),SetTo,256*4000000);
            TSetMemory(Vi(MBossEPD[i][2],13),SetTo,0);
			SetInvincibility(Enable,MBID[i],P12,"Anywhere");
		})
    end
        f_Read(FP,0x628438,nil,MBossEPD[4])
            CDoActionsX(FP,{
                CreateUnit3(MBID[4],MBLoc[4],P12);
                TSetMemory(Vi(MBossEPD[4][2],2),SetTo,256*3000000);
                TSetMemory(Vi(MBossEPD[4][2],13),SetTo,0);
                SetInvincibility(Enable,MBID[4],P12,"Anywhere");
            })

DoActions(FP,{SetImageScript(42,25),SetImageColor(940,10)}) -- Reset Script, Color
CIfEnd()

------<  Shapes Data  >---------------------------------------------
--< MB1 >--
YCircleA1 = CS_MoveXY(CS_RatioXY(CSMakeCircle(4,96,0,CS_Level("Circle",4,4),0),1.2,0.8),128*3,-128*3)
YCircleA2 = CS_MoveXY(CS_RatioXY(CSMakeCircle(4,96,0,CS_Level("Circle",4,4),0),1.2,0.8),-128*3,-128*3)
YCircleB1 = CS_MoveXY(CS_RatioXY(CSMakeCircle(5,96,0,CS_Level("Circle",5,4),0),1.2,0.8),128*3,-128*3)
YCircleB2 = CS_MoveXY(CS_RatioXY(CSMakeCircle(5,96,0,CS_Level("Circle",5,4),0),1.2,0.8),-128*3,-128*3)
YCircleC1 = CS_MoveXY(CS_RatioXY(CSMakeCircle(6,96,0,CS_Level("Circle",6,4),0),1.2,0.8),128*3,-128*3)
YCircleC2 = CS_MoveXY(CS_RatioXY(CSMakeCircle(6,96,0,CS_Level("Circle",6,4),0),1.2,0.8),-128*3,-128*3)

EnergyShapeA = CS_MoveXY(CS_SortX(CSMakeLine(2,8,90,25,0),0),0,48)
EnergyShapeB = CS_MoveXY(CS_SortX(CSMakeLine(2,8,90,20,0),0),0,48)
--< MB2 >--
MB2_CircleA = CSMakeCircleX(24,512,0,24,0)
MB2_CircleB = CSMakeCircleX(36,512,0,36,0)
--< MB3 >--
--CrossA = CS_OverlapX(CSMakeLine(2,32,0,13,0),CS_MoveXY(CSMakeLine(2,32,0,13,0),-32,0),CS_MoveXY(CSMakeLine(2,32,0,13,0),32,0))
--CrossB = CS_MoveXY(CS_OverlapX(CSMakeLine(2,32,90,9,0),CS_MoveXY(CSMakeLine(2,32,90,9,0),0,-32),CS_MoveXY(CSMakeLine(2,32,90,9,0),0,32)),0,-32*2)
--SH_Cross = CS_RatioXY(CS_Rotate(CS_RemoveStack(CS_OverlapX(CrossA,CrossB),10),240),1.35,1.35)
MB3_Circle = CSMakeCircleX(6,1024,0,6,0)
function AbsX(X,Y) return {math.abs(X)} end

MB3_SquareA = CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,6),CS_Level("PolygonX",4,3)),"AbsX",nil,1),45)
MB3_SquareB = CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,6),CS_Level("PolygonX",4,2)),"AbsX",nil,1),45)
MB3_SquareC = CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,6),CS_Level("PolygonX",4,3)),"AbsX",nil,0),135)
MB3_SquareD = CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,6),CS_Level("PolygonX",4,2)),"AbsX",nil,0),135)

MB3_SideA = CS_RatioXY(CSMakePolygonX(4,224,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2)),0.9,1.3)
MB3_SideB = CS_RatioXY(CSMakePolygonX(4,224,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2)),1.3,0.9)
MB3_Side = CS_OverlapX(MB3_SideA,MB3_SideB)
MB3_SideC = CS_MoveXY(CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,5),CS_Level("PolygonX",4,3)),"AbsX",nil,1),45),0,-144)
MB3_SideD = CS_MoveXY(CS_Rotate(CS_SortXY(CSMakePolygonX(4,64,45,CS_Level("PolygonX",4,5),CS_Level("PolygonX",4,3)),"AbsX",nil,1),135),0,-144)

MB3_PatternPass = CSMakeCircleX(24,512,0,24,0)
--< MB4 >--

function Sort_MB4Func(R,A)
	return {math.abs(R),math.abs(A)}
end
MB4_StarX1 = CS_MoveXY(CSMakePolygon(4,96,0,CS_Level("Polygon",4,3),0),-128*3.5,-128)
MB4_StarX2 = CS_MoveXY(CSMakePolygon(4,96,0,CS_Level("Polygon",4,3),0),128*3.5,-128)

MB4_Square = CS_RatioXY(CSMakePolygonX(4,192,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2)),1,0.8)
MB4_BulletSH = CS_SortRA(CSMakeCircleX(5,64,0,CS_Level("CircleX",5,5),0),"Sort_X4Func",{0},1)
------<  CreateUnit for CJump  >---------------------------------------------

CJump(FP,0x400)
SetLabel(0x2001)

NIf(FP,{Memory(0x628438,AtLeast,1)})
    f_Read(FP,0x628438,Nextptrs,NextEPD)
    CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
        CreateUnit(1,212,"CLoc106",P8);
        TSetMemoryX(Vi(NextEPD[2],35),SetTo,1,0xFF); -- 개별건작 세팅
        TSetMemoryX(Vi(NextEPD[2],55),SetTo,0x100,0x100); -- 스테이터스플래그 세팅
        TSetMemoryX(Vi(NextEPD[2],57),SetTo,2^5,0xFF); -- P6
        TSetMemoryX(Vi(NextEPD[2],68),SetTo,300,0xFFFF); -- 리무브타이머
        TSetMemoryX(Vi(NextEPD[2],70),SetTo,255*16777216,0xFF000000); -- Storm Timer ( GunTimer )
        TSetMemoryX(Vi(NextEPD[2],72),SetTo,255*256,0xFF00);
        TSetMemoryX(Vi(NextEPD[2],73),SetTo,(2^5)*256,0xFF00); -- Unused Timer
        CopyCpAction({MinimapPing("CLoc106")},{Force1,Force5},FP);
    },{Preserved})
    f_Read(FP,_Add(NextEPD,10),NukePosXY) -- 공격지점 저장
    f_Read(FP,0x628438,nil,NextEPD)
        CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
            CreateUnit(1,14,"HZ",P8);
            TSetMemory(Vi(NextEPD[2],32),SetTo,Nextptrs); -- 연결유닛 
            TSetMemoryX(Vi(NextEPD[2],19),SetTo,125*256,0xFF00); -- 오더ID 핵공격
            TSetMemory(Vi(NextEPD[2],22),SetTo,NukePosXY); -- 핵쏠위치 지정
        },{Preserved})
NIfEnd()
SetLabel(0x2002)
CJumpEnd(FP,0x400)

CJump(FP,0x401)
SetLabel(0x2003) -- CBPlot 생성단락

NIf(FP,{Memory(0x628438,AtLeast,1)})
    CIfX(FP,{CDeathsX("X",Exactly,1*16777216,MB_Stage,0xFF000000)}) -- MB1
        BulletImage2 = 541
        BulletScript2 = 247
        BulletColor2 = 17
        BulletInitSetting(FP,{197,122,283},92,199,493,BulletImage2,BulletScript2,BulletColor2,7000,0,60,1,4,3,{32,32,32},0) -- Ignore Def

        CIfX(FP,{NVar(MB_Shape,AtMost,6)})
	        CreateBullet(FP,P8,197,20,MB_BulletAngle,1024*6,22,"CLoc106")
        CElseIfX({NVar(MB_Shape,AtLeast,7),NVar(MB_Shape,AtMost,8)}) -- Energy
            CIf(FP,{TNVar(Temp_DataIndex,AtMost,CurEnergy)})
                CreateEffect(FP,Nextptr,16,509,20,204,"CLoc106",P8)
            CIfEnd()
            CIf(FP,{TNVar(Temp_DataIndex,AtLeast,_Add(CurEnergy,1))})
                CreateEffect(FP,Nextptr,10,509,20,204,"CLoc106",P8)
            CIfEnd()
        CIfXEnd()

    CElseIfX{CDeathsX("X",Exactly,2*16777216,MB_Stage,0xFF000000)} -- MB2
        SetNextptr()
            CTrigger(FP,{Memory(0x628438,AtLeast,1),CVar("X",GMode,AtMost,2)},{
                CreateUnit(1,30,"CLoc106",P8);
                TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
                TSetMemoryX(Vi(Nextptr[2],57),SetTo,MB2_VFlag,0xFF); -- Visibility State
                TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
                TSetMemoryX(Vi(Nextptr[2],73),SetTo,MB2_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
                TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
                TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
            },{Preserved})
            CTrigger(FP,{Memory(0x628438,AtLeast,1),CVar("X",GMode,Exactly,3)},{
                CreateUnit(1,69,"CLoc106",P8);
                TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
                TSetMemoryX(Vi(Nextptr[2],57),SetTo,MB2_VFlag,0xFF); -- Visibility State
                TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
                TSetMemoryX(Vi(Nextptr[2],73),SetTo,MB2_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
                TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
                TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
            },{Preserved})

    CElseIfX{CDeathsX("X",Exactly,3*16777216,MB_Stage,0xFF000000)} -- MB3
        CIf(FP,{CDeaths("X",Exactly,1,MB3Cache)}) -- After SaveCache
            CIfX(FP,{CVar("X",GMode,Exactly,1)})
                TriggerX(FP,{CDeathsX("X",Exactly,0,PatternSW,0xFF)},{
                    CreateUnit(1,77,"CLoc106",P6);
                    CreateUnit(1,70,"CLoc106",P6);
                    CreateUnit(1,84,"CLoc106",P5);
                },{Preserved})
                TriggerX(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)},{
                    CreateUnit(1,78,"CLoc106",P7);
                    CreateUnit(1,70,"CLoc106",P7);
                    CreateUnit(1,84,"CLoc106",P5);
                },{Preserved})
            CElseX() -- CVar("X",GMode,AtLeast,2)
                TriggerX(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)},{CreateUnit(1,84,"CLoc106",P5)},{Preserved}) -- 패턴예고 이팩트
                CIf(FP,{CDeathsX("X",Exactly,6,PatternSW,0xFF),CDeathsX("X",Exactly,0*65536,MB_Stage,0xFF0000)})
                    CIfX(FP,{NVar(RandPattern,AtMost,1)}) -- 유닛
                        TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
                            CreateUnit(1,69,"CLoc106",P8);
                            CreateUnit(1,84,"CLoc106",P5);
                            Order(69,P8,"CLoc106",Attack,"MB3")
                        },{Preserved})
                        TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
                            CreateUnit(1,30,"CLoc106",P8);
                            CreateUnit(1,84,"CLoc106",P5);
                        },{Preserved})
                    
                    CElseIfX({NVar(RandPattern,AtLeast,2)},{TSetBulletDamage(92, SetTo, DamagePerHP);}) -- NVar(RandPattern,AtLeast,2) 탄막
                        CIfX(FP,{CVar("X",GMode,Exactly,2)})
                            BulletImage2 = 381
                            BulletScript2 = 395 -- Unknown 395
                            BulletColor2 = 16
                            BulletInitSetting(FP,{197,122,283},92,199,493,BulletImage2,BulletScript2,BulletColor2,2000,0,60,1,4,3,{64,64,64},0) -- Ignore Def
                            CreateBullet(FP,P8,197,20,0,1,44,"CLoc106")
                        CElseIfX({CVar("X",GMode,Exactly,3)})
                            BulletImage2 = 381
                            BulletScript2 = 395 -- Unknown 395
                            BulletColor2 = 9
                            BulletInitSetting(FP,{197,122,283},92,199,493,BulletImage2,BulletScript2,BulletColor2,2000,0,60,1,4,3,{96,96,96},0) -- Ignore Def
                            CreateBullet(FP,P8,197,20,0,1,66,"CLoc106")
                        CIfXEnd()
                    CIfXEnd()
                CIfEnd()

                CIf(FP,{CDeathsX("X",Exactly,1*65536,MB_Stage,0xFF0000),NVar(MB_Shape,Exactly,18)})
                    CDoActions(FP,{
                        TCreateUnit(1,UV[1],"CLoc106",P8);
                        TCreateUnit(1,UV[2],"CLoc106",P8);
                        TCreateUnit(1,UV[3],"CLoc106",P8);
                        TOrder(UV[1],P8,"CLoc106",Attack,"MB3");
                        TOrder(UV[2],P8,"CLoc106",Attack,"MB3");
                        TOrder(UV[3],P8,"CLoc106",Attack,"MB3");
                    })
                CIfEnd()

                CIf(FP,{NVar(MB_Shape,Exactly,21)})
                    DoActionsX(FP,{CreateUnit(1,84,"CLoc106",P5)})
                CIfEnd()
            CIfXEnd()
        CIfEnd() -- After SaveCache End
    CElseIfX{CDeathsX("X",Exactly,4*16777216,MB_Stage,0xFF000000)} -- MB4
        CIf(FP,{CDeathsX("X",Exactly,34*20*65536,PatternSW,0xFFFF0000)})
            CIfX(FP,{CVar("X",GMode,Exactly,1)})
                CDoActions(FP,{
                    TCreateUnit(1,UV[1],"CLoc106",P8);
                    TCreateUnit(1,UV[2],"CLoc106",P8);
                    TOrder(UV[1],P8,"CLoc106",Attack,"MB4");
                    TOrder(UV[2],P8,"CLoc106",Attack,"MB4");
                })
            CElseX() -- CVar("X",GMode,AtLeast,2)
                CDoActions(FP,{
                    TCreateUnit(1,UV[1],"CLoc106",P8);
                    TCreateUnit(1,UV[2],"CLoc106",P8);
                    TCreateUnit(1,UV[3],"CLoc106",P8);
                    TOrder(UV[1],P8,"CLoc106",Attack,"MB4");
                    TOrder(UV[2],P8,"CLoc106",Attack,"MB4");
                    TOrder(UV[3],P8,"CLoc106",Attack,"MB4");
                })
            CIfXEnd()
        CIfEnd()

        CIf(FP,{CDeathsX("X",Exactly,4,PatternSW,0xFF)}) -- 파훼실패시 사이드유닛소환
            CDoActions(FP,{
                    TCreateUnit(1,UV[1],"CLoc106",P8);
                    TCreateUnit(1,UV[2],"CLoc106",P8);
                    TCreateUnit(1,UV[3],"CLoc106",P8);
                    TOrder(UV[1],P8,"CLoc106",Attack,"MB4");
                    TOrder(UV[2],P8,"CLoc106",Attack,"MB4");
                    TOrder(UV[3],P8,"CLoc106",Attack,"MB4");
                })
        CIfEnd()

        CIf(FP,{NVar(MB_Shape,Exactly,25),CDeathsX("X",Exactly,5,PatternSW,0xFF),CVar("X",GMode,AtLeast,2)}) -- 파훼실패시 마엘 탄막
        	BulletImage2 = 366
	        BulletScript2 = 246 -- Unknown 395
	        BulletColor2 = 16
	        BulletInitSetting(FP,{197,122,283},92,199,493,BulletImage2,BulletScript2,BulletColor2,0,0,60,1,4,22,{64,64,64},0) -- 마엘
	        CreateBullet(FP,P8,197,20,0,0,1,"CLoc106")
        CIfEnd()

    CIfXEnd()
NIfEnd()
SetLabel(0x2004)
CJumpEnd(FP,0x401)

------<  CFunc  >---------------------------------------------
--[[
SetIgnoreTile = InitCFunc(FP)
CFunc(SetIgnoreTile)
    CMov(FP,0x6509B0,19025+55)
        CWhile(FP,{Memory(0x6509B0,AtMost,19025+55 + (84*1699))})
            Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0x40000,0,0x40000)},{SetDeathsX(CurrentPlayer,SetTo,0,0,0x40000)},{Preserved})
            CAdd(FP,0x6509B0,84)
        CWhileEnd()
    CMov(FP,0x6509B0,FP) -- RecoverCp
CFuncEnd()
]]--
NukeCBPlot = InitCFunc(FP)
CFunc(NukeCBPlot)
    MinDistance = 128*5
    -- X_Axis
    BaseX = CSMakeLine(2,128,90,15,0)
    NukeShapeA = CS_OverlapX(CS_MoveXY(BaseX,0,64),CS_MoveXY(BaseX,0,-64)) -- Hard ( MB1 )
    NukeShapeB = CS_OverlapX(CS_MoveXY(BaseX,0,64),CS_MoveXY(BaseX,0,-64)) -- Lunatic ( MB1 )
    NukeShapeC = CS_OverlapX(CS_MoveXY(BaseX,0,64),CS_MoveXY(BaseX,0,-64),BaseX) -- Hard ( MB2 )
    NukeShapeD = CS_OverlapX(CS_MoveXY(BaseX,0,64),CS_MoveXY(BaseX,0,-64),BaseX) -- Lunatic ( MB2 )
    -- Y_Axis
    BaseY = CS_MoveXY(CSMakeLine(2,256,0,27,0),0,-MinDistance)
    NukeShapeE = CS_OverlapX(CS_MoveXY(BaseY,-32,0),CS_MoveXY(BaseY,32,0)) -- Hard ( MB3 )
    NukeShapeF = CS_OverlapX(CS_MoveXY(BaseY,-64,0),CS_MoveXY(BaseY,64,0)) -- Lunatic ( MB3 )
    BaseZ1 = CS_MoveXY(CSMakeLine(2,144,45,21,0),0,-MinDistance)
    BaseZ2 = CS_Rotate(BaseZ1,135)
    NukeShapeG = CS_OverlapX(BaseZ1,BaseZ2) -- Hard ( MB4 )
    NukeShapeH = CS_OverlapX(CS_MoveXY(BaseX,0,-MinDistance),BaseZ1,BaseZ2) -- Lunatic ( MB4 )

    NukeShapeArr = {NukeShapeA,NukeShapeB,NukeShapeC,NukeShapeD,NukeShapeE,NukeShapeF,NukeShapeG,NukeShapeH}

    CIfX(FP,{NVar(NukeShape,AtMost,2)},{SetNVar(NukePosX,SetTo,1024)})
        f_Mul(FP,NukePosY,_Add(SaveJYDGunTimer,2),128)
    CElseIfX({NVar(NukeShape,AtLeast,3),NVar(NukeShape,AtMost,4)},{SetNVar(NukePosX,SetTo,1024)})
        f_Mul(FP,NukePosY,_Add(SaveJYDGunTimer,4),128) -- {Min = (128 ~ 512+128) // Max = (8192-128 ~ 8192-(512+128))}
    CElseIfX({NVar(NukeShape,AtLeast,5),NVar(NukeShape,AtMost,6)},{SetNVar(NukePosY,SetTo,4096)})
        CAdd(FP,NukePosX,_Mul(_Mod(SaveJYDGunTimer,17),96),256)
    CElseIfX({NVar(NukeShape,AtLeast,7),NVar(NukeShape,AtMost,8)},{SetNVar(NukePosX,SetTo,1024)})
        f_Mul(FP,NukePosY,_Add(SaveJYDGunTimer,2),128)
    CElseX({SetNVar(NukePosY,SetTo,4096)}) -- NukeShape 9 ~ 10
        
    CIfXEnd()
    DoActionsX(FP,{SetNVar(NukeDataIndex,SetTo,1)})
    -- CAPlot(NukeShapeArr,P8,193,"CLoc106",{NukePosX,NukePosY},1,32,
    --     {NukeShape,0,0,0,600,NukeDataIndex},nil,FP,nil,{SetNext("X",0x2001),SetNext(0x2002,"X",1)})
CFuncEnd()

CreateNuke = InitCFunc(FP)

CFunc(CreateNuke)
    CIf(FP,{Memory(0x628438,AtLeast,1)})
        f_Read(FP,0x628438,Nextptrs,NextEPD)
        CDoActions(FP,{
            CreateUnit(1,212,"HZ",P8);
            TSetMemoryX(Vi(NextEPD[2],35),SetTo,1,0xFF); -- 개별건작 세팅
            TSetMemoryX(Vi(NextEPD[2],55),SetTo,0x100,0x100); -- 스테이터스플래그 세팅
            TSetMemoryX(Vi(NextEPD[2],57),SetTo,2^5,0xFF); -- P6
            TSetMemoryX(Vi(NextEPD[2],68),SetTo,300,0xFFFF); -- 리무브타이머
            TSetMemoryX(Vi(NextEPD[2],70),SetTo,255*16777216,0xFF000000); -- Storm Timer ( GunTimer )
            TSetMemoryX(Vi(NextEPD[2],72),SetTo,255*256,0xFF00);
            TSetMemoryX(Vi(NextEPD[2],73),SetTo,(2^5)*256,0xFF00); -- Unused Timer
        })
        f_Read(FP,_Add(NextEPD,10),NukePosXY) -- 공격지점 저장
        f_Read(FP,0x628438,nil,NextEPD)
            CDoActions(FP,{
                CreateUnit(1,14,"HZ",P8);
                TSetMemory(Vi(NextEPD[2],32),SetTo,Nextptrs); -- 연결유닛
                TSetMemoryX(Vi(NextEPD[2],19),SetTo,125*256,0xFF00); -- 오더ID 핵공격
                TSetMemory(Vi(NextEPD[2],22),SetTo,NukePosXY); -- 핵쏠위치 지정
            })
    CIfEnd()
CFuncEnd()

MBShapeArr = {YCircleA1,YCircleA2,YCircleB1,YCircleB2,YCircleC1,YCircleC2,EnergyShapeA,EnergyShapeB,MB2_CircleA,MB2_CircleB,
    MB3_Circle,RetSH(MB3_Circle),RetSH(MB3_Circle),MB3_SquareA,MB3_SquareB,MB3_SquareC,MB3_SquareD,MB3_Side,MB3_SideC,MB3_SideD,MB3_PatternPass,
    MB4_StarX1,MB4_StarX2,MB4_Square,MB4_BulletSH
}

MB_CBPlot = InitCFunc(FP)
CFunc(MB_CBPlot)
    CBPlot(MBShapeArr,nil,P8,193,"CLoc106",{MBLocX,MBLocY},1,32,
        {MB_Shape,0,0,0,MB_LoopMax,MB_DataIndex},"MB_CAFunc","MB_CBFunc",FP,nil,{SetNext("X",0x2003),SetNext(0x2004,"X",1)})
CFuncEnd()

CheckWarpPlayer = InitCFunc(FP)
CFunc(CheckWarpPlayer)
for i = 0, 4 do
	TriggerX(FP,{Kills(i,AtLeast,1,189)},{
		SetNVar(VFlag,SetTo,2^i);
		SetNVar(VFlag256,SetTo,(2^i)*256);
		SetKills(i,SetTo,0,189);
	},{Preserved})
end
CFuncEnd()

------<  MBoss1  >---------------------------------------------
-- 체력비례 무기변경, 광범위탄막, 에너지풀일때 즉사기
MB1_VFlag, MB1_VFlag256 = CreateVars(2,FP)

CIf(FP,{Bring(P8,Exactly,0,189,"MB1"),CDeaths("X",Exactly,0,MB1_SW)})

CallCFuncX(FP,CheckWarpPlayer)
SetMB_VFlags(MB1_VFlag,MB1_VFlag256)

TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(WarpTxt,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,66666,Kills);
        SetNVar(BGMVar[1],SetTo,15);
        SetNVar(BGMVar[2],SetTo,15);
        SetNVar(BGMVar[3],SetTo,15);
        SetNVar(BGMVar[4],SetTo,15);
        SetNVar(BGMVar[5],SetTo,15);
        SetNVar(OB_BGMVar,SetTo,15);
        SetCDeaths("X",SetTo,34*16,MB_WaitTimer);
        SetCDeaths("X",SetTo,2,MB_HP); -- 800m + 700m * 2
        SetCDeathsX("X",SetTo,1*16777216,MB_Stage,0xFF000000); -- BossNumber
})
CIf(FP,{CDeaths("X",Exactly,0,MB_WaitTimer)},{SetSpriteImage(309,422)})

TriggerX(FP,{},{
    SetNVar(MBLocX,SetTo,1024);
    SetNVar(MBLocY,SetTo,6832);
    SetNVar(MB_LoopMax,SetTo,600);
    GiveUnits(1,89,P12,"MB1",P8);
    SetInvincibility(Disable, 89, P8, "MB1");
    CopyCpAction({DisplayTextX(MB1Txt,4),MinimapPing("MB1"),
        PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
})

WeaponArr = {86,87,88}
LeftHP = {2,1,0}

for i = 1, 3 do
    TriggerX(FP,{CDeaths("X",Exactly,LeftHP[i],MB_HP)},{SetNVar(WeaponV,SetTo,WeaponArr[i])},{Preserved})
end

CTrigger(FP,{ -- Reset HP
    TMemory(Vi(MB1_EPD[2],2),AtMost,1000000*256);
    CDeaths("X",AtLeast,1,MB_HP);
 },{
       TSetMemory(Vi(MB1_EPD[2],2),SetTo,256*4000000);
       TSetMemoryB(0x6636B8,89,SetTo,WeaponV);
       SetCDeaths("X",Subtract,1,MB_HP);
       SetCDeathsX("X",Add,1*65536,MB_Stage,0xFF0000);
 },{Preserved})

CTrigger(FP,{ -- 보스 개별건작 적용
    CVar("X",GMode,AtLeast,2);
},{
    TSetMemory(Vi(MB1_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB1_EPD[2],55),SetTo,0x100,0x100);
    TSetMemoryX(Vi(MB1_EPD[2],57),SetTo,MB1_VFlag,0xFF); -- Visibility State
    TSetMemoryX(Vi(MB1_EPD[2],70),SetTo,255*16777216,0xFF000000); -- Storm Timer ( GunTimer )
    TSetMemoryX(Vi(MB1_EPD[2],73),SetTo,MB1_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
    TSetMemoryX(Vi(MB1_EPD[2],35),SetTo,1,0xFF);
    TSetMemoryX(Vi(MB1_EPD[2],35),SetTo,1*256,0xFF00);
    TSetMemoryX(Vi(MB1_EPD[2],72),SetTo,255*256,0xFF00);
    TSetMemoryX(Vi(MB1_EPD[2],72),SetTo,255*16777216,0xFF000000);
})

    CIfX(FP,{CVar("X",GMode,Exactly,1)})
        CTrigger(FP,{TMemoryX(Vi(MB1_EPD[2],19),AtLeast,1*256,0xFF00)},{
            TSetMemory(Vi(MB1_EPD[2],13),SetTo,0); -- MaxSpeed
            TSetMemoryX(Vi(MB1_EPD[2],72),SetTo,255*256,0xFF00); -- Parasite
        })
        CIfX(FP,{CDeathsX("X",Exactly,0,MB1_STimer,0xFF)},{SetCDeathsX("X",SetTo,34*6,MB1_STimer,0xFF)})
            DoActionsX(FP,{
                SetNVar(MB_Shape,SetTo,1);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,156*256);
                SetImageColor(542,9);SetImageColor(544,9);SetBulletDamage(92,SetTo,2500);
                SetCDeathsX("X",Subtract,1*65536,MB_Stage,0xFF0000);
            })
            CallCFuncX(FP,MB_CBPlot)
        CElseIfX({CDeathsX("X",Exactly,34*3,MB1_STimer,0xFF)})
            DoActionsX(FP,{
                SetNVar(MB_Shape,SetTo,2);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,100*256);
                SetImageColor(542,16);SetImageColor(544,16);SetBulletDamage(92,SetTo,3500);
                SetCDeathsX("X",Subtract,1*65536,MB_Stage,0xFF0000);
            })
            CallCFuncX(FP,MB_CBPlot)
        CIfXEnd()
    CElseIfX({CVar("X",GMode,Exactly,2)},{SetNVar(NukeShape,SetTo,1)})

        CIf(FP,{CDeathsX("X",Exactly,0,MB1_STimer,0xFF)},{SetCDeathsX("X",SetTo,34*2,MB1_STimer,0xFF)})
            DoActionsX(FP,{ -- MB1 Skill
                SetNVar(MB_Shape,SetTo,3);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,156*256);
                SetImageColor(542,9);SetImageColor(544,9);SetBulletDamage(92,SetTo,5000);
            })
            CallCFuncX(FP,MB_CBPlot)
        CIfEnd()
        CIf(FP,{NVar(CurEnergy,Exactly,25)}) -- Energy 255
            DoActionsX(FP,{ -- Fatal Skill
                SetNVar(MB_Shape,SetTo,4);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,100*256);
                SetImageColor(542,16);SetImageColor(544,16);SetBulletDamage(92,SetTo,9000);
                SetCDeathsX("X",Subtract,1*65536,MB_Stage,0xFF0000);SetNVar(CurEnergy,SetTo,0);
                SetCDeathsX("X",SetTo,5*34*256,MB1_STimer,0xFF00);
            })
            CallCFuncX(FP,MB_CBPlot)
        CIfEnd()

        DoActionsX(FP,{SetSpriteImage(385,509),SetImageScript(509,131),SetNVar(MB_Shape,SetTo,7),SetNVar(MB_DataIndex,SetTo,1)})
        CallCFuncX(FP,MB_CBPlot)
        DoActions(FP,{SetImageScript(509,260),SetImageColor(509,9)})

    CElseX({SetNVar(NukeShape,SetTo,2)}) -- Lunatic

        CIf(FP,{CDeathsX("X",Exactly,0,MB1_STimer,0xFF)},{SetCDeathsX("X",SetTo,34*1,MB1_STimer,0xFF)})
            DoActionsX(FP,{ -- MB1 Skill
                SetNVar(MB_Shape,SetTo,5);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,156*256);
                SetImageColor(542,9);SetImageColor(544,9);SetBulletDamage(92,SetTo,6500);
            })
            CallCFuncX(FP,MB_CBPlot)
        CIfEnd()

        CIf(FP,{TTOR({NVar(CurEnergy,Exactly,20),CDeathsX("X",Exactly,1*65536,MB_Stage,0xFF0000)})})-- Case1 : EnergyMax // Case2 : HP_Reset
            DoActionsX(FP,{ -- Fatal Skill
                SetNVar(MB_Shape,SetTo,6);SetNVar(MB_DataIndex,SetTo,1);SetNVar(MB_BulletAngle,SetTo,100*256);
                SetImageColor(542,16);SetImageColor(544,16);SetBulletDamage(92,SetTo,50000);
                SetCDeathsX("X",Subtract,1*65536,MB_Stage,0xFF0000);SetNVar(CurEnergy,SetTo,0);
                SetCDeathsX("X",SetTo,5*34*256,MB1_STimer,0xFF00);
            })
            CallCFuncX(FP,MB_CBPlot)
        CIfEnd()

        DoActionsX(FP,{SetSpriteImage(385,509),SetImageScript(509,131),SetNVar(MB_Shape,SetTo,8),SetNVar(MB_DataIndex,SetTo,1)})
        CallCFuncX(FP,MB_CBPlot)
        DoActions(FP,{SetImageScript(509,260),SetImageColor(509,9)})
    CIfXEnd()
CIfOnce(FP)
    CIf(FP,{CVar("X",GMode,AtLeast,2)})
        CallCFuncX(FP,NukeCBPlot) -- Y축 실시간위치변경 워프 뉴클리어
    CIfEnd()
    CallCFuncX(FP,CreateNuke) -- 기지 고정 뉴클리어
CIfEnd()
-- MB_Stage :: 0xFF0000 = Fatal
-- MB1_STimer :: 0xFF = MB1_SkillTimer // 0xFF00 = EnergyTimer // 0xFF0000 = Wait SkillTimer // 0xFF000000 = Energy
CIf(FP,{CVar("X",GMode,AtLeast,2)})
    TriggerX(FP,{
        CDeathsX("X",Exactly,0*16777216,MB1_STimer,0xFF000000);
        CDeathsX("X",Exactly,0*256,MB1_STimer,0xFF00);
    },{
        SetCDeathsX("X",SetTo,34*16777216,MB1_STimer,0xFF000000);
        SetNVar(CurEnergy,Add,1)},{Preserved})

    TriggerX(FP,{CVar("X",GMode,Exactly,2),NVar(CurEnergy,Exactly,24)},{SetCDeathsX("X",SetTo,3*34*65536,MB1_STimer,0xFF0000)},{Preserved})
    TriggerX(FP,{CVar("X",GMode,Exactly,3),NVar(CurEnergy,Exactly,19)},{SetCDeathsX("X",SetTo,3*34*65536,MB1_STimer,0xFF0000)},{Preserved})
    TriggerX(FP,{CDeathsX("X",Exactly,0*65536,MB1_STimer,0xFF0000)},{
        SetCDeathsX("X",Subtract,1,MB1_STimer,0xFF)},{Preserved}) -- FatalPattern아닐때 스킬타이머감소
    CTrigger(FP,{TMemoryX(Vi(MB1_EPD[2],19),AtLeast,1*256,0xFF00)},{TSetMemoryX(Vi(MB1_EPD[2],55),SetTo,0,0x40000)},{Preserved})-- Ignore Tile Collision
CIfEnd()

--CallCFuncX(FP,SetIgnoreTile) -- 이팩트 충돌무시

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetCDeathsX("X",Subtract,1,MB1_STimer,0xFF)},{Preserved})
DoActionsX(FP,{
    SetCDeathsX("X",Subtract,1*256,MB1_STimer,0xFF00);
    SetCDeathsX("X",Subtract,1*65536,MB1_STimer,0xFF0000);
    SetCDeathsX("X",Subtract,1*16777216,MB1_STimer,0xFF000000);
})
CIfEnd() -- 보스 활성화 단락

TriggerX(FP,{Deaths(P8,Exactly,1,89),CDeaths("X",Exactly,0,MB_WaitTimer)},{
    SetCDeaths("X",SetTo,1,MB1_SW);
    SetCDeaths("X",SetTo,0,MB_Stage);
    SetCDeathsX("X",Add,1*16777216,BossClearCheck,0xFF000000);
    SetDeaths(P8,SetTo,0,89);
    SetSpriteImage(309,318);
    SetImageColor(542,16);SetImageColor(544,16); -- Recover Color
    SetScore(Force1,Add,200000,Kills);
    SetScore(Force1,Subtract,10,Custom); -- 데카감소
    SetInvincibility(Disable,189,P8,"MB2");
    CopyCpAction({DisplayTextX(ClearMB1Txt,4),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")
    ,PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")},{Force1,Force5},FP);
})
DoActionsX(FP,{SetCDeaths("X",Subtract,1,MB_WaitTimer)})

CIfEnd() -- MB1 end


------<  MBoss2  >---------------------------------------------
-- 랜덤장판탄막, 비비기, 광범위보스평타
MB_BulletPosX, MB_BulletPosY, BulletCount = CreateVars(3,FP)

CIf(FP,{Bring(P8,Exactly,0,189,"MB2"),CDeaths("X",Exactly,0,MB2_SW)})

CallCFuncX(FP,CheckWarpPlayer)
SetMB_VFlags(MB2_VFlag,MB2_VFlag256)

TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(WarpTxt,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,66666,Kills);
        SetNVar(BGMVar[1],SetTo,15);
        SetNVar(BGMVar[2],SetTo,15);
        SetNVar(BGMVar[3],SetTo,15);
        SetNVar(BGMVar[4],SetTo,15);
        SetNVar(BGMVar[5],SetTo,15);
        SetNVar(OB_BGMVar,SetTo,15);
        SetCDeaths("X",SetTo,34*16,MB_WaitTimer);
        SetCDeaths("X",SetTo,2,MB_HP); -- 보스 피통리젠횟수 ( 800m + 700m * 2 )
        SetCDeathsX("X",SetTo,2*16777216,MB_Stage,0xFF000000); -- BossNumber
})
CIf(FP,{CDeaths("X",Exactly,0,MB_WaitTimer)},{SetSpriteImage(309,422)}) -- 핵미사일엔진 이미지 변경

TriggerX(FP,{},{
    SetNVar(MBLocX,SetTo,1024);
    SetNVar(MBLocY,SetTo,5792);
    SetNVar(MB_LoopMax,SetTo,1);
    SetKillScore(103,0);
    SetKillScore(37,0);
    SetKillScore(38,0);
    GiveUnits(1,57,P12,"MB2",P8);
    SetInvincibility(Disable, 57, P8, "MB2");
    CopyCpAction({DisplayTextX(MB2Txt,4),MinimapPing("MB2"),
        PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
})

CTrigger(FP,{ -- Reset HP
    TMemory(Vi(MB2_EPD[2],2),AtMost,1000000*256);
    CDeaths("X",AtLeast,1,MB_HP);
 },{
       TSetMemory(Vi(MB2_EPD[2],2),SetTo,256*4000000);
       SetNVar(BulletCount,Add,4*1);
       SetCDeathsX("X",SetTo,1*65536,MB_Stage,0xFF0000);
       SetCDeaths("X",Subtract,1,MB_HP);
 },{Preserved})

CTrigger(FP,{
    TMemoryX(Vi(MB2_EPD[2],19),AtLeast,1*256,0xFF00);
    CVar("X",GMode,Exactly,1);
},{
    TSetMemory(Vi(MB2_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB2_EPD[2],72),SetTo,255*256,0xFF00); -- Parasite
})

CTrigger(FP,{ -- 보스 개별건작 적용
    CVar("X",GMode,AtLeast,2);
},{
    TSetMemory(Vi(MB2_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB2_EPD[2],55),SetTo,0x100,0x100);
    TSetMemoryX(Vi(MB2_EPD[2],57),SetTo,MB2_VFlag,0xFF); -- Visibility State
    TSetMemoryX(Vi(MB2_EPD[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
    TSetMemoryX(Vi(MB2_EPD[2],73),SetTo,MB2_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
    TSetMemoryX(Vi(MB2_EPD[2],35),SetTo,1,0xFF);
    TSetMemoryX(Vi(MB2_EPD[2],35),SetTo,1*256,0xFF00);
    TSetMemoryX(Vi(MB2_EPD[2],72),SetTo,255*256,0xFF00);
    TSetMemoryX(Vi(MB2_EPD[2],72),SetTo,255*16777216,0xFF000000);
})

BulletImage2 = 912
BulletScript2 = 242
BulletColor2 = 0
BulletInitSetting(FP,{197,122,283},92,199,493,BulletImage2,BulletScript2,BulletColor2,50000,0,7,1,3,3,{48,48,48},0)

CIfX(FP,{CVar("X",GMode,Exactly,1)})
    DoActionsX(FP,{SetNVar(BulletCount,SetTo,3*4)}) -- Set BulletCount
CElseIfX({CVar("X",GMode,Exactly,2)},{SetNVar(NukeShape,SetTo,3)})
    TriggerX(FP,{},{SetNVar(BulletCount,SetTo,4*4),SetNVar(MB_TUnit,SetTo,69)}) -- Init BulletCount / TUnit
        CIf(FP,{CDeathsX("X",Exactly,1*65536,MB_Stage,0xFF0000)})
            DoActionsX(FP,{SetNVar(MB_DataIndex,Add,1),SetNVar(MB_Shape,SetTo,9)})
            CallCFuncX(FP,MB_CBPlot)
            TriggerX(FP,{NVar(MB_DataIndex,AtLeast,24+1)},{SetNVar(MB_DataIndex,SetTo,0),SetCDeathsX("X",SetTo,0*65536,MB_Stage,0xFF0000)},{Preserved})
        CIfEnd()
CElseX({SetNVar(NukeShape,SetTo,4)}) -- CVar("X",GMode,Exactly,3)
    TriggerX(FP,{},{SetNVar(BulletCount,SetTo,4*6),SetNVar(MB_TUnit,SetTo,30)}) -- Init BulletCount / TUnit
        CIf(FP,{CDeathsX("X",Exactly,1*65536,MB_Stage,0xFF0000)})
            DoActionsX(FP,{SetNVar(MB_DataIndex,Add,1),SetNVar(MB_Shape,SetTo,10)})
            CallCFuncX(FP,MB_CBPlot)
            TriggerX(FP,{NVar(MB_DataIndex,AtLeast,36+1)},{SetNVar(MB_DataIndex,SetTo,0),SetCDeathsX("X",SetTo,0*65536,MB_Stage,0xFF0000)},{Preserved})
        CIfEnd()
CIfXEnd()

CIf(FP,{CDeathsX("X",Exactly,0,MB2_STimer,0xFFFF)},{SetCDeathsX("X",SetTo,255+34*2,MB2_STimer,0xFFFF)})
    DoActions(FP,{RemoveUnitAt(all,37,"MB2",P8),RemoveUnitAt(all,38,"MB2",P8),RemoveUnitAt(all,103,"MB2",P8)})
    SLoopN(FP,{BulletCount,8})
		CDoActions(FP,{
			TSetNVar(MB_BulletPosX,SetTo,_Add(_Mod(_Rand(),512),768)); -- Range_X : 768 ~ 768+511
			TSetNVar(MB_BulletPosY,SetTo,_Add(_Mod(_Rand(),384),5632)); -- Range_Y : 5632 ~ 5632+383
		})
		Simple_SetLocX(FP,"CLoc106",_Sub(MB_BulletPosX,32),_Sub(MB_BulletPosY,32),_Add(MB_BulletPosX,32),_Add(MB_BulletPosY,32))
        CIf(FP,{Memory(0x628438,AtLeast,1)})
		    CreateBullet(FP,P8,197,12,0,0,255,"CLoc106")
        CIfEnd()
        CIf(FP,{CVar("X",GMode,AtLeast,2)})
            SetNextptr()
                CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
                    SetMemoryB(0x663150+25,SetTo,12); --  Height
                    SetMemoryX(0x664080+25*4,SetTo,0x4,0x4); -- Set AirUnit
                    TCreateUnit(1,MB_TUnit,"CLoc106",P8);
                    TSetMemory(Vi(Nextptr[2],13),SetTo,0); -- MaxSpeed
                    TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
                    TSetMemoryX(Vi(Nextptr[2],57),SetTo,MB2_VFlag,0xFF); -- Visibility State
                    TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
                    TSetMemoryX(Vi(Nextptr[2],73),SetTo,MB2_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
                    TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
                    TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
                    TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
                    TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
                    SetMemoryB(0x663150+25,SetTo,4); -- Recover
                    SetMemoryX(0x664080+25*4,SetTo,0,0x4); -- Recover
                },{Preserved})
        CIfEnd()
        DoActions(FP,{
            SetSpriteImage(159,17); -- 저글링 이미지변경
            SetImageScript(17,31); -- 드론 - > 저글링
            CreateBurrowedUnit(12,37,"CLoc106",P8);
            SetSpriteImage(146,17); -- 히드라 이미지변경
            SetImageScript(17,18); -- 드론 -> 히드라
            CreateBurrowedUnit(12,38,"CLoc106",P8);
            CreateBurrowedUnit(12,103,"CLoc106",P8);
            SetSpriteImage(146,29); -- 히드라 복구
            SetSpriteImage(159,54); -- 저글링 복구
            SetImageScript(17,11); -- 드론 스크립트 복구
            Order(37,P8,"CLoc106",Move,"MB2");
            Order(38,P8,"CLoc106",Move,"MB2");
            Order(103,P8,"CLoc106",Move,"MB2");
        })
	SLoopNEnd()
CIfEnd()

CIfOnce(FP)
    CIf(FP,{CVar("X",GMode,AtLeast,2)})
        CallCFuncX(FP,NukeCBPlot) -- Y축 실시간위치변경 워프 뉴클리어
    CIfEnd()
    CallCFuncX(FP,CreateNuke) -- 기지 고정 뉴클리어
CIfEnd()
Trigger2X(FP,{Deaths(P8,Exactly,1,57),CDeaths("X",Exactly,0,MB_WaitTimer)},{
    SetCDeaths("X",SetTo,1,MB2_SW);
    SetCDeathsX("X",Add,1*16777216,BossClearCheck,0xFF000000);
    SetDeaths(P8,SetTo,0,57);
    SetSpriteImage(309,318);
    SetKillScore(103,500);
    SetKillScore(37,50);
    SetKillScore(38,350);
    SetMemoryB(0x58CF44+24*0+19,SetTo,1); -- 영마바로뽑기 해금
    SetMemoryB(0x58CF44+24*1+19,SetTo,1); -- 영마바로뽑기 해금
    SetMemoryB(0x58CF44+24*2+19,SetTo,1); -- 영마바로뽑기 해금
    SetMemoryB(0x58CF44+24*3+19,SetTo,1); -- 영마바로뽑기 해금
    SetMemoryB(0x58CF44+24*4+19,SetTo,1); -- 영마바로뽑기 해금
    SetScore(Force1,Add,400000,Kills);
    SetScore(Force1,Subtract,10,Custom); -- 데카감소
    SetInvincibility(Disable,189,P8,"MB3");
    CopyCpAction({DisplayTextX(ClearMB2Txt,4),PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")
    ,PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")},{Force1,Force5},FP);
})
DoActionsX(FP,{SetCDeathsX("X",Subtract,1,MB2_STimer,0xFFFF)})
CIfEnd() -- 보스 활성화 단락

DoActionsX(FP,{SetCDeaths("X",Subtract,1,MB_WaitTimer)})

CIfEnd() -- MB2 End

------<  MBoss3  >---------------------------------------------
-- 딜측정보스 // 패턴활성화시 체력비례,반비례따른 패턴(미네랄감소, 탄막생성수 증가)

PreMB3_HP, CheckMB3_HP, TempCA1, TempCA5, TempCA6 = CreateVars(5,FP)
ClearPattern = CreateCcode()

CIf(FP,{Bring(P8,Exactly,0,189,"MB3"),CDeaths("X",Exactly,0,MB3_SW)})

CallCFuncX(FP,CheckWarpPlayer)
SetMB_VFlags(MB3_VFlag,MB3_VFlag256)

TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(WarpTxt,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,66666,Kills);
        SetNVar(BGMVar[1],SetTo,15);
        SetNVar(BGMVar[2],SetTo,15);
        SetNVar(BGMVar[3],SetTo,15);
        SetNVar(BGMVar[4],SetTo,15);
        SetNVar(BGMVar[5],SetTo,15);
        SetNVar(OB_BGMVar,SetTo,15);
        SetCDeaths("X",SetTo,34*16,MB_WaitTimer);
        SetCDeaths("X",SetTo,3,MB_HP); -- 보스 피통리젠횟수 ( 400m + 300m * 2 )
        SetCDeathsX("X",SetTo,3*16777216,MB_Stage,0xFF000000); -- BossNumber
})

CIf(FP,{CDeaths("X",Exactly,0,MB3Cache)},{SetNVar(MB_Shape,SetTo,13),SetNVar(MB_DataIndex,SetTo,1),SetNVar(MB_LoopMax,SetTo,600)}) -- 캐시메모리 저장
    CallCFuncX(FP,MB_CBPlot) -- MBRatio 초기값 1
    TriggerX(FP,{NVar(MB_VTimeLine,AtMost,63)},{SetNVar(AngleXY,Add,8),SetNVar(MBRatio,Add,16)},{Preserved})
    TriggerX(FP,{NVar(MB_VTimeLine,AtLeast,64)},{SetNVar(AngleXY,Add,8),SetNVar(MBRatio,Subtract,16)},{Preserved})
    DoActionsX(FP,{SetNVar(MB_VTimeLine,Add,1)})
    TriggerX(FP,{NVar(MB_VTimeLine,Exactly,128)},{SetNVar(MB_VTimeLine,SetTo,0),SetCDeaths("X",SetTo,1,MB3Cache)}) -- LockSaveCache
CIfEnd()

CIf(FP,{CDeaths("X",Exactly,0,MB_WaitTimer)},{SetSpriteImage(309,422)}) -- 핵미사일엔진 이미지 변경

TriggerX(FP,{},{
    SetNVar(MBLocX,SetTo,1024);
    SetNVar(MBLocY,SetTo,4240);
    SetNVar(MB_LoopMax,SetTo,600);
    GiveUnits(1,96,P12,"MB3",P8);
    SetInvincibility(Disable, 96, P8, "MB3");
    CopyCpAction({DisplayTextX(MB3Txt,4),MinimapPing("MB3"),
        PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
})

CTrigger(FP,{ -- Reset HP
    TMemory(Vi(MB3_EPD[2],2),AtMost,1000000*256);
    CDeaths("X",AtLeast,1,MB_HP);
 },{
       TSetMemory(Vi(MB3_EPD[2],2),SetTo,256*4000000);
       SetCDeathsX("X",SetTo,1*65536,MB_Stage,0xFF0000); -- 체력리젠시 추가패턴
       SetCDeaths("X",Subtract,1,MB_HP);
 },{Preserved})

CTrigger(FP,{
    TMemoryX(Vi(MB3_EPD[2],19),AtLeast,1*256,0xFF00);
    CVar("X",GMode,Exactly,1);
},{
    TSetMemory(Vi(MB3_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB3_EPD[2],72),SetTo,255*256,0xFF00); -- Parasite
})

CTrigger(FP,{ -- 보스 개별건작 적용
    CVar("X",GMode,AtLeast,2);
},{
    TSetMemory(Vi(MB3_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB3_EPD[2],55),SetTo,0x100,0x100); -- Require Detection
    TSetMemoryX(Vi(MB3_EPD[2],57),SetTo,MB3_VFlag,0xFF); -- Visibility State
    TSetMemoryX(Vi(MB3_EPD[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
    TSetMemoryX(Vi(MB3_EPD[2],73),SetTo,MB3_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
    TSetMemoryX(Vi(MB3_EPD[2],35),SetTo,1,0xFF);
    TSetMemoryX(Vi(MB3_EPD[2],35),SetTo,1*256,0xFF00); -- Individual Pointer
    TSetMemoryX(Vi(MB3_EPD[2],72),SetTo,255*256,0xFF00); -- Vision
    TSetMemoryX(Vi(MB3_EPD[2],72),SetTo,255*16777216,0xFF000000); -- Individual TBL ( Blind State )
})

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(NukeShape,SetTo,5)})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(NukeShape,SetTo,6)})

CIf(FP,{CVar("X",GMode,AtLeast,2),CDeathsX("X",Exactly,1*65536,MB_Stage,0xFF0000)})
    DoActionsX(FP,{SetNVar(MB_Shape,SetTo,18),SetNVar(MB_DataIndex,SetTo,1),SetNVar(MB_LoopMax,SetTo,600)})
    TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(UV[1],SetTo,8),SetNVar(UV[2],SetTo,3),SetNVar(UV[3],SetTo,5)},{Preserved})
    TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(UV[1],SetTo,102),SetNVar(UV[2],SetTo,2),SetNVar(UV[3],SetTo,16)},{Preserved})
    CallCFuncX(FP,MB_CBPlot)
    DoActionsX(FP,{SetCDeathsX("X",SetTo,0*65536,MB_Stage,0xFF0000)})
CIfEnd()

-- PatternSW = 0xFF : 랜덤패턴설정스위치

CIfX(FP,{CVar("X",GMode,Exactly,1)}) -- 노말

CIf(FP,{CDeathsX("X",Exactly,0,MB3_STimer,0xFFFF)})
    TriggerX(FP,{CDeathsX("X",Exactly,0,PatternSW,0xFF)},{SetNVar(MB_Shape,SetTo,19),SetNVar(MB_LoopMax,SetTo,2),SetNVar(MB_DataIndex,Add,2)},{Preserved})
    TriggerX(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)},{SetNVar(MB_Shape,SetTo,20),SetNVar(MB_LoopMax,SetTo,2),SetNVar(MB_DataIndex,Add,2)},{Preserved})
    CallCFuncX(FP,MB_CBPlot)
    TriggerX(FP,{NVar(MB_DataIndex,AtLeast,128)},{
        SetCDeathsX("X",SetTo,34*10,MB3_STimer,0xFFFF),SetNVar(MB_DataIndex,SetTo,0),SetCDeathsX("X",Add,1,PatternSW,0xFF)},{Preserved})
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,2,PatternSW,0xFF)})
SetLocCenter("MB3","CLoc76")
DoActionsX(FP,{
    Simple_CalcLoc("CLoc76",-512,-512,512,512);
    SetCDeathsX("X",SetTo,0,PatternSW,0xFF);
    Order(70,Force2,"CLoc76",Attack,"MB3");
    Order(77,Force2,"CLoc76",Attack,"MB3");
    Order(78,Force2,"CLoc76",Attack,"MB3");
})
CIfEnd()

CElseX() -- 하드이상

CIf(FP,{CDeathsX("X",Exactly,0,PatternSW,0xFF),CDeathsX("X",Exactly,0,MB3_STimer,0xFFFF)},
    {SetCDeathsX("X",SetTo,1,PatternSW,0xFF),SetCDeaths("X",SetTo,0,ClearPattern)}) -- 패턴 랜덤설정
    f_Mod(FP,RandPattern,_Rand(),4)
    TriggerX(FP,{NVar(RandPattern,Exactly,0)},{SetImageColor(214,10)},{Preserved}) -- 검
    TriggerX(FP,{NVar(RandPattern,Exactly,1)},{SetImageColor(214,17)},{Preserved}) -- 흰
    TriggerX(FP,{NVar(RandPattern,Exactly,2)},{SetImageColor(214,13)},{Preserved}) -- 초
    TriggerX(FP,{NVar(RandPattern,Exactly,3)},{SetImageColor(214,16)},{Preserved}) -- 파
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)},{SetNVar(MB_Shape,SetTo,13),SetNVar(MB_DataIndex,SetTo,0),SetNVar(MB_LoopMax,SetTo,600)}) -- 예고이팩트
--Stage1
    CallCFuncX(FP,MB_CBPlot)
    DoActionsX(FP,{SetNVar(MB_VTimeLine,Add,1)})
    TriggerX(FP,{NVar(MB_VTimeLine,AtLeast,128)},{SetNVar(MB_VTimeLine,SetTo,0),SetCDeathsX("X",SetTo,2,PatternSW,0xFF)},{Preserved})
CIfEnd()

CTrigger(FP,{ -- 패턴예고이팩트후 현재체력저장 & 측정체력세팅
    CDeathsX("X",Exactly,2,PatternSW,0xFF); -- Stage2
    CDeathsX("X",Exactly,0,MB3_STimer,0xFFFF)
},{
    TSetNVar(PreMB3_HP,SetTo,_Read(_Add(MB3_EPD,2)));
    TSetMemory(Vi(MB3_EPD[2],2),SetTo,256*8000000); -- 측정체력을 현재체력으로 저장
    SetCDeathsX("X",SetTo,3,PatternSW,0xFF);
    SetCDeathsX("X",SetTo,34*6,MB3_STimer,0xFFFF); -- 6초동안 딜 측정
    SetImageColor(214,9);
},{Preserved})

CTrigger(FP,{ -- 최대측정딜700만 오버플로우방지
    TMemory(Vi(MB3_EPD[2],2),AtMost,999999);
    CDeathsX("X",Exactly,3,PatternSW,0xFF); -- Stage3
    CDeathsX("X",AtLeast,1,MB3_STimer,0xFFFF);
},{
    TSetMemory(Vi(MB3_EPD[2],2),SetTo,1200000);
},{Preserved})

CIf(FP,{CDeathsX("X",Exactly,3,PatternSW,0xFF),CDeathsX("X",Exactly,0,MB3_STimer,0xFFFF)},{SetCDeathsX("X",SetTo,4,PatternSW,0xFF)}) -- 딜측정타이머 0일때
    CSub(FP,CheckMB3_HP,_Mov(256*8000000),_Read(_Add(MB3_EPD,2)))  -- 6초동안 넣은 딜 저장
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,4,PatternSW,0xFF)},{SetCDeathsX("X",SetTo,5,PatternSW,0xFF)})
    CDoActions(FP,{TSetMemory(Vi(MB3_EPD[2],2),SetTo,PreMB3_HP)}) -- 현재체력을 저장체력으로 변경

-- 도형데이터 // 루프리미트 // 데이터인덱스초기화 세팅
   CIfX(FP,{NVar(RandPattern,Exactly,0)}) -- 비례 ( 검 ) 자원몰수 + 강유닛소환 ( 딜X )
            CTrigger(FP,{CVar("X",GMode,Exactly,2),NVar(CheckMB3_HP,AtLeast,256*100000)},{ -- Min 100000
                TSetResources(Force1,Subtract,CheckMB3_HP,Ore);
                SetNVar(TempCA1,SetTo,14); -- Descending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,1); -- Shape 8*8
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
            CTrigger(FP,{CVar("X",GMode,Exactly,3),NVar(CheckMB3_HP,AtLeast,256*50000)},{ -- Min 50000
                TSetResources(Force1,Subtract,_Mul(CheckMB3_HP,2),Ore);
                SetNVar(TempCA1,SetTo,15); -- Ascending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,2); -- Shape 12*12
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
        
        CElseIfX({NVar(RandPattern,Exactly,1)}) -- 반비례 ( 흰 ) 자원몰수 + 강유닛소환 ( 딜O )
            CTrigger(FP,{CVar("X",GMode,Exactly,2),NVar(CheckMB3_HP,AtMost,256*200000)},{ -- Max 200000
                TSetResources(Force1,Subtract,CheckMB3_HP,Ore);
                SetNVar(TempCA1,SetTo,16); -- Ascending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,1); -- Shape 8*8
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
            CTrigger(FP,{CVar("X",GMode,Exactly,3),NVar(CheckMB3_HP,AtMost,256*400000)},{ -- Max 400000
                TSetResources(Force1,Subtract,CheckMB3_HP,Ore);
                SetNVar(TempCA1,SetTo,17); -- Descending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,2); -- Shape 12*12
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
        
        CElseIfX({NVar(RandPattern,Exactly,2)}) -- 비례 ( 초 ) 즉사불릿생성 ( 딜 X )
            CTrigger(FP,{CVar("X",GMode,Exactly,2),NVar(CheckMB3_HP,AtLeast,256*125000)},{
                TSetNVar(DamagePerHP,SetTo,_Div(CheckMB3_HP,256*50));
                SetNVar(TempCA1,SetTo,14);
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,1);
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
            CTrigger(FP,{CVar("X",GMode,Exactly,3),NVar(CheckMB3_HP,AtLeast,256*75000)},{
                TSetNVar(DamagePerHP,SetTo,_Div(CheckMB3_HP,256*25));
                SetNVar(TempCA1,SetTo,15); -- Ascending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,2); -- Shape 12*12
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
        
        CElseX() -- {NVar(RandPattern,Exactly,3)} // 반비례 ( 파 ) 즉사불릿생성 ( 딜 O )
            CTrigger(FP,{CVar("X",GMode,Exactly,2),NVar(CheckMB3_HP,AtMost,256*200000)},{
                TSetNVar(DamagePerHP,SetTo,7000);
                SetNVar(TempCA1,SetTo,16); -- Ascending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,1); -- Shape 8*8
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
            CTrigger(FP,{CVar("X",GMode,Exactly,3),NVar(CheckMB3_HP,AtMost,256*400000)},{
                TSetNVar(DamagePerHP,SetTo,60000);
                SetNVar(TempCA1,SetTo,17); -- Descending
                SetNVar(TempCA6,SetTo,0);
                SetNVar(TempCA5,SetTo,2); -- Shape 12*12
                SetCDeaths("X",SetTo,1,ClearPattern);
            },{Preserved})
        CIfXEnd()
    TriggerX(FP,{NVar(DamagePerHP,AtLeast,65536)},{SetNVar(DamagePerHP,SetTo,60000)},{Preserved}) -- 데미지 오버플로우방지 ( 최대치 6만 )
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,5,PatternSW,0xFF)},{SetCDeathsX("X",SetTo,6,PatternSW,0xFF),SetCDeathsX("X",SetTo,34*10,MB3_STimer,0xFFFF)})

    CIf(FP,{CDeaths("X",Exactly,0,ClearPattern),CDeathsX("X",Exactly,34*10,MB3_STimer,0xFFFF)})
        DoActionsX(FP,{
            CreateUnit(1,84,"MB3",P5);
            CopyCpAction({MinimapPing("MB3"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{P1,P2,P3,P4,P5},FP)
        })
    CIfEnd()
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,6,PatternSW,0xFF)})
    CDoActions(FP,{ -- 탄막 데미지설정 // Temp
            TSetBulletDamage(92, SetTo, DamagePerHP);
            TSetNVar(MB_Shape,SetTo,TempCA1);
            TSetNVar(MB_LoopMax,SetTo,TempCA5);
            TSetNVar(MB_DataIndex,SetTo,TempCA6);
        })
    CallCFuncX(FP,MB_CBPlot) -- 탄막 & 유닛 생성단락진입
    TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(TempCA6,Add,1*1)},{Preserved})
    TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(TempCA6,Add,1*2)},{Preserved})
CIfEnd()

TriggerX(FP,{CDeathsX("X",Exactly,6,PatternSW,0xFF),CDeathsX("X",Exactly,0,MB3_STimer,0xFFFF)},{
    SetCDeathsX("X",SetTo,0,PatternSW,0xFF),SetCDeaths("X",SetTo,0,ClearPattern)},{Preserved})

CIfXEnd() -- 하드이상

CIfOnce(FP)
    CIf(FP,{CVar("X",GMode,AtLeast,2)})
        CallCFuncX(FP,NukeCBPlot) -- Y축 실시간위치변경 뉴클리어
    CIfEnd()
    CallCFuncX(FP,CreateNuke) -- 기지 고정 뉴클리어
CIfEnd()

Trigger2X(FP,{Deaths(P8,Exactly,1,96),CDeaths("X",Exactly,0,MB_WaitTimer)},{
    SetCDeaths("X",SetTo,1,MB3_SW);
    SetCDeaths("X",SetTo,0,PatternSW); -- Reset
    SetCDeathsX("X",Add,1*16777216,BossClearCheck,0xFF000000);
    SetDeaths(P8,SetTo,0,96);
    SetMemoryB(0x58CF44+24*0+20,SetTo,1); -- 자동환전 해금
    SetMemoryB(0x58CF44+24*1+20,SetTo,1); -- 자동환전 해금
    SetMemoryB(0x58CF44+24*2+20,SetTo,1); -- 자동환전 해금
    SetMemoryB(0x58CF44+24*3+20,SetTo,1); -- 자동환전 해금
    SetMemoryB(0x58CF44+24*4+20,SetTo,1); -- 자동환전 해금
    SetSpriteImage(309,318);
    SetScore(Force1,Add,600000,Kills);
    SetScore(Force1,Subtract,20,Custom); -- 데카감소
    SetInvincibility(Disable,189,P8,"MB4");
    CopyCpAction({DisplayTextX(ClearMB3Txt,4),PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")
    ,PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")},{Force1,Force5},FP);
})
DoActionsX(FP,{SetCDeathsX("X",Subtract,1,MB3_STimer,0xFFFF)})
CIfEnd() -- 보스 활성화 단락

DoActionsX(FP,{SetCDeaths("X",Subtract,1,MB_WaitTimer)})
CIfEnd()

------<  MBoss4  >---------------------------------------------
-- 분신소환, 각 분신처치시간 차에따른 패턴통과, 스테이시스필드, 즉사기
MB4_VFlag, MB4_VFlag256 = CreateVars(2,FP)

CIf(FP,{Bring(P8,Exactly,0,189,"MB4"),CDeaths("X",Exactly,0,MB4_SW)})

CallCFuncX(FP,CheckWarpPlayer)
SetMB_VFlags(MB4_VFlag,MB4_VFlag256)

TriggerX(FP,{},{
        CopyCpAction({DisplayTextX(WarpTxt,4)},{Force1,Force5},FP);
        SetScore(Force1,Add,66666,Kills);
        SetNVar(BGMVar[1],SetTo,15);
        SetNVar(BGMVar[2],SetTo,15);
        SetNVar(BGMVar[3],SetTo,15);
        SetNVar(BGMVar[4],SetTo,15);
        SetNVar(BGMVar[5],SetTo,15);
        SetNVar(OB_BGMVar,SetTo,15);
        SetCDeaths("X",SetTo,34*16,MB_WaitTimer);
        SetCDeaths("X",SetTo,2,MB_HP); -- 보스 피통리젠횟수 ( 800m + 700m * 2 )
        SetCDeathsX("X",SetTo,4*16777216,MB_Stage,0xFF000000); -- BossNumber
})

CIf(FP,{CDeaths("X",Exactly,0,MB_WaitTimer)},{SetSpriteImage(309,422)}) -- 핵미사일엔진 이미지 변경

TriggerX(FP,{},{
    SetNVar(MBLocX,SetTo,1024);
    SetNVar(MBLocY,SetTo,3037);
    SetNVar(MB_LoopMax,SetTo,600);
    GiveUnits(1,71,P12,"MB4",P8);
    SetInvincibility(Disable, 71, P8, "MB4");
    CopyCpAction({DisplayTextX(MB4Txt,4),MinimapPing("MB4"),
        PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
})

CTrigger(FP,{
    TMemoryX(Vi(MB4_EPD[2],19),AtLeast,1*256,0xFF00);
    CVar("X",GMode,Exactly,1);
},{
    TSetMemory(Vi(MB4_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB4_EPD[2],72),SetTo,255*256,0xFF00); -- Parasite
})

CTrigger(FP,{ -- 보스 개별건작 적용
    CVar("X",GMode,AtLeast,2);
},{
    TSetMemory(Vi(MB4_EPD[2],13),SetTo,0); -- MaxSpeed
    TSetMemoryX(Vi(MB4_EPD[2],55),SetTo,0x100,0x100); -- Require Detection
    TSetMemoryX(Vi(MB4_EPD[2],57),SetTo,MB4_VFlag,0xFF); -- Visibility State
    TSetMemoryX(Vi(MB4_EPD[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
    TSetMemoryX(Vi(MB4_EPD[2],73),SetTo,MB4_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
    TSetMemoryX(Vi(MB4_EPD[2],35),SetTo,1,0xFF);
    TSetMemoryX(Vi(MB4_EPD[2],35),SetTo,1*256,0xFF00); -- Individual Pointer
    TSetMemoryX(Vi(MB4_EPD[2],72),SetTo,255*256,0xFF00); -- Vision
    TSetMemoryX(Vi(MB4_EPD[2],72),SetTo,255*16777216,0xFF000000); -- Individual TBL ( Blind State )
})

CTrigger(FP,{ -- Reset HP
    TMemory(Vi(MB4_EPD[2],2),AtMost,1000000*256);
    CDeaths("X",AtLeast,1,MB_HP);
 },{
       TSetMemory(Vi(MB4_EPD[2],2),SetTo,256*5000000);
       SetCDeathsX("X",SetTo,1*65536,MB_Stage,0xFF0000); -- 추가패턴
       SetCDeaths("X",Subtract,1,MB_HP);
 },{Preserved})

------------------------------------------------------

CIfX(FP,{CVar("X",GMode,Exactly,1)}) -- Normal
    CIf(FP,{CDeathsX("X",Exactly,0,PatternSW,0xFF),CDeathsX("X",Exactly,0,MB4_STimer,0xFFFF)},{SetCDeathsX("X",SetTo,1,PatternSW,0xFF)})
        DoActions(FP,{SetInvincibility(Enable, 71, P8, "MB4")})
        SetNextptr()
            CTrigger(FP,{Memory(0x628438,AtLeast,1)},{ -- Left Arbiter
                SetImageColor(130,16);
                CreateUnit(1,71,"X3",P6);
                TSetMemory(Vi(Nextptr[2],2),SetTo,256*3000000); -- Max HP
                TSetMemory(Vi(Nextptr[2],13),SetTo,0); -- Max Speed
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Parasite
            },{Preserved})
        SetNextptr()
            CTrigger(FP,{Memory(0x628438,AtLeast,1)},{ -- Right Arbiter
                CreateUnit(1,71,"X4",P7);
                TSetMemory(Vi(Nextptr[2],2),SetTo,256*3000000); -- Max HP
                TSetMemory(Vi(Nextptr[2],13),SetTo,0); -- Max Speed
                TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Parasite
                SetImageColor(130,6);
            },{Preserved})
    CIfEnd()

    CIf(FP,{CDeathsX("X",Exactly,0*65536,PatternSW,0xFFFF0000)},{SetCDeathsX("X",SetTo,34*20*65536,PatternSW,0xFFFF0000)}) -- 주기적유닛소환
        DoActionsX(FP,{ -- MB_CBPlot Preset
            SetNVar(MB_Shape,SetTo,22); -- Left X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,86);
            SetNVar(UV[2],SetTo,25);
            --SetNVar(UV[3],SetTo,93);
        })
        CallCFuncX(FP,MB_CBPlot)
        DoActionsX(FP,{
            SetNVar(MB_Shape,SetTo,23); -- Right X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,86);
            SetNVar(UV[2],SetTo,25);
            --SetNVar(UV[3],SetTo,52);
        })
        CallCFuncX(FP,MB_CBPlot)
    CIfEnd()

    CIf(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)})
            TriggerX(FP,{Deaths(P6,AtLeast,1,71),Deaths(P7,AtLeast,1,71)},{
                SetDeaths(P6,SetTo,0,71);SetDeaths(P7,SetTo,0,71);
                SetInvincibility(Disable, 71, P8, "MB4");
                SetCDeathsX("X",SetTo,34*15,MB4_STimer,0xFFFF);
                SetCDeathsX("X",SetTo,0,PatternSW,0xFF);
                CreateUnit(1,84,"MB4",P5);
                CopyCpAction({MinimapPing("MB4"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1},FP)
            },{Preserved})
    CIfEnd()

CElseX() -- Hard , Lunatic

CondTimer, CondTimer2 = CreateVars(2,FP)

TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(CondTimer,SetTo,3*34,0xFFFF),SetNVar(CondTimer2,SetTo,3*34*65536,0xFFFF0000)})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(CondTimer,SetTo,2*34,0xFFFF),SetNVar(CondTimer2,SetTo,2*34*65536,0xFFFF0000)})
------------------------------------------------------------

CIf(FP,{CDeathsX("X",Exactly,0*65536,PatternSW,0xFFFF0000)},{SetCDeathsX("X",SetTo,34*20*65536,PatternSW,0xFFFF0000)}) -- 주기적유닛소환
    DoActionsX(FP,{ -- MB_CBPlot Preset
            SetNVar(MB_Shape,SetTo,22); -- Left X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,86);
            SetNVar(UV[2],SetTo,25);
            SetNVar(UV[3],SetTo,93);
        })
    TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
            SetNVar(MB_Shape,SetTo,22); -- Left X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,28);
            SetNVar(UV[2],SetTo,2);
            SetNVar(UV[3],SetTo,66);
    },{Preserved})
        CallCFuncX(FP,MB_CBPlot)
    DoActionsX(FP,{
            SetNVar(MB_Shape,SetTo,23); -- Right X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,86);
            SetNVar(UV[2],SetTo,25);
            SetNVar(UV[3],SetTo,52);
        })
    TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
            SetNVar(MB_Shape,SetTo,23); -- Left X'elnaga
            SetNVar(MB_LoopMax,SetTo,600);
            SetNVar(MB_DataIndex,SetTo,1);
            SetNVar(UV[1],SetTo,28);
            SetNVar(UV[2],SetTo,2);
            SetNVar(UV[3],SetTo,66);
    },{Preserved})
        CallCFuncX(FP,MB_CBPlot)
CIfEnd()
    
CIf(FP,{CDeathsX("X",Exactly,0*65536,MB4_STimer,0xFFFF0000)}) -- 타이머 리셋후 패턴시작

CIf(FP,{CDeathsX("X",Exactly,0,PatternSW,0xFF)},{SetCDeathsX("X",SetTo,1,PatternSW,0xFF)}) --  Create Puppets
DoActions(FP,{SetInvincibility(Enable, 71, P8, "MB4")})
    SetNextptr()
        CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
            SetImageColor(130,16); -- Set Puppets Color
            CreateUnit(1,71,"X3",P6);
            TSetMemory(Vi(Nextptr[2],2),SetTo,256*3000000); -- Current HP
            TSetMemory(Vi(Nextptr[2],13),SetTo,0); -- Max Speed
            TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Parasite
        },{Preserved})
    SetNextptr()
        CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
            CreateUnit(1,71,"X4",P7);
            TSetMemory(Vi(Nextptr[2],2),SetTo,256*3000000);
            TSetMemory(Vi(Nextptr[2],13),SetTo,0);
            TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Parasite
            SetImageColor(130,6); -- Color Recover
        },{Preserved})
CIfEnd()
-- MB4_STimer : 0xFFFF = CheckTimer1 // 0xFFFF0000 = CheckTimer2
-- PatternSW : 0xFF = Stage // 0xFFFFFF00 = Passed or Failed // 0xFFFF0000 = BulletTimer

CIf(FP,{CDeathsX("X",Exactly,1,PatternSW,0xFF)}) -- While Puppets Alive // CreateBullet
    TriggerX(FP,{Deaths(P6,Exactly,1,71)},{
        SetCDeathsX("X",SetTo,2,PatternSW,0xFF),SetCDeaths("X",SetTo,1,MB4Deaths),SetDeaths(P6,SetTo,0,71)},{Preserved})
    TriggerX(FP,{Deaths(P7,Exactly,1,71)},{
        SetCDeathsX("X",SetTo,2,PatternSW,0xFF),SetCDeaths("X",SetTo,1,MB4Deaths),SetDeaths(P7,SetTo,0,71)},{Preserved})
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,2,PatternSW,0xFF)})
    TriggerX(FP,{CDeaths("X",Exactly,1,MB4Deaths)},{SetCDeathsX("X",Add,1,MB4_STimer,0xFFFF)},{Preserved}) -- 시간측정시작
    TriggerX(FP,{Deaths(P6,Exactly,1,71)},{ -- MB4_STimer End, Execution Pattern
        SetCDeathsX("X",SetTo,3,PatternSW,0xFF),SetCDeaths("X",SetTo,2,MB4Deaths),SetDeaths(P6,SetTo,0,71)},{Preserved})
    TriggerX(FP,{Deaths(P7,Exactly,1,71)},{ -- MB4_STimer End, Execution Pattern
        SetCDeathsX("X",SetTo,3,PatternSW,0xFF),SetCDeaths("X",SetTo,2,MB4Deaths),SetDeaths(P7,SetTo,0,71)},{Preserved})
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,3,PatternSW,0xFF)})
    CTrigger(FP,{
        TCDeathsX("X",AtMost,CondTimer,MB4_STimer,0xFFFF);
    },{
        SetCDeathsX("X",SetTo,0,MB4_STimer,0xFFFF); -- MB4_STimer Reset
        SetCDeathsX("X",SetTo,34*15*65536,MB4_STimer,0xFFFF0000); -- 패턴 통과후 대기시간
        SetCDeathsX("X",SetTo,0,PatternSW,0xFF); -- 패턴통과시 PatternSW 값 0으로 Set
        SetInvincibility(Disable, 71, P8, "MB4");
        CreateUnit(1,84,"MB4",P5);
        CopyCpAction({MinimapPing("MB4"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1},FP)
    },{Preserved})
    CTrigger(FP,{
        TCDeathsX("X",AtLeast,_Add(CondTimer,1),MB4_STimer,0xFFFF);
    },{
        SetCDeathsX("X",SetTo,0,MB4_STimer,0xFFFF); -- MB4_STimer Reset
        SetCDeathsX("X",SetTo,34*2*65536,MB4_STimer,0xFFFF0000); -- 패턴 통과후 대기시간
        SetCDeathsX("X",SetTo,4,PatternSW,0xFF); -- 패턴파훼 실패시 PatternSW 값 4로 Set
    },{Preserved})
CIfEnd()

CIf(FP,{CDeathsX("X",Exactly,4,PatternSW,0xFF)}) --    패턴파훼 실패시 진입단락
    DoActionsX(FP,{ -- 사이드유닛생성, Temp변수값 설정
        SetNVar(MB_Shape,SetTo,24),SetNVar(MB_LoopMax,SetTo,600),SetNVar(MB_DataIndex,SetTo,1);
        SetNVar(UV[1],SetTo,30);
        SetNVar(UV[2],SetTo,2);
        SetNVar(UV[3],SetTo,102);
        SetNVar(TempCA1,SetTo,25); -- Shape
        SetNVar(TempCA5,SetTo,1); -- LoopMax
        SetNVar(TempCA6,SetTo,1); -- DataIndex
    })
    CallCFuncX(FP,MB_CBPlot)
    DoActionsX(FP,{SetCDeathsX("X",SetTo,5,PatternSW,0xFF)})

    CIf(FP,{Memory(0x628438,AtLeast,1)})
        f_Read(FP,0x628438,Nextptrs,NextEPD)
        CDoActions(FP,{
            CreateUnit(1,212,"MB4",P8);
            TSetMemoryX(Vi(NextEPD[2],35),SetTo,1,0xFF); -- 개별건작 세팅
            TSetMemoryX(Vi(NextEPD[2],55),SetTo,0x100,0x100); -- 스테이터스플래그 세팅
            TSetMemoryX(Vi(NextEPD[2],57),SetTo,2^5,0xFF); -- P6
            TSetMemoryX(Vi(NextEPD[2],68),SetTo,300,0xFFFF); -- 리무브타이머
            TSetMemoryX(Vi(NextEPD[2],70),SetTo,255*16777216,0xFF000000); -- Storm Timer ( GunTimer )
            TSetMemoryX(Vi(NextEPD[2],72),SetTo,255*256,0xFF00);
            TSetMemoryX(Vi(NextEPD[2],73),SetTo,(2^5)*256,0xFF00); -- Unused Timer
        })
        f_Read(FP,_Add(NextEPD,10),NukePosXY) -- 공격지점 저장
        f_Read(FP,0x628438,nil,NextEPD)
            CDoActions(FP,{
                CreateUnit(1,14,"MB4",P8);
                TSetMemory(Vi(NextEPD[2],32),SetTo,Nextptrs); -- 연결유닛
                TSetMemoryX(Vi(NextEPD[2],19),SetTo,125*256,0xFF00); -- 오더ID 핵공격
                TSetMemory(Vi(NextEPD[2],22),SetTo,NukePosXY); -- 핵쏠위치 지정
            })
    CIfEnd()
CIfEnd()

CIfEnd() -- 보스활성화단락

CIf(FP,{CDeathsX("X",Exactly,5,PatternSW,0xFF)})
    CDoActions(FP,{ -- Temp -> Main
            TSetNVar(MB_Shape,SetTo,TempCA1);
            TSetNVar(MB_LoopMax,SetTo,TempCA5);
            TSetNVar(MB_DataIndex,SetTo,TempCA6);
        })
    CallCFuncX(FP,MB_CBPlot) -- 탄막 생성단락진입
    DoActionsX(FP,{SetNVar(TempCA6,Add,1)})

    TriggerX(FP,{NVar(TempCA6,AtLeast,MB4_BulletSH[1]+1)},{SetCDeathsX("X",SetTo,0,PatternSW,0xFF)},{Preserved})
CIfEnd()

CIfXEnd() -- 난이도구분 CIf단락


CIfOnce(FP)
    CIf(FP,{CVar("X",GMode,AtLeast,2)})
        TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(NukeShape,SetTo,5)})
        TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(NukeShape,SetTo,6)})
        CallCFuncX(FP,NukeCBPlot) -- Y축 실시간위치변경 워프 뉴클리어
        TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(NukeShape,SetTo,1)})
        TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(NukeShape,SetTo,2)})
        CallCFuncX(FP,NukeCBPlot)
    CIfEnd()
    CallCFuncX(FP,CreateNuke) -- 기지 고정 뉴클리어
CIfEnd()


TriggerX(FP,{Deaths(P8,Exactly,1,71),CDeaths("X",Exactly,0,MB_WaitTimer)},{
    SetCDeaths("X",SetTo,1,MB4_SW);
    SetCDeathsX("X",Add,1*16777216,BossClearCheck,0xFF000000);
    SetDeaths(P8,SetTo,0,71);
    SetSpriteImage(309,318);
    SetScore(Force1,Add,800000,Kills);
    SetScore(Force1,Subtract,20,Custom); -- 데카감소
    --SetInvincibility(Disable,189,P8,"MB5");
    CopyCpAction({DisplayTextX(ClearMB4Txt,4),PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")
    ,PlayWAVX("staredit\\wav\\ClearMBoss.ogg"),PlayWAVX("staredit\\wav\\ClearMBoss.ogg")},{Force1,Force5},FP);
})

CIfEnd()

DoActionsX(FP,{
    SetCDeathsX("X",Subtract,1*65536,PatternSW,0xFFFF0000),
    SetCDeaths("X",Subtract,1,MB_WaitTimer),SetInvincibility(Disable, 20, Force1, "Anywhere");
    SetCDeathsX("X",Subtract,1*65536,MB4_STimer,0xFFFF0000)
})
CIfEnd() -- 보스단락End

end