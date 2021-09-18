function ActivateArmyId6_Wave3()
  
  
-------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------
    
        ArmyWave3Barracks1_ID6 = UnlimitedArmy:New({					
                -- benötigt
                Player = 6,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                    })
            
                    SpawnerArmyWave3Barracks1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Barracks1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_b1_id6"), --position
                        ArmySize = 6, --armysize
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
                        Generator = "b1_id6",  --generator
                    })

 -------------------------------------ID6 Archery1-------------------------------------------------------------------------------------

            ArmyWave3Archery1_ID6 = UnlimitedArmy:New({					
                -- benötigt
                Player = 6,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                    })
            
                    SpawnerArmyWave3Archery1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Archery1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_a1_id6"), --position
                        ArmySize = 6, --armysize
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
                        Generator = "a1_id6",  --generator
                    })
            
    
----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------
        
 ArmyWave3Foundry1_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave3Foundry1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Foundry1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_f1_id6"), --position
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
            Generator = "f1_id6",  --generator
        })   
        
     
----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------
        
ArmyWave3Tower1_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave3Tower1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Tower1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_t1_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 40,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
            },
            -- optional:
            Generator = "t1_id6",  --generator
        })   

----------------------------------ID6 Tower2 ---------------------------------------------------------------------------------
        
ArmyWave3Tower2_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave3Tower2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Tower2_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_t1_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 40,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
            },
            -- optional:
            Generator = "t1_id6",  --generator
        })   

----------------------------------ID6 Castle ---------------------------------------------------------------------------------
    
ArmyWave3Castle1_ID6 = UnlimitedArmy:New({					
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave3Castle1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave3Castle1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_c1_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 20,  --spawncounter
            SpawnLeaders = 6,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "c1_id6",  --generator
        })

--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
        
ArmyWave3Barracks1_ID6: AddCommandMove(GetPosition("id6_attack_target1"), true);
ArmyWave3Archery1_ID6: AddCommandMove(GetPosition("id6_attack_target2"), true);
ArmyWave3Foundry1_ID6: AddCommandMove(GetPosition("id6_attack_target3"), true);
ArmyWave3Tower1_ID6: AddCommandMove(GetPosition("id6_attack_target4"), true);
ArmyWave3Tower2_ID6: AddCommandMove(GetPosition("id6_attack_target6"), true);
ArmyWave3Castle1_ID6: AddCommandMove(GetPosition("id6_attack_target5"), true);

    
    
       
    
    end