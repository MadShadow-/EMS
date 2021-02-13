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
	Version = 1.24,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		TriggerFix_mode = "Xpcall"
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua")
		mcbPacker.mainPath="maps\\user\\EMS\\tools\\"
		mcbPacker.require("s5CommunityLib/comfort/other/FrameworkWrapperLight")
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\lib\\UnlimitedArmySpawnGenerator.lua")
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\\comfort\\player\\AddTribute.lua")
		S5HookLoader.Init()
		EntityIdChangedHelper.Init()
		LuaDebugger.Log() = function()end
		--ActivateDebug = true
		--TriggerFix.xpcallTimeMsg = false
		Logic.SetPlayerRawName(5, "Highport")
		Logic.SetPlayerRawName(6, "Nebelvolk")
		Logic.SetPlayerRawName(7, "Barbaren")
		Logic.SetPlayerRawName(8, "Nomaden")
		InitWeather()
		InitDiplomacy()
		InitTechnologies()
		AddPeriodicRain(193)
		LocalMusic.UseSet = DARKMOORMUSIC
		CreateArmies()
		BarBarAttackDelayCounter = 600
		BarBarUArightDone = true
		BarbarUAleftDone = true
		BarbarAttackFlag = false
		flagcounterTeam1 = 0
		flagcounterTeam2 = 0
		NorthTeam = {1,2}
		SouthTeam = {3,4}
		ThiefPlayerCounter = {0,0,0,0}
		ThiefAtKala = {0,0,0,0}
		ThiefAtKeberos =  {0,0,0,0}
		KalaTributes = {}
		KerberosTributes = {}
		ReiterAnzahl = 1
		basedownx = 0
		basedowny = 0
		TeamNorthHasAllied = false
		TeamSouthHasAllied = false
		KalaPosition = GetPosition("NVLeader")
		KeberosPosition = GetPosition("DarkLeader")
		CreateWoodPiles()
		StartSimpleJob("BombSquadTrigger")
		MiddleUnitTrader()
		CreateBarBarCamps()
		SetupColorMappingForPlayers()
		newHintTable = {
		"Ihr seit nicht in der Lage mehr als einen Dieb zu besitzen.",
		"Man munkelt, dass sich einer der beiden Oberhäupter anschließen kann. Jetzt muss man nur noch jemanden mit Tarnung durchschleusen um zu verhandeln...",
		"Glaube wird in der Kapelle, Kirche oder der Kathedrale von den Mönchen produziert (maximal 5000).",
		"Was hier wohl Flaggen zu suchen haben...",
		"Jedes Oberhaupt hat Stärken und Schwächen.",
		"Wo ist denn das Eisen und der Schwefel?",
		"Was sich wohl auf der Insel befindet...",
		"Jeder Held hat seine Vorteile. Nutzt sie weise!",
		"Irgendwie sind nicht alle Technologien verfügbar. Vielleicht bekommt man sie auf anderen Wegen.",
		"Handel kann ganz sinnvoll sein je nachdem in welcher Situation man sich befindet.",
		"Einige Sachen werden mit Glauben finanziert, da sie euch ethnisch negativ belasten."
		}
		
	function InterfaceTool_CreateCostString( _Costs )

	local PlayerID = GUI.GetPlayerID()
	
	local PlayerClay   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Clay ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.ClayRaw)	
	local PlayerGold   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Gold ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.GoldRaw)
	local PlayerSilver = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Silver ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.SilverRaw)
	local PlayerWood   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Wood ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.WoodRaw)
	local PlayerIron   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Iron ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.IronRaw)
	local PlayerStone  = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Stone ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.StoneRaw)
	local PlayerSulfur = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Sulfur ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.SulfurRaw)
	local PlayerFaith  = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Faith )

	local CostString = ""
	
	if _Costs[ ResourceType.Faith ] ~= 0 then
		CostString = "Glauben"
		if PlayerFaith >= _Costs[ ResourceType.Faith ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[  ResourceType.Faith ] .. " @color:255,255,255,255 @cr "
	end
	
	if _Costs[ ResourceType.Gold ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameMoney") .. ": " 
		if PlayerGold >= _Costs[ ResourceType.Gold ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Gold ] .. " @color:255,255,255,255 @cr "
	end
	
	if _Costs[ ResourceType.Wood ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameWood") .. ": " 
		if PlayerWood >= _Costs[ ResourceType.Wood ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Wood ] .. " @color:255,255,255,255 @cr "
	end
	
	if _Costs[ ResourceType.Silver ] ~= 0 then
		CostString = CostString .. "Silver: " 
		if PlayerSilver >= _Costs[ ResourceType.Silver ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Silver ] .. " @color:255,255,255,255 @cr "
	end
		
	if _Costs[ ResourceType.Clay ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameClay") .. ": " 
		if PlayerClay >= _Costs[ ResourceType.Clay ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Clay ] .. " @color:255,255,255,255 @cr "
	end
			
	if _Costs[ ResourceType.Stone ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameStone") .. ": " 
		if PlayerStone >= _Costs[ ResourceType.Stone] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Stone ] .. " @color:255,255,255,255 @cr "
	end
	
	if _Costs[ ResourceType.Iron ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameIron") .. ": " 
		if PlayerIron >= _Costs[ ResourceType.Iron ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Iron ] .. " @color:255,255,255,255 @cr "
	end
		
	if _Costs[ ResourceType.Sulfur ] ~= 0 then
		CostString = CostString .. XGUIEng.GetStringTableText("InGameMessages/GUI_NameSulfur") .. ": " 
		if PlayerSulfur >= _Costs[ ResourceType.Sulfur ] then
			CostString = CostString .. " @color:255,255,255,255 "
		else
			CostString = CostString .. " @color:220,64,16,255 "
		end
		CostString = CostString .. _Costs[ ResourceType.Sulfur ] .. " @color:255,255,255,255 @cr "
	end

	return CostString

end
function
GUITooltip_TroopOffer(_SlotIndex)
		
	
	local LeaderType, Amount = Logic.GetMercenaryOffer(SelectedTroopMerchantID,_SlotIndex, InterfaceGlobals.CostTable)
	
	
	local TooltipText = "@color:180,180,180,255 "	
	local ShortCutToolTip = " "
	local CostString = InterfaceTool_CreateCostString( InterfaceGlobals.CostTable )
	
	
	
	local EntityTypeName = Logic.GetEntityTypeName( LeaderType )
	if EntityTypeName == nil then
		return
	end
	local NameString = "names/" .. EntityTypeName
	if XGUIEng.GetStringTableText(NameString) then
	TooltipText = TooltipText .. " " .. XGUIEng.GetStringTableText(NameString) .. " @cr "
	else
	TooltipText = TooltipText.." Bergkrieger @cr "
	end
	TooltipText = TooltipText .. "@color:255,255,255,255 Erwerbt eine Truppe dieser Einheitenart."
	
	
	XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomCosts, CostString)
	
	XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomText,TooltipText)
	XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomShortCut, ShortCutToolTip)


end
function InterfaceTool_HasPlayerEnoughResources_Feedback( _Costs )
	
	local PlayerID = GUI.GetPlayerID()
	
	
	local Clay = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Clay ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.ClayRaw)	
	local Wood = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Wood ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.WoodRaw)
	local Gold   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Gold ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.GoldRaw)
	local Iron   = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Iron ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.IronRaw)
	local Stone  = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Stone ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.StoneRaw)
	local Sulfur = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Sulfur ) + Logic.GetPlayersGlobalResource( PlayerID, ResourceType.SulfurRaw)
	local Faith = Logic.GetPlayersGlobalResource( PlayerID, ResourceType.Faith)


	local Message = ""
	
	if 	_Costs[ ResourceType.Sulfur ] ~= nil and Sulfur < _Costs[ ResourceType.Sulfur ] then		
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughSulfur"), _Costs[ ResourceType.Sulfur ] - Sulfur )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Sulfur, _Costs[ ResourceType.Sulfur ] - Sulfur )
	end
		
	if _Costs[ ResourceType.Iron ] ~= nil and Iron < _Costs[ ResourceType.Iron ] then		
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughIron"), _Costs[ ResourceType.Iron ] - Iron )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Iron, _Costs[ ResourceType.Iron ] - Iron )
	end
	
	if _Costs[ ResourceType.Stone ] ~= nil and Stone < _Costs[ ResourceType.Stone ] then		
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughStone"), _Costs[ ResourceType.Stone ] - Stone )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Stone, _Costs[ ResourceType.Stone ] - Stone )
	end
	
	if _Costs[ ResourceType.Clay ] ~= nil and Clay < _Costs[ ResourceType.Clay ]  then
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughClay"), _Costs[ ResourceType.Clay ] - Clay )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Clay, _Costs[ ResourceType.Clay ] - Clay )
	end
	
	
	if _Costs[ ResourceType.Wood ] ~= nil and Wood < _Costs[ ResourceType.Wood ]  then
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughWood"), _Costs[ ResourceType.Wood ] - Wood )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Wood, _Costs[ ResourceType.Wood ] - Wood )
	end
	
	if _Costs[ ResourceType.Gold ] ~= nil and Gold < _Costs[ ResourceType.Gold ]  
	and _Costs[ ResourceType.Gold ] ~= 0 then
		Message = string.format(XGUIEng.GetStringTableText("InGameMessages/GUI_NotEnoughMoney"), _Costs[ ResourceType.Gold ] - Gold )
		GUI.AddNote( Message )
		GUI.SendNotEnoughResourcesFeedbackEvent( ResourceType.Gold, _Costs[ ResourceType.Gold ] - Gold )
	end
	if _Costs[ ResourceType.Faith ] ~= nil and Faith < _Costs[ ResourceType.Faith ]
	and _Costs[ ResourceType.Faith ] ~= 0 then
		Message = string.format("%d Glauben muss in der Kapelle, Kirche oder Kathedrale noch produziert werden", _Costs [ ResourceType.Faith ] - Faith )
		GUI.AddNote( Message )
	end

	-- Any message
	if Message ~= "" then
		return 0
	else
		return 1
	end
	
end

