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
	Version = 1.0,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
	Callback_OnMapStart = function()

		AddPeriodicSummer(10)
		SetupNormalWeatherGfxSet()

		LocalMusic.UseSet = EUROPEMUSIC

		local resourceTable = {
			{Entities.XD_ClayPit1, 50000},
			{Entities.XD_StonePit1, 50000},
			{Entities.XD_IronPit1, 30000},
			{Entities.XD_SulfurPit1, 30000},
			{Entities.XD_Clay1, 4000},
			{Entities.XD_Stone1, 4000},
			{Entities.XD_Iron1, 4000},
			{Entities.XD_Sulfur1, 4000},
		}
		MapTools.SetMapResource(resourceTable)

        for p = 1, 16 do
			if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(p) == 0 then
                DestroyEntity("hq" .. p)
                DestroyEntity("vc" .. p .. "a")
                DestroyEntity("vc" .. p .. "b")
                DestroyEntity("vc" .. p .. "c")
                DestroyEntity("vc" .. p .. "d")
                DestroyEntity("clay" .. p)
                DestroyEntity("stone" .. p)
                DestroyEntity("iron" .. p .. "a")
                DestroyEntity("iron" .. p .. "b")
                DestroyEntity("sulfur" .. p .. "a")
                DestroyEntity("sulfur" .. p .. "b")

                for id in CEntityIterator.Iterator(CEntityIterator.OfPlayerFilter(p), CEntityIterator.OfTypeFilter(Entities.XD_StandartePlayerColor)) do
                    DestroyEntity(id)
                end
            end
        end
        
		for i = 1, 32 do
			CreateWoodPile("wood"..i, 20000)
		end
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
		for i = 1, 16 do
			DestroyEntity("block"..i)
		end
	end,

 
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
	-- * Called together with Callback_OnGameStart if the player selected ResourceLevel 2 or 3
	-- * (FastGame or SpeedGame)
	-- ********************************************************************************************
	Callback_OnFastGame = function()
        MapTools.RecreateFastGameEntities()
	end,
 
	-- ********************************************************************************************
	-- * AI Players
	-- * Player Entities that belong to an ID that is also present in the AIPlayers table won't be
	-- * removed
	-- ********************************************************************************************
	AIPlayers = {}
}
--------------------------------------WoodPiles--------------------------------------------------
function CreateWoodPile( _posEntity, _resources )
    assert( type( _posEntity ) == "string" )
    assert( type( _resources ) == "number" )
    gvWoodPiles = gvWoodPiles or {
        JobID = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND,nil,"ControlWoodPiles",0,nil,nil),
    }
    local pos = GetPosition( _posEntity )
    local pile_id = Logic.CreateEntity( Entities.XD_Rock3, pos.X, pos.Y, 0, 0 )

    SetEntityName( pile_id, _posEntity.."_WoodPile" )

    local newE = ReplaceEntity( _posEntity, Entities.XD_ResourceTree )
    Logic.SetModelAndAnimSet(newE, Models.XD_SignalFire1)
    Logic.SetResourceDoodadGoodAmount( GetEntityId( _posEntity ), _resources*10 )
    Logic.SetModelAndAnimSet(pile_id, Models.Effects_XF_ChopTree)
    table.insert( gvWoodPiles, { ResourceEntity = _posEntity, PileEntity = _posEntity.."_WoodPile", ResourceLimit = _resources*9 } )
end

function ControlWoodPiles()
    for i = table.getn( gvWoodPiles ),1,-1 do
        if Logic.GetResourceDoodadGoodAmount( GetEntityId( gvWoodPiles[i].ResourceEntity ) ) <= gvWoodPiles[i].ResourceLimit then
            DestroyWoodPile( gvWoodPiles[i], i )
        end
    end
end

function DestroyWoodPile( _piletable, _index )
    local pos = GetPosition( _piletable.ResourceEntity )
    DestroyEntity( _piletable.ResourceEntity )
    DestroyEntity( _piletable.PileEntity )
    Logic.CreateEffect( GGL_Effects.FXCrushBuilding, pos.X, pos.Y, 0 )
    table.remove( gvWoodPiles, _index )
end