function ActivateArmyId6_Wave4()
  
  
-------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------
    
        ArmyWave4Barracks1_ID6 = UnlimitedArmy:New({					
                -- benötigt
                Player = 6,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                        })
                
                        SpawnerArmyWave4Barracks1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Barracks1_ID6, {
                            -- benötigt:
                            Position = GetPosition("spawn_end_b1_id6"), --position
                            ArmySize = 8, --armysize
                            SpawnCounter = 20,  --spawncounter
                            SpawnLeaders = 5,   --spawnleaders
                            LeaderDesc = {
                                {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                {LeaderType = Entities.CU_BlackKnight_LeaderMace1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                                {LeaderType = Entities.CU_Barbarian_LeaderClub1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                                {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                                {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            },
                            -- optional:
                            Generator = "end_b1_id6",  --generator
                        })


-------------------------------------ID6 Barracks2-------------------------------------------------------------------------------------
    
ArmyWave4Barracks2_ID6 = UnlimitedArmy:New({					
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
            })

            SpawnerArmyWave4Barracks2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Barracks2_ID6, {
                -- benötigt:
                Position = GetPosition("spawn_end_b2_id6"), --position
                ArmySize = 8, --armysize
                SpawnCounter = 20,  --spawncounter
                SpawnLeaders = 5,   --spawnleaders
                LeaderDesc = {
                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_BlackKnight_LeaderMace1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_Barbarian_LeaderClub1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.CU_BanditLeaderSword1, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                    {LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                },
                -- optional:
                Generator = "end_b2_id6",  --generator
            })

-------------------------------------ID6 Archery1-------------------------------------------------------------------------------------

            ArmyWave4Archery1_ID6 = UnlimitedArmy:New({					
                -- benötigt
                Player = 6,
                Area = 4000,
                -- optional
                AutoDestroyIfEmpty = true,
                TransitAttackMove = true,
                Formation = UnlimitedArmy.Formations.Chaotic,
                LeaderFormation = FormationFunktion,
                AIActive = true,
                AutoRotateRange = 100000,
                    })
            
                    SpawnerArmyWave4Archery1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Archery1_ID6, {
                        -- benötigt:
                        Position = GetPosition("spawn_end_a1_id6"), --position
                        ArmySize = 8, --armysize
                        SpawnCounter = 30,  --spawncounter
                        SpawnLeaders = 5,   --spawnleaders
                        LeaderDesc = {
                            {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                            {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                        },
                        -- optional:
                        Generator = "end_a1_id6",  --generator
                    })
            

 -------------------------------------ID7 Archery2-------------------------------------------------------------------------------------

 ArmyWave4Archery2_ID6 = UnlimitedArmy:New({					
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave4Archery2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Archery2_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_end_a2_id6"), --position
            ArmySize = 8, --armysize
            SpawnCounter = 30,  --spawncounter
            SpawnLeaders = 5,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_BanditLeaderBow1, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "end_a2_id6",  --generator
        })


----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------
        
ArmyWave4Foundry1_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave4Foundry1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Foundry1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_end_f1_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 30,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
            },
            -- optional:
            Generator = "end_f1_id6",  --generator
        })   
        
    
----------------------------------ID6 Foundry2 ---------------------------------------------------------------------------------
        
ArmyWave4Foundry2_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave4Foundry2_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Foundry2_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_end_f2_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 30,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon3, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
                {LeaderType = Entities.PV_Cannon4, SoldierNum = 0 , SpawnNum = 1, Looped = true, Experience = 0},
            },
            -- optional:
            Generator = "end_f2_id6",  --generator
        })  
----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------
        
 ArmyWave4Tower1_ID6 = UnlimitedArmy:New({					
    
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave4Tower1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Tower1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_end_t1_id6"), --position
            ArmySize = 6, --armysize
            SpawnCounter = 40,  --spawncounter
            SpawnLeaders = 3,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "end_t1_id6",  --generator
        })   
        





