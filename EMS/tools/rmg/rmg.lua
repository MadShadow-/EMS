-- author:RobbiTheFox,mcb		current maintainer:RobbiTheFox
-- Tool um zufällige Maps zu erzeugen.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- TODO:
-- fix Pit locations to 400 grid or maybe 200 is already enough
-- mirror rivers
-- do generation before countdown starts
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
EMS_CustomMapConfig.Version = 1.9
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\fixes\\TriggerFix.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\math\\SimplexNoise.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\math\\astar.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\tables\\TerrainTypes.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\tables\\WaterTypes.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\number\\round.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\entity\\CreateWoodPile.lua" )
Script.Load( "maps\\user\\EMS\\tools\\s5CommunityLib\\mapeditor\\MirrorMapTools.lua" )
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator = {}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.SetupThresholdsNormal()
	EMS.GL.SetValueSynced("RMG_TerrainBaseHeight",	 2900)	-- height of flat terrain
	EMS.GL.SetValueSynced("RMG_WaterBaseHeight",	 2500)
	EMS.GL.SetValueSynced("RMG_NoiseFactorZ",		  100)
	EMS.GL.SetValueSynced("RMG_NoiseFactorXY",		  100)	-- lower values stretch the noise
	EMS.GL.SetValueSynced("RMG_ForestDensity",		  100)
	
	EMS.GL.SetValueSynced("RMG_ThresholdPike",		  600)	-- noise higher than value
	EMS.GL.SetValueSynced("RMG_ThresholdHighMeadow", 1000)
	EMS.GL.SetValueSynced("RMG_ThresholdHighForest", 1000)
	EMS.GL.SetValueSynced("RMG_ThresholdMountain",	  500)
	EMS.GL.SetValueSynced("RMG_ThresholdHill",		  450)
	EMS.GL.SetValueSynced("RMG_ThresholdForest",	  275)
	EMS.GL.SetValueSynced("RMG_ThresholdMeadow",	  225)
	EMS.GL.SetValueSynced("RMG_ThresholdSea",		 -600)	-- noise lower than value
	EMS.GL.SetValueSynced("RMG_ThresholdLake",		 -500)
	EMS.GL.SetValueSynced("RMG_ThresholdCoast",		 -450)
	EMS.GL.SetValueSynced("RMG_ThresholdLowForest",	 -275)
	EMS.GL.SetValueSynced("RMG_ThresholdLowMeadow",	 -225)
	EMS.GL.SetValueSynced("RMG_ThresholdFlatland",	  420)	-- noise values between ThresholdFlatland and ThresholdLowFlatland get flattened to TerrainBaseHeight
	EMS.GL.SetValueSynced("RMG_ThresholdLowFlatland",-420)
	EMS.GL.SetValueSynced("RMG_ThresholdRoad",		    0)	-- roads can theoreticly generate naturaly (which they are not supposed to) but this is extreme unlikely
	EMS.GL.SetValueSynced("RMG_ThresholdPlateau",	 1000)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupThresholdsNorth()
	--EMS.GL.SetValueSynced("RMG_TerrainBaseHeight",	 2900)
	--EMS.GL.SetValueSynced("RMG_WaterBaseHeight",	 2500)
	EMS.GL.SetValueSynced("RMG_NoiseFactorZ",		   75)
	--EMS.GL.SetValueSynced("RMG_NoiseFactorXY",		  100)
	
	EMS.GL.SetValueSynced("RMG_ThresholdPike",		 1000)
	EMS.GL.SetValueSynced("RMG_ThresholdHighMeadow",  420)
	EMS.GL.SetValueSynced("RMG_ThresholdHighForest",  240)
	EMS.GL.SetValueSynced("RMG_ThresholdMountain",	  220)
	EMS.GL.SetValueSynced("RMG_ThresholdHill",		  150)
	EMS.GL.SetValueSynced("RMG_ThresholdForest",	  -25)
	EMS.GL.SetValueSynced("RMG_ThresholdMeadow",	  -75)
	EMS.GL.SetValueSynced("RMG_ThresholdSea",		 -600)
	EMS.GL.SetValueSynced("RMG_ThresholdLake",		 -500)
	EMS.GL.SetValueSynced("RMG_ThresholdCoast",		 -450)
	EMS.GL.SetValueSynced("RMG_ThresholdLowForest",	 -375)
	EMS.GL.SetValueSynced("RMG_ThresholdLowMeadow",	 -325)
	EMS.GL.SetValueSynced("RMG_ThresholdFlatland",	   70)
	EMS.GL.SetValueSynced("RMG_ThresholdLowFlatland",-420)
	EMS.GL.SetValueSynced("RMG_ThresholdRoad",		 -200)
	EMS.GL.SetValueSynced("RMG_ThresholdPlateau",	  240)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupThresholdsTideland()
	--EMS.GL.SetValueSynced("RMG_TerrainBaseHeight",	 2900)
	--EMS.GL.SetValueSynced("RMG_WaterBaseHeight",	 2500)
	EMS.GL.SetValueSynced("RMG_NoiseFactorZ",		   75)
	--EMS.GL.SetValueSynced("RMG_NoiseFactorXY",		  100)
	
	EMS.GL.SetValueSynced("RMG_ThresholdPike",		  650)
	--EMS.GL.SetValueSynced("RMG_ThresholdHighMeadow", 1000)
	--EMS.GL.SetValueSynced("RMG_ThresholdHighForest", 1000)
	EMS.GL.SetValueSynced("RMG_ThresholdMountain",	  550)
	EMS.GL.SetValueSynced("RMG_ThresholdHill",		  500)
	EMS.GL.SetValueSynced("RMG_ThresholdForest",	  325)
	EMS.GL.SetValueSynced("RMG_ThresholdMeadow",	  275)
	EMS.GL.SetValueSynced("RMG_ThresholdSea",		 -550)
	EMS.GL.SetValueSynced("RMG_ThresholdLake",		 -450)
	EMS.GL.SetValueSynced("RMG_ThresholdCoast",		 -200)
	EMS.GL.SetValueSynced("RMG_ThresholdLowForest",	 -175)
	EMS.GL.SetValueSynced("RMG_ThresholdLowMeadow",	 -125)
	EMS.GL.SetValueSynced("RMG_ThresholdFlatland",	  470)
	EMS.GL.SetValueSynced("RMG_ThresholdLowFlatland",-170)
	EMS.GL.SetValueSynced("RMG_ThresholdRoad",		   50)
	--EMS.GL.SetValueSynced("RMG_ThresholdPlateau",	 1000)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupThresholdsMordor()
	EMS.GL.SetValueSynced("RMG_WaterBaseHeight", 0)
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.SetupLandscapeNormal()
	SetupNormalWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeNorth()
	SetupHighlandWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeEvelance()
	SetupEvelanceWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeMediterran()
	SetupMediterraneanWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeMoor()
	SetupMoorWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeTideland()
	SetupNormalWeatherGfxSet()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetupLandscapeMordor()
	SetupEvelanceWeatherGfxSet()
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.TextureSets = { -- define TextureSets HERE !

 -- European
	NormalEarthAndRocks = {
		TerrainTypes.EarthFir01_AT,
		TerrainTypes.EarthFir02_AT,TerrainTypes.EarthFir02_AT,
		TerrainTypes.EarthFir03_AT,TerrainTypes.EarthFir03_AT,
	},
	NormalEarthBright = {
		TerrainTypes.EarthBright01B_AT,TerrainTypes.EarthBright01B_AT,TerrainTypes.EarthBright01B_AT,TerrainTypes.EarthBright01B_AT,
			TerrainTypes.EarthBright02_AT,TerrainTypes.EarthBright02_AT,
 	TerrainTypes.EarthBrStones01B_AT,TerrainTypes.EarthBrStones01B_AT,
	},
	NormalEarthDark = {
		TerrainTypes.EarthDark01B_AT,TerrainTypes.EarthDark01B_AT,TerrainTypes.EarthDark01B_AT,TerrainTypes.EarthDark01B_AT,
		TerrainTypes.EarthDark02_AT,TerrainTypes.EarthDark02_AT,
		TerrainTypes.EarthDark03_AT,TerrainTypes.EarthDark03_AT,
	},
	NormalForestSmooth = {
		TerrainTypes.EarthFir02_AT,
		TerrainTypes.EarthFir03_AT,
		TerrainTypes.EarthMoss01_AT,TerrainTypes.EarthMoss01_AT,TerrainTypes.EarthMoss01_AT,TerrainTypes.EarthMoss01_AT,
		TerrainTypes.EarthMoss02_AT,TerrainTypes.EarthMoss02_AT,TerrainTypes.EarthMoss02_AT,TerrainTypes.EarthMoss02_AT,
		TerrainTypes.GrassDark01B_AT,
		TerrainTypes.GrassDark02_AT,
		TerrainTypes.GrassDarkLeaf01B_CT,
		TerrainTypes.GrassDarkLeaf02_CT,
	},
	NormalGrassBrightSmooth = {
		TerrainTypes.EarthBrStones01B_AT,
		TerrainTypes.GrassBright01B_AT,TerrainTypes.GrassBright01B_AT,TerrainTypes.GrassBright01B_AT,TerrainTypes.GrassBright01B_AT,
		TerrainTypes.GrassBright02_AT,TerrainTypes.GrassBright02_AT,
		TerrainTypes.GrassBright03_AT,TerrainTypes.GrassBright03_AT,
	},
	NormalGrassDarkSmooth = {
		TerrainTypes.EarthDark01B_AT,
		TerrainTypes.GrassDark01B_AT,TerrainTypes.GrassDark01B_AT,TerrainTypes.GrassDark01B_AT,TerrainTypes.GrassDark01B_AT,TerrainTypes.GrassDark01B_AT,TerrainTypes.GrassDark01B_AT,
		TerrainTypes.GrassDark02_AT,TerrainTypes.GrassDark02_AT,TerrainTypes.GrassDark02_AT,TerrainTypes.GrassDark02_AT,
		TerrainTypes.GrassDarkLeaf01B_CT,
		TerrainTypes.GrassDarkLeaf02_CT,
	},
	NormalMudDarkSmooth = {
		TerrainTypes.MudDark01B_AT,TerrainTypes.MudDark01B_AT,TerrainTypes.MudDark01B_AT,TerrainTypes.MudDark01B_AT,
		TerrainTypes.MudDark02B_AT,TerrainTypes.MudDark02B_AT,TerrainTypes.MudDark02B_AT,
		TerrainTypes.MudDark03_AT,TerrainTypes.MudDark03_AT,
		TerrainTypes.MudDark04_AT,TerrainTypes.MudDark04_AT,
		TerrainTypes.MudDark05_AT,TerrainTypes.MudDark05_AT,
	},
	NormalRockDarkSmooth = {
		TerrainTypes.RockDark01B_AT,TerrainTypes.RockDark01B_AT,TerrainTypes.RockDark01B_AT,TerrainTypes.RockDark01B_AT,
		TerrainTypes.RockDark02_AT,TerrainTypes.RockDark02_AT,TerrainTypes.RockDark02_AT,
		TerrainTypes.RockDark03_AT,TerrainTypes.RockDark03_AT,
		TerrainTypes.EarthRocky01B_AT,
	},
	NormalRocky = {
		TerrainTypes.EarthRocky01B_AT,
	},
	NormalSeabedSmooth = {
		TerrainTypes.EarthSeabed01_AT,
		TerrainTypes.EarthSeabed01_AT,
		TerrainTypes.EarthSeabed02_AT,
	},
 
	-- Norths
	NorthEarthBright = {
		TerrainTypes.EarthBrightNorth01B_AT,
	},
	NorthEarthDark = {
		TerrainTypes.EarthDarkNorth01B_AT,
	},
	NorthForest = {
		TerrainTypes.EarthDarkNorth01B_AT,
		TerrainTypes.GrassNorth02B_AT,
		TerrainTypes.GrassNorth02B_AT,
	},
	NorthGrassBrightSmooth = {
		TerrainTypes.EarthBrightNorth01B_AT,
		TerrainTypes.GrassNorth01B_AT,
		TerrainTypes.GrassNorth01B_AT,
		TerrainTypes.GrassNorth01B_AT,
	},
	NorthGrassDarkSmooth = {
		TerrainTypes.EarthBrightNorth01B_AT,
		TerrainTypes.GrassNorth02B_AT,
		TerrainTypes.GrassNorth02B_AT,
		TerrainTypes.GrassNorth02B_AT,
	},
	NorthGrassPurpleSmooth = {
		TerrainTypes.EarthDarkNorth01B_AT,
		TerrainTypes.GrassNorth03B_AT,
		TerrainTypes.GrassNorth03B_AT,
		TerrainTypes.GrassNorth03B_AT,
	},
	NorthGrassYellowSmooth = {
		TerrainTypes.EarthBrightNorth01B_AT,
		TerrainTypes.GrassNorthMoor01B_AT,
		TerrainTypes.GrassNorthMoor01B_AT,
		TerrainTypes.GrassNorthMoor01B_AT,
		TerrainTypes.GrassNorthMoor01B_AT,
		TerrainTypes.GrassNorthMoor01B_AT,
	},
	NorthRockDarkSmooth = {
		TerrainTypes.RockDarkNorth01B_AT,
	},
	NorthSand = {
		TerrainTypes.SandRockyNorth01_AT_HP,
		TerrainTypes.SandEarthNorth01_AT_HP,
	},	
	NorthSeabedSmooth = {
		TerrainTypes.EarthSeabedNorth01_AT,
	},
 
	-- Evelance
	EvelanceEarthBones = {
		TerrainTypes.EarthDarkEvelance01_AT,
		TerrainTypes.EarthDarkEvelance02_AT,
	},
	EvelanceEarthDark = {
		TerrainTypes.EarthDarkEvelance01_AT,
		TerrainTypes.EarthBrightEvelance02_AT,
	},
	EvelanceEarthDry = {
		TerrainTypes.EarthBrightEvelance01B_AT,
		TerrainTypes.EarthBrightEvelance01B_AT,
		TerrainTypes.EarthBrightEvelance01B_AT,
		TerrainTypes.EarthBrightEvelance02_AT,
	},
	EvelanceEarthRocky = {
		TerrainTypes.EarthBrightNorth01B_AT,
		TerrainTypes.EarthErosiveEvelance01B_AT,
		TerrainTypes.EarthErosiveEvelance01B_AT,
		TerrainTypes.EarthErosiveEvelance01B_AT,
		TerrainTypes.EarthErosiveEvelance01B_AT,
	},
	EvelanceForest = {
		TerrainTypes.EarthDarkEvelance01_AT,
		TerrainTypes.EarthMoss01_AT,
		TerrainTypes.EarthMoss02_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
	},
	EvelanceGrassErosive = {
		TerrainTypes.EarthErosiveEvelance01B_AT,
		TerrainTypes.EarthErosiveEvelance01B_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
		TerrainTypes.GrassErosiveEvelance01B_AT,
	},
	EvelanceRockDarkSmooth = {
		TerrainTypes.RockDarkEvelance01B_AT,
		TerrainTypes.RockDarkEvelance01B_AT,
		TerrainTypes.RockDarkEvelance01B_AT,
		TerrainTypes.RockDarkEvelance01B_AT,
		TerrainTypes.RockDarkEvelance02_AT,
		TerrainTypes.RockDarkEvelance02_AT,
		TerrainTypes.RockDarkEvelance02_AT,
		TerrainTypes.RockDarkEvelance03B_AT,
		TerrainTypes.RockDarkEvelance03B_AT,
		TerrainTypes.RockDarkEvelance04B_AT,
		TerrainTypes.RockDarkEvelance04B_AT,
	},
	
	-- Medi
	MediForest = {
		TerrainTypes.EarthBright01B_AT,
		TerrainTypes.GrassMediterrean01_AT,
		TerrainTypes.GrassMediterrean01_AT,
		TerrainTypes.GrassMediterrean01_AT,
	},
	MediGrassBright = {
		TerrainTypes.EarthBright01B_AT,
		TerrainTypes.GrassMediterrean02_AT,
		TerrainTypes.GrassMediterrean02_AT,
		TerrainTypes.GrassMediterrean02_AT,
	},
	MediGrassYellow = {
		TerrainTypes.EarthBright01B_AT,
		TerrainTypes.GrassMediterrean03_AT,
		TerrainTypes.GrassMediterrean03_AT,
		TerrainTypes.GrassMediterrean03_AT,
	},
	MediGrassSandy = {
		TerrainTypes.EarthBright01B_AT,
		TerrainTypes.GrassMediterrean04_AT,
		TerrainTypes.GrassMediterrean04_AT,
		TerrainTypes.GrassMediterrean04_AT,
	},
	MediRockBright = {
		TerrainTypes.RockLight01B_AT,
	},
	MediRockDark = {
		TerrainTypes.RockMedium01B_AT,
	},
	MediSand = {
		TerrainTypes.SandMediterrean01_AT,
		TerrainTypes.SandMediterrean02_AT,
		TerrainTypes.SandMediterrean03_AT,
	},
	
	-- Moor
	MoorEarth = {
		TerrainTypes.EarthBrightMoor01B_AT,
		TerrainTypes.EarthBrightMoor01B_AT,
		TerrainTypes.EarthBrightMoor01B_AT,
		TerrainTypes.EarthBrightMoor02B_AT,
		TerrainTypes.EarthDarkMoor01B_AT,
	},
	MoorGrassBright = {
		TerrainTypes.EarthBrightMoor01B_AT,
		TerrainTypes.GrassBrightMoor01B_AT,
		TerrainTypes.GrassBrightMoor01B_AT,
		TerrainTypes.GrassBrightMoor01B_AT,
	},
	MoorGrassDark = {
		TerrainTypes.EarthDarkMoor01B_AT,
		TerrainTypes.GrassDarkMoor01B_AT,
		TerrainTypes.GrassDarkMoor01B_AT,
		TerrainTypes.GrassDarkMoor01B_AT,
	},
	MoorRockDark = {
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor02_AT,
		TerrainTypes.RockDarkMoor02_AT,
		TerrainTypes.RockDarkMoor03_AT,
		TerrainTypes.RockDarkMoor03_AT,
	},
	MoorRockDarkVains = {
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor01B_AT,
		TerrainTypes.RockDarkMoor02_AT,
		TerrainTypes.RockDarkMoor02_AT,
		TerrainTypes.RockDarkMoor03_AT,
		TerrainTypes.RockDarkMoor03_AT,
		TerrainTypes.RockDarkMoor04B_AT,
		TerrainTypes.RockDarkMoor04B_AT,
		TerrainTypes.RockDarkMoor05_AT,
		TerrainTypes.RockDarkMoor05_AT,
	},
	MoorRocky = {
		TerrainTypes.EarthBrightMoor01B_AT,
		TerrainTypes.EarthRockyMoor01_AT,
		TerrainTypes.EarthRockyMoor01_AT,
		TerrainTypes.EarthRockyMoor01_AT,
	},
	
	-- Tideland
	TidelandGrass = {
		TerrainTypes.GrassFlowersTideland01B_AT,
		TerrainTypes.GrassFlowersTideland02B_AT,
	},
	TidelandMud = {
		TerrainTypes.MudTideland01B_AT,
		TerrainTypes.MudTideland02_AT,
	},
	TidelandRockBright = {
		TerrainTypes.RockBrightTideland01B_AT,
	},
	TidelandSand = {
		TerrainTypes.SandEarthTideland01B_AT,
		TerrainTypes.SandEarthTideland02_AT,
	},
	
	-- Misc
	MiscSnow = {
		TerrainTypes.Snow01_CT,
		TerrainTypes.Snow01_CT,
		TerrainTypes.Snow01_CT,
		TerrainTypes.Snow02_CT,
		TerrainTypes.Snow03_CT,
	},
	
	MiscRoad = {
		TerrainTypes.PebblesEarth01_AT,
	}
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.VertexColorSets = {

	MordorLava = {
		{r = 127, g = 0, b = 0},
		{r = 153, g = 25, b = 0},
		{r = 178, g = 59, b = 0},
		{r = 204, g = 102, b = 0},
		{r = 229, g = 153, b = 0},
		{r = 255, g = 212, b = 0},
		{r = 255, g = 255, b = 127},
	},
	MiscNormal = {
		{r = 127, g = 127, b = 127},
	},
	MiscSlightlyDark = {
		{r = 95, g = 95, b = 95},
	},
	MiscDark = {
		{r = 63, g = 63, b = 63},
	},
	MiscVeryDark = {
		{r = 31, g = 31, b = 31},
	},
	MiscBlack = {
		{r = 0, g = 0, b = 0},
	},
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.EntitySets = { -- define EntitySets HERE !

	-- European
	NormalGrassBright = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Corn1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant1,
		Entities.XD_Plant2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_Rock1,
		Entities.XD_RockGrass2,
	},
	NormalGrassDark = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant1,
		Entities.XD_Plant2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_Rock1,
		Entities.XD_RockGrass2,
	},
	NormalForestMixed = {
		Entities.XD_Bush1,
		Entities.XD_Bush4,
		Entities.XD_Fir1,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir2,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_GreeneryBushHigh2,
		Entities.XD_GreeneryBushHigh3,
		Entities.XD_GreeneryBushHigh4,
		Entities.XD_Plant1,
		Entities.XD_Plant2,
		Entities.XD_Rock1,
		Entities.XD_RockGrass2,
		Entities.XD_Tree1,
		Entities.XD_Tree1_small,
		Entities.XD_Tree1_small,
		Entities.XD_Tree2,
		Entities.XD_Tree2_small,
		Entities.XD_Tree2_small,
		Entities.XD_Tree3,
		Entities.XD_Tree3_small,
		Entities.XD_Tree3_small,
	},
	NormalRockDark = {
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock2,
		Entities.XD_Rock2,
		Entities.XD_Rock2,
		Entities.XD_Rock2,
		Entities.XD_Rock2,
		Entities.XD_Rock2,
		Entities.XD_Rock3,
		Entities.XD_Rock3,
		Entities.XD_Rock3,
		Entities.XD_Rock3,
		Entities.XD_Rock3,
		Entities.XD_Rock4,
		Entities.XD_Rock4,
		Entities.XD_Rock4,
		Entities.XD_Rock4,
		Entities.XD_Rock5,
		Entities.XD_Rock5,
		Entities.XD_Rock5,
		Entities.XD_Rock6,
		Entities.XD_Rock6,
		Entities.XD_Rock7,
	},
	NormalForestBirchAndWillow = {
		Entities.XD_Bush1,
		Entities.XD_Bush4,
		Entities.XD_Plant1,
		Entities.XD_Plant2,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_Rock1,
		Entities.XD_RockGrass2,
		Entities.XD_Tree4,
		Entities.XD_Tree5,
		Entities.XD_Tree6,
		Entities.XD_Tree7,
		Entities.XD_Willow1,
	},

	-- North
	NorthGrass = {
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth3,
		Entities.XD_PlantNorth3,
		Entities.XD_PlantNorth3,
		Entities.XD_PlantNorth3,
		Entities.XD_PlantNorth4,
		Entities.XD_PlantNorth4,
		Entities.XD_PlantNorth4,
		Entities.XD_PlantNorth4,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
	},
	NorthGrassPurple = {
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth5,
		Entities.XD_PlantNorth5,
		Entities.XD_PlantNorth6,
		Entities.XD_PlantNorth6,
		Entities.XD_PlantNorth7,
		Entities.XD_PlantNorth7,
		Entities.XD_PlantNorth7,
		Entities.XD_PlantNorth7,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
	},
	NorthGrassYellow = {
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_RockNorth3,	
		Entities.XD_RockNorth4,
	},
	NorthForestMixed = {
		Entities.XD_Fir1,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir2,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_PineNorth1,
		Entities.XD_PineNorth2,
		Entities.XD_PineNorth2,
		Entities.XD_PineNorth3,
		Entities.XD_PineNorth3,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
	},
	NorthForestFir = {
		Entities.XD_Fir1,
		Entities.XD_Fir1,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir2,
		Entities.XD_Fir2,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
	},
	NorthRockDark = {
		Entities.XD_RockNorth1,
		Entities.XD_RockNorth2,
		Entities.XD_RockNorth2,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
	},
	NorthForestBirch = {
		Entities.XD_TreeNorth1,
		Entities.XD_TreeNorth1,
		Entities.XD_TreeNorth2,
		Entities.XD_TreeNorth2,
		Entities.XD_TreeNorth3,
		Entities.XD_TreeNorth3,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
	},
	NorthForestPine = {
		Entities.XD_PineNorth1,
		Entities.XD_PineNorth1,
		Entities.XD_PineNorth2,
		Entities.XD_PineNorth2,
		Entities.XD_PineNorth2,
		Entities.XD_PineNorth3,
		Entities.XD_PineNorth3,
		Entities.XD_PineNorth3,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth1,
		Entities.XD_PlantNorth2,
		Entities.XD_PlantNorth2,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth3,
		Entities.XD_RockNorth4,
		Entities.XD_RockNorth4,
	},
	
	-- Evelance
	EvelanceEarth = {
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush6,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
	},
	EvelanceForestFir = {
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush6,
		Entities.XD_DeadBush6,
		Entities.XD_Fir1,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir1_small,
		Entities.XD_Fir2,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_Fir2_small,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_TreeEvelance1,
	},
	EvelanceForestDead = {
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush6,
		Entities.XD_DeadBush6,
		Entities.XD_DeadBush6,
		Entities.XD_DeadBush6,
		Entities.XD_DeadTree01,
		Entities.XD_DeadTree01,
		Entities.XD_DeadTree02,
		Entities.XD_DeadTree02,
		Entities.XD_DeadTree02,
		Entities.XD_DeadTree02,
		Entities.XD_DeadTree03,
		Entities.XD_DeadTree03,
		Entities.XD_DeadTree04,
		Entities.XD_DeadTree04,
		Entities.XD_DeadTree04,
		Entities.XD_DeadTree04,
		Entities.XD_DeadTree05,
		Entities.XD_DeadTree05,
		Entities.XD_DeadTree06,
		Entities.XD_DeadTree06,
		Entities.XD_DeadTreeEvelance1,
		Entities.XD_DeadTreeEvelance1,
		Entities.XD_DeadTreeEvelance2,
		Entities.XD_DeadTreeEvelance2,
		Entities.XD_DeadTreeEvelance3,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
	},
	EvelanceGrass = {
		Entities.XD_DeadBush1,
		Entities.XD_DeadBush2,
		Entities.XD_DeadBush3,
		Entities.XD_DeadBush4,
		Entities.XD_DeadBush5,
		Entities.XD_DeadBush6,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant1,
		Entities.XD_Plant2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_Plant5,
		Entities.XD_Plant6,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance2,
	},
	EvelanceRockDark = {
		Entities.XD_CliffEvelance1,
		Entities.XD_CliffEvelance2,
		Entities.XD_CliffEvelance3,
		Entities.XD_CliffEvelance3,
		Entities.XD_CliffEvelance3,
		Entities.XD_CliffEvelance4,
		Entities.XD_CliffEvelance4,
		Entities.XD_CliffEvelance4,
		Entities.XD_CliffEvelance4,
		Entities.XD_CliffEvelance5,
		Entities.XD_CliffEvelance5,
		Entities.XD_CliffEvelance5,
		Entities.XD_CliffEvelance5,
		Entities.XD_CliffEvelance5,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance1,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance2,
		Entities.XD_RockDarkEvelance3,
		Entities.XD_RockDarkEvelance3,
		Entities.XD_RockDarkEvelance3,
		Entities.XD_RockDarkEvelance3,
		Entities.XD_RockDarkEvelance3,
		Entities.XD_RockDarkEvelance4,
		Entities.XD_RockDarkEvelance4,
		Entities.XD_RockDarkEvelance4,
		Entities.XD_RockDarkEvelance4,
		Entities.XD_RockDarkEvelance5,
		Entities.XD_RockDarkEvelance5,
		Entities.XD_RockDarkEvelance5,
		Entities.XD_RockDarkEvelance6,
		Entities.XD_RockDarkEvelance6,
		Entities.XD_RockDarkEvelance7,
	},
	
	-- Medi
	MediForestCypress = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Bush4,
		Entities.XD_Cypress1,
		Entities.XD_Cypress1,
		Entities.XD_Cypress2,
		Entities.XD_Cypress2,
		Entities.XD_Cypress2,
		Entities.XD_Cypress2,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediForestFruit = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Bush4,
		Entities.XD_AppleTree1,
		Entities.XD_AppleTree1,
		Entities.XD_AppleTree2,
		Entities.XD_OrangeTree1,
		Entities.XD_OrangeTree1,
		Entities.XD_OrangeTree2,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediForestOlive = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Bush4,
		Entities.XD_OliveTree1,
		Entities.XD_OliveTree2,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediForestPine = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Bush4,
		Entities.XD_Pine1,
		Entities.XD_Pine1,
		Entities.XD_Pine2,
		Entities.XD_Pine3,
		Entities.XD_Pine3,
		Entities.XD_Pine4,
		Entities.XD_Pine4,
		Entities.XD_Pine5,
		Entities.XD_Pine5,
		Entities.XD_Pine6,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_Plant3,
		Entities.XD_Plant4,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediGrassBright = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_Corn1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediGrassDark = {
		Entities.XD_Bush2,
		Entities.XD_Bush3,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediGrassYellow = {
		Entities.XD_Corn1,
		Entities.XD_Corn1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal3,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge1,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediGrassSandy = {
		Entities.XD_Corn1,
		Entities.XD_Corn1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge2,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	MediRockBright = {
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright6,
		Entities.XD_RockKhakiBright6,
		Entities.XD_RockKhakiBright7,
	},
	MediRockBrightCliff = {
		Entities.XD_CliffBright1,
		Entities.XD_CliffBright1,
		Entities.XD_CliffBright1,
		Entities.XD_CliffBright1,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright2,
		Entities.XD_CliffBright3,
		Entities.XD_CliffBright4,
		Entities.XD_CliffBright4,
		Entities.XD_CliffBright4,
		Entities.XD_CliffBright5,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright1,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright2,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright3,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright4,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright5,
		Entities.XD_RockKhakiBright6,
		Entities.XD_RockKhakiBright6,
		Entities.XD_RockKhakiBright7,
	},
	MediRockDark = {
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium6,
		Entities.XD_RockKhakiMedium6,
		Entities.XD_RockKhakiMedium7,
	},
	MediRockDarkCliff = {
		Entities.XD_Cliff1,
		Entities.XD_Cliff1,
		Entities.XD_Cliff1,
		Entities.XD_Cliff2,
		Entities.XD_Cliff2,
		Entities.XD_Cliff2,
		Entities.XD_Cliff2,
		Entities.XD_Cliff2,
		Entities.XD_CliffBright3,
		Entities.XD_CliffBright4,
		Entities.XD_CliffBright4,
		Entities.XD_CliffBright5,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium1,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium2,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium3,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium4,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium5,
		Entities.XD_RockKhakiMedium6,
		Entities.XD_RockKhakiMedium6,
		Entities.XD_RockKhakiMedium7,
	},
	MediSand = {
		Entities.XD_PlantDecal1,
		Entities.XD_PlantDecal2,
		Entities.XD_PlantDecal4,
		Entities.XD_PlantDecalLarge3,
		Entities.XD_PlantDecalLarge5,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium1,
		Entities.XD_RockMedium2,
	},
	
	--Moor
	MoorEarth = {
		Entities.XD_BushMoor1,
		Entities.XD_BushMoor2,
		Entities.XD_BushMoor3,
		Entities.XD_BushMoor4,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
	},
	MoorForest = {
		Entities.XD_BushMoor1,
		Entities.XD_BushMoor4,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
		Entities.XD_TreeMoor1,
		Entities.XD_TreeMoor2,
		Entities.XD_TreeMoor3,
		Entities.XD_TreeMoor4,
		Entities.XD_TreeMoor5,
		Entities.XD_TreeMoor6,
	},
	MoorForestBirch = {
		Entities.XD_BushMoor1,
		Entities.XD_BushMoor4,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
		Entities.XD_TreeMoor7,
		Entities.XD_TreeMoor8,
		Entities.XD_TreeMoor9,
	},
	MoorForestDead = {
		Entities.XD_BushMoor1,
		Entities.XD_BushMoor4,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
		Entities.XD_DeadTreeMoor1,
		Entities.XD_DeadTreeMoor2,
		Entities.XD_DeadTreeMoor3,
	},
	MoorGrass = {
		Entities.XD_BushMoor1,
		Entities.XD_BushMoor2,
		Entities.XD_BushMoor3,
		Entities.XD_BushMoor4,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
	},
	MoorRockDark = {
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor6,
		Entities.XD_RockDarkMoor6,
		Entities.XD_RockDarkMoor7,
	},
	MoorRockDarkCliff = {
		Entities.XD_CliffMoor1,
		Entities.XD_CliffMoor2,
		Entities.XD_CliffMoor3,
		Entities.XD_CliffMoor3,
		Entities.XD_CliffMoor3,
		Entities.XD_CliffMoor4,
		Entities.XD_CliffMoor4,
		Entities.XD_CliffMoor4,
		Entities.XD_CliffMoor4,
		Entities.XD_CliffMoor5,
		Entities.XD_CliffMoor5,
		Entities.XD_CliffMoor5,
		Entities.XD_CliffMoor5,
		Entities.XD_CliffMoor5,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor2,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor3,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor4,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor5,
		Entities.XD_RockDarkMoor6,
		Entities.XD_RockDarkMoor6,
		Entities.XD_RockDarkMoor7,
	},
	MoorRocky = {
		Entities.XD_PlantMoor1,
		Entities.XD_PlantMoor2,
		Entities.XD_PlantMoor3,
		Entities.XD_PlantMoor4,
		Entities.XD_PlantMoor5,
		Entities.XD_PlantMoor6,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor1,
		Entities.XD_RockDarkMoor2,
	},
	MoorFog = {
		Entities.XD_Fog1,
		Entities.XD_Fog1,
		Entities.XD_Fog2,
		Entities.XD_Fog2,
		Entities.XD_Fog2,
		Entities.XD_Fog3,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
		Entities.XD_ScriptEntity,
	},
	
	--Tideland
	TidelandGrass = {
		Entities.XD_Flower1,
		Entities.XD_Flower2,
		Entities.XD_Flower3,
		Entities.XD_Flower4,
		Entities.XD_Flower5,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical1,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
		Entities.XD_GreeneryVertical2,
	},
	TidelandMud = {
		Entities.XD_PlantDecalTideland1,
		Entities.XD_PlantDecalTideland2,
		Entities.XD_PlantDecalTideland3,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland2,
	},
	TidelandRockBright = {
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland1,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland2,
		Entities.XD_RockTideland3,
		Entities.XD_RockTideland3,
		Entities.XD_RockTideland3,
		Entities.XD_RockTideland3,
		Entities.XD_RockTideland3,
		Entities.XD_RockTideland4,
		Entities.XD_RockTideland4,
		Entities.XD_RockTideland4,
		Entities.XD_RockTideland4,
		Entities.XD_RockTideland5,
		Entities.XD_RockTideland5,
		Entities.XD_RockTideland5,
		Entities.XD_RockTideland6,
		Entities.XD_RockTideland6,
		Entities.XD_RockTideland7,
	},
	TidelandCliff = {
		Entities.XD_CliffTideland1,
		Entities.XD_CliffTideland2,
		Entities.XD_CliffTideland2,
		Entities.XD_CliffTideland3,
		Entities.XD_CliffTideland3,
		Entities.XD_CliffTideland3,
		Entities.XD_CliffTideland4,
		Entities.XD_CliffTideland4,
		Entities.XD_CliffTideland4,
		Entities.XD_CliffTideland4,
		Entities.XD_CliffTideland5,
		Entities.XD_CliffTideland5,
		Entities.XD_CliffTideland5,
		Entities.XD_CliffTideland5,
		Entities.XD_CliffTideland5,
	},
	TidelandSand = {
		Entities.XD_Driftwood1,
		Entities.XD_Driftwood2,
		Entities.XD_PlantDecalTideland1,
		Entities.XD_PlantDecalTideland2,
		Entities.XD_PlantDecalTideland3,
		Entities.XD_PlantDecalTideland4,
		Entities.XD_PlantDecalTideland4,
		Entities.XD_PlantDecalTideland4,
		Entities.XD_PlantDecalTideland5,
		Entities.XD_PlantDecalTideland5,
		Entities.XD_PlantDecalTideland5,
	},
 
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.LandscapeSetKeys = {
	{id = "Normal",		eval = RandomMapGenerator.SetupLandscapeNormal, representative = "Europa"},
	{id = "North",		eval = RandomMapGenerator.SetupLandscapeNorth, representative = "Skandinavien", func = RandomMapGenerator.SetupThresholdsNorth},
	{id = "Evelance",	eval = RandomMapGenerator.SetupLandscapeEvelance},
	{id = "Mediterran",	eval = RandomMapGenerator.SetupLandscapeMediterran},
	{id = "Moor",		eval = RandomMapGenerator.SetupLandscapeMoor},
	{id = "Tideland",	eval = RandomMapGenerator.SetupLandscapeTideland, representative = "Küstenland", func = RandomMapGenerator.SetupThresholdsTideland},
	{id = "Mordor",		eval = RandomMapGenerator.SetupLandscapeMordor, func = RandomMapGenerator.SetupThresholdsMordor},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RandomMapGenerator.LandscapeSets = {

	Normal = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.NormalRockDarkSmooth,
			HighMeadow	= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			HighForest	= RandomMapGenerator.TextureSets.NormalForestSmooth,
			Mountain	= RandomMapGenerator.TextureSets.NormalRockDarkSmooth,
			Hill		= RandomMapGenerator.TextureSets.NormalRocky,
			Forest		= RandomMapGenerator.TextureSets.NormalForestSmooth,
			Meadow		= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			Flatland	= RandomMapGenerator.TextureSets.NormalGrassBrightSmooth,
			Road		= RandomMapGenerator.TextureSets.NormalEarthBright,
			LowFlatland	= RandomMapGenerator.TextureSets.NormalGrassBrightSmooth,
			LowMeadow	= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			LowForest	= RandomMapGenerator.TextureSets.NormalForestSmooth,
			Coast		= RandomMapGenerator.TextureSets.NormalEarthAndRocks,
			Lake		= RandomMapGenerator.TextureSets.NormalEarthAndRocks,
			Sea			= RandomMapGenerator.TextureSets.NormalSeabedSmooth,
		},
		Water			= WaterTypes.WaterA,
		Entities = {
			HighMeadow	= RandomMapGenerator.EntitySets.NormalGrassDark,
			HighForest	= RandomMapGenerator.EntitySets.NormalForestMixed,
			Hill		= RandomMapGenerator.EntitySets.NormalRockDark,
			Forest		= RandomMapGenerator.EntitySets.NormalForestMixed,
			Meadow		= RandomMapGenerator.EntitySets.NormalGrassDark,
			Flatland	= RandomMapGenerator.EntitySets.NormalGrassBright,
			LowFlatland	= RandomMapGenerator.EntitySets.NormalGrassBright,
			LowMeadow	= RandomMapGenerator.EntitySets.NormalGrassDark,
			LowForest	= RandomMapGenerator.EntitySets.NormalForestBirchAndWillow,
		},
	},
	
	North = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.MiscSnow,
			HighMeadow	= RandomMapGenerator.TextureSets.NorthGrassYellowSmooth,
			HighForest	= RandomMapGenerator.TextureSets.NorthForest,
			Mountain	= RandomMapGenerator.TextureSets.NorthRockDarkSmooth,
			Hill		= RandomMapGenerator.TextureSets.NorthEarthBright,
			Forest		= RandomMapGenerator.TextureSets.NorthForest,
			Meadow		= RandomMapGenerator.TextureSets.NorthGrassDarkSmooth,
			Flatland	= RandomMapGenerator.TextureSets.NorthGrassBrightSmooth,
			Road		= RandomMapGenerator.TextureSets.NorthEarthDark,
			LowFlatland	= RandomMapGenerator.TextureSets.NorthGrassBrightSmooth,
			LowMeadow	= RandomMapGenerator.TextureSets.NorthGrassDarkSmooth,
			LowForest	= RandomMapGenerator.TextureSets.NorthForest,
			Coast		= RandomMapGenerator.TextureSets.NorthSand,
			Lake		= RandomMapGenerator.TextureSets.NorthSand,
			Sea			= RandomMapGenerator.TextureSets.NorthSeabedSmooth,
		},
		Water			= WaterTypes.Nordic_Swamp,
		Entities = {
			HighMeadow	= RandomMapGenerator.EntitySets.NorthGrassYellow,
			HighForest	= RandomMapGenerator.EntitySets.NorthForestPine,
			Hill		= RandomMapGenerator.EntitySets.NorthRockDark,
			Forest		= RandomMapGenerator.EntitySets.NorthForestFir,
			Meadow		= RandomMapGenerator.EntitySets.NorthGrass,
			Flatland	= RandomMapGenerator.EntitySets.NorthGrass,
			LowFlatland	= RandomMapGenerator.EntitySets.NorthGrass,
			LowMeadow	= RandomMapGenerator.EntitySets.NorthGrass,
			LowForest	= RandomMapGenerator.EntitySets.NorthForestBirch,
		},
	},
	
	Evelance = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
			HighMeadow	= RandomMapGenerator.TextureSets.EvelanceEarthDry,
			HighForest	= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Mountain	= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
			Hill		= RandomMapGenerator.TextureSets.EvelanceEarthDark,
			Forest		= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Meadow		= RandomMapGenerator.TextureSets.EvelanceEarthDry,
			Flatland	= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Road		= RandomMapGenerator.TextureSets.EvelanceEarthDry,
			LowFlatland	= RandomMapGenerator.TextureSets.EvelanceGrassErosive,
			LowMeadow	= RandomMapGenerator.TextureSets.EvelanceGrassErosive,
			LowForest	= RandomMapGenerator.TextureSets.EvelanceForest,
			Coast		= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			Lake		= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			Sea			= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
		},
		Water			= WaterTypes.Evelance_Swamp,
		Entities = {
			Mountain	= RandomMapGenerator.EntitySets.EvelanceRockDark,
			HighMeadow	= RandomMapGenerator.EntitySets.EvelanceEarth,
			HighForest	= RandomMapGenerator.EntitySets.EvelanceForestDead,
			Hill		= RandomMapGenerator.EntitySets.EvelanceEarth,
			Forest		= RandomMapGenerator.EntitySets.EvelanceForestDead,
			Meadow		= RandomMapGenerator.EntitySets.EvelanceEarth,
			Flatland	= RandomMapGenerator.EntitySets.EvelanceEarth,
			LowFlatland	= RandomMapGenerator.EntitySets.EvelanceGrass,
			LowMeadow	= RandomMapGenerator.EntitySets.EvelanceGrass,
			LowForest	= RandomMapGenerator.EntitySets.EvelanceForestFir,
		},
	},
	
	Mediterran = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.MediRockDark,
			HighMeadow	= RandomMapGenerator.TextureSets.MediGrassBright,
			HighForest	= RandomMapGenerator.TextureSets.MediForest,
			Mountain	= RandomMapGenerator.TextureSets.MediRockBright,
			Hill		= RandomMapGenerator.TextureSets.MediRockBright,
			Forest		= RandomMapGenerator.TextureSets.MediForest,
			Meadow		= RandomMapGenerator.TextureSets.MediGrassBright,
			Flatland	= RandomMapGenerator.TextureSets.MediGrassYellow,
			Road		= RandomMapGenerator.TextureSets.NormalEarthBright,
			LowFlatland	= RandomMapGenerator.TextureSets.MediGrassYellow,
			LowMeadow	= RandomMapGenerator.TextureSets.MediGrassBright,
			LowForest	= RandomMapGenerator.TextureSets.MediForest,
			Coast		= RandomMapGenerator.TextureSets.MediGrassSandy,
			Lake		= RandomMapGenerator.TextureSets.MediSand,
			Sea			= RandomMapGenerator.TextureSets.MediSand,
		},
		Water			= WaterTypes.Mediterran_River,
		Entities = {
			Pike		= RandomMapGenerator.EntitySets.MediRockDarkCliff,
			Mountain	= RandomMapGenerator.EntitySets.MediRockBrightCliff,
			HighMeadow	= RandomMapGenerator.EntitySets.MediForestPine,
			HighForest	= RandomMapGenerator.EntitySets.MediGrassBright,
			Hill		= RandomMapGenerator.EntitySets.MediRockBright,
			Forest		= RandomMapGenerator.EntitySets.MediForestPine,
			Meadow		= RandomMapGenerator.EntitySets.MediGrassBright,
			Flatland	= RandomMapGenerator.EntitySets.MediGrassYellow,
			LowFlatland	= RandomMapGenerator.EntitySets.MediGrassYellow,
			LowMeadow	= RandomMapGenerator.EntitySets.MediGrassBright,
			LowForest	= RandomMapGenerator.EntitySets.MediForestCypress,
		},
	},
	
	Tideland = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.TidelandRockBright,
			HighMeadow	= RandomMapGenerator.TextureSets.TidelandGrass,
			HighForest	= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			Mountain	= RandomMapGenerator.TextureSets.TidelandRockBright,
			Hill		= RandomMapGenerator.TextureSets.TidelandMud,
			Forest		= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			Meadow		= RandomMapGenerator.TextureSets.TidelandGrass,
			Flatland	= RandomMapGenerator.TextureSets.NormalGrassBrightSmooth,
			Road		= RandomMapGenerator.TextureSets.TidelandSand,
			LowFlatland	= RandomMapGenerator.TextureSets.NormalGrassBrightSmooth,
			LowMeadow	= RandomMapGenerator.TextureSets.TidelandGrass,
			LowForest	= RandomMapGenerator.TextureSets.NormalGrassDarkSmooth,
			Coast		= RandomMapGenerator.TextureSets.TidelandSand,
			Lake		= RandomMapGenerator.TextureSets.NormalSeabedSmooth,
			Sea			= RandomMapGenerator.TextureSets.NormalSeabedSmooth,
		},
		Water			= WaterTypes.WaterC,
		Entities = {
			Mountain	= RandomMapGenerator.EntitySets.TidelandRockBright,
			HighMeadow	= RandomMapGenerator.EntitySets.TidelandGrass,
			HighForest	= RandomMapGenerator.EntitySets.MediForestPine,
			Hill		= RandomMapGenerator.EntitySets.TidelandRockBright,
			Forest		= RandomMapGenerator.EntitySets.MediForestPine,
			Meadow		= RandomMapGenerator.EntitySets.TidelandGrass,
			Flatland	= RandomMapGenerator.EntitySets.NormalGrassDark,
			LowFlatland	= RandomMapGenerator.EntitySets.NormalGrassDark,
			LowMeadow	= RandomMapGenerator.EntitySets.TidelandGrass,
			LowForest	= RandomMapGenerator.EntitySets.NormalForestBirchAndWillow,
			Coast		= RandomMapGenerator.EntitySets.TidelandSand,
			--Sea			= RandomMapGenerator.EntitySets.TidelandCliff, -- too much
		},
	},
	
	Moor = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.MoorRockDark,
			HighMeadow	= RandomMapGenerator.TextureSets.MoorGrassDark,
			HighForest	= RandomMapGenerator.TextureSets.MoorEarth,
			Mountain	= RandomMapGenerator.TextureSets.MoorRockDarkVains,
			Hill		= RandomMapGenerator.TextureSets.MoorRocky,
			Forest		= RandomMapGenerator.TextureSets.MoorEarth,
			Meadow		= RandomMapGenerator.TextureSets.MoorGrassDark,
			Flatland	= RandomMapGenerator.TextureSets.MoorGrassBright,
			Road		= RandomMapGenerator.TextureSets.MoorEarth,
			LowFlatland	= RandomMapGenerator.TextureSets.MoorGrassBright,
			LowMeadow	= RandomMapGenerator.TextureSets.MoorGrassDark,
			LowForest	= RandomMapGenerator.TextureSets.MoorEarth,
			Coast		= RandomMapGenerator.TextureSets.MoorEarth,
			Lake		= RandomMapGenerator.TextureSets.MoorEarth,
			Sea			= RandomMapGenerator.TextureSets.MoorEarth,
		},
		Water			= WaterTypes.Moor,
		Entities = {
			Pike		= RandomMapGenerator.EntitySets.MoorRockDark,
			Mountain	= RandomMapGenerator.EntitySets.MoorRockDarkCliff,
			HighMeadow	= RandomMapGenerator.EntitySets.MoorGrass,
			HighForest	= RandomMapGenerator.EntitySets.MoorForest,
			Hill		= RandomMapGenerator.EntitySets.MoorRocky,
			Forest		= RandomMapGenerator.EntitySets.MoorForest,
			Meadow		= RandomMapGenerator.EntitySets.MoorFog,
			Flatland	= RandomMapGenerator.EntitySets.MoorGrass,
			LowFlatland	= RandomMapGenerator.EntitySets.MoorGrass,
			LowMeadow	= RandomMapGenerator.EntitySets.MoorFog,
			LowForest	= RandomMapGenerator.EntitySets.MoorForestBirch,
			Coast		= RandomMapGenerator.EntitySets.MoorFog,
			Lake		= RandomMapGenerator.EntitySets.MoorFog,
			Sea			= RandomMapGenerator.EntitySets.MoorFog,
		},
	},
	
	Mordor = {
		Textures = {
			Pike		= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
			HighMeadow	= RandomMapGenerator.TextureSets.EvelanceEarthDark,
			HighForest	= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Mountain	= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
			Hill		= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Forest		= RandomMapGenerator.TextureSets.EvelanceEarthBones,
			Meadow		= RandomMapGenerator.TextureSets.EvelanceEarthDark,
			Flatland	= RandomMapGenerator.TextureSets.EvelanceEarthDark,
			Road		= RandomMapGenerator.TextureSets.MiscRoad,
			LowFlatland	= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			LowMeadow	= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			LowForest	= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			Coast		= RandomMapGenerator.TextureSets.EvelanceEarthRocky,
			Lake		= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
			Sea			= RandomMapGenerator.TextureSets.EvelanceRockDarkSmooth,
		},
		Water			= WaterTypes.Evelance_Swamp,
		Entities = {
			Mountain	= RandomMapGenerator.EntitySets.EvelanceRockDark,
			HighMeadow	= RandomMapGenerator.EntitySets.EvelanceEarth,
			HighForest	= RandomMapGenerator.EntitySets.EvelanceForestDead,
			Hill		= RandomMapGenerator.EntitySets.EvelanceEarth,
			Forest		= RandomMapGenerator.EntitySets.EvelanceForestDead,
			Meadow		= RandomMapGenerator.EntitySets.EvelanceEarth,
			Flatland	= RandomMapGenerator.EntitySets.EvelanceEarth,
			LowFlatland	= RandomMapGenerator.EntitySets.EvelanceEarth,
			LowMeadow	= RandomMapGenerator.EntitySets.EvelanceEarth,
			LowForest	= RandomMapGenerator.EntitySets.EvelanceForestDead,
			Coast		= RandomMapGenerator.EntitySets.EvelanceEarth,
			Lake		= RandomMapGenerator.EntitySets.MoorFog,
			Sea			= RandomMapGenerator.EntitySets.MoorFog,
		},
		VertexColors = {
			Mountain	= RandomMapGenerator.VertexColorSets.MiscDark,
			Hill		= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Forest		= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Meadow		= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Flatland	= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Road		= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			LowFlatland	= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			LowMeadow	= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			LowForest	= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Coast		= RandomMapGenerator.VertexColorSets.MiscSlightlyDark,
			Lake		= RandomMapGenerator.VertexColorSets.MordorLava,
			Sea			= RandomMapGenerator.VertexColorSets.MordorLava,
		},
	},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RandomMapGenerator.TeamBorderTypes = {
	{id = "none", representative = "keine", gate = 0},
	{id = "fence", representative = "Zaun", gate = 1},
	{id = "river", representative = "Flüsse", gate = 0},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RandomMapGenerator.GateLayouts = {
	{id = "player", representative = "je Spieler"},
	{id = "team", representative = "je Team"},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RandomMapGenerator.GateSizes = {
	{id = 2.25, representative = "sehr klein"},
	{id = 2.5, representative = "klein"},
	{id = 3, representative = "moderat"},
	{id = 4, representative = "groß"},
	{id = 6, representative = "sehr groß"},
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.BlockingTypes = {
	None = 0,
	River = 1,
	Road = 2,
	Mountain = 4,
	Structure = 8,
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--[[
Structure = {
 Placement = {
  AbsolutX,
  AbsolutY, -- excl.
  RelativX,
  RelativY, -- excl.
  AreaMax, -- excl.
  = Number
  = {x, y}
  = {x1, y1, x2, y2}
  AreaMin, -- excl.
  = Number
  = {x, y}
  = {x1, y1, x2, y2}
  NoiseMin,
  NoiseMax,
  Asymetric,
  Blocking,
 },
 Data = {
  Entities = {
   [1] = {
    Type,     -- type or table of types
    RelativX, -- offset
    RelativY,
    Grid,     -- snap position
    Rotation, -- -1 = random
    Angle,    -- snap rotation
    Scale,
    Ambient,
    Volume,
    Resource, -- amount
    Player,
    Name,
    Health,
    Soldiers, -- amount
   },
  },
  TerrainHeights = {
   [x] = {
    [y] = Number,
   },
   Area, -- excl.
   = Number
   = {x, y}
   = {x1, y1, x2, y2}
  },
  TerrainTextures = {
   [1] = {
    Area,
    -- excl.
    = Number
    = {x, y}
    = {x1, y1, x2, y2},
    TextureList = RandomMapGenerator.TextureSets.Name or TerrainTypes.Name, -- excl.
    BiomeKey = String,
   },
  },
  Water = {
   [1] = {
    Area = {x1, y1, x2, y2},
    Height = Number,
    Type = WaterTypes.Name,
   },
  },
  RemoveEntities, -- excl.
  = Number
  = {x, y}
  = {x1, y1, x2, y2}
 },
 Childs = {
  -- more structures
 },
}
]]
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
	--RandomMapGenerator.InitRules();XGUIEng.ShowWidget("EMSPagesUnits", 0);XGUIEng.ShowWidget("EMSPagesRMG", 1);
	--XGUIEng.ShowWidget("EMSPagesUnits", 1);XGUIEng.ShowWidget("EMSPagesRMG", 0);
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.AddToThreshold(_val)
	
	if not EMS.CanChangeRules then
		return;
	end
	RandomMapGenerator.AddToLowThreshold(_val)
	RandomMapGenerator.AddToHighThreshold(_val)
	
	EMS.RD.Rules.RMG_ThresholdRoad:SetValue(EMS.RD.Rules.RMG_ThresholdRoad:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdRoad", EMS.RD.Rules.RMG_ThresholdRoad:GetValue());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AddToHighThreshold(_val)

	if not EMS.CanChangeRules then
		return;
	end
	EMS.RD.Rules.RMG_ThresholdPike:SetValue(EMS.RD.Rules.RMG_ThresholdPike:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdPike", EMS.RD.Rules.RMG_ThresholdPike:GetValue());
	EMS.RD.Rules.RMG_ThresholdMountain:SetValue(EMS.RD.Rules.RMG_ThresholdMountain:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdMountain", EMS.RD.Rules.RMG_ThresholdMountain:GetValue());
	EMS.RD.Rules.RMG_ThresholdHill:SetValue(EMS.RD.Rules.RMG_ThresholdHill:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdHill", EMS.RD.Rules.RMG_ThresholdHill:GetValue());
	EMS.RD.Rules.RMG_ThresholdForest:SetValue(EMS.RD.Rules.RMG_ThresholdForest:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdForest", EMS.RD.Rules.RMG_ThresholdForest:GetValue());
	EMS.RD.Rules.RMG_ThresholdMeadow:SetValue(EMS.RD.Rules.RMG_ThresholdMeadow:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdMeadow", EMS.RD.Rules.RMG_ThresholdMeadow:GetValue());
	EMS.RD.Rules.RMG_ThresholdFlatland:SetValue(EMS.RD.Rules.RMG_ThresholdFlatland:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdFlatland", EMS.RD.Rules.RMG_ThresholdFlatland:GetValue());
	
	if EMS.RD.Rules.RMG_ThresholdPlateau:GetValue() < 1000 then
		EMS.RD.Rules.RMG_ThresholdHighMeadow:SetValue(EMS.RD.Rules.RMG_ThresholdHighMeadow:GetValue() + _val)
		EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdHighMeadow", EMS.RD.Rules.RMG_ThresholdHighMeadow:GetValue());
		EMS.RD.Rules.RMG_ThresholdHighForest:SetValue(EMS.RD.Rules.RMG_ThresholdHighForest:GetValue() + _val)
		EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdHighForest", EMS.RD.Rules.RMG_ThresholdHighForest:GetValue());
		EMS.RD.Rules.RMG_ThresholdPlateau:SetValue(EMS.RD.Rules.RMG_ThresholdPlateau:GetValue() + _val)
		EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdPlateau", EMS.RD.Rules.RMG_ThresholdPlateau:GetValue());
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AddToLowThreshold(_val)

	if not EMS.CanChangeRules then
		return;
	end
	EMS.RD.Rules.RMG_ThresholdSea:SetValue(EMS.RD.Rules.RMG_ThresholdSea:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdSea", EMS.RD.Rules.RMG_ThresholdSea:GetValue());
	EMS.RD.Rules.RMG_ThresholdLake:SetValue(EMS.RD.Rules.RMG_ThresholdLake:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdLake", EMS.RD.Rules.RMG_ThresholdLake:GetValue());
	EMS.RD.Rules.RMG_ThresholdCoast:SetValue(EMS.RD.Rules.RMG_ThresholdCoast:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdCoast", EMS.RD.Rules.RMG_ThresholdCoast:GetValue());
	EMS.RD.Rules.RMG_ThresholdLowForest:SetValue(EMS.RD.Rules.RMG_ThresholdLowForest:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdLowForest", EMS.RD.Rules.RMG_ThresholdLowForest:GetValue());
	EMS.RD.Rules.RMG_ThresholdLowMeadow:SetValue(EMS.RD.Rules.RMG_ThresholdLowMeadow:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdLowMeadow", EMS.RD.Rules.RMG_ThresholdLowMeadow:GetValue());
	EMS.RD.Rules.RMG_ThresholdLowFlatland:SetValue(EMS.RD.Rules.RMG_ThresholdLowFlatland:GetValue() + _val)
	EMS.GL.TrySync("EMS.GL.SetValueSynced", "RMG_ThresholdLowFlatland", EMS.RD.Rules.RMG_ThresholdLowFlatland:GetValue());
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.GetRandomSeed(_value)
	
	_value = _value or 0
	local seed = _value + 9876543210 + Game.RealTimeGetMs() + Game.RealTimeGetMs() * 100000
	
	while seed >= 1000000000 do
		seed = seed - 1000000000
	end
	
	return seed
	--EMS.GL.SetValueSynced("RMG_Seed", value)
	--oder einfach math.randomseed?
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.InitGenerationData()
	
	RandomMapGenerator.GenerationData = { DebugMode = false, }
	
	Score.Player[0] = {buildings=0, all=0}
	
	-- DBG only --
	if RandomMapGenerator.GenerationData.DebugMode then
		
		Game.GameTimeSetFactor(10)
		Tools.ExploreArea(-1, -1, 900);
		Camera.ZoomSetFactorMax(10);
		Camera.ZoomSetFactor(2);
		GUI.MiniMap_SetRenderFogOfWar(0);
		Display.SetRenderFogOfWar(0);
		Display.SetRenderFog(0);
		Display.SetRenderShadows(0);
		Display.SetRenderLandscapeFogOfWar(0);
		Display.SetRenderInvisibleObjects(1);
		
		--for k,v in pairs(Technologies) do ResearchTechnology(v) end
	end
	-- DBG only --
	
	
	local seed = EMS.RD.Rules.RMG_Seed:GetValue()

	RandomMapGenerator.GenerationData.Seed = seed,
	SimplexNoise.seedP(seed)
	
	if XNetwork.Manager_DoesExist() == 0 then
		math.randomseed(seed) --desynct auf Simis Server
		gvRandomseed = true -- prevent GetRandom from reseeding
	end
	
	RandomMapGenerator.GenerationData.TeamBorderType		= EMS.RD.Rules.RMG_GenerateRivers:GetValue()
	RandomMapGenerator.GenerationData.GateLayout			= EMS.RD.Rules.RMG_GateLayout:GetValue()
	RandomMapGenerator.GenerationData.GateSize				= RandomMapGenerator.GateSizes[EMS.RD.Rules.RMG_GateSize:GetValue()].id
	RandomMapGenerator.GenerationData.GenerateRoads 		= Num2Bool(EMS.RD.Rules.RMG_GenerateRoads:GetValue())
	
	RandomMapGenerator.GenerationData.LandscapeSetKey		= RandomMapGenerator.LandscapeSetKeys[EMS.RD.Rules.RMG_LandscapeSet:GetValue()].id
	RandomMapGenerator.GenerationData.MirrorMap				= Num2Bool(EMS.RD.Rules.RMG_MirrorMap:GetValue())
	RandomMapGenerator.GenerationData.RandomPlayerPosition	= Num2Bool(EMS.RD.Rules.RMG_RandomPlayerPosition:GetValue())
	
	RandomMapGenerator.GenerationData.TerrainBaseHeight		= EMS.RD.Rules.RMG_TerrainBaseHeight:GetValue()
	RandomMapGenerator.GenerationData.WaterBaseHeight		= EMS.RD.Rules.RMG_WaterBaseHeight:GetValue()
	RandomMapGenerator.GenerationData.NoiseFactorZ			= EMS.RD.Rules.RMG_NoiseFactorZ:GetValue() * 28
	RandomMapGenerator.GenerationData.NoiseFactorXY			= (EMS.RD.Rules.RMG_NoiseFactorXY:GetValue() * 0.5 + 50) / 12500 -- otherwise it is way to sensitiv
	RandomMapGenerator.GenerationData.ForestDensity			= EMS.RD.Rules.RMG_ForestDensity:GetValue() / 100
	
	RandomMapGenerator.GenerationData.ThresholdPike			= EMS.RD.Rules.RMG_ThresholdPike:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdMountain		= EMS.RD.Rules.RMG_ThresholdMountain:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdHill			= EMS.RD.Rules.RMG_ThresholdHill:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdSea			= EMS.RD.Rules.RMG_ThresholdSea:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdLake			= EMS.RD.Rules.RMG_ThresholdLake:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdCoast		= EMS.RD.Rules.RMG_ThresholdCoast:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdForest		= EMS.RD.Rules.RMG_ThresholdForest:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdMeadow		= EMS.RD.Rules.RMG_ThresholdMeadow:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdFlatland		= EMS.RD.Rules.RMG_ThresholdFlatland:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdLowForest	= EMS.RD.Rules.RMG_ThresholdLowForest:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdLowMeadow	= EMS.RD.Rules.RMG_ThresholdLowMeadow:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdLowFlatland	= EMS.RD.Rules.RMG_ThresholdLowFlatland:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdRoad			= EMS.RD.Rules.RMG_ThresholdRoad:GetValue() / 1000
	
	RandomMapGenerator.GenerationData.ThresholdHighMeadow	= EMS.RD.Rules.RMG_ThresholdHighMeadow:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdHighForest	= EMS.RD.Rules.RMG_ThresholdHighForest:GetValue() / 1000
	RandomMapGenerator.GenerationData.ThresholdPlateau		= EMS.RD.Rules.RMG_ThresholdPlateau:GetValue() / 1000
	
	local amountClayPit		= EMS.RD.Rules.RMG_AmountClayPit:GetValue()
	local contentClayPit	= EMS.RD.Rules.RMG_ContentClayPit:GetValue()
	local amountClayPile	= EMS.RD.Rules.RMG_AmountClayPile:GetValue()
	local contentClayPile	= EMS.RD.Rules.RMG_ContentClayPile:GetValue()
	local amountStonePit	= EMS.RD.Rules.RMG_AmountStonePit:GetValue()
	local contentStonePit	= EMS.RD.Rules.RMG_ContentStonePit:GetValue()
	local amountStonePile	= EMS.RD.Rules.RMG_AmountStonePile:GetValue()
	local contentStonePile	= EMS.RD.Rules.RMG_ContentStonePile:GetValue()
	local amountIronPit		= EMS.RD.Rules.RMG_AmountIronPit:GetValue()
	local contentIronPit	= EMS.RD.Rules.RMG_ContentIronPit:GetValue()
	local amountIronPile	= EMS.RD.Rules.RMG_AmountIronPile:GetValue()
	local contentIronPile	= EMS.RD.Rules.RMG_ContentIronPile:GetValue()
	local amountSulfurPit	= EMS.RD.Rules.RMG_AmountSulfurPit:GetValue()
	local contentSulfurPit	= EMS.RD.Rules.RMG_ContentSulfurPit:GetValue()
	local amountSulfurPile	= EMS.RD.Rules.RMG_AmountSulfurPile:GetValue()
	local contentSulfurPile	= EMS.RD.Rules.RMG_ContentSulfurPile:GetValue()
	local amountWoodPile	= EMS.RD.Rules.RMG_AmountWoodPile:GetValue()
	local contentWoodPile	= EMS.RD.Rules.RMG_ContentWoodPile:GetValue()
	local amountVillageCenter = EMS.RD.Rules.RMG_AmountVC:GetValue()
	
	local exploreres = EMS.RD.Rules.RMG_ShowResources:GetValue()
	local explorevc = EMS.RD.Rules.RMG_ShowVillageCenters:GetValue()
	
	-- Node = { x, y, noise, height, blocking }
	-- TODO: Blocking = { 1 = Terrain, 2 = Water, 4 = Entity, 8 = River, 16 = Road }
	RandomMapGenerator.GenerationData.TerrainNodes = {}
 	RandomMapGenerator.GenerationData.Entities = {}

	-- get number of players and number of teams
	local nplayers, players, nteams = RandomMapGenerator.UnpackPlayerConfig()
	
	if EMS.RD.Rules.RMG_PlayerConfig:GetValue() == 0 then
		nplayers, players, nteams = RandomMapGenerator.GetPlayersAndTeams()
	end
	
	RandomMapGenerator.GenerationData.Players = {}
	RandomMapGenerator.GenerationData.NumberOfPlayers = nplayers
	RandomMapGenerator.GenerationData.NumberOfTeams = nteams
 
	--[[for t = 1, nteams do
		for p = 1, nplayers do
			if players[p].team == teams[t] then
				table.insert(RandomMapGenerator.GenerationData.Players, {id = players[p].id, team = teams[t]})
			end
		end
	end]]
	
	for p = 1, nplayers do
		table.insert(RandomMapGenerator.GenerationData.Players, {id = players[p].id, team = players[p].team, ishuman = players[p].ishuman})
	end
	
	RandomMapGenerator.GenerationData.PlayerRadian = math.rad(360 / RandomMapGenerator.GenerationData.NumberOfPlayers) -- 180° = pi
 
	-- generate no rivers if not enough teams
	if nteams <= 1 then
		RandomMapGenerator.GenerationData.TeamBorderType = 1 -- none
	end
 
	-- generate no roads if not enough players
	if nplayers <= 1 then
		RandomMapGenerator.GenerationData.GenerateRoads = false
	end
	
	-- build structure tables
	local noiseMin = RandomMapGenerator.GenerationData.ThresholdLowFlatland
	local noiseMax = RandomMapGenerator.GenerationData.ThresholdFlatland
	
	if RandomMapGenerator.GenerationData.ThresholdPlateau < 1.0 then
		noiseMax = RandomMapGenerator.GenerationData.ThresholdPlateau
	end
	
	RandomMapGenerator.StructureSets = {
		ClayPit = {
			Entities = {{Type = Entities.XD_ClayPit1, Resource = contentClayPit,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 6, Name = "white"},},
			Blocking = 12,
			TerrainHeights = {
				Area = 18,
				[-6]={[-6]=  -3,[-5]=  -14,[-4]=  -24,[-3]=  -32,[-2]=  -34,[-1]=  -33,[0]=  -35,[1]=  -40,[2]=  -43,[3]=  -34,[4]=  -21,[5]=  -9},
				[-5]={[-6]= -13,[-5]=  -29,[-4]=  -47,[-3]=  -62,[-2]=  -72,[-1]=  -76,[0]=  -88,[1]=  -95,[2]=  -90,[3]=  -64,[4]=  -33,[5]= -11},
				[-4]={[-6]= -23,[-5]=  -63,[-4]= -102,[-3]= -135,[-2]= -162,[-1]= -183,[0]= -201,[1]= -204,[2]= -182,[3]= -125,[4]=  -62,[5]= -18},
				[-3]={[-6]= -45,[-5]= -105,[-4]= -180,[-3]= -257,[-2]= -294,[-1]= -377,[0]= -377,[1]= -377,[2]= -292,[3]= -214,[4]=  -90,[5]= -28,[6]=  -1},
				[-2]={[-6]= -59,[-5]= -140,[-4]= -249,[-3]= -346,[-2]= -372,[-1]= -377,[0]= -377,[1]= -377,[2]= -360,[3]= -269,[4]= -105,[5]= -26,[6]=  -6},
				[-1]={[-6]= -58,[-5]= -150,[-4]= -263,[-3]= -355,[-2]= -377,[-1]= -377,[0]= -377,[1]= -377,[2]= -361,[3]= -268,[4]= -125,[5]= -39,[6]=  -9},
				[ 0]={[-6]= -58,[-5]= -150,[-4]= -266,[-3]= -358,[-2]= -377,[-1]= -377,[0]= -377,[1]= -377,[2]= -363,[3]= -266,[4]= -134,[5]= -46,[6]= -14},
				[ 1]={[-6]= -58,[-5]= -145,[-4]= -263,[-3]= -360,[-2]= -377,[-1]= -377,[0]= -377,[1]= -377,[2]= -357,[3]= -265,[4]= -140,[5]= -52,[6]= -14},
				[ 2]={[-6]= -50,[-5]= -130,[-4]= -254,[-3]= -358,[-2]= -377,[-1]= -377,[0]= -377,[1]= -377,[2]= -363,[3]= -267,[4]= -137,[5]= -52,[6]= -17},
				[ 3]={[-6]= -43,[-5]= -115,[-4]= -226,[-3]= -314,[-2]= -353,[-1]= -355,[0]= -351,[1]= -345,[2]= -303,[3]= -232,[4]= -132,[5]= -56,[6]= -16},
				[ 4]={[-6]= -38,[-5]=  -92,[-4]= -167,[-3]= -233,[-2]= -271,[-1]= -267,[0]= -262,[1]= -249,[2]= -218,[3]= -165,[4]=  -97,[5]= -40,[6]= -12},
				[ 5]={[-6]= -21,[-5]=  -51,[-4]=  -95,[-3]= -124,[-2]= -125,[-1]= -131,[0]= -133,[1]= -127,[2]= -111,[3]=  -82,[4]=  -49,[5]= -20,[6]=  -6},
				[ 6]={[-6]=  -9,[-5]=  -16,[-4]=  -32,[-3]=  -43,[-2]=  -39,[-1]=  -44,[0]=  -47,[1]=  -47,[2]=  -39,[3]=  -28,[4]=  -18,[5]= -10,[6]=  -2},
				[ 7]={[-6]=  -2,[-5]=   -2,[-4]=   -3,[-3]=   -5,[-2]=   -5,[-1]=   -8,[0]=   -9,[1]=  -12,[2]=   -6,[3]=   -4,[4]=   -3,[5]=  -1},
			},
			TerrainTextures = {
				TextureList = RandomMapGenerator.TextureSets.NormalEarthDark,
				Area = 11,
			},
			Water = {}, -- empty Water table uses preset for resource pits -> lowers water around pit - see CreateStructure(...)
		},
		StonePit = {
			Entities = {{Type = Entities.XD_StonePit1, Resource = contentStonePit,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 5, Name = "white"},},
			Blocking = 12,
			TerrainHeights = {
				Area = 18,
				[0] = {[0] = -89, [1] = -103,[-1] = -71,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -112,[-2] = -54,[-20] = 0,[20] = 480,[3] = -126,[-3] = -45,[4] = -126,[-4] = -39,[5] = -110,[-5] = -17,[6] = 17,[-6] = -2,[-7] = 0,[7] = 400,[-8] = 0,[8] = 452,[-9] = 0,[9] = 480,},
				[1] = {[0] = -104,[1] = -107,[-1] = -96,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -117,[-2] = -92,[-20] = 0,[20] = 480,[3] = -126,[-3] = -126,[4] = -126,[-4] = -71,[-5] = -31,[5] = -51,[6] = 162,[-6] = -4,[-7] = -1,[7] = 459,[-8] = 0,[8] = 465,[-9] = 0,[9] = 480,},
				[-1] = {[0] = -60,[-1] = -45,[1] = -82,[-10] = 0,[10] = 472,[-11] = 0,[11] = 475,[-12] = 0,[12] = 477,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -161,[-2] = -26,[-20] = 0,[20] = 480,[3] = -131,[-3] = -18,[4] = -126,[-4] = -14,[-5] = 0,[5] = -126,[-6] = 0,[6] = 46,[-7] = 0,[7] = 321,[-8] = 0,[8] = 409,[-9] = 0,[9] = 460,},
				[-10] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 11,[-11] = 0,[11] = 45,[-12] = 0,[12] = 101,[-13] = 0,[13] = 180,[-14] = 0,[14] = 261,[-15] = 0,[15] = 339,[-16] = 0,[16] = 398,[-17] = 0,[17] = 438,[-18] = 0,[18] = 447,[-19] = 0,[19] = 422,[2] = 0,[-2] = 0,[-20] = 0,[20] = 329,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[10] = {[0] = 480,[-1] = 479,[1] = 480,[-10] = 27,[10] = 480,[-11] = 3,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[-3] = 447,[3] = 480,[-4] = 426,[4] = 480,[-5] = 395,[5] = 480,[-6] = 303,[6] = 480,[-7] = 218,[7] = 480,[-8] = 141,[8] = 480,[9] = 480,[-9] = 76,},
				[-11] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 1,[-11] = 0,[11] = 23,[-12] = 0,[12] = 66,[-13] = 0,[13] = 129,[-14] = 0,[14] = 211,[-15] = 0,[15] = 290,[-16] = 0,[16] = 357,[-17] = 0,[17] = 405,[-18] = 0,[18] = 421,[-19] = 0,[19] = 401,[2] = 0,[-2] = 0,[-20] = 0,[20] = 319,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[11] = {[0] = 480,[1] = 480,[-1] = 480,[10] = 480,[-10] = 55,[11] = 480,[-11] = 6,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[-3] = 468,[3] = 480,[-4] = 457,[4] = 480,[-5] = 439,[5] = 480,[-6] = 360,[6] = 480,[-7] = 284,[7] = 480,[-8] = 210,[8] = 480,[-9] = 130,[9] = 480,},
				[-12] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[-11] = 0,[11] = 8,[-12] = 0,[12] = 37,[-13] = 0,[13] = 87,[-14] = 0,[14] = 156,[-15] = 0,[15] = 235,[-16] = 0,[16] = 307,[-17] = 0,[17] = 358,[-18] = 0,[18] = 381,[-19] = 0,[19] = 366,[2] = 0,[-2] = 0,[-20] = 0,[20] = 284,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[12] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 124,[10] = 480,[11] = 480,[-11] = 57,[-12] = 25,[12] = 480,[13] = 480,[-13] = 7,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[-3] = 473,[3] = 480,[-4] = 467,[4] = 480,[-5] = 461,[5] = 480,[-6] = 414,[6] = 480,[-7] = 364,[7] = 480,[-8] = 311,[8] = 480,[-9] = 213,[9] = 480,},
				[-13] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[-12] = 0,[12] = 17,[-13] = 0,[13] = 52,[-14] = 0,[14] = 106,[-15] = 0,[15] = 177,[-16] = 0,[16] = 249,[-17] = 0,[17] = 312,[-18] = 0,[18] = 343,[-19] = 0,[19] = 328,[2] = 0,[-2] = 0,[-20] = 0,[20] = 239,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[13] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 203,[10] = 480,[-11] = 128,[11] = 480,[12] = 480,[-12] = 76,[-13] = 38,[13] = 480,[-14] = 15,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[-3] = 477,[3] = 480,[-4] = 474,[4] = 480,[-5] = 474,[5] = 480,[-6] = 451,[6] = 480,[-7] = 424,[7] = 480,[-8] = 392,[8] = 480,[-9] = 294,[9] = 480,},
				[-14] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[-12] = 0,[12] = 3,[-13] = 0,[13] = 26,[-14] = 0,[14] = 66,[-15] = 0,[15] = 125,[-16] = 0,[16] = 201,[-17] = 0,[17] = 279,[-18] = 0,[18] = 319,[-19] = 0,[19] = 320,[2] = 0,[-2] = 0,[-20] = 0,[20] = 275,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[14] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 292,[10] = 480,[-11] = 221,[11] = 480,[-12] = 166,[12] = 480,[-13] = 115,[13] = 480,[14] = 480,[-14] = 80,[-15] = 44,[15] = 480,[-16] = 19,[16] = 480,[17] = 480,[-17] = 5,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[-6] = 469,[6] = 480,[-7] = 465,[7] = 480,[-8] = 455,[8] = 480,[-9] = 375,[9] = 480,},
				[-15] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[-13] = 0,[13] = 7,[-14] = 0,[14] = 34,[-15] = 0,[15] = 81,[-16] = 0,[16] = 147,[-17] = 0,[17] = 234,[-18] = 0,[18] = 291,[-19] = 0,[19] = 292,[2] = 0,[-2] = 0,[-20] = 0,[20] = 238,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[15] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 373,[10] = 480,[-11] = 328,[11] = 480,[-12] = 285,[12] = 480,[-13] = 232,[13] = 480,[-14] = 179,[14] = 480,[-15] = 124,[15] = 480,[16] = 480,[-16] = 71,[-17] = 29,[17] = 480,[18] = 480,[-18] = 9,[-19] = 0,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[-9] = 434,[9] = 480,},
				[-16] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[13] = 0,[-13] = 0,[-14] = 0,[14] = 10,[-15] = 0,[15] = 44,[-16] = 0,[16] = 101,[-17] = 0,[17] = 175,[-18] = 0,[18] = 236,[-19] = 0,[19] = 242,[2] = 0,[-2] = 0,[-20] = 0,[20] = 197,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[16] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 435,[10] = 480,[-11] = 412,[11] = 480,[-12] = 389,[12] = 480,[-13] = 347,[13] = 480,[-14] = 291,[14] = 480,[-15] = 231,[15] = 480,[-16] = 151,[16] = 480,[17] = 480,[-17] = 80,[-18] = 33,[18] = 480,[-19] = 12,[19] = 480,[2] = 480,[-2] = 480,[-20] = 0,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[-9] = 463,[9] = 480,},
				[-17] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[13] = 0,[-13] = 0,[-14] = 0,[14] = 1,[-15] = 0,[15] = 23,[-16] = 0,[16] = 66,[-17] = 0,[17] = 130,[-18] = 0,[18] = 186,[-19] = 0,[19] = 202,[2] = 0,[-2] = 0,[-20] = 0,[20] = 175,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[17] = {[0] = 480,[1] = 480,[-1] = 480,[-10] = 471,[10] = 480,[-11] = 467,[11] = 480,[-12] = 462,[12] = 480,[-13] = 432,[13] = 480,[-14] = 382,[14] = 480,[-15] = 329,[15] = 480,[-16] = 252,[16] = 480,[-17] = 160,[17] = 480,[18] = 480,[-18] = 89,[-19] = 41,[19] = 480,[2] = 480,[-2] = 480,[-20] = 13,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[9] = 480,[-9] = 480,},
				[-18] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[13] = 0,[-13] = 0,[14] = 0,[-14] = 0,[-15] = 0,[15] = 7,[-16] = 0,[16] = 36,[-17] = 0,[17] = 89,[-18] = 0,[18] = 149,[-19] = 0,[19] = 185,[2] = 0,[-2] = 0,[-20] = 0,[20] = 161,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[18] = {[0] = 480,[1] = 480,[-1] = 480,[10] = 480,[-10] = 480,[11] = 480,[-11] = 480,[12] = 480,[-12] = 480,[-13] = 467,[13] = 480,[-14] = 433,[14] = 480,[-15] = 399,[15] = 480,[-16] = 343,[16] = 480,[-17] = 265,[17] = 480,[-18] = 190,[18] = 480,[-19] = 115,[19] = 480,[2] = 480,[-2] = 480,[20] = 480,[-20] = 51,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[9] = 480,[-9] = 480,},
				[-19] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[13] = 0,[-13] = 0,[14] = 0,[-14] = 0,[15] = 0,[-15] = 0,[-16] = 0,[16] = 9,[-17] = 0,[17] = 45,[-18] = 0,[18] = 131,[-19] = 0,[19] = 228,[2] = 0,[-2] = 0,[-20] = 0,[20] = 190,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[19] = {[0] = 480,[1] = 480,[-1] = 480,[10] = 480,[-10] = 480,[11] = 480,[-11] = 480,[12] = 480,[-12] = 480,[-13] = 474,[13] = 480,[-14] = 451,[14] = 480,[-15] = 432,[15] = 480,[-16] = 403,[16] = 480,[-17] = 356,[17] = 480,[-18] = 298,[18] = 480,[-19] = 224,[19] = 480,[2] = 480,[-2] = 480,[-20] = 111,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[9] = 480,[-9] = 480,},
				[2] = {[0] = -104,[1] = -112,[-1] = -117,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -126,[-2] = -126,[-20] = 0,[20] = 480,[3] = -126,[-3] = -126,[4] = -107,[-4] = -109,[-5] = -20,[5] = 30,[-6] = -3,[6] = 326,[-7] = -1,[7] = 478,[-8] = 0,[8] = 480,[-9] = 0,[9] = 480,},
				[-2] = {[0] = -39,[-1] = -22,[1] = -64,[-10] = 0,[10] = 459,[-11] = 0,[11] = 472,[-12] = 0,[12] = 475,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -116,[-2] = -9,[-20] = 0,[20] = 480,[3] = -141,[-3] = -4,[-4] = -1,[4] = -126,[-5] = 0,[5] = -126,[-6] = 0,[6] = 50,[-7] = 0,[7] = 246,[-8] = 0,[8] = 345,[-9] = 0,[9] = 425,},
				[-20] = {[0] = 0,[1] = 0,[-1] = 0,[10] = 0,[-10] = 0,[11] = 0,[-11] = 0,[12] = 0,[-12] = 0,[13] = 0,[-13] = 0,[14] = 0,[-14] = 0,[15] = 0,[-15] = 0,[-16] = 0,[16] = 1,[-17] = 0,[17] = 23,[-18] = 0,[18] = 87,[-19] = 0,[19] = 164,[2] = 0,[-2] = 0,[-20] = 0,[20] = 140,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[9] = 0,[-9] = 0,},
				[20] = {[0] = 480,[1] = 480,[-1] = 480,[10] = 480,[-10] = 480,[11] = 480,[-11] = 480,[12] = 480,[-12] = 480,[13] = 480,[-13] = 480,[-14] = 374,[14] = 480,[-15] = 366,[15] = 480,[-16] = 355,[16] = 480,[-17] = 318,[17] = 480,[-18] = 265,[18] = 480,[-19] = 220,[19] = 480,[2] = 480,[-2] = 480,[-20] = 149,[20] = 480,[3] = 480,[-3] = 480,[4] = 480,[-4] = 480,[5] = 480,[-5] = 480,[6] = 480,[-6] = 480,[7] = 480,[-7] = 480,[8] = 480,[-8] = 480,[9] = 480,[-9] = 480,},
				[-3] = {[0] = -11,[1] = -33,[-1] = -6,[-10] = 0,[10] = 426,[-11] = 0,[11] = 462,[-12] = 0,[12] = 471,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = -3,[2] = -76,[-20] = 0,[20] = 480,[-3] = 0,[3] = -97,[-4] = 0,[4] = -101,[-5] = 0,[5] = -126,[-6] = 0,[6] = 51,[-7] = 0,[7] = 204,[-8] = 0,[8] = 267,[-9] = 0,[9] = 310,},
				[3] = {[0] = -126,[1] = -126,[-1] = -126,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -126,[-2] = -126,[-20] = 0,[20] = 480,[3] = -124,[-3] = -126,[-4] = -112,[4] = -57,[5] = 153,[-5] = -17,[-6] = -3,[6] = 416,[-7] = -1,[7] = 480,[-8] = 0,[8] = 480,[-9] = 0,[9] = 480,},
				[-4] = {[0] = 0,[-1] = 0,[1] = -4,[-10] = 0,[10] = 365,[-11] = 0,[11] = 434,[-12] = 0,[12] = 460,[-13] = 0,[13] = 473,[-14] = 0,[14] = 475,[-15] = 0,[15] = 478,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = 0,[2] = -36,[-20] = 0,[20] = 480,[-3] = 0,[3] = -50,[-4] = 0,[4] = -48,[5] = 0,[-5] = 0,[-6] = 0,[6] = 29,[-7] = 0,[7] = 124,[-8] = 0,[8] = 178,[-9] = 0,[9] = 252,},
				[4] = {[0] = -126,[1] = -126,[-1] = -126,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = -126,[-2] = -126,[-20] = 0,[20] = 480,[-3] = -126,[3] = -65,[4] = 101,[-4] = -106,[5] = 336,[-5] = -39,[6] = 480,[-6] = -9,[-7] = -1,[7] = 480,[-8] = 0,[8] = 480,[-9] = 0,[9] = 480,},
				[-5] = {[0] = 0,[-1] = 0,[1] = -1,[-10] = 0,[10] = 298,[-11] = 0,[11] = 392,[-12] = 0,[12] = 438,[-13] = 0,[13] = 467,[-14] = 0,[14] = 469,[-15] = 0,[15] = 477,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = 0,[2] = -7,[-20] = 0,[20] = 480,[-3] = 0,[3] = -18,[-4] = 0,[4] = -12,[5] = 0,[-5] = 0,[-6] = 0,[6] = 5,[-7] = 0,[7] = 57,[-8] = 0,[8] = 106,[-9] = 0,[9] = 179,},
				[5] = {[0] = -126,[1] = -124,[-1] = -126,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = -126,[2] = -77,[-20] = 0,[20] = 480,[-3] = -126,[3] = 78,[4] = 279,[-4] = -88,[-5] = -29,[5] = 439,[-6] = 2,[6] = 480,[-7] = 1,[7] = 480,[-8] = 0,[8] = 480,[-9] = 0,[9] = 480,},
				[-6] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 176,[-11] = 0,[11] = 347,[-12] = 0,[12] = 412,[-13] = 0,[13] = 438,[-14] = 0,[14] = 454,[-15] = 0,[15] = 473,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 0,[-2] = 0,[-20] = 0,[20] = 480,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[-7] = 0,[7] = 11,[-8] = 0,[8] = 40,[-9] = 0,[9] = 89,},
				[6] = {[0] = -75,[-1] = -126,[1] = 8,[-10] = 0,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 101,[-2] = -126,[-20] = 0,[20] = 480,[-3] = -126,[3] = 237,[-4] = -12,[4] = 415,[-5] = 41,[5] = 480,[6] = 480,[-6] = 53,[-7] = 34,[7] = 480,[8] = 480,[-8] = 8,[-9] = 2,[9] = 480,},
				[-7] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 106,[-11] = 0,[11] = 206,[-12] = 0,[12] = 296,[-13] = 0,[13] = 360,[-14] = 0,[14] = 411,[-15] = 0,[15] = 447,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 0,[-2] = 0,[-20] = 0,[20] = 480,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[-8] = 0,[8] = 14,[-9] = 0,[9] = 42,},
				[7] = {[0] = 94,[-1] = -13,[1] = 207,[10] = 480,[-10] = 7,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 331,[-2] = -36,[-20] = 0,[20] = 480,[3] = 439,[-3] = 92,[-4] = 179,[4] = 480,[-5] = 165,[5] = 480,[-6] = 142,[6] = 480,[7] = 480,[-7] = 94,[8] = 480,[-8] = 54,[-9] = 30,[9] = 480,},
				[-8] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 54,[-11] = 0,[11] = 118,[-12] = 0,[12] = 198,[-13] = 0,[13] = 286,[-14] = 0,[14] = 359,[-15] = 0,[15] = 422,[-16] = 0,[16] = 470,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[2] = 0,[-2] = 0,[-20] = 0,[20] = 480,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[-9] = 0,[9] = 19,},
				[8] = {[0] = 322,[-1] = 196,[1] = 424,[-10] = 17,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = 270,[2] = 485,[-20] = 0,[20] = 480,[-3] = 267,[3] = 480,[-4] = 269,[4] = 480,[-5] = 243,[5] = 480,[-6] = 195,[6] = 480,[-7] = 137,[7] = 480,[8] = 480,[-8] = 93,[9] = 480,[-9] = 61,},
				[-9] = {[0] = 0,[1] = 0,[-1] = 0,[-10] = 0,[10] = 29,[-11] = 0,[11] = 69,[-12] = 0,[12] = 142,[-13] = 0,[13] = 229,[-14] = 0,[14] = 309,[-15] = 0,[15] = 381,[-16] = 0,[16] = 432,[-17] = 0,[17] = 461,[-18] = 0,[18] = 463,[-19] = 0,[19] = 442,[2] = 0,[-2] = 0,[-20] = 0,[20] = 343,[3] = 0,[-3] = 0,[4] = 0,[-4] = 0,[5] = 0,[-5] = 0,[6] = 0,[-6] = 0,[7] = 0,[-7] = 0,[8] = 0,[-8] = 0,[-9] = 0,[9] = 4,},
				[9] = {[0] = 485,[-1] = 448,[1] = 485,[-10] = 20,[10] = 480,[-11] = 0,[11] = 480,[-12] = 0,[12] = 480,[-13] = 0,[13] = 480,[-14] = 0,[14] = 480,[-15] = 0,[15] = 480,[-16] = 0,[16] = 480,[-17] = 0,[17] = 480,[-18] = 0,[18] = 480,[-19] = 0,[19] = 480,[-2] = 429,[2] = 480,[-20] = 0,[20] = 480,[-3] = 378,[3] = 480,[-4] = 352,[4] = 480,[-5] = 311,[5] = 480,[-6] = 246,[6] = 480,[-7] = 170,[7] = 480,[-8] = 110,[8] = 480,[9] = 480,[-9] = 62,},
			},
			TerrainTextures = {
				TextureList = RandomMapGenerator.TextureSets.NormalRocky,
				RelativX = 3,
				RelativY = 4,
				Area = {x1 = -8, y1 = -8, x2 = 12, y2 = 12},
			},
			Water = {},
		},
		IronPit = {
			Entities = {{Type = Entities.XD_IronPit1, Resource = contentIronPit,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 5, Name = "white"},},
			Blocking = 12,
			TerrainHeights = {
				Area = 16,
				[-4]={[-4]= 0,[-3]=   0,[-2]=   -5},
				[-3]={[-4]= 0,[-3]=  -2,[-2]=   -2,[-1]=   -2,[0]=   -2},
				[-2]={[-4]= 0,[-3]=  -8,[-2]=  -14,[-1]=  -24,[0]=  -46,[1]=  -44,[2]=  -49,[3]=  -25},
				[-1]={[-4]= 0,[-3]= -23,[-2]=  -58,[-1]= -106,[0]= -172,[1]= -180,[2]= -153,[3]=  -74},
				[0]={[-4]=-4,[-3]= -32,[-2]= -103,[-1]= -337,[0]= -327,[1]= -375,[2]= -264,[3]= -114},
				[1]={[-4]=-5,[-3]= -36,[-2]= -109,[-1]= -308,[0]= -357,[1]= -412,[2]= -296,[3]= -122},
				[2]={[-4]=-1,[-3]= -24,[-2]=  -89,[-1]= -182,[0]= -246,[1]= -268,[2]= -219,[3]=  -70},
				[3]={[-4]= 0,[-3]=  -4,[-2]=  -40,[-1]=  -85,[0]= -109,[1]= -107,[2]=  -64},
				[4]={[-4]= 0,[-3]=   0,[-2]=    0,[-1]=   -2,[0]=   -4},
			},
			TerrainTextures = {
				TextureList = RandomMapGenerator.TextureSets.NormalMudDarkSmooth,
				Area = 10,
			},
			Water = {},
		},
		SulfurPit = {
			Entities = {{Type = Entities.XD_SulfurPit1, Resource = contentSulfurPit,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 5, Name = "white"},},
			Blocking = 12,
			TerrainHeights = {
				Area = 16,
				[-3]={[-5]= 0,[-4]=  -2,[-3]=   -2,[-2]=   -2,[-1]=   -2},
				[-2]={[-5]= 0,[-4]=  -8,[-3]=  -14,[-2]=  -24,[-1]=  -46,[0]=  -44,[1]=  -49,[2]=  -25},
				[-1]={[-5]= 0,[-4]= -23,[-3]=  -58,[-2]= -106,[-1]= -172,[0]= -180,[1]= -153,[2]=  -74},
				[0]={[-5]=-4,[-4]= -32,[-3]= -103,[-2]= -337,[-1]= -327,[0]= -365,[1]= -264,[2]= -114},
				[1]={[-5]=-5,[-4]= -36,[-3]= -109,[-2]= -308,[-1]= -357,[0]= -412,[1]= -296,[2]= -122},
				[2]={[-5]=-1,[-4]= -24,[-3]=  -89,[-2]= -182,[-1]= -246,[0]= -268,[1]= -219,[2]=  -70},
				[3]={[-5]= 0,[-4]=  -4,[-3]=  -40,[-2]=  -85,[-1]= -109,[0]= -107,[1]=  -64},
			},
			TerrainTextures = {
				TextureList = RandomMapGenerator.TextureSets.NorthSand,
				Area = 9,
			},
			Water = {},
		},
		ClayPile = {
			Entities = {{Type = Entities.XD_Clay1, Resource = contentClayPile,},},
			Blocking = 4,
		},
		StonePile = {
			Entities = {{Type = Entities.XD_Stone1, Resource = contentStonePile,},},
			Blocking = 4,
		},
		IronPile = {
			Entities = {{Type = Entities.XD_Iron1, Resource = contentIronPile,},},
			Blocking = 4,
		},
		SulfurPile = {
			Entities = {{Type = Entities.XD_Sulfur1, Resource = contentSulfurPile,},},
			Blocking = 4,
		},
		WoodPileExplored = {
			Entities = {{Type = Entities.XD_ScriptEntity, Name = "woodpile",}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 2, Name = "white"},},
			Blocking = 4,
		},
		ClayPileExplored = {
			Entities = {{Type = Entities.XD_Clay1, Resource = contentClayPile,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 3, Name = "white"},},
			Blocking = 4,
		},
		StonePileExplored = {
			Entities = {{Type = Entities.XD_Stone1, Resource = contentStonePile,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 3, Name = "white"},},
			Blocking = 4,
		},
		IronPileExplored = {
			Entities = {{Type = Entities.XD_Iron1, Resource = contentIronPile,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 3, Name = "white"},},
			Blocking = 4,
		},
		SulfurPileExplored = {
			Entities = {{Type = Entities.XD_Sulfur1, Resource = contentSulfurPile,}, {Type = Entities.XD_ScriptEntity, Explore = exploreres * 3, Name = "white"},},
			Blocking = 4,
		},
		Bridge1 = { -- x axis
			Blocking = 18,
			Entities = {
				{Type = Entities.XD_Bridge1,},
				{Type = Entities.PB_Bridge1,},
			},
			TerrainHeights = {
				Area = {x = 24, y = 10},
				LerpDist = 5,
				BaseHeight = RandomMapGenerator.GenerationData.TerrainBaseHeight,
				[-15] = {[10] = -50, [9] = -50, [8] = -50, [7] = -50, [6] = -30, [5] = -20, [4] = 0, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = 0, [-5] = -20, [-6] = -30, [-7] = -50, [-8] = -50, [-9] = -50, [-10] = -50, },
				[-14] = {[10] = -125, [9] = -125, [8] = -125, [7] = -125, [6] = -125, [5] = -80, [4] = -20, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = -20, [-5] = -80, [-6] = -125, [-7] = -125, [-8] = -125, [-9] = -125, [-10] = -125, },
				[-13] = {[10] = -225, [9] = -225, [8] = -225, [7] = -225, [6] = -225, [5] = -225, [4] = -180, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = -180, [-5] = -225, [-6] = -225, [-7] = -225, [-8] = -225, [-9] = -225, [-10] = -225, },
				[-12] = {[10] = -331, [9] = -331, [8] = -331, [7] = -331, [6] = -331, [5] = -331, [4] = -331, [3] = -331, [2] = -331, [1] = -331, [0] = -331, [-1] = -331, [-2] = -331, [-3] = -331, [-4] = -331, [-5] = -331, [-6] = -331, [-7] = -331, [-8] = -331, [-9] = -331, [-10] = -331, },
				[-11] = {[10] = -438, [9] = -438, [8] = -438, [7] = -438, [6] = -438, [5] = -438, [4] = -438, [3] = -438, [2] = -438, [1] = -438, [0] = -438, [-1] = -438, [-2] = -438, [-3] = -438, [-4] = -438, [-5] = -438, [-6] = -438, [-7] = -438, [-8] = -438, [-9] = -438, [-10] = -438, },
				[-10] = {[10] = -538, [9] = -538, [8] = -538, [7] = -538, [6] = -538, [5] = -538, [4] = -538, [3] = -538, [2] = -538, [1] = -538, [0] = -538, [-1] = -538, [-2] = -538, [-3] = -538, [-4] = -538, [-5] = -538, [-6] = -538, [-7] = -538, [-8] = -538, [-9] = -538, [-10] = -538, },
				[-9] = {[10] = -613, [9] = -613, [8] = -613, [7] = -613, [6] = -613, [5] = -613, [4] = -613, [3] = -613, [2] = -613, [1] = -613, [0] = -613, [-1] = -613, [-2] = -613, [-3] = -613, [-4] = -613, [-5] = -613, [-6] = -613, [-7] = -613, [-8] = -613, [-9] = -613, [-10] = -613, },
				[-8] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-7] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-6] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-5] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-4] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-3] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-2] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[-1] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[0] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[1] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[2] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[3] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[4] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[5] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[6] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[7] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[8] = {[10] = -663, [9] = -663, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -663, [-10] = -663, },
				[9] = {[10] = -613, [9] = -613, [8] = -613, [7] = -613, [6] = -613, [5] = -613, [4] = -613, [3] = -613, [2] = -613, [1] = -613, [0] = -613, [-1] = -613, [-2] = -613, [-3] = -613, [-4] = -613, [-5] = -613, [-6] = -613, [-7] = -613, [-8] = -613, [-9] = -613, [-10] = -613, },
				[10] = {[10] = -538, [9] = -538, [8] = -538, [7] = -538, [6] = -538, [5] = -538, [4] = -538, [3] = -538, [2] = -538, [1] = -538, [0] = -538, [-1] = -538, [-2] = -538, [-3] = -538, [-4] = -538, [-5] = -538, [-6] = -538, [-7] = -538, [-8] = -538, [-9] = -538, [-10] = -538, },
				[11] = {[10] = -438, [9] = -438, [8] = -438, [7] = -438, [6] = -438, [5] = -438, [4] = -438, [3] = -438, [2] = -438, [1] = -438, [0] = -438, [-1] = -438, [-2] = -438, [-3] = -438, [-4] = -438, [-5] = -438, [-6] = -438, [-7] = -438, [-8] = -438, [-9] = -438, [-10] = -438, },
				[12] = {[10] = -331, [9] = -331, [8] = -331, [7] = -331, [6] = -331, [5] = -331, [4] = -331, [3] = -331, [2] = -331, [1] = -331, [0] = -331, [-1] = -331, [-2] = -331, [-3] = -331, [-4] = -331, [-5] = -331, [-6] = -331, [-7] = -331, [-8] = -331, [-9] = -331, [-10] = -331, },
				[13] = {[10] = -225, [9] = -225, [8] = -225, [7] = -225, [6] = -225, [5] = -225, [4] = -180, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = -180, [-5] = -225, [-6] = -225, [-7] = -225, [-8] = -225, [-9] = -225, [-10] = -225, },
				[14] = {[10] = -125, [9] = -125, [8] = -125, [7] = -125, [6] = -125, [5] = -80, [4] = -20, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = -20, [-5] = -80, [-6] = -125, [-7] = -125, [-8] = -125, [-9] = -125, [-10] = -125, },
				[15] = {[10] = -50, [9] = -50, [8] = -50, [7] = -50, [6] = -30, [5] = -20, [4] = 0, [3] = 0, [2] = 0, [1] = 0, [0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = 0, [-5] = -20, [-6] = -30, [-7] = -50, [-8] = -50, [-9] = -50, [-10] = -50, },
			},
			TerrainTextures = {
				Area = {x = 10, y = 6,},
				TextureList = "Lake",
			},
		},
		Bridge2 = { -- y axis
			Blocking = 18,
			Entities = {
				{Type = Entities.XD_Bridge2,},
				{Type = Entities.PB_Bridge2,},
			},
			TerrainHeights = {
				Area = {x = 10, y = 24},
				LerpDist = 5,
				BaseHeight = RandomMapGenerator.GenerationData.TerrainBaseHeight,
				[-10] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-9] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-8] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-7] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-6] = {[15] = -30, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -30, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-5] = {[15] = -20, [14] = -80, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -80, [-15] = -20, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-4] = {[15] = 0, [14] = -20, [13] = -180, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -180, [-14] = -20, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-3] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-2] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[-1] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[0] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[1] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[2] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[3] = {[15] = 0, [14] = 0, [13] = 0, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = 0, [-14] = 0, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[4] = {[15] = 0, [14] = -20, [13] = -180, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -180, [-14] = -20, [-15] = 0, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[5] = {[15] = -20, [14] = -80, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -80, [-15] = -20, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[6] = {[15] = -30, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -30, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[7] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[8] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[9] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
				[10] = {[15] = -50, [14] = -125, [13] = -225, [12] = -331, [11] = -438, [10] = -538, [9] = -613, [8] = -663, [7] = -663, [6] = -663, [5] = -663, [4] = -663, [3] = -663, [2] = -663, [1] = -663, [0] = -663, [-1] = -663, [-2] = -663, [-3] = -663, [-4] = -663, [-5] = -663, [-6] = -663, [-7] = -663, [-8] = -663, [-9] = -613, [-10] = -538, [-11] = -438, [-12] = -331, [-13] = -225, [-14] = -125, [-15] = -50, [-16] = 0, [-17] = 0, [-18] = 0, [-19] = 0, [-20] = 0, },
			},
			TerrainTextures = {
				Area = {x = 6, y = 10,},
				TextureList = "Lake",
			},
		},
		NeutralVillageCenter = {
			Blocking = 12,
			Entities = {
				{Type = Entities.XD_VillageCenter, Player = 0,}, {Type = Entities.XD_ScriptEntity, Explore = explorevc * 6, Name = "green"},
			},
			TerrainHeights = {
				Area = {x = 18, y = 18,},
			},
			TerrainTextures = {
				Area = {x = 8, y = 8,},
				TextureList = "Road",
			},
		},
		Placement = {
			PileAtPit = {
				AreaMin = 16,
				AreaMax = 32,
				NoiseMin = noiseMin,
				NoiseMax = noiseMax,
			},
		},
	}
	
	noiseMin = RandomMapGenerator.GenerationData.ThresholdCoast
	noiseMax = RandomMapGenerator.GenerationData.ThresholdHill
	
	local noiseIron = RandomMapGenerator.GenerationData.ThresholdHill
	local noiseSulfur = RandomMapGenerator.GenerationData.ThresholdCoast

	if RandomMapGenerator.GenerationData.ThresholdPlateau < RandomMapGenerator.GenerationData.ThresholdPike then
		noiseMax = RandomMapGenerator.GenerationData.ThresholdPike
		noiseIron = 1
	elseif amountIronPit <= 0 then
		noiseIron = RandomMapGenerator.GenerationData.ThresholdForest
	end
	
	if amountSulfurPit <= 0 then
		noiseSulfur = RandomMapGenerator.GenerationData.ThresholdLowForest	
	end
	
	RandomMapGenerator.StructureSets.PlayerStruct = {
		Childs = {
			{
				Data = {
					Blocking = 12,
					Entities = {
						{Type = Entities.PB_Headquarters1, SkipDummy = true},
						--{Type = Entities.PU_Serf, RelativX = -900, RelativY = -300, Rotation = 180,},
						--{Type = Entities.PU_Serf, RelativX = -900, RelativY = -100, Rotation = 180,},
						--{Type = Entities.PU_Serf, RelativX = -900, RelativY =  100, Rotation = 180,},
						--{Type = Entities.PU_Serf, RelativX = -900, RelativY =  300, Rotation = 180,},
					},
					TerrainHeights = {
					Area = {x = 18, y = 18,},
					},
					TerrainTextures = {
						Area = {x = 8, y = 8,},
						TextureList = "Road",
					},
				},
			},
		},
	}
	
	RandomMapGenerator.GenerationData.PlayerDistanceToMiddle = 0.667 -- in percent
	RandomMapGenerator.GenerationData.PlayerClearance = 35 -- distance to team border
	
	if nplayers > 8 then
		RandomMapGenerator.GenerationData.PlayerDistanceToMiddle = 0.75 -- in percent
		RandomMapGenerator.GenerationData.PlayerClearance = 15 -- distance to team border
	end
	
	if RandomMapGenerator.GenerationData.RandomPlayerPosition then
		RandomMapGenerator.GenerationData.PlayerClearance = 0
	end
	
	local resmax = 90 -- highest distance
	local resfac = ((Logic.WorldGetSize() / 100) * RandomMapGenerator.GenerationData.PlayerDistanceToMiddle * math.cos(math.rad((180 - 360 / nplayers) / 2)) / 2 - RandomMapGenerator.GenerationData.PlayerClearance) / resmax -- involves triangle opration for two equal sides, the rest is 
	local resoff = 5
	local resdist = {}
	
	do -- player resources and vc
	-- vc
		for i = 1, amountVillageCenter do
		
			local dist = math.random(30 * resfac, 90 * resfac)

			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RandomMapGenerator.GenerationData.ThresholdRoad,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
				},
				Data = RandomMapGenerator.StructureSets.NeutralVillageCenter,
			}
			if i == 1 then
				child.Childs = {{Data = {Entities = {{Type = Entities.PB_VillageCenter1, SkipDummy = true}}}}}
			end

			table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
		end
		
		-- wood
		for i = 1, amountWoodPile do
			
			local dist = math.random(50 * resfac, 70 * resfac)
			
			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RandomMapGenerator.GenerationData.ThresholdRoad,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
				},
				Data = RandomMapGenerator.StructureSets.WoodPileExplored,
			}

			table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
		end
		
		-- clay
		if amountClayPit > 0 then
			local amountPiles, amountPilesLeft = math.floor(amountClayPile / amountClayPit), math.mod(amountClayPile, amountClayPit)
			for i = 1, amountClayPit do
			
				local dist = math.random(50 * resfac, 70 * resfac)
		
				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = RandomMapGenerator.GenerationData.ThresholdCoast,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.ClayPit,
					Childs = {},
				}

				local n = 1
				if i <= amountPilesLeft then
					n = 0
				end
				for j = n, amountPiles do
					table.insert(child.Childs, {Placement = RandomMapGenerator.StructureSets.Placement.PileAtPit, Data = RandomMapGenerator.StructureSets.ClayPile,})
				end

				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		else
			for i = 1, amountClayPile do
			
				local dist = math.random(50 * resfac, 70 * resfac)
		
				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = RandomMapGenerator.GenerationData.ThresholdCoast,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.ClayPileExplored,
					Childs = {},
				}
				
				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		end
		
		-- stone
		if amountStonePit > 0 then
			amountPiles, amountPilesLeft = math.floor(amountStonePile / amountStonePit), math.mod(amountStonePile, amountStonePit)
			for i = 1, amountStonePit do
			
				local dist = math.random(60 * resfac, 80 * resfac)

				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = RandomMapGenerator.GenerationData.ThresholdHill,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.StonePit,
					Childs = {},
				}

				local n = 1
				if i <= amountPilesLeft then
					n = 0
				end
				for j = n, amountPiles do
					table.insert(child.Childs, {Placement = RandomMapGenerator.StructureSets.Placement.PileAtPit, Data = RandomMapGenerator.StructureSets.StonePile,})
				end

				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		else
			for i = 1, amountStonePile do
			
				local dist = math.random(60 * resfac, 80 * resfac)
		
				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = RandomMapGenerator.GenerationData.ThresholdHill,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.StonePileExplored,
					Childs = {},
				}
				
				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		end
		
		-- iron
		if amountIronPit > 0 then
			amountPiles, amountPilesLeft = math.floor(amountIronPile / amountIronPit), math.mod(amountIronPile, amountIronPit)
			for i = 1, amountIronPit do
			
				local dist = math.random(70 * resfac, 90 * resfac)

				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = noiseIron,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.IronPit,
					Childs = {},
				}

				local n = 1
				if i <= amountPilesLeft then
					n = 0
				end
				for j = n, amountPiles do
					table.insert(child.Childs, {Placement = RandomMapGenerator.StructureSets.Placement.PileAtPit, Data = RandomMapGenerator.StructureSets.IronPile,})
				end

				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		else
			for i = 1, amountIronPile do
			
				local dist = math.random(70 * resfac, 90 * resfac)
		
				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = noiseIron,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.IronPileExplored,
					Childs = {},
				}
				
				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		end
		
		-- sulfur
		if amountSulfurPit > 0 then
			amountPiles, amountPilesLeft = math.floor(amountSulfurPile / amountSulfurPit), math.mod(amountSulfurPile, amountSulfurPit)
			for i = 1, amountSulfurPit do
			
				local dist = math.random(70 * resfac, 90 * resfac)

				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = noiseSulfur,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.SulfurPit,
					Childs = {},
				}

				local n = 1
				if i <= amountPilesLeft then
					n = 0
				end
				for j = n, amountPiles do
					table.insert(child.Childs, {Placement = RandomMapGenerator.StructureSets.Placement.PileAtPit, Data = RandomMapGenerator.StructureSets.SulfurPile,})
				end

				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		else
			for i = 1, amountSulfurPile do
			
				local dist = math.random(70 * resfac, 90 * resfac)
		
				local child = {
					Placement = {
						AreaMin = dist - resoff,
						AreaMax = dist + resoff,
						Noise = noiseSulfur,
						NoiseMin = noiseMin,
						NoiseMax = noiseMax,
						Grid = 4,
					},
					Data = RandomMapGenerator.StructureSets.SulfurPileExplored,
					Childs = {},
				}
				
				table.insert(RandomMapGenerator.StructureSets.PlayerStruct.Childs, child)
			end
		end
	end
	
	RandomMapGenerator.StructureSets.NeutralStruct = {
		Childs = {
			--[[{
				placement = {
					RelativY = 20,
				},
				Data = RandomMapGenerator.StructureSets.ClayPit,
			},
			{
				placement = {
					RelativY = -20,
				},
				Data = RandomMapGenerator.StructureSets.StonePit,
			},]]
		},
	}
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.GetPlayersAndTeams()
	
	local nplayers = 0
	local players = {}
	local nteams = 0
	local teams = {}
	
	if XNetwork.Manager_DoesExist() == 1 then
	
		for p = 1, 16 do
			if Logic.PlayerGetGameState(p) == 1 then
				nplayers = nplayers + 1
				
				local team = XNetwork.GameInformation_GetLogicPlayerTeam(p)
				local isIn = false
		
				for k,v in pairs(teams) do
					if v == team then
						isIn = true
						break
					end
				end
		
				if not isIn then
					nteams = nteams + 1
					teams[nteams] = team
				end
			
				players[nplayers] = {id = p, team = team, ishuman = 1}
			end
		end
 
	else
		-- just some testing in SP - amount must fit now due to new sorting system
		nplayers = 4
		players[1] = {id = 1, team = 5, ishuman = 1}
		players[2] = {id = 6, team = 2, ishuman = 1}
		players[3] = {id = 4, team = 5, ishuman = 1}
		players[4] = {id = 3, team = 2, ishuman = 1}
		--players[5] = {id = 5, team = 2, ishuman = 1}
		--players[6] = {id = 2, team = 5, ishuman = 1}
		--players[7] = {id = 7, team = 5, ishuman = 1}
		--players[8] = {id = 8, team = 2, ishuman = 1}
		--players[9] = {id = 3, team = 2, ishuman = 1}
		--players[10] = {id = 2, team = 5, ishuman = 1}
		nteams = 2
		teams[1] = 5
		teams[2] = 2
		--teams[3] = 3
		--teams[4] = 4
	end
	
	-- sort MUST be done here !
	-- sort team by id
	table.sort(teams,
	function(a, b)
		return a < b;
	end
	)
	
	-- sort players by team
	table.sort(players,
	function(a, b)
		return (a.team < b.team) --or (a.team == b.team and a.id < b.id)
	end
	)

	return nplayers, players, nteams, teams
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.FinalizeGenerationData()
	
	local _generationData = RandomMapGenerator.GenerationData
	
	-- set landscapeSet if not existing or key is valid
	if not _generationData.LandscapeSet or RandomMapGenerator.LandscapeSets[_generationData.LandscapeSetKey] then
		
		_generationData.LandscapeSet = RandomMapGenerator.LandscapeSets[_generationData.LandscapeSetKey]
	end
	
	_generationData.Structures = { -- level 0 = world

		Childs = {}, -- level 1
		Current = {
			Levels = {[0] = 1, [1] = 0}, -- 2nd is player to start with (set to 0 or 1)
			Structs = {
				Placement = {
					X = 0,
					Y = 0,
				},
				Childs = {},
			},
		},
	}
	_generationData.PlayerStruct = RandomMapGenerator.StructureSets.PlayerStruct
	_generationData.NeutralStruct = RandomMapGenerator.StructureSets.NeutralStruct
	
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.StartGenerateMap()
	
	local _generationData = RandomMapGenerator.GenerationData
	
	RandomMapGenerator.FillNoiseTable(_generationData)
	RandomMapGenerator.FillPlayerLocationTable(_generationData)
	
	if _generationData.TeamBorderType == 2 then
		RandomMapGenerator.CreateFences(_generationData)
	elseif _generationData.TeamBorderType == 3 then
		RandomMapGenerator.FillRiverLocationTable(_generationData)
		RandomMapGenerator.CreateRivers(_generationData)
		RandomMapGenerator.ApplyNoiseOverride(_generationData, RandomMapGenerator.BlockingTypes.River, math.min)
	end
	
	if _generationData.GenerateRoads then
		RandomMapGenerator.FillRoadLocationTable(_generationData)
		RandomMapGenerator.CreateRoads(_generationData)
		RandomMapGenerator.ApplyNoiseOverride(_generationData, RandomMapGenerator.BlockingTypes.Road)
	end
	
	RandomMapGenerator.SetTerrainTextures(_generationData)
	
	if RandomMapGenerator.GenerateStructures(_generationData) or _generationData.DebugMode then
	
		RandomMapGenerator.SetTerrainHeights(_generationData)
		RandomMapGenerator.UpdateBlocking(_generationData)
	
		RandomMapGenerator.CreateEntities(_generationData)
		
		RandomMapGenerator.Finalize(_generationData)
		
		return true
	end
	
	return false
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.GenerateMap()
	RandomMapGenerator.InitGenerationData()
	RandomMapGenerator.FinalizeGenerationData()
	return RandomMapGenerator.StartGenerateMap()
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Noise Calculation
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.FillNoiseTable(_generationData)

	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	
	local lerpRadius = maphalf - 16
	local noise

	for x = 0, mapsize, 2 do
		
		_generationData.TerrainNodes[x] = {}
		
		for y = 0, mapsize, 2 do
	
			local distance = math.sqrt((maphalf - x)^2 + (maphalf - y)^2)
			
			if distance < maphalf then
				
				local mx, my = x, y
				if _generationData.MirrorMap then
					mx, my = RandomMapGenerator.MirrorNode(_generationData, x, y)
				end
				
				noise = RandomMapGenerator.GetSimplexNoise(4, mx, my, 0.5, _generationData.NoiseFactorXY)
				
				if distance > lerpRadius then
					noise = Lerp( _generationData.ThresholdPike, noise, (distance - lerpRadius) / 16 )
				end
				
			else
				noise = _generationData.ThresholdPike
			end
			
			_generationData.TerrainNodes[x][y] = RandomMapGenerator.CreateTerrainNode(_generationData, x, y, noise)
		end
	end
	
	for x = 1, mapsize, 2 do

		_generationData.TerrainNodes[x] = {}

		for y = 0, mapsize, 2 do
		
			noise = (_generationData.TerrainNodes[x-1][y].noise + _generationData.TerrainNodes[x+1][y].noise) / 2
			_generationData.TerrainNodes[x][y] = RandomMapGenerator.CreateTerrainNode(_generationData, x, y, noise)
			
		end
	end

	for x = 0, mapsize do
		for y = 1, mapsize, 2 do
		
			noise = (_generationData.TerrainNodes[x][y-1].noise + _generationData.TerrainNodes[x][y+1].noise) / 2
			_generationData.TerrainNodes[x][y] = RandomMapGenerator.CreateTerrainNode(_generationData, x, y, noise)
			
		end
	end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Noise Utility
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetSimplexNoise(_octaves, _x, _y, _persistence, _scale)

	local maxAmp = 0
	local amp = 1
	local freq = _scale
	local noise = 0

	--add successively smaller, higher-frequency terms
	for i = 1, _octaves do
		noise = noise + SimplexNoise.Noise2D(SimplexNoise.perm[i], _x * freq, _y * freq) * amp
		maxAmp = maxAmp + amp
		amp = amp * _persistence
		freq = freq * 2
	end

	--take the average value of the iterations
	noise = noise / maxAmp

	return noise
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateTerrainNode(_generationData, _x, _y, _noise)--, _height)

	return {x = _x, y = _y, noise = _noise, height = RandomMapGenerator.GetTerrainHeightFromNoise(_generationData, _noise), blocking = 0}
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Player Locations
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.FillPlayerLocationTable(_generationData)
	
	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	local radhalf = _generationData.PlayerRadian / 2
	local distance = math.min(maphalf - 50, maphalf * _generationData.PlayerDistanceToMiddle)
	
	_generationData.Players[0] = {x = maphalf, y = maphalf, id = 0, team = 0}
	
	local nplayers = _generationData.NumberOfPlayers
	
	for p = 1, nplayers do
		
		local delta, x, y

		if _generationData.RandomPlayerPosition then
			delta = math.random(0, math.rad(360)) 
			distance = math.random(5, maphalf - 15)
		else
			delta = (p - 1) * _generationData.PlayerRadian + radhalf
		end
		
		x = distance * math.cos(delta) + maphalf
		y = distance * math.sin(delta) + maphalf
		
		if _generationData.RandomPlayerPosition then
			x, y = SnapToGrid(4, x, y)
		else
			x, y = RandomMapGenerator.FindBestPoint(_generationData, x, y, 8, 4)
		end
		
		_generationData.Players[p].x = x
		_generationData.Players[p].y = y
		
		if p == 1 or not _generationData.MirrorMap then
		_generationData.Structures.Childs[p] = {
			Placement = {
				AbsolutX = x,
				AbsolutY = y,
				--Blocking = 100,
			},
			Childs = {_generationData.PlayerStruct,},
		}
		end
	end
	
	_generationData.Structures.Childs[0] = { --_generationData.NumberOfPlayers + 1
		Placement = {
			AbsolutX = 0,
			AbsolutY = 0,
		},
		Childs = {},
	}
	
	return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.MirrorPosition(_generationData, _x, _y, _slize)
	return RandomMapGenerator.Mirror(_generationData, _x, _y, Logic.WorldGetSize(), _slize)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.MirrorNode(_generationData, _x, _y, _slize)
	return RandomMapGenerator.Mirror(_generationData, _x, _y, Logic.WorldGetSize() / 100, _slize)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.Mirror(_generationData, _x, _y, _mapsize, _slize)
	
	local maphalf = _mapsize / 2
	if _y == maphalf and _x >= maphalf then
		return _x, _y
	end
	
	_slize = _slize or 1
	
	-- handle unter and overshots
	while _slize > _generationData.NumberOfPlayers do
		_slize = _slize - _generationData.NumberOfPlayers
	end
	while _slize < 1 do
		_slize = _slize + _generationData.NumberOfPlayers
	end

	local x, y = _x - maphalf, _y - maphalf
	local distance = math.sqrt(x ^ 2 + y ^ 2)
	
	--if distance == 0 then
		--return _x, _y
	--end
	
	local delta = math.atan2(y, x)
	
	if delta < 0 then
		delta = 2 * math.pi + delta 
	end
	
	local slize = math.ceil(delta / _generationData.PlayerRadian)
	
	local difference = slize - _slize
	local theta = delta - difference * _generationData.PlayerRadian
	
	-- mirror slize if one index is even and the other is odd so we get matching edges
	-- note that an uneven number of slizes allways generates one odd edge
	-- this edge will be covered by a team dividing River if TeamBorderType is true
	if math.mod(slize, 2) ~= math.mod(_slize, 2) then
		local gamma = math.mod(theta, _generationData.PlayerRadian)
		theta = theta - 2 * gamma + _generationData.PlayerRadian -- this results from try and error late at night - dont ask me, it just works
	end
	
	return distance * math.cos(theta) + maphalf, distance * math.sin(theta) + maphalf -- mirrored x and y
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.FindBestPoint(_generationData, _x, _y, _dist, _grid, _value)
	
	_value = _value or 0
	_grid = _grid or 1
	_x, _y, _dist = SnapToGrid(_grid, _x, _y, _dist)
	
	local mapsize = Logic.WorldGetSize() / 100
	local px, py = _x, _y
	local noise = _generationData.TerrainNodes[_x][_y].noise
  
	for x = math.max(_x -_dist, 0), math.min(_x + _dist, mapsize), _grid do
		for y = math.max(_y - _dist, 0), math.min(_y + _dist, mapsize), _grid do
			if math.abs(_generationData.TerrainNodes[x][y].noise - _value) < math.abs(noise - _value) then
				noise = _generationData.TerrainNodes[x][y].noise
				px, py = x, y
			end
		end
	end
 
	return px, py
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Rivers & Roads
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.CreateFences(_generationData)
	
	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	
	-- circle radius
	local r = 50

	local currentTeam = 0

	local radea = {}
	local currentRadius = 1
	
	-- create fence lines from circle radius to map border
	for player = 1, _generationData.NumberOfPlayers do
		
		local delta = (player - 1) * _generationData.PlayerRadian
		
		-- per player
		if _generationData.GateLayout == 1 then
			table.insert(radea, delta)
		end

		if _generationData.Players[player].team > currentTeam then
			currentTeam = _generationData.Players[player].team
			
			-- per team
			if _generationData.GateLayout == 2 then
				table.insert(radea, delta)
			end
			
			for i = r + 2, maphalf, 2 do
				local x = (i - 1) * math.cos(delta) + maphalf
				local y = (i - 1) * math.sin(delta) + maphalf
				
				Logic.CreateEntity(Entities["XD_WoodenFence0"..math.random(1,8)], x * 100, y * 100, math.deg(delta), 0)
			end
		end
	end
	
	local a = math.rad(360) / ((math.pi * r * 2) / 2) -- 360° / (umfang / Zaunlänge)
	local b = radea[currentRadius + 1]
	local c = radea[currentRadius] -- should always be 0
	
	-- create fence circle
	for delta = 0, math.rad(360), a do
		
		if delta > b then
			currentRadius = currentRadius + 1
			c = b--radea[currentRadius]
			
			if currentRadius >= table.getn(radea) then
				b = radea[1] + math.rad(360)
			else
				b = radea[currentRadius + 1]
			end
		end
		
		-- difference
		-- defines the entry size: <= 2 = closed, 2.5 = small, 3 = medium, 4 = large, 6 = very large
		local d = (b - c) / _generationData.GateSize
		
		local x = r * math.cos(delta) + maphalf
		local y = r * math.sin(delta) + maphalf
		
		-- create fence or gate
		if delta > c + d and delta < b - d then
		
			-- leave gap or create gate
			if EMS_CustomMapConfig.Peacetime > 0 then
				Logic.CreateEntity(Entities.XD_WoodenFence15, x * 100, y * 100, math.deg(delta) + 90, 0)
			end
			
		else
			Logic.CreateEntity(Entities["XD_WoodenFence0"..math.random(1,8)], x * 100, y * 100, math.deg(delta) + 90, 0)
		end
	end
	
	r = r + 10
	local l = 10 -- lerp
	
	for x = -r-l, r+l do
		for y = -r-l, r+l do
			
			local distance = math.sqrt(x^2 + y^2)
			
			if distance < r + l then
				
				-- the lazy aproach ...
				local noise = _generationData.TerrainNodes[maphalf + x][maphalf + y].noise
				local noise2 = noise / 1.8
				
				if distance > r then
					
					noise2 = Lerp( noise, noise2, (distance - r) / l )
				end
				
				_generationData.TerrainNodes[maphalf + x][maphalf + y] = RandomMapGenerator.CreateTerrainNode(_generationData, x + maphalf, y + maphalf, noise2)
			end
		end
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.FillRiverLocationTable(_generationData)
	
	_generationData.Rivers = {}
	_generationData.Rivers.Nodes = {}
	
	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	local radhalf = _generationData.PlayerRadian / 2
	local currentTeam = 0
	local teamIndex = 0
	
	_generationData.Rivers.Paths = {}
	_generationData.Rivers.MirrorAngles = {}
	
	-- find the points at the egde of the map between different teams
	for player = 1, _generationData.NumberOfPlayers do
		if _generationData.Players[player].team > currentTeam then
			currentTeam = _generationData.Players[player].team
			teamIndex = teamIndex + 1
			
			local delta = (player - 1) * _generationData.PlayerRadian

			-- add mirror angles 
			if _generationData.MirrorMap then
				
				table.insert( _generationData.Rivers.MirrorAngles, math.deg( delta ) )
			end
			
			if not _generationData.MirrorMap or teamIndex == 1 then
			
				local x = maphalf * math.cos(delta) + maphalf
				local y = maphalf * math.sin(delta) + maphalf
				
				-- dont use FindBestPoint here, since the river might not touch the map border then
				x, y = SnapToGrid(4, x, y)
				_generationData.Rivers[teamIndex] = {x = x, y = y}
				
				_generationData.Rivers.Paths[teamIndex] = {teamIndex, _generationData.NumberOfTeams + 1}
			end
		end
	end
	
	-- add the central point in the middle of the map, where all rivers merge together
	-- must be the exact center if rivers will be mirrored
	local x, y = maphalf, maphalf
	if not _generationData.MirrorMap then
		x, y = RandomMapGenerator.FindBestPoint(_generationData, maphalf, maphalf, 16, 4, -1)
	end
	_generationData.Rivers[_generationData.NumberOfTeams + 1] = {x = x, y = y}
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateRivers(_generationData)

	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	
	for i = 1, table.getn(_generationData.Rivers.Paths) do
		
		local a, b = _generationData.Rivers.Paths[i][1], _generationData.Rivers.Paths[i][2]
		local x1, y1, x2, y2 = _generationData.Rivers[a].x, _generationData.Rivers[a].y, _generationData.Rivers[b].x, _generationData.Rivers[b].y
		
		local river = AStar.FindPath( _generationData.TerrainNodes[x1][y1], _generationData.TerrainNodes[x2][y2], _generationData.TerrainNodes, RandomMapGenerator.AStar_GetNeighborNodes_River, RandomMapGenerator.AStar_GetPathCost_River )
		
		if river then
		
			local height = _generationData.TerrainBaseHeight - 663
			local noise = RandomMapGenerator.GetTerrainNoiseFromHeight(_generationData, height)

			local currNode = river[1]
			RandomMapGenerator.AddRiverNode( _generationData, currNode.x, currNode.y, 16, 6, noise, height )

 			local prevNode = currNode
 
			for j = 2, table.getn(river) do
			
				currNode = river[j]
				RandomMapGenerator.AddRiverNode( _generationData, currNode.x, currNode.y, 16, 6, noise, height )
				
				-- add the middle between two nodes so rivers and roads do not miss each other with two diagonals
				RandomMapGenerator.AddRiverNode( _generationData, (currNode.x + prevNode.x) / 2, (currNode.y + prevNode.y) / 2 )
				
				prevNode = currNode
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AddRiverNode( _generationData, _x, _y, _a, _b, _noise, _height )
	
	local maphalf = Logic.WorldGetSize() / 200
	
	for _, targetangle in ipairs( _generationData.Rivers.MirrorAngles ) do
		
		_x, _y = _x - maphalf, _y - maphalf
		_x, _y = MMT.GetMirrorPosition( math.sqrt( _x ^ 2 + _y ^ 2 ), 0, targetangle, MMT.AllignAngle( math.deg( math.atan2( _y, _x ) ), targetangle ), maphalf, 0 )
		_x, _y = Round( _x ), Round( _y )
		
		table.insert( _generationData.Rivers.Nodes, {x = _x, y = _y} )
		
		if _noise then
			RandomMapGenerator.SetNoiseOverride( _generationData, _x, _y, _a, _b, _noise, _height )
		end
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.FillRoadLocationTable(_generationData)

	_generationData.Roads = {}

	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2
	local distance = math.min(maphalf - 50, maphalf * 0.8)
	local delta, x, y
 
	-- check for specific case with nonly 2 players on 2 teams
	if _generationData.NumberOfPlayers == 2 and _generationData.NumberOfTeams == 2 then
	
		_generationData.Roads.Paths = {{1, 2}, {3, 1}, {4, 1}, {3, 2}, {4, 2}} -- from player 1 to player 2 and from imaginary player 3 and 4 to each player 1 and 2
		
		_generationData.Roads[1] = _generationData.Players[1]
		_generationData.Roads[2] = _generationData.Players[2]
		
		delta = _generationData.PlayerRadian / 2 -- 90°
		x = distance * math.cos(delta) + maphalf
		y = distance * math.sin(delta) + maphalf
		
		x, y = RandomMapGenerator.FindBestPoint(_generationData, x, y, 16, 4, 0)
		_generationData.Roads[3] = {x = x, y = y}
  
		delta = delta * 3 -- 270°
		x = distance * math.cos(delta) + maphalf
		y = distance * math.sin(delta) + maphalf
		
		x, y = RandomMapGenerator.FindBestPoint(_generationData, x, y, 16, 4, 0)
		_generationData.Roads[4] = {x = x, y = y}
	
	-- otherwise use the generic system
	else
 
		_generationData.Roads.Paths = {}
  
		-- players
		for p = 1, _generationData.NumberOfPlayers do
		
			_generationData.Roads[p] = _generationData.Players[p]
			table.insert(_generationData.Roads.Paths, {_generationData.NumberOfPlayers + 1, p}) -- from middle to player is faster than player to middle when rivers are generated, without its equal fast
   
			if p < _generationData.NumberOfPlayers then
			
				table.insert(_generationData.Roads.Paths, {p, p + 1})
			else
			
				table.insert(_generationData.Roads.Paths, {1, p})
			end
		end
  
		-- center of map
		x, y = RandomMapGenerator.FindBestPoint(_generationData, maphalf, maphalf, 16, 4, 0)
		_generationData.Roads[_generationData.NumberOfPlayers + 1] = {x = x, y = y}
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateRoads(_generationData)

	local mapsize = Logic.WorldGetSize() / 100
	local bridges = {}
	
	for i = 1, table.getn(_generationData.Roads.Paths) do
		
		local a, b = _generationData.Roads.Paths[i][1], _generationData.Roads.Paths[i][2]
		local x1, y1, x2, y2 = _generationData.Roads[a].x, _generationData.Roads[a].y, _generationData.Roads[b].x, _generationData.Roads[b].y

		local road = AStar.FindPath ( _generationData.TerrainNodes[x1][y1], _generationData.TerrainNodes[x2][y2], _generationData.TerrainNodes, RandomMapGenerator.AStar_GetNeighborNodes_Road, RandomMapGenerator.AStar_GetPathCost_Road )
		
		if road then
  
			local nodeA, nodeB
			local n = 0
			
			for j = 2, table.getn(road) do
			
				if n ~= 0 then
					break
				end
				
				nodeA = road[j]
				nodeB = road[j-1]
				
				x1, y1, x2, y2 = nodeA.x, nodeA.y, (nodeA.x + nodeB.x) / 2, (nodeA.y + nodeB.y) / 2
				
				if _generationData.Rivers then
				
					for k = 1, table.getn(_generationData.Rivers.Nodes) do
					
						nodeB = _generationData.Rivers.Nodes[k]
						
						if (x1 == nodeB.x or x2 == nodeB.x) and (y1 == nodeB.y or y2 == nodeB.y) then
						
							n = j
							--x, y = nodeA.x, nodeA.y
							break
						end
					end
				end
			end
  
			-- reroute road to bridge entry points
			if n ~= 0 then

				nodeB = road[math.max(n - 4, 1)]
				local nodeC = road[math.min(n + 4, table.getn(road))]
				
				local x, y = math.abs(nodeB.x - nodeC.x), math.abs(nodeB.y - nodeC.y)
				local b, c = math.max(n - 8, 1), math.min(n + 8, table.getn(road))
				
				local nodeB = road[b]
				local nodeC = road[c]
				
				local ax, ay, bridge
   
				if x > y then
				
					ax, ay = 16, 0
					bridge = {Placement = {AbsolutX = nodeA.x, AbsolutY = nodeA.y,}, Data = RandomMapGenerator.StructureSets.Bridge1,}
				else
				
					ax, ay = 0, 16
					bridge = {Placement = {AbsolutX = nodeA.x, AbsolutY = nodeA.y,}, Data = RandomMapGenerator.StructureSets.Bridge2,}
				end
				
				local isblocked = false
				
				for _,v in pairs(bridges) do
					
					if IsInRange(v.Placement.AbsolutX, v.Placement.AbsolutY, bridge.Placement.AbsolutX, bridge.Placement.AbsolutY, 28.14) then -- sqrt( 20 ^ 2 + 20 ^ 2 ) = 28.28
						isblocked = true
					end
				end
				
				if not isblocked then
					table.insert(bridges, bridge)
				end
				--table.insert(_generationData.Structures.Childs[0].Childs, bridge)
			end
   
				--[[x, y = nodeA.x - ax, nodeA.y - ay
    
				if (x - nodeB.x) ^ 2 + (y - nodeB.y) ^ 2 > (x - nodeC.x) ^ 2 + (y - nodeC.y) ^ 2 then
					nodeA = nodeB -- save
					nodeB = nodeC -- switch
					nodeC = nodeA -- nodeB
					--local a = b
					--b = c
					--c = a
				end
     
				-- now B is the lower node
				local raod1 = AStar.FindPath ( _generationData.TerrainNodes[x][y], _generationData.TerrainNodes[nodeB.x][nodeB.y], _generationData.TerrainNodes, RandomMapGenerator.AStar_GetNeighborNodes_Road, RandomMapGenerator.AStar_GetPathCost_Road )
   
				x, y = x + ax * 2, y + ay * 2
   
				local road2 = AStar.FindPath ( _generationData.TerrainNodes[x][y], _generationData.TerrainNodes[nodeC.x][nodeC.y], _generationData.TerrainNodes, RandomMapGenerator.AStar_GetNeighborNodes_Road, RandomMapGenerator.AStar_GetPathCost_Road )
			end
   
			for i = c, b, -1 do
				table.remove(road, i)
			end

			for i = 1, table.getn(road1) do
				table.insert(road, {x = road1[i].x, y = road1[i].y})
			end
			
			for i = 1, table.getn(road2) do
				table.insert(road, {x = road2[i].x, y = road2[i].y})
			end]]
			
			local height = RandomMapGenerator.GetTerrainHeightFromNoise(_generationData, _generationData.ThresholdRoad) - 150
			local noise = _generationData.ThresholdRoad
			
			local currNode = road[1]
			
			if _generationData.TerrainNodes[currNode.x][currNode.y].blocking ~= RandomMapGenerator.BlockingTypes.River then
				RandomMapGenerator.SetNoiseOverride(_generationData, currNode.x, currNode.y, 6, 1, noise, height)
			end
			
			local prevNode = currNode
			
			for j = 2, table.getn(road) do
		
				currNode = road[j]
				
				-- same as for rivers we need at least the middle node to make shure river and road dont miss each other at a diagonal
				for k = 4, 1, -1 do
				
					local x,y = Lerp(currNode.x, prevNode.x, k/4), Lerp(currNode.y, prevNode.y, k/4)
					
					if _generationData.TerrainNodes[x][y].blocking ~= RandomMapGenerator.BlockingTypes.River then
						RandomMapGenerator.SetNoiseOverride(_generationData, x, y, 6, 1, noise, height)
					end
				end
				
				prevNode = currNode
			end
		end
	end
	
	for _,v in pairs(bridges) do
		table.insert(_generationData.Structures.Childs[0].Childs, v)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetNoiseOverride(_generationData, _nodeX, _nodeY, _radius, _lerpRadius, _noise, _height)
	
	local mapsize = Logic.WorldGetSize() / 100
	
	local x1, x2, y1, y2 = math.max(_nodeX - _radius, 0), math.min(_nodeX + _radius, mapsize), math.max(_nodeY - _radius, 0), math.min(_nodeY + _radius, mapsize)
	local radiusSq = _radius ^ 2
	
	for x = x1, x2 do
		for y = y1, y2 do
			if IsInRangeSq(x, y, _nodeX, _nodeY, radiusSq) then -- acts like the first check
			
				local dist = RTFGetDistance(x, y, _nodeX, _nodeY)
			
			--if dist < _radius then
				
				local factor = 0 -- 1 = old, 0 = new
				
				if dist > _lerpRadius then -- seccond check
					factor = (dist - _lerpRadius) / (_radius - _lerpRadius)
				end
				
				local override = _generationData.TerrainNodes[x][y].override
				
				if override then --and override.noise == _noise
					_generationData.TerrainNodes[x][y].override.factor = math.min(override.factor, factor)
				else
					_generationData.TerrainNodes[x][y].override = {noise = _noise, height = _height, factor = factor}
				end
				
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.ApplyNoiseOverride(_generationData, _mode, _func)

	local mapsize = Logic.WorldGetSize() / 100
	
	for x = 0, mapsize do
		for y = 0, mapsize do
		
			local override = _generationData.TerrainNodes[x][y].override
			
			if override then
			
				local height = CurvedLerp(_generationData.TerrainNodes[x][y].height, override.height, override.factor)
				
				if _func then
					height = _func(_generationData.TerrainNodes[x][y].height, height)
				end
				
				local noise
				
				if _mode == RandomMapGenerator.BlockingTypes.River then -- river
					noise = RandomMapGenerator.GetTerrainNoiseFromHeight(_generationData, height)
				else
					noise = CurvedLerp(_generationData.TerrainNodes[x][y].noise, override.noise, override.factor)
				end
				
				_generationData.TerrainNodes[x][y].noise = noise
				_generationData.TerrainNodes[x][y].height = height
				
				-- we set blocking on rivers and roads
				if override.factor < 0.5 then
					_generationData.TerrainNodes[x][y].blocking = _mode
				end
				
				_generationData.TerrainNodes[x][y].override = nil
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- AStar Utility
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetNeighborNodes( _thisNode, _nodes, _steps )
 
 local mapsize = Logic.WorldGetSize() / 100
 local maphalf = mapsize / 2
 local neighbors = {}
 local node
 local x1, x2, y1, y2 = math.max(_thisNode.x - _steps, 0), math.min(_thisNode.x + _steps, mapsize), math.max(_thisNode.y - _steps, 0), math.min(_thisNode.y + _steps, mapsize)
 
 for x = x1, x2, _steps do
  for y = y1, y2, _steps do
   node = _nodes[x][y]
   if (node.x ~= _thisNode.x or node.y ~= _thisNode.y) and IsInRange(node.x, node.y, maphalf, maphalf, maphalf) then --  - _steps
    table.insert ( neighbors, node )
   end
  end
 end
 
	return neighbors
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetNeighborNodes_Road( _thisNode, _nodes )
 return RandomMapGenerator.AStar_GetNeighborNodes( _thisNode, _nodes, 4 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetNeighborNodes_River( _thisNode, _nodes )
 return RandomMapGenerator.AStar_GetNeighborNodes( _thisNode, _nodes, 4 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- fast distance calculation for neighboring nodes
 -- if x or y values are equal, subtraction is zero resultig in multiplication with zero so dist = 1 + 0 * 0.414 = 1.0
 -- where if both are not equal, the result is eather 1 or -1 which results in 1 so dist = 1 + 1 * 0.414 = 1.414
 -- river nodes have a higher distance since only every 4th node is used so 4 + 16 * 0.104 = 5.657 = 4 * 1.414
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetPathDist( _nodeA, _nodeB, _straight, _diagonalFraction )
 return _straight + math.abs( (_nodeA.x - _nodeB.x) * (_nodeA.y - _nodeB.y) ) * _diagonalFraction
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetPathCost_Road ( _nodeA, _nodeB )
 local cost = math.abs(( _nodeA.noise + _nodeB.noise ) / 2 ) * 25.0; -- adjust factor by needs
 return RandomMapGenerator.AStar_GetPathDist ( _nodeA, _nodeB, 1.0, 1.41421353816986083984375 ) * cost;
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.AStar_GetPathCost_River ( _nodeA, _nodeB )
 local cost = (( _nodeA.noise + _nodeB.noise ) / 4.0 + 0.5) * 2.5 -- adjust factor by needs
 return RandomMapGenerator.AStar_GetPathDist ( _nodeA, _nodeB, 4.0, 0.103553391993045806884765625 ) * cost
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Set Terrain Textures
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.SetTerrainTextures(_generationData)

	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2

 	for x = 0, mapsize, 4 do
		for y = 0, mapsize, 4 do
			if math.sqrt((x - maphalf)^2 + (y - maphalf)^2) < maphalf then
				RandomMapGenerator.SetRandomTexture(x, y, _generationData.LandscapeSet.Textures[RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[x][y].noise)])
			end
		end
	end
	
	Logic.WaterSetType(0, 0, mapsize, mapsize, _generationData.LandscapeSet.Water)
	Logic.WaterSetAbsoluteHeight(0, 0, mapsize, mapsize, _generationData.WaterBaseHeight)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetRandomVertexColor(_generationData, _nodeX, _nodeY)
	
	local colors = _generationData.LandscapeSet.VertexColors
	local key = RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[_nodeX][_nodeY].noise)
	
	if colors and colors[key] then
	
		local color = GetRandomValueFromTable(colors[key])
		Logic.SetTerrainVertexColor(_nodeX, _nodeY, color.r, color.g, color.b)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetRandomTexture(_nodeX, _nodeY, _textures)

	if _textures then
	
		Logic.SetTerrainNodeType(_nodeX, _nodeY, GetRandomValueFromTable(_textures))
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function GetRandomValueFromTable(_table)

	if type(_table) == "table" then
	
		return _table[math.random(1, table.getn(_table))]
	end
	
	return _table
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetBiomeKey(_generationData, _noise) -- this way, we can use the same biome logic for terrain and entities

	if _noise > _generationData.ThresholdPike then
		return "Pike"
	elseif _noise > _generationData.ThresholdHighMeadow then
		return "HighMeadow"
	elseif _noise > _generationData.ThresholdHighForest then
		return "HighForest"
	elseif _noise > _generationData.ThresholdMountain then
		return "Mountain"
	elseif _noise > _generationData.ThresholdHill then
		return "Hill"
	elseif _noise > _generationData.ThresholdForest then
		return "Forest"
	elseif _noise > _generationData.ThresholdMeadow then
		return "Meadow"
	elseif _noise > _generationData.ThresholdRoad then
		return "Flatland"
	elseif _noise < _generationData.ThresholdSea then
		return "Sea"
	elseif _noise < _generationData.ThresholdLake then
		return "Lake"
	elseif _noise < _generationData.ThresholdCoast then
		return "Coast"
	elseif _noise < _generationData.ThresholdLowForest then
		return "LowForest"
	elseif _noise < _generationData.ThresholdLowMeadow then
		return "LowMeadow"
	elseif _noise < _generationData.ThresholdRoad then
		return "LowFlatland"
	elseif _noise == _generationData.ThresholdRoad then
		return "Road"
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Set Terrain Heights
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.SetTerrainHeights(_generationData)
 
	local mapsize = Logic.WorldGetSize() / 100
	local maphalf = mapsize / 2

	for x = 0, mapsize do
		for y = 0, mapsize do
		
			Logic.SetTerrainNodeHeight(x, y, _generationData.TerrainNodes[x][y].height)
			
			-- this is more a textures thing but since textures use a 4 stepped loop we do it here
			if math.sqrt((x - maphalf)^2 + (y - maphalf)^2) < maphalf then
				RandomMapGenerator.SetRandomVertexColor(_generationData, x, y)

				--if _generationData.TerrainNodes[x][y].blocking ~= 0 then
					--Logic.SetTerrainVertexColor(x, y, 255, 128, 128)
				--end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetTerrainHeightFromNoise(_generationData, _noise)
	
	-- experimental 
	--[[if _noise > 0 then
		_noise = math.sin((_noise - 1) * math.pi / 2) + 1
	else
		_noise = math.sin((_noise + 0.5) * math.pi) / 2 - 0.5
	end]]
		
	if _noise < 0 then --_generationData.ThresholdRoad then
		_noise = math.min( _noise - _generationData.ThresholdLowFlatland, 0 ) / ( 1 + _generationData.ThresholdLowFlatland )
	else
		_noise = math.max( math.min(_noise, _generationData.ThresholdPlateau) - _generationData.ThresholdFlatland, 0 ) / ( 1 - _generationData.ThresholdFlatland ) * (2 - _generationData.ThresholdPlateau)
	end
	
	return math.max(_noise * _generationData.NoiseFactorZ + _generationData.TerrainBaseHeight, 0)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- this must be the reverse function to RandomMapGenerator.GetTerrainHeightFromNoise
