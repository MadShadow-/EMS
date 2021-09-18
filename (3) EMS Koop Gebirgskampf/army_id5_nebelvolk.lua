function ActivateFogWarriors()




    for i=1,12,1 do
        _G["nv"..i] = UnlimitedArmy:New({					
            -- benötigt
            Player = 5,
            Area = 4000,
            -- optional
            AutoDestroyIfEmpty = true,
            TransitAttackMove = true,
            Formation = UnlimitedArmy.Formations.Chaotic,
            LeaderFormation = FormationFunktion,
            AIActive = true,
            AutoRotateRange = 100000,
        })

        _G["SpawnerBanditen"..i] = UnlimitedArmySpawnGenerator:New(_G["nv"..i], {
            -- benötigt:
            Position = GetPosition("spawn_nebel"..i.."_id5"), --position
            ArmySize = 3, --armysize
            SpawnCounter = 25,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_Evil_LeaderBearman1, SoldierNum = 16 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_Evil_LeaderSkirmisher1, SoldierNum = 16 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "nebel"..i.."_id5",  --generator
        })

        _G["nv"..i]: AddCommandMove(GetPosition("id5_attack_target"..i), true);
    end





end


