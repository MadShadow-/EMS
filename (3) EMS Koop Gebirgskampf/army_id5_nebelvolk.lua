function ActivateFogWarriors()

    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end



    for i=1,12,1 do
        local j = i
        _G["nv_army"..j] = function()
            if IsExisting("nebel"..j.."_id5") then
            local SpawnPos = GetPosition("spawn_nebel"..j.."_id5")
                if IsDestroyed("Truppname0_"..j) and IsDestroyed("Truppname1_"..j) then
                    if Counter.Tick2("nv1_"..j, RespawnTime) then
                        for g = 0, 1 do
                            SetEntityName(AI.Entity_CreateFormation(5, Entities.CU_Evil_LeaderBearman1, nil, 16, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname"..g.."_"..j)
                            AddWaypoints("Truppname"..g.."_"..j, {"id5_attack_target"..j, loop=true})
                            Logic.LeaderChangeFormationType(GetEntityId("Truppname"..g.."_"..j), math.random(1, 4))
                        end
                    end
                end
                --
                if IsDestroyed("Truppname2_"..j) then
                    if Counter.Tick2("nv2_"..j, RespawnTime) then
                        for g = 2,2 do
                            SetEntityName(AI.Entity_CreateFormation(5, Entities.CU_Evil_LeaderSkirmisher1, nil, 16, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname"..g.."_"..j)
                            AddWaypoints("Truppname"..g.."_"..j, {"id5_attack_target"..j, loop=true})
                            Logic.LeaderChangeFormationType(GetEntityId("Truppname"..g.."_"..j), math.random(1, 4))
                        end
                    end
                end
            end
            if IsDead("nebel"..j.."_id5") then
                return true
            end
        end 
    end

    for i=1,12,1 do
        StartSimpleJob("nv_army"..i)
    end

end