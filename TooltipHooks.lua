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

function CraftingMaterialLevelDisplay.HookTooltips()
    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)

        if tradeSkillType == CRAFTING_TYPE_PROVISIONING then
            if CraftingMaterialLevelDisplay.savedVariables.provisioning then
                AddTooltipLineForProvisioningMaterial(control, GetItemIdFromBagAndSlot(bagId, slotIndex))
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
