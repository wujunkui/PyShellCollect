require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/storeroom.zip"),
	Asset("ANIM", "anim/ui_chest_4x5.zip"),
	Asset("ANIM", "anim/ui_chest_5x8.zip"),
	Asset("ANIM", "anim/ui_chest_5x12.zip"),
	Asset("ANIM", "anim/ui_chest_5x16.zip"),
}

local function onopen(inst) 
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	inst.AnimState:PlayAnimation("open")
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("closed")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed", true)
	inst.components.container:DropEverything() 
	inst.components.container:Close()
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed")
end

	local slotpos = {}
	if mod_slots==20 then
		for y = 3, 0, -1 do
		for x = 0, 4 do
		table.insert(slotpos, Vector3(80*x-346*2+90, 80*y-100*2+130,0))
		end
		end
	elseif mod_slots==40 then
		for y = 4, 0, -1 do
		for x = 0, 7 do
		table.insert(slotpos, Vector3(80*x-346*2+109, 80*y-100*2+42,0))
		end
		end
	elseif mod_slots==60 then
		for y = 4, 0, -1 do
		for x = 0, 11 do
		table.insert(slotpos, Vector3(80*x-346*2+98, 80*y-100*2+42,0))
		end
		end
	else
		for y = 4, 0, -1 do
		for x = 0, 15 do
		table.insert(slotpos, Vector3(80*x-346*2+91, 80*y-100*2+42,0))
		end
		end
	end

local function updatelight(inst)

end

local function LongUpdate(inst)
    updatelight(inst)
end 

local function fn(Sim)
	local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon("storeroom.tex")

		MakeObstaclePhysics(inst, 1.2)

		inst.AnimState:SetBank("storeroom")
		inst.AnimState:SetBuild("storeroom")
		inst.AnimState:PlayAnimation("closed", true)
		--inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )

		inst:AddComponent("inspectable")
		inst:AddComponent("container")
		inst.components.container:SetNumSlots(#slotpos)

		inst.components.container.onopenfn = onopen
		inst.components.container.onclosefn = onclose

		inst.components.container.widgetslotpos = slotpos
		inst.components.container.side_align_tip = 160

		inst:AddComponent("lootdropper")
		-- destroyable option
		if yees then
			inst:AddComponent("workable")
			inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
			inst.components.workable:SetWorkLeft(5)
			inst.components.workable:SetOnFinishCallback(onhammered)
			inst.components.workable:SetOnWorkCallback(onhit)
		end
	return inst
end

return Prefab( "common/cupboard", fn, assets),
			 MakePlacer("common/cupboard_placer", "storeroom", "storeroom", "closed") 