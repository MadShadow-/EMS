
  function ActivateBandits()     
       
       
       
       bandit1 = UnlimitedArmy:New({					
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

        --Patrol Queue
        bandit1: AddCommandMove(GetPosition("id5_patrol_point1"), true);
        bandit1:AddCommandWaitForIdle(true);
        bandit1: AddCommandMove(GetPosition("spawn_tower1_id5"), true);
        bandit1:AddCommandWaitForIdle(true);



        bandit2 = UnlimitedArmy:New({					
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

                --Patrol Queue
                bandit2: AddCommandMove(GetPosition("id5_patrol_point2"), true);
                bandit2:AddCommandWaitForIdle(true);
                bandit2: AddCommandMove(GetPosition("spawn_tower2_id5"), true);
                bandit2:AddCommandWaitForIdle(true);

        bandit3 = UnlimitedArmy:New({					
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

        --Patrol Queue
        bandit3: AddCommandMove(GetPosition("id5_patrol_point3"), true);
        bandit3:AddCommandWaitForIdle(true);
        bandit3: AddCommandMove(GetPosition("spawn_tower3_id5"), true);
        bandit3:AddCommandWaitForIdle(true);

        bandit4 = UnlimitedArmy:New({					
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

        --Patrol Queue
        bandit4: AddCommandMove(GetPosition("id5_patrol_point4"), true);
        bandit4:AddCommandWaitForIdle(true);
        bandit4: AddCommandMove(GetPosition("spawn_tower4_id5"), true);
        bandit4:AddCommandWaitForIdle(true);

        SpawnerBanditen1 = UnlimitedArmySpawnGenerator:New(bandit1, {
			-- benötigt:
			Position = GetPosition("spawn_tower1_id5"), --position
			ArmySize = 6, --armysize
 			SpawnCounter = 20,  --spawncounter
			SpawnLeaders = 6,   --spawnleaders
			LeaderDesc = {
				{LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
			},
 			-- optional:
 			Generator = "tower1_id5",  --generator
 		})


         SpawnerBanditen2 = UnlimitedArmySpawnGenerator:New(bandit2, {
			-- benötigt:
			Position = GetPosition("spawn_tower2_id5"), --position
			ArmySize = 6, --armysize
 			SpawnCounter = 20,  --spawncounter
			SpawnLeaders = 6,   --spawnleaders
			LeaderDesc = {
				{LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
			},
 			-- optional:
 			Generator = "tower2_id5",  --generator
 		})



         SpawnerBanditen3 = UnlimitedArmySpawnGenerator:New(bandit3, {
			-- benötigt:
			Position = GetPosition("spawn_tower3_id5"), --position
			ArmySize = 6, --armysize
 			SpawnCounter = 20,  --spawncounter
			SpawnLeaders = 6,   --spawnleaders
			LeaderDesc = {
				{LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
			},
 			-- optional:
 			Generator = "tower3_id5",  --generator
 		})




         SpawnerBanditen4 = UnlimitedArmySpawnGenerator:New(bandit4, {
			-- benötigt:
			Position = GetPosition("spawn_tower4_id5"), --position
			ArmySize = 6, --armysize
 			SpawnCounter = 20,  --spawncounter
			SpawnLeaders = 6,   --spawnleaders
			LeaderDesc = {
				{LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 8 , SpawnNum = 2, Looped = true, Experience = 3},
			},
 			-- optional:
 			Generator = "tower4_id5",  --generator
 		})


    end