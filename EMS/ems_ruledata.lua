-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                           RULE DATA                                          * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
EMS.RD = {};
EMS.RD.Rules = {};
function EMS.RD.Setup(_cfg)
	
	local noconfig = false;
	if not _cfg then
		EMS_RD_NO_CONFIG = function()
			EMS.GL.Info("@color:255,0,0 " .. EMS.L.NoConfigFileFound);
			return true;
		end
		StartSimpleJob("EMS_RD_NO_CONFIG")
		noconfig = true;
	end
		
	_cfg = _cfg or {};

	if _cfg.NeedsCppLogic then
		if not CppLogic then
			EMS_RD_NO_CPP_LOGIC = function()
				EMS.GL.Info("@color:255,0,0 " .. EMS.L.NeedsCppLogic);
				if Counter.Tick2("EMS_RD_NO_CPP_LOGIC", 15) then
					--Framework.CloseGame();
				end
				return true;
			end
			StartSimpleJob("EMS_RD_NO_CPP_LOGIC")
		end
	end

	-- this config file defines rules directly
	EMS.RD.Config = 
	{
		Peacetime = _cfg.Peacetime or 30,
		GameMode = _cfg.GameMode or 1,
		
		-- Units
		Sword = _cfg.Sword or 4,
		Bow = _cfg.Bow or 4,
		PoleArm = _cfg.PoleArm or 4,
		HeavyCavalry = _cfg.HeavyCavalry or 0,
		LightCavalry = _cfg.LightCavalry or 0,
		Rifle = _cfg.Rifle or 2,
		Thief = _cfg.Thief or 1,
		Scout = _cfg.Scout or 1,
		Cannon1 = _cfg.Cannon1 or 0,
		Cannon2 = _cfg.Cannon2 or 0,
		Cannon3 = _cfg.Cannon3 or 0,
		Cannon4 = _cfg.Cannon4 or 0,
		
		-- Buildings
		Bridge = _cfg.Bridges or 1,
		Markets = _cfg.Markets or -1, -- -1 = forbidden, 0=allowed, >0 limit of marktplaces
		TradeLimit = _cfg.TradeLimit or 0,
		TowerLevel = _cfg.TowerLevel or 1, -- 0-3
		TowerLimit = _cfg.TowerLimit or 0,
		
		WeatherChangeLockTimer = _cfg.WeatherChangeLockTimer or 3,
		MakeSummer = _cfg.MakeSummer or 1,
		MakeRain = _cfg.MakeRain or 1,
		MakeSnow = _cfg.MakeSnow or 1,
		
		AntiBug = _cfg.AntiBug or 1,
		HQRush = _cfg.AntiHQRush or 1,
		BlessLimit = _cfg.BlessLimit or 1,
		
		Dario = _cfg.Dario or 1,
		Pilgrim = _cfg.Pilgrim or 1,
		Ari = _cfg.Ari or 1,
		Erec = _cfg.Erec or 1,
		Salim = _cfg.Salim or 1,
		Helias = _cfg.Helias or 1,
		Drake = _cfg.Drake or 1,
		Yuki = _cfg.Yuki or 1,
		Kerberos = _cfg.Kerberos or 1,
		Varg = _cfg.Varg or 1,
		Mary_de_Mortfichet = _cfg.Mary_de_Mortfichet or 1,
		Kala = _cfg.Kala or 1,
		
		ResourceLevel = _cfg.ResourceLevel or 1,
		--PredefinedRuleset = _cfg.PredefinedRuleset or 1,
	};
	_cfg.Heroes = _cfg.Heroes or {};
	for playerId = 1, EMS.GV.MaxPlayers do
		if _cfg.Heroes[playerId] then
			EMS.RD.Config["NumberOfHeroesForPlayer"..playerId] = _cfg.Heroes[playerId];
		end
	end
	EMS.RD.Config.NumberOfHeroesForAll = _cfg.NumberOfHeroesForAll or 0;
	
	-- Additional Config
	-- (things that are not evaluated by rules);
	_cfg.Ressources = _cfg.Ressources or {};
	_cfg.Ressources.Normal = _cfg.Ressources.Normal or {};
	_cfg.Ressources.FastGame = _cfg.Ressources.FastGame or {};
	_cfg.Ressources.SpeedGame = _cfg.Ressources.SpeedGame or {};
	local noFunction = function()end;
	EMS.RD.AdditionalConfig =
	{
		Callback_OnMapStart = _cfg.Callback_OnMapStart or noFunction,
		Callback_OnGameStart = _cfg.Callback_OnGameStart or noFunction,
		Callback_OnPeacetimeEnded = _cfg.Callback_OnPeacetimeEnded or noFunction,
		
		Callback_OnFastGame = _cfg.Callback_OnFastGame or noFunction,
		Callback_GameModeSelected = _cfg.Callback_GameModeSelected or noFunction,
		
		GameModes = _cfg.GameModes or {EMS.L.Standard},
		
		NoPeacetimeEndedFeedback = _cfg.NoPeacetimeEndedFeedback or false,
		
		Ressources =
		{
			Normal = {},
			FastGame = {},
			SpeedGame = {},
		},
		
		ConfigVersion = _cfg.Version or "No config",
		
		DontRemoveScriptEntities = _cfg.DontRemoveScriptEntities or false;

		NeedsCppLogic = _cfg.NeedsCppLogic or false;
		NeedsS5CommunityLib = _cfg.NeedsS5CommunityLib or false;

		ActivateDebug = _cfg.ActivateDebug or false;
	}
	
	EMS.RD.AdditionalConfig.AIPlayers = {};
	if _cfg.AIPlayers then
		for i = 1, table.getn(_cfg.AIPlayers) do
			EMS.RD.AdditionalConfig.AIPlayers[_cfg.AIPlayers[i]] = true;
		end
	end
	
	-- setup fixed diplomacies
	local dipl;
	EMS.RD.AdditionalConfig.Diplomacies = _cfg.Diplomacies or {};
	for i = 1, table.getn(EMS.RD.AdditionalConfig.Diplomacies) do
		dipl = EMS.RD.AdditionalConfig.Diplomacies[i];
		Logic.SetDiplomacyState( unpack(dipl) );
		if dipl[3] == Diplomacy.Friendly then
			EMS.T.ShareExploration(dipl[1],dipl[2]);
		end
	end
	
	-- determine ressources
	-- 1. obtain ressources if function is given
	for ressourceMode, ressourceTable in pairs(_cfg.Ressources) do
		for player, res in pairs(ressourceTable) do
			for resType, v in pairs(res) do
				if type(v) == "function" then
					_cfg.Ressources[ressourceMode][player][resType] = v();
				end
			end
		end
	end
	-- 2. transfer ressources to config
	-- Normal
	for player, data in pairs(EMS.PlayerList) do
		if _cfg.Ressources.Normal[player] then
			-- ressources for player have been defined in config, use them
			EMS.RD.AdditionalConfig.Ressources.Normal[player] = _cfg.Ressources.Normal[player];
		elseif _cfg.Ressources.Normal[1] then
			-- ressources for player have not been defined, use player 1 cfg
			EMS.RD.AdditionalConfig.Ressources.Normal[player] = _cfg.Ressources.Normal[1];
		else
			-- player 1 ressources are not defined, use std
			EMS.RD.AdditionalConfig.Ressources.Normal[player] = {1000, 1800, 1500, 800, 50, 50};
		end
	end
	-- FastGame
	local p;
	for player, data in pairs(EMS.PlayerList) do
		if _cfg.Ressources.FastGame[player] then
			-- ressources for player have been defined in config, use them
			p = player;
		elseif _cfg.Ressources.FastGame[1] then
			p = 1;
		else
			-- player 1 ressources are not defined, use std( 0 = 2*normal)
			p = 1;
			_cfg.Ressources.FastGame[p] = {0,0,0,0,0,0};
		end
		EMS.RD.AdditionalConfig.Ressources.FastGame[player] = {};
		for i = 1,6 do
			if _cfg.Ressources.FastGame[p][i] == 0 then
				-- 0 => use normal*2
				EMS.RD.AdditionalConfig.Ressources.FastGame[player][i] = EMS.RD.AdditionalConfig.Ressources.Normal[player][i] * 2;
			else
				EMS.RD.AdditionalConfig.Ressources.FastGame[player][i] = _cfg.Ressources.FastGame[p][i];
			end
		end
	end
	-- SpeedGame
	local speedgamestd = {20000,12000,14000,10000,7500,7500};
	for player, data in pairs(EMS.PlayerList) do
		if _cfg.Ressources.SpeedGame[player] then
			-- ressources for player have been defined in config, use them
			p = player;
		elseif _cfg.Ressources.SpeedGame[1] then
			p = 1;
		else
			-- player 1 ressources are not defined, use std 20k, 12k, 14k, 10k, 7.5k, 7.5k
			p = 1;
			_cfg.Ressources.SpeedGame[p] = {20000,12000,14000,10000,7500,7500};
		end
		EMS.RD.AdditionalConfig.Ressources.SpeedGame[player] = {};
		for i = 1,6 do
			if _cfg.Ressources.SpeedGame[p][i] == 0 then
				-- 0 => speedgame standard
				EMS.RD.AdditionalConfig.Ressources.SpeedGame[player][i] = speedgamestd[i];
			else
				EMS.RD.AdditionalConfig.Ressources.SpeedGame[player][i] = _cfg.Ressources.SpeedGame[p][i];
			end
		end
	end
	
	EMS.RD.AdditionalConfig.InvulnerableHQs = _cfg.InvulnerableHQs or false;
	
	if not _cfg.DisableInitCameraOnHeadquarter then
		MultiplayerTools.InitCameraPositionsForPlayers();
	end
	
	if not _cfg.DisableSetZoomFactor then
		Camera.ZoomSetFactorMax(2);
	end
	
	if noconfig then
		-- if there is no config file, add summer and normal weather
		AddPeriodicSummer(10);
		SetupNormalWeatherGfxSet();
	end
	
	if not _cfg.DisableStandardVictoryCondition then
		-- if disabled, destroying the Headquarter will not mean a player loses
		EMS.T.InitStandardVictoryCondition();
		StartSimpleJob("EMS_T_StandardVictoryConditionJob");
	end

	-- initialize rules with data
	EMS.RD.SetActiveRuleSet(1);
	
	--[[ create obecjts that can
		Increase()
		Decrease()
		GetValue()
		SetValue()
		GetTitle()
		GetDescription()
	]]
	--EMS.RD.Peacetime = EMS.RD.NewRule();
	
	--[[
		Important Data
		
		DONE:
			Einheiten - entweder button -> über GetValue regeln oder string -> get representant
			Brücken
			Marktplätze bauen
			Türme - stufe 1,2,3
			Peacetime
			Anti Abreiss bug - aktiviert, deaktiviert
			Anti HQ Rush - ak,d 
			Segnenlimit - ak, d
			Helden - anz pro spieler, alle spieler
			Turmlimit
			Handelslimit
			Marktplatz limit
			Wetterwechsel
			Wetterwechselsperre
			Scouts, Thiefs, cannons
		
		UNFINISHED:
			PredefinedRuleSet - erbe rules - keine nebelreich stuff
				-6er... keine kanonen, kein handeln, kein pferde keine türme etc.
				tournament rules einstellen
		
		TODO:
			Ressource Mode
		PAY2WIN DU NOOB !

		Gamemode: Adaptive, 2vs2, 3vs3 - muss über config enabled werden


		-- MODS:
		Zugeordnete DZ
		mauerbau - 2 varianten
		
	-------------------------------
		weitere ideen:
		es gibt eine identifier liste ["Peacetime"] = tableref - um direkt values aus der config ändern zu können
		in der config soll man game modi erstellen können: zb: 1vs1, 2vs2 oder adaptive -> muss auf map angepasst werden
		in der config soll man rule setes erstellen können
		- es muss zufalls regeln geben :D
		in der config gibt es einene eintrag für add pages
		dann kann man seiten mit beliebig vielen regeln hinzufügen
		
		achtung ressourcen in der config. es kann eine einstellung geben bei der ressourcen für alle spieler festgelegt werden, es muss allerdings auch
		die möglichkeit für fast game ressis geben und diese nochmal für jeden spieler anzupassen in falle von 3vs3, 2vs3 situationen
		Eine Ändderung an den Regeln muss dafür sorgen, dass die voreingestelle regel zu Benutzerdefiniert, custom springt
		
		Pages brauchen headlines Konfiguration ROT: 1 / 5 :normal: Seitentitel
		STDBool klasse erschaffen und mit cpy table vervielfachen
		STDHero klasse und für helden
		was passiert wenn rule helden für andere spieler ändern soll? Zugriff über Index H1-H8 (NrOfHeroesP1)
	]]
	
	if _cfg.ActivateDebug then
		EMS.D.Setup(_cfg.CustomDebugFunc1, _cfg.CustomDebugFunc2);
	end

