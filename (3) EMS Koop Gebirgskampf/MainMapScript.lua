-- Hier kommen meine Funktionen rein, die nach den Regeleinstellungen ausgeführt
-- werden sollen. Sind Regeln fest, dann wird es sofort ausgeführt.



function Debug1()
    Tools.ExploreArea(-1,-1,13000)
    ReplaceEntity("gate_id1", Entities.XD_PalisadeGate2);
    DestroyEntity("barrier1_id6")
        DestroyEntity("barrier2_id6")
        DestroyEntity("barrier3_id6")
        DestroyEntity("barrier4_id6")
        DestroyEntity("barrier5_id6")
        for i=1,23,1 do
            ReplaceEntity("w1_gate"..i, Entities.XD_DarkWallStraightGate);
        end
        for i=1,18,1 do
            ReplaceEntity("x"..i, Entities.XD_DarkWallStraightGate)
        end
        for i=1,3,1 do
            ReplaceEntity("z"..i, Entities.XD_DarkWallStraightGate)
        end
        for i=1,4,1 do
            ReplaceEntity("y"..i, Entities.XD_DarkWallStraightGate)
        end
        for i=1,6,1 do
            ReplaceEntity("boss"..i, Entities.XD_DarkWallStraightGate)
        end
        ReplaceEntity("endfight1", Entities.XD_DarkWallStraightGate)
        ReplaceEntity("endfight2", Entities.XD_DarkWallStraightGate)

        
end

function Debug2()
    DestroyEntity("barrier1_id5")
    DestroyEntity("barrier2_id5")
    DestroyEntity("barrier3_id5")
    DestroyEntity("barrier4_id5")
    DestroyEntity("barrier5_id5")
    DestroyEntity("barrier6_id5")
end


-----------Funktion zum Spielstart

function OnGameStart()


    StartCountdown(1,AnfangsBriefing,false)
    CreateWoodPile( "woodpile1", 1000000 )
    CreateWoodPile( "woodpile2", 1000000 )
    CreateWoodPile( "woodpile3", 1000000 )


    ---Aktiviere Waypoints für army
    StartSimpleJob("WaypointsFunc")

    --Wetteraktivierung
    weatherTimer = 0

    SummerJob = StartSimpleJob("WeatherNormalTimer")
    
    counterCastle = 0;
    diplomacy()
    ReadyPlayer_1 = 0
    ReadyPlayer_2 = 0
    ReadyPlayer_3 = 0

    Logic.SetPlayerPaysLeaderFlag(1, 0)
    Logic.SetPlayerPaysLeaderFlag(2, 0)
    Logic.SetPlayerPaysLeaderFlag(3, 0)

 ----------Schwierigkeitsauswahl------------------------------------------------------
 checkmode = 0;
 TickPeace = StartSimpleJob("TickPeacetime")
 StopPayday1 = StartSimpleJob("ResetGoldTillStart1")
 StopPayday2 = StartSimpleJob("ResetGoldTillStart2")
 StopPayday3 = StartSimpleJob("ResetGoldTillStart3")
 ResourcesCompleted1 = StartSimpleJob("ResourcesPlayer1")
 ResourcesCompleted2 = StartSimpleJob("ResourcesPlayer2")
 ResourcesCompleted3 = StartSimpleJob("ResourcesPlayer3")
 Tribut1()
 Tribut2()
 Tribut3()
    

    --Stadtwachenfix
    GameCallback_OnTechnologyResearchedOriginal = GameCallback_OnTechnologyResearched
    function GameCallback_OnTechnologyResearched( _PlayerID, _TechnologyType )
        GameCallback_OnTechnologyResearchedOriginal( _PlayerID,_TechnologyType)
        if _TechnologyType == Technologies.T_TownGuard then
        Logic.SetTechnologyState(_PlayerID,Technologies.T_CityGuard, 3)
        end
    end
    --


--##################################################################--
--################ Cannon / Serf Heal by P4F #######################--
--##################################################################--

function ComfortsStart()
	SerfTablePlayer1={}
	CannonTablePlayer1={}
	Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED,"","EV_ON_ENTITY_CREATED",1)
	StartSimpleJob("SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player1")
	--
	if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(2) == 1 then
	SerfTablePlayer2={}
	CannonTablePlayer2={}
	StartSimpleJob("SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player2")
	end
    if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(3) == 1 then
        SerfTablePlayer3={}
        CannonTablePlayer3={}
        StartSimpleJob("SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player3")
        end
end

-- Player 1
function SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player1()
	for i = table.getn(SerfTablePlayer1), 1, -1 do
		if IsAlive(SerfTablePlayer1[i]) then
			if GetHealth(SerfTablePlayer1[i]) < 100 then
				SetHealth(SerfTablePlayer1[i], GetHealth(SerfTablePlayer1[i]) + 1 )
			end
		else
			table.remove(SerfTablePlayer1, i)
		end
	end

	for i = table.getn(CannonTablePlayer1), 1, -1 do
		if IsAlive(CannonTablePlayer1[i]) then
			if GetHealth(CannonTablePlayer1[i]) < 100 then
				SetHealth(CannonTablePlayer1[i], GetHealth(CannonTablePlayer1[i]) + 1 )
			end
		else
			table.remove(CannonTablePlayer1, i)
		end
	end
end
-- Player 2
function SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player2()
	for i = table.getn(SerfTablePlayer2), 1, -1 do
		if IsAlive(SerfTablePlayer2[i]) then
			if GetHealth(SerfTablePlayer2[i]) < 100 then
				SetHealth(SerfTablePlayer2[i], GetHealth(SerfTablePlayer2[i]) + 1 )
			end
		else
			table.remove(SerfTablePlayer2, i)
		end
	end

	for i = table.getn(CannonTablePlayer2), 1, -1 do
		if IsAlive(CannonTablePlayer2[i]) then
			if GetHealth(CannonTablePlayer2[i]) < 100 then
				SetHealth(CannonTablePlayer2[i], GetHealth(CannonTablePlayer2[i]) + 1 )
			end
		else
			table.remove(CannonTablePlayer2, i)
		end
	end
end