function 
GUIAction_OnlineHelp()
	
	local CurrentTime = Game.RealTimeGetMs() / 1000		
	if 		gvOnlineHelp_LastTimeStarted == nil 
		or 	( CurrentTime - gvOnlineHelp_LastTimeStarted ) > 2.0
	then			
		--get current selection
		local SelectedEntityID = GUI.GetSelectedEntity()
		
		local EntityType = Logic.GetEntityType( SelectedEntityID )
		
		local UpgradeCategory
		
		if Logic.IsBuilding( SelectedEntityID ) == 1 then	
			UpgradeCategory = Logic.GetUpgradeCategoryByBuildingType(EntityType)
		else
			UpgradeCategory = Logic.LeaderGetSoldierUpgradeCategory( SelectedEntityID )
		end
		
		
		
		--get random text and sound
		local RandomHelp = 1+XGUIEng.GetRandom(table.getn(newHintTable)-1)
				
		local SpokenText	= nil
		local Text 			= newHintTable[RandomHelp]
			
		--is something selected
		if SelectedEntityID ~= nil then	
			--YES!
			if HintTable[UpgradeCategory] ~= nil then
		
				-- use text from Upgradecategory		
				SpokenText	= Sounds["VoicesMentorHelp_" .. HintTable[UpgradeCategory]]
				Text 		= XGUIEng.GetStringTableText("VoicesMentorHelp/" .. HintTable[UpgradeCategory])			
			
			end
			
			if Logic.IsWorker(SelectedEntityID) == 1 then
				SpokenText	= Sounds.VoicesMentorHelp_UNIT_Workers
				Text 		= XGUIEng.GetStringTableText("VoicesMentorHelp/UNIT_Workers")
			end
			
			
			if Logic.IsHero(SelectedEntityID) == 1 then
				SpokenText	= Sounds.VoicesMentorHelp_UNIT_Heroes
				Text 		= XGUIEng.GetStringTableText("VoicesMentorHelp/UNIT_Heroes")
			end
			
			if GUIAction_AOOnlineHelp ~= nil then
				SpokenText, Text = GUIAction_AOOnlineHelp(SelectedEntityID, SpokenText, Text)
			end
		
			
		end
		if SpokenText ~= nil then
		Sound.StartOnlineHelpSound(SpokenText, 0)	
		end
		
		gvOnlineHelp_LastTimeStarted = CurrentTime
	
		--display text
		GUI.ClearNotes()
		GUI.AddNote(Text)
	end
end
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
	
	 Logic.AddWeatherElement(1,110,1,4,5,10) 
	 Logic.AddWeatherElement(1,505,1,1,5,10) 
	 Logic.AddWeatherElement(1,97,1,4,5,10) 
	 Logic.AddWeatherElement(2,260,1,2,5,10) 
	 Logic.AddWeatherElement(2,180,1,5,5,10)
	 Logic.AddWeatherElement(1,140,1,6,5,10)
	 Logic.AddWeatherElement(3,471,1,3,5,10)
	 Logic.AddWeatherElement(3,94,1,8,5,10)
	if Logic.GetTimeToNextWeatherPeriod() > 15 then
	Logic.SetWeatherOffset(Logic.GetTimeToNextWeatherPeriod()-10)
	end
	Maptimervariable = 0
	StartUnlimitedArmysStart()
	StartSimpleJob("StartFlagController")
	StartSimpleJob("MapTimeCounter")
	StartSimpleJob("CheckThiefLeaders")
	StartSimpleJob("KIBasesHQs")
	KILeaderThief1_Job = StartSimpleJob("KILeaderThief1")
	KILeaderThief2_Job = StartSimpleJob("KILeaderThief2")
	
    GUITooltip_TroopOfferOrig = GUITooltip_TroopOffer
    GUITooltip_TroopOffer = function(_index)
            if Logic.IsTechTraderBuilding(SelectedTroopMerchantID) == true then 
                local techType, amount = Logic.GetTechOffer(SelectedTroopMerchantID, _index, InterfaceGlobals.CostTable)
                local text = "@color:180,180,180,255 "   
                local costs = InterfaceTool_CreateCostString( InterfaceGlobals.CostTable )
                local techTypeName = table.foreach(Technologies, function(__k, __v) if techType == __v then return __k end end)
                if techTypeName == nil then
                    return
                end
                local nameString = "names/" .. techTypeName
				if XGUIEng.GetStringTableText(nameString) then
				text = text .. " " .. XGUIEng.GetStringTableText(nameString) .. " @cr "
                else
				text = text .. " Belagerungskanone bauen @cr "
				end
				text = text .. "@color:255,255,255,255  Erwerbt die Technologie."
 
                XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomCosts, costs )
                XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomText, text )
                XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomShortCut, " " )
            elseif Logic.IsMercenaryBuilding(SelectedTroopMerchantID) == true then 
                GUITooltip_TroopOfferOrig(_index)
            end
        end
    GUIUpdate_TroopOfferOrig = GUIUpdate_TroopOffer
    GUIUpdate_TroopOffer = function(_index)
            if Logic.IsTechTraderBuilding(SelectedTroopMerchantID) == true then  
                local techType, amount = Logic.GetTechOffer(SelectedTroopMerchantID, _index, InterfaceGlobals.CostTable)
                local currentWidget = XGUIEng.GetCurrentWidgetID() 
                local techTypeName = table.foreach(Technologies, function(__k, __v) if techType == __v then return __k end end)
                if techTypeName == nil then
                    return
                end 
                local position = string.find( techTypeName, "_" )
                local source = "Research" .. string.sub(techTypeName, position)
				if techTypeName == "MU_Cannon4" then
					source = "Buy_Cannon4"
				elseif techTypeName == "T_UpgradeHeavyCavalry1" then
					source = "Research_UpgradeCavalryHeavy1"
				end
                if XGUIEng.GetWidgetID(source) ~= 0 then
                    XGUIEng.TransferMaterials( source, currentWidget )
                end 
                if amount == -1 then
                    amount = "00"
                end
                XGUIEng.SetText(gvGUI_WidgetID.TroopMerchantOfferAmount[_index], "@ra " .. amount) 
            elseif Logic.IsMercenaryBuilding(SelectedTroopMerchantID) == true then 
                GUIUpdate_TroopOfferOrig(_index)
            end
        end
    GUIAction_BuyMerchantOfferOrig = GUIAction_BuyMerchantOffer
    GUIAction_BuyMerchantOffer = function(_index) 
            if Logic.IsTechTraderBuilding(SelectedTroopMerchantID) == true then 
                local techType = Logic.GetTechOffer(SelectedTroopMerchantID, _index, InterfaceGlobals.CostTable)
                if InterfaceTool_HasPlayerEnoughResources_Feedback( InterfaceGlobals.CostTable ) == 1 then 
                    GUI.BuyMerchantOffer(SelectedTroopMerchantID, GUI.GetPlayerID(), _index)
                    GUIUpdate_TroopOffer(_index)
                end
            elseif Logic.IsMercenaryBuilding(SelectedTroopMerchantID) == true then
                GUIAction_BuyMerchantOfferOrig(_index)
            end
        end
	
	MiddleTechTrader()
	InvulerableTowers(1)
	--test
	
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 0,
 
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
	-- * You could give different resources or change the map environment accordingly
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
				750,
				600,
				450,
				400,
				0,
				150,
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
	
	 
	-- ********************************************************************************************
	-- * AI Players
	-- * Player Entities that belong to an ID that is also present in the AIPlayers table won't be
	-- * removed
	-- ********************************************************************************************
	AIPlayers = {5,6,7,8},
 
	-- ********************************************************************************************
	-- * DisableInitCameraOnHeadquarter
	-- * Set to true if you don't want the camera to be set to the headquarter automatically
	-- * (default: false)
	-- ********************************************************************************************
	DisableInitCameraOnHeadquarter = false,
 
	-- ********************************************************************************************
	-- * DisableSetZoomFactor
	-- * If set to false, ZoomFactor will be set to 2 automatically
	-- * Set to true if nothing should be done
	-- * (default: false)
	-- ********************************************************************************************
	DisableSetZoomFactor = false,
 
	-- ********************************************************************************************
	-- * DisableStandardVictoryCondition
	-- * Set to true if you want to implement your own victory condition
	-- * Otherwise the player will lose upon losing his headquarter
	-- * (default: false)
	-- ********************************************************************************************
	DisableStandardVictoryCondition = false,
 
	-- ********************************************************************************************
	-- * Units
	-- * Various units can be allowed or forbidden
	-- * A 0 means the unit is forbidden - a higher number represents the maximum allowed level
	-- * Example: 
	-- * Sword = 0, equals Swords are forbidden
	-- * Sword = 2, equals the maximum level for swords is 2 = Upgrading once
	-- ********************************************************************************************
	Sword   = 4,
	Bow     = 4,
	PoleArm = 4,
	HeavyCavalry = 2,
	LightCavalry = 2,
	Rifle = 2,
	Thief = 1,
	Scout = 1,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
 
	-- * Buildings
	Bridge = 1,
	-- * Markets
	-- * -1 = forbidden
	-- * 0 = Building markets is allowed and unlimited
	-- * 1 = Building markets is allowed and limited to 1
	-- * greater then one = Markets are allowed and limited to the number given
	Markets = 1,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 0,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 4,
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  2,
 
	MakeSummer = 1,
	MakeRain   = 1,
	MakeSnow   = 1,
 
	-- * Fixes the DestrBuild bug
	AntiBug    = 1,
 
	-- * HQRush
	-- * If set to true, Headquarters are invulernerable as long the player still has village centers
	HQRush     = 1,
	BlessLimit = 1,
	InvulnerableHQs = false,
 
	-- * Heroes
	NumberOfHeroesForAll = 2,
	Dario    = 1,
	Pilgrim  = 1,
	Ari      = 1,
	Erec     = 0,
	Salim    = 1,
	Helias   = 1,
	Drake    = 0,
	Yuki     = 1,
	Kerberos = 1,
	Varg     = 1,
	Mary_de_Mortfichet = 1,
	Kala     = 1,
	
};

-- 1 Diebe max. auf der Weihnachtsmap; 
function GameCallback_PreBuyLeader(_buildingID, _uCat)
    local player = Logic.EntityGetPlayer(_buildingID)
    
    if _uCat == UpgradeCategories.Thief then
        local nthiefs = Logic.GetNumberOfEntitiesOfTypeOfPlayer(player, Entities.PU_Thief)
        if nthiefs >= 1 then
            return false
        end
    end
    return true
end; 

GUIAction_BuyMilitaryUnitOrig = GUIAction_BuyMilitaryUnit
function GUIAction_BuyMilitaryUnit(_UpgradeCategory)
    if _UpgradeCategory == UpgradeCategories.Thief then
        if Logic.GetNumberOfEntitiesOfTypeOfPlayer(GUI.GetPlayerID(),Entities.PU_Thief) >= 1 then
            Message("Ihr habt das Diebe-Limit erreicht!")
            return 
        else
            GUIAction_BuyMilitaryUnitOrig(_UpgradeCategory)
        end
    else
        GUIAction_BuyMilitaryUnitOrig(_UpgradeCategory)
    end
end 

function IsEnemyDead1(self)
	if NVBasedown then
		basedownx = self.Spawner.ArmySize
		self:ClearCommandQueue()
		self:KillAllLeaders()
		self:Destroy()
	end
	return true
end

function IsEnemyDead2(self)
	if KIBasedown then
		basedowny = self.Spawner.ArmySize
		self:ClearCommandQueue()
		self:KillAllLeaders()
		self:Destroy()
	end
	return true
end

function KIBasesHQs()
	if IsDead("NVHQ") and not NVBasedown then
		NVBasedown = true
	end
	if IsDead("KILeaderBase") and not KIBasedown then
		KIBasedown = true
	end
	if NVBasedown and KIBasedown then
		return true
	end
	return false
end

