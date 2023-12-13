function SetExpiration(Month,Day)

TriggerX(FP,{UnixTime(AtLeast,{year = 2023, month = Month, day = Day, hour = 23, min = 59, sec = 59})},{
        CopyCpAction({Defeat()},{P1,P2,P3,P4,P5},FP);
    },{Preserved})
    
end