-- Player 3
function SJ_Refresh_Hp_Of_Serfs_And_Cannons_Player3()
	for i = table.getn(SerfTablePlayer3), 1, -1 do
		if IsAlive(SerfTablePlayer3[i]) then
			if GetHealth(SerfTablePlayer3[i]) < 100 then
				SetHealth(SerfTablePlayer3[i], GetHealth(SerfTablePlayer3[i]) + 1 )
			end
		else
			table.remove(SerfTablePlayer3, i)
		end
	end

	for i = table.getn(CannonTablePlayer3), 1, -1 do
		if IsAlive(CannonTablePlayer3[i]) then
			if GetHealth(CannonTablePlayer3[i]) < 100 then
				SetHealth(CannonTablePlayer3[i], GetHealth(CannonTablePlayer3[i]) + 1 )
			end
		else
			table.remove(CannonTablePlayer3, i)
		end
	end
end

function EV_ON_ENTITY_CREATED()
	local ent_ID = Event.GetEntityID()
	local ent_typ = Logic.GetEntityTypeName(Logic.GetEntityType(ent_ID))
	local ent_P = GetPlayer(ent_ID)
		
	if ent_P == 1 then
		if ent_typ == "PU_Serf" then
		table.insert(SerfTablePlayer1,ent_ID)
		elseif ent_typ == "PV_Cannon1" or ent_typ == "PV_Cannon2" or ent_typ == "PV_Cannon3" or ent_typ == "PV_Cannon4" then
		table.insert(CannonTablePlayer1,ent_ID)
		end
	end

	if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(2) == 1 then
		if ent_P == 2 then
			if ent_typ == "PU_Serf" then
			table.insert(SerfTablePlayer2,ent_ID)
			elseif ent_typ == "PV_Cannon1" or ent_typ == "PV_Cannon2" or ent_typ == "PV_Cannon3" or ent_typ == "PV_Cannon4" then
			table.insert(CannonTablePlayer2,ent_ID)
			end
		end
	end

    if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(3) == 1 then
		if ent_P == 3 then
			if ent_typ == "PU_Serf" then
			table.insert(SerfTablePlayer3,ent_ID)
			elseif ent_typ == "PV_Cannon1" or ent_typ == "PV_Cannon2" or ent_typ == "PV_Cannon3" or ent_typ == "PV_Cannon4" then
			table.insert(CannonTablePlayer3,ent_ID)
			end
		end
	end
end

--##################################################################--
--##################################################################--

function GetHealth( _entity )
    local entityID = GetEntityId( _entity )
    if not Tools.IsEntityAlive( entityID ) then
        return 0
    end
    local MaxHealth = Logic.GetEntityMaxHealth( entityID )
    local Health = Logic.GetEntityHealth( entityID )
    return ( Health / MaxHealth ) * 100
end

--##################################################################--
--##################################################################--



            -- Utility Weatherplant
            GameCallback_OnBuildingConstructionCompleteOld2=GameCallback_OnBuildingConstructionComplete
            function GameCallback_OnBuildingConstructionComplete(_BuildingID2,_PlayerID2)
            GameCallback_OnBuildingConstructionCompleteOld2(_BuildingID2,_PlayerID2)
                if _BuildingID2 == lighthouseID  then
                    StartSimpleHiResJob("SetLighthouse")
                end
                if Logic.GetPlayerEntities(1, Entities.PB_VillageCenter1, 1) == 1 then
                    Logic.SetPlayerPaysLeaderFlag(1, 1)
                    EndJob(StopPayday1)
                end
                if Logic.GetPlayerEntities(2, Entities.PB_VillageCenter1, 1) == 1 then
                    Logic.SetPlayerPaysLeaderFlag(2, 1)
                    EndJob(StopPayday2)
                end
                if Logic.GetPlayerEntities(3, Entities.PB_VillageCenter1, 1) == 1 then
                    Logic.SetPlayerPaysLeaderFlag(3, 1)
                    EndJob(StopPayday3)
                end
            end




    StartSimpleJob("castleCheck");
    StartSimpleJob("DefeatBedingung");
    StartSimpleJob("gateCastle1");
    Logic.AddQuest(1, 1, MAINQUEST_OPEN, "Hauptauftrag", "Willkommen in Mansuri, @cr Ihr habt die Aufgabe, dass Land von allen schaendlichen Gegnern zu befreien und @cr für Gerechtigkeit zu sorgen. @cr @cr Viel Erfolg!", 1)
    Logic.AddQuest(2, 1, MAINQUEST_OPEN, "Hauptauftrag", "Willkommen in Mansuri, @cr Ihr habt die Aufgabe, dass Land von allen schaendlichen Gegnern zu befreien und @cr für Gerechtigkeit zu sorgen. @cr @cr Viel Erfolg!", 1)
    Logic.AddQuest(3, 1, MAINQUEST_OPEN, "Hauptauftrag", "Willkommen in Mansuri, @cr Ihr habt die Aufgabe, dass Land von allen schaendlichen Gegnern zu befreien und @cr für Gerechtigkeit zu sorgen. @cr @cr Viel Erfolg!", 1)



    for i=6,8,1 do
        Logic.SetTechnologyState(i, Technologies.T_LeatherMailArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_ChainMailArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_PlateMailArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_SoftArcherArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_PaddedArcherArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_LeatherArcherArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_MasterOfSmithery, 3)
        Logic.SetTechnologyState(i, Technologies.T_IronCasting, 3)
        Logic.SetTechnologyState(i, Technologies.T_Fletching, 3)
        Logic.SetTechnologyState(i, Technologies.T_BodkinArrow, 3)
        Logic.SetTechnologyState(i, Technologies.T_WoodAging, 3)
        Logic.SetTechnologyState(i, Technologies.T_Turnery, 3)
        Logic.SetTechnologyState(i, Technologies.T_EnhancedGunPowder, 3)
        Logic.SetTechnologyState(i, Technologies.T_BlisteringCannonballs, 3)
        Logic.SetTechnologyState(i, Technologies.T_BetterTrainingBarracks, 3)
        Logic.SetTechnologyState(i, Technologies.T_BetterTrainingArchery, 3)
        Logic.SetTechnologyState(i, Technologies.T_BetterChassis, 3)
        Logic.SetTechnologyState(i, Technologies.T_Masonry, 3)
        Logic.SetTechnologyState(i, Technologies.T_Shoeing, 3)
        Logic.SetTechnologyState(i, Technologies.T_Masonry, 3)
        Logic.SetTechnologyState(i, Technologies.T_FleeceArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_FleeceLinedLeatherArmor, 3)
        Logic.SetTechnologyState(i, Technologies.T_LeadShot, 3)
        Logic.SetTechnologyState(i, Technologies.T_Sights, 3)
    end



    StartSimpleJob("VillageCenterIsBuild_ID1")
    StartSimpleJob("VillageCenterIsBuild_ID2")
    StartSimpleJob("VillageCenterIsBuild_ID3")

