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
	Version = 1.0,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		AddPeriodicSummer(40*60);
		AddPeriodicWinter(30*60);
		AddPeriodicRain(30*60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		
		Script.Load("data\\maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua")
		mcbPacker.Paths = {{"data/maps/user/EMS/tools/", ".lua"}}
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmy")
		TriggerFix.AllScriptsLoaded()
	    
		StartSimpleJob("Angriff20")	
		StartSimpleJob("Angriff19")	
		StartSimpleJob("Angriff18")	
		StartSimpleJob("Angriff17")	
		StartSimpleJob("Angriff16")	
		StartSimpleJob("Angriff15")	
		StartSimpleJob("Angriff14")	
		StartSimpleJob("Angriff13")	
		StartSimpleJob("Angriff12")			
		StartSimpleJob("Angriff11")			
		StartSimpleJob("Angriff10")		
		StartSimpleJob("Angriff9")		
		StartSimpleJob("Angriff8")			
	    StartSimpleJob("Angriff7")			
	    StartSimpleJob("Angriff6")		
	    StartSimpleJob("Angriff5")
	    StartSimpleJob("Angriff4")
        StartSimpleJob("Angriff3")
	    StartSimpleJob("Angriff2")
	    StartSimpleJob("Angriff1")
        StartSimpleJob("timedarmy")
		StartSimpleJob("timedarmy1")
		
        Angriffe = 0		
		CreateRandomGoldChests()
CreateChest(GetPosition("chest1"), chestCallbackGold)
CreateChest(GetPosition("chest2"), chestCallbackGold)
CreateChest(GetPosition("chest3"), chestCallbackGold)
CreateChest(GetPosition("chest4"), chestCallbackGold)
CreateChestOpener("pilgrim")
CreateChestOpener("pilgrim1")
CreateChestOpener("pilgrim2")
CreateChestOpener("pilgrim3")
StartChestQuest()
	Mission_InitTechnologies()

		
		OverrideDiplomacy()
		-- hier die ais aufrufen
		SetupPlayer9AI()
		
		CreateWoodPile( "P5", 500000)
		CreateWoodPile( "P4", 500000)
		CreateWoodPile( "P3", 500000)
		CreateWoodPile( "P2", 500000)		
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		
	end,
	
		-- ********************************************************************************************
	-- * AI Players
	-- * Player Entities that belong to an ID that is also present in the AIPlayers table won't be
	-- * removed
	-- ********************************************************************************************
	AIPlayers = {9},
 	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		MapTools.OpenPalisadeGates()
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
	end,

	-- ********************************************************************************************
	-- * AI Players
	-- * specify AI players to make sure their entities won't be deleted on game start
	-- ********************************************************************************************
	AIPlayers = {},
};

-- eigentlich auch sp code, weiß gerade nicht ob die im mp genutzt wird. muss auf jeden fall aus der GameCallback_OnGameStart raus
function InitPlayerColorMapping()
	Display.SetPlayerColorMapping(8,ENEMY_COLOR2)
end 

function OverrideDiplomacy() -- diplo in funktion ausgelagert
	SetHostile( 1, 6 )
	SetHostile( 2, 6 )
	SetHostile( 3, 6 )
	SetHostile( 4, 6 )
end



-- die ki spieler alle in ne extra funktion
function SetupPlayer9AI()
	local aiID = 6;
	SetupPlayerAi( aiID, {6}); -- p9 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Banditen" );
end

function spawnArmy22()
    UA22 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,20 do
        UA22:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_22"), VERYHIGH_EXPERIENCE)
    end
    for i=1,20 do
        UA22:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_22"), VERYHIGH_EXPERIENCE)
    end
    for i=1,20 do
        UA22:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_22"), VERYHIGH_EXPERIENCE)
    end
    UA22:AddCommandMove(GetPosition("t2"), true)
    UA22:AddCommandWaitForIdle(true)
    UA22:AddCommandMove(GetPosition("Lo2"), true)
    UA22:AddCommandWaitForIdle(true)
    UA22:AddCommandMove(GetPosition("Turm_22"), true)
    UA22:AddCommandWaitForIdle(true)
end
        
function Angriff22()       -- Deff 22 Für Die Burgen
    if IsExisting("Turm_22_army_1") then
        if not UA22 or UA22:IsDead() then
            spawnArmy22()
            Angriffe = Angriffe + 1
        end
    end
end

timedarmycounter = 180 * 60
function timedarmy()
    timedarmycounter = timedarmycounter - 1
    if timedarmycounter <= 0 then
        StartSimpleJob("Angriff22")
        return true
    end