function SetupColorMappingForPlayers()
	local ai1Color = XNetwork.GameInformation_GetLogicPlayerColor(5)
	local ai2Color = XNetwork.GameInformation_GetLogicPlayerColor(6)
	local barbarcolor = XNetwork.GameInformation_GetLogicPlayerColor(7)
	local NPCcolor = XNetwork.GameInformation_GetLogicPlayerColor(8)
	if ai1Color == 0 then
		ai1Color = 9
	end
	if ai2Color == 0 then
		ai2Color = 13
	end
	if barbarcolor == 0 then
		barbarcolor = 14
	end
	if NPCcolor == 0 then
		NPCcolor = 11
	end
	
	local colors = {}
	for i = 1,4 do
		colors[XNetwork.GameInformation_GetLogicPlayerColor(i)] = true
	end
	
	-- enemy ai color not used

	-- if default colors green and white are not used by players-> use them
	if not colors[9] then
		ai1Color = 9
		colors[9] = true
	elseif colors[ai1Color] then
		-- set aiColor also used by player
		for i = 1, 16 do
			if not colors[i] then
				ai1Color = i
				colors[i] = true
				break
			end
		end
	end
	if not colors[13] then
		ai2Color = 13
		colors[13] = true
	elseif colors[ai2Color] then
		-- set aiColor also used by player
		for i = 1, 16 do
			if not colors[i] then
				ai2Color = i
				colors[i] = true
				break
			end
		end
	end
	
	if not colors[14] then
		barbarcolor = 14
		colors[barbarcolor] = true
	elseif colors[barbarcolor] then
		for i = 1,16 do
			if not colors[i] then
				barbarcolor = id
				colors[barbarcolor] = true
				break
			end
		end
	end
	
	if not colors[11] then
		NPCcolor = 11
		colors[11] = true
	elseif colors[NPCcolor] then
		for i = 1,16 do
			if not colors[i] then
				NPCcolor = id
				colors[i] = true
				break
			end
		end
	end
	-- set ingame colors
	Display.SetPlayerColorMapping(5, ai1Color)
	Display.SetPlayerColorMapping(6, ai2Color)
	Display.SetPlayerColorMapping(7,barbarcolor)
	Display.SetPlayerColorMapping(8,NPCcolor)
	
	-- stati colors
	local r,g,b = GUI.GetPlayerColor(5)
	Logic.PlayerSetPlayerColor(5, r, g, b)
	r,g,b = GUI.GetPlayerColor(6)
	Logic.PlayerSetPlayerColor(6, r, g, b)
	r,g,b = GUI.GetPlayerColor(7)
	Logic.PlayerSetPlayerColor(7, r, g, b)
end

function InitWeather()
	WeatherSets_SetupNormal(1) 	--normal sommer
	WeatherSets_SetupRain(2)	--normal regen
	WeatherSets_SetupSnow(3)	--normal winter
	WeatherSets_SetupNormal(4, 1, 0) --sommer mit regeneffekt
	WeatherSets_SetupRain(5, 0, 1) --regen mit wintereffekt
	WeatherSets_SetupNormal(6, 0, 1) --sommer mit wintereffekt
	WeatherSets_SetupNormal(7, 1, 1) --sommer mit regeneffekt und schneeffekt
	WeatherSets_SetupSnow(8,1,1) --winter mit schnee und regen
end

GameCallback_OnTechnologyResearchedOriginal = GameCallback_OnTechnologyResearched
function GameCallback_OnTechnologyResearched( _PlayerID, _TechnologyType )
	GameCallback_OnTechnologyResearchedOriginal( _PlayerID,_TechnologyType)
		if _TechnologyType == Technologies.T_TownGuard then
			Logic.SetTechnologyState(_PlayerID,Technologies.T_CityGuard, 3)
		end
		if _TechnologyType == Technologies.MU_Cannon4 then
			Logic.SetTechnologyState(_PlayerID,Technologies.MU_Cannon4, 2)
		end
end

function InvulerableTowers(_flag)
	for i = 1,7,1 do
		if IsAlive("NVTower"..i) then
			Logic.SetEntityInvulnerabilityFlag(GetID("NVTower"..i), _flag)
		end
	end
	for i = 1,5,1 do
		if IsAlive("KeberosTower"..i) then
			Logic.SetEntityInvulnerabilityFlag(GetID("KeberosTower"..i), _flag)
		end
	end
end

function InitDiplomacy()
SetFriendly(1,2)
SetFriendly(3,4)
Logic.SetShareExplorationWithPlayerFlag(1, 2, 1)

SetHostile(1,3)
SetHostile(1,4)
SetHostile(1,5)
SetHostile(1,6)
SetHostile(1,7)

SetHostile(2,3)
SetHostile(2,4)
SetHostile(2,5)
SetHostile(2,6)
SetHostile(2,7)

SetHostile(3,5)
SetHostile(3,6)
SetHostile(3,7)
SetHostile(4,5)
SetHostile(4,6)
SetHostile(4,7)

SetHostile(5,6)

SetFriendly(1,8)
SetFriendly(2,8)
SetFriendly(3,8)
SetFriendly(4,8)

Logic.SetShareExplorationWithPlayerFlag(3, 4, 1)
end

function InitTechnologies()
--Scharfschützen verbieten
-- was noch verbieten an techs? kaufbar in der mitte und kriegt man von der KI

-- NV Base: möglicher KI angriff + scharfschützen und alle techs dafür
-- Brücken in der Mitte gehen nach 60/80 min (wird bei Testphase entschieden) runter. Also wie Sudden Death
-- Mitte Lager techtrader: Sabotage bei Dieben (nur ein Dieb pro Team oder Spieler erlaubt), Skav Lvl2, Wettertechs, funktionierende Stadtwache.
-- Mitte Lager Einheitentrader: die Bergkrieger-soldaten (Veteranen, Pilgrim Kampagne), schwere Scharfschützen (wenn es geht mit 4 Soldaten), Bronzekanonen, Banditentruppen
-- normale KI (Spieler 5): möglicher KI angriff + schwere Kanonen (Eisen und Belagerungskanonen) und Skav lvl1.
for i = 1,4,1 do
Logic.SetTechnologyState(i,Technologies.T_ThiefSabotage, 0)
Logic.SetTechnologyState(i,Technologies.T_UpgradeRifle1, 0)
Logic.SetTechnologyState(i,Technologies.MU_LeaderRifle, 0)
Logic.SetTechnologyState(i,Technologies.T_FleeceArmor, 0)
Logic.SetTechnologyState(i,Technologies.T_FleeceLinedLeatherArmor, 0)
Logic.SetTechnologyState(i,Technologies.T_LeadShot, 0)
Logic.SetTechnologyState(i,Technologies.T_Sights, 0)
Logic.SetTechnologyState(i,Technologies.GT_PulledBarrel, 0)
Logic.SetTechnologyState(i,Technologies.MU_LeaderHeavyCavalry, 0)
Logic.SetTechnologyState(i,Technologies.T_UpgradeHeavyCavalry1, 0)
Logic.SetTechnologyState(i,Technologies.MU_Cannon3, 0)
Logic.SetTechnologyState(i,Technologies.MU_Cannon4, 0)
end

Logic.SetTechnologyState(5, Technologies.T_LeatherMailArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_ChainMailArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_PlateMailArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_SoftArcherArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_PaddedArcherArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_LeatherArcherArmor, 3)
Logic.SetTechnologyState(5, Technologies.T_MasterOfSmithery, 3)
Logic.SetTechnologyState(5, Technologies.T_IronCasting, 3)
Logic.SetTechnologyState(5, Technologies.T_Fletching, 3)
Logic.SetTechnologyState(5, Technologies.T_BodkinArrow, 3)
Logic.SetTechnologyState(5, Technologies.T_WoodAging, 3)
Logic.SetTechnologyState(5, Technologies.T_Turnery, 3)
Logic.SetTechnologyState(5, Technologies.T_EnhancedGunPowder, 3)
Logic.SetTechnologyState(5, Technologies.T_BlisteringCannonballs, 3)
Logic.SetTechnologyState(5, Technologies.T_BetterTrainingBarracks, 3)
Logic.SetTechnologyState(5, Technologies.T_BetterTrainingArchery, 3)
Logic.SetTechnologyState(5, Technologies.T_Shoeing, 3)
Logic.SetTechnologyState(5, Technologies.T_Masonry, 3)

Logic.SetTechnologyState(7, Technologies.T_LeatherMailArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_ChainMailArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_PlateMailArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_SoftArcherArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_PaddedArcherArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_LeatherArcherArmor, 3)
Logic.SetTechnologyState(7, Technologies.T_MasterOfSmithery, 3)
Logic.SetTechnologyState(7, Technologies.T_IronCasting, 3)
Logic.SetTechnologyState(7, Technologies.T_Fletching, 3)
Logic.SetTechnologyState(7, Technologies.T_BodkinArrow, 3)
Logic.SetTechnologyState(7, Technologies.T_WoodAging, 3)
Logic.SetTechnologyState(7, Technologies.T_Turnery, 3)
Logic.SetTechnologyState(7, Technologies.T_EnhancedGunPowder, 3)
Logic.SetTechnologyState(7, Technologies.T_BlisteringCannonballs, 3)
Logic.SetTechnologyState(7, Technologies.T_BetterTrainingBarracks, 3)
Logic.SetTechnologyState(7, Technologies.T_BetterTrainingArchery, 3)
Logic.SetTechnologyState(7, Technologies.T_Shoeing, 3)
Logic.SetTechnologyState(7, Technologies.T_Masonry, 3)

--ThiefCreatedTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED, nil, "EntityChecker1Tech", 1, nil, nil)
--ThiefDestroiedTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_DESTROYED, nil, "EntityChecker2Tech", 1, nil, nil)
end
--[[
GameCallback_GUI_SelectionChangedComplete = GameCallback_GUI_SelectionChanged
function GameCallback_GUI_SelectionChanged()
	GameCallback_GUI_SelectionChangedComplete()
	if Logic.GetTechnologyState(GUI.GetPlayerID(), Technologies.MU_Thief) == 0 then
		XGUIEng.DisableButton(XGUIEng.GetWidgetID("Buy_Thief"), 1)
	end
end]]

function EntityChecker1Tech()
	local entityIDcheck = Event.GetEntityID()
	if Logic.GetEntityType(entityIDcheck) == Entities.PU_Thief then
		local playerid = Logic.EntityGetPlayer(entityIDcheck)
		ThiefPlayerCounter[playerid] = ThiefPlayerCounter[playerid] + 1
		if ThiefPlayerCounter[playerid] >= 1 then
			Logic.SetTechnologyState(playerid,Technologies.MU_Thief, 0)
			XGUIEng.DisableButton(XGUIEng.GetWidgetID("Buy_Thief"), 1)
		end
	end
return false
end

function EntityChecker2Tech()
	local entityIDcheck = Event.GetEntityID()
	if Logic.GetEntityType(entityIDcheck) == Entities.PU_Thief then
		local playerid = Logic.EntityGetPlayer(entityIDcheck)
		ThiefPlayerCounter[playerid] = ThiefPlayerCounter[playerid] - 1
		if ThiefPlayerCounter[playerid] < 1 then
			Logic.SetTechnologyState(playerid,Technologies.MU_Thief, 2)
			XGUIEng.DisableButton(XGUIEng.GetWidgetID("Buy_Thief"), 0)
		end
	end
return false
end

