function CCMU()
------<  캔낫 트리거  >---------------------------------------------
CanNotText = "\x13\x1F─━┫ \x06캔낫\x04이 감지되어 필드위의 \x11일부유닛\x04을 \x08삭제\x04합니다. \x1B Cannot Count +1↑ \x1F┣━─"
CanNotDefeat = "\x13\x1F─━┫ \x06캔낫 \x04카운트가 3회이상 누적되어 패배합니다. \x1B。˚Game Over。˚\x1F┣━─"

C_Delay, C_Count = CreateNcodes(2)

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

DoActionsX(FP,{SetNDeaths(FP,Subtract,1,C_Delay)})

CIf(FP,{NVar(AllUnit,AtLeast,1400),NDeaths(FP,Exactly,0,C_Delay)}) -- 유닛수 1400이상일때

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
TriggerX(FP,{Switch("Switch 255",Cleared)},{CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere")},{Force2},FP)},{Preserved})
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
TriggerX(FP,{Switch("Switch 255",Cleared)},{CopyCpAction({RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere")},{Force2},FP)},{Preserved})
CIfEnd()

TriggerX(FP,Switch("Switch 254", Set),{
	KillUnit(35,Force2),
	KillUnit(36,Force2),
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
end
