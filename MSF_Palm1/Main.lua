
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
-- 건작보스 데스값 = 100 --
	
-- P7영작유닛 포인트삭제 데스값 = 200 (P9 데스값)--
-- 기지유닛끌당 데스값 = 201 (P9 데스값)--
-- 리더보드 데스값 = 202 (P9 데스값)--
-- 웨이브 데스값 (130~ ) --
-- 데스값 : 157(플레이어 유무확인)

FP = P8
SetForces({P1,P2,P3,P4,P5},{P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P8)
StartCtrig(1,nil,0,1,"C:\\Users\\jungt\\Documents\\euddraft0.9.3.6\\CSsave")
CJump(AllPlayers,0)
Include_CBPaint()
Include_CtrigPlib(360,"Switch 254",1)
Include_64BitLibrary("Switch 255")

CJumpEnd(AllPlayers,0)

Nextptrs = CreateVar(FP)
BossOn = CreateCcode()

NoAirCollisionX(FP)
DoActions(FP,{SetSpeed(SetTo, "#X2")})
ObserverChatToAll(FP, _Void(0xFF), nil, nil, 0)


Trigger {
	players = {P8},
	conditions = {
		Always();
	},
	actions = {
		SetMemory(0x58F44C, SetTo, 0x00000000);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Memory(0x58F44C,Exactly,1);
	},
	actions = {
		LeaderBoardScore(Kills,"\x1FP\x04oints -- 【Ver。1.0】");
	},
		flag = {Preserved}
}

Trigger {
	players = {P8},
	conditions = {
		Memory(0x58F44C,Exactly,121);
	},
	actions = {
		LeaderBoardScore(Custom,"\x06D\x04eaths -- 【Ver。1.0】");
	},
		flag = {Preserved}
}


Trigger {
	players = {P8},
	conditions = {
		Always();
	},
	actions = {
		SetMemory(0x58F44C, Add, 0x00000001);
	},
	flag = {Preserved}
}

Trigger {
	players = {P8},
	conditions = {
		Memory(0x58F44C,AtLeast,240);
	},
	actions = {
		SetMemory(0x58F44C, SetTo, 0x00000000);
	},
	flag = {Preserved}
}

Trigger { -- 
	players = {P8},
	conditions = {
	},
	actions = {
		SetMemory(0x6509A0, SetTo, 0x00000000);
	},
	flag = {Preserved}
}

Trigger { -- 컴퓨터 리더보드 비활성화
	players = {P6},
	conditions = {
			Always();
		},
	actions = {
			LeaderBoardComputerPlayers(Disable);
		}
}

Trigger { -- 퍼센트 딜 구현
	players = {Force1},
	conditions = {
		Always();
	},
	actions = {
		SetMemory(0x515B88,SetTo,256);
		SetMemory(0x515B8C,SetTo,256);
		SetMemory(0x515B90,SetTo,256);
		SetMemory(0x515B94,SetTo,256);
		SetMemory(0x515B98,SetTo,256);
		SetMemory(0x515B9C,SetTo,256);
		SetMemory(0x515BA0,SetTo,256);
		SetMemory(0x515BA4,SetTo,256);
		SetMemory(0x515BA8,SetTo,256);
		SetMemory(0x515BAC,SetTo,256);

		SetMemory(0x515BC4,SetTo,20480); -- 영마 8만
		SetMemory(0x515BC8,SetTo,10240); -- 일마 4만
 		SetMemory(0x515BCC,SetTo,5120); -- 에시비 2만
		SetMemory(0x515BD0,SetTo,40960); -- 건물 
		SetMemory(0x515BD4,SetTo,256); -- 적유닛
		PreserveTrigger();
	},
}

TriggerX(FP,{CDeaths("X",Exactly,0,BossOn)},{ -- 보스이전 쉴드체업 설정
	SetMemoryB(0x58D088+(0*46)+15,SetTo,255);
	SetMemoryB(0x58D088+(1*46)+15,SetTo,255);
	SetMemoryB(0x58D088+(2*46)+15,SetTo,255);
	SetMemoryB(0x58D088+(3*46)+15,SetTo,255);
	SetMemoryB(0x58D088+(4*46)+15,SetTo,255);
})

TriggerX(FP,{CDeaths("X",Exactly,1,BossOn)},{ -- 보스전 쉴드체업 설정
	SetMemoryB(0x58D088+(0*46)+15,SetTo,127);
	SetMemoryB(0x58D088+(1*46)+15,SetTo,127);
	SetMemoryB(0x58D088+(2*46)+15,SetTo,127);
	SetMemoryB(0x58D088+(3*46)+15,SetTo,127);
	SetMemoryB(0x58D088+(4*46)+15,SetTo,127);
	SetMemoryB(0x58D2B0+(0*46)+15,SetTo,127);
	SetMemoryB(0x58D2B0+(1*46)+15,SetTo,127);
	SetMemoryB(0x58D2B0+(2*46)+15,SetTo,127);
	SetMemoryB(0x58D2B0+(3*46)+15,SetTo,127);
	SetMemoryB(0x58D2B0+(4*46)+15,SetTo,127);
},{Preserved})

Trigger { -- 미션오브젝티브
	players = {Force1},
	conditions = {
			Always()
		},
	actions = {
		SetMissionObjectives("\x13\x04환전율 : \x1F２５．０ % \n\x13\x03※\x04아래 광산에 일마넣으시면 영마(\x1F20,000원)로 변환됩니다.\n\x13\x04 프로토스인구수 : 전체유닛수 // 테란인구수 : 기지에있는적유닛수 // 저그인구수 : 캔낫횟수\n\x13\x1FTip: \x04기지유닛수 300이상이면 벙커가 터집니다.")
	}
}

Trigger { -- 컴퓨터 유닛 못오게하기
	players = {P8},
	conditions = {
			Always()
		},
	actions = {
			MoveUnit(all,"Men",Force2,"EUL1","Heal Zone");
			MoveUnit(all,"Men",Force2,"EUL2","Heal Zone");
			PreserveTrigger()
		}
}

Trigger { -- 나간플레이어 유닛삭제
	players = {P8},
	conditions = {
			Always();
		},
	actions = {
			RemoveUnit("Men",P12);
			RemoveUnit(111,P12);
			RemoveUnit(107,P12);
			RemoveUnit(125,P12);
			PreserveTrigger()
		}
}

for i = 0, 4 do

Trigger { -- 에시비제한
	players = {i},
	conditions = {
			Bring(i,AtLeast,3,7,"Anywhere");
		},
	actions = {
			KillUnitAt(1,7,"Anywhere",i);
			PreserveTrigger()
		}
}

end

Trigger { -- 오프닝
	players = {Force1},
	conditions = {
			Always()
		},
	actions = {
			CenterView("Anywhere");
			PlayWAV("staredit\\wav\\scan.ogg");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\n\n\n\n\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\n\n\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\n\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x05-Men- , \x03GALAXY_BURST\n\n\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x05-Men- , \x03GALAXY_BURST\n\x13\x04\x11Special \x04Thanks to \x1BNinfia\n\n",4);
			Wait(150);
			CenterView("Anywhere");
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x05-Men- , \x04GALAXY_BURST\n\x13\x04♡ \x11Special \x04Thanks to \x1BNinfia \x04♡\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
			Wait(150);
			DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
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
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
		Wait(250);
		CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1FSTRCtrigAssembler \x08v5.4 \x04& \x08CB\x04 Paint \x08v2.4 \x04In Used\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
	
	}
}

Trigger {
	players = {Force1},
	conditions = {
			Always()
		},
	actions = {
		Wait(250);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x04\x08５\n\n\x13\x04☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		PlayWAV("sound\\glue\\countdown.wav");
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x04\x08４\n\n\x13\x04☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		PlayWAV("sound\\glue\\countdown.wav");
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x04\x08３\n\n\x13\x04☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		PlayWAV("sound\\glue\\countdown.wav");
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x04\x08２\n\n\x13\x04☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		PlayWAV("sound\\glue\\countdown.wav");
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x04\x08１\n\n\x13\x04☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥ \x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		PlayWAV("sound\\glue\\countdown.wav");
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");	
		Wait(250);CenterView("Anywhere");
	DisplayText("\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x08－\x04 ＳＴＡＲＴ！ \x08－\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14", 0);
		CenterView("Heal Zone");
		SetSwitch("Switch 2",Set);
		PlayWAV("staredit\\wav\\Intro");
		PlayWAV("staredit\\wav\\Intro");
		PlayWAV("staredit\\wav\\Intro");
	}
}

Trigger { -- 포스1 자원 설정
	players = {Force1},
	conditions = {
		Switch("Switch 2", Set);
	},
	actions = {
		SetResources(CurrentPlayer, SetTo, 35000, Ore);
	},
}

function CreateUnit2(Count,Unit,Location,Player)
	return CreateUnitWithProperties(Count,Unit,Location,Player,{
		clocked = false,
		burrowed = false,
		intransit = false,
		hallucinated = false,
		invincible = true,
		hitpoint = 100,
		shield = 100,
		energy = 100,
		resource = 0,
		hanger = 0,
	})
end



for i = 0, 4 do
Trigger { -- 포스1 마린,기부시민
	players = {i},
	conditions = {
		Deaths(i,Exactly,1,157);
		Switch("Switch 2", Set);
	},
	actions = {
		CreateUnit(3,0,"Heal Zone",CurrentPlayer);
		CreateUnit(1,15,"Donator",CurrentPlayer);
	},
}

end

Trigger { -- 방장강퇴유닛
	players = {P1},
	conditions = {
		Always();
	},
	actions = {
		CreateUnit(1,20,"Ban",P1);
		--CreateUnit(24,1,"Heal Zone",P1);
	},
}

Trigger { -- 영작유닛1
	players = {P7},
	conditions = {
		Always()
	},
	actions = {
		CreateUnit(1,98,"Cor1",P7);
		CreateUnit(3,98,"Cor2",P7);
		CreateUnit(1,60,"Interceptor",P7);
		CreateUnit(3,60,"Interceptor2",P7);
		CreateUnit(1,63,"DA1",P7);
		CreateUnit(2,63,"DA2",P7);
		CreateUnit(1,64,"Prob1",P7);
		CreateUnit(2,64,"Prob2",P7);
		CreateUnit(2,64,"Prob3",P7);
		CreateUnit(2,64,"Prob4",P7);
		CreateUnit(1,93,"Mutant0",P7);
		CreateUnit(4,93,"Mutant1",P7);
		CreateUnit(3,93,"Mutant2",P7);
		CreateUnit(4,95,"Sarah",P7);
		CreateUnit(4,95,"Sarah1",P7);
		CreateUnit(3,95,"Sarah2",P7);
		CreateUnit(4,89,"Hyp1",P7);
		CreateUnit(4,89,"Hyp0",P7);
		CreateUnit(4,89,"Hyp2",P7);
		CreateUnit(4,96,"Val1",P7);
		CreateUnit(2,96,"Val2",P7);
		CreateUnit(3,96,"Val3",P7);
		CreateUnit(3,96,"Val4",P7);
		CreateUnit(1,90,"Norad1",P7);
		CreateUnit(4,90,"Norad2",P7);
		CreateUnit(1,81,"Reaver",P7);
		CreateUnit(2,81,"Reaver2",P7);
		CreateUnit(2,52,"Defiler",P7);
		CreateUnit(2,52,"Defiler2",P7);
		CreateUnit(1,23,"Duke",P7);
		CreateUnit(1,102,"Mortis",P7);
		CreateUnit(1,9,"Ververg",P7);
		CreateUnit(1,9,"Ververg2",P7);
		CreateUnit(2,65,"Zealot",P7);
		CreateUnit(3,65,"Zealot2",P7);
		CreateUnit(2,66,"Dragoon",P7);
		CreateUnit(2,87,"HighT",P7);
		CreateUnit(2,3,"Goliath",P7);
		CreateUnit(2,3,"Goliath2",P7);
		CreateUnit(3,3,"Goliath3",P7);
		CreateUnit(2,5,"Tank",P7);
		CreateUnit(2,5,"Tank2",P7);
		CreateUnit(1,61,"Dark",P7);
		CreateUnit(1,30,"Reverse1",P7);
		CreateUnit(1,30,"Reverse2",P7);
		CreateUnit(1,30,"Reverse3",P7);
		CreateUnit(3,88,"Scout",P7);
		CreateUnit(1,25,"Siege1",P7);
		CreateUnit(1,25,"Siege2",P7);
		CreateUnit(1,25,"Siege3",P7);
		CreateUnit(1,25,"Siege4",P7);
		CreateUnit(1,25,"Siege5",P7);
		CreateUnit(1,25,"Siege6",P7);
		CreateUnit(1,25,"Siege7",P7);
		CreateUnit(1,25,"Siege8",P7);
		CreateUnit(1,25,"Siege9",P7);
		CreateUnit(1,25,"Siege10",P7);
		CreateUnit(2,32,"Firebat",P7);
		CreateUnit(2,32,"Firebat2",P7);
		CreateUnit(1,8,"Stealth1",P7);
		CreateUnit(2,8,"Stealth2",P7);
	}
}

Trigger { -- 영작유닛2
	players = {P7},
	conditions = {
		Always()
	},
	actions = {
		CreateUnit(1,77,"Z1",P7);
		CreateUnit(4,77,"Z2",P7);
		CreateUnit(4,78,"D1",P7);
		CreateUnit(4,78,"D2",P7);
		CreateUnit(2,88,"AT1",P7);
		CreateUnit(4,75,"ZT1",P7);
		CreateUnit(4,75,"ZT2",P7);
		CreateUnit(3,79,"HT1",P7);
		CreateUnit(3,79,"HT2",P7);
		CreateUnit(2,76,"ARC1",P7);
		CreateUnit(3,21,"KZ1",P7);
		CreateUnit(4,21,"KZ2",P7);
		CreateUnit(1,27,"Kronos1",P7);
		CreateUnit(1,27,"Kronos2",P7);
		CreateUnit(1,27,"Kronos3",P7);
		CreateUnit(1,27,"Kronos4",P7);
		CreateUnit(1,23,"Duke2",P7);
		CreateUnit(1,23,"Duke3",P7);
		CreateUnit(1,23,"Duke4",P7);
		CreateUnit(4,17,"Alan1",P7);
		CreateUnit(4,17,"Alan2",P7);
		CreateUnit(4,19,"Vul",P7);
		CreateUnit(4,80,"MJ1",P7);
		CreateUnit(3,80,"MJ2",P7);
	}
}

Trigger { -- 옵저버,캐리어,탬플러,카카루 삭제
	players = {P8},
	conditions = {
		Always()
	},
	actions = {
		KillUnit(84,CurrentPlayer);
		KillUnit(72,CurrentPlayer);
		KillUnit(67,CurrentPlayer);
		KillUnit(94,CurrentPlayer);
		PreserveTrigger()
	}
}


Trigger { -- 특수건물 소환
	players = {P6},
	conditions = {
		Always()
	},
	actions = {
		CreateUnit(1,25,"Bonus 2",P7);
		CreateUnit(1,25,"Bonus 1",P7);
		CreateUnit(1,152,"Daggoth L",P7);
		CreateUnit(1,152,"Daggoth R",P7);
		CreateUnit(1,148,"Daggoth 5",P7);
		CreateUnit(1,148,"Daggoth 6",P7);
		CreateUnit(1,"Palm Center","Center 1",P7);
		CreateUnit(1,"Palm Center","Center 2",P7);
		CreateUnit(1,"Palm Center","Center 3",P7);
		CreateUnit(1,127,"Mortar 1",P7);
		CreateUnit(1,127,"Mortar 2",P7);
		CreateUnit(1,190,"HeadQuater",P7);
		CreateUnit(1,201,"Cocoon",P7);
		CreateUnit(1,175, "XTemple",P7);
		CreateUnit(1,106,"Center A",P7);
		CreateUnit(1,106,"Center B",P7);
		CreateUnit(1,106,"Center C",P7);
		CreateUnit(1,106,"Center D",P7);
		CreateUnit(1,106,"Center E",P7);
		CreateUnit(1,106,"Center F",P7);
		CreateUnit(1,168,"Prison L",P7);
		CreateUnit(1,168,"Prison R",P7);
		SetInvincibility(Enable,168,P7,"Anywhere");
		--SetInvincibility(Enable,147,P8,"Anywhere");
		SetInvincibility(Enable,175,P7,"Anywhere");
		SetInvincibility(Enable,190,P7,"Anywhere");
	}
}

Trigger { -- 쉴드 재생 데스값 203 (유닛,일반건물)
	players = {P6},
	conditions = {
		Always()
	},
	actions = {
		SetDeaths(P9,Add,1,203);
		PreserveTrigger()
	}
}


Trigger { -- 쉴드 재생 (유닛,일반건물)
	players = {Force2},
	conditions = {
		Deaths(P9,Exactly,340,203)
	},
	actions = {
		ModifyUnitShields(all,"Any unit",P6,"Anywhere",100);
		SetDeaths(P9,SetTo,0,203);
		PreserveTrigger()
	}
}

Trigger { -- 쉴드 재생 데스값 204 (중앙제네,중앙커맨드)
	players = {P6},
	conditions = {
			Always()
		},
	actions = {
		SetDeaths(P9,Add,1,204);
		PreserveTrigger()
	}
}

Trigger { -- 쉴드 재생 데스값 204 (중앙제네,중앙커맨드,5시 탬플,중앙코쿤)
	players = {P6},
	conditions = {
			Deaths(P9,AtLeast,1,204)
		},
	actions = {
		ModifyUnitShields(all,200,P6,"Anywhere",100);
		ModifyUnitShields(all,175,P7,"Anywhere",100);
		ModifyUnitShields(all,106,P7,"Anywhere",100);
		ModifyUnitShields(all,201,P7,"Anywhere",100);
		SetDeaths(P9,SetTo,0,204);
		PreserveTrigger()
	}
}

Trigger { -- 캔낫표시 
	players = {P8},
	conditions = {
			Always()
		},
	actions = {
		SetMemory(0x582174, SetTo, 0x00000000);
		SetMemory(0x582178, SetTo, 0x00000000);
		SetMemory(0x58217C, SetTo, 0x00000000);
		SetMemory(0x582180, SetTo, 0x00000000);
		SetMemory(0x582184, SetTo, 0x00000000);
		SetMemory(0x582144, SetTo, 0x00000006);
		SetMemory(0x582148, SetTo, 0x00000006);
		SetMemory(0x58214C, SetTo, 0x00000006);
		SetMemory(0x582150, SetTo, 0x00000006);
		SetMemory(0x582154, SetTo, 0x00000006);
	}
}

Trigger { -- 맵전체유닛수 표기
	players = {P8},
	conditions = {
			Always();
		},
	actions = {
		SetMemory(0x0582264,SetTo,2400); --현재가능인구수
		SetMemory(0x0582268,SetTo,2400);
		SetMemory(0x058226C,SetTo,2400);
		SetMemory(0x0582270,SetTo,2400);
		SetMemory(0x0582274,SetTo,2400);

		SetMemory(0x05822C4,SetTo,3400); --최대 인구수
		SetMemory(0x05822C8,SetTo,3400);
		SetMemory(0x05822CC,SetTo,3400);
		SetMemory(0x05822D0,SetTo,3400);
		SetMemory(0x05822D4,SetTo,3400);
		
		}
}

Trigger { -- 기지유닛수 표기
	players = {P8},
	conditions = {
			Always();
		},
	actions = {
		SetMemory(0x05821D4,SetTo,400); --현재가능인구수
		SetMemory(0x05821D8,SetTo,400);
		SetMemory(0x05821DC,SetTo,400);
		SetMemory(0x05821E0,SetTo,400);
		SetMemory(0x05821E4,SetTo,400);

		SetMemory(0x0582234,SetTo,3400); --최대 인구수
		SetMemory(0x0582238,SetTo,3400);
		SetMemory(0x058223C,SetTo,3400);
		SetMemory(0x0582240,SetTo,3400);
		SetMemory(0x0582244,SetTo,3400);
		
		}
}

Trigger { -- 캔낫시 유닛삭제 1
	players = {P8},
	conditions = {
		Memory(0x628438, Exactly, 0x00000000);
		Memory(0x58F454, Exactly, 0x00000000);
		Memory(0x58F450, Exactly, 0x00000000);
	},
	actions = {
		KillUnit(104,Force2);
		KillUnit(56,Force2);
		KillUnit(55,Force2);
		KillUnit(53,Force2);
		KillUnit(54,Force2);
		KillUnit(51,Force2);
		KillUnit(40,Force2);
		KillUnit(37,Force2);
		KillUnit(38,Force2);
		KillUnit(44,Force2);
		KillUnit(43,Force2);
		KillUnit(39,Force2);
		SetMemory(0x582174, SetTo, 0x00000002);
		SetMemory(0x582178, SetTo, 0x00000002);
		SetMemory(0x58217C, SetTo, 0x00000002);
		SetMemory(0x582180, SetTo, 0x00000002);
		SetMemory(0x582184, SetTo, 0x00000002);
		SetMemory(0x58F450, SetTo, 0x0000003C); -- '다음단계까지의 대기시간'
		SetMemory(0x58F454, SetTo, 0x00000001); -- '단계'
		SetMemory(0x6509B0, SetTo, 0x00000000);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 2번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000001);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 2번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000002);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 2번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000003);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 2번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000004);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 2번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000005);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
		SetMemory(0x6509B0, SetTo, 0x00000007);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
	}
}

Trigger { -- 캔낫시 유닛삭제 1
	players = {P8},
	conditions = {
		Always()
	},
	actions = {
			SetMemory(0x58F450, Subtract, 1);
			PreserveTrigger();
	}
}


Trigger { -- 캔낫시 유닛삭제 2
	players = {P8},
	conditions = {
		Memory(0x628438, Exactly, 0x00000000);
		Memory(0x58F454, Exactly, 0x00000001);
		Memory(0x58F450, Exactly, 0x00000000);
	},
	actions = {
		KillUnit(104,Force2);
		KillUnit(56,Force2);
		KillUnit(55,Force2);
		KillUnit(53,Force2);
		KillUnit(54,Force2);
		KillUnit(51,Force2);
		KillUnit(40,Force2);
		KillUnit(37,Force2);
		KillUnit(38,Force2);
		KillUnit(44,Force2);
		KillUnit(43,Force2);
		KillUnit(39,Force2);
		SetMemory(0x582174, SetTo, 0x00000004);
		SetMemory(0x582178, SetTo, 0x00000004);
		SetMemory(0x58217C, SetTo, 0x00000004);
		SetMemory(0x582180, SetTo, 0x00000004);
		SetMemory(0x582184, SetTo, 0x00000004);
	SetMemory(0x58F450, SetTo, 0x0000003C);
	SetMemory(0x58F454, SetTo, 0x00000002);
		SetMemory(0x6509B0, SetTo, 0x00000000);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 1번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000001);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 1번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000002);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 1번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000003);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 1번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000004);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되었습니다. 1번더 캔낫시 \x06패배\x04합니다.\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000005);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
		SetMemory(0x6509B0, SetTo, 0x00000007);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
	}
}

Trigger { -- 캔낫시 유닛삭제 3
	players = {P8},
	conditions = {
		Memory(0x628438, Exactly, 0x00000000);
		Memory(0x58F454, Exactly, 0x00000002);
		Memory(0x58F450, Exactly, 0x00000000);
	},
	actions = {
		KillUnit(104,Force2);
		KillUnit(56,Force2);
		KillUnit(55,Force2);
		KillUnit(53,Force2);
		KillUnit(54,Force2);
		KillUnit(51,Force2);
		KillUnit(40,Force2);
		KillUnit(37,Force2);
		KillUnit(38,Force2);
		KillUnit(44,Force2);
		KillUnit(43,Force2);
		KillUnit(39,Force2);
		SetMemory(0x582174, SetTo, 0x00000004);
		SetMemory(0x582178, SetTo, 0x00000004);
		SetMemory(0x58217C, SetTo, 0x00000004);
		SetMemory(0x582180, SetTo, 0x00000004);
		SetMemory(0x582184, SetTo, 0x00000004);
		SetMemory(0x6509B0, SetTo, 0x00000000);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되어 패배하였습니다...(つ>ㅅ<)つ\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000001);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되어 패배하였습니다...(つ>ㅅ<)つ\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000002);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되어 패배하였습니다...(つ>ㅅ<)つ\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000003);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되어 패배하였습니다...(つ>ㅅ<)つ\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000004);
		DisplayText("\x13\x1F···-▷\x04“ \x06캔낫\x04이 감지되어 패배하였습니다...(つ>ㅅ<)つ\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000005);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
		SetMemory(0x6509B0, SetTo, 0x00000007);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog", "Anywhere");
		Wait(1000);
		SetMemory(0x6509B0, SetTo, 0x00000000);
		Defeat();
		SetMemory(0x6509B0, SetTo, 0x00000001);
		Defeat();
		SetMemory(0x6509B0, SetTo, 0x00000002);
		Defeat();
		SetMemory(0x6509B0, SetTo, 0x00000003);
		Defeat();
		SetMemory(0x6509B0, SetTo, 0x00000004);
		Defeat();
	}
}



Trigger { -- 기지유닛 끌당 데스값 201
	players = {Force2},
	conditions = {
		Always()
	},
	actions = {
		SetDeaths(P9,Add,1,201);
		PreserveTrigger()
	}
}

Trigger { -- 기지유닛 끌당
	players = {Force2},
	conditions = {
		Deaths(P9,Exactly,2000,201)
	},
	actions = {
		Order("Any unit",Force2,"Pulling",Attack,"Heal Zone");
		SetDeaths(P9,SetTo,0,201);
		PreserveTrigger()
	}
}

