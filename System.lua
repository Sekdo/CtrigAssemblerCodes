function Install_System()

------<  �ۼ�Ʈ��, ��Ӽ���  >---------------------------------------------

DoActions(FP,{ -- �ۼ�Ʈ �� ���� & ���
    SetMemory(0x515B88,SetTo,256);SetMemory(0x515B8C,SetTo,256);SetMemory(0x515B90,SetTo,256);SetMemory(0x515B94,SetTo,256);
    SetMemory(0x515B98,SetTo,256);SetMemory(0x515B9C,SetTo,256);SetMemory(0x515BA0,SetTo,256);SetMemory(0x515BA4,SetTo,256);
    SetMemory(0x515BA8,SetTo,256);SetMemory(0x515BAC,SetTo,256);
    SetMemory(0x515BC4,SetTo,20480); -- ���� 8�� ( Ÿ�� 0,1,2,3,4 )
	SetMemory(0x515BC8,SetTo,10240); -- �ϸ� 4�� ( Ÿ�� 6 )
 	SetMemory(0x515BCC,SetTo,5120); -- ���ú� 2�� ( Ÿ�� 7 )
	SetMemory(0x515BD0,SetTo,40960); -- �ǹ� 
	SetMemory(0x515BD4,SetTo,256); -- ������ ( Ÿ�� 9 )
    SetSpeed(SetTo,"#X2");
})

------<  ���� & ���ͼ���  >---------------------------------------------

DoActions(Force1,{RunAIScript('Turn ON Shared Vision for Player 1'), -- Vision
		RunAIScript('Turn ON Shared Vision for Player 2'),
		RunAIScript('Turn ON Shared Vision for Player 3'),
		RunAIScript('Turn ON Shared Vision for Player 4'),
		RunAIScript('Turn ON Shared Vision for Player 5'),
        SetAllianceStatus(Force1,AlliedVictory);
	})
DoActions(Force2,{
	SetAllianceStatus(Force1,Enemy)
})

------<  �̼� ������Ƽ��  >---------------------------------------------

OBText1 = "\x13\x04ȯ���� : \x1F�������� % \n\x13\x03��\x04�Ʒ� ���꿡 �ϸ������ø� ����(\x1F20,000��)�� ��ȯ�˴ϴ�.\n\x13\x04 �����佺�α��� : ��ü���ּ� // �׶��α��� : �������ִ������ּ� // �����α��� : ĵ��Ƚ��\n\x13\x1FTip: \x04�������ּ� 300�̻��̸� ��Ŀ�� �����ϴ�."
OBText2 = "\x13\x04ȯ���� : \x1F�������� % \n\x13\x03��\x04�Ʒ� ���꿡 �ϸ������ø� ����(\x1F20,000��)�� ��ȯ�˴ϴ�.\n\x13\x04 �����佺�α��� : ��ü���ּ� // �׶��α��� : �������ִ������ּ� // �����α��� : ĵ��Ƚ��\n\x13\x1FTip: \x04�������ּ� 300�̻��̸� ��Ŀ�� �����ϴ�."
TriggerX(FP,{CDeaths("X",Exactly,1,GMode)},{ -- �븻
    CopyCpAction({SetMissionObjectivesX(OBText1)}, {Force1}, FP);
    })
TriggerX(FP,{CDeaths("X",Exactly,2,GMode)},{ -- �ϵ�
    CopyCpAction({SetMissionObjectivesX(OBText2)}, {Force1}, FP);
    })
------<  ���ּ� üũ , �α��� ǥ�� >---------------------------------------------
AllUnit, AllUnitX = CreateVars(2,FP)
	TriggerX(FP,Always(),{FSetMemory(0x0582264,SetTo,2400),
	FSetMemory(0x0582268,SetTo,2400),
	FSetMemory(0x058226C,SetTo,2400),
	FSetMemory(0x0582270,SetTo,2400),
	FSetMemory(0x0582274,SetTo,2400),

	FSetMemory(0x05822C4,SetTo,3200), -- Max Unit (Over 1000, Max 1500)
	FSetMemory(0x05822C8,SetTo,3200),
	FSetMemory(0x05822CC,SetTo,3200),
	FSetMemory(0x05822D0,SetTo,3200),
	FSetMemory(0x05822D4,SetTo,3200)})

