
 function ActivateArmyId6()
  
  
-------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------

    ArmyBarracks1_ID6 = UnlimitedArmy:New({					
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

            SpawnerArmyBarracks1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyBarracks1_ID6, {
                -- benötigt:
                Position = GetPosition("spawn_barracks1_id6"), --position
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
                Generator = "barracks1_id6",  --generator
            })


----------------------------------ID6 Archery1 ---------------------------------------------------------------------------------

    ArmyArchery1_ID6 = UnlimitedArmy:New({					
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

                SpawnerArmyArchery1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyArchery1_ID6, {
                    -- benötigt:
                    Position = GetPosition("spawn_archery1_id6"), --position
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
                    Generator = "archery1_id6",  --generator
                })


----------------------------------ID6 Stable1 ---------------------------------------------------------------------------------

     ArmyStable1_ID6 = UnlimitedArmy:New({					
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

                SpawnerArmyStable1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyStable1_ID6, {
                    -- benötigt:
                    Position = GetPosition("spawn_stable1_id6"), --position
                    ArmySize = 5, --armysize
                    SpawnCounter = 30,  --spawncounter
                    SpawnLeaders = 5,   --spawnleaders
                    LeaderDesc = {
                        {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
                        {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
                        {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
                        {LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
                        {LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
                    },
                    -- optional:
                    Generator = "stable1_id6",  --generator
                })



 ----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------

     ArmyFoundry1_ID6 = UnlimitedArmy:New({					
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

                    SpawnerArmyFoundry1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyFoundry1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_foundry1_id6"), --position
                        ArmySize = 5, --armysize
                        SpawnCounter = 10,  --spawncounter
                        SpawnLeaders = 5,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                            {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                        },
                        -- optional:
                        Generator = "foundry1_id6",  --generator
                    })

 ----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------
 
      ArmyTower1_ID6 = UnlimitedArmy:New({					
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

                    SpawnerArmyTower1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyTower1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_tower1_id6"), --position
                        ArmySize = 5, --armysize
                        SpawnCounter = 10,  --spawncounter
                        SpawnLeaders = 5,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},

                        },
                        -- optional:
                        Generator = "tower1_id6",  --generator
                    })

----------------------------------ID6 Tower2 ----------------------------------------------------------------------------------
 
     ArmyTower2_ID6 = UnlimitedArmy:New({					
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

                SpawnerArmyTower2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyTower2_ID6, {
                    -- benötigt:
                    Position = GetPosition("spawn_tower2_id6"), --position
                    ArmySize = 5, --armysize
                    SpawnCounter = 10,  --spawncounter
                    SpawnLeaders = 5,   --spawnleaders
                    LeaderDesc = {
                        {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                        {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},

                    },
                    -- optional:
                    Generator = "tower2_id6",  --generator
                })



    ----------------------------------ID6 Outpost1 ---------------------------------------------------------------------------------
 
    ArmyOutpost1_ID6 = UnlimitedArmy:New({					
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

                    SpawnerArmyOutpost1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyOutpost1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_outpost1_id6"), --position
                        ArmySize = 5, --armysize
                        SpawnCounter = 10,  --spawncounter
                        SpawnLeaders = 5,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},

                        },
                        -- optional:
                        Generator = "outpost1_id6",  --generator
                    })

--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
    
        ArmyBarracks1_ID6: AddCommandMove(GetPosition("id6_attack_target1"), true);
        ArmyArchery1_ID6: AddCommandMove(GetPosition("id6_attack_target2"), true);
        ArmyStable1_ID6: AddCommandMove(GetPosition("id6_attack_target3"), true);
        ArmyFoundry1_ID6: AddCommandMove(GetPosition("id6_attack_target4"), true);
        ArmyTower1_ID6: AddCommandMove(GetPosition("id6_attack_target5"), true);
        ArmyTower2_ID6: AddCommandMove(GetPosition("id6_attack_target6"), true);
        ArmyOutpost1_ID6: AddCommandMove(GetPosition("id6_attack_target7"), true);

   

end