Trigger { -- 벙커무적해제
	players = {P8},
	conditions = {
		Bring(Force2,AtLeast,301,"Any unit","Heal Zone")
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0x00000000);
		DisplayText("\x13\x1F···-▷\x04“ 기지 적유닛 \x06400\x04마리이상 쌓여 벙커를 \x08파괴합니다. \x03꺌꺌!!\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000001);
		DisplayText("\x13\x1F···-▷\x04“ 기지 적유닛 \x06400\x04마리이상 쌓여 벙커를 \x08파괴합니다. \x03꺌꺌!!\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000002);
		DisplayText("\x13\x1F···-▷\x04“ 기지 적유닛 \x06400\x04마리이상 쌓여 벙커를 \x08파괴합니다. \x03꺌꺌!!\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000003);
		DisplayText("\x13\x1F···-▷\x04“ 기지 적유닛 \x06400\x04마리이상 쌓여 벙커를 \x08파괴합니다. \x03꺌꺌!!\x1F◁-···\x04”" ,4);
		SetMemory(0x6509B0, SetTo, 0x00000004);
		DisplayText("\x13\x1F···-▷\x04“ 기지 적유닛 \x06400\x04마리이상 쌓여 벙커를 \x08파괴합니다. \x03꺌꺌!!\x1F◁-···\x04”" ,4);
		KillUnitAt(all,"Terran Bunker","Heal Zone",Force1);
	}
}

Trigger { -- P8 색 
	players = {P8},
	conditions = {
		Always()
	},
	actions = {
		SetMemoryX(0x581DAC,SetTo,58*65536,0xFF0000);
		SetMemoryX(0x581DDC,SetTo,58*256,0xFF00);
	}
}

Trigger { -- P7 색
	players = {P7},
	conditions = {
		Always()
	},
	actions = {
		SetMemoryX(0x581DDC,SetTo,42*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DA4,SetTo,42*65536,0xFF0000), --P7 컬러
	}
}

Trigger { -- P6 색
	players = {P6},
	conditions = {
		Always()
	},
	actions = {
		SetMemoryX(0x581DD8,SetTo,128*16777216,0xFF000000); -- 6P
		SetMemoryX(0x581D9C,SetTo,128*65536,0xFF0000); -- 6P
	}
}

for i = 0, 4 do

Trigger { -- 일마 데카
	players = {P6},
	conditions = {
		Deaths(i, AtLeast, 1, 0);
	},
	actions = {
		SetScore(i, Add, 1, Custom);
		PreserveTrigger();
	},
}

end

Trigger { -- 영마데카
	players = {P1},
	conditions = {
		Deaths(0, AtLeast, 1, 1);
	},
	actions = {
		SetScore(0, Add, 3, Custom);
		PreserveTrigger();
	},
}

Trigger { -- 영마데카
	players = {P2},
	conditions = {
		Deaths(1, AtLeast, 1, 10);
	},
	actions = {
		SetScore(1, Add, 3, Custom);
		PreserveTrigger();
	},
}

Trigger { -- 영마데카
	players = {P3},
	conditions = {
		Deaths(2, AtLeast, 1, 16);
	},
	actions = {
		SetScore(2, Add, 3, Custom);
		PreserveTrigger();
	},
}

Trigger { -- 영마데카
	players = {P4},
	conditions = {
		Deaths(3, AtLeast, 1, 99);
	},
	actions = {
		SetScore(3, Add, 3, Custom);
		PreserveTrigger();
	},
}

Trigger { -- 영마데카
	players = {P5},
	conditions = {
		Deaths(4, AtLeast, 1, 100);
	},
	actions = {
		SetScore(4, Add, 3, Custom);
		PreserveTrigger();
	},
}


Trigger { -- P8 시야보임
	players = {Force1},
	conditions = {
		Always();
	},
	actions = {
		RunAIScript("Turn ON Shared Vision for Player 8");
		PreserveTrigger();
	},
}

Trigger { -- 컴퓨터가 플레이어 시야보임
	players = {Force2},
	conditions = {
		Always();
	},
	actions = {
		RunAIScript('Turn ON Shared Vision for Player 1');
		RunAIScript('Turn ON Shared Vision for Player 2');
		RunAIScript('Turn ON Shared Vision for Player 3');
		RunAIScript('Turn ON Shared Vision for Player 4');
		RunAIScript('Turn ON Shared Vision for Player 5');
		PreserveTrigger();
	},
}

Trigger { -- 동맹 비젼
	players = {Force1},
	conditions = {
		Always();
	},
	actions = {
		RunAIScript('Turn ON Shared Vision for Player 1');
		RunAIScript('Turn ON Shared Vision for Player 2');
		RunAIScript('Turn ON Shared Vision for Player 3');
		RunAIScript('Turn ON Shared Vision for Player 4');
		RunAIScript('Turn ON Shared Vision for Player 5');
		PreserveTrigger();
	},
}

Trigger { -- No comment (F4396891)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Heal Zone");
	},
	actions = {
		SetDeaths(CurrentPlayer, Add, 1, "Zerg Marker");
		PreserveTrigger();
	},
}

Trigger { -- No comment (A5B1781A)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Heal Zone");
		Deaths(CurrentPlayer, AtLeast, 100, "Zerg Marker");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 0, "Zerg Marker");
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Heal Zone", 100);
		PreserveTrigger();
	},
}

Trigger { -- 영마 변환
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0, "Hero Upgrading");
		Accumulate(CurrentPlayer, AtLeast, 20000, Ore);
	},
	actions = {
		SetResources(CurrentPlayer, Subtract, 20000, Ore);
		RemoveUnitAt(1, 0, "Hero Upgrading", CurrentPlayer);
		CreateUnit(1, 1, "P1 Marine", CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x08H\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-20,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { --영마 변환
	players = {P2},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0, "Hero Upgrading");
		Accumulate(CurrentPlayer, AtLeast, 20000, Ore);
	},
	actions = {
		SetResources(CurrentPlayer, Subtract, 20000, Ore);
		RemoveUnitAt(1, 0, "Hero Upgrading", CurrentPlayer);
		CreateUnit(1, 10, "P2 Marine", CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x0EH\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-20,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { -- 영마 변환
	players = {P3},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0, "Hero Upgrading");
		Accumulate(CurrentPlayer, AtLeast, 20000, Ore);
	},
	actions = {
		SetResources(CurrentPlayer, Subtract, 20000, Ore);
		RemoveUnitAt(1, 0, "Hero Upgrading", CurrentPlayer);
		CreateUnit(1, 16, "P3 Marine", CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x0FH\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-20,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { -- 영마 변환
	players = {P4},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0, "Hero Upgrading");
		Accumulate(CurrentPlayer, AtLeast, 20000, Ore);
	},
	actions = {
		SetResources(CurrentPlayer, Subtract, 20000, Ore);
		RemoveUnitAt(1, 0, "Hero Upgrading", CurrentPlayer);
		CreateUnit(1, 99, "P4 Marine", CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x10H\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-20,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { -- 영마 변환
	players = {P5},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0, "Hero Upgrading");
		Accumulate(CurrentPlayer, AtLeast, 20000, Ore);
	},
	actions = {
		SetResources(CurrentPlayer, Subtract, 20000, Ore);
		RemoveUnitAt(1, 0, "Hero Upgrading", CurrentPlayer);
		CreateUnit(1, 100, "P5 Marine", CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x11H\x04ero \x03M\x04arine 을 소환하였습니다. 「\x08-20,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { -- No comment (D0487A06)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 512);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 512, Kills);
		SetResources(CurrentPlayer, Add, 128, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (ED0F51D8)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 1024);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1024, Kills);
		SetResources(CurrentPlayer, Add, 256, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (97810664)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 2048);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 2048, Kills);
		SetResources(CurrentPlayer, Add, 512, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (629DA91C)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 4096);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 4096, Kills);
		SetResources(CurrentPlayer, Add, 1024, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (53D5F1AD)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 8192);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 8192, Kills);
		SetResources(CurrentPlayer, Add, 2048, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (314540CF)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 16384);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 16384, Kills);
		SetResources(CurrentPlayer, Add, 4096, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (A557E1C2)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 65536);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 65536, Kills);
		SetResources(CurrentPlayer, Add, 16384, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (213C3E6A)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 100000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 100000, Kills);
		SetResources(CurrentPlayer, Add, 25000, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (17A92825)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 1000000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1000000, Kills);
		SetResources(CurrentPlayer, Add, 250000, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (17A92825)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging L");
		Score(CurrentPlayer, Kills, AtLeast, 1000000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1000000, Kills);
		SetResources(CurrentPlayer, Add, 250000, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (7396585F)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 512);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 512, Kills);
		SetResources(CurrentPlayer, Add, 128, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4ED17381)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 1024);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1024, Kills);
		SetResources(CurrentPlayer, Add, 256, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (345F243D)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 2048);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 2048, Kills);
		SetResources(CurrentPlayer, Add, 512, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (C1438B45)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 4096);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 4096, Kills);
		SetResources(CurrentPlayer, Add, 1024, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (F00BD3F4)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 8192);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 8192, Kills);
		SetResources(CurrentPlayer, Add, 2048, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (929B6296)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 16384);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 16384, Kills);
		SetResources(CurrentPlayer, Add, 4096, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (0689C39B)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 65536);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 65536, Kills);
		SetResources(CurrentPlayer, Add, 16384, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (82E21C33)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 100000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 100000, Kills);
		SetResources(CurrentPlayer, Add, 25000, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (B4770A7C)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 1000000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1000000, Kills);
		SetResources(CurrentPlayer, Add, 250000, Ore);
		PreserveTrigger();
	},
}

Trigger { -- No comment (B4770A7C)
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Men", "Exchanging R");
		Score(CurrentPlayer, Kills, AtLeast, 1000000);
	},
	actions = {
		SetScore(CurrentPlayer, Subtract, 1000000, Kills);
		SetResources(CurrentPlayer, Add, 250000, Ore);
		PreserveTrigger();
	},
}

-- 기부하기 (데스값 : 156),(데스값 : 157(플레이어 유무확인))--

Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,0,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,1,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x185000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,1,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,2,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x1810000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,2,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,3,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x1850000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,3,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,4,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x18100000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,4,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,5,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x18500000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"Marine,Scv");
		Deaths(P9,Exactly,5,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,0,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x181000원\x04으로 감소했습니다. \x18”",4);
		PreserveTrigger();
	},
}

Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,0,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,1,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x185000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,1,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,2,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x1810000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,2,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,3,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x1850000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,3,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,4,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x18100000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,4,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,5,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x18500000원\x04으로 증가했습니다. \x18”",4);
		PreserveTrigger();
	},
}
Trigger { -- 기부금액 변경
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,11,"P5 Marine,Scv");
		Deaths(P9,Exactly,5,156);
	},
	actions = {
		RemoveUnit(11,CurrentPlayer);
		SetDeaths(P9,SetTo,0,156);
		DisplayText("\x04·\x16·\x1D·\x07-\x18▷“\x04 기부 금액이 \x181000원\x04으로 감소했습니다. \x18”",4);
		PreserveTrigger();
	},
}

local GiveRate2 = {1000, 5000, 10000, 50000, 100000,500000}
for i = 0, 5 do

Trigger { -- P1에게 기부
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,Exactly,1,15,"Donate P1");
		Accumulate(CurrentPlayer,AtLeast,GiveRate2[i+1],Ore);
		Deaths(P9,Exactly,i,156);
		Deaths(P1,Exactly,1,157);
	},
	actions = {
		MoveUnit(1,15,CurrentPlayer,"Donate P1","Donator");
		SetResources(CurrentPlayer,Subtract,GiveRate2[i+1],Ore);
		SetResources(P1,Add,GiveRate2[i+1],Ore);
		DisplayText("\x04·\x16·\x1D·\x0F-\x1F▷“ \x08P1\x04에게 \x1F" .. GiveRate2[i+1] .. "원\x04을 기부했습니다. \x1F”",4);
		PreserveTrigger();
	},
}

Trigger { -- P2에게 기부
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,Exactly,1,15,"Donate P2");
		Accumulate(CurrentPlayer,AtLeast,GiveRate2[i+1],Ore);
		Deaths(P9,Exactly,i,156);
		Deaths(P2,Exactly,1,157);
	},
	actions = {
		MoveUnit(1,15,CurrentPlayer,"Donate P2","Donator");
		SetResources(CurrentPlayer,Subtract,GiveRate2[i+1],Ore);
		SetResources(P2,Add,GiveRate2[i+1],Ore);
		DisplayText("\x04·\x16·\x1D·\x0F-\x1F▷“ \x0EP2\x04에게 \x1F" .. GiveRate2[i+1] .. "원\x04을 기부했습니다. \x1F”",4);
		PreserveTrigger();
	},
}

Trigger { -- P3에게 기부
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,Exactly,1,15,"Donate P3");
		Accumulate(CurrentPlayer,AtLeast,GiveRate2[i+1],Ore);
		Deaths(P9,Exactly,i,156);
		Deaths(P3,Exactly,1,157);
	},
	actions = {
		MoveUnit(1,15,CurrentPlayer,"Donate P3","Donator");
		SetResources(CurrentPlayer,Subtract,GiveRate2[i+1],Ore);
		SetResources(P3,Add,GiveRate2[i+1],Ore);
		DisplayText("\x04·\x16·\x1D·\x0F-\x1F▷“ \x0FP3\x04에게 \x1F" .. GiveRate2[i+1] .. "원\x04을 기부했습니다. \x1F”",4);
		PreserveTrigger();
	},
}

Trigger { -- P4에게 기부
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,Exactly,1,15,"Donate P4");
		Accumulate(CurrentPlayer,AtLeast,GiveRate2[i+1],Ore);
		Deaths(P9,Exactly,i,156);
		Deaths(P4,Exactly,1,157);
	},
	actions = {
		MoveUnit(1,15,CurrentPlayer,"Donate P4","Donator");
		SetResources(CurrentPlayer,Subtract,GiveRate2[i+1],Ore);
		SetResources(P4,Add,GiveRate2[i+1],Ore);
		DisplayText("\x04·\x16·\x1D·\x0F-\x1F▷“ \x10P4\x04에게 \x1F" .. GiveRate2[i+1] .. "원\x04을 기부했습니다. \x1F”",4);
		PreserveTrigger();
	},
}

Trigger { -- P5에게 기부
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,Exactly,1,15,"Donate P5");
		Accumulate(CurrentPlayer,AtLeast,GiveRate2[i+1],Ore);
		Deaths(P9,Exactly,i,156);
		Deaths(P5,Exactly,1,157);
	},
	actions = {
		MoveUnit(1,15,CurrentPlayer,"Donate P5","Donator");
		SetResources(CurrentPlayer,Subtract,GiveRate2[i+1],Ore);
		SetResources(P5,Add,GiveRate2[i+1],Ore);
		DisplayText("\x04·\x16·\x1D·\x0F-\x1F▷“ \x11P5\x04에게 \x1F" .. GiveRate2[i+1] .. "원\x04을 기부했습니다. \x1F”",4);
		PreserveTrigger();
	},
}

end

-- 브금 on / off (데스값:158~162) --

Trigger { -- on
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer,Exactly,0,158);
		Bring(CurrentPlayer,AtLeast,1,12,"Marine,Scv")
	},
	actions = {
		RemoveUnitAt(1,12,"Marine,Scv",CurrentPlayer);
		DisplayText("\x04·\x16·\x1D·\x18-\x07▷“ \x04건물파괴 \x07BGM\x04을 듣지않습니다. \x07”",4);
		SetDeaths(CurrentPlayer,SetTo,1,158);
		PreserveTrigger()
	},
}

Trigger { -- off
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer,Exactly,1,158);
		Bring(CurrentPlayer,AtLeast,1,12,"Marine,Scv")
	},
	actions = {
		RemoveUnitAt(1,12,"Marine,Scv",CurrentPlayer);
		DisplayText("\x04·\x16·\x1D·\x18-\x07▷“ \x04건물파괴 \x07BGM\x04을 듣습니다. \x07”",4);
		SetDeaths(CurrentPlayer,SetTo,0,158);
		PreserveTrigger()
	},
}

Trigger { -- on
	players = {P5},
	conditions = {
		Deaths(CurrentPlayer,Exactly,0,158);
		Bring(CurrentPlayer,AtLeast,1,12,"P5 Marine,Scv")
	},
	actions = {
		RemoveUnitAt(1,12,"P5 Marine,Scv",CurrentPlayer);
		DisplayText("\x04·\x16·\x1D·\x18-\x07▷“ \x04건물파괴 \x07BGM\x04을 듣지않습니다. \x07”",4);
		SetDeaths(CurrentPlayer,SetTo,1,158);
		PreserveTrigger()
	},
}

Trigger { -- off
	players = {P5},
	conditions = {
		Deaths(CurrentPlayer,Exactly,1,158);
		Bring(CurrentPlayer,AtLeast,1,12,"P5 Marine,Scv")
	},
	actions = {
		RemoveUnitAt(1,12,"P5 Marine,Scv",CurrentPlayer);
		DisplayText("\x04·\x16·\x1D·\x18-\x07▷“ \x04건물파괴 \x07BGM\x04을 듣습니다. \x07”",4);
		SetDeaths(CurrentPlayer,SetTo,0,158);
		PreserveTrigger()
	},
}

function SetMemoryBA(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return SetMemoryX(Offset-ret,Type,Value,Mask)
end
for i=0, 4 do -- 예약메딕

Trigger { -- 
	players = {i},
	conditions = {
		Always()
	},
	actions = {
		SetMemoryBA(0x57F27C+(228*i)+2,SetTo,0);
		SetMemoryBA(0x57F27C+(228*i)+34,SetTo,1);
	},
}

Trigger { -- 
	players = {i},
	conditions = {
		Deaths(i,Exactly,0,"Map Revealer");
		Bring(i,AtLeast,1,17,"Anywhere");
	},
	actions = {
		RemoveUnit(17,i);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x04예약 \x0F메딕(힐) \x04기능을 사용합니다\x04. 「\x0F250ore\x04」\x0F”", 4);
		SetMemoryBA(0x57F27C+(228*i)+2,SetTo,1);
		SetMemoryBA(0x57F27C+(228*i)+34,SetTo,0);
		SetDeaths(i,SetTo,1,"Map Revealer");
		PreserveTrigger();
	},
}

Trigger { -- 
	players = {i},
	conditions = {
		Deaths(i,Exactly,1,"Map Revealer");
		Bring(i,AtLeast,1,17,"Anywhere");
	},
	actions = {
		RemoveUnit(17,i);
		DisplayText("\x04·\x16·\x02·\x1F-\x1F▷“ \x04예약 \x1F메딕(힐) \x04기능을 사용하지 않습니다. 「\x1F200ore\x04」. \x1F”", 4);
		SetMemoryBA(0x57F27C+(228*i)+2,SetTo,0);
		SetMemoryBA(0x57F27C+(228*i)+34,SetTo,1);
		SetDeaths(i,SetTo,0,"Map Revealer");
		PreserveTrigger();
	},
}

end
Trigger { -- 메딕
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, "Terran Medic");
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		RemoveUnit("Terran Medic", CurrentPlayer);
		PreserveTrigger();
	},
}

Trigger { -- 생속3메딕
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, 2);
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		RemoveUnit(2, CurrentPlayer);
		PreserveTrigger();
	},
}

Trigger { -- 일마 소환
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0,"Marine,Scv");
	},
	actions = {
		RemoveUnitAt(1,0,"Marine,Scv",CurrentPlayer);
		CreateUnit(1,0,"Heal Zone",CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x1FM\x04arine 을 소환하였습니다. 「\x08-10,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

Trigger { -- P5 일마 소환
	players = {P5},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, 0,"P5 Marine,Scv");
	},
	actions = {
		RemoveUnitAt(1,0,"P5 Marine,Scv",CurrentPlayer);
		CreateUnit(1,0,"Heal Zone",CurrentPlayer);
		PreserveTrigger();
	},
}

HeroMarArr = {1,10,16,99,100}
-- 영마 바로 소환
for i = 0, 4 do
	Trigger2(FP,{Bring(i,AtLeast,1,8,"Anywhere")},{
		RemoveUnit(8,i),CreateUnit(1,HeroMarArr[i+1],"Heal Zone",i);
	},{Preserved})
end

Trigger { -- scv 소환
	players = {Force1},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,7,"Marine,Scv");
	},
	actions = {
		RemoveUnitAt(1,7,"Marine,Scv",CurrentPlayer);
		CreateUnit(1,7,"Heal Zone",CurrentPlayer);
		PreserveTrigger();
	},
}

Trigger { -- P5 scv 소환
	players = {P5},
	conditions = {
		Bring(CurrentPlayer,AtLeast,1,7,"P5 Marine,Scv");
	},
	actions = {
		RemoveUnitAt(1,7,"P5 Marine,Scv",CurrentPlayer);
		CreateUnit(1,7,"Heal Zone",CurrentPlayer);
		DisplayText("\x04·\x16·\x02·\x1F-\x0F▷“ \x1FS\x04cv 를 소환하였습니다. 「\x08-1,000 \x1FOre\x04」”", 4);
		PreserveTrigger();
	},
}

 -- 영작 --

Trigger { -- No comment (E2123E06)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 78);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06G\x04uilty 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (ABB625F6)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 77);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04alypso 를 \x06처치\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 80);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06F\x04ierce 를 \x06처치\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 75);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06V\x04iolet 를 \x06처치\x04하였습니다. +45,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 45000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 79);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06D\x04ivinity 를 \x06처치\x04하였습니다. +45,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 45000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 86);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04amou\x1FF\x04lager 를 \x06처치\x04하였습니다. +65,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 65000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 76);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06T\x04esla 를 \x06처치\x04하였습니다. +55,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 55000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 63);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06E\x04dge 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 64);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06L\x04ux 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 98);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04eres 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 60);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06W\x04icked 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 88);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06P\x04redator 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 93);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06M\x04utant 를 \x06처치\x04하였습니다. +35,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 35000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 21);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06V\x04anish 를 \x06처치\x04하였습니다. +45,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 45000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 95);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06S\x04arah 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 89);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06H\x04yperion 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 90);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06A\x04pex 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 96);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06D\x04ystopia 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 17);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06Q\x04uaser 를 \x06처치\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 19);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06V\x04elocity 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 102);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06M\x04ortis 를 \x06처치\x04하였습니다. +90,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 90000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 27);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06K\x04ronos 를 \x06처치\x04하였습니다. +120,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 120000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 8);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06S\x04tealth 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 9);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06V\x04erverg 를 \x06처치\x04하였습니다. +150,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 150000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 23);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06A\x04gony 를 \x06처치\x04하였습니다. +90,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 90000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 22);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06M\x04agellan 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 52);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04ollapse 를 \x06처치\x04하였습니다. +55,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 55000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 61);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06W\x04hisper 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 87);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06A\x04nxiety 를 \x06처치\x04하였습니다. +70,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 70000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 65);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06Immortal C\x04alypso 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 66);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06Immortal G\x04uilty 를 \x06처치\x04하였습니다. +65,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 65000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 81);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04atastrophic 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 3);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06C\x04obalt 를 \x06처치\x04하였습니다. +60,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 60000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 25);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06V\x04esta 를 \x06처치\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 32);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06I\x04gnite 를 \x06처치\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 5);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06R\x04eversed \x1FT\x04ank 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- No comment (2EE63055)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 30);
		Deaths(P9,Exactly,0,200)
	},
	actions = {
		DisplayText("\x13\x04●····『\x03 [Hero] \x04:: \x06R\x04eversed \x1FS\x04iege 를 \x06처치\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PlayWAV("staredit\\wav\\Hero");
		PreserveTrigger();
	},
}