function RandomMapGenerator.GetTerrainNoiseFromHeight(_generationData, _height)

	local _height = math.max(math.min((_height - _generationData.TerrainBaseHeight) / _generationData.NoiseFactorZ, 1), -1)
	
	if _height < 0 then
		return _height * ( 1 + _generationData.ThresholdLowFlatland ) + _generationData.ThresholdLowFlatland
	end
	
	return _height * ( 1 - _generationData.ThresholdFlatland ) + _generationData.ThresholdFlatland
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Generate Structures
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.GenerateStructures(_generationData)
		
	local success = false
	local failure = false
	
	while not success and not failure do
		success, failure = RandomMapGenerator.GenerateStructure(_generationData)
	end
	
	if failure then
		GUI.AddStaticNote("@color:255,0,0,255 RandomMapGenerator ERROR: Auf der Karte ist nicht genug Platz um alle Strukturen platzieren zu können. @cr @color:255,255,255 Ändert den Seed oder verwendet eine größere Karte.")-- oder verringert die Anzahl an Strukturen.")
		return false
	end
	
	return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GenerateStructure(_generationData)
 
	local struct = RandomMapGenerator.GetCurrentStruct(_generationData)
	local parent = RandomMapGenerator.GetCurrentParentData(_generationData)
 
	local placement, x, y, forcePlacement
	local noise, noiseMin, noiseMax, symetric = 0, -1, 1, true
 
	if not struct.Placement then
	
		x, y = parent.X, parent.Y
		forcePlacement = true
	else
		placement = struct.Placement
  
		if placement.AbsolutX then
		
			x, y = placement.AbsolutX, placement.AbsolutY
			forcePlacement = true
			
		elseif placement.RelativX then
		
			x, y = placement.RelativX + parent.X, placement.RelativY + parent.Y
			forcePlacement = true
		else
		
			forcePlacement = false
			
			symetric = not placement.Asymetric
			noiseMin = placement.NoiseMin or -1
			noiseMax = placement.NoiseMax or  1
		end
	end

	local blocking = 0
	
	if struct.Data and struct.Data.Blocking then
	
		blocking = struct.Data.Blocking
	end

	local node = false
 
	if not forcePlacement then
		
		local areamax = placement.AreaMax
		
		if placement.AreaMax then
			
			node = RandomMapGenerator.GetRandomPosition(_generationData, struct, parent, placement.Grid)
			
			if node then
				x, y = node.x, node.y
			end
		
		else
			x, y = parent.X, parent.Y
			forcePlacement = true
		end
	end
	
	if forcePlacement or node then
  
		if _generationData.MirrorMap and RandomMapGenerator.StructGetCurrentPlayer(_generationData) > 0 then
			for p = 2, _generationData.NumberOfPlayers do
				
				local mx, my = RandomMapGenerator.MirrorNode(_generationData, x, y, p)
				mx, my = Round(mx), Round(my)
				RandomMapGenerator.CreateStructure(_generationData, struct, mx, my, _generationData.Players[p])--, true) -- this works without doNotRegister since player 1 is set at last below
			end
		end
		
		-- if MirrorMap is true, this is player 1 and needs to be the last call to get the positioning for mirror sources right
		RandomMapGenerator.CreateStructure(_generationData, struct, x, y, _generationData.Players[RandomMapGenerator.StructGetCurrentPlayer(_generationData)])
				
		-- never change anything in the following lines !!!
		local level = _generationData.Structures.Current.Levels[0]
		
		if struct.Childs and table.getn(struct.Childs) > 0 then
			
			level = level + 1
			_generationData.Structures.Current.Levels[0] = level
			_generationData.Structures.Current.Levels[level] = 1
     
			return false, false
		else
  
			while level > 0 do
				if _generationData.Structures.Current.Levels[level] < table.getn(RandomMapGenerator.GetStructByLevel(_generationData, level-1).Childs) then
				
					_generationData.Structures.Current.Levels[level] = _generationData.Structures.Current.Levels[level] + 1
     
					return false, false
				else
				
					_generationData.Structures.Current.Levels[level] = 1
					_generationData.Structures.Current.Levels[0] = _generationData.Structures.Current.Levels[0] - 1
					level = level - 1
					-- do not call return here, there could be more levels finished
				end
			end
			
			 -- this is only called if level reaches 0, so the generation is finished
			return true, false
		end
	end

	return false, true
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetCurrentParent(_generationData)
 return RandomMapGenerator.GetStructByLevel(_generationData, _generationData.Structures.Current.Levels[0] - 1)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetCurrentStruct(_generationData)
 return RandomMapGenerator.GetStructByLevel(_generationData, _generationData.Structures.Current.Levels[0])
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetStructByLevel(_generationData, _level)
 local struct = _generationData.Structures
 
 for l = 1, _level do
  struct = struct.Childs[_generationData.Structures.Current.Levels[l]]
 end
 return struct
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetCurrentParentData(_generationData)
 return RandomMapGenerator.GetStructDataByLevel(_generationData, _generationData.Structures.Current.Levels[0] - 1)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetCurrentStructData(_generationData)
 return RandomMapGenerator.GetStructDataByLevel(_generationData, _generationData.Structures.Current.Levels[0])
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetStructDataByLevel(_generationData, _level)
 local struct = _generationData.Structures.Current.Structs
 
 for l = 1, _level do
  struct = struct.Childs[_generationData.Structures.Current.Levels[l]]
 end
 return struct
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetCurrentStructData(_generationData, _nodeX, _nodeY, _radius)
	
	local mapsize = Logic.WorldGetSize() / 100
	local x1, x2, y1, y2 = math.max(_nodeX - _radius, 0), math.min(_nodeX + _radius, mapsize), math.max(_nodeY - _radius, 0), math.min(_nodeY + _radius, mapsize)
	
	for x = x1, x2 do
		for y = y1, y2 do
			
			if RTFGetDistance(x, y, _nodeX, _nodeY) < _radius then
			
				_generationData.TerrainNodes[x][y].blocking = RandomMapGenerator.BlockingTypes.Structure
			end
		end
	end
	
	RandomMapGenerator.SetStructDataBylevel(_generationData, _generationData.Structures.Current.Levels[0], _nodeX, _nodeY, _radius)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.SetStructDataBylevel(_generationData, _level, _x, _y, _Blocking)
 local struct = _generationData.Structures.Current.Structs
 for l = 1, _level do
  if not struct.Childs then
   struct.Childs = {}
  end
  if not struct.Childs[_generationData.Structures.Current.Levels[l]] then
   struct.Childs[_generationData.Structures.Current.Levels[l]] = {}
  end
  struct = struct.Childs[_generationData.Structures.Current.Levels[l]]
 end
 struct.X = _x
 struct.Y = _y
 struct.Blocking = _Blocking
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.StructGetCurrentPlayer(_generationData)
 return math.min(_generationData.Structures.Current.Levels[1], 16)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.IsAvailableMapIndex(_generationData, _nodeX, _nodeY, _radius)
	
	local mapsize = Logic.WorldGetSize() / 100
	local x1, x2, y1, y2 = _nodeX - _radius, _nodeX + _radius, _nodeY - _radius, _nodeY + _radius
	
	if x1 < 0 or x2 > mapsize or y1 < 0 or y2 > mapsize then
		return false
	end
	
	for x = x1, x2 do
		for y = y1, y2 do
			
			if RTFGetDistance(x, y, _nodeX, _nodeY) < _radius and _generationData.TerrainNodes[x][y].blocking ~= 0 then
				return false
			end
		end
	end
	
	return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateStructure(_generationData, _struct, _x, _y, _player, _doNotRegister)
 
	-- Data
	if _struct.Data then
		local data = _struct.Data
		
		if not _doNotRegister then
			RandomMapGenerator.SetCurrentStructData(_generationData, _x, _y, data.Blocking or 0)
		end
		
		-- Entities
		if data.Entities then
			for i = 1, table.getn(data.Entities) do
				
				local entity = {}
				entity.data = data.Entities[i]
				entity.x = _x * 100
				entity.y = _y * 100
				entity.p = data.Entities[i].Player or _player.id
				
				if _player.ishuman == 1 or ((not entity.data.SkipDummy) and (not entity.data.Explore)) then
					table.insert(_generationData.Entities, entity)
				end
			end
		end
		
		-- Terrain Heights
		if data.TerrainHeights then
			
			local heights = data.TerrainHeights
			local area = heights.Area or 10
			local lerpdist = heights.LerpDist or 8
			local x1, y1, x2, y2, areasq, isrect = RandomMapGenerator.GetAreaData(area)
			
			local height, dist
			local baseheight = heights.BaseHeight or math.max(_generationData.WaterBaseHeight + 100, _generationData.TerrainNodes[_x][_y].height)--_generationData.TerrainBaseHeight--
			
			for x = x1, x2 do
				for y = y1, y2 do
					if IsValidMapIndex(0, x + _x, y + _y) and (isrect or IsInRangeSq(0, 0, x, y, areasq)) then
						
						if heights[x] then
							height = heights[x][y] or 0
						else
							height = 0
						end
						
						height = height + baseheight
						
						if isrect then
							dist = math.min(math.abs(x1 - x), math.abs(y1 - y), math.abs(x2 - x), math.abs(y2 - y)) -- shortest dist to border
						else
							dist = area - RTFGetDistance(0, 0, x, y) -- 0 because its a relativ index
						end
						
						if dist < lerpdist then
							height = CurvedLerp(height, _generationData.TerrainNodes[x + _x][y + _y].height, (dist + .0) / (lerpdist +.0))
						end
						
						_generationData.TerrainNodes[x + _x][y + _y].height = height
					end
				end
			end
		end
		
		-- Terrain Textures
		if data.TerrainTextures then
			
			local textures = data.TerrainTextures
			
			local area = textures.Area or 10
			local x, y = textures.RelativX or 0, textures.RelativY or 0
			local x1, y1, x2, y2, areasq, isrect = RandomMapGenerator.GetAreaData(area)
   
			local px, py = SnapToGrid(4, _x + x, _y + y)
			x1, y1 = FloorToGrid(4, px + x1, py + y1)
			x2, y2 = CeilToGrid(4, px + x2, py + y2)
			
			local textureList = textures.TextureList or TerrainTypes.EdgeColor01_AT
			
			if type(textureList) == "string" then
				textureList = _generationData.LandscapeSet.Textures[textureList]
			end
			
			for x = x1, x2, 4 do
				for y = y1, y2, 4 do
					if isrect or IsInRangeSq(x, y, _x, _y, areasq) then
						RandomMapGenerator.SetRandomTexture(x, y, textureList)
					end
				end
			end
		end
		
		-- Water
		if data.Water then
			
			local water = data.Water
			
			local area = water.Area or 4 -- default for resource pits
			local x1, y1, x2, y2, areasq, isrect = RandomMapGenerator.GetAreaData(area)
			
			local px, py = SnapToGrid(4, _x, _y)
			x1, y1 = FloorToGrid(4, px + x1, py + y1)
			x2, y2 = CeilToGrid(4, px + x2, py + y2)
   
			local height = water.Height or 0
			Logic.WaterSetAbsoluteHeight(x1, y1, x2, y2, height)
   
			if water.Type then
				Logic.WaterSetType(x1, y1, x2, y2, water.Type)
			end
		end
  
	else
		RandomMapGenerator.SetCurrentStructData(_generationData, _x, _y, 0)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetAreaData(_area)
 local x1, y1, x2, y2, areasq, isrect
 
 if type(_area) == "number" then
  x1, y1, x2, y2 = -_area, -_area, _area, _area
  areasq = _area ^ 2
  isrect = false
 else --if type(_area) == "table" then
  areasq = 0--2 * _area ^ 2
  isrect = true
  if _area.x then
   x1, y1, x2, y2 = -_area.x, -_area.y, _area.x, _area.y
  else --if _area.x1 then
   x1, y1, x2, y2 = _area.x1, _area.y1, _area.x2, _area.y2
  end
 end
 
 return x1, y1, x2, y2, areasq, isrect
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- this function shall only be called if _struct.Placemant is valid
function RandomMapGenerator.GetRandomPosition(_generationData, _struct, _parent, _grid)
	
	-- get the overall area
	local x1, y1, x2, y2, areasq1, isrect1 = RandomMapGenerator.GetAreaData(_struct.Placement.AreaMax)
	
	-- and the excluded inner area
	local x3, y3, x4, y4, areasq2, isrect2 = 0,0,0,0,0,true
	
	if _struct.Placement.AreaMin then
		x3, y3, x4, y4, areasq2, isrect2 = RandomMapGenerator.GetAreaData(_struct.Placement.AreaMin)
	end
	
	local bestNoise = _struct.Placement.Noise
		
	if not bestNoise then
		local noiseMax = _struct.Placement.NoiseMax or 1
		local noiseMin = _struct.Placement.NoiseMin or -noiseMax
		bestNoise = (noiseMin + noiseMax) / 2
	end
	
	local blocking = 0
	
	if _struct.Data.Blocking then
		blocking = _struct.Data.Blocking
	end
	
	local maphalf = Logic.WorldGetSize() / 200
	local l = {}
	
	if _grid then
		x1, y1 = CeilToGrid(_grid, x1, y1)
		x2, y2 = FloorToGrid(_grid, x2, y2)
	end
	
	local step = _grid or 1
	
	for x = x1, x2, step do
		for y = y1, y2, step do
		
			-- is inside outer area ?
			local nx, ny = x +_parent.X, y +_parent.Y
			if (isrect1 or IsInRangeSq(0, 0, x, y, areasq1)) and RTFGetDistance(nx, ny, maphalf, maphalf) <= maphalf - blocking then --IsValidMapIndex(0, xn, yn) and 
			
				-- is outside inner area ?
				if not ((isrect2 and x > x3 and y > y3 and x < x4 and y < y4) or (not isrect2 and IsInRangeSq(0, 0, x, y, areasq2))) then
					
					local dif = math.abs(_generationData.TerrainNodes[nx][ny].noise - bestNoise)
					table.insert(l, {dif = dif, x = nx, y = ny})
				end
			end
		end
	end
	
	table.sort(l,
    function(e, e2)
        return e.dif < e2.dif;
    end
	);
	
	for _,v in pairs(l) do
		if RandomMapGenerator.IsAvailableMapIndex(_generationData, v.x, v.y, blocking) then
			return v
		end
	end
	
	return false
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetRandomPositionAtDistance(_key, _x, _y, _r)
 local a = SimplexNoise.GetRandomByNoise(-_r, _r, _key)
 --local a = math.random(-_r, _r)
 local b = math.floor(math.sqrt(_r^2 - a^2) + 0.5)
 
 if SinDeg(a) < 0 then
  b = -b
 end
  
 return _x + a, _y + b
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.GetRandomPositionInDistance(_key, _x, _y, _rMin, _rMax)
 if not _rMax then
  _rMax = _rMin
  _rMin = 0
 end
 local a = SimplexNoise.GetRandomByNoise(-_rMax, _rMax, _key)
 --local a = math.random(-_rMax, _rMax)
 local bMin = 0
 if math.abs(a) < _rMin then
  bMin = math.sqrt(_rMin^2 - a^2)
 end
 local bMax = math.sqrt(_rMax^2 - a^2)
 local b = math.floor(SimplexNoise.GetRandomByNoise(bMin, bMax, _key+1) + 0.5)
 --local b = math.floor(math.random(bMin, bMax) + 0.5)
 if SinDeg(a) < 0 then
  b = -b
 end
 return _x + a, _y + b
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- this function assumes that y1 < y3 < y4 < y2
function RandomMapGenerator.GetRandomPositionInArea(_key, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
 if not _x3 then
  return SimplexNoise.GetRandomByNoise(_x1, _x2, _key), SimplexNoise.GetRandomByNoise(_y1, _y2, _key + 1)
  --return math.random(_x1, _x2), math.random(_y1, _y2)
 end
 local x = SimplexNoise.GetRandomByNoise(_x1, _x2, _key)
 --local x = math.random(_x1, _x2)
 if x < _x3 or x > _x4 then
  return x, SimplexNoise.GetRandomByNoise(_y1, _y2, _key + 1)
  --return x, math.random(_y1, _y2)
 else
  local gap = _y4 - _y3
  local y = SimplexNoise.GetRandomByNoise(_y1, _y2 - gap, _key + 1)
  --local y = math.random(_y1, _y2 - gap)
  if y > _y3 - _y1 then
   y = y + gap
  end
  return x, y
 end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function SinDeg(_value)
 return math.sin(math.rad(_value))
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function CosDeg(_value)
 return math.cos(math.rad(_value))
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Update Blocking
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.UpdateBlocking(_generationData)

	local mapsize = Logic.WorldGetSize() / 100
	Logic.UpdateBlocking(1, 1, mapsize-1, mapsize-1)
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Create Entities
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.CreateEntities(_generationData)
	
	-- structural entities
	for _,v in ipairs(_generationData.Entities) do
		RandomMapGenerator.CreateEntity(_generationData, v)
	end
	
	-- environmental entities
	-- skip if density is 0
	local density = _generationData.ForestDensity
	
	if density > 0 then
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		local maphalfsqared = maphalf ^ 2
		
		-- base value is here
		local step = 5 / density
		
		-- density only for forests ! global would hit the entity limit quite quickly
		for i = 8, mapsize - 8, step do
			
			local x = Round(i)
			
			for j = 8, mapsize - 8, step do
				
				local y = Round(j)
				local biome = RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[x][y].noise)
				
				if biome == "Forest" or biome == "LowForest" or biome == "HighForest" then
					if _generationData.TerrainNodes[x][y].blocking == 0 and IsInRangeSq(x, y, maphalf, maphalf, maphalfsqared) then
					
						local entitytable = _generationData.LandscapeSet.Entities[RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[x][y].noise)]
						RandomMapGenerator.CreateRandomEntity(i * 100, j * 100, entitytable)
					end
				end
			end
		end
		
		-- and now everything else in the known way
		for x = 8, mapsize - 8, 3 do
			for y = 8, mapsize - 8, 3 do
			
				local biome = RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[x][y].noise)
				
				if biome ~= "Forest" and biome ~= "LowForest" and biome ~= "HighForest" then
					if _generationData.TerrainNodes[x][y].blocking == 0 and IsInRangeSq(x, y, maphalf, maphalf, maphalfsqared) then
					
						local entitytable = _generationData.LandscapeSet.Entities[RandomMapGenerator.GetBiomeKey(_generationData, _generationData.TerrainNodes[x][y].noise)]
						RandomMapGenerator.CreateRandomEntity(x * 100, y * 100, entitytable)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateEntity(_generationData, _entity)

	local entity = _entity.data
	local etype = GetRandomValueFromTable(entity.Type)
	local x, y = _entity.x, _entity.y
	
	if entity.Grid then
		x, y = SnapToGrid(entity.Grid, x, y)
	end
	
	x = x + (entity.RelativX or 0)
	y = y + (entity.RelativY or 0)
	
	local rotation = entity.Rotation or 0
	
	if rotation == -1 then
		rotation = math.random(0, 360)
	end
	
	if entity.Angle then
		rotation = SnapToGrid(entity.Angle, rotation)
	end
	
	local player = _entity.p
	local id
	
	if entity.Soldiers and type(entity.Soldiers) == "number" then
		id = Tools.CreateGroup(player, etype, entity.Soldiers, x, y, rotation)
	else
		id = Logic.CreateEntity(etype, x, y, rotation, player)
	end
	
	if entity.Explore then
		local name = entity.Name or ""
		Logic.SetEntityExplorationRange(id, entity.Explore)
		Logic.SetEntityName(id, "rmg_explore"..player.."_"..name)
		return
	end
	
	--if entity.Scale then
		--SCV.SetScale(id, entity.Scale)
	--end
	
	if entity.Resource then
		Logic.SetResourceDoodadGoodAmount(id, entity.Resource)
	end
	
	if entity.Name then
		Logic.SetEntityName(id, entity.Name)
	end
	
	if entity.Health then
		SetHealth(id, entity.Health)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RandomMapGenerator.CreateRandomEntity(_x, _y, _entities)

	if _entities then
		Logic.CreateEntity(GetRandomValueFromTable(_entities), _x + math.random(-100, 100), _y + math.random(-100, 100), math.random(0, 360), 0)
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Finalize
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.Finalize(_generationData)

	GUI.RebuildMinimapTerrain()
	
	-- set initial camera position
	if GUI.GetPlayerID() == 17 then -- observer
		Camera.ScrollSetLookAt(Logic.WorldGetSize() / 2, Logic.WorldGetSize() / 2)
	else
		for i = 1, _generationData.NumberOfPlayers do
		
			local player = _generationData.Players[i]
			
			if player.id == GUI.GetPlayerID() then
				Camera.ScrollSetLookAt(player.x * 100, player.y * 100)
				break
			end
		end
	end
	
	-- update blocking 
	--CppLogic.Logic.BlockingUpdateWeatherChange()
	-- work around
	local gfx = Logic.GetWeatherState()
	if CUtilMemory then -- try to get it more precise
		gfx = CUtilMemory.GetMemory(tonumber("0x85A3A0", 16))[0][11][10]:GetInt()
	end
	
	local weather = Logic.GetWeatherState()
	if weather == 3 then
		Logic.AddWeatherElement(1, 5, 0, gfx, 5.0, 10.0)
	else
		Logic.AddWeatherElement(3, 5, 0, gfx, 5.0, 10.0)
	end
	-- supress feedback sound does not work because the system queus the sounds if the volume is down - wtf
	--RandomMapGenerator.SoundBackup = GDB.GetValue("Config\\Sound\\FeedbackVolume")
	--Trigger.RequestTrigger( Events.LOGIC_EVENT_EVERY_SECOND, nil, RandomMapGenerator.ResetFeedbackSound, 1, {}, {GDB.GetValue("Config\\Sound\\FeedbackVolume")} )
	--StartSimpleJob("RMG_ResetFeedbackSound")
	--GDB.SetValueNoSave( "Config\\Sound\\FeedbackVolume", 0)
	--SoundOptions.UpdateSound()

	-- peacetime with rivers
	if EMS_CustomMapConfig.Peacetime > 0 and _generationData.TeamBorderType == 3 then
		for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.PB_Bridge1)) do
			DestroyEntity(id)
		end
		for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.PB_Bridge2)) do
			DestroyEntity(id)
		end
		for p = 1, RandomMapGenerator.GenerationData.NumberOfPlayers do
			ForbidTechnology(Technologies.B_Bridge, p)
		end
	end
	
	-- debug
	if _generationData.DebugMode then
		
		Game.GameTimeSetFactor(1)
		for i = 1,18 do Display.GfxSetSetFogParams(i,0,1,0,0,0,2999999,4999999) end

		--[[local mapsize = Logic.WorldGetSize() / 100
		for x = 0, mapsize do
			for y = 0, mapsize do
				if _generationData.TerrainNodes[x][y].blocking ~= 0 then
					Logic.SetTerrainVertexColor(x, y, 255, 0, 0)
				end
			end
		end]]
		
	else
		
		-- clear _generationData
		_generationData.Entities = nil
		_generationData.Rivers = nil
		_generationData.Roads = nil
		_generationData.Structures = nil
		_generationData.TerrainNodes = nil
		
		RandomMapGenerator.TextureSets = nil
		RandomMapGenerator.VertexColorSets = nil
		RandomMapGenerator.EntitySets = nil
		RandomMapGenerator.LandscapeSets = nil
	end
	
	-- start game
	if GUI.GetPlayerID() == EMS.GV.HostId or not CNetwork then
		RandomMapGenerator.EMS_GL_StartRequestYes()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RMG_ResetFeedbackSound(_volume)
