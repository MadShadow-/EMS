function ActivateArmyId7()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
    -------------------------------------ID7 Barracks1-------------------------------------------------------------------------------------

    function ArmyBarracks1_ID7()
        if IsExisting("barracks1_id7") then
        local SpawnPos = GetPosition("spawn_barracks1_id7")
            if IsDestroyed("Truppname430") and IsDestroyed("Truppname431")  and IsDestroyed("Truppname432") then
                if Counter.Tick2("ArmyBarracks1_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderSword3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname43"..i)
                        AddWaypoints("Truppname43"..i, {"id7_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname43"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname433") and IsDestroyed("Truppname434") and IsDestroyed("Truppname435") then
                if Counter.Tick2("ArmyBarracks1_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderPoleArm3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname43"..i)
                        AddWaypoints("Truppname43"..i, {"id7_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname43"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("barracks1_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyBarracks1_ID7")
      
    
    ----------------------------------ID7 Archery1 ---------------------------------------------------------------------------------

    function ArmyArchery1_ID7()
        if IsExisting("archery1_id7") then
        local SpawnPos = GetPosition("spawn_archery1_id7")
            if IsDestroyed("Truppname440") and IsDestroyed("Truppname441")  and IsDestroyed("Truppname442") then
                if Counter.Tick2("ArmyArchery1_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname44"..i)
                        AddWaypoints("Truppname44"..i, {"id7_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname44"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname443") and IsDestroyed("Truppname444") and IsDestroyed("Truppname445") then
                if Counter.Tick2("ArmyArchery1_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderRifle1, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname44"..i)
                        AddWaypoints("Truppname44"..i, {"id7_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname44"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("archery1_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyArchery1_ID7")

    
    ----------------------------------ID7 Stable1 ---------------------------------------------------------------------------------

    function ArmyStable1_ID7()
        if IsExisting("stable1_id7") then
        local SpawnPos = GetPosition("spawn_stable1_id7")
            if IsDestroyed("Truppname450") and IsDestroyed("Truppname451")  and IsDestroyed("Truppname452") then
                if Counter.Tick2("ArmyStable1_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderHeavyCavalry1, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname45"..i)
                        AddWaypoints("Truppname45"..i, {"id7_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname45"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname453") and IsDestroyed("Truppname454") and IsDestroyed("Truppname455") then
                if Counter.Tick2("ArmyStable1_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderCavalry1, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname45"..i)
                        AddWaypoints("Truppname45"..i, {"id7_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname45"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("stable1_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyStable1_ID7")

    
     ----------------------------------ID7 Foundry1 ---------------------------------------------------------------------------------

     function ArmyFoundry1_ID7()
        if IsExisting("foundry1_id7") then
        local SpawnPos = GetPosition("spawn_foundry1_id7")
            if IsDestroyed("Truppname460") and IsDestroyed("Truppname461")  and IsDestroyed("Truppname462") then
                if Counter.Tick2("ArmyFoundry1_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname46"..i)
                        AddWaypoints("Truppname46"..i, {"id7_attack_target4", loop=true})
                    end
                end
            end
            --
            if IsDestroyed("Truppname463") and IsDestroyed("Truppname464") and IsDestroyed("Truppname465") then
                if Counter.Tick2("ArmyFoundry1_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon1, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname46"..i)
                        AddWaypoints("Truppname46"..i, {"id7_attack_target4", loop=true})
                    end
                end
            end
        end
        if IsDead("foundry1_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyFoundry1_ID7")


    
     ----------------------------------ID7 Tower1 ---------------------------------------------------------------------------------
     function ArmyTower1_ID7()
        if IsExisting("tower1_id7") then
        local SpawnPos = GetPosition("spawn_tower1_id7")
            if IsDestroyed("Truppname470") and IsDestroyed("Truppname471")  and IsDestroyed("Truppname472") then
                if Counter.Tick2("ArmyTower1_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname47"..i)
                        AddWaypoints("Truppname47"..i, {"id7_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname47"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname473") and IsDestroyed("Truppname474") and IsDestroyed("Truppname475") then
                if Counter.Tick2("ArmyTower1_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname47"..i)
                        AddWaypoints("Truppname47"..i, {"id7_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname47"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("tower1_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyTower1_ID7")

         
    ----------------------------------ID7 Tower2 ----------------------------------------------------------------------------------

    function ArmyTower2_ID7()
        if IsExisting("tower2_id7") then
        local SpawnPos = GetPosition("spawn_tower2_id7")
            if IsDestroyed("Truppname480") and IsDestroyed("Truppname481")  and IsDestroyed("Truppname482") then
                if Counter.Tick2("ArmyTower2_ID7_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname48"..i)
                        AddWaypoints("Truppname48"..i, {"id7_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname48"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname483") and IsDestroyed("Truppname484") and IsDestroyed("Truppname485") then
                if Counter.Tick2("ArmyTower2_ID7_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname48"..i)
                        AddWaypoints("Truppname48"..i, {"id7_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname48"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("tower2_id7") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyTower2_ID7")

    
        ----------------------------------ID7 Outpost1 ---------------------------------------------------------------------------------

        function ArmyOutpost1_ID7()
            if IsExisting("outpost1_id7") then
            local SpawnPos = GetPosition("spawn_outpost1_id7")
                if IsDestroyed("Truppname490") and IsDestroyed("Truppname491")  and IsDestroyed("Truppname492") then
                    if Counter.Tick2("ArmyOutpost1_ID7_1", RespawnTime) then
                        for i = 0, 2 do
                            SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname49"..i)
                            AddWaypoints("Truppname49"..i, {"id7_attack_target7", loop=true})
                            Logic.LeaderChangeFormationType(GetEntityId("Truppname48"..i), math.random(1, 4))
                        end
                    end
                end
                --
                if IsDestroyed("Truppname493") and IsDestroyed("Truppname494") and IsDestroyed("Truppname495") then
                    if Counter.Tick2("ArmyOutpost1_ID7_2", RespawnTime) then
                        for i = 3, 5 do
                            SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname49"..i)
                            AddWaypoints("Truppname49"..i, {"id7_attack_target7", loop=true})
                            Logic.LeaderChangeFormationType(GetEntityId("Truppname49"..i), math.random(1, 4))
                        end
                    end
                end
            end
            if IsDead("outpost1_id7") then
                return true
            end
        end 
        
        StartSimpleJob("ArmyOutpost1_ID7")

    end
