local CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay"
}

local function AddTooltipLineForProvisioningMaterial(control, itemId)
    if ProvisioningMaterials[itemId] then
        control:AddVerticalPadding(20)
        control:AddLine(ProvisioningMaterials[itemId].tooltip, "ZoFontGame", 1, 1, 1, CENTER,
            MODIFY_TEXT_TYPE_NONE, LEFT, false)
    end
end

local function AddTooltipLineForWoodworkingMaterial(control, itemId)
    if WoodworkingMaterials[itemId] then
        control:AddVerticalPadding(20)
        control:AddLine(WoodworkingMaterials[itemId].tooltip, "ZoFontGame", 1, 1, 1, CENTER,
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
            local itemLink = GetItemLink(bagId, slotIndex)
            local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
            AddTooltipLineForProvisioningMaterial(control, tonumber(itemId))
        elseif tradeSkillType == CRAFTING_TYPE_WOODWORKING then
            local itemLink = GetItemLink(bagId, slotIndex)
            local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
            AddTooltipLineForWoodworkingMaterial(control, tonumber(itemId))
        end
    end
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