Trigger { -- 영작유닛 데스값 -1
	players = {P7},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(CurrentPlayer, Subtract, 1, 3);
		SetDeaths(CurrentPlayer, Subtract, 1, 5);
		SetDeaths(CurrentPlayer, Subtract, 1, 8);
		SetDeaths(CurrentPlayer, Subtract, 1, 9);
		SetDeaths(CurrentPlayer, Subtract, 1, 17);
		SetDeaths(CurrentPlayer, Subtract, 1, 19);
		SetDeaths(CurrentPlayer, Subtract, 1, 21);
		SetDeaths(CurrentPlayer, Subtract, 1, 22);
		SetDeaths(CurrentPlayer, Subtract, 1, 23);
		SetDeaths(CurrentPlayer, Subtract, 1, 25);
		SetDeaths(CurrentPlayer, Subtract, 1, 27);
		SetDeaths(CurrentPlayer, Subtract, 1, 30);
		SetDeaths(CurrentPlayer, Subtract, 1, 32);
		SetDeaths(CurrentPlayer, Subtract, 1, 52);
		SetDeaths(CurrentPlayer, Subtract, 1, 60);
		SetDeaths(CurrentPlayer, Subtract, 1, 61);
		SetDeaths(CurrentPlayer, Subtract, 1, 63);
		SetDeaths(CurrentPlayer, Subtract, 1, 64);
		SetDeaths(CurrentPlayer, Subtract, 1, 65);
		SetDeaths(CurrentPlayer, Subtract, 1, 66);
		SetDeaths(CurrentPlayer, Subtract, 1, 74);
		SetDeaths(CurrentPlayer, Subtract, 1, 75);
		SetDeaths(CurrentPlayer, Subtract, 1, 76);
		SetDeaths(CurrentPlayer, Subtract, 1, 77);
		SetDeaths(CurrentPlayer, Subtract, 1, 78);
		SetDeaths(CurrentPlayer, Subtract, 1, 79);
		SetDeaths(CurrentPlayer, Subtract, 1, 80);
		SetDeaths(CurrentPlayer, Subtract, 1, 81);
		SetDeaths(CurrentPlayer, Subtract, 1, 86);
		SetDeaths(CurrentPlayer, Subtract, 1, 87);
		SetDeaths(CurrentPlayer, Subtract, 1, 88);
		SetDeaths(CurrentPlayer, Subtract, 1, 89);
		SetDeaths(CurrentPlayer, Subtract, 1, 90);
		SetDeaths(CurrentPlayer, Subtract, 1, 93);
		SetDeaths(CurrentPlayer, Subtract, 1, 95);
		SetDeaths(CurrentPlayer, Subtract, 1, 96);
		SetDeaths(CurrentPlayer, Subtract, 1, 98);
		SetDeaths(CurrentPlayer, Subtract, 1, 102);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4CA09540)
	players = {Force1},
	conditions = {
		Deaths(P1, AtLeast, 1, 0);
	},
	actions = {
		DisplayText("\x12\x1F【\x06 [1 Player]\x04의 \x06M\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (20D6DA45)
	players = {Force1},
	conditions = {
		Deaths(P2, AtLeast, 1, 0);
	},
	actions = {
		DisplayText("\x12\x1F【\x0E [2 Player]\x04의 \x1FM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (5D15CE34)
	players = {Force1},
	conditions = {
		Deaths(P3, AtLeast, 1, 0);
	},
	actions = {
		DisplayText("\x12\x1F【\x0F [3 Player]\x04의 \x1FM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (3C2EF8C0)
	players = {Force1},
	conditions = {
		Deaths(P4, AtLeast, 1, 0);
	},
	actions = {
		DisplayText("\x12\x1F【\x10 [4 Player]\x04의 \x1FM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (91C2EC47)
	players = {Force1},
	conditions = {
		Deaths(P5, AtLeast, 1, 0);
	},
	actions = {
		DisplayText("\x12\x1F【\x11 [5 Player]\x04의 \x1FM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

for i = 0, 4 do

Trigger { -- No comment (6A2BBA73)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(i, Subtract, 1, 0);
		PreserveTrigger();
	},
}

end

Trigger { -- No comment (CF0289B2)
	players = {Force1},
	conditions = {
		Deaths(P1, AtLeast, 1, 1);
	},
	actions = {
		DisplayText("\x12\x1F【\x06 [1 Player]\x04의 \x03H\x04ero \x06M\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (A0BEA39E)
	players = {Force1},
	conditions = {
		Deaths(P2, AtLeast, 1, 10);
	},
	actions = {
		DisplayText("\x12\x1F【\x0E [2 Player]\x04의 \x03H\x04ero \x0EM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (68D319E8)
	players = {Force1},
	conditions = {
		Deaths(P3, AtLeast, 1, 16);
	},
	actions = {
		DisplayText("\x12\x1F【\x0F [3 Player]\x04의 \x03H\x04ero \x0FM\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (076F33C4)
	players = {Force1},
	conditions = {
		Deaths(P4, AtLeast, 1, 99);
	},
	actions = {
		DisplayText("\x12\x1F【\x10 [4 Player]\x04의 \x03H\x04ero \x10M\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (23796B45)
	players = {Force1},
	conditions = {
		Deaths(P5, AtLeast, 1, 100);
	},
	actions = {
		DisplayText("\x12\x1F【\x11 [5 Player]\x04의 \x03H\x04ero \x11M\x04arine 이 \x06사망\x04하였습니다.\x1F】", 4);
		PlayWAV("staredit\\wav\\Death");
		PreserveTrigger();
	},
}

Trigger { -- No comment (9A2DA158)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P1, Subtract, 1, 1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (9A2DA158)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P2, Subtract, 1,10);
		PreserveTrigger();
	},
}

Trigger { -- No comment (9A2DA158)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P3, Subtract, 1,16);
		PreserveTrigger();
	},
}

Trigger { -- No comment (9A2DA158)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P4, Subtract, 1,99);
		PreserveTrigger();
	},
}

Trigger { -- No comment (9A2DA158)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P5, Subtract, 1,100);
		PreserveTrigger();
	},
}

Trigger { -- No comment (0A30C1D0)
	players = {P7},
	conditions = {
		Always();
	},
	actions = {
		RunAIScriptAt("Expansion Zerg Campaign Insane", "AI");
		RunAIScriptAt("Value This Area Higher", "Heal Zone");
	},
}

Trigger { -- No comment (866B4FC4)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		RunAIScriptAt("Expansion Zerg Campaign Insane", "AI");
		RunAIScriptAt("Value This Area Higher", "Heal Zone");
	},
}

Trigger { -- 컴퓨터동맹설정
	players = {Force2},
	conditions = {
		Always();
	},
	actions = {
		SetResources(P7, SetTo, 9999999, OreAndGas);
		SetResources(P6, SetTo, 9999999, OreAndGas);
		PreserveTrigger();
		SetAllianceStatus(Force1, Enemy);
	},
}



Trigger { -- 동맹설정
	players = {Force1},
	conditions = {
		Always();
	},
	actions = {
		SetAllianceStatus(Force1,AlliedVictory);
		PreserveTrigger();
	},
}

Trigger { -- No comment (343457FE)
	players = {P6, P7},
	conditions = {
		Command(CurrentPlayer, AtLeast, 50, "Lavar");
	},
	actions = {
		RemoveUnitAt(5, "Lavar", "Anywhere", CurrentPlayer);
		PreserveTrigger();
	},
}

Trigger { -- 건물데스값 -1
	players = {P8},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(P6,Subtract,1,"Palm Lair");
		SetDeaths(P6,Subtract,1,"Palm Hive");
		SetDeaths(P7,Subtract,1,152);
		SetDeaths(P7,Subtract,1,201);
		SetDeaths(P7,Subtract,1,190);
		SetDeaths(P6,Subtract,1,200);
		SetDeaths(P7,Subtract,1,"Palm Center");
		SetDeaths(P7,Subtract,1,"Diversity");
		SetDeaths(P7,Subtract,1,"Palm Senter");
		SetDeaths(P7,Subtract,1,127);
		SetDeaths(P7,Subtract,1,148);
		SetDeaths(P7,Subtract,1,175);
		SetDeaths(P7,Subtract,1,154);
		PreserveTrigger()
	}
}
--------------------- 건작 -----------------
GunLock = CreateVar(P6)
GunLock = CreateVar(P7)
GunLock = CreateVar(FP)
-- 12시 건작 --
--DoActionsX({P6,P7,P8},{SetNVar(GunLock,SetTo,1),SetResources(P1,SetTo,99999999,Ore)}) -- Test

CIf(P6,{NVar(GunLock,Exactly,0)}) -- P6 건작트리거단락 시작

PA = CSMakePolygon(6,80,0,61,1)
PB = CSMakePolygon(6,80,0,37,1)
PC = CSMakePolygon(6,80,0,19,1)
PD = CSMakePolygon(6,80,0,7,0)
PE = CSMakePolygon(6,80,0,91,1)
PAA = CSMakePolygon(6,1,0,61,1)
PBB = CSMakePolygon(6,1,0,37,1)
PCC = CSMakePolygon(6,1,0,19,1)
PDD = CSMakePolygon(6,1,0,7,0)
PEE = CSMakePolygon(6,1,0,91,1)
PLA = CSMakeLine(6,180,0,13,0)
	

Trigger { -- 12시 좌측레어 건작 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-1")
	},
	actions = {
		SetDeaths(P9,Add,1,0);
		PreserveTrigger();
	}
}

CSPlotOrder(PLA,P6,56,"Lair L-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PA,P7,55,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PA,P6,53,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PA,P7,54,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PB,P7,104,"Lair L-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PB,P6,40,"Lair L-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})
CSPlotOrder(PC,P7,48,"Lair L-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,AtLeast,0,0)})

CSPlotOrder(PLA,P6,56,"Lair L-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PA,P7,55,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PA,P6,53,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PA,P7,54,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PB,P7,104,"Lair L-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PA,P6,40,"Lair L-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})
CSPlotOrder(PC,P7,48,"Lair L-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-1"), Deaths(P9,Exactly,330,0)})


Trigger { -- 12시 우측레어 건작 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-1")
	},
	actions = {
		SetDeaths(P9,Add,1,1);
		PreserveTrigger();
	}
}

CSPlotOrder(PLA,P6,56,"Lair R-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PA,P7,55,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PA,P6,53,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PA,P7,54,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PB,P7,104,"Lair R-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PB,P6,40,"Lair R-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})
CSPlotOrder(PC,P7,48,"Lair R-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,AtLeast,0,1)})

CSPlotOrder(PLA,P6,56,"Lair R-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PA,P7,55,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PA,P6,53,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PA,P7,54,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PB,P7,104,"Lair R-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PA,P6,40,"Lair R-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})
CSPlotOrder(PC,P7,48,"Lair R-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-1"), Deaths(P9,Exactly,330,1)})

Trigger { -- 12시 중앙하이브 건작 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Center Hive 1")
	},
	actions = {
		SetDeaths(P9,Add,1,2);
		PreserveTrigger()
	}
}
CSPlotOrder(PLA,P6,56,"Center Hive 1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PE,P6,55,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PC,P7,53,"Center Hive 1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PB,P7,54,"Center Hive 1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PE,P7,104,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PE,P6,51,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})
CSPlotOrder(PD,P7,48,"Center Hive 1",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,AtLeast,0,2)})

CSPlotOrder(PLA,P6,56,"Center Hive 1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PE,P6,55,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PC,P7,53,"Center Hive 1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PB,P7,54,"Center Hive 1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PE,P7,104,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PE,P6,51,"Center Hive 1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})
CSPlotOrder(PD,P7,48,"Center Hive 1",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Center Hive 1"), Deaths(P9,Exactly,330,2)})

 -- 11시 건작

Trigger { -- 11시 레어1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-2-1")
	},
	actions = {
		SetDeaths(P9,Add,1,3);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,56,"Lair L-2-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PA,P7,55,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PA,P6,51,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PA,P7,54,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PB,P6,104,"Lair L-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PB,P6,77,"Lair L-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})
CSPlotOrder(PC,P7,48,"Lair L-2-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,AtLeast,0,3)})

CSPlotOrder(PLA,P6,62,"Lair L-2-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PA,P7,56,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PA,P6,51,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PA,P7,54,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PB,P6,104,"Lair L-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PA,P6,77,"Lair L-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})
CSPlotOrder(PC,P7,48,"Lair L-2-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-1"), Deaths(P9,Exactly,330,3)})

Trigger { -- 11시 레어2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-2-2")
	},
	actions = {
		SetDeaths(P9,Add,1,4);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,62,"Lair L-2-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PA,P7,55,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PA,P6,51,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PA,P7,54,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PB,P7,104,"Lair L-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PB,P6,78,"Lair L-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})
CSPlotOrder(PC,P7,48,"Lair L-2-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,AtLeast,0,4)})

CSPlotOrder(PLA,P6,80,"Lair L-2-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PA,P7,56,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PA,P6,51,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PA,P7,54,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PB,P7,104,"Lair L-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PA,P6,78,"Lair L-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})
CSPlotOrder(PC,P7,48,"Lair L-2-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-2"), Deaths(P9,Exactly,330,4)})

Trigger { -- 11시 레어3 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-2-3")
	},
	actions = {
		SetDeaths(P9,Add,1,5);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,80,"Lair L-2-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PA,P7,55,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PA,P6,51,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PA,P7,54,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PB,P7,104,"Lair L-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PB,P6,77,"Lair L-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})
CSPlotOrder(PC,P7,48,"Lair L-2-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,AtLeast,0,5)})

CSPlotOrder(PLA,P6,80,"Lair L-2-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PA,P7,56,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PA,P6,51,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PA,P7,54,"Lair L-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PB,P7,104,"Lair L-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PB,P6,78,"Lair L-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})
CSPlotOrder(PC,P7,48,"Lair L-2-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-2-3"), Deaths(P9,Exactly,330,5)})

Trigger { -- 11시 하이브 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive L-2")
	},
	actions = {
		SetDeaths(P9,Add,1,6);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,80,"Hive L-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PE,P7,56,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PE,P6,51,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PA,P7,54,"Hive L-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PC,P6,104,"Hive L-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PE,P6,77,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})
CSPlotOrder(PD,P7,48,"Hive L-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,AtLeast,0,6)})

CSPlotOrder(PLA,P6,88,"Hive L-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PE,P7,56,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PE,P6,51,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PA,P7,54,"Hive L-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PC,P6,104,"Hive L-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PE,P6,78,"Hive L-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})
CSPlotOrder(PD,P7,48,"Hive L-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-2"), Deaths(P9,Exactly,330,6)})

-- 1시 건작 --

Trigger { -- 1시 오른쪽 레어1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-2-1")
	},
	actions = {
		SetDeaths(P9,Add,1,10);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,62,"Lair R-2-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PA,P7,55,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PA,P6,51,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PA,P7,54,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PB,P7,104,"Lair R-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PB,P6,93,"Lair R-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})
CSPlotOrder(PC,P7,48,"Lair R-2-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,AtLeast,0,10)})

CSPlotOrder(PLA,P6,21,"Lair R-2-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PA,P7,56,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PA,P6,51,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PA,P7,54,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PB,P7,104,"Lair R-2-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PA,P6,93,"Lair R-2-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})
CSPlotOrder(PC,P7,48,"Lair R-2-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-1"), Deaths(P9,Exactly,330,10)})

Trigger { -- 1시 오른쪽 레어2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-2-2")
	},
	actions = {
		SetDeaths(P9,Add,1,11);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,62,"Lair R-2-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PA,P7,55,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PA,P6,51,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PA,P7,54,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PB,P7,104,"Lair R-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PB,P6,95,"Lair R-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})
CSPlotOrder(PC,P7,48,"Lair R-2-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,AtLeast,0,11)})

CSPlotOrder(PLA,P6,21,"Lair R-2-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PA,P7,56,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PA,P6,51,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PA,P7,54,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PB,P7,104,"Lair R-2-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PA,P6,95,"Lair R-2-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})
CSPlotOrder(PC,P7,48,"Lair R-2-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-2"), Deaths(P9,Exactly,330,11)})

Trigger { -- 1시 오른쪽 레어3 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-2-3")
	},
	actions = {
		SetDeaths(P9,Add,1,12);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,21,"Lair R-2-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PA,P7,55,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PA,P6,51,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PA,P7,54,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PB,P7,104,"Lair R-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PB,P6,93,"Lair R-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})
CSPlotOrder(PC,P7,48,"Lair R-2-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,AtLeast,0,12)})

CSPlotOrder(PLA,P6,21,"Lair R-2-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PA,P7,56,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PA,P6,51,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PA,P7,54,"Lair R-2-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PB,P7,104,"Lair R-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PB,P6,95,"Lair R-2-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})
CSPlotOrder(PC,P7,48,"Lair R-2-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-2-3"), Deaths(P9,Exactly,330,12)})

Trigger { -- 1시 오른쪽 하이브 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-2")
	},
	actions = {
		SetDeaths(P9,Add,1,13);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,21,"Hive R-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PE,P7,56,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PE,P6,51,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PA,P7,54,"Hive R-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PC,P7,104,"Hive R-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PE,P6,93,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})
CSPlotOrder(PD,P7,48,"Hive R-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,AtLeast,0,13)})

CSPlotOrder(PLA,P6,8,"Hive R-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PE,P7,56,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PE,P6,51,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PA,P7,54,"Hive R-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PC,P7,104,"Hive R-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PE,P6,95,"Hive R-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})
CSPlotOrder(PD,P7,48,"Hive R-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-2"), Deaths(P9,Exactly,330,13)})

-- 9시 건작 -- (데스값 18~25)

Trigger { -- 9시 레어3-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-3-1")
	},
	actions = {
		SetDeaths(P9,Add,1,18);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,64,"Lair L-3-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PA,P7,55,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PA,P6,51,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PA,P7,54,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PB,P7,104,"Lair L-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PB,P6,75,"Lair L-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})
CSPlotOrder(PC,P7,48,"Lair L-3-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,AtLeast,0,18)})

CSPlotOrder(PLA,P6,64,"Lair L-3-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PA,P7,56,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PA,P6,51,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PA,P7,54,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PB,P7,104,"Lair L-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PA,P6,75,"Lair L-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})
CSPlotOrder(PC,P7,48,"Lair L-3-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-1"), Deaths(P9,Exactly,330,18)})

Trigger { -- 9시 레어3-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-3-2")
	},
	actions = {
		SetDeaths(P9,Add,1,19);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,64,"Lair L-3-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PA,P7,55,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PA,P6,51,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PA,P7,54,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PB,P7,104,"Lair L-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PB,P6,79,"Lair L-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})
CSPlotOrder(PC,P7,48,"Lair L-3-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,AtLeast,0,19)})

CSPlotOrder(PLA,P6,64,"Lair L-3-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PA,P7,56,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PA,P6,51,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PA,P7,54,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PB,P7,104,"Lair L-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PA,P6,79,"Lair L-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})
CSPlotOrder(PC,P7,48,"Lair L-3-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-3-2"), Deaths(P9,Exactly,330,19)})

Trigger { -- 9시 하이브3 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive L-3")
	},
	actions = {
		SetDeaths(P9,Add,1,20);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,86,"Hive L-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PE,P7,56,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PD,P6,64,"Hive L-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PE,P6,51,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PA,P7,54,"Hive L-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PC,P7,104,"Hive L-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PE,P6,75,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})
CSPlotOrder(PD,P7,48,"Hive L-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,AtLeast,0,20)})

CSPlotOrder(PLA,P6,86,"Hive L-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PE,P7,56,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PD,P6,64,"Hive L-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PE,P6,51,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PA,P7,54,"Hive L-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PC,P7,104,"Hive L-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PE,P6,79,"Hive L-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})
CSPlotOrder(PD,P7,48,"Hive L-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-3"), Deaths(P9,Exactly,330,20)})

Trigger { -- 9시 레어4-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-4-1")
	},
	actions = {
		SetDeaths(P9,Add,1,21);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,64,"Lair L-4-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PA,P7,55,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PA,P6,51,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PA,P7,54,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PB,P7,104,"Lair L-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PB,P6,76,"Lair L-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})
CSPlotOrder(PC,P7,48,"Lair L-4-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,AtLeast,0,21)})

CSPlotOrder(PLA,P6,64,"Lair L-4-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PA,P7,56,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PA,P6,51,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PA,P7,54,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PB,P7,104,"Lair L-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PA,P6,76,"Lair L-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})
CSPlotOrder(PC,P7,48,"Lair L-4-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-1"), Deaths(P9,Exactly,330,21)})


Trigger { -- 9시 레어4-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair L-4-2")
	},
	actions = {
		SetDeaths(P9,Add,1,22);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,64,"Lair L-4-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PA,P7,55,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PA,P6,51,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PA,P7,54,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PB,P7,104,"Lair L-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PB,P6,63,"Lair L-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})
CSPlotOrder(PC,P7,48,"Lair L-4-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,AtLeast,0,22)})

CSPlotOrder(PLA,P6,64,"Lair L-4-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PA,P7,55,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PA,P6,51,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PA,P7,54,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PB,P7,104,"Lair L-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PA,P6,63,"Lair L-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})
CSPlotOrder(PC,P7,48,"Lair L-4-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-4-2"), Deaths(P9,Exactly,330,22)})

Trigger { -- 9시 하이브4 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive L-4")
	},
	actions = {
		SetDeaths(P9,Add,1,23);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,86,"Hive L-4",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PE,P7,56,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PD,P6,64,"Hive L-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PE,P6,51,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PA,P7,54,"Hive L-4",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PC,P7,104,"Hive L-4",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PE,P6,76,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})
CSPlotOrder(PD,P7,48,"Hive L-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,AtLeast,0,23)})

CSPlotOrder(PLA,P6,86,"Hive L-4",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PE,P7,56,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PD,P6,64,"Hive L-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PE,P6,51,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PA,P7,54,"Hive L-4",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PC,P7,104,"Hive L-4",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PE,P6,63,"Hive L-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})
CSPlotOrder(PD,P7,48,"Hive L-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-4"), Deaths(P9,Exactly,330,23)})


Trigger { -- 9시 하이브5-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive L-5-1")
	},
	actions = {
		SetDeaths(P9,Add,1,24);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,60,"Hive L-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PE,P7,56,"Hive L-5-1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PE,P6,51,"Hive L-5-1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PA,P7,54,"Hive L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PC,P7,104,"Hive L-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PB,P6,81,"Hive L-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})
CSPlotOrder(PD,P7,48,"Hive L-5-1",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,AtLeast,0,24)})

CSPlotOrder(PLA,P6,60,"Hive L-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PE,P7,56,"Hive L-5-1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PE,P6,51,"Hive L-5-1",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PA,P7,54,"Hive L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PC,P7,104,"Hive L-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PA,P6,81,"Hive L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})
CSPlotOrder(PD,P7,48,"Hive L-5-1",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-1"), Deaths(P9,Exactly,330,24)})

Trigger { -- 9시 하이브5-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive L-5-2")
	},
	actions = {
		SetDeaths(P9,Add,1,25);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,60,"Hive L-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PE,P7,56,"Hive L-5-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PE,P6,51,"Hive L-5-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PA,P7,54,"Hive L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PC,P7,104,"Hive L-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PA,P6,25,"Hive L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})
CSPlotOrder(PD,P7,48,"Hive L-5-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,AtLeast,0,25)})

CSPlotOrder(PLA,P6,60,"Hive L-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PE,P7,56,"Hive L-5-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PE,P6,51,"Hive L-5-2",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PA,P7,54,"Hive L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PC,P7,104,"Hive L-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PB,P6,5,"Hive L-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})
CSPlotOrder(PD,P7,48,"Hive L-5-2",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive L-5-2"), Deaths(P9,Exactly,330,25)})

 -- 3시 건작 --

Trigger { -- 3시 레어 3-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-3-1")
	},
	actions = {
		SetDeaths(P9,Add,1,26);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,89,"Lair R-3-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PA,P6,55,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PA,P6,51,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PA,P7,54,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PB,P7,53,"Lair R-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PB,P6,17,"Lair R-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})
CSPlotOrder(PC,P7,48,"Lair R-3-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,AtLeast,0,26)})

CSPlotOrder(PLA,P6,90,"Lair R-3-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PA,P7,56,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PA,P6,51,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PA,P7,54,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PB,P7,53,"Lair R-3-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PA,P6,17,"Lair R-3-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})
CSPlotOrder(PC,P7,48,"Lair R-3-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-1"), Deaths(P9,Exactly,330,26)})

Trigger { -- 3시 레어 3-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-3-2")
	},
	actions = {
		SetDeaths(P9,Add,1,27);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,89,"Lair R-3-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PA,P7,55,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PA,P6,51,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PA,P7,54,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PB,P7,53,"Lair R-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PB,P6,17,"Lair R-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})
CSPlotOrder(PC,P7,48,"Lair R-3-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,AtLeast,0,27)})

CSPlotOrder(PLA,P6,90,"Lair R-3-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PA,P7,56,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PA,P6,51,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PA,P7,54,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PB,P7,53,"Lair R-3-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PA,P6,17,"Lair R-3-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})
CSPlotOrder(PC,P7,48,"Lair R-3-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-3-2"), Deaths(P9,Exactly,330,27)})

Trigger { -- 3시 하이브 3 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-3")
	},
	actions = {
		SetDeaths(P9,Add,1,28);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,90,"Hive R-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PE,P7,56,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PD,P6,96,"Hive R-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PE,P6,51,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PB,P7,54,"Hive R-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PC,P7,53,"Hive R-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PE,P6,17,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})
CSPlotOrder(PD,P7,48,"Hive R-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,AtLeast,0,28)})

CSPlotOrder(PLA,P6,30,"Hive R-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PE,P7,56,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PD,P6,89,"Hive R-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PE,P6,51,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PB,P7,54,"Hive R-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PC,P7,53,"Hive R-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PE,P6,17,"Hive R-3",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})
CSPlotOrder(PD,P7,48,"Hive R-3",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-3"), Deaths(P9,Exactly,330,28)})




Trigger { -- 3시 레어 4-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-4-1")
	},
	actions = {
		SetDeaths(P9,Add,1,29);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,89,"Lair R-4-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PA,P7,55,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PA,P6,51,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PA,P7,54,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PB,P7,53,"Lair R-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PB,P6,19,"Lair R-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})
CSPlotOrder(PC,P7,48,"Lair R-4-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,AtLeast,0,29)})

CSPlotOrder(PLA,P6,90,"Lair R-4-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PA,P7,56,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PA,P6,51,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PA,P7,54,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PB,P7,53,"Lair R-4-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PA,P6,19,"Lair R-4-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})
CSPlotOrder(PC,P7,48,"Lair R-4-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-1"), Deaths(P9,Exactly,330,29)})

Trigger { -- 3시 레어 4-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-4-2")
	},
	actions = {
		SetDeaths(P9,Add,1,30);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,89,"Lair R-4-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PA,P7,55,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PA,P6,51,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PA,P7,54,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PB,P7,53,"Lair R-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PB,P6,19,"Lair R-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})
CSPlotOrder(PC,P7,48,"Lair R-4-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,AtLeast,0,30)})

CSPlotOrder(PLA,P6,90,"Lair R-4-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PA,P7,56,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PA,P6,51,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PA,P7,54,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PB,P7,53,"Lair R-4-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PA,P6,19,"Lair R-4-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})
CSPlotOrder(PC,P7,48,"Lair R-4-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-4-2"), Deaths(P9,Exactly,330,30)})

Trigger { -- 3시 하이브 4 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-4")
	},
	actions = {
		SetDeaths(P9,Add,1,31);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,90,"Hive R-4",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PE,P7,56,"Hive R-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PD,P6,96,"Hive R-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PE,P6,51,"Hive R-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PB,P7,54,"Hive R-4",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PC,P7,53,"Hive R-4",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PA,P6,17,"Hive R-4",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})
CSPlotOrder(PD,P7,48,"Hive R-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,AtLeast,0,31)})

CSPlotOrder(PLA,P6,102,"Hive R-4",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PE,P7,56,"Hive R-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PD,P6,89,"Hive R-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PE,P6,51,"Hive R-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PB,P7,54,"Hive R-4",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PC,P7,53,"Hive R-4",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PE,P6,17,"Hive R-4",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})
CSPlotOrder(PD,P7,48,"Hive R-4",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-4"), Deaths(P9,Exactly,330,31)})

Trigger { -- 3시 레어 5-1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-5-1")
	},
	actions = {
		SetDeaths(P9,Add,1,32);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,22,"Lair R-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PA,P7,55,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PA,P6,51,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PA,P7,54,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PB,P7,53,"Lair R-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PB,P6,52,"Lair R-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})
CSPlotOrder(PC,P7,48,"Lair R-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,AtLeast,0,32)})

CSPlotOrder(PLA,P6,22,"Lair R-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PA,P7,56,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PA,P6,51,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PA,P7,54,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PB,P7,53,"Lair R-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PA,P6,52,"Lair R-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})
CSPlotOrder(PC,P7,48,"Lair R-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-1"), Deaths(P9,Exactly,330,32)})

Trigger { -- 3시 레어 5-2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(132,"Lair R-5-2")
	},
	actions = {
		SetDeaths(P9,Add,1,33);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,22,"Lair R-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PA,P7,55,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PA,P6,51,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PA,P7,54,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PB,P7,53,"Lair R-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PB,P6,52,"Lair R-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})
CSPlotOrder(PC,P7,48,"Lair R-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,AtLeast,0,33)})

CSPlotOrder(PLA,P6,22,"Lair R-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PA,P7,56,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PA,P6,51,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PA,P7,54,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PB,P7,53,"Lair R-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PA,P6,52,"Lair R-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})
CSPlotOrder(PC,P7,48,"Lair R-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair R-5-2"), Deaths(P9,Exactly,330,33)})

Trigger { -- 3시 하이브 5 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-5")
	},
	actions = {
		SetDeaths(P9,Add,1,34);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,30,"Hive R-5",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PE,P7,56,"Hive R-5",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PD,P6,96,"Hive R-5",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PE,P6,51,"Hive R-5",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PB,P7,54,"Hive R-5",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PC,P7,53,"Hive R-5",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PA,P6,52,"Hive R-5",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})
CSPlotOrder(PD,P7,48,"Hive R-5",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,AtLeast,0,34)})

CSPlotOrder(PLA,P6,102,"Hive R-5",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PE,P7,56,"Hive R-5",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PD,P6,96,"Hive R-5",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PE,P6,51,"Hive R-5",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PB,P7,54,"Hive R-5",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PC,P7,53,"Hive R-5",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PA,P6,52,"Hive R-5",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})
CSPlotOrder(PD,P7,48,"Hive R-5",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-5"), Deaths(P9,Exactly,330,34)})


Trigger { -- 3시 하이브 6 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-6")
	},
	actions = {
		SetDeaths(P9,Add,1,35);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,102,"Hive R-6",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PE,P7,56,"Hive R-6",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PD,P6,89,"Hive R-6",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PE,P6,51,"Hive R-6",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PB,P7,54,"Hive R-6",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PC,P7,53,"Hive R-6",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PA,P6,32,"Hive R-6",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})
CSPlotOrder(PD,P7,48,"Hive R-6",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,AtLeast,0,35)})

CSPlotOrder(PLA,P6,102,"Hive R-6",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PE,P7,56,"Hive R-6",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PD,P6,89,"Hive R-6",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PE,P6,51,"Hive R-6",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PB,P7,54,"Hive R-6",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PC,P7,53,"Hive R-6",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PE,P6,32,"Hive R-6",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
CSPlotOrder(PD,P7,48,"Hive R-6",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-6"), Deaths(P9,Exactly,330,35)})
Trigger { -- 3시 하이브 7 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(133,"Hive R-7")
	},
	actions = {
		SetDeaths(P9,Add,1,36);
		PreserveTrigger()
	}
}

CSPlotOrder(PLA,P6,102,"Hive R-7",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PE,P7,56,"Hive R-7",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PD,P6,90,"Hive R-7",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PE,P6,51,"Hive R-7",nil,1,64,PEE,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PB,P7,54,"Hive R-7",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PC,P7,53,"Hive R-7",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PD,P6,23,"Hive R-7",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PD,P7,48,"Hive R-7",nil,1,64,PDD,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,AtLeast,0,36)})
CSPlotOrder(PLA,P6,9,"Hive R-7",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(133,"Hive R-7"), Deaths(P9,Exactly,330,36)})

function Circle_Vector(X,Y) return {(X-Y)/2,(X+Y)/2} end ---- 대각선방향
C0 = CSMakeCircle(6,60,0,91,0) --------- 원본
C00 = CSMakeCircle(6,60,0,1,0)
C01 = CSMakeCircle(6,60,0,19,7)
C02 = CSMakeCircle(6,60,0,37,19)
C03 = CSMakeCircle(6,60,0,61,37)
C04 = CSMakeCircle(6,60,0,91,61)

CA = CSMakeCircle(6,60,0,51,0)
CAA = CS_MoveXY(CA,70,0)
CA0 = CS_Vector2D(CS_Subtract(C0,CAA,48),1,"Circle_Vector") ------- 1

CB = CSMakeCircle(5,60,0,51,0)
CBB = CS_MoveXY(CB,180,0)
CB0 = CS_Vector2D(CS_Subtract(C0,CBB,45),1,"Circle_Vector") ------- 2

CC = CSMakeCircle(6,60,0,19,0)
CCC = CS_MoveXY(CC,280,0)
CC0 = CS_Vector2D(CS_Subtract(C0,CCC,45),1,"Circle_Vector") ------- 3

CD0 = CS_Vector2D(C0,1,"Circle_Vector") --------- 4
 -- 센터 1 건작 -- (데스값 43~46)

Trigger { -- 제네 1 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 1")
	},
	actions = {
		SetDeaths(P9,Add,1,37);
		PreserveTrigger()
	}
}


CSPlotOrder(CA0,P8,84,"Generator 1",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,AtLeast,0,37)})
CSPlotOrder(CA0,P6,63,"Generator 1",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,1,37)})
CSPlotOrder(CA0,P8,89,"Generator 1",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,1,37)})
CSPlotOrder(CB0,P8,84,"Generator 1",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,320,37)})
CSPlotOrder(CB0,P6,63,"Generator 1",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,320,37)})
CSPlotOrder(CB0,P8,89,"Generator 1",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,320,37)})
CSPlotOrder(CC0,P8,84,"Generator 1",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,640,37)})
CSPlotOrder(CC0,P6,63,"Generator 1",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,640,37)})
CSPlotOrder(CC0,P8,89,"Generator 1",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,640,37)})
CSPlotOrder(C00,P8,84,"Generator 1",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,960,37)})
CSPlotOrder(C01,P8,84,"Generator 1",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,962,37)})
CSPlotOrder(C02,P8,84,"Generator 1",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,964,37)})
CSPlotOrder(C03,P8,84,"Generator 1",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,968,37)})
CSPlotOrder(C04,P8,84,"Generator 1",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,970,37)})
CSPlotOrder(C0,P8,84,"Generator 1",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,970,37)})
CSPlotOrder(CD0,P6,5,"Generator 1",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,970,37)})
CSPlotOrder(CD0,P8,89,"Generator 1",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 1"), Deaths(P9,Exactly,970,37)})

Trigger { -- 제네 1 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 1");
			Deaths(P9,AtMost,970,37);
		},
	actions = {
			CreateUnit(1,72,"Generator 1",P8);
			PreserveTrigger();
		}
}