end



 function ResourcesPlayer1()
    if CheckMode == 1 and ReadyPlayer_1 == 1 then
        -- Initial Resources
        local InitGoldRaw 		= 1800
        local InitClayRaw 		= 2500
        local InitWoodRaw 		= 2500
        local InitStoneRaw 		= 2000
        local InitIronRaw 		= 450
        local InitSulfurRaw		= 250

        
        --Add Players Resources
        Tools.GiveResouces(1, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted1)
    elseif CheckMode == 2 and ReadyPlayer_1 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 1200
         local InitClayRaw 		= 1500
         local InitWoodRaw 		= 1500
         local InitStoneRaw 	= 1000
         local InitIronRaw 		= 150
         local InitSulfurRaw	= 50
 
         
         --Add Players Resources

        Tools.GiveResouces(1, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted1)
    elseif CheckMode == 3 and ReadyPlayer_1 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 900
         local InitClayRaw 		= 800
         local InitWoodRaw 		= 800
         local InitStoneRaw 	= 800
         local InitIronRaw 		= 0
         local InitSulfurRaw	= 0
 
         
         --Add Players Resources

         Tools.GiveResouces(1, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
         EndJob(ResourcesCompleted1)
    end

 end

 function ResourcesPlayer2()
    if CheckMode == 1 and ReadyPlayer_2 == 1 then
        -- Initial Resources
        local InitGoldRaw 		= 1800
        local InitClayRaw 		= 2500
        local InitWoodRaw 		= 2500
        local InitStoneRaw 		= 2000
        local InitIronRaw 		= 450
        local InitSulfurRaw		= 250

        
        --Add Players Resources
        Tools.GiveResouces(2, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted2)
    elseif CheckMode == 2 and ReadyPlayer_2 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 1200
         local InitClayRaw 		= 1500
         local InitWoodRaw 		= 1500
         local InitStoneRaw 	= 1000
         local InitIronRaw 		= 150
         local InitSulfurRaw	= 50
 
         
         --Add Players Resources

        Tools.GiveResouces(2, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted2)
    elseif CheckMode == 3 and ReadyPlayer_2 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 900
         local InitClayRaw 		= 800
         local InitWoodRaw 		= 800
         local InitStoneRaw 	= 800
         local InitIronRaw 		= 0
         local InitSulfurRaw	= 0
 
         
         --Add Players Resources

         Tools.GiveResouces(2, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
         EndJob(ResourcesCompleted2)
    end

 end


 function ResourcesPlayer3()
    if CheckMode == 1 and ReadyPlayer_3 == 1 then
        -- Initial Resources
        local InitGoldRaw 		= 1800
        local InitClayRaw 		= 2500
        local InitWoodRaw 		= 2500
        local InitStoneRaw 		= 2000
        local InitIronRaw 		= 450
        local InitSulfurRaw		= 250

        
        --Add Players Resources
        Tools.GiveResouces(3, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted3)
    elseif CheckMode == 2 and ReadyPlayer_3 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 1200
         local InitClayRaw 		= 1500
         local InitWoodRaw 		= 1500
         local InitStoneRaw 	= 1000
         local InitIronRaw 		= 150
         local InitSulfurRaw	= 50
 
         
         --Add Players Resources

        Tools.GiveResouces(3, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
        EndJob(ResourcesCompleted3)
    elseif CheckMode == 3 and ReadyPlayer_3 == 1 then
         -- Initial Resources
         local InitGoldRaw 		= 900
         local InitClayRaw 		= 800
         local InitWoodRaw 		= 800
         local InitStoneRaw 	= 800
         local InitIronRaw 		= 0
         local InitSulfurRaw	= 0
 
         
         --Add Players Resources

         Tools.GiveResouces(3, InitGoldRaw , InitClayRaw,InitWoodRaw, InitStoneRaw,InitIronRaw,InitSulfurRaw)
         EndJob(ResourcesCompleted3)
    end

 end



 function TickPeacetime()
    EMS.T.StopCountdown(Peacetime)
 end

 function ResetGoldTillStart1()
    if CheckMode == 0 then
        gold1 = Logic.GetPlayersGlobalResource(1, ResourceType.GoldRaw)
        Logic.SubFromPlayersGlobalResource(1, ResourceType.Gold, gold1)
    end
end

function ResetGoldTillStart2()
    if CheckMode == 0 then
        gold2 = Logic.GetPlayersGlobalResource(2, ResourceType.GoldRaw)
        Logic.SubFromPlayersGlobalResource(2, ResourceType.Gold, gold2)
    end
end

function ResetGoldTillStart3()
    if CheckMode == 0 then
        gold3 = Logic.GetPlayersGlobalResource(3, ResourceType.GoldRaw)
        Logic.SubFromPlayersGlobalResource(3, ResourceType.Gold, gold3)
    end
end

---------------------------------Schwierigkeiten

---Easy
function Tribut1()
    local TrMod1 =  {}
    TrMod1.pId = 1
    TrMod1.text = "Spielmodus @color:57,245,26 <<Kooperation/Leicht>>! "
    TrMod1.cost = { Gold = 0 }
    TrMod1.Callback = Mode1
    TMod1 = AddTribute(TrMod1)
end

function Mode1()

      --------Starttruppen Spieler 1  
  
 
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp1_id1"),"help1_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp2_id1"),"help2_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp3_id1"),"help3_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp4_id1"),"help4_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp1_id1"),"help5_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp2_id1"),"help6_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp3_id1"),"help7_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp4_id1"),"help8_id1")
      CreateMilitaryGroup(1,Entities.PU_Serf,0,GetPosition("start_trupp5_id1"),"serf_id1")
      ForbidTechnology( Technologies.B_Village, 1 )
      ForbidTechnology( Technologies.B_Residence, 1 )
      ForbidTechnology( Technologies.B_Farm, 1 )
      ForbidTechnology( Technologies.B_University, 1 )
      ForbidTechnology( Technologies.B_Claymine, 1 )
      ForbidTechnology( Technologies.B_PowerPlant, 1 )
      
  
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp1_id2"),"help1_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp2_id2"),"help2_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp3_id2"),"help3_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp4_id2"),"help4_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp1_id2"),"help5_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp2_id2"),"help6_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp3_id2"),"help7_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp4_id2"),"help8_id2")
      CreateMilitaryGroup(2,Entities.PU_Serf,0,GetPosition("start_trupp5_id2"),"serf_id2")
      ForbidTechnology( Technologies.B_Village, 2 )
      ForbidTechnology( Technologies.B_Residence, 2 )
      ForbidTechnology( Technologies.B_Farm, 2 )
      ForbidTechnology( Technologies.B_University, 2 )
      ForbidTechnology( Technologies.B_Claymine, 2 )
      ForbidTechnology( Technologies.B_PowerPlant, 2 )
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp1_id3"),"help1_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp2_id3"),"help2_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp3_id3"),"help3_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp4_id3"),"help4_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp1_id3"),"help5_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp2_id3"),"help6_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp3_id3"),"help7_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp4_id3"),"help8_id3")
      CreateMilitaryGroup(3,Entities.PU_Serf,0,GetPosition("start_trupp5_id3"),"serf_id3")
      ForbidTechnology( Technologies.B_Village, 3 )
      ForbidTechnology( Technologies.B_Residence, 3 )
      ForbidTechnology( Technologies.B_Farm, 3 )
      ForbidTechnology( Technologies.B_University, 3 )
      ForbidTechnology( Technologies.B_Claymine, 3 )
      ForbidTechnology( Technologies.B_PowerPlant, 3 )

      serfCheck = StartSimpleJob("StartSerfCheck");

    CheckMode = 1
    Message("Schwierigkeit: @color:57,245,26 LEICHT @color:255,255,255 wurde gewaehlt!")
    Logic.RemoveTribute(1,TMod1)
    Logic.RemoveTribute(1,TMod2)
    Logic.RemoveTribute(1,TMod3)
    GUIAction_ToggleMenu( gvGUI_WidgetID.TradeWindow,0)
    nv_helper = 12
    ActivateBandits()
    
    StartSimpleJob("StopBandit1")
    StartSimpleJob("StopBandit2")
    StartSimpleJob("StopBandit3")
    StartSimpleJob("StopBandit4")


   EndJob(TickPeace)
   EMS.T.SetPeacetime(90*60 )
end


---Normal
function Tribut2()
    local TrMod2 =  {}
    TrMod2.pId = 1
    TrMod2.text = "Spielmodus @color:255,136,0 <<Kooperation/Normal>>! "
    TrMod2.cost = { Gold = 0 }
    TrMod2.Callback = Mode2
    TMod2 = AddTribute(TrMod2)
end

function Mode2()

      --------Starttruppen Spieler 1  
  
 
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp1_id1"),"help1_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp2_id1"),"help2_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp3_id1"),"help3_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp4_id1"),"help4_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp1_id1"),"help5_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp2_id1"),"help6_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp3_id1"),"help7_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp4_id1"),"help8_id1")
      CreateMilitaryGroup(1,Entities.PU_Serf,0,GetPosition("start_trupp5_id1"),"serf_id1")
      ForbidTechnology( Technologies.B_Village, 1 )
      ForbidTechnology( Technologies.B_Residence, 1 )
      ForbidTechnology( Technologies.B_Farm, 1 )
      ForbidTechnology( Technologies.B_University, 1 )
      ForbidTechnology( Technologies.B_Claymine, 1 )
      ForbidTechnology( Technologies.B_PowerPlant, 1 )
      
  
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp1_id2"),"help1_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp2_id2"),"help2_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp3_id2"),"help3_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp4_id2"),"help4_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp1_id2"),"help5_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp2_id2"),"help6_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp3_id2"),"help7_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp4_id2"),"help8_id2")
      CreateMilitaryGroup(2,Entities.PU_Serf,0,GetPosition("start_trupp5_id2"),"serf_id2")
      ForbidTechnology( Technologies.B_Village, 2 )
      ForbidTechnology( Technologies.B_Residence, 2 )
      ForbidTechnology( Technologies.B_Farm, 2 )
      ForbidTechnology( Technologies.B_University, 2 )
      ForbidTechnology( Technologies.B_Claymine, 2 )
      ForbidTechnology( Technologies.B_PowerPlant, 2 )
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp1_id3"),"help1_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp2_id3"),"help2_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp3_id3"),"help3_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp4_id3"),"help4_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp1_id3"),"help5_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp2_id3"),"help6_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp3_id3"),"help7_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp4_id3"),"help8_id3")
      CreateMilitaryGroup(3,Entities.PU_Serf,0,GetPosition("start_trupp5_id3"),"serf_id3")
      ForbidTechnology( Technologies.B_Village, 3 )
      ForbidTechnology( Technologies.B_Residence, 3 )
      ForbidTechnology( Technologies.B_Farm, 3 )
      ForbidTechnology( Technologies.B_University, 3 )
      ForbidTechnology( Technologies.B_Claymine, 3 )
      ForbidTechnology( Technologies.B_PowerPlant, 3 )

      serfCheck = StartSimpleJob("StartSerfCheck");
    nv_helper = math.random(10, 12)
    CheckMode = 2
    Message("Schwierigkeit: @color:255,136,0 NORMAL @color:255,255,255 wurde gewaehlt!")
    Logic.RemoveTribute(1,TMod1)
    Logic.RemoveTribute(1,TMod2)
    Logic.RemoveTribute(1,TMod3)
    GUIAction_ToggleMenu( gvGUI_WidgetID.TradeWindow,0)

    ActivateBandits() 

    StartSimpleJob("StopBandit1")
    StartSimpleJob("StopBandit2")
    StartSimpleJob("StopBandit3")
    StartSimpleJob("StopBandit4")


   EndJob(TickPeace)
   EMS.T.SetPeacetime(70*60 )
end

---Hard
function Tribut3()
    local TrMod3 =  {}
    TrMod3.pId = 1
    TrMod3.text = "Spielmodus @color:255,0,0 <<Kooperation/Schwer>>! "
    TrMod3.cost = { Gold = 0 }
    TrMod3.Callback = Mode3
    TMod3 = AddTribute(TrMod3)
end

function Mode3()

      --------Starttruppen Spieler 1  
  
 
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp1_id1"),"help1_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp2_id1"),"help2_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp3_id1"),"help3_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword3,8,GetPosition("start_trupp4_id1"),"help4_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp1_id1"),"help5_id1")
      CreateMilitaryGroup(1,Entities.PU_LeaderSword4,8,GetPosition("start_trupp2_id1"),"help6_id1")
      CreateMilitaryGroup(1,Entities.PU_Serf,0,GetPosition("start_trupp5_id1"),"serf_id1")
      ForbidTechnology( Technologies.B_Village, 1 )
      ForbidTechnology( Technologies.B_Residence, 1 )
      ForbidTechnology( Technologies.B_Farm, 1 )
      ForbidTechnology( Technologies.B_University, 1 )
      ForbidTechnology( Technologies.B_Claymine, 1 )
      ForbidTechnology( Technologies.B_PowerPlant, 1 )
      
  
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp1_id2"),"help1_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp2_id2"),"help2_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp3_id2"),"help3_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow3,8,GetPosition("start_trupp4_id2"),"help4_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp1_id2"),"help5_id2")
      CreateMilitaryGroup(2,Entities.PU_LeaderBow4,8,GetPosition("start_trupp2_id2"),"help6_id2")
      CreateMilitaryGroup(2,Entities.PU_Serf,0,GetPosition("start_trupp5_id2"),"serf_id2")
      ForbidTechnology( Technologies.B_Village, 2 )
      ForbidTechnology( Technologies.B_Residence, 2 )
      ForbidTechnology( Technologies.B_Farm, 2 )
      ForbidTechnology( Technologies.B_University, 2 )
      ForbidTechnology( Technologies.B_Claymine, 2 )
      ForbidTechnology( Technologies.B_PowerPlant, 2 )
  
  
      --------Starttruppen Spieler 2  
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp1_id3"),"help1_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp2_id3"),"help2_id3")
      CreateMilitaryGroup(3,Entities.PV_Cannon3,0,GetPosition("start_trupp3_id3"),"help3_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp1_id3"),"help5_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp2_id3"),"help6_id3")
      CreateMilitaryGroup(3,Entities.PU_LeaderRifle1,4,GetPosition("start_trupp3_id3"),"help7_id3")
      CreateMilitaryGroup(3,Entities.PU_Serf,0,GetPosition("start_trupp5_id3"),"serf_id3")
      ForbidTechnology( Technologies.B_Village, 3 )
      ForbidTechnology( Technologies.B_Residence, 3 )
      ForbidTechnology( Technologies.B_Farm, 3 )
      ForbidTechnology( Technologies.B_University, 3 )
      ForbidTechnology( Technologies.B_Claymine, 3 )
      ForbidTechnology( Technologies.B_PowerPlant, 3 )

      serfCheck = StartSimpleJob("StartSerfCheck");
    nv_helper = math.random(8, 12)
    CheckMode = 3
    Message("Schwierigkeit: @color:255,0,06 SCHWER @color:255,255,255 wurde gewaehlt!")
    Logic.RemoveTribute(1,TMod1)
    Logic.RemoveTribute(1,TMod2)
    Logic.RemoveTribute(1,TMod3)
    GUIAction_ToggleMenu( gvGUI_WidgetID.TradeWindow,0)
    ActivateBandits() 

    StartSimpleJob("StopBandit1")
    StartSimpleJob("StopBandit2")
    StartSimpleJob("StopBandit3")
    StartSimpleJob("StopBandit4")

    
   EndJob(TickPeace)
   EMS.T.SetPeacetime(55*60 )