function CreateArmies()
	local spawnpos = {}
	NVAttackKeberosUA = UnlimitedArmy:New({
				Player = 6,
				Area = 3800,
				AutoDestroyIfEmpty = true,
				TransitAttackMove = true,
				Formation = UnlimitedArmy.Formations.Chaotic,
				AutoRotateRange = true,
				DoNotNormalizeSpeed = false,
				IgnoreFleeing = false
				})
	NVAttackKeberosUA:AddCommandSetSpawnerStatus(false,false)
	spawnpos[1] = GetPosition("NVBarracksSpawn1")
	spawnpos[1].Generator = "NVBarracksSpawn1Generator"
	spawnpos[2] = GetPosition("NVBarracksSpawn2")
	spawnpos[2].Generator = "NVBarracksSpawn2Generator"
	NVAttackKeberosUASpawnGenerator = UnlimitedArmySpawnGenerator:New(NVAttackKeberosUA,{
											Position = spawnpos,
											ArmySize = 14,
											SpawnCounter = 30,
											SpawnLeaders = 14,
											LeaderDesc = {
													{LeaderType = Entities.CU_Evil_LeaderBearman1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3},
													{LeaderType = Entities.CU_Evil_LeaderSkirmisher1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3}
													},
											RandomizeSpawn = true,
											RandomizeSpawnPoint = true
											})
	
	NVDef1UA = UnlimitedArmy:New({
				Player = 6,
				Area = 3500,
				AutoDestroyIfEmpty = true,
				TransitAttackMove = true,
				Formation = UnlimitedArmy.Formations.Chaotic,
				AutoRotateRange = true,
				DoNotNormalizeSpeed = false,
				IgnoreFleeing = false
				})
	NVDef1UA:AddCommandSetSpawnerStatus(false,false)
	local spawnpos1 = {}
	spawnpos1[1] = GetPosition("NVBarracksSpawn1")
	spawnpos1[1].Generator = "NVBarracksSpawn1Generator"
	spawnpos1[2] = GetPosition("NVBarracksSpawn2")
	spawnpos1[2].Generator = "NVBarracksSpawn2Generator"
	NVDef1UASpawnGenerator = UnlimitedArmySpawnGenerator:New(NVDef1UA,{
								Position = spawnpos1,
								ArmySize = 10,
								SpawnCounter = 60,
								SpawnLeaders = 10,
								LeaderDesc = {
											{LeaderType = Entities.CU_Evil_LeaderBearman1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3},
											{LeaderType = Entities.CU_Evil_LeaderSkirmisher1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3}
											},
											})
	NVDef2UA = UnlimitedArmy:New({
				Player = 6,
				Area = 3500,
				AutoDestroyIfEmpty = true,
				TransitAttackMove = true,
				Formation = UnlimitedArmy.Formations.Chaotic,
				AutoRotateRange = true,
				DoNotNormalizeSpeed = false,
				IgnoreFleeing = false
				})
	NVDef2UA:AddCommandSetSpawnerStatus(false,false)
	local spawnpos2 = {}
	spawnpos2[1] = GetPosition("NVBarracksSpawn2")
	spawnpos2[1].Generator = "NVBarracksSpawn2Generator"
	spawnpos2[2] = GetPosition("NVBarracksSpawn1")
	spawnpos2[2].Generator = "NVBarracksSpawn1Generator"
	NVDef2UASpawnGenerator = UnlimitedArmySpawnGenerator:New(NVDef2UA,{
								Position = spawnpos2,
								ArmySize = 10,
								SpawnCounter = 60,
								SpawnLeaders = 10,
								LeaderDesc = {
											{LeaderType = Entities.CU_Evil_LeaderBearman1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3},
											{LeaderType = Entities.CU_Evil_LeaderSkirmisher1, SoldierNum = 16, SpawnNum = 2, Looped = true, Experience = 3}
											},
											})
	
	NVAttackPlayerUA = UnlimitedArmy:New({
				Player = 6,
				Area = 3800,
				AutoDestroyIfEmpty = true,
				TransitAttackMove = true,
				Formation = UnlimitedArmy.Formations.Chaotic,
				AutoRotateRange = true,
				DoNotNormalizeSpeed = false,
				IgnoreFleeing = false
				})
	NVAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
	
	KerberosAttackNVUA = UnlimitedArmy:New({
					Player = 5,
					Area = 3800,
					AutoDestroyIfEmpty = true,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					LeaderFormation = FormationFunktion,
					AutoRotateRange = true,
					DoNotNormalizeSpeed = false,
					IgnoreFleeing = false
					})
	KerberosAttackNVUA:AddCommandSetSpawnerStatus(false,false)
	local spawnpos3 = {}
	spawnpos3[1] = GetPosition("KeberosUACollectingDefPoint")
	spawnpos3[1].Generator = {"KeberosUASpawnGenerator2","KeberosUASpawnGenerator1"}
	spawnpos3[2] = GetPosition("KeberosUACollectingDefPoint1")
	spawnpos3[2].Generator = "KeberosUASpawnGenerator3"
	KerberosAttackNVUASpawnGenerator = UnlimitedArmySpawnGenerator:New(KerberosAttackNVUA,{
										Position = spawnpos3,
										ArmySize = 12,
										SpawnCounter = 60,
										SpawnLeaders = 12,
										LeaderDesc = {
												{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 4, Looped = true, Experience = 0},
												{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum = 5, Looped = true, Experience = 0},
												{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum = 4, Loopoed = true, Experience = 0},
												{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3, SpawnNum = 3, Looped = true, Experience = 0},
												{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3, SpawnNum = 2, Looped = true, Experience = 0},
												{LeaderType = Entities.PV_Cannon3, SoldierNum = 0, SpawnNum = function() for cannonid in KerberosAttackNVUA:Iterator(true) do if Logic.GetEntityType(cannonid) == 233 then return 0 end end return 1 end, Looped = true, Experience = 0},
												{LeaderType = Entities.PV_Cannon4, SoldierNum = 0, SpawnNum = function() for cannonid in KerberosAttackNVUA:Iterator(true) do if Logic.GetEntityType(cannonid) == 234 then return 0 end end return 1 end, Looped = true, Experience = 0}
												},
												RandomizeSpawn = false
												})
	
	KerberosDef1UA = UnlimitedArmy:New({
					Player = 5,
					Area = 3800,
					AutoDestroyIfEmpty = true,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					LeaderFormation = FormationFunktion,
					AutoRotateRange = true,
					DoNotNormalizeSpeed = false,
					IgnoreFleeing = false
					})
	KerberosDef1UA:AddCommandSetSpawnerStatus(false,false)
	local spawnpos4 = {}
	spawnpos4[1] = GetPosition("KeberosUACollectingDefPoint")
	spawnpos4[1].Generator = {"KeberosUASpawnGenerator2","KeberosUASpawnGenerator1"}
	spawnpos4[2] = GetPosition("KeberosUACollectingDefPoint1")
	spawnpos4[2].Generator = "KeberosUASpawnGenerator3"
	KerberosDef1UASpawnGenerator = UnlimitedArmySpawnGenerator:New(KerberosDef1UA,{
							Position = spawnpos4,
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum= 3, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3, SpawnNum= 2, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 0, SpawnNum= 3, Looped = true, Experience = 3 }
									},
									})
									
	
	KerberosDef2UA = UnlimitedArmy:New({
					Player = 5,
					Area = 3800,
					AutoDestroyIfEmpty = true,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					LeaderFormation = FormationFunktion,
					AutoRotateRange = true,
					DoNotNormalizeSpeed = false,
					IgnoreFleeing = false
					})
	KerberosDef2UA:AddCommandSetSpawnerStatus(false,false)
	local spawnpos5 = {}
	spawnpos5[1] = GetPosition("KeberosUACollectingDefPoint")
	spawnpos5[1].Generator = {"KeberosUASpawnGenerator2","KeberosUASpawnGenerator1"}
	spawnpos5[2] = GetPosition("KeberosUACollectingDefPoint1")
	spawnpos5[2].Generator = "KeberosUASpawnGenerator3"
	KerberosDef2UASpawnGenerator = UnlimitedArmySpawnGenerator:New(KerberosDef2UA,{
							Position = spawnpos5,
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum= 3, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3, SpawnNum= 2, Looped = true, Experience = 3 },
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3, SpawnNum= 4, Looped = true, Experience = 3 },
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 0, SpawnNum= 3, Looped = true, Experience = 3 }
									},
									})
	
	KerberosAttackPlayerUA = UnlimitedArmy:New({
					Player = 5,
					Area = 4000,
					AutoDestroyIfEmpty = true,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					LeaderFormation = FormationFunktion,
					AutoRotateRange = true,
					DoNotNormalizeSpeed = false,
					IgnoreFleeing = false
					})
	KerberosAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
--[[spawnpos[1] = GetPosition("KeberosUACollectingDefPoint")
	spawnpos[1].Generator = {"KeberosUASpawnGenerator2","KeberosUASpawnGenerator1"}
	spawnpos[2] = GetPosition("KeberosUACollectingDefPoint1")
	spawnpos[2].Generator = "KeberosUASpawnGenerator3"
	KerberosAttackPlayerUASpawnGenerator = UnlimitedArmySpawnGenerator:New(KerberosAttackPlayerUA,{
								Position = spawnpos,
								ArmySize = 8,
								SpawnCounter = 300,
								SpawnLeaders = 8,
								LeaderDesc = {
										{LeaderType = Entities.PU_LeaderSword1, SoldierNum = 4, SpawnNum = 2,Looped = true, Experience = 4},
										{LeaderType = Entities.PU_LeaderPoleArm1, SoldierNum = 4, SpawnNum = 2,Looped = true, Experience = 4},
										{LeaderType = Entities.PU_LeaderBow1, SoldierNum = 4, SpawnNum = 2,Looped = true, Experience = 4},
										{LeaderType = Entities.PU_LeaderCavalry1, SoldierNum = 4, SpawnNum = 1,Looped = true, Experience = 4},
										{LeaderType = Entities.PU_LeaderHeavyCavalry1, SoldierNum = 4, SpawnNum = 1,Looped = true, Experience = 4},
										{LeaderType = Entities.PV_Cannon1, SoldierNum = 0, SpawnNum = 1,Looped = true, Experience = 4},
										{LeaderType = Entities.PV_Cannon2, SoldierNum = 0, SpawnNum = 1,Looped = true, Experience = 4}
										}
										})]]
	
	BarbarsTopRightUA = UnlimitedArmy:New({
					Player = 7,
					Area = 3000,
					AutoDestroyIfEmpty = false,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					DoNotNormalizeSpeed = true,
					IgnoreFleeing = false
					})
					
	BarbarsBottomLeftUA = UnlimitedArmy:New({
					Player = 7,
					Area = 3000,
					AutoDestroyIfEmpty = false,
					TransitAttackMove = true,
					Formation = UnlimitedArmy.Formations.Chaotic,
					DoNotNormalizeSpeed = true,
					IgnoreFleeing = false,
					})
					
end

function StartUnlimitedArmysStart()

--wenn KIbase down, dann UA die Ki angreift zerstören und Truppen der UA hinzufügen, die auf Spieler geht.