Trigger { -- 제네 2 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 2")
	},
	actions = {
		SetDeaths(P9,Add,1,38);
		PreserveTrigger()
	}
}

CSPlotOrder(CA0,P8,84,"Generator 2",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,AtLeast,0,38)})
CSPlotOrder(CA0,P6,76,"Generator 2",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,1,38)})
CSPlotOrder(CA0,P8,21,"Generator 2",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,1,38)})
CSPlotOrder(CB0,P8,84,"Generator 2",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,320,38)})
CSPlotOrder(CB0,P6,76,"Generator 2",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,320,38)})
CSPlotOrder(CB0,P8,21,"Generator 2",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,320,38)})
CSPlotOrder(CC0,P8,84,"Generator 2",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,640,38)})
CSPlotOrder(CC0,P6,76,"Generator 2",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,640,38)})
CSPlotOrder(CC0,P8,21,"Generator 2",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,640,38)})
CSPlotOrder(C00,P8,84,"Generator 2",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,960,38)})
CSPlotOrder(C01,P8,84,"Generator 2",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,962,38)})
CSPlotOrder(C02,P8,84,"Generator 2",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,964,38)})
CSPlotOrder(C03,P8,84,"Generator 2",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,966,38)})
CSPlotOrder(C04,P8,84,"Generator 2",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,968,38)})
CSPlotOrder(C0,P8,84,"Generator 2",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,970,38)})
CSPlotOrder(CD0,P6,32,"Generator 2",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,970,38)})
CSPlotOrder(CD0,P8,8,"Generator 2",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 2"), Deaths(P9,Exactly,970,38)})


Trigger { -- 제네 2 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 2");
			Deaths(P9,AtMost,970,38);
		},
	actions = {
			CreateUnit(1,72,"Generator 2",P8);
			PreserveTrigger();
		}
}


Trigger { -- 제네 3 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 3")
	},
	actions = {
		SetDeaths(P9,Add,1,39);
		PreserveTrigger()
	}
}

CSPlotOrder(CA0,P8,84,"Generator 3",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,AtLeast,0,39)})
CSPlotOrder(CA0,P6,79,"Generator 3",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,1,39)})
CSPlotOrder(CA0,P8,80,"Generator 3",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,1,39)})
CSPlotOrder(CB0,P8,84,"Generator 3",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,320,39)})
CSPlotOrder(CB0,P6,79,"Generator 3",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,320,39)})
CSPlotOrder(CB0,P8,80,"Generator 3",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,320,39)})
CSPlotOrder(CC0,P8,84,"Generator 3",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,640,39)})
CSPlotOrder(CC0,P6,79,"Generator 3",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,640,39)})
CSPlotOrder(CC0,P8,80,"Generator 3",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,640,39)})
CSPlotOrder(C00,P8,84,"Generator 3",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,960,39)})
CSPlotOrder(C01,P8,84,"Generator 3",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,962,39)})
CSPlotOrder(C02,P8,84,"Generator 3",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,964,39)})
CSPlotOrder(C03,P8,84,"Generator 3",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,966,39)})
CSPlotOrder(C04,P8,84,"Generator 3",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,968,39)})
CSPlotOrder(C0,P8,84,"Generator 3",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,970,39)})
CSPlotOrder(CD0,P6,95,"Generator 3",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,970,39)})
CSPlotOrder(CD0,P8,88,"Generator 3",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 3"), Deaths(P9,Exactly,970,39)})

Trigger { -- 제네 3 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 3");
			Deaths(P9,AtMost,970,39);
		},
	actions = {
			CreateUnit(1,72,"Generator 3",P8);
			PreserveTrigger();
		}
}

Trigger { -- 제네 4 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 4")
	},
	actions = {
		SetDeaths(P9,Add,1,40);
		PreserveTrigger()
	}
}

CSPlotOrder(CA0,P8,84,"Generator 4",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,AtLeast,0,40)})
CSPlotOrder(CA0,P6,19,"Generator 4",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,1,40)})
CSPlotOrder(CA0,P8,60,"Generator 4",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,1,40)})
CSPlotOrder(CB0,P8,84,"Generator 4",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,320,40)})
CSPlotOrder(CB0,P6,19,"Generator 4",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,320,40)})
CSPlotOrder(CB0,P8,60,"Generator 4",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,320,40)})
CSPlotOrder(CC0,P8,84,"Generator 4",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,640,40)})
CSPlotOrder(CC0,P6,19,"Generator 4",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,640,40)})
CSPlotOrder(CC0,P8,60,"Generator 4",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,640,40)})
CSPlotOrder(C00,P8,84,"Generator 4",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,960,40)})
CSPlotOrder(C01,P8,84,"Generator 4",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,962,40)})
CSPlotOrder(C02,P8,84,"Generator 4",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,964,40)})
CSPlotOrder(C03,P8,84,"Generator 4",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,966,40)})
CSPlotOrder(C04,P8,84,"Generator 4",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,968,40)})
CSPlotOrder(C0,P8,84,"Generator 4",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,970,40)})
CSPlotOrder(CD0,P6,3,"Generator 4",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,970,40)})
CSPlotOrder(CD0,P8,64,"Generator 4",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 4"), Deaths(P9,Exactly,970,40)})

Trigger { -- 제네 4 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 4");
			Deaths(P9,AtMost,970,40);
		},
	actions = {
			CreateUnit(1,72,"Generator 4",P8);
			PreserveTrigger();
		}
}

Trigger { -- 제네 5 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 5")
	},
	actions = {
		SetDeaths(P9,Add,1,41);
		PreserveTrigger()
	}
}

CSPlotOrder(CA0,P8,84,"Generator 5",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,AtLeast,0,41)})
CSPlotOrder(CA0,P6,78,"Generator 5",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,1,41)})
CSPlotOrder(CA0,P8,22,"Generator 5",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,1,41)})
CSPlotOrder(CB0,P8,84,"Generator 5",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,320,41)})
CSPlotOrder(CB0,P6,78,"Generator 5",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,320,41)})
CSPlotOrder(CB0,P8,22,"Generator 5",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,320,41)})
CSPlotOrder(CC0,P8,84,"Generator 5",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,640,41)})
CSPlotOrder(CC0,P6,78,"Generator 5",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,640,41)})
CSPlotOrder(CC0,P8,22,"Generator 5",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,640,41)})
CSPlotOrder(C00,P8,84,"Generator 5",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,960,41)})
CSPlotOrder(C01,P8,84,"Generator 5",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,962,41)})
CSPlotOrder(C02,P8,84,"Generator 5",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,964,41)})
CSPlotOrder(C03,P8,84,"Generator 5",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,966,41)})
CSPlotOrder(C04,P8,84,"Generator 5",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,968,41)})
CSPlotOrder(C0,P8,84,"Generator 5",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,970,41)})
CSPlotOrder(CD0,P6,81,"Generator 5",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,970,41)})
CSPlotOrder(CD0,P8,86,"Generator 5",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 5"), Deaths(P9,Exactly,970,41)})

Trigger { -- 제네 5 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 5");
			Deaths(P9,AtMost,970,41);
		},
	actions = {
			CreateUnit(1,72,"Generator 5",P8);
			PreserveTrigger();
		}
}

Trigger { -- 제네 6 데스값
	players = {P6},
	conditions = {
		CommandLeastAt(200,"Generator 6")
	},
	actions = {
		SetDeaths(P9,Add,1,42);
		PreserveTrigger()
	}
}

CSPlotOrder(CA0,P8,84,"Generator 6",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,AtLeast,0,42)})
CSPlotOrder(CA0,P6,17,"Generator 6",nil,1,64,CA0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,1,42)})
CSPlotOrder(CA0,P8,96,"Generator 6",nil,1,64,CA0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,1,42)})
CSPlotOrder(CB0,P8,84,"Generator 6",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,320,42)})
CSPlotOrder(CB0,P6,17,"Generator 6",nil,1,64,CB0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,320,42)})
CSPlotOrder(CB0,P8,96,"Generator 6",nil,1,64,CB0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,320,42)})
CSPlotOrder(CC0,P8,84,"Generator 6",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,640,42)})
CSPlotOrder(CC0,P6,17,"Generator 6",nil,1,64,CC0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,640,42)})
CSPlotOrder(CC0,P8,96,"Generator 6",nil,1,64,CC0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,640,42)})
CSPlotOrder(C00,P8,84,"Generator 6",nil,1,64,C00,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,960,42)})
CSPlotOrder(C01,P8,84,"Generator 6",nil,1,64,C01,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,962,42)})
CSPlotOrder(C02,P8,84,"Generator 6",nil,1,64,C02,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,964,42)})
CSPlotOrder(C03,P8,84,"Generator 6",nil,1,64,C03,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,966,42)})
CSPlotOrder(C04,P8,84,"Generator 6",nil,1,64,C04,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,968,42)})
CSPlotOrder(C0,P8,84,"Generator 6",nil,1,64,C0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,970,42)})
CSPlotOrder(CD0,P6,77,"Generator 6",nil,1,64,CD0,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,970,42)})
CSPlotOrder(CD0,P8,90,"Generator 6",nil,1,64,CD0,0,Attack,"CenterCenter",nil,0,nil,P6,{CommandLeastAt(200,"Generator 6"), Deaths(P9,Exactly,970,42)})

Trigger { -- 제네 6 중앙 이펙트
	players = {P6},
	conditions = {
			CommandLeastAt(200,"Generator 6");
			Deaths(P9,AtMost,970,42);
		},
	actions = {
			CreateUnit(1,72,"Generator 6",P8);
			PreserveTrigger();
		}
}

 -- 5시 건작 -- (데스값 57~62)

 PPA = CSMakePolygonX(6,80,0,54,0)
 PPB = CSMakePolygonX(6,80,0,54,6)
 PPC = CSMakePolygonX(6,80,0,54,24)
 PPD = CSMakePolygonX(6,80,0,24,6)
 PPE = CSMakePolygon(6,60,0,19,7)
 
	 
 Trigger { -- R9 젤왼쪽하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-9-1")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,57);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-1",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-1",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPD,P6,77,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPD,P6,80,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 CSPlotOrder(PPE,P6,65,"Hive R-9-1",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,AtLeast,0,57)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-1",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-1",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPD,P6,77,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPD,P6,88,"Hive R-9-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 CSPlotOrder(PPE,P6,65,"Hive R-9-1",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-1"),Deaths(P9,Exactly,330,57)})
 
 Trigger { -- R9 중앙하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-9-2")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,58);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-2",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-2",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPD,P6,78,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPD,P6,80,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 CSPlotOrder(PPE,P6,66,"Hive R-9-2",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,AtLeast,0,58)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-2",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-2",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPD,P6,78,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPD,P6,88,"Hive R-9-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 CSPlotOrder(PPE,P6,66,"Hive R-9-2",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-2"),Deaths(P9,Exactly,330,58)})
 
 Trigger { -- R9 오른쪽하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-9-3")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,59);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-3",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-3",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPD,P6,79,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPD,P6,80,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 CSPlotOrder(PPE,P6,87,"Hive R-9-3",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,AtLeast,0,59)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-9-3",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPB,P7,51,"Hive R-9-3",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPC,P6,53,"Hive R-9-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPC,P7,56,"Hive R-9-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPD,P6,54,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPD,P6,79,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPD,P6,88,"Hive R-9-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 CSPlotOrder(PPE,P6,87,"Hive R-9-3",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-9-3"),Deaths(P9,Exactly,330,59)})
 
 Trigger { -- R8 오른쪽하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-8-3")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,60);
		 PreserveTrigger()
	 }
 }
	 
 CSPlotOrder(PPA,P6,104,"Hive R-8-3",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-3",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPD,P6,75,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPD,P6,21,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 CSPlotOrder(PPE,P6,61,"Hive R-8-3",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,AtLeast,0,60)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-8-3",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-3",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-3",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPD,P6,75,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPD,P6,8,"Hive R-8-3",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 CSPlotOrder(PPE,P6,61,"Hive R-8-3",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-3"),Deaths(P9,Exactly,330,60)})
 
 Trigger { -- R8 중앙하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-8-2")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,61);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PPA,P6,104,"Hive R-8-2",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-2",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPD,P6,25,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPD,P6,90,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 CSPlotOrder(PPE,P6,5,"Hive R-8-2",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,AtLeast,0,61)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-8-2",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-2",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-2",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPD,P6,25,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPD,P6,58,"Hive R-8-2",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 CSPlotOrder(PPE,P6,5,"Hive R-8-2",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-2"),Deaths(P9,Exactly,330,61)})
 
 Trigger { -- R8 왼쪽하이브
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive R-8-1")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,62);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PPA,P6,104,"Hive R-8-1",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-1",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPD,P6,17,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPD,P6,90	,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 CSPlotOrder(PPE,P6,3,"Hive R-8-1",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,AtLeast,0,62)})
 
 CSPlotOrder(PPA,P6,104,"Hive R-8-1",nil,1,64,PPA,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPB,P7,51,"Hive R-8-1",nil,1,64,PPB,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPC,P6,53,"Hive R-8-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPC,P7,56,"Hive R-8-1",nil,1,64,PPC,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPD,P6,54,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPD,P6,17,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPD,P6,58,"Hive R-8-1",nil,1,64,PPD,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 CSPlotOrder(PPE,P6,3,"Hive R-8-1",nil,1,64,PPE,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive R-8-1"),Deaths(P9,Exactly,330,62)})
 
 
  ------ 데스값 63~66 ----------
 
  -- 6시 건작 --
	 
 Trigger { -- 6시 레어 5-3 데스값
	 players = {P6},
	 conditions = {
		 CommandLeastAt(132,"Lair L-5-3")
	 },
	 actions = {	
		 SetDeaths(P9,Add,1,63);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PA,P7,56,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PA,P6,77,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PA,P6,81,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PB,P7,104,"Lair L-5-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PB,P7,51,"Lair L-5-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 CSPlotOrder(PC,P7,48,"Lair L-5-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,AtLeast,0,63)})
 
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-3",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PA,P7,56,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PA,P6,78,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PA,P6,81,"Lair L-5-3",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PB,P7,104,"Lair L-5-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PB,P7,51,"Lair L-5-3",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 CSPlotOrder(PC,P7,48,"Lair L-5-3",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-3"), Deaths(P9,Exactly,330,63)})
 
 
 
 Trigger { -- 6시 레어 5-2 데스값
	 players = {P6},
	 conditions = {
		 CommandLeastAt(132,"Lair L-5-2")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,64);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PA,P7,56,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PA,P6,17,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PA,P6,19,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PB,P7,104,"Lair L-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PB,P7,51,"Lair L-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 CSPlotOrder(PC,P7,48,"Lair L-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,AtLeast,0,64)})
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-2",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PA,P7,56,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PA,P6,32,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PA,P6,25,"Lair L-5-2",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PB,P7,104,"Lair L-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PB,P7,51,"Lair L-5-2",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 CSPlotOrder(PC,P7,48,"Lair L-5-2",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-2"), Deaths(P9,Exactly,330,64)})
 
 
 
 Trigger { -- 6시 레어 5-1 데스값
	 players = {P6},
	 conditions = {
		 CommandLeastAt(132,"Lair L-5-1")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,65);
		 PreserveTrigger()
	 }
 }
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PA,P7,56,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PA,P6,3,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PA,P6,5,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PB,P7,51,"Lair L-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PB,P7,104,"Lair L-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 CSPlotOrder(PC,P7,48,"Lair L-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,AtLeast,0,65)})
 
 CSPlotOrder(PLA,P6,98,"Lair L-5-1",nil,1,64,PLA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PA,P7,56,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PA,P6,25,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PA,P6,81,"Lair L-5-1",nil,1,64,PAA,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PB,P7,51,"Lair L-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PB,P7,104,"Lair L-5-1",nil,1,64,PBB,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 CSPlotOrder(PC,P7,48,"Lair L-5-1",nil,1,64,PCC,0,Attack,"Heal Zone",nil,0,nil,P6,{CommandLeastAt(132,"Lair L-5-1"), Deaths(P9,Exactly,330,65)})
 
 
 Trigger { -- 6시 하이브 6 데스값
	 players = {P6},
	 conditions = {
		 CommandLeastAt(133,"Hive L-6")
	 },
	 actions = {
		 SetDeaths(P9,Add,1,66);
		 PreserveTrigger()
	 }
 }
 
  -- 정육각형 외접원 --
 
 CX0 = CSMakeCircleX(6,80,30,54,0)
 CX1 = CSMakeCircleX(6,80,30,54,24)
 CX2 = CSMakeCircleX(6,80,30,30,0)
 CX3 = CSMakeCircleX(6,80,30,30,6)
 CX4 = CSMakeCircleX(6,80,30,18,0)
 
 CSPlotOrder(CX0,P7,104,"Hive L-6",nil,1,64,CX0,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX1,P7,51,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX1,P7,53,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX0,P7,56,"Hive L-6",nil,1,64,CX0,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX2,P6,32,"Hive L-6",nil,1,64,CX2,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX4,P6,76,"Hive L-6",nil,1,64,CX4,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX1,P6,25,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX2,P6,96,"Hive L-6",nil,1,64,CX2,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 CSPlotOrder(CX1,P6,58,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,AtLeast,0,66)})
 
 CSPlotOrder(CX0,P7,104,"Hive L-6",nil,1,64,CX0,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX1,P7,51,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX1,P7,53,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX0,P7,56,"Hive L-6",nil,1,64,CX0,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX2,P6,32,"Hive L-6",nil,1,64,CX2,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX4,P6,63,"Hive L-6",nil,1,64,CX4,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX1,P6,30,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX2,P6,58,"Hive L-6",nil,1,64,CX2,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
 CSPlotOrder(CX1,P6,96,"Hive L-6",nil,1,64,CX1,0,Attack,"Heal Zone",nil,64,nil,P6,{CommandLeastAt(133,"Hive L-6"),Deaths(P9,Exactly,330,66)})
  

CIfEnd() -- P6 건작트리거단락 종료



CIf(P7,{NVar(GunLock,Exactly,0)}) -- P7 건작트리거단락 시작

Trigger { -- 11시 순대 데스값
	players = {P7},
	conditions = {
		CommandLeastAt(152,"Daggoth L")
	},
	actions = {
		SetDeaths(P9,Add,1,7);
		PreserveTrigger()
	}
}

Trigger { -- 11시 순대 이펙트
	players = {P7},
	conditions = {
		CommandLeastAt(152,"Daggoth L");
		Deaths(P9,AtMost,320,7)
	},
	actions = {
		CreateUnit(1,"【Thanks to Galaxy Burst】","Daggoth L",P8);
		PreserveTrigger()
	}
}

 -- 11시 순대 건작

CircleA = CSMakeCircle(6,60,0,61,37)
CircleB = CSMakeCircle(6,60,0,37,19)
CircleC = CSMakeCircle(6,60,0,19,7)
CircleD = CSMakeCircle(6,60,0,7,1)
CircleE = CSMakeCircle(6,60,0,61,1)
CircleF = CSMakeCircle(6,60,0,91,1)
CircleFF = CSMakeCircle(6,60,0,91,1)

CSPlotOrder(CircleD,P8,72,"Daggoth L",nil,1,64,CircleD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,1,7)})
CSPlotOrder(CircleD,P6,80,"Daggoth L",nil,1,64,CircleD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,1,7)})
CSPlotOrder(CircleD,P6,77,"Daggoth L",nil,1,64,CircleD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,1,7)})
CSPlotOrder(CircleA,P6,25,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,1,7)})

CSPlotOrder(CircleC,P8,72,"Daggoth L",nil,1,64,CircleC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,80,7)})
CSPlotOrder(CircleC,P6,80,"Daggoth L",nil,1,64,CircleC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,80,7)})
CSPlotOrder(CircleC,P6,78,"Daggoth L",nil,1,64,CircleC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,80,7)})
CSPlotOrder(CircleA,P6,25,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,80,7)})

CSPlotOrder(CircleB,P8,72,"Daggoth L",nil,1,64,CircleB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,160,7)})
CSPlotOrder(CircleB,P6,80,"Daggoth L",nil,1,64,CircleB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,160,7)})
CSPlotOrder(CircleB,P6,77,"Daggoth L",nil,1,64,CircleB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,160,7)})
CSPlotOrder(CircleA,P6,25,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,160,7)})

CSPlotOrder(CircleA,P8,72,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,240,7)})
CSPlotOrder(CircleA,P6,80,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,240,7)})
CSPlotOrder(CircleA,P6,78,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,240,7)})
CSPlotOrder(CircleA,P6,25,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,240,7)})