end


----  Army 21   dIE DEFF FÜR ARMY 21

function spawnArmy21()
	UA21 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,20 do
        UA21:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_21"), VERYHIGH_EXPERIENCE)
    end
    for i=1,20 do
        UA21:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_21"), VERYHIGH_EXPERIENCE)
    end
    for i=1,20 do
        UA21:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_21"), VERYHIGH_EXPERIENCE)
    end
	UA21:AddCommandMove(GetPosition("P-13"), true)
	UA21:AddCommandWaitForIdle(true)
	UA21:AddCommandMove(GetPosition("L5"), true)
	UA21:AddCommandWaitForIdle(true)
	UA21:AddCommandMove(GetPosition("Turm_21"), true)
	UA21:AddCommandWaitForIdle(true)
end
		
function Angriff21()       -- Deff 21 Für Die Burgen
    if IsExisting("Turm_21_army_1") then
        if not UA21 or UA21:IsDead() then
			spawnArmy21()
			Angriffe = Angriffe + 1
        end
	end
end

timedarmycounter = 180 * 60
function timedarmy1()
    timedarmycounter = timedarmycounter - 1
    if timedarmycounter <= 0 then
        StartSimpleJob("Angriff21")
        return true
    end
end

----  Army 20   dIE DEFF FÜR ARMY 20

function spawnArmy20()
	UA20 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA20:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_19"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA20:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_19"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA20:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_19"), VERYHIGH_EXPERIENCE)
    end
	UA20:AddCommandMove(GetPosition("I2"), true)
	UA20:AddCommandWaitForIdle(true)
	UA20:AddCommandMove(GetPosition("I1"), true)
	UA20:AddCommandWaitForIdle(true)
	UA20:AddCommandMove(GetPosition("Turm_19"), true)
	UA20:AddCommandWaitForIdle(true)
end
		
function Angriff20()       -- Deff 20 Für Die Burgen
    if IsExisting("Turm_19_army_1") then
        if not UA20 or UA20:IsDead() then
			spawnArmy20()
			Angriffe = Angriffe + 1
        end
	end
end



--------------- ARMY 19

function spawnArmy19()
	UA19 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA19:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_19"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA19:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_19"), VERYHIGH_EXPERIENCE)
    end
	UA19:AddCommandMove(GetPosition("t3"), true)
	UA19:AddCommandWaitForIdle(true)
	UA19:AddCommandMove(GetPosition("t2"), true)
	UA19:AddCommandWaitForIdle(true)
	UA19:AddCommandMove(GetPosition("Turm_19"), true)
	UA19:AddCommandWaitForIdle(true)
end

function Angriff19()       -- Deff 18 Für Die Burgen
    if IsExisting("Turm_19_army_1") then
        if not UA19 or UA19:IsDead() then
			spawnArmy19()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 18

function spawnArmy18()
	UA18 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA18:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_17"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA18:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_17"), VERYHIGH_EXPERIENCE)
    end
	UA18:AddCommandMove(GetPosition("OO1"), true)
	UA18:AddCommandWaitForIdle(true)
	UA18:AddCommandMove(GetPosition("t2"), true)
	UA18:AddCommandWaitForIdle(true)
	UA18:AddCommandMove(GetPosition("Turm_17"), true)
	UA18:AddCommandWaitForIdle(true)
end

function Angriff18()       -- Deff 18 Für Die Burgen
    if IsExisting("Turm_17_army_1") then
        if not UA18 or UA18:IsDead() then
			spawnArmy18()
			Angriffe = Angriffe + 1
        end
	end
end

----  Army 17   dIE DEFF FÜR ARMY 17

function spawnArmy17()
	UA17 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA17:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_17"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA17:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_17"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA17:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_17"), VERYHIGH_EXPERIENCE)
    end
	UA17:AddCommandMove(GetPosition("m101"), true)
	UA17:AddCommandWaitForIdle(true)
	UA17:AddCommandMove(GetPosition("m100"), true)
	UA17:AddCommandWaitForIdle(true)
	UA17:AddCommandMove(GetPosition("Turm_17"), true)
	UA17:AddCommandWaitForIdle(true)
end
		
function Angriff17()       -- Deff 17 Für Die Burgen
    if IsExisting("Turm_17_army_1") then
        if not UA17 or UA17:IsDead() then
			spawnArmy17()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 16

