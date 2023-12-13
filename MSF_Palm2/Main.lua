------<  Map Properties  >---------------------------------------------
FP = P8

SetForces({P1,P2,P3,P4,P5},{P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P8)
StartCtrig(1,nil,0,1,"C:\\Users\\jungt\\Documents\\euddraft0.9.3.6\\CSsave")

CJump(AllPlayers,0)
	Include_CBPaint()
	Include_CtrigPlib(360,"Switch 1",1)
	Include_64BitLibrary("Switch 253")
CJumpEnd(AllPlayers,0)
Enable_PlayerCheck()
ObserverChatToAll(FP, _Void(0xFF), nil, nil, 0)
------<  Vars, Ccodes  >---------------------------------------------
GMode, TestOn = CreateCcodes(2)
Nextptr, BackupCp, HPosXY, HPosX, HPosY, HPlayer, Pre_HPlayer = CreateVars(7,FP)
------<  CFuncs  >---------------------------------------------
Call_SaveCpCFunc = InitCFunc(FP)
CFunc(Call_SaveCpCFunc)
	SaveCp(FP,BackupCp)
CFuncEnd()

Call_LoadCpCFunc = InitCFunc(FP)
CFunc(Call_LoadCpCFunc)
	LoadCp(FP,BackupCp)
CFuncEnd()

Call_Nextptr = InitCFunc(FP)
CFunc(Call_Nextptr)
	f_Read(FP,0x628438,nil,Nextptr)
CFuncEnd()
------<  functions  >---------------------------------------------
function SetNextptr()
	CallCFuncX(FP,Call_Nextptr)
end

function Call_SaveCp()
	CallCFuncX(FP,Call_SaveCpCFunc)
end

function Call_LoadCp()
	CallCFuncX(FP,Call_LoadCpCFunc)
end

function LimitC(Player,Value)
	local X = {}
	table.insert(X,(SetMemory(0x582174+4*Player,SetTo,2*Value)))
	return X
end

function LimitCMax(Player,Value)
	local X = {}
	table.insert(X,(SetMemory(0x582144+4*Player,SetTo,2*Value)))
	return X
end

function SetLabel(Index)
	Trigger {
		players = {FP},
		conditions = {
				Label(Index);
			},
	}
end

------<  Main  >---------------------------------------------



SetExpiration(12, 12) -- 유통기한설정
DoActions(FP,{
	RemoveUnit("Any unit",P12);
	RemoveUnit(204,Force2);
	RemoveUnit(204,P5);
})
Enable_TestMode(true)
Install_Opening() -- 오프닝, 난이도 선택
Install_System() -- 기본 시스템
Install_BGM() -- 브금, 온오프 ( Void 1 ~ 5 )

UnitPatch() -- 영작, 스테이터스플래그 재설정

Install_MGun() -- 일반건작 CLoc91 유닛생성 // CLoc92 오더
Install_SGun() -- 특건
--Install_Climax() -- 화홀
Install_Wave()
CCMU()
--CheckAPM(0x19) -- APM측정 (val 94 95 사용중)

HeroLoop() -- 영작유닛인식 루프


EndCtrig()
ErrorCheck()
EUDTurbo(FP)

