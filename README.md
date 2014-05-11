Crafting Material Level Display - v1.0.1
===================================

An Elder Scrolls Online addon that displays the level of crafting materials in the item tooltips (as viewed from your bag or bank).

## What is the purpose of this addon?

It might be best to start with describing what this addon is not meant to do: I don't intend it to replace addons such as [Sous Chef](http://www.esoui.com/downloads/info163-SousChef-ProvisioningHelper.html) or [Harven's Provisioning Tooltips](http://www.esoui.com/downloads/info435-HarvensProvisioningTooltips.html). Those are two great addons that inform you about which ingredients are used by which recipes, which recipes you have on various characters, etc. In fact, if those addons provide a better way of keeping track of Provisioning item levels, then I recommend that you go to the settings menu, find Crafting Material Level Display, and turn off the Provisioning information.

Instead, I created this addon to ease the identification of crafting materials that are no longer worthwhile for skill increases. So, really, I just want the game to tell me what skill level the various crafting materials are at. For example, once you get to Provisioning level 20, the ingredients below level 15 provide very little gains. Or, perhaps you don't care about Jewelry-specific enchanting runes, regardless of their level. Since bag and bank space are at a premium, I wanted an easier way to identify those crafting materials for either destruction, selling to a vendor, or passing to an alt or even a friend. The information is readily available at the [Tamriel Journal website](http://tamrieljournal.com/eso-provisioning-ingredients/), but having it integrated into the tooltips feels easier.

## Language Support

The addon should theoretically work with non-English game clients, but it has not been tested. It is using item IDs for comparison with the item/tooltip list that I've bundled (pulling data from both Tamriel Journal and ESOHead), so the tooltip text should be displayed as expected; but note that the tooltip text is not translated.

## Libraries used

* [LibAddonMenu](http://www.esoui.com/downloads/info7-LibAddonMenu.html)
* [LibStub](http://www.esoui.com/downloads/info44-LibStub.html)

## Where can I download official releases of this addon?

* [ESOUI](http://www.esoui.com/downloads/info459-CraftingMaterialLevelDisplay.html)
* [Curse](http://www.curse.com/teso-addons/teso/crafting-material-level-display)
* [GitHub (development site)](https://github.com/jhegg/eso-crafting-material-level-display/)

## Where should I file bugs?

If you see text such as "Unknown crafting item ID ##### - please submit a bug for CraftingMaterialLevelDisplay", please either leave a comment at the [ESOUI page](http://www.esoui.com/downloads/info459-CraftingMaterialLevelDisplay.html#comments), or feel free to file a bug on the [GitHub issues page](https://github.com/jhegg/eso-crafting-material-level-display/issues).

## Screenshots

### Primary Ingredients

This screenshot shows a primary ingredient, with text added that says "**Primary Ingredient, Level 20, Ebonheart Pact**".

![Primary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-primary-v0.4.jpg)

### Secondary Ingredients

The added text for this screenshot is "**Secondary Ingredient, Level 20-25, Increase Stamina Recovery**".

![Secondary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-secondary-v0.4.jpg)

### Tier 2 Ingredients

The added text for this screenshot is "**Tier 2 Ingredient, Increase Health Recovery**".

![Tier 2 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-tier2-v0.4.jpg)

### Tier 3 Ingredients

The added text for this screenshot is "**Tier 3 Ingredient**".

![Tier 3 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-tier3-v0.4.jpg)

### Woodworking

The added text for this screenshot is "**Level 16 - 24**".

![Woodworking Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-woodworking-v0.4.jpg)

### Clothing

The added text for this screenshot is "**Level 26 - 34**".

![Clothing Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-clothing-v0.4.jpg)

### Blacksmithing

The added text for this screenshot is "**Level 16 - 24**".

![Blacksmithing Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-blacksmithing-v0.4.jpg)

### Enchanting - Potency Rune

The added text for this screenshot is "**Raise, Slight, Potency Level 2, Gear Level 15 - 25**".

![Enchanting Potency Rune Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-enchanting-potency-rune-v0.5.jpg)

### Enchanting - Essence Rune

The added text for this screenshot is "**For both Armor and Weapon Glyphs**".

![Enchanting Essence Rune Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-enchanting-essence-rune-v0.5.jpg)
