
   function ActivateArmyId8_Wave2()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
  
-------------------------------------ID8 Barracks2-------------------------------------------------------------------------------------
function ArmyBarracks2_ID8()
    if IsExisting("barracks2_id8") then
    local SpawnPos = GetPosition("spawn_barracks2_id8")
        if IsDestroyed("Truppname500") and IsDestroyed("Truppname501")  and IsDestroyed("Truppname502") then
            if Counter.Tick2("ArmyBarracks2_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname50"..i)
                    AddWaypoints("Truppname50"..i, {"id8_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname50"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname503") and IsDestroyed("Truppname504") and IsDestroyed("Truppname505") then
            if Counter.Tick2("ArmyBarracks2_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderPoleArm4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname50"..i)
                    AddWaypoints("Truppname50"..i, {"id8_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname50"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("barracks2_id8") then
        return true
    end
end 

StartSimpleJob("ArmyBarracks2_ID8")

        
----------------------------------ID8 Archery2 ---------------------------------------------------------------------------------

function ArmyArchery2_ID8()
    if IsExisting("archery2_id8") then
    local SpawnPos = GetPosition("spawn_archery2_id8")
        if IsDestroyed("Truppname510") and IsDestroyed("Truppname511")  and IsDestroyed("Truppname512") then
            if Counter.Tick2("ArmyArchery2_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname51"..i)
                    AddWaypoints("Truppname51"..i, {"id8_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname51"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname513") and IsDestroyed("Truppname514") and IsDestroyed("Truppname515") then
            if Counter.Tick2("ArmyArchery2_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname51"..i)
                    AddWaypoints("Truppname51"..i, {"id8_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname51"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("archery2_id8") then
        return true
    end
end 

StartSimpleJob("ArmyArchery2_ID8")


----------------------------------ID8 Foundry2 ---------------------------------------------------------------------------------

function ArmyFoundry2_ID8()
    if IsExisting("foundry2_id8") then
    local SpawnPos = GetPosition("spawn_foundry2_id8")
        if IsDestroyed("Truppname520") and IsDestroyed("Truppname521")  and IsDestroyed("Truppname522") then
            if Counter.Tick2("ArmyFoundry2_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname52"..i)
                    AddWaypoints("Truppname52"..i, {"id8_attack_target5", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname523") and IsDestroyed("Truppname524") and IsDestroyed("Truppname525") then
            if Counter.Tick2("ArmyFoundry2_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon1, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname52"..i)
                    AddWaypoints("Truppname52"..i, {"id8_attack_target5", loop=true})
                end
            end
        end
    end
    if IsDead("foundry2_id8") then
        return true
    end
end 

StartSimpleJob("ArmyFoundry2_ID8")

      
----------------------------------ID8 Foundry3 ---------------------------------------------------------------------------------

function ArmyFoundry3_ID8()
    if IsExisting("foundry3_id8") then
    local SpawnPos = GetPosition("spawn_foundry3_id8")
        if IsDestroyed("Truppname530") and IsDestroyed("Truppname531")  and IsDestroyed("Truppname532") then
            if Counter.Tick2("ArmyFoundry3_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname53"..i)
                    AddWaypoints("Truppname53"..i, {"id8_attack_target6", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname533") and IsDestroyed("Truppname534") and IsDestroyed("Truppname535") then
            if Counter.Tick2("ArmyFoundry3_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon1, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname53"..i)
                    AddWaypoints("Truppname53"..i, {"id8_attack_target6", loop=true})
                end
            end
        end
    end
    if IsDead("foundry3_id8") then
        return true
    end
end 

StartSimpleJob("ArmyFoundry3_ID8")

       
        
end