end



-- Hier kommen die Funktionen rein, die nach Ende der Friedenszeit ausgeführt
-- werden sollen. Gibt es keine Friedenszeit wird es sofort ausgeführt, sobald
-- die Regeln eingestellt wurden.
function OnPeacetimeOver()
    LocalMusic.UseSet =DARKMOORMUSIC;
    LocalMusic.SetLength = 0;
    DestroyEntity("barrier1_id5")
    DestroyEntity("barrier2_id5")
    DestroyEntity("barrier3_id5")
    DestroyEntity("barrier4_id5")
    DestroyEntity("barrier5_id5")
    DestroyEntity("barrier6_id5")
    ActivateFogWarriors()
    Message("Das Nebelvolk wird ab jetzt angreifen");
   StartSimpleJob("wave1barriers")
   Logic.AddQuest(1, 2, MAINQUEST_OPEN, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
   Logic.AddQuest(2, 2, MAINQUEST_OPEN, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
   Logic.AddQuest(3, 2, MAINQUEST_OPEN, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
end

---------------------------------------Weather-----------------------------------

function WeatherNormalTimer()
    if weatherTimer == 0 then
        AddSummer(4*60)
    elseif weatherTimer == 240 then
        AddTransitionSunrise(60)
    elseif weatherTimer == 300 then
        AddSunrise(60)
    elseif weatherTimer == 360 then
        AddNight(4*60)
    elseif weatherTimer == 600 then
        AddSunrise(60)
    elseif weatherTimer == 660 then
        AddTransitionSunrise(60);
    elseif weatherTimer == 720 then
        AddRain(4*60)
    elseif weatherTimer == 960 then
        AddTransitionSunriseRain(60);
    elseif weatherTimer == 1020 then
        AddSunriseRain(60)
    elseif weatherTimer == 1080 then
        AddNightRain(4*60)
    elseif weatherTimer == 1320 then
        AddSunriseRain(60)
    elseif weatherTimer == 1380 then
        AddTransitionSunriseRain(60)
    elseif weatherTimer == 1440 then
        AddSummer(4*60)
    elseif weatherTimer == 1680 then
        AddTransitionSunrise(60)
    elseif weatherTimer == 1740 then
        AddSunrise(60)
    elseif weatherTimer == 1800 then
        AddNight(4*60)
    elseif weatherTimer == 2040 then
        AddSunrise(60)
    elseif weatherTimer == 2100 then
        AddTransitionSunrise(60);
    elseif weatherTimer == 2160 then
        weatherTimer = -1
    end
    weatherTimer = weatherTimer +1;
end


------------------------General Setup--------------------------------------------------------------------
function diplomacy()
    SetHostile( 1, 5 )
    SetHostile( 1, 6 )
    SetHostile( 1, 7 )
    SetHostile( 1, 8 )

    SetHostile( 2, 5 )
    SetHostile( 2, 6 )
    SetHostile( 2, 7 )
    SetHostile( 2, 8 )

    SetHostile( 3, 5 )
    SetHostile( 3, 6 )
    SetHostile( 3, 7 )
    SetHostile( 3, 8 ) 

    SetNeutral( 1, 4 )
    SetNeutral( 2, 4 )
    SetNeutral( 3, 4 )

    SetFriendly( 1, 2 )
    SetFriendly( 1, 3 )
    SetFriendly( 2, 3 )
end
---------------------------------------------------------------------------------------------------------



------------------------Defeat---------------------------------------------------------------------------
function DefeatBedingung()
        if not IsExisting("burg_id1") or not IsExisting("burg_id2") or not IsExisting("burg_id3") then
           Logic.PlayerSetGameStateToLost(1);
           Logic.PlayerSetGameStateToLost(2);
           Logic.PlayerSetGameStateToLost(3);
           return true;
        end
end


function StartSerfCheck()
    if IsDead("serf_id1") or IsDead("serf_id2")  or IsDead("serf_id3") then
        Logic.PlayerSetGameStateToLost(1);
        Logic.PlayerSetGameStateToLost(2);
        Logic.PlayerSetGameStateToLost(3);
        return true;
    end
end
---------------------------------------------------------------------------------------------------------



-----------------------------------------GateToCastle1-----------------------------------------------------

function gateCastle1()
    if IsDestroyed("tower2_id5") then
        ReplaceEntity("gate_id1", Entities.XD_PalisadeGate2);
        return true;
    end
end

------------------------------------------------------------------------------------------------------------







----------------Burg-Einnahme----------------------------------------------------------------------------

function castleCheck()
    for k,v in pairs (GetActivePlayers()) do
        if IsNear("serf_id"..v, "burg_id"..v, 1500) and Logic.EntityGetPlayer(GetID("burg_id"..v)) ~= v then
            ChangePlayer("burg_id"..v,v);
            AllowTechnology( Technologies.B_Village, v );
            AllowTechnology( Technologies.B_Residence, v )
            AllowTechnology( Technologies.B_Farm, v )
            AllowTechnology( Technologies.B_University, v )
            AllowTechnology( Technologies.B_Claymine, v )
            _G["ReadyPlayer_"..v] = 1
            counterCastle = counterCastle+1;
            if counterCastle == table.getn(GetActivePlayers()) then
                EndJob(serfCheck);
                return true;
            end
        end
    end
    return false;
end


-----------------------------------------------------------------------------------------------------------




----------------------------------------Nebelvolk----------------------------------------------------------
nv_counter = 0

function NVBuildingCheck0()
    if IsDestroyed("burg_id5") then
        nv_counter = nv_counter +1
        return true;
    end
end
StartSimpleJob("NVBuildingCheck0")

for i=1,12,1 do
    local j = i
    _G["NVBuildingCheck"..j] = function()
        if IsDestroyed("nebel"..j.."_id5") then
            nv_counter = nv_counter +1
            return true;
        end
    end
end

for i=1,12,1 do
    StartSimpleJob("NVBuildingCheck"..i)
end



function wave1barriers()

        if nv_counter == nv_helper then
        ------Aktivierung Welle1

        DestroyEntity("barrier1_id6")
        DestroyEntity("barrier2_id6")
        DestroyEntity("barrier3_id6")
        DestroyEntity("barrier4_id6")
        DestroyEntity("barrier5_id6")
        Message("Die grossen Herrscher von Mansuri sind auf euch Aufmerksam geworden und greifen nun an!")
        
        LocalMusic.UseSet =EVELANCEMUSIC;
        LocalMusic.SetLength = 0;

        Logic.AddQuest(1, 2, MAINQUEST_CLOSED, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
        Logic.AddQuest(2, 2, MAINQUEST_CLOSED, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
        Logic.AddQuest(3, 2, MAINQUEST_CLOSED, "Das Nebelvolk", "Gut gemacht meine Mitstreiter, @cr Ihr habt es geschafft florierende Burgen zu errichten. Ab sofort greift jedoch das Nebelvolk an. Besiegt es @cr um den Sumpf zu passieren und die Belagerer @cr von Mansuri zu beseitigen. ", 1)
        ActivateArmyId6()
        ActivateArmyId7()
        ActivateArmyId8()
        Logic.AddQuest(1, 3, MAINQUEST_OPEN, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)
        Logic.AddQuest(2, 3, MAINQUEST_OPEN, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)
        Logic.AddQuest(3, 3, MAINQUEST_OPEN, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)
        lighthouseID = GetID("weatherchange");
        StartSnow()

        ------ Preset Welle2
        StartSimpleJob("wave2_openGates");
        return true;
    end



end

--------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------Wetterwechsel/ Wettermaschine-----------------------------------------------
function StartSnow()
    EndJob(SummerJob)
    snowTimer = 0
    SnowJob = StartSimpleJob("WeatherSnowTimer")
    if not checkWeatherMachine then
        checkWeatherMachine = StartSimpleJob("WeatherPlant")
    end
end

function WeatherSnowTimer()
    --Schneetagezyklus

    if snowTimer == 0 then
        AddSnow(4*60)
    elseif snowTimer == 240 then
        AddTransitionSunriseSnow(60)
    elseif snowTimer == 300 then
        AddSunriseSnow(60)
    elseif snowTimer == 360 then
        AddNightSnow(4*60)
    elseif snowTimer == 600 then
        AddSunriseSnow(60)
    elseif snowTimer == 660 then
        AddTransitionSunriseSnow(60)
    elseif snowTimer == 720 then
        snowTimer = -1
    end
    snowTimer = snowTimer +1
end

function WeatherPlant()
    if IsDestroyed(lighthouseID) then
    EndJob(SnowJob)
    weatherTimer = 0
    SummerJob = StartSimpleJob("WeatherNormalTimer")
    StartSimpleJob("BuildWeatherPlant");
    return true;
    end

end



function BuildWeatherPlant()
    if Counter.Tick2("SerfsSleep", 6*60) then
    Logic.CreateConstructionSite(13900, 50300, 0, Entities.PB_Residence1, 8);
    _,lighthouseID = Logic.GetEntitiesInArea(Entities.PB_Residence, 13900, 50300, 200, 2)
    Logic.SetModelAndAnimSet(lighthouseID ,Models.PB_Weathermachine,nil);
    StartSimpleJob("WeatherPlant")
    return true;
    end
    return false;
end

function SetLighthouse()
    lighthouseID = ReplaceEntity(lighthouseID,Entities.PB_Weathermachine);
    StartSnow()
    return true;
end
------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------Welle1-besiegt------------------------------------------------------------

function wave2_openGates()

    if IsDestroyed("villagecenter1_id8") 
    and IsDestroyed("outpost1_id8")
    and IsDestroyed("tower1_id8")
    and IsDestroyed("tower2_id8")
    and IsDestroyed("villagecenter1_id7") 
    and IsDestroyed("outpost1_id7")
    and IsDestroyed("tower1_id7")
    and IsDestroyed("tower2_id7")
    and IsDestroyed("villagecenter1_id6") 
    and IsDestroyed("outpost1_id6")
    and IsDestroyed("tower1_id6")
    and IsDestroyed("tower2_id6") then

        Logic.AddQuest(1, 3, MAINQUEST_CLOSED, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)
        Logic.AddQuest(2, 3, MAINQUEST_CLOSED, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)
        Logic.AddQuest(3, 3, MAINQUEST_CLOSED, "Welle 1", "Hier bin ich wieder, @cr Ihr habt es weit gebracht meine Freunde und steht nun vor der Toren der Belagerer von Mansuri. @cr Bereitet euch auf einen starken Angriff vor. @cr @cr @cr @cr Tipp: Passt auf den Winter auf. Einer der Herzoge missbraucht das Wetter.", 1)

        Logic.AddQuest(1, 4, MAINQUEST_OPEN,"Welle 2", "Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)
        Logic.AddQuest(2, 4, MAINQUEST_OPEN, "Welle 2","Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)
        Logic.AddQuest(3, 4, MAINQUEST_OPEN, "Welle 2","Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)        
        
        --Aktivierung der Armeen: Welle 2

        ActivateArmyId6_Wave2()
        ActivateArmyId7_Wave2()
        ActivateArmyId8_Wave2()

        --Öffnung zu Wave 2
        for i=1,23,1 do
            ReplaceEntity("w1_gate"..i, Entities.XD_DarkWallStraightGate);
        end



        ChangePlayer("barracks2_id6",6)
        ChangePlayer("stable2_id6",6)
        ChangePlayer("archery2_id6",6)
        ChangePlayer("barracks2_id7",7)
        ChangePlayer("foundry3_id7",7)
        ChangePlayer("archery2_id7",7)
        ChangePlayer("foundry2_id7",7)
        ChangePlayer("barracks2_id8",8)
        --Job für Triggern von Welle 3

        StartSimpleJob("ActivateWave3")
        return true;
    end

end

---------------------------------------------------Wave 3------------------------------------------------------------------------------

function ActivateWave3()

    if IsDead("archery2_id6") 
    and IsDead("stable2_id6")
    and IsDead("stable3_id6") 
    and IsDead("stable4_id6")
    and IsDead("barracks2_id6")
    and IsDead("barracks2_id7")
    and IsDead("foundry2_id7")
    and IsDead("foundry3_id7")
    and IsDead("archery2_id7")
    and IsDead("archery2_id8")
    and IsDead("foundry2_id8")
    and IsDead("foundry3_id8")
    and IsDead("barracks2_id8")
    then

        Logic.AddQuest(1, 4, MAINQUEST_CLOSED, "Welle 2","Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)
        Logic.AddQuest(2, 4, MAINQUEST_CLOSED, "Welle 2","Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)
        Logic.AddQuest(3, 4, MAINQUEST_CLOSED, "Welle 2","Und da bin ich wieder! @cr Ihr habt erfolgreich Welle 1 zurueckgeschlagen und den ersten Ring der Schalatane eingenommen. @cr Kundschafter berichten, dass die Herrscher von Mansuri garnich ueber euren Fortschritt @cr erfreut sind und schicken aus den Vorbezirken neue Horden los. @cr Schlagt diese ebenfalls zurueck!", 1)

        Logic.AddQuest(1, 5, MAINQUEST_OPEN,"Welle 3", "Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)
        Logic.AddQuest(2, 5, MAINQUEST_OPEN, "Welle 3","Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)
        Logic.AddQuest(3, 5, MAINQUEST_OPEN,"Welle 3 ", "Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)

        for i=1,18,1 do
            ReplaceEntity("x"..i, Entities.XD_DarkWallStraightGate)
        end
        



        ChangePlayer("b1_id7",7)
        ChangePlayer("f1_id7",7)
        ChangePlayer("c1_id7",7)
        ChangePlayer("s1_id8",8)
        ChangePlayer("s2_id8",8)
        ChangePlayer("b1_id8",8)
        ChangePlayer("c1_id8",8)
        ChangePlayer("a1_id8",8)
        ChangePlayer("f1_id8",8)


        --Aktivierung Welle 3

       
        ActivateArmyId7_Wave3()
        ActivateArmyId8_Wave3()
        --Trigger für Welle 4

        StartSimpleJob("ActivateWave4_Id7")
        StartSimpleJob("ActivateWave4_Id8")
        StartSimpleJob("ActivateWave4_Id6")
        return true;
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------Wave 4--------------------------------------------------------------------------------------------------

function ActivateWave4_Id7()
    if IsDead("f1_id7") 
    and IsDead("f2_id7")
    and IsDead("c1_id7")
    and IsDead("b1_id7")
    and IsDead("a1_id7") then
        
        for i=1,3,1 do
            ReplaceEntity("z"..i, Entities.XD_DarkWallStraightGate)
        end

        ActivateArmyId7_Wave4()

        ChangePlayer("t1_id7",7)
        ChangePlayer("end_s1_id7",7)
        ChangePlayer("end_t1_id7",7)


        Message("Die Unterburg vom Herzog der Herrlichkeit wurde zerstoert!")
        Message("Der Weg zur Burg ist frei!")
    return true;
    end


end

function ActivateWave4_Id8()
    if IsDead("f1_id8") 
    and IsDead("s1_id8")
    and IsDead("s2_id8")
    and IsDead("c1_id8")
    and IsDead("b1_id8")
    and IsDead("a1_id8") then
        
        for i=1,4,1 do
            ReplaceEntity("y"..i, Entities.XD_DarkWallStraightGate)
        end

        ActivateArmyId8_Wave4()

        ChangePlayer("end_t1_id8",8)
        ChangePlayer("end_b1_id8",8)

        Message("Die Unterburg vom Herzog der Gerechtigkeit wurde zerstoert!")
        Message("Der Weg zur Burg ist frei!")
    return true;
    end


end

--------------------------------------------------------------Endschlacht---------------------------------------------------------------------------------------------


function ActivateWave4_Id6()
    if IsDead("burg_id8")
    and IsDead("burg_id7")
    and IsDead("end_a1_id8")
    and IsDead("end_t1_id7") then

        --Wave 3 von KI 6
        ActivateArmyId6_Wave3()
        
        for i=1,6,1 do
            ReplaceEntity("boss"..i, Entities.XD_DarkWallStraightGate)
        end
        ChangePlayer("b1_id6", 6)
        ChangePlayer("f1_id6", 6)

        Logic.AddQuest(1, 5, MAINQUEST_CLOSED, "Welle 3","Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)
        Logic.AddQuest(2, 5, MAINQUEST_CLOSED, "Welle 3","Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)
        Logic.AddQuest(3, 5, MAINQUEST_CLOSED, "Welle 3","Guten Tag meine Herren, @cr wir haben es geschafft die Vorburgen komplett zu vernichten. @cr Unsere naechsten Ziele sind die Unterburgen der Belagere von Mansuri. @cr @cr @cr Info: @cr Nun ist es abhaenging von euren Angriffen, wie sich der Gegner verhaelt: @cr 1) Die Tore zu Hauptburg von den Gegnern oeffnen sich dann, wenn ihr deren militaerische Gebaeude zerstoert habt. @cr 2) Zugang zum letzten und staerksten Belagerer von Mansuri erhaltet ihr durch das zerstoeren der Hauptburgen der anderen beiden Herrschern.", 1)
   
        Logic.AddQuest(1, 6, MAINQUEST_OPEN,"Finale", "Heureka, @cr Ihr habt es geschafft die Burgen von Herzog Herrlichkeit und Herzog Gerechtigkeit zu zerstoeren. Jetzt bleibt nurnoch der Herzog der Schrechklichkeit ueber. @cr @cr @cr @cr Tipp: Es wird giftig.", 1)
        Logic.AddQuest(2, 6, MAINQUEST_OPEN, "Finale","Heureka, @cr Ihr habt es geschafft die Burgen von Herzog Herrlichkeit und Herzog Gerechtigkeit zu zerstoeren. Jetzt bleibt nurnoch der Herzog der Schrechklichkeit ueber. @cr @cr @cr @cr Tipp: Es wird giftig.", 1)
        Logic.AddQuest(3, 6, MAINQUEST_OPEN, "Finale","Heureka, @cr Ihr habt es geschafft die Burgen von Herzog Herrlichkeit und Herzog Gerechtigkeit zu zerstoeren. Jetzt bleibt nurnoch der Herzog der Schrechklichkeit ueber. @cr @cr @cr @cr Tipp: Es wird giftig.", 1)


        StartSimpleJob("Finale")

        return true;
    end

end


function Finale()
    if IsDead("c1_id6")
    and IsDead("t1_id6")
    and IsDead("t2_id6")
    and IsDead("a1_id6")
    and IsDead("b1_id6") 
    and IsDead("f1_id6")then

    ReplaceEntity("endfight1", Entities.XD_DarkWallStraightGate)
    ReplaceEntity("endfight2", Entities.XD_DarkWallStraightGate)


    ActivateArmyId6_Wave4()



    ChangePlayer("end_f2_id6",6)
    ChangePlayer("end_f1_id6",6)
    ChangePlayer("end_s1_id6",6)

    Message("Beissender Geruch steigt euch in die Nase!")
    StartSimpleJob("Sieg")
    return true;
    end

end



function Sieg()
    if IsDead("burg_id6")
    and IsDead("end_a1_id6")
    and IsDead("end_a2_id6")
    and IsDead("end_b1_id6")
    and IsDead("end_b2_id6") 
    and IsDead("end_f1_id6")
    and IsDead("end_f2_id6")
    and IsDead("end_t1_id6") 
    and IsDead("end_s1_id6")
    then

        Logic.PlayerSetGameStateToWon(1)
        Logic.PlayerSetGameStateToWon(2)
        Logic.PlayerSetGameStateToWon(3)

    return true;
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------













function GetActivePlayers()
    local Players = {};
    if XNetwork.Manager_DoesExist() == 1 then
        -- TODO: Does that fix everything for Community Server?
        for i= 1, table.getn(Score.Player), 1 do
            if Logic.PlayerGetGameState(i) == 1 then
                table.insert(Players, i);
            end
        end
    else
        table.insert(Players, GUI.GetPlayerID());
    end
    return Players;
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


------------------------------------------Schmelings Stuff-----------------------------------------------------------------------



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

--------------------------------------------------------------------------------------------------------------------------------------