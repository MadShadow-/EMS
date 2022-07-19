
 function ActivateArmyId6()


    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
  
-------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------

function ArmyBarracks1_ID6()
    if IsExisting("barracks1_id6") then
    local SpawnPos = GetPosition("spawn_barracks1_id6")
        if IsDestroyed("Truppname210") and IsDestroyed("Truppname211")  and IsDestroyed("Truppname212") then
            if Counter.Tick2("ArmyBarracks1_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname21"..i)
                    AddWaypoints("Truppname21"..i, {"id6_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname21"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname213") and IsDestroyed("Truppname214") and IsDestroyed("Truppname215") then
            if Counter.Tick2("ArmyBarracks1_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname21"..i)
                    AddWaypoints("Truppname21"..i, {"id6_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname21"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("barracks1_id6") then
        return true
    end
end 

StartSimpleJob("ArmyBarracks1_ID6")

    

----------------------------------ID6 Archery1 ---------------------------------------------------------------------------------
function ArmyArchery1_ID6()
    if IsExisting("archery1_id6") then
    local SpawnPos = GetPosition("spawn_archery1_id6")
        if IsDestroyed("Truppname220") and IsDestroyed("Truppname221")  and IsDestroyed("Truppname222") then
            if Counter.Tick2("ArmyArchery1_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname22"..i)
                    AddWaypoints("Truppname22"..i, {"id6_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname22"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname223") and IsDestroyed("Truppname224") and IsDestroyed("Truppname225") then
            if Counter.Tick2("ArmyArchery1_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname22"..i)
                    AddWaypoints("Truppname22"..i, {"id6_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname22"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("archery1_id6") then
        return true
    end
end 

StartSimpleJob("ArmyArchery1_ID6")



----------------------------------ID6 Stable1 ---------------------------------------------------------------------------------

function ArmyStable1_ID6()
    if IsExisting("stable1_id6") then
    local SpawnPos = GetPosition("spawn_stable1_id6")
        if IsDestroyed("Truppname230") and IsDestroyed("Truppname231")  and IsDestroyed("Truppname232") then
            if Counter.Tick2("ArmyStable1_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname23"..i)
                    AddWaypoints("Truppname23"..i, {"id6_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname23"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname233") and IsDestroyed("Truppname234") and IsDestroyed("Truppname235") then
            if Counter.Tick2("ArmyStable1_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname23"..i)
                    AddWaypoints("Truppname23"..i, {"id6_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname23"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("stable1_id6") then
        return true
    end
end 

StartSimpleJob("ArmyStable1_ID6")


 ----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------

 function ArmyFoundry1_ID6()
    if IsExisting("foundry1_id6") then
    local SpawnPos = GetPosition("spawn_foundry1_id6")
        if IsDestroyed("Truppname240") and IsDestroyed("Truppname241")  and IsDestroyed("Truppname242") then
            if Counter.Tick2("ArmyFoundry1_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname24"..i)
                    AddWaypoints("Truppname24"..i, {"id6_attack_target4", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname243") and IsDestroyed("Truppname244") and IsDestroyed("Truppname245") then
            if Counter.Tick2("ArmyFoundry1_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname24"..i)
                    AddWaypoints("Truppname24"..i, {"id6_attack_target4", loop=true})
                end
            end
        end
    end
    if IsDead("foundry1_id6") then
        return true
    end
end 

StartSimpleJob("ArmyFoundry1_ID6")


 ----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------

 function ArmyTower1_ID6()
    if IsExisting("tower1_id6") then
    local SpawnPos = GetPosition("spawn_tower1_id6")
        if IsDestroyed("Truppname250") and IsDestroyed("Truppname251")  and IsDestroyed("Truppname252") then
            if Counter.Tick2("ArmyTower1_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname25"..i)
                    AddWaypoints("Truppname25"..i, {"id6_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname25"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname253") and IsDestroyed("Truppname254") and IsDestroyed("Truppname255") then
            if Counter.Tick2("ArmyTower1_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname25"..i)
                    AddWaypoints("Truppname25"..i, {"id6_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname25"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("tower1_id6") then
        return true
    end
end 

StartSimpleJob("ArmyTower1_ID6")


----------------------------------ID6 Tower2 ----------------------------------------------------------------------------------

function ArmyTower2_ID6()
    if IsExisting("tower2_id6") then
    local SpawnPos = GetPosition("spawn_tower2_id6")
        if IsDestroyed("Truppname260") and IsDestroyed("Truppname261")  and IsDestroyed("Truppname262") then
            if Counter.Tick2("ArmyTower2_ID6_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname26"..i)
                    AddWaypoints("Truppname26"..i, {"id6_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname26"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname263") and IsDestroyed("Truppname264") and IsDestroyed("Truppname265") then
            if Counter.Tick2("ArmyTower2_ID6_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname26"..i)
                    AddWaypoints("Truppname26"..i, {"id6_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname26"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("tower2_id6") then
        return true
    end
end 

StartSimpleJob("ArmyTower2_ID6")


----------------------------------ID6 Outpost1 ---------------------------------------------------------------------------------

    function ArmyOutpost1_ID6()
        if IsExisting("outpost1_id6") then
        local SpawnPos = GetPosition("spawn_outpost1_id6")
            if IsDestroyed("Truppname270") and IsDestroyed("Truppname271")  and IsDestroyed("Truppname272") then
                if Counter.Tick2("ArmyOutpost1_ID6_1", RespawnTime) then
                    for i = 0, 2 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname27"..i)
                        AddWaypoints("Truppname27"..i, {"id6_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname27"..i), math.random(1, 4))
                    end
                end
            end
            --
            if IsDestroyed("Truppname273") and IsDestroyed("Truppname274") and IsDestroyed("Truppname275") then
                if Counter.Tick2("ArmyOutpost1_ID6_2", RespawnTime) then
                    for i = 3, 5 do
                        SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname27"..i)
                        AddWaypoints("Truppname27"..i, {"id6_attack_target7", loop=true})
                        Logic.LeaderChangeFormationType(GetEntityId("Truppname27"..i), math.random(1, 4))
                    end
                end
            end
        end
        if IsDead("outpost1_id6") then
            return true
        end
    end 
    
        StartSimpleJob("ArmyOutpost1_ID6")

end