KerberosAttackNVUA:AddCommandSetSpawnerStatus(true,false)
KerberosAttackNVUA:AddCommandMove(GetPosition("KeberosUACollectingDefPoint"),true)
KerberosAttackNVUA:AddCommandWaitForIdle(true)
KerberosAttackNVUA:AddCommandWaitForSpawnerFull(true)
KerberosAttackNVUA:AddCommandSetSpawnerStatus(false,true)
KerberosAttackNVUA:AddCommandMove(GetPosition("KeberosUAWaypoint1"),true)
KerberosAttackNVUA:AddCommandWaitForIdle(true)
KerberosAttackNVUA:AddCommandMove(GetPosition("KeberosUAWaypoint2"),true)
KerberosAttackNVUA:AddCommandWaitForIdle(true)
KerberosAttackNVUA:AddCommandMove(GetPosition("NVHQ"),true)
KerberosAttackNVUA:AddCommandWaitForIdle(true)
KerberosAttackNVUA:AddCommandLuaFunc(IsEnemyDead1,true)
KerberosAttackNVUA:AddCommandWaitForTroopSize(1,true,true)
KerberosAttackNVUA:AddCommandSetSpawnerStatus(true,true)

KerberosDef2UA:AddCommandSetSpawnerStatus(true,false)
KerberosDef2UA:AddCommandMove(GetPosition("KeberosUACollectingDefPoint"),false)
KerberosDef2UA:AddCommandWaitForIdle(false)
KerberosDef2UA:AddCommandMove(GetPosition("KeberosUADefWaypoint2"),true)
KerberosDef2UA:AddCommandWaitForIdle(true)
KerberosDef2UA:AddCommandMove(GetPosition("KeberosUADefWaypoint3"),true)
KerberosDef2UA:AddCommandWaitForIdle(true)

KerberosDef1UA:AddCommandSetSpawnerStatus(true,false)
KerberosDef1UA:AddCommandMove(GetPosition("KeberosUACollectingDefPoint"),false)
KerberosDef1UA:AddCommandWaitForIdle(false)
KerberosDef1UA:AddCommandMove(GetPosition("KeberosUADefWaypoint1"),true)
KerberosDef1UA:AddCommandWaitForIdle(true)
KerberosDef1UA:AddCommandMove(GetPosition("KeberosUACollectingDefPoint"),true)
KerberosDef1UA:AddCommandWaitForIdle(true)
KerberosDef1UA:AddCommandMove(GetPosition("KeberosUADefWaypoint5"),true)
KerberosDef1UA:AddCommandWaitForIdle(true)

NVDef1UA:AddCommandSetSpawnerStatus(true,false)
NVDef1UA:AddCommandMove(GetPosition("NVBarracksSpawn1"),true)
NVDef1UA:AddCommandWaitForIdle(true)
NVDef1UA:AddCommandMove(GetPosition("NVUADefWaypoint2"),true)
NVDef1UA:AddCommandWaitForIdle(true)
NVDef1UA:AddCommandMove(GetPosition("NVUADefWaypoint1"),true)
NVDef1UA:AddCommandWaitForIdle(true)
NVDef1UA:AddCommandMove(GetPosition("NVUADefWaypoint3"),true)
NVDef1UA:AddCommandWaitForIdle(true)

NVDef2UA:AddCommandSetSpawnerStatus(true,false)
NVDef2UA:AddCommandMove(GetPosition("NVBarracksSpawn2"),true)
NVDef2UA:AddCommandWaitForIdle(true)
NVDef2UA:AddCommandMove(GetPosition("NVUADefWaypoint5"),true)
NVDef2UA:AddCommandWaitForIdle(true)
NVDef2UA:AddCommandMove(GetPosition("NVUADefWaypoint4"),true)
NVDef2UA:AddCommandWaitForIdle(true)
NVDef2UA:AddCommandMove(GetPosition("NVUADefWaypoint6"),true)
NVDef2UA:AddCommandWaitForIdle(true)

NVAttackKeberosUA:AddCommandSetSpawnerStatus(true,false)
NVAttackKeberosUA:AddCommandMove(GetPosition("NVUAWaypoint1"),true)
NVAttackKeberosUA:AddCommandWaitForIdle(true)
NVAttackKeberosUA:AddCommandWaitForSpawnerFull(true)
NVAttackKeberosUA:AddCommandSetSpawnerStatus(false,true)
NVAttackKeberosUA:AddCommandMove(GetPosition("NVUAWaypoint2"),true)
NVAttackKeberosUA:AddCommandWaitForIdle(true)
NVAttackKeberosUA:AddCommandMove(GetPosition("NVUAWaypoint3"),true)
NVAttackKeberosUA:AddCommandWaitForIdle(true)
NVAttackKeberosUA:AddCommandMove(GetPosition("KILeaderBase"),true)
NVAttackKeberosUA:AddCommandWaitForIdle(true)
NVAttackKeberosUA:AddCommandLuaFunc(IsEnemyDead2,true)
NVAttackKeberosUA:AddCommandWaitForTroopSize(1,true,true)
NVAttackKeberosUA:AddCommandSetSpawnerStatus(true,true)

end

function BarBarAttackDelay(TeamSide)
	if BarBarAttackDelayCounter > 0 then
		BarBarAttackDelayCounter = BarBarAttackDelayCounter - 1
		return false
	end
	SpawnBarBarAttackArmies(TeamSide)
	return true
end

function SpawnBarBarAttackArmies(TeamSelection)
	MapLocal_StopCountDown()
	BarbarUAleftDone = false
	BarBarUArightDone = false
	ReiterAnzahl = math.floor(Maptimervariable/300)
	for i = 1,ReiterAnzahl,1 do
		if i <= math.floor(ReiterAnzahl/2) then
		SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderHeavyCavalry2, nil, 0, GetPosition("BarbarenBombenTruppSpawn2").X, GetPosition("BarbarenBombenTruppSpawn2").Y, nil, nil, 4, 0),"bomb"..i)
		BarbarsBottomLeftUA:AddLeader("bomb"..i)
		else
		SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderHeavyCavalry2, nil, 0, GetPosition("BarbarenBombenTruppSpawn1").X, GetPosition("BarbarenBombenTruppSpawn1").Y, nil, nil, 4, 0),"bomb"..i)
		BarbarsTopRightUA:AddLeader("bomb"..i)
		end
	end
	if TeamSelection[1] == 3 and TeamSelection[2] == 4 then
	SetFriendly(7,1)
	SetFriendly(7,2)
	Logic.SetShareExplorationWithPlayerFlag(1, 7, 1)
	Logic.SetShareExplorationWithPlayerFlag(2, 7, 1)
	BarbarsBottomLeftUA:AddCommandLuaFunc(AttackTargetFunc1,true)
	BarbarsBottomLeftUA:AddCommandWaitForIdle(true)
	BarbarsBottomLeftUA:AddCommandLuaFunc(BarbarUAChecker1,true)
	BarbarsTopRightUA:AddCommandLuaFunc(AttackTargetFunc2,true)
	BarbarsTopRightUA:AddCommandWaitForIdle(true)
	BarbarsTopRightUA:AddCommandLuaFunc(BarbarUAChecker2,true)
	end
	if TeamSelection[1] == 1 and TeamSelection[2] == 2 then
	SetFriendly(7,3)
	SetFriendly(7,4)
	Logic.SetShareExplorationWithPlayerFlag(3, 7, 1)
	Logic.SetShareExplorationWithPlayerFlag(4, 7, 1)
	BarbarsBottomLeftUA:AddCommandLuaFunc(AttackTargetFunc3,true)
	BarbarsBottomLeftUA:AddCommandWaitForIdle(true)
	BarbarsBottomLeftUA:AddCommandLuaFunc(BarbarUAChecker1,true)
	BarbarsTopRightUA:AddCommandLuaFunc(AttackTargetFunc4,true)
	BarbarsTopRightUA:AddCommandWaitForIdle(true)
	BarbarsTopRightUA:AddCommandLuaFunc(BarbarUAChecker2,true)
	end
end

function AttackTargetFunc1(self)
	if IsValid("PlayerHQ4") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ4"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ3"))
	end
	return true
end

function AttackTargetFunc2(self)
	if IsValid("PlayerHQ3") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ3"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ4"))
	end
	return true
end

function AttackTargetFunc3(self)
	if IsValid("PlayerHQ1") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ1"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ2"))
	end
	return true
end

function AttackTargetFunc4(self)
	if IsValid("PlayerHQ2") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ2"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ1"))
	end
	return true
end

function BarbarUAChecker1(self)
	if self:GetSize() == 0 then
		if self.CommandQueue[1] ~= nil then
			self:ClearCommandQueue()
			BarbarUAleftDone = true
			if self.CommandQueue[1] == nil and BarbarsTopRightUA.CommandQueue[1] == nil then
				for i = 1,4,1 do
					if Logic.GetDiplomacyState(7, i) == Diplomacy.Friendly then
						Logic.SetShareExplorationWithPlayerFlag(i, 7, 0)
						Logic.SetDiplomacyState(7, i, Diplomacy.Hostile)
						BarbarAttackFlag = false
						BarBarAttackDelayCounter = 600
					end
				end
				return true
			end
		end
	end
	return false
end

function BarbarUAChecker2(self)
	if self:GetSize() == 0 then
		if self.CommandQueue[1] ~= nil then
			self:ClearCommandQueue()
			BarBarUArightDone = true
			if self.CommandQueue[1] == nil and BarbarsBottomLeftUA.CommandQueue[1] == nil then
				for i = 1,4,1 do
					if Logic.GetDiplomacyState(7, i) == Diplomacy.Friendly then
						Logic.SetShareExplorationWithPlayerFlag(i, 7, 0)
						Logic.SetDiplomacyState(7, i, Diplomacy.Hostile)
						BarbarAttackFlag = false
						BarBarAttackDelayCounter = 600
					end
				end
				return true
			end
		end
	end
	return false
end

function StartFlagController()
	for i = 1, 4, 1 do
		FlagEntitiesChecker(i)
	end
	if (BarbarUAleftDone == true) and (BarBarUArightDone == true) then
		flagcounterTeam1,flagcounterTeam2 = FlagTeamCounter()
		if (flagcounterTeam1 == 4) and (BarbarAttackFlag ~= true) then
			BarbarAttackFlag = true
			MapLocal_StartCountDown(BarBarAttackDelayCounter)
			BarBarTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND,"","BarBarAttackDelay",1,nil,{SouthTeam})
		end
		if (flagcounterTeam2 == 4) and (BarbarAttackFlag ~= true) then
			BarbarAttackFlag = true
			MapLocal_StartCountDown(BarBarAttackDelayCounter)
			BarBarTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND,"","BarBarAttackDelay",1,nil,{NorthTeam})
		end 
		if (flagcounterTeam1 < 4) and (flagcounterTeam2 < 4) then
			BarbarAttackFlag = false
			MapLocal_StopCountDown()
			BarBarAttackDelayCounter = 600
			if JobIsRunning(BarBarTrigger) then
				Trigger.UnrequestTrigger(BarBarTrigger)
			end
		end
	end
	
	return false
end

