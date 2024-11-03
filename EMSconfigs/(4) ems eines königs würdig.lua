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
	Version = 2,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		Script.Load( Folders.MapTools.."Main.lua" )
		IncludeGlobals("MapEditorTools")

		gvMission = {}
		gvMission.PlayerID = GUI.GetPlayerID()

		-- TODO: Debug path
		--local path = "maps\\user\\(4) EMS Eines Königs würdig\\maps\\externalmap\\"
		local path = "maps\\externalmap\\"

		-- Determine language
		Language = string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "")
		if Language ~= "de" then
			Language = "en"
		end

		Script.Load(path .. "script\\text.lua")
		Script.Load(path .. "script\\util.lua")
		Script.Load(path .. "script\\messagebriefing.lua")
		Script.Load(path .. "script\\progressbar.lua")
		Script.Load(path .. "script\\tableextensions.lua")
		-- Script.Load(path .. "script\\thief.lua")
		-- Script.Load(path .. "script\\unknowntaskhandler.lua")

		-- PlayerIds:
		-- Player 1 : Player of Team 1
		-- Player 2 : Player of Team 1
		-- Player 3 : Player of Team 2
		-- Player 4 : Player of Team 2
		-- Player 5 : Player of hostile bandit camps
		-- Player 6 : Player of central large bandit camp
		-- Player 7 : Player of villages
		-- Player 8 : Neutral (carts, etc...)

		PlayerTeams = {1, 1, 2, 2}
		TeamPlayers = {{1, 2}, {3, 4}}
		PlayerHQs = {"Player1", "Player2", "Player3", "Player4"}
		OtherTeam = {2, 1}

		Quests = {}

		-- Load quests
		Script.Load(path .. "quests\\mainquest.lua")
		Script.Load(path .. "quests\\banditleader.lua")
		Script.Load(path .. "quests\\destroycamps.lua")
		Script.Load(path .. "quests\\findshards.lua")
		Script.Load(path .. "quests\\sendtroops.lua")
		Script.Load(path .. "quests\\sendresources.lua")
		Script.Load(path .. "quests\\buildbridge.lua")
		Script.Load(path .. "quests\\minesilver.lua")

		-- Load armies
		Script.Load(path .. "army\\defensivearmy.lua")
		Script.Load(path .. "army\\filter.lua")
		Script.Load(path .. "army\\spawnarmy.lua")
		Script.Load(path .. "army\\waypointarmy.lua")
		Script.Load(path .. "army\\wavespawner.lua")

		AddPeriodicSummer(60)
		SetupNormalWeatherGfxSet()
		LocalMusic.UseSet = EUROPEMUSIC

		local resourceTable = {
			{Entities.XD_StonePit1, 50000},
			{Entities.XD_IronPit1, 30000},
			{Entities.XD_ClayPit1, 50000},
			{Entities.XD_SulfurPit1, 30000},
			{Entities.XD_Stone1, 3000},
			{Entities.XD_Iron1, 3000},
			{Entities.XD_Clay1, 3000},
			{Entities.XD_Sulfur1, 3000}
		}
		MapTools.SetMapResource(resourceTable)
		MapTools.WallsToPlayerZero(
			Entities.XD_DarkWallStraightGate,
			Entities.XD_DarkWallStraightGate_Closed, 
			Entities.XD_DarkWallCorner, 
			Entities.XD_DarkWallStraight, 
			Entities.XD_DarkWallDistorted,
			Entities.XD_WallStraightGate,
			Entities.XD_WallStraightGate_Closed, 
			Entities.XD_WallCorner, 
			Entities.XD_WallStraight, 
			Entities.XD_WallDistorted,
			Entities.PB_PalisadeCorner,
			Entities.PB_PalisadeDistorted,
			Entities.PB_PalisadeStraight,
			Entities.PB_PalisadeStraightGate_Closed,
			Entities.PB_PalisadeStraightGate
		)

		-- init player colors
		Display.SetPlayerColorMapping(5, 14)
		Display.SetPlayerColorMapping(6, 14)
		Display.SetPlayerColorMapping(7, 11)
		
		for p = 5, 7 do
			Logic.SetPlayerRawName(p, Text.PlayerNames[p])
		end

		for PlayerId = 1, 4 do
			-- Bandit camps
			SetHostile(PlayerId, 5)
			-- Bandit leader
			SetNeutral(PlayerId, 6)
			-- Villages
			SetFriendly(PlayerId, 7)
			-- Neutral Player
			SetNeutral(PlayerId, 8)

			--[[ TODO: Debug only
			Camera.ZoomSetFactorMax(5)
			for i = 1,3 do
				Display.GfxSetSetFogParams(i,0,0,0,0,0,0,0,0)
			end
			Display.SetRenderFogOfWar(0)

			for _, Technology in pairs(Technologies) do
				ResearchTechnology(Technology, PlayerId)
			end]]
		end

		--for id in CEntityIterator.Iterator(CEntityIterator.OfAnyTypeFilter(Entities.PB_DarkTower2, Entities.PB_DarkTower3)) do
			--Logic.DestroyEntity(id)
		--end
	end,

	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		TIME_EMS_COUNTDOWN_FINISHED = Logic.GetTime()

		-- Init MessageBriefing
		MessageBriefing.Init()

		-- Init ProgressBars
		ProgressBars.Init()

		-- Init all quests
		Quests.Mainquest.Init()
	end,

	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
	end,

	Peacetime = 0,

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
				50,
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
	end,

	-- ********************************************************************************************
	-- * AI Players
	-- * specify AI players to make sure their entities won't be deleted on game start
	-- ********************************************************************************************
	AIPlayers = {},

	HeavyCavalry = 2,
	LightCavalry = 2,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,

	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 12,

	-- * Heroes
	-- * NumberOfHeroesForAll sets the number of heroes every player can pick
	NumberOfHeroesForAll = 2,

	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  0,
};