--function RandomMapGenerator.ResetFeedbackSound(_volume)
	if Counter.Tick2("FeedbackSoundCounter", 15) then
		GDB.SetValueNoSave( "Config\\Sound\\FeedbackVolume", RandomMapGenerator.SoundBackup)
		--GDB.SetValueNoSave( "Config\\Sound\\FeedbackVolume", _volume)
		SoundOptions.UpdateSound()
		return true
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Game Start Callback
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.Callback_OnGameStart()
	
	local woodpilecounter = 1
	
	for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.XD_ScriptEntity)) do
		
		local name = GetEntityName(id)
		if name then
			if string.find(name, "rmg_explore") then
				-- code for minimap markers
				--[[if Logic.GetEntityExplorationRange(id) > 0 and string.find(name, "rmg_explore"..GUI.GetPlayerID().."_") then
				
					local pos = GetPosition(id)
					local col = 0
					
					if string.find(name, "blue") then
						col = 1
					elseif string.find(name, "white") then
						col = 2
					end
					
					GUI.CreateMinimapMarker(pos.X, pos.Y, col)
				end]]
			
				DestroyEntity(id)
				
			elseif string.find(name, "woodpile") then
				
				Logic.SetEntityName(id, "woodpile"..woodpilecounter)
				CreateWoodPile("woodpile"..woodpilecounter, EMS.RD.Rules.RMG_ContentWoodPile:GetValue())
				woodpilecounter = woodpilecounter + 1
			end
		else
			DestroyEntity(id)
		end
	end
	
	--RandomMapGenerator = nil
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Peacetime Callback
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.Callback_OnPeacetimeEnded()
	
	if RandomMapGenerator.GenerationData.TeamBorderType == 2 then
	
		for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.XD_WoodenFence15)) do
			DestroyEntity(id)
		end
		
	elseif RandomMapGenerator.GenerationData.TeamBorderType == 3 then
		
		for p = 1, RandomMapGenerator.GenerationData.NumberOfPlayers do
			AllowTechnology(Technologies.B_Bridge, p)
		end
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Utility
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- linear interpolation of two values
function Lerp(_a, _b, _factor)
	return _a * _factor + _b * (1.0 - _factor)
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- curved interpolation of two values
function CurvedLerp(_a, _b, _factor)
 return Lerp(_a, _b, math.sin((_factor - 0.5) * math.pi) / 2.0 + 0.5)
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- faster distance check than using math.sqrt
function IsInRange(_x1, _y1, _x2, _y2, _range)
 return IsInRangeSq(_x1, _y1, _x2, _y2, _range ^ 2)
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- faster distance check than using math.sqrt
function IsInRangeSq(_x1, _y1, _x2, _y2, _rangesqared)
 return (_x1 - _x2) ^ 2 + (_y1 - _y2) ^ 2 < _rangesqared
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- aligns values to a given grid size
function SnapToGrid(_grid, ...)
 for i,v in ipairs(arg) do
  arg[i] = math.floor(v / _grid + 0.5) * _grid
 end
 return unpack(arg)
