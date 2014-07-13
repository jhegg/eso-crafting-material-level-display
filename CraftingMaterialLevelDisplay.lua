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
    currentInventoryRows = {}
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

local function onLoad(_, name)
    if name ~= CraftingMaterialLevelDisplay.name then return end
    EVENT_MANAGER:UnregisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED);
    InitializeSavedVariables()
    BuildAddonMenu()
    CraftingMaterialLevelDisplay.HookTooltips()
    CraftingMaterialLevelDisplay.HookInventory()
end

EVENT_MANAGER:RegisterForEvent(CraftingMaterialLevelDisplay.name, EVENT_ADD_ON_LOADED, onLoad)
