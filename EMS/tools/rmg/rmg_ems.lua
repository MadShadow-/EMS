EMS_CustomMapConfig.Version = EMS_CustomMapConfig.Version + 3.0
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
RMG.LandscapeSetKeys = {
	{id = "Normal",		eval = RMG.SetupLandscapeNormal, representative = "Europa"},
	{id = "North",		eval = RMG.SetupLandscapeNorth, representative = "Skandinavien"},
	{id = "Evelance",	eval = RMG.SetupLandscapeEvelance},
	{id = "Mediterran",	eval = RMG.SetupLandscapeMediterran},
	{id = "Moor",		eval = RMG.SetupLandscapeMoor},
	{id = "Tideland",	eval = RMG.SetupLandscapeTideland, representative = "Küstenland"},
	{id = "Steppe",		eval = RMG.SetupLandscapeSteppe,},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RMG.TeamBorderTypes = {
	{id = "none",  representative = "keine",  gate = 0},
	{id = "fence", representative = "Zaun",   gate = 1},
	{id = "river", representative = "Flüsse", gate = 0},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RMG.GateLayouts = {
	{id = "team", representative = "je Team"},
	--{id = "player", representative = "je Spieler"},
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RMG.GateSizes = {
	{id = 2.25, representative = "sehr klein"},
	{id = 2.5,  representative = "klein"},
	{id = 3,    representative = "moderat"},
	{id = 4,    representative = "groß"},
	{id = 6,    representative = "sehr groß"},
}
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RMG.CustomizeGenerationData(_GenerationData)

    local seed = EMS.RD.Rules.RMG_Seed:GetValue()

	_GenerationData.Seed = seed,
	SimplexNoise.seedP(seed)

	math.randomseed(seed)
	gvRandomseed = true -- prevent GetRandom from reseeding

	_GenerationData.TeamBorderType			= EMS.RD.Rules.RMG_GenerateRivers:GetValue()
	_GenerationData.GateLayout				= EMS.RD.Rules.RMG_GateLayout:GetValue()
	_GenerationData.GateSize				= RMG.GateSizes[EMS.RD.Rules.RMG_GateSize:GetValue()].id
	_GenerationData.GenerateRoads 			= Num2Bool(EMS.RD.Rules.RMG_GenerateRoads:GetValue())

	_GenerationData.LandscapeSetKey			= RMG.LandscapeSetKeys[EMS.RD.Rules.RMG_LandscapeSet:GetValue()].id
	_GenerationData.MirrorMap				= Num2Bool(EMS.RD.Rules.RMG_MirrorMap:GetValue())
	_GenerationData.RandomPlayerPosition	= Num2Bool(EMS.RD.Rules.RMG_RandomPlayerPosition:GetValue())

	_GenerationData.ContentClayPit          = EMS.RD.Rules.RMG_ContentClayPit:GetValue()
	_GenerationData.ContentClayPile         = EMS.RD.Rules.RMG_ContentClayPile:GetValue()
	_GenerationData.ContentStonePit	        = EMS.RD.Rules.RMG_ContentStonePit:GetValue()
	_GenerationData.ContentStonePile	    = EMS.RD.Rules.RMG_ContentStonePile:GetValue()
	_GenerationData.ContentIronPit	        = EMS.RD.Rules.RMG_ContentIronPit:GetValue()
	_GenerationData.ContentIronPile	        = EMS.RD.Rules.RMG_ContentIronPile:GetValue()
	_GenerationData.ContentSulfurPit	    = EMS.RD.Rules.RMG_ContentSulfurPit:GetValue()
	_GenerationData.ContentSulfurPile	    = EMS.RD.Rules.RMG_ContentSulfurPile:GetValue()
	_GenerationData.ContentWoodPile	        = EMS.RD.Rules.RMG_ContentWoodPile:GetValue()

    _GenerationData.AmountClayPit		    = EMS.RD.Rules.RMG_AmountClayPit:GetValue()
	_GenerationData.AmountClayPile	        = EMS.RD.Rules.RMG_AmountClayPile:GetValue()
	_GenerationData.AmountStonePit	        = EMS.RD.Rules.RMG_AmountStonePit:GetValue()
	_GenerationData.AmountStonePile	        = EMS.RD.Rules.RMG_AmountStonePile:GetValue()
	_GenerationData.AmountIronPit		    = EMS.RD.Rules.RMG_AmountIronPit:GetValue()
	_GenerationData.AmountIronPile	        = EMS.RD.Rules.RMG_AmountIronPile:GetValue()
	_GenerationData.AmountSulfurPit	        = EMS.RD.Rules.RMG_AmountSulfurPit:GetValue()
	_GenerationData.AmountSulfurPile	    = EMS.RD.Rules.RMG_AmountSulfurPile:GetValue()
	_GenerationData.AmountWoodPile	        = EMS.RD.Rules.RMG_AmountWoodPile:GetValue()
	_GenerationData.AmountVillageCenter     = EMS.RD.Rules.RMG_AmountVC:GetValue()

	_GenerationData.ExploreResources        = EMS.RD.Rules.RMG_ShowResources:GetValue()
	_GenerationData.ExploreVCs              = EMS.RD.Rules.RMG_ShowVillageCenters:GetValue()

    -- get number of players and number of teams
	local nplayers, players, nteams         = RMG.UnpackPlayerConfig()

	-- player config may be 0 if rmg rule page was not initialized, get data directly in this case
	if EMS.RD.Rules.RMG_PlayerConfig:GetValue() == 0 then
		nplayers, players, nteams           = RMG.GetPlayersAndTeams()
	end

	_GenerationData.Players = {}
	_GenerationData.NumberOfPlayers = nplayers
	_GenerationData.NumberOfTeams = nteams

	for p = 1, nplayers do
		table.insert(_GenerationData.Players, {Id = players[p].Id, Team = players[p].Team, IsHuman = players[p].IsHuman, IsReady = false,})
	end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function RMG.DeleteBridges(_GenerationData)
	if EMS_CustomMapConfig.Peacetime > 0 and _GenerationData.TeamBorderType == 3 then
		for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.PB_Bridge1)) do
			DestroyEntity(id)
		end
		for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.PB_Bridge2)) do
			DestroyEntity(id)
		end
		for p = 1, _GenerationData.NumberOfPlayers do
			ForbidTechnology(Technologies.B_Bridge, p)
		end
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- override EMS StartRequest
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RMG.Callback_OnGenerationFinished()
    RMG.EMS_GL_StartRequestYes()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
