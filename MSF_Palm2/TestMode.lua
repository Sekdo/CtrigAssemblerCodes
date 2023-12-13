function Enable_TestMode(f)

if f == true
    then X = 1
elseif f == false
    then X = 0
end

TriggerX(P1,{isname(P1,"CheezeNacho")},{ -- Å×½ºÆ®
	CreateUnit(1,92,"HZ",CurrentPlayer);
	CreateUnit(12,1,"HZ",CurrentPlayer);
	SetResources(P1,SetTo,0xFFFFFF,Ore);
	SetCDeaths("X",SetTo,X,TestOn);
})
end
