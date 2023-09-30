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
	Version = 1,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		Angriffe = 0
	    MercTent1()
		MercTent2()
		MercTent3()
		MercTent4()
		 Angriffe = 0
        StartSimpleJob("WaypointsFunc")
        StartSimpleJob("Action_ChestJob")
		
		CreateWoodPile( "P8", 500000)		
		CreateWoodPile( "P7", 500000)
	    CreateWoodPile( "P6", 500000)		
		CreateWoodPile( "P5", 500000)
		CreateWoodPile( "P4", 500000)
		CreateWoodPile( "P3", 500000)		
		CreateWoodPile( "P2", 500000)
		CreateWoodPile( "P1", 500000)
			
		SetHostile( 1, 10 )
		SetHostile( 2, 10 )
		SetHostile( 3, 10 )
	    SetHostile( 4, 10 )	
		SetHostile( 5, 10 )
		SetHostile( 6, 10 )
		SetHostile( 7, 10 )
	    SetHostile( 8, 10 )	
		SetHostile( 10, 1 )
		SetHostile( 10, 2 )
		SetHostile( 10, 3 )
	    SetHostile( 10, 4 )	
		SetHostile( 10, 5 )
		SetHostile( 10, 6 )
		SetHostile( 10, 7 )
	    SetHostile( 10, 8 )			
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		MapTools.OpenPalisadeGates();
		StartSimpleJob("Angriff1")
	    StartSimpleJob("Angriff2")
		StartSimpleJob("Angriff3")
	end,
 
  		-- ********************************************************************************************
	-- * AI Players
	-- * Player Entities that belong to an ID that is also present in the AIPlayers table won't be
	-- * removed
	-- ********************************************************************************************
	AIPlayers = {10},

	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 40,
 
	-- ********************************************************************************************
	-- * GameMode
	-- * GameMode is a concept of a switchable option, that the scripter can freely use
	-- *
	-- * GameModes is a table that contains the available options for the players, for example:
	-- * GameModes = {"3vs3", "2vs2", "1vs1"},
	-- *
	-- * GameMode contains the index of selected mode by default - ranging from 1 to X
	-- *
	-- * Callback_GameModeSelected
	-- * Lets the scripter make changes, according to the selected game mode.
	-- * You could give different ressources or change the map environment accordingly
	-- * _gamemode contains the index of the selected option according to the GameModes table
	-- ********************************************************************************************
	GameMode = 1,
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
	end,
	
	-- ********************************************************************************************
	-- * Resource Level
	-- * Determines how much ressources the players start with
	-- * 1 = Normal
	-- * 2 = FastGame
	-- * 3 = SpeedGame
	-- * See the ressources table below for configuration
	-- ********************************************************************************************
	ResourceLevel = 1,
 
	-- ********************************************************************************************
	-- * Resources
	-- * Order:
	-- * Gold, Clay, Wood, Stone, Iron, Sulfur
	-- * Rules:
	-- * 1. If no player is defined, default values are used
	-- * 2. If player 1 is defined, these ressources will be used for all other players too
	-- * 3. Use the players index to give ressources explicitly
	-- ********************************************************************************************
	Ressources =
	{
		Normal = {
			[1] = {
				500,
				2200,
				1600,
				700,
				50,
				50,
			},
		},
	},
 
	-- ********************************************************************************************
	-- * Callback_OnFastGame
	-- * Called together with Callback_OnGameStart if the player selected ResourceLevel 2 or 3
	-- * (FastGame or SpeedGame)
	-- ********************************************************************************************
	Callback_OnFastGame = function()
	end,

};

 function MercTent1()
  local mercenaryId = GetEntityId("MercTent1")
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 400, ResourceType.Gold, 1800);
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 400, ResourceType.Gold, 1800);
end

  function MercTent2()
  local mercenaryId = GetEntityId("MercTent2")
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 400, ResourceType.Gold, 1800);
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 400, ResourceType.Gold, 1800);
end
  function MercTent3()
  local mercenaryId = GetEntityId("MercTent3")
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 400, ResourceType.Gold, 1800);
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 400, ResourceType.Gold, 1800);
end
  function MercTent4()
  local mercenaryId = GetEntityId("MercTent4")
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 400, ResourceType.Gold, 1800);
  Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 400, ResourceType.Gold, 1800);