function spawnArmy16()
	UA16 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA16:CreateLeaderForArmy(Entities.PU_LeaderBow3, 4, GetPosition("Turm_16"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA16:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_16"), VERYHIGH_EXPERIENCE)
    end
	UA16:AddCommandMove(GetPosition("t1"), true)
	UA16:AddCommandWaitForIdle(true)
	UA16:AddCommandMove(GetPosition("t2"), true)
	UA16:AddCommandWaitForIdle(true)
	UA16:AddCommandMove(GetPosition("Turm_16"), true)
	UA16:AddCommandWaitForIdle(true)
end

function Angriff16()       -- Deff 16 Für Die Burgen
    if IsExisting("Turm_16_army_1") then
        if not UA16 or UA16:IsDead() then
			spawnArmy16()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 15

function spawnArmy15()
	UA15 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA15:CreateLeaderForArmy(Entities.PU_LeaderBow3, 4, GetPosition("Turm_15"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA15:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_15"), VERYHIGH_EXPERIENCE)
    end
	UA15:AddCommandMove(GetPosition("M3"), true)
	UA15:AddCommandWaitForIdle(true)
	UA15:AddCommandMove(GetPosition("Lo2"), true)
	UA15:AddCommandWaitForIdle(true)
	UA15:AddCommandMove(GetPosition("Turm_15"), true)
	UA15:AddCommandWaitForIdle(true)
end

function Angriff15()       -- Deff 15 Für Die Burgen
    if IsExisting("Turm_15_army_1") then
        if not UA15 or UA15:IsDead() then
			spawnArmy15()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 14

function spawnArmy14()
	UA14 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA14:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_13"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA14:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_13"), VERYHIGH_EXPERIENCE)
    end
	UA14:AddCommandMove(GetPosition("M3"), true)
	UA14:AddCommandWaitForIdle(true)
	UA14:AddCommandMove(GetPosition("Lo2"), true)
	UA14:AddCommandWaitForIdle(true)
	UA14:AddCommandMove(GetPosition("Turm_11"), true)
	UA14:AddCommandWaitForIdle(true)
end

function Angriff14()       -- Deff 14 Für Die Burgen
    if IsExisting("Turm_13_army_1") then
        if not UA14 or UA14:IsDead() then
			spawnArmy14()
			Angriffe = Angriffe + 1
        end
	end
end

----  Army 13   dIE DEFF FÜR ARMY 13

function spawnArmy13()
	UA13 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA13:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_13"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA13:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_13"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA13:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_13"), VERYHIGH_EXPERIENCE)
    end
	UA13:AddCommandMove(GetPosition("M1"), true)
	UA13:AddCommandWaitForIdle(true)
	UA13:AddCommandMove(GetPosition("M2"), true)
	UA13:AddCommandWaitForIdle(true)
	UA13:AddCommandMove(GetPosition("Turm_13"), true)
	UA13:AddCommandWaitForIdle(true)
end
		
function Angriff13()       -- Deff 13 Für Die Burgen
    if IsExisting("Turm_13_army_1") then
        if not UA13 or UA13:IsDead() then
			spawnArmy13()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 12

function spawnArmy12()
	UA12 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA12:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_11"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA12:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_11"), VERYHIGH_EXPERIENCE)
    end
	UA12:AddCommandMove(GetPosition("Lo1"), true)
	UA12:AddCommandWaitForIdle(true)
	UA12:AddCommandMove(GetPosition("Lo2"), true)
	UA12:AddCommandWaitForIdle(true)
	UA12:AddCommandMove(GetPosition("Turm_11"), true)
	UA12:AddCommandWaitForIdle(true)
end

function Angriff12()       -- Deff 12 Für Die Burgen
    if IsExisting("Turm_11_army_1") then
        if not UA12 or UA12:IsDead() then
			spawnArmy12()
			Angriffe = Angriffe + 1
        end
	end
end

----  Army 11   dIE DEFF FÜR ARMY 11

function spawnArmy11()
	UA11 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA11:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_11"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA11:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_11"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA11:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_11"), VERYHIGH_EXPERIENCE)
    end
	UA11:AddCommandMove(GetPosition("b399"), true)
	UA11:AddCommandWaitForIdle(true)
	UA11:AddCommandMove(GetPosition("b400"), true)
	UA11:AddCommandWaitForIdle(true)
	UA11:AddCommandMove(GetPosition("Turm_11"), true)
	UA11:AddCommandWaitForIdle(true)
end
		
function Angriff11()       -- Deff 11 Für Die Burgen
    if IsExisting("Turm_11_army_1") then
        if not UA11 or UA11:IsDead() then
			spawnArmy11()
			Angriffe = Angriffe + 1
        end
	end
