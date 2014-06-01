local CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay",
    savedVariables,
    defaultSavedVariables = {
        provisioning = true,
        provisioningFlavor = true,
        woodworking = true,
        blacksmithing = true,
        clothing = true,
        enchanting = true,
        alchemy = true,
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
        local text = ProvisioningMaterials[itemId].tooltip
        if CraftingMaterialLevelDisplay.savedVariables.provisioningFlavor == false then
            if text == "For extra flavor in |c5B90F6blue|r and |cAA00FFpurple|r recipes" then
                text = "Tier 2 Ingredient"
            elseif text == "For extra flavor in |cAA00FFpurple|r recipes" then
                text = "Tier 3 Ingredient"
            end
        end
        AddTooltipLine(control, text)
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

local function AddTooltipLineForAlchemyMaterial(control, itemId)
    if AlchemyMaterials[itemId] then
        -- Ignore the Solvent items until I have information worth displaying
        if AlchemyMaterials[itemId].solvent ~= nil then return end

        AddTooltipLine(control, AlchemyMaterials[itemId].tooltip)
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
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.provisioning end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.provisioning =
                not CraftingMaterialLevelDisplay.savedVariables.provisioning
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."ProvisioningFlavorCheckbox",
        "Use Flavor text instead of Tier 2/3 text",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.provisioningFlavor end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.provisioningFlavor =
            not CraftingMaterialLevelDisplay.savedVariables.provisioningFlavor
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."WoodworkingCheckbox",
        "Show Woodworking levels",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.woodworking end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.woodworking =
            not CraftingMaterialLevelDisplay.savedVariables.woodworking
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."BlacksmithingCheckbox",
        "Show Blacksmithing levels",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.blacksmithing end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.blacksmithing =
            not CraftingMaterialLevelDisplay.savedVariables.blacksmithing
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."ClothingCheckbox",
        "Show Clothing levels",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.clothing end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.clothing =
            not CraftingMaterialLevelDisplay.savedVariables.clothing
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."AlchemyCheckbox",
        "Show Alchemy tooltips",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.alchemy end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.alchemy =
            not CraftingMaterialLevelDisplay.savedVariables.alchemy
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."EnchantingCheckbox",
        "Show Enchanting levels",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.enchanting end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.enchanting =
            not CraftingMaterialLevelDisplay.savedVariables.enchanting
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
            if CraftingMaterialLevelDisplay.savedVariables.woodworking then
                AddTooltipLineForWoodworkingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end

        elseif tradeSkillType == CRAFTING_TYPE_BLACKSMITHING then
            if CraftingMaterialLevelDisplay.savedVariables.blacksmithing then
                AddTooltipLineForBlacksmithingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end

        elseif tradeSkillType == CRAFTING_TYPE_CLOTHIER then
            if CraftingMaterialLevelDisplay.savedVariables.clothing then
                AddTooltipLineForClothingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end

        elseif tradeSkillType == CRAFTING_TYPE_ALCHEMY then
            if CraftingMaterialLevelDisplay.savedVariables.alchemy then
                AddTooltipLineForAlchemyMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end

        elseif tradeSkillType == CRAFTING_TYPE_ENCHANTING
                and itemType ~= ITEMTYPE_GLYPH_ARMOR
                and itemType ~= ITEMTYPE_GLYPH_JEWELRY
                and itemType ~= ITEMTYPE_GLYPH_WEAPON then
            -- Does not need to account for the created Glyphs, just the runes
            if CraftingMaterialLevelDisplay.savedVariables.enchanting then
                AddTooltipLineForEnchantingMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
            end
        end
    end
end

local function onLoad(_, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end
    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);
    InitializeSavedVariables()
    BuildAddonMenu()
    HookTooltips()
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
