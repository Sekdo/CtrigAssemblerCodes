# CS_Minimap.exe v5.0 전용 UNIT.chk 삽입용 플러그인

from eudplib import *
from os.path import getsize
filename = None
def onInit():
    for k, v in settings.items():
        if k.lower() == "unit":
            filename = v
    file_size = getsize(filename)
    file = open(filename, 'rb')

    byteBuffer = bytearray(file.read())

    Count, UNITSize = 0, 0x24
    if file_size % UNITSize != 0:
        print("[CopyUNIT] UNIT.chk : Invaild File")
        return

    chk = GetChkTokenized()
    UNIT = chk.getsection('UNIT')
    
    nUNIT = bytearray()
    for i in range(0, len(UNIT), UNITSize):
        Temp = bytearray(UNIT[i:i+UNITSize])
        nUNIT += Temp
    for i in range(0, file_size, UNITSize):
        Temp = bytearray(byteBuffer[i:i+UNITSize])
        nUNIT += Temp
        Count += 1

    chk.setsection('UNIT', nUNIT)
    print(
            "[CopyUNIT] UNIT.chk : {} Loaded. ({} Units Added)".format(
                file, Count
        )
    )
    file.close()

onInit()