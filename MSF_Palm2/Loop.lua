function HeroLoop()

DoActions(FP, ModifyUnitEnergy(all, 8, Force2, "Anywhere", 100))

HT1 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04obalt 를 \x06처치\x04하였습니다. \x07+ 90,000 \x1B┣━─"
HT2 = "\x13\x1B─━┫ \x03Hero \x04:: \x08R\x04eversed \x1FT\x04ank 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT3 = "\x13\x1B─━┫ \x03Hero \x04:: \x08S\x04tealth 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT4 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04erverg 를 \x06처치\x04하였습니다. \x07+ 300,000 \x1B┣━─"
HT5 = "\x13\x1B─━┫ \x03Hero \x04:: \x08A\x04pex 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT6 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Q\x04uaser 를 \x06처치\x04하였습니다. \x07+ 45,000 \x1B┣━─"
HT7 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04elocity 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT8 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04anish 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT9 = "\x13\x1B─━┫ \x03Hero \x04:: \x08M\x04agellan 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT10 = "\x13\x1B─━┫ \x03Hero \x04:: \x08A\x04gony 를 \x06처치\x04하였습니다. \x07+ 250,000 \x1B┣━─"
HT11 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04esta 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT12 = "\x13\x1B─━┫ \x03Hero \x04:: \x08K\x04ronos 를 \x06처치\x04하였습니다. \x07+ 200,000 \x1B┣━─"
HT13 = "\x13\x1B─━┫ \x03Hero \x04:: \x08H\x04yperion 를 \x06처치\x04하였습니다. \x07+ 40,000 \x1B┣━─"
HT14 = "\x13\x1B─━┫ \x03Hero \x04:: \x08R\x04eversed \x1FS\x04iege 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT15 = "\x13\x1B─━┫ \x03Hero \x04:: \x08I\x04gnite 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT16 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04ollapse 를 \x06처치\x04하였습니다. \x07+ 75,000 \x1B┣━─"
HT17 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04ystopia 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT18 = "\x13\x1B─━┫ \x03Hero \x04:: \x08W\x04icked 를 \x06처치\x04하였습니다. \x07+ 75,000 \x1B┣━─"
HT19 = "\x13\x1B─━┫ \x03Hero \x04:: \x08W\x04hisper 를 \x06처치\x04하였습니다. \x07+ 100,000 \x1B┣━─"
HT20 = "\x13\x1B─━┫ \x03Hero \x04:: \x08E\x04dge 를 \x06처치\x04하였습니다. \x07+ 55,000 \x1B┣━─"
HT21 = "\x13\x1B─━┫ \x03Hero \x04:: \x08L\x04ux 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"
HT22 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Immortal C\x04alypso 를 \x06처치\x04하였습니다. \x07+ 80,000 \x1B┣━─"
HT23 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Immortal G\x04uilty 를 \x06처치\x04하였습니다. \x07+ 90,000 \x1B┣━─"
HT24 = "\x13\x1B─━┫ \x03Hero \x04:: \x08G\x04alaxy 를 \x06처치\x04하였습니다. \x07+ 150,000 \x1B┣━─"
HT25 = "\x13\x1B─━┫ \x03Hero \x04:: \x08S\x04arah 를 \x06처치\x04하였습니다. \x07+ 45,000 \x1B┣━─"
HT26 = "\x13\x1B─━┫ \x03Hero \x04:: \x08V\x04iolet 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT27 = "\x13\x1B─━┫ \x03Hero \x04:: \x08T\x04esla 를 \x06처치\x04하였습니다. \x07+ 55,000 \x1B┣━─"
HT28 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04alypso 를 \x06처치\x04하였습니다. \x07+ 35,000 \x1B┣━─"
HT29 = "\x13\x1B─━┫ \x03Hero \x04:: \x08G\x04uilty 를 \x06처치\x04하였습니다. \x07+ 40,000 \x1B┣━─"
HT30 = "\x13\x1B─━┫ \x03Hero \x04:: \x08D\x04ivinity 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT31 = "\x13\x1B─━┫ \x03Hero \x04:: \x08F\x04ierce 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT32 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04atastrophic 를 \x06처치\x04하였습니다. \x07+ 65,000 \x1B┣━─"
HT33 = "\x13\x1B─━┫ \x03Hero \x04:: \x1FC\x04amou\x08F\x04lager 를 \x06처치\x04하였습니다. \x07+ 50,000 \x1B┣━─"
HT34 = "\x13\x1B─━┫ \x03Hero \x04:: \x08A\x04nxiety 를 \x06처치\x04하였습니다. \x07+ 110,000 \x1B┣━─"
HT35 = "\x13\x1B─━┫ \x03Hero \x04:: \x08P\x04redator 를 \x06처치\x04하였습니다. \x07+ 75,000 \x1B┣━─"
HT36 = "\x13\x1B─━┫ \x03Hero \x04:: \x08M\x04utant 를 \x06처치\x04하였습니다. \x07+ 30,000 \x1B┣━─"
HT37 = "\x13\x1B─━┫ \x03Hero \x04:: \x08C\x04eres 를 \x06처치\x04하였습니다. \x07+ 60,000 \x1B┣━─"
HT38 = "\x13\x1B─━┫ \x03Hero \x04:: \x08Ｍ\x04Ωｒｔｉｓ 를 \x06처치\x04하였습니다. \x07+ 100,000 \x1B┣━─"
HT39 = "\x13\x1B─━┫ \x03Hero \x04:: \x0EP\x07a\x04lm\x08T\x04ower 를 \x06처치\x04하였습니다. \x07+ 70,000 \x1B┣━─"

