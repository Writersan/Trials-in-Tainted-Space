﻿import classes.BreastRowClass;
import classes.Characters.PlayerCharacter;
import classes.Creature;
import classes.GameData.PerkData;
import classes.GameData.Pregnancy.Handlers.RenvraEggPregnancy;
import classes.GameData.Pregnancy.Handlers.NyreaHuntressPregnancy;
import classes.GameData.Pregnancy.PregnancyManager;
import classes.GUI;
import classes.Items.Accessories.LeithaCharm;
import classes.Items.Miscellaneous.EmptySlot;
import classes.Items.Miscellaneous.HorsePill;
import classes.Items.Transformatives.Cerespirin;
import classes.Items.Transformatives.Clippex;
import classes.Items.Transformatives.Goblinola;
import classes.RoomClass;
import classes.StorageClass;
import classes.UIComponents.ContentModules.MailModule;
import classes.UIComponents.SquareButton;
import flash.events.Event;
import classes.Engine.Combat.DamageTypes.DamageFlag;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.ItemSlotClass;
import classes.PregnancyData;
import classes.SexualPreferences;
import classes.StringUtil;

public function get canSaveAtCurrentLocation():Boolean
{

	if(inCombat()) 
		return false;

	if (inSceneBlockSaving)
		return false;

	return rooms[currentLocation].canSaveInRoom
}

public function infiniteItems():Boolean
{
	return (debug || flags["INFINITE_ITEMS"] != undefined);
}

public function logTimeStamp(logColor:String = "words"):String
{
	// logColor correlates to the CSS colors:
	// 'words' = white (default - usually for normal stuff)
	// 'good' = cyan (good news - any positive messages that need highlighting)
	// 'bad' = red (bad news - any negative messages that need highlighting)
	// 'caution' = yellow (active alert - usually for mission timers)
	// 'passive' = purple (passive alert - usually for item changes)
	
	var bufferButt:String = "";
	bufferButt += "\\\[<span class='" + logColor + "'><b>D: " + days + " T: ";
	if(hours < 10) bufferButt += String(0) + hours;
	else bufferButt += String(hours);
	bufferButt += ":";
	if(minutes < 10) bufferButt += String(0) + minutes;
	else bufferButt += minutes;
	bufferButt += "</b></span>\\\]";
	return bufferButt;
}

// Wrap some newline shit to make eventBuffer more consistent
// Takes in message (as a whole string of text for that event) and a color (if any).
public function addToEventBuffer(msg:String, logColor:String):void
{
	if(msg.length > 0) eventBuffer += "\n\n" + logTimeStamp(logColor) + " " + ParseText(msg);
}

public function processEventBuffer():Boolean
{
	if (eventBuffer.length > 0)
	{
		clearOutput();
		clearBust();
		output("<b>" + possessive(pc.short) + " log:</b>" + eventBuffer);
		showLocationName();
		eventBuffer = "";
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return true;
	}
	return false;
}

public static const NAV_NORTH_DISABLE:uint 	= 1;
public static const NAV_EAST_DISABLE:uint 	= 1 << 1;
public static const NAV_SOUTH_DISABLE:uint 	= 1 << 2;
public static const NAV_WEST_DISABLE:uint 	= 1 << 3;
public static const NAV_IN_DISABLE:uint 	= 1 << 4;
public static const NAV_OUT_DISABLE:uint 	= 1 << 5;

public function isNavDisabled(umask:uint):Boolean
{
	if (flags["NAV_DISABLED"] != undefined && flags["NAV_DISABLED"] & umask) return true;
	
	return false;
}

public function setNavDisabled(addUmask:uint):void
{
	if (flags["NAV_DISABLED"] == undefined) flags["NAV_DISABLED"] = addUmask;
	flags["NAV_DISABLED"] |= addUmask;
}

public function showLocationName():void
{
	if(InShipInterior()) setLocation("SHIP\nINTERIOR", rooms[shipLocation].planet, rooms[shipLocation].system);
	else setLocation(rooms[currentLocation].roomName, rooms[currentLocation].planet, rooms[currentLocation].system);
}

public function disableExploreEvents():Boolean
{
	// Stellar Tether (Bomb Timer)
	if (flags["TARKUS_BOMB_TIMER"] != undefined && flags["TARKUS_BOMB_TIMER"] > 0) return true;
	// Deck 13 Duration
	if (flags["ANNO_MISSION_OFFER"] > 1 && flags["DECK13_COMPLETE"] == undefined) return true;
	// Pirate Base (Bomb Timer)
	if (flags["KQ2_NUKE_STARTED"] != undefined && flags["KQ2_NUKE_EXPLODED"] == undefined) return true;
	// Kashima Duration
	if (flags["KASHIMA_STATE"] > 0 && flags["KASHIMA_STATE"] < 2) return true;
	
	return false;
}

public function mainGameMenu(minutesMoved:Number = 0):void {
	flags["COMBAT MENU SEEN"] = undefined;
	
	if (flags["PC_UPBRINGING"] == undefined)
	{
		if(eventQueue.indexOf(fixPcUpbringing) == -1) eventQueue.push(fixPcUpbringing);
	}
	if(baby.originalRace != pc.originalRace)
	{
		if(eventQueue.indexOf(setBabyValuesOptions) == -1) eventQueue.push(setBabyValuesOptions);
	}
	
	if (flags["CELISE_BEDSTUFF_HAPPENED"] != undefined)
	{
		flags["CELISE_BEDSTUFF_HAPPENED"] = undefined;
	}
	
	//Display shit that happened during time passage.
	if (processEventBuffer()) return;
	
	//Queued events can fire off too!
	//trace("EventQueue = ", eventQueue);
	//trace("this.eventQueue = ", this.eventQueue);
	if(eventQueue.length > 0) {
		//Do the most recent:
		eventQueue[0]();
		//Strip out the most recent:
		eventQueue.splice(0,1);
		return;
	}
	
	if (pc.hasStatusEffect("Leitha Charm"))
	{
		if (pc.statusEffectv1("Leitha Charm") > 0)
		{
			// Add about two hours of variance to the proc time.
			if (rand(pc.statusEffectv1("Leitha Charm")) > 60)
			{
				pc.setStatusValue("Leitha Charm", 1, -720 - rand(360));
				if ((pc.accessory as LeithaCharm).attemptTF(pc)) return;
			}
		}
	}
	
	// Update the state of the players mails -- we don't want to do this all the time (ie in process time), and we're only going to care about it at the menu root soooooo...
	updateMailStatus();
	
	//Set up all appropriate flags
	//Display the room description
	clearOutput();
	if(debug) output("<b>\\\[ <span class='lust'>DEBUG MODE IS ON</span> \\\]</b>\n\n");
	output(rooms[currentLocation].description);
	showLocationName();
	
	// Time passing effects
	if(passiveTimeEffects(minutesMoved)) return;
	
	// Random events, outside of important/timed missions
	if (!disableExploreEvents())
	{
		if (tryEncounterFreedomBeef()) return;
	}
	
	if(inCombat()) 
		output("\n\n<b>You’re still in combat, you ninny!</b>");
	if(pc.hasStatusEffect("Temporary Nudity Cheat"))
		output("\n\n<b>BUG REPORT: TEMP NUDITY STUCK ON.</b>");
	//Standard buttons:
	clearMenu(false);
	clearBust();
	inSceneBlockSaving = false;
	updatePCStats();
	//Inventory shit
	itemScreen = mainGameMenu;
	lootScreen = inventory;
	addButton(13, "Inventory", inventory);
	//Other standard buttons
	
	if(pc.lust() < 33)
	{
		if(canArouseSelf()) addButton(8, "Arousal", arousalMenu);
		else addDisabledButton(8, "Masturbate");
	}
	else
	{
		if(pc.hasStatusEffect("Myr Venom Withdrawal")) addDisabledButton(8, "Masturbate", "Masturbate", "While you’re in withdrawal, you don’t see much point in masturbating, no matter how much your body may want it.");
		else if(!pc.canMasturbate()) addDisabledButton(8, "Masturbate", "Masturbate", "You can’t seem to masturbate at the moment....");
		else addButton(8, "Masturbate", masturbateMenu);
	}
	if (!rooms[currentLocation].hasFlag(GLOBAL.BED)) 
	{
		addButton(9, "Rest", rest);
	}
	else 
	{
		if (currentLocation == "KI-H16" && flags["KI_REFUSED_VANDERBILT"] != undefined && flags["KI_VANDERBILT_WORKING"] != undefined)
		{
			addDisabledButton(9, "Sleep", "Sleep", "You can't afford to risk sleeping with Elenora around. Who knows if she'll be able to hold it together... or if she'll try something while you rest.");
		}
		else
		{
			addButton(9, "Sleep", sleep);
		}
	}
		
	addButton(14, "Codex", showCodex);
	
	//Display movement shits - after clear menu for extra options!
	if(rooms[currentLocation].runOnEnter != undefined) {
		if(rooms[currentLocation].runOnEnter()) return;
	}
	
	//Turn off encounters since you're already here. Moving clears this.
	flags["ENCOUNTERS_DISABLED"] = 1;

	if(pc.hasStatusEffect("Endowment Immobilized"))
	{
		if (rooms[currentLocation].northExit && !isNavDisabled(NAV_NORTH_DISABLE))
		{
			addDisabledButton(6, "North", "North", "You can't move - you're immobilized!");
		}
		if (rooms[currentLocation].eastExit && !isNavDisabled(NAV_EAST_DISABLE)) 
		{
			addDisabledButton(12, "East", "East", "You can't move - you're immobilized!");
		}
		if (rooms[currentLocation].southExit && !isNavDisabled(NAV_SOUTH_DISABLE)) 
		{
			addDisabledButton(11,"South","South","You can't move - you're immobilized!");
		}
		if (rooms[currentLocation].westExit && !isNavDisabled(NAV_WEST_DISABLE)) 
		{
			addDisabledButton(10,"West","West","You can't move - you're immobilized!");
		}
		if (rooms[currentLocation].inExit && !isNavDisabled(NAV_IN_DISABLE))
		{
			addDisabledButton(5, rooms[currentLocation].inText, rooms[currentLocation].inText, "You can't move - you're immobilized!");
		}
		if (rooms[currentLocation].outExit && !isNavDisabled(NAV_OUT_DISABLE)) 
		{
			addDisabledButton(7,rooms[currentLocation].outText,rooms[currentLocation].outText,"You can't move - you're immobilized!");
		}
	}
	else
	{
		if (rooms[currentLocation].northExit && !isNavDisabled(NAV_NORTH_DISABLE))
		{
			addButton(6, "North", move, rooms[currentLocation].northExit);
		}
		if (rooms[currentLocation].eastExit && !isNavDisabled(NAV_EAST_DISABLE))
		{
			addButton(12, "East", move, rooms[currentLocation].eastExit);
		}
		if (rooms[currentLocation].southExit && !isNavDisabled(NAV_SOUTH_DISABLE))
		{
			addButton(11,"South", move, rooms[currentLocation].southExit);
		}
		if (rooms[currentLocation].westExit && !isNavDisabled(NAV_WEST_DISABLE))
		{
			addButton(10, "West", move, rooms[currentLocation].westExit);
		}
		if (rooms[currentLocation].inExit && !isNavDisabled(NAV_IN_DISABLE)) 
		{
			addButton(5, rooms[currentLocation].inText, move, rooms[currentLocation].inExit);
		}
		if (rooms[currentLocation].outExit && !isNavDisabled(NAV_OUT_DISABLE))
		{
			addButton(7, rooms[currentLocation].outText, move, rooms[currentLocation].outExit);
		}
	}
	if (currentLocation == "SHIP INTERIOR")
	{
		if (rooms[currentLocation].outExit && isNavDisabled(NAV_OUT_DISABLE)) 
		{
			addDisabledButton(7,rooms[currentLocation].outText,rooms[currentLocation].outText,"You can’t exit your ship here!");
		}
	}
	if (currentLocation == shipLocation)
	{
		if (isNavDisabled(NAV_IN_DISABLE))
		{
			addDisabledButton(5, rooms[currentLocation].inText, rooms[currentLocation].inText, "You can’t enter your ship here!");
		}
		else addButton(5, "Enter Ship", move, "SHIP INTERIOR");
	}
	
	if (rooms[currentLocation].runAfterEnter != null) rooms[currentLocation].runAfterEnter();

	flags["NAV_DISABLED"] = undefined; // Clear disabled directions.

	//if (kGAMECLASS.debug) this.addButton(13, "RESET NPCs", initializeNPCs);
	
	// Show the minimap too!
	userInterface.showMinimap();
	generateMap();
	userInterface.perkDisplayButton.Activate();
}

public function generateMap():void
{
	generateMapForLocation(currentLocation);
}
public function generateMapForLocation(location:String):void
{
	userInterface.setMapData(mapper.generateMap(location));
}
public function generateLocationName(location:String):void
{
	setLocation(rooms[location].roomName, rooms[location].planet, rooms[location].system);
}
public function generateLocation(location:String):void
{
	generateMapForLocation(location);
	generateLocationName(location);
}

public function backToPrimaryOutput():void
{
	clearBust();
	userInterface.backToPrimaryOutput();
}
public function clearBust(forceNone:Boolean = false):void
{
	if(forceNone || !inCombat()) showBust("none");
}
public function showCodex():void
{
	userInterface.showCodex();
	codexHomeFunction();
	clearGhostMenu();
	
	// Default toggles
	if(flags["TOGGLE_MENU_STATS"] == undefined) flags["TOGGLE_MENU_STATS"] = "All";
	if(flags["TOGGLE_MENU_LOG"] == undefined) flags["TOGGLE_MENU_LOG"] = "All";
	
	// TESTO BUTTONO
	addGhostButton(0, "Stats", statisticsScreen, flags["TOGGLE_MENU_STATS"]);
	
	//addGhostButton(1, "Messages", function():void { } );
	//addGhostButton(2, "Log", function():void { } );
	//addGhostButton(3, "CHEEVOS", function():void { } );
	addGhostButton(1, "Log", displayQuestLog, flags["TOGGLE_MENU_LOG"]);
	if(flags["EMMY_QUEST"] >= 6 && flags["EMMY_QUEST"] != undefined) 
	{
		if(flags["KQ2_MYRELLION_STATE"] == 1) addDisabledGhostButton(3,"EmmyRemote","EmmyRemote","Who knows if Emmy is even alive with what happened to Myrellion. Maybe after you finish with this probe nonsense, you can use your Dad's resources to track down her whereabouts - assuming she made it out in one piece.");
		else addGhostButton(3,"EmmyRemote",pushEmmysButtonsMenu);
	}
	addGhostButton(4, "Back", backToPrimaryOutput);
}