end


--------------- ARMY 10

function spawnArmy10()
	UA10 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA10:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_9"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA10:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_9"), VERYHIGH_EXPERIENCE)
    end
	UA10:AddCommandMove(GetPosition("P40"), true)
	UA10:AddCommandWaitForIdle(true)
	UA10:AddCommandMove(GetPosition("P-13"), true)
	UA10:AddCommandWaitForIdle(true)
	UA10:AddCommandMove(GetPosition("Turm_9"), true)
	UA10:AddCommandWaitForIdle(true)
end

function Angriff10()       -- Deff 10 Für Die Burgen
    if IsExisting("Turm_9_army_1") then
        if not UA10 or UA10:IsDead() then
			spawnArmy10()
			Angriffe = Angriffe + 1
        end
	end
end

----  Army 9   dIE DEFF FÜR ARMY 9

function spawnArmy9()
	UA9 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA9:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_9"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA9:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_9"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA9:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_9"), VERYHIGH_EXPERIENCE)
    end
	UA9:AddCommandMove(GetPosition("z20"), true)
	UA9:AddCommandWaitForIdle(true)
	UA9:AddCommandMove(GetPosition("z21"), true)
	UA9:AddCommandWaitForIdle(true)
	UA9:AddCommandMove(GetPosition("Turm_9"), true)
	UA9:AddCommandWaitForIdle(true)
end
		
function Angriff9()       -- Deff 9 Für Die Burgen
    if IsExisting("Turm_9_army_1") then
        if not UA9 or UA9:IsDead() then
			spawnArmy9()
			Angriffe = Angriffe + 1
        end
	end
end


----  Army 8   dIE DEFF FÜR ARMY 8

function spawnArmy8()
	UA8 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA8:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_7"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA8:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_7"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA8:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_7"), VERYHIGH_EXPERIENCE)
    end
	UA8:AddCommandMove(GetPosition("z1"), true)
	UA8:AddCommandWaitForIdle(true)
	UA8:AddCommandMove(GetPosition("z3"), true)
	UA8:AddCommandWaitForIdle(true)
	UA8:AddCommandMove(GetPosition("Turm_7"), true)
	UA8:AddCommandWaitForIdle(true)
end
		
function Angriff8()       -- Deff 8 Für Die Burgen
    if IsExisting("Turm_7_army_1") then
        if not UA8 or UA8:IsDead() then
			spawnArmy8()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 7

function spawnArmy7()
	UA7 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA7:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_7"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA7:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_7"), VERYHIGH_EXPERIENCE)
    end
	UA7:AddCommandMove(GetPosition("z1"), true)
	UA7:AddCommandWaitForIdle(true)
	UA7:AddCommandMove(GetPosition("z2"), true)
	UA7:AddCommandWaitForIdle(true)
	UA7:AddCommandMove(GetPosition("P-12"), true)
	UA7:AddCommandWaitForIdle(true)
	UA7:AddCommandMove(GetPosition("P-13"), true)
	UA7:AddCommandWaitForIdle(true)
	UA7:AddCommandMove(GetPosition("Turm_5"), true)
	UA7:AddCommandWaitForIdle(true)
end

function Angriff7()       -- Deff 7 Für Die Burgen
    if IsExisting("Turm_7_army_1") then
        if not UA7 or UA7:IsDead() then
			spawnArmy7()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 6

