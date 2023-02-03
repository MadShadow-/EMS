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
	-- ********************************************************************************************
	-- * Configuration File Version
	-- * A version check will make sure every player has the same version of the configuration file
	-- ********************************************************************************************
	Version = 1.1,
	
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		MapTools.RemoveFastGameEntities()
		
		Script.Load("maps\\externalmap\\customweather.lua")
		Script.Load("maps\\externalmap\\weatherextensions.lua")
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\other\\CustomTick.lua")
		
		InitCustomWeather()
		LocalMusic.UseSet = MEDITERANEANMUSIC
		Camera.ZoomSetFactorMax(2)

		-- woraround for black fog due to no weather
		Display.SetRenderUseGfxSets(0)
		local x = math.cos(math.rad(157.5)) * 50
		local y = math.sin(math.rad(157.5)) * 50
		local z = (math.sin(math.rad(157.5)) * 50 - 100) / 2
		Display.SetGlobalLightDirection(x, y, z)
		Display.SetGlobalLightAmbient(139,131,122)
		Display.SetGlobalLightDiffuse(206,195,186)
		Display.SetFogColor(188,180,149)
		Display.SetFogStartAndEnd(9000,36000)

		MapTools.CreateWoodPiles(50000);
		
		for e in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.XD_SnowBarrier1)) do
			Logic.SetModelAndAnimSet(e, Models.XD_RockMedium1)
		end
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		StartCustomWeather()
		-- woraround for black fog due to no weather
		-- there is still a rendering bug for a split second
		Display.SetRenderUseGfxSets(1)
		
		-- load dz spam fix (self initializing)
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\comfort\\other\\NextTick.lua")
		Script.Load("maps\\externalmap\\preventdzspam.lua")
		
		-- non periodic day night cycle until peacetime ended
		local peacetime = EMS.RD.Rules.Peacetime:GetValue() * 60
		local weather = {}
		local phase = {{1,240},{4,60},{7,120},{4,60},}
		local p = 1
		local t = 0
		
		while t < peacetime do
			table.insert(weather, {phase[p][1], phase[p][2] + t})
			t = t + phase[p][2]
			p = p + 1
			if p > table.getn(phase) then
				p = 1
			end
		end
		
		for i = table.getn(weather), 1, -1 do
			Logic.AddWeatherElement(1, weather[i][2], 0, weather[i][1], 0, 60)
		end
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for e in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.XD_SnowBarrier1)) do
			DestroyEntity(e)
		end
		for e in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.XD_Groyne3)) do
			DestroyEntity(e)
		end
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