end


-- ************************************************************************************************ --
-- *	Template StdRule
-- *
EMS.RD.Templates = {};
EMS.RD.Templates.StdRule = {value=0};
function EMS.RD.Templates.StdRule:Increase()
	self:SetValue(self.value + 1);
end

function EMS.RD.Templates.StdRule:Decrease()
	self:SetValue(self.value - 1);
end

function EMS.RD.Templates.StdRule:GetValue()
	return self.value;
end

function EMS.RD.Templates.StdRule:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:HardCustomize();
	if _value >= 0 then
		self.value = _value;
	end
end

function EMS.RD.Templates.StdRule:GetRepresentative()
	return self.value;
end

function EMS.RD.Templates.StdRule:GetTitle()
	return "Undefined Rule";
end

function EMS.RD.Templates.StdRule:GetDescription()
	return "Undefined description";
end

function EMS.RD.Templates.StdRule:Evaluate()
	assert(true, "Evaluate Method not defined");
end

-- ************************************************************************************************ --
-- *	Template StdBool
-- *

EMS.RD.Templates.StdBool = {value=0, Representatives = {[0]= EMS.L.Forbidden, [1] = EMS.L.Allowed}};
function EMS.RD.Templates.StdBool:Increase()
	self:SetValue(1-self.value);