function spawnArmy6()
	UA6 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA6:CreateLeaderForArmy(Entities.PU_LeaderBow3, 4, GetPosition("Turm_6"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA6:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_6"), VERYHIGH_EXPERIENCE)
    end
	UA6:AddCommandMove(GetPosition("P-10"), true)
	UA6:AddCommandWaitForIdle(true)
	UA6:AddCommandMove(GetPosition("P-11"), true)
	UA6:AddCommandWaitForIdle(true)
	UA6:AddCommandMove(GetPosition("P-12"), true)
	UA6:AddCommandWaitForIdle(true)
	UA6:AddCommandMove(GetPosition("P-13"), true)
	UA6:AddCommandWaitForIdle(true)
	UA6:AddCommandMove(GetPosition("Turm_5"), true)
	UA6:AddCommandWaitForIdle(true)
end

function Angriff6()       -- Deff 6 Für Die Burgen
    if IsExisting("Turm_6_army_1") then
        if not UA6 or UA6:IsDead() then
			spawnArmy6()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 5

function spawnArmy5()
	UA5 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA5:CreateLeaderForArmy(Entities.PU_LeaderBow3, 4, GetPosition("Turm_5"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA5:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_5"), VERYHIGH_EXPERIENCE)
    end
	UA5:AddCommandMove(GetPosition("P-1"), true)
	UA5:AddCommandWaitForIdle(true)
	UA5:AddCommandMove(GetPosition("P-2"), true)
	UA5:AddCommandWaitForIdle(true)
	UA5:AddCommandMove(GetPosition("L4"), true)
	UA5:AddCommandWaitForIdle(true)
	UA5:AddCommandMove(GetPosition("L5"), true)
	UA5:AddCommandWaitForIdle(true)
	UA5:AddCommandMove(GetPosition("Turm_5"), true)
	UA5:AddCommandWaitForIdle(true)
end

function Angriff5()       -- Deff 5 Für Die Burgen
    if IsExisting("Turm_5_army_1") then
        if not UA5 or UA5:IsDead() then
			spawnArmy5()
			Angriffe = Angriffe + 1
        end
	end
end


----  Army 4   dIE DEFF FÜR ARMY 3

function spawnArmy4()
	UA4 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA4:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_4"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA4:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_4"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA4:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_4"), VERYHIGH_EXPERIENCE)
    end
	UA4:AddCommandMove(GetPosition("O1"), true)
	UA4:AddCommandWaitForIdle(true)
	UA4:AddCommandMove(GetPosition("O2"), true)
	UA4:AddCommandWaitForIdle(true)
	UA4:AddCommandMove(GetPosition("Turm_4"), true)
	UA4:AddCommandWaitForIdle(true)
end
		
function Angriff4()       -- Deff 4 Für Die Burgen
    if IsExisting("Turm_4_army_1") then
        if not UA4 or UA4:IsDead() then
			spawnArmy4()
			Angriffe = Angriffe + 1
        end
	end
end

--------------- ARMY 3

function spawnArmy3()
	UA3 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA3:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_4"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA3:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_4"), VERYHIGH_EXPERIENCE)
    end
	UA3:AddCommandMove(GetPosition("L1"), true)
	UA3:AddCommandWaitForIdle(true)
	UA3:AddCommandMove(GetPosition("L2"), true)
	UA3:AddCommandWaitForIdle(true)
	UA3:AddCommandMove(GetPosition("L3"), true)
	UA3:AddCommandWaitForIdle(true)
	UA3:AddCommandMove(GetPosition("L4"), true)
	UA3:AddCommandWaitForIdle(true)
	UA3:AddCommandMove(GetPosition("L5"), true)
	UA3:AddCommandWaitForIdle(true)
	UA3:AddCommandMove(GetPosition("Turm_4"), true)
	UA3:AddCommandWaitForIdle(true)
end

function Angriff3()       -- Deff 6 Für Die Burgen
    if IsExisting("Turm_4_army_1") then
        if not UA3 or UA3:IsDead() then
			spawnArmy3()
			Angriffe = Angriffe + 1
        end
	end
end

---  armme 2

function spawnArmy2()
	UA2 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,2 do
        UA2:CreateLeaderForArmy(Entities.PU_LeaderBow2, 4, GetPosition("Turm_2"), VERYHIGH_EXPERIENCE)
    end
    for i=1,2 do
        UA2:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_2"), VERYHIGH_EXPERIENCE)
    end
	UA2:AddCommandMove(GetPosition("L-1"), true)
	UA2:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("L-2"), true)
	UA2:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("L2"), true)
	UA2:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("L3"), true)
	UA2:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("L4"), true)
	UA2:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("L5"), true)
	UA3:AddCommandWaitForIdle(true)
	UA2:AddCommandMove(GetPosition("Turm_2"), true)
	UA2:AddCommandWaitForIdle(true)
end

function Angriff2()       -- Deff 2 Für Die Burgen
    if IsExisting("Turm_2_army_1") then
        if not UA2 or UA2:IsDead() then
			spawnArmy2()
			Angriffe = Angriffe + 1
        end
	end
end

----  Army 1   dIE DEFF FÜR ARMY 3