-- ----------------------------------ID6 Stable1 ---------------------------------------------------------------------------------
    
 ArmyWave4Stable1_ID6 = UnlimitedArmy:New({					
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = false,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        ArmyWave4Stable1_ID6.SpawnCounter = 0
        ArmyWave4Stable1_ID6.Spawnpos = GetPosition("spawn_end_s1_id6")
        ArmyWave4Stable1_ID6.Generator = "end_s1_id6"
        ArmyWave4Stable1_ID6.giftreiter = 100
        ArmyWave4Stable1_ID6:AddCommandLuaFunc(PoisenReiterAttack,true)

        
        -- SpawnerArmyWave4Stable1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Stable1_ID6, {
        --     -- benötigt:
        --     Position = GetPosition("spawn_end_s1_id6"), --position
        --     ArmySize = 6, --armysize
        --     SpawnCounter = 20,  --spawncounter
        --     SpawnLeaders = 6,   --spawnleaders
        --     LeaderDesc = {
        --         {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
        --         {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
        --         {LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
        --         {LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
        --         {LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 3 , SpawnNum = 1, Looped = true, Experience = 3},
        --     },
        --     -- optional:
        --     Generator = "end_s1_id6",  --generator
        -- })



----------------------------------ID6 Castle ---------------------------------------------------------------------------------
    
ArmyWave4Castle1_ID6 = UnlimitedArmy:New({					
    -- benötigt
    Player = 6,
    Area = 4000,
    -- optional
    AutoDestroyIfEmpty = true,
    TransitAttackMove = true,
    Formation = UnlimitedArmy.Formations.Chaotic,
    LeaderFormation = FormationFunktion,
    AIActive = true,
    AutoRotateRange = 100000,
        })

        SpawnerArmyWave4Castle1_ID6 = UnlimitedArmySpawnGenerator:New(ArmyWave4Castle1_ID6, {
            -- benötigt:
            Position = GetPosition("spawn_burg_id6"), --position
            ArmySize = 10, --armysize
            SpawnCounter = 30,  --spawncounter
            SpawnLeaders = 5,   --spawnleaders
            LeaderDesc = {
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranMajor, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.CU_VeteranLieutenant, SoldierNum = 4 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
                {LeaderType = Entities.PU_LeaderRifle2, SoldierNum = 8 , SpawnNum = 1, Looped = true, Experience = 3},
            },
            -- optional:
            Generator = "burg_id6",  --generator
        })

--------------------------------ArmyMovesets--------------------------------------------------------------------------------------
        
ArmyWave4Barracks1_ID6: AddCommandMove(GetPosition("id6_attack_target1"), true);
ArmyWave4Barracks2_ID6: AddCommandMove(GetPosition("id6_attack_target2"), true);
ArmyWave4Archery1_ID6: AddCommandMove(GetPosition("id6_attack_target3"), true);
ArmyWave4Archery2_ID6: AddCommandMove(GetPosition("id6_attack_target4"), true);
ArmyWave4Foundry1_ID6: AddCommandMove(GetPosition("id6_attack_target5"), true);
ArmyWave4Foundry2_ID6: AddCommandMove(GetPosition("id6_attack_target7"), true);
ArmyWave4Tower1_ID6: AddCommandMove(GetPosition("id6_attack_target6"), true);
ArmyWave4Stable1_ID6: AddCommandMove(GetPosition("id6_attack_target2"), true);
ArmyWave4Castle1_ID6: AddCommandMove(GetPosition("id6_attack_target4"), true);

    
    
       
    
end


function PoisenReiterAttack(self)
       if IsDead(self.Generator) then
        return true
    end
    if self.SpawnCounter <= 0 then
        local splitter
        for i = 1,4-self:GetSize(true,false),1 do
            if not splitter then
                self:CreateLeaderForArmy(Entities.PU_LeaderHeavyCavalry2,3,self.Spawnpos,3)
            else
                self:CreateLeaderForArmy(Entities.PU_LeaderCavalry2,3,self.Spawnpos,3)
            end
        end
        if self.giftreiter >= 3 then
            for i = 1,3,1 do
                local trooptable = {ID = AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 0, self.Spawnpos.X,self.Spawnpos.Y, nil, nil, 3,0),PoisonCounter = 2}
                self:AddLeader(trooptable.ID)
                table.insert(giftreiter,trooptable)
            end
            self.giftreiter = 0
        else
            self.giftreiter = self.giftreiter + 1
        self.SpawnCounter = 60
    else
        self.SpawnCounter =  self.SpawnCounter - 1
    end
    if self:IsIdle() then
        return true, UnlimitedArmy.CreateCommandMove(GetPosition("id6_attack_target2"))
    end
    return false
end



