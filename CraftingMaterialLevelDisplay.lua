CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay",
    savedVariables,
    defaultSavedVariables = {
        provisioning = true,
        provisioningFlavor = true,
        enchanting = true,
        alchemy = true,
        enchantingInventoryList = true,
    },
    slotLines = {}
}

local function BuildAddonMenu()
    local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
    local panelId = LAM:CreateControlPanel(CraftingMaterialLevelDisplay.name.."ControlPanel", "Crafting Material Level Display")
    LAM:AddHeader(panelId, CraftingMaterialLevelDisplay.name.."ControlPanelHeader", "By Marihk")

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."ProvisioningCheckbox",
        "Show Provisioning tooltips",
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
        "Show Enchanting tooltips",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.enchanting end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.enchanting =
            not CraftingMaterialLevelDisplay.savedVariables.enchanting
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."EnchantingInvCheckbox",
        "Show Enchanting levels in inventory",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList =
            not CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList
        end,
        true,
        "Requires /reloadui to take effect")
end

local function InitializeSavedVariables()
    CraftingMaterialLevelDisplay.savedVariables = ZO_SavedVars:New("CMLD_SavedVariables", 1, nil,
        CraftingMaterialLevelDisplay.defaultSavedVariables)
end

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
    local label = CraftingMaterialLevelDisplay.slotLines[row:GetName()]
    if not label then
        label = WINDOW_MANAGER:CreateControl(row:GetName() .. "CMLD", row, CT_LABEL)
        CraftingMaterialLevelDisplay.slotLines[row:GetName()] = label
    end
    return label
end

local function GetItemIdFromLink(itemLink)
    local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
    return tonumber(itemId)
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
                label:SetAnchor(RIGHT, rowControl, RIGHT, -50)
                label:SetHidden(false)
            end
        end
    end
end

local function HookInventory()
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

local function onLoad(_, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end
    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);
    InitializeSavedVariables()
    BuildAddonMenu()
    CraftingMaterialLevelDisplay.HookTooltips()
    HookInventory()
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
