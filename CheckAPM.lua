function CheckAPM(Value)

McrTxt = "\n\n\n\n\n\n\x13\x08[APMCounterX] MACRO DETECTED : 매크로가 감지되었습니다.\n\n\n\n"
McrTxt2 = "\n\n\n\n\n\n\x13\x08[APMCounterX] MACRO DETECTED : 어떤 야발놈이 매크로를 사용하여 헤으읏되었습니다.\n\n\n\n"

Mcr_Check = CreateCcode()

-- CRead(FP,0x57F120,DtoA(P1,95)) -- P1의 APM값 -> 빨강 가스로

CTrigger(FP,{Memory(DtoA(P1,95),AtLeast,1)},{TSetResources(P1, SetTo,_ReadF(DtoA(P1,95)), Gas)},{Preserved})

for i = 0, 4 do
TriggerX(FP,{Memory(DtoA(i,95),AtLeast,Value)}, {
    CopyCpAction({
        DisplayTextX(McrTxt, 4),
        PlayWAVX("sound\\Misc\\Buzz.wav"),
        PlayWAVX("sound\\Misc\\Buzz.wav"),
        Defeat()
    }, i, FP);
    SetCDeaths("X",SetTo,1,Mcr_Check);
})
end

TriggerX(FP,{CDeaths("X",Exactly,1,Mcr_Check)},{
    SetCDeaths("X",SetTo,0,Mcr_Check);
    CopyCpAction({
        DisplayTextX(McrTxt2, 4),
        PlayWAVX("sound\\Misc\\Buzz.wav"),
        PlayWAVX("sound\\Misc\\Buzz.wav"),
    }, {Force1}, FP);
})

end