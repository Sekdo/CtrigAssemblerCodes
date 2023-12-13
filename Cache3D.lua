function InitCache3D(PlayerID,Number,Size,Null)
	return {InitCache2(PlayerID,Number,Size,Null),InitCache2(FP,Number,Size,Null),InitCache2(FP,Number,Size,Null)} -- [1]=X / [2]=Y / [3]=Z
end

-- EX : CXPlotCache = InitCache3D(FP,도형점의수,캐시메모리사이즈,Null변수) 형식으로 입력

function LoadCache3D(PlayerID,Cache3,Number,Time,OutputX,OutputY,OutputZ) -- OutputX,OutputY,OutputZ에 X, Y, Z 대입
	LoadCache2(PlayerID,Cache3[1],Number,Time,OutputX) -- Try Cache2X
	LoadCache2(PlayerID,Cache3[2],Number,Time,OutputY) -- Try Cache2Y
	LoadCache2(PlayerID,Cache3[3],Number,Time,OutputZ) -- Try Cache2Z
end

function SaveCache3D(PlayerID,Cache3,Number,Time,InputX,InputY,InputZ) -- InputX,InputY,InputZ에 V(CA[8]), V(CA[9]), V(CA[11]) 대입
	SaveCache2(PlayerID,Cache3[1],Number,Time,InputX)
	SaveCache2(PlayerID,Cache3[2],Number,Time,InputY)
	SaveCache2(PlayerID,Cache3[3],Number,Time,InputZ)
end

function ResetCache3D(PlayerID,Cache3,Number,Start,End) -- 캐시메모리 초기화
	ResetCache2(PlayerID,Cache3[1],Number,Start,End)
	ResetCache2(PlayerID,Cache3[2],Number,Start,End)
	ResetCache2(PlayerID,Cache3[3],Number,Start,End)
end

--[[
	CXPosX, CXPosY, CXPosZ, RT, CXTimeLine, AX, AY, AZ = CreateVars(8,FP)

SH_Fullerene = CXMakePolyhedron(32,96,0)

Cache3D = InitCache3D(FP,SH_Fullerene[1],360,0x80000000)

DoActionsX(FP,{
	SetNVar(CXTimeLine,Add,1),SetNVar(AX,Add,1),SetNVar(AY,Add,-1)
	,SetNVar(AZ,Add,2),RemoveUnit(204,P2),SetNVar(RT,SetTo,0)})

TriggerX(FP,{NVar(CXTimeLine,AtLeast,360)},{SetNVar(CXTimeLine,SetTo,0)},{Preserved})

function CXFuncA()
    local CA = CAPlotDataArr
		LoadCache3D(FP,Cache3D,RT,CXTimeLine,CXPosX,CXPosY,CXPosZ)
            CIfX(FP,{NVar(CXPosX,Exactly,0x80000000)}) -- Cache Miss (Null)
                CX_Rotate(AX,AY,AZ)
                SaveCache3D(FP,Cache3D,RT,CXTimeLine,V(CA[8]),V(CA[9]),V(CA[11]))
				CMov(FP,0x57F0F0,CXTimeLine)
				CMov(FP,0x57F120,RT)
            CElseX()
                CMov(FP,V(CA[8]),CXPosX)
                CMov(FP,V(CA[9]),CXPosY)
                CMov(FP,V(CA[11]),CXPosZ)
            CIfXEnd()
        DoActionsX(FP,SetNVar(RT,Add,1))
    end

CXPlot(SH_Fullerene,P2,204,"CLoc1",{1024,6914},1,32,{1,0,0,0,600,0},"CXFuncA",FP,nil,nil,1)
]]--