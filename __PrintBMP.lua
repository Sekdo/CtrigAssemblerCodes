-- __PrintBMP lib for Tep v3.0 Made by Ninfia
TEP30Flag = 0
for k, v in pairs(_G) do
if k == "__mapdirsetting" then
	TEP30Flag = 1
end
end

BMPNameIndex = 0
function CS_PrintBMP(Shape,Xpx,Ypx,Limit) -- Shape -> GRP 
	if TEP30Flag == 0 then
		NEED_TEP3_VERSION()
	end
	
	if Limit == nil then
		Limit = 100000000
	end

	local FileName = "\\PRINTBMP"
	local HEX = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
	if BMPNameIndex < 0x10 then
		FileName = FileName.."000"..HEX[BMPNameIndex+1]
	elseif BMPNameIndex < 0x100 then
		FileName = FileName.."00"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x1000 then
		FileName = FileName.."0"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x10000 then
		FileName = FileName..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF000),12)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	else
		BMPIndex_Overflow()
	end
	
	local NShape = CS_RatioXY(Shape,1/Xpx,1/Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = __CurrentPath..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	local XFill = math.ceil(3*(XNum+1)/4)*4

	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end
	
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
	end

	io.close(GRPFile)
	
	__PrintBMP(FilePath)
end


function CS_PrintBMPX(Shape,TargetXpx,TargetYpx,Limit) -- Shape -> GRP 
	if TEP30Flag == 0 then
		NEED_TEP3_VERSION()
	end
	
	if Limit == nil then
		Limit = 100000000
	end

	local FileName = "\\PRINTBMP"
	local HEX = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
	if BMPNameIndex < 0x10 then
		FileName = FileName.."000"..HEX[BMPNameIndex+1]
	elseif BMPNameIndex < 0x100 then
		FileName = FileName.."00"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x1000 then
		FileName = FileName.."0"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x10000 then
		FileName = FileName..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF000),12)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	else
		BMPIndex_Overflow()
	end
	
	TargetXpx = TargetXpx - 1
	TargetYpx = TargetYpx - 1
	local XSize = CS_GetXmax(Shape)-CS_GetXmin(Shape)
	local YSize = CS_GetYmax(Shape)-CS_GetYmin(Shape)

	local Xpx = (TargetXpx)/XSize
	local Ypx = (TargetYpx)/YSize
	local NShape = CS_RatioXY(Shape,Xpx,Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = __CurrentPath..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	
	local XFill = math.ceil(3*(XNum+1)/4)*4
	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end
	
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
	end

	io.close(GRPFile)
	
	__PrintBMP(FilePath)
end


function CS_PrintBMPColor(Shape,ColorArr,Xpx,Ypx,Limit) -- Shape -> GRP 
	if TEP30Flag == 0 then
		NEED_TEP3_VERSION()
	end
	
	if Limit == nil then
		Limit = 100000000
	end

	local FileName = "\\PRINTBMP"
	local HEX = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
	if BMPNameIndex < 0x10 then
		FileName = FileName.."000"..HEX[BMPNameIndex+1]
	elseif BMPNameIndex < 0x100 then
		FileName = FileName.."00"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x1000 then
		FileName = FileName.."0"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x10000 then
		FileName = FileName..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF000),12)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	else
		BMPIndex_Overflow()
	end
	
	local NShape = CS_RatioXY(Shape,1/Xpx,1/Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = __CurrentPath..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	local XFill = math.ceil(3*(XNum+1)/4)*4

	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end
	
	local RGBArr = {
		{0x04,0x04,0xF4},
		{0xCC,0x48,0x0C},
		{0x94,0xB4,0x2C},
		{0x9C,0x40,0x88},
		{0x14,0x8C,0xF8},
		{0x14,0x30,0x70},
		{0xD0,0xE0,0xCC},
		{0x38,0xFC,0xFC},
		
		{0x08,0x80,0x08},
		{0x7C,0xFC,0xFC},
		{0xB0,0xC4,0xEC},
		{0xD4,0x68,0x40},
		{0x7C,0xA4,0x74},
		{0xB8,0x90,0x90},
		{0xFC,0xE4,0x00},
		{0x18,0xFC,0x10},
	}
	if ColorArr == nil then ColorArr = {} end

	local Num = 1
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)

		if ColorArr[k-1] == nil then
			GRPFile:write(string.char(RGBArr[Num][1]))
			GRPFile:write(string.char(RGBArr[Num][2]))
			GRPFile:write(string.char(RGBArr[Num][3]))
		else
			GRPFile:write(string.char(bit32.band(ColorArr[k-1],0xFF)))
			GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF00),8)))
			GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF0000),16)))
		end

		Num = Num + 1
		if Num > 16 then
			Num = 1
		end
	end

	io.close(GRPFile)
	
	__PrintBMP(FilePath)