CSPlotOrder(CircleD,P8,72,"Daggoth L",nil,1,64,CircleD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,296,7)})
CSPlotOrder(CircleC,P8,72,"Daggoth L",nil,1,64,CircleC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,302,7)})
CSPlotOrder(CircleB,P8,72,"Daggoth L",nil,1,64,CircleB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,308,7)})
CSPlotOrder(CircleA,P8,72,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,314,7)})
CSPlotOrder(CircleF,P6,88,"Daggoth L",nil,1,64,CircleFF,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,320,7)})
CSPlotOrder(CircleE,P6,79,"Daggoth L",nil,1,64,CircleE,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,320,7)})
CSPlotOrder(CircleA,P6,25,"Daggoth L",nil,1,64,CircleA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth L"), Deaths(P9,Exactly,320,7)})

 -- 우측 순대 건작 --

Trigger { -- 우측 순대 건작데스값
	players = {P7},
	conditions = {
		CommandLeastAt(152,"Daggoth R")
	},
	actions = {
		SetDeaths(P9,Add,1,14);
		PreserveTrigger()
	}
}

Trigger { -- 우측 순대 건작 이펙트
	players = {P7},
	conditions = {
		CommandLeastAt(152,"Daggoth R");
		Deaths(P9,AtMost,320,14)
	},
	actions = {
		CreateUnit(1,"【Thanks to Galaxy Burst】","Daggoth R",P8);
		PreserveTrigger()
	}
}

PentagonA = CSMakePolygon(5,60,0,6,1)
PentagonB = CSMakePolygon(5,60,0,16,6)
PentagonC = CSMakePolygon(5,60,0,31,16)
PentagonD = CSMakePolygon(5,60,0,51,31)
PentagonE = CSMakePolygon(5,60,0,51,1)

CSPlotOrder(PentagonA,P8,84,"Daggoth R",nil,1,64,PentagonA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,1,14)})
CSPlotOrder(PentagonA,P6,8,"Daggoth R",nil,1,64,PentagonA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,1,14)})
CSPlotOrder(PentagonA,P6,93,"Daggoth R",nil,1,64,PentagonA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,1,14)})
CSPlotOrder(PentagonD,P6,25,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,1,14)})

CSPlotOrder(PentagonB,P8,84,"Daggoth R",nil,1,64,PentagonB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,80,14)})
CSPlotOrder(PentagonB,P6,8,"Daggoth R",nil,1,64,PentagonB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,80,14)})
CSPlotOrder(PentagonB,P6,95,"Daggoth R",nil,1,64,PentagonB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,80,14)})
CSPlotOrder(PentagonD,P6,25,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,80,14)})

CSPlotOrder(PentagonC,P8,84,"Daggoth R",nil,1,64,PentagonC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,160,14)})
CSPlotOrder(PentagonC,P6,8,"Daggoth R",nil,1,64,PentagonC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,160,14)})
CSPlotOrder(PentagonC,P6,93,"Daggoth R",nil,1,64,PentagonC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,160,14)})
CSPlotOrder(PentagonD,P6,25,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,160,14)})

CSPlotOrder(PentagonD,P8,84,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,240,14)})
CSPlotOrder(PentagonD,P6,8,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,240,14)})
CSPlotOrder(PentagonD,P6,95,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,240,14)})
CSPlotOrder(PentagonD,P6,25,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,240,14)})

CSPlotOrder(PentagonA,P8,84,"Daggoth R",nil,1,64,PentagonA,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,296,14)})
CSPlotOrder(PentagonB,P8,84,"Daggoth R",nil,1,64,PentagonB,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,302,14)})
CSPlotOrder(PentagonC,P8,84,"Daggoth R",nil,1,64,PentagonC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,308,14)})
CSPlotOrder(PentagonD,P8,84,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,314,14)})
CSPlotOrder(PentagonE,P8,84,"Daggoth R",nil,1,64,PentagonE,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,320,14)})
CSPlotOrder(PentagonE,P6,89,"Daggoth R",nil,1,64,PentagonE,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,320,14)})
CSPlotOrder(PentagonE,P6,3,"Daggoth R",nil,1,64,PentagonE,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,320,14)})
CSPlotOrder(PentagonD,P6,25,"Daggoth R",nil,1,64,PentagonD,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(152,"Daggoth R"), Deaths(P9,Exactly,320,14)})
--- ↑↑ P9 데스값 7~14 // 펜타곤A~E, 써클A~E, 폴리건 1A~1D 사용완료 ↑↑ ---

 -- 코쿤 건작 --

Trigger { -- 코쿤 건작 데스값
	players = {P7},
	conditions = {
		CommandLeastAt(201,"Cocoon")
	},
	actions = {
		SetDeaths(P9,Add,1,15);
		PreserveTrigger()
	}
}
 -- 가로 파도모양 --
-- A,C = Air 3 \\ B,D = Air 4
function Cos_FuncY(X) return math.cos(X) end
WaveShapeA = CSMakeGraphX({256,256},"Cos_FuncY",0,0,0.1,nil,190) -- y= math.cos(x)

function Cos_FuncY(X) return math.cos(X) end
WaveShapeB = CSMakeGraphX({256,256},"Cos_FuncY",0,1,0.2,nil,96) -- y= math.cos(x)

function Cos_FuncY(X) return math.cos(X) end
WaveShapeC = CSMakeGraphX({256,256},"Cos_FuncY",0,0,0.2,nil,96) -- y= math.cos(x)

function Cos_FuncY(X) return math.cos(X) end
WaveShapeD = CSMakeGraphX({256,256},"Cos_FuncY",0,1,0.7,nil,28) -- y= math.cos(x)

CSPlot(WaveShapeA,P8,62,"Air 3",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,AtLeast,0,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeB,P8,80,"Air 4",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,150,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeB,P8,21,"Air 4",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,300,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeC,P8,60,"Air 3",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,450,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeB,P8,89,"Air 4",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,600,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeC,P8,90,"Air 3",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,800,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeC,P8,64,"Air 3",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,1000,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})
CSPlot(WaveShapeD,P8,27,"Air 4",nil,1,32,P7,{CommandLeastAt(201,"Cocoon"), Deaths(P9,Exactly,1200,15)},{Order("Men",P8,"Air Attack",Patrol,"Heal Zone")})

SQ0 = CSMakePolygon(4,360,0,41,25) -- 리빌러


Trigger { -- 센터1 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1")
	},
	actions = {
		SetDeaths(P9,Add,1,43);
		SetDeaths(P9,Add,1,45);
		SetDeaths(P9,Add,1,46);
		PreserveTrigger()
	}
}

Trigger { -- 센터 1 on/off 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1")
	},
	actions = {
		SetDeaths(P9,SetTo,1,44)
	}
}

Trigger { -- 센터 1 스카무적
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1");
		Deaths(P9,Exactly,1,44);
	},
	actions = {
		SetInvincibility(Enable,80,P8,"Anywhere");
		PreserveTrigger()
	}
}

Trigger { -- 리빌러
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1");
		Deaths(P9,AtLeast,0,45)
	},
	actions = {
		CreateUnit(1,"Map Revealer","Generator 1",P8);
		CreateUnit(1,"Map Revealer","Generator 2",P8);
		CreateUnit(1,"Map Revealer","Generator 3",P8);
		CreateUnit(1,"Map Revealer","Generator 4",P8);
		CreateUnit(1,"Map Revealer","Generator 5",P8);
		CreateUnit(1,"Map Revealer","Generator 6",P8);
		CreateUnit(1,"Map Revealer","Sky 1",P8);
		CreateUnit(1,"Map Revealer","Sky 2",P8);
		CreateUnit(1,"Map Revealer","Sky 3",P8);
		CreateUnit(1,"Map Revealer","Sky 4",P8);
	}
}

CSPlot(SQ0,P8,101,"CenterCenter",nil,1,64,P7,{CommandLeastAt("Palm Center","Center 1"),Deaths(P9,AtLeast,0,45)})

Trigger { -- 리빌러 삭제
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1");
		Deaths(P9,Exactly,700,45)
	},
	actions = {
		RemoveUnit("Map Revealer",P8);
	}
}


Trigger { -- 센터 중앙이펙트 1
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,1,46)
	},
	actions = {
		CreateUnit(1,84,"Center E1",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 2
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,5,46)
	},
	actions = {
		CreateUnit(1,84,"Center E2",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 3
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,9,46)
	},
	actions = {
		CreateUnit(1,84,"Center E3",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 4
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,13,46)
	},
	actions = {
		CreateUnit(1,84,"Center E4",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 5
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,17,46)
	},
	actions = {
		CreateUnit(1,84,"Center E5",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 6
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,44);
		Deaths(P9,Exactly,21,46)
	},
	actions = {
		CreateUnit(1,84,"Center E6",P8);
		SetDeaths(P9,SetTo,0,46);
		PreserveTrigger()
	}
}


Trigger { -- 센터1 유닛생산
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,16,43);
		Deaths(P9,Exactly,1,44)
	},
	actions = {
		CreateUnit(1,72,"Center 1",P8);
		CreateUnit(1,80,"Center 1",P8);
		CreateUnit(1,72,"Center 2",P8);
		CreateUnit(1,80,"Center 2",P8);
		CreateUnit(1,72,"Center 3",P8);
		CreateUnit(1,80,"Center 3",P8);
		SetDeaths(P9,SetTo,0,43);
		PreserveTrigger()
	}
}

Trigger { -- p8 스카 무브오더
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1");
		Deaths(P9,AtMost,698,45)
	},
	actions = {
		Order(80,P8,"Anywhere",Move,"CenterCenter");
		PreserveTrigger()
	}
}


Trigger { -- 센터1 정야독
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,700,45)
	},
	actions = {
		SetDeaths(P9,SetTo,0,44);
		GiveUnits(all,80,P8,"Anywhere",P6);
		GiveUnits(all,89,P11,"Anywhere",P6);
		SetInvincibility(Disable,80,P6,"Anywhere");
		SetInvincibility(Disable,89,P6,"Anywhere");
		CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")},{P6},P7);
	}
}

CircleA = CSMakeCircle(6,60,0,61,0) ---- 작은 원
EllipseA = CS_Distortion(CircleA,{2,1},{2,1},{2,1},{2,1}) ---- 작은 타원
EllipseRA = CS_Rotate(EllipseA,15) ---- 작은 타원 회전

CircleB = CSMakeCircle(6,40,0,91,0) ---- 큰 원
EllipseB = CS_Distortion(CircleB,{3,1.5},{3,1.5},{3,1.5},{3,1.5}) ---- 큰 타원
EllipseRB = CS_Rotate(EllipseB,40) ---- 큰 타원 회전
EllipseRAD = CS_MoveXY(EllipseRA,0,500) ---- 큰 타원 평행이동
EllipseShape = CS_Merge(EllipseRB,EllipseRAD,64,1) ---- 작은타원 큰타원 합
EllipseMirror = CS_MirrorX(EllipseShape,500,1,1) ---- X축 대칭

CAPlot(EllipseMirror,P8,89,"Butterfly",nil,1,32,{1,0,0,0,1,0},nil,P7,{CommandLeastAt("Palm Center","Center 1"),Deaths(P9,AtLeast,0,45)}
	,{SetInvincibility(Enable,89,P8,"Butterfly"),GiveUnits(all,89,P8,"Butterfly",P11)})

Trigger {
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 1");
		Deaths(P9,AtLeast,0,45)
	},
	actions = {
		SetInvincibility(Enable,89,P8,"Anywhere");
		GiveUnits(all,89,P8,"Anywhere",P11)
	}
}

-- 센터 2 -- (데스값 76~79)

Trigger { -- 센터 2 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2")
	},
	actions = {
		SetDeaths(P9,Add,1,76);
		SetDeaths(P9,Add,1,78);
		SetDeaths(P9,Add,1,79);
		PreserveTrigger()
	}
}

Trigger { -- 센터2 on/off 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2")
	},
	actions = {
		SetDeaths(P9,SetTo,1,77)
	}
}

Trigger { -- 센터2 커세어무적
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2");
		Deaths(P9,Exactly,1,77);
	},
	actions = {
		SetInvincibility(Enable,98,P8,"Anywhere");
		PreserveTrigger()
	}
}

Trigger { -- 리빌러
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2");
		Deaths(P9,AtLeast,0,78)
	},
	actions = {
		CreateUnit(1,"Map Revealer","Generator 1",P8);
		CreateUnit(1,"Map Revealer","Generator 2",P8);
		CreateUnit(1,"Map Revealer","Generator 3",P8);
		CreateUnit(1,"Map Revealer","Generator 4",P8);
		CreateUnit(1,"Map Revealer","Generator 5",P8);
		CreateUnit(1,"Map Revealer","Generator 6",P8);
		CreateUnit(1,"Map Revealer","Sky 1",P8);
		CreateUnit(1,"Map Revealer","Sky 2",P8);
		CreateUnit(1,"Map Revealer","Sky 3",P8);
		CreateUnit(1,"Map Revealer","Sky 4",P8);
	}
}

CSPlot(SQ0,P8,101,"CenterCenter",nil,1,64,P7,{CommandLeastAt("Palm Center","Center 2"),Deaths(P9,AtLeast,0,78)})

Trigger { -- 리빌러 삭제
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2");
		Deaths(P9,Exactly,700,78)
	},
	actions = {
		RemoveUnit("Map Revealer",P8)
	}
}

Trigger { -- 센터 중앙이펙트 1
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,1,79)
	},
	actions = {
		CreateUnit(1,84,"Center E1",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 2
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,5,79)
	},
	actions = {
		CreateUnit(1,84,"Center E2",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 3
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,9,79)
	},
	actions = {
		CreateUnit(1,84,"Center E3",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 4
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,13,79)
	},
	actions = {
		CreateUnit(1,84,"Center E4",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 5
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,17,79)
	},
	actions = {
		CreateUnit(1,84,"Center E5",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 6
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,77);
		Deaths(P9,Exactly,21,79)
	},
	actions = {
		CreateUnit(1,84,"Center E6",P8);
		SetDeaths(P9,SetTo,0,79);
		PreserveTrigger()
	}
}

Trigger { -- 센터2 유닛생산
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,16,76);
		Deaths(P9,Exactly,1,77)
	},
	actions = {
		CreateUnit(1,72,"Center 1",P8);
		CreateUnit(1,98,"Center 1",P8);
		CreateUnit(1,72,"Center 2",P8);
		CreateUnit(1,98,"Center 2",P8);
		CreateUnit(1,72,"Center 3",P8);
		CreateUnit(1,98,"Center 3",P8);
		SetDeaths(P9,SetTo,0,76);
		PreserveTrigger()
	}
}

Trigger { -- p8 커세어 무브오더
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 2");
		Deaths(P9,AtMost,698,78)
	},
	actions = {
		Order(98,P8,"Anywhere",Move,"CenterCenter");
		PreserveTrigger()
	}
}

function SF_Vector(X,Y) return {0.8*(X+Y),0.8*(X-Y)} end

SF0 = CSMakePolygonX(6,60,30,96,54)
SFM = CS_MoveXY(SF0,380,0)
SFM1 = CS_Merge(SF0,SFM,5,0)
SLineA = CSMakeLineX(1,60,90,25,1)
SLineB = CS_MoveXY(CSMakePolygonX(5,60,18,45,20),860,0)
SFM2 = CS_Merge(CS_Merge(SFM1,SLineA,5,0),SLineB,5,0)
SFM3 =CS_Kaleidoscope(SFM2,6,0,0)
SF1 = CS_SortA(CS_Vector2D(CS_RemoveStack(SFM3,12),1,"SF_Vector"),1)

CAPlot(SF1,P8,21,"CenterCenter",nil,1,32,{1,0,0,0,1,0},nil,P7,{CommandLeastAt("Palm Center","Center 2"),Deaths(P9,AtLeast,0,78)}
	,{SetInvincibility(Enable,21,P8,"CenterCenter"),GiveUnits(all,21,P8,"CenterCenter",P11)})

Trigger { -- 센터2 정야독
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,700,78)
	},
	actions = {
		SetDeaths(P9,SetTo,0,77);
		GiveUnits(all,98,P8,"Anywhere",P6);
		GiveUnits(all,21,P11,"Anywhere",P6);
		SetInvincibility(Disable,98,P6,"Anywhere");
		SetInvincibility(Disable,21,P6,"Anywhere");
		CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")},{P6},P7);
	}
}

 -- 센터 3  -- (데스값 47~50)

Trigger { -- 센터3 건작 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3")
	},
	actions = {
		SetDeaths(P9,Add,1,47);
		SetDeaths(P9,Add,1,49);
		SetDeaths(P9,Add,1,50);
		PreserveTrigger()
	}
}


Trigger { -- 센터3 on/off 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3")
	},
	actions = {
		SetDeaths(P9,SetTo,1,48)
	}
}

Trigger { -- -- 센터3 유닛무적
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3");
		Deaths(P9,Exactly,1,48);
	},
	actions = {
		SetInvincibility(Enable,22,P8,"Anywhere");
		PreserveTrigger()
	}
}

Trigger { -- 리빌러
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3");
		Deaths(P9,AtLeast,0,49)
	},
	actions = {
		CreateUnit(1,"Map Revealer","Generator 1",P8);
		CreateUnit(1,"Map Revealer","Generator 2",P8);
		CreateUnit(1,"Map Revealer","Generator 3",P8);
		CreateUnit(1,"Map Revealer","Generator 4",P8);
		CreateUnit(1,"Map Revealer","Generator 5",P8);
		CreateUnit(1,"Map Revealer","Generator 6",P8);
		CreateUnit(1,"Map Revealer","Sky 1",P8);
		CreateUnit(1,"Map Revealer","Sky 2",P8);
		CreateUnit(1,"Map Revealer","Sky 3",P8);
		CreateUnit(1,"Map Revealer","Sky 4",P8);
	}
}

CSPlot(SQ0,P8,101,"CenterCenter",nil,1,64,P7,{CommandLeastAt("Palm Center","Center 3"),Deaths(P9,AtLeast,0,49)})

Trigger { -- 리빌러 삭제
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3");
		Deaths(P9,Exactly,700,49)
	},
	actions = {
		RemoveUnit("Map Revealer",P8)
	}
}


Trigger { -- 센터 중앙이펙트 1
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,1,50)
	},
	actions = {
		CreateUnit(1,84,"Center E1",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 2
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,5,50)
	},
	actions = {
		CreateUnit(1,84,"Center E2",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 3
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,9,50)
	},
	actions = {
		CreateUnit(1,84,"Center E3",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 4
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,13,50)
	},
	actions = {
		CreateUnit(1,84,"Center E4",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 5
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,17,50)
	},
	actions = {
		CreateUnit(1,84,"Center E5",P8);
		PreserveTrigger()
	}
}

Trigger { -- 센터 중앙이펙트 6
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,1,48);
		Deaths(P9,Exactly,21,50)
	},
	actions = {
		CreateUnit(1,84,"Center E6",P8);
		SetDeaths(P9,SetTo,0,50);
		PreserveTrigger()
	}
}

Trigger { -- 센터3 유닛생산
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,16,47);
		Deaths(P9,Exactly,1,48)
	},
	actions = {
		CreateUnit(1,72,"Center 1",P8);
		CreateUnit(1,22,"Center 1",P8);
		CreateUnit(1,72,"Center 2",P8);
		CreateUnit(1,22,"Center 2",P8);
		CreateUnit(1,72,"Center 3",P8);
		CreateUnit(1,22,"Center 3",P8);
		SetDeaths(P9,SetTo,0,47);
		PreserveTrigger()
	}
}

Trigger { -- p8 배틀 무브오더
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3");
		Deaths(P9,AtMost,698,49)
	},
	actions = {
		Order(22,P8,"Anywhere",Move,"CenterCenter");
		PreserveTrigger()
	}
}

Trigger { -- 센터3 정야독
	players = {P7},
	conditions = {
		Deaths(P9,Exactly,700,49)
	},
	actions = {
		SetDeaths(P9,SetTo,0,48);
		GiveUnits(all,22,P8,"Anywhere",P6);
		GiveUnits(all,88,P11,"Anywhere",P6);
		SetInvincibility(Disable,22,P6,"Anywhere");
		SetInvincibility(Disable,88,P6,"Anywhere");
		CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")},{P6},P7);
	}
}
 -- 톱니바퀴 모양 --

C1 = CSMakeCircle(8,60,0,441,169)
S1 = CSMakePolygon(4,45,45,13,0)
S2 = CS_MoveXY(S1,700,0)
M1 = CS_Merge(S2,C1,1,0)
SS1 = CS_KaleidoscopeX(M1,20,0,0) --- 큰바퀴

C2 = CSMakeCircle(8,45,0,122,50)
S3 = CSMakeLineX(3,70,0,35,15)
SS2 = CS_Merge(S3,C2,1,0) --- 작은바퀴

MM = CS_Merge(SS1,SS2,1,0)
SS3 = CS_RemoveStack(MM,5,0) -------20개 톱니바퀴

function S1_Vector(X,Y) return {X+Y,X-Y} end

WheelA = CS_SortA(CS_Vector2D(SS3,1,"S1_Vector"),0)

CAPlot(WheelA,P8,88,"CenterCenter",nil,1,32,{1,0,0,0,1,0},nil,P7,{CommandLeastAt("Palm Center","Center 3"),Deaths(P9,AtLeast,0,49)}
	,{SetInvincibility(Enable,88,P8,"CenterCenter"),GiveUnits(all,88,P8,"CenterCenter",P11)})

Trigger {
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Center","Center 3");
		Deaths(P9,AtLeast,0,49)
	},
	actions = {
		SetInvincibility(Enable,88,P8,"Anywhere");
		GiveUnits(all,88,P8,"Anywhere",P11)
	}
}

LN1 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),0,0)
LN2 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),60,0)
LN3 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),120,0)
LN4 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),180,0)
LN5 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),240,0)
LN6 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),300,0)
LN7 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),360,0)
LN8 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),420,0)
LN9 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),480,0)
LN10 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),540,0)
LN11 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),600,0)
LN12 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),660,0)
LN13 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),720,0)
LN14 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),780,0)
LN15 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),840,0)
LN16 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),900,0)
LN17 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),960,0)

LA1 = CS_MoveXY(CSMakeLineX(2,80,0,2,0),0,0)
LA2 = CS_MoveXY(CSMakeLineX(2,80,0,4,0),60,0)
LA3 = CS_MoveXY(CSMakeLineX(2,80,0,6,0),120,0)
LA4 = CS_MoveXY(CSMakeLineX(2,80,0,8,0),180,0)
LA5 = CS_MoveXY(CSMakeLineX(2,80,0,10,0),240,0)
LA6 = CS_MoveXY(CSMakeLineX(2,80,0,12,0),300,0)
LA7 = CS_MoveXY(CSMakeLineX(2,80,0,14,0),360,0)
LA8 = CS_MoveXY(CSMakeLineX(2,80,0,16,0),420,0)
LA9 = CS_MoveXY(CSMakeLineX(2,80,0,18,0),480,0)
LA10 = CS_MoveXY(CSMakeLineX(2,80,0,16,0),540,0)
LA11 = CS_MoveXY(CSMakeLineX(2,80,0,14,0),600,0)
LA12 = CS_MoveXY(CSMakeLineX(2,80,0,12,0),660,0)
LA13 = CS_MoveXY(CSMakeLineX(2,80,0,10,0),720,0)
LA14 = CS_MoveXY(CSMakeLineX(2,80,0,8,0),780,0)
LA15 = CS_MoveXY(CSMakeLineX(2,80,0,6,0),840,0)
LA16 = CS_MoveXY(CSMakeLineX(2,80,0,4,0),900,0)
LA17 = CS_MoveXY(CSMakeLineX(2,80,0,2,0),960,0)

LB1 = CS_Subtract(LN1,LA1,16)
LB2 = CS_Subtract(LN2,LA2,16)
LB3 = CS_Subtract(LN3,LA3,16)
LB4 = CS_Subtract(LN4,LA4,16)
LB5 = CS_Subtract(LN5,LA5,16)
LB6 = CS_Subtract(LN6,LA6,16)
LB7 = CS_Subtract(LN7,LA7,16)
LB8 = CS_Subtract(LN8,LA8,16)
LB9 = CS_Subtract(LN9,LA9,16)
LB10 = CS_Subtract(LN10,LA10,16)
LB11 = CS_Subtract(LN11,LA11,16)
LB12 = CS_Subtract(LN12,LA12,16)
LB13 = CS_Subtract(LN13,LA13,16)
LB14 = CS_Subtract(LN14,LA14,16)
LB15 = CS_Subtract(LN15,LA15,16)
LB16 = CS_Subtract(LN16,LA16,16)
LB17 = CS_Subtract(LN17,LA17,16)
	
Trigger { -- 신전 데스값 (73)
	players = {P7},
	conditions = {
			CommandLeastAt(175, "XTemple")
			},
	actions = {
			SetDeaths(P9,Add,1,73);
			SetDeaths(P9,Add,1,75);
			PreserveTrigger()
		}
}

Trigger { -- 신전 effect on/off (74)
	players = {P7},
	conditions = {
			CommandLeastAt(175, "XTemple")
			},
	actions = {
			SetDeaths(P9,SetTo,1,74);
		}
}

CSPlot(LB1,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,2,75),Deaths(P9,Exactly,1,74)},nil,1) -- Side Eff
CSPlot(LB2,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,4,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB3,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,6,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB4,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,8,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB5,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,10,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB6,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,12,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB7,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,14,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB8,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,16,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB9,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,18,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB10,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,16,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB11,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,14,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB12,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,12,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB13,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,10,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB14,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,8,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB15,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,6,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB16,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,4,75),Deaths(P9,Exactly,1,74)},nil,1)
CSPlot(LB17,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,2,75),Deaths(P9,Exactly,1,74)},nil,1)

