class X2StrategyElement_BetterAlienRulerRewards extends X2StrategyElement_DefaultTechs 
    config(BetterAlienRulerRewards);

var config int RageVest_DaysToComplete;
var config array<ArtifactCost> RageVest_ResourceCosts;
var config array<ArtifactCost> RageVest_ArtifactCosts;

var config int FrostHook_DaysToComplete;
var config array<ArtifactCost> FrostHook_ResourceCosts;
var config array<ArtifactCost> FrostHook_ArtifactCosts;

var config int IcarusJets_DaysToComplete;
var config array<ArtifactCost> IcarusJets_ResourceCosts;
var config array<ArtifactCost> IcarusJets_ArtifactCosts;

static function array<X2DataTemplate> CreateTemplates() {

	local array<X2DataTemplate> Techs;

	// Create new Alien Ruler Techs:
	Techs.AddItem(CreateRageVestTemplate());
	Techs.AddItem(CreateFrostHookTemplate());
	Techs.AddItem(CreateIcarusJetsTemplate());

	return Techs;
}

// #######################
// ###-TECH-TEMPLATES -###
// #######################

static function X2DataTemplate CreateRageVestTemplate() {
	
	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'RageVest');
	Template.strImage = "img:///UILibrary_DLC2Images.TECH_RageSuit";
	Template.PointsToComplete = StafferXDays(1, default.RageVest_DaysToComplete);
	Template.SortingTier = 1;

	Template.bProvingGround = true;

	// Reward:
	Template.ItemRewards.AddItem('RageVest');
	Template.ResearchCompletedFn = GiveRandomItemReward;

	// Requirements:
	Template.Requirements.RequiredTechs.AddItem('AutopsyBerserkerQueen');

	// Cost:
	foreach default.RageVest_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.RageVest_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}

	return Template;

}

static function X2DataTemplate CreateFrostHookTemplate() {

	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FrostHook');
	Template.strImage = "img:///UILibrary_DLC2Images.TECH_SerpentArmor";
	Template.PointsToComplete = StafferXDays(1, default.FrostHook_DaysToComplete);
	Template.SortingTier = 1;

	Template.bProvingGround = true;

	// Reward:
	Template.ItemRewards.AddItem('FrostHook');
	Template.ResearchCompletedFn = GiveRandomItemReward;

	// Requirements:
	Template.Requirements.RequiredTechs.AddItem('AutopsyViperKing');

	// Cost:
	foreach default.FrostHook_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.FrostHook_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}

	return Template;

}

static function X2DataTemplate CreateIcarusJetsTemplate() {

	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'IcarusJets');
	Template.strImage = "img:///UILibrary_DLC2Images.TECH_IcarusArmor";
	Template.PointsToComplete = StafferXDays(1, default.IcarusJets_DaysToComplete);
	Template.SortingTier = 1;

	Template.bProvingGround = true;

	// Reward:
	Template.ItemRewards.AddItem('IcarusJets');
	Template.ResearchCompletedFn = GiveRandomItemReward;

	// Requirements:
	Template.Requirements.RequiredTechs.AddItem('AutopsyArchonKing');

	// Cost:
	foreach default.IcarusJets_ResourceCosts(Resources) {

		Template.Cost.ResourceCosts.AddItem(Resources);

	}
	foreach default.IcarusJets_ArtifactCosts(Artifacts) {

		Template.Cost.ArtifactCosts.AddItem(Artifacts);

	}

	return Template;
	
}