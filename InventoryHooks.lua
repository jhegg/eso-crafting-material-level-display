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

    if tradeSkillType == CRAFTING_TYPE_ENCHANTING
            and itemType ~= ITEMTYPE_GLYPH_ARMOR
            and itemType ~= ITEMTYPE_GLYPH_JEWELRY
            and itemType ~= ITEMTYPE_GLYPH_WEAPON then
        -- Does not need to account for the created Glyphs, just the runes
        if CraftingMaterialLevelDisplay.savedVariables.enchanting then
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

function CraftingMaterialLevelDisplay.HookInventoryLists()
    for _,inventoryList in pairs(inventoryLists) do
        if inventoryList and inventoryList.dataTypes and inventoryList.dataTypes[1] then
            local existingCallbackFunction = inventoryList.dataTypes[1].setupCallback
            inventoryList.dataTypes[1].setupCallback = function(rowControl, slot)
                existingCallbackFunction(rowControl, slot)

                local inventorySlot = rowControl.dataEntry.data
                local slotIndex = "slotIndex" and inventorySlot["slotIndex"] or nil
                local bagId = inventorySlot["bagId"]
                local itemId = CraftingMaterialLevelDisplay.GetItemIdFromBagAndSlot(bagId, slotIndex)
                local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)

                if CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList then
                    AddCraftingMaterialLevelToInventoryRow(rowControl, tradeSkillType, itemType, itemId)
                end
            end
        end
    end
end