end

function FloorToGrid(_grid, ...)
 for i,v in ipairs(arg) do
  arg[i] = math.floor(v / _grid) * _grid
 end
 return unpack(arg)
end

function CeilToGrid(_grid, ...)
 for i,v in ipairs(arg) do
  arg[i] = math.ceil(v / _grid) * _grid
 end
 return unpack(arg)
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- converts a position to an index aligned to a given grid size
function PositionToIndex(_grid, _x, _y)
 local mapsize = Logic.WorldGetSize() / 100
 _x, _y = SnapToGrid(_grid, _x, _y)
 return math.max(math.min(_x / 100, mapsize), 0), math.max(math.min(_y / 100, mapsize), 0) -- 100 not _grid is correct
end

--- author:RobbiTheFox		current maintainer:RobbiTheFox		v1.0
-- checks if position is within distance to map center
-- if no distance is given, the intended circular map is checked
function IsValidMapPosition(_x, _y, _dist)
 _dist = _dist or 0
 
 local maphalf = Logic.WorldGetSize() / 2
 return IsInRange(_x, _y, maphalf, maphalf, maphalf - _dist)
end

function IsValidMapIndex(_dist, ...)--_x, _y)
 local mapsize = Logic.WorldGetSize() / 100
 for i,v in ipairs(arg) do
  if arg[i] < _dist or arg[i] > mapsize - _dist then
   return false
  end
 end
 return true
 --return _x >= 0 and _x <= mapsize and _y >= 0 and _y <= mapsize