end


function Chests()
	StartSimpleJob("Action_ChestJob") -- Comforts
	CreateRandomGoldChests()
  
	CreateChest(GetPosition("chest1"),chestCallback ) 
	StartChestQuest()
end

function chestCallbackchest1(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 10000)
--
    if GUI.GetPlayerID() == playerID then
      for i = 1, 8 do
        if playerID == i then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 10000 Taler gefunden!");
           Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
        end
      end
    end

function Angriff1()        --  Angriff 1
			if IsDead("Nebelruine1")  or RemoveSpawners then
		return true
end	 
		if IsDestroyed("Nebelruine1_1") and IsDestroyed("Nebelruine1_2") and IsDestroyed("Nebelruine1_3") and IsDestroyed("Nebelruine1_4") and IsDestroyed("Nebelruine1_5") and IsDestroyed("Nebelruine1_6") then
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_1")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_2")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_3")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_4")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_5")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_6")
            AddWaypoints("Nebelruine1_1", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_2", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_3", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_4", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_5", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_6", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
			Angriffe = Angriffe + 1
        end
end

function Angriff2()        --  Angriff 2
			if IsDead("Nebelruine1")  or RemoveSpawners then
		return true
end	 
		if IsDestroyed("Nebelruine1_7") and IsDestroyed("Nebelruine1_8") and IsDestroyed("Nebelruine1_9") and IsDestroyed("Nebelruine1_10") and IsDestroyed("Nebelruine1_11") and IsDestroyed("Nebelruine1_12") then
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_7")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_8")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_9")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_10")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_11")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_12")
            AddWaypoints("Nebelruine1_7", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_8", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_9", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_10", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_11", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_12", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
			Angriffe = Angriffe + 1
        end
end

function Angriff3()        --  Angriff 3
			if IsDead("Nebelruine1")  or RemoveSpawners then
		return true
end	 
		if IsDestroyed("Nebelruine1_13") and IsDestroyed("Nebelruine1_14") and IsDestroyed("Nebelruine1_15") and IsDestroyed("Nebelruine1_16") and IsDestroyed("Nebelruine1_17") and IsDestroyed("Nebelruine1_18") then
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_13")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_14")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderBearman1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_15")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_16")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_17")
			CreateMilitaryGroup(10,Entities.CU_Evil_LeaderSkirmisher1,16,GetPosition("Nebelruine1_Angriff"),"Nebelruine1_18")
            AddWaypoints("Nebelruine1_13", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_14", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_15", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_16", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_17", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
            AddWaypoints("Nebelruine1_18", {"KI_Weg1", "KI_Weg2", "TTT3",  loop=true})
			Angriffe = Angriffe + 1
        end
end

--Truppen Entity nach Entity bewegen (Übernimmt ALLE DAVORSTEHENDEN Function Angriff1, Angriff2 usw. Befehle)--

Waypoints = {}
function AddWaypoints(name, points)
    Waypoints[name] = points
    points.i = 1
end
function WaypointsFunc()
    if Counter.Tick2("Waypoints", 20) then
        for name, points in pairs(Waypoints) do
            if IsAlive(name) then
                if IsValid(points[points.i]) and IsNear(name, points[points.i], 1000) then
                    points.i = points.i + 1
                    if IsDestroyed(points[points.i]) and points.loop then
                        points.i = 1
                    end
                end
                if IsValid(points[points.i]) then
                    Attack(name, points[points.i])
                end
            end
        end
    end
end

function Action_ChestJob() --StartSimpleJob("Action_ChestJob")
    for i = 1 , table.getn(chestControl.list) , 1 do
        if chestControl.list[i].state == CHEST_CLOSED then 
            for j = 1 , table.getn(chestOpener) , 1 do
                if IsNear(chestOpener[j],chestControl.list[i].name,250) then 
                    chestControl.list[i].callback(chestOpener[j]) -- Änderung hier 
                    chestControl.list[i].state = CHEST_OPENED 
                    ReplaceEntity(chestControl.list[i].name,Entities.XD_ChestOpen)

--                    Sound.PlayGUISound( Sounds.OnKlick_Select_erec, 0 )
--                    Sound.PlayGUISound(Sounds.Misc_Chat,65)
                    end 
                end
            end 
        end
    return false        
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