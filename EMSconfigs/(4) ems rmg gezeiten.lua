-- ************************************************************************************************
-- *                                                                                              *
-- *                                                                                              *
-- *                                              EMS                                             *
-- *                                         CONFIGURATION                                        *
-- *                                                                                              *
-- *                                                                                              *
-- ************************************************************************************************

EMS_CustomMapConfig =
{
	-- version is set by the generator
	Version = 0,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		MapTools.RemoveFastGameEntities()
		
		AddPeriodicSummer(10);
		AddPeriodicSummer(10);
		SetupNormalWeatherGfxSet();
		LocalMusic.UseSet = MEDITERANEANMUSIC;
		
		Script.Load("maps\\user\\EMS\\tools\\rmg\\rmg.lua")
		OverrideRMG()
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		RMG.Callback_OnGameStart()
		
		-- start timeline
		LowerWater1()
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		RMG.Callback_OnPeacetimeEnded()
	end,
	
	Peacetime = 40,
	
	-- ********************************************************************************************
	--  			GameModes
	-- add as many items as you want = {"3vs3", "2vs2", "1vs1"},
	-- the callback will return you the index of the selected gamemode
	-- between 1 - max nr
	-- allows you to modify the game depending on the chosen gamemode
	-- GameMode determines the preselected value;
	GameMode = 1,
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
	end,
	
	-- ********************************************************************************************
	-- * Resource Level ( 1 = Normal, 2 = FastGame, 3 = SpeedGame )
	-- * Setting the resource level to either one, two or three will give the players the ressources
	-- * specified in the table below.
	-- * You can specify the resources for each gamemode
	-- ********************************************************************************************
	--[[
		Ressources
		You can specify the ressources for a player in one of the tables Normal, FastGame, SpeedGame
		by adding a key entry with the playerId containing 6 entries which either contain a number
		or a function that returns a number as amount for the respective ressource
		If a player is not specified, he will get the ressources of player 1
		So if you want to give the same amount of ressources to all players, just specify player 1
	]]
	ResourceLevel = 1,
	
	Ressources =
	{
		Normal = {
			[1] = {
				500,
				2400,
				1750,
				700,
				50,
				50,
			},
		},
	},
	
	-- ********************************************************************************************
	-- * Callback_OnFastGame
	-- * this function will be called alongside with Callback_OnGameStart
	-- * if the players selected fastgame or speedgame
	-- ********************************************************************************************
	Callback_OnFastGame = function()
		MapTools.RecreateFastGameEntities()
	end,

	-- ********************************************************************************************
	-- * AI Players
	-- * specify AI players to make sure their entities won't be deleted on game start
	-- ********************************************************************************************
	AIPlayers = {},
};
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- rmg rule widgets
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
if not WidgetHelper then
	Script.Load( "MP_SettlerServer\\WidgetHelper.lua" )
end