function spawnArmy1()
	UA1 = UnlimitedArmy:New{
        Player = 6,
        Area = 5000,
        AutoRotateRange = 10000,
        Formation = UnlimitedArmy.Formations.Lines,
        AutoDestroyIfEmpty = true,
        IgnoreFleeing = true,
    }
    for i=1,8 do
        UA1:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2, 4, GetPosition("Turm_2"), VERYHIGH_EXPERIENCE)
    end
    for i=1,4 do
        UA1:CreateLeaderForArmy(Entities.CU_BlackKnight_LeaderMace1, 4, GetPosition("Turm_2"), VERYHIGH_EXPERIENCE)
    end
    for i=1,8 do
        UA1:CreateLeaderForArmy(Entities.PU_LeaderRifle1, 4, GetPosition("Turm_2"), VERYHIGH_EXPERIENCE)
    end
	UA1:AddCommandMove(GetPosition("L-1"), true)
	UA1:AddCommandWaitForIdle(true)
	UA1:AddCommandMove(GetPosition("S2"), true)
	UA1:AddCommandWaitForIdle(true)
	UA1:AddCommandMove(GetPosition("Turm_2"), true)
	UA1:AddCommandWaitForIdle(true)
end
		
function Angriff1()       -- Deff 1 Für Die Burgen
    if IsExisting("Turm_2_army_1") then
        if not UA1 or UA1:IsDead() then
			spawnArmy1()
			Angriffe = Angriffe + 1
        end
	end
end


-- Schatztruhen


function chestCallbackGold()
 Message("Ihr habt einen Schatz mit 10050 Talern gefunden")
 AddGold(10050)
end

-- Limit the Technologies here. For example Weathermashine.

function Mission_InitTechnologies()
    for i  = 6, 6 do
        ResearchTechnology(Technologies.T_BodkinArrow, i)
        ResearchTechnology(Technologies.T_Fletching, i)
        ResearchTechnology(Technologies.T_WoodAging, i)
        ResearchTechnology(Technologies.T_Turnery, i)
        ResearchTechnology(Technologies.T_Masonry, i)
        ResearchTechnology(Technologies.GT_Binocul, i)
        ResearchTechnology(Technologies.GT_Mathematics, i)
        ResearchTechnology(Technologies.T_PaddedArcherArmor, i)
        ResearchTechnology(Technologies.T_LeatherArcherArmor, i)
        ResearchTechnology(Technologies.T_LeatherMailArmor, i)
        ResearchTechnology(Technologies.T_SoftArcherArmor, i)
        ResearchTechnology(Technologies.T_ChainMailArmor, i)
        ResearchTechnology(Technologies.T_PlateMailArmor, i)
        ResearchTechnology(Technologies.T_MasterOfSmithery, i)
        ResearchTechnology(Technologies.T_IronCasting, i)
        ResearchTechnology(Technologies.T_BetterTrainingArchery, i)
        ResearchTechnology(Technologies.T_Research_Shoeing, i)
        ResearchTechnology(Technologies.T_BetterTrainingBarracks, i)
    end
end


-- Holzstapel

function CreateWoodPile( _posEntity, _resources )
	assert( type( _posEntity ) == "string" );
	assert( type( _resources ) == "number" );
	gvWoodPiles = gvWoodPiles or {
		JobID = StartSimpleJob("ControlWoodPiles"),
	};
	local pos = GetPosition( _posEntity );
	local pile_id = Logic.CreateEntity( Entities.XD_Rock3, pos.X, pos.Y, 0, 0 );

	SetEntityName( pile_id, _posEntity.."_WoodPile" );

	local newE = ReplaceEntity( _posEntity, Entities.XD_ResourceTree );
	Logic.SetModelAndAnimSet(newE, Models.XD_SignalFire1);
	Logic.SetResourceDoodadGoodAmount( GetEntityId( _posEntity ), _resources*10 );
	Logic.SetModelAndAnimSet(pile_id, Models.Effects_XF_ChopTree);
	table.insert( gvWoodPiles, { ResourceEntity = _posEntity, PileEntity = _posEntity.."_WoodPile", ResourceLimit = _resources*9 } );
end

function ControlWoodPiles()
	for i = table.getn( gvWoodPiles ),1,-1 do
		if Logic.GetResourceDoodadGoodAmount( GetEntityId( gvWoodPiles[i].ResourceEntity ) ) <= gvWoodPiles[i].ResourceLimit then
			DestroyWoodPile( gvWoodPiles[i], i );
		end
	end
end

function DestroyWoodPile( _piletable, _index )
	local pos = GetPosition( _piletable.ResourceEntity );
	DestroyEntity( _piletable.ResourceEntity );
	DestroyEntity( _piletable.PileEntity );
	Logic.CreateEffect( GGL_Effects.FXCrushBuilding, pos.X, pos.Y, 0 );
	table.remove( gvWoodPiles, _index )
end