end

function EMS.RD.Templates.StdBool:Decrease()
	self:SetValue(1-self.value);
end

function EMS.RD.Templates.StdBool:GetValue()
	return self.value;
end

function EMS.RD.Templates.StdBool:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:HardCustomize();
	if _value ~= 0 and _value ~= 1 then
		return;
	end;
	self.value = _value;
end

function EMS.RD.Templates.StdBool:GetRepresentative()
	return self.Representatives[self.value];
end

-- ************************************************************************************************ --
-- *	AntiBug
-- *

EMS.RD.Rules.AntiBug = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.AntiBug.Representatives = {[0]= EMS.GV.ForbiddenColor .. " @center " .. EMS.L.Deactivated, [1] = EMS.GV.AllowedColor .. " @center " .. EMS.L.Activated};
function EMS.RD.Rules.AntiBug:GetTitle()
	return EMS.L.AntiBug;
end

function EMS.RD.Rules.AntiBug:GetDescription()
	return EMS.L.AntiBugDescription;
end

function EMS.RD.Rules.AntiBug:Evaluate()
	if self.value == 1 then
		EMS.AC.CheckSellBuilding = true;
	else
		EMS.AC.CheckSellBuilding = false;
	end
end

-- ************************************************************************************************ --
-- *	BlessLimit
-- *

EMS.RD.Rules.BlessLimit = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.BlessLimit.Representatives = {[0]= EMS.GV.ForbiddenColor .. " @center " .. EMS.L.Deactivated, [1] = EMS.GV.AllowedColor .. " @center " .. EMS.L.Activated};

function EMS.RD.Rules.BlessLimit:GetTitle()
	return EMS.L.BlessLimit;
end