end


function CS_PrintBMPColorX(Shape,ColorArr,TargetXpx,TargetYpx,Limit) -- Shape -> GRP 
	if TEP30Flag == 0 then
		NEED_TEP3_VERSION()
	end
	
	if Limit == nil then
		Limit = 100000000
	end

	local FileName = "\\PRINTBMP"
	local HEX = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
	if BMPNameIndex < 0x10 then
		FileName = FileName.."000"..HEX[BMPNameIndex+1]
	elseif BMPNameIndex < 0x100 then
		FileName = FileName.."00"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x1000 then
		FileName = FileName.."0"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x10000 then
		FileName = FileName..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF000),12)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	else
		BMPIndex_Overflow()
	end
	
	TargetXpx = TargetXpx - 1
	TargetYpx = TargetYpx - 1
	local XSize = CS_GetXmax(Shape)-CS_GetXmin(Shape)
	local YSize = CS_GetYmax(Shape)-CS_GetYmin(Shape)

	local Xpx = (TargetXpx)/XSize
	local Ypx = (TargetYpx)/YSize
	local NShape = CS_RatioXY(Shape,Xpx,Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = __CurrentPath..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	
	local XFill = math.ceil(3*(XNum+1)/4)*4
	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end

	local RGBArr = {
		{0x04,0x04,0xF4},
		{0xCC,0x48,0x0C},
		{0x94,0xB4,0x2C},
		{0x9C,0x40,0x88},
		{0x14,0x8C,0xF8},
		{0x14,0x30,0x70},
		{0xD0,0xE0,0xCC},
		{0x38,0xFC,0xFC},
		
		{0x08,0x80,0x08},
		{0x7C,0xFC,0xFC},
		{0xB0,0xC4,0xEC},
		{0xD4,0x68,0x40},
		{0x7C,0xA4,0x74},
		{0xB8,0x90,0x90},
		{0xFC,0xE4,0x00},
		{0x18,0xFC,0x10},
	}
	if ColorArr == nil then ColorArr = {} end

	local Num = 1
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)

		if ColorArr[k-1] == nil then
			GRPFile:write(string.char(RGBArr[Num][1]))
			GRPFile:write(string.char(RGBArr[Num][2]))
			GRPFile:write(string.char(RGBArr[Num][3]))
		else
			GRPFile:write(string.char(bit32.band(ColorArr[k-1],0xFF)))
			GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF00),8)))
			GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF0000),16)))
		end

		Num = Num + 1
		if Num > 16 then
			Num = 1
		end
	end

	io.close(GRPFile)
	
	__PrintBMP(FilePath)
end

