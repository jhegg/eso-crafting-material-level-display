local CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay",
    savedVariables,
    defaultSavedVariables = {
        provisioning = true,
    },
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

local function AddTooltipLineForEnchantingMaterial(control, itemId)
    if EnchantingMaterials[itemId] then
        -- Ignore the Aspect runes until I have information worth displaying
        if EnchantingMaterials[itemId].aspect ~= nil then return end

        AddTooltipLine(control, EnchantingMaterials[itemId].tooltip)
    else
        OutputErrorForMissingItemId(itemId)
    end
end

local function GetItemIdFromBagAndSlot(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex)
    local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
    return tonumber(itemId)
end

local function BuildAddonMenu()
    local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
    local panelId = LAM:CreateControlPanel(CraftingMaterialLevelDisplay.name.."ControlPanel", "Crafting Material Level Display")
    LAM:AddHeader(panelId, CraftingMaterialLevelDisplay.name.."ControlPanelHeader", "By Marihk")

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."ProvisioningCheckbox",
        "Show Provisioning levels",
        "Turn off if another mod provides the same or better information.",
        function() return CraftingMaterialLevelDisplay.savedVariables.provisioning end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.provisioning =
                not CraftingMaterialLevelDisplay.savedVariables.provisioning
        end)
end

local function InitializeSavedVariables()
    CraftingMaterialLevelDisplay.savedVariables = ZO_SavedVars:New("CMLD_SavedVariables", 1, nil,
        CraftingMaterialLevelDisplay.defaultSavedVariables)
end

local function HookTooltips()
    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)

        if tradeSkillType == CRAFTING_TYPE_PROVISIONING then
            if CraftingMaterialLevelDisplay.savedVariables.provisioning then
                AddTooltipLineForProvisioningMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end

        elseif tradeSkillType == CRAFTING_TYPE_WOODWORKING then
            AddTooltipLineForWoodworkingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))

        elseif tradeSkillType == CRAFTING_TYPE_BLACKSMITHING then
            AddTooltipLineForBlacksmithingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))

        elseif tradeSkillType == CRAFTING_TYPE_CLOTHIER then
            AddTooltipLineForClothingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))

        elseif tradeSkillType == CRAFTING_TYPE_ENCHANTING
                and itemType ~= ITEMTYPE_GLYPH_ARMOR
                and itemType ~= ITEMTYPE_GLYPH_JEWELRY
                and itemType ~= ITEMTYPE_GLYPH_WEAPON then
            -- Does not need to account for the created Glyphs, just the runes
            AddTooltipLineForEnchantingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
        end
    end
end

local function onLoad(event, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end
    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);
    InitializeSavedVariables()
    BuildAddonMenu()
    HookTooltips()
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