function EMS.RD.Rules.BlessLimit:GetDescription()
	return EMS.L.BlessLimitDescription;
end

function EMS.RD.Rules.BlessLimit:Evaluate()
	if self.value == 1 then
		EMS.RF.ActivateBlessLimit();
	end
end

-- ************************************************************************************************ --
-- *	HQ Rush Protection
-- *

EMS.RD.Rules.HQRush = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.HQRush.Representatives = {[0]= EMS.GV.ForbiddenColor .. " @center " .. EMS.L.Deactivated, [1] = EMS.GV.AllowedColor .. " @center " .. EMS.L.Activated};

function EMS.RD.Rules.HQRush:GetTitle()
	return EMS.L.HQRushProtection;
end

function EMS.RD.Rules.HQRush:GetDescription()
	return EMS.L.HQRushProtectionDescripion;
end

function EMS.RD.Rules.HQRush:Evaluate()
	if self.value == 1 then
		EMS.RF.ActivateHQRushProtection();
	end
end

-- ************************************************************************************************ --
-- *	Thiefs
-- *

EMS.RD.Rules.Thief = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.Thief:GetTitle()
	return EMS.L.Thief;
end

function EMS.RD.Rules.Thief:GetDescription()
	return EMS.L.ThiefDescription;
end

function EMS.RD.Rules.Thief:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies["MU_Thief"], playerId);
		end
	end
end


-- ************************************************************************************************ --
-- *	Scouts
-- *

EMS.RD.Rules.Scout = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.Scout:GetTitle()
	return EMS.L.Scout;
end

function EMS.RD.Rules.Scout:GetDescription()
	return EMS.L.ScoutDescription;
end

function EMS.RD.Rules.Scout:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies["MU_Scout"], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	Cannon1
-- *

EMS.RD.Rules.Cannon1 = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.Cannon1.CannonId = 1;
function EMS.RD.Rules.Cannon1:GetTitle()
	return EMS.L.MU.Cannon[self.CannonId];
end

function EMS.RD.Rules.Cannon1:GetDescription()
	return EMS.L.CannonDescription .. EMS.GV.TooltipHighlightColor1 .. EMS.L.MU.Cannon[self.CannonId];
end

function EMS.RD.Rules.Cannon1:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies["MU_Cannon"..self.CannonId], playerId);
		end
	end
end

for cId = 2, 4 do
	_G["EMS"]["RD"]["Rules"]["Cannon"..cId] = EMS.T.CopyTable(EMS.RD.Rules.Cannon1);
	_G["EMS"]["RD"]["Rules"]["Cannon"..cId].CannonId = cId;
end

-- ************************************************************************************************ --
-- *	Cannons
-- *	to switch off all cannons at once in rule menu

EMS.RD.Cannons = EMS.T.CopyTable(EMS.RD.Rules.Cannon1);
EMS.RD.Cannons.CannonId = 5;
function EMS.RD.Cannons:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:HardCustomize();
	self.value = _value;
	for i = 1,4 do
		EMS.RD.Rules["Cannon"..i]:SetValue(_value);
	end
end

function EMS.RD.Cannons:Evaluate()
	-- nothing to do here
end

-- ************************************************************************************************ --
-- *	Make Summer
-- *

EMS.RD.Rules.MakeSummer = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.MakeSummer:GetTitle()
	return EMS.L.MakeSummer;
end

function EMS.RD.Rules.MakeSummer:GetDescription()
	return EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription1 .. EMS.GV.TooltipHighlightColor1 .. self:GetTitle() .. EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription2;
end

function EMS.RD.Rules.MakeSummer:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies.T_MakeSummer, playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	MakeRain
-- *

EMS.RD.Rules.MakeRain = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.MakeRain:GetTitle()
	return EMS.L.MakeRain;
end

function EMS.RD.Rules.MakeRain:GetDescription()
	return EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription1 .. EMS.GV.TooltipHighlightColor1 .. self:GetTitle() .. EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription2;
end

function EMS.RD.Rules.MakeRain:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies.T_MakeRain, playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	MakeSnow
-- *

EMS.RD.Rules.MakeSnow = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.MakeSnow:GetTitle()
	return EMS.L.MakeSnow;
end

function EMS.RD.Rules.MakeSnow:GetDescription()
	return EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription1 .. EMS.GV.TooltipHighlightColor1 .. self:GetTitle() .. EMS.GV.TooltipNormalColor1 .. EMS.L.MakeDescription2;
end

function EMS.RD.Rules.MakeSnow:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies.T_MakeSnow, playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	WeatherChangeLockTimer
-- *

EMS.RD.Rules.WeatherChangeLockTimer = {value=0};
function EMS.RD.Rules.WeatherChangeLockTimer:Increase()
	self.SetValue(self.value+0.5);
end

function EMS.RD.Rules.WeatherChangeLockTimer:Decrease()
	self.SetValue(self.value-0.5);
end

function EMS.RD.Rules.WeatherChangeLockTimer:GetValue()
	return self.value;
end

function EMS.RD.Rules.WeatherChangeLockTimer:SetValue(_value)
	if _value >= 0 then
		self.value = _value;
	end
end

function EMS.RD.Rules.WeatherChangeLockTimer:GetRepresentative()
	if self.value == 0 then
		return EMS.L.Deactivated;
	end
	return self.value;
end

function EMS.RD.Rules.WeatherChangeLockTimer:GetTitle()
	return EMS.L.WeatherChangeLockTimer;
