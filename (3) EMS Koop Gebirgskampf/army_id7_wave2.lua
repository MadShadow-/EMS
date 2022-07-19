
function ActivateArmyId7_Wave2()

  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end


-------------------------------------ID7 Barracks2-------------------------------------------------------------------------------------
function ArmyBarracks2_ID7()
    if IsExisting("barracks2_id7") then
    local SpawnPos = GetPosition("spawn_barracks2_id7")
        if IsDestroyed("Truppname280") and IsDestroyed("Truppname281")  and IsDestroyed("Truppname282") then
            if Counter.Tick2("ArmyBarracks2_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderSword3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname28"..i)
                    AddWaypoints("Truppname28"..i, {"id7_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname28"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname283") and IsDestroyed("Truppname284") and IsDestroyed("Truppname285") then
            if Counter.Tick2("ArmyBarracks2_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderPoleArm4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname28"..i)
                    AddWaypoints("Truppname28"..i, {"id7_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname28"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("barracks2_id7") then
        return true
    end
end 

StartSimpleJob("ArmyBarracks2_ID7")


    
----------------------------------ID7 Archery2 ---------------------------------------------------------------------------------

function ArmyArchery2_ID7()
    if IsExisting("archery2_id7") then
    local SpawnPos = GetPosition("spawn_archery2_id7")
        if IsDestroyed("Truppname290") and IsDestroyed("Truppname291")  and IsDestroyed("Truppname292") then
            if Counter.Tick2("ArmyArchery2_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname29"..i)
                    AddWaypoints("Truppname29"..i, {"id7_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname29"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname293") and IsDestroyed("Truppname294") and IsDestroyed("Truppname295") then
            if Counter.Tick2("ArmyArchery2_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderRifle1, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname29"..i)
                    AddWaypoints("Truppname29"..i, {"id7_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname29"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("archery2_id7") then
        return true
    end
end 

StartSimpleJob("ArmyArchery2_ID7")

        
----------------------------------ID7 Foundry2 ---------------------------------------------------------------------------------

function ArmyFoundry2_ID7()
    if IsExisting("foundry2_id7") then
    local SpawnPos = GetPosition("spawn_foundry2_id7")
        if IsDestroyed("Truppname300") and IsDestroyed("Truppname301")  and IsDestroyed("Truppname302") then
            if Counter.Tick2("ArmyFoundry2_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname30"..i)
                    AddWaypoints("Truppname30"..i, {"id7_attack_target6", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname303") and IsDestroyed("Truppname304") and IsDestroyed("Truppname305") then
            if Counter.Tick2("ArmyFoundry2_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon1, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname30"..i)
                    AddWaypoints("Truppname30"..i, {"id7_attack_target6", loop=true})
                end
            end
        end
    end
    if IsDead("foundry2_id7") then
        return true
    end
end 

StartSimpleJob("ArmyFoundry2_ID7")


----------------------------------ID7 Foundry3 ---------------------------------------------------------------------------------
    
function ArmyFoundry3_ID7()
    if IsExisting("foundry3_id7") then
    local SpawnPos = GetPosition("spawn_foundry3_id7")
        if IsDestroyed("Truppname310") and IsDestroyed("Truppname311")  and IsDestroyed("Truppname312") then
            if Counter.Tick2("ArmyFoundry3_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon2, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname31"..i)
                    AddWaypoints("Truppname31"..i, {"id7_attack_target7", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname313") and IsDestroyed("Truppname314") and IsDestroyed("Truppname315") then
            if Counter.Tick2("ArmyFoundry3_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon1, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname31"..i)
                    AddWaypoints("Truppname31"..i, {"id7_attack_target7", loop=true})
                end
            end
        end
    end
    if IsDead("foundry3_id7") then
        return true
    end
end 

StartSimpleJob("ArmyFoundry3_ID7")
  
    
end
    