CSPlot(LA1,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,2,75),Deaths(P9,Exactly,1,74)},nil,0) -- Eff
CSPlot(LA2,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,4,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,6,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,8,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,10,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,12,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,14,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,16,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,18,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,20,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,22,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,24,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,26,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,28,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,30,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,32,75),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,34,75),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,2,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,4,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,6,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,8,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,10,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,12,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,14,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,16,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,18,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,20,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,22,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,24,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,26,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,28,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,30,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,32,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,80,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,34,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,2,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,4,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,6,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,8,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,10,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,12,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,14,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,16,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,18,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,20,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,22,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,24,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,26,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,28,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,30,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,32,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,34,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,402,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,404,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,406,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,408,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,410,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,412,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,414,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,416,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,418,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,420,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,422,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,424,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,426,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,428,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,430,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,432,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,434,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,402,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,404,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,406,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,408,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,410,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,412,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,414,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,416,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,418,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,420,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,422,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,424,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,426,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,428,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,430,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,432,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,89,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,434,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,402,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,404,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,406,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,408,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,410,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,412,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,414,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,416,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,418,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,420,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,422,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,424,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,426,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,428,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,430,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,432,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,434,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,802,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,804,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,806,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,808,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,810,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,812,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,814,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,816,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,818,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,820,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,822,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,824,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,826,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,828,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,830,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,832,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,834,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,802,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,804,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,806,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,808,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,810,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,812,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,814,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,816,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,818,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,820,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,822,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,824,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,826,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,828,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,830,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,832,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,60,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,834,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,802,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,804,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,806,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,808,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,810,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,812,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,814,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,816,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,818,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,820,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,822,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,824,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,826,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,828,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,830,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,832,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,834,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1202,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1204,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1206,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1208,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1210,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1212,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1214,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1216,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1218,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1220,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1222,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1224,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1226,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1228,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1230,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1232,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P8,84,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1234,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1202,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1204,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1206,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1208,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1210,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1212,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1214,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1216,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1218,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1220,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1222,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1224,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1226,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1228,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1230,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1232,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,64,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1234,73),Deaths(P9,Exactly,1,74)},nil,0)

CSPlot(LA1,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1202,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA2,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1204,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA3,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1206,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA4,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1208,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA5,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1210,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA6,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1212,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA7,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1214,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA8,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1216,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA9,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1218,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA10,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1220,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA11,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1222,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA12,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1224,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA13,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1226,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA14,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1228,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA15,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1230,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA16,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1232,73),Deaths(P9,Exactly,1,74)},nil,0)
CSPlot(LA17,P6,25,"Xelnaga Temple",nil,1,64,P7,{CommandLeastAt(175, "XTemple"),Deaths(P9,Exactly,1234,73),Deaths(P9,Exactly,1,74)},nil,0)

Trigger { -- 신전 eff 데스값 (75)
	players = {P7},
	conditions = {
			CommandLeastAt(175, "XTemple");
			Deaths(P9,AtLeast,35,75);
			Deaths(P9,Exactly,1,74)
			},
	actions = {
			SetDeaths(P9,SetTo,0,75);
			PreserveTrigger()
		}
}

Trigger { -- 신전 on/off 데스값 // ATK 오더
	players = {P7},
	conditions = {
			CommandLeastAt(175, "XTemple");
			Deaths(P9,AtLeast,1235,73);
			Deaths(P9,Exactly,1,74)
			},
	actions = {
			SetDeaths(P9,SetTo,0,74);
			SetDeaths(P9,SetTo,0,75);
			Order("Men",P6,"Temple ATK",Attack,"Heal Zone")
		}
}

---------------------------------------------------

-- 9시 감옥 -- (데스값 81~ )

Trigger { -- 9시 감옥 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(168,"Prison L")
		},
	actions = {
			SetDeaths(P9,Add,1,81);
			PreserveTrigger()
		}
}

Trigger { -- 9시 감옥 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,330,18);
			Deaths(P9,AtLeast,330,19);
			Deaths(P9,AtLeast,330,20);
			Deaths(P9,AtLeast,330,21);
			Deaths(P9,AtLeast,330,22);
			Deaths(P9,AtLeast,330,23);
			Deaths(P9,AtLeast,330,24);
			Deaths(P9,AtLeast,330,25);
		},
	actions = {
			DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『좌측 \x1FD\x04iversity 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			MinimapPing("Prison L");
			SetInvincibility(Disable,168,P7,"Prison L");
		}
}

function SHBF(Y) return Y end

GYL = CS_Vector2D(CS_FillPathGradY({3,{-250,430},{850,0},{-300,-650}},0,40,"SHBF",0,0,45,3),1,"SF_Vector")
GYL0 = CS_Vector2D(CS_RatioXY(CS_FillPathGradY({3,{-250,430},{850,0},{-300,-650}},0,40,"SHBF",0,0,45,3),0.5,0.5),1,"SF_Vector")
GYLH = CS_Vector2D(CS_FillPathGradY({3,{-250,430},{850,0},{-300,-650}},0,60,"SHBF",0,0,45,3),1,"SF_Vector")
GYLH0 = CS_Vector2D(CS_RatioXY(CS_FillPathGradY({3,{-250,430},{850,0},{-300,-650}},0,60,"SHBF",0,0,45,3),0.5,0.5),1,"SF_Vector")

CSPlotOrder(GYLH,P6,88,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,AtLeast,0,81)})
CSPlotOrder(GYLH,P6,75,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,AtLeast,0,81)})
CSPlotOrder(GYL,P7,56,"Prison L",nil,1,64,GYL0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,AtLeast,0,81)})
CSPlotOrder(GYLH,P6,51,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,AtLeast,0,81)})

CSPlotOrder(GYLH,P6,60,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,400,81)})
CSPlotOrder(GYLH,P6,79,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,400,81)})
CSPlotOrder(GYL,P7,56,"Prison L",nil,1,64,GYL0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,400,81)})
CSPlotOrder(GYLH,P6,51,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,400,81)})

CSPlotOrder(GYLH,P6,98,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,800,81)})
CSPlotOrder(GYLH,P6,76,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,800,81)})
CSPlotOrder(GYL,P7,56,"Prison L",nil,1,64,GYL0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,800,81)})
CSPlotOrder(GYLH,P6,51,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,800,81)})

CSPlotOrder(GYLH,P6,64,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,1200,81)})
CSPlotOrder(GYLH,P6,63,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,1200,81)})
CSPlotOrder(GYL,P7,56,"Prison L",nil,1,64,GYL0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,1200,81)})
CSPlotOrder(GYLH,P6,51,"Prison L",nil,1,64,GYLH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison L"),Deaths(P9,Exactly,1200,81)})

Trigger { -- 3시 감옥 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(168,"Prison R")
		},
	actions = {
			SetDeaths(P9,Add,1,82);
			PreserveTrigger()
		}
}



Trigger { -- 3시 감옥 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,330,26);
			Deaths(P9,AtLeast,330,27);
			Deaths(P9,AtLeast,330,28);
			Deaths(P9,AtLeast,330,29);
			Deaths(P9,AtLeast,330,30);
			Deaths(P9,AtLeast,330,31);
			Deaths(P9,AtLeast,330,32);
			Deaths(P9,AtLeast,330,33);
			Deaths(P9,AtLeast,330,34);
			Deaths(P9,AtLeast,330,35);
			Deaths(P9,AtLeast,330,36);
		},
	actions = {
			DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『우측 \x1FD\x04iversity 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			MinimapPing("Prison R");
			SetInvincibility(Disable,168,P7,"Prison R");
		}
}



GYR = CS_FillPathGradY({3,{-1140,60},{60,580},{80,-700}},0,60,"SHBF",0,0,45,3)
GYR0 = CS_RatioXY(GYR,0.5,0.5)
GYRH = CS_FillPathGradY({3,{-1140,60},{60,580},{80,-450}},0,90,"SHBF",0,0,45,3)
GYRH0 = CS_RatioXY(GYRH,0.5,0.5)

CSPlotOrder(GYRH,P6,21,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,AtLeast,0,82)})
CSPlotOrder(GYRH,P6,17,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,AtLeast,0,82)})
CSPlotOrder(GYR,P7,56,"Prison R",nil,1,64,GYR0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,AtLeast,0,82)})
CSPlotOrder(GYRH,P6,51,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,AtLeast,0,82)})

CSPlotOrder(GYRH,P6,89,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,400,82)})
CSPlotOrder(GYRH,P6,19,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,400,82)})
CSPlotOrder(GYR,P7,56,"Prison R",nil,1,64,GYR0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,400,82)})
CSPlotOrder(GYRH,P6,51,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,400,82)})

CSPlotOrder(GYRH,P6,58,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,800,82)})
CSPlotOrder(GYRH,P6,25,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,800,82)})
CSPlotOrder(GYR,P7,56,"Prison R",nil,1,64,GYR0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,800,82)})
CSPlotOrder(GYRH,P6,51,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,800,82)})

CSPlotOrder(GYRH,P6,90,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,1200,82)})
CSPlotOrder(GYRH,P6,52,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,1200,82)})
CSPlotOrder(GYR,P7,56,"Prison R",nil,1,64,GYR0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,1200,82)})
CSPlotOrder(GYRH,P6,51,"Prison R",nil,1,64,GYRH0,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(168,"Prison R"),Deaths(P9,Exactly,1200,82)})

function HyperCycloidA(T) return {4*math.cos(T) + math.cos(4*T), 4*math.sin(T) - math.sin(4*T)} end
HCA0 = CSMakeGraphT({32,32},"HyperCycloidA",0,0,12,12,70)
HCA = CS_RatioXY(CS_RemoveStack(HCA0,10,0),1.5,1.5) -- 원본

HCA1 = CS_Rotate3D(HCA,30,0,0)
HCA2 = CS_Rotate3D(HCA,30,30,0)
HCA3 = CS_Rotate3D(HCA,30,30,30)
HCA4 = CS_Rotate3D(HCA,30,30,60)
HCA5 = CS_Rotate3D(HCA,30,30,90)
HCA6 = CS_Rotate3D(HCA,30,60,90)
HCA7 = CS_Rotate3D(HCA,30,60,60)
HCA8 = CS_Rotate3D(HCA,30,60,30)
HCA9 = CS_Rotate3D(HCA,30,60,0)
HCA10 = CS_Rotate3D(HCA,60,120,0)
HCA11 = CS_Rotate3D(HCA,60,60,60)
HCA12 = CS_Rotate3D(HCA,60,30,30)
HCA13 = CS_Rotate3D(HCA,0,0,0)

Trigger { -- 중앙센터1 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center A")
	},
	actions = {
		SetDeaths(P9,Add,1,51);
		PreserveTrigger()
	}
}

CSPlot(HCA1,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,AtLeast,0,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA2,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,120,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA3,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,240,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA4,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,360,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA5,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,480,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA6,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,600,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA7,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,720,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA8,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,840,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA9,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,960,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA10,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,1080,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA11,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,1200,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA12,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,1320,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})
CSPlot(HCA13,P6,80,"Center A",nil,1,64,P7,{CommandLeastAt("Palm Senter","Center A"),Deaths(P9,Exactly,1440,51)},{Order(80,P6,"Center A",Attack,"Wave Zone 1")})

function HyperCycloidB(T) return {4*math.cos(T) + 2*math.cos(4*T), 4*math.sin(T) - 2*math.sin(4*T)} end
HCB0 = CSMakeGraphT({32,32},"HyperCycloidB",0,0,12,12,120)
HCB = CS_RatioXY(CS_RemoveStack(HCB0,12,0),1.5,1.5)

HCB1 = CS_Rotate3D(HCB,30,0,0)
HCB2 = CS_Rotate3D(HCB,30,30,0)
HCB3 = CS_Rotate3D(HCB,30,30,30)
HCB4 = CS_Rotate3D(HCB,30,30,60)
HCB5 = CS_Rotate3D(HCB,30,30,90)
HCB6 = CS_Rotate3D(HCB,30,60,90)
HCB7 = CS_Rotate3D(HCB,30,60,60)
HCB8 = CS_Rotate3D(HCB,30,60,30)
HCB9 = CS_Rotate3D(HCB,30,60,0)
HCB10 = CS_Rotate3D(HCB,60,120,0)
HCB11 = CS_Rotate3D(HCB,60,60,60)
HCB12 = CS_Rotate3D(HCB,60,30,30)
HCB13 = CS_Rotate3D(HCB,0,0,0)

Trigger { -- 중앙센터2 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center B")
	},
	actions = {
		SetDeaths(P9,Add,1,52);
		PreserveTrigger()
	}
}


CSPlotOrder(HCB1,P6,21,"Center B",nil,1,64,HCB1,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,AtLeast,0,52)})
CSPlotOrder(HCB2,P6,21,"Center B",nil,1,64,HCB2,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,120,52)})
CSPlotOrder(HCB3,P6,21,"Center B",nil,1,64,HCB3,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,240,52)})
CSPlotOrder(HCB4,P6,21,"Center B",nil,1,64,HCB4,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,360,52)})
CSPlotOrder(HCB5,P6,21,"Center B",nil,1,64,HCB5,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,480,52)})
CSPlotOrder(HCB6,P6,21,"Center B",nil,1,64,HCB6,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,600,52)})
CSPlotOrder(HCB7,P6,21,"Center B",nil,1,64,HCB7,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,720,52)})
CSPlotOrder(HCB8,P6,21,"Center B",nil,1,64,HCB8,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,840,52)})
CSPlotOrder(HCB9,P6,21,"Center B",nil,1,64,HCB9,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,960,52)})
CSPlotOrder(HCB10,P6,21,"Center B",nil,1,64,HCB10,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,1080,52)})
CSPlotOrder(HCB11,P6,21,"Center B",nil,1,64,HCB11,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,1200,52)})
CSPlotOrder(HCB12,P6,21,"Center B",nil,1,64,HCB12,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,1320,52)})
CSPlotOrder(HCB13,P6,21,"Center B",nil,1,64,HCB13,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center B"),Deaths(P9,Exactly,1440,52)})

CircleF = CSMakeCircle(6,60,0,61,0)
CircleG = CSMakeCircle(6,60,0,19,0)
CircleH = CS_MoveXY(CircleG,90,0)
CircleI = CS_Subtract(CircleF,CircleH,48)

HCC1 = CS_Rotate3D(CircleI,30,0,0)
HCC2 = CS_Rotate3D(CircleI,30,30,0)
HCC3 = CS_Rotate3D(CircleI,30,30,30)
HCC4 = CS_Rotate3D(CircleI,30,30,60)
HCC5 = CS_Rotate3D(CircleI,30,30,90)
HCC6 = CS_Rotate3D(CircleI,30,60,90)
HCC7 = CS_Rotate3D(CircleI,30,60,60)
HCC8 = CS_Rotate3D(CircleI,30,60,30)
HCC9 = CS_Rotate3D(CircleI,30,60,0)
HCC10 = CS_Rotate3D(CircleI,60,120,0)
HCC11 = CS_Rotate3D(CircleI,60,60,60)
HCC12 = CS_Rotate3D(CircleI,60,30,30)
HCC13 = CS_Rotate3D(CircleI,0,0,0)

Trigger { -- 중앙센터3 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center C")
	},
	actions = {
		SetDeaths(P9,Add,1,53);
		PreserveTrigger()
	}
}

CSPlotOrder(HCC1,P6,98,"Center C",nil,1,64,HCC1,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,AtLeast,0,53)})
CSPlotOrder(HCC2,P6,98,"Center C",nil,1,64,HCC2,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,120,53)})
CSPlotOrder(HCC3,P6,98,"Center C",nil,1,64,HCC3,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,240,53)})
CSPlotOrder(HCC4,P6,98,"Center C",nil,1,64,HCC4,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,360,53)})
CSPlotOrder(HCC5,P6,98,"Center C",nil,1,64,HCC5,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,480,53)})
CSPlotOrder(HCC6,P6,98,"Center C",nil,1,64,HCC6,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,600,53)})
CSPlotOrder(HCC7,P6,98,"Center C",nil,1,64,HCC7,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,720,53)})
CSPlotOrder(HCC8,P6,98,"Center C",nil,1,64,HCC8,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,840,53)})
CSPlotOrder(HCC9,P6,98,"Center C",nil,1,64,HCC9,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,960,53)})
CSPlotOrder(HCC10,P6,98,"Center C",nil,1,64,HCC10,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,1080,53)})
CSPlotOrder(HCC11,P6,98,"Center C",nil,1,64,HCC11,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,1200,53)})
CSPlotOrder(HCC12,P6,98,"Center C",nil,1,64,HCC12,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,1320,53)})
CSPlotOrder(HCC13,P6,98,"Center C",nil,1,64,HCC13,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center C"),Deaths(P9,Exactly,1440,53)})

Trigger { -- 중앙센터4 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center D")
	},
	actions = {
		SetDeaths(P9,Add,1,54);
		PreserveTrigger()
	}
}

HCD0 = CSMakeStar(5,108,50,180,62,12)
HCD = CS_RatioXY(CS_Vector2D(HCD0,1,"S1_Vector"),1.5,1.5)

HCD1 = CS_Rotate3D(HCD,30,0,0)
HCD2 = CS_Rotate3D(HCD,30,30,0)
HCD3 = CS_Rotate3D(HCD,30,30,30)
HCD4 = CS_Rotate3D(HCD,30,30,60)
HCD5 = CS_Rotate3D(HCD,30,30,90)
HCD6 = CS_Rotate3D(HCD,30,60,90)
HCD7 = CS_Rotate3D(HCD,30,60,60)
HCD8 = CS_Rotate3D(HCD,30,60,30)
HCD9 = CS_Rotate3D(HCD,30,60,0)
HCD10 = CS_Rotate3D(HCD,60,120,0)
HCD11 = CS_Rotate3D(HCD,60,60,60)
HCD12 = CS_Rotate3D(HCD,60,30,30)
HCD13 = CS_Rotate3D(HCD,0,0,0)

CSPlotOrder(HCD1,P6,60,"Center D",nil,1,64,HCD1,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,AtLeast,0,54)})
CSPlotOrder(HCD2,P6,60,"Center D",nil,1,64,HCD2,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,120,54)})
CSPlotOrder(HCD3,P6,60,"Center D",nil,1,64,HCD3,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,240,54)})
CSPlotOrder(HCD4,P6,60,"Center D",nil,1,64,HCD4,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,360,54)})
CSPlotOrder(HCD5,P6,60,"Center D",nil,1,64,HCD5,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,480,54)})
CSPlotOrder(HCD6,P6,60,"Center D",nil,1,64,HCD6,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,600,54)})
CSPlotOrder(HCD7,P6,60,"Center D",nil,1,64,HCD7,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,720,54)})
CSPlotOrder(HCD8,P6,60,"Center D",nil,1,64,HCD8,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,840,54)})
CSPlotOrder(HCD9,P6,60,"Center D",nil,1,64,HCD9,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,960,54)})
CSPlotOrder(HCD10,P6,60,"Center D",nil,1,64,HCD10,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,1080,54)})
CSPlotOrder(HCD11,P6,60,"Center D",nil,1,64,HCD11,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,1200,54)})
CSPlotOrder(HCD12,P6,60,"Center D",nil,1,64,HCD12,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,1320,54)})
CSPlotOrder(HCD13,P6,60,"Center D",nil,1,64,HCD13,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center D"),Deaths(P9,Exactly,1440,54)})

Trigger { -- 중앙센터5 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center E")
	},
	actions = {
		SetDeaths(P9,Add,1,55);
		PreserveTrigger()
	}
}

function HyperCycloidE(T) return {6*math.cos(T) - 2*math.cos(6*T), 6*math.sin(T) - 2*math.sin(6*T)} end
HCE0 = CSMakeGraphT({24,24},"HyperCycloidE",0,0,1,1,90)
HCE = CS_RatioXY(CS_RemoveStack(HCE0,20,0),1.5,1.5)

HCE1 = CS_Rotate3D(HCE,30,0,0)
HCE2 = CS_Rotate3D(HCE,30,30,0)
HCE3 = CS_Rotate3D(HCE,30,30,30)
HCE4 = CS_Rotate3D(HCE,30,30,60)
HCE5 = CS_Rotate3D(HCE,30,30,90)
HCE6 = CS_Rotate3D(HCE,30,60,90)
HCE7 = CS_Rotate3D(HCE,30,60,60)
HCE8 = CS_Rotate3D(HCE,30,60,30)
HCE9 = CS_Rotate3D(HCE,30,60,0)
HCE10 = CS_Rotate3D(HCE,60,120,0)
HCE11 = CS_Rotate3D(HCE,60,60,60)
HCE12 = CS_Rotate3D(HCE,60,30,30)
HCE13 = CS_Rotate3D(HCE,0,0,0)

CSPlotOrder(HCE1,P6,86,"Center E",nil,1,64,HCE1,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,AtLeast,0,55)})
CSPlotOrder(HCE2,P6,86,"Center E",nil,1,64,HCE2,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,120,55)})
CSPlotOrder(HCE3,P6,86,"Center E",nil,1,64,HCE3,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,240,55)})
CSPlotOrder(HCE4,P6,86,"Center E",nil,1,64,HCE4,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,360,55)})
CSPlotOrder(HCE5,P6,86,"Center E",nil,1,64,HCE5,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,480,55)})
CSPlotOrder(HCE6,P6,86,"Center E",nil,1,64,HCE6,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,600,55)})
CSPlotOrder(HCE7,P6,86,"Center E",nil,1,64,HCE7,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,720,55)})
CSPlotOrder(HCE8,P6,86,"Center E",nil,1,64,HCE8,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,840,55)})
CSPlotOrder(HCE9,P6,86,"Center E",nil,1,64,HCE9,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,960,55)})
CSPlotOrder(HCE10,P6,86,"Center E",nil,1,64,HCE10,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,1080,55)})
CSPlotOrder(HCE11,P6,86,"Center E",nil,1,64,HCE11,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,1200,55)})
CSPlotOrder(HCE12,P6,86,"Center E",nil,1,64,HCE12,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,1320,55)})
CSPlotOrder(HCE13,P6,86,"Center E",nil,1,64,HCE13,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center E"),Deaths(P9,Exactly,1440,55)})

Trigger { -- 중앙센터6 데스값
	players = {P7},
	conditions = {
		CommandLeastAt("Palm Senter","Center F")
	},
	actions = {
		SetDeaths(P9,Add,1,56);
		PreserveTrigger()
	}
}

function HyperCycloidF(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
HCFF = CSMakeGraphT({12,12},"HyperCycloidF",0,0,2,2,51) 
HCF0 = CS_Rotate(HCFF,180)
HCF = CS_RatioXY(CS_RemoveStack(HCF0,15,0),1.5,1.5)

HCF1 = CS_Rotate3D(HCF,30,0,0)
HCF2 = CS_Rotate3D(HCF,30,30,0)
HCF3 = CS_Rotate3D(HCF,30,30,30)
HCF4 = CS_Rotate3D(HCF,30,30,60)
HCF5 = CS_Rotate3D(HCF,30,30,90)
HCF6 = CS_Rotate3D(HCF,30,60,90)
HCF7 = CS_Rotate3D(HCF,30,60,60)
HCF8 = CS_Rotate3D(HCF,30,60,30)
HCF9 = CS_Rotate3D(HCF,30,60,0)
HCF10 = CS_Rotate3D(HCF,60,120,0)
HCF11 = CS_Rotate3D(HCF,60,60,60)
HCF12 = CS_Rotate3D(HCF,60,30,30)
HCF13 = CS_Rotate3D(HCF,0,0,0)

CSPlotOrder(HCF1,P6,89,"Center F",nil,1,64,HCF1,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,AtLeast,0,56)})
CSPlotOrder(HCF2,P6,89,"Center F",nil,1,64,HCF2,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,120,56)})
CSPlotOrder(HCF3,P6,89,"Center F",nil,1,64,HCF3,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,240,56)})
CSPlotOrder(HCF4,P6,89,"Center F",nil,1,64,HCF4,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,360,56)})
CSPlotOrder(HCF5,P6,89,"Center F",nil,1,64,HCF5,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,480,56)})
CSPlotOrder(HCF6,P6,89,"Center F",nil,1,64,HCF6,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,600,56)})
CSPlotOrder(HCF7,P6,89,"Center F",nil,1,64,HCF7,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,720,56)})
CSPlotOrder(HCF8,P6,89,"Center F",nil,1,64,HCF8,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,840,56)})
CSPlotOrder(HCF9,P6,89,"Center F",nil,1,64,HCF9,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,960,56)})
CSPlotOrder(HCF10,P6,89,"Center F",nil,1,64,HCF10,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,1080,56)})
CSPlotOrder(HCF11,P6,89,"Center F",nil,1,64,HCF11,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,1200,56)})
CSPlotOrder(HCF12,P6,89,"Center F",nil,1,64,HCF12,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,1320,56)})
CSPlotOrder(HCF13,P6,89,"Center F",nil,1,64,HCF13,0,Attack,"Wave Zone 1",nil,64,nil,P7,{CommandLeastAt("Palm Senter","Center F"),Deaths(P9,Exactly,1440,56)})

 -- 6시 순대 --
	
Trigger { -- 6시 순대 데스값(83~
	players = {P7},
	conditions = {
			CommandLeastAt(148,"Daggoth 6")
		},
	actions = {
			SetDeaths(P9,Add,1,83);
			PreserveTrigger()
		}
}

for i = 1, 24 do
GLi = CSMakeLineX(1,60,0+15*i,7,1) -- 원그리기 1
CSPlot(GLi,P6,88,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,4*i,83)})

CSPlot(GLi,P6,60,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,800+4*i,83)})

end

CSPlot(CX2,P6,76,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,96,83)}) --외접원
CSPlot(CX2,P6,63,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,896,83)}) --외접원

Trigger { -- 6시 순대 오더 1
	players = {P7},
	conditions = {
			CommandLeastAt(148,"Daggoth 6");
			Deaths(P9,Exactly,100,83);
		},
	actions = {
			Order(88,P6,"Daggoth 6",Attack,"Heal Zone");
			Order(76,P6,"Daggoth 6",Attack,"Heal Zone");
		}
}

Trigger { -- 6시 순대 오더 3
	players = {P7},
	conditions = {
			CommandLeastAt(148,"Daggoth 6");
			Deaths(P9,Exactly,900,83);
		},
	actions = {
			Order(60,P6,"Daggoth 6",Attack,"Heal Zone");
			Order(63,P6,"Daggoth 6",Attack,"Heal Zone");
		}
}

for j = 1, 24 do
GLj = CSMakeLineX(1,60,360-15*j,11,1) -- 원그리기 2
CSPlot(GLj,P6,89,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,400+4*j,83)})

CSPlot(GLj,P6,64,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,1200+4*j,83)})
end

CSPlot(CX2,P6,65,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,496,83)})
CSPlot(CX2,P6,5,"Daggoth 6",nil,1,32,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,1296,83)})

Trigger { -- 6시 순대 오더 2
	players = {P7},
	conditions = {
			CommandLeastAt(148,"Daggoth 6");
			Deaths(P9,Exactly,500,83);
		},
	actions = {
			Order(89,P6,"Daggoth 6",Attack,"Heal Zone");
			Order(65,P6,"Daggoth 6",Attack,"Heal Zone");
		}
}