// Temp display stuff for perks
public function showPerkListHandler(e:Event = null):void
{
	var pButton:SquareButton = (userInterface as GUI).perkDisplayButton;
	
	if (pc.short.length == 0) return;
	
	if (pButton.isActive && !pButton.isHighlighted)
	{
		showPerksList();
		userInterface.DeGlowButtons();
		pButton.Highlight();
	}
	else if (pButton.isActive && pButton.isHighlighted)
	{
		backToPrimaryOutput();
	}
}

public function showMailsHandler(e:Event = null):void
{
	var pButton:SquareButton = (userInterface as GUI).mailsDisplayButton;
	
	if (pc.short.length == 0) return;
	
	if (!pc || pc.hasStatusEffect("In Creation"))
	{
		userInterface.mailsDisplayButton.Deactivate();
		return;
	}
	
	if (flags["KASHIMA_STATE"] == 1)
	{
		if (!userInterface.isSecondaryOutputActive())
		{
			userInterface.showSecondaryOutput();
			clearOutput2();
			output2("You try and access your Codex’s communications functions, but the app refuses to go beyond the login screen. Something's messed up with it's quantuum comms. device... or it’s getting some serious interference. You'll not be able to use the function until you get back to your ship and tinker with it.");
			return;
		}
		else
		{
			backToPrimaryOutput();
			return;
		}
	}
	
	if (flags["PC_EMAIL_ADDRESS"] == undefined)
	{
		(userInterface as GUI).showSecondaryOutput();
		initialMailConfiguration();
		return;
	}
	
	if (pButton.isActive && !pButton.isHighlighted)
	{
		showMails();
	}
	else if (pButton.isActive && pButton.isHighlighted)
	{
		backToPrimaryOutput();
	}
}

public function showMails():void
{
	userInterface.showMails();
	userInterface.DeGlowButtons();
	(userInterface as GUI).mailsDisplayButton.Highlight();
	codexMailFunction();
}

public function codexMailFunction():void
{
	var m:MailModule = (userInterface as GUI).mailModule;
	
	m.htmlText = "<span class='words'><p>";
	m.htmlText += "Welcome to the Steele Industries® CODEX™ Extranet Messenger Extension.";
	m.htmlText += "\n\nThe Codex EME system allows you, as a user of a Steele Industries® CODEX™ device, to exchange messages with other EME system users, allowing you to keep a historical record of various communications and transactions.";
	m.htmlText += "\n\nReceived messages are displayed to the right of the CODEX™ display, with as-yet unread messages sorted to the top and displayed in <b>bold</b>.\n\nThe CODEX™ root menu will alert you to new messages via an un-obtrusive notification - the access icon for the system will display as a green icon when unread messages are detected.";
	m.htmlText += "</p></span>";
	
	clearGhostMenu();
	addGhostButton(4, "Back", showMailsHandler);
}

import classes.GameData.MailManager;
import classes.GUI;
import classes.UIComponents.UIStyleSettings;

public function updateMailStatus():void
{
	if (flags["KASHIMA_STATE"] == 1)
	{
		userInterface.mailsDisplayButton.Activate();
		userInterface.mailsDisplayButton.iconColour = UIStyleSettings.gStatusBadColour;
		return;
	}
	
	// Initial mail config option!
	if (flags["PC_EMAIL_ADDRESS"] == undefined)
	{
		userInterface.mailsDisplayButton.Activate();
		userInterface.mailsDisplayButton.iconColour = UIStyleSettings.gStatusGoodColour;
		return;
	}
	
	// No mails, disable button
	if (!MailManager.hasUnlockedEntries())
	{
		(userInterface as GUI).mailsDisplayButton.Deactivate();
		(userInterface as GUI).mailsDisplayButton.iconColour = 0xFFFFFF;
	}
	// Has mails, no new mails
	else if (!MailManager.hasUnreadEntries())
	{
		(userInterface as GUI).mailsDisplayButton.Activate();
		(userInterface as GUI).mailsDisplayButton.iconColour = 0xFFFFFF;
	}
	// Has new mails
	else
	{
		(userInterface as GUI).mailsDisplayButton.Activate();
		(userInterface as GUI).mailsDisplayButton.iconColour = UIStyleSettings.gStatusGoodColour;
	}
}

public function showPerksList():void
{
	clearOutput2();
	showPCBust();
	setLocation("\nPERKS", "CODEX", "DATABASE");
	author("");
	clearGhostMenu();
	addGhostButton(14, "Back", showPerkListHandler);
	
	var perkList:Array = (pc as PlayerCharacter).perks;
	
	if (perkList.length == 0) output2("<i>No available character perks have been acquired.</i>");
	
	for (var i:int = 0; i < perkList.length; i++)
	{
		var perk:StorageClass = perkList[i] as StorageClass;
		var perkDesc:String = _perkDB.getDescriptionForPerk(perk.storageName);
		
		if (perkDesc.length == 0) perkDesc = perk.tooltip;
		
		if (perk.combatOnly == false)
		{
			output2("<b>" + perk.storageName + "</b> - " + perkDesc + "\n");
		}
	}
	output2("\n");
}

public function crewRecruited(allcrew:Boolean = false):Number
{
	var counter:Number = 0;
	
	// Actual crew members
	if (flags["RECRUITED_CELISE"] > 0) counter++;
	if (reahaRecruited()) counter++;
	if (!annoNotRecruited()) counter++;
	if (bessIsFollower()) counter++;
	if (yammiIsCrew()) counter++;
	if (gooArmorIsCrew()) counter++;
	
	// Pets or other non-speaking crew members
	if (allcrew)
	{
		if (hasGooArmor() && !gooArmorIsCrew()) counter++;
		if (varmintIsTame()) counter++;
	}
	
	return counter;
}

public function crew(counter:Boolean = false, allcrew:Boolean = false):Number {
	if(!counter) {
		clearOutput();
		clearMenu();
	}
	
	var crewMessages:String = "";
	var count:int = 0; // For actual crew members
	var other:int = 0; // For pets or other non-speaking crew members
	if(celiseIsCrew()) {
		count++;
		if(!counter) {
			addButton((count + other) - 1, "Celise", celiseFollowerInteractions);
			crewMessages += "\n\nCelise is onboard, if you want to go see her. The ship does seem to stay clean of spills and debris with her around.";
		}
	}
	if(reahaIsCrew())
	{
		count++;
		if(!counter)
		{
			addButton((count + other) - 1, "Reaha", approachShipBoardReahaWhyDidntSavinCodeThisHeWasntExhaustedYesterday);
			crewMessages += "\n\nReaha is currently meandering around the ship, arms clutched under her hefty bosom, her nipples hooked up to a small portable milker.";
		}
	}
	if (annoIsCrew())
	{
		count++;
		if (!counter)
		{
			addButton((count + other) - 1, "Anno", annoFollowerApproach);
			if (hours >= 6 && hours <= 7 || hours >= 19 && hours <= 20) crewMessages += "\n\nAnno is walking about in her quarters, sorting through her inventory and organizing some of her equipment.";
			else if (hours >= 12 || hours <= 13) crewMessages += "\n\nAnno's busy doing a quick workout in her quarters to the beat of some fast-paced ausar heavy metal. <i>“Gotta keep in shape!”</i> she says.";
			else crewMessages += "\n\nAnno is sitting in the common area with her nose buried in half a dozen different data slates. It looks like she's splitting her attention between the latest Warp Gate research and several different field tests of experimental shield generators.";
		}
	}
	if (bessIsCrew())
	{
		count++;
		if (!counter)
		{
			crewMessages += "\n\n[bess.name] is wandering around the ship and keeping [bess.himHer]self busy. It shouldn't be that hard to find [bess.himHer].";
			addButton((count + other) - 1, bess.short, approachFollowerBess);
		}
	}
	if (yammiIsCrew())
	{
		count++;
		if (!counter)
		{
			crewMessages += "\n\n" + yammiShipBonusText();
			addButton((count + other) - 1, "Yammi", yammiInTheKitchen);
		}
	}
	if (hasGooArmor() || gooArmorIsCrew())
	{
		if(gooArmorIsCrew()) count++; // Speaking crew member on ship.
		else other++; // Mostly quiet member on person or in storage.
		if (!counter)
		{
			crewMessages += gooArmorOnSelfBonus((count + other) - 1);
		}
	}
	if (varmintIsCrew())
	{
		other++;
		if (!counter)
		{
			crewMessages += varmintOnShipBonus((count + other) - 1);
		}
	}
	if(!counter) {
		if((count + other) > 0) {
			clearBust();
			showName("\nCREW");
			output("Who of your crew do you wish to interact with?" + crewMessages);
		}
		addButton(14, "Back", mainGameMenu);
	}
	if(allcrew) return (count + other);
	return count;
}

public function passiveTimeEffects(minPass:int = 0):Boolean
{
	if (minPass > 0)
	{
		if (pc.hasStatusEffect("Bitterly Cold") && tryApplyUvetoColdDamage(minPass)) return true;
	}
	return false;
}

