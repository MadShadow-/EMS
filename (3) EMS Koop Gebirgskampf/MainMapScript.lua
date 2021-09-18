-- Hier kommen meine Funktionen rein, die nach den Regeleinstellungen ausgeführt
-- werden sollen. Sind Regeln fest, dann wird es sofort ausgeführt.
function OnGameStart()

    StartCountdown(1,AnfangsBriefing,false)
    CreateWoodPile( "woodpile1", 1000000 )
    CreateWoodPile( "woodpile2", 1000000 )
    CreateWoodPile( "woodpile3", 1000000 )


    counterCastle = 0;
    diplomacy()
    ActivateBandits()     
  
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



            -- Utility Weatherplant
            GameCallback_OnBuildingConstructionCompleteOld2=GameCallback_OnBuildingConstructionComplete
            function GameCallback_OnBuildingConstructionComplete(_BuildingID2,_PlayerID2)
            GameCallback_OnBuildingConstructionCompleteOld2(_BuildingID2,_PlayerID2)
            if _BuildingID2 == lighthouseID  then
                StartSimpleHiResJob("SetLighthouse")
                
            end
            end




    serfCheck = StartSimpleJob("StartSerfCheck");
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
            Logic.AddToPlayersGlobalResource(v, ResourceType.Gold, 1500)
            Logic.AddToPlayersGlobalResource(v, ResourceType.Clay, 1500)
            Logic.AddToPlayersGlobalResource(v, ResourceType.Wood, 1500)
            Logic.AddToPlayersGlobalResource(v, ResourceType.Stone, 800)
            Logic.AddToPlayersGlobalResource(v, ResourceType.Iron, 150)
            Logic.AddToPlayersGlobalResource(v, ResourceType.Sulfur, 150)
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

function wave1barriers()
    if IsDestroyed("burg_id5") 
    and IsDestroyed("nebel1_id5")
    and IsDestroyed("nebel2_id5")
    and IsDestroyed("nebel3_id5")
    and IsDestroyed("nebel4_id5")
    and IsDestroyed("nebel5_id5")
    and IsDestroyed("nebel6_id5")
    and IsDestroyed("nebel7_id5")
    and IsDestroyed("nebel8_id5")
    and IsDestroyed("nebel9_id5")
    and IsDestroyed("nebel10_id5")
    and IsDestroyed("nebel11_id5")
    and IsDestroyed("nebel12_id5") then


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

    --Schneetagezyklus
        CppLogic.Logic.ClearWeatherQueueAndAddInitial(3, 60*4, 1, 3, 10)
		AddPeriodicTransitionSunriseSnow(60);
		AddPeriodicSunriseSnow(60)
		AddPeriodicNightSnow(4*60);
		AddPeriodicSunriseSnow(60)
		AddPeriodicTransitionSunriseSnow(60);

    
    if not checkWeatherMachine then
        checkWeatherMachine = StartSimpleJob("WeatherPlant")
    end
end

function WeatherPlant()
    if IsDestroyed(lighthouseID) then

    	--Sommertag 1

		CppLogic.Logic.ClearWeatherQueueAndAddInitial(1, 60*4, 1, 1, 10)
		AddPeriodicTransitionSunrise(60);
		AddPeriodicSunrise(60)
		AddPeriodicNight(4*60);
		AddPeriodicSunrise(60)
		AddPeriodicTransitionSunrise(60);
		
        --Sommertag 2

        AddPeriodicSummer(4*60);
		AddPeriodicTransitionSunrise(60);
		AddPeriodicSunrise(60)
		AddPeriodicNight(4*60);
		AddPeriodicSunrise(60)
		AddPeriodicTransitionSunrise(60);

		--Regentage

		AddPeriodicRain(4*60);
		AddPeriodicTransitionSunriseRain(60);
		AddPeriodicSunriseRain(60)
		AddPeriodicNightRain(4*60);
		AddPeriodicSunriseRain(60)
		AddPeriodicTransitionSunriseRain(60);

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

---------------------------------------------------------------------------------------------------------------------------------------