function FlagEntitiesChecker(flagnumber)
	local flagposition = GetPosition("flag_camp"..flagnumber)
	local isTeam1, isTeam2 = false,false
	local EntitiesAtFlag = {}
	for i = 1,4,1 do --playercounter
			local PlayerEntitiesAtFlag = S5Hook.EntityIteratorTableize(Predicate.OfPlayer(i), Predicate.OfCategory(EntityCategories.Military),Predicate.InCircle(GetPosition("flag_camp"..flagnumber).X, GetPosition("flag_camp"..flagnumber).Y, 200))
			EntitiesAtFlag[i] = table.getn(PlayerEntitiesAtFlag)
	end
	
	if ((EntitiesAtFlag[1] > 0) or (EntitiesAtFlag[2] > 0)) and ((EntitiesAtFlag[3] == 0) or (EntitiesAtFlag[4] == 0)) then
		isTeam1 = true
	end
	if((EntitiesAtFlag[1] == 0) or (EntitiesAtFlag[2]==0)) and ((EntitiesAtFlag[3] > 0) or (EntitiesAtFlag[4] > 0)) then
        isTeam2 = true
	end
	
	if isTeam1 and not isTeam2 then
		if Logic.EntityGetPlayer("flag_camp"..flagnumber) ~= 1 and Logic.EntityGetPlayer("flag_camp"..flagnumber) ~= 2 then
			Logic.ChangeEntityPlayerID(Logic.GetEntityIDByName("flag_camp"..flagnumber), TableSpotWithHighestValue(EntitiesAtFlag))
		end
	end
	if not isTeam1 and isTeam2 then
		if Logic.EntityGetPlayer("flag_camp"..flagnumber) ~= 3 and Logic.EntityGetPlayer("flag_camp"..flagnumber) ~= 4 then
			Logic.ChangeEntityPlayerID(Logic.GetEntityIDByName("flag_camp"..flagnumber), TableSpotWithHighestValue(EntitiesAtFlag))
		end
	end
	return false
end

function TableSpotWithHighestValue(_tid)
	local number
	local tpos
	for i = 1, table.getn(_tid) do
		if number == nil then
			number = _tid[i]
			tpos = i
		else
			if number < math.max(number,_tid[i]) then
			number = math.max(number,_tid[i])
			tpos = i
			end
		end
	end
	return tpos
end

function FlagTeamCounter()
	local team1flagCounter, team2flagCounter = 0,0
	for i = 1,4,1 do
	local plaiyerID = Logic.EntityGetPlayer(GetID("flag_camp"..i))
		if Logic.EntityGetPlayer(GetID("flag_camp"..i)) <= 4 then
			if plaiyerID <= 2 then
				team1flagCounter = team1flagCounter + 1
			else
				team2flagCounter = team2flagCounter + 1
			end
		end
	end
	return team1flagCounter,team2flagCounter
end

function MapTimeCounter()
	for i = 1,4,1 do
		if Logic.GetPlayersGlobalResource(i, ResourceType.Faith) > 5000 then
			local faithdifference = Logic.GetPlayersGlobalResource(i, ResourceType.Faith) - 5000
			Logic.SubFromPlayersGlobalResource(i, ResourceType.Faith, faithdifference)
		end
	end
	if Maptimervariable > 3600 and SuddenDeathFlag == nil then
		for i = 1,4,1 do
			ReplaceEntity("middleBridge"..i,Entities.PB_DrawBridgeClosed2)
		end
		SuddenDeathFlag = true
	end
	Maptimervariable = Maptimervariable + 1
	return false
end

FormationFunktion = function(self, truppid)
	if Logic.IsEntityInCategory(truppid, EntityCategories.Cannon)==1 then
		return 1
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Hero)==1 then
		return 1
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.CavalryHeavy)==1 then
		return 7
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.CavalryLight)==1 then
		return 2
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Bow)==1 or Logic.IsEntityInCategory(truppid, EntityCategories.Rifle)==1 then
		return 2
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Spear)==1 then
		return 6
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Sword)==1 then
		return 4
	end
	return 1
end

function BombSquadTrigger()
	for i = 1,ReiterAnzahl,1 do
		local bombname = "bomb"..i
		
		if IsDead(bombname) == false then
			if GetRandom(100) > 90 then
				CreateEntity(7,Entities.XD_Bomb1,GetPosition(bombname))
			end
		end
	end
	return false
end

function MiddleUnitTrader()
	Logic.AddMercenaryOffer(GetID("UnitTrader"), Entities.CU_VeteranLieutenant, 4, ResourceType.Gold, 1500, ResourceType.Iron, 1000, ResourceType.Faith, 5000)
	Logic.AddMercenaryOffer(GetID("UnitTrader"), Entities.PV_Cannon3, 4, ResourceType.Gold, 500, ResourceType.Iron, 250, ResourceType.Sulfur, 250)
	Logic.AddMercenaryOffer(GetID("UnitTrader"), Entities.PU_LeaderRifle2, 4, ResourceType.Sulfur, 999, ResourceType.Wood, 1, ResourceType.Faith, 1200)
	Logic.AddMercenaryOffer(GetID("UnitTrader"), Entities.CU_BanditLeaderSword1, 4,ResourceType.Faith, 1400, ResourceType.Gold, 500)
end

function CheckThiefLeaders()
	--[[for i = 1,4,1 do
		local EntitiesTableNV = {Logic.GetPlayerEntitiesInArea(i, Entities.PU_Thief, GetPosition("NVLeader").X, GetPosition("NVLeader").Y, 300, 1)}
		if EntitiesTableNV[1] > 0 then
			if  then
			end
		end	
	end]]
	
	
	-- NVLeader
	-- DarkLeader
end

function IsInTeamNorth(_playerids)
	for _,teamid in ipairs(NorthTeam) do
		if _playerids == teamid then
			return true
		else
			return false
		end
	end
end

--kosten durch tests bestimmen

function MiddleTechTrader()
	local desc = {
    entity = "TechTraderMiddle",
    type = Technologies.T_ThiefSabotage, --Sabotage
    cost = { Gold = 1000,
			Sulfur = 500,
			Faith = 3000},
    amount = 2,		        
}
AddMerchantOffer(desc)
local desc = {
    entity = "TechTraderMiddle",
    type = Technologies.GT_PulledBarrel, --gezogener Lauf
    cost = { Wood = 500,
			Iron = 750,
			Sulfur = 750,
			Faith = 1500},
    amount = 2,		        
}
AddMerchantOffer(desc)
local desc = {
    entity = "TechTraderMiddle",
    type = Technologies.T_UpgradeHeavyCavalry1, --Upgrade Skav2
    cost = { Iron = 1300,
			Gold = 800,
			Faith = 1000},
    amount = 2,
}
AddMerchantOffer(desc)
local desc = {
    entity = "TechTraderMiddle",
    type = Technologies.MU_Cannon4, --Belagerungskanone
    cost = { Sulfur = 900,
			Gold = 1000,
			Iron = 500},
    amount = 2,		        
}
AddMerchantOffer(desc)
end

function CreateWoodPiles()
	for i = 1,4,1 do
		CreateWoodPile("CreateWoodPile"..i, 5000000)
	end
end

-- Holzstapel

function CreateWoodPile( _posEntity, _resources )
    assert( type( _posEntity ) == "string" )
    assert( type( _resources ) == "number" )
    gvWoodPiles = gvWoodPiles or {
        JobID = StartSimpleJob("ControlWoodPiles"),
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

--techtraderfunction
function AddMerchantOffer(_desc)
    if IsDead(_desc.entity) then
        return
    end
    local entity = GetEntityId(_desc.entity)
    assert(type(_desc.cost) == "table", "costs are needed")
    assert( Logic.GetNumerOfMerchantOffers( entity ) < 4, "there exist only 4 slots" )
    local tResCost = {}
    for k, v in pairs(_desc.cost) do
        assert( ResourceType[k] )
        assert( type(v) == "number" and v >= 0 )
        table.insert( tResCost, ResourceType[k] )
        table.insert( tResCost, v )
    end  
    assert(type(_desc.amount) == "number" and _desc.amount > 0, "there must be sold at least 1 entity / technology")
    assert(type(_desc.type) == "number", "an entity type / a technology is needed")
    if Logic.IsMercenaryBuilding(entity) == true then 
        Logic.AddMercenaryOffer(entity, _desc.type, _desc.amount, unpack( tResCost ))
    elseif Logic.IsTechTraderBuilding(entity) == true then 
        Logic.AddTechOffer(entity, _desc.type, _desc.amount, unpack( tResCost ))
    end
end

function CreateBarBarCamps()
	AI.Player_EnableAi(7)
	BBArmyTable = {}
	BarbarCampSmallArmy = {}
	for i = 1,4,1  do
		BarbarCampSmallArmy[i] = {}
		BarbarCampSmallArmy[i].player = 7
		BarbarCampSmallArmy[i].id = i
		if math.mod(i,2) > 0 then
			BarbarCampSmallArmy[i].strength = 5
		else
			BarbarCampSmallArmy[i].strength = 8
		end
		BarbarCampSmallArmy[i].position = GetPosition("BarbarianCampCollect"..i)
		BarbarCampSmallArmy[i].rodeLength = 300
		BarbarCampSmallArmy[i].generatorspawnpointlist = {	{"BarbarianCamp"..i.."1Spawner","BarbarianCamp"..i.."1"},
															{"BarbarianCamp"..i.."2Spawner","BarbarianCamp"..i.."2"},
															{"BarbarianCamp"..i.."3Spawner","BarbarianCamp"..i.."3"}
														}
		BarbarCampSmallArmy[i].trooplist = {Entities.CU_Barbarian_LeaderClub1,
											Entities.CU_BanditLeaderBow1,
											Entities.CU_Barbarian_LeaderClub1,
											Entities.CU_BanditLeaderBow1,
											Entities.CU_Barbarian_LeaderClub1,
											Entities.CU_BanditLeaderBow1,
											Entities.CU_Barbarian_LeaderClub1,
											Entities.PV_Cannon1
											}
		BarbarCampSmallArmy[i].trooplistcounter = 1
		BarbarCampSmallArmy[i].spawntimer = 60
		
		if math.mod(i,2) == 1 then
			Logic.CreateEntity(Entities.CU_VeteranLieutenant, GetPosition("BarbarianCamp"..i.."3").X, GetPosition("BarbarianCamp"..i.."3").Y, 180, 7)
		end
		
		SetupArmy(BarbarCampSmallArmy[i])
		BarbarCampSmallArmy[i].generatorID = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, nil, "BarbarCampSpawnGenerator", 1, nil, {BarbarCampSmallArmy[i]})
		BarbarCampSmallArmy[i].controllJob = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, nil, "BarBarCampControllerJob", 1, nil, {BarbarCampSmallArmy[i]})
	end
end

function BarBarCampControllerJob(_BbArmy)
	if not JobIsRunning(_BbArmy.generatorID) then
		return true
	end
	Redeploy(_BbArmy,_BbArmy.position)
	return false
end

