//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_BetterAlienRulerRewards.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_BetterAlienRulerRewards extends X2DownloadableContentInfo;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame() {

	AddNewTechTemplates();

}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState) {

	AddNewTechTemplates();

}

static event OnPostTemplatesCreated() {

	// Hide DLC Techs:
	HideDLCTechTemplates();

}

// ##############################
// ###-ADD-NEW-TECH-TEMPLATES-###
// ##############################

static function AddNewTechTemplates() {

	local X2StrategyElementTemplateManager StratMgr;
	local XComGameState	NewGameState;
	local array<name> TemplateNames;
	local name TemplateName;
	local bool bTechExists;
	local XComGameState_Tech TechState;
	local X2TechTemplate TechTemplate;

	// Access Strategy Template Manager:
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	
	// Set up new GameState:
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add new Tech Templates");

	// List Tech Templates by names:
	TemplateNames.AddItem('RageVest');
	TemplateNames.AddItem('FrostHook');
	TemplateNames.AddItem('IcarusJets');

	foreach TemplateNames(TemplateName) {

		// Check if TechState object exists:
		bTechExists = false;

		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Tech', TechState) {
			if (TechState.GetMyTemplateName() == TemplateName) {

				bTechExists = true;
				break;

			}
		}

		if (!bTechExists) {
			
			// Access Tech Template:
			TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate(TemplateName));			
			if (TechTemplate != none) {

				// Build TechState object:
				TechState = XComGameState_Tech(NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate));
				NewGameState.AddStateObject(TechState);

			}
		}
	}

	// Submit new GameState:
	if (NewGameState.GetNumGameStateObjects() > 0) {

		`GAMERULES.SubmitGameState(NewGameState);

	} else { // Should never trigger, but just good practice:

		`XCOMHISTORY.CleanupPendingGameState(NewGameState);

	}
}

// ###############################
// ###-HIDE-DLC-TECHS-FUNCTION-###
// ###############################

static function HideDLCTechTemplates() {

	local X2StrategyElementTemplateManager StratMgr;
	local array<name> TemplateNames;
	local array<X2DataTemplate> TechTemplates;
	local X2TechTemplate TechTemplate;
	local int i, j;

	// Access StrategyElement Template Manager:
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	// List all DLC Tech Templates by names:
	TemplateNames.AddItem('RAGESuit');
	TemplateNames.AddItem('SerpentSuit');
	TemplateNames.AddItem('IcarusArmor');
	for (i = 0; i < TemplateNames.Length; i++) {		

		// Reset DLC Tech Templates for all difficulties:
		TechTemplates.Length = 0;
		
		// Access DLC Tech Templates for all difficulties:
		StratMgr.FindDataTemplateAllDifficulties(TemplateNames[i], TechTemplates);

		for (j = 0; j < TechTemplates.Length; j++) {

			// Access Tech Template:
			TechTemplate = X2TechTemplate(TechTemplates[j]);
		
			// Reset Alternate Requirements:
			TechTemplate.AlternateRequirements.Length = 0;

			// Hide Tech Template:
			TechTemplate.Requirements.SpecialRequirementsFn = HideTech;

		}
	}
}

static function bool HideTech() {

	return false;

}

// #####################################
// ###-APPEND-SOCKETS-FOR-ANIMATIONS-###
// #####################################

static function string DLCAppendSockets(XComUnitPawn Pawn) {

	local XComGameState_Unit UnitState;
	local array<XComGameState_Item> arrItemState;
	local X2ItemTemplate ItemTemplate;
	local int i;

	// Access UnitState:
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Pawn.ObjectID));
	if (UnitState == none) return "";

	// Access all Items in Utility Slot:
	arrItemState = UnitState.GetAllItemsInSlot(eInvSlot_Utility);
	for (i = 0; i < arrItemState.Length; i++) {

		// Access Item Template:
		ItemTemplate = arrItemState[i].GetMyTemplate();
		if (UnitState.kAppearance.iGender == eGender_Male) {

			// Append Sockets to male units
			switch (ItemTemplate.DataName) {

				case 'RageVest':

					return "AlienRulerAccessories.Meshes.SM_RageSuit_M";

				case 'IcarusJets':

					return "AlienRulerAccessories.Meshes.SM_ArchonArmor_M";

				default:

					return "";

			}
		} else {

			// Append Sockets to female units:
			switch (ItemTemplate.DataName)
			{
				case 'RageVest':
					return "AlienRulerAccessories.Meshes.SM_RageSuit_F";
				case 'IcarusJets':
					return "AlienRulerAccessories.Meshes.SM_ArchonArmor_F";
				default:
					return "";

			}
		}
	}
}