SpriteCount, SubCount1, SubCount2, SubCount3, SubCount4, SubCount5, SubCount6, SubCount7 = CreateVars(8,FP)

CheckSTGun = CreateCcode()

UnitReadX(FP,AllPlayers,"Any unit","Anywhere",AllUnitX)
UnitReadX(FP,AllPlayers,3,nil,SubCount1)
UnitReadX(FP,AllPlayers,23,nil,SubCount3)
UnitReadX(FP,AllPlayers,17,nil,SubCount4)
UnitReadX(FP,AllPlayers,25,nil,SubCount6)
UnitReadX(FP,AllPlayers,30,nil,SubCount7)

CMov(FP,AllUnit,_Add(AllUnitX,_Add(SubCount1,_Add(SubCount2,_Add(SubCount3,_Add(SubCount4,_Add(SubCount5,_Add(SubCount6,SubCount7))))))))

CDoActions(FP,{
	TSetMemory(0x582294,SetTo,_Mul(AllUnit,2));
	TSetMemory(0x582298,SetTo,_Mul(AllUnit,2));
	TSetMemory(0x58229C,SetTo,_Mul(AllUnit,2));
	TSetMemory(0x5822A0,SetTo,_Mul(AllUnit,2));
	TSetMemory(0x5822A4,SetTo,_Mul(AllUnit,2));
})

HZUnitCount = CreateVar(FP)

UnitReadX(FP,Force2,"Any unit","CountingLoc",HZUnitCount)
f_Mul(FP,HZUnitCount,2)

CDoActions(FP,{
	SetMemory(0x582234+4*0,SetTo,2*600); -- Max TPop
	SetMemory(0x582234+4*1,SetTo,2*600);
	SetMemory(0x582234+4*2,SetTo,2*600);
	SetMemory(0x582234+4*3,SetTo,2*600);
	SetMemory(0x582234+4*4,SetTo,2*600);

	SetMemory(0x5821D4+4*0,SetTo,2*200); -- Available TPop
	SetMemory(0x5821D4+4*1,SetTo,2*200);
	SetMemory(0x5821D4+4*2,SetTo,2*200);
	SetMemory(0x5821D4+4*3,SetTo,2*200);
	SetMemory(0x5821D4+4*4,SetTo,2*200);

	TSetMemory(0x582204+4*0,SetTo,HZUnitCount); -- Used
	TSetMemory(0x582204+4*1,SetTo,HZUnitCount);
	TSetMemory(0x582204+4*2,SetTo,HZUnitCount);
	TSetMemory(0x582204+4*3,SetTo,HZUnitCount);
	TSetMemory(0x582204+4*4,SetTo,HZUnitCount);
})
------<  ��Ŀ���� Ʈ����  >---------------------------------------------
TriggerX(FP,{NVar(HZUnitCount,AtLeast,600)},{KillUnit(125,Force1);})

------<  �������� Ʈ����  >---------------------------------------------
LB = CreateCcode()

DoActionsX(FP,{SetCDeaths("X",Add,1,LB)})
DifLB = {"\x04������ \x03N\x04ormal \x04������","\x04������ \x08H\x04ard \x04������"}

for i = 1, 2 do
	TriggerX(FP,{CDeaths("X",Exactly,1,LB),CDeaths("X",Exactly,i,GMode)},LeaderBoardScore(Kills,"\x1FP\x04oints" ..DifLB[i]),{Preserved})
	TriggerX(FP,{CDeaths("X",Exactly,171,LB),CDeaths("X",Exactly,i,GMode)},LeaderBoardScore(Custom,"\x06D\x04eaths" ..DifLB[i]),{Preserved})
	end

TriggerX(FP,{CDeaths("X",AtLeast,340,LB)},{SetCDeaths("X",SetTo,0,LB)},{Preserved})
TriggerX(FP,{CDeaths("X",Exactly,0,LB)},{Order("Men",Force2,"CountingLoc",Attack,"HZ")},{Preserved})
DoActions(FP,{LeaderBoardComputerPlayers(Disable)},{}) -- ��ǻ�� �������� ����

------<  ����, ���� Ʈ����  >---------------------------------------------
MarID = {1,10,16,99,100}

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

DeathM1 = "\x12\x1F������\x06 [1 Player]\x04�� \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathM2 = "\x12\x1F������\x0E [2 Player]\x04�� \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathM3 = "\x12\x1F������\x0F [3 Player]\x04�� \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathM4 = "\x12\x1F������\x10 [4 Player]\x04�� \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathM5 = "\x12\x1F������\x11 [5 Player]\x04�� \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathHM1 = "\x12\x1F������\x06 [1 Player]\x04�� \x03H\x04ero \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathHM2 = "\x12\x1F������\x0E [2 Player]\x04�� \x03H\x04ero \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathHM3 = "\x12\x1F������\x0F [3 Player]\x04�� \x03H\x04ero \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathHM4 = "\x12\x1F������\x10 [4 Player]\x04�� \x03H\x04ero \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."
DeathHM5 = "\x12\x1F������\x11 [5 Player]\x04�� \x03H\x04ero \x1CM\x04arine �� \x06���\x04�Ͽ����ϴ�."

MarText = {DeathM1,DeathM2,DeathM3,DeathM4,DeathM5}
HeroMarText = {DeathHM1,DeathHM2,DeathHM3,DeathHM4,DeathHM5}
for i = 0, 4 do
        TriggerX(FP,{Deaths(i,AtLeast,1,20)},{
			SetScore(i, Add, 1, Custom);SetDeaths(i, Subtract, 1, 20);
			CopyCpAction({DisplayTextX(MarText[i+1],4),PlayWAVX("staredit\\wav\\Death.ogg")},{Force1,Force5},FP)
		},{Preserved})
        TriggerX(FP,{
			Deaths(i,AtLeast,1,MarID[i+1])},{
				SetScore(i, Add, 3, Custom);SetDeaths(i, Subtract, 1, MarID[i+1]);
				CopyCpAction({DisplayTextX(HeroMarText[i+1],4),PlayWAVX("staredit\\wav\\Death.ogg")},{Force1,Force5},FP)
		},{Preserved})
        
        TriggerX(i,{ -- ���� �ٷλ̱�
            Bring(CurrentPlayer,AtLeast,1,8,"Anywhere");
        },{
            ModifyUnitEnergy(1,8,CurrentPlayer,"Anywhere",0);
            RemoveUnitAt(1,8,"Anywhere",CurrentPlayer);
            CreateUnit2(1,MarID[i+1],"HZ",CurrentPlayer);
            DisplayText("\x1F������ �� \x08H\x04ero \x03M\x04arine �� ��ȯ�Ͽ����ϴ�. ��\x08-30,000 \x1FOre\x04����", 4);
        },{Preserved})
        
        TriggerX(i,{ -- ����
            Bring(CurrentPlayer,AtLeast,1,20,"Hero");
            Accumulate(CurrentPlayer,AtLeast,20000,Ore);
        },{
            SetResources(CurrentPlayer,Subtract,20000,Ore);
            ModifyUnitEnergy(1,20,CurrentPlayer,"Hero",0);
            RemoveUnitAt(1,20,"Hero",CurrentPlayer);
            CreateUnit2(1,MarID[i+1],"HeroDest",CurrentPlayer);
            DisplayText("\x1F������ �� \x08H\x04ero \x03M\x04arine �� ��ȯ�Ͽ����ϴ�. ��\x08-20,000 \x1FOre\x04����", 4);
        },{Preserved})
        
        TriggerX(i,{ -- �ϸ�
            Bring(CurrentPlayer,AtLeast,1,0,"Anywhere");
        },{
			ModifyUnitEnergy(all, 0, CurrentPlayer, "Anywhere", 0);
            RemoveUnitAt(1,0,"Anywhere",i);
            CreateUnit2(1,20,"HeroDest",i);
            DisplayText("\x1F������ �� \x0EM\x04arine �� ��ȯ�Ͽ����ϴ�. ��\x08-10,000 \x1FOre\x04����", 4);
        },{Preserved})
end