end

function EMS.RD.Rules.WeatherChangeLockTimer:GetDescription()
	return EMS.L.WeatherChangeLockTimerDescription;
end

function EMS.RD.Rules.WeatherChangeLockTimer:Evaluate()
	if self.value > 0 then
		EMS.RF.ActivateWeatherLockTimer(self.value);
	end
end

-- ************************************************************************************************ --
-- *	Markets
-- *

EMS.RD.Rules.Markets = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.Markets:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:HardCustomize();
	if _value >= -1 then
		self.value = _value;
	end
end

function EMS.RD.Rules.Markets:GetRepresentative()
	if self.value == -1 then
		return EMS.L.Forbidden;
	elseif self.value == 0 then
		return EMS.L.Allowed;
	end
	return self.value;
end

function EMS.RD.Rules.Markets:GetTitle()
	if self.value < 1 then
		return EMS.L.Markets;
	end
	return EMS.L.MarketsWithLimit;
end

function EMS.RD.Rules.Markets:GetDescription()
	return EMS.L.MarketsDescription;
end

function EMS.RD.Rules.Markets:Evaluate()
	-- possible: -1 = no markets allowed, 0 = 0 markets allowed
	if self.value == -1 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies["UP1_Market"], playerId);
		end
	elseif self.value > 0 then
		EMS.RF.ActivateMarketLimit(self.value);
	end
end


-- ************************************************************************************************ --
-- *	TowerLimit
-- *

EMS.RD.Rules.TowerLimit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.TowerLimit:GetRepresentative()
	if self.value == 0 then
		return EMS.L.Unlimited;
	end
	return self.value;
end

function EMS.RD.Rules.TowerLimit:GetTitle()
	return EMS.L.TowerLimit;
end

function EMS.RD.Rules.TowerLimit:GetDescription()
	return EMS.L.TowerLimitDescription;
end

function EMS.RD.Rules.TowerLimit:Evaluate()
	if self.value > 0 then
		EMS.RF.ActivateTowerLimit(self.value);
	end
end

-- ************************************************************************************************ --
-- *	TradeLimit
-- *

EMS.RD.Rules.TradeLimit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
function EMS.RD.Rules.TradeLimit:Increase()
	self.SetValue(self.value+500);
end

function EMS.RD.Rules.TradeLimit:Decrease()
	self.SetValue(self.value-500);
end

function EMS.RD.Rules.TradeLimit:GetRepresentative()
	if self.value == 0 then
		return EMS.L.Unlimited;
	end
	return self.value;
end

function EMS.RD.Rules.TradeLimit:GetTitle()
	return EMS.L.TradeLimit;
end

function EMS.RD.Rules.TradeLimit:GetDescription()
	return EMS.L.TradeLimitDescription;
end

function EMS.RD.Rules.TradeLimit:Evaluate()
	if self.value > 0 then
		EMS.RF.ActivateTradeLimit(self.value);
	end
end

-- ************************************************************************************************ --
-- *	Bridge
-- *

EMS.RD.Rules.Bridge = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
function EMS.RD.Rules.Bridge:GetRepresentative()
	if self.value == -1 then
		return EMS.L.Forbidden;
	elseif self.value == 0 then
		return EMS.L.Allowed;
	end
	return self.value;
end

function EMS.RD.Rules.Bridge:GetTitle()
	return EMS.L.Bridge;
end

function EMS.RD.Rules.Bridge:GetDescription()
	return EMS.L.BridgeDescription;
end

function EMS.RD.Rules.Bridge:Evaluate()
	if self.value == 0 then
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies["B_Bridge"], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	Heroes
-- *

EMS.RD.Templates.StdHero = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Templates.StdHero.HeroID = 0;
function EMS.RD.Templates.StdHero:GetTitle()
	return EMS.L.Heroes[self.HeroID];
end

function EMS.RD.Templates.StdHero:GetDescription()
	return EMS.L.AllowOrForbidBuyHero .. EMS.GV.TooltipHighlightColor1 .. EMS.L.Heroes[self.HeroID];
end

function EMS.RD.Templates.StdHero:Evaluate()
	-- nothing to do here, gui will ask objects directly
end

EMS.RD.HeroKeys = 
{
	"Dario",
	"Pilgrim",
	"Salim",
	"Erec",
	"Ari",
	"Helias",
	"Drake",
	"Yuki",
	"Kerberos",
	"Varg",
	"Mary_de_Mortfichet",
	"Kala"
}

for i = 1, table.getn(EMS.RD.HeroKeys) do
	_G["EMS"]["RD"]["Rules"][EMS.RD.HeroKeys[i]] = EMS.T.CopyTable(EMS.RD.Templates.StdHero);
	_G["EMS"]["RD"]["Rules"][EMS.RD.HeroKeys[i]]["HeroID"] = i;
end


-- ************************************************************************************************ --
-- *	Number of heroes for players
-- *

EMS.RD.Rules.NumberOfHeroesForPlayer1 = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
EMS.RD.Rules.NumberOfHeroesForPlayer1.PlayerID = 1;

function EMS.RD.Rules.NumberOfHeroesForPlayer1:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 0 then
		_value = 0;
	elseif _value > 12 then
		_value = 12
	end
	self.value = _value;
end

function EMS.RD.Rules.NumberOfHeroesForPlayer1:GetTitle()
	return EMS.PlayerList[self.PlayerID].ColorName;
