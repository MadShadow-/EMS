function ActivateArmyId8()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
    -------------------------------------ID8 Barracks1-------------------------------------------------------------------------------------

    function ArmyBarracks1_ID8()
        if IsExisting("barracks1_id8") then
        local SpawnPos = GetPosition("spawn_barracks1_id8")
            if IsDestroyed("Truppname640") and IsDestroyed("Truppname641")  and IsDestroyed("Truppname642") then
                if Counter.Tick2("ArmyBarracks1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderSword3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname64"..i)
                        AddWaypoints("Truppname64"..i, {"id8_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname64"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname643") and IsDestroyed("Truppname644") and IsDestroyed("Truppname645") then
                if Counter.Tick2("ArmyBarracks1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderPoleArm3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname64"..i)
                        AddWaypoints("Truppname64"..i, {"id8_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname64"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("barracks1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyBarracks1_ID8")

    
    ----------------------------------ID8 Archery1 ---------------------------------------------------------------------------------

    function ArmyArchery1_ID8()
        if IsExisting("archery1_id8") then
        local SpawnPos = GetPosition("spawn_archery1_id8")
            if IsDestroyed("Truppname650") and IsDestroyed("Truppname651")  and IsDestroyed("Truppname652") then
                if Counter.Tick2("ArmyArchery1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname65"..i)
                        AddWaypoints("Truppname65"..i, {"id8_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname65"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname653") and IsDestroyed("Truppname654") and IsDestroyed("Truppname655") then
                if Counter.Tick2("ArmyArchery1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname65"..i)
                        AddWaypoints("Truppname65"..i, {"id8_attack_target6", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname65"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("archery1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyArchery1_ID8")
                
    
    ----------------------------------ID8 Stable1 ---------------------------------------------------------------------------------

    function ArmyStable1_ID8()
        if IsExisting("stable1_id8") then
        local SpawnPos = GetPosition("spawn_stable1_id8")
            if IsDestroyed("Truppname660") and IsDestroyed("Truppname661")  and IsDestroyed("Truppname662") then
                if Counter.Tick2("ArmyStable1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderHeavyCavalry1, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname66"..i)
                        AddWaypoints("Truppname66"..i, {"id8_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname66"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname663") and IsDestroyed("Truppname664") and IsDestroyed("Truppname665") then
                if Counter.Tick2("ArmyStable1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderCavalry1, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname66"..i)
                        AddWaypoints("Truppname66"..i, {"id8_attack_target5", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname66"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("stable1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyStable1_ID8")


    
     ----------------------------------ID8 Foundry1 ---------------------------------------------------------------------------------

     function ArmyFoundry1_ID8()
        if IsExisting("foundry1_id8") then
        local SpawnPos = GetPosition("spawn_foundry1_id8")
            if IsDestroyed("Truppname670") and IsDestroyed("Truppname671")  and IsDestroyed("Truppname672") then
                if Counter.Tick2("ArmyFoundry1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname67"..i)
                        AddWaypoints("Truppname67"..i, {"id8_attack_target4", loop=true})
                    end
                end
            end
            --
            if IsDestroyed("Truppname673") and IsDestroyed("Truppname674") and IsDestroyed("Truppname675") then
                if Counter.Tick2("ArmyFoundry1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname67"..i)
                        AddWaypoints("Truppname67"..i, {"id8_attack_target4", loop=true})
                    end
                end
            end
        end
        if IsDead("foundry1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyFoundry1_ID8")


    
     ----------------------------------ID8 Tower1 ---------------------------------------------------------------------------------

     function ArmyTower1_ID8()
        if IsExisting("tower1_id8") then
        local SpawnPos = GetPosition("spawn_tower1_id8")
            if IsDestroyed("Truppname680") and IsDestroyed("Truppname681")  and IsDestroyed("Truppname682") then
                if Counter.Tick2("ArmyTower1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname68"..i)
                        AddWaypoints("Truppname68"..i, {"id8_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname68"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname683") and IsDestroyed("Truppname684") and IsDestroyed("Truppname685") then
                if Counter.Tick2("ArmyTower1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname68"..i)
                        AddWaypoints("Truppname68"..i, {"id8_attack_target3", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname68"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("tower1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyTower1_ID8") 

    
    ----------------------------------ID8 Tower2 ----------------------------------------------------------------------------------

    function ArmyTower2_ID8()
        if IsExisting("tower2_id8") then
        local SpawnPos = GetPosition("spawn_tower2_id8")
            if IsDestroyed("Truppname690") and IsDestroyed("Truppname691")  and IsDestroyed("Truppname692") then
                if Counter.Tick2("ArmyTower2_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname69"..i)
                        AddWaypoints("Truppname69"..i, {"id8_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname69"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname693") and IsDestroyed("Truppname694") and IsDestroyed("Truppname695") then
                if Counter.Tick2("ArmyTower2_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname69"..i)
                        AddWaypoints("Truppname69"..i, {"id8_attack_target2", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname69"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("tower2_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyTower2_ID8") 

        
    ----------------------------------ID8 Outpost1 ---------------------------------------------------------------------------------

    function ArmyOutpost1_ID8()
        if IsExisting("outpost1_id8") then
        local SpawnPos = GetPosition("spawn_outpost1_id8")
            if IsDestroyed("Truppname700") and IsDestroyed("Truppname701")  and IsDestroyed("Truppname702") then
                if Counter.Tick2("ArmyOutpost1_ID8_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname70"..i)
                        AddWaypoints("Truppname70"..i, {"id8_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname70"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname703") and IsDestroyed("Truppname704") and IsDestroyed("Truppname705") then
                if Counter.Tick2("ArmyOutpost1_ID8_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname70"..i)
                        AddWaypoints("Truppname70"..i, {"id8_attack_target1", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname70"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("outpost1_id8") then
            return true
        end
    end 
    
    StartSimpleJob("ArmyOutpost1_ID8")

end