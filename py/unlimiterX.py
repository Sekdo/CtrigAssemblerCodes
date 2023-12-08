'''
unlimiter v1
'''

from eudplib import *

def connectDList(el_start, el_end, itemSize, itemN, isSprite):
    dataDb = Db(bytes(itemSize * itemN))

    a1, a2, a3 = Forward(), Forward(), Forward()
    if EUDLoopN()(itemN):
        DoActions([
            a1 << SetMemory(dataDb, SetTo, dataDb - itemSize),
            a2 << SetMemory(dataDb + 4, SetTo, dataDb + itemSize),
            SetMemory(a1 + 16, Add, itemSize // 4),
            SetMemory(a1 + 20, Add, itemSize),
            SetMemory(a2 + 16, Add, itemSize // 4),
            SetMemory(a2 + 20, Add, itemSize),
        ])
        Trigger(
            isSprite >= 1,
            [
                a3 << SetMemory(dataDb + 0x10, SetTo, 10000),
                SetMemory(a3 + 16, Add, itemSize // 4),
                SetMemory(a3 + 20, Add, 1),
            ]
        )
    EUDEndLoopN()

    DoActions([
        SetMemory(el_start, SetTo, dataDb),
        SetMemory(dataDb, SetTo, 0),
        SetMemory(el_end, SetTo, dataDb + itemSize * (itemN - 1)),
        SetMemory(dataDb + itemSize * (itemN - 1) + 4, SetTo, 0)
    ])


def onPluginStart():
    global SpCount, Count
    Count, SpCount = -1, -1
    for k, v in settings.items():
        if k == "Count":
            Count = v
        elif k == "SpCount":
            SpCount = v
    if Count == -1:
        Count = 8192
    else:
        Count = int(Count,0)
    if SpCount == -1:
        SpCount = max([65536, Count])
    else:
        SpCount = int(SpCount,0)

    connectDList(0x64EED8, 0x64EEDC, 112, Count, 0)  # Patch bullet count
    connectDList(0x63FE30, 0x63FE34, 36, SpCount, 1)  # Patch sprite count
    connectDList(0x57EB68, 0x57EB70, 64, SpCount, 0)  # Patch image count
    connectDList(0x64B2E0, 0x64B2E4, 20, SpCount, 0)  # Patch order count

    print(
        "[UnlimiterX] Bullet MaxCount : {} (Sprite/Image/Order : {})".format(
            Count, SpCount
        )
    )

def afterTriggerExec():
    DoActions(SetMemory(0x64DEBC, SetTo, 40))
