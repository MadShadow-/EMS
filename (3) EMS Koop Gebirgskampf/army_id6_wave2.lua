
 function ActivateArmyId6_Wave2()
  
  
-------------------------------------ID6 Barracks2-------------------------------------------------------------------------------------

    ArmyBarracks2_ID6 = UnlimitedArmy:New({					
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

                SpawnerArmyBarracks2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyBarracks2_ID6, {
                    -- benötigt:
                    Position = GetPosition("spawn_barracks2_id6"), --position
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
                    Generator = "barracks2_id6",  --generator
                })


----------------------------------ID6 Archery2 ---------------------------------------------------------------------------------

    ArmyArchery2_ID6 = UnlimitedArmy:New({					
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

                    SpawnerArmyArchery2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyArchery2_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_archery2_id6"), --position
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
                        Generator = "archery2_id6",  --generator
                    })


----------------------------------ID6 Stable2 ---------------------------------------------------------------------------------

     ArmyStable2_ID6 = UnlimitedArmy:New({					
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

                        SpawnerArmyStable2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyStable2_ID6, {
                            -- benötigt:
                            Position = GetPosition("spawn_stable2_id6"), --position
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
                            Generator = "stable2_id6",  --generator
                        })



----------------------------------ID6 Stable3 ---------------------------------------------------------------------------------

     ArmyStable3_ID6 = UnlimitedArmy:New({					
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

                    SpawnerArmyStable3_ID6 = UnlimitedArmySpawnGenerator:New(ArmyStable3_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_stable3_id6"), --position
                        ArmySize = 6, --armysize
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
                        Generator = "stable3_id6",  --generator
                    })

 ----------------------------------ID6 Stable4 ---------------------------------------------------------------------------------

    ArmyStable4_ID6 = UnlimitedArmy:New({					
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

                        SpawnerArmyStable4_ID6 = UnlimitedArmySpawnGenerator:New(ArmyStable4_ID6, {
                            -- benötigt:
                            Position = GetPosition("spawn_stable4_id6"), --position
                            ArmySize = 6, --armysize
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
                            Generator = "stable4_id6",  --generator
                        })



--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
    
        ArmyBarracks2_ID6: AddCommandMove(GetPosition("id6_attack_target1"), true);
        ArmyArchery2_ID6: AddCommandMove(GetPosition("id6_attack_target2"), true);
        ArmyStable2_ID6: AddCommandMove(GetPosition("id6_attack_target3"), true);
        ArmyStable3_ID6: AddCommandMove(GetPosition("id6_attack_target4"), true);
        ArmyStable4_ID6: AddCommandMove(GetPosition("id6_attack_target5"), true);


   

end