HText = {HT1,HT2,HT3,HT4,HT5,HT6,HT7,HT8,HT9,HT10,HT11,HT12,HT13,HT14,HT15,HT16,HT17,HT18,HT19,HT20,HT21,HT22,HT23,HT24,
		HT25,HT26,HT27,HT28,HT29,HT30,HT31,HT32,HT33,HT34,HT35,HT36,HT37,HT38,HT39}
HIndex = {3,5,8,9,70,17,19,21,22,23,25,71,28,30,32,52,58,60,61,63,64,65,66,68,74,75,76,77,78,79,80,81,86,87,88,93,98,102,162} -- 38
HPoint = {9,6,7,30,6,4.5,5,3,6.5,25,3,20,4,6.5,6.5,7.5,5,7.5,10,5.5,7,8,9,15,4.5,5,5.5,3.5,4,5,3,6.5,5,11,7.5,3,6,10,7}

HInfoArr = {} -- {{HIndex[1],HText[1],HPoint[1]},{HIndex[2],HText[2],HPoint[2]}, ...}
for i = 1, 39 do
	local X = {}
	table.insert(X,HIndex[i])
	table.insert(X,HText[i])
	table.insert(X,HPoint[i])
	table.insert(HInfoArr,X)
end

CunitCtrig_Part1(FP)
MoveCp("X",25*4) -- UnitID (EPD 25)

DoActions(FP,MoveCp(Subtract,16*4))
CIf(FP,{DeathsX(CurrentPlayer,Exactly,1*65536,0,0xFF0000)},SetDeathsX(CurrentPlayer,SetTo,0*65536,0,0xFF0000)) -- EPD 9 ( 1 = 영작유닛표식 )
	DoActions(FP,MoveCp(Add,16*4))
		for i = 1, #HInfoArr do
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,HInfoArr[i][1],0,0xFF)},{
				CopyCpAction({DisplayTextX(HInfoArr[i][2],4)},{Force1,Force5},FP);
				CopyCpAction({PlayWAVX("staredit\\wav\\Hero.ogg"),PlayWAVX("staredit\\wav\\Hero.ogg")},{Force1,Force5},FP);
				SetScore(Force1,Add,HInfoArr[i][3]*10000,Kills);
			},{Preserved})
		end
CIfEnd()
Call_LoadCp() -- EPD 25

ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtLeast,1*16777216,0,0xFF000000), -- Energy
	DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtMost,250*16777216,0,0xFF000000), -- Energy
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),Exactly,0*256,0,0xFF00), -- MainOrderID : Die 0x0
},
{	SetDeathsX(EPDF(0x628298-0x150*i+(40*4)),SetTo,0*16777216,0,0xFF000000); -- Reset Energy
	MoveCp(Add,25*4);})
end
CunitCtrig_End()

end