end

function EMS.RD.Rules.NumberOfHeroesForPlayer1:GetDescription()
	return EMS.L.ChangeNrOfBuyableHeroesForPlayer .. EMS.PlayerList[self.PlayerID].ColorName;
end

function EMS.RD.Rules.NumberOfHeroesForPlayer1:Evaluate()
	Logic.SetNumberOfBuyableHerosForPlayer( self.PlayerID, self.value );
end

for i = 2,16 do
	_G["EMS"]["RD"]["Rules"]["NumberOfHeroesForPlayer"..i] = EMS.T.CopyTable(EMS.RD.Rules.NumberOfHeroesForPlayer1);
	_G["EMS"]["RD"]["Rules"]["NumberOfHeroesForPlayer"..i]["PlayerID"] = i;
end

EMS.RD.Rules.NumberOfHeroesForAll = EMS.T.CopyTable(EMS.RD.Rules.NumberOfHeroesForPlayer1);
EMS.RD.Rules.NumberOfHeroesForAll.PlayerID = 100;
function EMS.RD.Rules.NumberOfHeroesForAll:SetValue(_value)
	if _value < 0 then
		_value = 0;
	elseif _value > 12 then
		_value = 12;
	end
	for i = 1,16 do
		_G["EMS"]["RD"]["Rules"]["NumberOfHeroesForPlayer"..i]:SetValue(_value);
	end
	self.value = _value;
end

function EMS.RD.Rules.NumberOfHeroesForAll:GetTitle()
	return EMS.L.ChangeNrOfBuyableHeroesForAll;
end

function EMS.RD.Rules.NumberOfHeroesForAll:GetDescription()
	return EMS.L.ChangeNrOfBuyableHeroesForAllDescription;
end

function EMS.RD.Rules.NumberOfHeroesForAll:Evaluate()
	-- each number will be set individual, nothing to do
end

-- ************************************************************************************************ --
-- *	Peacetime
-- *

EMS.RD.Rules.Peacetime = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
function EMS.RD.Rules.Peacetime:Increase()
	self:SetValue(self.value + 5);
end

function EMS.RD.Rules.Peacetime:Decrease()
	self:SetValue(self.value - 5);
end

function EMS.RD.Rules.Peacetime:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize();
	if _value < 0
	or _value > 1000 then
		self.value = 0;
		return
	end;
	self.value = _value;
end

function EMS.RD.Rules.Peacetime:GetTitle()
	return EMS.L.Peacetime;
end

function EMS.RD.Rules.Peacetime:GetDescription()
	return EMS.L.PeacetimeDescription;
end

function EMS.RD.Rules.Peacetime:Evaluate()
	if self.value > 0 then
		EMS.T.SetPeacetime(self.value*60);
	else
		EMS.EndPeacetime(true);
	end
end

-- ************************************************************************************************ --
-- *	Current Page
-- *

EMS.RD.Rules.CurrentPage = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
EMS.RD.Rules.CurrentPage.value = 1;

function EMS.RD.Rules.CurrentPage:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 1 then
		_value = table.getn(EMS.GV.Pages)
	elseif _value > table.getn(EMS.GV.Pages) then
		_value = 1
	end
	XGUIEng.ShowWidget(EMS.GV.Pages[self.value], 0)
	XGUIEng.ShowWidget(EMS.GV.Pages[_value], 1)
	self.value = _value
end

function EMS.RD.Rules.CurrentPage:GetTitle()
	return "Seite"
end

function EMS.RD.Rules.CurrentPage:GetDescription(_id)
	if _id == 1 then
		return "Springt zur nächsten Regel-Seite."
	end
	return "Springt zur vorherigen Regel-Seite."
end

-- ************************************************************************************************ --
-- *	Predefined Ruleset
-- *

EMS.RD.Rules.PredefinedRuleset = {CurrentRuleSet=1, Customized=false, Rulesets = {EMS.L.MapStandard, EMS.L.Std6er, EMS.L.Erbe}};
function EMS.RD.Rules.PredefinedRuleset:Increase()
	self:SetValue(self.CurrentRuleSet + 1);
end

function EMS.RD.Rules.PredefinedRuleset:Decrease()
	self:SetValue(self.CurrentRuleSet - 1);
end

function EMS.RD.Rules.PredefinedRuleset:GetValue()
	return self.CurrentRuleSet;
end

function EMS.RD.Rules.PredefinedRuleset:SetValue(_value)
	if _value > table.getn(self.Rulesets) then
		_value = 1;
	elseif _value <= 0 then
		_value = table.getn(self.Rulesets);
	end
	EMS.RD.SetActiveRuleSet(_value);
	self.Customized = false;
	self.CurrentRuleSet = _value;
end

function EMS.RD.Rules.PredefinedRuleset:GetRepresentative()
	if self.Customized then
		return "@center " .. EMS.L.CustomRules;
	else
		return "@center " .. self.Rulesets[self.CurrentRuleSet];
	end
end

function EMS.RD.Rules.PredefinedRuleset:GetTitle()
	return EMS.L.PredefinedRuleset;
end

function EMS.RD.Rules.PredefinedRuleset:GetDescription()
	return EMS.L.PredefinedRulesetDescription;
end

function EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	-- this function is picky with definition of 'customize'
	-- it only resets, if current ruleset was standard
	-- does not reset erbe, 6er when change nr heroes, etc..
	if self.Rulesets[self.CurrentRuleSet] == EMS.L.MapStandard then
		self.Customized = true;
		self.CurrentRuleSet = 0;
	end
end

function EMS.RD.Rules.PredefinedRuleset:HardCustomize()
	-- always resets to 'customized rules'
	self.Customized = true;
	self.CurrentRuleSet = 0;
end

function EMS.RD.SetRulesByConfig(_config)
	if _config["NumberOfHeroesForAll"] then
		EMS.RD.Rules["NumberOfHeroesForAll"]:SetValue(_config["NumberOfHeroesForAll"]);
	end
	if _config["PredefinedRuleset"] then
		EMS.RD.Rules["PredefinedRuleset"]:SetValue(_config["PredefinedRuleset"]);
	end
	for ruleName, ruleValue in pairs(_config) do
		-- Exclude "all" since the amount of heroes is set individual
		if ruleName ~= "NumberOfHeroesForAll" 
		and ruleName ~= "PredefinedRuleset" then
			EMS.RD.Rules[ruleName]:SetValue(ruleValue);
		end;
	end
end

function EMS.RD.GetRuleConfig()
	local config = {};
	for k,ruleObj in pairs(EMS.RD.Rules) do
		config[k] = ruleObj:GetValue();
	end
	return config;
end

function EMS.RD.SetActiveRuleSet(_rulesetId)
	local ruleset = EMS.RD.Rules.PredefinedRuleset.Rulesets[_rulesetId];
	if ruleset == EMS.L.MapStandard then
        EMS.RD.SetRulesByConfig(EMS.RD.Config);
	elseif ruleset == EMS.L.Erbe then
		-- erbe rules
		local config = 
		{
			-- Units
			Sword = 4,
			Bow = 4,
			PoleArm = 4,
			HeavyCavalry = 0,
			LightCavalry = 0,
			Rifle = 0,
			Thief = 0,
			Scout = 0,
			Cannon1 = 0,
			Cannon2 = 0,
			Cannon3 = 0,
			Cannon4 = 0,
			
			-- Buildings
			Bridge = 0,
			Markets = 0,
			TowerLevel = 0,
			
			Dario    = 1,
			Pilgrim  = 1,
			Ari      = 1,
			Erec     = 1,
			Salim    = 1,
			Helias   = 1,
			Drake    = 0,
			Yuki     = 0,
			Kerberos = 1,
			Varg     = 1,
			Mary_de_Mortfichet = 1,
			Kala     = 0,
		};
		EMS.RD.SetRulesByConfig(config);
	elseif ruleset == EMS.L.Std6er then
		-- 6er rules
		local config = 
		{
			-- Units
			Sword = 4,
			Bow = 4,
			PoleArm = 4,
			HeavyCavalry = 0,
			LightCavalry = 0,
			Rifle = 1,
			Thief = 1,
			Scout = 1,
			Cannon1 = 0,
			Cannon2 = 0,
			Cannon3 = 0,
			Cannon4 = 0,
			
			-- Buildings
			Bridge = 1,
			Markets = 0,
			TowerLevel = 0,
			
			Dario    = 1,
			Pilgrim  = 1,
			Ari      = 1,
			Erec     = 1,
			Salim    = 1,
			Helias   = 1,
			Drake    = 1,
			Yuki     = 1,
			Kerberos = 1,
			Varg     = 1,
			Mary_de_Mortfichet = 1,
			Kala     = 1,
		};
		EMS.RD.SetRulesByConfig(config);
	end
end

-- ************************************************************************************************ --
-- *	Resource Level
-- *

EMS.RD.Rules.ResourceLevel = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
function EMS.RD.Rules.ResourceLevel:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize();
	if _value >= 0 then
		self.value = _value;
	end
end

function EMS.RD.Rules.ResourceLevel:GetRepresentative()
	return EMS.L.ResourceLevels[self.value];
end

function EMS.RD.Rules.ResourceLevel:GetTitle()
	return EMS.L.ResourceLevel;
end

function EMS.RD.Rules.ResourceLevel:GetDescription(_id)
	return EMS.L.ResourceLevelDescripion[_id];
end

function EMS.RD.Rules.ResourceLevel:Evaluate()
	EMS.RF.GiveResources(self.value);
	if self.value == 2 then
		EMS.RD.AdditionalConfig.Callback_OnFastGame();
	end
end

-- ************************************************************************************************ --
-- *	GameMode
-- * 

EMS.RD.Rules.GameMode = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
function EMS.RD.Rules.GameMode:SetValue(_value)
	local max = table.getn(EMS.RD.AdditionalConfig.GameModes);
	if _value < 1 then
		_value = max;
	elseif _value > max then
		_value = 1;
	end
	self.value = _value;
end

function EMS.RD.Rules.GameMode:GetRepresentative()
	local rep = EMS.L.Standard;
	if EMS.RD.AdditionalConfig.GameModes[self.value] then
		rep = EMS.RD.AdditionalConfig.GameModes[self.value];
	end
	return "@center " .. rep;
end

function EMS.RD.Rules.GameMode:GetTitle()
	return EMS.L.GameMode;
end

function EMS.RD.Rules.GameMode:GetDescription()
	return EMS.L.GameModeDescripion;
end

function EMS.RD.Rules.GameMode:Evaluate()
	EMS.RF.ActivateGameMode(self.value);