function BarbarCampSpawnGenerator(_BbArmy)
	local _curTroops = AI.Army_GetNumberOfTroops(_BbArmy.player,_BbArmy.id)
	if _curTroops < _BbArmy.strength then
		if _BbArmy.spawntimer > 0 then
			_BbArmy.spawntimer = _BbArmy.spawntimer - 1
			return false
		end
	end
	for jj = table.getn(_BbArmy.generatorspawnpointlist), 1, -1 do
		if IsDead(_BbArmy.generatorspawnpointlist[jj][1]) then
				table.remove(_BbArmy.generatorspawnpointlist,jj)
		end
	end
	--[[for tableindex1,spawnerstring in ipairs(_BbArmy.generatorspawnpointlist) do
		if IsDead(spawnerstring[1]) then
				table.remove(_BbArmy.generatorspawnpointlist,tableindex1)
		end
	end]]
	local _genNumber = table.getn(_BbArmy.generatorspawnpointlist)
	if _curTroops < _BbArmy.strength then
		for i = 1, _BbArmy.strength - _curTroops,1 do
			if _genNumber == 0 then
				return true
			end
			local spawnnumber = GetRandom(1,_genNumber)
			local spawnerpoint = GetPosition(_BbArmy.generatorspawnpointlist[spawnnumber][2])
			AI.Entity_ConnectLeader(AI.Entity_CreateFormation(_BbArmy.player,_BbArmy.trooplist[_BbArmy.trooplistcounter],0,4, spawnerpoint.X,spawnerpoint.Y,0,0,3,0),_BbArmy.id)
			_BbArmy.trooplistcounter = _BbArmy.trooplistcounter + 1
			if _BbArmy.trooplistcounter == 9 then
				_BbArmy.trooplistcounter = 1
			end
		end
		_BbArmy.spawntimer = 300
	end
	return false
end

--Kala

function KILeaderThief1()
	if IsDead("NVLeader") then
		if IsDead("NVHQ") then
			return true
		end
		return false
	end
	KalaLeaderpos = GetPosition("NVLeader")
	for thiefid in S5Hook.EntityIterator(Predicate.OfAnyType(Entities.PU_Thief, Entities.PU_Hero5),Predicate.InCircle(KalaLeaderpos.X, KalaLeaderpos.Y, 800)) do
		local ThiefPlayerID = Logic.EntityGetPlayer(thiefid)
		if ThiefAtKala[ThiefPlayerID] == 0 then
			ThiefAtKala[ThiefPlayerID] = 1
			Message("@color:174,87,0,255 "..XNetwork.GameInformation_GetLogicPlayerUserName(ThiefPlayerID).." verhandelt mit Kala.")
			local TributeTable = CreateATribute(ThiefPlayerID, "Zahlt 5000 Taler, 5000 Eisen und 5000 Glauben an Kala, damit sie zusammen mit euch kämpft.", {Gold = 5000,Iron = 5000, Faith = 5000},KalaTributePaied)
			TributeTable.Tribute = nil
			AddTribute(TributeTable)
			KalaTributes[ThiefPlayerID] = TributeTable
		end
	end
	return false
end

function KalaTributePaied(CreateATable_table)
	for j = 1,4,1 do
		local PlayersTributes = {Logic.GetAllTributes(j)}
		for _,tableindexs2 in pairs(PlayersTributes) do
			if KalaTributes[j] ~= nil then
				if tableindexs2 == KalaTributes[j].Tribute then
					Logic.RemoveTribute(j, tableindexs2)
					if JobIsRunning(KILeaderThief1_Job) then
						Trigger.UnrequestTrigger(KILeaderThief1_Job)
					end
				end
			end
		end
		if not NVBasedown then
			if XNetwork.GameInformation_GetLogicPlayerTeam(j) == XNetwork.GameInformation_GetLogicPlayerTeam(CreateATable_table.pId) then
				--hier tribute löschen von kerberos bei team wo kala verbündet
				ThiefAtKeberos[j] = 1
				for _,playeridtributes in pairs(PlayersTributes) do
					if KerberosTributes[j] ~= nil then
						if playeridtributes == KerberosTributes[j].Tribute then
							Logic.RemoveTribute(j,playeridtributes)
						end
					end
				end
			end
		end
	end
	if NVBasedown then
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Gold, 5000)
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Iron, 5000)
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Faith, 5000)
		if GUI.GetPlayerID() == CreateATable_table.pId then
			Message("Da Kala bereits vernichtet ist, erhaltet ihr die Rohstoffe zurück.")
		end
		return
	end
	local newleaderID = Logic.ChangeEntityPlayerID(GetID("NVLeader"),6)
	if IsAlive("NVBarracksSpawn2Generator") and IsAlive("NVBarracksSpawn1Generator") then
		local spawnpos= {}
		spawnpos[1] = GetPosition("NVBarracksSpawn2")
		spawnpos[1].Generator = "NVBarracksSpawn2Generator"
		spawnpos[2] = GetPosition("NVBarracksSpawn1")
		spawnpos[2].Generator = "NVBarracksSpawn1Generator"
		NVAttackPlayerUASpawnGenerator = UnlimitedArmySpawnGenerator:New(NVAttackPlayerUA,{
									Position = spawnpos,
									ArmySize = math.floor(Maptimervariable/250),
									SpawnCounter = 600,
									SpawnLeaders = math.floor(Maptimervariable/250),
									LeaderDesc = {
												{LeaderType = Entities.CU_Evil_LeaderBearman1, SoldierNum = 16, SpawnNum = 1, Looped = true, Experience = 3},
												{LeaderType = Entities.CU_Evil_LeaderSkirmisher1, SoldierNum = 16,  SpawnNum = 1, Looped = true, Experience = 3}
												},
									RandomizeSpawnPoint = true
												})
	end
		NVAttackPlayerUA:AddCommandSetSpawnerStatus(true,false)
		NVAttackPlayerUA:AddLeader(newleaderID)


		 if IsInTeamNorth(CreateATable_table.pId) then
			SetFriendly(1,6)
			Logic.SetShareExplorationWithPlayerFlag(1, 6, 1)
			Logic.SetTechnologyState(1,Technologies.T_UpgradeRifle1, 2)
			Logic.SetTechnologyState(1,Technologies.MU_LeaderRifle, 2)
			Logic.SetTechnologyState(1,Technologies.T_FleeceArmor, 2)
			Logic.SetTechnologyState(1,Technologies.T_FleeceLinedLeatherArmor, 2)
			Logic.SetTechnologyState(1,Technologies.T_LeadShot, 2)
			Logic.SetTechnologyState(1,Technologies.T_Sights, 2)
			SetFriendly(2,6)
			Logic.SetShareExplorationWithPlayerFlag(2, 6, 1)
			Logic.SetTechnologyState(2,Technologies.T_UpgradeRifle1, 2)
			Logic.SetTechnologyState(2,Technologies.MU_LeaderRifle, 2)
			Logic.SetTechnologyState(2,Technologies.T_FleeceArmor, 2)
			Logic.SetTechnologyState(2,Technologies.T_FleeceLinedLeatherArmor, 2)
			Logic.SetTechnologyState(2,Technologies.T_LeadShot, 2)
			Logic.SetTechnologyState(2,Technologies.T_Sights, 2)
			NVAttackPlayerUA:AddCommandWaitForSpawnerFull(false)
			NVAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
			NVAttackPlayerUA:AddCommandWaitForIdle(false)
			NVAttackPlayerUA:AddCommandMove(GetPosition("NVUAWaypoint1"),false)
			NVAttackPlayerUA:AddCommandWaitForIdle(false)
			NVAttackPlayerUA:AddCommandLuaFunc(SouthAttackPlayerfunc1, true)
			NVAttackPlayerUA:AddCommandWaitForIdle(true)
			NVAttackPlayerUA:AddCommandLuaFunc(NVAttackerChecker1, true)
		 else
			SetFriendly(3,6)
			Logic.SetShareExplorationWithPlayerFlag(3, 6, 1)
			Logic.SetTechnologyState(3,Technologies.T_UpgradeRifle1, 2)
			Logic.SetTechnologyState(3,Technologies.MU_LeaderRifle, 2)
			Logic.SetTechnologyState(3,Technologies.T_FleeceArmor, 2)
			Logic.SetTechnologyState(3,Technologies.T_FleeceLinedLeatherArmor, 2)
			Logic.SetTechnologyState(3,Technologies.T_LeadShot, 2)
			Logic.SetTechnologyState(3,Technologies.T_Sights, 2)
			SetFriendly(4,6)
			Logic.SetShareExplorationWithPlayerFlag(4, 6, 1)
			Logic.SetTechnologyState(4,Technologies.T_UpgradeRifle1, 2)
			Logic.SetTechnologyState(4,Technologies.MU_LeaderRifle, 2)
			Logic.SetTechnologyState(4,Technologies.T_FleeceArmor, 2)
			Logic.SetTechnologyState(4,Technologies.T_FleeceLinedLeatherArmor, 2)
			Logic.SetTechnologyState(4,Technologies.T_LeadShot, 2)
			Logic.SetTechnologyState(4,Technologies.T_Sights, 2)
			NVAttackPlayerUA:AddCommandWaitForSpawnerFull(false)
			NVAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
			NVAttackPlayerUA:AddCommandWaitForIdle(false)
			NVAttackPlayerUA:AddCommandMove(GetPosition("NVUAWaypoint1"),false)
			NVAttackPlayerUA:AddCommandWaitForIdle(false)
			NVAttackPlayerUA:AddCommandLuaFunc(SouthAttackPlayerfunc2, true)
			NVAttackPlayerUA:AddCommandWaitForIdle(true)
			NVAttackPlayerUA:AddCommandLuaFunc(NVAttackerChecker2, true)
		 end
	 InvulerableTowers(0)
end