function CS_PrintBMPGraph(Shape,ColorArr,areaX,areaY,MainSize,SubSize,AxisColor,DotSize,Xpx,Ypx,Alert,Limit) -- Shape -> GRP
	if TEP30Flag == 0 then
		NEED_TEP3_VERSION()
	end
	
	if Limit == nil then
		Limit = 100000000
	end

	local FileName = "\\PRINTBMP"
	local HEX = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
	if BMPNameIndex < 0x10 then
		FileName = FileName.."000"..HEX[BMPNameIndex+1]
	elseif BMPNameIndex < 0x100 then
		FileName = FileName.."00"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x1000 then
		FileName = FileName.."0"..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	elseif BMPNameIndex < 0x10000 then
		FileName = FileName..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF000),12)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF00),8)+1]..HEX[bit32.rshift(bit32.band(BMPNameIndex, 0xF0),4)+1]..HEX[bit32.band(BMPNameIndex, 0xF)+1]
	else
		BMPIndex_Overflow()
	end
 
	if DotSize == nil or DotSize < 1 then DotSize = 1 end
	if Xpx == nil then Xpx = 1 end
	if Ypx == nil then Ypx = 1 end
	local NShape = CS_RatioXY(Shape,1/Xpx,1/Ypx)

	local MainX, MainY, SubX, SubY, YLoc, XLoc
	if AxisColor == nil then
		AxisColor = {}
	end
	if MainSize ~= nil then 
		MainSize = math.abs(MainSize)
		MainX = MainSize/Xpx
		MainY = MainSize/Ypx
		if AxisColor[2] == nil then
			AxisColor[2] = {}
			AxisColor[2][1] = 0xC0
			AxisColor[2][2] = 0xC0
			AxisColor[2][3] = 0xC0
		else
			local AxisTemp = AxisColor[2]
			AxisColor[2] = {}
			AxisColor[2][1] = bit32.band(AxisTemp,0xFF)
			AxisColor[2][2] = bit32.rshift(bit32.band(AxisTemp,0xFF00),8)
			AxisColor[2][3] = bit32.rshift(bit32.band(AxisTemp,0xFF0000),16)
		end
	end
	if SubSize ~= nil then 
		SubSize = math.abs(SubSize)
		SubX = SubSize/Xpx
		SubY = SubSize/Ypx
		if AxisColor[3] == nil then
			AxisColor[3] = {}
			AxisColor[3][1] = 0xE8
			AxisColor[3][2] = 0xE8
			AxisColor[3][3] = 0xE8
		else
			local AxisTemp = AxisColor[3]
			AxisColor[3] = {}
			AxisColor[3][1] = bit32.band(AxisTemp,0xFF)
			AxisColor[3][2] = bit32.rshift(bit32.band(AxisTemp,0xFF00),8)
			AxisColor[3][3] = bit32.rshift(bit32.band(AxisTemp,0xFF0000),16)
		end
	end

	local Xmin = math.floor(CS_GetXmin(NShape))
	local Ymin = math.floor(CS_GetYmin(NShape))
	local Xmax = math.floor(CS_GetXmax(NShape)+1)
	local Ymax = math.floor(CS_GetYmax(NShape)+1)

	if areaX == nil then
		areaX = {}
	end
	if areaY == nil then
		areaY = {}
	end
	if type(areaX) == "number" then areaX = {-areaX/2,areaX/2} end
	if type(areaY) == "number" then areaY = {-areaY/2,areaY/2} end

	if areaX[1] == nil then areaX[1] = Xmin end
	if areaX[2] == nil then areaX[2] = Xmax end
	if areaY[1] == nil then areaY[1] = Ymin end
	if areaY[2] == nil then areaY[2] = Ymax end

	if type(areaX[1]) == "table" then areaX[1] = areaX[1][1]+Xmin end
	if type(areaX[2]) == "table" then areaX[2] = areaX[2][1]+Xmax end
	if type(areaY[1]) == "table" then areaY[1] = areaY[1][1]+Ymin end
	if type(areaY[2]) == "table" then areaY[2] = areaY[2][1]+Ymax end

	NShape = CS_MoveXY(NShape,-areaX[1],-areaY[1])
	NShape = CS_Round(NShape,0)

	local XMax = areaX[2] - areaX[1]
	local YMax = areaY[2] - areaY[1]

	local FilePath = __CurrentPath..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	local XFill = math.ceil(3*(XNum+1)/4)*4

	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0xFF))
		end
	end

	if SubSize ~= nil then
		YLoc = SubY - areaY[1]%SubY 
		while true do
			for i = 0, XNum do
				GRPFile:seek("set",math.floor(54+3*i+((YNum)-YLoc)*XFill))
				GRPFile:write(string.char(AxisColor[3][1]))
				GRPFile:write(string.char(AxisColor[3][2]))
				GRPFile:write(string.char(AxisColor[3][3]))
			end
			YLoc = YLoc + SubY
			if YLoc > YNum then break end
		end

		XLoc = SubX - areaX[1]%SubX 
		while true do
			for i = 0, YNum do
				GRPFile:seek("set",math.floor(54+3*XLoc+((YNum)-i)*XFill))
				GRPFile:write(string.char(AxisColor[3][1]))
				GRPFile:write(string.char(AxisColor[3][2]))
				GRPFile:write(string.char(AxisColor[3][3]))
			end
			XLoc = XLoc + SubX
			if XLoc > XNum then break end
		end
	end

	if MainSize ~= nil then
		YLoc = MainY - areaY[1]%MainY 
		while true do
			for i = 0, XNum do
				GRPFile:seek("set",math.floor(54+3*i+((YNum)-YLoc)*XFill))
				GRPFile:write(string.char(AxisColor[2][1]))
				GRPFile:write(string.char(AxisColor[2][2]))
				GRPFile:write(string.char(AxisColor[2][3]))
			end
			YLoc = YLoc + MainY
			if YLoc > YNum then break end
		end

		XLoc = MainX - areaX[1]%MainX 
		while true do
			for i = 0, YNum do
				GRPFile:seek("set",math.floor(54+3*XLoc+((YNum)-i)*XFill))
				GRPFile:write(string.char(AxisColor[2][1]))
				GRPFile:write(string.char(AxisColor[2][2]))
				GRPFile:write(string.char(AxisColor[2][3]))
			end
			XLoc = XLoc + MainX
			if XLoc > XNum then break end
		end
	end

	if AxisColor[1] == nil then
		AxisColor[1] = {}
		AxisColor[1][1] = 0
		AxisColor[1][2] = 0
		AxisColor[1][3] = 0
	else
		local AxisTemp = AxisColor[1]
		AxisColor[1] = {}
		AxisColor[1][1] = bit32.band(AxisTemp,0xFF)
		AxisColor[1][2] = bit32.rshift(bit32.band(AxisTemp,0xFF00),8)
		AxisColor[1][3] = bit32.rshift(bit32.band(AxisTemp,0xFF0000),16)
	end

	if areaY[1] <= 0 then -- X축
		for i = 0, XNum do
			GRPFile:seek("set",math.floor(54+3*i+((YNum)+areaY[1])*XFill))
			GRPFile:write(string.char(AxisColor[1][1]))
			GRPFile:write(string.char(AxisColor[1][2]))
			GRPFile:write(string.char(AxisColor[1][3]))
		end
	end

	if areaX[1] <= 0 then -- Y축
		for i = 0, YNum do
			GRPFile:seek("set",math.floor(54-3*areaX[1]+((YNum)-i)*XFill))
			GRPFile:write(string.char(AxisColor[1][1]))
			GRPFile:write(string.char(AxisColor[1][2]))
			GRPFile:write(string.char(AxisColor[1][3]))
		end
	end

	local RGBArr = {
		{0x04,0x04,0xF4},
		{0xCC,0x48,0x0C},
		{0x94,0xB4,0x2C},
		{0x9C,0x40,0x88},
		{0x14,0x8C,0xF8},
		{0x14,0x30,0x70},
		{0x80,0x80,0x80}, -- Grey
		{0x00,0xFF,0xFF}, -- Pure Yellow
		
		{0x08,0x80,0x08},
		{0x00,0x80,0x80}, -- Olive
		{0xFF,0x00,0xFF}, -- Magenta
		{0xD4,0x68,0x40},
		{0x7C,0xA4,0x74},
		{0xB8,0x90,0x90},
		{0xFC,0xE4,0x00},
		{0x18,0xFC,0x10},
	}
	if ColorArr == nil then ColorArr = {} end

	local Num = 1
	for k = 2, NShape[1]+1 do
		if NShape[k][1] <= XNum and NShape[k][1] >= 0 and NShape[k][2] <= YNum and NShape[k][2] >= 0 then
			if DotSize == 1 then
				GRPFile:seek("set",54+3*(NShape[k][1])+((YNum)-(NShape[k][2]))*XFill)

				if ColorArr[k-1] == nil then
					GRPFile:write(string.char(RGBArr[Num][1]))
					GRPFile:write(string.char(RGBArr[Num][2]))
					GRPFile:write(string.char(RGBArr[Num][3]))
				else
					GRPFile:write(string.char(bit32.band(ColorArr[k-1],0xFF)))
					GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF00),8)))
					GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF0000),16)))
				end
			else
				local StX = NShape[k][1]-DotSize+1
				local StY = NShape[k][2]-DotSize+1
				if StX < 0 then StX = 0 end
				if StY < 0 then StY = 0 end

				local EnX = NShape[k][1]+DotSize-1
				local EnY = NShape[k][2]+DotSize-1
				if EnX > XNum then EnX = XNum end
				if EnY > YNum then EnY = YNum end

				for p = StX, EnX, 1 do
					for q = StY, EnY, 1 do 
						GRPFile:seek("set",54+3*(p)+((YNum)-(q))*XFill)

						if ColorArr[k-1] == nil then
							GRPFile:write(string.char(RGBArr[Num][1]))
							GRPFile:write(string.char(RGBArr[Num][2]))
							GRPFile:write(string.char(RGBArr[Num][3]))
						else
							GRPFile:write(string.char(bit32.band(ColorArr[k-1],0xFF)))
							GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF00),8)))
							GRPFile:write(string.char(bit32.rshift(bit32.band(ColorArr[k-1],0xFF0000),16)))
						end
					end
				end
			end

			Num = Num + 1
			if Num > 16 then
				Num = 1
			end
		else
			if Alert == 1 then
				CS_BMPGraph_Shape_is_outside_the_region_shown()
			end
		end
	end

	io.close(GRPFile)
	
	__PrintBMP(FilePath)
end
