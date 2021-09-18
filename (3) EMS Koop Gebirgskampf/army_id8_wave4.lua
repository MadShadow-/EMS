function ActivateArmyId8_Wave4()
  
  
-------------------------------------ID8 Barracks1-------------------------------------------------------------------------------------
    
        ArmyWave4Barracks1_ID8 = UnlimitedArmy:New({					
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
    
            SpawnerArmyWave4Barracks1_ID8 = UnlimitedArmySpawnGenerator:New(ArmyWave4Barracks1_ID8, {
                -- benötigt:
                Position = GetPosition("spawn_end_b1_id8"), --position
                ArmySize = 8, --armysize
                SpawnCounter = 20,  --spawncounter
                SpawnLeaders = 5,   --spawnleaders
                LeaderDesc = {
                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_BlackKnight_LeaderMace1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_Barbarian_LeaderClub1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                },
                -- optional:
                Generator = "end_b1_id8",  --generator
            })

 -------------------------------------ID8 Archery1-------------------------------------------------------------------------------------

            ArmyWave4Archery1_ID8 = UnlimitedArmy:New({					
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
            
                    SpawnerArmyWave4Archery1_ID8 = UnlimitedArmySpawnGenerator:New(ArmyWave4Archery1_ID8, {
                        -- benötigt:
                        Position = GetPosition("spawn_end_a1_id8"), --position
                        ArmySize = 8, --armysize
                        SpawnCounter = 30,  --spawncounter
                        SpawnLeaders = 5,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                        },
                        -- optional:
                        Generator = "end_a1_id8",  --generator
                    })
            
    
----------------------------------ID8 Tower1 ---------------------------------------------------------------------------------
        
 ArmyWave4Tower1_ID8 = UnlimitedArmy:New({					
    
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

        SpawnerArmyWave4Tower1_ID8 = UnlimitedArmySpawnGenerator:New(ArmyWave4Tower1_ID8, {
            -- benötigt:
            Position = GetPosition("spawn_end_t1_id8"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 40,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
            },
            -- optional:
            Generator = "end_t1_id8",  --generator
        })   
        



----------------------------------ID8 Castle ---------------------------------------------------------------------------------
    
ArmyWave4Castle1_ID8 = UnlimitedArmy:New({					
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

        SpawnerArmyWave4Castle1_ID8 = UnlimitedArmySpawnGenerator:New(ArmyWave4Castle1_ID8, {
            -- benötigt:
            Position = GetPosition("spawn_burg_id8"), --position
            ArmySize = 8, --armysize
            SpawnCounter = 30,  --spawncounter
            SpawnLeaders = 6,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "burg_id8",  --generator
        })

--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
        
ArmyWave4Barracks1_ID8: AddCommandMove(GetPosition("id8_attack_target1"), true);
ArmyWave4Archery1_ID8: AddCommandMove(GetPosition("id8_attack_target2"), true);
ArmyWave4Tower1_ID8: AddCommandMove(GetPosition("id8_attack_target3"), true);
ArmyWave4Castle1_ID8: AddCommandMove(GetPosition("id8_attack_target4"), true);

    
    
       
    
    end