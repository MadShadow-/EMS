
function ActivateBandits()    
	
	if CheckMode == 1 then
       timeBandits = 40
	elseif CheckMode == 2 then
		timeBandits = 20
	elseif CheckMode == 3 then
		timeBandits = 10
	end

		bandit1 = DefensiveArmy.new(5, GetPosition("id5_patrol_point1").X, GetPosition("id5_patrol_point1").Y, 5000, PlayerChunk_GetPlayerEnemyChunk(5), 600, true);
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit1, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower1_id5").X, GetPosition("spawn_tower1_id5").Y, 0, math.random(1, 4));
		
		function StopBandit1()
			if IsDestroyed("tower1_id5") then
				DefensiveArmy.StopRespawn(bandit1)
				return true;
			end
		end


		bandit2 = DefensiveArmy.new(5, GetPosition("id5_patrol_point2").X, GetPosition("id5_patrol_point2").Y, 5000, PlayerChunk_GetPlayerEnemyChunk(5), 600, true);
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit2, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower2_id5").X, GetPosition("spawn_tower2_id5").Y, 0, math.random(1, 4));
		
		function StopBandit2()
			if IsDestroyed("tower2_id5") then
				DefensiveArmy.StopRespawn(bandit2)
				return true;
			end
		end


		bandit3 = DefensiveArmy.new(5, GetPosition("id5_patrol_point3").X, GetPosition("id5_patrol_point3").Y, 10000, PlayerChunk_GetPlayerEnemyChunk(5), 600, true);
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit3, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower3_id5").X, GetPosition("spawn_tower3_id5").Y, 0, math.random(1, 4));
		
		function StopBandit3()
			if IsDestroyed("tower3_id5") then
				DefensiveArmy.StopRespawn(bandit3)
				return true;
			end
		end


		bandit4 = DefensiveArmy.new(5, GetPosition("id5_patrol_point4").X, GetPosition("id5_patrol_point4").Y, 13000, PlayerChunk_GetPlayerEnemyChunk(5), 600, true);
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderSword1, 8, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		DefensiveArmy.AddTroopSpawn(bandit4, timeBandits, Entities.CU_BanditLeaderBow1, 4, GetPosition("spawn_tower4_id5").X, GetPosition("spawn_tower4_id5").Y, 0, math.random(1, 4));
		
		function StopBandit4()
			if IsDestroyed("tower4_id5") then
				DefensiveArmy.StopRespawn(bandit4)
				return true;
			end
		end

end