end

function MakePositionValid(...)
 local mapsize = Logic.WorldGetSize()
 for i,v in ipairs(arg) do
  arg[i] = math.max(math.min(v, mapsize), 0)
 end
 return unpack(arg)
end

function MakeIndexValid(...)
 local mapsize = Logic.WorldGetSize() / 100
 for i,v in ipairs(arg) do
  arg[i] = math.max(math.min(v, mapsize), 0)
 end
 return unpack(arg)
end

function RTFGetDistance(_x1, _y1, _x2, _y2)
	return math.sqrt((_x1 - _x2)^2 + (_y1 - _y2)^2)
end
-- bool <-> number conversion
function Bool2Num(_b)
 if _b then
  return 1;
 end
 return 0;
end
function Num2Bool(_n)
 if _n == 0 then
  return false;
 end
 return true; 
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- override EMS StartRequest
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RandomMapGenerator.EMS_GL_StartRequestYes = EMS.GL.StartRequestYes
EMS.GL.StartRequestYes = function()
	if EMS.UseCNetwork then -- TODO: refactor Sync.Call, so sync call works as a substitute.
		Sync.Call("EMS.GL.SetRulesByConfig", Sync.TableToString(EMS.RD.GetRuleConfig()));
	else
		Sync.Call("EMS.GL.SetRulesByConfig", EMS.RD.GetRuleConfig());
	end
	
	if CNetwork then
		CNetwork.SendCommand("RandomMapGenerator.GenerateMap")
	else
		RandomMapGenerator.GenerateMap()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
if CNetwork then
	CNetwork.SetNetworkHandler("RandomMapGenerator.GenerateMap", function (_name)
		RandomMapGenerator.GenerateMap(_name);
	end)
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 -- load these files at the end due to dependencies
 --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
Script.Load("maps\\user\\EMS\\tools\\rmg\\rmg_guil.lua")
Script.Load("maps\\user\\EMS\\tools\\rmg\\rmg_ruledata.lua")

RandomMapGenerator.GL_Setup()
RandomMapGenerator.SetRulesToDefault()

-- init on rule page changed, not immediately because player data is not yet available >:(
RandomMapGenerator.EMS_GL_ToggleRulePage = EMS.GL.ToggleRulePage
EMS.GL.ToggleRulePage = function( _value )
	RandomMapGenerator.PackPlayerConfig( unpack({ RandomMapGenerator.GetPlayersAndTeams() }) )
	XGUIEng.ShowWidget("RMG6", 1)
	EMS.GL.DbgShow_PlayerConfig()
	
	EMS.GL.ToggleRulePage = RandomMapGenerator.EMS_GL_ToggleRulePage
	RandomMapGenerator.EMS_GL_ToggleRulePage = nil
	EMS.GL.ToggleRulePage( _value )
end