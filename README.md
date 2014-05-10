eso-crafting-material-level-display
===================================

An Elder Scrolls Online addon that displays the level of crafting materials in the item tooltips (as viewed from your bag or bank).

## Disclaimer

This is my first use of Lua, and my first creation of an addon. I suck at it. I had to look through several other much better addons for examples of how to perform certain things, such as hooking functions, or what kind of API functions might have the right kind of data I was looking for. I mention those other addons below, and I recommend that you check them out.

## What is the purpose of this addon?

It might be best to start with describing what this addon is not meant to do: I don't intend it to replace addons such as [Sous Chef](http://www.esoui.com/downloads/info163-SousChef-ProvisioningHelper.html) or [Harven's Provisioning Tooltips](http://www.esoui.com/downloads/info435-HarvensProvisioningTooltips.html). Those are two great addons that inform you about which ingredients are used by which recipes, which recipes you have on various characters, etc.

Instead, I created this addon to ease the identification of crafting materials that are no longer worthwhile for skill increases. So, really, I just want the game to tell me what skill level the various crafting materials are at. For example, once you get to Provisioning level 20, the ingredients below level 15 provide very little gains. Since bag and bank space are at a premium, I wanted an easier way to identify those crafting materials for either destruction, selling to a vendor, or passing to an alt or even a friend. The information is readily available at the [Tamriel Journal website](http://tamrieljournal.com/eso-provisioning-ingredients/), but having it integrated into the tooltips feels easier.

At this time, the addon is limited to provisioning ingredients, although my plan is to add in the other crafting materials (particularly enchanting) in updated versions. The addon should theoretically work with non-English game clients, but it has not been tested. It is using item IDs for comparison with the item/tooltip list that I've bundled (pulling data from both Tamriel Journal and ESOHead), so the tooltips should be added; but note that the tooltip text is not translated.

## Screenshots

### Primary Ingredients

This screenshot shows a primary ingredient, and also the addon working in conjunction with [Harven's Provisioning Tooltips](http://www.esoui.com/downloads/info435-HarvensProvisioningTooltips.html), which is a good addon to identify which recipes the ingredient is used with. The text that is added says "**Primary Ingredient, Level 20, Ebonheart Pact**".

![Primary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-primary-v0.2.jpg)

### Secondary Ingredients

The added text for this screenshot is "**Secondary Ingredient, Level 20-25, Increase Stamina Recovery**".

![Secondary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-secondary-v0.2.jpg)

### Tier 2 Ingredients

The added text for this screenshot is "**Tier 2 Ingredient, Increase Health Recovery**".

![Tier 2 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-tier2-v0.2.jpg)

### Tier 3 Ingredients

The added text for this screenshot is "**Tier 3 Ingredient**".

![Tier 3 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-tier3-v0.2.jpg)
