local function getLabelForInventoryRowControl(row, itemId)
    local label = CraftingMaterialLevelDisplay.currentInventoryRows[row:GetName()]
    if not label then
        label = WINDOW_MANAGER:CreateControl(row:GetName() .. "CMLD", row, CT_LABEL)
        CraftingMaterialLevelDisplay.currentInventoryRows[row:GetName()] = label
    end
    label:SetText(itemId)
    label:SetFont("ZoFontGame")
    label:ClearAnchors()
    label:SetHidden(true)
    return label
end

local function IsTheRowRectangular(rowControl)
    return rowControl:GetWidth() / rowControl:GetHeight() > 1.5
end

local function DisplayTheLabel(rowControl, labelControl, text)
    if IsTheRowRectangular(rowControl) then
        labelControl:SetText(text)
        labelControl:SetAnchor(RIGHT, rowControl, RIGHT, -100)
        labelControl:SetHidden(false)
    end
end

local function AddCraftingMaterialLevelToInventoryRow(rowControl, tradeSkillType, itemType, itemId)
    local label = getLabelForInventoryRowControl(rowControl, itemId)

    if tradeSkillType == CRAFTING_TYPE_CLOTHIER then
        if CraftingMaterialLevelDisplay.savedVariables.clothingInventoryList then
            if ClothingMaterials[itemId] and ClothingMaterials[itemId].level ~= nil then
                DisplayTheLabel(rowControl, label, "["..ClothingMaterials[itemId].level.."]")
            end
        end

    elseif tradeSkillType == CRAFTING_TYPE_BLACKSMITHING then
        if CraftingMaterialLevelDisplay.savedVariables.blacksmithingInventoryList then
            if BlacksmithingMaterials[itemId] and BlacksmithingMaterials[itemId].level ~= nil then
                DisplayTheLabel(rowControl, label, "["..BlacksmithingMaterials[itemId].level.."]")
            end
        end

    elseif tradeSkillType == CRAFTING_TYPE_WOODWORKING then
        if CraftingMaterialLevelDisplay.savedVariables.woodworkingInventoryList then
            if WoodworkingMaterials[itemId] and WoodworkingMaterials[itemId].level ~= nil then
                DisplayTheLabel(rowControl, label, "["..WoodworkingMaterials[itemId].level.."]")
            end
        end

    elseif tradeSkillType == CRAFTING_TYPE_ENCHANTING
            and itemType ~= ITEMTYPE_GLYPH_ARMOR
            and itemType ~= ITEMTYPE_GLYPH_JEWELRY
            and itemType ~= ITEMTYPE_GLYPH_WEAPON then
        -- Does not need to account for the created Glyphs, just the runes
        if CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList then
            if EnchantingMaterials[itemId] and EnchantingMaterials[itemId].level ~= nil then
                DisplayTheLabel(rowControl, label, "["..EnchantingMaterials[itemId].level.."]")
            end
        end
    end
end

-- See PLAYER_INVENTORY["bagToInventoryType"] for the mappings from bag constants to inventory IDs
local inventoryLists = {
    ["backpackListView"] = PLAYER_INVENTORY.inventories[1].listView,
    ["bankListView"] = PLAYER_INVENTORY.inventories[3].listView,
    ["guildBankListView"] = PLAYER_INVENTORY.inventories[4].listView,
    ["enchantingTableListView"] = ENCHANTING.inventory.list,
}

local function GetTradeSkillTypeFromItemId(itemId)
    -- in 1.3.0 it will be possible to get all info from itemLink,
    -- but until then, look for the item in known materials
    if not itemId then
        return nil
    elseif BlacksmithingMaterials[itemId] then
        return CRAFTING_TYPE_BLACKSMITHING
    elseif ClothingMaterials[itemId] then
        return CRAFTING_TYPE_CLOTHIER
    elseif EnchantingMaterials[itemId] then
        return CRAFTING_TYPE_ENCHANTING
    elseif WoodworkingMaterials[itemId] then
        return CRAFTING_TYPE_WOODWORKING
    else
        return nil
    end
end

local function HookNormalInventoryLists()
    for _,inventoryList in pairs(inventoryLists) do
        if inventoryList and inventoryList.dataTypes and inventoryList.dataTypes[1] then
            local existingCallbackFunction = inventoryList.dataTypes[1].setupCallback
            inventoryList.dataTypes[1].setupCallback = function(rowControl, slot)
                existingCallbackFunction(rowControl, slot)
                local slotIndex = "slotIndex" and slot["slotIndex"] or nil
                local bagId = slot["bagId"]
                local itemId = CraftingMaterialLevelDisplay.GetItemIdFromBagAndSlot(bagId, slotIndex)
                local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)
                AddCraftingMaterialLevelToInventoryRow(rowControl, tradeSkillType, itemType, itemId)
            end
        end
    end
end

local function HookLootWindowInventoryList()
    local existingCallbackFunction = LOOT_WINDOW.list.dataTypes[1].setupCallback
    LOOT_WINDOW.list.dataTypes[1].setupCallback = function(rowControl, slot)
        existingCallbackFunction(rowControl, slot)
        local itemLink = GetLootItemLink(slot.lootId)
        local itemId = CraftingMaterialLevelDisplay.GetItemIdFromLink(itemLink)
        local tradeSkillType = GetTradeSkillTypeFromItemId(itemId)
        AddCraftingMaterialLevelToInventoryRow(rowControl, tradeSkillType, nil, itemId)
    end
end

function CraftingMaterialLevelDisplay.HookInventoryLists()
    if CraftingMaterialLevelDisplay.savedVariables.showLevelsInInventoryLists then
        HookNormalInventoryLists()
        HookLootWindowInventoryList()
    end
end
