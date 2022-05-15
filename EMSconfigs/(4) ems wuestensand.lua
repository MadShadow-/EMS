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
	Version = 1,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		MapTools.RemoveFastGameEntities()
		
		for i = 1,4 do
			CreateWoodPile("Wood"..i, 50000)
		end

		AddPeriodicSummer(60);
		SetupMediterraneanWeatherGfxSet();
		LocalMusic.UseSet = MEDITERANEANMUSIC;
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for i =1,12,1 do
			DestroyEntity("Rock"..i)
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

-------------------------------------------------------------------------------------------------------
--------------------------- Misc Comforts -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
function CreateWoodPile( _posEntity, _resources )

    assert( type( _posEntity ) == "string" );
	
    assert( type( _resources ) == "number" );
	
    gvWoodPiles = gvWoodPiles or {
	
        JobID = StartSimpleJob("ControlWoodPiles"),
		
    };
	
    local pos = {}
	
	pos.X,pos.Y = Logic.GetEntityPosition(Logic.GetEntityIDByName(_posEntity))
	
    local pile_id = Logic.CreateEntity( Entities.XD_Rock3, pos.X, pos.Y, 0, 0 );
	
    SetEntityName( pile_id, _posEntity.."_WoodPile" );
	
    local newE = ReplacingEntity( _posEntity, Entities.XD_ResourceTree );
	
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

function ReplacingEntity(_Entity, _EntityType)

	local entityId      = Logic.GetEntityIDByName(_Entity)
	
	local pos 			= {}
	
	pos.X,pos.Y  		= Logic.GetEntityPosition(entityId)
	
	local name 			= Logic.GetEntityName(entityId)
	
	local player 		= Logic.EntityGetPlayer(entityId)
	
	local orientation 	= Logic.GetEntityOrientation(entityId)
	
	local wasSelected	= IsEntitySelected(_Entity)
	
	if wasSelected then
	
		GUI.DeselectEntity(entityId)
		
    end
	
	DestroyEntity(_Entity)
	
	local newEntityId = Logic.CreateEntity(_EntityType,pos.X,pos.Y,orientation,player)
	
	Logic.SetEntityName(newEntityId, name)
	
	if wasSelected then
	
		GUI.SelectEntity(newEntityId)
		
    end
	
	GroupSelection_EntityIDChanged(entityId, newEntityId)
	
	return newEntityId
	
end