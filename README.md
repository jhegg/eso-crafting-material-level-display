Crafting Material Level Display - v1.3.1
===================================

An Elder Scrolls Online addon that displays the level of crafting materials in the item tooltips (as viewed from your 
bag or bank) and inventory lists.

## What does it do?

This addon provides additional information about crafting materials in two places: in the item tooltips, and directly
in the inventory lists.

The tooltips contain valuable information about Alchemy, Enchanting, and Provisioning materials, such as easily
distinguishing between positive and negative effects, or showing which faction a particular provisioning material
belongs to.

The inventory lists (bags, bank, loot, and enchanting crafting table) contain simple level ranges for Blacksmithing, 
Clothing, Enchanting, and Woodworking materials, so that you don't have to even look at the tooltip to make a decision 
about whether to sell low-level materials.

Each piece of functionality can be disabled in the settings menu, if it conflicts with other addons or causes an error.
I'd prefer to fix any problems, though, so please let me know if you disable something due to an error.

## What is the purpose of this addon?

I created this addon to ease the identification of crafting materials that are no longer worthwhile for skill 
increases. So, really, I just want the game to tell me what skill level the various crafting materials are at. For 
example, once you get to Provisioning level 20, the ingredients below level 15 provide very little gains. Or, perhaps 
you don't care about Jewelry-specific enchanting runes, regardless of their level. Since bag and bank space are at a 
premium, I wanted an easier way to identify those crafting materials for either destruction, selling to a vendor, or 
passing to an alt or even a friend. The information is readily available at the 
[Tamriel Journal website](http://tamrieljournal.com/eso-provisioning-ingredients/), but having it integrated into the 
tooltips feels easier.

Note: This addon used to provide level information about Blacksmithing, Clothing, and Woodworking materials in tooltips, but in 
ESO v1.2.3, that information was put into the built-in game tooltips, so in v1.1.0 of this addon I removed that data.

## Language Support

The addon should theoretically work with non-English game clients, but it has not been tested. It is using item IDs 
for comparison with the item/tooltip list that I've bundled (pulling data from both Tamriel Journal and ESOHead), so 
the tooltip text should be displayed as expected; but note that the tooltip text is not translated.

## Libraries used

* [LibAddonMenu](http://www.esoui.com/downloads/info7-LibAddonMenu.html)
* [LibStub](http://www.esoui.com/downloads/info44-LibStub.html)

## Where can I download official releases of this addon?

* [ESOUI](http://www.esoui.com/downloads/info459-CraftingMaterialLevelDisplay.html)
* [Curse](http://www.curse.com/teso-addons/teso/crafting-material-level-display)
* [GitHub (development site)](https://github.com/jhegg/eso-crafting-material-level-display/)

## Where should I file bugs?

If you see text such as "Unknown crafting item ID ##### - please submit a bug for CraftingMaterialLevelDisplay", 
please either leave a comment at the 
[ESOUI page](http://www.esoui.com/downloads/info459-CraftingMaterialLevelDisplay.html#comments), or feel free to file 
a bug on the [GitHub issues page](https://github.com/jhegg/eso-crafting-material-level-display/issues).

## Screenshots

### Provisioning - Primary Ingredients

The text that is added says "**Primary Ingredient, Level 20, Ebonheart Pact**".

![Primary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-primary-v0.4.jpg)

### Provisioning - Secondary Ingredients

The added text for this screenshot is "**Secondary Ingredient, Level 30-35, Increase Max Magicka**".

![Secondary Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-secondary-v0.4.jpg)

### Provisioning - Blue and Purple Flavor Ingredients

The added text for this screenshot is "**For extra flavor in blue and purple recipes**".

![Tier 2 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-flavor-blue_and_purple-v1.0.4.jpg)

### Provisioning - Purple Flavor Ingredients

The added text for this screenshot is "**For extra flavor in purple recipes**".

![Tier 3 Ingredient Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-flavor-purple-v1.0.4.jpg)

### Enchanting - Potency Rune

The added text for this screenshot is "**Level 15 - 20, Additive**". It also shows the level range in the inventory list.

![Enchanting Potency Rune Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-enchanting-potency-rune-v1.3.0.jpg)

### Enchanting - Essence Rune

The added text for this screenshot is "**Magicka - Armor, Weapon**" and "**+ Adds max Magicka**" and 
"**- Deals magic damage and restores Magicka**".

![Enchanting Essence Rune Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-enchanting-essence-rune-v1.3.0.jpg)

### Alchemy

The added text for this screenshot is "**Restore stamina, Increase weapon power, Weapon crit, Lower Armor**".

![Alchemy Image](https://github.com/jhegg/eso-crafting-material-level-display/wiki/CraftingMaterialLevelDisplay-alchemy-v1.0.9.jpg)

## Disclaimer

This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. 
The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United 
States and/or other countries. All rights reserved.