Trigger { -- 6시 순대 오더 4
	players = {P7},
	conditions = {
			CommandLeastAt(148,"Daggoth 6");
			Deaths(P9,Exactly,1300,83);
		},
	actions = {
			Order(64,P6,"Daggoth 6",Attack,"Heal Zone");
			Order(5,P6,"Daggoth 6",Attack,"Heal Zone");
		}
}

GA1 = CS_MoveXY(CS_InvertXY(CS_FillGradA(0,{0,512},270,18,"SHBF",0),270),-500,0) --A그라데이션
GA1D = CS_RatioXY(CS_MoveXY(CS_InvertXY(CS_FillGradA(0,{0,512},270,18,"SHBF",0),270),-500,0),0.1,0.1) --도착지 도형
CSPlotOrder(GA1,P8,25,"Daggoth 6",nil,1,64,GA1D,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,1500,83)})
CSPlotOrder(GA1,P8,96,"Daggoth 6",nil,1,64,GA1D,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(148,"Daggoth 6"),Deaths(P9,Exactly,1500,83)})

Trigger { -- 11시 넥서스 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(154,"Sky 1");
		},
	actions = {
			SetDeaths(P9,Add,1,84);
			PreserveTrigger()
		}
}

NGR1 = CS_Rotate(CS_FillGradR(0,{0,768},135,50,"SHBF",0),170)
NGR1D = CS_RatioXY(CS_Rotate(CS_FillGradR(0,{0,768},135,50,"SHBF",0),170),0.01,0.01)
NGR2 = CS_Rotate(CS_FillGradR(0,{0,768},135,70,"SHBF",0),170)

CSPlotOrder(NGR1,P6,80,"Sky 1",nil,1,64,NGR1D,0,Attack,"NX1",nil,64,nil,P7,{CommandLeastAt(154,"Sky 1"),Deaths(P9,AtLeast,0,84)})
CSPlotOrder(NGR1,P6,80,"Sky 1",nil,1,64,NGR1D,0,Attack,"NX1",nil,64,nil,P7,{CommandLeastAt(154,"Sky 1"),Deaths(P9,Exactly,330,84)})
CSPlotOrder(NGR1,P6,80,"Sky 1",nil,1,64,NGR1D,0,Attack,"NX1",nil,64,nil,P7,{CommandLeastAt(154,"Sky 1"),Deaths(P9,Exactly,660,84)})
CSPlotOrder(NGR2,P8,30,"Sky 1",nil,1,64,NGR2,0,Attack,"Heal Zone",nil,64,nil,P7,{CommandLeastAt(154,"Sky 1"),Deaths(P9,Exactly,990,84)})


Trigger { -- 11시 넥서스 정야독 데스값
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,850,84)
		},
	actions = {
			SetDeaths(P9,SetTo,1,85);
		}
}

Trigger { -- 11시 넥서스 정야독 캔슬
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,900,84)
		},
	actions = {
			SetDeaths(P9,SetTo,0,85);
		}
}

Trigger { -- 11시 넥서스 정야독
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,1,85)
		},
	actions = {
			CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"NXJ1")},{P6},P7);
			PreserveTrigger()
		}
}

Trigger { -- 11시 넥서스 공중 어택
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,901,84)
		},
	actions = {
			Order(80,P6,"NXJ1",Attack,"Heal Zone");
		}
}

Trigger { -- 1시 넥서스 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(154,"Sky 2");
		},
	actions = {
			SetDeaths(P9,Add,1,86);
			PreserveTrigger()
		}
}

DSQ1 = CS_Distortion(CSMakePolygon(4,60,0,113,1),{2,1},nil,nil,{2,1},nil) --평행사변형
DSQ2 = CS_Distortion(CSMakePolygon(4,60,0,113,1),nil,{2,1},{2,1},nil,nil) --평행사변형
DSQ3 = CS_Distortion(CSMakePolygon(4,60,0,113,1),{2,1},{2,1},nil,nil,nil) --마름모
DSQD = CS_RatioXY(CS_Distortion(CSMakePolygon(4,60,0,113,1),{2,1},{2,1},nil,nil,nil),0.001,0.001) -- 도착모양

CSPlotOrder(DSQ1,P6,21,"NX2",nil,1,64,DSQD,0,Attack,"NXJ2",nil,64,nil,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,AtLeast,0,86)})
CSPlotOrder(DSQ2,P6,21,"NX2",nil,1,64,DSQD,0,Attack,"NXJ2",nil,64,nil,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,330,86)})
CSPlotOrder(DSQ3,P6,21,"NX2",nil,1,64,DSQD,0,Attack,"NXJ2",nil,64,nil,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,660,86)})

for i = 1, 15 do

SQi = CSMakePolygon(4,30*i,10*i,5,1)

CSPlot(SQi,P7,33,"NX2",nil,1,32,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,990+2*i,86)},{KillUnit(33,P7)})
CSPlot(SQi,P8,30,"NX2",nil,1,32,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,990+2*i,86)})


end

for j = 1, 15 do

SQj = CSMakePolygon(4,30*(16-j),10*(16-j),5,1)

CSPlot(SQj,P7,33,"NX2",nil,1,32,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,1020+2*j,86)},{KillUnit(33,P7)})
CSPlot(SQj,P8,89,"NX2",nil,1,32,P7,{CommandLeastAt(154,"Sky 2"),Deaths(P9,Exactly,1020+2*j,86)},{KillUnit(33,P7)})


end

Trigger { -- 1시 넥서스 정야독 데스값
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,850,86)
		},
	actions = {
			SetDeaths(P9,SetTo,1,87);
		}
}

Trigger { -- 1시 넥서스 정야독 캔슬
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,900,86)
		},
	actions = {
			SetDeaths(P9,SetTo,0,87);
		}
}

Trigger { -- 1시 넥서스 정야독
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,1,87)
		},
	actions = {
			CopyCpAction({RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"NXJ2")},{P6},P7);
			PreserveTrigger()
		}
}

Trigger { -- 1시 넥서스 공중 어택
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,901,86)
		},
	actions = {
			Order(21,P6,"NXJ2",Attack,"Heal Zone");
		}
}

-- 6시 넥서스 건작 --

Trigger { -- 6시 왼쪽 넥서스 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(154,"Sky 3");
		},
	actions = {
			SetDeaths(P9,Add,1,89);
			PreserveTrigger()
		}
}
Trigger { -- 6시 오른쪽 넥서스 데스값
	players = {P7},
	conditions = {
			CommandLeastAt(154,"Sky 4");
		},
	actions = {
			SetDeaths(P9,Add,1,88);
			PreserveTrigger()
		}
}
for i = 0, 7 do

	LNAi = CSMakeLineX(3,60,0+10*i,33,18)
	
	CSPlotOrder(LNAi,P6,88,"Sky 3",nil,1,64,LNAi,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,AtLeast,0,89)})
	CSPlotOrder(LNAi,P6,98,"Sky 3",nil,1,64,LNAi,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,660,89)})
	
	CSPlotOrder(LNAi,P6,86,"Sky 4",nil,1,64,LNAi,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,AtLeast,0,88)})
	CSPlotOrder(LNAi,P6,90,"Sky 4",nil,1,64,LNAi,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,660,88)})
	
	end
	
	for j = 0, 7 do
	
	LNBj = CSMakeLineX(3,60,60+10*j,33,18)
	
	CSPlotOrder(LNBj,P6,60,"Sky 3",nil,1,64,LNBj,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,330,89)})
	CSPlotOrder(LNBj,P6,96,"Sky 4",nil,1,64,LNBj,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,330,88)})
	
	end
	
	NAC = CSMakeCircleX(6,50,0,24,0)
	NAS = CSMakeStar(5,108,100,180,62,32)
	NASQ = CSMakePolygon(4,400,45,5,0)
	
	CSPlotOrder(NAC,P8,80,"Sky 3",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,AtLeast,0,89)})
	CSPlotOrder(NAC,P8,80,"Sky 3",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,330,89)})
	CSPlotOrder(NAC,P8,80,"Sky 3",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,660,89)})
	CSPlotOrder(NAS,P8,64,"Sky 3",nil,1,64,NAS,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,990,89)})
	CSPlotOrder(NASQ,P8,27,"Sky 3",nil,1,64,NASQ,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 3"),Deaths(P9,Exactly,990,89)})
	
	CSPlotOrder(NAC,P8,21,"Sky 4",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,AtLeast,0,88)})
	CSPlotOrder(NAC,P8,21,"Sky 4",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,330,88)})
	CSPlotOrder(NAC,P8,89,"Sky 4",nil,1,64,NAC,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,660,88)})
	CSPlotOrder(NAS,P8,102,"Sky 4",nil,1,64,NAS,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,990,88)})
	CSPlotOrder(NASQ,P8,27,"Sky 4",nil,1,64,NASQ,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(154,"Sky 4"),Deaths(P9,Exactly,990,88)})
	
	-- 5시 옵마 (90~) --
	
	Trigger { -- 5시 옵마 데스값
		players = {P7},
		conditions = {
				CommandLeastAt(148,"Daggoth 5");
			},
		actions = {
				SetDeaths(P9,Add,1,90);
				PreserveTrigger()
			}
	}
	
	DGR1 = CS_Rotate(CS_FillGradR(0,{0,756},110,80,"SHBF",0),170)
	DGR1D = CS_RatioXY(DGR1,0.1,0.1)
	
	CSPlotOrder(DGR1,P6,52,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,AtLeast,0,90)})
	CSPlotOrder(DGR1,P6,58,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,AtLeast,0,90)})
	CSPlotOrder(DGR1,P6,65,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,AtLeast,0,90)})
	
	CSPlotOrder(DGR1,P6,5,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,400,90)})
	CSPlotOrder(DGR1,P6,88,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,400,90)})
	CSPlotOrder(DGR1,P6,66,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,400,90)})
	
	CSPlotOrder(DGR1,P6,32,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,800,90)})
	CSPlotOrder(DGR1,P6,90,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,800,90)})
	CSPlotOrder(DGR1,P6,87,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,800,90)})
	
	CSPlotOrder(DGR1,P6,102,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,1200,90)})
	CSPlotOrder(DGR1,P6,61,"DG5",nil,1,64,DGR1D,0,Attack,"Heal Zone",nil,0,nil,P7,{CommandLeastAt(148,"Daggoth 5"),Deaths(P9,Exactly,1200,90)})


CIfEnd() -- P7 건작트리거단락 종료


 --- 5시 신전 건작 --- (데스값 : 73~ ) (67~72 -> 제네1~6 이펙트 데스값으로 교체) --------새로 추가한거

Trigger { -- 5시 신전 무적 해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,330,57);
			Deaths(P9,AtLeast,330,58);
			Deaths(P9,AtLeast,330,59);
			Deaths(P9,AtLeast,330,60);
			Deaths(P9,AtLeast,330,61);
			Deaths(P9,AtLeast,330,62);
		},
	actions = {
			DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『5시 탬플 \x1FC\x04itadel 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			MinimapPing("XTemple");
			SetInvincibility(Disable,175,P7,"Anywhere")
		}
}

Trigger { -- 11시 넥서스 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,330,3);
			Deaths(P9,AtLeast,330,4);
			Deaths(P9,AtLeast,330,5);
			Deaths(P9,AtLeast,330,6);
		},
	actions = {
		DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『11시 넥서스 \x1FS\x04kyscraper 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
		MinimapPing("Sky 1");
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		SetInvincibility(Disable,154,P7,"Sky 1");
		}
}

Trigger { -- 1시 넥서스 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,330,10);
			Deaths(P9,AtLeast,330,11);
			Deaths(P9,AtLeast,330,12);
			Deaths(P9,AtLeast,330,13);
		},
	actions = {
		DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『1시 넥서스 \x1FS\x04kyscraper 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
		MinimapPing("Sky 2");
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		SetInvincibility(Disable,154,P7,"Sky 2");
		}
}

Trigger { -- 6시 왼쪽 넥서스 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,990,84);
		},
	actions = {
		DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『6시 왼쪽 넥서스 \x1FS\x04kyscraper 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
		MinimapPing("Sky 3");
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		SetInvincibility(Disable,154,P7,"Sky 3");
		}
}

Trigger { -- 6시 오른쪽 넥서스 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,1020,86);
		},
	actions = {
		DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『6시 오른쪽 넥서스 \x1FS\x04kyscraper 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
		MinimapPing("Sky 4");
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		SetInvincibility(Disable,154,P7,"Sky 4");
		}
}
 -- 건작보스 --

Trigger { -- 건작보스 무적해제
	players = {Force1},
	conditions = {
		Deaths(Force1,Exactly,0,"Zerg Flag Beacon");
		Deaths(Force1,Exactly,0,"Unused Zerg Bldg");
		Deaths(Force1,Exactly,0,"Unused Terran Bldg type   2");
		Bring(P6,Exactly,0,132,"Anywhere");
		Bring(P6,Exactly,0,133,"Anywhere");
		Bring(P6,Exactly,0,200,"Anywhere");
		Bring(P7,Exactly,0,106,"Anywhere");
		Bring(P7,Exactly,0,130,"Anywhere");
		Bring(P7,Exactly,0,168,"Anywhere");
		Bring(P7,Exactly,0,175,"Anywhere");
		Bring(P7,Exactly,0,152,"Anywhere");
		Bring(P7,Exactly,0,127,"Anywhere");
		Bring(P7,Exactly,0,148,"Anywhere");
		Bring(P7,Exactly,0,201,"Anywhere");
		Bring(P7,Exactly,0,154,"Anywhere");
	},
	actions = {
		SetDeaths(P9,Add,1,91);
		PreserveTrigger();
	}
}

Trigger {
	players = {Force1},
	conditions = {
		Deaths(P9,AtLeast,990,91);
	},
	actions = {
		DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x1F···-▷\x04 『중앙 건작보스 \x1FC\x04limax 의 \x07무적\x04이 \x0E해제\x04되었습니다.』\x1F◁-···\x04\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
		MinimapPing("HeadQuater");
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
		SetInvincibility(Disable,190,P7,"HeadQuater");
		SetSwitch("Switch 2",Clear);
	}
}


Trigger { -- 건작보스 브금
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, Exactly, 1, "Unused type   1");
		Deaths(CurrentPlayer, Exactly, 0, "Unused type   2");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 9724, "Unused type   2");
		PlayWAV("staredit\\wav\\Ricochet");
		PlayWAV("staredit\\wav\\Ricochet");
		PlayWAV("staredit\\wav\\Ricochet");
		PreserveTrigger();
	},
}

CIf({P6,P7,P8},{NVar(GunLock,Exactly,0)}) -- P8 건작트리거단락 시작

Trigger { -- 화이트홀 
	players = {P7},
	conditions = {
		CommandLeastAt(190,"HeadQuater")
	},
	actions = {
		CreateUnit(1,218,"HeadQuater",P8)
	}
}

Trigger { -- 화이트홀 삭제
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,9724,101)
	},
	actions = {
		RemoveUnit(218,P8)
	}
}

Trigger { -- No comment (165CF9E9)
	players = {P7},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(Force1, Subtract, 1, "Unused type   2");
		PreserveTrigger();
	},
}

Trigger { -- No comment (AF9ADCB1)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, AtLeast, 1, "Unused type   1");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 0, "Unused type   1");
		PreserveTrigger();
	},
}

Trigger { -- 건작보스 데스값
	players = {P7},
	conditions = {
		CommandLeastAt(190,"HeadQuater")
	},
	actions = {
		SetDeaths(P9,Add,1,101);
		PreserveTrigger()
	}
}

Trigger {
	players = {P7},
	conditions = {
		CommandLeastAt(190,"HeadQuater");
		Deaths(P9,AtLeast,408,101)
	},
	actions = {
		SetDeaths(P9,Add,1,100); -- 0.5초 배틀 젠
		SetDeaths(P9,Add,1,107); -- p6 정야독
		SetDeaths(P9,Add,1,108); -- p7 정야독
		PreserveTrigger()
	}
}

Trigger { -- P6 정야독
	players = {P6},
	conditions = {
		Deaths(P9,AtLeast,70,107);
		Deaths(P9,AtMost,8500,101)
	},
	actions = {
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere");
		SetDeaths(P9,SetTo,0,107);
		PreserveTrigger()
	}
}

Trigger { -- P7 정야독
	players = {P7},
	conditions = {
		Deaths(P9,AtLeast,70,108);
		Deaths(P9,AtMost,8500,101)
	},
	actions = {
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere");
		SetDeaths(P9,SetTo,0,108);
		PreserveTrigger()
	}
}


-- p8정야독 데스값 (108)

Trigger { -- 0.5초 배틀 젠 1
	players = {P8},
	conditions = {
		CommandLeastAt(190,"HeadQuater");
		Deaths(P9,AtLeast,17,100);
		Deaths(P9,AtLeast,442,101);
		Deaths(P9,AtMost,2312,101)
	},
	actions = {
		CreateUnit(1,84,"Generator 1",P8);
		CreateUnit(1,84,"Generator 2",P8);
		CreateUnit(1,84,"Generator 3",P8);
		CreateUnit(1,84,"Generator 4",P8);
		CreateUnit(1,84,"Generator 5",P8);
		CreateUnit(1,84,"Generator 6",P8);
		CreateUnit(1,22,"Generator 1",P8);
		CreateUnit(1,22,"Generator 2",P8);
		CreateUnit(1,22,"Generator 3",P8);
		CreateUnit(1,22,"Generator 4",P8);
		CreateUnit(1,22,"Generator 5",P8);
		CreateUnit(1,22,"Generator 6",P8);	
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 1");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 2");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 3");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 4");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 5");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 6");
		SetDeaths(P9,SetTo,0,100);
		PreserveTrigger()
	}
}

Trigger { -- 0.5초 배틀 젠 2
	players = {P8},
	conditions = {
		CommandLeastAt(190,"HeadQuater");
		Deaths(P9,AtLeast,17,100);
		Deaths(P9,AtLeast,3808,101);
		Deaths(P9,AtMost,8500,101)
	},
	actions = {
		CreateUnit(1,84,"Generator 1",P8);
		CreateUnit(1,84,"Generator 2",P8);
		CreateUnit(1,84,"Generator 3",P8);
		CreateUnit(1,84,"Generator 4",P8);
		CreateUnit(1,84,"Generator 5",P8);
		CreateUnit(1,84,"Generator 6",P8);
		CreateUnit(1,22,"Generator 1",P8);
		CreateUnit(1,22,"Generator 2",P8);
		CreateUnit(1,22,"Generator 3",P8);
		CreateUnit(1,22,"Generator 4",P8);
		CreateUnit(1,22,"Generator 5",P8);
		CreateUnit(1,22,"Generator 6",P8);
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 1");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 2");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 3");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 4");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 5");
		RunAIScriptAt('Set Unit Order To: Junk Yard Dog', "Generator 6");
		SetDeaths(P9,SetTo,0,100);
		PreserveTrigger()
	}
}

-- 직선 채우기 --

L36 = CSMakeLineX(6,100,0,60,24)
-- 소용돌이 모양 --

function HyperCycloid1(T) return {2.1*math.cos(T) - math.cos(2.1*T), 2.1*math.sin(T) - math.sin(2.1*T)} end
Hp0 = CSMakeGraphT({192,192},"HyperCycloid1",0,0,10,10,200)
Hp1 = CS_RemoveStack(Hp0,10)

CSPlot(Hp1,P7,62,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,748,101)})
CSPlot(Hp1,P6,104,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,748,101)})

CSPlot(Hp1,P7,80,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1380,101)})
CSPlot(Hp1,P6,77,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1380,101)})

CSPlot(Hp1,P7,21,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1850,101)})
CSPlot(Hp1,P6,93,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1850,101)})

CSPlot(Hp1,P7,89,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,2400,101)})
CSPlot(Hp1,P6,78,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,2400,101)})

CSPlot(Hp1,P7,22,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3000,101)})
CSPlot(Hp1,P6,95,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3000,101)})

CSPlot(Hp1,P7,88,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3808,101)})
CSPlot(Hp1,P6,81,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3808,101)})

CSPlot(L36,P8,84,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4046,101)})
CSPlot(L36,P7,58,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4046,101)})
CSPlot(L36,P6,25,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4046,101)})

CSPlot(L36,P8,84,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4538,101)})
CSPlot(L36,P7,58,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4538,101)})
CSPlot(L36,P6,25,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,4538,101)})

CSPlot(Hp1,P7,90,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,4600,101)})
CSPlot(Hp1,P6,79,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,4600,101)})

CSPlot(L36,P8,84,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5016,101)})
CSPlot(L36,P7,58,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5016,101)})
CSPlot(L36,P6,25,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5016,101)})

CSPlot(L36,P8,84,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5474,101)})
CSPlot(L36,P7,58,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5474,101)})
CSPlot(L36,P6,25,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,5474,101)})

CSPlot(Hp1,P7,86,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,5500,101)})
CSPlot(Hp1,P6,76,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,5500,101)})

CSPlot(Hp1,P7,3,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6200,101)})
CSPlot(Hp1,P6,98,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6200,101)})

CSPlot(Hp1,P7,64,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6800,101)})
CSPlot(Hp1,P6,5,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6800,101)})

CSPlot(L36,P8,84,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,7162,101)})
CSPlot(L36,P7,58,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,7162,101)})
CSPlot(L36,P6,25,"CenterCenter",nil,1,64,P6,{Deaths(P9,Exactly,7162,101)})

CSPlot(Hp1,P7,96,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,7800,101)})
CSPlot(Hp1,P6,52,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,7800,101)})

 -- 101 (4233) --


-- 꽃모양 11p유닛 --

CircleA = CSMakeCircle(6,60,0,91,61)
EllipseB = CS_Distortion(CircleA,{5,0},{5,0},nil,nil)
EllipseN = CS_RemoveStack(CS_MoveXY(EllipseB,1600,0),20)
Ellipse1 = CS_Rotate(EllipseN,30)
Ellipse2 = CS_Rotate(EllipseN,60)
Ellipse3 = CS_Rotate(EllipseN,90)
Ellipse4 = CS_Rotate(EllipseN,120)
Ellipse5 = CS_Rotate(EllipseN,150)
Ellipse6 = CS_Rotate(EllipseN,180)
Ellipse7 = CS_Rotate(EllipseN,210)
Ellipse8 = CS_Rotate(EllipseN,240)
Ellipse9 = CS_Rotate(EllipseN,270)
Ellipse10 = CS_Rotate(EllipseN,300)
Ellipse11 = CS_Rotate(EllipseN,330)
Ellipse12 = CS_Rotate(EllipseN,0)

CSPlot(Ellipse1,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,20,101)})
CSPlot(Ellipse2,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,40,101)})
CSPlot(Ellipse3,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,60,101)})
CSPlot(Ellipse4,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,80,101)})
CSPlot(Ellipse5,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,100,101)})
CSPlot(Ellipse6,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,120,101)})
CSPlot(Ellipse7,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,140,101)})
CSPlot(Ellipse8,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,160,101)})
CSPlot(Ellipse9,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,180,101)})
CSPlot(Ellipse10,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,200,101)})
CSPlot(Ellipse11,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,220,101)})
CSPlot(Ellipse12,P8,101,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,240,101)})

CSPlot(Ellipse1,P8,62,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,20,101)})
CSPlot(Ellipse2,P8,80,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,40,101)})
CSPlot(Ellipse3,P8,21,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,60,101)})
CSPlot(Ellipse4,P8,88,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,80,101)})
CSPlot(Ellipse5,P8,96,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,100,101)})
CSPlot(Ellipse6,P8,98,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,120,101)})
CSPlot(Ellipse7,P8,89,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,140,101)})
CSPlot(Ellipse8,P8,60,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,160,101)})
CSPlot(Ellipse9,P8,90,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,180,101)})
CSPlot(Ellipse10,P8,64,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,200,101)})
CSPlot(Ellipse11,P8,102,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,220,101)})
CSPlot(Ellipse12,P8,27,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,240,101)})

NBL0 = CSMakeLineX(1,1300,90,2,0)

NBL1 = CS_Rotate(NBL0,30)
NBL2 = CS_Rotate(NBL0,60)
NBL3 = CS_Rotate(NBL0,90)
NBL4 = CS_Rotate(NBL0,120)
NBL5 = CS_Rotate(NBL0,150)
NBL6 = CS_Rotate(NBL0,180)
NBL7 = CS_Rotate(NBL0,210)
NBL8 = CS_Rotate(NBL0,240)
NBL9 = CS_Rotate(NBL0,270)
NBL10 = CS_Rotate(NBL0,300)
NBL11 = CS_Rotate(NBL0,330)
NBL12 = CS_Rotate(NBL0,0)

CSPlot(NBL1,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,748,101)})
CSPlot(NBL2,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1380,101)})
CSPlot(NBL3,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,1850,101)})
CSPlot(NBL4,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,2400,101)})
CSPlot(NBL5,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3000,101)})
CSPlot(NBL6,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,3808,101)})
CSPlot(NBL7,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,4600,101)})
CSPlot(NBL8,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,5500,101)})
CSPlot(NBL9,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6200,101)})
CSPlot(NBL10,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,6800,101)})
CSPlot(NBL11,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,7800,101)})
CSPlot(NBL12,P8,9,"CenterCenter",nil,1,64,P7,{Deaths(P9,Exactly,8400,101)})

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,22,101)
	},
	actions = {
		SetInvincibility(Enable,62,P8,"Anywhere");
		GiveUnits(all,62,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,42,101)
	},
	actions = {
		SetInvincibility(Enable,80,P8,"Anywhere");
		GiveUnits(all,80,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,62,101)
	},
	actions = {
		SetInvincibility(Enable,21,P8,"Anywhere");
		GiveUnits(all,21,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,82,101)
	},
	actions = {
		SetInvincibility(Enable,88,P8,"Anywhere");
		GiveUnits(all,88,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,102,101)
	},
	actions = {
		SetInvincibility(Enable,96,P8,"Anywhere");
		GiveUnits(all,96,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,122,101)
	},
	actions = {
		SetInvincibility(Enable,98,P8,"Anywhere");
		GiveUnits(all,98,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,142,101)
	},
	actions = {
		SetInvincibility(Enable,89,P8,"Anywhere");
		GiveUnits(all,89,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,162,101)
	},
	actions = {
		SetInvincibility(Enable,60,P8,"Anywhere");
		GiveUnits(all,60,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,182,101)
	},
	actions = {
		SetInvincibility(Enable,90,P8,"Anywhere");
		GiveUnits(all,90,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,202,101)
	},
	actions = {
		SetInvincibility(Enable,64,P8,"Anywhere");
		GiveUnits(all,64,P8,"Anywhere",P11);
	}
}
Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,222,101)
	},
	actions = {
		SetInvincibility(Enable,102,P8,"Anywhere");
		GiveUnits(all,102,P8,"Anywhere",P11);
	}
}

