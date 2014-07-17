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

local function GetTradeSkillTypeFromItemId(itemId)
    -- in 1.3.0 it will be possible to get all info from itemLink,
    -- but until then, look for the item in known materials
    if not itemId then
        return nil
    elseif AlchemyMaterials[itemId] then
        return CRAFTING_TYPE_ALCHEMY
    elseif EnchantingMaterials[itemId] then
        return CRAFTING_TYPE_ENCHANTING
    elseif ProvisioningMaterials[itemId] then
        return CRAFTING_TYPE_PROVISIONING
    else
        return nil
    end
end

local function AddTooltipByType(control, tradeSkillType, itemType, itemId)
    if tradeSkillType == CRAFTING_TYPE_PROVISIONING then
        if CraftingMaterialLevelDisplay.savedVariables.provisioning then
            AddTooltipLineForProvisioningMaterial(control, itemId)
        end

    elseif tradeSkillType == CRAFTING_TYPE_ALCHEMY then
        if CraftingMaterialLevelDisplay.savedVariables.alchemy then
            AddTooltipLineForAlchemyMaterial(control, itemId)
        end

    elseif tradeSkillType == CRAFTING_TYPE_ENCHANTING
            and itemType ~= ITEMTYPE_GLYPH_ARMOR
            and itemType ~= ITEMTYPE_GLYPH_JEWELRY
            and itemType ~= ITEMTYPE_GLYPH_WEAPON then
        -- Does not need to account for the created Glyphs, just the runes
        if CraftingMaterialLevelDisplay.savedVariables.enchanting then
            AddTooltipLineForEnchantingMaterial(control, itemId)
        end
    end
end

local function HookBagTooltip()
    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)
        local itemId = CraftingMaterialLevelDisplay.GetItemIdFromBagAndSlot(bagId, slotIndex)
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)
        AddTooltipByType(control, tradeSkillType, itemType, itemId)
    end
end

local function HookLootWindowTooltip()
    -- The idea for this was contributed by merlight at esoui.com; thanks!
    --
    -- hooking InformationTooltip.SetLootItem doesn't work (as of API 100007),
    -- but luckily tinkering with its metatable does ;)
    local InformationTooltip_index = getmetatable(InformationTooltip).__index
    local InvokeSetLootItemTooltip = InformationTooltip_index.SetLootItem
    InformationTooltip_index.SetLootItem = function(control, lootId, ...)
        local itemLink = GetLootItemLink(lootId)
        local itemId = CraftingMaterialLevelDisplay.GetItemIdFromLink(itemLink)
        local tradeSkillType = GetTradeSkillTypeFromItemId(itemId)
        InvokeSetLootItemTooltip(control, lootId, ...)
        AddTooltipByType(control, tradeSkillType, nil, itemId)
    end
end

function CraftingMaterialLevelDisplay.HookTooltips()
    HookBagTooltip()
    HookLootWindowTooltip()
end