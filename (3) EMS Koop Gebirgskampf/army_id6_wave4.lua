function ActivateArmyId6_Wave4()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
    -------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------
    function ArmyWave4Barracks1_ID6()
        if IsExisting("end_b1_id6") then
        local SpawnPos = GetPosition("spawn_end_b1_id6")
            if IsDestroyed("Truppname120") and IsDestroyed("Truppname121")  and IsDestroyed("Truppname122") then
                if Counter.Tick2("ArmyWave4Barracks1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname12"..i)
                        AddWaypoints("Truppname12"..i, {"id6_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname12"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname123") and IsDestroyed("Truppname124") and IsDestroyed("Truppname125") then
                if Counter.Tick2("ArmyWave4Barracks1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname12"..i)
                        AddWaypoints("Truppname12"..i, {"id6_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname12"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_b1_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Barracks1_ID6")

    
    
    -------------------------------------ID6 Barracks2-------------------------------------------------------------------------------------
    function ArmyWave4Barracks2_ID6()
        if IsExisting("end_b2_id6") then
        local SpawnPos = GetPosition("spawn_end_b2_id6")
            if IsDestroyed("Truppname130") and IsDestroyed("Truppname131")  and IsDestroyed("Truppname132") then
                if Counter.Tick2("ArmyWave4Barracks2_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname13"..i)
                        AddWaypoints("Truppname13"..i, {"id6_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname13"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname133") and IsDestroyed("Truppname134") and IsDestroyed("Truppname135") then
                if Counter.Tick2("ArmyWave4Barracks2_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname13"..i)
                        AddWaypoints("Truppname13"..i, {"id6_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname13"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_b2_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Barracks2_ID6")

    
    -------------------------------------ID6 Archery1-------------------------------------------------------------------------------------

    function ArmyWave4Archery1_ID6()
        if IsExisting("end_a1_id6") then
        local SpawnPos = GetPosition("spawn_end_a1_id6")
            if IsDestroyed("Truppname140") and IsDestroyed("Truppname141")  and IsDestroyed("Truppname142") then
                if Counter.Tick2("ArmyWave4Archery1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname14"..i)
                        AddWaypoints("Truppname14"..i, {"id6_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname14"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname143") and IsDestroyed("Truppname144") and IsDestroyed("Truppname145") then
                if Counter.Tick2("ArmyWave4Archery1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname14"..i)
                        AddWaypoints("Truppname14"..i, {"id6_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname14"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_a1_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Archery1_ID6")

    
     -------------------------------------ID7 Archery2-------------------------------------------------------------------------------------

     function ArmyWave4Archery2_ID6()
        if IsExisting("end_a2_id6") then
        local SpawnPos = GetPosition("spawn_end_a2_id6")
            if IsDestroyed("Truppname150") and IsDestroyed("Truppname151")  and IsDestroyed("Truppname152") then
                if Counter.Tick2("ArmyWave4Archery2_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname15"..i)
                        AddWaypoints("Truppname15"..i, {"id6_attack_target4", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname15"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname153") and IsDestroyed("Truppname154") and IsDestroyed("Truppname155") then
                if Counter.Tick2("ArmyWave4Archery2_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname15"..i)
                        AddWaypoints("Truppname15"..i, {"id6_attack_target4", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname15"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_a2_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Archery2_ID6")

    
    ----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------

    function ArmyWave4Foundry1_ID6()
        if IsExisting("end_f1_id6") then
        local SpawnPos = GetPosition("spawn_end_f1_id6")
            if IsDestroyed("Truppname160") and IsDestroyed("Truppname161")  and IsDestroyed("Truppname162") then
                if Counter.Tick2("ArmyWave4Foundry1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname16"..i)
                        AddWaypoints("Truppname16"..i, {"id6_attack_target5", loop=true})
                    end
                end
            end
            --
            if IsDestroyed("Truppname163") and IsDestroyed("Truppname164") and IsDestroyed("Truppname165") then
                if Counter.Tick2("ArmyWave4Foundry1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname16"..i)
                        AddWaypoints("Truppname16"..i, {"id6_attack_target5", loop=true})
                    end
                end
            end
        end
        if IsDead("end_f1_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Foundry1_ID6")     
    
    
    
        
    ----------------------------------ID6 Foundry2 ---------------------------------------------------------------------------------

    function ArmyWave4Foundry2_ID6()
        if IsExisting("end_f2_id6") then
        local SpawnPos = GetPosition("spawn_end_f2_id6")
            if IsDestroyed("Truppname170") and IsDestroyed("Truppname171")  and IsDestroyed("Truppname172") then
                if Counter.Tick2("ArmyWave4Foundry2_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname17"..i)
                        AddWaypoints("Truppname17"..i, {"id6_attack_target5", loop=true})
                    end
                end
            end
            --
            if IsDestroyed("Truppname173") and IsDestroyed("Truppname174") and IsDestroyed("Truppname175") then
                if Counter.Tick2("ArmyWave4Foundry2_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname17"..i)
                        AddWaypoints("Truppname17"..i, {"id6_attack_target5", loop=true})
                    end
                end
            end
        end
        if IsDead("end_f2_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Foundry2_ID6")
    
    
    ----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------

    function ArmyWave4Tower1_ID6()
        if IsExisting("end_t1_id6") then
        local SpawnPos = GetPosition("spawn_end_t1_id6")
            if IsDestroyed("Truppname180") and IsDestroyed("Truppname181")  and IsDestroyed("Truppname182") then
                if Counter.Tick2("ArmyWave4Tower1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname18"..i)
                        AddWaypoints("Truppname18"..i, {"id6_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname18"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname183") and IsDestroyed("Truppname184") and IsDestroyed("Truppname185") then
                if Counter.Tick2("ArmyWave4Tower1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname18"..i)
                        AddWaypoints("Truppname18"..i, {"id6_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname18"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_t1_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Tower1_ID6")
    
    
    
    
    -- ----------------------------------ID6 Stable1 ---------------------------------------------------------------------------------

    function ArmyWave4Stable1_ID6()
        if IsExisting("end_s1_id6") then
        local SpawnPos = GetPosition("spawn_end_s1_id6")
            if IsDestroyed("Truppname190") and IsDestroyed("Truppname191")  and IsDestroyed("Truppname192") then
                if Counter.Tick2("ArmyWave4Stable1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname19"..i)
                        AddWaypoints("Truppname19"..i, {"id6_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname19"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname193") and IsDestroyed("Truppname194") and IsDestroyed("Truppname195") then
                if Counter.Tick2("ArmyWave4Stable1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname19"..i)
                        AddWaypoints("Truppname19"..i, {"id6_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname19"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("end_s1_id6") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyWave4Stable1_ID6")


    
    
    ----------------------------------ID6 Castle ---------------------------------------------------------------------------------
    function ArmyWave4Castle1_ID6()
        if IsExisting("burg_id6") then
        local SpawnPos = GetPosition("spawn_burg_id6")
            if IsDestroyed("Truppname200") and IsDestroyed("Truppname201")  and IsDestroyed("Truppname202") then
                if Counter.Tick2("ArmyWave4Castle1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname20"..i)
                        AddWaypoints("Truppname20"..i, {"id6_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname20"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname203") and IsDestroyed("Truppname204") and IsDestroyed("Truppname205") then
                if Counter.Tick2("ArmyWave4Castle1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname20"..i)
                        AddWaypoints("Truppname20"..i, {"id6_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname20"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("burg_id6") then
            return true
        end
    end 
    
        StartSimpleJob("ArmyWave4Castle1_ID6")
    
        
        
           
        
    end
    
    
    