end

-- ************************************************************************************************ --
-- *	Standard Unit Template
-- *

EMS.RD.StdMUnit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
EMS.RD.StdMUnit.maxLevel = 4;
function EMS.RD.StdMUnit:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:HardCustomize();
	if _value >= 0 and _value <= self.maxLevel then
		self.value = _value;
	end
end

function EMS.RD.StdMUnit:GetRepresentative()
	return self.Representatives[self.value];
end

function EMS.RD.StdMUnit:GetDescription()
	if self:GetValue() == 0 then
		return EMS.GV.TooltipHighlightColor1 .. self.GetTitle()
			   .. EMS.GV.TooltipNormalColor1 .. EMS.L.AreCurrently
			   .. EMS.GV.ForbiddenColor .. EMS.L.Forbidden;
	end
	return EMS.GV.TooltipNormalColor1 .. EMS.L.CurrentlyAllowed .. EMS.GV.TooltipHighlightColor1 .. self:GetRepresentative();
end

-- ************************************************************************************************ --
-- *	Sword
-- *

EMS.RD.Rules.Sword = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.Sword.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.Sword[1],
	EMS.L.MU.Sword[2],
	EMS.L.MU.Sword[3],
	EMS.L.MU.Sword[4]
}
function EMS.RD.Rules.Sword:GetTitle()
	return EMS.L.Sword;
end

function EMS.RD.Rules.Sword:Evaluate()
	local utechs = {"MU_LeaderSword", "T_UpgradeSword1", "T_UpgradeSword2", "T_UpgradeSword3"}
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	Bow
-- *

EMS.RD.Rules.Bow = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.Bow.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.Bow[1],
	EMS.L.MU.Bow[2],
	EMS.L.MU.Bow[3],
	EMS.L.MU.Bow[4]
}
function EMS.RD.Rules.Bow:GetTitle()
	return EMS.L.Bow;
end

function EMS.RD.Rules.Bow:Evaluate()
	local utechs = {"MU_LeaderBow",   "T_UpgradeBow1",   "T_UpgradeBow2",   "T_UpgradeBow3"}
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	PoleArm
-- *

EMS.RD.Rules.PoleArm = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.PoleArm.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.PoleArm[1],
	EMS.L.MU.PoleArm[2],
	EMS.L.MU.PoleArm[3],
	EMS.L.MU.PoleArm[4]
}
function EMS.RD.Rules.PoleArm:GetTitle()
	return EMS.L.PoleArm;
end

function EMS.RD.Rules.PoleArm:Evaluate()
	local utechs = {"MU_LeaderSpear",   "T_UpgradeSpear1",   "T_UpgradeSpear2",   "T_UpgradeSpear3"}
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	Heavy Cavalry
-- *

EMS.RD.Rules.HeavyCavalry = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.HeavyCavalry.maxLevel = 2;
EMS.RD.Rules.HeavyCavalry.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.HeavyCavalry[1],
	EMS.L.MU.HeavyCavalry[2]
}
function EMS.RD.Rules.HeavyCavalry:GetTitle()
	return EMS.L.HeavyCavalry;
end

function EMS.RD.Rules.HeavyCavalry:Evaluate()
	local utechs = {"MU_LeaderHeavyCavalry", "T_UpgradeHeavyCavalry1"};
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end


-- ************************************************************************************************ --
-- *	Light Cavalry
-- *

EMS.RD.Rules.LightCavalry = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.LightCavalry.maxLevel = 2;
EMS.RD.Rules.LightCavalry.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.LightCavalry[1],
	EMS.L.MU.LightCavalry[2],
}
function EMS.RD.Rules.LightCavalry:GetTitle()
	return EMS.L.LightCavalry;
end

function EMS.RD.Rules.LightCavalry:Evaluate()
	local utechs = {"MU_LeaderLightCavalry", "T_UpgradeLightCavalry1"};
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end


-- ************************************************************************************************ --
-- *	Rifle
-- *

EMS.RD.Rules.Rifle = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.Rifle.maxLevel = 2;
EMS.RD.Rules.Rifle.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.MU.Rifle[1],
	EMS.L.MU.Rifle[2],
}
function EMS.RD.Rules.Rifle:GetTitle()
	return EMS.L.Rifle;
end

function EMS.RD.Rules.Rifle:Evaluate()
	local utechs = {"MU_LeaderRifle", "T_UpgradeRifle1"};
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end

-- ************************************************************************************************ --
-- *	TowerLevel
-- *
EMS.RD.Rules.TowerLevel = EMS.T.CopyTable(EMS.RD.StdMUnit);
EMS.RD.Rules.TowerLevel.maxLevel = 3;
EMS.RD.Rules.TowerLevel.Representatives = 
{
	[0] = EMS.L.Forbidden,
	EMS.L.TowerLevels[1],
	EMS.L.TowerLevels[2],
	EMS.L.TowerLevels[3]
}

function EMS.RD.Rules.TowerLevel:GetTitle()
	return EMS.L.TowerLevel;
end

function EMS.RD.Rules.TowerLevel:Evaluate()
	local utechs = {"B_Tower", "UP1_Tower", "UP2_Tower"}
	for i = self.maxLevel-1, self.value, -1 do
		for playerId, data in pairs(EMS.PlayerList) do
			ForbidTechnology(Technologies[utechs[i+1]], playerId);
		end
	end
end