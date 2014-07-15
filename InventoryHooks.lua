local backpackListView = PLAYER_INVENTORY.inventories[1].listView
local bankListView = PLAYER_INVENTORY.inventories[3].listView
local guildBankListView = PLAYER_INVENTORY.inventories[4].listView
local lootWindowListView = LOOT_WINDOW.list

local inventoriesToItemLookupFunctions = {
    [backpackListView] = {GetItemLink, "bagId", "slotIndex"},
    [bankListView] = {GetItemLink, "bagId", "slotIndex"},
    [guildBankListView] = {GetItemLink, "bagId", "slotIndex"},
    [lootWindowListView] = {GetLootItemLink, "lootId", nil}
}

local function getLabelForInventoryRowControl(row)
    local label = CraftingMaterialLevelDisplay.currentInventoryRows[row:GetName()]
    if not label then
        label = WINDOW_MANAGER:CreateControl(row:GetName() .. "CMLD", row, CT_LABEL)
        CraftingMaterialLevelDisplay.currentInventoryRows[row:GetName()] = label
    end
    return label
end

local function GetItemIdFromLink(itemLink)
    local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
    return tonumber(itemId)
end

local function IsTheRowRectangular(rowControl)
    return rowControl:GetWidth() / rowControl:GetHeight() > 1.5
end

local function AddEnchantingLevelToInventoryRow(rowControl, lookupFunctions)
    local getItemLinkFunction = lookupFunctions[1]
    local inventorySlot = rowControl.dataEntry.data
    local bagId = inventorySlot[lookupFunctions[2]]
    local inventorySlotIndex = lookupFunctions[3] and inventorySlot[lookupFunctions[3]] or nil
    local itemId = GetItemIdFromLink(getItemLinkFunction(bagId, inventorySlotIndex))
    local label = getLabelForInventoryRowControl(rowControl)
    label:SetText(itemId)
    label:SetFont("ZoFontGame")
    label:ClearAnchors()
    label:SetHidden(true)

    local tradeSkillType, itemType = GetItemCraftingInfo(bagId, inventorySlotIndex)
    if tradeSkillType == CRAFTING_TYPE_ENCHANTING
            and itemType ~= ITEMTYPE_GLYPH_ARMOR
            and itemType ~= ITEMTYPE_GLYPH_JEWELRY
            and itemType ~= ITEMTYPE_GLYPH_WEAPON then
        -- Does not need to account for the created Glyphs, just the runes
        if CraftingMaterialLevelDisplay.savedVariables.enchanting then
            if EnchantingMaterials[itemId].level ~= nil then
                label:SetText(EnchantingMaterials[itemId].level)
                if IsTheRowRectangular(rowControl) then
                    label:SetAnchor(RIGHT, rowControl, RIGHT, -50)
                    label:SetHidden(false)
                end
            end
        end
    end
end

function CraftingMaterialLevelDisplay.HookInventory()
    for inventoryList, lookupFunctions in pairs(inventoriesToItemLookupFunctions) do
        if inventoryList and inventoryList.dataTypes and inventoryList.dataTypes[1] then
            local existingCallbackFunction = inventoryList.dataTypes[1].setupCallback
            inventoryList.dataTypes[1].setupCallback = function(rowControl, slot)
                existingCallbackFunction(rowControl, slot)
                if CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList then
                    AddEnchantingLevelToInventoryRow(rowControl, lookupFunctions)
                end
            end
        end
    end
end