RMG.EMS_GL_StartRequestYes = EMS.GL.StartRequestYes
EMS.GL.StartRequestYes = function()
	
	if not RMG.GenerationStarted then
		
		RMG.GenerationStarted = true
		
		if EMS.UseCNetwork then
			Sync.Call("EMS.GL.SetRulesByConfig", Sync.TableToString(EMS.RD.GetRuleConfig()));
		else
			Sync.Call("EMS.GL.SetRulesByConfig", EMS.RD.GetRuleConfig());
		end
		
		if CNetwork and EMS.CanChangeRules then
			CNetwork.SendCommand("RMG.GenerateMap")
		else
			RMG.GenerateMap()
		end
	end
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 -- load these files at the end due to dependencies
 --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
Script.Load("maps\\user\\EMS\\tools\\rmg\\rmg_guil.lua")
Script.Load("maps\\user\\EMS\\tools\\rmg\\rmg_ruledata.lua")

RMG.GL_Setup()
RMG.SetRulesToDefault()

-- init on rule page changed, not immediately because player data is not yet available >:(
RMG.EMS_GL_ToggleRulePage = EMS.GL.ToggleRulePage
EMS.GL.ToggleRulePage = function(_value)
	RMG.PackPlayerConfig(unpack({RMG.GetPlayersAndTeams()}))
	XGUIEng.ShowWidget("RMG6", 1)
	EMS.GL.DbgShow_PlayerConfig()
	
	EMS.GL.ToggleRulePage = RMG.EMS_GL_ToggleRulePage
	RMG.EMS_GL_ToggleRulePage = nil
	EMS.GL.ToggleRulePage(_value)
end