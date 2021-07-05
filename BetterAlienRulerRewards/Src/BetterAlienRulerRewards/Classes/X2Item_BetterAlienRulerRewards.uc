class X2Item_BetterAlienRulerRewards extends X2Item 
	config(BetterAlienRulerRewards);

var config int RageVest_TradingPostValue;
var config array<ArtifactCost> RageVest_ResourceCosts;
var config array<ArtifactCost> RageVest_ArtifactCosts;

var config int FrostHook_TradingPostValue;
var config array<ArtifactCost> FrostHook_ResourceCosts;
var config array<ArtifactCost> FrostHook_ArtifactCosts;

var config int IcarusJets_TradingPostValue;
var config array<ArtifactCost> IcarusJets_ResourceCosts;
var config array<ArtifactCost> IcarusJets_ArtifactCosts;

static function array<X2DataTemplate> CreateTemplates() {

	local array<X2DataTemplate> Items;

	// Create new Alien Ruler Items:
	Items.AddItem(CreateRageVest());
	Items.AddItem(CreateFrostHook());
	Items.AddItem(CreateIcarusJets());

	return Items;

}

static function X2EquipmentTemplate CreateRageVest() {

	local X2EquipmentTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'RageVest');

	Template.strImage = "img:///AlienRulerAccessories.Icons.RageVest";
	Template.EquipSound = "StrategyUI_Vest_Equip";
	Template.InventorySlot = eInvSlot_Utility;
	Template.ItemCat = 'defense';

	// Abilities:
	Template.Abilities.AddItem('RageVestBonus');
	Template.Abilities.AddItem('Ragestrike');
	Template.Abilities.AddItem('RageArmorAnim');

	// Build:
	Template.CanBeBuilt = true;
	Template.PointsToComplete = 0;
	Template.TradingPostValue = default.RageVest_TradingPostValue;

	// Requirements:
	Template.Requirements.RequiredTechs.AddItem('RageVest');

	// Cost:
	foreach default.RageVest_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.RageVest_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}

	// UI:
	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_BetterAlienRulerRewards'.default.RAGE_VEST_HP_BONUS);
	
	return Template;

}

static function X2DataTemplate CreateFrostHook() {

	local X2WeaponTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'FrostHook');

	Template.strImage = "img:///AlienRulerAccessories.Icons.FrostHook";
	Template.EquipSound = "StrategyUI_Heavy_Weapon_Equip";
	Template.InventorySlot = eInvSlot_TacticalGadget;
	Template.ItemCat = 'tacticalgadget';
	Template.WeaponCat = 'tacticalgadget';

	// Abilities:
	Template.Abilities.AddItem('GrapplePowered');
	Template.Abilities.AddItem('FreezingLash');
	Template.Abilities.AddItem('SerpentSuitAnim');

	// Build:
	Template.CanBeBuilt = true;
	Template.PointsToComplete = 0;
	Template.TradingPostValue = default.FrostHook_TradingPostValue;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('FrostHook');

	// Cost
	foreach default.FrostHook_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.FrostHook_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}
	
	return Template;

}

static function X2DataTemplate CreateIcarusJets() {

	local X2EquipmentTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'IcarusJets');

	Template.strImage = "img:///AlienRulerAccessories.Icons.IcarusJets";
	Template.EquipSound = "StrategyUI_Vest_Equip";
	Template.InventorySlot = eInvSlot_TacticalGadget;
	Template.ItemCat = 'tacticalgadget';

	// Abilities:
	Template.Abilities.AddItem('IcarusJump');
	Template.Abilities.AddItem('IcarusSuitAnim');

	// Build:
	Template.CanBeBuilt = true;
	Template.PointsToComplete = 0;
	Template.TradingPostValue = default.IcarusJets_TradingPostValue;

	// Requirements:
	Template.Requirements.RequiredTechs.AddItem('IcarusJets');

	// Cost
	foreach default.IcarusJets_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.IcarusJets_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}
	
	return Template;

}