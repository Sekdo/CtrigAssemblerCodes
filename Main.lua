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



SetExpiration(12, 12) -- ������Ѽ���
DoActions(FP,{
	RemoveUnit("Any unit",P12);
	RemoveUnit(204,Force2);
	RemoveUnit(204,P5);
})
Enable_TestMode(true)
Install_Opening() -- ������, ���̵� ����
Install_System() -- �⺻ �ý���
Install_BGM() -- ���, �¿��� ( Void 1 ~ 5 )

UnitPatch() -- ����, �������ͽ��÷��� �缳��

Install_MGun() -- �Ϲݰ��� CLoc91 ���ֻ��� // CLoc92 ����
Install_SGun() -- Ư��
--Install_Climax() -- ȭȦ
Install_Wave()
CCMU()
--CheckAPM(0x19) -- APM���� (val 94 95 �����)

HeroLoop() -- ���������ν� ����


EndCtrig()
ErrorCheck()
EUDTurbo(FP)

