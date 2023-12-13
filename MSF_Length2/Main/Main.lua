
--[[
sIndex
0x0 = Code Paragraph
0x1 ~ 0xFE = Gun Jump sIndex
0xFF = Exchange Jump sIndex
0x100 ~ 0x106 = TTrig Jump sIndex
0x107 ~ 0x108 = WH sIndex
0x200 ~ 0x2FF = CallTrig Jump sIndex
0x300 ~ 0x3FF = CunitCtrig4X Jump sIndex

0x400 ~ 0x4FF = MBoss, FBoss sIndex

Index
0x0 ~ 0x1FF = Etc Var
0x200 ~ 0x200+100 = Save Gun Angle Var
0x200+100 ~ 0x200+100+500 = CAPlot Var
0x1001 ~ 0x1004 = TTrig Label
0x1005 ~ 0x1006 = ExtraGun Label
0x1007 ~ 0x1008 = Wave Label

0x5000 ~ 0x5FFF = Gun Label

0x3000 ~ 0x3FFF = MBoss, FBoss Label

Void
1 ~ 100 SGun Order Var
101 ~ 200 BGM Var


Simple_SetLocX -> LocID( In SCMD ) - 1
--]]
------<  Map Properties  >---------------------------------------------
SetForces({P1,P2,P3,P4,P5},{P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P8)
StartCtrig(1,nil,0,1,"C:\\Users\\jungt\\Documents\\euddraft0.9.3.6\\CSsave")

------<  Ccodes & NCodes  >---------------------------------------------
C_Count, C_Delay = CreateNcodes(2)
HZ, HTik = CreateNcodes(2)
DonationT, GiveRate = CreateNcodes(2)
NT1, NT2, NT3, NT4, NT5, NT6 = CreateNcodes(6)
CTime1, CTime2, CTime3 = CreateNcodes(3)
LvlJump, SelectView = CreateNcodes(2)
TestMode, LimitX = CreateNcodes(2)
TNumber = CreateNcode()
P_Count = CreateNcode()
BGMO = CreateNcode()
BanCode2, BanCode3, BanCode4, BanCode5 = CreateNcodes(4)
EXSwitch = CreateNcode()

BossClearCheck = CreateCcode()

N = CreateCcodeArr(500)

------<  Tables & Consts  >---------------------------------------------
CJump(AllPlayers,0)
Include_CBPaint()
Include_CtrigPlib(360,"Switch 1",1)
Include_64BitLibrary("Switch 253")
--Player--
FP = P8 
CP = CurrentPlayer
AP = AllPlayers

--Const--
LBC = 170 -- LB Cycle
TMode = 0 -- 1 = TestOn // 0 = TestOff
HZTimer = 102

--Table--
LimitCArr = {}
LimitCMaxArr = {}
GModeLocArr = {"Normal","Hard","Lunatic","Unspeakable"}
NUnit = {0,7,20,34,107,111,124,125,188}
NUnitArr = {}

HealTikUnit = {34,1,2}
HZHealArr = {}
ButtonSetPatch = {}
ZergPatchArr = {}
UnitSizeArr = {}
ConvertAir = {}
ConvertGround = {}
ELevelArr = {}
ZergGroupFlagsPatch = {}
NDeathsTable = {}
ExRate = {{20,18,18,19,20},{23,23,24,24,25},{25,25,26,27,28}} -- 환전율
GiveRate2 = {1000,5000,10000,50000,100000,500000}
GiveUnitID = {58,60,70,71,72}
Player = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5"}
UpgradeSetting = {}
NonBionicPatch = {}
MarBionicPatch = {}
SpellcasterPatch = {}
--Index( 0x0001 ~ 0x00FF // 0x0100 ~ 0x01FF // 0x0200 ~ 0x0200+100 // 0x0200+101 ~ 0x0200+400[0x0390] )
-----------------------------↓			For CVar Variables		↓-----------------------------------------------------

CVariable(FP,0x0FFA) GMode = 0x0FFA
CVariable(FP,0x0FFB) LB = 0x0FFB
CVariable(FP,0x0FFC) CPlayer = 0x0FFC
CVariable(FP,0x0FFE) TAngle2 = 0x0FFE -- Lunatic Angle Index
CVariable(FP,0x0FFF) TAngle1 = 0x0FFF -- Hard Angle Index

for i = 1 , 100 do
CVariable(FP,0x0200+i) -- Save GunAngle Index
end

for i = 1, 700 do
CVariable(FP,0x0200+100+i) -- CAPlot Index
end
-----------------------------↓		For CVArr 		↓-----------------------------------------------------
HUArr = CVArray(FP,23)
GUArr = CVArray(FP,18)
HPVArr = CVArray(FP,105)
KillPointVArr = CVArray(FP,105)
HeroVArr = CVArray(FP,39)
GTextVArr = CVArray(FP,4)
-----------------------------↓			For NVar Variables		↓-----------------------------------------------------
Nextptr, VFlag, VFlag256, CTimer, UPlayer, GiveUPlayer, MaxDCount, SaveJYDGunTimer, JYDTimer = CreateVars(9,FP)
AllUnit, AllUnitX, UnitX = CreateVars(3,FP)
PUnit, PUnitAmount, EXGunDataIndex, HeroSetting = CreateVars(4,FP)
Save_VFlag, Save_VFlag256, InvTimer = CreateVars(3,FP)

Install_GetCLoc(FP,7,29) -- 322
CJumpEnd(AllPlayers,0)

NoAirCollisionX(FP)
Enable_PlayerCheck()
ObserverChatToAll(FP, _Void(0xFF), nil, nil, 0)
--Enable_HideErrorMessage(FP)
DoActions(FP,SetSpeed(SetTo,"#X2")) -- 2배속
------<  Functions  >---------------------------------------------
function EnermyNonBionic(Index)
	table.insert(NonBionicPatch,SetMemoryX(0x664080 + (Index*4),SetTo,0,0x10000))
end
for i = 0, 227 do
	EnermyNonBionic(i)
end

function MarineBionic(Index)
	table.insert(MarBionicPatch,SetMemoryX(0x664080 + (Index*4),SetTo,0x10000,0x10000))
end
MarineBionic(0)
MarineBionic(7)
MarineBionic(20)
MarineBionic(124)
MarineBionic(125)

function SetUnitAdvFlag(UnitID,Value,Mask)
	table.insert(SpellcasterPatch,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
end
for i = 0, 227 do
	SetUnitAdvFlag(i,0x200000,0x200000)
end
SetUnitAdvFlag(204,0,0x200000) -- 204 이팩트유닛 제외

function SetHeroUpgrade(Player,Value)
	for i = 0, 15 do
			table.insert(UpgradeSetting,SetMemoryB(0x58D2B0+(Player*46)+i,SetTo,Value))
	end	
end

function SetZergUpgrade(Player,Value)
	ZP = {3,4,10,11,12}
	for i = 1, #ZP do
			table.insert(UpgradeSetting,SetMemoryB(0x58D2B0+(Player*46)+ZP[i],SetTo,Value))
	end
end

function UnitDefTypePatch(Value)
		for i = 0, 104 do
			table.insert(UnitSizeArr,SetMemoryB(0x662180+i,SetTo,Value))
		end
			table.insert(UnitSizeArr,SetMemoryB(0x662180+176,SetTo,Value))
			table.insert(UnitSizeArr,SetMemoryB(0x662180+177,SetTo,Value))
			table.insert(UnitSizeArr,SetMemoryB(0x662180+178,SetTo,Value))
end



function SetZergGroupFlags(Unit)
table.insert(ZergGroupFlagsPatch,SetMemoryB(0x6637A0 + (Unit),SetTo,0x01+0x08+0x20))
--0x01 Zerg // 0x02 Terran // 0x04 Protoss // 0x08 Men // 0x10 Building // 0x20 Factories // 0x40 Independent // 0x80 Neutral
end

SetZergGroupFlags(37)
SetZergGroupFlags(38)
SetZergGroupFlags(39)
SetZergGroupFlags(40)
SetZergGroupFlags(43)
SetZergGroupFlags(44)
SetZergGroupFlags(48)
SetZergGroupFlags(50)
SetZergGroupFlags(51)
SetZergGroupFlags(53)
SetZergGroupFlags(54)
SetZergGroupFlags(62)

function BleedingDrawFunc(Value)
	local X = {}
	for i = 0, 7 do
		table.insert(X,SetMemoryB(0x669E28+458+i,SetTo,Value))
		table.insert(X,SetMemoryB(0x669E28+480+i,SetTo,Value))
	end
	return X
end

function SetWeaponDamage(Index,Value)-- 무기공격력
	return SetMemoryW(0x656EB0+2*Index,SetTo,Value)
end

function SetExtraUpgrade(Index,Value)
	local X = {}
	for i = 5, 7 do
	table.insert(X,SetMemoryB(0x58F32C + 15*i + Index, SetTo, Value))
	end
	return X
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

function Call_SaveCp()
	CallTrigger(FP,Call_SaveCpIndex)
end
function Call_LoadCp()
	CallTrigger(FP,Call_LoadCpIndex)
end
function SetNextptr()
	CallTrigger(FP,Call_Nextptr)
end

function CreateUnit2(Count,Unit,Location,Player)
	return CreateUnitWithProperties(Count,Unit,Location,Player,{
		clocked = false,
		burrowed = false,
		intransit = false,
		hallucinated = false,
		invincible = false,
		hitpoint = 100,
		shield = 100,
		energy = 100,
		resource = 0,
		hanger = 0,
	})
end

function SetMaxHP(UnitID,Value)
	local X = {}
	table.insert(X,(SetMemory(0x662350+4*UnitID,SetTo,Value*256)))
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
------<  Texts  >---------------------------------------------

HT1 = "\x13\x1B─━┫ \x03Hero \x04:: \x08B\x04ishop 를 \x06처치\x04하였습니다. \x07+ 90,000 \x1B┣━─"
HT2 = "\x13\x1B─━┫ \x03Hero \x04:: \x08R\x04ook 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT3 = "\x13\x1B─━┫ \x03Hero \x04:: \x08K\x04night 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT4 = "\x13\x1B─━┫ \x03Hero \x04:: \x08W\x04raith 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT5 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Z\x04ero 를 \x06처치\x04하였습니다. \x07+ 150,000 \x1B┣━─"
HT6 = "\x13\x1B─━┫ \x03Hero \x04:: \x08M\x04ontag 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT7 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04ruiser 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT8 = "\x13\x1B─━┫ \x03Hero \x04:: \x08S\x04arah 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT9 = "\x13\x1B─━┫ \x03Hero \x04:: \x08S\x04chezar 를 \x06처치\x04하였습니다. \x07+ 40,000 \x1B┣━─"
HT10 = "\x13\x1B─━┫ \x03Hero \x04:: \x08R\x04aynor \x08V \x04를 \x06처치\x04하였습니다. \x07+ 40,000 \x1B┣━─"
HT11 = "\x13\x1B─━┫ \x03Hero \x04:: \x08K\x04azansky \x04를 \x06처치\x04하였습니다. \x07+ 25,000 \x1B┣━─"
HT12 = "\x13\x1B─━┫ \x03Hero \x04:: \x087\x04。7。7 를 \x06처치\x04하였습니다. \x07+ 300,000 \x1B┣━─"
HT13 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04eaths 를 \x06처치\x04하였습니다. \x07+ 300,000 \x1B┣━─"
HT14 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04uke 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT15 = "\x13\x1B─━┫ \x03Hero \x04:: \x08N\x04orad 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT16 = "\x13\x1B─━┫ \x03Hero \x04:: \x08H\x04yperion 를 \x06처치\x04하였습니다. \x07+ 80,000 \x1B┣━─"
HT17 = "\x13\x1B─━┫ \x03Hero \x04:: \x08I\x04dentity 를 \x06처치\x04하였습니다. \x07+ 9,704 \x1B┣━─"
HT18 = "\x13\x1B─━┫ \x03Hero \x04:: \x08F\x04lare 를 \x06처치\x04하였습니다. \x07+ 45,000 \x1B┣━─"
HT19 = "\x13\x1B─━┫ \x03Hero \x04:: \x08U\x04nclean \x08O\x04ne 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT20 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04alkyrie 를 \x06처치\x04하였습니다. \x07+ 55,000 \x1B┣━─"
HT21 = "\x13\x1B─━┫ \x03Hero \x04:: \x08J\x04upiter 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT22 = "\x13\x1B─━┫ \x03Hero \x04:: \x08S\x04hadow 를 \x06처치\x04하였습니다. \x07+ 95,000 \x1B┣━─"
HT23 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04ark \x08A\x04rchon 를 \x06처치\x04하였습니다. \x07+ 350,000 \x1B┣━─"
HT24 = "\x13\x1B─━┫ \x03Hero \x04:: \x08P\x04robe 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT25 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Z\x04ealot 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT26 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04ragoon 를 \x06처치\x04하였습니다. \x07+ 75,000 \x1B┣━─"
HT27 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04estroy 를 \x06처치\x04하였습니다. \x07+ 300,000 \x1B┣━─"
HT28 = "\x13\x1B─━┫ \x03Hero \x04:: \x08U\x04ranus 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT29 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Z\x04eratul 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT30 = "\x13\x1B─━┫ \x03Hero \x04:: \x08A\x04rchon 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT31 = "\x13\x1B─━┫ \x03Hero \x04:: \x08F\x04enix Z 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT32 = "\x13\x1B─━┫ \x03Hero \x04:: \x08F\x04enix D 를 \x06처치\x04하였습니다. \x07+ 35,000 \x1B┣━─"
HT33 = "\x13\x1B─━┫ \x03Hero \x04:: \x08T\x04assadar 를 \x06처치\x04하였습니다. \x07+ 45,000 \x1B┣━─"
HT34 = "\x13\x1B─━┫ \x03Hero \x04:: \x08M\x04ojo 를 \x06처치\x04하였습니다. \x07+ 25,000 \x1B┣━─"
HT35 = "\x13\x1B─━┫ \x03Hero \x04:: \x08W\x04arbringer 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT36 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04animoth 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT37 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04oid \x08W\x04alker 를 \x06처치\x04하였습니다. \x07+ 80,000 \x1B┣━─"
HT38 = "\x13\x1B─━┫ \x03Hero \x04:: \x08A\x04rtanis 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT39 = "\x13\x1B─━┫ \x03Hero \x04:: \x08X\x04enomorph 를 \x06처치\x04하였습니다. \x07+ 75,000 \x1B┣━─"
HT40 = "\x13\x1B─━┫ \x03Hero \x04:: \x08R\x04aszagal 를 \x06처치\x04하였습니다. \x07+ 55,000 \x1B┣━─"
HT41 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04ivision 를 \x06처치\x04하였습니다. \x07+ 120,000 \x1B┣━─"
HT42 = "\x13\x1B─━┫ \x03Hero \x04:: \x08P\x04hoton \x08C\x04anon 를 \x06처치\x04하였습니다. \x07+ 80,000 \x1B┣━─"
HT43 = "\x13\x1B─━┫ \x03Hero \x04:: \x08T\x04itan 를 \x06처치\x04하였습니다. \x07+ 90,000 \x1B┣━─"

BT1 = "\x13\x10─━┫ \x03Bonus \x04:: \x10M\x04urphy 를 \x06파괴\x04하였습니다. \x07+ 100,000 \x10┣━─"
BT2 = "\x13\x19─━┫ \x03Bonus \x04:: \x18G\x04ift \x03B\x04ox 를 \x06파괴\x04하였습니다. \x07+ 70,000 \x19┣━─"
BT3 = "\x13\x19─━┫ \x03Bonus \x04:: \x18G\x04ift \x03B\x04ox 를 \x06파괴\x04하였습니다. \x07+ 30,000 \x19┣━─"
BT4 = "\x13\x19─━┫ \x03Bonus \x04:: \x18F\x04ake \x03B\x04ox 를 \x06파괴\x04하였습니다. \x07+ 6,974 \x19┣━─"


HIndex = {2,3,5,8,9,10,12,16,17,19,21,22,23,25,27,28,30,32,52,58,60,61,63,64,65,66,68,74,75,76,77,78,79,80,81,86,87,88,93,98,102,162,99}
HText = {HT1,HT2,HT3,HT4,HT5,HT6,HT7,HT8,HT9,HT10,HT11,HT12,HT13,HT14,HT15,HT16,HT17,HT18,HT19,HT20,HT21,HT22,HT23,HT24,
		HT25,HT26,HT27,HT28,HT29,HT30,HT31,HT32,HT33,HT34,HT35,HT36,HT37,HT38,HT39,HT40,HT41,HT42,HT43}
HPoint = {90000,60000,50000,60000,150000,50000,30000,70000,40000,40000,25000,300000,300000,30000,50000,80000,9704,45000,70000,55000,
		70000,95000,350000,65000,70000,75000,300000,65000,50000,50000,30000,35000,45000,25000,65000,60000,80000,70000,75000,
		55000,120000,80000,90000}
-- 0 ~ 50,00 = *2.5
-- 50,00 ~ 100,000 = *2
-- 100,000 ~ 300,000 = *1.5
-- 300,000 ~ 500,000= *1.25

HInfoArr = {} -- {{HIndex[1],HText[1],HPoint[1]},{HIndex[2],HText[2],HPoint[2]}, ...}
for i = 1, 43 do
	local X = {}
	table.insert(X,HIndex[i])
	table.insert(X,HText[i])
	table.insert(X,HPoint[i])
	table.insert(HInfoArr,X)
end

ExtraGunPatch = {}

		local XUnitTable = {40,48,53,54,55,56,70,104}
		local HUnitTable = {3,5,10,12,16,17,19,21,25,27,28,32,58,74,75,76,77,78,79,80,81,86,98} -- -1
		local GUnitTable = {2,8,9,22,23,30,52,60,61,64,65,66,68,87,88,93,99,102} -- +2
	for i = 0, 22 do -- 23
		table.insert(ExtraGunPatch,SetVArrayX(VArr(HUArr,i),"Value",SetTo,HUnitTable[i+1]))
	end
	for i = 0, 17 do
		table.insert(ExtraGunPatch,SetVArrayX(VArr(GUArr,i),"Value",SetTo,GUnitTable[i+1]))
	end
DoActions2X(FP,ExtraGunPatch,{})
UnitDefTypePatch(1)
DoActions2(FP,NonBionicPatch,{})
DoActions2(FP,MarBionicPatch,{})
DoActions2(FP,UnitSizeArr,{})
DoActions2(FP,ZergGroupFlagsPatch,{})
DoActions2(FP,SpellcasterPatch,{})

------<  칭호 Trig  >------------------------------------------
--Mejiro_McQueen
Name1 = "Mejiro_McQueen"

TitleNameA1 = "\x06†하드솔플 최초클리어† \x04"


TitleNameA2 = "\x06† 하드\x04다인플 클리어 \x06† \x04"
Name2 = "Beatsaber"
Name3 = "marine_T_T"
Name4 = "MArinnnnnnnnnn"
Name5 = "hohobab14"
Name6 = "Tana_"
Name7 = "baxter-solo"
Name8 = "CMSF-fuyun"

NameArr = {Name2,Name3,Name4,Name5,Name6,Name7,Name8}



------<  BGM Trig  >------------------------------------------
BGMVar = CreateVarArr(5,FP)
OB_BGMVar = CreateVar(FP)

for i = 0, 4 do -- BGM On/Off (Void 1 ~ 5)

TriggerX(FP,{
		LocalPlayerID(i);
		Void(i+1,Exactly,1);
	},{
		SetNVar(BGMVar[i+1],SetTo,0);
	},{Preserved})

IBGM_EPD(FP,{i},BGMVar[i+1],{
	{1,"staredit\\wav\\Easy_1.ogg",31*1000},
	{2,"staredit\\wav\\Normal_1.ogg",51*1000},
	{3,"staredit\\wav\\Hard_1.ogg",81*1000},
	{4,"staredit\\wav\\Easy_2.ogg",53*1000},
	{5,"staredit\\wav\\Normal_2.ogg",37*1000},
	{6,"staredit\\wav\\Hard_2.ogg",42*1000},
	{7,"staredit\\wav\\Easy_3.ogg",40*1000},
	{8,"staredit\\wav\\Normal_3.ogg",48*1000},
	{9,"staredit\\wav\\Hard_3.ogg",84*1000},
	{10,"staredit\\wav\\Easy_4.ogg",31*1000},
	{11,"staredit\\wav\\Normal_4.ogg",44*1000},
	{12,"staredit\\wav\\Hard_4.ogg",86*1000},
	{14,"staredit\\wav\\Hard_5.ogg",60*1000},
	{15,"staredit\\wav\\MBoss.ogg",84*1000},
	{16,"staredit\\wav\\OC.ogg",107*1000},
	{17,"staredit\\wav\\Hard_6.ogg",161*1000},
	{18,"staredit\\wav\\FB2.ogg",136*1000},
	{19,"staredit\\wav\\FB3.ogg",127*1000},
	})
end
--< OB BGM >--

IBGM_EPD(FP,{Force5},OB_BGMVar,{
	{1,"staredit\\wav\\Easy_1.ogg",31*1000},
	{2,"staredit\\wav\\Normal_1.ogg",51*1000},
	{3,"staredit\\wav\\Hard_1.ogg",55*1000},
	{4,"staredit\\wav\\Easy_2.ogg",53*1000},
	{5,"staredit\\wav\\Normal_2.ogg",37*1000},
	{6,"staredit\\wav\\Hard_2.ogg",42*1000},
	{7,"staredit\\wav\\Easy_3.ogg",40*1000},
	{8,"staredit\\wav\\Normal_3.ogg",48*1000},
	{9,"staredit\\wav\\Hard_3.ogg",84*1000},
	{10,"staredit\\wav\\Easy_4.ogg",31*1000},
	{11,"staredit\\wav\\Normal_4.ogg",44*1000},
	{12,"staredit\\wav\\Hard_4.ogg",86*1000},
	{14,"staredit\\wav\\Hard_5.ogg",60*1000},
	{15,"staredit\\wav\\MBoss.ogg",84*1000},
	{16,"staredit\\wav\\OC.ogg",107*1000},
	{17,"staredit\\wav\\Hard_6.ogg",161*1000},
	{18,"staredit\\wav\\FB2.ogg",136*1000},
	{19,"staredit\\wav\\FB3.ogg",127*1000},
	})

DoActions(FP,{SetMemory(0x6509B0,SetTo,7)})

------<  CallTrigger  >------------------------------------------
BackupCp = CreateVars(1,FP)

CJump(FP,0x200)
Call_Nextptr = SetCallForward()
SetCall(FP)
f_Read(FP,0x628438,nil,Nextptr)
SetCallEnd()
CJumpEnd(FP,0x200)

CJump(FP,0x201)
Call_SaveCpIndex = SetCallForward()
SetCall(FP)
SaveCp(FP,BackupCp)
SetCallEnd()
CJumpEnd(FP,0x201)

CJump(FP,0x202)
Call_LoadCpIndex = SetCallForward()
SetCall(FP)
LoadCp(FP,BackupCp)
SetCallEnd()
CJumpEnd(FP,0x202)

BuildingArr = {114,116,126,127,130,147,148,150,151,152,154,162,167,168,173,174,175,189,190,200,201}

HeroArr = {2,3,5,8,9,10,12,13,16,17,19,21,22,23,25,27,28,30,32,
			52,58,60,61,63,64,65,66,68,74,75,76,77,78,79,80,
			81,86,87,88,93,98,99,100,102} -- 44
-- 0 ~ 50,00 = *3.5
-- 50,00 ~ 100,000 = *3
-- 100,000 ~ 300,000 = *2
-- 300,000 ~ 500,000= *1.75

LRatio = 4 -- 특수유닛,영작유닛 체력비율증가
MRatio = 3
HRatio = 2.5
ERatio = 1.5
			
HeroHP = {190000*HRatio,100000*MRatio,89999*MRatio,67500*MRatio,320000*HRatio,90000*MRatio,85000*MRatio,1*MRatio,122222*HRatio,75172*MRatio,70000*MRatio,37932*LRatio,777777*ERatio,
		666666*5,72031*MRatio,132913*HRatio,316420*HRatio,69,70000*MRatio,120000*HRatio,80000*MRatio,90000*MRatio,444444*HRatio,8000000,120000*HRatio,110000*HRatio,
		135000*HRatio,5555555,72000*MRatio,60000*MRatio,78000*MRatio,26000*LRatio,45500*LRatio,59898*MRatio,39152*LRatio,91000*MRatio,15215*LRatio,500000*ERatio,67500*MRatio,
		110000*HRatio,50000*LRatio,425000*HRatio,120000,300000*HRatio} -- 44
HPlayer, HPosXY, HPosX, HPosY = CreateVars(4,FP)

CJump(FP,0x203)
Install_HeroSetting = SetCallForward()
SetCall(FP)

CMov(FP,0x6509B0,19025+19)
NIf(FP,{NDeaths(FP,Exactly,1,LvlJump)})
	NWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),NVar(HeroSetting,Exactly,0)})
			CAdd(FP,0x6509B0,6)
			Call_SaveCp() -- Save EPD 25
			for i = 1, #HeroArr do
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,HeroArr[i],0,0xFF)})
					f_Read(FP,_Sub(BackupCp,15),HPosXY) -- Save HeroPosition
					f_Read(FP,_Sub(BackupCp,6),HPlayer,"X",0xFF) -- Save Player
					CMov(FP,HPosX,_Mov(HPosXY,0xFFFF))
					CMov(FP,HPosY,_Div(_Mov(HPosXY,0xFFFF0000),65536))
					Simple_SetLocX(FP,26,_Sub(HPosX,16),_Sub(HPosY,16),_Add(HPosX,16),_Add(HPosY,16))
					CDoActions(FP,{  -- Replace Hero
						TModifyUnitEnergy(1,HeroArr[i],HPlayer,"CLoc27",0);
						TRemoveUnitAt(1,HeroArr[i],"CLoc27",HPlayer);
						TCreateUnit(1,HeroArr[i],"CLoc27",HPlayer);
					})
				CIfEnd()
			end
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,162,0,0xFF)})
						f_Read(FP,_Sub(BackupCp,15),HPosXY) -- Save HeroPosition
						f_Read(FP,_Sub(BackupCp,6),HPlayer,"X",0xFF) -- Save Player
						CMov(FP,HPosX,_Mov(HPosXY,0xFFFF))
						CMov(FP,HPosY,_Div(_Mov(HPosXY,0xFFFF0000),65536))
						Simple_SetLocX(FP,26,_Sub(HPosX,16),_Sub(HPosY,16),_Add(HPosX,16),_Add(HPosY,16))
						CDoActions(FP,{ -- Replace Hero
							TModifyUnitEnergy(1,162,HPlayer,"CLoc27",0);
							TRemoveUnitAt(1,162,"CLoc27",HPlayer);
							TCreateUnit(1,162,"CLoc27",HPlayer);
							SetMemoryX(0x664080 + 162*4,SetTo,0x0,0x1); -- Set Photon Canon Rank
						})
				CIfEnd()
			for i = 1 , #BuildingArr do
				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,BuildingArr[i],0,0xFF)},{ -- Set BID Cloacked
					TSetMemoryX(_Add(BackupCp,30),SetTo,0xB00,0xB00);
					TSetMemoryX(_Add(BackupCp,12),SetTo,0,0xFF0000);
					TSetMemoryX(_Add(BackupCp,32),SetTo,0,0xFFFFFFFF);
				},{Preserved})
			end
				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,114,0,0xFF)},{ -- Set Starport Max Speed (EPD 13)
					TSetMemory(_Sub(BackupCp,12),SetTo,0)
				},{Preserved})
				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,116,0,0xFF)},{ -- Set Facility Max Speed (EPD 13)
					TSetMemory(_Sub(BackupCp,12),SetTo,1200);
				},{Preserved})
				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,130,0,0xFF)},{ -- Set Center Max Speed (EPD 13)
					TSetMemory(_Sub(BackupCp,12),SetTo,0)
				},{Preserved})
			Call_LoadCp() -- EPD 25
			CSub(FP,0x6509B0,6) -- EPD 19
		CIfEnd()

		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),NVar(HeroSetting,Exactly,1)})
			CAdd(FP,0x6509B0,6)
			Call_SaveCp() -- Save EPD 25
				for i = 1, #HeroArr do
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,HeroArr[i],0,0xFF)},{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000);
						MoveCp(Subtract,7*4);
						SetDeaths(CurrentPlayer,SetTo,HeroHP[i]*256,0);
						MoveCp(Add,23*4); -- Recover CP
					},{Preserved})
				end
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,220,0,0xFF)},{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000);
						MoveCp(Add,16*4); -- Recover CP
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,226,0,0xFF)},{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000);
						MoveCp(Add,16*4); -- Recover CP
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,162,0,0xFF)},{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000);
						MoveCp(Add,16*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,150,0,0xFF)},{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000);
						MoveCp(Subtract,7*4);
						SetDeaths(CurrentPlayer,SetTo,169696*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,147,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,300000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,148,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,300000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,168,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,500000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,174,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,100000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,175,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,150000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,189,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,200000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,190,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,444444*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,200,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,120000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
					TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,201,0,0xFF)},{
						MoveCp(Subtract,23*4);
						SetDeaths(CurrentPlayer,SetTo,150000*256,0);
						MoveCp(Add,23*4);
					},{Preserved})
				Call_LoadCp() -- EPD 25
			CSub(FP,0x6509B0,6) -- EPD 19
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	NWhileEnd()
NIfEnd()
CMov(FP,0x6509B0,FP) -- RecoverCp

SetCallEnd()
CJumpEnd(FP,0x203)

CJump(FP,0x204)
SetGUnitHP = SetCallForward()
SetCall(FP)

UIDVar, HPVar = CreateVars(2,FP)
for i = 1, 44 do
	TriggerX(FP,{NVar(UIDVar,Exactly,HeroArr[i])},{SetNVar(HPVar,SetTo,256*HeroHP[i])},{Preserved})
end

SetCallEnd()
CJumpEnd(FP,0x204)

CJump(FP,0x205)
Set_JYD = SetCallForward()
SetCall(FP)

TriggerX(FP,{Switch("Switch 255",Cleared)},{CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere")},{Force2},FP)},{Preserved})
--[[
CMov(FP,0x6509B0,19025+9) -- EPD 9
	NWhile(FP,Memory(0x6509B0,AtMost,19025+9 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,Exactly,0*65536,0,0xFF0000)})
				CAdd(FP,0x6509B0,10)
					TriggerX(FP,{
						DeathsX(CurrentPlayer,AtLeast,5,0,0xFF);
						DeathsX(CurrentPlayer,AtMost,7,0,0xFF)
					},{
						SetDeathsX(CurrentPlayer,SetTo,187*256,0,0xFF00)},{Preserved})
				CSub(FP,0x6509B0,10)
			CIfEnd()
		CAdd(FP,0x6509B0,84)
	NWhileEnd()
CMov(FP,0x6509B0,FP) -- RecoverCp
]]--

SetCallEnd()
CJumpEnd(FP,0x205)

CJump(FP,0x206)
SetCenterJYD = SetCallForward()
SetCall(FP)

CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,5,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)}) -- EPD 19 ( 6p ~ 8p)
	CSub(FP,0x6509B0,10)
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,2*65536,0,0xFF0000)},{SetDeathsX(CurrentPlayer,SetTo,0*65536,0,0xFF0000)}) -- EPD 9 ( Check JYD Unit )
			CAdd(FP,0x6509B0,26)
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF)}) -- EPD 35 ( Check Individual Unit )
					DoActions(FP,{
						MoveCp(Add,37*4);
						SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00); -- EPD 72 ( Turn Off Vision )
						MoveCp(Subtract,53*4);
						SetDeathsX(CurrentPlayer,SetTo,187*256,0,0xFF00); -- EPD 19 ( JYD )
						MoveCp(Add,16*4);
					})
				CIfEnd()
				CIf(FP,{DeathsX(CurrentPlayer,Exactly,1,0,0xFF)}) -- EPD 35 ( Check Individual Unit )
					DoActions(FP,{
						MoveCp(Subtract,16*4);
						SetDeathsX(CurrentPlayer,SetTo,187*256,0,0xFF00); -- EPD 19 ( JYD )
						MoveCp(Add,16*4);
					})
				CIfEnd()
			CSub(FP,0x6509B0,26)
		CIfEnd()
	CAdd(FP,0x6509B0,10)
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP) -- RecoverCp
SetCallEnd()
CJumpEnd(FP,0x206)

-- SetTarget 0x207

------<  PreserveTriggers  >---------------------------------------------
DoActionsX(FP,{
	KillUnit(84,P8);
	KillUnit(84,P5);
	RemoveUnit(33,P8);
	RemoveUnit(203,P5);
	RemoveUnit(204,P5);
	RemoveUnit(205,P5);
	RemoveUnit(20,P12);
	RemoveUnit(0,P12);
	RemoveUnit(20,P12);
	RemoveUnit(124,P12);
	RemoveUnit(125,P12);
	ModifyUnitEnergy(all,"Buildings",Force1,"Anywhere",100);
	ModifyUnitEnergy(all,8,Force2,"Anywhere",100);
	ModifyUnitEnergy(all,16,Force2,"Anywhere",100);
	ModifyUnitEnergy(all,21,Force2,"Anywhere",100);
	ModifyUnitEnergy(all,99,Force2,"Anywhere",100);
	RemoveUnitAt(all,"Factories","BanZone",Force2);
})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{ModifyUnitEnergy(all,63,Force2,"Anywhere",0)},{Preserved})

------<  Level Patch  >---------------------------------------------
T_txt1 = "\x13\x1F─━┫ \x04테스트 버전입니다. 점심버전으로 플레이해주세요. \x1F┣━─"
T_txt2 = "\x13\x1F─━┫ \x04싱글플레이가 감지되었습니다. 치트 멈...춰!! \x1F┣━─"
T_txt3 = "\x13\x1F─━┫ \x1B컴퓨터 슬롯 변경이 감지되었습니다. 깔!!깔!! \x1F┣━─"
T_txt4 = "\x13\x1F─━┫ \x1B컴퓨터 종족 변경이 감지되었습니다. 깔!!깔!! \x1F┣━─"

OPSW = CreateCcode()

Trigger2(Force1,{},{SetMissionObjectives("\n\x13\x03※\x04광산에 일마넣으시면 영마(\x1F10,000원)로 변환됩니다.")}) -- 미션오브젝티브

Trigger { -- 오프닝
	players = {Force1},
	conditions = {
			Always()
		},
	actions = {
			CenterView("Level");
			PlayWAV("staredit\\wav\\scan.ogg");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\n\n\n\n\n\n",4);
			Wait(150);
			CenterView("Level");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
			Wait(150);
			CenterView("Level");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♡ \x11Special \x04Thanks to \x1BNinfia \x04♡\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
			Wait(150);
			CenterView("Level");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♡ \x11Special \x04Thanks to \x1BNinfia \x04♡\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		}
}

Trigger {
	players = {Force1},
	conditions = {
			Always()
	},
	actions = {
		Wait(250);
		CenterView("Level");	
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Level");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 세로\x08２ \x04 -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetSwitch("Switch 249",Set);
		DisplayText("\n\n\n\n\n\n\n\n\n\n\n",4);
	}
}

TriggerX(FP,{},{SetNDeaths(FP,SetTo,1,SelectView);})

CIf(FP,{Switch("Switch 249",Set)})

NJump(FP,1,{NDeaths(FP,Exactly,1,LvlJump)})

DoActionsX(FP,{
	SetNDeaths(FP,SetTo,TMode,TestMode);
	SetNDeaths(FP,SetTo,0,LimitX);
	ModifyUnitEnergy(all,15,Force1,"Anywhere",100);
	ModifyUnitEnergy(all,0,Force1,"Anywhere",100);
	ModifyUnitEnergy(all,194,P8,"Anywhere",100);
	ModifyUnitEnergy(all,195,P8,"Anywhere",100);
	ModifyUnitEnergy(all,196,P8,"Anywhere",100);
},{})
for i = 0, 4 do
TriggerX(FP,{isname(i,"Minfia"),NDeaths(FP,Exactly,TMode,TestMode)},{SetNDeaths(FP,SetTo,1,LimitX)})
end

TriggerX(FP,{NDeaths(FP,Exactly,0,LimitX),NDeaths(FP,Exactly,1,TestMode)},{ -- Test Defeat
	RotatePlayer({DisplayTextX(T_txt1,4)},{P1,P2,P3,P4,P5},FP);
	Wait(1000);
	RotatePlayer({Defeat()},{P1,P2,P3,P4,P5},FP);
})
TriggerX(FP,{Memory(0x57F0B4, Exactly, 0)},{
	CopyCpAction({DisplayTextX(T_txt2,4),Defeat()},{P1,P2,P3,P4,P5},FP)}) -- SinglePlay Defeat
for i = 5, 7 do
	TriggerX(FP,{MemoryX(0x57EEE8 + 36*i,Exactly,0,0xFF)},{ -- 0 = inactive
		CopyCpAction({PlayWAVX("sound\\Misc\\TPwrDown.wav"),DisplayTextX(T_txt3,4),Defeat()},{P1,P2,P3,P4,P5},FP)
	})
end
for i = 5, 7 do
	TriggerX(FP,{MemoryX(0x57EEE8 + 36*i,Exactly,2,0xFF)},{ -- 2 = human
		CopyCpAction({PlayWAVX("sound\\Misc\\TPwrDown.wav"),DisplayTextX(T_txt3,4),Defeat()},{P1,P2,P3,P4,P5},FP)
	})
end


TriggerX(FP,{MemoryX(0x57EFC0,AtLeast,1*256,0xFF00)},{
	CopyCpAction({PlayWAVX("sound\\Misc\\TPwrDown.wav"),DisplayTextX(T_txt4,4),Defeat()
	},{P1,P2,P3,P4,P5},FP)})
TriggerX(FP,{MemoryX(0x57EFE4,AtLeast,1*256,0xFF00)},{
	CopyCpAction({PlayWAVX("sound\\Misc\\TPwrDown.wav"),DisplayTextX(T_txt4,4),Defeat()
	},{P1,P2,P3,P4,P5},FP)})

TriggerX(P1,{NDeaths(FP,Exactly,0,LvlJump),Switch("Switch 249",Set)},{
		CreateUnit(1,15,"Level",P1);
		CreateUnit(1,95,"BanZone",P1);
		
	})
TriggerX(P2,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P2);
		CreateUnit(1,95,"BanZone",P2);
		
	})
TriggerX(P3,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		PlayerCheck(P2,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P3);
		CreateUnit(1,95,"BanZone",P3);
		
	})
TriggerX(P4,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		PlayerCheck(P2,0);
		PlayerCheck(P3,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P4);
		CreateUnit(1,95,"BanZone",P4);
		
	})
TriggerX(P5,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		PlayerCheck(P2,0);
		PlayerCheck(P3,0);
		PlayerCheck(P4,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P5);
		CreateUnit(1,95,"BanZone",P5);
		
	})

for i = 0, 4 do
TriggerX(i,{Bring(CP,Exactly,0,15,"Level2"),NDeaths(FP,Exactly,1,SelectView);},{MoveUnit(1,15,CP,"Anywhere","Level")},{Preserved})
end
TriggerX(FP,{NDeaths(FP,Exactly,1,SelectView)},{
	ModifyUnitEnergy(1,194,P8,"Anywhere",0);
	ModifyUnitEnergy(1,195,P8,"Anywhere",0);
	ModifyUnitEnergy(1,196,P8,"Anywhere",0);
	ModifyUnitEnergy(1,199,P8,"Anywhere",0);
	ModifyUnitEnergy(all,0,Force1,"Anywhere",100);
	MoveUnit(all,0,Force1,"Anywhere","Level");
	CopyCpAction({CenterView("Level")},{P1,P2,P3,P4,P5},FP)
},{Preserved})


for i = 1, 3 do
Trigger {
	players = {FP},
	conditions = {
			Label(0);
			Bring(Force1,Exactly,1,15,GModeLocArr[i]);
		},
	actions = {
			ModifyUnitEnergy(all,15,Force1,"Anywhere",0);
			ModifyUnitEnergy(all,194,P8,"Anywhere",0);
			ModifyUnitEnergy(all,195,P8,"Anywhere",0);
			ModifyUnitEnergy(all,196,P8,"Anywhere",0);
			ModifyUnitEnergy(all,199,P8,"Anywhere",0);
			RemoveUnit(15,Force1);
			RemoveUnit(194,P8);
			RemoveUnit(195,P8);
			RemoveUnit(196,P8);
			RemoveUnit(199,P8);
			CopyCpAction({PlayWAVX("staredit\\wav\\OpeningB.ogg"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
			SetCVar(FP,GMode,SetTo,i);
			SetNDeaths(FP,SetTo,1,LvlJump);
			SetMinimapColor(P9,SetTo,0);
			SetPlayerColor(P9,SetTo,0);
			SetMinimapColor(P10,SetTo,0);
			SetPlayerColor(P10,SetTo,0);
			SetMinimapColor(P11,SetTo,0);
			SetPlayerColor(P11,SetTo,0);
			--SetSwitch("Switch 255", Set); -- 건작 잠금
		}
}
end
NJumpEnd(FP,1)

HardSoloTxt = "\x13\x1B─━┫ \x06하드 \x04솔플클리어 수고하셨습니다. 영웅마린 3마리, 미네랄 지급 \x1B┣━─"
HardClearTxt = "\x13\x1B─━┫ \x06하드 \x04클리어 수고하셨습니다. 영웅마린 3마리, 미네랄 지급 \x1B┣━─"

CIfOnce(FP,{CVar("X",GMode,Exactly,1)},{SetNDeaths(FP,SetTo,0,SelectView)})
		SetHeroUpgrade(5,5)
		SetHeroUpgrade(6,5)
		SetHeroUpgrade(7,7)
		SetZergUpgrade(5,0)
		SetZergUpgrade(6,0)
		SetZergUpgrade(7,2)
	DoActions2(FP,UpgradeSetting)
		
	DoActions2(FP,{
		SetPlayerColor(5,SetTo,196); -- 199
		SetPlayerColor(6,SetTo,184); -- 190
		SetPlayerColor(7,SetTo,54); -- 12
		SetMinimapColor(5,SetTo,59);
		SetMinimapColor(6,SetTo,8);
		SetMinimapColor(7,SetTo,54);
		SetWeaponDamage(27,0); -- 아덴시즈
		SetExtraUpgrade(4,1); -- 777 Upgrade
		SetExtraUpgrade(2,3); -- Mine Upgrade
		SetExtraUpgrade(0,3); -- PhotonCanon Upgrade
		
		SetSwitch("Switch 250",Set);
		SetResources(Force2,Add,10000000,OreAndGas);
		SetInvincibility(Disable,176,P6,"Anywhere");
		SetInvincibility(Disable,177,P6,"Anywhere");
		SetInvincibility(Disable,178,P6,"Anywhere");
		SetInvincibility(Disable,176,P7,"Anywhere");
		SetInvincibility(Disable,177,P7,"Anywhere");
		SetInvincibility(Disable,178,P7,"Anywhere");
		RemoveUnit(101,Force1);
		SetResources(Force1,Add,5000,Ore);
		CreateUnit(1,46,"MB1",P6);
		CreateUnit(1,46,"MB1",P7);
		CreateUnit(1,46,"MB1",P8);
			})
	DoActionsX(FP,{
		SetNVar(MaxDCount,SetTo,999);
		SetMemoryB(0x662DB8+13,SetTo,6); -- Seek Range
		SetMemoryB(0x656888+6,SetTo,100); -- Splash Inner Radius
		SetMemoryB(0x6570C8+6,SetTo,150); -- Splash Middle Radius
		SetMemoryB(0x657780+6,SetTo,200); -- Splash Outer Radius
		SetMemoryX(0x664080+4*13,SetTo,0x0,0x4); -- Set Non-Flyer
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P6_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P6},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P7_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P7},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P8_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P8},FP);
		CopyCpAction({CenterView("HZ")},{Force1,Force5},FP);
			})
CIfEnd()
CIfOnce(FP,{CVar("X",GMode,Exactly,2)},{SetNDeaths(FP,SetTo,0,SelectView)})
		SetHeroUpgrade(5,10);
		SetHeroUpgrade(6,10);
		SetHeroUpgrade(7,12);
		SetZergUpgrade(5,5);
		SetZergUpgrade(6,5);
		SetZergUpgrade(7,7);
	DoActions2(FP,UpgradeSetting)
		
	DoActions2(FP,{
		SetPlayerColor(5,SetTo,157); -- 158
		SetPlayerColor(6,SetTo,190); -- 191
		SetPlayerColor(7,SetTo,8); -- 124
		SetMinimapColor(5,SetTo,49);
		SetMinimapColor(6,SetTo,59);
		SetMinimapColor(7,SetTo,8);
		SetExtraUpgrade(4,11); -- 777 Upgrade
		SetExtraUpgrade(2,4); -- Mine Upgrade
		SetExtraUpgrade(0,5); -- PhotonCanon Upgrade
		SetSwitch("Switch 250",Set);
		SetResources(Force2,Add,10000000,OreAndGas);
		SetInvincibility(Disable,176,P6,"Anywhere");
		SetInvincibility(Disable,177,P6,"Anywhere");
		SetInvincibility(Disable,178,P6,"Anywhere");
		SetInvincibility(Disable,176,P7,"Anywhere");
		SetInvincibility(Disable,177,P7,"Anywhere");
		SetInvincibility(Disable,178,P7,"Anywhere");
		RemoveUnit(101,Force1);
		SetResources(Force1,Add,7500,Ore);
		CreateUnit(1,46,"MB1",P6);
		CreateUnit(1,46,"MB1",P7);
		CreateUnit(1,46,"MB1",P8);
			})
	DoActionsX(FP,{
		SetNVar(MaxDCount,SetTo,300);
		SetNVar(PUnit,SetTo,102);
		SetNVar(EXGunDataIndex,SetTo,4);
		SetNVar(JYDTimer,SetTo,60*30);
		SetMemoryB(0x662DB8+13,SetTo,8); -- Seek Range
		SetMemoryB(0x656888+6,SetTo,100+100); -- Splash Inner Radius
		SetMemoryB(0x6570C8+6,SetTo,150+100); -- Splash Middle Radius
		SetMemoryB(0x657780+6,SetTo,200+100); -- Splash Outer Radius
		SetMemoryX(0x664080+4*13,SetTo,0x4,0x4); -- Set Flyer
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P6_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P6},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P7_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P7},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P8_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P8},FP);
		CopyCpAction({CenterView("HZ")},{Force1,Force5},FP);
			})
			for i = 0, 4 do
				TriggerX(FP,{isname(i,Name1)},{
					CreateUnit2(3,20,"HZ",i),SetResources(i,Add,10000,Ore);
					CopyCpAction({DisplayTextX(HardSoloTxt,4)},{i},P8);
				})
			end
			for j = 1, #NameArr do
				for i = 0, 4 do
					TriggerX(FP,{isname(i,NameArr[j])},{
						CreateUnit2(3,20,"HZ",i),SetResources(i,Add,10000,Ore);
						CopyCpAction({DisplayTextX(HardClearTxt,4)},{i},P8);
					})
				end
			end
CIfEnd()

CIfOnce(FP,{CVar("X",GMode,Exactly,3)},{SetNDeaths(FP,SetTo,0,SelectView)})
		SetHeroUpgrade(5,12);
		SetHeroUpgrade(6,12);
		SetHeroUpgrade(7,13);
		SetZergUpgrade(5,7);
		SetZergUpgrade(6,7);
		SetZergUpgrade(7,8);
	DoActions2(FP,UpgradeSetting)
	
	DoActions2(FP,{
		SetExtraUpgrade(4,111); -- 777 Upgrade
		SetExtraUpgrade(2,5); -- Mine Upgrade
		SetExtraUpgrade(0,6); -- PhotonCanon Upgrade
		SetPlayerColor(5,SetTo,85); -- 78
		SetPlayerColor(6,SetTo,128); -- 52
		SetPlayerColor(7,SetTo,246); -- 45
		SetMinimapColor(5,SetTo,85);
		SetMinimapColor(6,SetTo,128);
		SetMinimapColor(7,SetTo,246);
		SetSwitch("Switch 250",Set);
		SetResources(Force2,Add,10000000,OreAndGas);
		SetInvincibility(Disable,176,P6,"Anywhere");
		SetInvincibility(Disable,177,P6,"Anywhere");
		SetInvincibility(Disable,178,P6,"Anywhere");
		SetInvincibility(Disable,176,P7,"Anywhere");
		SetInvincibility(Disable,177,P7,"Anywhere");
		SetInvincibility(Disable,178,P7,"Anywhere");
		RemoveUnit(101,Force1);
		SetResources(Force1,Add,25000,Ore);
		CreateUnit(3,20,"HZ",Force1);
		CreateUnit(1,46,"MB1",P6);
		CreateUnit(1,46,"MB1",P7);
		CreateUnit(1,46,"MB1",P8);
			})
	DoActionsX(FP,{
		SetNVar(MaxDCount,SetTo,400);
		SetNVar(PUnit,SetTo,9);
		SetNVar(EXGunDataIndex,SetTo,5);
		SetNVar(JYDTimer,SetTo,60*45);
		SetMemoryB(0x662DB8+13,SetTo,10); -- Seek Range
		SetMemoryB(0x656888+6,SetTo,100+200); -- Splash Inner Radius
		SetMemoryB(0x6570C8+6,SetTo,150+200); -- Splash Middle Radius
		SetMemoryB(0x657780+6,SetTo,200+200); -- Splash Outer Radius
		SetMemoryX(0x664080+4*13,SetTo,0x4,0x4); -- Set Flyer
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P6_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P6},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P7_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P7},FP);
		CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P8_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P8},FP);
		CopyCpAction({CenterView("HZ")},{Force1,Force5},FP);
			})
CIfEnd()

KPRate = CreateVar(FP)
KPTempV = CreateVar(FP)
HPTempV = CreateVar(FP)
HPOffset = CreateVar(FP)
KPRateArr = {30,30,30,35,35}

CIfOnce(FP,{NDeaths(FP,Exactly,1,LvlJump);}) -- After HeroSetting
	CFor(FP,0,105,1)
		local UnitIndex = CForVariable()
		f_WreadX(FP, 0x663EB8, UnitIndex, KPTempV)
		CMovX(FP,VArr(KillPointVArr,UnitIndex),KPTempV)

		f_Read(FP,_Add(_Mul(UnitIndex,4),EPD(0x662350)),_Mul(HPTempV,256))
		CMovX(FP,VArr(HPVArr,UnitIndex),HPTempV)
	CForEnd()

for i = 1, 5 do
	TriggerX(FP,{Bring(Force1,Exactly,i,111,"HZ")},{
		SetNVar(KPRate,SetTo,KPRateArr[i]);
		SetCVar(FP,CPlayer,SetTo,i); -- 초기 플레이어수 체크
		SetDeaths(i-1,SetTo,0,0);
	})
end
DoActions(FP,BleedingDrawFunc(17))

CallTrigger(FP,Install_HeroSetting) -- 테스트
CIfEnd() -- CIfOnceEnd.

CIfEnd() -- Switch 249 Set

CIf(FP,{Deaths(P10,Exactly,0,201)}) -- 트리거 잠금
------<  KillPoint Trig  >---------------------------------------------
PointTemp = CreateVar(FP)

--PArr = {{P2,P3,P4,P5},{P1,P3,P4,P5},{P1,P2,P4,P5},{P1,P2,P3,P5},{P1,P2,P3,P4}}


CIf(FP,CVar("X",CPlayer,AtLeast,2))
	CFor(FP,0,5,1)
	local CForPlayer = CForVariable()
		for i = 0, 104 do
			CIf(FP,{TKills(CForPlayer,AtLeast,1,i)})
				f_Div(FP,PointTemp,VArr(KillPointVArr,i),KPRate)
				CDoActions(FP,{
					TSetScore(Force1, Add, PointTemp, Kills);
					TSetScore(CForPlayer, Subtract, PointTemp, Kills);
					TSetKills(CForPlayer,Subtract,1,i);
				})
			CIfEnd()
		end
	CForEnd()
CIfEnd()



------<  Player/MinimapColor Trig  >---------------------------------------------
ColorTimer = CreateVar(FP)
CIfX(FP,CVar("X",GMode,Exactly,1))
	TriggerX(FP,{NVar(ColorTimer,AtLeast,18)},{SetNVar(ColorTimer,SetTo,0)},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,0)},{
			SetPlayerColor(5,SetTo,126); -- 78
			SetPlayerColor(6,SetTo,85); -- 52
			SetPlayerColor(7,SetTo,247); -- 45
			SetMinimapColor(5,SetTo,126);
			SetMinimapColor(6,SetTo,85);
			SetMinimapColor(7,SetTo,247);
		},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,9)},{
			SetPlayerColor(5,SetTo,127);
			SetPlayerColor(6,SetTo,154); --154
			SetPlayerColor(7,SetTo,247);
			SetMinimapColor(5,SetTo,127);
			SetMinimapColor(6,SetTo,154);
			SetMinimapColor(7,SetTo,247);
		},{Preserved})
	DoActionsX(FP,SetNVar(ColorTimer,Add,1))
CElseIfX({CVar("X",GMode,Exactly,2)})
	TriggerX(FP,{NVar(ColorTimer,AtLeast,18)},{SetNVar(ColorTimer,SetTo,0)},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,0)},{
			SetPlayerColor(5,SetTo,126); -- 78
			SetPlayerColor(6,SetTo,85); -- 52
			SetPlayerColor(7,SetTo,8); -- 45
			SetMinimapColor(5,SetTo,126);
			SetMinimapColor(6,SetTo,85);
			SetMinimapColor(7,SetTo,8);
		},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,9)},{
			SetPlayerColor(5,SetTo,127);
			SetPlayerColor(6,SetTo,154); --154
			SetPlayerColor(7,SetTo,8);
			SetMinimapColor(5,SetTo,127);
			SetMinimapColor(6,SetTo,154);
			SetMinimapColor(7,SetTo,8);
		},{Preserved})
	DoActionsX(FP,SetNVar(ColorTimer,Add,1))
CElseIfX({CVar("X",GMode,Exactly,3)})
	TriggerX(FP,{NVar(ColorTimer,AtLeast,18)},{SetNVar(ColorTimer,SetTo,0)},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,0)},{
			SetPlayerColor(5,SetTo,126); -- 78
			SetPlayerColor(6,SetTo,85); -- 52
			SetPlayerColor(7,SetTo,128); -- 45
			SetMinimapColor(5,SetTo,126);
			SetMinimapColor(6,SetTo,85);
			SetMinimapColor(7,SetTo,128);
		},{Preserved})
		TriggerX(FP,{NVar(ColorTimer,Exactly,9)},{
			SetPlayerColor(5,SetTo,127);
			SetPlayerColor(6,SetTo,154); --154
			SetPlayerColor(7,SetTo,128);
			SetMinimapColor(5,SetTo,127);
			SetMinimapColor(6,SetTo,154);
			SetMinimapColor(7,SetTo,128);
		},{Preserved})
	DoActionsX(FP,SetNVar(ColorTimer,Add,1))
CIfXEnd()
------<  LeaderBoard Trig  >---------------------------------------------

DoActionsX(FP,SetCVar("X",LB,Add,1))
-- ─━┫ ┣━─
DifLB = {{" 『 \x08Max\x04 999 \x04』\x04─━┫ \x03Normal \x04┣━─",
			" 『 \x08Max\x04 300 \x04』\x04─━┫ \x08Hard \x04┣━─",
			" 『 \x08Max\x04 400 \x04』\x04─━┫ \x10Lunatic \x04┣━─"},
		{" \x04─━┫ \x03Normal \x04┣━─",
			" \x04─━┫ \x08Hard \x04┣━─",
			" \x04─━┫ \x10Lunatic \x04┣━─"}
		}
DifLBS = {{" 『 \x08Max\x04 999 \x04』\x04─━┫ \x03Normal \x04┣━─",
			" 『 \x08Max\x04 450 \x04』\x04─━┫ \x08Hard \x04┣━─",
			" 『 \x08Max\x04 550 \x04』\x04─━┫ \x10Lunatic \x04┣━─"},
		{" \x04─━┫ \x03Normal \x04┣━─",
			" \x04─━┫ \x08Hard \x04┣━─",
			" \x04─━┫ \x10Lunatic \x04┣━─"}
		}
CIf(FP,{CVar("X",CPlayer,Exactly,1)})
	for i = 1, 3 do
		TriggerX(FP,{CVar("X",LB,Exactly,1),CVar("X",GMode,Exactly,i)},LeaderBoardScore(Kills,"\x1FP\x04oints" ..DifLBS[2][i]),{Preserved})
		TriggerX(FP,{CVar("X",LB,Exactly,171),CVar("X",GMode,Exactly,i)},LeaderBoardScore(Custom,"\x06D\x04eaths" ..DifLBS[1][i]),{Preserved})
	end
CIfEnd()

CIf(FP,{CVar("X",CPlayer,AtLeast,2)})
	for i = 1, 3 do
		TriggerX(FP,{CVar("X",LB,Exactly,1),CVar("X",GMode,Exactly,i)},LeaderBoardScore(Kills,"\x1FP\x04oints" ..DifLB[2][i]),{Preserved})
		TriggerX(FP,{CVar("X",LB,Exactly,171),CVar("X",GMode,Exactly,i)},LeaderBoardScore(Custom,"\x06D\x04eaths" ..DifLB[1][i]),{Preserved})
	end
CIfEnd()

TriggerX(FP,CVar("X",LB,AtLeast,340),SetCVar("X",LB,SetTo,0),{Preserved})
DoActions(FP,{LeaderBoardComputerPlayers(Disable)},{})

------<  Defeat Trig  >---------------------------------------------

TriggerX(FP,{CVar("X",GMode,Exactly,2),CVar("X",CPlayer,Exactly,1)},{SetNVar(MaxDCount,SetTo,450)}) -- 솔플 데카제한
TriggerX(FP,{CVar("X",GMode,Exactly,3),CVar("X",CPlayer,Exactly,1)},{SetNVar(MaxDCount,SetTo,550)}) -- 솔플 데카제한

CTrigger(FP,{
		TScore(P1,Custom,AtLeast,MaxDCount);
		NDeaths(FP,Exactly,0,SelectView)},
			{
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ 저런... 얼마나 죽으신겁니까? 나약하시군요 깔깔!! \x1B。˙+˚Game Over。>_< +.˚”\x04━━━━━━━━━━",4),Defeat()},{P1},FP);
		ModifyUnitEnergy(all,"Any unit",P1,"Anywhere",0);
		RemoveUnit("Any unit",P1);
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ \x08P1\x04이(가) 개쳐맞고 \x08데카아웃\x04당하였습니다.”\x04━━━━━━━━━━",4)},{P2,P3,P4,P5},FP);
		}
	)


CTrigger(FP,{
		TScore(P2,Custom,AtLeast,MaxDCount);
		NDeaths(FP,Exactly,0,SelectView)},
			{
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ 저런... 얼마나 죽으신겁니까? 나약하시군요 깔깔!! \x1B。˙+˚Game Over。>_< +.˚”\x04━━━━━━━━━━",4),Defeat()},{P2},FP);
		ModifyUnitEnergy(all,"Any unit",P2,"Anywhere",0);
		RemoveUnit("Any unit",P2);
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“\x0EP2\x04이(가) 개쳐맞고 \x08데카아웃\x04당하였습니다.”\x04━━━━━━━━━━",4)},{P1,P3,P4,P5},FP);
		}
	)

CTrigger(FP,{
		TScore(P3,Custom,AtLeast,MaxDCount);
		NDeaths(FP,Exactly,0,SelectView)},
			{
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ 저런... 얼마나 죽으신겁니까? 나약하시군요 깔깔!! \x1B。˙+˚Game Over。>_< +.˚”\x04━━━━━━━━━━",4),Defeat()},{P3},FP);
		ModifyUnitEnergy(all,"Any unit",P3,"Anywhere",0);
		RemoveUnit("Any unit",P3);
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ \x0FP3\x04이(가) 개쳐맞고 \x08데카아웃\x04당하였습니다.”\x04━━━━━━━━━━",4)},{P1,P2,P4,P5},FP);
		}
	)

CTrigger(FP,{
		TScore(P4,Custom,AtLeast,MaxDCount);
		NDeaths(FP,Exactly,0,SelectView)},
			{
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ 저런... 얼마나 죽으신겁니까? 나약하시군요 깔깔!! \x1B。˙+˚Game Over。>_< +.˚”\x04━━━━━━━━━━",4),Defeat()},{P4},FP);
		ModifyUnitEnergy(all,"Any unit",P4,"Anywhere",0);
		RemoveUnit("Any unit",P4);
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ \x10P4\x04이(가) 개쳐맞고 \x08데카아웃\x04당하였습니다.”\x04━━━━━━━━━━",4)},{P1,P2,P3,P5},FP);
		}
	)

CTrigger(FP,{
		TScore(P5,Custom,AtLeast,MaxDCount);
		NDeaths(FP,Exactly,0,SelectView)},
			{
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ 저런... 얼마나 죽으신겁니까? 나약하시군요 깔깔!! \x1B。˙+˚Game Over。>_< +.˚”\x04━━━━━━━━━━",4),Defeat()},{P5},FP);
		ModifyUnitEnergy(all,"Any unit",P5,"Anywhere",0);
		RemoveUnit("Any unit",P5);
		RotatePlayer({DisplayTextX("\x13\x04━━━━━━━━━━\x04“ \x11P5\x04이(가) 개쳐맞고 \x08데카아웃\x04당하였습니다.”\x04━━━━━━━━━━",4)},{P1,P2,P3,P4},FP);
		}
	)



------<  Counting Units / Players Trig >---------------------------------------------

TriggerX(FP,Always(),{FSetMemory(0x0582264,SetTo,2000),
		FSetMemory(0x0582268,SetTo,2000),
		FSetMemory(0x058226C,SetTo,2000),
		FSetMemory(0x0582270,SetTo,2000),
		FSetMemory(0x0582274,SetTo,2000),

		FSetMemory(0x05822C4,SetTo,3000), -- Max Unit (Over 1000, Max 1500)
		FSetMemory(0x05822C8,SetTo,3000),
		FSetMemory(0x05822CC,SetTo,3000),
		FSetMemory(0x05822D0,SetTo,3000),
		FSetMemory(0x05822D4,SetTo,3000)})

SpriteCount, SubCount1, SubCount2, SubCount3, SubCount4, SubCount5, SubCount6, SubCount7 = CreateVars(8,FP)

CheckSTGun = CreateCcode()

UnitReadX(FP,AllPlayers,"Any unit","Anywhere",AllUnitX)
UnitReadX(FP,AllPlayers,2,nil,SubCount1)
UnitReadX(FP,AllPlayers,3,nil,SubCount2)
UnitReadX(FP,AllPlayers,5,nil,SubCount3)
UnitReadX(FP,AllPlayers,17,nil,SubCount4)
UnitReadX(FP,AllPlayers,23,nil,SubCount5)
UnitReadX(FP,AllPlayers,25,nil,SubCount6)
UnitReadX(FP,AllPlayers,30,nil,SubCount7)

CMov(FP,AllUnit,_Add(AllUnitX,_Add(SubCount1,_Add(SubCount2,_Add(SubCount3,_Add(SubCount4,_Add(SubCount5,_Add(SubCount6,SubCount7))))))))


TriggerX(FP,{CDeathsX("X",Exactly,1,CheckSTGun,0xFF)},{SetNVar(SpriteCount,Add,3*(64+8))})
TriggerX(FP,{CDeathsX("X",Exactly,1*256,CheckSTGun,0xFF00)},{SetNVar(SpriteCount,Add,3*(64+8))})
TriggerX(FP,{CDeathsX("X",Exactly,1*65536,CheckSTGun,0xFF0000)},{SetNVar(SpriteCount,Add,3*(64+8))})
TriggerX(FP,{CDeathsX("X",Exactly,1*16777216,CheckSTGun,0xFF000000)},{SetNVar(SpriteCount,Add,3*(64+8))})

CMov(FP,AllUnit,_Add(AllUnitX,SpriteCount))


CDoActions(FP,{
		TSetMemory(0x582294,SetTo,_Mul(AllUnit,2));
		TSetMemory(0x582298,SetTo,_Mul(AllUnit,2));
		TSetMemory(0x58229C,SetTo,_Mul(AllUnit,2));
		TSetMemory(0x5822A0,SetTo,_Mul(AllUnit,2));
		TSetMemory(0x5822A4,SetTo,_Mul(AllUnit,2));
	})

for i = 0, 4 do
	TriggerX(FP,{Command(Force1,Exactly,i+1,111)},{SetNDeaths(FP,SetTo,i+1,P_Count)},{Preserved}) -- 상시 플레이어수 체크
end
------<  Mar Limit Trig >---------------------------------------------

LimitM = CreateVar(FP)

LimitM_N = {240,144,120,96,72}
LimitM_H = {360,192,168,144,120}
LimitM_L = {480,240,216,192,168}

CIf(FP,NDeaths(FP,Exactly,1,LvlJump))
	CIfX(FP,{CVar("X",GMode,Exactly,1)})
			for i = 1, 5 do
				TriggerX(FP,{NDeaths(FP,Exactly,i,P_Count)},{SetNVar(LimitM,SetTo,4*LimitM_N[i])})
			end
		CElseIfX({CVar("X",GMode,Exactly,2)})
			for i = 1, 5 do
				TriggerX(FP,{NDeaths(FP,Exactly,i,P_Count)},{SetNVar(LimitM,SetTo,4*LimitM_H[i])})
			end
		CElseIfX({CVar("X",GMode,Exactly,3)})
			for i = 1, 5 do
				TriggerX(FP,{NDeaths(FP,Exactly,i,P_Count)},{SetNVar(LimitM,SetTo,4*LimitM_L[i])})
			end
	CIfXEnd()
CDoActions(FP,{
	TSetMemory(0x582234+4*0,SetTo,LimitM); -- Max TPop
	TSetMemory(0x582234+4*1,SetTo,LimitM);
	TSetMemory(0x582234+4*2,SetTo,LimitM);
	TSetMemory(0x582234+4*3,SetTo,LimitM);
	TSetMemory(0x582234+4*4,SetTo,LimitM);

	TSetMemory(0x5821D4+4*0,SetTo,LimitM); -- Available TPop
	TSetMemory(0x5821D4+4*1,SetTo,LimitM);
	TSetMemory(0x5821D4+4*2,SetTo,LimitM);
	TSetMemory(0x5821D4+4*3,SetTo,LimitM);
	TSetMemory(0x5821D4+4*4,SetTo,LimitM);
})
CIfEnd()

------<  CanNot Panalty Trig  >---------------------------------------------
CanNotText = "\x13\x1F─━┫ \x06캔낫\x04이 감지되어 필드위의 \x11일부유닛\x04을 \x08삭제\x04합니다. \x1B Cannot Count +1↑ \x1F┣━─"
CanNotDefeat = "\x13\x1F─━┫ \x06캔낫 \x04카운트가 3회이상 누적되어 패배합니다. \x1B。˚Game Over。˚\x1F┣━─"
for i = 0, 4 do
Trigger { -- Set First C_Count ( 0 / 3 )
	players = {FP},
	conditions = {
			Always();
		},
	actions = {
			LimitC(i,0);
			LimitCMax(i,3)
		}
}
end

ClearField = SetSwitch("Switch 254", Set)

CIf(FP,{NVar(HeroSetting,Exactly,1)})

DoActionsX(FP,{SetNDeaths(FP,Subtract,1,C_Delay)})

CIf(FP,{NVar(AllUnit,AtLeast,1300),NDeaths(FP,Exactly,0,C_Delay)}) -- 유닛수 1300이상일때

TriggerX(FP,{-- 1캔
	NDeaths(FP,Exactly,0,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,1),LimitC(1,1),LimitC(2,1),LimitC(3,1),LimitC(4,1);
	RotatePlayer({DisplayTextX(CanNotText,4),PlayWAVX("sound\\Bullet\\TNsHit00.wav"),PlayWAVX("sound\\Bullet\\TNsHit00.wav")},{Force1,Force5},FP);
	ClearField;
	SetNDeaths(FP,SetTo,1,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
})

TriggerX(FP,{ -- 2캔
	NDeaths(FP,Exactly,1,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,2),LimitC(1,2),LimitC(2,2),LimitC(3,2),LimitC(4,2);
	RotatePlayer({DisplayTextX(CanNotText,4),PlayWAVX("sound\\Bullet\\TNsHit00.wav"),PlayWAVX("sound\\Bullet\\TNsHit00.wav")},{Force1,Force5},FP);
	ClearField;
	SetNDeaths(FP,SetTo,2,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
})

TriggerX(FP,{ -- 3캔 (패배)
	NDeaths(FP,Exactly,2,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,3),LimitC(1,3),LimitC(2,3),LimitC(3,3),LimitC(4,3);
	RotatePlayer({DisplayTextX(CanNotDefeat,4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),Defeat()},{Force1},FP);
	ClearField;
	SetNDeaths(FP,SetTo,3,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
	SetSwitch("Switch 255", Set); -- 건작 잠금
})
CallTrigger(FP,Set_JYD)
CIfEnd()

CIf(FP,{Memory(0x628438,Exactly,0),NDeaths(FP,Exactly,0,C_Delay)}) -- Nextptr 0 일때

TriggerX(FP,{-- 1캔
	NDeaths(FP,Exactly,0,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,1),LimitC(1,1),LimitC(2,1),LimitC(3,1),LimitC(4,1);
	RotatePlayer({DisplayTextX(CanNotText,4),PlayWAVX("sound\\Bullet\\TNsHit00.wav"),PlayWAVX("sound\\Bullet\\TNsHit00.wav")},{Force1,Force5},FP);
	ClearField;
	SetNDeaths(FP,SetTo,1,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
})

TriggerX(FP,{ -- 2캔
	NDeaths(FP,Exactly,1,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,2),LimitC(1,2),LimitC(2,2),LimitC(3,2),LimitC(4,2);
	RotatePlayer({DisplayTextX(CanNotText,4),PlayWAVX("sound\\Bullet\\TNsHit00.wav"),PlayWAVX("sound\\Bullet\\TNsHit00.wav")},{Force1,Force5},FP);
	ClearField;
	SetNDeaths(FP,SetTo,2,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
})

TriggerX(FP,{ -- 3캔 (패배)
	NDeaths(FP,Exactly,2,C_Count);
	NDeaths(FP,Exactly,0,C_Delay);
	NDeaths(FP,Exactly,0,SelectView)
},{
	LimitC(0,3),LimitC(1,3),LimitC(2,3),LimitC(3,3),LimitC(4,3);
	RotatePlayer({DisplayTextX(CanNotDefeat,4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),Defeat()},{Force1},FP);
	ClearField;
	SetNDeaths(FP,SetTo,3,C_Count);
	SetNDeaths(FP,SetTo,170,C_Delay);
	SetSwitch("Switch 255", Set); -- 건작 잠금
})
CallTrigger(FP,Set_JYD)
CIfEnd()

TriggerX(FP,Switch("Switch 254", Set),{
	KillUnit(35,Force2),
	KillUnit(36,Force2),
	KillUnit("Factories",Force2),
	KillUnit(48,Force2),
	KillUnit(50,Force2),
	KillUnit(51,Force2),
	KillUnit(53,Force2),
	KillUnit(54,Force2),
	KillUnit(55,Force2),
	KillUnit(56,Force2),
	KillUnit(62,Force2),
	KillUnit(104,Force2),
	KillUnit(97,Force2),
	SetSwitch("Switch 254",Clear)},{Preserved})

CIfEnd()



------<  Marine // Heal Trig  >---------------------------------------------


for i = 0, 4 do
TriggerX(FP,{CVar("X",CPlayer,Exactly,1),Deaths(i,AtLeast,1,20)},{SetScore(i, Add, 1, Custom),SetDeaths(i, Subtract, 1, 20)},{Preserved})
TriggerX(FP,{CVar("X",CPlayer,AtLeast,2),Deaths(i,AtLeast,1,20)},{SetScore(i, Add, 2, Custom),SetDeaths(i, Subtract, 1, 20)},{Preserved})

CTrigger(i,{
	TMemory(0x582204+4*i,AtMost,LimitM);
	Bring(CP,AtLeast,1,80,"Anywhere");
},{
	ModifyUnitEnergy(1,80,CP,"Anywhere",0);
	RemoveUnitAt(1,80,"Anywhere",CP);
	CreateUnit2(1,20,"HZ",CP);
	DisplayText("\x1F─━┫ “ \x08H\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-15,000 \x1FOre\x04」”", 4);
},{Preserved})

CTrigger(i,{
	TMemory(0x582204+4*i,AtMost,LimitM);
	Bring(CP,AtLeast,1,0,"Hero");
	Accumulate(CP,AtLeast,10000,Ore);
},{
	SetResources(CP,Subtract,10000,Ore);
	ModifyUnitEnergy(1,0,CP,"Hero",0);
	RemoveUnitAt(1,0,"Hero",CP);
	CreateUnit2(1,20,"HeroDest",CP);
	DisplayText("\x1F─━┫ “ \x08H\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-10,000 \x1FOre\x04」”", 4);
},{Preserved})

CTrigger(i,{
	TMemory(0x582204+4*i,AtMost,LimitM);
	Bring(CP,AtLeast,1,82,"HZ");
},{
	RemoveUnitAt(1,82,"HZ",i);
	CreateUnit2(1,0,"HZ",i);
	DisplayText("\x1F─━┫ “ \x0EM\x04arine 을 소환하였습니다. 「\x08-5,000 \x1FOre\x04」”", 4);
},{Preserved})

Trigger { -- First Heal Value
	players = {i},
	conditions = {
			Label(0);
			Always()
		},
	actions = {
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,1);
			SetMemoryB(0x57F27C+(i*228)+1,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,0);
		}
}

end

--DoActions(FP,{RemoveUnit(80,Force1),RemoveUnit(82,Force1)}) -- 오류방지


CIf(Force1,{Bring(CP,AtLeast,1,12,"HZ")})

for i = 0, 4 do

Trigger { -- 2 tik Heal
	players = {i},
	conditions = {
			Label(0);
			Bring(i,AtLeast,1,12,"HZ");
			NDeaths(i,Exactly,0,HTik);
		},
	actions = {
			GiveUnits(all,12,i,"Anywhere",P12);
			RemoveUnit(12,P12);
			DisplayText("\x1F─━┫“ \x04예약 \x0F메딕(2 tik) \x04기능을 사용합니다\x04. 「\x0F225ore\x04」\x0F”", 4);
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+1,SetTo,1);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,0);
			SetNDeaths(i,SetTo,1,HTik);
			PreserveTrigger()
		}
}

Trigger { -- 3 tik Heal
	players = {i},
	conditions = {
			Label(0);
			Bring(i,AtLeast,1,12,"HZ");
			NDeaths(i,Exactly,1,HTik);
		},
	actions = {
			GiveUnits(all,12,i,"Anywhere",P12);
			RemoveUnit(12,P12);
			DisplayText("\x1F─━┫“ \x04예약 \x0F메딕(3 tik) \x04기능을 사용합니다\x04. 「\x0F250ore\x04」\x0F”", 4);
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+1,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,1);
			SetNDeaths(i,SetTo,2,HTik);
			PreserveTrigger()
		}
}

Trigger { -- 1 tik Heal
	players = {i},
	conditions = {
			Label(0);
			Bring(i,AtLeast,1,12,"HZ");
			NDeaths(i,Exactly,2,HTik);
		},
	actions = {
			GiveUnits(all,12,i,"Anywhere",P12);
			RemoveUnit(12,P12);
			DisplayText("\x1F─━┫“ \x04일반 \x0F메딕(1 tik) \x04기능을 사용합니다\x04. 「\x0F200ore\x04」\x0F”", 4);
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,1);
			SetMemoryB(0x57F27C+(i*228)+1,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,0);
			SetNDeaths(i,SetTo,0,HTik);
			PreserveTrigger()
		}
}
end
CIfEnd()

for i = 0, 4 do
for j = 1, 3 do
Trigger { -- Heal Trig (1,2,3tik)
	players = {i},
	conditions = {
			Command(CP,AtLeast,1,HealTikUnit[j]);
		},
	actions = {
			RemoveUnitAt(all,HealTikUnit[j],"HZ",i);
			ModifyUnitHitPoints(all,0,i,"Anywhere",100);
			ModifyUnitHitPoints(all,7,i,"Anywhere",100);
			ModifyUnitHitPoints(all,20,i,"Anywhere",100);
			--ModifyUnitHitPoints(all,124,i,"Anywhere",100);
			--ModifyUnitHitPoints(all,125,i,"Anywhere",100);
			PreserveTrigger();
		}
}

end
end

function RemoveNUnit()
	for i = 1, #NUnit do
		local X ={}
			table.insert(X,(ModifyUnitEnergy(all,NUnit[i],P12,"Anywhere",0)))
			table.insert(X,(RemoveUnit(NUnit[i],P12)))
		return X
	end
end

DoActionsX(FP,{RemoveNUnit()})

DoActions(Force1,{RunAIScript('Turn ON Shared Vision for Player 1'), -- Vision
		RunAIScript('Turn ON Shared Vision for Player 2'),
		RunAIScript('Turn ON Shared Vision for Player 3'),
		RunAIScript('Turn ON Shared Vision for Player 4'),
		RunAIScript('Turn ON Shared Vision for Player 5'),
		SetAllianceStatus(Force1,AlliedVictory)
	})
DoActions(Force2,{
	SetAllianceStatus(Force1,Enemy)
})
DoActionsX(FP,SetNDeaths(FP,Add,1,HZ))

Trigger { -- 4 Seconds per Heal
	players = {FP},
	conditions = {
			Label(0);
			NDeaths(FP,AtLeast,HZTimer,HZ)
		},
	actions = {
			ModifyUnitHitPoints(all,0,Force1,"HZ",100);
			ModifyUnitHitPoints(all,7,Force1,"HZ",100);
			ModifyUnitHitPoints(all,20,Force1,"HZ",100);
			ModifyUnitHitPoints(all,124,Force1,"HZ",100);
			ModifyUnitHitPoints(all,125,Force1,"HZ",100);
			SetNDeaths(FP,SetTo,0,HZ);
			PreserveTrigger()
		}
}


------<  Building Trig / Upgrade Trig  >---------------------------------------------
-- Building Trig --
StartText1 = "\x13\x16─━┫ \x07엔베\x04는 \x1120초 \x04동안 \x1F이용\x04이 가능합니다. \x16┣━─"
StartText2 = "\x13\x16─━┫ \x10커맨드 센터\x04는 \x1120초 \x04동안 \x1F이용\x04이 가능합니다. \x16┣━─"
RemainText1 = "\x13 \x16─━┫ \x07엔베 \x1F쿨타임\x04이 \x11아직 \x04남아있습니다. \x16┣━─"
RemainText2 = "\x13 \x16─━┫ \x10커맨드 센터 \x1F쿨타임\x04이 \x11아직 \x04남아있습니다. \x16┣━─"
EndText1 = "\x13 \x16─━┫ \x07엔베 \x1F쿨타임\x04이 \x08종료 \x04되었습니다. \x16┣━─"
EndText2 = "\x13 \x16─━┫ \x10커맨드 센터 \x1F쿨타임\x04이 \x08종료 \x04되었습니다. \x16┣━─"

TxtArr = {StartText1,RemainText1,EndText1}
BIDLocArr = {{"LBay","LBDest"},{"RBay","RBDest"}}
BIDTimer = CreateVarArr(5,FP)
BIDTimerSW = CreateVarArr(5,FP) -- 1 = Using
CoolTimeTxt = CreateVarArr(5,FP)

TxtArr2 = {StartText2,RemainText2,EndText2}
BIDLocArr2 = {{"LCenter","LCDest"},{"RCenter","RCDest"}}
BIDTimer2 = CreateVarArr(5,FP)
BIDTimer2SW = CreateVarArr(5,FP) -- 1 = Using
CoolTime2Txt = CreateVarArr(5,FP)

-- Bay --
for j = 0, 4 do
DoActionsX(FP,SetNVar(BIDTimer[j+1],Subtract,1))
for i = 1, 2 do
TriggerX(FP,{ -- In Use
	Bring(j,AtLeast,1,"Men",BIDLocArr[i][2]);
	Bring(P12,AtLeast,1,122,BIDLocArr[i][1]);
	NVar(BIDTimerSW[j+1],Exactly,0);
},{
	GiveUnits(1,122,P12,BIDLocArr[i][1],j);
	SetNVar(BIDTimer[j+1],SetTo,34*20);
	SetNVar(BIDTimerSW[j+1],SetTo,1);
	CopyCpAction({DisplayTextX(StartText1,4)},{j},FP);
},{Preserved})

TriggerX(FP,{ -- Return
	Bring(j,AtLeast,1,122,BIDLocArr[i][1]);
	Bring(j,Exactly,0,"Men",BIDLocArr[i][2]);
},{
	GiveUnits(1,122,j,BIDLocArr[i][1],P12);
	SetNVar(CoolTimeTxt[j+1],SetTo,1);
},{Preserved})

TriggerX(FP,{ -- CoolTime
	Bring(P12,Exactly,1,122,BIDLocArr[i][1]);
	Bring(j,AtLeast,1,"Men",BIDLocArr[i][2]);
	NVar(BIDTimerSW[j+1],Exactly,1);
	NVar(CoolTimeTxt[j+1],Exactly,1);
},{
	CopyCpAction({DisplayTextX(RemainText1,4)},{j},FP);
	SetNVar(CoolTimeTxt[j+1],SetTo,2);
},{Preserved})

TriggerX(FP,{ -- CoolTime End
	NVar(BIDTimerSW[j+1],Exactly,1);
	NVar(BIDTimer[j+1],Exactly,0);
},{
	CopyCpAction({DisplayTextX(EndText1,4)},{j},FP);
	GiveUnits(1,122,j,BIDLocArr[i][1],P12);
	SetNVar(BIDTimerSW[j+1],SetTo,0);
	SetNVar(CoolTimeTxt[j+1],SetTo,0);
},{Preserved})
end
end
-- Center --
for j = 0, 4 do
DoActionsX(FP,SetNVar(BIDTimer2[j+1],Subtract,1))
	for i = 1, 2 do
	TriggerX(FP,{ -- In Use
		Bring(j,AtLeast,1,"Men",BIDLocArr2[i][2]);
		Bring(P12,AtLeast,1,106,BIDLocArr2[i][1]);
		NVar(BIDTimer2SW[j+1],Exactly,0);
	},{
		GiveUnits(1,106,P12,BIDLocArr2[i][1],j);
		SetNVar(BIDTimer2[j+1],SetTo,34*20);
		SetNVar(BIDTimer2SW[j+1],SetTo,1);
		CopyCpAction({DisplayTextX(StartText2,4)},{j},FP);
	},{Preserved})
	
	TriggerX(FP,{ -- Return
		Bring(j,AtLeast,1,106,BIDLocArr2[i][1]);
		Bring(j,Exactly,0,"Men",BIDLocArr2[i][2]);
	},{
		GiveUnits(1,106,j,BIDLocArr2[i][1],P12);
		SetNVar(CoolTime2Txt[j+1],SetTo,1);
	},{Preserved})
	
	TriggerX(FP,{ -- CoolTime
		Bring(P12,Exactly,1,106,BIDLocArr2[i][1]);
		Bring(j,AtLeast,1,"Men",BIDLocArr2[i][2]);
		NVar(BIDTimer2SW[j+1],Exactly,1);
		NVar(CoolTime2Txt[j+1],Exactly,1);
	},{
		CopyCpAction({DisplayTextX(RemainText2,4)},{j},FP);
		SetNVar(CoolTime2Txt[j+1],SetTo,2);
	},{Preserved})
	
	TriggerX(FP,{ -- CoolTime End
		NVar(BIDTimer2SW[j+1],Exactly,1);
		NVar(BIDTimer2[j+1],Exactly,0);
	},{
		CopyCpAction({DisplayTextX(EndText2,4)},{j},FP);
		GiveUnits(1,106,j,BIDLocArr2[i][1],P12);
		SetNVar(BIDTimer2SW[j+1],SetTo,0);
		SetNVar(CoolTime2Txt[j+1],SetTo,0);
	},{Preserved})
	end
end

-- Upgrade Trig --
UpgradeDef = CreateVarArr(5,FP)
UpgradeCond = CreateVarArr(5,FP)

for i = 0, 4 do
TriggerX(FP,{},{ -- Init Upgrade Set
	SetNVar(UpgradeDef[i+1],SetTo,5);
	SetNVar(UpgradeCond[i+1],SetTo,1);
})

CTrigger(FP,{TMemoryB(0x58D2B0,46*i,Exactly,UpgradeCond[i+1])},{
	TSetMemoryB(0x58D2B0,46*i,SetTo,UpgradeDef[i+1]);
	SetNVar(UpgradeCond[i+1],Add,5);
	SetNVar(UpgradeDef[i+1],Add,5);
},{Preserved})
end
-- SCV Trig --
TriggerX(Force1,{Bring(CurrentPlayer,AtLeast,1,21,"LCenter")},{
	GiveUnits(all,21,CurrentPlayer,"Anywhere",P12);
	RemoveUnit(21,P12);
	CreateUnit(1,7,"LCDest",CurrentPlayer);
},{Preserved})
TriggerX(Force1,{Bring(CurrentPlayer,AtLeast,1,21,"RCenter")},{
	GiveUnits(all,21,CurrentPlayer,"Anywhere",P12);
	RemoveUnit(21,P12);
	CreateUnit(1,7,"RCDest",CurrentPlayer);
},{Preserved})


------<  GiveRate Trig  >--------------------------------------------- [ GiveRateUnit = 8  ]
GText1 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F5,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
GText2 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F10,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
GText3 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F50,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
GText4 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F100,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
GText5 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F500,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
GText6 = "\x13\x1F─━┫ \x04기부금액 단위가 \x1F1,000 Ore \x04로 \x11변경\x04되었습니다. \x1F┣━─"
-- 1000 = 0 // 5000 = 1 // 10000 = 2 // 50000 = 3 // 100000 = 4 // 500000 = 5
GTable = {{0,1,GText1},{1,2,GText2},{2,3,GText3},{3,4,GText4},{4,5,GText5},{5,0,GText6}}
--Give Trig -- [ GiveUnit (58,60,69,71,72) ]
--GiveRate 0~5 [ 5000, 10000, 50000, 100000, 500000, 1000 ]
CIf(Force1,{Command(CP,AtLeast,1,8)})

for i = 0, 4 do
for j = 1, 6 do
Trigger {
	players = {i},
	conditions = {
			Label(0);
			NDeaths(i,Exactly,GTable[j][1],GiveRate);
			Command(i,AtLeast,1,8)
		},
	actions = {
			GiveUnits(all,8,i,"Anywhere",P12);
			RemoveUnit(8,P12);
			DisplayText(GTable[j][3],4);
			SetNDeaths(i,SetTo,GTable[j][2],GiveRate);
			PreserveTrigger();
		}
}

end end

CIfEnd()

for k = 0, 4 do
for j = 0, 4 do
if k~=j then
CIf(k,Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere"))
	for i = 0, 5 do
	Trigger {
			players = {k},
			conditions = {
					Label(0);
					Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere");
					PlayerCheck(j,1);
					NDeaths(k,Exactly,i,GiveRate);
					Accumulate(k,AtMost,GiveRate2[i+1],Ore);
				},
			actions = {
					RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
					DisplayText("\x1F─━┫ “ \x1F잔액\x04이 부족합니다.\x0F”",4);
					PreserveTrigger()
				},
		}
	Trigger {
			players = {k},
			conditions = {
					Label(0);
					Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere");
					PlayerCheck(j,1);
					NDeaths(k,Exactly,i,GiveRate);
					Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
					Accumulate(k,AtMost,0x7FFFFFFF,Ore);
				},
			actions = {
					SetResources(k,Subtract,GiveRate2[i+1],Ore);
					SetResources(j,Add,GiveRate2[i+1],Ore);
					RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
					DisplayText("\x1F─━┫ “ "..Player[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. \x0F”",4);
					SetMemory(0x6509B0,SetTo,j);
					DisplayText("\x1F─━┫ “ "..Player[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다. \x0F”",4);
					SetMemory(0x6509B0,SetTo,k);
					PreserveTrigger();
				},
		}
	end
Trigger {
	players = {k},
	conditions = {
			Label(0);
			Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere");
			PlayerCheck(j,0);
		},
	actions = {
			DisplayText("\x1F─━┫ “"..Player[j+1].."\x04이(가) 존재하지 않습니다. \x0F”",4);
			RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
			PreserveTrigger();
				},
		}
	
CIfEnd()
elseif k==j then
	TriggerX(k,{Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere")},{RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k)},{Preserved})
end end end

------<  Exchange Trig  >---------------------------------------------

NJump(Force1,0x0FF,{Bring(CP,Exactly,0,"Men","EXL"),Bring(CP,Exactly,0,"Men","EXR")})
for k = 1, 3 do
	CIf(Force1,{CVar(FP,GMode,Exactly,k)})
			for i = 0, 4 do
			for j = 15, 0, -1 do
			Trigger {
					players = {Force1},
					conditions = {
							Label(0);
							Score(CP,Kills,AtLeast,2^j*100); 
							NDeaths(FP,Exactly,i+1,P_Count); 
						},
					actions = {
							SetScore(CP,Subtract,2^j*100,Kills);
							SetResources(CP,Add,2^j*ExRate[k][i+1],Ore);
							PreserveTrigger()
							}
			}
			end 
			end
	CIfEnd()
end
NJumpEnd(Force1,0x0FF)


CIf(Force1,{Bring(CP,AtLeast,1,88,"Anywhere")},{RemoveUnit(88,CP),DisplayText("\x1F─━┫ \x0F“ \x10자동환전\x04을 사용하였습니다.\x0F”",4)})
for k = 1, 3 do
	CIf(Force1,{CVar(FP,GMode,Exactly,k)})
			for i = 0, 4 do
			for j = 15, 0, -1 do
			Trigger {
					players = {Force1},
					conditions = {
							Label(0);
							Score(CP,Kills,AtLeast,2^j*100); 
							NDeaths(FP,Exactly,i+1,P_Count); 
						},
					actions = {
							SetScore(CP,Subtract,2^j*100,Kills);
							SetResources(CP,Add,2^j*ExRate[k][i+1],Ore);
							PreserveTrigger()
							}
			}
			end 
			end
	CIfEnd()
end
CIfEnd()

------<  BGM Trig  >---------------------------------------------
BText1 = "\x1F─━┫ “ \x10BGM\x04을 듣지 않습니다\x04.\x0F”"
BText2 = "\x1F─━┫ “ \x10BGM\x04을 듣습니다\x04.\x0F”"

CIf(Force1,{Bring(CP,AtLeast,1,22,"HZ")})
 for i = 0, 4 do
		Trigger { -- BGM OFF
				players = {i},
				conditions = {
						Label(0);
						Void(i+1,Exactly,0);
						Bring(i,AtLeast,1,22,"HZ");
					},
				actions = {
						RemoveUnit(22,i);
						DisplayText(BText1,4);
						SetVoid(i+1,SetTo,1);
						PreserveTrigger()
					}
			}
		Trigger { -- BGM ON
				players = {i},
				conditions = {
						Label(0);
						Void(i+1,Exactly,1);
						Bring(i,AtLeast,1,22,"HZ");
					},
				actions = {
						RemoveUnit(22,i);
						DisplayText(BText2,4);
						SetVoid(i+1,SetTo,0);
						PreserveTrigger()
					}
			}
	end
CIfEnd()
------<  Ban Trig  >---------------------------------------------

BanText = "\x13\x1F─━┫【 \x04당신은 \x11방장에 의해 \x08강제퇴장 \x04당하였습니다.  \x1F】┣━─"
BanLocArr = {"P1_Ban","P2_Ban","P3_Ban","P4_Ban","P5_Ban"}
for i = 0, 4 do
Trigger {
	players = {FP},
	conditions = {
			Label(0);
			Bring(Force1,AtLeast,1,95,BanLocArr[i+1]);
		},
	actions = {
			RotatePlayer({DisplayTextX(BanText)},{i},FP);
			RotatePlayer({Defeat()},{i},FP);
		}
}
end



------<  Computer Trig  >---------------------------------------------

DoActions(FP,{CopyCpAction({RunAIScript('Turn ON Shared Vision for Player 1'),RunAIScript('Turn ON Shared Vision for Player 2'),RunAIScript('Turn ON Shared Vision for Player 3'),
			RunAIScript('Turn ON Shared Vision for Player 4'),RunAIScript('Turn ON Shared Vision for Player 5')},{P6,P7,P8},FP)})


DoActions(FP,{RemoveUnit(215,P12)}) -- Remove Flags

for i = 5, 7 do
TriggerX(FP,{Bring(i,AtLeast,50,42,"Anywhere")},{RemoveUnitAt(2,42,"Anywhere",i)},{Preserved})
TriggerX(FP,{Bring(i,AtLeast,50,35,"Anywhere")},{RemoveUnitAt(5,35,"Anywhere",i)},{Preserved})
end

------<  TTrig  >---------------------------------------------
-- Variables --
TUnit, T_GUnitX, T_AUnitX, T_GUnit, T_AUnit, TPlayer,
 TShape, TLevel, TShapeType, T_UnitType, AreaPlayer = CreateVars(11,FP)
-- Functions --
function CreateBurrowedUnit(Count,Unit,Location,Player)
	return CreateUnitWithProperties(Count,Unit,Location,Player,{
		clocked = false,
		burrowed = true,
		intransit = false,
		hallucinated = false,
		invincible = false,
		hitpoint = 100,
		shield = 100,
		energy = 100,
		resource = 0,
		hanger = 0,
	})
end

function TCreateBurrowedUnit(Count,Unit,Location,Player)
	return TCreateUnitWithProperties(Count,Unit,Location,Player,{
		clocked = false,
		burrowed = true,
		intransit = false,
		hallucinated = false,
		invincible = false,
		hitpoint = 100,
		shield = 100,
		energy = 100,
		resource = 0,
		hanger = 0,
	})
end



function TTrig(L,U,R,D,LockSwitch,TValue,ShapeType,AreaNumber)
	DoActions(FP,{Simple_SetLoc(20,L,U,R,D);
		KillUnitAt(1,72,"CLoc21",P12)})
	CIf(FP,{Switch(LockSwitch,Cleared)})
	for i = 0, 4 do
		CIf(FP,{Switch(LockSwitch,Cleared),TTOR({Bring(i,AtLeast,1,20,"CLoc21"),Bring(i,AtLeast,1,0,"CLoc21")})})
			DoActionsX(FP,{
					SetNVar(TShapeType,SetTo,ShapeType);
					SetNVar(AreaPlayer,SetTo,AreaNumber);
					SetNVar(VFlag,SetTo,2^i);
					SetNVar(VFlag256,SetTo,(2^i)*256);
					SetNDeaths(FP,SetTo,TValue,TNumber);
					SetSwitch(LockSwitch,Set);
					SetSwitch("Switch 21",Set);
					SetNext("X",0x1001);
					SetNext(0x1002,"X",1);
				})
		CIfEnd()
	end
	CIfEnd()
end

--< Beacon Trap >--

BTVar = CreateVar(FP)

TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","LBDest")},{
	CreateBurrowedUnit(12,37,"LBDest",P6);
	CreateBurrowedUnit(4,53,"LBDest",P6);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"LBDest",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","RBDest")},{
	CreateBurrowedUnit(12,37,"RBDest",P7);
	CreateBurrowedUnit(4,53,"RBDest",P7);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"RBDest",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","LCDest")},{
	CreateBurrowedUnit(12,37,"LCDest",P6);
	CreateBurrowedUnit(4,53,"LCDest",P6);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"LCDest",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","RCDest")},{
	CreateBurrowedUnit(12,37,"RCDest",P7);
	CreateBurrowedUnit(4,53,"RCDest",P7);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"RCDest",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","EXL")},{
	CreateBurrowedUnit(15,37,"EXL",P7);
	CreateBurrowedUnit(5,38,"EXL",P7);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"EXL",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","EXR")},{
	CreateBurrowedUnit(15,37,"EXR",P7);
	CreateBurrowedUnit(5,38,"EXR",P7);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"EXR",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})
TriggerX(FP,{Bring(Force1,AtLeast,1,"Men","Hero")},{
	CreateUnit(3,56,"Hero",P8);
	SetMemoryX(0x666458,SetTo,391,0xFFFF);
	CreateUnit(1,33,"Hero",P8);
	SetMemoryX(0x666458,SetTo,546,0xFFFF);
	SetNVar(BTVar,Add,1);
})

TriggerX(FP,{CVar("X",GMode,Exactly,1),NVar(BTVar,Exactly,7)},{
	CreateUnit(1,77,"LBDest",P6);
	CreateUnit(1,78,"LCDest",P6);
	CreateUnit(1,25,"EXL",P6);
	CreateUnit(1,77,"RBDest",P7);
	CreateUnit(1,78,"RCDest",P7);
	CreateUnit(1,25,"EXR",P7);
	CreateUnit(3,25,"Hero",P8);
})
TriggerX(FP,{CVar("X",GMode,Exactly,2),NVar(BTVar,Exactly,7)},{
	CreateUnit(1,65,"LBDest",P6);
	CreateUnit(1,66,"LCDest",P6);
	CreateUnit(2,69,"EXL",P6);
	CreateUnit(1,65,"RBDest",P7);
	CreateUnit(1,66,"RCDest",P7);
	CreateUnit(2,69,"EXR",P7);
	CreateUnit(4,69,"Hero",P8);
})
TriggerX(FP,{CVar("X",GMode,Exactly,3),NVar(BTVar,Exactly,7)},{
	CreateUnit(1,65,"LBDest",P6);
	CreateUnit(1,66,"LCDest",P6);
	CreateUnit(1,30,"LBDest",P6);
	CreateUnit(1,30,"LCDest",P6);
	CreateUnit(2,30,"EXL",P6);
	CreateUnit(1,65,"RBDest",P7);
	CreateUnit(1,66,"RCDest",P7);
	CreateUnit(1,30,"RBDest",P7);
	CreateUnit(1,30,"RCDest",P7);
	CreateUnit(2,30,"EXR",P7);
	CreateUnit(4,30,"Hero",P8);
	CreateUnit(1,61,"Hero",P8);
})
--------< Shapes >--------
-- TNumber = 1 (Lurker)
-- TNumber = 2 (TrapA1,TrapA2)
-- TNumber = 3 (TrapB1,TrapB2)
-- TNumber = 4 (TrapC1,TrapC2,TrapC3,TrapC4)
-- TNumber = 5 (TrapD)
--TShapeType = 1
TrapA1 = CSMakePolygonX(4,16,0,CS_Level("PolygonX",4,2),0) -- 16 (XUnit Ground)
TrapA2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,2),0) -- 16 (XUnit Air)
--TShapeType = 3
TrapB1 = CSMakePolygon(4,16,0,CS_Level("Polygon",4,4),0) -- 25 (XUnit Ground)
TrapB2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,2),0) -- 16 (XUnit Air)
--TShapeType = 5
TrapC1 = CSMakePolygon(4,32,0,CS_Level("Polygon",4,4),CS_Level("Polygon",4,2)) -- 24 (XUnit Ground)
TrapC2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,1)) -- 30 (XUnit Air)
TrapC3 = CSMakePolygon(4,32,0,CS_Level("Polygon",4,2),1) -- 1 (HUnit Ground)
TrapC4 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,1),0) -- 4 (HUnit Air)
--TShapeType = 9
TrapD1 = CSMakePolygon(4,32,0,CS_Level("Polygon",4,4),CS_Level("Polygon",4,2)) -- 20 (XUnit Ground)
TrapD2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,1)) -- 30-4 (XUnit Air)
TrapD3 = CSMakePolygon(4,32,0,CS_Level("Polygon",4,2),0) -- 5 (HUnit Ground)
TrapD4 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,1),0) -- 4 (HUnit Air)
--TShapeType = 13
TrapD1 = CSMakePolygon(4,32,0,CS_Level("Polygon",4,4),CS_Level("Polygon",4,2)) -- 20 (XUnit Ground)
TrapD2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,1)) -- 30-4 (XUnit Air)
TrapD3 = CSMakePolygon(4,64,0,CS_Level("Polygon",4,2),0) -- 5 (HUnit Ground)
TrapD4 = CSMakePolygonX(4,256+128,0,CS_Level("PolygonX",4,1),0) -- 4 (HUnit Air)
--TShapeType = 17
TrapE1 = CSMakePolygon(4,16,0,CS_Level("Polygon",4,3),CS_Level("Polygon",4,1)) -- 12 (HUnit Ground)
TrapE2 = CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,1)) -- 30-4 (HUnit Air)
TrapE3 = CSMakePolygon(3,32,0,4,1) -- 3 (GUnit Ground)
TrapE4 = CSMakePolygonX(4,256+128,0,CS_Level("PolygonX",4,1),0) -- 4 (GUnit Air)

CJump(FP,0x101)
Trigger {
	players = {FP},
	conditions = {
			Label(0x1001);
		},
}
-- TUnit Preset --
CIf(FP,CVar("X",GMode,Exactly,1))
	TriggerX(FP,{NDeaths(FP,Exactly,1,TNumber)},{
		SetNVar(T_GUnitX,SetTo,37);
		SetNVar(T_AUnitX,SetTo,43);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,2,TNumber)},{
		SetNVar(T_GUnitX,SetTo,38);
		SetNVar(T_AUnitX,SetTo,44);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,AtLeast,3,TNumber),NDeaths(FP,AtMost,4,TNumber)},{
		SetNVar(T_GUnitX,SetTo,53);
		SetNVar(T_AUnitX,SetTo,55);
		SetNVar(T_GUnit,SetTo,48);
		SetNVar(T_AUnit,SetTo,56);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,AtLeast,5,TNumber),NDeaths(FP,AtMost,8,TNumber)},{
		SetNVar(T_GUnitX,SetTo,104);
		SetNVar(T_AUnitX,SetTo,56);
		SetNVar(T_GUnit,SetTo,40);
		SetNVar(T_AUnit,SetTo,70);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,9,TNumber)},{
		SetNVar(T_GUnitX,SetTo,40);
		SetNVar(T_AUnitX,SetTo,21);
		SetNVar(T_GUnit,SetTo,51);
		SetNVar(T_AUnit,SetTo,86);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,AtLeast,10,TNumber),NDeaths(FP,AtMost,15,TNumber)},{
		SetNVar(T_GUnitX,SetTo,51);
		SetNVar(T_AUnitX,SetTo,56);
		SetNVar(T_GUnit,SetTo,32);
		SetNVar(T_AUnit,SetTo,27);
	},{Preserved})
	TriggerX(FP,{NDeaths(FP,AtLeast,16,TNumber),NDeaths(FP,AtMost,17,TNumber)},{
		SetNVar(T_GUnitX,SetTo,32);
		SetNVar(T_AUnitX,SetTo,12);
		SetNVar(T_GUnit,SetTo,23);
		SetNVar(T_AUnit,SetTo,30);
	},{Preserved})
CIfEnd()

CIf(FP,CVar("X",GMode,AtLeast,2))
	TriggerX(FP,{NDeaths(FP,Exactly,1,TNumber)},{
			SetNVar(T_GUnitX,SetTo,54);
			SetNVar(T_AUnitX,SetTo,55);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,2,TNumber)},{
			SetNVar(T_GUnitX,SetTo,53);
			SetNVar(T_AUnitX,SetTo,56);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,3,TNumber)},{
			SetNVar(T_GUnitX,SetTo,104);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,77);
			SetNVar(T_AUnit,SetTo,80);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,4,TNumber)},{
			SetNVar(T_GUnitX,SetTo,40);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,78);
			SetNVar(T_AUnit,SetTo,80);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,5,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,75);
			SetNVar(T_AUnit,SetTo,80);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,6,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,17);
			SetNVar(T_AUnit,SetTo,21);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,7,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,76);
			SetNVar(T_AUnit,SetTo,86);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,8,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,74);
			SetNVar(T_AUnit,SetTo,58);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,9,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,12);
			SetNVar(T_GUnit,SetTo,32);
			SetNVar(T_AUnit,SetTo,27);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,10,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,64);
			SetNVar(T_AUnit,SetTo,88);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,11,TNumber)},{
			SetNVar(T_GUnitX,SetTo,51);
			SetNVar(T_AUnitX,SetTo,56);
			SetNVar(T_GUnit,SetTo,5);
			SetNVar(T_AUnit,SetTo,8);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,12,TNumber)},{
			SetNVar(T_GUnitX,SetTo,77);
			SetNVar(T_AUnitX,SetTo,80);
			SetNVar(T_GUnit,SetTo,98);
			SetNVar(T_AUnit,SetTo,65);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,13,TNumber)},{
			SetNVar(T_GUnitX,SetTo,17);
			SetNVar(T_AUnitX,SetTo,21);
			SetNVar(T_GUnit,SetTo,61);
			SetNVar(T_AUnit,SetTo,28);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,14,TNumber)},{
			SetNVar(T_GUnitX,SetTo,81);
			SetNVar(T_AUnitX,SetTo,86);
			SetNVar(T_GUnit,SetTo,87);
			SetNVar(T_AUnit,SetTo,60);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,15,TNumber)},{
			SetNVar(T_GUnitX,SetTo,52);
			SetNVar(T_AUnitX,SetTo,28);
			SetNVar(T_GUnit,SetTo,68);
			SetNVar(T_AUnit,SetTo,102);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,16,TNumber)},{
			SetNVar(T_GUnitX,SetTo,93);
			SetNVar(T_AUnitX,SetTo,88);
			SetNVar(T_GUnit,SetTo,23);
			SetNVar(T_AUnit,SetTo,102);
		},{Preserved})
	TriggerX(FP,{NDeaths(FP,Exactly,17,TNumber)},{
			SetNVar(T_GUnitX,SetTo,61);
			SetNVar(T_AUnitX,SetTo,28);
			SetNVar(T_GUnit,SetTo,68);
			SetNVar(T_AUnit,SetTo,9);
		},{Preserved})
CIfEnd()

	CJump(FP,0x102)
	Trigger {
		players = {FP},
		conditions = {
			Label(0x1003);
		},
	}
	NIf(FP,{Memory(0x628438,AtLeast,1),NDeaths(FP,AtLeast,1,TNumber)})
		CIfX(FP,NVar(TLevel,Exactly,0))
				CDoActions(FP,{
						TCreateUnit(1,TUnit,"CLoc21",AreaPlayer);
					})
		CElseIfX(NVar(TLevel,Exactly,1))
			CIfX(FP,CVar("X",GMode,Exactly,1))
				SetNextptr()
					CDoActions(FP,{
						TCreateUnit(1,TUnit,"CLoc21",TPlayer);
						TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Vision
					})
			CElseIfX(CVar("X",GMode,Exactly,2))
					SetNextptr()
					CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
							TCreateUnit(1,TUnit,"CLoc21",AreaPlayer);
							TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
							TSetMemoryX(Vi(Nextptr[2],57),SetTo,VFlag,0xFF);
							TSetMemoryX(Vi(Nextptr[2],70),SetTo,192*16777216,0xFF000000); -- Timer
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
							TSetMemoryX(Vi(Nextptr[2],73),SetTo,VFlag256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
						},{Preserved})
			CElseIfX(CVar("X",GMode,Exactly,3))
				CMov(FP,UIDVar,TUnit,0,0xFFFF)
				CallTrigger(FP,SetGUnitHP)
					SetNextptr()
					CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
							TCreateUnit(1,TUnit,"CLoc21",P8);
							--TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
							TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
							TSetMemoryX(Vi(Nextptr[2],57),SetTo,VFlag,0xFF);
							TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000); -- Timer
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
							TSetMemoryX(Vi(Nextptr[2],73),SetTo,VFlag256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
						},{Preserved})
			CIfXEnd()
		CIfXEnd()
	NIfEnd()
	Trigger {
		players = {FP},
		conditions = {
				Label(0x1004);
			},
	}
	CJumpEnd(FP,0x102)

	CJump(FP,0x103)
		Call_TTrig = SetCallForward()
		SetCall(FP)
			function TTrig_CAFunc()
				local CB = CAPlotCreateArr
				CIf(FP,NVar(T_UnitType,Exactly,2))
					CIfX(FP,{CVar("X",GMode,Exactly,1)})
							CA_Rotate(V(TAngle2))
						CElseIfX({CVar("X",GMode,Exactly,2)})
							CA_Rotate(V(TAngle2))
							CA_MoveXY(-192,0)
							CA_Rotate(V(TAngle2))
						CElseIfX({CVar("X",GMode,Exactly,3)})
							CA_Rotate(V(TAngle2))
								CIfX(FP,{CVar("X",TAngle2,AtLeast,0),CVar("X",TAngle2,AtMost,90)})
										CA_MoveXY(192,0)
									CElseIfX({CVar("X",TAngle2,AtLeast,91),CVar("X",TAngle2,AtMost,180)})
										CA_MoveXY(-192,0)
									CElseIfX({CVar("X",TAngle2,AtLeast,181),CVar("X",TAngle2,AtMost,270)})
										CA_MoveXY(0,192)
									CElseIfX({CVar("X",TAngle2,AtLeast,271),CVar("X",TAngle2,AtMost,360)})
										CA_MoveXY(0,-192)
								CIfXEnd()
					CIfXEnd()
				CIfEnd()
			end
			CAPlot({TrapA1,TrapA2,TrapB1,TrapB2,TrapC1,TrapC2,TrapC3,TrapC4,TrapD1,TrapD2,TrapD3,TrapD4,TrapE1,TrapE2,TrapE3,TrapE4}
				,P6,193,"CLoc21",nil,1,16,{TShape,0,0,0,600,0},"TTrig_CAFunc",FP,nil,{SetNext("X",0x1003),SetNext(0x1004,"X",1)},1)
		SetCallEnd()
	CJumpEnd(FP,0x103)
	CJump(FP,0x104)
		Call_TTrigOrder = SetCallForward()
		TTrigLocSize = 256
		SetCall(FP)
			CDoActionsX(FP,{
				Simple_CalcLoc("CLoc21", -TTrigLocSize, -TTrigLocSize, TTrigLocSize, TTrigLocSize);
				TOrder(TUnit,TPlayer,"CLoc21",Attack,"HZ");
				TOrder(TUnit,AreaPlayer,"CLoc21",Attack,"HZ");
			})
		SetCallEnd()
	CJumpEnd(FP,0x104)
CDoActions(FP,{ -- Set TUnit1
	TSetNVar(TShape,SetTo,TShapeType); -- Set InitShape
	TSetNVar(TUnit,SetTo,T_GUnitX); -- GroundX
	SetNVar(T_UnitType,SetTo,1); -- GoundUnit -> CAFunc X
})
CallTrigger(FP,Call_TTrig)
CallTrigger(FP,Call_TTrigOrder)

CDoActions(FP,{ -- Set TUnit2
	TSetNVar(TShape,Add,1);
	TSetNVar(TUnit,SetTo,T_AUnitX); -- AirX
	SetNVar(T_UnitType,SetTo,2); -- AirUnit -> CAFunc O
})
CallTrigger(FP,Call_TTrig)
CallTrigger(FP,Call_TTrigOrder)

CIf(FP,{NDeaths(FP,AtLeast,3,TNumber)})
	TriggerX(FP,{CVar("X",GMode,AtLeast,2)},{SetNVar(TLevel,SetTo,1)},{Preserved})
	CDoActionsX(FP,{ -- Set TUnit3
			TSetNVar(TShape,Add,1);
			TSetNVar(TUnit,SetTo,T_GUnit); -- Ground HUnit
			SetNVar(TPlayer,SetTo,7);
			SetNVar(T_UnitType,SetTo,1); -- GoundUnit -> CAFunc X
	})
	CallTrigger(FP,Call_TTrig)
	CallTrigger(FP,Call_TTrigOrder)

	CDoActions(FP,{ -- Set TUnit4
			TSetNVar(TShape,Add,1);
			TSetNVar(TUnit,SetTo,T_AUnit); -- Air HUnit
			SetNVar(TPlayer,SetTo,7);
			SetNVar(T_UnitType,SetTo,2); -- AirUnit -> CAFunc O
	})
	CallTrigger(FP,Call_TTrig)
	CallTrigger(FP,Call_TTrigOrder)
DoActionsX(FP,{ -- Reset
	SetNVar(TLevel,Subtract,1);
})
CIfEnd()

Trigger {
	players = {FP},
	conditions = {
			Label(0x1002);
		},
}
CJumpEnd(FP,0x101)

--SetLoc Trig-- [ Switch 2 ~ 20 // NDeaths = TNumber // CVar = GMode ]
-- Switch 21 = 영침텍스트
TText = "\x13\x1F─━┫ \x04누군가 \x08적\x04의 \x11영역\x04을 침범하였습니다..! \x1F┣━─"

TriggerX(FP,{Switch("Switch 21",Set)},{
	CopyCpAction({DisplayTextX(TText,4),PlayWAVX("staredit\\wav\\Trap.ogg"),PlayWAVX("staredit\\wav\\Trap.ogg")},{Force1,Force5},FP);
	SetSwitch("Switch 21",Clear)},{Preserved})

--------------------------------TNumber = 1-----------------------------------
----------01
TTrig(576,7680,672,7776,"Switch 2",1,1,5) -- A1, A2

----------02
TTrig(1376,7680,1472,7776,"Switch 3",1,1,6) -- A1, A2

--------------------------------TNumber = 2-----------------------------------
----------03
TTrig(224,7488,384,7584,"Switch 4",2,3,5) -- B1, B2

----------04
TTrig(1664,7488,1824,7584,"Switch 5",2,3,6) -- B1, B2

--------------------------------TNumber = 3-----------------------------------
----------05
TTrig(160,6944,288,7072,"Switch 6",3,5,5)

----------06
TTrig(1760,6944,1888,7072,"Switch 7",3,5,6)
--------------------------------TNumber = 4-----------------------------------
----------07
TTrig(480,6464,608,6592,"Switch 8",4,5,5)

----------08
TTrig(1440,6464,1568,6592,"Switch 9",4,5,6)

--------------------------------TNumber = 5-----------------------------------
----------09
TTrig(320,6144,448,6240,"Switch 10",5,9,5)

----------10
TTrig(480,5984,608,6080,"Switch 10",5,9,5)
--------------------------------TNumber = 6-----------------------------------
----------11
TTrig(1600,6144,1728,6240,"Switch 11",6,9,6)

----------12
TTrig(1440,5984,1568,6080,"Switch 11",6,9,6)

--------------------------------TNumber = 7-----------------------------------
----------13
TTrig(576,5024,704,5120,"Switch 12",7,9,5)

----------14
TTrig(448,4992,576,5088,"Switch 12",7,9,5)

--------------------------------TNumber = 8-----------------------------------
----------15
TTrig(1344,5024,1472,5120,"Switch 13",8,9,6)

----------16
TTrig(1472,4992,1600,5088,"Switch 13",8,9,6)

--------------------------------TNumber = 9-----------------------------------
----------17
TTrig(864,4896,1184,4992,"Switch 14",9,9,7)

--------------------------------TNumber = 10-----------------------------------
----------18
TTrig(448,3328,576,3456,"Switch 15",10,9,5)

----------19
TTrig(576,3264,704,3392,"Switch 15",10,9,5)
--------------------------------TNumber = 11-----------------------------------
----------20
TTrig(1440,3296,1568,3424,"Switch 16",11,13,6)

----------21
TTrig(1312,3264,1440,3392,"Switch 16",11,13,6)

--------------------------------TNumber = 12-----------------------------------
----------22
TTrig(832,3136,960,3232,"Switch 17",12,13,5)

----------23
TTrig(1088,3136,1216,3232,"Switch 17",12,13,5)

--------------------------------TNumber = 13-----------------------------------
----------24
TTrig(160,2336,320,2464,"Switch 18",13,13,6)

--------------------------------TNumber = 14-----------------------------------
----------25
TTrig(1728,2336,1888,2464,"Switch 19",14,13,6)

--------------------------------TNumber = 15-----------------------------------
----------26
TTrig(544,1376,704,1536,"Switch 20",15,13,5)

--------------------------------TNumber = 16-----------------------------------
----------27
TTrig(1344,1376,1504,1536,"Switch 22",16,13,6)

--------------------------------TNumber = 17-----------------------------------
----------28
TTrig(832,1824,1216,1920,"Switch 23",17,13,7)

--------------------------------TNumber = 18-----------------------------------
----------28
TTrig(96,288,224,416,"Switch 24",17,13,5)

--------------------------------TNumber = 19-----------------------------------
----------28
TTrig(1824,288,1952,416,"Switch 25",17,13,6)



-------------------------------- 건작 Trig --------------------------------------

function SaveAngle()
	CIf(FP,{CVar("X",GMode,Exactly,2),CDeaths("X",Exactly,0,AngleG)},SetCDeaths("X",SetTo,360*65536,AngleG))
			CMov(FP,_Ccode(FP,AngleG),V(TAngle2),0,0xFFFF)
	CIfEnd()
end

function LoadAngle()
	f_Read(FP,_Ccode("X",AngleG),V(TAngle1))
end

function CreateEffect(Player,Variable,Color,CIndex,Height,UnitID,Loc,Owner)
	SetNextptr()
		CTrigger(Player,{NVar(Variable,AtLeast,19025),NVar(Variable,AtMost,161741)},{
			SetMemoryB(0x669E28+CIndex,SetTo,Color);
			SetMemoryB(0x663150+UnitID,SetTo,Height);
			TCreateUnit(1,UnitID,Loc,Owner);
			TSetDeathsX(Vi(Variable[2],72),SetTo,255*256,0,0xFF00);
			TSetDeathsX(Vi(Variable[2],55),SetTo,0x200104,0,0x300104);
			TSetDeaths(Vi(Variable[2],57),SetTo,0,0)},{Preserved})
end
function RetSH(Shape)
	return CS_InputVoid(Shape[1])
end
------<  GunSystem  >---------------------------------------------
RTimer = CreateVar(FP)
CMov(FP,RTimer,_Div(_Mul(_ReadF(0x57F23C),42),1000)) -- 실제시간
CMov(FP,SaveJYDGunTimer,_Mod(RTimer,60))
f_Mul(FP,V(TAngle2),SaveJYDGunTimer,6)

BuildTimeVar = CreateVar(FP)

TriggerX(FP,{NVar(BuildTimeVar,AtLeast,1)},{ -- 마린 생산시간 단축
	SetNVar(BuildTimeVar,Subtract,1);
	SetMemoryW(0x660428+82*2,Subtract,5);
},{Preserved})

for i = 0, 4 do -- 잡건물일때
TriggerX(FP,{Kills(i,AtLeast,1,"Buildings")},{
		SetNVar(VFlag,SetTo,2^i);
		SetNVar(VFlag256,SetTo,(2^i)*256);
		SetKills(i,SetTo,0,"Buildings");
	},{Preserved})
end

CheckGunID = InitCFunc(FP) -- 건작일때
GunIDArr = {114,126,127,132,133,147,151,130,167,174,175,189,200,201}
CFunc(CheckGunID)
for i = 0, 4 do
for j = 1, #GunIDArr do
	TriggerX(FP,{Kills(i,AtLeast,1,GunIDArr[j])},{
		SetNVar(VFlag,SetTo,2^i);
		SetNVar(VFlag256,SetTo,(2^i)*256);
		SetKills(i,SetTo,0,GunIDArr[j]);
	},{Preserved})
end end
CFuncEnd()

function SetVFlags() -- 개별건작플레이어 저장 // 개별건작타이머 저장
	CIf(FP,{CVar("X",GMode,AtLeast,2),CVar("X",VFlagIndex,Exactly,0),CVar("X",VFlag256Index,Exactly,0)})
		CallCFuncX(FP,CheckGunID)
		CDoActions(FP,{
			TSetNVar(V(VFlagIndex),SetTo,VFlag);
			TSetNVar(V(VFlag256Index),SetTo,VFlag256);
		})
	CIfEnd()
		CDoActions(FP,{
			TSetNVar(Save_VFlag,SetTo,V(VFlagIndex));
			TSetNVar(Save_VFlag256,SetTo,V(VFlag256Index));
			TSetNVar(InvTimer,SetTo,V(InvTimeIndex));
		})
	
end

DoActions(FP,SetMemoryX(0x656EB0+84*2,SetTo,0,0xFFFF)) -- 스톰딜 0 ( 스톰타이머 사용 )

------<  유닛 생성 단락  >---------------------------------------------

Common_UType, Common_XUType = CreateVars(2,FP)
VInput = CreateCcode()

CJump(FP,3)
SetLabel(0x5000)

CIf(FP,{NVar(Common_UType,AtLeast,192,0xFFFF),NVar(Common_UType,AtMost,193,0xFFFF)},{SetCDeaths("X",SetTo,1,VInput)})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,0*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(Common_UType,SetTo,1*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,53);
	},{Preserved})

	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,1*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(Common_UType,SetTo,2*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,54);
	},{Preserved})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,2*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,2);
	},{
		SetNVar(Common_UType,SetTo,3*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,48);
	},{Preserved})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,2*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,3);
	},{
		SetNVar(Common_UType,SetTo,3*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,48);
	},{Preserved})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,3*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,2);
	},{
		SetNVar(Common_UType,SetTo,0*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,104);
	},{Preserved})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,192,0xFFFF);
		NVar(Common_UType,Exactly,3*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,3);
	},{
		SetNVar(Common_UType,SetTo,0*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,51);
	},{Preserved})

	TriggerX(FP,{
		NVar(Common_UType,Exactly,193,0xFFFF);
		NVar(Common_UType,Exactly,0*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(Common_UType,SetTo,1*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,55);
	},{Preserved})
	TriggerX(FP,{
		NVar(Common_UType,Exactly,193,0xFFFF);
		NVar(Common_UType,Exactly,1*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,2);
	},{
		SetNVar(Common_UType,SetTo,0*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,56);
	},{Preserved})

	TriggerX(FP,{
		NVar(Common_UType,Exactly,193,0xFFFF);
		NVar(Common_UType,Exactly,1*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,3);
	},{
		SetNVar(Common_UType,SetTo,2*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,56);
	},{Preserved})

	TriggerX(FP,{
		NVar(Common_UType,Exactly,193,0xFFFF);
		NVar(Common_UType,Exactly,2*65536,0xFF0000);
		NVar(Common_UType,Exactly,0*16777216,0xFF000000);
		CVar("X",GMode,Exactly,3);
	},{
		SetNVar(Common_UType,SetTo,0*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000);
		SetNVar(Common_XUType,SetTo,70);
	},{Preserved})
CIfEnd()

CIf(FP,Memory(0x628438,AtLeast,1))
	CIf(FP,CDeaths("X",Exactly,0,VInput))
		CMov(FP,Common_XUType,Common_UType,0,0xFFFF)
	CIfEnd()
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_XUType,"CLoc106",UPlayer);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100); -- 클로킹
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF); -- 현재건작 유저 인식
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,InvTimer,0xFF000000); -- 개별건작 타이머
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00); -- 현재건작 유저 인식
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF); -- 개별건작 표식
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
		},{Preserved})
		CTrigger(FP,{NVar(Common_XUType,Exactly,10)},{ -- 파벳 스팀팩
			TSetMemoryX(Vi(Nextptr[2],69),SetTo,255*256,0xFF00);
		},{Preserved})
CIfEnd()

DoActionsX(FP,{SetNVar(Common_UType,Subtract,1*16777216,0xFF000000),SetCDeaths("X",Subtract,1,VInput)})

SetLabel(0x5001)
CJumpEnd(FP,3)

function CA_GunPreset(Player,BuildingID,LockSwitch,Index,Location,ShapeA,ShapeB)
	GunPlayer = Player
	BID = BuildingID
	GLock = LockSwitch
	DIndex = Index -- GunIndex Auto Apply
	GLoc = Location
	GXtra = ShapeA -- Normal Shape
	GHero = ShapeB -- Normal Shape
	XUType = 0x0200+100+7*DIndex-6
	InvTimeIndex = 0x0200+100+7*DIndex-5
	VFlag256Index = 0x0200+100+7*DIndex-4
	VFlagIndex = 0x0200+100+7*DIndex-3
	NextDot = 0x0200+100+7*DIndex-2 -- V1 = Data Index
	UType = 0x0200+100+7*DIndex-1 -- V2 = UnitID
	SType = 0x0200+100+7*DIndex -- V3 = ShapeID
	Stage = N[5*DIndex-4]
	Timer = N[5*DIndex-3] -- GunTimer
	AngleG = N[5*DIndex-2] -- SaveAngle Var
	AirType = N[5*DIndex-1] -- If AirUnit , Apply CA_Rotate ( 6 degree per sec )
	OrderG = N[5*DIndex] -- Order Var ( 0xFF : Order // 0xFF000000 : Penalty )
end

XUnitsArr = {48,53,54,104}

DText1 =  "\x13\x1F─━┫ \x1FL\x04air 를 파괴했습니다. \x19+20,000\x04ⓟⓣⓢ  \x1F┣━─"
DText2 =  "\x13\x1F─━┫ \x1FH\x04ive 를 파괴했습니다. \x19+30,000\x04ⓟⓣⓢ  \x1F┣━─"

function SetGunSystem(GLoc,PlayerID,N_A1,N_A2,N_G1,N_G2,H_A1,H_A2,H_G1,H_G2,L_A1,L_A2,L_G1,L_G2,InvGunTimer)

CIfX(FP,{CVar("X",GMode,Exactly,1)})
		CSPlotX(GXtra,PlayerID,XUnitsArr,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,0,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GXtra,PlayerID,N_A1,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,0,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GHero,PlayerID,N_G1,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,0,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GHero,PlayerID,56,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,0,Stage),CDeaths(FP,Exactly,0,Timer)})
		SetLocCenter(GLoc,"CLoc76")
		TriggerX(FP,{
			CDeaths("X",Exactly,0,Stage);
			CDeaths("X",Exactly,0,Timer);
		},{
			SetCDeaths("X",SetTo,1,Stage);
			SetCDeaths("X",SetTo,360,Timer);
			Simple_CalcLoc("CLoc76",-512,-512,512,512);
			Order("Factories",PlayerID,"CLoc76",Attack,"HZ");
			Order(N_G1,PlayerID,"CLoc76",Patrol,"HZ");
			Order(N_A1,PlayerID,"CLoc76",Attack,"HZ");
		})
		CSPlotX(GXtra,PlayerID,XUnitsArr,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,1,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GXtra,PlayerID,N_A2,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,1,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GHero,PlayerID,N_G2,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,1,Stage),CDeaths(FP,Exactly,0,Timer)})
		CSPlot(GHero,PlayerID,56,"CLoc106",GCenter,1,32,FP,{Label(0),CDeaths(FP,Exactly,1,Stage),CDeaths(FP,Exactly,0,Timer)})
		SetLocCenter(GLoc,"CLoc76")
		TriggerX(FP,{
			CDeaths("X",Exactly,1,Stage);
			CDeaths("X",Exactly,0,Timer);
		},{
			SetCDeaths("X",SetTo,2,Stage);
			SetCDeaths("X",SetTo,360,Timer);
			Simple_CalcLoc("CLoc76",-512,-512,512,512);
			Order("Factories",PlayerID,"CLoc76",Attack,"HZ");
			Order(N_A2,PlayerID,"CLoc76",Attack,"HZ");
			Order(N_G2,PlayerID,"CLoc76",Patrol,"HZ");
		})
	CElseIfX({CVar("X",GMode,Exactly,2)})
		SaveAngle()
			DoActionsX(FP,{ -- 유닛생성 막는곳
				SetCVar("X",NextDot,SetTo,600);
				SetNVar(UPlayer,SetTo,PlayerID);
				SetNVar(V(InvTimeIndex),SetTo,(10*InvGunTimer+47)*16777216);
			}) 

			TriggerX(FP,{CDeaths("X",Exactly,0,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCDeaths("X",SetTo,1,Stage);
				SetCDeaths("X",SetTo,1,Timer)})

			TriggerX(FP,{CDeaths("X",Exactly,1,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,192); -- 잡몹지상
				SetCVar("X",SType,SetTo,1);
				SetCDeaths("X",SetTo,2,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})

			TriggerX(FP,{CDeaths("X",Exactly,2,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,193); -- 잡몹공중
				SetCVar("X",SType,SetTo,1);
				SetCDeaths("X",SetTo,3,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})

			TriggerX(FP,{CDeaths("X",Exactly,3,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,H_A1); -- 영웅공중1
				SetCVar("X",SType,SetTo,2);
				SetCDeaths("X",SetTo,4,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,4,Stage),CDeaths("X",Exactly,0,Timer);},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,H_G1); -- 영웅지상1
				SetCVar("X",SType,SetTo,2);
				SetCDeaths("X",SetTo,5,Stage);
				SetCDeaths("X",SetTo,30*12,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
			})
			TriggerX(FP,{CDeaths("X",Exactly,5,Stage),CDeaths("X",Exactly,0,Timer);},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,192); -- 잡몹지상
				SetCVar("X",SType,SetTo,1);
				SetCDeaths("X",SetTo,6,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
			})
			TriggerX(FP,{CDeaths("X",Exactly,6,Stage);CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,193); -- 잡몹공중
				SetCVar("X",SType,SetTo,1);
				SetCDeaths("X",SetTo,7,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
			})
			TriggerX(FP,{CDeaths("X",Exactly,7,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,H_A2); -- 영웅공중2
				SetCVar("X",SType,SetTo,2);
				SetCDeaths("X",SetTo,8,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
			})
			TriggerX(FP,{CDeaths("X",Exactly,8,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,H_G2); -- 영웅지상2
				SetCVar("X",SType,SetTo,2);
				SetCDeaths("X",SetTo,9,Stage);
				SetCDeaths("X",SetTo,30*12,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				SetSwitch(GLock,Set);
			})
		LoadAngle() -- 저장한 각도 불러옴
--< Lunatic >----------------------------------------------
	CElseX() -- Lunatic
		DoActionsX(FP,{ -- 유닛생성 막는곳
			SetCVar("X",NextDot,SetTo,600);
			SetNVar(UPlayer,SetTo,PlayerID);
			SetNVar(V(InvTimeIndex),SetTo,(13*InvGunTimer+47)*16777216);
		})
			TriggerX(FP,{CDeaths("X",Exactly,0,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCDeaths("X",SetTo,1,Stage);
				SetCDeaths("X",SetTo,1,Timer);
			})

			TriggerX(FP,{CDeaths("X",Exactly,1,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,192); -- 잡몹지상
				SetCVar("X",SType,SetTo,3);
				SetCDeaths("X",SetTo,2,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,2,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,193); -- 잡몹공중
				SetCVar("X",SType,SetTo,3);
				SetCDeaths("X",SetTo,3,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,3,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,L_A1); -- 영웅공중1
				SetCVar("X",SType,SetTo,4);
				SetCDeaths("X",SetTo,4,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,4,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,L_G1); -- 영웅지상1
				SetCVar("X",SType,SetTo,4);
				SetCDeaths("X",SetTo,5,Stage);
				SetCDeaths("X",SetTo,30*12,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,5,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,192); -- 잡몹지상
				SetCVar("X",SType,SetTo,3);
				SetCDeaths("X",SetTo,6,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,6,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,193); -- 잡몹공중
				SetCVar("X",SType,SetTo,3);
				SetCDeaths("X",SetTo,7,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,7,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,L_A2); -- 영웅공중2
				SetCVar("X",SType,SetTo,4);
				SetCDeaths("X",SetTo,8,Stage);
				SetCDeaths("X",SetTo,1,Timer);
				SetCDeaths("X",SetTo,1,AirType);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF)})
			TriggerX(FP,{CDeaths("X",Exactly,8,Stage),CDeaths("X",Exactly,0,Timer)},{
				SetCVar("X",NextDot,SetTo,0);
				SetCVar("X",UType,SetTo,L_G2); -- 영웅지상2
				SetCVar("X",SType,SetTo,4);
				SetCDeaths("X",SetTo,9,Stage);
				SetCDeaths("X",SetTo,30*12,Timer);
				SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				SetSwitch(GLock,Set);
			})
CIfXEnd()
end	

PenaltyLocSize = 256

function SetOrder(PlayerID,H_A1,H_A2,H_G1,H_G2,L_A1,L_A2,L_G1,L_G2)
DoActionsX(FP,{SetCDeaths("X",Subtract,1,VInput),SetCDeaths("X",Subtract,1,AirType)})
	SetLocCenter(GLoc,"CLoc76");
	TriggerX(FP,{
		CDeathsX("X",Exactly,1,OrderG,0xFF);
	},{
		Simple_CalcLoc("CLoc76",-768,-768,768,768);
		Order(H_A1,PlayerID,"CLoc76",Attack,"HZ");
		Order(H_A2,PlayerID,"CLoc76",Attack,"HZ");
		Order(H_G1,PlayerID,"CLoc76",Attack,"HZ");
		Order(H_G2,PlayerID,"CLoc76",Attack,"HZ");
		Order(L_A1,PlayerID,"CLoc76",Attack,"HZ");
		Order(L_A2,PlayerID,"CLoc76",Attack,"HZ");
		Order(L_G1,PlayerID,"CLoc76",Attack,"HZ");
		Order(L_G2,PlayerID,"CLoc76",Attack,"HZ");
		Order("Factories",PlayerID,"CLoc76",Attack,"HZ");
		SetCDeathsX("X",Subtract,1,OrderG,0xFF);
	},{Preserved})
	SetLocCenter(GLoc,"CLoc76");
DoActionsX(FP,{
	Simple_CalcLoc("CLoc76",-PenaltyLocSize,-PenaltyLocSize,PenaltyLocSize,PenaltyLocSize);
	KillUnitAt(1,72,"CLoc76",P12);
	SetCDeathsX("X",Subtract,1*16777216,OrderG,0xFF000000);
})
CIf(FP,{CVar("X",CPlayer,Exactly,1),Bring(Force1,AtMost,3,"Men","CLoc76"),CDeathsX("X",Exactly,0*16777216,OrderG,0xFF000000)}) -- Solo Penalty
NIf(FP,{Memory(0x628438,AtLeast,1)})
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},
				{
			TCreateUnit(1,PUnit,"CLoc76",P8);
			TSetMemory(Vi(Nextptr[2],13),SetTo,1707); -- Max Speed
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,48,0xFFFF); -- Acceleration
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
			TSetMemoryX(Vi(Nextptr[2],57),SetTo,2^5,0xFF);
			TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
			TSetMemoryX(Vi(Nextptr[2],73),SetTo,(2^5)*256,0xFF00); -- Unused Timer
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
			TOrder(PUnit,P8,"CLoc76",Attack,"HZ");
			SetCDeathsX("X",SetTo,3*34*16777216,OrderG,0xFF000000);
		},{Preserved})
NIfEnd()
CIfEnd()
end


----< 일반 건작 >--------------------------------------------
CIf(FP,Switch("Switch 255", Cleared))

------<  L1  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL1 = CSMakePath({-283,-126},{186,-26},{-301,282})
SHL1a = CS_FillPathGradY(SHL1,1,50,"GRADX",3,0,0,1) -- N_XUnit (17)
SHL1b = CS_FillPathGradY(SHL1,1,80,"GRADX",3,0,0,1) -- N_Hero  (8)
SHL1c = CS_FillPathGradY(SHL1,1,40,"GRADX",3,0,0,1) -- H_XUnit (26)
SHL1d = CS_FillPathGradY(SHL1,1,60,"GRADX",3,0,0,1) -- H_Hero (11)
SHL1e = CS_FillPathGradY(SHL1,1,35,"GRADX",3,0,0,1) -- L_XUnit (31)
SHL1f = CS_FillPathGradY(SHL1,1,55,"GRADX",3,0,0,1) -- L_Hero (14)
GCenter = {320,7312}
HShapeA = SHL1c
HShapeB = SHL1d
LShapeA = SHL1e
LShapeB = SHL1f
-- Preset --
CA_GunPreset(P6,132,"Switch 32",2,"L1",SHL1a,SHL1b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L1")})

SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,1);
		SetNVar(BuildTimeVar,Add,1);
		SetNVar(BGMVar[1],SetTo,1);
		SetNVar(BGMVar[2],SetTo,1);
		SetNVar(BGMVar[3],SetTo,1);
		SetNVar(BGMVar[4],SetTo,1);
		SetNVar(BGMVar[5],SetTo,1);	
		SetScore(Force1,Add,20000,Kills);
})
	function L1func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L1",GunPlayer,55,55,54,53,55,56,104,40,56,56,40,51,0)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L1Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,104,40,56,56,40,51)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()


------<  L2  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL2 = CSMakePath({-326,31},{-30,199},{-32,-199})
SHL2a = CS_FillPathGradX(SHL2,1,50,"GRADX",3,0,0,1) -- N_XUnit (17)
SHL2b = CS_FillPathGradX(SHL2,1,80,"GRADX",3,0,0,1) -- N_Hero (8)
SHL2c = CS_FillPathGradX(SHL2,1,40,"GRADX",3,0,0,1) -- H_XUnit (26)
SHL2d = CS_FillPathGradX(SHL2,1,60,"GRADX",3,0,0,1) -- H_Hero (12)
SHL2e = CS_FillPathGradX(SHL2,1,35,"GRADX",3,0,0,1) -- L_XUnit (33)
SHL2f = CS_FillPathGradX(SHL2,1,55,"GRADX",3,0,0,1) -- L_Hero (16)
GCenter = {576,7056}
HShapeA = SHL2c
HShapeB = SHL2d
LShapeA = SHL2e
LShapeB = SHL2f

-- Preset --

CA_GunPreset(P6,132,"Switch 33",3,"L2",SHL2a,SHL2b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L2")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,1);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,1);
	SetNVar(BGMVar[2],SetTo,1);
	SetNVar(BGMVar[3],SetTo,1);
	SetNVar(BGMVar[4],SetTo,1);
	SetNVar(BGMVar[5],SetTo,1);	
	SetScore(Force1,Add,20000,Kills);
})
	function L2func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L2",GunPlayer,55,55,53,48,55,56,40,51,56,56,51,77,0)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L2Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,40,51,56,56,51,77)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

--832,6848

------<  H1  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH1 = CSMakePath({185,-262},{-262,0},{176,347})
SHH1a = CS_FillPathGradY(SHH1,1,60,"GRADX",3,0,0,1) -- N_XUnit (29)
SHH1b = CS_FillPathGradY(SHH1,1,90,"GRADX",3,0,0,1) -- N_Hero (13)
SHH1c = CS_FillPathGradY(SHH1,1,50,"GRADX",3,0,0,1) -- H_XUnit (41)
SHH1d = CS_FillPathGradY(SHH1,1,80,"GRADX",3,0,0,1) -- H_Hero (16)
SHH1e = CS_FillPathGradY(SHH1,1,45,"GRADX",3,0,0,1) -- L_XUnit (50)
SHH1f = CS_FillPathGradY(SHH1,1,70,"GRADX",3,0,0,1) -- L_Hero (21)
GCenter = {832,6848}
HShapeA = SHH1c
HShapeB = SHH1d
LShapeA = SHH1e
LShapeB = SHH1f

-- Preset --

CA_GunPreset(P8,133,"Switch 34",4,"H1",SHH1a,SHH1b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H1")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,2);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,2);
	SetNVar(BGMVar[2],SetTo,2);
	SetNVar(BGMVar[3],SetTo,2);
	SetNVar(BGMVar[4],SetTo,2);
	SetNVar(BGMVar[5],SetTo,2);	
	SetScore(Force1,Add,30000,Kills);
})
	function H1func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H1",GunPlayer,55,56,104,40,56,70,51,77,70,70,77,78,1)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H1Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,70,51,77,70,70,77,78)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L3  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL3 = CSMakePath({136,-218},{-207,-31},{309,289})
SHL3a = CS_FillPathGradX(SHL3,1,55,"GRADX",3,0,0,1) -- N_XUnit (27)
SHL3b = CS_FillPathGradX(SHL3,1,80,"GRADX",3,0,0,1) -- N_Hero (13)
SHL3c = CS_FillPathGradX(SHL3,1,45,"GRADX",3,0,0,1) -- H_XUnit (35)
SHL3d = CS_FillPathGradX(SHL3,1,75,"GRADX",3,0,0,1) -- H_Hero (15)
SHL3e = CS_FillPathGradX(SHL3,1,40,"GRADX",3,0,0,1) -- L_XUnit (43)
SHL3f = CS_FillPathGradX(SHL3,1,70,"GRADX",3,0,0,1) -- L_Hero (18)
GCenter = {1728,7312}
HShapeA = SHL3c
HShapeB = SHL3d
LShapeA = SHL3e
LShapeB = SHL3f

-- Preset --

CA_GunPreset(P7,132,"Switch 35",5,"L3",SHL3a,SHL3b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L3")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,1);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,1);
	SetNVar(BGMVar[2],SetTo,1);
	SetNVar(BGMVar[3],SetTo,1);
	SetNVar(BGMVar[4],SetTo,1);
	SetNVar(BGMVar[5],SetTo,1);	
	SetScore(Force1,Add,20000,Kills);
})

	function L3func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
						CIf(FP,{CVar("X",SType,Exactly,5)})
							CA_Rotate(_Mul(V(TAngle2),2))
						CIfEnd()
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L3",GunPlayer,55,55,54,53,55,56,104,40,56,56,40,51,0)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L3Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,104,40,56,56,40,51)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L4  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL4 = CSMakePath({-323,-4},{38,219},{40,-216})
SHL4a = CS_FillPathGradX(SHL4,1,50,"GRADX",3,0,0,1) -- N_XUnit (25)
SHL4b = CS_FillPathGradX(SHL4,1,90,"GRADX",3,0,0,1) -- N_Hero (10)
SHL4c = CS_FillPathGradX(SHL4,1,45,"GRADX",3,0,0,1) -- H_XUnit (31)
SHL4d = CS_FillPathGradX(SHL4,1,80,"GRADX",3,0,0,1) -- H_Hero (12)
SHL4e = CS_FillPathGradX(SHL4,1,40,"GRADX",3,0,0,1) -- L_XUnit (39)
SHL4f = CS_FillPathGradX(SHL4,1,70,"GRADX",3,0,0,1) -- L_Hero (15)
GCenter = {1472,7056}
HShapeA = SHL4c
HShapeB = SHL4d
LShapeA = SHL4e
LShapeB = SHL4f

-- Preset --

CA_GunPreset(P7,132,"Switch 36",6,"L4",SHL4a,SHL4b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L4")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,1);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,1);
	SetNVar(BGMVar[2],SetTo,1);
	SetNVar(BGMVar[3],SetTo,1);
	SetNVar(BGMVar[4],SetTo,1);
	SetNVar(BGMVar[5],SetTo,1);	
	SetScore(Force1,Add,20000,Kills);
})
	function L4func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L4",GunPlayer,55,55,53,48,55,56,40,51,56,56,51,77,0)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L4Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,40,51,56,56,51,77)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H2  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH2 = CSMakePath({121,-195},{-225,-169},{-180,332})
SHH2a = CS_FillPathGradY(SHH2,1,45,"GRADX",3,0,0,1) -- N_XUnit (24)
SHH2b = CS_FillPathGradY(SHH2,1,80,"GRADX",3,0,0,1) -- N_Hero (12)
SHH2c = CS_FillPathGradY(SHH2,1,40,"GRADX",3,0,0,1) -- H_XUnit (39)
SHH2d = CS_FillPathGradY(SHH2,1,60,"GRADX",3,0,0,1) -- H_Hero (19)
SHH2e = CS_FillPathGradY(SHH2,1,35,"GRADX",3,0,0,1) -- L_XUnit (51)
SHH2f = CS_FillPathGradY(SHH2,1,50,"GRADX",3,0,0,1) -- L_Hero (24)
GCenter = {1216,6848}
HShapeA = SHH2c
HShapeB = SHH2d
LShapeA = SHH2e
LShapeB = SHH2f
-- Preset --

CA_GunPreset(P8,133,"Switch 37",7,"H2",SHH2a,SHH2b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H2")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,2);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,2);
	SetNVar(BGMVar[2],SetTo,2);
	SetNVar(BGMVar[3],SetTo,2);
	SetNVar(BGMVar[4],SetTo,2);
	SetNVar(BGMVar[5],SetTo,2);	
	SetScore(Force1,Add,30000,Kills);
})
	function H2func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H2",GunPlayer,55,56,104,40,56,70,51,77,70,70,77,78,1)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H2Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,70,51,77,70,70,77,78)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L5  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL5 = CSMakePath({-116,-69},{-122,281},{432,-98},{258,-283})
SHL5a = CS_FillPathGradY(SHL5,1,60,"GRADX",3,0,0,1) -- N_XUnit (23)
SHL5b = CS_FillPathGradY(SHL5,1,80,"GRADX",3,0,0,1) -- N_Hero (14)
SHL5c = CS_FillPathGradY(SHL5,1,50,"GRADX",3,0,0,1) -- H_XUnit (34)
SHL5d = CS_FillPathGradY(SHL5,1,70,"GRADX",3,0,0,1) -- H_Hero (18)
SHL5e = CS_FillPathGradY(SHL5,1,45,"GRADX",3,0,0,1) -- L_XUnit (40)
SHL5f = CS_FillPathGradY(SHL5,1,65,"GRADX",3,0,0,1) -- L_Hero (21)
GCenter = {128,6832}
HShapeA = SHL5c
HShapeB = SHL5d
LShapeA = SHL5e
LShapeB = SHL5f

-- Preset --

CA_GunPreset(P6,132,"Switch 38",8,"L5",SHL5a,SHL5b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L5")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,1);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,1);
	SetNVar(BGMVar[2],SetTo,1);
	SetNVar(BGMVar[3],SetTo,1);
	SetNVar(BGMVar[4],SetTo,1);
	SetNVar(BGMVar[5],SetTo,1);	
	SetScore(Force1,Add,20000,Kills);
})
	function L5func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
						CIf(FP,{CVar("X",SType,Exactly,5)})
							CA_Rotate(_Mul(V(TAngle2),2))
						CIfEnd()
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L5",GunPlayer,55,55,40,51,55,56,77,78,56,56,78,78,2)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L5Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,77,78,56,56,78,78)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H3  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH3 = CSMakePath({-43,-147},{-290,-74},{196,197},{361,52})
SHH3a = CS_FillPathGradX(SHH3,1,60,"GRADX",3,0,0,1) -- N_XUnit (33)
SHH3b = CS_FillPathGradX(SHH3,1,85,"GRADX",3,0,0,1) -- N_Hero (17)
SHH3c = CS_FillPathGradX(SHH3,1,50,"GRADX",3,0,0,1) -- H_XUnit (48)
SHH3d = CS_FillPathGradX(SHH3,1,75,"GRADX",3,0,0,1) -- H_Hero (24)
SHH3e = CS_FillPathGradX(SHH3,1,45,"GRADX",3,0,0,1) -- L_XUnit (58)
SHH3f = CS_FillPathGradX(SHH3,1,65,"GRADX",3,0,0,1) -- L_Hero (31)
GCenter = {288,6592}
HShapeA = SHH3c
HShapeB = SHH3d
LShapeA = SHH3e
LShapeB = SHH3f

-- Preset --

CA_GunPreset(P6,133,"Switch 39",9,"H3",SHH3a,SHH3b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H3")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,2);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,2);
	SetNVar(BGMVar[2],SetTo,2);
	SetNVar(BGMVar[3],SetTo,2);
	SetNVar(BGMVar[4],SetTo,2);
	SetNVar(BGMVar[5],SetTo,2);	
	SetScore(Force1,Add,30000,Kills);
})
	function H3func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H3",GunPlayer,56,56,51,77,56,70,78,78,70,70,78,79,3)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H3Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,70,78,78,70,70,78,79)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L6  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL6 = CSMakePath({-338,-299},{-461,-83},{91,258},{92,-66})
SHL6a = CS_FillPathGradY(SHL6,1,60,"GRADX",3,0,0,1) -- N_XUnit (26)
SHL6b = CS_FillPathGradY(SHL6,1,80,"GRADX",3,0,0,1) -- N_Hero (13)
SHL6c = CS_FillPathGradY(SHL6,1,50,"GRADX",3,0,0,1) -- H_XUnit (35)
SHL6d = CS_FillPathGradY(SHL6,1,70,"GRADX",3,0,0,1) -- H_Hero (17)
SHL6e = CS_FillPathGradY(SHL6,1,45,"GRADX",3,0,0,1) -- L_XUnit (43)
SHL6f = CS_FillPathGradY(SHL6,1,65,"GRADX",3,0,0,1) -- L_Hero (20)
GCenter = {1920,6832}
HShapeA = SHL6c
HShapeB = SHL6d
LShapeA = SHL6e
LShapeB = SHL6f
-- Preset --

CA_GunPreset(P7,132,"Switch 40",10,"L6",SHL6a,SHL6b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L6")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,1);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,1);
	SetNVar(BGMVar[2],SetTo,1);
	SetNVar(BGMVar[3],SetTo,1);
	SetNVar(BGMVar[4],SetTo,1);
	SetNVar(BGMVar[5],SetTo,1);	
	SetScore(Force1,Add,20000,Kills);
})
	function L6func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2))
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L6",GunPlayer,55,55,40,51,55,56,77,78,56,56,78,78,2)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L6Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,77,78,56,56,78,78)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H4  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH4 = CSMakePath({72,-216},{-396,59},{-237,203},{258,-69})
SHH4a = CS_FillPathGradX(SHH4,1,60,"GRADX",3,0,0,1) -- N_XUnit (33)
SHH4b = CS_FillPathGradX(SHH4,1,85,"GRADX",3,0,0,1) -- N_Hero (18)
SHH4c = CS_FillPathGradX(SHH4,1,50,"GRADX",3,0,0,1) -- H_XUnit (45)
SHH4d = CS_FillPathGradX(SHH4,1,75,"GRADX",3,0,0,1) -- H_Hero (21)
SHH4e = CS_FillPathGradX(SHH4,1,45,"GRADX",3,0,0,1) -- L_XUnit (55)
SHH4f = CS_FillPathGradX(SHH4,1,65,"GRADX",3,0,0,1) -- L_Hero (30)
GCenter = {1760,6592}
HShapeA = SHH4c
HShapeB = SHH4d
LShapeA = SHH4e
LShapeB = SHH4f
-- Preset --

CA_GunPreset(P7,133,"Switch 41",11,"H4",SHH4a,SHH4b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H4")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,2);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,2);
	SetNVar(BGMVar[2],SetTo,2);
	SetNVar(BGMVar[3],SetTo,2);
	SetNVar(BGMVar[4],SetTo,2);
	SetNVar(BGMVar[5],SetTo,2);	
	SetScore(Force1,Add,30000,Kills);
})
	function H4func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H4",GunPlayer,56,56,51,77,56,70,78,78,70,70,78,79,3)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H4Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,70,78,78,70,70,78,79)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L7  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL7 = CSMakePath({-74,-85},{-66,85},{290,395},{282,-268})
SHL7a = CS_FillPathGradX(SHL7,1,55,"GRADX",3,0,0,1) -- N_XUnit (24)
SHL7b = CS_FillPathGradX(SHL7,1,75,"GRADX",3,0,0,1) -- N_Hero (14)
SHL7c = CS_FillPathGradX(SHL7,1,50,"GRADX",3,0,0,1) -- H_XUnit (31)
SHL7d = CS_FillPathGradX(SHL7,1,70,"GRADX",3,0,0,1) -- H_Hero (19)
SHL7e = CS_FillPathGradX(SHL7,1,40,"GRADX",3,0,0,1) -- L_XUnit (40)
SHL7f = CS_FillPathGradX(SHL7,1,55,"GRADX",3,0,0,1) -- L_Hero (24)
GCenter = {704,5808}
HShapeA = SHL7c
HShapeB = SHL7d
LShapeA = SHL7e
LShapeB = SHL7f

-- Preset --

CA_GunPreset(P6,132,"Switch 42",12,"L7",SHL7a,SHL7b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L7")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,4);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,4);
	SetNVar(BGMVar[2],SetTo,4);
	SetNVar(BGMVar[3],SetTo,4);
	SetNVar(BGMVar[4],SetTo,4);
	SetNVar(BGMVar[5],SetTo,4);	
	SetScore(Force1,Add,20000,Kills);
})
	function L7func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L7",GunPlayer,55,55,77,77,55,56,79,79,56,56,79,75,4)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L7Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,79,79,56,56,79,75)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L8  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL8 = CSMakePath({-247,7},{0,-123},{195,-6},{0,331})
SHL8a = CS_FillPathGradY(SHL8,1,50,"GRADX",3,0,90,1) -- N_XUnit (25)
SHL8b = CS_FillPathGradY(SHL8,1,80,"GRADX",3,0,90,1) -- N_Hero (11)
SHL8c = CS_FillPathGradY(SHL8,1,40,"GRADX",3,0,90,1) -- H_XUnit (39)
SHL8d = CS_FillPathGradY(SHL8,1,60,"GRADX",3,0,90,1) -- H_Hero (19)
SHL8e = CS_FillPathGradY(SHL8,1,35,"GRADX",3,0,90,1) -- L_XUnit (48)
SHL8f = CS_FillPathGradY(SHL8,1,55,"GRADX",3,0,90,1) -- L_Hero (23)
GCenter = {512,5584}
HShapeA = SHL8c
HShapeB = SHL8d
LShapeA = SHL8e
LShapeB = SHL8f

-- Preset --

CA_GunPreset(P6,132,"Switch 43",13,"L8",SHL8a,SHL8b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L8")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,4);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,4);
	SetNVar(BGMVar[2],SetTo,4);
	SetNVar(BGMVar[3],SetTo,4);
	SetNVar(BGMVar[4],SetTo,4);
	SetNVar(BGMVar[5],SetTo,4);	
	SetScore(Force1,Add,20000,Kills);
})
	function L8func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L8",GunPlayer,55,55,77,78,55,56,79,75,56,56,75,75,4)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L8Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,79,75,56,56,75,75)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H5  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH5 = CSMakePath({-188,-178},{-188,273},{353,0})
SHH5a = CS_FillPathGradY(SHH5,1,50,"GRADX",3,0,0,1) -- N_XUnit (34)
SHH5b = CS_FillPathGradY(SHH5,1,75,"GRADX",3,0,0,1) -- N_Hero (19)
SHH5c = CS_FillPathGradY(SHH5,1,40,"GRADX",3,0,0,1) -- H_XUnit (47)
SHH5d = CS_FillPathGradY(SHH5,1,70,"GRADX",3,0,0,1) -- H_Hero (20)
SHH5e = CS_FillPathGradY(SHH5,1,35,"GRADX",3,0,0,1) -- L_XUnit (54)
SHH5f = CS_FillPathGradY(SHH5,1,60,"GRADX",3,0,0,1) -- L_Hero (25)
GCenter = {224,5728} 
HShapeA = SHH5c
HShapeB = SHH5d
LShapeA = SHH5e
LShapeB = SHH5f

-- Preset --

CA_GunPreset(P6,133,"Switch 44",14,"H5",SHH5a,SHH5b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H5")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,5);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,5);
	SetNVar(BGMVar[2],SetTo,5);
	SetNVar(BGMVar[3],SetTo,5);
	SetNVar(BGMVar[4],SetTo,5);
	SetNVar(BGMVar[5],SetTo,5);	
	SetScore(Force1,Add,30000,Kills);
})
	function H5func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H5",GunPlayer,56,70,78,78,56,80,75,75,70,80,75,76,5)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H5Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,80,75,75,70,80,75,76)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L9  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL9 = CSMakePath({0,0},{-309,-344},{-307,227})
SHL9a = CS_FillPathGradY(SHL9,1,65,"GRADX",3,0,0,1) -- N_XUnit (23)
SHL9b = CS_FillPathGradY(SHL9,1,90,"GRADX",3,0,0,1) -- N_Hero (14)
SHL9c = CS_FillPathGradY(SHL9,1,55,"GRADX",3,0,0,1) -- H_XUnit (33)
SHL9d = CS_FillPathGradY(SHL9,1,75,"GRADX",3,0,0,1) -- H_Hero (18)
SHL9e = CS_FillPathGradY(SHL9,1,45,"GRADX",3,0,0,1) -- L_XUnit (48)
SHL9f = CS_FillPathGradY(SHL9,1,65,"GRADX",3,0,0,1) -- L_Hero (23)
GCenter = {1344,5808}
HShapeA = SHL9c
HShapeB = SHL9d
LShapeA = SHL9e
LShapeB = SHL9f
-- Preset --

CA_GunPreset(P7,132,"Switch 45",15,"L9",SHL9a,SHL9b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L9")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,4);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,4);
	SetNVar(BGMVar[2],SetTo,4);
	SetNVar(BGMVar[3],SetTo,4);
	SetNVar(BGMVar[4],SetTo,4);
	SetNVar(BGMVar[5],SetTo,4);	
	SetScore(Force1,Add,20000,Kills);
})
	function L9func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L9",GunPlayer,55,55,77,77,55,56,19,19,56,56,19,17,4)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L9Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,17,17,56,56,17,19)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L10  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL10 = CSMakePath({0,-63},{503,87},{0,309},{-448,68})
SHL10a = CS_FillPathGradY(SHL10,1,45,"GRADX",3,0,0,1) -- H_XUnit (22)
SHL10b = CS_FillPathGradY(SHL10,1,60,"GRADX",3,0,0,1) -- N_Hero (14)
SHL10c = CS_FillPathGradY(SHL10,1,35,"GRADX",3,0,0,1) -- H_XUnit (34)
SHL10d = CS_FillPathGradY(SHL10,1,50,"GRADX",3,0,0,1) -- H_Hero (21)
SHL10e = CS_FillPathGradY(SHL10,1,30,"GRADX",3,0,0,1) -- L_XUnit (44)
SHL10f = CS_FillPathGradY(SHL10,1,40,"GRADX",3,0,0,1) -- L_Hero (29)
GCenter = {1536,5584} 
HShapeA = SHL10c
HShapeB = SHL10d
LShapeA = SHL10e
LShapeB = SHL10f

-- Preset --

CA_GunPreset(P7,132,"Switch 46",16,"L10",SHL10a,SHL10b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L10")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,4);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,4);
	SetNVar(BGMVar[2],SetTo,4);
	SetNVar(BGMVar[3],SetTo,4);
	SetNVar(BGMVar[4],SetTo,4);
	SetNVar(BGMVar[5],SetTo,4);	
	SetScore(Force1,Add,20000,Kills);
})
	function L10func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L10",GunPlayer,55,55,77,78,55,56,19,17,56,56,17,17,4)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L10Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,55,56,17,19,56,56,19,19)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H6  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH6 = CSMakePath({-200,-50},{-200,100},{231,263},{186,-208})
SHH6a = CS_FillPathGradY(SHH6,1,60,"GRADX",3,0,0,1) -- N_XUnit (26)
SHH6b = CS_FillPathGradY(SHH6,1,80,"GRADX",3,0,0,1) -- N_Hero (16)
SHH6c = CS_FillPathGradY(SHH6,1,50,"GRADX",3,0,0,1) -- H_XUnit (37)
SHH6d = CS_FillPathGradY(SHH6,1,70,"GRADX",3,0,0,1) -- H_Hero (21)
SHH6e = CS_FillPathGradY(SHH6,1,45,"GRADX",3,0,0,1) -- L_XUnit (45)
SHH6f = CS_FillPathGradY(SHH6,1,60,"GRADX",3,0,0,1) -- L_Hero (26)
GCenter = {1824,5728} 
HShapeA = SHH6c
HShapeB = SHH6d
LShapeA = SHH6e
LShapeB = SHH6f

-- Preset --

CA_GunPreset(P7,133,"Switch 47",17,"H6",SHH6a,SHH6b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H6")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,5);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,5);
	SetNVar(BGMVar[2],SetTo,5);
	SetNVar(BGMVar[3],SetTo,5);
	SetNVar(BGMVar[4],SetTo,5);
	SetNVar(BGMVar[5],SetTo,5);	
	SetScore(Force1,Add,30000,Kills);
})
	function H6func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H6",GunPlayer,56,70,78,78,56,21,17,17,70,21,17,74,5)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H6Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,21,17,17,70,21,17,74)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H7  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH7 = CSMakePath({-248,-202},{3,-82},{69,-114},{363,38},{193,112},{128,81},{-62,181},{-250,86})
SHH7a = CS_FillPathGradX(SHH7,1,60,"GRADX",3,0,0,1) -- N_XUnit (30)
SHH7b = CS_FillPathGradX(SHH7,1,70,"GRADX",3,0,0,1) -- N_Hero (22)
SHH7c = CS_FillPathGradX(SHH7,1,50,"GRADX",3,0,0,1) -- H_XUnit (39)
SHH7d = CS_FillPathGradX(SHH7,1,65,"GRADX",3,0,0,1) -- H_Hero (28)
SHH7e = CS_FillPathGradX(SHH7,1,40,"GRADX",3,0,0,1) -- L_XUnit (58)
SHH7f = CS_FillPathGradX(SHH7,1,60,"GRADX",3,0,0,1) -- L_Hero (30)
GCenter = {256,5104}
HShapeA = SHH7c
HShapeB = SHH7d
LShapeA = SHH7e
LShapeB = SHH7f

-- Preset --

CA_GunPreset(P6,133,"Switch 48",18,"H7",SHH7a,SHH7b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H7")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,5);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,5);
	SetNVar(BGMVar[2],SetTo,5);
	SetNVar(BGMVar[3],SetTo,5);
	SetNVar(BGMVar[4],SetTo,5);
	SetNVar(BGMVar[5],SetTo,5);	
	SetScore(Force1,Add,30000,Kills);
})
	function H7func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H7",GunPlayer,56,80,79,79,70,86,76,76,70,86,76,81,6)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H7Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,70,86,76,76,70,86,76,81)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H8  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH8 = CSMakePath({237,-173},{9,-66},{-72,-94},{-356,34},{-200,115},{-129,85},{54,179},{242,83})
SHH8a = CS_FillPathGradX(SHH8,1,60,"GRADX",3,0,0,1) -- N_XUnit (40)
SHH8b = CS_FillPathGradX(SHH8,1,80,"GRADX",3,0,0,1) -- N_Hero (25)
SHH8c = CS_FillPathGradX(SHH8,1,55,"GRADX",3,0,0,1) -- H_XUnit (48)
SHH8d = CS_FillPathGradX(SHH8,1,75,"GRADX",3,0,0,1) -- H_Hero (27)
SHH8e = CS_FillPathGradX(SHH8,1,50,"GRADX",3,0,0,1) -- L_XUnit (55)
SHH8f = CS_FillPathGradX(SHH8,1,70,"GRADX",3,0,0,1) -- L_Hero (32)
GCenter = {1792,5104}
HShapeA = SHH8c
HShapeB = SHH8d
LShapeA = SHH8e
LShapeB = SHH8f
-- Preset --

CA_GunPreset(P7,133,"Switch 49",19,"H8",SHH8a,SHH8b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H8")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,5);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,5);
	SetNVar(BGMVar[2],SetTo,5);
	SetNVar(BGMVar[3],SetTo,5);
	SetNVar(BGMVar[4],SetTo,5);
	SetNVar(BGMVar[5],SetTo,5);	
	SetScore(Force1,Add,30000,Kills);
})
	function H8func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H8",GunPlayer,56,80,19,19,56,58,74,74,70,58,74,10,6)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H8Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,70,86,74,74,70,86,74,10)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L11  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL11 = CSMakePath({6,-504},{-390,-290},{-390,-57},{209,-351})
SHL11a = CS_FillPathGradY(SHL11,1,50,"GRADX",3,0,0,1) -- N_XUnit (25)
SHL11b = CS_FillPathGradY(SHL11,1,70,"GRADX",3,0,0,1) -- N_Hero (15)
SHL11c = CS_FillPathGradY(SHL11,1,40,"GRADX",3,0,0,1) -- H_XUnit (40)
SHL11d = CS_FillPathGradY(SHL11,1,60,"GRADX",3,0,0,1) -- H_Hero (20)
SHL11e = CS_FillPathGradY(SHL11,1,35,"GRADX",3,0,0,1) -- L_XUnit (48)
SHL11f = CS_FillPathGradY(SHL11,1,55,"GRADX",3,0,0,1) -- L_Hero (24)
GCenter = {416,4688}
HShapeA = SHL11c
HShapeB = SHL11d
LShapeA = SHL11e
LShapeB = SHL11f

-- Preset --

CA_GunPreset(P6,132,"Switch 50",20,"L11",SHL11a,SHL11b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L11")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,7);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,7);
	SetNVar(BGMVar[2],SetTo,7);
	SetNVar(BGMVar[3],SetTo,7);
	SetNVar(BGMVar[4],SetTo,7);
	SetNVar(BGMVar[5],SetTo,7);	
	SetScore(Force1,Add,20000,Kills);
})
	function L11func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L11",GunPlayer,55,55,75,75,56,80,81,81,70,80,81,3,7)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L11Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,80,81,81,70,80,81,3)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L12  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL12 = CSMakePath({-313,30},{324,14},{325,-401})
SHL12a = CS_FillPathGradY(SHL12,1,55,"GRADX",3,0,0,1) -- N_XUnit (24)
SHL12b = CS_FillPathGradY(SHL12,1,70,"GRADX",3,0,0,1) -- N_Hero (13)
SHL12c = CS_FillPathGradY(SHL12,1,45,"GRADX",3,0,0,1) -- H_XUnit (33)
SHL12d = CS_FillPathGradY(SHL12,1,60,"GRADX",3,0,0,1) -- H_Hero (19)
SHL12e = CS_FillPathGradY(SHL12,1,40,"GRADX",3,0,0,1) -- L_XUnit (43)
SHL12f = CS_FillPathGradY(SHL12,1,55,"GRADX",3,0,0,1) -- L_Hero (24)
GCenter = {1664,4688}
HShapeA = SHL12c
HShapeB = SHL12d
LShapeA = SHL12e
LShapeB = SHL12f
-- Preset --

CA_GunPreset(P7,132,"Switch 51",21,"L12",SHL12a,SHL12b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L12")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,7);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,7);
	SetNVar(BGMVar[2],SetTo,7);
	SetNVar(BGMVar[3],SetTo,7);
	SetNVar(BGMVar[4],SetTo,7);
	SetNVar(BGMVar[5],SetTo,7);	
	SetScore(Force1,Add,20000,Kills);
})
	function L12func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L12",GunPlayer,55,55,17,17,56,21,10,10,70,21,10,5,7)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L12Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,21,10,10,70,21,10,5)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H9  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH9 = CSMakePath({0,0},{-97,-175},{-384,-317},{0,-475},{379,-312},{106,-178},{54,179},{242,83})
SHH9a = CS_FillPathGradX(SHH9,1,55,"GRADX",3,0,0,1) -- N_XUnit (42)
SHH9b = CS_FillPathGradX(SHH9,1,80,"GRADX",3,0,0,1) -- N_Hero (19)
SHH9c = CS_FillPathGradX(SHH9,1,50,"GRADX",3,0,0,1) -- H_XUnit (52)
SHH9d = CS_FillPathGradX(SHH9,1,76,"GRADX",3,0,0,1) -- H_Hero (26)
SHH9e = CS_FillPathGradX(SHH9,1,45,"GRADX",3,0,0,1) -- L_XUnit (58)
SHH9f = CS_FillPathGradX(SHH9,1,65,"GRADX",3,0,0,1) -- L_Hero (29)
GCenter = {1024,4592}
HShapeA = SHH9c
HShapeB = SHH9d
LShapeA = SHH9e
LShapeB = SHH9f
-- Preset --

CA_GunPreset(P8,133,"Switch 52",22,"H9",SHH9a,SHH9b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H9")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H9func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H9",GunPlayer,56,70,75,17,56,12,81,10,70,12,3,5,8)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H9Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,12,81,10,70,12,3,5)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H10  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH10 = CSMakePath({-217,22},{-511,-135},{-299,-299},{-3,-143},{119,7},{-7,184},{-308,323},{-483,176})
SHH10a = CS_FillPathGradX(SHH10,1,55,"GRADX",3,0,0,1) -- N_XUnit (43)
SHH10b = CS_FillPathGradX(SHH10,1,70,"GRADX",3,0,0,1) -- N_Hero (30)
SHH10c = CS_FillPathGradX(SHH10,1,50,"GRADX",3,0,0,1) -- H_XUnit (52)
SHH10d = CS_FillPathGradX(SHH10,1,65,"GRADX",3,0,0,1) -- H_Hero (32)
SHH10e = CS_FillPathGradX(SHH10,1,45,"GRADX",3,0,0,1) -- L_XUnit (62)
SHH10f = CS_FillPathGradX(SHH10,1,60,"GRADX",3,0,0,1) -- L_Hero (36)
GCenter = {640,4144}
HShapeA = SHH10c
HShapeB = SHH10d
LShapeA = SHH10e
LShapeB = SHH10f

-- Preset --

CA_GunPreset(P6,133,"Switch 53",23,"H10",SHH10a,SHH10b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H10")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H10func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H10",GunPlayer,56,70,76,76,56,86,3,25,70,86,64,25,9)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H10Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,86,3,25,70,86,64,25)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H11  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH11 = CSMakePath({0,-137},{220,17},{0,194},{-775,20})
SHH11a = CS_FillPathGradX(SHH11,1,95,"GRADX",3,0,0,1) -- N_XUnit (41)
SHH11b = CS_FillPathGradX(SHH11,1,115,"GRADX",3,0,0,1) -- N_Hero (27)
SHH11c = CS_FillPathGradX(SHH11,1,85,"GRADX",3,0,0,1) -- H_XUnit (49)
SHH11d = CS_FillPathGradX(SHH11,1,105,"GRADX",3,0,0,1) -- H_Hero (33)
SHH11e = CS_FillPathGradX(SHH11,1,80,"GRADX",3,0,0,1) -- L_XUnit (57)
SHH11f = CS_FillPathGradX(SHH11,1,100,"GRADX",3,0,0,1) -- L_Hero (36)
GCenter = {1408,4144}
HShapeA = SHH11c
HShapeB = SHH11d
LShapeA = SHH11e
LShapeB = SHH11f
-- Preset --

CA_GunPreset(P7,133,"Switch 54",24,"H11",SHH11a,SHH11b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H11")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H11func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H11",GunPlayer,56,70,74,74,56,58,5,25,70,58,64,25,9)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H11Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,58,5,25,70,58,64,25)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H12  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH12x = CSMakePath({-90,-259},{-380,-318},{-321,-97},{0,0})
SHH12xa = CS_FillPathGradY(SHH12x,1,40,"GRADX",3,0,0,1)
SHH12xb = CS_FillPathGradY(SHH12x,1,60,"GRADX",3,0,0,1)
SHH12xc = CS_FillPathGradY(SHH12x,1,35,"GRADX",3,0,0,1)
SHH12xd = CS_FillPathGradY(SHH12x,1,55,"GRADX",3,0,0,1)
SHH12xe = CS_FillPathGradY(SHH12x,1,30,"GRADX",3,0,0,1)
SHH12xf = CS_FillPathGradY(SHH12x,1,50,"GRADX",3,0,0,1)

SHH12y = CSMakePath({322,-85},{383,-311},{84,-259},{0,0})
SHH12ya = CS_FillPathGradY(SHH12y,1,40,"GRADX",3,0,0,1)
SHH12yb = CS_FillPathGradY(SHH12y,1,60,"GRADX",3,0,0,1)
SHH12yc = CS_FillPathGradY(SHH12y,1,35,"GRADX",3,0,0,1)
SHH12yd = CS_FillPathGradY(SHH12y,1,55,"GRADX",3,0,0,1)
SHH12ye = CS_FillPathGradY(SHH12y,1,30,"GRADX",3,0,0,1)
SHH12yf = CS_FillPathGradY(SHH12y,1,50,"GRADX",3,0,0,1)

SHH12a = CS_Overlap(SHH12xa,SHH12ya) -- N_XUnit (48)
SHH12b = CS_Overlap(SHH12xb,SHH12yb) -- N_Hero (24)
SHH12c = CS_Overlap(SHH12xc,SHH12yc) -- H_XUnit (64)
SHH12d = CS_Overlap(SHH12xd,SHH12yd) -- H_Hero (27)
SHH12e = CS_Overlap(SHH12xe,SHH12ye) -- L_XUnit (79)
SHH12f = CS_Overlap(SHH12xf,SHH12yf) -- L_Hero (34)
GCenter = {1024,3728}
HShapeA = SHH12c
HShapeB = SHH12d
LShapeA = SHH12e
LShapeB = SHH12f

-- Preset --

CA_GunPreset(P8,133,"Switch 55",25,"H12",SHH12a,SHH12b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H12")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H12func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H12",GunPlayer,56,70,81,10,56,12,64,64,70,27,64,30,10)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H12Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,12,64,64,70,27,64,30)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H13  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH13x = CSMakePath({-200,-85},{-200,-282},{161,-88},{0,0})
SHH13xa = CS_FillPathGradY(SHH13x,1,55,"GRADX",3,0,0,1)
SHH13xb = CS_FillPathGradY(SHH13x,1,80,"GRADX",3,0,0,1)
SHH13xc = CS_FillPathGradY(SHH13x,1,50,"GRADX",3,0,0,1)
SHH13xd = CS_FillPathGradY(SHH13x,1,75,"GRADX",3,0,0,1)
SHH13xe = CS_FillPathGradY(SHH13x,1,45,"GRADX",3,0,0,1)
SHH13xf = CS_FillPathGradY(SHH13x,1,70,"GRADX",3,0,0,1)


SHH13y = CSMakePath({-200,153},{-200,428},{218,284},{0,0})
SHH13ya = CS_FillPathGradY(SHH13x,1,55,"GRADX",3,0,0,1)
SHH13yb = CS_FillPathGradY(SHH13x,1,80,"GRADX",3,0,0,1)
SHH13yc = CS_FillPathGradY(SHH13x,1,50,"GRADX",3,0,0,1)
SHH13yd = CS_FillPathGradY(SHH13x,1,75,"GRADX",3,0,0,1)
SHH13ye = CS_FillPathGradY(SHH13y,1,45,"GRADX",3,0,0,1)
SHH13yf = CS_FillPathGradY(SHH13y,1,70,"GRADX",3,0,0,1)

SHH13a = CS_Overlap(SHH13xa,SHH13ya) -- N_XUnit (30)
SHH13b = CS_Overlap(SHH13xb,SHH13yb) -- N_Hero (16)
SHH13c = CS_Overlap(SHH13xc,SHH13yc) -- H_XUnit (34)
SHH13d = CS_Overlap(SHH13xd,SHH13yd) -- H_Hero (18)
SHH13e = CS_Overlap(SHH13xe,SHH13ye) -- L_XUnit (56)
SHH13f = CS_Overlap(SHH13xf,SHH13yf) -- L_Hero (30)
GCenter = {224,3216}
HShapeA = SHH13c
HShapeB = SHH13d
LShapeA = SHH13e
LShapeB = SHH13f

-- Preset --

CA_GunPreset(P6,133,"Switch 56",26,"H13",SHH13a,SHH13b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H13")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H13func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H13",GunPlayer,56,80,3,3,80,80,93,93,80,86,93,65,11)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H13Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,80,80,93,93,80,86,93,65)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H14  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH14 = CSMakePath({0,0},{-164,180},{-406,54},{-409,-121},{-608,-239},{-613,-305},{-346,-442},{-76,-306},{-86,-238},{-238,-132})
SHH14a = CS_FillPathGradX(SHH14,1,60,"GRADX",3,0,0,1) -- N_XUnit (35)
SHH14b = CS_FillPathGradX(SHH14,1,80,"GRADX",3,0,0,1) -- N_Hero (21)
SHH14c = CS_FillPathGradX(SHH14,1,55,"GRADX",3,0,0,1) -- H_XUnit (43)
SHH14d = CS_FillPathGradX(SHH14,1,70,"GRADX",3,0,0,1) -- H_Hero (27)
SHH14e = CS_FillPathGradX(SHH14,1,45,"GRADX",3,0,0,1) -- L_XUnit (59)
SHH14f = CS_FillPathGradX(SHH14,1,65,"GRADX",3,0,0,1) -- L_Hero (30)

GCenter = {1824,3216}
HShapeA = SHH14c
HShapeB = SHH14d
LShapeA = SHH14e
LShapeB = SHH14f
-- Preset --

CA_GunPreset(P7,133,"Switch 57",27,"H14",SHH14a,SHH14b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H14")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,8);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,8);
	SetNVar(BGMVar[2],SetTo,8);
	SetNVar(BGMVar[3],SetTo,8);
	SetNVar(BGMVar[4],SetTo,8);
	SetNVar(BGMVar[5],SetTo,8);	
	SetScore(Force1,Add,30000,Kills);
})
	function H14func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H14",GunPlayer,56,21,5,5,21,21,52,52,21,58,52,2,11)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H14Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,21,21,52,52,21,58,52,2)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L13  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL13 = CSMakePath({-260,-377},{521,-258},{148,-94},{76,214},{-260,25})
SHL13a = CS_FillPathGradX(SHL13,1,55,"GRADX",3,0,0,1) -- N_XUnit (47)
SHL13b = CS_FillPathGradX(SHL13,1,80,"GRADX",3,0,0,1) -- N_Hero (23)
SHL13c = CS_FillPathGradX(SHL13,1,50,"GRADX",3,0,0,1) -- H_XUnit (53)
SHL13d = CS_FillPathGradX(SHL13,1,70,"GRADX",3,0,0,1) -- H_Hero (31)
SHL13e = CS_FillPathGradX(SHL13,1,45,"GRADX",3,0,0,1) -- L_XUnit (67)
SHL13f = CS_FillPathGradX(SHL13,1,65,"GRADX",3,0,0,1) -- L_Hero (33)

GCenter = {288,2160}
HShapeA = SHL13c
HShapeB = SHL13d
LShapeA = SHL13e
LShapeB = SHL13f
-- Preset --

CA_GunPreset(P6,132,"Switch 58",28,"L13",SHL13a,SHL13b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L13")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,10);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,10);
	SetNVar(BGMVar[2],SetTo,10);
	SetNVar(BGMVar[3],SetTo,10);
	SetNVar(BGMVar[4],SetTo,10);
	SetNVar(BGMVar[5],SetTo,10);	
	SetScore(Force1,Add,20000,Kills);
})
	function L13func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L13",GunPlayer,56,86,25,25,56,98,65,65,70,98,65,66,12)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L13Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,98,65,65,70,98,65,66)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L14  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL14 = CSMakePath({-246,61},{-460,-217},{-81,-445},{61,-229},{373,-37})
SHL14a = CS_FillPathGradX(SHL14,1,65,"GRADX",3,0,0,1) -- N_XUnit (45)
SHL14b = CS_FillPathGradX(SHL14,1,90,"GRADX",3,0,0,1) -- N_Hero (27)
SHL14c = CS_FillPathGradX(SHL14,1,55,"GRADX",3,0,0,1) -- H_XUnit (62)
SHL14d = CS_FillPathGradX(SHL14,1,80,"GRADX",3,0,0,1) -- H_Hero (32)
SHL14e = CS_FillPathGradX(SHL14,1,50,"GRADX",3,0,0,1) -- L_XUnit (69)
SHL14f = CS_FillPathGradX(SHL14,1,70,"GRADX",3,0,0,1) -- L_Hero (41)

GCenter = {448,1904}
HShapeA = SHL14c
HShapeB = SHL14d
LShapeA = SHL14e
LShapeB = SHL14f

-- Preset --

CA_GunPreset(P6,132,"Switch 59",29,"L14",SHL14a,SHL14b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L14")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,10);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,10);
	SetNVar(BGMVar[2],SetTo,10);
	SetNVar(BGMVar[3],SetTo,10);
	SetNVar(BGMVar[4],SetTo,10);
	SetNVar(BGMVar[5],SetTo,10);	
	SetScore(Force1,Add,20000,Kills);
})
	function L14func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L14",GunPlayer,56,86,64,64,70,98,66,66,80,98,66,66,12)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L14Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,70,98,66,66,80,98,66,66)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H15  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH15x = CSMakePath({0,-191},{-240,-179},{-240,17},{363,-15})
SHH15xa = CS_FillPathGradX(SHH15x,1,60,"GRADX",3,0,0,1)
SHH15xb = CS_FillPathGradX(SHH15x,1,80,"GRADX",3,0,0,1)
SHH15xc = CS_FillPathGradX(SHH15x,1,50,"GRADX",3,0,0,1)
SHH15xd = CS_FillPathGradX(SHH15x,1,70,"GRADX",3,0,0,1)
SHH15xe = CS_FillPathGradX(SHH15x,1,45,"GRADX",3,0,0,1)
SHH15xf = CS_FillPathGradX(SHH15x,1,65,"GRADX",3,0,0,1)

SHH15y = CSMakePath({0,0},{563,283},{211,443})
SHH15ya = CS_FillPathGradY(SHH15y,1,60,"GRADX",3,0,0,1)
SHH15yb = CS_FillPathGradY(SHH15y,1,75,"GRADX",3,0,0,1)
SHH15yc = CS_FillPathGradY(SHH15y,1,50,"GRADX",3,0,0,1)
SHH15yd = CS_FillPathGradY(SHH15y,1,65,"GRADX",3,0,0,1)
SHH15ye = CS_FillPathGradY(SHH15y,1,45,"GRADX",3,0,0,1)
SHH15yf = CS_FillPathGradY(SHH15y,1,60,"GRADX",3,0,0,1)

SHH15a = CS_Overlap(SHH15xa,SHH15ya) -- N_XUnit (51)
SHH15b = CS_Overlap(SHH15xb,SHH15yb) -- N_Hero (30)
SHH15c = CS_Overlap(SHH15xc,SHH15yc) -- H_XUnit (67)
SHH15d = CS_Overlap(SHH15xd,SHH15yd) -- H_Hero (39)
SHH15e = CS_Overlap(SHH15xe,SHH15ye) -- L_XUnit (82)
SHH15f = CS_Overlap(SHH15xf,SHH15yf) -- L_Hero (46)

GCenter = {256,1648}
HShapeA = SHH15c
HShapeB = SHH15d
LShapeA = SHH15e
LShapeB = SHH15f

-- Preset --

CA_GunPreset(P6,133,"Switch 60",30,"H15",SHH15a,SHH15b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H15")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H15func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H15",GunPlayer,56,98,93,93,80,98,65,66,86,98,66,87,13)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H15Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,80,98,65,66,86,98,66,87)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L15  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL15x = CSMakePath({0,0},{28,469},{282,474})
SHL15xa = CS_FillPathGradX(SHL15x,1,65,"GRADX",3,0,0,1)
SHL15xb = CS_FillPathGradX(SHL15x,1,80,"GRADX",3,0,0,1)
SHL15xc = CS_FillPathGradX(SHL15x,1,55,"GRADX",3,0,0,1)
SHL15xd = CS_FillPathGradX(SHL15x,1,70,"GRADX",3,0,0,1)
SHL15xe = CS_FillPathGradX(SHL15x,1,50,"GRADX",3,0,0,1)
SHL15xf = CS_FillPathGradX(SHL15x,1,60,"GRADX",3,0,0,1)

SHL15y = CSMakePath({0,0},{-605,-304},{-253,-483})
SHL15ya = CS_FillPathGradX(SHL15y,1,65,"GRADX",3,0,0,1)
SHL15yb = CS_FillPathGradX(SHL15y,1,80,"GRADX",3,0,0,1)
SHL15yc = CS_FillPathGradX(SHL15y,1,55,"GRADX",3,0,0,1)
SHL15yd = CS_FillPathGradX(SHL15y,1,70,"GRADX",3,0,0,1)
SHL15ye = CS_FillPathGradX(SHL15y,1,50,"GRADX",3,0,0,1)
SHL15yf = CS_FillPathGradX(SHL15y,1,60,"GRADX",3,0,0,1)

SHL15a = CS_Overlap(SHL15xa,SHL15ya) -- N_XUnit (28)
SHL15b = CS_Overlap(SHL15xb,SHL15yb) -- N_Hero (20)
SHL15c = CS_Overlap(SHL15xc,SHL15yc) -- H_XUnit (38)
SHL15d = CS_Overlap(SHL15xd,SHL15yd) -- H_Hero (27)
SHL15e = CS_Overlap(SHL15xe,SHL15ye) -- L_XUnit (44)
SHL15f = CS_Overlap(SHL15xf,SHL15yf) -- L_Hero (32)

GCenter = {1760,2160} 
HShapeA = SHL15c
HShapeB = SHL15d
LShapeA = SHL15e
LShapeB = SHL15f

-- Preset --

CA_GunPreset(P7,132,"Switch 61",31,"L15",SHL15a,SHL15b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L15")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,10);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,10);
	SetNVar(BGMVar[2],SetTo,10);
	SetNVar(BGMVar[3],SetTo,10);
	SetNVar(BGMVar[4],SetTo,10);
	SetNVar(BGMVar[5],SetTo,10);	
	SetScore(Force1,Add,20000,Kills);
})
	function L15func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L15",GunPlayer,56,58,25,25,56,98,2,2,70,98,2,16,12)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L15Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,98,2,2,70,98,2,16)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  L16  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHL16x = CSMakePath({0,0},{-153,-410},{313,-303})
SHL16xa = CS_FillPathGradX(SHL16x,1,55,"GRADX",3,0,0,1)
SHL16xb = CS_FillPathGradX(SHL16x,1,70,"GRADX",3,0,0,1)
SHL16xc = CS_FillPathGradX(SHL16x,1,50,"GRADX",3,0,0,1)
SHL16xd = CS_FillPathGradX(SHL16x,1,65,"GRADX",3,0,0,1)
SHL16xe = CS_FillPathGradX(SHL16x,1,45,"GRADX",3,0,0,1)
SHL16xf = CS_FillPathGradX(SHL16x,1,55,"GRADX",3,0,0,1)

SHL16y = CSMakePath({0,0},{309,123},{69,485})
SHL16ya = CS_FillPathGradX(SHL16y,1,55,"GRADX",3,0,0,1)
SHL16yb = CS_FillPathGradX(SHL16y,1,70,"GRADX",3,0,0,1)
SHL16yc = CS_FillPathGradX(SHL16y,1,45,"GRADX",3,0,0,1)
SHL16yd = CS_FillPathGradX(SHL16y,1,60,"GRADX",3,0,0,1)
SHL16ye = CS_FillPathGradX(SHL16y,1,40,"GRADX",3,0,0,1)
SHL16yf = CS_FillPathGradX(SHL16y,1,50,"GRADX",3,0,0,1)

SHL16a = CS_Overlap(SHL16xa,SHL16ya) -- N_XUnit (29)
SHL16b = CS_Overlap(SHL16xb,SHL16yb) -- N_Hero (19)
SHL16c = CS_Overlap(SHL16xc,SHL16yc) -- H_XUnit (39)
SHL16d = CS_Overlap(SHL16xd,SHL16yd) -- H_Hero (26)
SHL16e = CS_Overlap(SHL16xe,SHL16ye) -- L_XUnit (45)
SHL16f = CS_Overlap(SHL16xf,SHL16yf) -- L_Hero (31)

GCenter = {1600,1904}
HShapeA = SHL16c
HShapeB = SHL16d
LShapeA = SHL16e
LShapeB = SHL16f

-- Preset --

CA_GunPreset(P7,132,"Switch 62",32,"L16",SHL16a,SHL16b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"L16")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText1,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,10);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,10);
	SetNVar(BGMVar[2],SetTo,10);
	SetNVar(BGMVar[3],SetTo,10);
	SetNVar(BGMVar[4],SetTo,10);
	SetNVar(BGMVar[5],SetTo,10);	
	SetScore(Force1,Add,20000,Kills);
})
	function L16func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("L16",GunPlayer,56,58,64,64,56,98,2,16,70,98,16,16,12)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"L16Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,56,98,2,16,70,98,16,16)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H16  >---------------------------------------------
-- Shape --
function GRADX(X) return X end
SHH16x = CSMakePath({0,0},{-335,-42},{-635,-197},{-407,-307},{-106,-147})
SHH16xa = CS_FillPathGradX(SHH16x,1,60,"GRADX",3,0,0,1)
SHH16xb = CS_FillPathGradX(SHH16x,1,85,"GRADX",3,0,0,1)
SHH16xc = CS_FillPathGradX(SHH16x,1,55,"GRADX",3,0,0,1)
SHH16xd = CS_FillPathGradX(SHH16x,1,80,"GRADX",3,0,0,1)
SHH16xe = CS_FillPathGradX(SHH16x,1,50,"GRADX",3,0,0,1)
SHH16xf = CS_FillPathGradX(SHH16x,1,75,"GRADX",3,0,0,1)

SHH16y = CSMakePath({0,0},{0,286},{-282,286})
SHH16ya = CS_FillPathGradX(SHH16y,1,60,"GRADX",3,0,0,1)
SHH16yb = CS_FillPathGradX(SHH16y,1,85,"GRADX",3,0,0,1)
SHH16yc = CS_FillPathGradX(SHH16y,1,55,"GRADX",3,0,0,1)
SHH16yd = CS_FillPathGradX(SHH16y,1,80,"GRADX",3,0,0,1)
SHH16ye = CS_FillPathGradX(SHH16y,1,50,"GRADX",3,0,0,1)
SHH16yf = CS_FillPathGradX(SHH16y,1,75,"GRADX",3,0,0,1)

SHH16a = CS_Overlap(SHH16xa,SHH16ya) -- N_XUnit (48)
SHH16b = CS_Overlap(SHH16xb,SHH16yb) -- N_Hero (29)
SHH16c = CS_Overlap(SHH16xc,SHH16yc) -- H_XUnit (60)
SHH16d = CS_Overlap(SHH16xd,SHH16yd) -- H_Hero (30)
SHH16e = CS_Overlap(SHH16xe,SHH16ye) -- L_XUnit (66)
SHH16f = CS_Overlap(SHH16xf,SHH16yf) -- L_Hero (34)

GCenter = {1792,1648}
HShapeA = SHH16c
HShapeB = SHH16d
LShapeA = SHH16e
LShapeB = SHH16f
-- Preset --

CA_GunPreset(P7,133,"Switch 63",33,"H16",SHH16a,SHH16b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H16")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H16func()
	local CB = CAPlotCreateArr
		CIf(FP,CDeaths("X",Exactly,1,AirType))
			CIfX(FP,{CVar("X",GMode,Exactly,2)})
					CA_MoveXY(-200,-200)
					CA_Rotate(V(TAngle1))
				CElseX()
					CA_MoveXY(0,-200)
					CA_Rotate(V(TAngle2)) -- Lunatic Angle
			CIfXEnd()
		CIfEnd()
	end
	SetGunSystem("H16",GunPlayer,56,98,52,52,21,98,2,16,58,98,16,87,13)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H16Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,21,98,2,16,58,98,16,87)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H17  >---------------------------------------------
-- Shape --
function HCenter_Ufunc(X) return X^2/1024-64 end
function HCenter_Dfunc(X) return -X^2/1024+256 end
function HCenter_Lfunc(Y) return -Y^2/256-64 end
function HCenter_Rfunc(Y) return Y^2/256+64 end

SHH17 = CSMakePolygonX(3,60,180,CS_Level("PolygonX",3,5),0)
SHH17a = CS_DistortionX(CSMakePolygonX(3,60,180,CS_Level("PolygonX",3,4),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)
SHH17b = CS_DistortionX(CSMakePolygonX(3,60,180,CS_Level("PolygonX",3,3),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)--SHH17d = CS_DistortionX(CSMakePolygonX(4,60,180,CS_Level("PolygonX",4,5),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)
SHH17c = CS_DistortionX(CSMakePolygonX(4,60,180,CS_Level("PolygonX",4,4),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)
SHH17d = CS_DistortionX(CSMakePolygonX(4,60,180,CS_Level("PolygonX",4,3),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)
SHH17e = CS_DistortionX(CSMakePolygonX(3,60,180,CS_Level("PolygonX",3,5),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)
SHH17f = CS_DistortionX(CSMakePolygonX(3,60,180,CS_Level("PolygonX",3,4),0),{0.5,0.5},{3,4},{0.5,0.5},{3,4},nil,{"HCenter_Ufunc"},{"HCenter_Dfunc"},nil,nil)

GCenter = {1025,958} -- H17 ~ H20
HShapeA = SHH17c
HShapeB = SHH17d
LShapeA = SHH17e
LShapeB = SHH17f
-- Preset --

CA_GunPreset(P8,133,"Switch 64",34,"H17",SHH17a,SHH17b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H17")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H17func()
	local CB = CAPlotCreateArr

	end
	SetGunSystem("H17",GunPlayer,56,56,77,65,80,12,81,25,86,12,64,3,14)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H17Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,80,12,81,25,86,12,64,3)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H18  >---------------------------------------------
-- Shape --
GCenter = {1025,958} -- H17 ~ H20
HShapeA = SHH17c
HShapeB = SHH17d
LShapeA = SHH17e
LShapeB = SHH17f
-- Preset --

CA_GunPreset(P6,133,"Switch 65",35,"H18",SHH17a,SHH17b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H18")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H18func()
		local CB = CAPlotCreateArr

	end
	SetGunSystem("H18",GunPlayer,56,56,78,65,80,86,81,65,86,98,64,93,15)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H18Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,80,86,81,65,86,93,64,93)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H19  >---------------------------------------------
-- Shape --
GCenter = {1025,958} -- H17 ~ H20
HShapeA = SHH17c
HShapeB = SHH17d
LShapeA = SHH17e
LShapeB = SHH17f
-- Preset --

CA_GunPreset(P7,133,"Switch 66",36,"H19",SHH17a,SHH17b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H19")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H19func()
		local CB = CAPlotCreateArr

end
	SetGunSystem("H19",GunPlayer,56,56,78,66,21,58,10,3,58,27,3,52,15)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H19Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,21,58,10,3,58,27,3,52)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

------<  H20  >---------------------------------------------
-- Shape --
GCenter = {1025,958} -- H17 ~ H20
HShapeA = SHH17c
HShapeB = SHH17d
LShapeA = SHH17e
LShapeB = SHH17f
-- Preset --
CA_GunPreset(P8,133,"Switch 67",37,"H20",SHH17a,SHH17b)
--< Normal >----------------------------------------------

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"H20")})
SetVFlags()
TriggerX(FP,{CDeaths(FP,Exactly,0,Stage)},{
	CopyCpAction({DisplayTextX(DText2,4)},{Force1,Force5},FP);
	SetNVar(OB_BGMVar,SetTo,11);
	SetNVar(BuildTimeVar,Add,1);
	SetNVar(BGMVar[1],SetTo,11);
	SetNVar(BGMVar[2],SetTo,11);
	SetNVar(BGMVar[3],SetTo,11);
	SetNVar(BGMVar[4],SetTo,11);
	SetNVar(BGMVar[5],SetTo,11);	
	SetScore(Force1,Add,30000,Kills);
})
	function H20func()
		local CB = CAPlotCreateArr

	end
	SetGunSystem("H20",GunPlayer,56,56,65,66,69,69,79,75,30,30,76,74,16)
	CMov(FP,Common_UType,V(UType)) --> 건작단락에서 유닛변수값을 공통유닛변수에 저장
	CIf(FP,CVar("X",GMode,AtLeast,2))
		CAPlot({HShapeA,HShapeB,LShapeA,LShapeB},P6,191,"CLoc106",GCenter,1,32,{V(SType),0,0,0,600,V(NextDot)},"H20Func",FP
				,nil,{SetNext("X",0x5000),SetNext(0x5001,"X",1)},nil)
		SetOrder(GunPlayer,69,69,79,75,30,30,76,74)
	CIfEnd()
	DoActionsX(FP,SetCDeaths("X",Subtract,1,Timer))
CIfEnd()

----< 특수 건작 >--------------------------------------------
GU1, GU2, GU3, GU4, HU1, HU2, HU3, HU4 = CreateVars(8,FP) -- GunUnitVars
UV = CreateVarArr(18,FP)
C_Shape, C_Rand, C_Air, C_Ground, C_LocID = CreateVars(5,FP)
DoActions(FP,{
		RemoveUnit(205,P8);
		RemoveUnit(204,P8);
		RemoveUnit(203,P8);
		RemoveUnit(205,P5);
		RemoveUnit(204,P5);
		RemoveUnit(203,P5);
})

SText1 = "\x13\x1F─━┫ \x10C\x04erebrate 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
SText2 = "\x13\x1F─━┫ \x10C\x04oCoon 를 파괴했습니다. \x19+125,000\x04ⓟⓣⓢ  \x1F┣━─"
SText3 = "\x13\x1F─━┫ \x10D\x04aggoth 를 파괴했습니다. \x19+150,000\x04ⓟⓣⓢ  \x1F┣━─"
SText4 = "\x13\x1F─━┫ \x10O\x04verMind 를 파괴했습니다. \x19+300,000\x04ⓟⓣⓢ  \x1F┣━─"
SText5 = "\x13\x1F─━┫ \x10C\x04enter 를 파괴했습니다. \x19+150,000\x04ⓟⓣⓢ  \x1F┣━─"
SText6 = "\x13\x1F─━┫ \x10X\x04el'Naga Temple 를 파괴했습니다. \x19+200,000\x04ⓟⓣⓢ  \x1F┣━─"
SText7 = "\x13\x1F─━┫ \x10S\x04targate 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
SText8 = "\x13\x1F─━┫ \x10S\x04tarport 를 파괴했습니다. \x19+100,000\x04ⓟⓣⓢ  \x1F┣━─"
SText9 = "\x13\x1F─━┫ \x10C\x04heckmate 를 파괴했습니다. \x19+200,000\x04ⓟⓣⓢ  \x1F┣━─"
SText10 = "\x13\x1F─━┫ \x10E\x04vent \x10H\x04orizon 을 파괴했습니다. \x19+300,000\x04ⓟⓣⓢ  \x1F┣━─"
SText11 = "\x13\x1F─━┫ \x10T\x04emple 을 파괴했습니다. \x19+250,000\x04ⓟⓣⓢ  \x1F┣━─"
-- Case Cerebrate
function SetCerebrateGun(Player,Location,ShapeA,ShapeB,ShapeC,ShapeD,ShapeE,ShapeF,ShapeG)
	NShape = ShapeA
	HShape = ShapeB
	LShape = ShapeC
	SideShapeA = ShapeD
	SideShapeB = ShapeE
	SideShapeC = ShapeF
	SideShapeD = ShapeG
	
		DoActionsX(FP,{
			SetCVar("X",NextDot,SetTo,600);
			SetNVar(UPlayer,SetTo,Player);
			SetNVar(C_LocID,SetTo,ParseLocation(Location))
		})
			TriggerX(FP,{
					CDeaths("X",Exactly,0,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					SetCDeaths("X",SetTo,1,Stage);
					SetCDeaths("X",SetTo,1,Timer);
			})
			CTrigger(FP,{
					CDeaths("X",Exactly,1,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					SetCVar("X",NextDot,SetTo,1);
					SetNVar(Common_UType,SetTo,192);
					SetCDeaths("X",SetTo,2,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,2,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[1]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,3,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,3,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[2]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,4,Stage);
					SetCDeaths("X",SetTo,12*30,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{ -- SideUnit Set
					CDeaths("X",Exactly,4,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,_Add(_Mod(_Rand(),2),4)); -- Shape #5 or #6
					TSetNVar(Common_XUType,SetTo,C_Air);
					SetNVar(Common_UType,SetTo,194);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,5,Stage);
					SetCDeaths("X",SetTo,1,Timer);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,5,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					SetCVar("X",NextDot,SetTo,1);
					SetNVar(Common_UType,SetTo,192);
					SetCDeaths("X",SetTo,6,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,6,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[3]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,7,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,7,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[4]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,8,Stage);
					SetCDeaths("X",SetTo,12*30,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{ -- SideUnit Set
					CDeaths("X",Exactly,8,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,_Add(_Mod(_Rand(),2),6)); -- Shape #6 or #7
					TSetNVar(Common_XUType,SetTo,C_Ground);
					SetNVar(Common_UType,SetTo,194);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,9,Stage);
					SetCDeaths("X",SetTo,1,Timer);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,9,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					SetCVar("X",NextDot,SetTo,1);
					SetNVar(Common_UType,SetTo,192);
					SetCDeaths("X",SetTo,10,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,10,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[5]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,11,Stage);
					SetCDeaths("X",SetTo,1,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			CTrigger(FP,{
					CDeaths("X",Exactly,11,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					TSetCVar("X",SType,SetTo,C_Shape);
					TSetNVar(Common_XUType,SetTo,UV[6]);
					SetNVar(Common_UType,SetTo,193);
					SetCVar("X",NextDot,SetTo,1);
					SetCDeaths("X",SetTo,12,Stage);
					SetCDeaths("X",SetTo,12*30,Timer);
					SetCDeathsX("X",SetTo,1,OrderG,0xFF);
				})
			TriggerX(FP,{
					CDeaths("X",Exactly,12,Stage);
					CDeaths("X",Exactly,0,Timer);
				},{
					SetCDeaths("X",SetTo,13,Stage);
					SetSwitch(GLock,Set);
				})
	CAPlot({NShape,HShape,LShape,SideShapeA,SideShapeB,SideShapeC,SideShapeD},P6,191,"CLoc106",GCenter,1,32,
		{V(SType),0,0,0,600,V(NextDot)},nil,FP,nil,{SetNext("X",0x5002),SetNext(0x5003,"X",1)})
			
				CIf(FP,{CDeathsX("X",Exactly,1,OrderG,0xFF)})
					SetLocCenter(GLoc,"CLoc76");
					DoActionsX(FP,{Simple_CalcLoc("CLoc76",-768,-768,768,768)})
					CDoActions(FP,{
						TOrder(Common_UType,UPlayer,"CLoc76",Attack,"HZ");
						TOrder(Common_XUType,UPlayer,"CLoc76",Attack,"HZ");
						TOrder("Factories",UPlayer,"CLoc76",Attack,"HZ");
						SetCDeathsX("X",Subtract,1,OrderG,0xFF);
					})
				CIfEnd()
	DoActionsX(FP,{SetCDeaths("X",Subtract,1,Timer)})
end

CJump(FP,4)
SetLabel(0x5002)

CIf(FP,{NVar(Common_UType,Exactly,192,0xFFFF)})
	TriggerX(FP,{NVar(Common_UType,Exactly,0*65536,0xFF0000),NVar(Common_UType,Exactly,0*16777216,0xFF000000)},{
		SetNVar(Common_XUType,SetTo,53,0xFFFF);
		SetNVar(Common_UType,SetTo,1*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000)},{Preserved})
	TriggerX(FP,{NVar(Common_UType,Exactly,1*65536,0xFF0000),NVar(Common_UType,Exactly,0*16777216,0xFF000000)},{
		SetNVar(Common_XUType,SetTo,54,0xFFFF);
		SetNVar(Common_UType,SetTo,2*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000)},{Preserved})
	TriggerX(FP,{NVar(Common_UType,Exactly,2*65536,0xFF0000),NVar(Common_UType,Exactly,0*16777216,0xFF000000)},{
		SetNVar(Common_XUType,SetTo,104,0xFFFF);
		SetNVar(Common_UType,SetTo,3*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000)},{Preserved})
	TriggerX(FP,{NVar(Common_UType,Exactly,3*65536,0xFF0000),NVar(Common_UType,Exactly,0*16777216,0xFF000000)},{
		SetNVar(Common_XUType,SetTo,48,0xFFFF);
		SetNVar(Common_UType,SetTo,4*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000)},{Preserved})
	TriggerX(FP,{NVar(Common_UType,Exactly,4*65536,0xFF0000),NVar(Common_UType,Exactly,0*16777216,0xFF000000)},{
		SetNVar(Common_XUType,SetTo,51,0xFFFF);
		SetNVar(Common_UType,SetTo,0*65536,0xFF0000);
		SetNVar(Common_UType,SetTo,1*16777216,0xFF000000)},{Preserved})
CIfEnd()

CIf(FP,Memory(0x628438,AtLeast,1))
	CIfX(FP,{CVar("X",GMode,Exactly,1)})
		CDoActions(FP,{TCreateUnit(1,Common_XUType,"CLoc106",UPlayer),TOrder(Common_XUType,UPlayer,"CLoc106",Attack,C_LocID);})
	CElseX()
		CIfX(FP,{NVar(Common_UType,Exactly,194,0xFFFF)})
			TriggerX(FP,{NVar(Common_XUType,Exactly,25)},{SetMemoryB(0x663150+25,SetTo,12),SetMemoryX(0x664080+25*4,SetTo,0x4,0x4)},{Preserved})
			SetNextptr()
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
					TCreateUnit(1,Common_XUType,"CLoc106",P8);
					TSetMemory(Vi(Nextptr[2],13),SetTo,255);
					TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
					TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
					TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000); -- 개별건작 타이머
					TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
					TOrder(Common_XUType,P8,"CLoc106",Attack,C_LocID);
					CreateUnit(1,84,"CLoc106",P5);
			},{Preserved})
			TriggerX(FP,{NVar(Common_XUType,Exactly,25)},{SetMemoryB(0x663150+25,SetTo,4),SetMemoryX(0x664080+25*4,SetTo,0x0,0x4)},{Preserved})
		CElseIfX({NVar(Common_UType,AtLeast,192,0xFFFF),NVar(Common_UType,AtMost,193,0xFFFF)})
			CDoActions(FP,{TCreateUnit(1,Common_XUType,"CLoc106",UPlayer),TOrder(Common_XUType,UPlayer,"CLoc106",Attack,C_LocID);})
		CIfXEnd()
	CIfXEnd()
CIfEnd()
DoActionsX(FP,{SetNVar(Common_UType,Subtract,1*16777216,0xFF000000)})

SetLabel(0x5003)
CJumpEnd(FP,4)

------<  C1  >-----------------------------------------------
-- Shape --
SHC1a1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(3,60,90,CS_Level("Polygon",3,5),1),60*math.sqrt(3)*0.5,0),1.3,1)
SHC1b1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(4,60,90,CS_Level("Polygon",4,5),1),60*math.sqrt(3)*0.75,0),1.1,0.8)
SHC1c1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(5,60,90,CS_Level("Polygon",5,5),1),60*math.sqrt(3)*0.75,0),1,0.7)
SHC1a = CS_Distortion(SHC1a1,{1,1.4},{1,0.6},nil,nil,nil) -- 30
SHC1b = CS_Distortion(SHC1b1,{1,1.4},{1,0.6},nil,nil,nil) -- 40
SHC1c = CS_Distortion(SHC1c1,{1,1.4},{1,0.6},nil,nil,nil) -- 50

SHC1LineA1 = CS_MoveXY(CSMakeLine(1,120,120,10,0),0,-128*6)
SHC1LineA2 = CS_MoveXY(CSMakeLine(1,120,50,11,1),0,128*7)
SHC1LineT1 = CS_MoveXY(CSMakeLine(1,80,110,11,0),0,-128*3.5)
SHC1LineT2 = CS_MoveXY(CSMakeLine(1,80,50,11,0),0,128*5)
GCenter = {80,6624}
CA_GunPreset(P6,151,"Switch 68",38,"C1")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})

SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{Force1,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,55);SetNVar(UV[2],SetTo,40);
	SetNVar(UV[3],SetTo,56);SetNVar(UV[4],SetTo,51);
	SetNVar(UV[5],SetTo,70);SetNVar(UV[6],SetTo,77);
	SetNVar(C_Air,SetTo,80);SetNVar(C_Ground,SetTo,21); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,77);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,78);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,79);
	SetNVar(C_Air,SetTo,98);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,77);
	SetNVar(UV[3],SetTo,80);SetNVar(UV[4],SetTo,78);
	SetNVar(UV[5],SetTo,21);SetNVar(UV[6],SetTo,75);
	SetNVar(C_Air,SetTo,60);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC1a,SHC1b,SHC1c,SHC1LineA1,SHC1LineA2,SHC1LineT1,SHC1LineT2)

CIfEnd()

------<  C2  >-----------------------------------------------
-- Shape --
SHC2a1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(3,60,270,CS_Level("Polygon",3,5),1),-60*math.sqrt(3)*0.5,0),1.3,1)
SHC2b1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(4,60,270,CS_Level("Polygon",4,5),1),-60*math.sqrt(3)*0.75,0),1.1,0.8)
SHC2c1 = CS_RatioXY(CS_MoveXY(CSMakePolygon(5,60,270,CS_Level("Polygon",5,5),1),-60*math.sqrt(3)*0.75,0),1,0.7)
SHC2a = CS_Distortion(SHC2a1,nil,nil,{1,1.4},{1,0.6},nil) -- 30
SHC2b = CS_Distortion(SHC2b1,nil,nil,{1,1.4},{1,0.6},nil) -- 40
SHC2c = CS_Distortion(SHC2c1,nil,nil,{1,1.4},{1,0.6},nil) -- 50

SHC2LineA1 = CS_MoveXY(CSMakeLine(1,120,-50,11,1),0,128*7)
SHC2LineA2 = CS_MoveXY(CSMakeLine(1,120,-120,10,0),0,-128*6)
SHC2LineT1 = CS_MoveXY(CSMakeLine(1,80,-50,11,0),0,128*5)
SHC2LineT2 = CS_MoveXY(CSMakeLine(1,80,-110,11,0),0,-128*3.5)
GCenter = {1968,6624}
CA_GunPreset(P7,151,"Switch 69",39,"C2")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})

SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{Force1,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,55);SetNVar(UV[2],SetTo,40);
	SetNVar(UV[3],SetTo,56);SetNVar(UV[4],SetTo,51);
	SetNVar(UV[5],SetTo,70);SetNVar(UV[6],SetTo,77);
	SetNVar(C_Air,SetTo,21);SetNVar(C_Ground,SetTo,80); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,77);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,78);
	SetNVar(UV[5],SetTo,21);SetNVar(UV[6],SetTo,19);
	SetNVar(C_Air,SetTo,58);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,77);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,78);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,17);
	SetNVar(C_Air,SetTo,28);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC2a,SHC2b,SHC2c,SHC2LineA1,SHC2LineA2,SHC2LineT1,SHC2LineT2)

CIfEnd()

------<  C3  >-----------------------------------------------
-- Shape --
SHCPA = CSMakePolygon(4,30,45,CS_Level("Polygon",4,3),1) -- XUnitShape
SHCPB = CSMakePolygon(4,30,45,CS_Level("Polygon",4,3),CS_Level("Polygon",4,2)) -- HUnitShape

SHCPathA = CS_RatioXY(CSMakePath({-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128) -- GUnitShape
SHCPathB = CS_OverlapX(CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128),CS_MoveXY(CSMakeLine(2,96,0,11,0),128*3,0))
SHCPathC = CS_OverlapX(CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5},{3,0.5}),128,128),CS_MoveXY(CSMakeLine(2,96,90,11,0),0,128*3))
SHCPathAX = CS_RatioXY(CSMakePath({-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128)
SHCPathBX = CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128)
SHCPathCX = CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5},{3,0.5}),128,128)

SHC3a = CS_ShapeInShape(SHCPA,SHCPathAX,0)
SHC3b = CS_ShapeInShape(SHCPA,SHCPathBX,0)
SHC3c = CS_ShapeInShape(SHCPA,SHCPathCX,0)

SHC3Ha = CS_ShapeInShape(SHCPB,SHCPathAX,0)
SHC3Hb = CS_ShapeInShape(SHCPB,SHCPathBX,0)
SHC3Hc = CS_ShapeInShape(SHCPB,SHCPathCX,0)

GCenter = {464,5760}
CA_GunPreset(P6,151,"Switch 70",40,"C3")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,55);SetNVar(UV[2],SetTo,51);
	SetNVar(UV[3],SetTo,56);SetNVar(UV[4],SetTo,77);
	SetNVar(UV[5],SetTo,70);SetNVar(UV[6],SetTo,78);
	SetNVar(C_Air,SetTo,12);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,79);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,75);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,76);
	SetNVar(C_Air,SetTo,61);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,79);
	SetNVar(UV[3],SetTo,80);SetNVar(UV[4],SetTo,75);
	SetNVar(UV[5],SetTo,12);SetNVar(UV[6],SetTo,74);
	SetNVar(C_Air,SetTo,99);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC3a,SHC3b,SHC3c,SHCPathC,SHCPathB,SHCPathC,SHCPathB)

CIfEnd()

------<  C4  >------------------------------------------
-- Shapes --
SHCPA = CSMakePolygon(4,30,45,CS_Level("Polygon",4,3),1) -- XUnitShape
SHCPB = CSMakePolygon(4,30,45,CS_Level("Polygon",4,3),CS_Level("Polygon",4,2)) -- HUnitShape

SHCPathA = CS_RatioXY(CSMakePath({-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128)
SHCPathB = CS_OverlapX(CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5},{3,0.5}),128,128),CS_MoveXY(CSMakeLine(2,96,0,11,0),-128*3,0))
SHCPathC = CS_OverlapX(CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5},{3,0.5}),128,128),CS_MoveXY(CSMakeLine(2,96,90,11,0),0,128*3))

SHCPathAX = CS_RatioXY(CSMakePath({-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128)
SHCPathBX = CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5}),128,128)
SHCPathCX = CS_RatioXY(CSMakePath({-3,0.5},{-2,-0.5},{-1,0.5},{0,-0.5},{1,0.5},{2,-0.5},{3,0.5}),128,128)

SHC4a = CS_ShapeInShape(SHCPA,SHCPathAX,0)
SHC4b = CS_ShapeInShape(SHCPA,SHCPathBX,0)
SHC4c = CS_ShapeInShape(SHCPA,SHCPathCX,0)

SHC4Ha = CS_ShapeInShape(SHCPB,SHCPathAX,0)
SHC4Hb = CS_ShapeInShape(SHCPB,SHCPathBX,0)
SHC4Hc = CS_ShapeInShape(SHCPB,SHCPathCX,0)

GCenter = {1583,5760}
CA_GunPreset(P7,151,"Switch 71",41,"C4")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,55);SetNVar(UV[2],SetTo,51);
	SetNVar(UV[3],SetTo,56);SetNVar(UV[4],SetTo,19);
	SetNVar(UV[5],SetTo,70);SetNVar(UV[6],SetTo,17);
	SetNVar(C_Air,SetTo,27);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,19);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,17);
	SetNVar(UV[5],SetTo,21);SetNVar(UV[6],SetTo,76);
	SetNVar(C_Air,SetTo,87);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,19);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,17);
	SetNVar(UV[5],SetTo,12);SetNVar(UV[6],SetTo,74);
	SetNVar(C_Air,SetTo,102);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC4a,SHC4b,SHC4c,SHCPathB,SHCPathC,SHCPathB,SHCPathC)

CIfEnd()

------<  C5  >------------------------------------------
-- Shapes --
SHC5a = CS_RatioXY(CS_MoveXY(CSMakePolygon(3,64,0,CS_Level("Polygon",3,5),0),0,128),1.4,0.8) -- 31
SHC5b = CS_RatioXY(CS_MoveXY(CSMakePolygon(4,64,0,CS_Level("Polygon",4,5),0),0,128),1.4,0.8) -- 41
SHC5c = CS_RatioXY(CS_MoveXY(CSMakePolygon(5,64,0,CS_Level("Polygon",5,5),0),0,128),1.4,0.8) -- 51

SubA0 = CSMakePolygon(3,64,45,CS_Level("Polygon",3,3),CS_Level("Polygon",3,2))
SubB0 = CSMakePolygon(4,64,45,CS_Level("Polygon",4,3),CS_Level("Polygon",4,2))
SubC0 = CSMakePolygon(5,64,45,CS_Level("Polygon",5,3),CS_Level("Polygon",5,2))
Sub5A = CS_OverlapX(CS_MoveXY(SubA0,448,-96),CS_MoveXY(SubA0,-448,-96),CS_MoveXY(SubA0,0,540))
Sub5B = CS_OverlapX(CS_MoveXY(SubB0,448,-96),CS_MoveXY(SubB0,-448,-96),CS_MoveXY(SubB0,0,540))
Sub5C = CS_OverlapX(CS_MoveXY(SubC0,448,-96),CS_MoveXY(SubC0,-448,-96),CS_MoveXY(SubC0,0,540))

GCenter = {1024,3472}
CA_GunPreset(P8,151,"Switch 72",42,"C5")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,79);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,19);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,76);
	SetNVar(C_Air,SetTo,86);SetNVar(C_Ground,SetTo,58); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,25);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,3);
	SetNVar(UV[5],SetTo,58);SetNVar(UV[6],SetTo,5);
	SetNVar(C_Air,SetTo,27);SetNVar(C_Ground,SetTo,25); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,3);
	SetNVar(UV[3],SetTo,88);SetNVar(UV[4],SetTo,81);
	SetNVar(UV[5],SetTo,8);SetNVar(UV[6],SetTo,10);
	SetNVar(C_Air,SetTo,28);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC5a,SHC5b,SHC5c,Sub5A,Sub5B,Sub5B,Sub5C)

CIfEnd()
------<  C6  >------------------------------------------
-- Shapes --
SHC6a = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),10),{512,0},{-256,0},{-64,0},nil),0,0,1),128,-64)
SHC6b = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),4),{512,0},{-256,0},{-64,0},nil),0,0,1),128,-64)
SHC6c = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),0),{512,0},{-256,0},{-64,0},nil),0,0,1),128,-64)

Sub6A = CS_OverlapX(CS_MoveXY(CSMakeCircleX(5,192,0,5,0),3*128,-3.5*128), CS_MoveXY(CSMakeCircleX(5,192,0,5,0),6*128,-64))
Sub6B = CS_OverlapX(CS_MoveXY(CSMakeCircleX(5,192,0,5,0),6*128,-64), CS_MoveXY(CSMakeCircleX(5,192,0,5,0),0,3.5*128))

GCenter = {265,1921}
CA_GunPreset(P6,151,"Switch 73",43,"C6")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,25);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,3);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,5);
	SetNVar(C_Air,SetTo,99);SetNVar(C_Ground,SetTo,99); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,32);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,93);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,65);
	SetNVar(C_Air,SetTo,69);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,32);
	SetNVar(UV[3],SetTo,88);SetNVar(UV[4],SetTo,93);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,66);
	SetNVar(C_Air,SetTo,13);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC6a,SHC6b,SHC6c,Sub6A,Sub6B,Sub6A,Sub6B)

CIfEnd()

------<  C7  >------------------------------------------
-- Shapes --
SHC7a = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),10),{-512,0},{256,0},{64,0},nil),0,0,1),-128,-64)
SHC7b = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),4),{-512,0},{256,0},{64,0},nil),0,0,1),-128,-64)
SHC7c = CS_MoveXY(CS_MirrorY(CS_Distortion2(CSMakePolygon(3,64,180,CS_Level("Polygon",3,6),0),{-512,0},{256,0},{64,0},nil),0,0,1),-128,-64)

Sub7A = CS_OverlapX(CS_MoveXY(CSMakeCircleX(5,192,0,5,0),-3*128,-3.5*128), CS_MoveXY(CSMakeCircleX(5,192,0,5,0),-6*128,-64))
Sub7B = CS_OverlapX(CS_MoveXY(CSMakeCircleX(5,192,0,5,0),-6*128,-64), CS_MoveXY(CSMakeCircleX(5,192,0,5,0),0,3.5*128))

GCenter = {1787,1916}
CA_GunPreset(P7,151,"Switch 74",44,"C7")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText1,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,9);
		SetNVar(BGMVar[1],SetTo,9);
		SetNVar(BGMVar[2],SetTo,9);
		SetNVar(BGMVar[3],SetTo,9);
		SetNVar(BGMVar[4],SetTo,9);
		SetNVar(BGMVar[5],SetTo,9);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(C_Shape,SetTo,1);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,25);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,10);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,81);
	SetNVar(C_Air,SetTo,99);SetNVar(C_Ground,SetTo,99); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(C_Shape,SetTo,2);
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,32);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,52);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,2);
	SetNVar(C_Air,SetTo,69);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(C_Shape,SetTo,3);
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,32);
	SetNVar(UV[3],SetTo,8);SetNVar(UV[4],SetTo,52);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,16);
	SetNVar(C_Air,SetTo,13);SetNVar(C_Ground,SetTo,30); -- GUnit Setting
},{Preserved})

SetCerebrateGun(GunPlayer,GLoc,SHC7a,SHC7b,SHC7c,Sub7A,Sub7B,Sub7A,Sub7B)

CIfEnd()

------<  StarGate / StarPort  >------------------------------------------
-- Vars & Shapes --

PreSaveCache, LockSW, SHLevel, ST_Stage = CreateCcodes(4)

ST_VNull, ST_VTimeLine, ST_AngleXY, ST_Ratio, ST_Shape, ST_AngleYZ, ST_AngleZX, ST_DataIndex, TempShape1, TempShape2,
TempRatio1, TempRatio2, Cur_DataIndex, ST_CreateSW, Temp_VTimeLine, ST_PosX, ST_PosY = CreateVars(17,FP)
EffectDot = CreateVarArr(4,FP)

ST1_A = CSMakeCircleX(16,512,0,16,0)
ST1_B = CSMakeCircleX(24,512,0,24,0)
ST1_C = CSMakeCircleX(32,512,0,32,0)

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(TempShape1,SetTo,3);SetNVar(TempShape2,SetTo,6);SetNVar(EffectDot[1],SetTo,7);SetNVar(EffectDot[2],SetTo,15)})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(TempShape1,SetTo,9);SetNVar(TempShape2,SetTo,12);
	SetNVar(EffectDot[1],SetTo,7);SetNVar(EffectDot[2],SetTo,15);SetNVar(EffectDot[3],SetTo,23)})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(TempShape1,SetTo,15),SetNVar(TempShape2,SetTo,18);
	SetNVar(EffectDot[1],SetTo,7);SetNVar(EffectDot[2],SetTo,15);SetNVar(EffectDot[3],SetTo,23);SetNVar(EffectDot[4],SetTo,31)
})

-- CAFunc --
function ST_CAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
        CMov(FP,Cur_DataIndex,V(CA[6]))
end

-- CBFunc --

ST_ShapeArr = {ST1_A,RetSH(ST1_A),RetSH(ST1_A),ST1_A,RetSH(ST1_A),RetSH(ST1_A),
			ST1_B,RetSH(ST1_B),RetSH(ST1_B),ST1_B,RetSH(ST1_B),RetSH(ST1_B),
			ST1_C,RetSH(ST1_C),RetSH(ST1_C),ST1_C,RetSH(ST1_C),RetSH(ST1_C)
		}

function ST_CBFunc()
	local CycleLength = 360

	CIfX(FP,{NVar(ST_Shape,Exactly,3)},{SetNVar(ST_AngleYZ,SetTo,60),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,1,SHLevel)})
		VptrInitA = CB_InitVShape(1) -- Init
		VptrRetA = CB_InitVShape(2) -- Init -> CB_Rotate
		VptrRetA2 = CB_InitVShape(3) -- CB_Rotate -> CB_Ratio
		SC1 = CB_InitCache(CycleLength,ST1_A[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_A[1]
		CB_LoadCache(SC1,ST_VTimeLine,VptrRetA2)
		CB_GetNumber(3,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio1) -- Temp비율 로드
	CElseIfX({NVar(ST_Shape,Exactly,6)},{SetNVar(ST_AngleYZ,SetTo,300),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,2,SHLevel)})
		CB_VShape(VptrInitA,4) -- Init
		CB_VShape(VptrRetA,5) -- Init -> CB_Rotate
		CB_VShape(VptrRetA2,6) -- CB_Rotate -> CB_Ratio
		SC2 = CB_InitCache(CycleLength,ST1_A[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_A[1]
		CB_LoadCache(SC2,ST_VTimeLine,VptrRetA2)
		CB_GetNumber(6,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio2) -- Temp비율 로드

	CElseIfX({NVar(ST_Shape,Exactly,9)},{SetNVar(ST_AngleYZ,SetTo,60),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,1,SHLevel)})
		VptrInitB = CB_InitVShape(7) -- Init
		VptrRetB = CB_InitVShape(8) -- Init -> CB_Rotate
		VptrRetB2 = CB_InitVShape(9) -- CB_Rotate -> CB_Ratio
		SC3 = CB_InitCache(CycleLength,ST1_B[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_B[1]
		CB_LoadCache(SC3,ST_VTimeLine,VptrRetB2)
		CB_GetNumber(9,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio1) -- Temp비율 로드
	CElseIfX({NVar(ST_Shape,Exactly,12)},{SetNVar(ST_AngleYZ,SetTo,300),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,2,SHLevel)})
		CB_VShape(VptrInitB,10) -- Init
		CB_VShape(VptrRetB,11) -- Init -> CB_Rotate
		CB_VShape(VptrRetB2,12) -- CB_Rotate -> CB_Ratio
		SC4 = CB_InitCache(CycleLength,ST1_B[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_B[1]
		CB_LoadCache(SC4,ST_VTimeLine,VptrRetB2)
		CB_GetNumber(12,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio2) -- Temp비율 로드

	CElseIfX({NVar(ST_Shape,Exactly,15)},{SetNVar(ST_AngleYZ,SetTo,60),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,1,SHLevel)})
		VptrInitC = CB_InitVShape(13) -- Init
		VptrRetC = CB_InitVShape(14) -- Init -> CB_Rotate
		VptrRetC2 = CB_InitVShape(15) -- CB_Rotate -> CB_Ratio
		SC5 = CB_InitCache(CycleLength,ST1_C[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_C[1]
		CB_LoadCache(SC5,ST_VTimeLine,VptrRetC2)
		CB_GetNumber(15,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio1) -- Temp비율 로드
	CElseIfX({NVar(ST_Shape,Exactly,18)},{SetNVar(ST_AngleYZ,SetTo,300),SetNVar(ST_AngleZX,SetTo,45),SetCDeaths("X",SetTo,2,SHLevel)})
		CB_VShape(VptrInitC,16) -- Init
		CB_VShape(VptrRetC,17) -- Init -> CB_Rotate
		CB_VShape(VptrRetC2,18) -- CB_Rotate -> CB_Ratio
		SC6 = CB_InitCache(CycleLength,ST1_C[1],0x80000000) -- CycleLength : 360 /  Dot : ST1_C[1]
		CB_LoadCache(SC6,ST_VTimeLine,VptrRetC2)
		CB_GetNumber(18,ST_VNull)
		CMov(FP,ST_Ratio,TempRatio2) -- Temp비율 로드
	CIfXEnd()
		CIf(FP,{NVar(ST_VNull,Exactly,0x80000000)})
			CIfX(FP,{NVar(ST_Shape,AtLeast,3),NVar(ST_Shape,AtMost,6)})
				CB_Rotate3D(ST_AngleXY,ST_AngleYZ,ST_AngleZX,VptrInitA,VptrRetA)
				CB_Ratio(ST_Ratio,540,ST_Ratio,540,VptrRetA,VptrRetA2) -- 1 ~ 720 (+8/tik)
				CIfX(FP,{NVar(ST_Shape,Exactly,3)})
					CB_SaveCache(SC1,ST_VTimeLine,VptrRetA2)
				CElseX()
					CB_SaveCache(SC2,ST_VTimeLine,VptrRetA2)
				CIfXEnd()
			CElseIfX({NVar(ST_Shape,AtLeast,9),NVar(ST_Shape,AtMost,12)})
				CB_Rotate3D(ST_AngleXY,ST_AngleYZ,ST_AngleZX,VptrInitB,VptrRetB)
				CB_Ratio(ST_Ratio,540,ST_Ratio,540,VptrRetB,VptrRetB2) -- 1 ~ 720 (+8/tik)
				CIfX(FP,{NVar(ST_Shape,Exactly,9)})
					CB_SaveCache(SC3,ST_VTimeLine,VptrRetB2)
				CElseX()
					CB_SaveCache(SC4,ST_VTimeLine,VptrRetB2)
				CIfXEnd()
			CElseIfX({NVar(ST_Shape,AtLeast,15),NVar(ST_Shape,AtMost,18)})
				CB_Rotate3D(ST_AngleXY,ST_AngleYZ,ST_AngleZX,VptrInitC,VptrRetC)
				CB_Ratio(ST_Ratio,540,ST_Ratio,540,VptrRetC,VptrRetC2) -- 1 ~ 720 (+8/tik)
				CIfX(FP,{NVar(ST_Shape,Exactly,15)})
					CB_SaveCache(SC5,ST_VTimeLine,VptrRetC2)
				CElseX()
					CB_SaveCache(SC6,ST_VTimeLine,VptrRetC2)
				CIfXEnd()
			CIfXEnd()
		CIfEnd()
end

-- CFunc -- 
CallCreateEffect = InitCFunc(FP)

CFunc(CallCreateEffect)
local SpriteIndex = 545
local SpriteIndexR = 253
local BigSpriteIndex = 925
local BigSpriteIndexR = 365
local CenterSprite = 928
local CenterSpriteR = 368
CIf(FP,{Memory(0x628438,AtLeast,1)})
	CIfX(FP,{CDeaths("X",Exactly,1,SHLevel)})
		CreateEffect(FP, Nextptr, 16, BigSpriteIndex, 18, 204, "CLoc106", P5)
		CreateEffect(FP, Nextptr, 6, BigSpriteIndex, 19, 204, "CLoc106", P5)
	CElseIfX({CDeaths("X",Exactly,2,SHLevel)})
		CreateEffect(FP, Nextptr, 13, BigSpriteIndex, 18, 204, "CLoc106", P5)
		CreateEffect(FP, Nextptr, 6, BigSpriteIndex, 19, 204, "CLoc106", P5)
	CIfXEnd()
CIfEnd()
CFuncEnd()

ST_CBPlot = InitCFunc(FP)

CFunc(ST_CBPlot)
	CBPlot(ST_ShapeArr,nil,P6,193,"CLoc106",{ST_PosX,ST_PosY},1,32,{ST_Shape,0,0,0,600,ST_DataIndex}
		,"ST_CAFunc","ST_CBFunc",FP,nil,{SetNext("X",0x5004),SetNext(0x5005,"X",1)})
CFuncEnd()

-- CreateUnit Para -- 

CJump(FP,5)
SetLabel(0x5004)

CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths("X",Exactly,1,LockSW)}) --  캐시메모리 저장후 

CTrigger(FP,{TNVar(Cur_DataIndex,Exactly,EffectDot[1])},{SetCDeathsX("X",SetTo,2*65536,ST_Stage,0xFF0000)},{Preserved})
CTrigger(FP,{TNVar(Cur_DataIndex,Exactly,EffectDot[2])},{SetCDeathsX("X",SetTo,2*65536,ST_Stage,0xFF0000)},{Preserved})
CTrigger(FP,{TNVar(Cur_DataIndex,Exactly,EffectDot[3]),CVar("X",GMode,AtLeast,2)},{SetCDeathsX("X",SetTo,2*65536,ST_Stage,0xFF0000)},{Preserved})
CTrigger(FP,{TNVar(Cur_DataIndex,Exactly,EffectDot[4]),CVar("X",GMode,Exactly,3)},{SetCDeathsX("X",SetTo,2*65536,ST_Stage,0xFF0000)},{Preserved})

CIfX(FP,{CDeathsX("X",Exactly,1*65536,ST_Stage,0xFF0000)},{SetSpriteImage(385, SpriteIndex),SetImageScript(SpriteIndex, 131)}) -- 일반유닛
	CreateEffect(FP, Nextptr, 17, SpriteIndex, 18, 204, "CLoc106", P5)
	CTrigger(FP,{NVar(ST_CreateSW,Exactly,1)},{
		TCreateUnit(1,Common_XUType,"CLoc106",UPlayer);
	},{Preserved})
CElseIfX({CDeathsX("X",Exactly,2*65536,ST_Stage,0xFF0000)},{SetSpriteImage(385, BigSpriteIndex),SetImageScript(BigSpriteIndex, 131)}) -- 특수유닛
	CallCFuncX(FP,CallCreateEffect)
	CIf(FP,{NVar(ST_CreateSW,Exactly,1)})
		CIfX(FP,{CVar("X",GMode,Exactly,1)})
			CDoActions(FP,{
				TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
			})
		CElseX() -- 하드이상
			SetNextptr()
			CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_UType,"CLoc106",P8);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100); -- Require Detection
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF); -- Visibility State
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000); -- Storm Timer ( GunTimer )
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00); -- Unused Timer ( Check GunPlayer )
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00); -- Individual Pointer
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Vision
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000); -- Individual TBL ( Blind State )
			},{Preserved})
		CIfXEnd()
	CIfEnd()
CIfXEnd()

DoActionsX(FP,{SetCDeathsX("X",Subtract,1*256,ST_Stage,0xFF00),SetCDeathsX("X",SetTo,1*65536,ST_Stage,0xFF0000)})

CIfEnd()

SetLabel(0x5005)
CJumpEnd(FP,5)

CIf(FP,{CDeaths("X",Exactly,0,LockSW),NDeaths(FP,Exactly,1,LvlJump)}) -- 캐시메모리 ( 난이도 선택 후 저장 )
	TriggerX(FP,{},{SetNVar(TempRatio1,SetTo,180),SetNVar(TempRatio2,SetTo,720)}) -- Init 540
	CDoActions(FP,{TSetNVar(ST_Shape,SetTo,TempShape1),SetNVar(ST_DataIndex,SetTo,0)})
	CallCFuncX(FP,ST_CBPlot)
	CDoActions(FP,{TSetNVar(ST_Shape,SetTo,TempShape2),SetNVar(ST_DataIndex,SetTo,0)})
	CallCFuncX(FP,ST_CBPlot)
	--( 0 ~ 90 증가(+8/tik) // 91 ~ 180 감소 // 181 ~ 270 증가 // 271 ~ 360 감소 )
	TriggerX(FP,{NVar(ST_VTimeLine,AtMost,90)},{SetNVar(TempRatio1,Add,6),SetNVar(TempRatio2,Subtract,6)},{Preserved})
	TriggerX(FP,{NVar(ST_VTimeLine,AtLeast,91),NVar(ST_VTimeLine,AtMost,180)},{SetNVar(TempRatio1,Subtract,6),SetNVar(TempRatio2,Add,6)},{Preserved})
	TriggerX(FP,{NVar(ST_VTimeLine,AtLeast,181),NVar(ST_VTimeLine,AtMost,270)},{SetNVar(TempRatio1,Add,6),SetNVar(TempRatio2,Subtract,6)},{Preserved})
	TriggerX(FP,{NVar(ST_VTimeLine,AtLeast,271),NVar(ST_VTimeLine,AtMost,360)},{SetNVar(TempRatio1,Subtract,6),SetNVar(TempRatio2,Add,6)},{Preserved})
	DoActionsX(FP,{SetNVar(ST_VTimeLine,Add,1),SetNVar(ST_AngleXY,Add,3)})
	TriggerX(FP,{NVar(ST_VTimeLine,AtLeast,360)},{
		SetNVar(ST_VTimeLine,SetTo,0);
		SetNVar(ST_AngleXY,SetTo,0);
		SetCDeaths("X",SetTo,1,LockSW);
	})
CIfEnd()

function SetSTGun(TimeLine,Timer)

CMov(FP,ST_VTimeLine,TimeLine) -- VTimeline 저장

TriggerX(FP,{NVar(TimeLine,Exactly,34)},{SetNVar(ST_CreateSW,SetTo,1)},{Preserved})
TriggerX(FP,{NVar(TimeLine,Exactly,180+34)},{SetNVar(ST_CreateSW,SetTo,1)},{Preserved})
CTrigger(FP,{CDeaths("X",Exactly,0,Timer)},{TSetNVar(Common_XUType,SetTo,UV[1]),TSetNVar(Common_UType,SetTo,UV[2])},{Preserved})
CTrigger(FP,{CDeaths("X",Exactly,1,Timer)},{TSetNVar(Common_XUType,SetTo,UV[3]),TSetNVar(Common_UType,SetTo,UV[4])},{Preserved})
CTrigger(FP,{CDeaths("X",Exactly,2,Timer)},{TSetNVar(Common_XUType,SetTo,UV[5]),TSetNVar(Common_UType,SetTo,UV[6])},{Preserved})
CTrigger(FP,{CDeaths("X",Exactly,3,Timer)},{TSetNVar(Common_XUType,SetTo,UV[7]),TSetNVar(Common_UType,SetTo,UV[8])},{Preserved})

CDoActions(FP,{TSetNVar(ST_Shape,SetTo,TempShape1),SetNVar(ST_DataIndex,SetTo,0)})
CallCFuncX(FP,ST_CBPlot)
CDoActions(FP,{TSetNVar(ST_Shape,SetTo,TempShape2),SetNVar(ST_DataIndex,SetTo,0)})
CallCFuncX(FP,ST_CBPlot)

SetLocCenter(GLoc,"CLoc76")
TriggerX(FP,{NVar(ST_CreateSW,Exactly,1)},{
	Simple_CalcLoc("CLoc76",-512,-512,512,512);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","CLoc76")},{Force2},FP);
},{Preserved})

DoActionsX(FP,{SetSpriteImage(385, CenterSprite),SetImageScript(CenterSprite, 131),SetNVar(TimeLine,Add,1),SetNVar(ST_CreateSW,SetTo,0)})
TriggerX(FP,{NVar(TimeLine,AtLeast,360)},{SetNVar(TimeLine,SetTo,0),SetCDeaths("X",Add,1,Timer)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,4,Timer)},{SetSwitch(GLock,Set)})

NIf(FP,{Memory(0x628438,AtLeast,1)}) -- Center Effect
	CreateEffect(FP, Nextptr, 16, CenterSprite, 19, 204, GLoc, P5)
	CreateEffect(FP, Nextptr, 6, CenterSprite, 20, 204, GLoc, P5)
NIfEnd()

DoActions(FP,{SetImageScript(CenterSprite, CenterSpriteR),SetImageScript(SpriteIndex, SpriteIndexR),SetImageScript(BigSpriteIndex, BigSpriteIndexR)})
end

------<  SG1  >------------------------------------------
SG1_VTimeLine = CreateVar(FP)
SG1_Timer = CreateCcode()

GCenter = {640,4464}
CA_GunPreset(P6,167,"Switch 75",45,"SG1")

TriggerX(FP,{Switch(GLock,Set)},{SetCDeathsX("X",SetTo,0,CheckSTGun,0xFF),SetNVar(SpriteCount,Subtract,3*(64+8))})
CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
DoActionsX(FP,{
	SetNVar(ST_PosX,SetTo,GCenter[1]),SetNVar(ST_PosY,SetTo,GCenter[2])
	,SetNVar(UPlayer,SetTo,5),SetCDeathsX("X",SetTo,1,CheckSTGun,0xFF)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText7,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,12);
		SetNVar(BGMVar[1],SetTo,12);
		SetNVar(BGMVar[2],SetTo,12);
		SetNVar(BGMVar[3],SetTo,12);
		SetNVar(BGMVar[4],SetTo,12);
		SetNVar(BGMVar[5],SetTo,12);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})
-- OddNum = HUnit  // EvenNum = GUnit
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,86);SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,86);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,98);SetNVar(UV[7],SetTo,12);SetNVar(UV[8],SetTo,98);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,88);SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,88);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,60);SetNVar(UV[7],SetTo,88);SetNVar(UV[8],SetTo,60);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,86);SetNVar(UV[2],SetTo,99);SetNVar(UV[3],SetTo,98);SetNVar(UV[4],SetTo,99);
	SetNVar(UV[5],SetTo,88);SetNVar(UV[6],SetTo,9);SetNVar(UV[7],SetTo,69);SetNVar(UV[8],SetTo,9);
},{Preserved})

SetSTGun(SG1_VTimeLine,SG1_Timer)

CIfEnd()

------<  SG2  >------------------------------------------

SG2_VTimeLine = CreateVar(FP)
SG2_Timer = CreateCcode()

GCenter = {640,3824}
CA_GunPreset(P6,167,"Switch 76",46,"SG2")

TriggerX(FP,{Switch(GLock,Set)},{SetCDeathsX("X",SetTo,0,CheckSTGun,0xFF00),SetNVar(SpriteCount,Subtract,3*(64+8))})
CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
DoActionsX(FP,{
	SetNVar(ST_PosX,SetTo,GCenter[1]),SetNVar(ST_PosY,SetTo,GCenter[2])
	,SetNVar(UPlayer,SetTo,5),SetCDeathsX("X",SetTo,1*256,CheckSTGun,0xFF00)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText7,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,12);
		SetNVar(BGMVar[1],SetTo,12);
		SetNVar(BGMVar[2],SetTo,12);
		SetNVar(BGMVar[3],SetTo,12);
		SetNVar(BGMVar[4],SetTo,12);
		SetNVar(BGMVar[5],SetTo,12);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})

-- OddNum = HUnit  // EvenNum = GUnit
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,86);SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,86);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,98);SetNVar(UV[7],SetTo,12);SetNVar(UV[8],SetTo,98);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,88);SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,88);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,60);SetNVar(UV[7],SetTo,88);SetNVar(UV[8],SetTo,60);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,86);SetNVar(UV[2],SetTo,99);SetNVar(UV[3],SetTo,98);SetNVar(UV[4],SetTo,99);
	SetNVar(UV[5],SetTo,88);SetNVar(UV[6],SetTo,9);SetNVar(UV[7],SetTo,69);SetNVar(UV[8],SetTo,9);
},{Preserved})

SetSTGun(SG2_VTimeLine,SG2_Timer)

CIfEnd()

------<  SP1  >------------------------------------------

SP1_VTimeLine = CreateVar(FP)
SP1_Timer = CreateCcode()

GCenter = {1408,4464}
CA_GunPreset(P7,114,"Switch 77",47,"SP1")

TriggerX(FP,{Switch(GLock,Set)},{SetCDeathsX("X",SetTo,0,CheckSTGun,0xFF0000),SetNVar(SpriteCount,Subtract,3*(64+8))})
CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
DoActionsX(FP,{
	SetNVar(ST_PosX,SetTo,GCenter[1]),SetNVar(ST_PosY,SetTo,GCenter[2])
	,SetNVar(UPlayer,SetTo,6),SetCDeathsX("X",SetTo,1*65536,CheckSTGun,0xFF0000)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText8,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,12);
		SetNVar(BGMVar[1],SetTo,12);
		SetNVar(BGMVar[2],SetTo,12);
		SetNVar(BGMVar[3],SetTo,12);
		SetNVar(BGMVar[4],SetTo,12);
		SetNVar(BGMVar[5],SetTo,12);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})

-- OddNum = HUnit  // EvenNum = GUnit
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,58);SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,58);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,27);SetNVar(UV[7],SetTo,12);SetNVar(UV[8],SetTo,27);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,21);SetNVar(UV[2],SetTo,8);SetNVar(UV[3],SetTo,58);SetNVar(UV[4],SetTo,8);
	SetNVar(UV[5],SetTo,27);SetNVar(UV[6],SetTo,102);SetNVar(UV[7],SetTo,8);SetNVar(UV[8],SetTo,102);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,58);SetNVar(UV[2],SetTo,102);SetNVar(UV[3],SetTo,27);SetNVar(UV[4],SetTo,102);
	SetNVar(UV[5],SetTo,8);SetNVar(UV[6],SetTo,9);SetNVar(UV[7],SetTo,30);SetNVar(UV[8],SetTo,9);
},{Preserved})

SetSTGun(SP1_VTimeLine,SP1_Timer)

CIfEnd()

------<  SP2  >------------------------------------------

SP2_VTimeLine = CreateVar(FP)
SP2_Timer = CreateCcode()

GCenter = {1408,3824}
CA_GunPreset(P7,114,"Switch 78",48,"SP2")

TriggerX(FP,{Switch(GLock,Set)},{SetCDeathsX("X",SetTo,0,CheckSTGun,0xFF000000),SetNVar(SpriteCount,Subtract,3*(64+8))})
CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
DoActionsX(FP,{
	SetNVar(ST_PosX,SetTo,GCenter[1]),SetNVar(ST_PosY,SetTo,GCenter[2])
	,SetNVar(UPlayer,SetTo,6),SetCDeathsX("X",SetTo,1*16777216,CheckSTGun,0xFF000000)})
SetVFlags()
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText8,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,12);
		SetNVar(BGMVar[1],SetTo,12);
		SetNVar(BGMVar[2],SetTo,12);
		SetNVar(BGMVar[3],SetTo,12);
		SetNVar(BGMVar[4],SetTo,12);
		SetNVar(BGMVar[5],SetTo,12);
		SetNVar(BuildTimeVar,Add,2);
		SetScore(Force1,Add,100000,Kills);
	})

-- OddNum = HUnit  // EvenNum = GUnit
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,58);SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,58);
	SetNVar(UV[5],SetTo,80);SetNVar(UV[6],SetTo,27);SetNVar(UV[7],SetTo,12);SetNVar(UV[8],SetTo,27);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,21);SetNVar(UV[2],SetTo,8);SetNVar(UV[3],SetTo,58);SetNVar(UV[4],SetTo,8);
	SetNVar(UV[5],SetTo,27);SetNVar(UV[6],SetTo,102);SetNVar(UV[7],SetTo,8);SetNVar(UV[8],SetTo,102);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,58);SetNVar(UV[2],SetTo,102);SetNVar(UV[3],SetTo,27);SetNVar(UV[4],SetTo,102);
	SetNVar(UV[5],SetTo,8);SetNVar(UV[6],SetTo,9);SetNVar(UV[7],SetTo,30);SetNVar(UV[8],SetTo,9);
},{Preserved})

SetSTGun(SP2_VTimeLine,SP2_Timer)

CIfEnd()


------<  Center  >------------------------------------------
--< Center ArrangeFuncs >--
function ArrangeFunc(X,Y)
	return {math.abs(Y)}
end
function ArrangeFunc2(X,Y)
	return {math.abs(X)}
end

--< Center7 Shapes >--
function Center7FuncA(Y) return 6*math.abs(2*(Y/8-math.floor(Y/8))-1)-2 end
function Center7FuncB(Y) return -6*math.abs(2*(Y/8-math.floor(Y/8))-1)+2 end
Center7A1 = CS_RatioXY(CSMakeGraphY2("Center7FuncA",0,0,0.3,10,0.01,94),256,256)
Center7A2 = CS_RatioXY(CSMakeGraphY2("Center7FuncB",0,0,0.3,10,0.01,94),256,256)
Center7A = CS_OverlapX(Center7A1,Center7A2)
SH_Center7A = CS_MirrorY(Center7A,0)
SHCenter7 = CS_SortXY(SH_Center7A,"ArrangeFunc",nil,0) -- Ascending Order
SHCenter7_Dest = CS_SortXY(CS_RatioXY(CS_Reverse(SH_Center7A),1,0.75),"ArrangeFunc",nil,0)

SHLine7A = CS_OverlapX(CS_ConnectPathX(CSMakePath({1000,-4000},{1000,0}),100),CS_ConnectPathX(CSMakePath({-1000,-4000},{1000,-4000}),80))
SHLine7B = CS_OverlapX(CS_ConnectPathX(CSMakePath({1000,-4000},{1000,0}),150),CS_ConnectPathX(CSMakePath({-1000,-4000},{1000,-4000}),120))
SHLine7A_Dest = CS_RatioXY(SHLine7A,0.001,0.001)
SHLine7B_Dest = CS_RatioXY(SHLine7B,0.001,0.001)
--< Center5 Shapes >-- 	
SHCenter5 = CS_SortXY(SH_Center7A,"ArrangeFunc2",nil,0) -- Ascending Order
SHCenter5_Dest = CS_SortXY(CS_RatioXY(CS_Reverse(SH_Center7A),1,0.75),"ArrangeFunc2",nil,0)

SHLine5A = CS_Rotate(SHLine7A,180)
SHLine5B = CS_Rotate(SHLine7B,180)
SHLine5A_Dest = CS_RatioXY(SHLine5A,0.001,0.001)
SHLine5B_Dest = CS_RatioXY(SHLine5B,0.001,0.001)

--< Center9 Shapes >--
function Center9FuncA(Y) return math.abs(7*math.sin(Y/2))-3.5 end
function Center9FuncB(Y) return -math.abs(7*math.sin(Y/2))+3.5 end
Center9A1 = CS_RatioXY(CSMakeGraphY2("Center9FuncA",0,0,0.4,10,0.01,95),256,256)
Center9A2 = CS_RatioXY(CSMakeGraphY2("Center9FuncB",0,0,0.4,10,0.01,95),256,256)
Center9A = CS_OverlapX(Center9A1,Center9A2)
Center9A = CS_MirrorY(Center9A,0)

SHCenter9 = CS_SortXY(Center9A,"ArrangeFunc2",nil,1) -- Descending Order
SHCenter9_Dest = CS_SortXY(CS_RatioXY(CS_Reverse(SHCenter9),1,0.75),"ArrangeFunc2",nil,1)
SHLine9A = CS_MoveXY(CSMakeSpiral(2, 756+128, 0.3, 128, 0, CS_Level("Spiral",2,30),0),0,-2496) -- Hard
SHLine9B = CS_MoveXY(CSMakeSpiral(3, 756+128, 0.3, 128, 150, CS_Level("Spiral",3,24),0),0,2496) -- Lunatic
SHLine9A_Dest = CS_RatioXY(SHLine9A,0.001,0.001)
SHLine9B_Dest = CS_RatioXY(SHLine9B,0.001,0.001)

--< Center3 Shapes >--
SHCenter3 = CS_SortXY(Center9A,"ArrangeFunc",nil,0) -- Ascending Order
SHCenter3_Dest = CS_SortXY(CS_RatioXY(CS_Reverse(SHCenter3),1,0.75),"ArrangeFunc",nil,0)
SHLine3A = CS_MoveXY(CSMakeSpiral(2, 756+128, 0.3, 128, 0, CS_Level("Spiral",2,30),0),0,2496) -- Hard
SHLine3B = CS_MoveXY(CSMakeSpiral(3, 756+128, 0.3, 128, 150, CS_Level("Spiral",3,24),0),0,-2496) -- Lunatic
SHLine3A_Dest = CS_RatioXY(SHLine3A,0.001,0.001)
SHLine3B_Dest = CS_RatioXY(SHLine3B,0.001,0.001)

--< Center11 Shapes >--
function Center11FuncA(Y) return math.sin(6*Y)+3*math.sin(Y) end
Center11A1 = CS_RatioXY(CSMakeGraphY2("Center11FuncA",0,0,0.5,10,0.01,134),256,256)
SHCenter11 = CS_SortXY(CS_MirrorY(Center11A1,0),"ArrangeFunc",nil,0)
SHCenter11_Dest = CS_SortXY(CS_RatioXY(CS_Reverse(SHCenter11),1,0.75),"ArrangeFunc",nil,0)

function CenterWarpUfunc(X,Data) return 128*math.sin(math.rad(X))+Data[2][1] end
function CenterWarpDfunc(X,Data) return 128*math.sin(math.rad(X))+Data[2][2] end

LineBaseA = CS_FillXY({1,1},384,256,36,36)
LineBaseB = CS_FillXY({1,1},384,256,32,32)
SHLine11A = CS_MoveXY(CS_RatioXY(CS_Warping(LineBaseA,"CenterWarpUfunc","CenterWarpDfunc"),5,4),0,3*1024) -- 88
SHLine11B = CS_MoveXY(CS_RatioXY(CS_Warping(LineBaseB,"CenterWarpUfunc","CenterWarpDfunc"),5,2),0,-3*1024) -- 117
SHLine11A_Dest = CS_RatioXY(SHLine11A,0.001,0.001)
SHLine11B_Dest = CS_RatioXY(SHLine11B,0.001,0.001)

--< Center1 Shapes >--

SHCenter1 = CS_SortXY(CS_SortXY(CS_MirrorY(Center11A1,0),"ArrangeFunc",nil,0),"ArrangeFunc2",nil,1)
SHCenter1_Dest = CS_SortXY(CS_SortXY(CS_RatioXY(CS_Reverse(SHCenter1),1,0.75),"ArrangeFunc",nil,0),"ArrangeFunc2",nil,1)

SHLine1A = CS_MoveXY(CS_RatioXY(CS_Warping(LineBaseA,"CenterWarpUfunc","CenterWarpDfunc"),5,4),0,-3*1024) -- 88
SHLine1B = CS_MoveXY(CS_RatioXY(CS_Warping(LineBaseB,"CenterWarpUfunc","CenterWarpDfunc"),5,2),0,3*1024) -- 117
SHLine1A_Dest = CS_RatioXY(SHLine1A,0.001,0.001)
SHLine1B_Dest = CS_RatioXY(SHLine1B,0.001,0.001)

-- ShapeArr -- 3*6
CenterShapeArr = {SHCenter7,SHLine7A,SHLine7B,SHCenter5,SHLine5A,SHLine5B,SHCenter9,SHLine9A,SHLine9B,SHCenter3,SHLine3A,SHLine3B,
				SHCenter11,SHLine11A,SHLine11B,SHCenter1,SHLine1A,SHLine1B}
CenterDestArr = {SHCenter7_Dest,SHLine7A_Dest,SHLine7B_Dest,SHCenter5_Dest,SHLine5A_Dest,SHLine5B_Dest,SHCenter9_Dest,SHLine9A_Dest,SHLine9B_Dest
		,SHCenter3_Dest,SHLine3A_Dest,SHLine3B_Dest,SHCenter11_Dest,SHLine11A_Dest,SHLine11B_Dest,SHCenter1_Dest,SHLine1A_Dest,SHLine1B_Dest}
-- Vars  --
Center7_OrderSW, Center5_OrderSW, Center3_OrderSW, Center9_OrderSW, Center11_OrderSW, Center1_OrderSW, LockTarget = CreateVars(7,FP)
CenterStage = CreateCcode()
CenterShape, DestVShape, CenterDataIndex, CenterLoopLimit, GiveUPlayer, CVShape, DestDataIndex = CreateVars(7,FP)

ChkMarPosA = InitCFunc(FP)
CFunc(ChkMarPosA)
	TriggerX(FP,{
		NVar(Center11_OrderSW,Exactly,0);
		Bring(Force1,AtLeast,1,20,"CLoc99")
	},{
		SetNVar(Center11_OrderSW,SetTo,1); -- Lock SW
		MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
	})
CFuncEnd()

ChkMarPosB = InitCFunc(FP)

CFunc(ChkMarPosB)
	TriggerX(FP,{
		NVar(Center1_OrderSW,Exactly,0);
		Bring(Force1,AtLeast,1,20,"CLoc99");
	},{
		SetNVar(Center1_OrderSW,SetTo,1); -- Lock SW
		MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
	})
CFuncEnd()

SetTarget = InitCFunc(FP)
CFunc(SetTarget)
--< Center 7 >--
CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center7_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 0, 127 do -- 최하단 우선타겟
			TriggerX(FP,{NVar(Center7_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,64*i,2048,64+64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center7_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center7_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
			TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{
					SetNVar(Center7_OrderSW,SetTo,1);
					MoveLocation("CLoc107",20,Force1,"HZ");
				})
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 31, 0, -1 do -- 최우측 우선타겟
			TriggerX(FP,{NVar(Center7_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",64*i,0,64+64*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center7_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center7_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center7_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()

--< Center 5 >--

CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center5_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 0, 127 do -- 최하단 우선타겟
			TriggerX(FP,{NVar(Center5_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,64*i,2048,64+64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center5_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center5_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 0, 31 do -- 최좌측 우선타겟
			TriggerX(FP,{NVar(Center5_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",64*i,0,64+64*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center5_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center5_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center5_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()

--< Center 9 >--

CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center9_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 31, 0, -1 do -- 최우측 우선타겟
			TriggerX(FP,{NVar(Center9_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",64*i,0,64+64*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center9_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center9_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 0, 127 do -- 최하단 우선타겟
			TriggerX(FP,{NVar(Center9_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,64*i,2048,64+64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center9_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center9_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center9_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()

--< Center 3 >--

CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center3_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 0, 31 do -- 최좌측 우선타겟
			TriggerX(FP,{NVar(Center3_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",64*i,0,64+64*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center3_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center3_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 127, 0, -1 do -- 최상단 우선타겟
			TriggerX(FP,{NVar(Center3_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,64*i,2048,64+64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			TriggerX(FP,{
				NVar(Center3_OrderSW,Exactly,0);
				Bring(Force1,AtLeast,1,20,"CLoc99")
			},{
				SetNVar(Center3_OrderSW,SetTo,1); -- Lock SW
				MoveLocation("CLoc107",20,Force1,"CLoc99"); -- Set Patrol Loc
			})
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center3_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()

--< Center 11 >--

CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center11_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 127, 0, -1 do -- 맵중앙( Y = 4096 )기준 Y절대값 가장큰타겟 우선
			TriggerX(FP,{NVar(Center11_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,4096+64*i,2048,4096+64*(i+1)); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosA,nil,nil,FP,{NVar(Center11_OrderSW,Exactly,0)},nil,1)
			TriggerX(FP,{NVar(Center11_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,4096-64*(i+1),2048,4096-64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosA,nil,nil,FP,{NVar(Center11_OrderSW,Exactly,0)},nil,1)
		end
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 0, 63 do -- 맵중앙( X= 1024 )기준 X절대값 가장작은타겟 우선
			TriggerX(FP,{NVar(Center11_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",1024-16*(i+1),0,1024-16*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosA,nil,nil,FP,{NVar(Center11_OrderSW,Exactly,0)},nil,1)
			TriggerX(FP,{NVar(Center11_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",1024+16*i,0,1024+16*(i+1),8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosA,nil,nil,FP,{NVar(Center11_OrderSW,Exactly,0)},nil,1)
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center11_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()

--< Center 1 >--
CIf(FP,{NVar(LockTarget,Exactly,0),NVar(Center1_OrderSW,Exactly,0)})
	CIfX(FP,CVar("X",GMode,Exactly,2))
		for i = 63, 0, -1 do -- 맵중앙( X= 1024 )기준 X절대값 가장큰타겟 우선
			TriggerX(FP,{NVar(Center1_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",1024+16*i,0,1024+16*(i+1),8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosB,nil,nil,FP,{NVar(Center1_OrderSW,Exactly,0)},nil,1)
			TriggerX(FP,{NVar(Center1_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",1024-16*(i+1),0,1024-16*i,8192); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosB,nil,nil,FP,{NVar(Center1_OrderSW,Exactly,0)},nil,1)
		end
	CElseIfX({CVar("X",GMode,Exactly,3)})
		for i = 0, 127 do -- 맵중앙( Y = 4096 )기준 Y절대값 가장작은타겟 우선
			TriggerX(FP,{NVar(Center1_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,4096+64*i,2048,4096+64*(i+1)); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosB,nil,nil,FP,{NVar(Center1_OrderSW,Exactly,0)},nil,1)
			TriggerX(FP,{NVar(Center1_OrderSW,Exactly,0)},{
				Simple_SetLoc("CLoc99",0,4096-64*(i+1),2048,4096-64*i); -- Priority Target
				RemoveUnitAt(1,84,"CLoc99",P12);
			})
			CallCFunc(ChkMarPosB,nil,nil,FP,{NVar(Center1_OrderSW,Exactly,0)},nil,1)
		end
	CIfXEnd()
TriggerX(FP,{Bring(Force1,Exactly,0,20,"Anywhere")},{ -- 영마없을때 힐존을 우선타겟으로 설정
		SetNVar(Center1_OrderSW,SetTo,1);
		MoveLocation("CLoc107",20,Force1,"HZ");
	})
DoActionsX(FP,SetNVar(LockTarget,SetTo,1))
CIfEnd()
DoActionsX(FP,SetNVar(LockTarget,Subtract,1)) -- Reset
CFuncEnd()

--< CAPlot CFunc >--
Center_CAPlot = InitCFunc(FP)
CFunc(Center_CAPlot)
	CAPlotOrder(CenterShapeArr,P6,193,"CLoc106",{1024,4096},1,32,{CenterShape,0,0,0,CenterLoopLimit,CenterDataIndex}
	,nil,CenterDestArr,Move,"CenterDest",nil,{DestVShape,DestDataIndex},nil,{32,32},FP,nil,{SetNext("X",0x5006),SetNext(0x5007,"X",1)})
CFuncEnd()

--< 유닛생성단락 >--

CJump(FP,6)
SetLabel(0x5006)

NIf(FP,{Memory(0x628438,AtLeast,1)})
	CIf(FP,CDeaths("X",Exactly,0,VInput)) -- Normal Unit
		SetNextptr()
			CDoActions(FP,{
				TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
				TSetMemory(Vi(Nextptr[2],13),SetTo,1707);
				TSetMemory(Vi(Nextptr[2],14),SetTo,67);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],9),SetTo,2*65536,0xFF0000); -- 정야독
				TGiveUnits(1,Common_UType,UPlayer,"CLoc106",P9);
				CreateUnit(1,84,"CLoc106",P5);
			})
	CIfEnd()
	CIf(FP,{CDeaths("X",Exactly,1,VInput),CVar("X",GMode,Exactly,1)})
		SetNextptr()
			CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
				TSetMemory(Vi(Nextptr[2],13),SetTo,1707);
				TSetMemory(Vi(Nextptr[2],14),SetTo,67);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],9),SetTo,2*65536,0xFF0000); -- 정야독
				TGiveUnits(1,Common_UType,UPlayer,"CLoc106",P10);
				CreateUnit(1,84,"CLoc106",P5);
			},{Preserved})
	CIfEnd()
	CIf(FP,{CDeaths("X",Exactly,1,VInput),CVar("X",GMode,AtLeast,2)}) -- 강유닛
		CMov(FP,UIDVar,Common_UType,0,0xFFFF)
		CallTrigger(FP,SetGUnitHP)
			SetNextptr()
			CIfX(FP,{NVar(Common_XUType,Exactly,191,0xFFFF)})
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
						TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
						TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
						TSetMemory(Vi(Nextptr[2],13),SetTo,1707);
						TSetMemory(Vi(Nextptr[2],14),SetTo,67);
						TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
						TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
						TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000);
						TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
						TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
						TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
						TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
						TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
						TSetMemoryX(Vi(Nextptr[2],9),SetTo,2*65536,0xFF0000); -- 정야독 
						TGiveUnits(1,Common_UType,UPlayer,"CLoc106",P10);
						CreateUnit(1,84,"CLoc106",P5);
				},{Preserved})
			CElseIfX({NVar(Common_XUType,Exactly,192,0xFFFF)}) -- 유도건작유닛
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
						SetMaxHP(9,160000);
						SetMaxHP(102,150000);
						TCreateUnit(1,UV[3],"CLoc106",P8);
						TSetMemory(Vi(Nextptr[2],13),SetTo,2560);
						TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
						TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
						TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
						TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
						TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
						TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
						TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
						TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
						TOrder(UV[3],P8,"CLoc106",Patrol,"CLoc107");
						SetMaxHP(9,320000);
						SetMaxHP(102,300000);
				},{Preserved})
			CIfXEnd()
	CIfEnd()
CDoActions(FP,{
	TOrder(UV[1],P9,"CLoc106",Move,"CenterDest");
	TOrder(UV[2],P10,"CLoc106",Move,"CenterDest");
	TSetInvincibility(Enable,UV[1],P9,"CLoc106");
	TSetInvincibility(Enable,UV[2],P10,"CLoc106");
})
NIfEnd()

SetLabel(0x5007)
CJumpEnd(FP,6)

function SetCenterGun(ShapeNumber)
	TriggerX(FP,{
			CDeaths("X",Exactly,0,Stage);
			CDeaths("X",Exactly,0,Timer);
		},{
			SetCVar("X",NextDot,SetTo,600);
			SetCDeaths("X",SetTo,1,Stage);
			SetCDeaths("X",SetTo,1,Timer);
	})
	TriggerX(FP,{
			CDeaths("X",Exactly,1,Stage);
			CDeaths("X",Exactly,0,Timer);
		},{
			SetCVar("X",NextDot,SetTo,0);
			SetCVar("X",UType,SetTo,191,0xFFFF); -- Main
			SetNVar(CenterLoopLimit,SetTo,1); -- 1 point / tik
			SetCDeaths("X",SetTo,2,Stage);
			SetCDeaths("X",SetTo,12*45,Timer);
		})
	TriggerX(FP,{
		CDeaths("X",Exactly,2,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,Add,1);
		SetNVar(CenterShape,SetTo,ShapeNumber);
		SetNVar(DestVShape,SetTo,ShapeNumber);
	},{Preserved})
	TriggerX(FP,{
			CDeaths("X",Exactly,2,Stage);
			CDeaths("X",Exactly,0,Timer);
			CVar("X",GMode,Exactly,1);
		},{
			SetCDeaths("X",SetTo,3,Stage);
			SetCDeaths("X",SetTo,1,Timer);
		})
------------------------------------------------------------
-- UV[1] = 일반유닛 // UV[2] = 강유닛 // UV[3] = 유도건작유닛
CIf(FP,{CVar("X",UType,Exactly,191,0xFFFF)}) -- MainUnit
	CTrigger(FP,{
		CVar("X",GMode,Exactly,1);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,7*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,GunPlayer);
		TSetNVar(Common_UType,SetTo,UV[1]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",GMode,Exactly,1);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,8*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		SetCDeaths("X",SetTo,1,VInput);
		TSetNVar(Common_UType,SetTo,UV[2]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",GMode,Exactly,2);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,5*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,GunPlayer);
		TSetNVar(Common_UType,SetTo,UV[1]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",GMode,Exactly,2);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,6*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[2]);
		SetCDeaths("X",SetTo,1,VInput);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",GMode,Exactly,3);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,3*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,GunPlayer);
		TSetNVar(Common_UType,SetTo,UV[1]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",GMode,Exactly,3);
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,4*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[2]);
		SetCDeaths("X",SetTo,1,VInput);
	},{Preserved})
CIfEnd()

TriggerX(FP,{CVar("X",UType,AtLeast,1*16777216,0xFF000000)},{SetCVar("X",UType,Subtract,1*16777216,0xFF000000)},{Preserved})

CIf(FP,{CVar("X",GMode,AtLeast,2),CDeaths("X",Exactly,2,Stage),CDeaths("X",Exactly,0,Timer)})
	CTrigger(FP,{
			CDeaths("X",Exactly,2,Stage);
			CDeaths("X",Exactly,0,Timer);
			CVar("X",GMode,AtLeast,2);
		},{
			SetNVar(CenterLoopLimit,SetTo,600); -- all points / tik
			TSetNVar(CenterShape,SetTo,CVShape);
			TSetNVar(DestVShape,SetTo,CVShape);
			TSetNVar(Common_UType,SetTo,UV[3]);
			SetCDeaths("X",SetTo,1,VInput);
			SetCVar("X",NextDot,SetTo,1);
			SetCVar("X",UType,SetTo,192); -- 유도건작
			SetCDeaths("X",SetTo,3,Stage);
		})
			CallCFuncX(FP,SetTarget)
	CIfEnd()

	CMov(FP,CenterDataIndex,V(NextDot)) -- 현재건작 데이터인덱스 저장
	CMov(FP,DestDataIndex,V(NextDot)) -- 현재건작 도착지데이터인덱스 저장
	CMov(FP,Common_XUType,V(UType),0,0xFFFF) -- 유닛타입 저장

	CallCFuncX(FP,Center_CAPlot)

CIf(FP,{CDeaths("X",Exactly,3,Stage),CDeaths("X",Exactly,0,Timer)})
		CDoActions(FP,{
				TGiveUnits(all,UV[1],P9,"Anywhere",GunPlayer);
				TGiveUnits(all,UV[2],P10,"Anywhere",P8);
				TSetInvincibility(Disable,UV[1],GunPlayer,"Anywhere");
				TSetInvincibility(Disable,UV[2],P8,"Anywhere");
				SetSwitch(GLock,Set);
			})
		CallTrigger(FP,SetCenterJYD) -- Vision Off // Set CenterUnit JYD
	CIfEnd()

DoActionsX(FP,{
	SetCDeaths("X",Subtract,1,Timer);
	SetCDeaths("X",Subtract,1,VInput);
	SetMinimapColor(P9,Add,1);
	SetPlayerColor(P9,Add,1);
	SetMinimapColor(P10,Add,1);
	SetPlayerColor(P10,Add,1);
})
end
------< Center 7 >------------------------------------------
CA_GunPreset(P6,130,"Switch 79",49,"Center7")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible7",GunPlayer);
		KillUnitAt(all,146,"Invincible7",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,21)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,86),SetNVar(CVShape,SetTo,2)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,8),SetNVar(CVShape,SetTo,3)},{Preserved})

SetCenterGun(1)

CIfEnd()

------< Center 5 >------------------------------------------
CA_GunPreset(P7,130,"Switch 80",50,"Center5")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible5",GunPlayer);
		KillUnitAt(all,146,"Invincible5",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,80)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,8),SetNVar(UV[3],SetTo,58),SetNVar(CVShape,SetTo,5)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,8),SetNVar(UV[3],SetTo,88),SetNVar(CVShape,SetTo,6)},{Preserved})

SetCenterGun(4)

CIfEnd()

------< Center 9 >------------------------------------------
CA_GunPreset(P6,130,"Switch 81",51,"Center9")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible9",GunPlayer);
		KillUnitAt(all,146,"Invincible9",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,58)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,60),SetNVar(UV[3],SetTo,88),SetNVar(CVShape,SetTo,8)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,60),SetNVar(UV[3],SetTo,99),SetNVar(CVShape,SetTo,9)},{Preserved})

SetCenterGun(7)

CIfEnd()

------< Center 3 >------------------------------------------
CA_GunPreset(P7,130,"Switch 82",52,"Center3")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible3",GunPlayer);
		KillUnitAt(all,146,"Invincible3",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,12),SetNVar(UV[2],SetTo,98)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,12),SetNVar(UV[2],SetTo,27),SetNVar(UV[3],SetTo,8),SetNVar(CVShape,SetTo,11)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,12),SetNVar(UV[2],SetTo,27),SetNVar(UV[3],SetTo,28),SetNVar(CVShape,SetTo,12)},{Preserved})

SetCenterGun(10)

CIfEnd()

------< Center 11 >------------------------------------------
CA_GunPreset(P6,130,"Switch 83",53,"Center11")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible11",GunPlayer);
		KillUnitAt(all,146,"Invincible11",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,88),SetNVar(UV[2],SetTo,58)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,88),SetNVar(UV[2],SetTo,28),SetNVar(UV[3],SetTo,99),SetNVar(CVShape,SetTo,14)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,88),SetNVar(UV[2],SetTo,28),SetNVar(UV[3],SetTo,60),SetNVar(CVShape,SetTo,15)},{Preserved})

SetCenterGun(13)

CIfEnd()

------< Center 1 >------------------------------------------
CA_GunPreset(P7,130,"Switch 84",54,"Center1")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText5,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,6);
		SetNVar(BGMVar[1],SetTo,6);
		SetNVar(BGMVar[2],SetTo,6);
		SetNVar(BGMVar[3],SetTo,6);
		SetNVar(BGMVar[4],SetTo,6);
		SetNVar(BGMVar[5],SetTo,6);
		KillUnitAt(all,144,"Invincible1",GunPlayer);
		KillUnitAt(all,146,"Invincible1",GunPlayer);
		SetScore(Force1,Add,150000,Kills);
	})
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,8),SetNVar(UV[2],SetTo,58)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,8),SetNVar(UV[2],SetTo,28),SetNVar(UV[3],SetTo,99),SetNVar(CVShape,SetTo,17)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,8),SetNVar(UV[2],SetTo,28),SetNVar(UV[3],SetTo,102),SetNVar(CVShape,SetTo,18)},{Preserved})

SetCenterGun(16)

CIfEnd()

------<  OverCocoon  >------------------------------------------
-- Shapes --
I1a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-10,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),10,0))
I1b = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,-220)
I1c = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,200)
CNA1 = CS_OverlapX(I1a,I1b,I1c)

I2a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-50,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),50,0))
I2b = CS_MoveXY(CSMakeLine(2,25,90,13,0),0,-220)
I2c = CS_MoveXY(CSMakeLine(2,25,90,13,0),0,200)
CNA2 = CS_OverlapX(I2a,I2b,I2c)

I3a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-90,0),CSMakeLine(2,40,0,10,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),90,0))
I3b = CS_MoveXY(CSMakeLine(2,30,90,13,0),0,-220)
I3c = CS_MoveXY(CSMakeLine(2,30,90,13,0),0,200)
CNA3 = CS_OverlapX(I3a,I3b,I3c) -- 세로:420, 가로: 420

I4a = CS_MoveXY(CSMakeLine(2,40,0,10,0),0,0)
I4b = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,-220)
I4c = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,200)
I4 = CS_MoveXY(CS_OverlapX(I4a,I4b,I4c),-220,0)
I4A = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),50,200)
CNA4 = CS_MoveXY(CS_OverlapX(I4A,I4),100,0)

I5a = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),-50,200)
I5b = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,19,1),CSMakeLine(1,30,-15,19,0)),-50,300)
CNA5 = CS_OverlapX(I5a,I5b)

I6a = CS_MoveXY(CSMakeLine(2,40,0,10,0),0,0)
I6b = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,-220)
I6c = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,200)
I6 = CS_MoveXY(CS_OverlapX(I6a,I6b,I6c),220,0)
I6A = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),-50,200)
CNA6 = CS_MoveXY(CS_OverlapX(I6A,I6),-100,0)

I7a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-45,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),45,0))
I7b = CS_MoveXY(CSMakeLine(2,20,90,11,0),0,-220)
I7c = CS_MoveXY(CSMakeLine(2,20,90,11,0),0,200)
I7 = CS_MoveXY(CS_OverlapX(I7a,I7b,I7c),220,0)
I7A = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),-50,200)
CNA7 = CS_MoveXY(CS_OverlapX(I7A,I7),-100,0)

I8a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-70,0),CSMakeLine(2,40,0,10,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),70,0))
I8b = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,-220)
I8c = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,200)
I8 = CS_MoveXY(CS_OverlapX(I8a,I8b,I8c),220,0)
I8A = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),-70,200)
CNA8 = CS_MoveXY(CS_OverlapX(I8A,I8),-100,0)

I9a = CS_MoveXY(CSMakeLine(2,40,0,10,0),0,0)
I9b = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,-220)
I9c = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,200)
I9 = CS_MoveXY(CS_OverlapX(I9a,I9b,I9c),-200,0)
I9A = CS_MoveXY(CS_OverlapX(CSMakeLine(2,30,20,16,0),CSMakeLine(2,30,-20,16,0)),50,-10)
CNA9 = CS_MoveXY(CS_OverlapX(I9A,I9),100,0)

I10 = CS_MoveXY(CS_OverlapX(CSMakeLine(2,30,35,16,0),CSMakeLine(2,30,-35,16,0)),50,40)
I10A = CS_MoveXY(CS_OverlapX(CSMakeLine(2,30,35,16,0),CSMakeLine(2,30,-35,16,0)),50,-10)
CNA10 = CS_OverlapX(I10A,I10)

I11a = CS_MoveXY(CSMakeLine(2,40,0,10,0),0,0)
I11b = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,-220)
I11c = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,200)
I11 = CS_MoveXY(CS_OverlapX(I11a,I11b,I11c),200,0)
I11A = CS_MoveXY(CS_OverlapX(CSMakeLine(2,30,20,16,0),CSMakeLine(2,30,-20,16,0)),-50,-10)
CNA11 = CS_MoveXY(CS_OverlapX(I11A,I11),-100,0)

I12a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-40,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),40,0))
I12b = CS_MoveXY(CSMakeLine(2,20,90,11,0),0,-220)
I12c = CS_MoveXY(CSMakeLine(2,20,90,11,0),0,200)
I12 = CS_MoveXY(CS_OverlapX(I12a,I12b,I12c),200,0)
I12A = CS_MoveXY(CS_OverlapX(CSMakeLine(2,30,20,16,0),CSMakeLine(2,30,-20,16,0)),-50,-10)
CNA12 = CS_MoveXY(CS_OverlapX(I12A,I12),-100,0)

function Warping_UFunc(X,Data)
	return 64*math.sin(math.rad(X))+Data[2][1] -- +Ymax
end
function Warping_DFunc(X,Data)
	return 64*math.sin(math.rad(X))+Data[2][2] -- +Ymin
end
function Warping_RFunc(Y,Data)
	return 64*math.sin(math.rad(Y))+Data[1][1] -- +Xmax
end
function Warping_LFunc(Y,Data)
	return 64*math.sin(math.rad(Y))+Data[1][2] -- +Xmin
end
function Coon_Vector(X,Y) return {X+Y,X-Y} end
CNB1 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(3,150,64,0,CS_Level("Star",3,3),0),64*2,0),CS_MoveXY(CSMakeStar(8,120,48,0,CS_Level("Star",8,3),0),-64*1,0)),1,"Coon_Vector")
CNB2 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(4,140,64,0,CS_Level("Star",4,3),0),64*2,0),CS_MoveXY(CSMakeStar(7,125,48,0,CS_Level("Star",7,3),0),-64*1,0)),1,"Coon_Vector")
CNB3 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(5,135,64,0,CS_Level("Star",5,3),0),64*2,0),CS_MoveXY(CSMakeStar(6,130,48,0,CS_Level("Star",6,3),0),-64*1,0)),1,"Coon_Vector")
CNB4 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(6,130,64,0,CS_Level("Star",6,3),0),64*2,0),CS_MoveXY(CSMakeStar(5,135,48,0,CS_Level("Star",5,3),0),-64*1,0)),1,"Coon_Vector")
CNB5 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(7,125,64,0,CS_Level("Star",7,3),0),64*2,0),CS_MoveXY(CSMakeStar(4,140,48,0,CS_Level("Star",4,3),0),-64*1,0)),1,"Coon_Vector")
CNB6 = CS_Vector2D(CS_OverlapX(CS_MoveXY(CSMakeStar(8,120,64,0,CS_Level("Star",8,3),0),64*2,0),CS_MoveXY(CSMakeStar(3,150,48,0,CS_Level("Star",3,3),0),-64*1,0)),1,"Coon_Vector")
CNB7 = CS_Warping(CNB1,"Warping_UFunc","Warping_DFunc")
CNB8 = CS_Warping(CNB2,"Warping_UFunc","Warping_DFunc")
CNB9 = CS_Warping(CNB3,"Warping_UFunc","Warping_DFunc")
CNB10 = CS_Warping(CNB4,nil,nil,"Warping_LFunc","Warping_RFunc")
CNB11 = CS_Warping(CNB5,nil,nil,"Warping_LFunc","Warping_RFunc")
CNB12 = CS_Warping(CNB6,nil,nil,"Warping_LFunc","Warping_RFunc")

Base_CoonCD = CS_RatioXY(CS_ConnectPathX(CS_RatioXY({4,{-1/math.sqrt(2),-1/math.sqrt(2)},{0,1},{1/math.sqrt(2),-1/math.sqrt(2)},{0,0}},320,320),50,1),1,0.6)
CNC1 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),"Warping_UFunc")
CNC2 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,"Warping_DFunc")
CNC3 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,nil,"Warping_LFunc")
CNC4 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,nil,nil,"Warping_RFunc")
CNC5 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),"Warping_UFunc","Warping_DFunc")
CNC6 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),"Warping_UFunc",nil,"Warping_LFunc")
CNC7 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),"Warping_UFunc",nil,nil,"Warping_RFunc")
CNC8 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,"Warping_DFunc")
CNC9 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,"Warping_DFunc","Warping_LFunc")
CNC10 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,"Warping_DFunc",nil,"Warping_RFunc")
CNC11 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),nil,nil,"Warping_LFunc","Warping_RFunc")
CNC12 = CS_Warping(CS_Rotate(CS_MoveXY(Base_CoonCD,0,128),90),"Warping_UFunc","Warping_DFunc","Warping_LFunc","Warping_RFunc")
CNLine = CSMakeLineX(2,512+128,0,2,0)

CoonShapesArr = {CNA1,CNA2,CNA3,CNA4,CNA5,CNA6,CNA7,CNA8,CNA9,CNA10,CNA11,CNA12,
				CNB1,CNB2,CNB3,CNB4,CNB5,CNB6,CNB7,CNB8,CNB9,CNB10,CNB11,CNB12,
				CNC1,CNC2,CNC3,CNC4,CNC5,CNC6,CNC7,CNC8,CNC9,CNC10,CNC11,CNC12,
				CNLine}

OC_Shapes, OC_LoopLimit, OC_DataIndex, OCPosX, OCPosY, OC_Dot, OC_WaitTimer, OC_Angle, OC_AngleSub, CLocDest = CreateVars(10,FP)
AngleVArr = CreateVarArr(4,FP)
DataIndexVArr = CreateVarArr(4,FP)

--< CAFunc / CFunc >--
function OverCoonCAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CIfX(FP,{NVar(OC_Shapes,Exactly,#CoonShapesArr)}) -- Side
		CA_Rotate(OC_AngleSub)
	CElseX() -- Main
		CA_Rotate(OC_Angle)
	CIfXEnd()

end

Coon_CAPlot = InitCFunc(FP)
CFunc(Coon_CAPlot)
	CAPlot(CoonShapesArr,P6,193,"CLoc106",{OCPosX,OCPosY},1,32,
		{OC_Shapes,0,0,0,OC_LoopLimit,OC_DataIndex},"OverCoonCAFunc",FP,nil,{SetNext("X",0x5008),SetNext(0x5009,"X",1)})
CFuncEnd()

function SetCoonGun(X,Y,GunLevel,DestLoc,DestX,DestY) -- GunLevel 1 ~ 4

DoActionsX(FP,{SetNVar(OCPosX,SetTo,X),SetNVar(OCPosY,SetTo,Y),SetNVar(V(NextDot),SetTo,999),SetNVar(AngleVArr[GunLevel],Add,2)})

for i = 1, 12 do
CTrigger(FP,{CDeaths("X",Exactly,i-1,Stage),CDeaths("X",Exactly,0,Timer)},{ -- MainUnit Setting
    TSetNVar(Common_XUType,SetTo,UV[1]);
	TSetNVar(Common_UType,SetTo,UV[2]);
    SetNVar(OC_Shapes,SetTo,i+12*(GunLevel-1));
	SetNVar(OC_Angle,SetTo,30*i);
	SetNVar(OC_DataIndex,SetTo,1);
	SetNVar(OC_LoopLimit,SetTo,600);
    SetCDeaths("X",SetTo,180,Timer);
    SetCDeaths("X",SetTo,i,Stage);
	SetCVar("X",UType,SetTo,1*256,0xFF00); -- MainSW On
	SetCVar("X",UType,SetTo,0*65536,0xFF0000); -- Reset / 180 tik
})
end
TriggerX(FP,{CDeaths("X",Exactly,12,Stage)},{SetSwitch(GLock,Set)}) -- Lock

CIf(FP,{CVar("X",UType,Exactly,1*256,0xFF00)}) -- GunExecution
	CMov(FP,OC_Dot,V(UType)) -- Main -> Temp -> CJump
	CallCFuncX(FP,Coon_CAPlot) -- MainShape
	CMov(FP,V(UType),OC_Dot) -- CJump -> Temp -> Main

	SetLocCenter(GLoc,"CLoc76")
	DoActionsX(FP,{Simple_CalcLoc("CLoc76",-768,-768,768,768)})
	CDoActions(FP,{
		TOrder(UV[1],Force2,"CLoc76",Attack,"HZ");
		TOrder(UV[2],Force2,"CLoc76",Attack,"HZ");
	})
CIfEnd()

CDoActions(FP,{ -- SideEffect Setting
	TSetNVar(OC_AngleSub,SetTo,AngleVArr[GunLevel]);
	SetNVar(C_LocID,SetTo,ParseLocation(DestLoc));
	SetNVar(OC_DataIndex,SetTo,1);
	SetNVar(OC_LoopLimit,SetTo,600);
	SetNVar(OCPosX,SetTo,DestX);
	SetNVar(OCPosY,SetTo,DestY);
	SetNVar(OC_Shapes,SetTo,#CoonShapesArr);
	SetCVar("X",UType,SetTo,0*256,0xFF00); -- SideSW On
})

CMov(FP,OC_Dot,V(UType)) -- Main -> Temp -> CJump
CallCFuncX(FP,Coon_CAPlot) -- EFF Rotation ( Sub Shape )
CMov(FP,V(UType),OC_Dot) -- CJump -> Temp -> Main

TriggerX(FP,{CVar("X",GMode,Exactly,2),CVar("X",UType,Exactly,0,0xFF)},{SetCVar("X",UType,SetTo,34,0xFF)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3),CVar("X",UType,Exactly,0,0xFF)},{SetCVar("X",UType,SetTo,17,0xFF)},{Preserved})
CDoActions(FP,{
	--TSetMemory(_Add(_Mul(UV[2],4),EPD(0x662350)),SetTo,VArr(HPVArr,UV[2])); -- Recover Init HP
	--TSetMemory(_Add(_Mul(UV[3],4),EPD(0x662350)),SetTo,VArr(HPVArr,UV[3])); -- Recover Init HP
	SetCVar("X",UType,Subtract,1,0xFF);
	SetCDeaths("X",Subtract,1,Timer)})
end

CJump(FP,7)
SetLabel(0x5008)

CIfX(FP,{NVar(OC_Dot,Exactly,1*256,0xFF00)})
	CIfX(FP,{CVar("X",GMode,Exactly,1)})
		CTrigger(FP,{ -- MainUnit
			NVar(OC_Dot,Exactly,0*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[1],"CLoc106",P6);
			SetNVar(OC_Dot,SetTo,1*65536,0xFF0000);
		},{Preserved})
		CTrigger(FP,{ -- SubUnit
			NVar(OC_Dot,Exactly,1*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[2],"CLoc106",P7);
			SetNVar(OC_Dot,SetTo,0*65536,0xFF0000);
		},{Preserved})
	CElseIfX({CVar("X",GMode,Exactly,2)})
		CTrigger(FP,{ -- MainUnit
			NVar(OC_Dot,AtMost,15*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[1],"CLoc106",UPlayer);
			SetNVar(OC_Dot,Add,1*65536,0xFF0000);
		},{Preserved})
	SetNextptr()
		CTrigger(FP,{ -- SubUnit
			Memory(0x628438,AtLeast,1);
			NVar(OC_Dot,Exactly,16*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[2],"CLoc106",P8);
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
			TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
			TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			SetNVar(OC_Dot,SetTo,0*65536,0xFF0000);
		},{Preserved})
	CElseX() -- Lunatic
		CTrigger(FP,{ -- MainUnit
			NVar(OC_Dot,AtMost,11*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[1],"CLoc106",UPlayer);
			SetNVar(OC_Dot,Add,1*65536,0xFF0000);
		},{Preserved})
	SetNextptr()
		CTrigger(FP,{ -- SubUnit
			Memory(0x628438,AtLeast,1);
			CVar("X",GMode,AtLeast,2);
			NVar(OC_Dot,Exactly,12*65536,0xFF0000);
			NVar(OC_Dot,Exactly,0*16777216,0xFF000000);
		},{
			TCreateUnit(1,UV[2],"CLoc106",P8);
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
			TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
			TSetMemoryX(Vi(Nextptr[2],70),SetTo,127*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			SetNVar(OC_Dot,SetTo,0*65536,0xFF0000);
		},{Preserved})
	CIfXEnd()
CElseIfX({CVar("X",GMode,AtLeast,2),NVar(OC_Dot,Exactly,0*256,0xFF00)},{CreateUnit(1,84,"CLoc106",P5)})
	CIf(FP,{NVar(OC_Dot,Exactly,0,0xFF)})
		SetNextptr()
			CTrigger(FP,{ -- SideUnit
				Memory(0x628438,AtLeast,1);
				CVar("X",GMode,Exactly,2);
			},{
				TCreateUnit(1,UV[3],"CLoc106",P8);
				TSetMemory(Vi(Nextptr[2],2),SetTo,256*100000);
				TSetMemory(Vi(Nextptr[2],13),SetTo,640);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,50,0xFFFF);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
				TOrder(UV[3],P8,"CLoc106",Attack,C_LocID);
			},{Preserved})
			CTrigger(FP,{ -- SideUnit
				Memory(0x628438,AtLeast,1);
				CVar("X",GMode,Exactly,3);
			},{
				TCreateUnit(1,UV[3],"CLoc106",P8);
				TSetMemory(Vi(Nextptr[2],2),SetTo,256*150000);
				TSetMemory(Vi(Nextptr[2],13),SetTo,1707);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,67,0xFFFF);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
				TOrder(UV[3],P8,"CLoc106",Attack,C_LocID);
			},{Preserved})
	CIfEnd()
CIfXEnd()

DoActionsX(FP,{SetNVar(OC_Dot,SetTo,0*16777216,0xFF000000)})

SetLabel(0x5009)
CJumpEnd(FP,7)

------< Coon A >------------------------------------------
CA_GunPreset(P8,201,"Switch 85",55,"CoonA")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText2,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,16);
		SetNVar(BGMVar[1],SetTo,16);
		SetNVar(BGMVar[2],SetTo,16);
		SetNVar(BGMVar[3],SetTo,16);
		SetNVar(BGMVar[4],SetTo,16);
		SetNVar(BGMVar[5],SetTo,16);
		SetScore(Force1,Add,125000,Kills);
	})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,55),SetNVar(UV[2],SetTo,56),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,56),SetNVar(UV[2],SetTo,55),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,98),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,8),SetNVar(UV[3],SetTo,58),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,60),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,8),SetNVar(UV[3],SetTo,99),SetNVar(UPlayer,SetTo,6)},{Preserved})

SetCoonGun(1024,6567,1,"CoonA",1024,7321)

CIfEnd()
------< Coon B >------------------------------------------
CA_GunPreset(P8,201,"Switch 86",56,"CoonB")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText2,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,16);
		SetNVar(BGMVar[1],SetTo,16);
		SetNVar(BGMVar[2],SetTo,16);
		SetNVar(BGMVar[3],SetTo,16);
		SetNVar(BGMVar[4],SetTo,16);
		SetNVar(BGMVar[5],SetTo,16);
		SetScore(Force1,Add,125000,Kills);
	})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,70),SetNVar(UV[2],SetTo,56),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,56),SetNVar(UV[2],SetTo,70),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,86),SetNVar(UV[2],SetTo,27),SetNVar(UV[3],SetTo,60),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,12),SetNVar(UV[2],SetTo,27),SetNVar(UV[3],SetTo,28),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,86),SetNVar(UV[2],SetTo,102),SetNVar(UV[3],SetTo,99),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,12),SetNVar(UV[2],SetTo,102),SetNVar(UV[3],SetTo,99),SetNVar(UPlayer,SetTo,6)},{Preserved})

SetCoonGun(1024,5890,2,"CoonB",1024,5376)
CIfEnd()

------< Coon C >------------------------------------------
CA_GunPreset(P6,201,"Switch 87",57,"CoonC")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText2,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,16);
		SetNVar(BGMVar[1],SetTo,16);
		SetNVar(BGMVar[2],SetTo,16);
		SetNVar(BGMVar[3],SetTo,16);
		SetNVar(BGMVar[4],SetTo,16);
		SetNVar(BGMVar[5],SetTo,16);
		SetScore(Force1,Add,125000,Kills);
	})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,70),SetNVar(UV[2],SetTo,21),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,21),SetNVar(UV[2],SetTo,70),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,60),SetNVar(UV[3],SetTo,9),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,58),SetNVar(UV[2],SetTo,99),SetNVar(UV[3],SetTo,9),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,99),SetNVar(UV[3],SetTo,22),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,58),SetNVar(UV[2],SetTo,9),SetNVar(UV[3],SetTo,22),SetNVar(UPlayer,SetTo,6)},{Preserved})

SetCoonGun(383,860,3,"CoonC",1024,958)

CIfEnd()
------< Coon D >------------------------------------------
CA_GunPreset(P7,201,"Switch 88",58,"CoonD")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags() -- 현재건작러 저장
TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText2,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,16);
		SetNVar(BGMVar[1],SetTo,16);
		SetNVar(BGMVar[2],SetTo,16);
		SetNVar(BGMVar[3],SetTo,16);
		SetNVar(BGMVar[4],SetTo,16);
		SetNVar(BGMVar[5],SetTo,16);
		SetScore(Force1,Add,125000,Kills);
	})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,70),SetNVar(UV[2],SetTo,80),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,1)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,80),SetNVar(UV[2],SetTo,70),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,102),SetNVar(UV[3],SetTo,9),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,2)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,58),SetNVar(UV[2],SetTo,102),SetNVar(UV[3],SetTo,9),SetNVar(UPlayer,SetTo,6)},{Preserved})

TriggerX(FP,{CDeaths("X",AtMost,6,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,98),SetNVar(UV[2],SetTo,102),SetNVar(UV[3],SetTo,22),SetNVar(UPlayer,SetTo,5)},{Preserved})
TriggerX(FP,{CDeaths("X",AtLeast,7,Stage),CVar("X",GMode,Exactly,3)},{ -- UV[1] : Main // UV[2] : Sub // UV[3] : Side
	SetNVar(UV[1],SetTo,58),SetNVar(UV[2],SetTo,9),SetNVar(UV[3],SetTo,22),SetNVar(UPlayer,SetTo,6)},{Preserved})

SetCoonGun(1668,860,3,"CoonD",1024,958)

CIfEnd()

------< X'elnaga Temple >------------------------------------------
--< Vars >--
TempleShapes, TempleLoopLimit, TempleDataIndex, TPosX, TPosY = CreateVars(5,FP)
--< Shapes >--

function Sort_X3Func(X)
	return {math.abs(X)}
end

function SortY_Abs(Y)
	return {math.abs(Y)}
end

function Sort_X4Func(R,A)
	return {math.abs(R),math.abs(A)}
end
function Sort_X1AFunc(R,A)
	return {math.abs((512+128*1)/2-R)} -- 2차정렬
end
function Sort_X1BFunc(R,A)
	return {math.abs((512+128*2)/2-R)} -- 2차정렬
end
function Sort_X1CFunc(R,A)
	return {math.abs((512+128*3)/2-R)} -- 2차정렬
end

function SHBF(Y) return Y end

SHX1A = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*1},135,64,"SHBF",0),180+22.5),"Sort_X1AFunc",nil,1)
SHX1B = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*2},135,64,"SHBF",0),180+22.5),"Sort_X1BFunc",nil,1)
SHX1C = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*3},135,64,"SHBF",0),180+22.5),"Sort_X1CFunc",nil,1)

SHX2A = CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*1},135,64,"SHBF",0),180+22.5),"Sort_X1AFunc",nil,0)
SHX2B = CS_Rotate(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*2},135,64,"SHBF",0),180+22.5),"Sort_X1BFunc",nil,0),180)
SHX2C = CS_MoveXY(CS_SortRA(CS_Rotate(CS_FillGradR(0,{0,512+128*3},135,64,"SHBF",0),180+22.5),"Sort_X1CFunc",nil,0),0,-256)

SHX3A = CS_SortXY(CSMakePolygonX(4,64,0,CS_Level("PolygonX",4,4),0),"Sort_X3Func",nil,1) -- Descending
SHX3B = CS_SortXY(CSMakePolygonX(5,64,0,CS_Level("PolygonX",5,5),0),"Sort_X3Func",nil,1)
SHX3C = CS_SortXY(CSMakePolygonX(5,64,0,CS_Level("PolygonX",5,6),0),"Sort_X3Func",nil,1) -- Descending

SHX4A = CS_SortRA(CSMakeCircleX(4,64,0,CS_Level("CircleX",4,4),0),"Sort_X4Func",{0},1)
SHX4B = CS_SortRA(CSMakeCircleX(5,64,0,CS_Level("CircleX",5,5),0),"Sort_X4Func",{0},1)
SHX4C = CS_SortRA(CSMakeCircleX(5,64,0,CS_Level("CircleX",5,6),0),"Sort_X4Func",{0},1)

X1SubA = CSMakeCircle(6,64,0,CS_Level("Circle",6,2),6+1)
X1SubB = CSMakeCircle(6,48,0,CS_Level("Circle",6,2),0)
X1SubC = CSMakeCircle(6,32,0,CS_Level("Circle",6,3),0)

X2SubA = CSMakeLine(2,128,0,9,0)
X2SubB = CSMakeLine(2,96,0,13,0)
X2SubC = CSMakeLine(2,64,0,17,0)

X3SubA = CSMakeLine(3,96,0,CS_Level("Line",3,3),0)
X3SubB = CSMakeLine(4,96,45,CS_Level("Line",4,3),0)
X3SubC = CSMakeLine(5,96,0,CS_Level("Line",5,3),0)

X4SubA = X3SubA
X4SubB = X3SubB
X4SubC = X3SubC

SH_X1SubA = CS_OverlapX(CS_MoveXY(X1SubA,-128*3,-128*4),CS_MoveXY(X1SubA,128*3,-128*4),CS_MoveXY(X1SubA,0,-128*5))
SH_X1SubB = CS_OverlapX(CS_MoveXY(X1SubB,-128*3,-128*4),CS_MoveXY(X1SubB,128*3,-128*4),CS_MoveXY(X1SubB,0,-128*5))
SH_X1SubC = CS_OverlapX(CS_MoveXY(X1SubC,-128*3,-128*4),CS_MoveXY(X1SubC,128*3,-128*4),CS_MoveXY(X1SubC,0,-128*5))

SH_X2SubA = CS_OverlapX(CS_MoveXY(X2SubA,-128*2,0),CS_MoveXY(X2SubA,128*2,0),CS_MoveXY(X2SubA,-128*3,128),CS_MoveXY(X2SubA,128*3,-128))
SH_X2SubB = CS_OverlapX(CS_MoveXY(X2SubB,-128*2,0),CS_MoveXY(X2SubB,128*2,0),CS_MoveXY(X2SubB,-128*3,96),CS_MoveXY(X2SubB,128*3,-96))
SH_X2SubC = CS_OverlapX(CS_MoveXY(X2SubC,-128*2,0),CS_MoveXY(X2SubC,128*2,0),CS_MoveXY(X2SubC,-128*3,64),CS_MoveXY(X2SubC,128*3,-64))

SH_X3SubA = CS_OverlapX(CS_MoveXY(X3SubA,0,128*4),CS_MoveXY(X3SubA,128*7,0))
SH_X3SubB = CS_OverlapX(CS_MoveXY(X3SubB,0,128*4),CS_MoveXY(X3SubB,128*7,0))
SH_X3SubC = CS_OverlapX(CS_MoveXY(X3SubC,0,128*4),CS_MoveXY(X3SubC,128*7,0))

SH_X4SubA = CS_OverlapX(CS_MoveXY(X4SubA,0,128*4),CS_MoveXY(X4SubA,-128*7,0))
SH_X4SubB = CS_OverlapX(CS_MoveXY(X4SubB,0,128*4),CS_MoveXY(X4SubB,-128*7,0))
SH_X4SubC = CS_OverlapX(CS_MoveXY(X4SubC,0,128*4),CS_MoveXY(X4SubC,-128*7,0))

TempleShapeArr = {SHX1A,SHX1B,SHX1C,SH_X1SubA,SH_X1SubB,SH_X1SubC,SHX2A,SHX2B,SHX2C,SH_X2SubA,SH_X2SubB,SH_X2SubC,
			SHX3A,SHX3B,SHX3C,SH_X3SubA,SH_X3SubB,SH_X3SubC,SHX4A,SHX4B,SHX4C,SH_X4SubA,SH_X4SubB,SH_X4SubC}
--< CAPlot CFunc >--
function TempleCAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
end

XTemple_CAPlot = InitCFunc(FP)
CFunc(XTemple_CAPlot)
	CAPlot(TempleShapeArr,P6,193,"CLoc106",{TPosX,TPosY},1,32,
		{TempleShapes,0,0,0,TempleLoopLimit,TempleDataIndex},"TempleCAFunc",FP,nil,{SetNext("X",0x5010),SetNext(0x5011,"X",1)})
CFuncEnd()

-- 유닛생성단락 --
CJump(FP,8)
SetLabel(0x5010)

CIfX(FP,CVar("X",GMode,AtLeast,2))
		CIfX(FP,{CDeaths("X",Exactly,0,VInput)}) -- Individual X
			SetNextptr()
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
					TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
					TSetMemory(Vi(Nextptr[2],13),SetTo,444);
					TOrder(Common_UType,UPlayer,"CLoc106",Attack,C_LocID);
					CreateUnit(1,84,"CLoc106",P5);
				},{Preserved})
		CElseIfX({CDeaths("X",AtLeast,1,VInput)}) -- Individual O
					SetNextptr()
						CTrigger(FP,{Memory(0x628438,AtLeast,1)},{ -- 개별 MainShape
							TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
							TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
							TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
							TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
							TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
							TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
							TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
							TOrder(Common_UType,UPlayer,"CLoc106",Attack,C_LocID);
						},{Preserved})
						CIfX(FP,{CDeathsX("X",Exactly,0*256,VInput,0xFF00)})
							--CMov(FP,UIDVar,Common_UType,0,0xFFFF)
							--CallTrigger(FP,SetGUnitHP)
							CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
								--TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
								TSetMemory(Vi(Nextptr[2],13),SetTo,444);
								CreateUnit(1,84,"CLoc106",P5);
							},{Preserved})
						CElseIfX({CDeathsX("X",Exactly,1*256,VInput,0xFF00)}) -- SubUnit
							CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
								TSetMemoryX(Vi(Nextptr[2],69),SetTo,255*256,0xFF00);
								TSetMemory(Vi(Nextptr[2],13),SetTo,0); -- MaxSpeed
							},{Preserved})
						CIfXEnd()
		CIfXEnd()
CElseX() -- Normal
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
				TOrder(Common_UType,UPlayer,"CLoc106",Attack,"HZ");
			},{Preserved})
		CTrigger(FP,{Memory(0x628438,AtLeast,1),CDeathsX("X",Exactly,0*256,VInput,0xFF00)},{
			TSetMemory(Vi(Nextptr[2],13),SetTo,444);
			CreateUnit(1,84,"CLoc106",P5);
		},{Preserved})
CIfXEnd()
DoActionsX(FP,{SetNVar(Common_UType,Subtract,1*16777216,0xFF000000)})

SetLabel(0x5011) -- XTemple
----------------------------------------------------------
SetLabel(0x5012) -- Temple
DoActions(FP,{SetMemoryB(0x663150+25,SetTo,12),SetMemoryX(0x664080+25*4,SetTo,0x4,0x4)})
CIfX(FP,{CVar("X",GMode,Exactly,1)})
	CTrigger(FP,{CDeaths("X",Exactly,0,VInput)},{
		TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
		TOrder(Common_UType,UPlayer,"CLoc106",Attack,"HZ");
		CreateUnit(1,84,"CLoc106",P5);
	},{Preserved})
	CTrigger(FP,{CDeaths("X",Exactly,1,VInput)},{
		TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
		TOrder(Common_UType,UPlayer,"CLoc106",Attack,"HZ");
	},{Preserved})
CElseX() -- {CVar("X",GMode,AtLeast,2)}
	CIfX(FP,{CDeaths("X",Exactly,0,VInput)})
		CDoActions(FP,{TCreateUnit(1,Common_UType,"CLoc106",UPlayer),CreateUnit(1,84,"CLoc106",P5),TOrder(Common_UType,UPlayer,"CLoc106",Attack,"HZ");})
	CElseX() -- CDeaths("X",Exactly,1,VInput)
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
			TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
			TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
			TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
			TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			TOrder(Common_UType,UPlayer,"CLoc106",Attack,"T1");
		},{Preserved})
	CIfXEnd()
CIfXEnd()
DoActions(FP,{SetMemoryB(0x663150+25,SetTo,4),SetMemoryX(0x664080+25*4,SetTo,0,0x4)})
SetLabel(0x5013)
CJumpEnd(FP,8)

function SetTempleGun(ShapeNumber)
DoActionsX(FP,{SetNVar(TPosX,SetTo,GCenter[1]),SetNVar(TPosY,SetTo,GCenter[2])}) -- X,Y 고정좌표세팅
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber-5)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber-4)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber-3)},{Preserved})
	TriggerX(FP,{
		CDeaths("X",Exactly,0,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
		SetCDeaths("X",SetTo,1,Stage);
		SetCDeaths("X",SetTo,1,Timer);
	})
TriggerX(FP,{
		CDeaths("X",Exactly,1,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetCVar("X",UType,SetTo,191,0xFFFF); -- Main1
		SetCDeaths("X",SetTo,2,Stage);
		SetCDeaths("X",SetTo,34*10,Timer); -- WaitTimer
	})
TriggerX(FP,{
	CDeaths("X",Exactly,2,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,2); -- Add DataIndex
	SetNVar(TempleLoopLimit,SetTo,2); -- 2 point / tik
},{Preserved})
TriggerX(FP,{
		CDeaths("X",Exactly,2,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetCVar("X",UType,SetTo,192,0xFFFF); -- Main2
		SetCDeaths("X",SetTo,3,Stage);
		SetCDeaths("X",SetTo,34*10,Timer); -- WaitTimer
	})
TriggerX(FP,{
	CDeaths("X",Exactly,3,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,2); -- Add DataIndex
	SetNVar(TempleLoopLimit,SetTo,2); -- 2 point / tik
},{Preserved})
TriggerX(FP,{
	CDeaths("X",Exactly,3,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
	SetCVar("X",UType,SetTo,193,0xFFFF); -- Main3
	SetCDeaths("X",SetTo,4,Stage);
	SetCDeaths("X",SetTo,34*5,Timer);
})
TriggerX(FP,{
	CDeaths("X",Exactly,4,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,2); -- Add DataIndex
	SetNVar(TempleLoopLimit,SetTo,2); -- 2 point / tik
},{Preserved})
CIf(FP,{CDeaths("X",Exactly,4,Stage),CDeaths("X",Exactly,0,Timer)})
	TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber-2)})
	TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber-1)})
	TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(TempleShapes,SetTo,6*ShapeNumber)})
	DoActionsX(FP,{
		SetCDeaths("X",SetTo,5,Stage);
		SetCVar("X",NextDot,SetTo,0); -- DataIndex Reset
		SetCVar("X",UType,SetTo,194,0xFFFF); -- Sub
		SetNVar(TempleLoopLimit,SetTo,600);
		SetSwitch(GLock,Set);
	})
CIfEnd()

-----------------------------------------

CIfX(FP,{CVar("X",UType,Exactly,191,0xFFFF)}) -- MainUnit
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,8*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(Common_UType,SetTo,UV[1]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,9*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[2]);
		SetCDeaths("X",SetTo,1,VInput);
	},{Preserved})
CElseIfX({CVar("X",UType,Exactly,192,0xFFFF)})
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,8*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,6);
		TSetNVar(Common_UType,SetTo,UV[3]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,9*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[4]);
		SetCDeaths("X",SetTo,1,VInput);
	},{Preserved})
CElseIfX({CVar("X",UType,Exactly,193,0xFFFF)})
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,AtMost,8*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,Add,1*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(Common_UType,SetTo,UV[5]);
	},{Preserved})
	CTrigger(FP,{
		CVar("X",UType,Exactly,0,0xFF000000);
		CVar("X",UType,Exactly,9*65536,0xFF0000);
	},{
		SetCVar("X",UType,SetTo,16777216,0xFF000000);
		SetCVar("X",UType,SetTo,0*65536,0xFF0000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[6]);
		SetCDeaths("X",SetTo,1,VInput);
	},{Preserved})
CElseIfX({CVar("X",UType,Exactly,194,0xFFFF)}) -- Sub
	CTrigger(FP,{CVar("X",GMode,Exactly,1)},{SetCVar("X",NextDot,SetTo,600)}) -- DataIndex Reset})
	CTrigger(FP,{CVar("X",GMode,AtLeast,2)},{SetNVar(UPlayer,SetTo,7),TSetNVar(Common_UType,SetTo,UV[7]),SetCDeathsX("X",SetTo,1*256,VInput,0xFF00)})
CIfXEnd()

CMov(FP,TempleDataIndex,V(NextDot)) -- 현재건작 데이터인덱스 저장
CallCFuncX(FP,XTemple_CAPlot)

DoActionsX(FP,{
	SetCDeaths("X",Subtract,1,Timer);
	SetCDeaths("X",SetTo,0,VInput);
	SetCVar("X",UType,Subtract,1*16777216,0xFF000000);
})
end

------< X1 >------------------------------------------
GCenter = {1024,7320}
CA_GunPreset(P8,175,"Switch 89",59,"X1")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"X1")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText6,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,14);
		SetNVar(BGMVar[1],SetTo,14);
		SetNVar(BGMVar[2],SetTo,14);
		SetNVar(BGMVar[3],SetTo,14);
		SetNVar(BGMVar[4],SetTo,14);
		SetNVar(BGMVar[5],SetTo,14);
		SetScore(Force1,Add,200000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,56);SetNVar(UV[2],SetTo,80);
	SetNVar(UV[3],SetTo,56);SetNVar(UV[4],SetTo,21);
	SetNVar(UV[5],SetTo,56);SetNVar(UV[6],SetTo,80);
	SetNVar(UV[7],SetTo,21);SetNVar(C_LocID,SetTo,ParseLocation("HZ"));
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,98);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,58);
	SetNVar(UV[5],SetTo,12);SetNVar(UV[6],SetTo,27);
	SetNVar(UV[7],SetTo,25);SetNVar(C_LocID,SetTo,ParseLocation("HZ"));
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,88);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,8);
	SetNVar(UV[5],SetTo,12);SetNVar(UV[6],SetTo,28);
	SetNVar(UV[7],SetTo,69);SetNVar(C_LocID,SetTo,ParseLocation("HZ"));
},{Preserved})

SetTempleGun(1)
CIfEnd()

------< X2 >------------------------------------------
GCenter = {1024,5166}
CA_GunPreset(P8,175,"Switch 90",60,"X2")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"X2")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText6,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,14);
		SetNVar(BGMVar[1],SetTo,14);
		SetNVar(BGMVar[2],SetTo,14);
		SetNVar(BGMVar[3],SetTo,14);
		SetNVar(BGMVar[4],SetTo,14);
		SetNVar(BGMVar[5],SetTo,14);
		SetScore(Force1,Add,200000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,70);SetNVar(UV[2],SetTo,12);
	SetNVar(UV[3],SetTo,70);SetNVar(UV[4],SetTo,86);
	SetNVar(UV[5],SetTo,70);SetNVar(UV[6],SetTo,12);
	SetNVar(UV[7],SetTo,86);SetNVar(C_LocID,SetTo,ParseLocation("HZ"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,88);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,8);
	SetNVar(UV[5],SetTo,86);SetNVar(UV[6],SetTo,28);
	SetNVar(UV[7],SetTo,69);SetNVar(C_LocID,SetTo,ParseLocation("M3"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,60);
	SetNVar(UV[3],SetTo,21);SetNVar(UV[4],SetTo,28);
	SetNVar(UV[5],SetTo,58);SetNVar(UV[6],SetTo,99);
	SetNVar(UV[7],SetTo,30);SetNVar(C_LocID,SetTo,ParseLocation("G1"))
},{Preserved})

SetTempleGun(2)
CIfEnd()

------< X3 >------------------------------------------
GCenter = {576,2870}
CA_GunPreset(P6,175,"Switch 91",61,"X3")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"X3")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText6,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,14);
		SetNVar(BGMVar[1],SetTo,14);
		SetNVar(BGMVar[2],SetTo,14);
		SetNVar(BGMVar[3],SetTo,14);
		SetNVar(BGMVar[4],SetTo,14);
		SetNVar(BGMVar[5],SetTo,14);
		SetScore(Force1,Add,200000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,98);SetNVar(UV[2],SetTo,28);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,28);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,28);
	SetNVar(UV[7],SetTo,86);SetNVar(C_LocID,SetTo,ParseLocation("HZ"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,98);SetNVar(UV[2],SetTo,102);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,102);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,102);
	SetNVar(UV[7],SetTo,30);SetNVar(C_LocID,SetTo,ParseLocation("H13"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,98);SetNVar(UV[2],SetTo,9);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,99);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,9);
	SetNVar(UV[7],SetTo,9);SetNVar(C_LocID,SetTo,ParseLocation("H14"))
},{Preserved})

SetTempleGun(3)
CIfEnd()
------< X4 >------------------------------------------
GCenter = {1475,2866}
CA_GunPreset(P7,175,"Switch 92",62,"X4")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"X4")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText6,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,14);
		SetNVar(BGMVar[1],SetTo,14);
		SetNVar(BGMVar[2],SetTo,14);
		SetNVar(BGMVar[3],SetTo,14);
		SetNVar(BGMVar[4],SetTo,14);
		SetNVar(BGMVar[5],SetTo,14);
		SetScore(Force1,Add,200000,Kills);
	})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(UV[1],SetTo,98);SetNVar(UV[2],SetTo,28);
	SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,28);
	SetNVar(UV[5],SetTo,98);SetNVar(UV[6],SetTo,28);
	SetNVar(UV[7],SetTo,86);SetNVar(C_LocID,SetTo,ParseLocation("HZ"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(UV[1],SetTo,58);SetNVar(UV[2],SetTo,102);
	SetNVar(UV[3],SetTo,27);SetNVar(UV[4],SetTo,102);
	SetNVar(UV[5],SetTo,58);SetNVar(UV[6],SetTo,102);
	SetNVar(UV[7],SetTo,30);SetNVar(C_LocID,SetTo,ParseLocation("H14"))
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(UV[1],SetTo,58);SetNVar(UV[2],SetTo,99);
	SetNVar(UV[3],SetTo,27);SetNVar(UV[4],SetTo,9);
	SetNVar(UV[5],SetTo,58);SetNVar(UV[6],SetTo,99);
	SetNVar(UV[7],SetTo,9);SetNVar(C_LocID,SetTo,ParseLocation("H13"))
},{Preserved})

SetTempleGun(4)
CIfEnd()
------< Temple >------------------------------------------
-- Sorting --
function Sort_TAFunc(I)
	return {math.fmod(I,SHTA[1]/2),I} -- 1차정렬 : 2로나눈 나머지값이 같은 인덱스끼리정렬 // 2차정렬 : 인덱스 작은순서로 정렬
end
function Sort_TBFunc(I)
	return {math.fmod(I,SHTB[1]/2),I} -- 1차정렬 : 2로나눈 나머지값이 같은 인덱스끼리정렬 // 2차정렬 : 인덱스 작은순서로 정렬
end
function Sort_TCFunc(I)
	return {math.fmod(I,SHTC[1]/2),I} -- 1차정렬 : 2로나눈 나머지값이 같은 인덱스끼리정렬 // 2차정렬 : 인덱스 작은순서로 정렬
end
-- Base --
SHTA = CSMakePolygonX(4,74,0,CS_Level("PolygonX",4,3),CS_Level("PolygonX",4,2))
SHTB = CSMakePolygonX(4,44,0,CS_Level("PolygonX",4,5),CS_Level("PolygonX",4,4))
SHTC = CSMakePolygonX(4,32,0,CS_Level("PolygonX",4,7),CS_Level("PolygonX",4,6))

SH_TA = CS_SortI(CS_SortA(SHTA,0),"Sort_TAFunc",{0},{0,1})
SH_TB = CS_SortI(CS_SortA(SHTB,0),"Sort_TBFunc",{0},{0,1})
SH_TC = CS_SortI(CS_SortA(SHTC,0),"Sort_TCFunc",{0},{0,1})
-- Main Shapes --
SH_TA1 = CS_RatioXY(CS_SortI(CS_SortA(SHTA,0),"Sort_TCFunc",{0},{0,1}),1.8,0.9) 
SH_TA2 = CS_RatioXY(CS_SortI(CS_SortA(SHTA,0),"Sort_TCFunc",{0},{0,1}),2.4,1.2)
SH_TA3 = CS_RatioXY(CS_SortI(CS_SortA(SHTA,0),"Sort_TCFunc",{0},{0,1}),3,1.5)
SH_TMainA = CS_OverlapX(SH_TA1,SH_TA2,SH_TA3) --64

SH_TB1 = CS_RatioXY(CS_SortI(CS_SortA(SHTB,0),"Sort_TCFunc",{0},{0,1}),1.8,0.9)
SH_TB2 = CS_RatioXY(CS_SortI(CS_SortA(SHTB,0),"Sort_TCFunc",{0},{0,1}),2.4,1.2)
SH_TB3 = CS_RatioXY(CS_SortI(CS_SortA(SHTB,0),"Sort_TCFunc",{0},{0,1}),3,1.5)
SH_TMainB = CS_OverlapX(SH_TB1,SH_TB2,SH_TB3) --112

SH_TC1 = CS_RatioXY(CS_SortI(CS_SortA(SHTC,0),"Sort_TCFunc",{0},{0,1}),1.8,0.9)
SH_TC2 = CS_RatioXY(CS_SortI(CS_SortA(SHTC,0),"Sort_TCFunc",{0},{0,1}),2.4,1.2)
SH_TC3 = CS_RatioXY(CS_SortI(CS_SortA(SHTC,0),"Sort_TCFunc",{0},{0,1}),3,1.5)
SH_TMainC = CS_OverlapX(SH_TC1,SH_TC2,SH_TC3) --160
-- Sub Shapes --
SH_TAArc = CS_CompassC({0,0}, 128*6, 180+22.5, 360-22.5, 0, 12)
SH_TBArc = CS_CompassC({0,0}, 128*6, 180+22.5, 360-22.5, 0, 18)
SH_TCArc = CS_CompassC({0,0}, 128*6, 135+22.5, 315-22.5, 0, 24)

CenterTempA = CS_FillPathXY(CSMakePath({-128*2,0},{0,128},{128*2,0},{0,-128}),1,64,64)
CenterTempB = CS_FillPathXY(CSMakePath({-128*2,0},{0,128},{128*2,0},{0,-128}),1,64,64)
CenterTempC = CS_FillPathXY(CSMakePath({-128*2,0},{0,128},{128*2,0},{0,-128}),1,64,64)

SH_TCenterA = CS_OverlapX(CenterTempA,CS_MoveXY(CenterTempA,-128*4,128*2),CS_MoveXY(CenterTempA,128*4,128*2))
SH_TCenterB = CS_OverlapX(CenterTempB,CS_MoveXY(CenterTempB,-128*4,128*2),CS_MoveXY(CenterTempB,128*4,128*2))
SH_TCenterC = CS_OverlapX(CenterTempC,CS_MoveXY(CenterTempC,-128*4,128*2),CS_MoveXY(CenterTempC,128*4,128*2))

TempleShapeArr2 = {SH_TMainA,SH_TCenterA,SH_TAArc,SH_TMainB,SH_TCenterB,SH_TBArc,SH_TMainC,SH_TCenterC,SH_TCArc}
------< T1 >------------------------------------------
--Vars--
Temple2_Shapes, Temple2_LoopLimit, Temple2_DataIndex, CycleCounting = CreateVars(4,FP)
GCenter = {1024,2607}
CA_GunPreset(P8,174,"Switch 93",63,"T1")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"T1")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText11,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,3);
		SetNVar(BGMVar[1],SetTo,3);
		SetNVar(BGMVar[2],SetTo,3);
		SetNVar(BGMVar[3],SetTo,3);
		SetNVar(BGMVar[4],SetTo,3);
		SetNVar(BGMVar[5],SetTo,3);
		SetScore(Force1,Add,250000,Kills);
	})
DoActionsX(FP,{SetNVar(TPosX,SetTo,GCenter[1]),SetNVar(TPosY,SetTo,GCenter[2])}) -- X,Y 고정좌표세팅
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(V(SType),SetTo,1);SetNVar(CycleCounting,SetTo,SH_TMainA[1]/2);
	SetNVar(UV[1],SetTo,80);SetNVar(UV[2],SetTo,21);SetNVar(UV[3],SetTo,12);SetNVar(UV[4],SetTo,25);SetNVar(UV[5],SetTo,28);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(V(SType),SetTo,4),SetNVar(CycleCounting,SetTo,SH_TMainB[1]/2);
	SetNVar(UV[1],SetTo,98);SetNVar(UV[2],SetTo,58);SetNVar(UV[3],SetTo,86);SetNVar(UV[4],SetTo,25);SetNVar(UV[5],SetTo,99);
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(V(SType),SetTo,7),SetNVar(CycleCounting,SetTo,SH_TMainC[1]/2);
	SetNVar(UV[1],SetTo,88);SetNVar(UV[2],SetTo,8);SetNVar(UV[3],SetTo,60);SetNVar(UV[4],SetTo,69);SetNVar(UV[5],SetTo,9);
},{Preserved})
TriggerX(FP,{
		CDeaths("X",Exactly,0,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
		SetCDeaths("X",SetTo,1,Stage);
		SetCDeaths("X",SetTo,1,Timer);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,1,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		TSetNVar(Common_UType,SetTo,UV[1]);
		TSetNVar(Temple2_Shapes,SetTo,V(SType)); -- Main
		SetCDeaths("X",SetTo,2,Stage);
		TSetCDeaths("X",SetTo,CycleCounting,Timer); -- WaitTimer
	})
CTrigger(FP,{
		CDeaths("X",Exactly,2,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,Add,2); -- Add DataIndex
		SetNVar(UPlayer,SetTo,5);
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		TSetNVar(Common_UType,SetTo,UV[1]);
	},{Preserved})
TriggerX(FP,{ -- CAPlot 막는곳
		CDeaths("X",Exactly,3,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,2,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetNVar(Temple2_LoopLimit,SetTo,600); -- 2 point / tik
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[4]);
		TSetNVar(Temple2_Shapes,SetTo,_Add(V(SType),1)); -- Center
		SetCDeaths("X",SetTo,3,Stage);
		SetCDeaths("X",SetTo,34*13,Timer); -- WaitTimer
		SetCDeaths("X",SetTo,1,VInput);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,3,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		TSetNVar(Common_UType,SetTo,UV[2]);
		TSetNVar(Temple2_Shapes,SetTo,V(SType)); -- Main
		SetCDeaths("X",SetTo,4,Stage);
		TSetCDeaths("X",SetTo,CycleCounting,Timer); -- WaitTimer
	})
CTrigger(FP,{
		CDeaths("X",Exactly,4,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,Add,2); -- Add DataIndex
		SetNVar(UPlayer,SetTo,6);
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		TSetNVar(Common_UType,SetTo,UV[2]);
	},{Preserved})
TriggerX(FP,{ -- CAPlot 막는곳
		CDeaths("X",Exactly,5,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,4,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		TSetNVar(Common_UType,SetTo,UV[4]);
		SetNVar(Temple2_LoopLimit,SetTo,600); -- 2 point / tik
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Temple2_Shapes,SetTo,_Add(V(SType),1)); -- Main
		SetCDeaths("X",SetTo,5,Stage);
		SetCDeaths("X",SetTo,34*13,Timer); -- WaitTimer
		SetCDeaths("X",SetTo,1,VInput);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,5,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		TSetNVar(Common_UType,SetTo,UV[3]);
		TSetNVar(Temple2_Shapes,SetTo,V(SType)); -- Main
		SetNVar(UPlayer,SetTo,5);
		SetCDeaths("X",SetTo,6,Stage);
		TSetCDeaths("X",SetTo,CycleCounting,Timer); -- WaitTimer
	})
CTrigger(FP,{
		CDeaths("X",Exactly,6,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,Add,2); -- Add DataIndex
		SetNVar(Temple2_LoopLimit,SetTo,2); -- 2 point / tik
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(Common_UType,SetTo,UV[3]);
	},{Preserved})
CTrigger(FP,{
		CDeaths("X",Exactly,6,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		TSetNVar(Common_UType,SetTo,UV[4]);
		SetNVar(UPlayer,SetTo,7);
		SetNVar(Temple2_LoopLimit,SetTo,600); -- 2 point / tik
		TSetNVar(Temple2_Shapes,SetTo,_Add(V(SType),1)); -- Main
		SetCDeaths("X",SetTo,7,Stage);
		SetCDeaths("X",SetTo,1,Timer); -- WaitTimer
		SetCDeaths("X",SetTo,1,VInput);
	})
CTrigger(FP,{
		CDeaths("X",Exactly,7,Stage);
		CDeaths("X",Exactly,0,Timer);
	},{
		SetCVar("X",NextDot,SetTo,1); -- DataIndex Reset
		TSetNVar(Common_UType,SetTo,UV[5]);
		SetNVar(UPlayer,SetTo,7);
		SetNVar(Temple2_LoopLimit,SetTo,600); -- 2 point / tik
		TSetNVar(Temple2_Shapes,SetTo,_Add(V(SType),2)); -- Arc
		SetCDeaths("X",SetTo,8,Stage);
		SetCDeaths("X",SetTo,1,VInput);
		SetSwitch(GLock,Set);
	})
function Temple2CAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CIf(FP,{CDeaths("X",Exactly,8,Stage)})
		CA_Rotate(V(TAngle2))
	CIfEnd()
end

CAPlot(TempleShapeArr2,P6,193,"CLoc106",{TPosX,TPosY},1,32,
	{Temple2_Shapes,0,0,0,Temple2_LoopLimit,V(NextDot)},"Temple2CAFunc",FP,nil,{SetNext("X",0x5012),SetNext(0x5013,"X",1)})

DoActionsX(FP,{SetCDeaths("X",Subtract,1,Timer),SetCDeaths("X",Subtract,1,VInput)})
CIfEnd()
------< N1 , Ion, Overmind >------------------------------------------
-- Vars , CDeaths --
N1_LoopLimit, N1_DataIndex, NDistance, CGiveNumber, N1_VIndex, Ind_Rand = CreateVars(6,FP)
N1_UnitVArr = CreateVArr(16,FP) -- 노라드 유닛배열
NPatch = {}
HPatch = {}
LPatch = {}
	local NormalTable = {80,21,12,80,21,12,80,21,12,86,98,58,27,60,28,99}
	local HardTable = {12,27,28,12,27,28,12,27,28,12,27,28,99,99,102,9}
	local LunaticTable = {27,28,60,27,28,60,27,28,60,27,102,102,99,99,9,9}
		for i = 0, 15 do
			table.insert(NPatch,SetVArrayX(VArr(N1_UnitVArr,i),"Value",SetTo,NormalTable[i+1]))
			table.insert(HPatch,SetVArrayX(VArr(N1_UnitVArr,i),"Value",SetTo,HardTable[i+1]))
			table.insert(LPatch,SetVArrayX(VArr(N1_UnitVArr,i),"Value",SetTo,LunaticTable[i+1]))
		end
TriggerX(FP,{CVar("X",GMode,Exactly,1)},NPatch)
TriggerX(FP,{CVar("X",GMode,Exactly,2)},HPatch)
TriggerX(FP,{CVar("X",GMode,Exactly,3)},LPatch)

-- Shapes -- 
EFLine = CSMakeLine(1,32,0,188,0)
N1_MainA = CS_MoveXY(CSMakeLine(2,64,90,33,0),0,-4096+64) -- 33*12 = 396
N1_MainB = CS_MoveXY(CSMakeLine(2,128,90,17,0),0,-4096+64) -- 17*12 = 204
N1_MainC = CS_MoveXY(CSMakeLine(2,256,90,9,0),0,-4096+64) -- 9*12 = 108
-- CFunc --
Call_CGive = InitCFunc(FP)

CFunc(Call_CGive)

-- CIf(FP,{CVar("X",GMode,Exactly,3)}) -- 랜덤개별적용
-- 	f_Mod(FP,Ind_Rand,_Rand(),2) -- 0 일때 개별 X // 1일때 개별 O
-- CIfEnd()

CFor(FP,19025,19025+(84*1700),84)
	local CI = CForVariable()
	CIf(FP,{
		TMemoryX(_Add(CI,9),Exactly,_Sub(CGiveNumber,10*65536),0xFF0000), -- f_CGive ( 나오는유닛순서 - 10 = CGive순서 )
		TMemoryX(_Add(CI,19),Exactly,10,0xFF), -- P11
		TMemoryX(_Add(CI,19),AtLeast,1*256,0xFF00), -- Alive
		TMemoryX(_Add(CI,25),Exactly,VArr(N1_UnitVArr,_Sub(N1_VIndex,11)),0xFFFF) -- UnitID
	})
		f_CGive(FP, CI, nil, P8, P11) -- P11 - > P8 Return

		CTrigger(FP,{NVar(Ind_Rand,Exactly,0)},{ -- 개별 X
				TSetMemoryX(_Add(CI,9),SetTo,0*65536,0xFF0000); -- Reset CGiveNumber
				TSetMemory(_Add(CI,13),SetTo,2560);
				TSetMemoryX(_Add(CI,18),SetTo,2560,0xFFFF);
				TSetMemoryX(_Add(CI,55),SetTo,0,0x4000000); -- Disable Invincibility
		},{Preserved})
		-- CTrigger(FP,{NVar(Ind_Rand,Exactly,1)},{ -- 개별 O
		-- 	TSetMemoryX(_Add(CI,9),SetTo,0*65536,0xFF0000); -- Reset CGiveNumber
		-- 	TSetMemory(_Add(CI,13),SetTo,2560);
		-- 	TSetMemoryX(_Add(CI,18),SetTo,2560,0xFFFF);
		-- 	TSetMemoryX(_Add(CI,35),SetTo,1,0xFF);
		-- 	TSetMemoryX(_Add(CI,35),SetTo,1*256,0xFF00);
		-- 	TSetMemoryX(_Add(CI,55),SetTo,0x100,0x4000100); -- Disable Invincibility
		-- 	TSetMemoryX(_Add(CI,57),SetTo,Save_VFlag,0xFF);
		-- 	TSetMemoryX(_Add(CI,70),SetTo,255*16777216,0xFF000000);
		-- 	TSetMemoryX(_Add(CI,72),SetTo,255*256,0xFF00);
		-- 	TSetMemoryX(_Add(CI,72),SetTo,255*16777216,0xFF000000);
		-- 	TSetMemoryX(_Add(CI,73),SetTo,Save_VFlag256,0xFF000000);
		-- },{Preserved})
	CIfEnd()
CForEnd()
CFuncEnd()

CJump(FP,9)
SetLabel(0x5014)
CDoActions(FP,{TSetMemoryB(0x6605F0,VArr(N1_UnitVArr,N1_VIndex),SetTo,16)}) -- Start Direction
NIf(FP,{Memory(0x628438,AtLeast,1)})
	SetNextptr()
		CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
			TCreateUnit(1,VArr(N1_UnitVArr,N1_VIndex),"CLoc106",P8);
			TGiveUnits(1,VArr(N1_UnitVArr,N1_VIndex),P8,"CLoc106",P11);
			TSetMemoryX(Vi(Nextptr[2],8),SetTo,127*65536,0xFF0000); -- Turn Radius
			TSetMemoryX(Vi(Nextptr[2],9),SetTo,_Add(CGiveNumber,1*65536),0xFF0000); -- Set CGiveNumber
			TSetMemory(Vi(Nextptr[2],13),SetTo,NDistance); -- MaxSpeed
			TSetMemoryX(Vi(Nextptr[2],18),SetTo,NDistance,0xFFFF); -- Acceleration
			TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x4000000,0x4000000); -- Enable Invincibility
			TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
			TOrder(VArr(N1_UnitVArr,N1_VIndex),P11,"CLoc106",Patrol,"N1_Dest")
		},{Preserved})
NIfEnd()
CDoActions(FP,{TSetMemoryB(0x6605F0,VArr(N1_UnitVArr,N1_VIndex),SetTo,32)}) -- Start Direction
SetLabel(0x5015)
-----------------< Over >------------------------
SetLabel(0x5016)

CIfX(FP,{CVar("X",GMode,Exactly,1)})
	CDoActions(FP,{
		TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
		TCreateUnit(1,Common_XUType,"CLoc106",UPlayer);
	})
CElseX() -- CVar("X",GMode,AtLeast,2)
	CIfX(FP,{CDeaths("X",Exactly,0,VInput)})
		CDoActions(FP,{
			TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
			TCreateUnit(1,Common_XUType,"CLoc106",UPlayer);
		})
	CElseX() -- CDeaths("X",Exactly,1,VInput)
		SetNextptr()
			CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_UType,"CLoc106",P8);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			},{Preserved})
		SetNextptr()
			CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
				TCreateUnit(1,Common_XUType,"CLoc106",P8);
				TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
				TSetMemoryX(Vi(Nextptr[2],57),SetTo,Save_VFlag,0xFF);
				TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],73),SetTo,Save_VFlag256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
				TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
				TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
			},{Preserved})
	CIfXEnd()
CIfXEnd()

SetLabel(0x5017)
CJumpEnd(FP,9)

function N_CAFunc()
    local CA = CAPlotDataArr
		f_Sqrt(FP, NDistance,_Div(_Add(_Square(V(CA[8])),_Square(V(CA[9]))),20)) -- Calc Distance ( Div 20 = 오차범위 최소화)
end

------< N1 >------------------------------------------
GCenter = {1024,6203}
CA_GunPreset(P8,126,"Switch 94",64,"N1")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,"N1")})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText10,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,17);
		SetNVar(BGMVar[1],SetTo,17);
		SetNVar(BGMVar[2],SetTo,17);
		SetNVar(BGMVar[3],SetTo,17);
		SetNVar(BGMVar[4],SetTo,17);
		SetNVar(BGMVar[5],SetTo,17);
		SetScore(Force1,Add,300000,Kills);
	})
DoActionsX(FP,{SetNVar(TPosX,SetTo,GCenter[1]),SetNVar(TPosY,SetTo,GCenter[2])}) -- X,Y 고정좌표세팅
TriggerX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(V(SType),SetTo,2),SetMinimapColor(P11,Add,1)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{SetNVar(V(SType),SetTo,1),SetMinimapColor(P11,Add,1)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{SetNVar(V(SType),SetTo,1),SetMinimapColor(P11,Add,1)},{Preserved})


DoActionsX(FP,{SetCDeaths("X",Subtract,1,Timer)})
CIf(FP,{CDeaths("X",Exactly,0,Timer),NVar(CGiveNumber,AtMost,26*65536,0xFF0000)})
	DoActionsX(FP,{SetCDeaths("X",SetTo,34*3,Timer),SetNVar(N1_DataIndex,SetTo,1),SetNVar(V(NextDot),SetTo,1)})
	CallCFuncX(FP,Call_CGive)
	CAPlotOrder({N1_MainA,N1_MainB,N1_MainC,EFLine},P6,193,"CLoc106",{1024,4096},1,64,{V(SType),0,0,0,600,N1_DataIndex},"N_CAFunc",
		{CS_Rotate(N1_MainA,180),CS_Rotate(N1_MainB,180),CS_Rotate(N1_MainC,180),EFLine},Attack,"N1_Dest",{1024,4096},{V(SType),V(NextDot)},nil,{16,16},FP,
		{NVar(CGiveNumber,AtMost,15*65536,0xFF0000)},{SetNext("X",0x5014),SetNext(0x5015,"X",1)})
	DoActionsX(FP,{SetNVar(N1_VIndex,Add,1),SetNVar(CGiveNumber,Add,1*65536)})
CIfEnd()

TriggerX(FP,{NVar(CGiveNumber,Exactly,26*655360,0xFF0000)},{SetSwitch(GLock,Set)})

CIfEnd() -- N1 End

------< Over >------------------------------------------
-- Vars --
OverShape, OverLoopLimit = CreateVars(2,FP)
-- Shapes --
Over_MainA = CSMakeStar(3,145,96,0,CS_Level("Star",3,6),CS_Level("Star",3,3)) -- 84
Over_MainB = CSMakeStar(4,135,96,0,CS_Level("Star",4,6),CS_Level("Star",4,3)) -- 112
Over_MainC = CSMakeStar(5,120,96,0,CS_Level("Star",5,6),CS_Level("Star",5,3)) -- 140
Over_SideA = CSMakeStar(3,145,96,0,CS_Level("Star",3,7),CS_Level("Star",3,6)) -- 36
Over_SideB = CSMakeStar(4,135,96,0,CS_Level("Star",4,7),CS_Level("Star",4,6)) -- 48
Over_SideC = CSMakeStar(5,120,96,0,CS_Level("Star",5,7),CS_Level("Star",5,6)) -- 60

OverShapeArr = {Over_MainA,Over_MainB,Over_MainC,Over_SideA,Over_SideB,Over_SideC}

GCenter = {1024,958}
CA_GunPreset(P8,147,"Switch 95",65,"Over")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})
SetVFlags()

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText4,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,3);
		SetNVar(BGMVar[1],SetTo,3);
		SetNVar(BGMVar[2],SetTo,3);
		SetNVar(BGMVar[3],SetTo,3);
		SetNVar(BGMVar[4],SetTo,3);
		SetNVar(BGMVar[5],SetTo,3);
		SetScore(Force1,Add,300000,Kills);
	})
DoActionsX(FP,{SetNVar(TPosX,SetTo,GCenter[1]),SetNVar(TPosY,SetTo,GCenter[2])}) -- X,Y 고정좌표세팅

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(CycleCounting,SetTo,Over_SideA[1]),SetNVar(V(SType),SetTo,1),
	SetNVar(UV[1],SetTo,76),SetNVar(UV[2],SetTo,12),SetNVar(UV[3],SetTo,25),SetNVar(UV[4],SetTo,27),
	SetNVar(UV[5],SetTo,74),SetNVar(UV[6],SetTo,86),SetNVar(UV[7],SetTo,5),SetNVar(UV[8],SetTo,27),
	SetNVar(UV[9],SetTo,93),SetNVar(UV[10],SetTo,98),SetNVar(UV[11],SetTo,3),SetNVar(UV[12],SetTo,69),
	SetNVar(UV[13],SetTo,32),SetNVar(UV[14],SetTo,58),SetNVar(UV[15],SetTo,2),SetNVar(UV[16],SetTo,69)
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(CycleCounting,SetTo,Over_SideB[1]),SetNVar(V(SType),SetTo,2),
	SetNVar(UV[1],SetTo,52),SetNVar(UV[2],SetTo,58),SetNVar(UV[3],SetTo,65),SetNVar(UV[4],SetTo,102),
	SetNVar(UV[5],SetTo,64),SetNVar(UV[6],SetTo,98),SetNVar(UV[7],SetTo,66),SetNVar(UV[8],SetTo,102),
	SetNVar(UV[9],SetTo,16),SetNVar(UV[10],SetTo,88),SetNVar(UV[11],SetTo,65),SetNVar(UV[12],SetTo,30),
	SetNVar(UV[13],SetTo,2),SetNVar(UV[14],SetTo,8),SetNVar(UV[15],SetTo,66),SetNVar(UV[16],SetTo,30)
},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(CycleCounting,SetTo,Over_SideC[1]),SetNVar(V(SType),SetTo,3),
	SetNVar(UV[1],SetTo,16),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,87),SetNVar(UV[4],SetTo,9),
	SetNVar(UV[5],SetTo,2),SetNVar(UV[6],SetTo,8),SetNVar(UV[7],SetTo,61),SetNVar(UV[8],SetTo,9),
	SetNVar(UV[9],SetTo,65),SetNVar(UV[10],SetTo,60),SetNVar(UV[11],SetTo,87),SetNVar(UV[12],SetTo,30),
	SetNVar(UV[13],SetTo,66),SetNVar(UV[14],SetTo,28),SetNVar(UV[15],SetTo,61),SetNVar(UV[16],SetTo,30)
},{Preserved})

TriggerX(FP,{ -- CAPlot End
	CDeaths("X",Exactly,0,Timer);
	CDeaths("X",Exactly,0,Stage);
},{
	SetCDeaths("X",SetTo,1,Timer);
	SetCDeaths("X",SetTo,1,Stage);
	SetCVar("X",NextDot,SetTo,600);
})
CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,0,Timer);
	CDeaths("X",Exactly,1,Stage);
},{
	SetCDeaths("X",SetTo,2,Stage);
	SetCDeaths("X",SetTo,0,VInput); -- 개별건작 미적용 
	TSetCDeaths("X",SetTo,CycleCounting,Timer); -- 순환 카운팅
	SetCVar("X",NextDot,SetTo,0); -- 찍을 점 초기화
	SetNVar(OverLoopLimit,SetTo,1); -- 루프리미트 1
	TSetNVar(Common_UType,SetTo,UV[3]); -- 강유닛 지상
	TSetNVar(Common_XUType,SetTo,UV[4]); -- 강유닛 공중
	TSetNVar(OverShape,SetTo,_Add(V(SType),3)); -- 도형선택
})
CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,2,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,1);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(OverLoopLimit,SetTo,1);
	SetNVar(UPlayer,SetTo,7);
	TSetNVar(Common_UType,SetTo,UV[3]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[4]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
},{Preserved})

TriggerX(FP,{ -- CAPlot 막는곳
		CDeaths("X",Exactly,3,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
	})

CTrigger(FP,{ -- Main1
	CDeaths("X",Exactly,2,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,3,Stage);
	SetCDeaths("X",SetTo,34*14,Timer);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetCDeaths("X",SetTo,1,OrderG);
	SetCVar("X",NextDot,SetTo,1);
	SetNVar(OverLoopLimit,SetTo,600);
	SetNVar(UPlayer,SetTo,5);
	TSetNVar(Common_UType,SetTo,UV[1]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[2]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,V(SType));
})

CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,3,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,4,Stage);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	TSetCDeaths("X",SetTo,CycleCounting,Timer);
	SetCVar("X",NextDot,SetTo,0);
	SetNVar(OverLoopLimit,SetTo,1);
	TSetNVar(Common_UType,SetTo,UV[7]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[8]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
})
CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,4,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,1);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(UPlayer,SetTo,7);
	TSetNVar(Common_UType,SetTo,UV[7]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[8]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
},{Preserved})

TriggerX(FP,{ -- CAPlot 막는곳
		CDeaths("X",Exactly,5,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
	})

CTrigger(FP,{ -- Main2
	CDeaths("X",Exactly,4,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,5,Stage);
	SetCDeaths("X",SetTo,34*14,Timer);
	SetCDeaths("X",SetTo,1,OrderG);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(OverLoopLimit,SetTo,600);
	SetNVar(UPlayer,SetTo,6);
	SetCVar("X",NextDot,SetTo,1);
	TSetNVar(Common_UType,SetTo,UV[5]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[6]); -- Air
	TSetNVar(OverShape,SetTo,V(SType));
})
CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,5,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,6,Stage);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	TSetCDeaths("X",SetTo,CycleCounting,Timer);
	SetNVar(OverLoopLimit,SetTo,1);
	SetCVar("X",NextDot,SetTo,0);
	TSetNVar(Common_UType,SetTo,UV[11]); -- 지상
	TSetNVar(Common_XUType,SetTo,UV[12]); -- 공중
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
})
CTrigger(FP,{ -- OutSide
	CDeaths("X",Exactly,6,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,1);
	SetNVar(OverLoopLimit,SetTo,1);
	SetNVar(UPlayer,SetTo,7);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	TSetNVar(Common_UType,SetTo,UV[11]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[12]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
},{Preserved})

TriggerX(FP,{ -- CAPlot 막는곳
		CDeaths("X",Exactly,7,Stage);
		CDeaths("X",AtLeast,1,Timer);
	},{
		SetCVar("X",NextDot,SetTo,600);
	})

CTrigger(FP,{ -- Main3
	CDeaths("X",Exactly,6,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,7,Stage);
	SetCDeaths("X",SetTo,34*14,Timer);
	SetCDeaths("X",SetTo,1,OrderG);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(OverLoopLimit,SetTo,600);
	SetCVar("X",NextDot,SetTo,1);
	SetNVar(UPlayer,SetTo,5);
	TSetNVar(Common_UType,SetTo,UV[9]); -- 지상
	TSetNVar(Common_XUType,SetTo,UV[10]); -- 공중
	TSetNVar(OverShape,SetTo,V(SType));
})
CTrigger(FP,{ -- Outside
	CDeaths("X",Exactly,7,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,8,Stage);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	TSetCDeaths("X",SetTo,CycleCounting,Timer);
	SetNVar(OverLoopLimit,SetTo,1);
	SetCVar("X",NextDot,SetTo,0);
	TSetNVar(Common_UType,SetTo,UV[15]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[16]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
})
CTrigger(FP,{ -- Outside
	CDeaths("X",Exactly,8,Stage);
	CDeaths("X",AtLeast,1,Timer);
},{
	SetCVar("X",NextDot,Add,1);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(OverLoopLimit,SetTo,1);
	SetNVar(UPlayer,SetTo,7);
	TSetNVar(Common_UType,SetTo,UV[15]); -- Ground
	TSetNVar(Common_XUType,SetTo,UV[16]); -- Air ( 30 , 69 )
	TSetNVar(OverShape,SetTo,_Add(V(SType),3));
},{Preserved})

CTrigger(FP,{ -- Main4
	CDeaths("X",Exactly,8,Stage);
	CDeaths("X",Exactly,0,Timer);
},{
	SetCDeaths("X",SetTo,9,Stage);
	SetCDeaths("X",SetTo,1,OrderG);
	SetCDeaths("X",SetTo,0,VInput); -- Individual
	SetNVar(OverLoopLimit,SetTo,600);
	SetNVar(UPlayer,SetTo,6);
	SetCVar("X",NextDot,SetTo,1);
	TSetNVar(Common_UType,SetTo,UV[13]); -- 지상
	TSetNVar(Common_XUType,SetTo,UV[14]); -- 공중
	TSetNVar(OverShape,SetTo,V(SType));
	SetSwitch(GLock,Set);
})


CAPlot(OverShapeArr,P6,193,"CLoc106",{TPosX,TPosY},1,32,{OverShape,0,0,0,OverLoopLimit,V(NextDot)}
	,nil,FP,nil,{SetNext("X",0x5016),SetNext(0x5017,"X",1)})
CIf(FP,{CDeaths("X",Exactly,1,OrderG)})
	SetLocCenter(GLoc,"CLoc76")
	DoActionsX(FP,{Simple_CalcLoc("CLoc76",-768,-768,768,768)})
	CDoActions(FP,{
		TOrder(Common_UType,Force2,"CLoc76",Attack,"HZ");
		TOrder(Common_XUType,Force2,"CLoc76",Attack,"HZ");
		TOrder(UV[3],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[4],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[7],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[8],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[11],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[12],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[15],P8,"CLoc76",Attack,"HZ");
		TOrder(UV[16],P8,"CLoc76",Attack,"HZ");
	})
CIfEnd()
DoActionsX(FP,{SetCDeaths("X",Subtract,1,Timer),SetCDeaths("X",Subtract,1,OrderG),SetCDeaths("X",Subtract,1,VInput)})
CIfEnd()

------< Ion >------------------------------------------
-- Vars --

SH_IA = CS_OverlapX(CS_MoveXY(CSMakeSpiral(3,96,0.8,64,0,3*8+1,1),-384,0),CS_MoveXY(CSMakeSpiral(3,96,0.8,32,0,3*8+1,1),384,0))
SH_IB = CS_OverlapX(CS_MoveXY(CSMakeSpiral(4,96,0.8,64,0,4*8+1,1),-384,0),CS_MoveXY(CSMakeSpiral(4,96,0.8,32,0,4*8+1,1),384,0))
SH_IC = CS_OverlapX(CS_MoveXY(CSMakeSpiral(5,96,0.8,64,0,5*8+1,1),-384,0),CS_MoveXY(CSMakeSpiral(5,96,0.8,32,0,5*8+1,1),384,0))

Ion_OrderSW, Ion_OrderType = CreateCcodes(2)

CJump(FP,10)
SetLabel(0x5018)

NIf(FP,{Memory(0x628438,AtLeast,1)})
SetNextptr()
	CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
		TCreateUnit(1,Common_UType,"CLoc106",UPlayer);
		TSetMemoryX(Vi(Nextptr[2],8),SetTo,127*65536,0xFF0000); -- Turn Radius
		TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
		TSetMemoryX(Vi(Nextptr[2],18),SetTo,2400,0xFFFF);
		TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00); -- Vision
		TOrder(Common_UType,UPlayer,"CLoc106",Move,"CLoc142");
	},{Preserved})
NIfEnd()

SetLabel(0x5019)
CJumpEnd(FP,10)

CheckMarPos = InitCFunc(FP)

CFunc(CheckMarPos)

CIfX(FP,{CDeaths("X",Exactly,0,Ion_OrderType)})
	for i = 0, 63 do -- 최좌측 우선타겟
		TriggerX(FP,{CDeaths("X",Exactly,0,Ion_OrderSW)},{
			Simple_SetLoc("CLoc141",32*i,0,32+32*i,8192); -- Priority Target
			RemoveUnitAt(1,84,"CLoc141",P12);
		},{Preserved})
		TriggerX(FP,{
			CDeaths("X",Exactly,0,Ion_OrderSW);
			Bring(Force1,AtLeast,1,20,"CLoc141")
		},{
			SetCDeaths("X",SetTo,1,Ion_OrderSW);
			MoveLocation("CLoc142",20,Force1,"CLoc141"); -- Set Move Loc
		},{Preserved})
	end

	TriggerX(FP,{ -- 영마없을때 도착지 이온으로 설정
		Bring(Force1,Exactly,0,20,"Anywhere");
		CDeaths("X",Exactly,0,Ion_OrderSW);
	},{
		MoveLocation("CLoc142",20,Force1,"Ion");
		SetCDeaths("X",SetTo,1,Ion_OrderSW);
	},{Preserved})

CElseIfX({CDeaths("X",Exactly,1,Ion_OrderType)}) -- OrderType 1
	for i = 63, 0, -1 do -- 최우측 우선타겟
		TriggerX(FP,{CDeaths("X",Exactly,0,Ion_OrderSW)},{
			Simple_SetLoc("CLoc141",32*i,0,32+32*i,8192); -- Priority Target
			RemoveUnitAt(1,84,"CLoc141",P12);
		},{Preserved})
		TriggerX(FP,{
			Bring(Force1,AtLeast,1,20,"CLoc141");
			CDeaths("X",Exactly,0,Ion_OrderSW)
		},{
			SetCDeaths("X",SetTo,1,Ion_OrderSW);
			MoveLocation("CLoc142",20,Force1,"CLoc141"); -- Set Move Loc
		},{Preserved})
	end
	TriggerX(FP,{ -- 영마없을때 도착지 이온으로 설정
		Bring(Force1,Exactly,0,20,"Anywhere");
		CDeaths("X",Exactly,0,Ion_OrderSW);
	},{
		MoveLocation("CLoc142",20,Force1,"Ion");
		SetCDeaths("X",SetTo,1,Ion_OrderSW);
	},{Preserved})
CIfXEnd()

CFuncEnd()

GCenter = {1024,1606}
CA_GunPreset(P8,127,"Switch 96",66,"Ion")

CIf(FP,{Switch(GLock,Cleared),Bring(GunPlayer,Exactly,0,BID,GLoc)})

TriggerX(FP,{CDeaths("X",Exactly,0,Stage)},{
		CopyCpAction({DisplayTextX(SText9,4)},{P1,P2,P3,P4,P5,Force5},FP);
		SetNVar(OB_BGMVar,SetTo,3);
		SetNVar(BGMVar[1],SetTo,3);
		SetNVar(BGMVar[2],SetTo,3);
		SetNVar(BGMVar[3],SetTo,3);
		SetNVar(BGMVar[4],SetTo,3);
		SetNVar(BGMVar[5],SetTo,3);
		SetScore(Force1,Add,200000,Kills);
	})
DoActionsX(FP,{SetNVar(TPosX,SetTo,GCenter[1]),SetNVar(TPosY,SetTo,GCenter[2]),SetCVar("X",NextDot,SetTo,600)})

TriggerX(FP,{CVar("X",GMode,Exactly,1)},{
	SetNVar(V(SType),SetTo,1),SetNVar(UV[1],SetTo,55),SetNVar(UV[2],SetTo,56),SetNVar(UV[3],SetTo,70),SetNVar(UV[4],SetTo,25)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,2)},{
	SetNVar(V(SType),SetTo,2),SetNVar(UV[1],SetTo,86),SetNVar(UV[2],SetTo,88),SetNVar(UV[3],SetTo,8),SetNVar(UV[4],SetTo,30)},{Preserved})
TriggerX(FP,{CVar("X",GMode,Exactly,3)},{
	SetNVar(V(SType),SetTo,3),SetNVar(UV[1],SetTo,28),SetNVar(UV[2],SetTo,58),SetNVar(UV[3],SetTo,98),SetNVar(UV[4],SetTo,13)},{Preserved})

for i = 1, 4 do
	CTrigger(FP,{
		CDeaths("X",Exactly,0,Timer);
		CDeaths("X",Exactly,i-1,Stage);
	},{
		SetCDeaths("X",SetTo,34*5,Timer);
		SetCDeaths("X",SetTo,i,Stage);
		SetCDeaths("X",SetTo,1,Ion_OrderType); -- Right
		SetCDeaths("X",SetTo,1,OrderG); -- Move, JYD Order
		SetCVar("X",NextDot,SetTo,1);
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(Common_UType,SetTo,UV[1]);
	})
end


for i = 5, 8 do
	CTrigger(FP,{
		CDeaths("X",Exactly,0,Timer);
		CDeaths("X",Exactly,i-1,Stage);
	},{
		SetCDeaths("X",SetTo,34*5,Timer);
		SetCDeaths("X",SetTo,i,Stage);
		SetCDeaths("X",SetTo,0,Ion_OrderType); -- Left
		SetCDeaths("X",SetTo,1,OrderG); -- Move, JYD Order
		SetCVar("X",NextDot,SetTo,1);
		SetNVar(UPlayer,SetTo,6);
		TSetNVar(Common_UType,SetTo,UV[2]);
	})
end

for i = 9, 12 do
	CTrigger(FP,{
		CDeaths("X",Exactly,0,Timer);
		CDeaths("X",Exactly,i-1,Stage);
	},{
		SetCDeaths("X",SetTo,34*5,Timer);
		SetCDeaths("X",SetTo,i,Stage);
		SetCDeaths("X",SetTo,1,Ion_OrderType); -- Right
		SetCDeaths("X",SetTo,1,OrderG); -- Move, JYD Order
		SetCVar("X",NextDot,SetTo,1);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(Common_UType,SetTo,UV[3]);
	})
end
CTrigger(FP,{
	CDeaths("X",Exactly,0,Timer);
	CDeaths("X",Exactly,12,Stage);
},{
	SetCDeaths("X",SetTo,34*5,Timer);
	SetCDeaths("X",SetTo,13,Stage);
	SetCDeaths("X",SetTo,1,OrderG); -- Move, JYD Order
	SetCVar("X",NextDot,SetTo,1);
	SetNVar(UPlayer,SetTo,7);
	TSetNVar(Common_UType,SetTo,UV[4]);
	SetSwitch(GLock,Set);
})

CIf(FP,{CDeaths("X",Exactly,1,OrderG)})
	DoActions(FP,{MoveLocation("CLoc143",20,P8,"CLoc142")}) -- CLoc143을 CLoc142로 이동
	CallCFuncX(FP,CheckMarPos) -- CLoc142 영마위치로 이동
CIfEnd()

function IonCAFunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
		CA_Rotate(V(TAngle2))
end

CAPlot({SH_IA,SH_IB,SH_IC},P6,193,"CLoc106",{TPosX,TPosY},1,32,
	{V(SType),0,0,0,600,V(NextDot)},"IonCAFunc",FP,nil,{SetNext("X",0x5018),SetNext(0x5019,"X",1)})

CIf(FP,{CDeaths("X",Exactly,1,OrderG)})
	DoActionsX(FP,{ -- CLoc143 정야독
		CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","CLoc143")},{Force2},FP);
	})
CIfEnd()

DoActionsX(FP,{SetCDeaths("X",Subtract,1,Timer),SetCDeaths("X",Subtract,1,OrderG),SetCDeaths("X",Subtract,1,Ion_OrderSW)
	,CreateUnit(1,84,"CLoc142",P5)})
CIfEnd()

Install_MBoss()
--SetMemoryB(0x58D2B0+(5*46)+i,Add,1)


------< Wave Trig >------------------------------------------
--sIndex : 0x105 , 0x106
--Label : 0x1007 , 0x1008
-- Shapes --
Wave_N4 = CSMakePolygon(5,96*4,0,CS_Level("Polygon",5,2),1) -- 5 ( GUnit )
Wave_N3 = CSMakePolygon(5,96,0,CS_Level("Polygon",5,3),1) -- 15 ( HUnit )
Wave_N2 = CSMakePolygon(5,96,0,CS_Level("Polygon",5,4),1) -- 30 ( HUnit )
Wave_N1 = CSMakePolygon(5,96,0,CS_Level("Polygon",5,5),1) -- 50 ( XUnit )

Wave_H4 = CSMakePolygon(6,96*4,0,CS_Level("Polygon",6,2),1) -- 6
Wave_H3 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,3),1) -- 18
Wave_H2 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,4),1) -- 36
Wave_H1 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,5),1) -- 60

Wave_L4 = CSMakePolygon(8,96*4,0,CS_Level("Polygon",8,2),1) -- 8
Wave_L3 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,4),1) -- 36
Wave_L2 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,5),1) -- 60
Wave_L1 = CSMakePolygon(6,96,0,CS_Level("Polygon",6,6),1) -- 90

WaveShapesArr = {Wave_N1,Wave_N2,Wave_N3,Wave_N4,Wave_H1,Wave_H2,Wave_H3,Wave_H4,Wave_L1,Wave_L2,Wave_L3,Wave_L4}
WCenter = {1024,958}
-- Variables --
XUnitAttackTimer = CreateVar(FP)
WaveLevel, WaveDataIndex, WaveShape, WaveUType, WaveXUType, WaveDataIndex, WTimer, WStage,
 WaveSW, VMod, WShape = CreateVars(11,FP)

CJump(FP,0x105)

Trigger {
	players = {FP},
	conditions = {
			Label(0x1007);
		},
}
-- UType 192 = GroundX
-- UType 193 = AirX
-- UType 194 = Hunit ( Ground )
-- UType 195 = HUnit ( Air )
-- UType 196 = GUnit
CIf(FP,{NVar(RTimer,AtMost,60*10)}) -- XUnitSetting
--< GroundX >--
	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,37);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,2*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,38);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,2*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,39);
	},{Preserved})
--< AirX >--
	TriggerX(FP,{
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,43);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,44);
	},{Preserved})
CIfEnd()

CIf(FP,NVar(RTimer,AtLeast,60*10+1)) -- XUnitSetting
--< GroundX >--
	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,53);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,2*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,54);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,2*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,3*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,48);
	},{Preserved})

	TriggerX(FP,{
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,3*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,4*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,104);
	},{Preserved})

	TriggerX(FP,{
		CVar("X",GMode,AtMost,2);
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,4*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,40);
	},{Preserved})

	TriggerX(FP,{
		CVar("X",GMode,Exactly,3);
		NVar(WaveUType,Exactly,192,0xFFFF);
		NVar(WaveUType,Exactly,4*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,51);
	},{Preserved})
--< AirX )--
	TriggerX(FP,{
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,55);
	},{Preserved})

	TriggerX(FP,{
		CVar("X",GMode,AtMost,2);
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,56);
	},{Preserved})

	TriggerX(FP,{
		CVar("X",GMode,Exactly,3);
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,2*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,56);
	},{Preserved})

	TriggerX(FP,{
		CVar("X",GMode,Exactly,3);
		NVar(WaveUType,Exactly,193,0xFFFF);
		NVar(WaveUType,Exactly,2*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(WaveXUType,SetTo,70);
	},{Preserved})
CIfEnd()

CIfX(FP,{NVar(WaveUType,AtLeast,194,0xFFFF)})
	CTrigger(FP,{ -- HUnit Ground1
		NVar(WaveUType,Exactly,194,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(WaveXUType,SetTo,HU1);
	},{Preserved})
	CTrigger(FP,{ -- HUnit Ground2
		NVar(WaveUType,Exactly,194,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,6);
		TSetNVar(WaveXUType,SetTo,HU2);
	},{Preserved})
	CTrigger(FP,{ -- HUnit Air1
		NVar(WaveUType,Exactly,195,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,5);
		TSetNVar(WaveXUType,SetTo,HU3);
	},{Preserved})
	CTrigger(FP,{ -- HUnit Air2
		NVar(WaveUType,Exactly,195,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,6);
		TSetNVar(WaveXUType,SetTo,HU4);
	},{Preserved})
	CTrigger(FP,{ -- GUnit Ground
		NVar(WaveUType,Exactly,196,0xFFFF);
		NVar(WaveUType,Exactly,0*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,1*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(WaveXUType,SetTo,GU1);
	},{Preserved})
	CTrigger(FP,{ -- GUnit Air
		NVar(WaveUType,Exactly,196,0xFFFF);
		NVar(WaveUType,Exactly,1*65536,0xFF0000);
		NVar(WaveUType,Exactly,0*16777216,0xFF000000);
	},{
		SetNVar(WaveUType,SetTo,0*65536,0xFF0000);
		SetNVar(WaveUType,SetTo,1*16777216,0xFF000000);
		SetNVar(UPlayer,SetTo,7);
		TSetNVar(WaveXUType,SetTo,GU2);
	},{Preserved})

CIfXEnd()
DoActionsX(FP,{SetNVar(WaveUType,Subtract,1*16777216,0xFF000000)})

CIf(FP,{Memory(0x628438,AtLeast,1)})
	CIfX(FP,NVar(WaveUType,AtLeast,194,0xFFFF)) -- HUnit , GUnit
		CDoActions(FP,{
			TCreateUnit(1,WaveXUType,"CLoc106",UPlayer);
		})
	CElseIfX({NVar(WaveUType,AtLeast,192,0xFFFF),NVar(WaveUType,AtMost,193,0xFFFF)}) -- 잡몹
		CDoActions(FP,{
			TCreateUnit(1,WaveXUType,"CLoc106",P8);
		})
	CIfXEnd()
CIfEnd()

Trigger {
	players = {FP},
	conditions = {
			Label(0x1008);
		},
}

CJumpEnd(FP,0x105)

CJump(FP,0x106)
CallWaveCAPlot = SetCallForward()

SetCall(FP)
CAPlot(WaveShapesArr,P6,191,"CLoc106",WCenter,1,32,{WaveShape,0,0,0,600,WaveDataIndex},nil,FP,
	nil,{SetNext("X",0x1007),SetNext(0x1008,"X",1)},nil)
SetCallEnd()

CJumpEnd(FP,0x106)

--< Wave Cylce Control / Wave Level >--
WaveSwitch = CreateCcode()
WaveTempShape = CreateVar(FP)
GUnitArr = {88,58,66,65,87,60,61,99,9,23,102,68,22}
HUnitArr = {77,78,80,21,79,98,75,86,27,2,28,52,60}
TimeLineArr = {6,12,18,24,30,36,42,48,54,60,66,72,78}
LTimeLineArr = {4,8,12,17,24,28,34,39,44,47,52,58,63}

WaveControlCFunc = InitCFunc(FP)
CFunc(WaveControlCFunc)
TriggerX(FP,{CVar("X",GMode,Exactly,2),NVar(RTimer,AtLeast,0)},{SetNVar(VMod,SetTo,60*5),SetNVar(GU3,SetTo,75)})
TriggerX(FP,{CVar("X",GMode,Exactly,3),NVar(RTimer,AtLeast,0)},{SetNVar(VMod,SetTo,60*5),SetNVar(GU3,SetTo,32)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*30)},{
	SetNVar(VMod,SetTo,60*15),SetNVar(HU1,SetTo,77),SetNVar(HU2,SetTo,78),
	SetNVar(HU3,SetTo,70),SetNVar(HU4,SetTo,70)})

TriggerX(FP,{NVar(RTimer,AtLeast,60*60)},{ -- 1시간
	SetNVar(VMod,SetTo,60*15),SetNVar(HU1,SetTo,19),SetNVar(HU2,SetTo,75),
	SetNVar(HU3,SetTo,80),SetNVar(HU4,SetTo,21),SetNVar(GU1,SetTo,65),SetNVar(GU2,SetTo,88)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*90)},{ -- 1시간 30분
	SetNVar(VMod,SetTo,60*15),SetNVar(HU1,SetTo,17),SetNVar(HU2,SetTo,79),
	SetNVar(HU3,SetTo,80),SetNVar(HU4,SetTo,21),SetNVar(GU1,SetTo,66),SetNVar(GU2,SetTo,8)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*150)},{ -- 2시간 30분
	SetNVar(VMod,SetTo,60*30),SetNVar(HU1,SetTo,32),SetNVar(HU2,SetTo,93),
	SetNVar(HU3,SetTo,86),SetNVar(HU4,SetTo,12),SetNVar(GU1,SetTo,61),SetNVar(GU2,SetTo,28)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*210)},{ -- 3시간 30분
	SetNVar(VMod,SetTo,60*30),SetNVar(HU1,SetTo,3),SetNVar(HU2,SetTo,100),
	SetNVar(HU3,SetTo,86),SetNVar(HU4,SetTo,12),SetNVar(GU1,SetTo,87),SetNVar(GU2,SetTo,60)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*270)},{ -- 4시간 30분
	SetNVar(VMod,SetTo,60*30),SetNVar(HU1,SetTo,81),SetNVar(HU2,SetTo,10),
	SetNVar(HU3,SetTo,98),SetNVar(HU4,SetTo,58),SetNVar(GU1,SetTo,68),SetNVar(GU2,SetTo,99)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*390)},{ -- 6시간 30분
	SetNVar(VMod,SetTo,60*60),SetNVar(HU1,SetTo,64),SetNVar(HU2,SetTo,52),
	SetNVar(HU3,SetTo,98),SetNVar(HU4,SetTo,58),SetNVar(GU1,SetTo,23),SetNVar(GU2,SetTo,102)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*510)},{ -- 8시간 30분
	SetNVar(VMod,SetTo,60*60),SetNVar(HU1,SetTo,2),SetNVar(HU2,SetTo,16),
	SetNVar(HU3,SetTo,98),SetNVar(HU4,SetTo,58),SetNVar(GU1,SetTo,68),SetNVar(GU2,SetTo,9)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*630)},{ -- 10시간 30분
	SetNVar(VMod,SetTo,60*60),SetNVar(HU1,SetTo,65),SetNVar(HU2,SetTo,66),
	SetNVar(HU3,SetTo,28),SetNVar(HU4,SetTo,60),SetNVar(GU1,SetTo,68),SetNVar(GU2,SetTo,22)})
CFuncEnd()

CIfX(FP,{CVar("X",GMode,AtMost,2)})
	CIfX(FP,{CVar("X",GMode,Exactly,1)},{SetNVar(WaveTempShape,SetTo,1)}) -- Normal
		TriggerX(FP,{NVar(RTimer,AtLeast,0)},{SetNVar(VMod,SetTo,60*5),SetNVar(GU3,SetTo,77)})
		TriggerX(FP,{NVar(RTimer,AtLeast,60*60)},{
			SetNVar(VMod,SetTo,60*15),SetNVar(HU1,SetTo,77),SetNVar(HU2,SetTo,78),SetNVar(HU3,SetTo,70),SetNVar(HU4,SetTo,70)})

	CElseX({SetNVar(WaveTempShape,SetTo,5)}) -- Hard
		TriggerX(FP,{NVar(RTimer,AtLeast,60*180)},{ -- 3시간일때
			CopyCpAction({
				RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F1");
				RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F2");
				RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F3");
			},{Force2},FP)})
		CallCFuncX(FP,WaveControlCFunc)
	CIfXEnd()
	for i = 1, #HUnitArr do -- Normal, Hard GUnitWave
		TriggerX(FP,{NVar(RTimer,Exactly,60*TimeLineArr[i])},{SetNVar(GU4,SetTo,HUnitArr[i]),SetCDeaths("X",SetTo,1,WaveSwitch)})
	end
	CIf(FP,{CDeaths("X",Exactly,1,WaveSwitch)},SetCDeaths("X",Subtract,1,WaveSwitch))
			CMov(FP,UIDVar,GU4,0,0xFFFF)
			CallTrigger(FP,SetGUnitHP)
			NLoopX(FP,2,{CVar("X",GMode,Exactly,1)}) -- Normal
				SetNextptr()
					CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
						TCreateUnit(1,GU4,"FBossInit",P8);
						TOrder(GU4,P8,"FBossInit",Attack,"HZ");
					},{Preserved})
			NWhileXEnd()
			NLoopX(FP,3,{CVar("X",GMode,Exactly,2)}) -- Hard
				SetNextptr()
					CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
						TCreateUnit(1,GU4,"FBossInit",P8);
						TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
						TOrder(GU4,P8,"FBossInit",Attack,"HZ");
					},{Preserved})
			NWhileXEnd()
	CIfEnd()
CElseX({SetNVar(WaveTempShape,SetTo,9)}) -- Lunactic
TriggerX(FP,{NVar(RTimer,AtLeast,60*150)},{ -- 퍼실정야독
	CopyCpAction({
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F1");
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F2");
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","F3");
	},{Force2},FP)})
	CallCFuncX(FP,WaveControlCFunc)
	for i = 1, #GUnitArr do -- Lunatic GUnitWave
		TriggerX(FP,{NVar(RTimer,Exactly,60*LTimeLineArr[i])},{SetNVar(GU4,SetTo,GUnitArr[i]),SetCDeaths("X",SetTo,1,WaveSwitch)})
	end
		CIf(FP,{CDeaths("X",Exactly,1,WaveSwitch)},SetCDeaths("X",Subtract,1,WaveSwitch))
			CMov(FP,UIDVar,GU4,0,0xFFFF)
			CallTrigger(FP,SetGUnitHP)
			NLoopX(FP,2)
				SetNextptr()
					CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
						TCreateUnit(1,GU4,"FBossInit",P8);
						TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
						TOrder(GU4,P8,"FBossInit",Attack,"HZ");
					},{Preserved})
			NWhileXEnd()
		CIfEnd()
CIfXEnd()

f_Mod(FP,WTimer,RTimer,VMod) -- Calc WTimer
TriggerX(FP,{NVar(WTimer,Exactly,2)},{SetNVar(WaveSW,SetTo,0)},{Preserved}) -- UnLock

CIf(FP,{ElapsedTime(AtLeast,60*2),NDeaths(FP,Exactly,1,LvlJump),NVar(WTimer,AtMost,1),NVar(WaveSW,Exactly,0)})
	CDoActions(FP,{-- GroundX
		SetNVar(WaveUType,SetTo,192,0xFFFF);
		SetNVar(WaveDataIndex,SetTo,1);
		TSetNVar(WaveShape,SetTo,WaveTempShape); -- #1
	})
	CallTrigger(FP,CallWaveCAPlot)
	CDoActions(FP,{-- AirX
		SetNVar(WaveUType,SetTo,193,0xFFFF);
		SetNVar(WaveDataIndex,SetTo,1);
		TSetNVar(WaveShape,SetTo,WaveTempShape); -- #1
	})
	CallTrigger(FP,CallWaveCAPlot)
		CIfX(FP,NVar(RTimer,AtLeast,60*30)) -- HUnitWave
			CTrigger(FP,{NVar(RTimer,AtMost,60*60-1)},{ -- HUnit Ground
				TSetNVar(WaveShape,SetTo,_Add(WaveTempShape,3)); -- #2
				SetNVar(WaveUType,SetTo,194,0xFFFF);
				SetNVar(WaveDataIndex,SetTo,1);
			},{Preserved})
			CallTrigger(FP,CallWaveCAPlot)

			CTrigger(FP,{NVar(RTimer,AtLeast,60*60),CVar("X",GMode,AtLeast,2)},{ -- HUnit Air
				TSetNVar(WaveShape,SetTo,_Add(WaveTempShape,2)); -- #3
				SetNVar(WaveUType,SetTo,195,0xFFFF);
				SetNVar(WaveDataIndex,SetTo,1);
			},{Preserved})
			CallTrigger(FP,CallWaveCAPlot)
			CTrigger(FP,{NVar(RTimer,AtLeast,60*60),CVar("X",GMode,AtLeast,2)},{ -- GUnit Wave
				TSetNVar(WaveShape,SetTo,_Add(WaveTempShape,3)); -- #4
				SetNVar(WaveUType,SetTo,196,0xFFFF);
				SetNVar(WaveDataIndex,SetTo,1);
			},{Preserved})
			CallTrigger(FP,CallWaveCAPlot)

		CElseX() -- NVar(RTimer,AtMost,60*29+59)) 초반 영작유닛 웨이브
			CIf(FP,{Memory(0x628438,AtLeast,1)})
			SetNextptr()
				CDoActions(FP,{TSetNVar(WaveXUType,SetTo,GU3)})
				CMov(FP,UIDVar,WaveXUType,0,0xFFFF)
				CallTrigger(FP,SetGUnitHP)
					CDoActions(FP,{
						TCreateUnit(1,WaveXUType,"FBossInit",P8);
						TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
						TSetMemoryX(Vi(Nextptr[2],9),SetTo,1*65536,0xFF0000);
						TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
						TOrder(WaveXUType,P8,"FBossInit",Attack,"HZ");
					})
			CIfEnd()
		CIfXEnd()
	DoActionsX(FP,{SetNVar(WaveSW,SetTo,1),Order("Men",Force2,"WaveLoc",Attack,"HZ")}) -- Lock
CIfEnd()



--< Attack Factories >--
TriggerX(FP,{NVar(XUnitAttackTimer,Exactly,0)},{
	SetNVar(XUnitAttackTimer,SetTo,36*60);
	Order("Factories",Force2,"Anywhere",Attack,"HZ");
},{Preserved})
DoActionsX(FP,SetNVar(XUnitAttackTimer,Subtract,1))

--------------------------<	 Murphy Trig  >--------------------------
MStack, CenterUpgrade, LFieldTimer, RFieldTimer, CFieldTimer, UpgradeLvl, PSwitch = CreateCcodes(7)
InitPosY1, InitPosY2, InitPosY3, PTimer = CreateVars(4,FP)
-- M1,M2 = 적 업그레이드+ 정야독(0xFF, 0xFF00)
-- M3 = 웨이브 강화 GUnit 스위치, 정야독이속Max (0xFF0000) // M4 = 중보웨이브, 제로(0xFF000000)
-- M1 -> M2 -> M3 -> M4
-- M2 -> M1 -> M3 -> M4

UpgradeP6Arr = {}
for i = 0, 15 do
	table.insert(UpgradeP6Arr,SetMemoryB(0x58D2B0+(5*46)+i,Add,1))
end
UpgradeP7Arr = {}
for i = 0, 15 do
	table.insert(UpgradeP7Arr,SetMemoryB(0x58D2B0+(6*46)+i,Add,1))
end
UpgradeP8Arr = {}
for i = 0, 15 do
	table.insert(UpgradeP8Arr,SetMemoryB(0x58D2B0+(7*46)+i,Add,1))
end
CIf(FP,{NDeaths(FP,Exactly,1,LvlJump)})

TriggerX(FP,{NVar(RTimer,AtLeast,60*60)},{KillUnitAt(1,150,"M1",P8)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*60)},{KillUnitAt(1,150,"M2",P8)})
TriggerX(FP,{NVar(RTimer,AtLeast,60*60)},{KillUnitAt(1,150,"M5",P8)})
TriggerX(FP,{NVar(RTimer,AtLeast,90*60)},{KillUnitAt(1,150,"M3",P8)})
TriggerX(FP,{NVar(RTimer,AtLeast,120*60)},{KillUnitAt(1,150,"M4",P8)})

	TriggerX(FP,{Bring(P8,Exactly,0,150,"M1")},{SetCDeathsX("X",SetTo,1,MStack,0xFF)}) -- LField
	TriggerX(FP,{Bring(P8,Exactly,0,150,"M2")},{SetCDeathsX("X",SetTo,1*256,MStack,0xFF00)}) -- RField
	TriggerX(FP,{Bring(P8,Exactly,0,150,"M3")},{SetCDeathsX("X",SetTo,1*65536,MStack,0xFF0000)}) -- WaveUpgrade
	TriggerX(FP,{Bring(P8,Exactly,0,150,"M4")},{SetCDeathsX("X",SetTo,1*16777216,MStack,0xFF000000)}) -- MBossWave
	TriggerX(FP,{Bring(P8,Exactly,0,150,"M5")},{SetCDeathsX("X",SetTo,1,CenterUpgrade,0xFF)}) -- CField

	TriggerX(FP,{CDeathsX("X",Exactly,1,CenterUpgrade,0xFF)},{SetCDeaths("X",Add,1,CFieldTimer)},{Preserved}) -- CenterTimer
	TriggerX(FP,{CDeathsX("X",Exactly,1,MStack,0xFF)},{SetCDeaths("X",Add,1,LFieldTimer)},{Preserved}) -- LeftTimer
	TriggerX(FP,{CDeathsX("X",Exactly,1*256,MStack,0xFF00)},{SetCDeaths("X",Add,1,RFieldTimer)},{Preserved}) -- RightTimer

	CIf(FP,{CDeaths("X",AtLeast,34*40*60,CFieldTimer),CDeathsX("X",AtMost,2,UpgradeLvl,0xFF)}) -- Max +3
		DoActionsX(FP,{SetCDeaths("X",SetTo,0,CFieldTimer),SetCDeathsX("X",Add,1,UpgradeLvl,0xFF)}) -- Max +3
		DoActions2(FP,UpgradeP8Arr)
	CIfEnd()
	CIf(FP,{CDeaths("X",AtLeast,34*40*60,LFieldTimer),CDeathsX("X",AtMost,2*256,UpgradeLvl,0xFF00)}) -- Max +3
		DoActionsX(FP,{SetCDeaths("X",SetTo,0,LFieldTimer),SetCDeathsX("X",Add,1*256,UpgradeLvl,0xFF00)}) -- Max +3
		DoActions2(FP,UpgradeP6Arr)
	CIfEnd()
	CIf(FP,{CDeaths("X",AtLeast,34*40*60,RFieldTimer),CDeathsX("X",AtMost,2*65536,UpgradeLvl,0xFF0000)}) -- Max +3
		DoActionsX(FP,{SetCDeaths("X",SetTo,0,RFieldTimer),SetCDeathsX("X",Add,1*65536,UpgradeLvl,0xFF0000)}) -- Max +3
		DoActions2(FP,UpgradeP7Arr)
	CIfEnd()

TriggerX(FP,{CDeathsX("X",Exactly,1,MStack,0xFF)},{SetNVar(InitPosY1,SetTo,2048)})
TriggerX(FP,{CDeathsX("X",Exactly,1*256,MStack,0xFF00)},{SetNVar(InitPosY2,SetTo,8192-2048)})
TriggerX(FP,{CDeathsX("X",Exactly,1,CenterUpgrade,0xFF)},{SetNVar(InitPosY3,SetTo,1024)}) -- CField

--------------------------<	Create Murphy Unit >--------------------------
f_Mod(FP,PTimer,RTimer,60*15) -- Calc PTimer

CIf(FP,{CVar("X",GMode,AtLeast,2),CDeaths("X",Exactly,0,PSwitch),NVar(PTimer,Exactly,1)})
	CIf(FP,{CDeathsX("X",Exactly,1,MStack,0xFF)},{SetNVar(InitPosY1,Add,512)})
		TriggerX(FP,{NVar(InitPosY1,AtLeast,8192-(512+1))},{SetNVar(InitPosY1,SetTo,512)},{Preserved})
		Simple_SetLocX(FP,23,512-32,_Sub(InitPosY1,32),512+32,_Add(InitPosY1,32),{RemoveUnitAt(1,72,"CLoc24",P12),CreateUnit(1,84,"CLoc24",P5)})

		NLoopX(FP,25,{Memory(0x628438,AtLeast,1)})
			CIfX(FP,{CDeathsX("X",Exactly,0*65536,MStack,0xFF0000)})
				DoActions(FP,{CreateUnit(1,88,"CLoc24",P6)})
			CElseIfX({CDeathsX("X",Exactly,1*65536,MStack,0xFF0000)})
				SetNextptr()
				CDoActions(FP,{
					CreateUnit(1,88,"CLoc24",P6);
					TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
					TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
				})
			CIfXEnd()
		NWhileXEnd()

		NLoopX(FP,5,{Memory(0x628438,AtLeast,1),CVar("X",GMode,Exactly,3),CDeathsX("X",Exactly,1*16777216,MStack,0xFF000000)})
			SetNextptr()
			CDoActions(FP,{
				CreateUnit(1,99,"M1",P6);
				TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
			})
		NWhileXEnd()
	CIfEnd()
DoActionsX(FP,{CopyCpAction({
	RunAIScriptAt("Set Unit Order To: Junk Yard Dog","CLoc24");
	RunAIScriptAt("Set Unit Order To: Junk Yard Dog","M1");
},{P6},FP)})

	CIf(FP,{CDeathsX("X",Exactly,1*256,MStack,0xFF00)},{SetNVar(InitPosY2,Subtract,512)})
		TriggerX(FP,{NVar(InitPosY2,AtMost,512+1)},{SetNVar(InitPosY2,SetTo,8192-512)},{Preserved})
		Simple_SetLocX(FP,23,512*3-32,_Sub(InitPosY2,32),512*3+32,_Add(InitPosY2,32),{RemoveUnitAt(1,72,"CLoc24",P12),CreateUnit(1,84,"CLoc24",P5)})

		NLoopX(FP,25,{Memory(0x628438,AtLeast,1)})
			CIfX(FP,{CDeathsX("X",Exactly,0*65536,MStack,0xFF0000)})
				DoActions(FP,{CreateUnit(1,8,"CLoc24",P7)})
			CElseIfX({CDeathsX("X",Exactly,1*65536,MStack,0xFF0000)})
				SetNextptr()
				CDoActions(FP,{
					CreateUnit(1,8,"CLoc24",P7);
					TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
					TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
				})
			CIfXEnd()
		NWhileXEnd()

		NLoopX(FP,3,{Memory(0x628438,AtLeast,1),CVar("X",GMode,Exactly,2),CDeathsX("X",Exactly,1*16777216,MStack,0xFF000000)})
			SetNextptr()
			CDoActions(FP,{
				CreateUnit(1,102,"M2",P7);
				TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
			})
		NWhileXEnd()
	CIfEnd()
DoActionsX(FP,{CopyCpAction({
	RunAIScriptAt("Set Unit Order To: Junk Yard Dog","CLoc24");
	RunAIScriptAt("Set Unit Order To: Junk Yard Dog","M2");
},{P7},FP)})
	CIf(FP,{CDeathsX("X",Exactly,1,CenterUpgrade,0xFF)},SetNVar(InitPosY3,Add,2048))
		TriggerX(FP,{NVar(InitPosY3,AtLeast,8192-(2048+1))},{SetNVar(InitPosY3,SetTo,1024)},{Preserved})
		Simple_SetLocX(FP,23,512*2-32,_Sub(InitPosY3,32),512*2+32,_Add(InitPosY3,32),{RemoveUnitAt(1,72,"CLoc24",P12),CreateUnit(1,84,"CLoc24",P5)})
		NLoopX(FP,20,{Memory(0x628438,AtLeast,1)})
			CIfX(FP,{CDeathsX("X",Exactly,0*65536,MStack,0xFF0000)})
				DoActions(FP,{CreateUnit(1,28,"CLoc24",P8)})
			CElseIfX({CDeathsX("X",Exactly,1*65536,MStack,0xFF0000)})
				SetNextptr()
				CDoActions(FP,{
					CreateUnit(1,27,"CLoc24",P8);
					TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
					TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
				})
			CIfXEnd()
		NWhileXEnd()
		NLoopX(FP,5,{Memory(0x628438,AtLeast,1),CVar("X",GMode,Exactly,3),CDeathsX("X",Exactly,1*16777216,MStack,0xFF000000)})
			SetNextptr()
			CDoActions(FP,{
				CreateUnit(1,9,"M5",P8);
				TSetMemory(Vi(Nextptr[2],13),SetTo,12000);
				TSetMemoryX(Vi(Nextptr[2],18),SetTo,6000,0xFFFF);
			})
		NWhileXEnd()
	CIfEnd()
	
DoActionsX(FP,{
	SetCDeaths("X",SetTo,34*3,PSwitch);
	CopyCpAction({
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","CLoc24");
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","M5");
	},{P8},FP);
})
CIfEnd()

CIfEnd() -- GunTrig Lock ( 건작잠금 )

CIfEnd() -- NVar(HeroSetting,Exactly,1)
DoActionsX(FP,{SetCDeaths("X",Subtract,1,PSwitch)})
------<  Extra GunTrig Shape & Timer >------------------------------------------

EG_Hard1 = CSMakePolygon(4,60,0,5,4)
EG_Hard2 = CSMakePolygon(4,60,0,5,3)
EG_Hard3 = CSMakePolygon(4,60,0,5,2)
EG_Hard4 = CSMakePolygon(4,60,0,5,1)
EG_Hard5 = CSMakePolygon(4,60,0,5,0)
EG_Lunatic1 = CSMakePolygon(6,60,0,7,5)
EG_Lunatic2 = CSMakePolygon(6,60,0,7,4)
EG_Lunatic3 = CSMakePolygon(6,60,0,7,3)
EG_Lunatic4 = CSMakePolygon(6,60,0,7,2)
EG_Lunatic5 = CSMakePolygon(6,60,0,7,1)
EG_Lunatic6 = CSMakePolygon(6,60,0,7,0)
ExtraShapeArr = {EG_Hard1,EG_Hard2,EG_Hard3,EG_Hard4,EG_Hard5,
				EG_Lunatic1,EG_Lunatic2,EG_Lunatic3,EG_Lunatic4,EG_Lunatic5,EG_Lunatic6}

BackupPos, BPosX, BPosY, BPosXY, HUnitRand, GUnitRand, EXShape = CreateVars(7,FP)

-- Unavailable Trig--
TriggerX(FP,{NVar(RTimer,AtMost,60*15)},{
	SetMemoryB(0x58CF44+24*5+14,SetTo,0); -- Technologies Available (0-23)
	SetMemoryB(0x58CF44+24*6+14,SetTo,0);
	SetMemoryB(0x58CF44+24*7+14,SetTo,0);
	SetMemoryB(0x57F27C+44+5,SetTo,1); -- Guardian X
	SetMemoryB(0x57F27C+44+6,SetTo,1);
	SetMemoryB(0x57F27C+44+7,SetTo,1);
	SetMemoryB(0x57F27C+62+5,SetTo,1); -- Devourer X
	SetMemoryB(0x57F27C+62+6,SetTo,1);
	SetMemoryB(0x57F27C+62+7,SetTo,1);
},{Preserved})
TriggerX(FP,{NVar(RTimer,AtLeast,60*30)},{
	SetMemoryB(0x58CF44+24*5+14,SetTo,1);
	SetMemoryB(0x58CF44+24*6+14,SetTo,1);
	SetMemoryB(0x58CF44+24*7+14,SetTo,1);
})

CIfX(FP,CVar("X",GMode,Exactly,2))
	TriggerX(FP,NVar(RTimer,AtLeast,60*0),SetNVar(EXShape,SetTo,1))
	TriggerX(FP,NVar(RTimer,AtLeast,60*30),SetNVar(EXShape,SetTo,2))
	TriggerX(FP,NVar(RTimer,AtLeast,60*60),SetNVar(EXShape,SetTo,3))
	TriggerX(FP,NVar(RTimer,AtLeast,60*90),SetNVar(EXShape,SetTo,4))
	TriggerX(FP,NVar(RTimer,AtLeast,60*120),SetNVar(EXShape,SetTo,5))
CElseIfX(CVar("X",GMode,Exactly,3))
	TriggerX(FP,NVar(RTimer,AtLeast,60*0),SetNVar(EXShape,SetTo,6))
	TriggerX(FP,NVar(RTimer,AtLeast,60*45),SetNVar(EXShape,SetTo,7))
	TriggerX(FP,NVar(RTimer,AtLeast,60*90),SetNVar(EXShape,SetTo,8))
	TriggerX(FP,NVar(RTimer,AtLeast,60*135),SetNVar(EXShape,SetTo,9))
	TriggerX(FP,NVar(RTimer,AtLeast,60*180),SetNVar(EXShape,SetTo,10))
	TriggerX(FP,NVar(RTimer,AtLeast,60*225),SetNVar(EXShape,SetTo,11))
CIfXEnd()

Ending1 = CreateCcode()

CIf(FP,{CDeaths("X",Exactly,1,Ending1)})
	TriggerX(FP,{CVar("X",CPlayer,Exactly,1)},{SetMemoryB(0x58D2B0+(0*46)+7,SetTo,150)}) -- 솔플 공1.5배
	Install_FBoss()
CIfEnd()

------< Cunit4X InstallHeroPoint & Extra GunTrig >------------------------------------------
JYD_PosX, JYD_PosY, JYD_Player, JYD_Unit, CoEfficient, EXGunP = CreateVars(6,FP)

DeathM1 = "\x12\x1F─━┫\x06 [1 Player]\x04의 \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathM2 = "\x12\x1F─━┫\x0E [2 Player]\x04의 \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathM3 = "\x12\x1F─━┫\x0F [3 Player]\x04의 \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathM4 = "\x12\x1F─━┫\x10 [4 Player]\x04의 \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathM5 = "\x12\x1F─━┫\x11 [5 Player]\x04의 \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathHM1 = "\x12\x1F─━┫\x06 [1 Player]\x04의 \x03H\x04ero \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathHM2 = "\x12\x1F─━┫\x0E [2 Player]\x04의 \x03H\x04ero \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathHM3 = "\x12\x1F─━┫\x0F [3 Player]\x04의 \x03H\x04ero \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathHM4 = "\x12\x1F─━┫\x10 [4 Player]\x04의 \x03H\x04ero \x1CM\x04arine 이 \x06사망\x04하였습니다."
DeathHM5 = "\x12\x1F─━┫\x11 [5 Player]\x04의 \x03H\x04ero \x1CM\x04arine 이 \x06사망\x04하였습니다."

DeathMArr = {DeathM1,DeathM2,DeathM3,DeathM4,DeathM5}
DeathHMArr = {DeathHM1,DeathHM2,DeathHM3,DeathHM4,DeathHM5}

CunitCtrig_Part1(FP)
MoveCp("X",25*4) -- UnitID (EPD 25)
Call_SaveCp() -- EPD 25
NJumpX(FP,0x306,DeathsX(CurrentPlayer,Exactly,0,0,0xFF))
NJumpX(FP,0x306,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
NJumpX(FP,0x308,DeathsX(CurrentPlayer,Exactly,116,0,0xFF)) -- Facility

CJump(FP,0x307)
NJumpXEnd(FP,0x306)
CIf(FP,DeathsX(CurrentPlayer,Exactly,0,0,0xFF))
	DoActions(FP,MoveCp(Subtract,6*4))
	for i = 1, 5 do
		CIf(FP,DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF))
			Call_SaveCp() -- EPD 19
			TriggerX(FP,{},{
				CopyCpAction({DisplayTextX(DeathMArr[i],4),PlayWAVX("staredit\\wav\\Deaths.ogg")},{Force1,Force5},FP);
				SetScore(i-1, Add, 1, Custom);
			},{Preserved})
			Call_LoadCp()
		CIfEnd()
	end
	DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
	DoActions(FP,MoveCp(Subtract,6*4))
			for i = 1, 5 do
				CIf(FP,DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF))
					Call_SaveCp() -- EPD 19
					TriggerX(FP,{},{CopyCpAction({DisplayTextX(DeathHMArr[i],4);
					PlayWAVX("staredit\\wav\\Deaths.ogg");
					},{Force1,Force5},FP)},{Preserved})
					Call_LoadCp()
				CIfEnd()
			end
	DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

ClearCalc() -- 마린,영마 계산단락종료
CJumpEnd(FP,0x307)

Call_SaveCp() -- EPD 25
DoActions(FP,MoveCp(Subtract,16*4))
CIf(FP,{DeathsX(CurrentPlayer,Exactly,1*65536,0,0xFF0000)},SetDeathsX(CurrentPlayer,SetTo,0*65536,0,0xFF0000)) -- EPD 9 ( 1 = 영작유닛표식 )
	DoActions(FP,MoveCp(Add,16*4))
for i = 1, 43 do
	TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,HInfoArr[i][1],0,0xFF)},{
		CopyCpAction({DisplayTextX(HInfoArr[i][2],4)},{Force1,Force5},FP);
		CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},{Force1,Force5},FP);
		SetScore(Force1,Add,HInfoArr[i][3],Kills);
	},{Preserved})
end
	TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,150,0,0xFF)},{
		CopyCpAction({DisplayTextX(BT1,4)},{Force1,Force5},FP);
		CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},{Force1,Force5},FP);
		SetScore(Force1,Add,100000,Kills);
	},{Preserved})
	TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,226,0,0xFF)},{
		CopyCpAction({DisplayTextX(BT2,4)},{Force1,Force5},FP);
		CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},{Force1,Force5},FP);
		SetScore(Force1,Add,70000,Kills);
	},{Preserved})
	TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,220,0,0xFF)},{
		CopyCpAction({DisplayTextX(BT3,4)},{Force1,Force5},FP);
		CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},{Force1,Force5},FP);
		SetScore(Force1,Add,30000,Kills);
	},{Preserved})
CIfEnd()
Call_LoadCp() -- EPD 25

CIf(FP,{CVar("X",GMode,AtLeast,2),TNVar(RTimer,AtLeast,JYDTimer)})
	Call_SaveCp() -- EPD 25
	DoActions(FP,MoveCp(Add,30*4)) -- Status Flags ( EPD 55 )

	NJump(FP,0x300,DeathsX(CurrentPlayer,Exactly,0x2,0,0x2)) -- 건물일때
	ClearCalc()
	CJump(FP,0x304)
	NJumpEnd(FP,0x300)

	CIf(FP,{ElapsedTime(AtLeast,10*30)})
		DoActions(FP,MoveCp(Subtract,36*4)) -- PlayerID ( EPD 19 )
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,5,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			JYD_Arr = {{5,1,88},{7,2,27},{6,3,8}}
			for i = 1 ,3 do
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,JYD_Arr[i][1],0,0xFF)},{
				SetNVar(JYD_Player,SetTo,JYD_Arr[i][1]);
				SetNVar(CoEfficient,SetTo,JYD_Arr[i][2]);
				SetNVar(JYD_Unit,SetTo,JYD_Arr[i][3])
			},{Preserved})
			end
			DoActions(FP,MoveCp(Add,6*4))
			CDoActions(FP,{
				TSetNVar(JYD_PosX,SetTo,_Mul(CoEfficient,512));
				TSetNVar(JYD_PosY,SetTo,_Mul(_Add(SaveJYDGunTimer,2),128));
			})
			Simple_SetLocX(FP,23,_Sub(JYD_PosX,64),_Sub(JYD_PosY,64),_Add(JYD_PosX,64),_Add(JYD_PosY,64),{RemoveUnitAt(1,72,"CLoc24",P12)})
				NIf(FP,{NDeaths(FP,Exactly,1,LvlJump)},{CreateUnit(1,84,"CLoc24",P5)})
					NLoopX(FP,6,{CVar("X",GMode,Exactly,2)})
						NIf(FP,{Memory(0x628438,AtLeast,1)})
							SetNextptr()
								CDoActions(FP,{
									TCreateUnit(1,JYD_Unit,"CLoc24",JYD_Player);
									TSetMemoryX(Vi(Nextptr[2],19),SetTo,187*256,0xFF00);
									TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
								})
						NIfEnd()
					NWhileXEnd()
					NLoopX(FP,8,{CVar("X",GMode,Exactly,3)})
						NIf(FP,{Memory(0x628438,AtLeast,1)})
							SetNextptr()
								CDoActions(FP,{
									TCreateUnit(1,JYD_Unit,"CLoc24",JYD_Player);
									TSetMemoryX(Vi(Nextptr[2],19),SetTo,187*256,0xFF00);
									TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
								})
						NIfEnd()
					NWhileXEnd()
				NIfEnd()
		CIfEnd()
	CJumpEnd(FP,0x304)
	Call_LoadCp()
	CIfEnd()
CIfEnd()

NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,131,0,0xFF)) -- Hatchery
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,134,0,0xFF)) -- Canal
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,135,0,0xFF)) -- Den
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,136,0,0xFF)) -- Mound
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,137,0,0xFF)) -- GSpire
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,138,0,0xFF)) -- Queen
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,139,0,0xFF)) -- Chamber
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,140,0,0xFF)) -- Cavern
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,141,0,0xFF)) -- Spire
NJumpX(FP,0x301,DeathsX(CurrentPlayer,Exactly,142,0,0xFF)) -- Pool

ClearCalc()

CJump(FP,0x302)
NJumpXEnd(FP,0x301)
	DoActions(FP,MoveCp(Subtract,15*4))
	Call_SaveCp() -- ExtraGunPos Save ( EPD 10 )
	CMov(FP,BPosXY,_Read(BackupCp))
	CMov(FP,BPosX,_Mov(BPosXY,0xFFFF))
	CMov(FP,BPosY,_Div(_Mov(BPosXY,0xFFFF0000),65536))
	Simple_SetLocX(FP,6,_Sub(BPosX,96*4),_Sub(BPosY,96*4),_Add(BPosX,96*4),_Add(BPosY,96*4))

ExtraGunCAPlot = CAPlotForward()
CJump(FP,0x305)

Trigger {
	players = {FP},
	conditions = {
			Label(0x1005);
		},
}

NIf(FP,Memory(0x628438,AtLeast,1))
	SetNextptr()
		CIfX(FP,{TCVar("X",ExtraGunCAPlot[6],AtMost,EXGunDataIndex)})
			f_Mod(FP,HUnitRand,_Rand(),23) -- 0~22 ( 23 )
			-- CMov(FP,UIDVar,VArr(HUArr,HUnitRand),0,0xFFFF)
			-- CallTrigger(FP,SetGUnitHP)
				DoActionsX(FP,Simple_CalcLoc("CLoc7",-128,-128,128,128))
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
					TCreateUnit(1,VArr(HUArr,HUnitRand),"CLoc7",P8);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
					TSetMemoryX(Vi(Nextptr[2],57),SetTo,VFlag,0xFF);
					TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
					TSetMemoryX(Vi(Nextptr[2],73),SetTo,VFlag256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
					TOrder(VArr(HUArr,HUnitRand),P8,"CLoc7",Attack,"HZ");
				},{Preserved})
		CElseIfX({TCVar("X",ExtraGunCAPlot[6],AtLeast,_Add(EXGunDataIndex,1))})
			f_Mod(FP,GUnitRand,_Rand(),18) -- 0~17 ( 18 )
			-- CMov(FP,UIDVar,VArr(GUArr,GUnitRand),0,0xFFFF)
			-- CallTrigger(FP,SetGUnitHP)
				DoActionsX(FP,Simple_CalcLoc("CLoc7",-128,-128,128,128))
				CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
					TCreateUnit(1,VArr(GUArr,GUnitRand),"CLoc7",P8);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],55),SetTo,0x100,0x100);
					TSetMemoryX(Vi(Nextptr[2],57),SetTo,VFlag,0xFF);
					TSetMemoryX(Vi(Nextptr[2],70),SetTo,255*16777216,0xFF000000);
					TSetMemoryX(Vi(Nextptr[2],73),SetTo,VFlag256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1,0xFF);
					TSetMemoryX(Vi(Nextptr[2],35),SetTo,1*256,0xFF00);
					TSetMemoryX(Vi(Nextptr[2],72),SetTo,255*16777216,0xFF000000);
					TOrder(VArr(GUArr,GUnitRand),P8,"CLoc7",Attack,"HZ");
				},{Preserved})
		CIfXEnd()
		-- CIf(FP,CVar("X",GMode,Exactly,3))
		-- 	CTrigger(FP,{Memory(0x628438,AtLeast,1)},{
		-- 		TSetMemory(Vi(Nextptr[2],2),SetTo,HPVar);
		-- 	},{Preserved})
		-- CIfEnd()
NIfEnd()

Trigger {
	players = {FP},
	conditions = {
			Label(0x1006);
		},
}

CJumpEnd(FP,0x305)

	CAPlot(ExtraShapeArr,P8,181,6,nil,1,32,{EXShape,0,0,0,600,0},nil,FP,
			{CVar("X",GMode,AtLeast,2)},{SetNext("X",0x1005),SetNext(0x1006,"X",1)},nil)
		CMov(FP,V(ExtraGunCAPlot[6]),1)
	Call_LoadCp() -- EPD 10


DoActions(FP,MoveCp(Add,9*4)) -- EPD 19
CIfX(FP,{DeathsX(CurrentPlayer,Exactly,5,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,5))
	CElseIfX({DeathsX(CurrentPlayer,Exactly,6,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,6))
	CElseIfX({DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,7))
CIfXEnd()

DoActions(FP,{MoveCp(Add,6*4)}) -- EPD 25

CJump(FP,0x309)
NJumpXEnd(FP,0x308) -- 퍼실일때 도착지점
DoActions(FP,MoveCp(Subtract,15*4))
	Call_SaveCp() -- ExtraGunPos Save ( EPD 10 )
	CMov(FP,BPosXY,_Read(BackupCp))
	CMov(FP,BPosX,_Mov(BPosXY,0xFFFF))
	CMov(FP,BPosY,_Div(_Mov(BPosXY,0xFFFF0000),65536))
	Simple_SetLocX(FP,6,_Sub(BPosX,96*4),_Sub(BPosY,96*4),_Add(BPosX,96*4),_Add(BPosY,96*4)) -- CLoc7
	Call_LoadCp()
DoActions(FP,MoveCp(Add,9*4)) -- EPD 19
CIfX(FP,{DeathsX(CurrentPlayer,Exactly,5,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,5))
	CElseIfX({DeathsX(CurrentPlayer,Exactly,6,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,6))
	CElseIfX({DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
		DoActionsX(FP,SetNVar(EXGunP,SetTo,7))
CIfXEnd()

CTrigger(FP,{
	CVar("X",GMode,Exactly,1);
	NVar(EXGunP,Exactly,5);
},{
	TCreateUnit(25,80,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P6},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,1);
	NVar(EXGunP,Exactly,6);
},{
	TCreateUnit(25,21,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P7},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,1);
	NVar(EXGunP,Exactly,7);
},{
	TCreateUnit(13,21,"CLoc7",EXGunP);
	TCreateUnit(13,80,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P8},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,2);
	NVar(EXGunP,Exactly,5);
},{
	TCreateUnit(10,60,"CLoc7",EXGunP);
	TCreateUnit(25,98,"CLoc7",EXGunP);
	TCreateUnit(30,25,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P6},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,2);
	NVar(EXGunP,Exactly,6);
},{
	TCreateUnit(10,28,"CLoc7",EXGunP);
	TCreateUnit(25,58,"CLoc7",EXGunP);
	TCreateUnit(30,25,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P7},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,2);
	NVar(EXGunP,Exactly,7);
},{
	TCreateUnit(5,28,"CLoc7",EXGunP);
	TCreateUnit(5,60,"CLoc7",EXGunP);
	TCreateUnit(13,58,"CLoc7",EXGunP);
	TCreateUnit(13,98,"CLoc7",EXGunP);
	TCreateUnit(50,25,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P8},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,3);
	NVar(EXGunP,Exactly,5);
},{
	TCreateUnit(3,9,"CLoc7",EXGunP);
	TCreateUnit(5,99,"CLoc7",EXGunP);
	TCreateUnit(25,60,"CLoc7",EXGunP);
	TCreateUnit(30,23,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P6},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,3);
	NVar(EXGunP,Exactly,6);
},{
	TCreateUnit(3,9,"CLoc7",EXGunP);
	TCreateUnit(5,102,"CLoc7",EXGunP);
	TCreateUnit(25,28,"CLoc7",EXGunP);
	TCreateUnit(30,68,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P7},FP)
},{Preserved})
CTrigger(FP,{
	CVar("X",GMode,Exactly,3);
	NVar(EXGunP,Exactly,7);
},{
	TCreateUnit(1,22,"CLoc7",EXGunP);
	TCreateUnit(2,9,"CLoc7",EXGunP);
	TCreateUnit(3,99,"CLoc7",EXGunP);
	TCreateUnit(3,102,"CLoc7",EXGunP);
	TCreateUnit(12,60,"CLoc7",EXGunP);
	TCreateUnit(12,28,"CLoc7",EXGunP);
	TCreateUnit(15,68,"CLoc7",EXGunP);
	TCreateUnit(15,23,"CLoc7",EXGunP);
	CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "CLoc7")},{P8},FP)
},{Preserved})
ClearCalc()
CJumpEnd(FP,0x309)

CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,131,0,0xFF)},{
	TCreateUnit(25,40,"CLoc7",EXGunP);
	TOrder(40,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,134,0,0xFF)},{
	TCreateUnit(1,30,"CLoc7",EXGunP);
	TCreateUnit(24,104,"CLoc7",EXGunP);
	TOrder(104,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,135,0,0xFF)},{
	TCreateUnit(25,53,"CLoc7",EXGunP);
	TOrder(53,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,136,0,0xFF)},{
	TCreateUnit(20,50,"CLoc7",EXGunP);
	TCreateUnit(6,46,"CLoc7",EXGunP);
	TOrder(50,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,137,0,0xFF)},{
	TCreateUnit(25,56,"CLoc7",EXGunP);
	TOrder(56,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,138,0,0xFF)},{
	TCreateUnit(10,45,"CLoc7",EXGunP);
	TCreateUnit(15,51,"CLoc7",EXGunP);
	TOrder(51,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,139,0,0xFF)},{
	TCreateUnit(1,30,"CLoc7",EXGunP);
	TCreateUnit(24,51,"CLoc7",EXGunP);
	TOrder(51,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,140,0,0xFF)},{
	TCreateUnit(25,48,"CLoc7",EXGunP);
	TOrder(48,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,141,0,0xFF)},{
	TCreateUnit(25,55,"CLoc7",EXGunP);
	TOrder(55,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})
CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,142,0,0xFF)},{
	TCreateUnit(25,54,"CLoc7",EXGunP);
	TOrder(54,EXGunP,"CLoc7",Attack,"HZ");
},{Preserved})

ClearCalc()
CJumpEnd(FP,0x302)
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtLeast,1*16777216,0,0xFF000000), -- Energy
	DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtMost,250*16777216,0,0xFF000000), -- Energy
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),Exactly,0*256,0,0xFF00), -- MainOrderID : Die 0x0
},
{	SetDeathsX(EPDF(0x628298-0x150*i+(40*4)),SetTo,0*16777216,0,0xFF000000);
	SetDeathsX(EPDF(0x628298-0x150*i+(35*4)),SetTo,0*256,0,0xFF00);
	SetDeathsX(EPDF(0x628298-0x150*i+(35*4)),SetTo,0,0,0xFF);
	MoveCp(Add,25*4);})
end
CunitCtrig_End()

------< Cunit4X Individual GunTrig >------------------------------------------



CIf(FP,CVar("X",GMode,AtLeast,2))
CunitCtrig_Part1(FP)
MoveCp("X",70*4)
NJumpX(FP,0x303,Deaths(CurrentPlayer,AtLeast,1*16777216,0)) -- GunTimer

DoActions(FP,{ -- GunTimer Exactly 0
	MoveCp(Add,2*4);
	SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00); -- Disable Parasite Flag
	SetDeathsX(CurrentPlayer,SetTo,0*16777216,0,0xFF000000); -- Disable Blind
	MoveCp(Subtract,37);
	SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF); -- Unused 0x8C
	MoveCp(Add,37);
})

ClearCalc()
NJumpXEnd(FP,0x303) -- If GunTimer AtLeast 1 (Arrival Point)

DoActions(FP,MoveCp(Add,3*4)) -- Unused Timer

for i = 0, 5 do -- If VFlag256 == 2^5, Set P6
Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,256*2^i,0,0xFF00)},{
	MoveCp(Subtract,16*4);
	SetDeathsX(CurrentPlayer,SetTo,2^i,0,0xFF);
	MoveCp(Add,16*4)},{Preserved})
end

ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(35*4)),Exactly,1,0,0xFF); -- EPD 35 Unused 0x8C
},
{
	MoveCp(Add,70*4)})
end
CunitCtrig_End()
CIfEnd()


CIfEnd() -- 트리거 잠금

CIfOnce(FP,{NDeaths(FP,Exactly,1,LvlJump)},{SetNVar(HeroSetting,SetTo,1)}) -- After HeroSetting
	CallTrigger(FP,Install_HeroSetting) -- 테스트
	DoActions(FP,{
		ModifyUnitEnergy(all,"Men",Force2,"Anywhere",100);
		SetMaxHP(127,0);
		SetMaxHP(147,0);
		SetMaxHP(148,0);
		SetMaxHP(174,0);
		SetMaxHP(175,0);
		SetMaxHP(150,0);
		SetMaxHP(189,0);
		SetMaxHP(190,0);
		SetMaxHP(200,0);
		SetMaxHP(201,0);
		CopyCpAction(({
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "LBDest"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "RBDest"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "LCDest"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "RCDest"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "LurkerA"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "LurkerB"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "EXR"),
			RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "EXL"),
		}),{Force2},FP);
	})
	TriggerX(FP,{CVar("X",GMode,AtLeast,2)},{ -- Hard,Lunatic SGun HP Setting
		SetMaxHP(114,35000);
		SetMaxHP(126,40000);
		SetMaxHP(130,35000);
		SetMaxHP(151,25000);
		SetMaxHP(152,50000);
		SetMaxHP(167,35000);
		ModifyUnitHitPoints(all, 114, Force2, "Anywhere", 100);
		ModifyUnitHitPoints(all, 126, Force2, "Anywhere", 100);
		ModifyUnitHitPoints(all, 130, Force2, "Anywhere", 100);
		ModifyUnitHitPoints(all, 151, Force2, "Anywhere", 100);
		ModifyUnitHitPoints(all, 152, Force2, "Anywhere", 100);
		ModifyUnitHitPoints(all, 167, Force2, "Anywhere", 100);
	})
CIfEnd()

TriggerX(FP,{isname(P2,"Minfia")},{CreateUnit(1,91,"HZ",P2)})


PrisonInvTimer = CreateCcode()

TriggerX(FP,{ -- 적유닛 20이하, 건물 0, 중보4마리 다잡았을때
	Bring(Force2,AtMost,20,"Men","Anywhere");
	Bring(Force2,Exactly,1,"Buildings","Anywhere");
	CDeathsX("X",Exactly,4*16777216,BossClearCheck,0xFF000000);
},{
	SetCDeaths("X",Add,1,PrisonInvTimer); -- 타이머 작동
},{Preserved})

FBossTxt = "\x13\x1B─━┫ \x08Ｆｉｎａｌ \x03Ｂｏｓｓ \x04:: \x08Ｒ\x04ｈｅｇｂ 를 \x06소환\x04하는중입니다...  \x1B┣━─"

TriggerX(FP,{CDeaths("X",AtLeast,34*30,PrisonInvTimer)},{
	SetInvincibility(Disable,168,P8,"Anywhere");
	CopyCpAction({MinimapPing("FBoss"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP)
}) -- 최종건물 무적해제

TriggerX(FP,{CDeaths("X",Exactly,1,Ending1)},{CopyCpAction({MinimapPing("FBossInit"),DisplayTextX(FBossTxt,4),
	PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP)})

TriggerX(FP,{Bring(P8,Exactly,0,168,"Anywhere")},{
	RemoveUnit("Any unit",Force2);
	SetSwitch("Switch 255",Set);
	SetScore(Force1,SetTo,0,Custom);
	SetCDeaths("X",SetTo,1,Ending1);
})

Trigger2(Force1,{Deaths(P11,Exactly,1,200)},{
	RunAIScript("Turn ON Shared Vision for Player 6");
	RunAIScript("Turn ON Shared Vision for Player 7");
	RunAIScript("Turn ON Shared Vision for Player 8");
})

CIf(FP,{CDeaths("X",Exactly,2,Ending1)},{SetDeaths(P10,SetTo,1,201)})

Trigger { -- 엔딩2(데스값 P10 200)
	players = {FP},
	conditions = {
	},
	actions = {
		SetDeaths(P10,SetTo,1,200);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetDeaths(P10,SetTo,1,200);

	},
}
Trigger { -- 최종보스 처치
	players = {FP},
	conditions = {
		Deaths(P10,Exactly,1,200);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――　　　　　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――　　　　　　　　　　　　　　　　　　　　\x04――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetDeaths(P10,SetTo,2,200);
		
			},
}


Trigger { -- 최종보스 처치
	players = {FP},
	conditions = {
		Deaths(P10,Exactly,2,200);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――　　　　　　　　　　　　　　　　\x04――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――　　　　　　　　　　　　\x04――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――　　　　　　　　\x04――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――　　　　\x04――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(100);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,7); Wait(1000);
		SetDeaths(P10,SetTo,3,200);
					},
}

Trigger { -- 승리조건
	players = {FP},
	conditions = {
			Deaths(P10,Exactly,3,200)
		},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04- 마린키우기 세로\x08２ \x04-\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		Wait(3000);
		Wait(3000);
		SetMemory(0x6509B0,SetTo,0);
		Victory();
		SetMemory(0x6509B0,SetTo,1);
		Victory();
		SetMemory(0x6509B0,SetTo,2);
		Victory();
		SetMemory(0x6509B0,SetTo,3);
		Victory();
		SetMemory(0x6509B0,SetTo,4);
		Victory();
		SetMemory(0x6509B0,SetTo,7);
		}
	}

CIfEnd()
--[[
TriggerX(FP,{UnixTime(AtLeast,{year = 2023, month = 6, day = 14, hour = 23, min = 59, sec = 59})},{
	CopyCpAction({Defeat()},{P1,P2,P3,P4,P5},FP);
},{Preserved})
]]--
EndCtrig()
-- 에러 체크 함수 선언 위치 --
--↑Tep에 그대로 붙여넣기----------------------------------------
SetCallErrorCheck()
ErrorCheck()
EUDTurbo(FP)

