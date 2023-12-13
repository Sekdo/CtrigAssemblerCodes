function Install_Opening()

SelectView, LvlJump, LimitX, TestMode = CreateNcodes(4)

T_txt1 = "\x13\x1FΑΜΥ \x04砺什闘 獄穿脊艦陥. 繊宿獄穿生稽 巴傾戚背爽室推. \x1FΣΜΑ"
T_txt2 = "\x13\x1FΑΜΥ \x04縮越巴傾戚亜 姶走鞠醸柔艦陥.  \x1FΣΜΑ"
T_txt3 = "\x13\x1FΑΜΥ \x1B陳濃斗 十茎 痕井戚 姶走鞠醸柔艦陥. 薗!!薗!! \x1FΣΜΑ"
T_txt4 = "\x13\x1FΑΜΥ \x1B陳濃斗 曽膳 痕井戚 姶走鞠醸柔艦陥. 薗!!薗!! \x1FΣΜΑ"

    Trigger { -- 神覗閑
	players = {Force1},
	conditions = {
			Always()
		},
	actions = {
			CenterView("Anywhere");
			PlayWAV("staredit\\wav\\scan.ogg");
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\n\n\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\n\n\n\n\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04\x11Special \x04Thanks to \x1BNinfia\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊇ \x11Special \x04Thanks to \x1BNinfia \x04⊇\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
		}
}

Trigger {
	players = {Force1},
	conditions = {
			Always()
	},
	actions = {
		Wait(250);
		CenterView("Anywhere");	
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
		
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n\x13\x04- 原鍵徹酔奄 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\x13\x04⊂ \x11Special \x04Thanks to \x1BNinfia \x04⊂\n\x13\x04！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！\n",4);
		SetSwitch("Switch 249",Set);
	}
}

TriggerX(FP,{},{SetNDeaths(FP,SetTo,1,SelectView);})

CIf(FP,{Switch("Switch 249",Set)})

NJump(FP,1,{NDeaths(FP,Exactly,1,LvlJump)})

DoActionsX(FP,{
	SetNDeaths(FP,SetTo,0,TestMode);
	SetNDeaths(FP,SetTo,0,LimitX);
	ModifyUnitEnergy(all,15,Force1,"Anywhere",100);
	ModifyUnitEnergy(all,0,Force1,"Anywhere",100);
	ModifyUnitEnergy(all,194,P8,"Anywhere",100);
	ModifyUnitEnergy(all,195,P8,"Anywhere",100);
	ModifyUnitEnergy(all,196,P8,"Anywhere",100);
},{})
for i = 0, 4 do
TriggerX(FP,{isname(i,"Minfia"),NDeaths(FP,Exactly,0,TestMode)},{SetNDeaths(FP,SetTo,1,LimitX)})
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
		CreateUnit(1,96,"BanZone",P1);
		
	})
TriggerX(P2,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P2);
		CreateUnit(1,96,"BanZone",P2);
		
	})
TriggerX(P3,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		PlayerCheck(P2,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P3);
		CreateUnit(1,96,"BanZone",P3);
		
	})
TriggerX(P4,{
		Switch("Switch 249",Set);
		PlayerCheck(P1,0);
		PlayerCheck(P2,0);
		PlayerCheck(P3,0);
		NDeaths(FP,Exactly,0,LvlJump);
	},{
		CreateUnit(1,15,"Level",P4);
		CreateUnit(1,96,"BanZone",P4);
		
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
		CreateUnit(1,96,"BanZone",P5);
		
	})

for i = 0, 4 do
TriggerX(i,{Bring(CurrentPlayer,Exactly,0,15,"Level2"),NDeaths(FP,Exactly,1,SelectView);},{MoveUnit(1,15,CurrentPlayer,"Anywhere","Level")},{Preserved})
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

GModeLocArr = {"Normal","Hard"}

for i = 1, 2 do
Trigger2X(FP,{Bring(Force1,Exactly,1,15,GModeLocArr[i])},{
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
	CopyCpAction({CenterView("HZ"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},{Force1,Force5},FP);
	SetCDeaths("X",SetTo,i,GMode);
	SetNDeaths(FP,SetTo,1,LvlJump);
	SetNDeaths(FP,SetTo,0,SelectView);
	SetPlayerColor(5,SetTo,126);
	SetPlayerColor(6,SetTo,85);
	SetPlayerColor(7,SetTo,128);
	SetMinimapColor(5,SetTo,126);
	SetMinimapColor(6,SetTo,85);
	SetMinimapColor(7,SetTo,128);
	CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P6_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P6},FP);
	CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P7_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P7},FP);
	CopyCpAction({RunAIScriptAt("Expansion Zerg Campaign Insane","P8_AI"),RunAIScriptAt("Value This Area Higher","HZ")},{P8},FP);
})


end
NJumpEnd(FP,1)

CIfEnd()


end