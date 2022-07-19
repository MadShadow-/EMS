function ActivateArmyId7_Wave3()
  

    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
  
-------------------------------------ID7 Barracks1-------------------------------------------------------------------------------------

function ArmyWave3Barracks1_ID7()
    if IsExisting("b1_id7") then
    local SpawnPos = GetPosition("spawn_b1_id7")
        if IsDestroyed("Truppname320") and IsDestroyed("Truppname321")  and IsDestroyed("Truppname322") then
            if Counter.Tick2("ArmyWave3Barracks1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname32"..i)
                    AddWaypoints("Truppname32"..i, {"id7_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname32"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname323") and IsDestroyed("Truppname324") and IsDestroyed("Truppname325") then
            if Counter.Tick2("ArmyWave3Barracks1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderPoleArm4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname32"..i)
                    AddWaypoints("Truppname32"..i, {"id7_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname32"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("b1_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Barracks1_ID7")


 -------------------------------------ID7 Archery1-------------------------------------------------------------------------------------

 function ArmyWave3Archery1_ID7()
    if IsExisting("a1_id7") then
    local SpawnPos = GetPosition("spawn_a1_id7")
        if IsDestroyed("Truppname330") and IsDestroyed("Truppname331")  and IsDestroyed("Truppname332") then
            if Counter.Tick2("ArmyWave3Archery1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderBow3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname33"..i)
                    AddWaypoints("Truppname33"..i, {"id7_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname33"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname333") and IsDestroyed("Truppname334") and IsDestroyed("Truppname335") then
            if Counter.Tick2("ArmyWave3Archery1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderRifle1, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname33"..i)
                    AddWaypoints("Truppname33"..i, {"id7_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname33"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("a1_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Archery1_ID7")


    
----------------------------------ID7 Foundry1 ---------------------------------------------------------------------------------

function ArmyWave3Foundry1_ID7()
    if IsExisting("f1_id7") then
    local SpawnPos = GetPosition("spawn_f1_id7")
        if IsDestroyed("Truppname340") and IsDestroyed("Truppname341")  and IsDestroyed("Truppname342") then
            if Counter.Tick2("ArmyWave3Foundry1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname34"..i)
                    AddWaypoints("Truppname34"..i, {"id7_attack_target3", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname343") and IsDestroyed("Truppname344") and IsDestroyed("Truppname345") then
            if Counter.Tick2("ArmyWave3Foundry1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname34"..i)
                    AddWaypoints("Truppname34"..i, {"id7_attack_target3", loop=true})
                end
            end
        end
    end
    if IsDead("f1_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Foundry1_ID7")

    
----------------------------------ID7 Foundry2 ---------------------------------------------------------------------------------

function ArmyWave3Foundry2_ID7()
    if IsExisting("f2_id7") then
    local SpawnPos = GetPosition("spawn_f2_id7")
        if IsDestroyed("Truppname350") and IsDestroyed("Truppname351")  and IsDestroyed("Truppname352") then
            if Counter.Tick2("ArmyWave3Foundry2_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname35"..i)
                    AddWaypoints("Truppname35"..i, {"id7_attack_target4", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname353") and IsDestroyed("Truppname354") and IsDestroyed("Truppname355") then
            if Counter.Tick2("ArmyWave3Foundry2_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname35"..i)
                    AddWaypoints("Truppname35"..i, {"id7_attack_target4", loop=true})
                end
            end
        end
    end
    if IsDead("f2_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Foundry2_ID7")


----------------------------------ID7 Castle ---------------------------------------------------------------------------------

function ArmyWave3Castle1_ID7()
    if IsExisting("c1_id7") then
    local SpawnPos = GetPosition("spawn_c1_id7")
        if IsDestroyed("Truppname360") and IsDestroyed("Truppname361")  and IsDestroyed("Truppname362") then
            if Counter.Tick2("ArmyWave3Castle1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname36"..i)
                    AddWaypoints("Truppname36"..i, {"id7_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname36"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname363") and IsDestroyed("Truppname364") and IsDestroyed("Truppname365") then
            if Counter.Tick2("ArmyWave3Castle1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname36"..i)
                    AddWaypoints("Truppname36"..i, {"id7_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname36"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("c1_id7") then
        return true
    end
end 

    StartSimpleJob("ArmyWave3Castle1_ID7")

       
end