WidgetHelper.AddPreCommitCallback(
	function()
		CWidget.Transaction_AddRawWidgetsFromFile( "maps\\user\\EMS\\tools\\rmg\\EMSPagesRMG.xml" )
	end
)
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function OverrideRMG()
	
	-- this is temporary until I figure out a better way to disable certein features
	RMG.IsCustomMap = true
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	RMG.InitGenerationData_Orig = RMG.InitGenerationData
	function RMG.InitGenerationData()
		
		RMG.InitGenerationData_Orig()
		
		-- custom stuff here
		RMG.GenerationData.WaterBaseHeight = 2500 -- start a little higher
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- define fix resource and village placement here
	function RMG.GetPlayerStruct()
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		
		local noiseMin = RMG.GenerationData.ThresholdCoast
		local noiseMax = RMG.GenerationData.ThresholdHill
		
		return {
			Childs = {
				-- first island
				{
					Placement = {
						AbsolutX = Round( maphalf * 0.75 * math.cos( math.rad( 112.50 ) ) + maphalf ),
						AbsolutY = Round( maphalf * 0.75 * math.sin( math.rad( 112.50 ) ) + maphalf ),
					},
					-- Headquarter
					Data = {
						Blocking = 12,
						Entities = {
							{Type = Entities.PB_Headquarters1, SkipDummy = true},
						},
						TerrainHeights = {
						Area = {X = 18, Y = 18,},
						},
						TerrainTextures = {
							Area = {X = 8, Y = 8,},
							TextureList = "Road",
						},
					},
					-- clay mine, stone mine, village
					Childs = {},
				},
				-- seccond island
				{
					Placement = {
						AbsolutX = Round( maphalf * 0.75 * math.cos( math.rad(  67.50 ) ) + maphalf ),
						AbsolutY = Round( maphalf * 0.75 * math.sin( math.rad(  67.50 ) ) + maphalf ),
					},
					-- 2x iron mine, 2x sulfur mine, village
					Childs = {},
				},
				-- third island
				{
					Placement = {
						AbsolutX = Round( maphalf * 0.35 * math.cos( math.rad(  90.00 ) ) + maphalf ),
						AbsolutY = Round( maphalf * 0.35 * math.sin( math.rad(  90.00 ) ) + maphalf ),
					},
					-- village
					Childs = {},
				},
			},
		}
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- define additional resource and village placement here
	function RMG.FillPlayerStruct()
		
		local noiseMin = RMG.GenerationData.ThresholdCoast
		local noiseMax = RMG.GenerationData.ThresholdHill
		
		local noiseIron = RMG.GenerationData.ThresholdHill
		local noiseSulfur = RMG.GenerationData.ThresholdCoast

		local resoff = 10
		local dist = 40
		
		--vc
		for i = 1, 3 do
		
			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RMG.GenerationData.TerrainBaseHeight,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
				},
				Data = RMG.StructureSets.NeutralVillageCenter,
			}
			if i == 1 then
				child.Childs = {{Data = {Entities = {{Type = Entities.PB_VillageCenter1, SkipDummy = true}}}}}
			end

			table.insert(RMG.StructureSets.PlayerStruct.Childs[i].Childs, child)
		end
		
		-- clay
		for i = 1, 1 do
		
			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RMG.GenerationData.ThresholdCoast,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
					Grid = 4,
				},
				Data = RMG.StructureSets.ClayPit,
				Childs = {
					{
						Placement = RMG.StructureSets.Placement.PileAtPit,
						Data = RMG.StructureSets.ClayPile,
						Childs = {},
					},
				},
			}
			
			for j = 1, 3 do
				table.insert(child.Childs[1].Childs, {Placement = RMG.StructureSets.Placement.PileAtPile, Data = RMG.StructureSets.ClayPile,})
			end

			table.insert(RMG.StructureSets.PlayerStruct.Childs[1].Childs, child)
		end
		
		-- stone
		for i = 1, 1 do
		
			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RMG.GenerationData.ThresholdHill,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
					Grid = 4,
				},
				Data = RMG.StructureSets.StonePit,
				Childs = {
					{
						Placement = RMG.StructureSets.Placement.PileAtPit,
						Data = RMG.StructureSets.StonePile,
						Childs = {},
					},
				},
			}
			
			for j = 1, 3 do
				table.insert(child.Childs[1].Childs, {Placement = RMG.StructureSets.Placement.PileAtPile, Data = RMG.StructureSets.StonePile,})
			end

			table.insert(RMG.StructureSets.PlayerStruct.Childs[1].Childs, child)
		end
		
		-- wood
		for i = 2, 3 do
			
			-- 1 = first island, i = clay or stone pit, 1 = first pile, Childs = other piles
			table.insert(RMG.StructureSets.PlayerStruct.Childs[1].Childs[i].Childs[1].Childs, {Placement = RMG.StructureSets.Placement.PileAtPile, Data = RMG.StructureSets.WoodPileExplored,})
		end
		
		-- iron
		for i = 1, 2 do
		
			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = noiseIron,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
					Grid = 4,
				},
				Data = RMG.StructureSets.IronPit,
				Childs = {
					{
						Placement = RMG.StructureSets.Placement.PileAtPit,
						Data = RMG.StructureSets.IronPile,
						Childs = {},
					}
				},
			}
			
			for j = 1, 1 do
				table.insert(child.Childs[1].Childs, {Placement = RMG.StructureSets.Placement.PileAtPile, Data = RMG.StructureSets.IronPile,})
			end

			table.insert(RMG.StructureSets.PlayerStruct.Childs[2].Childs, child)
		end
		
		-- sulfur
		for i = 1, 2 do

			local child = {
				Placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = noiseSulfur,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
					Grid = 4,
				},
				Data = RMG.StructureSets.SulfurPit,
				Childs = {
					{
						Placement = RMG.StructureSets.Placement.PileAtPit,
						Data = RMG.StructureSets.SulfurPile,
						Childs = {},
					}
				},
			}
			
			for j = 1, 1 do
				table.insert(child.Childs[1].Childs, {Placement = RMG.StructureSets.Placement.PileAtPile, Data = RMG.StructureSets.SulfurPile,})
			end

			table.insert(RMG.StructureSets.PlayerStruct.Childs[2].Childs, child)
		end
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	RMG.FillNoiseTable_Orig = RMG.FillNoiseTable
	function RMG.FillNoiseTable( _generationdata )
		
		RMG.FillNoiseTable_Orig( _generationdata )
		
		-- custom stuff here
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		
		-- flatten middle
		local innerrange = Round( maphalf * 0.15 ) - 15
		local outerrange = innerrange + 45
		
		local minnoise, maxnoise = 1, -1
		local noiseaverage = 0
		
		for x = 0, innerrange do
			for y = 0, innerrange do
				
				local noise = _generationdata.TerrainNodes[ x + maphalf ][ y + maphalf ].HeightNoise
				
				minnoise = math.min( minnoise, noise )
				maxnoise = math.max( maxnoise, noise )
				
				noiseaverage = noiseaverage + noise
			end
		end
		
		noiseaverage = noiseaverage / innerrange ^ 2
		
		local noiserange = maxnoise - minnoise
		
		RMG.SimpleNoiseOverride(
			_generationdata, maphalf, maphalf, innerrange, outerrange, -0.399297853124962, 0.10 / noiserange, nil, nil,
			function( _noise, _targetrange, _targetnoise, _offset )
				
				return math.min( ( _noise - _offset ) * _targetrange + _targetnoise, -0.396626934498992 )
			end,
			noiseaverage
		)
		
		-- flatten corners
		local innerrange = Round( maphalf * 0.20 ) - 15
		local outerrange = innerrange + 45
		
		local low, high = 0.175, 0.825
		
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * low  ), Round( mapsize * low  ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * high ), Round( mapsize * low  ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * low  ), Round( mapsize * high ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * high ), Round( mapsize * high ), innerrange, outerrange, -0.352147606136882, 0.10 )
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.FillRiverLocationTable( _generationData )
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2

		_generationData.Rivers.StartPoints = {
			{ X = maphalf * 1.00 * math.cos( math.rad(  45.00 ) ) + maphalf, Y = maphalf * 1.00 * math.sin( math.rad(  45.00 ) ) + maphalf },
			{ X = maphalf * 1.00 * math.cos( math.rad(  90.00 ) ) + maphalf, Y = maphalf * 1.00 * math.sin( math.rad(  90.00 ) ) + maphalf },
			
			{ X = maphalf * 1.00 * math.cos( math.rad( 180.00 ) ) + maphalf, Y = maphalf * 1.00 * math.sin( math.rad( 180.00 ) ) + maphalf },
			{ X = maphalf * 0.67 * math.cos( math.rad(  45.00 ) ) + maphalf, Y = maphalf * 0.67 * math.sin( math.rad(  45.00 ) ) + maphalf },
			
			{ X = maphalf * 0.60 * math.cos( math.rad(  57.50 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad(  57.50 ) ) + maphalf }, -- -10
			{ X = maphalf * 0.60 * math.cos( math.rad(  90.00 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad(  90.00 ) ) + maphalf },
			
			{ X = maphalf * 0.50 * math.cos( math.rad( 135.00 ) ) + maphalf, Y = maphalf * 0.50 * math.sin( math.rad( 135.00 ) ) + maphalf },
			{ X = maphalf * 0.60 * math.cos( math.rad( 180.00 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad( 180.00 ) ) + maphalf },
			
			{ X = maphalf * 0.60 * math.cos( math.rad( 212.50 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad( 212.50 ) ) + maphalf }, -- +10
			{ X = maphalf * 0.67 * math.cos( math.rad( 225.00 ) ) + maphalf, Y = maphalf * 0.67 * math.sin( math.rad( 225.00 ) ) + maphalf },
			
			{ X = maphalf * 0.15 * math.cos( math.rad(  68.75 ) ) + maphalf, Y = maphalf * 0.15 * math.sin( math.rad(  68.75 ) ) + maphalf }, -- -10
			{ X = maphalf * 0.15 * math.cos( math.rad( 201.25 ) ) + maphalf, Y = maphalf * 0.15 * math.sin( math.rad( 201.25 ) ) + maphalf }, -- +10
		}
		for _,v in ipairs( _generationData.Rivers.StartPoints ) do
			v.X, v.Y = SnapToGrid( 4, v.X, v.Y )
		end
		
		_generationData.Rivers.Paths = 
		{
			{  4,  1 },
			{  6,  2 },
			{  8,  3 },
			
			{  4,  5 },
			{  5,  6 },
			{  6,  7 },
			{ 10,  9 },
			{  9,  8 },
			{  8,  7 },
			
			{  5, 11 },
			{  9, 12 },
		}
		_generationData.Rivers.MirrorRadea = { math.rad( 180 ) }
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.FillRoadLocationTable( _generationData )
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		
		_generationData.Roads.StartPoints = {
			{ X = maphalf * 0.75 * math.cos( math.rad( 112.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 112.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad(  67.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad(  67.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad(  90.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad(  90.00 ) ) + maphalf },
			
			{ X = maphalf * 0.75 * math.cos( math.rad( 157.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 157.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad( 202.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad( 202.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad( 180.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad( 180.00 ) ) + maphalf },

			{ X = maphalf * 0.75 * math.cos( math.rad( 292.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 292.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad( 247.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad( 247.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad( 270.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad( 270.00 ) ) + maphalf },
			
			{ X = maphalf * 0.75 * math.cos( math.rad( 337.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 337.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad(  22.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad(  22.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad(   0.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad(   0.00 ) ) + maphalf },
		}
		for _,v in ipairs( _generationData.Roads.StartPoints ) do
			v.X, v.Y = SnapToGrid( 4, v.X, v.Y )
		end
		
		_generationData.Roads.Paths = {
			{ 1, 2 },
			{ 2, 3 },
			{ 6, 3 },
			{ 4, 5 },
			{ 5, 6 },
			
			{  7,  8 },
			{  8,  9 },
			{ 12,  9 },
			{ 10, 11 },
			{ 11, 12 },
		}
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.SetCameraStart( _player )
		
		local _, hq = Logic.GetPlayerEntities( _player.Id, Entities.PB_Headquarters1, 1 )
		local pos = GetPosition( hq )
		
		Camera.ScrollSetLookAt( pos.X, pos.Y)
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.DeleteBridges()
		
		local bridges = {}
		
		for bridge in CEntityIterator.Iterator( CEntityIterator.OfCategoryFilter( EntityCategories.Bridge ) ) do
			table.insert( bridges, bridge )
		end
		
		-- sort by distance to middle
		table.sort( bridges,
			function ( a, b )
				local maphalf = Logic.WorldGetSize() / 2
				local pa, pb = GetPosition( a ), GetPosition( b )
				return ( ( pa.X - maphalf ) ^ 2 + ( pa.Y - maphalf ) ^ 2 ) < ( ( pb.X - maphalf ) ^ 2 + ( pb.Y - maphalf ) ^ 2 )
			end
		)
		
		-- delete the 4 closest bridges - lazy but it works
		for i = 1, 4 do
			DestroyEntity( bridges[ i ] )
		end
	end
	
	-- set rule data
	EMS.RD.Rules.Peacetime:SetValue( 0 )
	EMS.RD.Rules.RMG_GenerateRivers:SetValue( 3 )
	EMS.RD.Rules.RMG_LandscapeSet:SetValue( 6 )
	EMS.RD.Rules.RMG_AmountClayPit:SetValue( 1 )
	EMS.RD.Rules.RMG_AmountClayPile:SetValue( 4 )
	EMS.RD.Rules.RMG_AmountStonePit:SetValue( 1 )
	EMS.RD.Rules.RMG_AmountStonePile:SetValue( 4 )
	EMS.RD.Rules.RMG_AmountIronPit:SetValue( 2 )
	EMS.RD.Rules.RMG_AmountIronPile:SetValue( 4 )
	EMS.RD.Rules.RMG_AmountSulfurPit:SetValue( 2 )
	EMS.RD.Rules.RMG_AmountSulfurPile:SetValue( 4 )
	EMS.RD.Rules.RMG_AmountWoodPile:SetValue( 2 )
	EMS.RD.Rules.RMG_AmountVC:SetValue( 3 )
	
	-- prevent rule changes
	function EMS.RD.Rules.Peacetime:SetValue() return end
	function EMS.RD.Rules.RMG_GenerateRivers:SetValue() return end
	function EMS.RD.Rules.RMG_GenerateRoads:SetValue() return end
	function EMS.RD.Rules.RMG_LandscapeSet:SetValue() return end
	function EMS.RD.Rules.RMG_MirrorMap:SetValue() return end
	function EMS.RD.Rules.RMG_RandomPlayerPosition:SetValue() return end
	function EMS.RD.Rules.RMG_AmountClayPit:SetValue() return end
	function EMS.RD.Rules.RMG_AmountClayPile:SetValue() return end
	function EMS.RD.Rules.RMG_AmountStonePit:SetValue() return end
	function EMS.RD.Rules.RMG_AmountStonePile:SetValue() return end
	function EMS.RD.Rules.RMG_AmountIronPit:SetValue() return end
	function EMS.RD.Rules.RMG_AmountIronPile:SetValue() return end
	function EMS.RD.Rules.RMG_AmountSulfurPit:SetValue() return end
	function EMS.RD.Rules.RMG_AmountSulfurPile:SetValue() return end
	function EMS.RD.Rules.RMG_AmountWoodPile:SetValue() return end
	function EMS.RD.Rules.RMG_AmountVC:SetValue() return end
	
	RMG.LandscapeSets.Tideland.Water = WaterTypes.European_NonFreezing_Shorewave
	
	--Display.GfxSetSetFogParams(1, 0.0, 1.0, 1, 223,223,223, 0,40000)
	--Display.GfxSetSetFogParams(2, 0.0, 1.0, 1, 191,191,191, 0,25000)
	--Display.GfxSetSetFogParams(3, 0.0, 1.0, 1, 207,207,207, 0,30000)
	--Display.GfxSetSetSnowStatus(1, 0.0, 1.0, 1)
	--Display.GfxSetSetSnowStatus(2, 0.0, 1.0, 1)
	--Display.GfxSetSetSnowEffectStatus(2, 0.0, 0.8, 1)
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- timeline
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- 0 - 50
function LowerWater1()
	ChangeWaterHeight.Start( 2500, 2300, 50 * 60, Wait1 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 50 - 70
function Wait1()
	StartSimpleJob( Wait1_Job )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function Wait1_Job()
	if Counter.Tick2( "Wait1", 20 * 60 ) then
		LowerWater2()
		return true
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 70 - 120
function LowerWater2()
	ChangeWaterHeight.Start( 2300, 2100, 50 * 60, Wait2 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 120 - 180
function Wait2()
	StartSimpleJob( Wait2_Job )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function Wait2_Job()
	if Counter.Tick2( "Wait2", 60 * 60 ) then
		--RaiseWater1()
		return true
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 180 ++
function RaiseWater1()
	ChangeWaterHeight.Start( 2100, 4100, 40 * 60, nil, true )
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- waterheight
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
ChangeWaterHeight = {}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO: get _StartHeight from terrain info
function ChangeWaterHeight.Start( _StartHeight, _DestinationHeight, _DurationSeconds, _Callback, _FloodMines )
	
	-- no duration? instant change!
	if not _DurationSeconds or _DurationSeconds <= 0 then
		_DurationSeconds = 1
	end
	
	-- no heights? no change!
	if not _DestinationHeight or not _StartHeight then
		return
	end
	
	-- save current state
	ChangeWaterHeight.ElapsedSeconds = 0
	ChangeWaterHeight.LastHeight = _StartHeight
	
	StartSimpleJob( ChangeWaterHeight.Job, _StartHeight, _DestinationHeight, ( _DestinationHeight - _StartHeight ) / _DurationSeconds, _Callback, _FloodMines )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.Job( _StartHeight, _DestinationHeight, _ChangePerSecond, _Callback, _FloodMines )
	
	ChangeWaterHeight.ElapsedSeconds = ChangeWaterHeight.ElapsedSeconds + 1
	local height = Round( _StartHeight + ( _ChangePerSecond * ChangeWaterHeight.ElapsedSeconds ) )
	
	if height ~= ChangeWaterHeight.LastHeight then
		
		ChangeWaterHeight.LastHeight = height
		
		local mapsize = Logic.WorldGetSize() / 100
		Logic.WaterSetAbsoluteHeight( 0, 0, mapsize, mapsize, height )
		
		-- exclude pits from change
		if not _FloodMines then
			for id in CEntityIterator.Iterator( CEntityIterator.OfCategoryFilter( EntityCategories.ResourcePit ) ) do
				
				local x, y = Logic.GetEntityPosition( id )
				x, y = SnapToGrid( 4, x / 100, y / 100 )
				
				if Logic.GetEntityType( id ) == Entities.XD_ClayPit1 then
					Logic.WaterSetAbsoluteHeight( x - 4, y - 8, x + 4, y, 0 )
				elseif Logic.GetEntityType( id ) == Entities.XD_StonePit1 then
					Logic.WaterSetAbsoluteHeight( x - 4, y - 8, x + 4, y + 4, 0 )
				else
					Logic.WaterSetAbsoluteHeight( x - 4, y - 4, x, y, 0 )
				end
			end
		end
		
		Logic.UpdateBlocking( 1, 1, mapsize - 1, mapsize - 1 )
		GUI.RebuildMinimapTerrain()
		
		if ( _DestinationHeight < _StartHeight and height <= _DestinationHeight ) or ( _DestinationHeight >= _StartHeight and height >= _DestinationHeight ) then
			
			if _Callback then
				_Callback()
			end
			
			return true
		end
	end
end

-- temporary fix for SP
if not CNetwork then
	S5Hook.GetRawMem( tonumber( "5381CB", 16 ) )[ 0 ]:SetByte( 0, tonumber( "A1", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381CB", 16 ) )[ 0 ]:SetByte( 1, tonumber( "AC", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381CB", 16 ) )[ 0 ]:SetByte( 2, tonumber( "5D", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381CB", 16 ) )[ 0 ]:SetByte( 3, tonumber( "89", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381CB", 16 ) )[ 0 ]:SetByte( 4, tonumber( "00", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D0", 16 ) )[ 0 ]:SetByte( 0, tonumber( "8B", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D0", 16 ) )[ 0 ]:SetByte( 1, tonumber( "48", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D0", 16 ) )[ 0 ]:SetByte( 2, tonumber( "24", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D3", 16 ) )[ 0 ]:SetByte( 0, tonumber( "6A", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D3", 16 ) )[ 0 ]:SetByte( 1, tonumber( "00", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D5", 16 ) )[ 0 ]:SetByte( 0, tonumber( "E8", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D5", 16 ) )[ 0 ]:SetByte( 1, tonumber( "39", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D5", 16 ) )[ 0 ]:SetByte( 2, tonumber( "14", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D5", 16 ) )[ 0 ]:SetByte( 3, tonumber( "04", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381D5", 16 ) )[ 0 ]:SetByte( 4, tonumber( "00", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381DA", 16 ) )[ 0 ]:SetByte( 0, tonumber( "33", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381DA", 16 ) )[ 0 ]:SetByte( 1, tonumber( "C0", 16 ) )
	S5Hook.GetRawMem( tonumber( "5381DC", 16 ) )[ 0 ]:SetByte( 0, tonumber( "C3", 16 ) )
	
	function Logic.UpdateBlocking()
		GUI.DEBUG_ActivateUpgradeSingleBuildingState()
	end
end