CraftingMaterialLevelDisplay = {
    name = "CraftingMaterialLevelDisplay",
    savedVariables,
    defaultSavedVariables = {
        provisioning = true,
        provisioningFlavor = true,
        provisioningLabelColors = true,
        enchanting = true,
        alchemy = true,
        showLevelsInInventoryLists = true,
        blacksmithingInventoryList = true,
        clothingInventoryList = true,
        enchantingInventoryList = true,
        woodworkingInventoryList = true,
    },
    currentInventoryRows = {}
}

function CraftingMaterialLevelDisplay.GetItemIdFromLink(itemLink)
    local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
    return tonumber(itemId)
end

function CraftingMaterialLevelDisplay.GetItemIdFromBagAndSlot(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex)
    return CraftingMaterialLevelDisplay.GetItemIdFromLink(itemLink)
end

local function HideCurrentInventoryRows()
    for _,labelControl in pairs(CraftingMaterialLevelDisplay.currentInventoryRows) do
        labelControl:SetHidden(true)
    end
end

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
        CraftingMaterialLevelDisplay.name.."ProvisioningLabelCheckbox",
        "Show Provisioning label colors",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.provisioningLabelColors end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.provisioningLabelColors =
            not CraftingMaterialLevelDisplay.savedVariables.provisioningLabelColors
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
        CraftingMaterialLevelDisplay.name.."InvListCheckbox",
        "Show levels in inventory lists",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.showLevelsInInventoryLists end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.showLevelsInInventoryLists =
                not CraftingMaterialLevelDisplay.savedVariables.showLevelsInInventoryLists
        end,
        true,
        "Requires /reloadui to take effect, prevents the inventory list hook code from even executing, useful if errors happen")

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."EnchantingInvCheckbox",
        "Show Enchanting levels in inventory",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList =
                not CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList
            if not CraftingMaterialLevelDisplay.savedVariables.enchantingInventoryList then
                HideCurrentInventoryRows()
            end
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."BlacksmithingInvCheckbox",
        "Show Blacksmithing levels in inventory",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.blacksmithingInventoryList end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.blacksmithingInventoryList =
                not CraftingMaterialLevelDisplay.savedVariables.blacksmithingInventoryList
            if not CraftingMaterialLevelDisplay.savedVariables.blacksmithingInventoryList then
                HideCurrentInventoryRows()
            end
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."ClothingInvCheckbox",
        "Show Clothing levels in inventory",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.clothingInventoryList end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.clothingInventoryList =
                not CraftingMaterialLevelDisplay.savedVariables.clothingInventoryList
            if not CraftingMaterialLevelDisplay.savedVariables.clothingInventoryList then
                HideCurrentInventoryRows()
            end
        end)

    LAM:AddCheckbox(panelId,
        CraftingMaterialLevelDisplay.name.."WoodworkingInvCheckbox",
        "Show Woodworking levels in inventory",
        nil,
        function() return CraftingMaterialLevelDisplay.savedVariables.woodworkingInventoryList end,
        function()
            CraftingMaterialLevelDisplay.savedVariables.woodworkingInventoryList =
                not CraftingMaterialLevelDisplay.savedVariables.woodworkingInventoryList
            if not CraftingMaterialLevelDisplay.savedVariables.woodworkingInventoryList then
                HideCurrentInventoryRows()
            end
        end)
end

local function InitializeSavedVariables()
    CraftingMaterialLevelDisplay.savedVariables = ZO_SavedVars:New("CMLD_SavedVariables", 1, nil,
        CraftingMaterialLevelDisplay.defaultSavedVariables)
end

local function onLoad(_, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end
    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);
    InitializeSavedVariables()
    BuildAddonMenu()
    CraftingMaterialLevelDisplay.HookTooltips()
    CraftingMaterialLevelDisplay.HookInventoryLists()
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