function NVAttackerChecker1(self)
	if self.DeadHeroes[1] then
		Logic.DestroyEntity(self.DeadHeroes[1])
	end
	if self:GetSize(true,true) == 0 then
		self:ClearCommandQueue()
		self:AddCommandLuaFunc(NVAttackerAnalyzier,false)
		self.Spawner:ResetCounter()
		self:CreateLeaderForArmy(Entities.CU_Evil_Queen, 0,  KalaPosition, 0)
		--self.Spawner:AddLeaderType(Entities.CU_Evil_Queen, 0, 1, 0, false)
		self:AddCommandSetSpawnerStatus(true,false)
		self:AddCommandWaitForSpawnerFull(false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandSetSpawnerStatus(false,false)
		self:AddCommandMove(GetPosition("NVUAWaypoint1"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandMove(GetPosition("Team2Collecting"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandLuaFunc(SouthAttackPlayerfunc1, true)
		self:AddCommandWaitForIdle(true)
		self:AddCommandLuaFunc(NVAttackerChecker1, true)
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("NVUAWaypoint1"))
	end
	return true
end

function NVAttackerChecker2(self)
	if self.DeadHeroes[1] then
		Logic.DestroyEntity(self.DeadHeroes[1])
	end	
	if self:GetSize(true,true) == 0 then
		self:ClearCommandQueue()
		self:AddCommandLuaFunc(NVAttackerAnalyzier,false)
		self.Spawner:ResetCounter()
		self.Spawner:AddLeaderType(Entities.CU_Evil_Queen, 0, 1, 0, false)
		self:AddCommandSetSpawnerStatus(true,false)
		self:AddCommandWaitForSpawnerFull(false)
		self:AddCommandSetSpawnerStatus(false,false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandMove(GetPosition("NVUAWaypoint1"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandMove(GetPosition("Team1Collecting"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandLuaFunc(SouthAttackPlayerfunc2, true)
		self:AddCommandWaitForIdle(true)
		self:AddCommandLuaFunc(NVAttackerChecker2, true)
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("NVUAWaypoint1"))
	end
	return true
end

function SouthAttackPlayerfunc1(self)
	if IsValid("PlayerHQ3") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ3"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ4"))
	end
end

function SouthAttackPlayerfunc2(self)
	if IsValid("PlayerHQ2") then
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ2"))
	else
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("PlayerHQ1"))
	end
end

function NVAttackerAnalyzier(self)
	for _,deadheroid in ipairs(self.DeadHeroes) do
		if deadheroid ~= nil then
			Logic.DestroyEntity(deadheroid)
		end
	end
	self.Spawner.ArmySize = math.floor(Maptimervariable/250) + basedowny
	self.Spawner.SpawnLeaders = math.floor(Maptimervariable/250)  + basedowny
	return true
end

--Kerberos

function KILeaderThief2()
	if IsDead("DarkLeader") then
		if IsDead("KILeaderBase") then
			return true
		end
        return false
    end
	KerberosLeaderpos = GetPosition("DarkLeader")
	for thiefid1 in S5Hook.EntityIterator(Predicate.OfAnyType(Entities.PU_Thief, Entities.PU_Hero5),Predicate.InCircle(KerberosLeaderpos.X, KerberosLeaderpos.Y, 800)) do
		local ThiefPlayerID1 = Logic.EntityGetPlayer(thiefid1)
		if ThiefAtKeberos[ThiefPlayerID1] == 0 then
			ThiefAtKeberos[ThiefPlayerID1] = 1
			Message("@color:174,87,0,255 "..XNetwork.GameInformation_GetLogicPlayerUserName(ThiefPlayerID1).." verhandelt mit Highport.")
			local TributeTable = CreateATribute(ThiefPlayerID1, "Zahlt 8000 Taler, 3000 Schwefel, 1500 Eisen und 5000 Glauben an Highport, damit er zusammen mit euch kämpft.", {Gold = 8000, Sulfur = 3000, Iron = 1500, Faith = 5000},KerberosTributePaied)
			TributeTable.Tribute = nil
			AddTribute(TributeTable)
			KerberosTributes[ThiefPlayerID1] = TributeTable
		end
	end
	return false
end

function KerberosTributePaied(CreateATable_table)
	for j = 1,4,1 do
		local PlayersTributes = {Logic.GetAllTributes(j)}
		for _,tableindexs2 in ipairs(PlayersTributes) do
			if KerberosTributes[j] ~= nil then
				if tableindexs2 == KerberosTributes[j].Tribute then
					Logic.RemoveTribute(j, tableindexs2)
					if JobIsRunning(KILeaderThief2_Job) then						
						Trigger.UnrequestTrigger(KILeaderThief2_Job)
					end						
				end
			end
		end
		if not KIBasedown then
			if XNetwork.GameInformation_GetLogicPlayerTeam(j) == XNetwork.GameInformation_GetLogicPlayerTeam(CreateATable_table.pId) then
				--hier tribute löschen von kerberos bei team wo kala verbündet
				ThiefAtKala[j] = 1
				for _,playeridtributes in pairs(PlayersTributes) do
					if KalaTributes[j] ~= nil then
						if playeridtributes == KalaTributes[j].Tribute then
							Logic.RemoveTribute(j,playeridtributes)
						end
					end
				end
			end
		end
	end
	if KIBasedown then
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Gold, 8000)
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Sulfur, 3000)
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Iron, 1500)
		Logic.AddToPlayersGlobalResource(CreateATable_table.pId, ResourceType.Faith, 5000)
		if GUI.GetPlayerID() == CreateATable_table.pId then
			Message("Da Highport bereits vernichtet ist, erhaltet ihr die Rohstoffe zurück.")
		end
		return
	end
	local newleaderID = Logic.ChangeEntityPlayerID(GetID("DarkLeader"),5)
	if IsAlive("KeberosUASpawnGenerator2") and IsAlive("KeberosUASpawnGenerator1") and IsAlive("KeberosUASpawnGenerator3") then
		local spawnpos= {}
		spawnpos[1] = GetPosition("KeberosUACollectingDefPoint")
		spawnpos[1].Generator = {"KeberosUASpawnGenerator2","KeberosUASpawnGenerator1"}
		spawnpos[2] = GetPosition("KeberosUACollectingDefPoint1")
		spawnpos[2].Generator = "KeberosUASpawnGenerator3"
		KerberosAttackPlayerUASpawnGenerator = UnlimitedArmySpawnGenerator:New(KerberosAttackPlayerUA,{
									Position = spawnpos,
									ArmySize = math.floor(Maptimervariable/257),
									SpawnCounter = 600,
									SpawnLeaders = math.floor(Maptimervariable/257),
									LeaderDesc = {
												{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8,  SpawnNum = 2, Looped = true, Experience = 3},
												{LeaderType = Entities.PV_Cannon4, SoldierNum = 8,  SpawnNum = 1, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8,  SpawnNum = 2, Looped = true, Experience = 3},
												{LeaderType = Entities.PV_Cannon3, SoldierNum = 8,  SpawnNum = 2, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 8,  SpawnNum = 2, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8,  SpawnNum = 3, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8,  SpawnNum = 2, Looped = true, Experience = 3},
												{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
												},
									RandomizeSpawn = true
												})
	end
	KerberosAttackPlayerUA:AddCommandSetSpawnerStatus(true,false)
	KerberosAttackPlayerUA:AddLeader(newleaderID)
											
	
	 if IsInTeamNorth(CreateATable_table.pId) then
		SetFriendly(1,5)
		Logic.SetShareExplorationWithPlayerFlag(1, 5, 1)
		--techs
		Logic.SetTechnologyState(1,Technologies.MU_LeaderHeavyCavalry, 2)
		Logic.SetTechnologyState(1,Technologies.MU_Cannon3, 2)
		Logic.SetTechnologyState(1,Technologies.MU_Cannon4, 2)
		SetFriendly(2,5)
		Logic.SetShareExplorationWithPlayerFlag(2, 5, 1)
		--techs
		Logic.SetTechnologyState(2,Technologies.MU_LeaderHeavyCavalry, 2)
		Logic.SetTechnologyState(2,Technologies.MU_Cannon3, 2)
		Logic.SetTechnologyState(2,Technologies.MU_Cannon4, 2)
		KerberosAttackPlayerUA:AddCommandWaitForSpawnerFull(false)
		KerberosAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(false)
		KerberosAttackPlayerUA:AddCommandMove(GetPosition("KeberosUAWaypoint1"),false)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(false)
		KerberosAttackPlayerUA:AddCommandLuaFunc(SouthAttackPlayerfunc1, true)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(true)
		KerberosAttackPlayerUA:AddCommandLuaFunc(KeberosAttackerChecker1, true)
	 else
		SetFriendly(3,5)
		Logic.SetShareExplorationWithPlayerFlag(3, 5, 1)
		--techs
		Logic.SetTechnologyState(3,Technologies.MU_LeaderHeavyCavalry, 2)
		Logic.SetTechnologyState(3,Technologies.MU_Cannon3, 2)
		Logic.SetTechnologyState(3,Technologies.MU_Cannon4, 2)
		SetFriendly(4,5)
		Logic.SetShareExplorationWithPlayerFlag(4, 5, 1)
		--techs
		Logic.SetTechnologyState(4,Technologies.MU_LeaderHeavyCavalry, 2)
		Logic.SetTechnologyState(4,Technologies.MU_Cannon3, 2)
		Logic.SetTechnologyState(4,Technologies.MU_Cannon4, 2)
		KerberosAttackPlayerUA:AddCommandWaitForSpawnerFull(false)
		KerberosAttackPlayerUA:AddCommandSetSpawnerStatus(false,false)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(false)
		KerberosAttackPlayerUA:AddCommandMove(GetPosition("KeberosUAWaypoint1"),false)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(false)
		KerberosAttackPlayerUA:AddCommandLuaFunc(SouthAttackPlayerfunc2, true)
		KerberosAttackPlayerUA:AddCommandWaitForIdle(true)
		KerberosAttackPlayerUA:AddCommandLuaFunc(KeberosAttackerChecker2, true)
	 end
	 InvulerableTowers(0)
end

function KeberosAttackerChecker1(self)
	if self.DeadHeroes[1] then
		Logic.DestroyEntity(self.DeadHeroes[1])
	end
	if self:GetSize(true,true) == 0 then
		self:ClearCommandQueue()
		self:AddCommandLuaFunc(KeberosAttackerAnalyzier,false)
		self.Spawner:ResetCounter()
		self:CreateLeaderForArmy(Entities.CU_BlackKnight, 0, KeberosPosition, 0)
		--self.Spawner:AddLeaderType(Entities.CU_Blackknight, 0, 1, 0, false)
		self:AddCommandSetSpawnerStatus(true,false)
		self:AddCommandWaitForSpawnerFull(false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandSetSpawnerStatus(false,false)
		self:AddCommandMove(GetPosition("KeberosUAWaypoint1"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandMove(GetPosition("Team2Collecting"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandLuaFunc(SouthAttackPlayerfunc1, true)
		self:AddCommandWaitForIdle(true)
		self:AddCommandLuaFunc(KeberosAttackerChecker1, true)
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("KeberosUACollectingDefPoint"))
	end
	return true
end

function KeberosAttackerChecker2(self)
	if self.DeadHeroes[1] then
		Logic.DestroyEntity(self.DeadHeroes[1])
	end
	if self:GetSize(true,true) == 0 then
		self:ClearCommandQueue()
		self:AddCommandLuaFunc(KeberosAttackerAnalyzier,false)
		self.Spawner:ResetCounter()
		self:CreateLeaderForArmy(Entities.CU_BlackKnight, 0, KeberosPosition, 0)
		--self.Spawner:AddLeaderType(Entities.CU_Blackknight, 0, 1, 0, false)
		self:AddCommandSetSpawnerStatus(true,false)
		self:AddCommandWaitForSpawnerFull(false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandSetSpawnerStatus(false,false)
		self:AddCommandMove(GetPosition("KeberosUAWaypoint1"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandMove(GetPosition("Team1Collecting"),false)
		self:AddCommandWaitForIdle(false)
		self:AddCommandLuaFunc(SouthAttackPlayerfunc2, true)
		self:AddCommandWaitForIdle(true)
		self:AddCommandLuaFunc(KeberosAttackerChecker2, true)
		return true, UnlimitedArmy.CreateCommandMove(GetPosition("KeberosUACollectingDefPoint"))
	end
	return true
end

function KeberosAttackerAnalyzier(self)
	for _,deadheroid in ipairs(self.DeadHeroes) do
		if deadheroid ~= nil then
			Logic.DestroyEntity(deadheroid)
		end
	end
	self.Spawner.ArmySize = math.floor(Maptimervariable/257) + basedownx
	self.Spawner.SpawnLeaders = math.floor(Maptimervariable/257) + basedownx
	return true
end