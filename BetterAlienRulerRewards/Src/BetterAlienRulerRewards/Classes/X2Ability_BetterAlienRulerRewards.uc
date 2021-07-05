class X2Ability_BetterAlienRulerRewards extends X2Ability 
	config(BetterAlienRulerRewards);

var config int RAGE_VEST_HP_BONUS;

static function array<X2DataTemplate> CreateTemplates() {

	local array<X2DataTemplate> Templates;

	// RAGE Vest Bonus:
	Templates.AddItem(RageVestBonusAbility());

	// Animations:
	Templates.AddItem(Create_AnimSet_Passive('RageArmorAnim', "DLC_60_Soldier_RageArmor_ANIM.Anims.AS_RageArmor"));
	Templates.AddItem(Create_AnimSet_Passive('SerpentSuitAnim', "DLC_60_Soldier_SerpentSuit_ANIM.Anims.AS_SerpentSuit"));
	Templates.AddItem(Create_AnimSet_Passive('IcarusSuitAnim', "DLC_60_Soldier_IcarusSuit_ANIM.Anims.AS_IcarusSuit"));

	return Templates;

}

static function X2AbilityTemplate RageVestBonusAbility() {

	local X2AbilityTemplate                 Template;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RageVestBonus');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// Bonus to health stat Effect:
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.RAGE_VEST_HP_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;

}

static function X2AbilityTemplate Create_AnimSet_Passive(name TemplateName, string AnimSetPath) {

    local X2AbilityTemplate Template;
    local X2Effect_AdditionalAnimSets AnimSetEffect;

    `CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

    Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
    Template.bDisplayInUITooltip = false;
    Template.bDisplayInUITacticalText = false;
    Template.bDontDisplayInAbilitySummary = true;
    Template.Hostility = eHostility_Neutral;

    Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
    Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
    
    AnimSetEffect = new class'X2Effect_AdditionalAnimSets';
    AnimSetEffect.AddAnimSetWithPath(AnimSetPath);
    AnimSetEffect.BuildPersistentEffect(1, true, false, false);
    Template.AddTargetEffect(AnimSetEffect);

    Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

    return Template;

}