public function rest(deltaT:int = -1):void {
	var minPass:int;
	//Turn encounters back on.
	flags["ENCOUNTERS_DISABLED"] = undefined;

	clearOutput();

	var postRestLustBonus:Number = 0;

	if (deltaT == -1)
	{
		if(pc.hasPerk("Auto-Autofellatio") && pc.hasCock())
		{
			//First time gudness
			if(pc.perkv1("Auto-Autofellatio") == 0 && pc.canAutoFellate(-1))
			{
				cumCowAutoFellatio(true, (280 + rand(30) + 1));
				return;
			}
			else if(pc.perkv2("Auto-Autofellatio") <= 0 && rand(3) == 0 && pc.canAutoFellate(-1))
			{
				cumCowAutoFellatio(true, (280 + rand(30) + 1));
				return;
			}
			else if(rand(20) == 0)
			{
				autoCocknosisDistraction();
				postRestLustBonus = pc.libido()/3 + 20;
			}
		}
		minPass = 230 + rand(20) + 1;
		if(pc.characterClass == GLOBAL.CLASS_SMUGGLER) {
			output("You take a rest for about " + num2Text(Math.round(minPass/60)) + " hours");
			if(pc.HP() < pc.HPMax()) output(" and dress your injuries with some less-than-legal nanogel you appropriated on an old job");
			output(".");
		}
		else output("You sit down and rest for around " + num2Text(Math.round(minPass/60)) + " hours.");
	}
	else
	{
		minPass = deltaT;
	}
	restHeal();
	processTime(minPass);
	pc.lust(postRestLustBonus);
	
	// Time passing effects
	if(passiveTimeEffects(minPass)) return;
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
public function restHeal():void
{
	var bonusMult:Number = 1 + pc.statusEffectv1("Home Cooking")/100;
	if(pc.HPRaw < pc.HPMax()) {
		if(pc.characterClass == GLOBAL.CLASS_SMUGGLER) pc.HP(Math.round(pc.HPMax()));
		else 
		pc.HP(Math.round(pc.HPMax() * .33 * bonusMult));
	}
	if(pc.energy() < pc.energyMax()) {
		pc.energy(Math.round(pc.energyMax() * .33 * bonusMult));
	}
}

public function sleep(outputs:Boolean = true):void {
	
	//Turn encounters back on.
	flags["ENCOUNTERS_DISABLED"] = undefined;
	
	if (kiMedbaySleeps()) return;
	
	var minPass:int = 420 + rand(80) + 1
	
	if(outputs) clearOutput();
	if(InShipInterior(pc))
	{
		if(outputs)
		{			
			// Anno interjection
			if (flags["ANNO_SLEEPWITH_INTRODUCED"] == undefined && annoIsCrew() && annoSexed() > 0)
			{
				annoSleepWithIntroduce();
				return;
			}
		}
	}
	if(outputs)
	{
		if ((pc.XPRaw >= pc.XPMax()) && pc.level < 8 && flags["LEVEL_UP_AVAILABLE"] == undefined)
		{
			(pc as PlayerCharacter).unspentStatPoints += 13;
			(pc as PlayerCharacter).unclaimedClassPerks += 1;
			(pc as PlayerCharacter).unclaimedGenericPerks += 1;
			
			pc.XPRaw -= pc.XPMax();
			pc.level++;
			pc.maxOutHP();
			
			// Enable the button
			userInterface.levelUpButton.Activate();
			
			eventBuffer += "\n\n" + logTimeStamp("good") + " A nights rest is just what you needed; you feel faster... stronger... harder....\n<b>Level Up is available!</b>";
		}
		else if (pc.level == 8)
		{
			eventBuffer += "\n\n" + logTimeStamp("good") + " <b>You've already reached the current maximum level. It will be raised in future builds.</b>";
		}
	}
	if(InShipInterior(pc))
	{
		if(outputs)
		{
			//CELISE NIGHT TIME BEDTIMEZ
			if(celiseIsCrew() && rand(3) == 0 && flags["CREWMEMBER_SLEEP_WITH"] == undefined)
			{
				celiseOffersToBeYourBedSenpai();
				return;
			}
			else if (annoIsCrew() && rand(3) == 0 && flags["CREWMEMBER_SLEEP_WITH"] == "ANNO")
			{
				annoSleepSexyTimes();
				return;
			}
			else if (bessIsCrew() && rand(3) == 0 && flags["CREWMEMBER_SLEEP_WITH"] == "BESS")
			{
				flags["BESS_SLEEPWITH_DOMORNING"] = 1;
			}
		}
	}
	if(outputs) output("You lie down and sleep for about " + num2Text(Math.round(minPass/60)) + " hours.");
	
	sleepHeal();
	
	processTime(minPass);
	dreamChances();
	if(outputs)
	{
		mimbraneSleepEvents();
		if(InShipInterior(pc)) grayGooSpessSkype();
	}
	
	//remove status effects
	pc.removeStatusEffect("Roshan Blue");
	
	// Time passing effects
	if(passiveTimeEffects(minPass)) return;
	
	clearMenu();
	if(InShipInterior(pc))
	{
		if (flags["ANNO_SLEEPWITH_DOMORNING"] != undefined)
		{
			addButton(0, "Next", annoMorningRouter);
			return;
		}
		if (flags["BESS_SLEEPWITH_DOMORNING"] == 1)
		{
			addButton(0, "Next", bessMorningEvents);
			return;
		}
		if (tryProcDommyReahaTime(minPass - rand(301)))
		{
			addButton(0, "Next", reahaDommyFuxTime);
			return;
		}
	}
	
	addButton(0, "Next", mainGameMenu);
}

public function sleepHeal():void
{
	if (pc.HPRaw < pc.HPMax()) 
	{
		pc.HP(Math.round(pc.HPMax()));
	}
	// Fecund Figure shape loss (Lose only after sore/working out)
	if(pc.hasPerk("Fecund Figure") && pc.isSore())
	{
		var numPreg:int = pc.totalPregnancies();
		if(pc.isPregnant(3)) numPreg--;
		
		var weightLoss:int = 0;
		if(pc.hasStatusEffect("Sore")) weightLoss = -1;
		if(pc.hasStatusEffect("Very Sore")) weightLoss = -2;
		if(pc.hasStatusEffect("Worn Out")) weightLoss = -3;
		
		if(numPreg <= 0)
		{
			pc.addPerkValue("Fecund Figure", 1, weightLoss);
			pc.addPerkValue("Fecund Figure", 2, weightLoss);
			pc.addPerkValue("Fecund Figure", 3, weightLoss);
		}
		pc.addPerkValue("Fecund Figure", 1, weightLoss);
		pc.addPerkValue("Fecund Figure", 2, weightLoss);
		pc.addPerkValue("Fecund Figure", 3, weightLoss);
		if(pc.perkv1("Fecund Figure") < 0) pc.setPerkValue("Fecund Figure", 1, 0);
		if(pc.perkv2("Fecund Figure") < 0) pc.setPerkValue("Fecund Figure", 2, 0);
		if(pc.perkv3("Fecund Figure") < 0) pc.setPerkValue("Fecund Figure", 3, 0);
	}
	if(pc.isSore()) soreChange(-3);
	pc.removeStatusEffect("Jaded");
	
	if (pc.energy() < pc.energyMax()) pc.energyRaw = pc.energyMax();
}

public function shipMenu():Boolean {
	
	rooms["SHIP INTERIOR"].outExit = shipLocation;
	
	setLocation("SHIP\nINTERIOR", rooms[rooms["SHIP INTERIOR"].outExit].planet, rooms[rooms["SHIP INTERIOR"].outExit].system);

	if(shipLocation == "KIROS SHIP AIRLOCK") output("\n\n<b>You're parked in the hangar of the distressed ship. You can step out to investigate at your leisure.</b>");
	
	// Lane follower hook
	if (tryFollowerLaneIntervention())
	{
		return true;
	}
	
	// Puppyslutmas hook :D
	if (annoIsCrew() && annoPuppyslutmasEntry())
	{
		return true;
	}
	
	// Goo Armor hook
	if (flags["ANNO_NOVA_UPDATE"] == 2)
	{
		grayGooArrivesAtShip();
		return true;
	}
	
	// Location Exceptions
	if(shipLocation == "600") myrellionLeaveShip();
	
	// Main ship interior buttons
	if(currentLocation == "SHIP INTERIOR")
	{
		if (crew(true, true) > 0) addButton(2, "Crew", crew);
		if (hasShipStorage()) addButton(3, "Storage", shipStorageMenuRoot);
		else addDisabledButton(3, "Storage");
		addButton(4, "Shower", showerMenu);
		addButton(5, "Fly", flyMenu);
	}
	
	return false;
}

public function flyMenu():void {
	clearOutput();
	if(pc.hasStatusEffect("Disarmed") && shipLocation == "500")
	{
		if(flags["CHECKED_GEAR_AT_OGGY"] != undefined)
		{
			output("<b>Your gear is still locked up in customs. You should go grab it before you jump out of system.");
			clearMenu();
			addButton(14, "Back", mainGameMenu);
			return;
		}
		else 
		{
			pc.removeStatusEffect("Disarmed");
		}
	}
	output("Where do you want to go?");
	clearMenu();
	//TAVROS
	if(shipLocation != "TAVROS HANGAR") 
		addButton(0, "Tavros", flyTo, "Tavros");
	else addDisabledButton(0, "Tavros");
	//MHEN'GA
	if(shipLocation != "SHIP HANGAR") 
		addButton(1, "Mhen'ga", flyTo, "Mhen'ga");
	else addDisabledButton(1, "Mhen'ga");
	//TARKUS
	if(flags["UNLOCKED_JUNKYARD_PLANET"] != undefined)
	{
		if(shipLocation != "201") addButton(2, "Tarkus", flyTo, "Tarkus");
		else addDisabledButton(2, "Tarkus", "You’re already here.");
	}
	else addDisabledButton(2, "Locked", "Locked", "You need to find your father’s probe on Mhen’ga to get this planet’s coordinates.");
	//MYRELLION
	if(flags["PLANET_3_UNLOCKED"] != undefined)
	{
		if (flags["KQ2_MYRELLION_STATE"] == undefined)
		{
			if(shipLocation != "600") addButton(3, "Myrellion", flyTo, "Myrellion");
			else addDisabledButton(3, "Myrellion", "Myrellion", "You’re already here.");
		}
		else if (flags["KQ2_MYRELLION_STATE"] == 1)
		{
			addDisabledButton(3, "Myrellion", "Myrellion", "It would be wise not to visit a planet currently experiencing a heavy nuclear winter...");
		}
		else
		{
			if (shipLocation != "2I7") addButton(3, "Myrellion", flyTo, "MyrellionDeepCaves");
			else addDisabledButton(3, "Myrellion", "Myrellion", "You’re already here.");
		}
	}
	else addDisabledButton(3, "Locked", "Locked", "You need to find one of your father’s probes to access this planet’s coordinates and name.");
	
	//NEW TEXAS
	if(flags["NEW_TEXAS_COORDINATES_GAINED"] != undefined)
	{
		if(shipLocation != "500") addButton(5, "New Texas", flyTo, "New Texas");
		else addDisabledButton(5, "New Texas", "New Texas", "You’re already here.");
	}
	else addDisabledButton(5, "Locked", "Locked", "You have not yet learned of this planet’s coordinates.");
	//POE A
	if(flags["HOLIDAY_OWEEN_ACTIVATED"] != undefined)
	{
		if(flags["POE_A_DISABLED"] == 1) addDisabledButton(6, "Poe A", "Poe A", "You probably shouldn’t go back there after your last trip to ‘The Masque.’")
		else if(shipLocation != "POESPACE") addButton(6, "Poe A", flyTo, "Poe A");
		else addDisabledButton(6, "Poe A", "Poe A", "You’re already here.");
	}
	else addDisabledButton(6, "Locked", "Locked", "You have not yet learned of this planet’s coordinates.");
	//UVETO
	if (uvetoUnlocked())
	{
		if (shipLocation != "UVS F15") addButton(7, "Uveto", flyTo, "Uveto");
		else addDisabledButton(7, "Uveto", "Uvto", "You’re already here.");
	}
	else addDisabledButton(7, "Locked", "Locked", "You have not yet learned of this planet’s coordinates.");
	
	//KQ2
	if (flags["KQ2_QUEST_OFFER"] != undefined && flags["KQ2_QUEST_DETAILED"] == undefined)
	{
		addButton(10, "Kara", flyTo, "karaQuest2", "Kara", "Go see what Kara has up her sleeve.");
	}
	
	addButton(14, "Back", mainGameMenu);
}

public function flyTo(arg:String):void {
	
	generateMapForLocation("SHIP INTERIOR");
	
	if (flags["SUPRESS TRAVEL EVENTS"] == 1)
	{
		flags["SUPRESS TRAVEL EVENTS"] = 0;
	}
	else if(!InCollection(arg, ["Poe A", "karaQuest2"]))
	{
		//Eggshit Override!
		if (pc.hasItem(new StrangeEgg()) || pc.hasItemInStorage(new StrangeEgg()))
		{
			//PC can preggo with it?
			//Has an open spot!
			if(pc.findEmptyPregnancySlot(0) != -1 && !pc.hasPregnancyOfType("PsychicTentacles"))
			{
				fuckingEggHatchOhFuck(arg);
				return;
			}
		}
		//Normal message events.
		var tEvent:Function = tryProcTravelEvent(arg);
		if (tEvent != null)
		{
			incomingMessage(tEvent, arg);
			return;
		}
	}
	
	var shortTravel:Boolean = false;
	var interruptMenu:Boolean = false;
	
	clearOutput();
	
	if(arg == "Mhen'ga")
	{
		shipLocation = "SHIP HANGAR";
		currentLocation = "SHIP HANGAR";
		flyToMhenga();
	}
	else if(arg == "Tavros")
	{
		shipLocation = "TAVROS HANGAR";
		currentLocation = "TAVROS HANGAR";
		flyToTavros();
	}
	else if(arg == "Tarkus")
	{
		shipLocation = "201";
		currentLocation = "201";
		landOnTarkus();
	}
	else if(arg == "New Texas")
	{
		shipLocation = "500";
		currentLocation = "500";
		landOnNewTexas();
	}
	else if(arg == "Myrellion")
	{
		shipLocation = "600";
		currentLocation = "600";
		flyToMyrellion();
	}
	else if (arg == "MyrellionDeepCaves")
	{
		shipLocation = "2I7";
		currentLocation = "2I7";
		flyToMyrellionDeepCaves();
	}
	else if(arg == "Poe A")
	{
		shipLocation = "POESPACE";
		currentLocation = "POESPACE";
		flyToPoeA();
	}
	else if (arg == "karaQuest2")
	{
		shortTravel = (shipLocation == "600");
		interruptMenu = true;
		kq2TravelToKara(shortTravel);
	}
	else if (arg == "Uveto")
	{
		shipLocation = "UVS F15";
		currentLocation = "UVS F15";
		flyToUveto();
		interruptMenu = true;
	}
	
	var timeFlown:Number = (shortTravel ? 30 + rand(10) : 600 + rand(30));
	StatTracking.track("movement/time flown", timeFlown);
	processTime(timeFlown);
	setLocation("SHIP\nINTERIOR", rooms[shipLocation].planet, rooms[shipLocation].system);
	
	if (!interruptMenu)
	{
		if(landingEventCheck(arg)) return;
		flags["LANDING_EVENT_CHECK"] = 1;
		
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

public function leaveShipOK():Boolean
{
	if(pc.hasStatusEffect("Endowment Immobilized"))
	{
		output(" and attempt to head towards the airlock... but you can barely budge an inch from where you are sitting. You’re immobilized. It looks like your endowments have swollen far too large, making it impossible for you to exit your ship! <b>You’ll have to take care of that if you want to leave...</b>");
		currentLocation = "SHIP INTERIOR";
		return false;
	}
	return true;
}

public function landingEventCheck(arg:String = ""):Boolean
{
	if(flags["LANDING_EVENT_CHECK"] != 1) return false;
	
	flags["LANDING_EVENT_CHECK"] = undefined;
	
	if(arg == "Mhen'ga")
	{
		if(((annoIsCrew() && flags["ANNOxSYRI_EVENT"] != undefined) || !annoIsCrew()) && syriIsAFuckbuddy() && rand(5) == 0)
		{
			currentLocation = "SHIP INTERIOR";
			gettingSyrisPanties();
			return true;
		}
	}
	if(arg != "New Texas")
	{
		// Wild varmint stowaway!
		if(varmintStowaway())
		{
			currentLocation = "SHIP INTERIOR";
			getAPetVarmint();
			return true;
		}
	}
	return false;
}

public function showerMenu():void {
	clearOutput();
	output("You find yourself in the ship’s shower room. What would you like to do?");
	clearMenu();
	addButton(0, "Shower", showerOptions, 0, "Shower", "Take a shower and wash off any sweat or grime you might have.");
	if (pc.lust() >= 33 && crew(true) > 0) addButton(1, "Sex", showerOptions, 1, "Sex", "Have some shower sex with a crew member.");
	addButton(14, "Back", mainGameMenu);
}

public function showerOptions(option:int = 0):void {
	clearOutput();
	clearMenu();
	var showerSex:int = 0;
	// Regular showers
	if (option == 0)
	{
		author("Couch");
		output("Adventuring is fun and all, but it also leaves a [pc.guy] feeling dirty at the end of the day");
		if (pc.libido() > 50) output(", and not in the good way");
		output(". You decide to hit the showers, stripping off your gear with a sigh of relief as you take a moment just to stretch and enjoy being");
		if (pc.isNude()) output(" fully");
		else output(" truly");
		output(" nude.");
		output("\n\nThe water comes out icy cold, sending a shiver down your spine. You think to yourself that you really should spring for a better temperature regulator, carefully adjusting the dial back and forth until finding that sweet spot between freezing and scalding where the water is blissfully warm. Now you can finally relax, setting to applying a good dose of shampoo to your [pc.hair]. Your [pc.skinFurScalesNoun] comes next, your hands running up and down your front to coat every last inch in a nice thick lather.");
		if (pc.biggestTitSize() >= 4) output(" You can’t help but take a moment just to grope your [pc.chest], licking your lips at how good it feels to be so busty.");
		if (pc.hasWings()) output(" Now for the fun part.");
		output(" You carefully apply more body wash to a brush and reach with it over your shoulder to scrub your back.");
		if (pc.hasWings())
		{
			output(" As it hits that spot right between your wingpoints you can’t help but shudder and moan,");
			if (pc.hasCock()) output(" [pc.eachCock] stiffening at");
			output(" the rush of pleasure cascading down your spine. Gods, you love having wings! They get their own turn at being washed when your back’s done, delicate brushing ensuring they’re free of dust and grime.");
		}
		output("\n\nOf course, you can’t forget below the belt.");
		if (pc.hasTail()) output(" You curl [pc.oneTail] in front to help with lathering it up, briefly relishing the little pleasure spot right at the top of where it meets your spine.");
		output(" Your [pc.hips] come next, followed by your [pc.ass]");
		if (pc.tone >= 30 && pc.buttRating() < 4) output(", relishing the hard, taut muscles you’ve worked so hard to achieve");
		else if (pc.tone < 30 && pc.buttRating() >= 10) output(", unable to resist topping it off with a good spank");
		output(".");
		output("\n\nEven after you’re fully rinsed off, you let yourself stay under the water for a few minutes longer, just enjoying the warmth running down your body. There’s nothing like a good shower to just melt all the tension away.");
		if (pc.lust() >= 33)
		{
			output(" In fact...");
			output("\n\nYou");
			if(pc.hasGenitals())
			{
				if(pc.genitalLocation() >= 2) output(" look back at your groin,");
				else output(" look down,");
				if (pc.hasCock()) output(" [pc.eachCock] stiff");
				if (pc.hasCock() && pc.hasVagina()) output(" and");
				if (pc.hasVagina()) output(" [pc.eachVagina] slick");
			}
			else output(" flex your [pc.asshole]");
			output(". Maybe you’re not done showering just yet.");
			
			if (pc.hasStatusEffect("Myr Venom Withdrawal")) addDisabledButton(0, "Masturbate", "Masturbate", "While you’re in withdrawal, you don’t see much point in masturbating, no matter how much your body may want it.");
			else if (!pc.canMasturbate()) addDisabledButton(0, "Masturbate", "Masturbate", "You can’t seem to masturbate at the moment....");
			else
			{
				showerSex = shipShowerFaps(true);
			}
			addButton(showerSex, "Nevermind", shipShowerFappening, "Nevermind", "On second thought...");
		}
		else
		{
			output("\n\nFinally you feel you’ve gotten all the relaxation you can and shut off the water, stepping out and toweling yourself off. You slip your gear on with a refreshed smile, squeaky clean and ready to resume your adventure.");
			addButton(0, "Next", mainGameMenu);
		}
		
		pc.shower();
		processTime(10);
	}
	// Shower sex options
	else if (option == 1)
	{
		if (annoIsCrew() && pc.hasGenitals())
		{
			addButton(showerSex, "Anno", annoFollowerShowerSex);
			showerSex++;
		}
		if (showerSex > 0) output(" Feeling a little turned on, you decide that maybe you should have some fun shower sex with one of your crew. Who do you approach?");
		else output(" You don’t seem to have any crew members onboard who can have shower sex with you at the moment.");
		addButton(14, "Back", showerMenu);
	}
}

public function sneakBackYouNudist():void
{
	clearOutput();
	output("You meticulously make your way back to the ship using every ounce of subtlety you possess. It takes way longer than you would have thought thanks to a couple of near-misses, but you make it safe and sound to the interior of your craft.");
	processTime(180+rand(30));
	currentLocation = "SHIP INTERIOR";
	generateMap();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function move(arg:String, goToMainMenu:Boolean = true):void {
	//Prevent movement for nudists into nude-restricted zones.
	if(rooms[arg].hasFlag(GLOBAL.NUDITY_ILLEGAL))
	{
		var nudistPrevention:Boolean = false;
		if((!pc.isChestGarbed() || pc.isChestExposed()) && pc.biggestTitSize() > 1) nudistPrevention = true;
		if(!pc.isCrotchGarbed() || pc.isCrotchExposed() || pc.isAssExposed()) nudistPrevention = true;
		if(pc.canCoverSelf(true)) nudistPrevention = false;
		if(nudistPrevention)
		{
			clearOutput();
			output("Nudity is illegal in that location! You'll have to cover up if you want to go there.");
			clearMenu();
			addButton(0, "SneakBack", sneakBackYouNudist, undefined, "SneakBack", "Sneak back to the ship. Fuckin' prudes. It might take you a couple hours to get back safely.");
			addButton(14, "Back", mainGameMenu);
			return;
		}
	}
	//Reset the thing that disabled encounters
	flags["ENCOUNTERS_DISABLED"] = undefined;

	var moveMinutes:int = rooms[currentLocation].moveMinutes;
	//Moveable immobilization adds more minutes!
	moveMinutes += immobilizedUpdate(true);
	//Huge nuts slow you down
	if(pc.hasStatusEffect("Egregiously Endowed")) moveMinutes *= 2;
	if(pc.hasItem(new DongDesigner())) moveMinutes *= 2;
	if(pc.hasItem(new Hoverboard())) {
		moveMinutes -= 1;
		if(moveMinutes < 1) moveMinutes = 1;
	}
	StatTracking.track("movement/time travelled", moveMinutes);
	processTime(moveMinutes);
	flags["PREV_LOCATION"] = currentLocation;
	currentLocation = arg;
	generateMap();
	if(pc.hasStatusEffect("Treatment Exhibitionism Gain 4 DickGirls") && pc.hasCock() && rooms[arg].hasFlag(GLOBAL.PUBLIC)) treatmentCumCowExhibitionism();
	trace("Printing map for " + currentLocation);
	//mapper.printMap(map);
	//process time here, then back to mainGameMenu!
	if(goToMainMenu) mainGameMenu(moveMinutes);
}

public function variableRoomUpdateCheck():void
{
	/* TAVROS STATION */
	
	//Residental Deck
	//Notices
	if(tavrosRDActiveNotice()) rooms["RESIDENTIAL DECK 2"].addFlag(GLOBAL.OBJECTIVE);
	else rooms["RESIDENTIAL DECK 2"].removeFlag(GLOBAL.OBJECTIVE);
	//Place Aina's NPC flag depending whenever or not the PC meet her + generate her room
	if(flags["HELPED_AINA"] == undefined) 
	{ 
		rooms["RESIDENTIAL DECK 15"].addFlag(GLOBAL.NPC);
		lockAinasRoom();
	}
	else if(flags["HELPED_AINA"] == true)
	{ 
		rooms["RESIDENTIAL DECK 15"].removeFlag(GLOBAL.NPC);
		unlockAinasRoom();
	}
	else
	{
		rooms["RESIDENTIAL DECK 15"].removeFlag(GLOBAL.NPC);
		lockAinasRoom();
	}
	//Place/remove Semith's NPC flag from chess area based on time and if pc played with him already
	if (hours >= 12 && hours <= 17) rooms["RESIDENTIAL DECK 7"].addFlag(GLOBAL.NPC);
	else rooms["RESIDENTIAL DECK 7"].removeFlag(GLOBAL.NPC);
	//Place/remove Semith's NPC flag from his apartment based on time.
	if (hours > 17) rooms["RESIDENTIAL DECK SEMITHS APARTMENT"].addFlag(GLOBAL.NPC);
	else rooms["RESIDENTIAL DECK SEMITHS APARTMENT"].removeFlag(GLOBAL.NPC);
	
	/* MHENGA */
	
	//Bounties
	if(mhengaActiveBounty()) rooms["ESBETH'S NORTH PATH"].addFlag(GLOBAL.OBJECTIVE);
	else rooms["ESBETH'S NORTH PATH"].removeFlag(GLOBAL.OBJECTIVE);
	//Kelly's work - close/open Xenogen Biotech.
	//Open up shop: link room
	if(hours >= 6 && hours < 17) 
	{
		rooms["SOUTH ESBETH 2"].northExit = "KELLY'S OFFICE";
		rooms["BURT'S BACK END"].removeFlag(GLOBAL.NPC);
		//Add back in icons.
		rooms["JULIAN'S OFFICE"].addFlag(GLOBAL.NPC);
		rooms["KELLY'S OFFICE"].addFlag(GLOBAL.NPC);
	}
	//Close shop: 
	else
	{
		//rooms["SOUTH ESBETH 2"].northExit = "";
		//Get rid of icons
		rooms["KELLY'S OFFICE"].removeFlag(GLOBAL.NPC);
		rooms["JULIAN'S OFFICE"].removeFlag(GLOBAL.NPC);
		//Add Kelly icon in the bar
		rooms["BURT'S BACK END"].addFlag(GLOBAL.NPC);
	}
	//Hungry Hungry Rahn
	if(flags["SEEN_BIMBO_PENNY"] != undefined && (hours < 8 || hours >= 17))
	{
		rooms["CUSTOMS OFFICE"].removeFlag(GLOBAL.NPC);
	}
	else rooms["CUSTOMS OFFICE"].addFlag(GLOBAL.NPC);
	//Pitchers on Mhen'ga
	if(flags["ROOM_80_PITCHER_MET"] == 1)
	{
		rooms["OVERGROWN ROCK 12"].addFlag(GLOBAL.PLANT_BULB);
	}
	else rooms["OVERGROWN ROCK 12"].removeFlag(GLOBAL.PLANT_BULB);
	if(flags["ROOM_65_PITCHER_MET"] == 1)
	{
		rooms["VINED JUNGLE 3"].addFlag(GLOBAL.PLANT_BULB);
	}
	else rooms["VINED JUNGLE 3"].removeFlag(GLOBAL.PLANT_BULB);
	if(flags["ROOM_61_PITCHER_MET"] == 1)
	{
		rooms["DEEP JUNGLE 2"].addFlag(GLOBAL.PLANT_BULB);
	}
	else rooms["DEEP JUNGLE 2"].removeFlag(GLOBAL.PLANT_BULB);
	// Visited Thare Plantation
	if(flags["THARE_MANOR_ENTERED"] != undefined) rooms["THARE MANOR"].addFlag(GLOBAL.OBJECTIVE);
	else rooms["THARE MANOR"].removeFlag(GLOBAL.OBJECTIVE);
	//Mhenga Probe
	if(flags["DIDNT_ENGAGE_RIVAL_ON_MHENGA"] == undefined && flags["FOUGHT_DANE_ON_MHENGA"] == undefined)
	{
		rooms["METAL POD 1"].roomName = "METAL\nPOD";
		rooms["METAL POD 1"].addFlag(GLOBAL.HAZARD);
		rooms["METAL POD 1"].addFlag(GLOBAL.QUEST);
		rooms["METAL POD 1"].removeFlag(GLOBAL.OBJECTIVE);
	}
	else if(flags["MHENGA_PROBE_CASH_GOT"] == undefined && flags["WHUPPED_DANES_ASS_ON_MHENGA"] != undefined)
	{
		rooms["METAL POD 1"].roomName = "METAL\nPOD";
		rooms["METAL POD 1"].removeFlag(GLOBAL.HAZARD);
		rooms["METAL POD 1"].removeFlag(GLOBAL.QUEST);
		rooms["METAL POD 1"].addFlag(GLOBAL.OBJECTIVE);
	}
	else
	{
		rooms["METAL POD 1"].roomName = "SMALL\nCRATER";
		rooms["METAL POD 1"].removeFlag(GLOBAL.HAZARD);
		rooms["METAL POD 1"].removeFlag(GLOBAL.QUEST);
		rooms["METAL POD 1"].removeFlag(GLOBAL.OBJECTIVE);
	}
	
	
	/* TARKUS */
	
	// Chasmfall entrance
	if(flags["STELLAR_TETHER_CLOSED"] == undefined)
	{
		rooms["350"].addFlag(GLOBAL.HAZARD);
		if(MailManager.isEntryViewed("annoweirdshit")) rooms["350"].addFlag(GLOBAL.OBJECTIVE);
		else rooms["350"].removeFlag(GLOBAL.OBJECTIVE);
	}
	else
	{
		rooms["350"].removeFlag(GLOBAL.HAZARD);
		rooms["350"].removeFlag(GLOBAL.OBJECTIVE);
	}
	// Stellar Tether probe clue
	if(flags["TARKUS_BOMB_TIMER"] != undefined && flags["TARKUS_BOMB_TIMER"] <= 0 && flags["PLANET_3_UNLOCKED"] == undefined) rooms["WIDGET WAREHOUSE"].addFlag(GLOBAL.QUEST);
	else rooms["WIDGET WAREHOUSE"].removeFlag(GLOBAL.QUEST);
	//Handle planet explosions
	if(flags["TARKUS_DESTROYED"] == 1 && rooms["211"].southExit != "") 
	{
		trace("PLANET BLEWED UP. HIDIN ROOMS");
		rooms["211"].southExit = "";
		rooms["213"].southExit = "";
	}
	else if(rooms["211"].southExit == "" && flags["TARKUS_DESTROYED"] == undefined)
	{
		trace("PLANET DIDN'T BLOWED UP. LINKIN' ROOMS");
		rooms["211"].southExit = "215";
		rooms["213"].southExit = "295";
	}
	//Sexbot factory opeeeeeen.
	if(flags["SEXBOTS_SCANNED_FOR_COLENSO"] != undefined && flags["SEXBOTS_SCANNED_FOR_COLENSO"] >= 4)
	{
		rooms["256"].southExit = "294";
	}
	else
	{
		rooms["256"].southExit = undefined;
	}
	// Annos shop
	if (!steeleTechTarkusShopAvailable())
	{
		rooms["303"].removeFlag(GLOBAL.NPC);
	}
	else
	{
		rooms["303"].addFlag(GLOBAL.NPC);
	}
	// Deck 13 Reactor -> Databank room
	if (flags["DECK13_REACTOR_DOOR_OPEN"] == undefined)
	{
		rooms["DECK 13 REACTOR"].northExit = undefined;
	}
	else
	{
		rooms["DECK 13 REACTOR"].northExit = "DECK 13 SECONDARY REACTOR";
	}
	// Deck 13 Reactor -> Vents
	if (flags["DECK13_REACTOR_DOOR_OPEN"] != undefined)
	{
		rooms["DECK 13 REACTOR"].eastExit = undefined;
	}
	else
	{
		rooms["DECK 13 REACTOR"].eastExit = "DECK 13 VENTS";
	}
	//Handle badger closure
	if(flags["DR_BADGER_TURNED_IN"] != undefined && rooms["209"].northExit != "") rooms["209"].northExit = "";
	if(flags["DR_BADGER_TURNED_IN"] == undefined && rooms["209"].northExit == "") rooms["209"].northExit = "304";
	// Arbetz Open:
	if (arbetzActiveHours())
	{
		rooms["ARBETZ MAIN"].addFlag(GLOBAL.NPC);
		rooms["ARBETZ POOL"].addFlag(GLOBAL.OBJECTIVE);
	}
	// Arbetz Closed:
	else
	{
		rooms["ARBETZ MAIN"].removeFlag(GLOBAL.NPC);
		rooms["ARBETZ POOL"].removeFlag(GLOBAL.OBJECTIVE);
	}
	// Lane is away
	if (flags["LANE_DISABLED"] == undefined) rooms["LANESSHOP"].addFlag(GLOBAL.NPC);
	else rooms["LANESSHOP"].removeFlag(GLOBAL.NPC);
	
	
	/* NEW TEXAS */
	
	// Brynn's Stall
	if (flags["BRYNN_MET_TODAY"] == 1) rooms["BrynnsStall"].removeFlag(GLOBAL.NPC);
	else rooms["BrynnsStall"].addFlag(GLOBAL.NPC);
	// Quenton Gym stuffs
	if (pc.hasKeyItem("Ten Ton Gym Membership") || pc.hasStatusEffect("Gym Pass"))
	{
		rooms["571"].addFlag(GLOBAL.OBJECTIVE);
		rooms["572"].addFlag(GLOBAL.OBJECTIVE);
		rooms["573"].addFlag(GLOBAL.OBJECTIVE);
		rooms["574"].addFlag(GLOBAL.OBJECTIVE);
	}
	else
	{
		rooms["571"].removeFlag(GLOBAL.OBJECTIVE);
		rooms["572"].removeFlag(GLOBAL.OBJECTIVE);
		rooms["573"].removeFlag(GLOBAL.OBJECTIVE);
		rooms["574"].removeFlag(GLOBAL.OBJECTIVE);
	}
	// Gianna
	if (giannaAWOL()) rooms["512"].removeFlag(GLOBAL.NPC);
	else rooms["512"].addFlag(GLOBAL.NPC);
	
	
	/* MYRELLION */
	
	// Yarasta Shit
	if(flags["MET_YARASTA"] != undefined)
	{
		//In classroom? 737
		if((hours >= 6 && hours < 12) || (hours >= 13 && hours < 18) || hours == 19 || hours == 20) rooms["737"].addFlag(GLOBAL.NPC);
		else rooms["737"].removeFlag(GLOBAL.NPC);
		//In Mush park 736
		if(hours == 12 || hours == 18) rooms["736"].addFlag(GLOBAL.NPC);
		else rooms["736"].removeFlag(GLOBAL.NPC);
		//In lobby (735)
		if(hours == 21) rooms["735"].addFlag(GLOBAL.NPC);
		else rooms["735"].removeFlag(GLOBAL.NPC);
	}
	// Steph Myrellion shit
	/*
	if (flags["STEPH_WATCHED"] == undefined)
	{
		rooms["1F22"].removeFlag(GLOBAL.NPC);
	}
	else
	{
		if (flags["STEPH_WORK_CHOICE"] == undefined)
		{
			rooms["1F22"].addFlag(GLOBAL.NPC);
		}
		else
		{
			rooms["1F22"].removeFlag(GLOBAL.NPC);
		}
	}
	*/
	// Doc McAllister
	if (mcallisterIsIn())
	{
		rooms["XBMYRELLIONLAB"].addFlag(GLOBAL.NPC);
	}
	else
	{
		rooms["XBMYRELLIONLAB"].removeFlag(GLOBAL.NPC);
	}
	// Liriel's Lemonade Stand
	if (flags["LIRIEL_MET"] != undefined && lirielStandActiveHours())
	{
		rooms["706"].addFlag(GLOBAL.NPC);
	}
	else
	{
		rooms["706"].removeFlag(GLOBAL.NPC);
	}
	//Irellia quest stuff.
	//IrelliaQuest incomplete. No east passage, people token in main room.
	if(flags["IRELLIA_QUEST_STATUS"] == undefined || flags["IRELLIA_QUEST_STATUS"] < 6)
	{
		// Quest markers
		//Added by JCup
		if(flags["IRELLIA_QUEST_STATUS"] == 2 && (hours >= 17 && hours <= 18)) rooms["708"].addFlag(GLOBAL.OBJECTIVE);
		else rooms["708"].removeFlag(GLOBAL.OBJECTIVE);
		if(flags["IRELLIA_QUEST_STATUS"] == 3 && hours >= 23) rooms["725"].addFlag(GLOBAL.OBJECTIVE);
		else rooms["725"].removeFlag(GLOBAL.OBJECTIVE);

		rooms["746"].addFlag(GLOBAL.NPC);
		rooms["747"].removeFlag(GLOBAL.NPC);
		rooms["746"].eastExit = "";
	}
	//IrelliaQuest complete: establish east/west link and move people token to Irellia's chambers
	else
	{
		rooms["746"].eastExit = "747";
		rooms["746"].removeFlag(GLOBAL.NPC);
		rooms["747"].addFlag(GLOBAL.NPC);
	}
	//Nyrea gate should be open
	if(nyreaDungeonGateOpen()) 
	{
		rooms["2G11"].westExit = "2E11";
		if(nyreaDungeonFinished()) rooms["2G11"].removeFlag(GLOBAL.QUEST);
		else rooms["2G11"].addFlag(GLOBAL.QUEST);
	}
	//Nyrea gate should be closed
	else 
	{
		rooms["2G11"].westExit = "";
		if(!nyreaDungeonFinished()) rooms["2G11"].addFlag(GLOBAL.QUEST);
		else rooms["2G11"].removeFlag(GLOBAL.QUEST);
	}
	//Other nyrea gate:
	if(flags["UNLOCKED_TAIVRAS_GATE"] == undefined) rooms["2G15"].southExit = "";
	else rooms["2G15"].southExit = "2G17";
	//Queensguard shit
	if(queensguardAtFountain()) 
	{
		rooms["2C13"].addFlag(GLOBAL.NPC);
	}
	else rooms["2C13"].removeFlag(GLOBAL.NPC);
	//Fungus area open:
	if(flags["FUNGUS_QUEEN_SAVED"] == undefined && flags["LET_FUNGUS_QUEEN_DIE"] == undefined)
	{
		rooms["2S11"].northExit = "2S9";
		if(CodexManager.entryUnlocked("Myr Fungus")) rooms["2S7"].addFlag(GLOBAL.OBJECTIVE);
	}
	else 
	{
		rooms["2S7"].removeFlag(GLOBAL.OBJECTIVE);
		rooms["2S11"].northExit = "";
	}
	// Crystal Goo Silly Modes
	if(silly) rooms["2O25"].southExit = "2O27";
	else rooms["2O25"].southExit = "";
	
	// KQuest
	kquest2RoomStateUpdater();
	if (flags["KQ2_MYRELLION_STATE"] == 2)
	{
		rooms["2I7"].removeFlag(GLOBAL.TAXI);
		rooms["2I7"].addFlag(GLOBAL.SHIPHANGAR);
	}
	else
	{
		rooms["2I7"].removeFlag(GLOBAL.SHIPHANGAR);
		rooms["2I7"].addFlag(GLOBAL.TAXI);
	}
	
	
	/* UVETO */
	
	// Huskar Bimbos
	if(uvetoStationLoungeHuskarBimboActive())
	{
		rooms["UVS B7"].addFlag(GLOBAL.NPC);
	}
	else
	{
		rooms["UVS B7"].removeFlag(GLOBAL.NPC);
	}
	// Shade Lover letter and home stuff
	if(MailManager.isEntryViewed("letter_from_shade") && flags["SHADE_ON_UVETO"] == 2 && shadeIsLover() && (shadeIsSiblings() || hours >= 16))
	{
		rooms["UVI P30"].addFlag(GLOBAL.OBJECTIVE);
	}
	else if(flags["SHADE_ON_UVETO"] >= 3 && shadeIsHome())
	{
		rooms["UVI P30"].addFlag(GLOBAL.NPC);
	}
	else
	{
		rooms["UVI P30"].removeFlag(GLOBAL.OBJECTIVE);
		rooms["UVI P30"].removeFlag(GLOBAL.NPC);
	}
}

public function processTime(arg:int):void {
	var x:int = 0;
	var msg:String = "";
	
	var tightnessChanged:Boolean = false;
	
	var productionFactor:Number = 100 / (1920) * ((pc.libido() * 3 + 100) / 100);
	// Ideally most of this character updating shit needs to be shifted into the Creature class itself
	// Then everything can just get stuffed in this loop as like chars[prop].processTime(arg) and hook everything like that.
	for (var prop:String in chars)
	{
		//Cum volume only simulated for those that simulate dat shit.
		if(chars[prop].fluidSimulate)
		{
			if(chars[prop].ballFullness < 100 || chars[prop] is PlayerCharacter) chars[prop].cumProduced(arg);
			chars[prop].cumFlationSimulate(arg);
		}
	}
	pc.cumFlationSimulate(arg);
	pc.cumProduced(arg);
	
	//Double time
	if (pc.hasPerk("Extra Ardor")) productionFactor *= 2;
	//Huge nuts double time!
	if (pc.hasStatusEffect("Ludicrously Endowed")) productionFactor *= 1.5;
	if (pc.hasStatusEffect("Overwhelmingly Endowed")) productionFactor *= 2;
	
	if (pc.hasStatusEffect("Red Myr Venom")) productionFactor *= 1.5;
	if (pc.hasStatusEffect("Egg Addled 1")) productionFactor *= 1.25;
	if (pc.hasStatusEffect("Egg Addled 3")) productionFactor *= 1.75;
		
	//BOOZE QUADRUPLES TIEM!
	if(pc.hasStatusEffect("X-Zil-rate") || pc.hasStatusEffect("Mead") || pc.hasStatusEffect("X-Zil-rate"))
	productionFactor *= 4;
	
	//Half time.
	else if (pc.hasPerk("Ice Cold")) productionFactor /= 2;
	
	if (pc.hasStatusEffect("Leitha Charm"))
	{
		// Hardcoding checks because we might have issues with items being replaced without running through equipItem() and
		// thus calling onEquip/onRemove.
		if (!(pc.accessory is LeithaCharm))
		{
			throw new Error("Leitha Charm status effect present, but the item isn't presently equipped to the player!");
		}
		else
		{
			pc.addStatusValue("Leitha Charm", 1, arg * 20); // temp debug shit
		}
	}

	//Used to establish a cap
	var lustCap:Number = Math.round(pc.lustMax() * .75);
	if(pc.hasStatusEffect("Egg Addled 2")) lustCap = pc.lustMax();
	//Not going over lustcap? Proceed as normal.
	if(pc.lust() + (arg * productionFactor) < lustCap)
	{
		//trace("Not going over lustcap. Lust: " + pc.lust() + " LustCap: " + lustCap + " Arg&Prod: " + arg*productionFactor);
		//Actually apply lust.
		pc.lust(arg * productionFactor);
	}
	//Already over the lustcap? Slowly reduce current lust.
	else if(pc.lust() > lustCap)
	{
		var reduce:Number = arg * productionFactor / 4;
		//Ice Cold - Ice cold becomes extra effective here., effectively multiplying loss by x4 (since it halved gains earlier)
		if (pc.hasPerk("Ice Cold")) reduce *= 4;
		//The reverse for Extra Ardor. Reduces much slower.
		if (pc.hasPerk("Extra Ardor")) reduce /= 4;
		pc.lust(-reduce);
	}
	//Gonna hit the cap? Change to cap.
	else
	{
		pc.lustRaw = lustCap;
	}
		
	//Top off shields
	pc.shieldsRaw = pc.shieldsMax();
	
	PregnancyManager.updatePregnancyStages(chars, arg);
	
	//milk is chunked out all at once due to lazies
	if(arg > 0 && pc.canLactate()) 
	{
		//Celise overnights halt milkstuff.
		if(!pc.hasStatusEffect("Milk Paused"))
		{
			//trace("time rested: " + arg);
			pc.milkProduced(arg);
			milkGainNotes();
		}
	}
	
	if (flags["MIMBRANES BITCH TIMER"] == undefined)
	{
		flags["MIMBRANES BITCH TIMER"] = arg;
	}
	else
	{
		flags["MIMBRANES BITCH TIMER"] += arg;
	}
	
	if (flags["MIMBRANES BITCH TIMER"] >= 300)
	{
		flags["MIMBRANES BITCH TIMER"] = 0;
		mimbranesComplainAndShit();
	}

	//Queue up procs for boobswell shit
	if (pc.hasStatusEffect("Boobswell Pads")) boobswellStuff(arg);

	//Laneshit
	processLaneDetoxEvents(arg);
	
	// Extra special handler for Renvra's egg messages
	if (pc.hasStatusEffect("Renvra Eggs Messages Available") || pc.hasStatusEffect("Nyrea Eggs Messages Available") || pc.hasStatusEffect("Royal Eggs Messages Available"))
	{
		var cRoom:RoomClass = rooms[currentLocation];
		var pSpace:Boolean = cRoom.hasFlag(GLOBAL.PUBLIC);
		
		// This should avoid doubling messages up if the player has both pregnancies at the same time.
		if (pc.hasStatusEffect("Renvra Eggs Messages Available")) RenvraEggPregnancy.renvraEggsMessageHandler(pSpace, arg);
		else if (pc.hasStatusEffect("Nyrea Eggs Messages Available")) NyreaHuntressPregnancy.nyreaEggsMessageHandler(pSpace, arg);
		else if (pc.hasStatusEffect("Royal Eggs Messages Available")) RoyalEggPregnancy.royalEggsMessageHandler(pSpace, arg);
		
	}
	
	// I named this badly, but this is the secondary pregnancy variant that Renvra has. It's much more complicated, so
	// all the checking is done at the target callsite.
	renvraMessageHandler();
	
	// Extra special handler for Queen of the Deeps pregnancy
	if (flags["Queen Message Supression"] == undefined)
	{
		QueenOfTheDeepPregnancy.queenPregnancyMessages(arg);
	}
	else
	{
		flags["Queen Message Supression"] = undefined;
	}

	//========== Stuff that gets checked once every time that time passes ===========//
	//Blue balls removed for not having cock and balls.
	if(!pc.hasCock() && pc.balls == 0)
	{
		if(pc.hasStatusEffect("Blue Balls")) pc.removeStatusEffect("Blue Balls");
	}
	//Remove Racial Perks No Longer Qualified For
	racialPerkUpdateCheck();

	//loop through every minute
	while(arg > 0) {
		//Check for shit that happens.
		//Actually move time!
		minutes++;

		//Status Effect Updates
		for (prop in chars) { if(chars[prop].statusSimulate) chars[prop].statusTick(); }
		pc.statusTick();
		//AlcoholTic
		if(pc.hasStatusEffect("Alcohol")) pc.alcoholTic();
		
		//Tarkus'splosions
		if(flags["TARKUS_BOMB_TIMER"] != undefined && flags["TARKUS_BOMB_TIMER"] > 0)
		{
			flags["TARKUS_BOMB_TIMER"]--;
			bombStatusUpdate();
			if(flags["TARKUS_BOMB_TIMER"] == 0)
			{
				if(eventQueue.indexOf(bombExplodes) == -1) eventQueue.push(bombExplodes);
			}
		}
		
		// Taivra's Pregnancy - Lasts 1 day until she naturally does away with them.
		if(flags["TAIVRA_FERTILE"] > 0 && (flags["TAIVRA_FERTILE"] + (24 * 60)) < GetGameTimestamp()) flags["TAIVRA_FERTILE"] = 0;
		
		if (flags["KQ2_NUKE_STARTED"] != undefined && flags["KQ2_NUKE_EXPLODED"] == undefined)
		{
			// Still there!
			if (flags["KQ2_QUEST_FINISHED"] == undefined)
			{
				if (flags["KQ2_NUKE_STARTED"] + KQ2_NUKE_DURATION < GetGameTimestamp())
				{
					if(eventQueue.indexOf(kq2NukeBadend) == -1) eventQueue.push(kq2NukeBadend);
				}
			}
			// Left
			else if (InShipInterior(pc))
			{
				flags["KQ2_NUKE_EXPLODED"] = 1;
				if(eventQueue.indexOf(kq2NukeExplodesLater) == -1) eventQueue.push(kq2NukeExplodesLater);
			}
		}
		
		// Followup for Dane to send coordinates to the player, should the need arise
		if (flags["KQ2_MYRELLION_STATE"] == 1)
		{
			if (flags["KQ2_DANE_COORDS_TIMER"] != undefined && flags["KQ2_DANE_COORDS_TIMER"] + 2880 < GetGameTimestamp())
			{
				if(eventQueue.indexOf(kq2DaneCoordEmail) == -1) eventQueue.push(kq2DaneCoordEmail);
			}
		}
		
		// Moving Shade to Uveto
		if(flags["KQ2_SHADE_AWAY_TIME"] != undefined)
		{
			if(GetGameTimestamp() > (flags["KQ2_SHADE_AWAY_TIME"] + (24 * 60)))
			{
				if(flags["SHADE_ON_UVETO"] == undefined || flags["SHADE_ON_UVETO"] < 1) flags["SHADE_ON_UVETO"] = 1;
				if(flags["SHADE_DISABLED"] == -1) flags["SHADE_DISABLED"] = undefined;
				flags["KQ2_SHADE_AWAY_TIME"] = undefined;
			}
		}
		
		// Gianna AWOL timer
		if(flags["GIANNA_AWAY_TIMER"] != undefined && flags["GIANNA_AWAY_TIMER"] > 0) giannaAWOL(-1);
		
		//Ovilium tracker removal
		if(pc.hasStatusEffect("Ovilium")) oviliumEffectCheck();
		//Clippex procs!
		if(pc.hasStatusEffect("Clippex Gel"))
		{
			var clippexTF:Clippex = new Clippex();
			clippexTF.itemClippexLustIncrease();
		}
		//Semen's Friend procs!
		if(pc.hasStatusEffect("Semen's Candy"))
		{
			var semensTF:SemensFriend = new SemensFriend();
			semensTF.itemSemensFriendLibidoIncrease();
		}
		//Cerespirin procs!
		if(pc.hasStatusEffect("Cerespirin"))
		{
			var plantTF:Cerespirin = new Cerespirin();
			plantTF.itemPlantTF();
		}
		//Treatment display shit
		if(pc.hasStatusEffect("Treatment Elasticity Report Q'ed"))
		{
			//Buttes
			if(pc.statusEffectv1("Treatment Elasticity Report Q'ed") == 1) treatedVagNote(true);
			//Cooters
			else treatedVagNote(false);
		}
		// Wild varmint run away!
		varmintDisappearChance();
		//Kiro stuff
		if(flags["KIRO_BAR_MET"] != undefined)
		{
			if (minutes >= 60) 
			{
				kiro.ballSizeRaw++;
				//Ball despunkification!
				if(kiro.ballDiameter() > 20)
				{
					if(rand(200) < kiro.ballDiameter()) kiro.orgasm();
				}
			}
			//Kiro's disabled timer!
			if(flags["KIRO_DISABLED_MINUTES"] != undefined)
			{
				flags["KIRO_DISABLED_MINUTES"]--;
				if(flags["KIRO_DISABLED_MINUTES"] <= 0) flags["KIRO_DISABLED_MINUTES"] = undefined;
			}
		}
		//Saendra's X-Pack Timer
		if(flags["SAENDRA_XPACK1_STATUS"] == 1 || flags["SAENDRA_XPACK1_STATUS"] == 5)
		{
			updateSaendraXPackTimer();
		}
		//Tick hours!
		if (minutes >= 60) {
			
			// Lust increase per hour
			mimbraneSweatHandler();
			
			minutes = 0;
			hours++;

			//Hours checks here!
			letsFapUpdateCheck();
			if(flags["SHEKKA_TALK_COOLDOWN"] != undefined)
			{
				if(flags["SHEKKA_TALK_COOLDOWN"] > 0) flags["SHEKKA_TALK_COOLDOWN"]--;
				if(flags["SHEKKA_TALK_COOLDOWN"] < 0) flags["SHEKKA_TALK_COOLDOWN"] = 0;
			}
			if(flags["FLAHNE_PISSED"] > 0) {
				flags["FLAHNE_PISSED"]--;
				if(flags["FLAHNE_PISSED"] < 0) flags["FLAHNE_PISSED"] = 0;
			}
			if(flags["ANNO_ASLEEP"] != undefined)
			{
				flags["ANNO_ASLEEP"]--;
				if(flags["ANNO_ASLEEP"] <= 0) flags["ANNO_ASLEEP"] = undefined;
			}
			if(chars["ALISS"].lust() < 70)
			{
				chars["ALISS"].lust(5);
			}
			if(chars["SHEKKA"].lust() < 50) chars["SHEKKA"].lust(15);

			if(pc.hasPerk("Dumb4Cum")) dumb4CumUpdate();
			//Gobbles Cooldown
			if(flags["GOBBLES_SEXYTIMES_STARTED"] == 1 && flags["GOBBLES_COOLDOWN"] != 24)
			{
				if(flags["GOBBLES_COOLDOWN"] == undefined) flags["GOBBLES_COOLDOWN"] = 0;
				flags["GOBBLES_COOLDOWN"]++;
				if(flags["GOBBLES_COOLDOWN"] > 24) flags["GOBBLES_COOLDOWN"] = 24;
			}
			if(flags["GIANNA_FUCK_TIMER"] != undefined) flags["GIANNA_FUCK_TIMER"]++;
			if(flags["IRELLIA_QUEST_STATUS"] == 3 && hours == 24 && currentLocation != "725") missedRebelExplosion();
			if(flags["IRELLIA_QUEST_STATUS"] == 4 && hours == 24) 
			{
				eventBuffer += "\n\n" + logTimeStamp("good") + " You receive a missive from your codex informing you that Queen Irellia would like to speak to you. Sounds like someone's about to get paid!";
				flags["IRELLIA_QUEST_STATUS"] = 5;
			}
			//Mushroom park meeting.
			if(flags["IRELLIA_QUEST_STATUS"] == 2 && hours == 18 && currentLocation == "708")
			{
				if(eventQueue.indexOf(unificationRallyEvent) == -1) eventQueue.push(unificationRallyEvent);
			}
			//Bomb explosion bad-end meeting
			if(flags["IRELLIA_QUEST_STATUS"] == 3 && hours >= 24 && currentLocation == "725")
			{
				if(eventQueue.indexOf(beADumbShitFallGuyForTheRebels) == -1) eventQueue.push(beADumbShitFallGuyForTheRebels);
			}
			//Irellia's sex cooldown
			if(flags["IRELLIA_SEX_COOLDOWN"] != undefined)
			{
				if(flags["IRELLIA_SEX_COOLDOWN"] <= 0) flags["IRELLIA_SEX_COOLDOWN"] = undefined;
				else flags["IRELLIA_SEX_COOLDOWN"]--;
			}
			//Lactation effect updates
			if(!pc.hasStatusEffect("Milk Paused")) lactationUpdateHourTick();
			//Horse pill procs!
			if(pc.hasStatusEffect("Horse Pill"))
			{
				var pill:HorsePill = new HorsePill();
				pill.pillTF();
			}
			//Goblinola procs!
			if(pc.hasStatusEffect("Goblinola Bar"))
			{
				var gobbyTF:Goblinola = new Goblinola();
				gobbyTF.itemGoblinTF();
			}
			//Treatmentr procs
			if(pc.hasStatusEffect("The Treatment"))
			{
				treatmentHourProcs();
			}
			//Omnisuit!
			if(pc.armor is Omnisuit) omnisuitChangeUpdate();
			//Egg trainer stuff
			carryTrainingBonusBlurbCheck();
			//Nessa cumflationshit
			nessaBellyTic();
			//Cunt stretching stuff
			if(pc.hasVagina()) {
				for(x = 0; x < pc.totalVaginas(); x++) {
					//Count da stretch cooldown or reset if at minimum.
					if(pc.vaginas[x].loosenessRaw > pc.vaginas[x].minLooseness) pc.vaginas[x].shrinkCounter++;
					else pc.vaginas[x].shrinkCounter = 0;
					//Reset for this cunt.
					tightnessChanged = false;
					if(pc.vaginas[x].loosenessRaw >= 5 && pc.vaginas[x].shrinkCounter >= 60) tightnessChanged = true;
					else if(pc.vaginas[x].loosenessRaw >= 4 && pc.vaginas[x].shrinkCounter >= 96) tightnessChanged = true;
					else if(pc.vaginas[x].loosenessRaw >= 3 && pc.vaginas[x].shrinkCounter >= 132) tightnessChanged = true;
					else if(pc.vaginas[x].loosenessRaw >= 2 && pc.vaginas[x].shrinkCounter >= 168) tightnessChanged = true;
					else if(pc.vaginas[x].loosenessRaw >= pc.vaginas[x].minLooseness && pc.vaginas[x].shrinkCounter >= 204) tightnessChanged = true;
					if(tightnessChanged) {
						pc.vaginas[x].loosenessRaw--;
						if (pc.vaginas[x].loosenessRaw < pc.vaginas[x].minLooseness)
							pc.vaginas[x].loosenessRaw = pc.vaginas[x].minLooseness;
						msg += "\n\n" + logTimeStamp() + " <b>Your";
						if(pc.totalVaginas() > 1) msg += " " + num2Text2(x+1);
						msg += " " + pc.vaginaDescript(x) + " has recovered from its ordeals, tightening up a bit.</b>";
						eventBuffer += msg;
					}
				}
			}
			//Butt stretching stuff
			//Count da stretch cooldown or reset if at minimum.
			if(pc.ass.loosenessRaw > pc.ass.minLooseness) pc.ass.shrinkCounter++;
			else pc.ass.shrinkCounter = 0;
			//Reset for this cunt.
			tightnessChanged = false;
			if(pc.ass.loosenessRaw >= 5 && pc.ass.shrinkCounter >= 12) tightnessChanged = true;
			else if(pc.ass.loosenessRaw >= 4 && pc.ass.shrinkCounter >= 24) tightnessChanged = true;
			else if(pc.ass.loosenessRaw >= 3 && pc.ass.shrinkCounter >= 48) tightnessChanged = true;
			else if(pc.ass.loosenessRaw >= 2 && pc.ass.shrinkCounter >= 72) tightnessChanged = true;
			else if(pc.ass.loosenessRaw >= pc.ass.minLooseness && pc.ass.shrinkCounter >= 96) tightnessChanged = true;
			if(tightnessChanged) {
				pc.ass.loosenessRaw--;
				if (pc.ass.loosenessRaw < pc.ass.minLooseness)
					pc.ass.loosenessRaw = pc.ass.minLooseness;
				if(pc.ass.loosenessRaw <= 4) eventBuffer += "\n\n" + logTimeStamp() + " <b>Your " + pc.assholeDescript() + " has recovered from its ordeals and is now a bit tighter.</b>";
				else eventBuffer += "\n\n" + logTimeStamp() + " <b>Your " + pc.assholeDescript() + " recovers from the brutal stretching it has received and tightens up.</b>";
			}
			//Cunt snake pregnancy stuff
			if (flags["CUNT_TAIL_PREGNANT_TIMER"] > 0) {
				if (!pc.hasCuntSnake()) {
					flags["CUNT_TAIL_PREGNANT_TIMER"] = undefined;
					flags["DAYS_SINCE_FED_CUNT_TAIL"] = undefined;
				}
				else {
					flags["CUNT_TAIL_PREGNANT_TIMER"]--;
					if(flags["CUNT_TAIL_PREGNANT_TIMER"] == 1) {
						flags["CUNT_TAIL_PREGNANT_TIMER"] = 0;
						if(eventQueue.indexOf(giveBirthThroughCuntTail) == -1) eventQueue.push(giveBirthThroughCuntTail);
					}
				}
			}
			//Shade cunt snakustuff
			if(flags["SHADE_INSEMINATION_COUNTER"] != undefined)
			{
				flags["SHADE_INSEMINATION_COUNTER"]++;
				//Birth that shit on her own time if she holds it too long
				if(flags["SHADE_INSEMINATION_COUNTER"] > 167) flags["SHADE_INSEMINATION_COUNTER"] = undefined;
			}
			//Goo PC updates and fixers:
			if(pc.hasStatusEffect("Goo Crotch")) gooCrotchUpdate();

			if(flags["BADGER_QUEST"] == -1)
			{
				if(flags["BADGER_QUEST_TIMER"] == undefined) flags["BADGER_QUEST_TIMER"] = GetGameTimestamp();
				if(GetGameTimestamp() >= flags["BADGER_QUEST_TIMER"] + 1440 && flags["BADGER_QUEST_TIMER"] != -1)
				{
					pennyBadgerQuestAlert();
					flags["BADGER_QUEST_TIMER"] = -1;
				}
			}
			// Hourly femininity check
			//eventBuffer += pc.fixFemininity();
			
			//Days ticks here!
			if(hours >= 24) {
				hours = 0;
				days++;
				
				//Unlock dat shiiit
				if(flags["HOLIDAY_OWEEN_ACTIVATED"] == undefined && (isHalloweenish() || rand(100) == 0))
				{
					if(eventQueue.indexOf(hollidayOweenAlert) == -1) eventQueue.push(hollidayOweenAlert);
				}
				if(pc.hasPerk("Honeypot") && days % 3 == 0) honeyPotBump();
				//Exhibitionism reduction!
				if
				(	!(pc.armor is EmptySlot)
				&&	!(pc.lowerUndergarment is EmptySlot || pc.lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) || pc.lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS))
				&&	!(pc.upperUndergarment is EmptySlot || pc.upperUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) || pc.upperUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST))
				)
				{
					if(pc.isChestExposed() && pc.isCrotchExposed() && pc.isAssExposed())
						{ /* No reduction for a full set of exposed clothing! */ }
					else pc.exhibitionism(-0.5);
				}
				// New Texas cockmilker repair cooldown.
				if (flags["MILK_BARN_COCKMILKER_BROKEN"] == undefined && flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"] != undefined)
				{
					if (flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"] > 0) flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"]--;
					else flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"] = 0;
				}
				//Reset Orryx shipments!
				if(flags["ORRYX_SHIPPED_TODAY"] != undefined) flags["ORRYX_SHIPPED_TODAY"] = undefined;
				if(days >= 2 && (flags["NEW_TEXAS_COORDINATES_GAINED"] == undefined || !MailManager.isEntryUnlocked("newtexas"))) newTexasEmail();
				
				if(chars["ALISS"].lust() >= 70)
				{
					chars["ALISS"].orgasm();
				}
				//Cooldown timer
				if(pc.perkv2("Auto-Autofellatio") >= 1) 
				{
					pc.addPerkValue("Auto-Autofellatio",2,-1);
				}
				//Cunt snake tomfoolery
				if(pc.hasCuntTail()) {
					if(flags["DAYS_SINCE_FED_CUNT_TAIL"] == undefined) flags["DAYS_SINCE_FED_CUNT_TAIL"] = 1;
					else flags["DAYS_SINCE_FED_CUNT_TAIL"]++;
				}
				//Reset 'dem venus pitcher hoz
				if(currentLocation != "OVERGROWN ROCK 12" && flags["ROOM_80_VENUS_PITCHER_ASLEEP"] != undefined) flags["ROOM_80_VENUS_PITCHER_ASLEEP"] = undefined;
				if(currentLocation != "VINED JUNGLE 3" && flags["ROOM_65_VENUS_PITCHER_ASLEEP"] != undefined) flags["ROOM_65_VENUS_PITCHER_ASLEEP"] = undefined;
				if(currentLocation != "DEEP JUNGLE 2" && flags["ROOM_61_VENUS_PITCHER_ASLEEP"] != undefined) flags["ROOM_61_VENUS_PITCHER_ASLEEP"] = undefined;
				//Reset milk barn events
				if (flags["MILK_BARN_EVENT_TODAY"] != undefined) flags["MILK_BARN_EVENT_TODAY"] = undefined;
				if (flags["BRYNN_MET_TODAY"] != undefined) flags["BRYNN_MET_TODAY"] = undefined;
				//Raskvel pregger shit
				if(flags["RASKVEL_PREG_TIMER"] != undefined)
				{
					flags["RASKVEL_PREG_TIMER"]--;
					//She pops eggs without you seeing.
					if(flags["RASKVEL_PREG_TIMER"] < -5) 
					{
						flags["RASKVEL_PREG_TIMER"] = undefined;
						flags["RASKVEL_EGG_COUNT"] = undefined;
					}
				}
				//Myr preggo shit
				if(flags["BRIHA_INCUBATION_TIMER"] != undefined) flags["BRIHA_INCUBATION_TIMER"]++;
				if(flags["BRIHA_LATEST_SPAWN_AGE"] != undefined) flags["BRIHA_LATEST_SPAWN_AGE"]++;
				if(flags["BRIHA_SECOND_OLDEST_SPAWN_AGE"] != undefined) flags["BRIHA_SECOND_OLDEST_SPAWN_AGE"]++;
				if(flags["BRIHA_OLDEST_SPAWN_AGE"] != undefined) flags["BRIHA_OLDEST_SPAWN_AGE"]++;
				
				// Thollum mushroom grow
				thollumYardMushroomGrow();
				
				// Tick up all of the attached mimbranes days since last fed
				mimbranesIncreaseDaysSinceFed();
				
				// Lane monies
				laneHandleCredits();
				//Venus pitcher
				venusSubmission( -1);
				
				tryProcSaendraXPackEmail();
				
				// Manes grow out!
				if(pc.hasPerk("Mane")) maneHairGrow();
				// Bodonkadonk-donks donkin'!
				if(pc.hasPerk("Buttslut")) buttslutBootyGrow();
				// Fecund Figure shape gain (Gains only while pregnant)
				if(pc.hasPerk("Fecund Figure"))
				{
					var numPreg:int = pc.totalPregnancies();
					// Wombs only--exclude anal pregnancy!
					if(pc.isPregnant(3)) numPreg--;
					// Longevity of growth based on number of current pregnant wombs.
					if(numPreg > 0) pc.addPerkValue("Fecund Figure", 4, numPreg);
					if(pc.perkv4("Fecund Figure") > 0)
					{
						// 20 days for 1 hips/butt size gain
						pc.addPerkValue("Fecund Figure", 1, 0.05); // Hips
						pc.addPerkValue("Fecund Figure", 2, 0.05); // Butt
						//pc.addPerkValue("Fecund Figure", 3, 0.0125); // Belly
						pc.addPerkValue("Fecund Figure", 4, -1); // Gains
					}
					if(pc.perkv4("Fecund Figure") < 0) pc.setPerkValue("Fecund Figure", 4, 0);
				}
				// Daily nyrean egg fills
				if(pc.hasStatusEffect("Nyrea Eggs"))
				{
					if(pc.fertility() > 0)
					{
						pc.addStatusValue("Nyrea Eggs", 1, Math.round(10 * pc.statusEffectv2("Nyrea Eggs") * pc.fertility()));
						if(pc.hasPerk("Fertility")) pc.addStatusValue("Nyrea Eggs", 1, 10 + rand(11));
						if(pc.statusEffectv1("Nyrea Eggs") > 1000 && rand(2) == 0) eventBuffer += "\n\n" + logTimeStamp("passive") + " You feel completely bloated with your production of nyrean eggs... Perhaps you should make some time to expel them?";
					}
				}
				//Reset Emmy Special Intro lockout:
				flags["EMMY_SPECIAL"] = undefined;
				//DAILY MYR VENOM CHECKS
				//Addicts
				if(flags["VENOM_ADDICTION"] != undefined)
				{
					//Not yet uber-addict:
					if(!pc.hasPerk("Venom Slut"))
					{
						if(pc.hasStatusEffect("Myr Venom Withdrawal")) myrAddiction(-2);
					}
				}
				//Non addicts not under the effects of venom lose progress to addiction
				else if(flags["VENOM_ADDICTION"] == undefined && !pc.hasStatusEffect("Red Myr Venom"))
				{
					venomProgress(-2);
				}
			}
		}
		arg--;
	}
	//Check to see if something changed in body part notices
	milkMultiplierGainNotificationCheck();
	nutSwellUpdates();
	immobilizedUpdate();

	//Queue up dumbfuck procs
	if(pc.hasStatusEffect("Dumbfuck"))
	{
		//Got some cums to pile oN?
		if(pc.hasStatusEffect("Dumbfuck Orgasm Procced"))
		{
			//No sneezes set up yet. Start dis shit.
			if(!pc.hasStatusEffect("Dumbfuck Orgasm Queued"))
			{
				pc.createStatusEffect("Dumbfuck Orgasm Queued", pc.statusEffectv1("Dumbfuck Orgasm Procced"), 0, 0, 0, true, "", "", false, 0);
			}
			//Already got some. PILE ON!
			else pc.addStatusValue("Dumbfuck Orgasm Queued",1,pc.statusEffectv1("Dumbfuck Orgasm Procced"));
			//Clear out the holding status now that we're cued up for sneezin'
			pc.removeStatusEffect("Dumbfuck Orgasm Procced");
		}
		//Add to event queue so long as it isn't on there already
		if(pc.hasStatusEffect("Dumbfuck Orgasm Queued"))
		{
			if(eventQueue.indexOf(procDumbfuckStuff) == -1) eventQueue.push(procDumbfuckStuff);
		}
	}
	
	// Don't send mails to the player whilst aboard the kashima
	if (flags["KASHIMA_STATE"] != 1)
	{
		//NEVRIE MAIL!
		if (!MailManager.isEntryUnlocked("myrpills") && flags["MCALLISTER_MEETING_TIMESTAMP"] <= (GetGameTimestamp() - (24 * 60))) nevriMailGet();
		if (!MailManager.isEntryUnlocked("orangepills") && flags["MCALLISTER_MYR_HYBRIDITY"] == 2 && GetGameTimestamp() >= (flags["MCALLISTER_MYR_HYBRIDITY_START"] + (7 * 24 * 60))) nevriOrangeMailGet();
		if (!MailManager.isEntryUnlocked("bjreminder") && flags["NEVRIE_FIRST_DISCOUNT_DATE"] != undefined && days >= flags["NEVRIE_FIRST_DISCOUNT_DATE"] + 20) nevriBJMailGet();

		//Emmy Mail
		if (!MailManager.isEntryUnlocked("emmy_apology") && flags["EMMY_EMAIL_TIMER"] <= (GetGameTimestamp() - (24 * 60))) emmyMailGet();
		//Emmy mail stage 2 START
		if (!MailManager.isEntryUnlocked("emmy_gift_starter") && flags["EMMY_ORAL_TIMER"] <= (GetGameTimestamp() - (72 * 60))) emmyMailGet2();
		//Emmy mail set up for sextoy go
		if (!MailManager.isEntryUnlocked("emmy_implant_explain_email") && flags["EMMY_PRESEX_FUN_TIMER"] <= (GetGameTimestamp() - (100 * 60))) emmyMailGet3();
		if (!MailManager.isEntryUnlocked("emmy_harness_here") && flags["EMMY_TOY_TIMER"] <= GetGameTimestamp()) emmyMailGet4();

		//Saendra Mail
		if (!MailManager.isEntryUnlocked("saendrathanks") && flags["FALL OF THE PHOENIX STATUS"] >= 1 && flags["SAENDRA_DISABLED"] != 1 && rooms[currentLocation].planet != "SHIP: PHOENIX" && !InShipInterior(pc)) saendraPhoenixMailGet();
		//Anno Mail
		if (!MailManager.isEntryUnlocked("annoweirdshit") && flags["MET_ANNO"] != undefined && flags["ANNO_MISSION_OFFER"] != 2 && flags["FOUGHT_TAM"] == undefined && flags["RUST_STEP"] != undefined && rand(20) == 0) goMailGet("annoweirdshit");
		//KIRO FUCKMEET
		if (!MailManager.isEntryUnlocked("kirofucknet") && flags["RESCUE KIRO FROM BLUEBALLS"] == 1 && kiroTrust() >= 50 && flags["MET_FLAHNE"] != undefined) { goMailGet("kirofucknet"); kiroFuckNetBonus(); }
		trySendStephMail();
		
		//Other Email Checks!
		if (rand(100) == 0) emailRoulette();
	}
	flags["HYPNO_EFFECT_OUTPUT_DONE"] = undefined;
	variableRoomUpdateCheck();
	updatePCStats();
}

public function racialPerkUpdateCheck():void
{
	var msg:String = "";
	
	if(pc.hasPerk("'Nuki Nuts"))
	{
		if(pc.nukiScore() < 3 && pc.perkv2("'Nuki Nuts") != 1)
		{
			if(pc.balls >= 1)
			{
				//Nuts inflated:
				if(pc.perkv1("'Nuki Nuts") > 0)
				{
					msg += "\n\n" + logTimeStamp("passive") + ParseText(" The extra size in your [pc.balls] bleeds off, making it easier to walk. You have a hunch that without all your");
					if(pc.originalRace.indexOf("kui-tan") != -1) msg += " natural kui-tan genes";
					else msg += " kui-tan body-mods";
					msg += ParseText(", you won't be swelling up with excess [pc.cumNoun] any more.");
				}
				//Nuts not inflated:
				else
				{
					msg += "\n\n" + logTimeStamp("passive") + ParseText(" A tingle spreads through your [pc.balls]. Once it fades, you realize that your [pc.sack] is noticeably less elastic. Perhaps you've replaced too much kui-tan DNA to reap the full benefits.");
				}
				msg += "\n\n(<b>Perk Lost: 'Nuki Nuts</b>)";
				pc.ballSizeMod -= pc.perkv1("'Nuki Nuts");
				pc.removePerk("'Nuki Nuts");
				nutStatusCleanup();
			}
			else
			{
				msg += "\n\n" + logTimeStamp("passive") + " (<b>Perk Lost: 'Nuki Nuts</b> - You no longer meet the requirements. You've lost too many kui-tan transformations.)";
				pc.removePerk("'Nuki Nuts");
			}
		}
		else if(pc.balls <= 0 && pc.perkv2("'Nuki Nuts") == 1)
		{
			msg += "\n\n" + logTimeStamp("passive") + " A strange sensation hits your nethers that forces you to wobble a little... Checking your status on your codex, it seems that removing your ballsack has also made the signature testicle-expanding tanuki mod vanish as well!";
			
			msg += "\n\n(<b>Perk Lost: 'Nuki Nuts</b> - You have no nuts to expand!)";
			pc.removePerk("'Nuki Nuts");
		}
	}
	if(pc.hasPerk("Fecund Figure"))
	{
		if(!pc.hasVagina())
		{
			msg += "\n\n" + logTimeStamp("passive") + " No longer possessing a vagina, your body tingles";
			if((pc.perkv1("Fecund Figure") + pc.perkv2("Fecund Figure") + pc.perkv3("Fecund Figure")) > 0) msg += ", rapidly changing as you lose your fertility goddess-like build";
			msg += ".";
			msg += "\n\n(<b>Perk Lost: Fecund Figure</b>)";
			pc.removePerk("Fecund Figure");
		}
	}
	if(pc.statusEffectv4("Vanae Markings") > 0)
	{
		if(pc.balls <= 0)
		{
			msg += "\n\n" + logTimeStamp("passive") + " A tingling sensations hits your crotch as you feel something fading away... Your codex beeps, informing you that the last remnants of your " + pc.skinAccent + " testicular tattoos have left your body, leaving the area bare.";
			pc.setStatusValue("Vanae Markings", 4, 0);
		}
	}
	if(pc.hasStatusEffect("Nyrea Eggs"))
	{
		if(pc.nyreaScore() < 3)
		{
			msg += "\n\n" + logTimeStamp("passive") + " You are interrupted by a shifting in your insides as a bubbling sensation fills your loins, and then... nothing.";
			if(pc.statusEffectv1("Nyrea Eggs") > 0)
			{
				msg += " Strangely, you feel";
				if(pc.statusEffectv1("Nyrea Eggs") <= 5) msg += " as if something is missing.";
				else if(pc.statusEffectv1("Nyrea Eggs") <= 10) msg += " a bit lighter now.";
				else if(pc.statusEffectv1("Nyrea Eggs") <= 50) msg += " like you have lost some pounds.";
				else if(pc.statusEffectv1("Nyrea Eggs") <= 100) msg += " much lighter now.";
				else msg += " like a huge weight has been lifted from you.";
			}
			msg += " Double-checking your codex, you find that";
			if(pc.statusEffectv1("Nyrea Eggs") > 0) msg += ParseText(" the nyrean eggs you’ve been carrying in your [pc.cumNoun] have dissolved and absobed into your body");
			else msg += ParseText(" your [pc.cumNoun] is no longer capable of producing eggs anymore");
			msg += ". It must be due to the lack of nyrean genes in your system....";
			pc.removeStatusEffect("Nyrea Eggs");
		}
	}
	if(pc.hasPerk("Slut Stamp"))
	{
		if(!pc.hasGenitals())
		{
			msg += "\n\n" + logTimeStamp("passive") + ParseText(" A sudden burning sensation hits your lower back, right above your [pc.ass]. You quickly");
			if(pc.isCrotchGarbed()) msg += ParseText(" struggle through your [pc.lowerGarments],");
			msg += " turn back and wince hard when the area is instantly struck by a refreshing coolness - as if being splashed on with cold water after being branded. When your hazed vision returns to normal, you see the slutty tattoo that resides there gradually dissolve and vanish before your eyes. It looks like your lack of genitalia makes it easier for you to cope with your libido now.";
			
			msg += "\n\n(<b>Perk Lost: Slut Stamp</b>)";
			pc.removePerk("Slut Stamp");
		}
	}
	if (pc.hasPerk("Androgyny") && pc.perkv1("Androgyny") > 0 && !pc.hasFaceFlag(GLOBAL.FLAG_MUZZLED))
	{ // racialPerkUpdateCheck: removal of Androgyny perk with the loss of muzzle.
		msg += "\n\n" + logTimeStamp("passive") + " With your face becoming more human, your appearance is now no longer androgynous.";
		msg += "\n\n(<b>Perk Lost: Androgyny</b> - You’ve lost your muzzle.)";
		pc.removePerk("Androgyny");
	}
	if (pc.hasPerk("Icy Veins") && pc.perkv1("Icy Veins") > 0 && (!pc.hasSkinFlag(GLOBAL.FLAG_FLUFFY) || pc.skinType != GLOBAL.SKIN_TYPE_FUR))
	{ // racialPerkUpdateCheck: removal of Icy Veins perk with he loss of fluffy fur (fork on still having fur but not fluffy flag?).
		msg += "\n\n" + logTimeStamp("passive") + " Without all that thick, fluffy coat of fur you suddenly feel rather cold...";
		msg += "\n\n(<b>Perk Lost: Icy Veins</b> - You’ve lost your insulating coat of fur, and as a result you are now weaker against cold.)";
		pc.removePerk("Icy Veins");
	}
	if(flags["GALOMAX_DOSES"] != undefined)
	{
		if(pc.hasHair() && pc.hairType != GLOBAL.HAIR_TYPE_GOO && !pc.hasStatusEffect("Hair Regoo"))
		{
			msg += "\n\n" + logTimeStamp("passive") + ParseText(" There is a slight tingling sensation at the roots of your [pc.hair].... Hm, strange....");
			pc.createStatusEffect("Hair Regoo", 0, 0, 0, 0, true, "", "", false, 720);
		}
	}
	if(pc.hasPerk("Black Latex"))
	{
		if(pc.skinType != GLOBAL.SKIN_TYPE_LATEX && !pc.hasStatusEffect("Latex Regrow"))
		{
			msg += "\n\n" + logTimeStamp("passive") + " Somehow, losing your natural latex skin makes you feel naked and insecure... You hope this feeling doesn’t last for too long...";
			pc.createStatusEffect("Latex Regrow", 0, 0, 0, 0, true, "", "", false, 720);
		}
	}
	if(pc.armType == GLOBAL.TYPE_FLOWER && pc.hasVagina())
	{
		if(!pc.hasWombPregnancy() && !pc.hasStatusEffect("Arm Flower"))
		{
			// Choose Flower Color
			var flowerColor:String = RandomInCollection(["red", "yellow", "blue", "purple", "pink", "white"]);
			
			msg += "\n\n" + logTimeStamp("passive") + " A summery feeling spreads down your arm ivy, like tiny veins of lustful energy. You intimately feel each of the small " + flowerColor + " flowers that pop and blossom into being on the delicate vines, like little skips of the heart.";
			msg += "\n\nWhy have you flowered like this? The rational part of your brain doesn’t have an answer... but the clear, green part of you knows. Your empty womb and [pc.eachVagina] know. You are ripe and ready for seeding, and your body is brightly signaling that fact to anyone that looks at you the best way it knows how.";
			
			pc.createStatusEffect("Arm Flower", 0, 0, 0, 0, true, "", flowerColor, false);
			// +Lust, slow Libido increase of 5
			pc.slowStatGain("libido", 5);
			pc.lust(50);
		}
		else if(pc.hasWombPregnancy() && pc.hasStatusEffect("Arm Flower"))
		{
			msg += "\n\n" + logTimeStamp("passive") + " Your " + pc.getStatusTooltip("Arm Flower") + " arm flowers droop and, over the course of the next hour, de-petal. Evidently they feel their work is done... which can only mean one thing. You stroke your [pc.belly].";
			
			//Libido decrease of 3
			pc.libido(-3);
			pc.removeStatusEffect("Arm Flower");
		}
	}
	else if(pc.armType != GLOBAL.TYPE_FLOWER)
	{
		pc.removeStatusEffect("Arm Flower");
	}
	if(pc.hasPerk("Resin"))
	{
		if(pc.skinType != GLOBAL.SKIN_TYPE_BARK)
		{
			msg += "\n\n" + logTimeStamp("passive") + " The surface of your body tingles and your nose briefly catches a whiff of a familiar amber aroma--which then completely dissipates into the air. Curious, you check your codex and, sure enough, due to the lack of your once bark skin, you’ve lost the ability to create a resin cast to protect yourself. Well, at least you feel a bit more nimble now...";
			
			msg += "\n\n(<b>Perk Lost: Resin</b>)";
			pc.removePerk("Resin");
		}
	}
	if(pc.hasPerk("Flower Power"))
	{
		var numFlowers:int = 0;
		if(pc.hasStatusEffect("Hair Flower"))
		{
			if(pc.statusEffectv1("Hair Flower") > 1) numFlowers += pc.statusEffectv1("Hair Flower");
			else numFlowers++;
		}
		if(pc.hasStatusEffect("Arm Flower")) numFlowers += 2;
		if(pc.hasVaginaType(GLOBAL.TYPE_FLOWER)) numFlowers += pc.totalVaginas(GLOBAL.TYPE_FLOWER);
		if(pc.tailGenitalArg == GLOBAL.TYPE_FLOWER && pc.hasTailCunt()) numFlowers += pc.tailCount;
		
		if(pc.perkv1("Flower Power") <= 0 && numFlowers > 0) msg += "\n\n" + logTimeStamp("passive") + " The flower" + (numFlowers == 1 ? "" : "s") + " located on your body blossom" + (numFlowers == 1 ? "s" : "") + ", ready to unleash " + (numFlowers == 1 ? "its" : "their") + " lust-inducing spores--this also adds to your sexual appetite... not that that’s a bad thing, after all!";
		else if(pc.perkv1("Flower Power") > 0 && numFlowers <= 0) msg += "\n\n" + logTimeStamp("passive") + " Without any flowers located on your body, you feel the need to produce spores fade. While this relaxes your body’s sexual urges, you know that producing any new flowers will have you ready for pollination again.";
		
		pc.setPerkValue("Flower Power", 1, numFlowers);
	}
	
	if(msg.length > 0) eventBuffer += msg;
}

public function badEnd(displayGG:String = "GAME OVER"):void 
{
	gameOverEvent = true;
	
	// Todo -- Hook alternate game ends in here, and also maybe look into some kind of categorisation system.
	
	if (displayGG != "") output("\n\n<b>" + displayGG + "</b>");
	output("\n\n(Access the main menu to start a new character or the data menu to load a saved game. The buttons are located in the lower left of the game screen.)");
	clearMenu();
}

// Checkin' da E-mails
public function goMailGet(mailKey:String = "", timeStamp:int = -1):void
{
	var mailFrom:String = "<i>Unknown Sender</i>";
	var mailFromAdress:String = "<i>Unknown Address</i>";
	if(timeStamp < 0) timeStamp = GetGameTimestamp();
	if(mailKey != "" && MailManager.hasEntry(mailKey))
	{
		var mailEmail:Object = MailManager.getEntry(mailKey);
		if(mailEmail.FromCache != null) mailFrom = mailEmail.FromCache;
		if(mailEmail.From != null) mailFrom = mailEmail.From();
		if(mailEmail.FromAddressCache != null) mailFromAdress = mailEmail.FromAddressCache;
		if(mailEmail.FromAddress != null) mailFromAdress = mailEmail.FromAddress();
		eventBuffer += "\n\n" + logTimeStamp() + " <b>New Email from " + mailFrom + " ("+ mailFromAdress +")!</b>";
		MailManager.unlockEntry(mailKey, timeStamp);
	}
}
// Random Emails!
public function emailRoulette():void
{
	var mailList:Array = [];
	var mailKey:String = "";
	var mailSubject:String = "\\\[No Subject\\\]";
	var mailContent:String = "<i>This message turns up empty...</i>";
	
	// Character/Event specific:
	if(!MailManager.isEntryUnlocked("burtsmeadhall") && pc.level >= 1)
		mailList.push("burtsmeadhall");
	if(!MailManager.isEntryUnlocked("kihaai") && flags["UNLOCKED_JUNKYARD_PLANET"] != undefined)
		mailList.push("kihaai");
	if(!MailManager.isEntryUnlocked("syrividja") && flags["SPAM_MSG_COV8"] != undefined && syriIsAFuckbuddy() && (flags["TIMES_WON_AGAINST_SYRI"] != undefined || flags["TIMES_LOST_TO_SYRI"] != undefined))
		mailList.push("syrividja");
	if(!MailManager.isEntryUnlocked("fuckinggoosloots") && celiseIsCrew() && pc.level >= 2)
		mailList.push("fuckinggoosloots");
	if(!MailManager.isEntryUnlocked("fuckinggooslootsII") && MailManager.isEntryUnlocked("fuckinggoosloots") && celiseIsCrew() && pc.level >= 5)
		mailList.push("fuckinggooslootsII");
	if(!MailManager.isEntryUnlocked("cuzfuckball") && flags["TIMES_MET_FEMZIL"] != undefined && flags["BEEN_ON_TARKUS"] != undefined && pc.level >= 2)
		mailList.push("cuzfuckball");
	
	// SPAM: (9999: If does not have spamblocker upgrade toggled on for CODEX.)
	if(SpamEmailKeys.length > 0 && flags["CODEX_SPAM_BLOCKER"] == undefined)
	{
		for(var i:int = 0; i < SpamEmailKeys.length; i++) 
		{
			if(	!InCollection(SpamEmailKeys[i], ["burtsmeadhall", "kihaai", "fuckinggoosloots", "fuckinggooslootsII", "kirofucknet"])
			&&	!MailManager.isEntryUnlocked(SpamEmailKeys[i])
			&&	rand(2) == 0
			)
				mailList.push(SpamEmailKeys[i]);
		}
	}
	
	if(mailList.length > 0) mailKey = mailList[rand(mailList.length)];
	
	if(mailKey != "" && MailManager.hasEntry(mailKey))
	{
		goMailGet(mailKey);
		
		// Any special actions/unlocks
		var mailEmail:Object = MailManager.getEntry(mailKey);
		if(mailEmail.SubjectCache != null) mailSubject = mailEmail.SubjectCache;
		if(mailEmail.Subject != null) mailSubject = mailEmail.Subject();
		if(mailEmail.ContentCache != null) mailContent = mailEmail.ContentCache;
		if(mailEmail.Content != null) mailContent = mailEmail.Content();
		
		// Regular:
		if(mailKey == "kirofucknet")
			kiroFuckNetBonus();
		// Spam:
		if(mailKey == "cov8" && flags["SPAM_MSG_COV8"] == undefined)
			flags["SPAM_MSG_COV8"] = 1;
		if(mailKey == "fatloss" && pc.isBimbo())
		{
			eventBuffer += " The subject line reads <i>“" + mailSubject + "”</i>. Ooo, secrets and stuff! You eagerly open the message and the codex lights up with the display:";
			eventBuffer += "\n\n<i>" + mailContent + "</i>";
			eventBuffer += "\n\nMmm, that sounds yummy!";
			pc.lust(20);
		}
		if(mailKey == "estrobloom" && !pc.hasKeyItem("Coupon - Estrobloom"))
		{
			eventBuffer += "\n\n<b>You have gained a coupon for Estrobloom!</b>";
			pc.createKeyItem("Coupon - Estrobloom", 0.9, 0, 0, 0, "Save 10% on your next purchase of Estrobloom!");
		}
		if(mailKey == "hugedicktoday" && pc.isBro() && pc.hasCock())
		{
			eventBuffer += " The subject line reads <i>“" + mailSubject + "”</i>. Hell yeah--who wouldn’t want a bigger dick? You quicky open the message to read its contents and the codex lights up with the display:";
			eventBuffer += "\n\n<i>" + mailContent + "</i>";
			eventBuffer += "\n\nYou’re not quite sure you understood all that, but your dick did.";
			pc.lust(20);
		}
	}
}
