function Install_BGM()

------<  BGM Trig  >------------------------------------------
BGMVar = CreateVarArr(5,FP)
OB_BGMVar = CreateVar(FP)

for i = 0, 4 do -- BGM On/Off (Void 1 ~ 5)

TriggerX(FP,{
		Void(i+1,Exactly,1);
	},{
		SetNVar(BGMVar[i+1],SetTo,0);
	},{Preserved})

IBGM_EPD(FP,{i},BGMVar[i+1],{
	{1,"staredit\\wav\\Nightmare.ogg",80*1000},
	{2,"staredit\\wav\\MainA.ogg",52*1000},
	{3,"staredit\\wav\\SMainA.ogg",57*1000},
	{4,"staredit\\wav\\SMainB.ogg",65*1000},
	{5,"staredit\\wav\\SMainC.ogg",63*1000},
	})
end
--< OB BGM >--

IBGM_EPD(FP,{Force5},OB_BGMVar,{
	{1,"staredit\\wav\\Nightmare.ogg",80*1000},
	{2,"staredit\\wav\\MainA.ogg",52*1000},
	{3,"staredit\\wav\\SMainA.ogg",57*1000},
	{4,"staredit\\wav\\SMainB.ogg",65*1000},
	{5,"staredit\\wav\\SMainC.ogg",63*1000},
	})

DoActions(FP,{SetMemory(0x6509B0,SetTo,7)})


BText1 = "\x1F─━┫ “ \x10BGM\x04을 듣지 않습니다\x04.\x0F”"
BText2 = "\x1F─━┫ “ \x10BGM\x04을 듣습니다\x04.\x0F”"

CIf(Force1,{Bring(CurrentPlayer,AtLeast,1,12,"Anywhere")})
 for i = 0, 4 do
		Trigger { -- BGM OFF
				players = {i},
				conditions = {
						Label(0);
						Void(i+1,Exactly,0);
						Bring(i,AtLeast,1,12,"Anywhere");
					},
				actions = {
						ModifyUnitEnergy(1,12,CurrentPlayer,"Anywhere",0);
						RemoveUnit(12,i);
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
						Bring(i,AtLeast,1,12,"Anywhere");
					},
				actions = {
						ModifyUnitEnergy(1,12,CurrentPlayer,"Anywhere",0);
						RemoveUnit(12,i);
						DisplayText(BText2,4);
						SetVoid(i+1,SetTo,0);
						PreserveTrigger()
					}
			}
	end
CIfEnd()

end