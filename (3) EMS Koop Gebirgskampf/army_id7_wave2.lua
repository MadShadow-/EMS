
  function ActivateArmyId7_Wave2()
  
  
-------------------------------------ID7 Barracks2-------------------------------------------------------------------------------------
    
        ArmyBarracks2_ID7 = UnlimitedArmy:New({					
                -- benötigt
                Player = 7,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                            })
                    
                            SpawnerArmyBarracks2_ID7 = UnlimitedArmySpawnGenerator:New(ArmyBarracks2_ID7, {
                                -- benötigt:
                                Position = GetPosition("spawn_barracks2_id7"), --position
                                ArmySize = 5, --armysize
                                SpawnCounter = 10,  --spawncounter
                                SpawnLeaders = 5,   --spawnleaders
                                LeaderDesc = {
                                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.CU_BlackKnight_LeaderMace1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.CU_Barbarian_LeaderClub1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                },
                                -- optional:
                                Generator = "barracks2_id7",  --generator
                            })
    
    
----------------------------------ID7 Archery2 ---------------------------------------------------------------------------------
    
        ArmyArchery2_ID7 = UnlimitedArmy:New({					
                -- benötigt
                Player = 7,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                            })
                    
                            SpawnerArmyArchery2_ID7 = UnlimitedArmySpawnGenerator:New(ArmyArchery2_ID7, {
                                -- benötigt:
                                Position = GetPosition("spawn_archery2_id7"), --position
                                ArmySize = 5, --armysize
                                SpawnCounter = 10,  --spawncounter
                                SpawnLeaders = 5,   --spawnleaders
                                LeaderDesc = {
                                    {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                    {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                },
                                -- optional:
                                Generator = "archery2_id7",  --generator
                            })
    
----------------------------------ID7 Foundry2 ---------------------------------------------------------------------------------
    
    ArmyFoundry2_ID7 = UnlimitedArmy:New({					

        -- benötigt
        Player = 7,
        Area = 4000,
        -- optional
        AutoDestroyIfEmpty = true,
        TransitAttackMove = true,
        Formation = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation = FormationFunktion,
        AIActive = true,
        AutoRotateRange = 100000,
                    })

                    SpawnerArmyFoundry2_ID7 = UnlimitedArmySpawnGenerator:New(ArmyFoundry2_ID7, {
                        -- benötigt:
                        Position = GetPosition("spawn_foundry2_id7"), --position
                        ArmySize = 6, --armysize
                        SpawnCounter = 30,  --spawncounter
                        SpawnLeaders = 3,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                        },
                        -- optional:
                        Generator = "foundry2_id7",  --generator
                    })    

----------------------------------ID7 Foundry3 ---------------------------------------------------------------------------------
    
     ArmyFoundry3_ID7 = UnlimitedArmy:New({					
        -- benötigt
        Player = 7,
        Area = 4000,
        -- optional
        AutoDestroyIfEmpty = true,
        TransitAttackMove = true,
        Formation = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation = FormationFunktion,
        AIActive = true,
        AutoRotateRange = 100000,
            })

            SpawnerArmyFoundry3_ID7 = UnlimitedArmySpawnGenerator:New(ArmyFoundry3_ID7, {
                -- benötigt:
                Position = GetPosition("spawn_foundry3_id7"), --position
                ArmySize = 6, --armysize
                SpawnCounter = 30,  --spawncounter
                SpawnLeaders = 3,   --spawnleaders
                LeaderDesc = {
                    {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                    {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                    {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                    {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                    {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                },
                -- optional:
                Generator = "foundry3_id7",  --generator
            })     
    
    --------------------------------ArmyMovesets--------------------------------------------------------------------------------------
        
    ArmyBarracks2_ID7: AddCommandMove(GetPosition("id7_attack_target3"), true);
    ArmyArchery2_ID7: AddCommandMove(GetPosition("id7_attack_target4"), true);
    ArmyFoundry2_ID7: AddCommandMove(GetPosition("id7_attack_target6"), true);
    ArmyFoundry3_ID7: AddCommandMove(GetPosition("id7_attack_target7"), true);
           
    
    
       
    
    end
    