------<  �߸����� ����, �޵� Ʈ����  >---------------------------------------------

NUnit = {0,1,10,16,99,100,20}

function RemoveNUnit()
	for i = 1, #NUnit do
		local X ={}
			table.insert(X,(ModifyUnitEnergy(all,NUnit[i],P12,"Anywhere",0)))
			table.insert(X,(RemoveUnit(NUnit[i],P12)))
		return X
	end
end

DoActions(FP,{
    RemoveNUnit();
    RemoveUnit("Buildings",P12);
    KillUnit(84,P5); -- �þ߰��������� P5�� ����
    RemoveUnit(204,P5); -- �þ߰��������� P5�� ����
})

HealTikUnit = {34,2}
HTik = CreateNcode()

for i = 0, 4 do

Trigger { -- First Heal Value
	players = {i},
	conditions = {
			Label(0);
			Always()
		},
	actions = {
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,1);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,0);
		}
}

end

CIf(Force1,{Bring(CurrentPlayer,AtLeast,1,21,"Anywhere")})

for i = 0, 4 do

Trigger { -- 3 tik Heal
	players = {i},
	conditions = {
			Label(0);
			Bring(i,AtLeast,1,21,"Anywhere");
			NDeaths(i,Exactly,0,HTik);
		},
	actions = {
			GiveUnits(all,21,i,"Anywhere",P12);
			ModifyUnitEnergy(all, 21, P12, "Anywhere", 0);
			RemoveUnit(21,P12);
			DisplayText("\x1F�������� \x04���� \x0F�޵�(3 tik) \x04����� ����մϴ�\x04. ��\x0F250ore\x04��\x0F��", 4);
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,0);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,1);
			SetNDeaths(i,SetTo,1,HTik);
			PreserveTrigger()
		}
}

Trigger { -- 2 tik Heal
	players = {i},
	conditions = {
			Label(0);
			Bring(i,AtLeast,1,21,"Anywhere");
			NDeaths(i,Exactly,1,HTik);
		},
	actions = {
			GiveUnits(all,21,i,"Anywhere",P12);
			ModifyUnitEnergy(all, 21, P12, "Anywhere", 0);
			RemoveUnit(21,P12);
			DisplayText("\x1F�������� \x04�Ϲ� \x0F�޵�(2 tik) \x04����� ����մϴ�\x04. ��\x0F200ore\x04��\x0F��", 4);
			SetMemoryB(0x57F27C+(i*228)+34,SetTo,1);
			SetMemoryB(0x57F27C+(i*228)+2,SetTo,0);
			SetNDeaths(i,SetTo,0,HTik);
			PreserveTrigger()
		}
}
end
CIfEnd()

for i = 0, 4 do
for j = 1, 2 do
Trigger { -- Heal Trig (1,2,3tik)
	players = {i},
	conditions = {
            Bring(CurrentPlayer,AtLeast,1,HealTikUnit[j],"Anywhere")
		},
	actions = {
			RemoveUnitAt(all,HealTikUnit[j],"Anywhere",i);
			ModifyUnitHitPoints(all,20,i,"Anywhere",100);
			ModifyUnitHitPoints(all,1,i,"Anywhere",100);
            ModifyUnitHitPoints(all,10,i,"Anywhere",100);
            ModifyUnitHitPoints(all,16,i,"Anywhere",100);
            ModifyUnitHitPoints(all,99,i,"Anywhere",100);
            ModifyUnitHitPoints(all,100,i,"Anywhere",100);
			PreserveTrigger();
		}
}

end
end

HZTimer = CreateCcode()

DoActionsX(FP,{SetCDeaths("X",Add,1,HZTimer)})

TriggerX(FP,{CDeaths("X",AtLeast,34*3,HZTimer)},{
    ModifyUnitHitPoints(all,"Men",Force1,"HZ",100);
    SetCDeaths("X",SetTo,0,HZTimer);
},{Preserved})

------<  ���� Ʈ����  >---------------------------------------------

