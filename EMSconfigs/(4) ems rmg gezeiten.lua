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
	Version = 1.5,
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
		
		--Input.KeyBindDown(Keys.X, "Logic.WaterSetAbsoluteHeight(0,0,607,607,2300)" )
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
	
	LightCavalry = 2,
	HeavyCavalry = 2,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
	
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
						AbsolutX = GetXFromAngleAndRelDist( 112.50, 0.75 ),
						AbsolutY = GetYFromAngleAndRelDist( 112.50, 0.75 ),
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
						AbsolutX = GetXFromAngleAndRelDist( 67.50, 0.75 ),
						AbsolutY = GetYFromAngleAndRelDist( 67.50, 0.75 ),
					},
					-- 2x iron mine, 2x sulfur mine, village
					Childs = {},
				},
				-- third island
				{
					Placement = {
						AbsolutX = GetXFromAngleAndRelDist( 75.00, 0.45 ),
						AbsolutY = GetYFromAngleAndRelDist( 75.00, 0.45 ),
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
			
			local placement
			
			-- the 3rd vc will have a fix location on the small island
			if i < 3 then
				placement = {
					AreaMin = dist - resoff,
					AreaMax = dist + resoff,
					Noise = RMG.GenerationData.TerrainBaseHeight,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
				}
			else
				placement = {
					AreaMin = 0,
					AreaMax = 12,
					Noise = RMG.GenerationData.TerrainBaseHeight,
					NoiseMin = noiseMin,
					NoiseMax = noiseMax,
				}
			end
			
			local child = {
				Placement = placement,
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
		
		-- flatten middle and main connectors
		local innerrange = Round( maphalf * 0.15 ) - 15
		local outerrange = innerrange + 45
		
		RMG.FlattenArea( _generationdata, maphalf, maphalf, innerrange, outerrange )
		RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist( 135.00, 0.55 ), GetYFromAngleAndRelDist( 135.00, 0.55 ), innerrange, outerrange )
		RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist( 315.00, 0.55 ), GetYFromAngleAndRelDist( 315.00, 0.55 ), innerrange, outerrange )
		
		-- flatten corners
		local innerrange = Round( maphalf * 0.20 ) - 15
		local outerrange = innerrange + 45
		
		local low, high = 0.175, 0.825
		
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * low  ), Round( mapsize * low  ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * high ), Round( mapsize * low  ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * low  ), Round( mapsize * high ), innerrange, outerrange, -0.352147606136882, 0.10 )
		RMG.SimpleNoiseOverride( _generationdata, Round( mapsize * high ), Round( mapsize * high ), innerrange, outerrange, -0.352147606136882, 0.10 )
		
		-- flatten outer connectors
		--local innerrange = Round( maphalf * 0.1 ) - 15
		--local outerrange = innerrange + 30
		
		--RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist(  70.00, 0.57 ), GetYFromAngleAndRelDist(  70.00, 0.57 ), innerrange, outerrange )
		--RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist( 200.00, 0.57 ), GetYFromAngleAndRelDist( 200.00, 0.57 ), innerrange, outerrange )
		--RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist( 250.00, 0.57 ), GetYFromAngleAndRelDist( 250.00, 0.57 ), innerrange, outerrange )
		--RMG.FlattenArea( _generationdata, GetXFromAngleAndRelDist(  20.00, 0.57 ), GetYFromAngleAndRelDist(  20.00, 0.57 ), innerrange, outerrange )
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	RMG.SetTerrainTextures_Orig = RMG.SetTerrainTextures
	function RMG.SetTerrainTextures( _generationdata )
		
		local maphalf = Logic.WorldGetSize() / 200
		
		-- flatten outer connectors
		local innerrange = Round( maphalf * 0.1 ) - 15
		local outerrange = innerrange + 30
		
		-- this needs to be done after rivers and roads have been calculated
		RMG.SimpleHeightOverride( _generationdata, GetXFromAngleAndRelDist(  70.00, 0.57 ), GetYFromAngleAndRelDist(  70.00, 0.57 ), innerrange, outerrange, 2356 )
		RMG.SimpleHeightOverride( _generationdata, GetXFromAngleAndRelDist( 200.00, 0.57 ), GetYFromAngleAndRelDist( 200.00, 0.57 ), innerrange, outerrange, 2356 )
		RMG.SimpleHeightOverride( _generationdata, GetXFromAngleAndRelDist( 250.00, 0.57 ), GetYFromAngleAndRelDist( 250.00, 0.57 ), innerrange, outerrange, 2356 )
		RMG.SimpleHeightOverride( _generationdata, GetXFromAngleAndRelDist(  20.00, 0.57 ), GetYFromAngleAndRelDist(  20.00, 0.57 ), innerrange, outerrange, 2356 )
		
		RMG.SetTerrainTextures_Orig( _generationdata )
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.FlattenArea( _generationdata, _X, _Y, _InnerRange, _OuterRange )
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		
		-- flatten middle
		local _InnerRange = Round( maphalf * 0.15 ) - 15
		local _OuterRange = _InnerRange + 45
		
		local minnoise, maxnoise = 1, -1
		local noiseaverage = 0
		local n = 0
		
		for x = -_InnerRange, _InnerRange do
			for y = -_InnerRange, _InnerRange do
				
				local noise = _generationdata.TerrainNodes[ x + _X ][ y + _Y ].HeightNoise
				
				minnoise = math.min( minnoise, noise )
				maxnoise = math.max( maxnoise, noise )
				
				noiseaverage = noiseaverage + noise
				n = n + 1
			end
		end
		
		noiseaverage = noiseaverage / n
		
		local noiserange = maxnoise - minnoise
		local func =	function( _noise, _targetrange, _targetnoise, _offset )
							return math.min( ( _noise - _offset ) * _targetrange + _targetnoise, -0.396626934498992 )
						end
		
		RMG.SimpleNoiseOverride( _generationdata, _X, _Y, _InnerRange, _OuterRange, -0.399297853124962, 0.10 / noiserange, nil, nil, func, noiseaverage )
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
			
			{ X = maphalf * 0.59 * math.cos( math.rad( 123.75 ) ) + maphalf, Y = maphalf * 0.59 * math.sin( math.rad( 123.75 ) ) + maphalf },
			{ X = maphalf * 0.59 * math.cos( math.rad( 146.25 ) ) + maphalf, Y = maphalf * 0.59 * math.sin( math.rad( 146.25 ) ) + maphalf },

			{ X = maphalf * 0.60 * math.cos( math.rad( 180.00 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad( 180.00 ) ) + maphalf },
			{ X = maphalf * 0.60 * math.cos( math.rad( 212.50 ) ) + maphalf, Y = maphalf * 0.60 * math.sin( math.rad( 212.50 ) ) + maphalf }, -- +10
			-- technically a double, but is required
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
			{  9,  3 },
			
			{  4,  5 },
			{  5,  6 },
			
			{  6,  7 },
			{ 11, 10 },
			{ 10,  9 },
			
			{  9,  8 },
			
			{  5, 12 },
			{  6, 12 },
			
			{  9, 13 },
			{ 10, 13 },
		}
		_generationData.Rivers.MirrorRadea = { math.rad( 180 ) }
	end
	------------------------------------------------------------------------------------------------------------------------------------------------------------
	function RMG.FillRoadLocationTable( _generationData )
		
		local mapsize = Logic.WorldGetSize() / 100
		local maphalf = mapsize / 2
		
		_generationData.Roads.StartPoints = {
			-- player 1
			{ X = maphalf * 0.75 * math.cos( math.rad( 112.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 112.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad(  67.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad(  67.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad(  75.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad(  75.00 ) ) + maphalf }, -- -15
			-- player 2
			{ X = maphalf * 0.75 * math.cos( math.rad( 157.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 157.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad( 202.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad( 202.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad( 195.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad( 195.00 ) ) + maphalf }, -- +15
			-- team 1
			{ X = maphalf * 0.37 * math.cos( math.rad( 135.00 ) ) + maphalf, Y = maphalf * 0.37 * math.sin( math.rad( 135.00 ) ) + maphalf },
			-- player 3
			{ X = maphalf * 0.75 * math.cos( math.rad( 292.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 292.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad( 247.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad( 247.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad( 255.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad( 255.00 ) ) + maphalf }, -- -15
			-- player 4
			{ X = maphalf * 0.75 * math.cos( math.rad( 337.50 ) ) + maphalf, Y = maphalf * 0.75 * math.sin( math.rad( 337.50 ) ) + maphalf },
			{ X = maphalf * 0.90 * math.cos( math.rad(  22.50 ) ) + maphalf, Y = maphalf * 0.90 * math.sin( math.rad(  22.50 ) ) + maphalf },
			{ X = maphalf * 0.35 * math.cos( math.rad(  15.00 ) ) + maphalf, Y = maphalf * 0.35 * math.sin( math.rad(  15.00 ) ) + maphalf }, -- +15
			-- team 2
			{ X = maphalf * 0.37 * math.cos( math.rad( 315.00 ) ) + maphalf, Y = maphalf * 0.37 * math.sin( math.rad( 315.00 ) ) + maphalf },
		}
		for _,v in ipairs( _generationData.Roads.StartPoints ) do
			v.X, v.Y = SnapToGrid( 4, v.X, v.Y )
		end
		
		_generationData.Roads.Paths = {
			{ 1, 2 },
			{ 2, 3 },
			{ 4, 5 },
			{ 5, 6 },
			{ 3, 7 },
			{ 6, 7 },
			
			{  8,  9 },
			{  9, 10 },
			{ 11, 12 },
			{ 12, 13 },
			{ 10, 14 },
			{ 13, 14 },
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
		
		-- delete the 8 closest bridges - lazy but it works
		for i = 1, 8 do
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
	ChangeWaterHeight.Start( 2500, 2356, 36 * 60, LowerWater2 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- raise update speed in the time where its likely that larger areas become walkable at the same time
function LowerWater2()
	ChangeWaterHeight.Start( 2356, 2348, 2 * 60, LowerWater3, nil, 10 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function LowerWater3()
	ChangeWaterHeight.Start( 2348, 2300, 12 * 60, Wait1 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 50 - 70
function Wait1()
	StartSimpleJob( Wait1_Job )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function Wait1_Job()
	if Counter.Tick2( "Wait1", 20 * 60 ) then
		LowerWater4()
		return true
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 70 - 120
function LowerWater4()
	ChangeWaterHeight.Start( 2300, 2140, 40 * 60, LowerWater5 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- raise update speed again when rivers are about to dry out
function LowerWater5()
	ChangeWaterHeight.Start( 2140, 2132, 2 * 60, Wait2, nil, 35 )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 120 - 180
function Wait2()
	StartSimpleJob( Wait2_Job )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function Wait2_Job()
	if Counter.Tick2( "Wait2", 68 * 60 ) then
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
function ChangeWaterHeight.Start( _StartHeight, _DestinationHeight, _DurationSeconds, _Callback, _FloodMines, _UpdateInterval )
	
	-- no duration? instant change!
	if not _DurationSeconds or _DurationSeconds <= 0 then
		_DurationSeconds = 1
	end
	
	-- no heights? no change!
	if not _DestinationHeight or not _StartHeight then
		return
	end
	
	-- fill table with all blocked nodes
	--if not ChangeWaterHeight.WaterBlockedNodes then
		--ChangeWaterHeight.InitWaterBlocking()
	--end
	
	-- save current state
	ChangeWaterHeight.ElapsedSeconds = 0
	ChangeWaterHeight.LastHeight = _StartHeight
	
	StartSimpleJob( ChangeWaterHeight.Job, _StartHeight, _DestinationHeight, ( _DestinationHeight - _StartHeight ) / _DurationSeconds, _Callback, _FloodMines, _UpdateInterval )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.Job( _StartHeight, _DestinationHeight, _ChangePerSecond, _Callback, _FloodMines, _UpdateInterval )
	
	ChangeWaterHeight.ElapsedSeconds = ChangeWaterHeight.ElapsedSeconds + 1
	local height = Round( _StartHeight + ( _ChangePerSecond * ChangeWaterHeight.ElapsedSeconds ) )
	
	if height ~= ChangeWaterHeight.LastHeight then --math.abs( height - ChangeWaterHeight.LastHeight ) >= 10 or height == _DestinationHeight then
		
		ChangeWaterHeight.LastHeight = height
		
		local mapsize = Logic.WorldGetSize() / 100
		Logic.WaterSetAbsoluteHeight( mapsize, mapsize, 0, 0, height )
		
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
		
		CUtil.UpdateBlockingWholeMapNoHeight()
		--ChangeWaterHeight.UpdateWaterBlocking( _UpdateInterval )
		GUI.RebuildMinimapTerrain()
		
		if ( _DestinationHeight < _StartHeight and height <= _DestinationHeight ) or ( _DestinationHeight >= _StartHeight and height >= _DestinationHeight ) then
			
			if _Callback then
				_Callback()
			end
			
			return true
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.InitWaterBlocking()
	
	local mapsize = Logic.WorldGetSize() / 100 - 2
	local maphalf = Logic.WorldGetSize() / 200
	local maphalfsq = maphalf ^ 2
	
	ChangeWaterHeight.WaterBlockedNodes = {}
	
	for x = 1, mapsize do
		for y = 1, mapsize do
			if (x - maphalf) ^ 2 + (y - maphalf) ^ 2 < maphalfsq and CUtil.GetWaterHeight( x, y ) >= CUtil.GetTerrainNodeHeight( x, y ) then
				table.insert( ChangeWaterHeight.WaterBlockedNodes, { X = x, Y = y } )
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.UpdateWaterBlocking( _UpdateInterval )
	EndJob( ChangeWaterHeight.UpdateWaterBlockingJobId )
	ChangeWaterHeight.UpdateWaterBlockingJobId = StartSimpleHiResJob( ChangeWaterHeight.UpdateWaterBlockingJob, _UpdateInterval )
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.UpdateWaterBlockingJob( _UpdateInterval )
	if ChangeWaterHeight.UpdateWaterBlockingInternal( _UpdateInterval ) then
		return true
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChangeWaterHeight.UpdateWaterBlockingInternal( _UpdateInterval )
	
	_UpdateInterval = _UpdateInterval or 5
	local n = 0
	
	for i = table.getn( ChangeWaterHeight.WaterBlockedNodes ), 1, -1 do
		
		local x, y = ChangeWaterHeight.WaterBlockedNodes[ i ].X, ChangeWaterHeight.WaterBlockedNodes[ i ].Y
		
		if CUtil.GetWaterHeight( x, y ) < CUtil.GetTerrainNodeHeight( x, y ) then
			
			Logic.UpdateBlocking( x, y, x + 1, y + 1 )
			table.remove( ChangeWaterHeight.WaterBlockedNodes, i )
			
			n = n + 1
			
			if n >= _UpdateInterval then
				return false
			end
		end
	end
	
	return true
end

function GetXFromAngleAndRelDist( _Angle, _Dist )
	local maphalf = Logic.WorldGetSize() / 200
	return Round( maphalf * _Dist * math.cos( math.rad( _Angle ) ) + maphalf )
end
function GetYFromAngleAndRelDist( _Angle, _Dist )
	local maphalf = Logic.WorldGetSize() / 200
	return Round( maphalf * _Dist * math.sin( math.rad( _Angle ) ) + maphalf )
end