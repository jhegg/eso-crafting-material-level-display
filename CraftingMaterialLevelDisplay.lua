local CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay"
}

local function AddTooltipLineForProvisioningMaterial(control, name)
    if ProvisioningMaterials[name] then
        control:AddVerticalPadding(20)
        control:AddLine(ProvisioningMaterials[name].tooltip, "ZoFontGame", 1, 1, 1, CENTER,
            MODIFY_TEXT_TYPE_NONE, LEFT, false)
    end
end

local function onLoad(event, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end

    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);

    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        local tradeSkillType = GetItemCraftingInfo(bagId, slotIndex)
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)
        if tradeSkillType == CRAFTING_TYPE_PROVISIONING then
            local name = zo_strformat("<<1>>", GetItemName(bagId, slotIndex))
            AddTooltipLineForProvisioningMaterial(control, name)
        end
    end
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
