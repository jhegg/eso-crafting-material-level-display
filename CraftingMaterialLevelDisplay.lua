local CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay"
}

local function AddTooltipLine(control, tooltipLine)
    control:AddVerticalPadding(20)
    control:AddLine(tooltipLine, "ZoFontGame", 1, 1, 1, CENTER, MODIFY_TEXT_TYPE_NONE, LEFT, false)
end

local function OutputErrorForMissingItemId(itemId)
    d("Unknown crafting item ID "..itemId.." - please submit a bug for CraftingMaterialLevelDisplay")
end

local function AddTooltipLineForProvisioningMaterial(control, itemId)
    if ProvisioningMaterials[itemId] then
        AddTooltipLine(control, ProvisioningMaterials[itemId].tooltip)
    else
        OutputErrorForMissingItemId(itemId)
    end
end

local function AddTooltipLineForWoodworkingMaterial(control, itemId)
    if WoodworkingMaterials[itemId] then
        -- Ignore the Resin items until I have information worth displaying
        if WoodworkingMaterials[itemId].resin ~= nil then return end

        AddTooltipLine(control, WoodworkingMaterials[itemId].tooltip)
    else
        OutputErrorForMissingItemId(itemId)
    end
end

local function AddTooltipLineForBlacksmithingMaterial(control, itemId)
    if BlacksmithingMaterials[itemId] then
        -- Ignore the Temper items until I have information worth displaying
        if BlacksmithingMaterials[itemId].temper ~= nil then return end

        AddTooltipLine(control, BlacksmithingMaterials[itemId].tooltip)
    else
        OutputErrorForMissingItemId(itemId)
    end
end

local function AddTooltipLineForClothingMaterial(control, itemId)
    if ClothingMaterials[itemId] then
        -- Ignore the Tannin items until I have information worth displaying
        if ClothingMaterials[itemId].tannin ~= nil then return end

        AddTooltipLine(control, ClothingMaterials[itemId].tooltip)
    else
        OutputErrorForMissingItemId(itemId)
    end
end

local function GetItemIdFromBagAndSlot(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex)
    local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
    return tonumber(itemId)
end

local function onLoad(event, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end

    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);

    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        local tradeSkillType = GetItemCraftingInfo(bagId, slotIndex)
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)
        if tradeSkillType == CRAFTING_TYPE_PROVISIONING then
            AddTooltipLineForProvisioningMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
        elseif tradeSkillType == CRAFTING_TYPE_WOODWORKING then
            AddTooltipLineForWoodworkingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
        elseif tradeSkillType == CRAFTING_TYPE_BLACKSMITHING then
            AddTooltipLineForBlacksmithingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
        elseif tradeSkillType == CRAFTING_TYPE_CLOTHIER then
            AddTooltipLineForClothingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
        end
    end
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