Trigger { --11p 기브유닛
	players = {P6},
	conditions = {
		Deaths(P9,Exactly,242,101)
	},
	actions = {
		SetInvincibility(Enable,27,P8,"Anywhere");
		GiveUnits(all,27,P8,"Anywhere",P11);
	}
}

Trigger { -- 중립유닛 리빌러 삭제
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,440,101)
	},
	actions = {
		RemoveUnit(101,P8)
	}
}

Trigger { --6p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,748,101)
	},
	actions = {
		SetInvincibility(Disable,62,P11,"Anywhere");
		GiveUnits(all,62,P11,"Anywhere",P8);
		Order(62,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --6p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,1380,101)
	},
	actions = {
		SetInvincibility(Disable,80,P11,"Anywhere");
		GiveUnits(all,80,P11,"Anywhere",P8);
		Order(80,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,1850,101)
	},
	actions = {
		SetInvincibility(Disable,21,P11,"Anywhere");
		GiveUnits(all,21,P11,"Anywhere",P8);
		Order(21,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,2400,101)
	},
	actions = {
		SetInvincibility(Disable,88,P11,"Anywhere");
		GiveUnits(all,88,P11,"Anywhere",P8);
		Order(88,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,3000,101)
	},
	actions = {
		SetInvincibility(Disable,96,P11,"Anywhere");
		GiveUnits(all,96,P11,"Anywhere",P8);
		Order(96,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,3808,101)
	},
	actions = {
		SetInvincibility(Disable,98,P11,"Anywhere");
		GiveUnits(all,98,P11,"Anywhere",P8);
		Order(98,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,4600,101)
	},
	actions = {
		SetInvincibility(Disable,89,P11,"Anywhere");
		GiveUnits(all,89,P11,"Anywhere",P8);
		Order(89,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,5500,101)
	},
	actions = {
		SetInvincibility(Disable,60,P11,"Anywhere");
		GiveUnits(all,60,P11,"Anywhere",P8);
		Order(60,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,6200,101)
	},
	actions = {
		SetInvincibility(Disable,90,P11,"Anywhere");
		GiveUnits(all,90,P11,"Anywhere",P8);
		Order(90,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,6800,101)
	},
	actions = {
		SetInvincibility(Disable,64,P11,"Anywhere");
		GiveUnits(all,64,P11,"Anywhere",P8);
		Order(64,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}
Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,7800,101)
	},
	actions = {
		SetInvincibility(Disable,102,P11,"Anywhere");
		GiveUnits(all,102,P11,"Anywhere",P8);
		Order(102,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { --11p 기브유닛
	players = {P8},
	conditions = {
		Deaths(P9,Exactly,8400,101)
	},
	actions = {
		SetInvincibility(Disable,27,P11,"Anywhere");
		GiveUnits(all,27,P11,"Anywhere",P8);
		Order(27,P8,"Anywhere",Attack,"CenterCenter");
		Order(9,P8,"Anywhere",Attack,"CenterCenter");
	}
}

Trigger { -- 회오리
	players = {P7},
	conditions = {
			Deaths(P9,AtLeast,8466,101);
		},
	actions = {
			SetDeaths(P9,Add,1,102);
			PreserveTrigger()
		}
}


for i = 1, 20 do

DTi = CSMakePolygon(6,30*i,10*i,7,1)

CSPlot(DTi,P8,84,"CenterCenter",nil,1,32,P7,{Deaths(P9,Exactly,2*i,102)},nil,0)
CSPlot(DTi,P6,30,"CenterCenter",nil,1,32,P7,{Deaths(P9,Exactly,2*i,102)},nil,0)

end

for j = 1, 20 do

DTj = CSMakePolygon(6,30*(21-j),10*(21-j),7,1)

CSPlot(DTj,P8,84,"CenterCenter",nil,1,32,P7,{Deaths(P9,Exactly,40+2*j,102)},nil,0)
CSPlot(DTj,P7,102,"CenterCenter",nil,1,32,P7,{Deaths(P9,Exactly,40+2*j,102)},nil,0)

end

Trigger { -- 
	players = {P6},
	conditions = {
			Deaths(P9,AtLeast,8500,101);
		},
	actions = {
			Order("Men",Force2,"Anywhere",Attack,"CenterCenter");
		}
}

 ---------- 유닛끌당건작 (데스값:150~155) ----------- 

function Heart(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
Shape4 = CSMakeGraphT({16,16},"Heart",0,0,1,1,100) -- 하트
Shape4A = CSMakeGraphT({12,12},"Heart",0,0,2,2,50) -- 하트2
Shape4B = CSMakeGraphT({6,6},"Heart",0,0,4,4,35) -- 하트3
ShapeHeart = CS_RemoveStack(CS_Rotate(Shape4,180),10)
ShapeHeartA = CS_RemoveStack(CS_Rotate(Shape4A,180),10)
ShapeHeartB = CS_RemoveStack(CS_Rotate(Shape4B,180),10)
BigHeart = CS_Merge(ShapeHeartA,ShapeHeartB,64,1)
	
Trigger { -- 끌당1 데스값 (150,151)
	players = {P7},
	conditions = {
				CommandLeastAt(127, "Mortar 1")},
	actions = {
				SetDeaths(P9,Add,1,150);
				SetDeaths(P9,Add,1,154);
				PreserveTrigger()}
}

Trigger { -- 끌당1 on/off
	players = {P7},
	conditions = {
				CommandLeastAt(127, "Mortar 1")},
	actions = {
				SetDeaths(P9,SetTo,1,151);
		}
}

Trigger { -- 끌당1
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 1");
				Deaths(P9,AtLeast,0,150);
				Deaths(P9,Exactly,1,151)},
	actions = {
			Order("Men",P6,"Anywhere",Move, "Center Hive 1");
			KillUnit(33,P7);
			SetMemoryX(0x666458, SetTo,391, 0xFFFF);
			PreserveTrigger();
		}			
}

Trigger { -- 끌당1 이펙트 데스값
	players = {P7},
	conditions = {
			Deaths(P9,Exactly,16,154);
				},
	actions = {
			SetDeaths(P9,SetTo,0,154);
			PreserveTrigger();}
}
CSPlot(ShapeHeartA,P7,33,"Center Hive 1",nil,1,64,P7,{CommandLeastAt(127,"Mortar 1"),Deaths(P9,AtLeast,0,150),Deaths(P9,Exactly,1,151),Deaths(P9,Exactly,7,154)},nil,1)

Trigger { -- 끌당1
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 1");
				Deaths(P9,AtLeast,0,150);
				Deaths(P9,Exactly,1,151)
		},
	actions = {
			SetMemoryX(0x666458, SetTo,546, 0xFFFF);
			PreserveTrigger();
		}			
}

Trigger { -- 끌당1 off
	players = {P6},
	conditions = {
				CommandLeastAt(127,"Mortar 1");
				Deaths(P9,AtLeast,1700,150);
		},
	actions = {
			SetDeaths(P9,SetTo,0,151);
			RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")
		}
}

Trigger { -- 끌당1 무적
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 2");
		},
	actions = {
			SetInvincibility(Enable,127,P7,"Mortar 1");
		}
}

Trigger { -- 끌당1 무적해제
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 2");
				Deaths(P9,AtLeast,1702,152);
				Deaths(P9,Exactly,0,153);
		},
	actions = {
			SetInvincibility(Disable,127,P7,"Mortar 1");
		}
}


Trigger { -- 끌당2 데스값 (152,153)
	players = {P7},
	conditions = {
				CommandLeastAt(127, "Mortar 2")},
	actions = {
				SetDeaths(P9,Add,1,152);
				SetDeaths(P9,Add,1,155);
				PreserveTrigger()}
}


Trigger { -- 끌당2 on/off
	players = {P7},
	conditions = {
				CommandLeastAt(127, "Mortar 2")},
	actions = {
				SetDeaths(P9,SetTo,1,153);
		}
}

Trigger { -- 끌당2
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 2");
				Deaths(P9,AtLeast,0,152);
				Deaths(P9,Exactly,1,153)},
	actions = {
			Order("Men",P6,"Anywhere",Move, "Cocoon");
			SetMemoryX(0x666458, SetTo,969, 0xFFFF);
			KillUnit(33,P7);
			PreserveTrigger();}		
}

Trigger { -- 끌당2 이펙트 데스값
	players = {P7},
	conditions = {
				Deaths(P9,Exactly,16,155)},
	actions = {
				SetDeaths(P9,SetTo,0,155);
				PreserveTrigger();}
}


CSPlot(ShapeHeartA,P7,33,"Cocoon",nil,1,64,P7,{CommandLeastAt(127,"Mortar 2"),Deaths(P9,AtLeast,0,152),Deaths(P9,Exactly,1,153),Deaths(P9,Exactly,7,155)},nil,1)

Trigger { -- 끌당2
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 2");
				Deaths(P9,AtLeast,0,152);
				Deaths(P9,Exactly,1,153)},
	actions = {
			SetMemoryX(0x666458, SetTo,546, 0xFFFF);
			PreserveTrigger();
		}		
}

Trigger { -- 끌당2 off
	players = {P6},
	conditions = {
				Deaths(P9,AtLeast,1700,152);
				CommandLeastAt(127,"Mortar 1");
		},
	actions = {
			SetDeaths(P9,SetTo,0,153);
			RunAIScriptAt('Set Unit Order To: Junk Yard Dog',"Anywhere")
		}
}

Trigger { -- 끌당2 무적
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 1");
		},
	actions = {
			SetInvincibility(Enable,127,P7,"Mortar 2");
		}
}

Trigger { -- 끌당2 무적해제
	players = {P7},
	conditions = {
				CommandLeastAt(127,"Mortar 1");
				Deaths(P9,AtLeast,1702,150);
				Deaths(P9,Exactly,0,151);
		},
	actions = {
			SetInvincibility(Disable,127,P7,"Mortar 2");
		}
}

CIfEnd() -- P8 건작트리거단락 끝

 -- 10분주기 웨이브 -- 
	
GR1 = CS_InvertXY(CS_FillGradR(0,{0,450},180,50,"SHBF",0)) --잡몹 공중
GR2 = CS_InvertXY(CS_FillGradR(0,{0,450},180,70,"SHBF",0)) --잡몹 지상1
GR3 = CS_InvertXY(CS_FillGradR(0,{0,450},180,80,"SHBF",0)) --잡몹 지상2
GRH = CS_InvertXY(CS_FillGradR(0,{0,450},180,60,"SHBF",0)) --영웅 지상

GR1D = CS_RatioXY(CS_InvertXY(CS_FillGradR(0,{0,450},180,50,"SHBF",0)),0.3,0.3) --잡몹 공중
GR2D = CS_RatioXY(CS_InvertXY(CS_FillGradR(0,{0,450},180,70,"SHBF",0)),0.3,0.3) --잡몹 지상1
GR3D = CS_RatioXY(CS_InvertXY(CS_FillGradR(0,{0,450},180,80,"SHBF",0)),0.3,0.3) --잡몹 지상2
GRHD = CS_RatioXY(CS_InvertXY(CS_FillGradR(0,{0,450},180,60,"SHBF",0)),0.3,0.3) --영웅 지상

Trigger { -- 카운트다운
	players = {P6},
	conditions = {
			Switch("Switch 2", Set);
		},
	actions = {
			SetCountdownTimer(SetTo,7200);
		}
}

for i = 1, 12 do

Trigger { -- 웨이브 알림
	players = {Force1},
	conditions = {
			CountdownTimer(Exactly,7201-600*i)
		},
	actions = {
			MinimapPing("Wave Zone 2");
			PlayWAV('sound\\Protoss\\ARCHON\\PArYes02.wav');
			PlayWAV('sound\\Protoss\\ARCHON\\PArYes02.wav');
			PlayWAV('sound\\Protoss\\ARCHON\\PArYes02.wav');
			PlayWAV('sound\\Protoss\\ARCHON\\PArYes02.wav');
			SetSwitch("Switch 1", Set);
			TalkingPortrait(68,1000);
		}
}

end

Trigger { -- 웨이브 데스값 (130)
	players = {P6},
	conditions = {
			Switch("Switch 1",Set)
		},
	actions = {
			SetDeaths(P9,Add,1,130);
			PreserveTrigger()
		}
}

Trigger {
	players = {P6},
	conditions = {
			Deaths(P9,AtLeast,18,130)
		},
	actions = {
			SetSwitch("Switch 1",Clear);
			SetDeaths(P9,SetTo,0,130);
			PreserveTrigger()
		}
}

Trigger { -- 건작보스 활성화시 웨이브삭제 (데스값:132)
	players = {P7},
	conditions = {
			CommandLeastAt(190,"CenterCenter");
		},
	actions = {
			SetDeaths(P9,SetTo,1,132);
			PauseTimer();
			KillUnit(189,Force2);
		}
}


CSPlotOrder(GR1,P7,55,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,40,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P6,48,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,56,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,53,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,54,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,5400),CountdownTimer(AtMost,6600),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P7,56,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P6,48,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,80,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,93,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,95,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,4800),CountdownTimer(AtMost,5399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P7,56,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P6,48,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,21,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,78,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,77,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,3600),CountdownTimer(AtMost,4799),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P7,56,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,89,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,75,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,79,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,19,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,17,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2400),CountdownTimer(AtMost,3599),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P7,56,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,98,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,64,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,76,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,63,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,65,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,1200),CountdownTimer(AtMost,2399),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P7,56,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GR3,P7,104,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,22,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P8,96,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,32,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,65,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)
CSPlotOrder(GRH,P6,76,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(AtLeast,2),CountdownTimer(AtMost,1199),Deaths(P9,Exactly,17,130),Deaths(P9,Exactly,0,132)},nil,1)

CSPlotOrder(GR1,P6,88,"HA3",nil,1,64,GR1D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GR2,P7,51,"HA3",nil,1,64,GR2D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GR3,P6,8,"HA3",nil,1,64,GR3D,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GRH,P8,60,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GRH,P6,5,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GRH,P6,81,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})
CSPlotOrder(GRH,P6,3,"HA3",nil,1,64,GRHD,0,Attack,"Heal Zone",nil,64,nil,P6,{CountdownTimer(Exactly,1),Deaths(P9,Exactly,0,132)})

-- 30초 주기 웨이브 --

Trigger { -- 30초 주기 웨이브 데스값 (131)
	players = {P6},
	conditions = {
			Switch("Switch 2",Set);
		},
	actions = {
			SetDeaths(P9,Add,1,131);
			PreserveTrigger()
		}
}

Trigger { -- 30초 주기 웨이브 데스값 초기화
	players = {P6},
	conditions = {
			Deaths(P9,AtLeast,1020,131);
		},
	actions = {
			SetDeaths(P9,SetTo,0,131);
			PreserveTrigger()
		}
}

RC1 = CSMakePolygon(4,50,0,25,5)
RC2 = CSMakePolygon(4,50,0,13,5)
CSPlotOrder(RC1,P7,40,"Wave Zone 1",nil,1,64,RC1,0,Attack,"Heal Zone",nil,64,nil,P6,{Deaths(P9,Exactly,1,131)},nil,1)
CSPlotOrder(RC2,P7,43,"Wave Zone 1",nil,1,64,RC2,0,Attack,"Heal Zone",nil,64,nil,P6,{Deaths(P9,Exactly,1,131)},nil,1)




 ------ 건작 브금 ------

Trigger { -- No comment (D9B181AD)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, Exactly, 1, "Zerg Beacon");
		Deaths(CurrentPlayer, Exactly, 0, "Zerg Flag Beacon");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Zerg Bldg");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Terran Bldg type   2");
		Deaths(CurrentPlayer, Exactly, 0, 158);
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 2734, "Zerg Flag Beacon");
		PlayWAV("staredit\\wav\\NightMare");
		PlayWAV("staredit\\wav\\NightMare");
		PreserveTrigger();
	},
}

Trigger { -- No comment (165CF9E9)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(Force1, Subtract, 1, "Zerg Flag Beacon");
		PreserveTrigger();
	},
}

Trigger { -- No comment (AF9ADCB1)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, AtLeast, 1, "Zerg Beacon");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 0, "Zerg Beacon");
		PreserveTrigger();
	},
}

Trigger { -- No comment (D9B181AD)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, Exactly, 1, "Unused Zerg Bldg 5");
		Deaths(CurrentPlayer, Exactly, 0, "Zerg Flag Beacon");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Zerg Bldg");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Terran Bldg type   2");
		Deaths(CurrentPlayer, Exactly, 0, 158);
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 1700, "Unused Zerg Bldg");
		PlayWAV("staredit\\wav\\Void.ogg");
		PlayWAV("staredit\\wav\\Void.ogg");
		PreserveTrigger();
	},
}

Trigger { -- No comment (165CF9E9)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(Force1, Subtract, 1, "Unused Zerg Bldg");
		PreserveTrigger();
	},
}

Trigger { -- No comment (AF9ADCB1)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, AtLeast, 1, "Unused Zerg Bldg 5");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 0, "Unused Zerg Bldg 5");
		PreserveTrigger();
	},
}

Trigger { -- No comment (D9B181AD)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, Exactly, 1, "Unused Terran Bldg type   1");
		Deaths(CurrentPlayer, Exactly, 0, "Zerg Flag Beacon");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Terran Bldg type   2");
		Deaths(CurrentPlayer, Exactly, 0, "Unused Zerg Bldg");	
		Deaths(CurrentPlayer, Exactly, 0, 158);	
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 1734, "Unused Terran Bldg type   2");
		PlayWAV("staredit\\wav\\L1.ogg");
		PlayWAV("staredit\\wav\\L1.ogg");
		PreserveTrigger();
	},
}

Trigger { -- No comment (165CF9E9)
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetDeaths(Force1, Subtract, 1, "Unused Terran Bldg type   2");
		PreserveTrigger();
	},
}

Trigger { -- No comment (AF9ADCB1)
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer, AtLeast, 1, "Unused Terran Bldg type   1");
	},
	actions = {
		SetDeaths(CurrentPlayer, SetTo, 0, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- No comment (8CE3E51A)
	players = {Force1},
	conditions = {
		Deaths(P6, AtLeast, 1, 132);
	},
	actions = {
		DisplayText("\x13\x04●····『\x0EP\x07a\x04lm \x1FL\x04air 를 \x06파괴\x04하였습니다. +40,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 40000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Zerg Beacon");
		PreserveTrigger();
	},
}

Trigger { -- No comment (0F586695)
	players = {Force1},
	conditions = {
		Deaths(P6, AtLeast, 1, 133);
	},
	actions = {
		DisplayText("\x13\x04●····『\x0EP\x07a\x04lm \x1FH\x04ive 를 \x06파괴\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Zerg Beacon");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 154);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FS\x04kyscraper 를 \x06파괴\x04하였습니다. +80,000 \x1Fⓟⓣⓢ\x04』····●", 4);		
		SetScore(CurrentPlayer, Add, 80000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Zerg Bldg 5");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 152);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FT\x04rinity 를 \x06파괴\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);		
		SetScore(CurrentPlayer, Add, 60000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 148);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FO\x04vermind 를 \x06파괴\x04하였습니다. +150,000 \x1Fⓟⓣⓢ\x04』····●", 4);		
		SetScore(CurrentPlayer, Add, 150000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, "Diversity");
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FD\x04iversity 를 \x06파괴\x04하였습니다. +100,000 \x1Fⓟⓣⓢ\x04』····●", 4);	
		SetScore(CurrentPlayer, Add, 100000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 201);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FW\x04ave 를 \x06파괴\x04하였습니다. +100,000 \x1Fⓟⓣⓢ\x04』····●", 4);	
		SetScore(CurrentPlayer, Add, 100000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Zerg Bldg 5");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 127);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FM\x04agnetic 를 \x06파괴\x04하였습니다. +100,000 \x1Fⓟⓣⓢ\x04』····●", 4);	
		SetScore(CurrentPlayer, Add, 100000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Zerg Bldg 5");
		PreserveTrigger();
	},
}

Trigger { -- 화홀 브금
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 190);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FC\x04limax 를 \x06파괴\x04하였습니다.』····●", 4);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused type   1");
		SetDeaths(P9, SetTo, 1, 200); ----------------------------------------------화홀파괴시 P7영작유닛포인트 삭제
	},
}

Trigger { -- 제네 브금
	players = {Force1},
	conditions = {
		Deaths(P6, AtLeast, 1, 200);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FC\x04ore 를 \x06파괴\x04하였습니다. +100,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		SetScore(CurrentPlayer, Add, 100000, Kills);
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, "Palm Center");
	},
	actions = {
		DisplayText("\x13\x04●····『\x0EP\x07a\x04lm \x1FC\x04enter 를 \x06파괴\x04하였습니다. +50,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 50000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Zerg Bldg 5");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, "Palm Senter");
	},
	actions = {
		DisplayText("\x13\x04●····『\x0EP\x07a\x04lm \x1FS\x04enter 를 \x06파괴\x04하였습니다. +150,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 150000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- No comment (45CE6317)
	players = {Force1},
	conditions = {
		Deaths(P7, AtLeast, 1, 175);
	},
	actions = {
		DisplayText("\x13\x04●····『\x1FC\x04itadel 를 \x06파괴\x04하였습니다. +250,000 \x1Fⓟⓣⓢ\x04』····●", 4);
		SetScore(CurrentPlayer, Add, 250000, Kills);
		SetDeaths(CurrentPlayer, SetTo, 1, "Unused Terran Bldg type   1");
		PreserveTrigger();
	},
}

Trigger { -- 7시 템플 무적해제
	players = {Force1},
	conditions = {
			Deaths(P9,AtLeast,9742,101);
			Bring(Force2,AtMost,10,"Men","Anywhere");
		},
	actions = {
			DisplayText("\x13\x04------------------------------\x07◑ \x04ＮＯＴＩＣＥ \x07◐\x04------------------------------\n\n\n\x13\x04●····“\x04 최종장 \x1FE\x04pilogue 의 \x07무적\x04이 \x0E해제\x04되었습니다. ”····●\n\n\n\x13\x04--------------------------------------------------------------------------" ,4);
			MinimapPing("Temple 1");
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			PlayWAV('sound\\Terran\\Frigate\\AfterOn.wav');
			SetInvincibility(Disable,147,P8,"Temple 1");
		}
}

CIf(FP,{Bring(P8,Exactly,0,147,"Temple 1")},{SetCDeaths("X",SetTo,1,BossOn)})
	--Trigger2(FP,{},{KillUnit("Men",Force2),KillUnit("Buildings",Force2)}) -- Test
	Install_FBoss()
CIfEnd()

Trigger { -- 엔딩1(데스값 P10 200)
	players = {P6},
	conditions = {
		Switch("Switch 100",Set);
	},
	actions = {
		SetDeaths(P10,SetTo,1,200);
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x14\r\n\x13\x04\x14――――――――――――――――――――――――――――――――――――――――――――――――――――――――\x04\r\n\x13", 4);
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
		SetDeaths(P10,SetTo,1,200);

	},
}
Trigger { -- 최종보스 처치
	players = {P6},
	conditions = {
		Switch("Switch 100",Set);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
		SetDeaths(P10,SetTo,2,200);
		
			},
}


Trigger { -- 최종보스 처치
	players = {P6},
	conditions = {
		Switch("Switch 100",Set);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(100);
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
		SetMemory(0x6509B0,SetTo,5); Wait(1000);
		SetSwitch("Switch 101",Set);
					},
}

Trigger { -- 승리조건
	players = {P6},
	conditions = {
			Switch("Switch 101",Set);
		},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04		- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04		- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04		- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04		- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04		- 마린키우기 \x0EP\x07a\x04lm \x1FI\x04sland -\n\n\x13\x1ECreated \x05By \x04CheezeNacho\n\x13\x1F클리어\x04하였습니다!!\n\n\x13☆Thanks to \x1F-Men- , \x03GALAXY_BURST\n\x13\x04♥\x11Special \x04Thanks to \x1BNinfia \x04♥\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――\n",4);
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
		SetMemory(0x6509B0,SetTo,5);
		}
}

Trigger { -- 게임오버 -강퇴
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,20,"Donate P1");
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\r\n\r\n\r\n\r\n\r\n\x13\x04···- ▶ \x04강퇴안될줄 알았지?ㅋㅋ \x05Game Over ><◀ -···\r\n\r\n\r\n\r\n\r\n", 4);
		Defeat();
	}
}

Trigger { -- 게임오버 -강퇴
	players = {P2},
	conditions = {
		Bring(P1,Exactly,1,20,"Donate P2");
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\r\n\r\n\r\n\r\n\r\n\x13\x04···- ▶ \x04방장에게 \x08강퇴당했습니다ㅋ \x05Game Over ><◀ -···\r\n\r\n\r\n\r\n\r\n", 4);
		Defeat();
	}
}
Trigger { -- 게임오버 -강퇴
	players = {P3},
	conditions = {
		Bring(P1,Exactly,1,20,"Donate P3");
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\r\n\r\n\r\n\r\n\r\n\x13\x04···- ▶ \x04방장에게 \x08강퇴당했습니다ㅋ \x05Game Over ><◀ -···\r\n\r\n\r\n\r\n\r\n", 4);
		Defeat();
	}
}
Trigger { -- 게임오버 -강퇴
	players = {P4},
	conditions = {
		Bring(P1,Exactly,1,20,"Donate P4");
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\r\n\r\n\r\n\r\n\r\n\x13\x04···- ▶ \x04방장에게 \x08강퇴당했습니다ㅋ \x05Game Over ><◀ -···\r\n\r\n\r\n\r\n\r\n", 4);
		Defeat();
	}
}
Trigger { -- 게임오버 -강퇴
	players = {P5},
	conditions = {
		Bring(P1,Exactly,1,20,"Donate P5");
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\r\n\r\n\r\n\r\n\r\n\x13\x04···- ▶ \x04방장에게 \x08강퇴당했습니다ㅋ \x05Game Over ><◀ -···\r\n\r\n\r\n\r\n\r\n", 4);
		Defeat();
	}
}

EndCtrig()
-- 에러 체크 함수 선언 위치 --
--↑Tep에 그대로 붙여넣기----------------------------------------
SetCallErrorCheck()
ErrorCheck()
EUDTurbo(FP)

