
   function ActivateArmyId8_Wave2()
  
  
-------------------------------------ID8 Barracks2-------------------------------------------------------------------------------------
        
            ArmyBarracks2_ID8 = UnlimitedArmy:New({					
                    -- benötigt
                    Player = 8,
                    Area = 4000,
                    -- optional
                    AutoDestroyIfEmpty = true,
                    TransitAttackMove = true,
                    Formation = UnlimitedArmy.Formations.Chaotic,
                    LeaderFormation = FormationFunktion,
                    AIActive = true,
                    AutoRotateRange = 100000,
                            })
                    
                            SpawnerArmyBarracks2_ID8 = UnlimitedArmySpawnGenerator:New(ArmyBarracks2_ID8, {
                                -- benötigt:
                                Position = GetPosition("spawn_barracks2_id8"), --position
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
                                Generator = "barracks2_id8",  --generator
                            })
        
        
----------------------------------ID8 Archery2 ---------------------------------------------------------------------------------
        
            ArmyArchery2_ID8 = UnlimitedArmy:New({					
                    -- benötigt
                    Player = 8,
                    Area = 4000,
                    -- optional
                    AutoDestroyIfEmpty = true,
                    TransitAttackMove = true,
                    Formation = UnlimitedArmy.Formations.Chaotic,
                    LeaderFormation = FormationFunktion,
                    AIActive = true,
                    AutoRotateRange = 100000,
                    })
            
                    SpawnerArmyArchery2_ID8 = UnlimitedArmySpawnGenerator:New(ArmyArchery2_ID8, {
                        -- benötigt:
                        Position = GetPosition("spawn_archery2_id8"), --position
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
                        Generator = "archery2_id8",  --generator
                    })
            
----------------------------------ID8 Foundry2 ---------------------------------------------------------------------------------
        
        ArmyFoundry2_ID8 = UnlimitedArmy:New({					
    
            -- benötigt
            Player = 8,
            Area = 4000,
            -- optional
            AutoDestroyIfEmpty = true,
            TransitAttackMove = true,
            Formation = UnlimitedArmy.Formations.Chaotic,
            LeaderFormation = FormationFunktion,
            AIActive = true,
            AutoRotateRange = 100000,
            })
    
            SpawnerArmyFoundry2_ID8 = UnlimitedArmySpawnGenerator:New(ArmyFoundry2_ID8, {
                -- benötigt:
                Position = GetPosition("spawn_foundry2_id8"), --position
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
                Generator = "foundry2_id8",  --generator
            })    
    
----------------------------------ID8 Foundry3 ---------------------------------------------------------------------------------
        
         ArmyFoundry3_ID8 = UnlimitedArmy:New({					
            -- benötigt
            Player = 8,
            Area = 4000,
            -- optional
            AutoDestroyIfEmpty = true,
            TransitAttackMove = true,
            Formation = UnlimitedArmy.Formations.Chaotic,
            LeaderFormation = FormationFunktion,
            AIActive = true,
            AutoRotateRange = 100000,
                })
    
                SpawnerArmyFoundry3_ID8 = UnlimitedArmySpawnGenerator:New(ArmyFoundry3_ID8, {
                    -- benötigt:
                    Position = GetPosition("spawn_foundry3_id8"), --position
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
                    Generator = "foundry3_id8",  --generator
                })     
        
--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
            
ArmyBarracks2_ID8: AddCommandMove(GetPosition("id8_attack_target1"), true);
ArmyArchery2_ID8: AddCommandMove(GetPosition("id8_attack_target2"), true);
ArmyFoundry2_ID8: AddCommandMove(GetPosition("id8_attack_target5"), true);
ArmyFoundry3_ID8: AddCommandMove(GetPosition("id8_attack_target6"), true);
               
        
        
           
        
end