BanText = "\x13\x1F�������� \x04����� \x11���忡 ���� \x08�������� \x04���Ͽ����ϴ�.  \x1F��������"
BanLocArr = {"BanP1","BanP2","BanP3","BanP4","BanP5"}
for i = 0, 4 do
Trigger {
	players = {FP},
	conditions = {
			Label(0);
			Bring(Force1,AtLeast,1,96,BanLocArr[i+1]);
		},
	actions = {
			RotatePlayer({DisplayTextX(BanText)},{i},FP);
			RotatePlayer({Defeat()},{i},FP);
		}
}
end
--56 59 243
------<  ��� Ʈ����  >--------------------------------------------- [ GiveRateUnit = 8  ]
GText1 = "\x13\x1F������ \x04��αݾ� ������ \x1F5,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
GText2 = "\x13\x1F������ \x04��αݾ� ������ \x1F10,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
GText3 = "\x13\x1F������ \x04��αݾ� ������ \x1F50,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
GText4 = "\x13\x1F������ \x04��αݾ� ������ \x1F100,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
GText5 = "\x13\x1F������ \x04��αݾ� ������ \x1F500,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
GText6 = "\x13\x1F������ \x04��αݾ� ������ \x1F1,000 Ore \x04�� \x11����\x04�Ǿ����ϴ�. \x1F������"
-- 1000 = 0 // 5000 = 1 // 10000 = 2 // 50000 = 3 // 100000 = 4 // 500000 = 5
GTable = {{0,1,GText1},{1,2,GText2},{2,3,GText3},{3,4,GText4},{4,5,GText5},{5,0,GText6}}
--Give Trig -- [ GiveUnit (58,60,69,71,72) ]
--GiveRate 0~5 [ 5000, 10000, 50000, 100000, 500000, 1000 ]

GiveRate = CreateNcode()

GiveRate2 = {1000,5000,10000,50000,100000,500000}
GiveUnitID = {58,60,69,71,72}
PlayerArr = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5"}

CIf(Force1,{Bring(CurrentPlayer,AtLeast,1,9,"Anywhere")})

for i = 0, 4 do
for j = 1, 6 do
Trigger {
	players = {i},
	conditions = {
			Label(0);
			NDeaths(i,Exactly,GTable[j][1],GiveRate);
			Bring(CurrentPlayer,AtLeast,1,9,"Anywhere")
		},
	actions = {
			GiveUnits(all,9,i,"Anywhere",P12);
			ModifyUnitEnergy(all, 9, P12, "Anywhere", 0);
			RemoveUnit(9,P12);
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
					ModifyUnitEnergy(all, GiveUnitID[j+1], k, "Anywhere", 0);
					RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
					DisplayText("\x1F������ �� \x1F�ܾ�\x04�� �����մϴ�.\x0F��",4);
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
					ModifyUnitEnergy(all, GiveUnitID[j+1], k, "Anywhere", 0);
					RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
					DisplayText("\x1F������ �� "..PlayerArr[j+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ����Ͽ����ϴ�. \x0F��",4);
					SetMemory(0x6509B0,SetTo,j);
					DisplayText("\x1F������ �� "..PlayerArr[k+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ��ι޾ҽ��ϴ�. \x0F��",4);
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
			DisplayText("\x1F������ ��"..PlayerArr[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x0F��",4);
			ModifyUnitEnergy(all, GiveUnitID[j+1], k, "Anywhere", 0);
			RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
			PreserveTrigger();
				},
		}
	
CIfEnd()
elseif k==j then
	TriggerX(k,{Bring(k,AtLeast,1,GiveUnitID[j+1],"Anywhere")},{
		ModifyUnitEnergy(all, GiveUnitID[j+1], k, "Anywhere", 0);
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
	},{Preserved})
end end end

------<  ȯ�� Ʈ����  >---------------------------------------------
ExRate = {22,25}

for k = 1, 2 do
	CIf(Force1,{CDeaths(FP,Exactly,k,GMode)})
		for j = 15, 0, -1 do
				TriggerX(Force1,{Score(CurrentPlayer,Kills,AtLeast,2^j*100)},{
					SetScore(CurrentPlayer,Subtract,2^j*100,Kills);
					SetResources(CurrentPlayer,Add,2^j*ExRate[k],Ore);
				},{Preserved})
		end
	CIfEnd()
end

end