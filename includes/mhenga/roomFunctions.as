﻿import classes.Characters.HuntressVanae;
/*
Fern, Lichens, and Ironwoods:
Man/FemZil, Cuntsnake

Dense Orange, Dark, Narrow Path
Naleen, Cuntsnake, Venus Pitchers

Deep Jungle Biome:
Naleen, Venus Pitchers, Elder Venus Pitchers, Zil
*/

public function flyToMhenga():void
{
	output("You fly to Mhen'ga");
	if(leaveShipOK()) output(" and step out of your ship.");
}

public function mhengaShipHangarFunc():Boolean
{
	if (annoIsCrew() && !syriIsCrew() && flags["ANNOxSYRI_EVENT"] == undefined)
	{
		annoFollowerFirstTimeOnMhenga();
		return true;
	}
	
	return false;
}
public function xenogenOutsideBlurb():Boolean
{
	variableRoomUpdateCheck();
	if(hours < 6 || hours >= 17)
	{
		output("\n\n<b>The doorway to the north is currently marked \"Closed.\"</b> A notice declares that it will be open again at 6:00 standard terran time.");		
	}
	else
	{
		output("\n\n<b>Xenogen Biotech is currently open!</b> Office hours are 6:00 to 17:00 standard terran time.");
	}
	return false;
}

public function synthSapNoticeUnlock():Boolean
{
	return (flags["MET_VANAE_MAIDEN"] != undefined && flags["MET_VANAE_HUNTRESS"] != undefined && CodexManager.entryViewed("Vanae: History"));
}

public function mhengaActiveBounty():Boolean
{
	var openQuests:int = 0;
	
	if(flags["SEEN_JULIANS_AD"] == undefined) openQuests++;
	if(synthSapNoticeUnlock() && flags["SEEN_SYNTHSAP_AD"] == undefined) openQuests++;
	
	if(openQuests > 0) return true;
	return false;
}
public function bountyBoardExtra():Boolean
{
	output("\n\nA large bulletin board has been erected against the wall of the building to the north.");
	if(mhengaActiveBounty()) output(" <b>There are new notices there.</b>");
	addButton(0,"Bulletins",checkOutBountyBoard);
	return false;
}
public function checkOutBountyBoard():void
{
	clearOutput();
	output("The bounty board is covered in simple leaflets, papers, and all manner of other detritus. Most appear to be for mundane tasks like trading construction equipment, advertising repair services, or business advertisements. Still, there's at least one that stands out.");
	
	// Zil Capture
	output("\n\n");
	if(flags["SEEN_JULIANS_AD"] == undefined) {
		output("<b>New:</b>");
		flags["SEEN_JULIANS_AD"] = 1;
	}
	else {
		if(flags["SECOND_CAPTURED_ZIL_REPORTED_ON"] == 1) output("<b>Completed:</b>");
		else if(flags["ACCEPTED_JULIANS_ZIL_CAPTURE_MISSION"] == 1) output("<b>Accepted:</b>");
		else output("<b>Seen Before:</b>");
	}
	output(" Dr. Julian of the Xenogen Biotech labs on the south end of town is looking for 'a strapping, adventurous type' to brave the jungles in search of something he can use for his research.");
	if(flags["SECOND_CAPTURED_ZIL_REPORTED_ON"] == 1) output(" You know from experience that it's quite lucrative.");
	else output(" It seems like it could be quite lucrative.");
	// SynthSap
	if(synthSapNoticeUnlock())
	{
		output("\n\n");
		if(flags["SEEN_SYNTHSAP_AD"] == undefined)
		{
			output("<b>New:</b>");
			flags["SEEN_SYNTHSAP_AD"] = 1;
		}
		else
		{
			if(flags["SYNTHSAP_UNLOCKED"] != undefined) output("<b>Completed:</b>");
			else output("<b>Seen Before:</b>");
		}
		output(" Xenogen Biotech Labs is seeking samples of ‘Sky Sap’ from the vanae natives. They are offering a monetary reward to anyone who can provide a steady supply of this substance.");
	}
	
	processTime(2);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}
	
public function barBackRoomBonus():Boolean
{
	if((hours >= 17 || hours < 6))
	{
		if(flags["KELLY_MET"] == 1) kellyAtTheBar();
		else output("\n\nA bunny-girl is back here with another patron, too busy to pay any attention to you.")
	}
	return false;
}

public function esbethFastTravelOfficeBonus():Boolean
{
	//Codex locked:
	if(!CodexManager.entryUnlocked("Leithans")) 
	{
		output(", and your codex beeps to inform you it's identified the leithan race");
		CodexManager.unlockEntry("Leithans");
	}
	output(".");

	addButton(0, (hasMetTanis() ? "Tanis" : "Scout"), mhengaScoutAuthority);
	return false ;
}

public function mhengaScoutAuthority():void
{
	clearOutput();
	showBust("TANIS");
	//if (hasMetTanis()) showName("\nTANIS");
	author("Savin");
	
	if (flags["TANIS_APPROACHED"] != undefined && flags["TANIS_BOW_INTRO"] == undefined && pc.hasBowWeaponAvailable())
	{
		tanisBowIntro();
		return;
	}
	
	if(flags["SALVAGED VANAE CAMP"] != 2) 
	{
		output("When you step up to " + (hasMetTanis() ? "Tanis" : "the leithan man") + ", he looks up from his work on a holoscreen and gives you an apologetic grin. <i>\"Sorry, friend, we're just getting set up here on Mhen'ga. Jungle's a little too dense for the scout drones to map and plan landing zones, so there's no transports going out yet.\"</i>");
		output("\n\n<i>\"Ah. Sorry to bother you,”</i> you say, turning to leave.");
		output("\n\n<i>“No worries. <b>If you come across any inactive ones out there, get them going, and we’ll be able to get you anywhere they cover.</b>”</i>");
		processTime(1);
		clearMenu();

		addButton(0, "Next", mainGameMenu);
		if (hasMetTanis() && pc.hasBowWeaponAvailable()) addButton(1, "Bow Training", tanisBowTraining);
		
		flags["TANIS_APPROACHED"] = 1;
	}
	//[Scout] (PC has fixed a comm array)
	else
	{
		output("When you step up to " + (hasMetTanis() ? "Tanis" : "the leithan man") + ", he looks up from his work on a holoscreen and gives you a big grin. <i>\"Hey there! Welcome to the Scout Authority base. We're running light transports out into the jungle now that comm arrays are coming online. So, where can we take you, " + pc.mf("sir","ma'am") + "?\"</i>");
		processTime(1);
		clearMenu();
		if(pc.credits >= 40) addButton(0,"XenogenCamp",mhengaTaxiToXenogen,undefined,"Xenogen Camp","This taxi will take you to the abandoned camp you found in the jungle. It costs 40 credits.");
		else addDisabledButton(0,"XenogenCamp","Xenogen Camp","You don't have enough credits to ride there.");

		if (hasMetTanis() && pc.hasBowWeaponAvailable()) addButton(1, "Bow Training", tanisBowTraining);

		addButton(14, "Back", mainGameMenu);
		
		flags["TANIS_APPROACHED"] = 1;
	}
}

public function mhengaTaxiToXenogen():void
{
	clearOutput();
	showBust("TANIS");
	pc.credits -= 40;
	output("<i>“Alright. I’ll upload the coordinates to one of the transports. Just swipe your credit stick here and head out back.”</i>");
	output("\n\nYou do so, transferring your payment to the Scout Authority and walking out into the back lot behind the structure. Several small hover-cars are arrayed there, all jungle-patterned and manned by simplistic drone pilots. One of them hails you with a wave of its mechanical arm. You slip into the car, and a moment later you’re on your way, zipping across the jungle of Mhen’ga.");
	output("\n\nNot long after, you arrive at the camp, and disembark into the jungle. The hover-car zips away a minute later, leaving you behind.");
	currentLocation = "ABANDONED CAMP";
	generateMapForLocation(currentLocation);
	processTime(15);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function jungleEncounterChances():Boolean {
	if(flags["ENCOUNTERS_DISABLED"] != undefined) return false;
	if(flags["JUNGLE_STEP"] == undefined) flags["JUNGLE_STEP"] = 1;
	else {
		if(pc.accessory is JungleLure) flags["JUNGLE_STEP"]++;
		flags["JUNGLE_STEP"]++;
	}
	
	// APPARANTLY I AM NOT ALLOWED DEBUG FUNCTIONS. FML
	
	var choices:Array = new Array();
	//If walked far enough w/o an encounter
	if((pc.accessory is JungleRepel && flags["JUNGLE_STEP"] >= 10 && rand(4) == 0) || (!(pc.accessory is JungleRepel) && flags["JUNGLE_STEP"] >= 5 && rand(4) == 0)) {
		//Reset step counter
		flags["JUNGLE_STEP"] = 0;
		
		//Build possible encounters
		choices.push(femzilEncounter);
		choices.push(femzilEncounter);
		choices.push(maleZilEncounter);
		choices.push(maleZilEncounter);
		choices.push(encounterCuntSnakeOnJungleLand);
		choices.push(encounterCuntSnakeOnJungleLand);
		choices.push(frogGirlsEncounter);
		if(dryadIsActive())
		{
			if(rand(3) == 0) choices.push(dryadMeeting);
			//Fragrant ladies or cum-drenched folks find her more often~
			if(dryadCanSmellPC())
			{
				choices.push(dryadMeeting);
				choices.push(dryadMeeting);
			}
		}
		//Run the event
		choices[rand(choices.length)]();
		return true;
	}
	if (tryEncounterMango()) return true;
	
	return false;
}

public function jungleMiddleEncounters():Boolean {
	if(flags["ENCOUNTERS_DISABLED"] != undefined) return false;
	if(flags["JUNGLE_STEP"] == undefined) flags["JUNGLE_STEP"] = 1;
	else {
		if(pc.accessory is JungleLure) flags["JUNGLE_STEP"]++;
		flags["JUNGLE_STEP"]++;
	}
	
	var choices:Array = new Array();
	//If walked far enough w/o an encounter
	if((pc.accessory is JungleRepel && flags["JUNGLE_STEP"] >= 10 && rand(3) == 0) || (!(pc.accessory is JungleRepel) && flags["JUNGLE_STEP"] >= 5 && rand(3) == 0)) {
		//Reset step counter
		flags["JUNGLE_STEP"] = 0;
		
		//Build possible encounters
		if((hours < 3 || hours > 20) && totalNaleenSexCount() >= 5)
		{
			choices[choices.length] = naleenNightCuddles;
			choices[choices.length] = naleenNightCuddles;
		}
		else {
			choices[choices.length] = encounterNaleen;
			choices[choices.length] = encounterNaleen;
		}
		choices[choices.length] = encounterCuntSnakeOnJungleLand;
		choices[choices.length] = encounterCuntSnakeOnJungleLand;
		choices[choices.length] = encounterRegularTentaclePitcherYouGay;
		choices[choices.length] = encounterRegularTentaclePitcherYouGay;
		choices[choices.length] = encounterRegularTentaclePitcherYouGay;
		if(flags["ZODEE_GALOQUEST"] == undefined) choices.push(zodeeGivesFirstGalomax);
		choices.push(frogGirlsEncounter);
		if(dryadIsActive())
		{
			if(rand(3) == 0) choices.push(dryadMeeting);
			//Fragrant ladies or cum-drenched folks find her more often~
			if(dryadCanSmellPC())
			{
				choices.push(dryadMeeting);
				choices.push(dryadMeeting);
			}
		}
		//Run the event
		choices[rand(choices.length)]();
		return true;
	}
	
	if (tryEncounterMango()) return true;
	
	return false;
}

public function jungleDeepEncounters():Boolean {
	if(flags["ENCOUNTERS_DISABLED"] != undefined) return false;
	if(flags["JUNGLE_STEP"] == undefined) flags["JUNGLE_STEP"] = 1;
	else {
		if(pc.accessory is JungleLure) flags["JUNGLE_STEP"]++;
		flags["JUNGLE_STEP"]++;
	}
	//Venus pitchers require you to have met a younger pitcher.
	if(flags["TIMES_MET_VENUS_PITCHER"] != undefined)
	{
		if(pc.hasCock() || pc.hasVagina() || pc.hasCuntTail())
		{
			//in this room and da chick awake.
			if(currentLocation == "OVERGROWN ROCK 12" && flags["ROOM_80_VENUS_PITCHER_ASLEEP"] == undefined) {
				elderVenusPitcherEncounter();
				flags["JUNGLE_STEP"] = 0;
				flags["ROOM_80_VENUS_PITCHER_ASLEEP"] = 1;
				flags["ROOM_80_PITCHER_MET"] = 1;
				if(!rooms[currentLocation].hasFlag(GLOBAL.PLANT_BULB)) rooms[currentLocation].addFlag(GLOBAL.PLANT_BULB);
				return true;
			}
			//in this room and da chick awake.
			if(currentLocation == "VINED JUNGLE 3" && flags["ROOM_65_VENUS_PITCHER_ASLEEP"] == undefined) {
				elderVenusPitcherEncounter();
				flags["JUNGLE_STEP"] = 0;
				flags["ROOM_65_VENUS_PITCHER_ASLEEP"] = 1;
				flags["ROOM_65_PITCHER_MET"] = 1;
				if(!rooms[currentLocation].hasFlag(GLOBAL.PLANT_BULB)) rooms[currentLocation].addFlag(GLOBAL.PLANT_BULB);
				return true;
			}
			//in this room and da chick awake.
			if(currentLocation == "DEEP JUNGLE 2" && flags["ROOM_61_VENUS_PITCHER_ASLEEP"] == undefined) {
				elderVenusPitcherEncounter();
				flags["JUNGLE_STEP"] = 0;
				flags["ROOM_61_VENUS_PITCHER_ASLEEP"] = 1;
				flags["ROOM_61_PITCHER_MET"] = 1;
				if(!rooms[currentLocation].hasFlag(GLOBAL.PLANT_BULB)) rooms[currentLocation].addFlag(GLOBAL.PLANT_BULB);
				return true;
			}
		}
	}
	if(rand(100) == 0 && !pc.hasItem(new StrangeEgg()))
	{
		findStrangeEgg();
		return true;
	}
	var choices:Array = new Array();
	//If walked far enough w/o an encounter
	if((pc.accessory is JungleRepel && flags["JUNGLE_STEP"] >= 10 && rand(2) == 0) || (!(pc.accessory is JungleRepel) && flags["JUNGLE_STEP"] >= 5 && rand(2) == 0)) {
		//Reset step counter
		flags["JUNGLE_STEP"] = 0;
		
		//Build possible encounters
		if((hours < 3 || hours > 20) && totalNaleenSexCount() >= 5)
		{
			choices[choices.length] = naleenNightCuddles;
			choices[choices.length] = naleenNightCuddles;
		}
		else {
			choices[choices.length] = encounterNaleen;
			choices[choices.length] = encounterNaleen;
			choices[choices.length] = encounterNaleen;
			choices[choices.length] = naleenMaleEncounter;
			choices[choices.length] = naleenMaleEncounter;
			choices[choices.length] = naleenMaleEncounter;
		}
		choices[choices.length] = encounterMimbrane;
		choices[choices.length] = encounterMimbrane;
		if(dryadIsActive())
		{
			if(rand(3) == 0) choices.push(dryadMeeting);
			//Fragrant ladies or cum-drenched folks find her more often~
			if(dryadCanSmellPC())
			{
				choices.push(dryadMeeting);
				choices.push(dryadMeeting);
			}
		}
		//choices[choices.length] = encounterRegularTentaclePitcherYouGay;
		if(flags["ZODEE_GALOQUEST"] == undefined) choices.push(zodeeGivesFirstGalomax);
		
		//Run the event
		choices[rand(choices.length)]();
		return true;
	}
	if(pc.level < 2) output("\n\n<b>You can't help but feel that this part of the jungle would chew you up and spit you out. Maybe you should come back after leveling up a little bit.</b>");
	
	if (tryEncounterMango()) return true;
	
	return false;
}

public function findOxoniumOnMhenga():Boolean {
	if(flags["TAGGED_MHENGA_OXONIUM_DEPOSIT"] == undefined) {
		output("\n\nThere is a vertical band of a different mineral running up through the rock wall, a streak of something pitch black that seems to draw in the light. You could probably scan it with your codex and radio it in to your Dad's company for a quick prospector's fee.");
	}
	else {
		output("\n\nThere's a deposit of Oxonium here, but you've already called in the claim to your Dad's company. They'll probably be out to mine it once the frontier settles down a little bit.");
	}
	//Overridden by Jungle deep encounters
	if(jungleDeepEncounters()) return true;
	//Option to loot it!
	else if(flags["TAGGED_MHENGA_OXONIUM_DEPOSIT"] == undefined) {
		addButton(0,"Scan Rock",claimMhengaOxonium);
	}
	return false;
}

public function claimMhengaOxonium():void {
	clearOutput();
	output("Utilizing your codex's sensors, you identify the material as Oxonium, a rare mineral used in holographic displays. The amount here is decent, easily worth at least 3,000 credits. You record your location and compose a short message, sending it off a few minutes later. Before you've had a chance to do anything else, the codex beeps.\n\n<b>Your bank account just got a 5,000 credit deposit.</b> Either you're not a great geologist, or Dad's company has orders to give you top dollar. Regardless, the profit is yours.");
	
	flags["TAGGED_MHENGA_OXONIUM_DEPOSIT"] = 1;
	if(flags["OXONIUM_FOUND"] == undefined) flags["OXONIUM_FOUND"] = 0;
	flags["OXONIUM_FOUND"]++;
	pc.credits += 5000;
	processTime(6);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function vanaeWarningBot():Boolean
{
	output("\n\n<b>A small, sleek drone bearing the U.G.C. Peacekeeper emblem is hovering here, puttering around in a small circle.</b> When you approach, the drone intones in a clearly mechanical voice: <i>“Peacekeeper Inoue has posted the following safety advisory: beyond this point, the southern area of jungle is classified as a level four threat and is to be avoided if at all possible.”</i>");
	addButton(0,"Drone",talkToWarningDrone);
	return false;
}

public function talkToWarningDrone():void
{
	clearOutput();
	author("Savin");
	showName("\nDRONE");
	showBust("DRONE");
	output("You step up to the drone and ask it for more information.");
	output("\n\n<i>“Peacekeeper Inoue has classified the local species ‘Vanae’ as a level four threat. This species is highly aggressive. Only well-equipped explorers with significant off-world experience should proceed beyond this point.”</i>");
	if(flags["SEXED_PENNY"] != undefined) output("\n\nAs you step back from the drone, it chirps and suddenly displays a holographic image of Penny. <i>“Hi, mate. I thought you might find this! Be safe out there, alright?”</i>\n\nYou smile and nod as the bonus message flickers off.");
	processTime(1);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function mhengaVanaeCombatZone():Boolean
{
	if (flags["ENCOUNTERS_DISABLED"] != undefined) return false;
	if (flags["JUNGLE_STEP"] == undefined) flags["JUNGLE_STEP"] = 1;
	else
	{
		if(pc.accessory is JungleLure) flags["JUNGLE_STEP"]++;
		flags["JUNGLE_STEP"]++;
	}
	
	var opts:Array = [];
	
	if ((pc.accessory is JungleRepel && flags["JUNGLE_STEP"] >= 10 && rand(2) == 0) || (!(pc.accessory is JungleRepel) && flags["JUNGLE_STEP"] >= 5 && rand(2) == 0)) 
	{
		//Reset step counter
		flags["JUNGLE_STEP"] = 0;
		
		//Build possible encounters	
		var MAIDEN:int = 0;
		var HUNTRESS:int = 1;
		var MIMBRANE:int = 3;
		
		var selected:int = RandomInCollection(MAIDEN, MAIDEN, HUNTRESS, HUNTRESS, HUNTRESS, HUNTRESS, HUNTRESS, MIMBRANE);
		
		if (selected == MAIDEN)
		{
			encounterVanae(false);
		}
		else if (selected == HUNTRESS)
		{
			encounterVanae(true);
		}
		else
		{
			encounterMimbrane();
		}
		return true;
	}
	
	return false;
}

public function mhengaThickMist2RoomFunc():Boolean
{
	clearOutput();
	
	output("The mist here is so thick you're having trouble seeing where you're going. If it wasn't for the blinking, multi-colored lichen lining the forest trees, you'd probably be lost. Moisture clings to your");
	if (!pc.isNude()) output (" [pc.armor]");
	else output(" [pc.skinFurScales]");
	output(" as you trudge forth, utterly surrounded by a blanket of white.");

	output("\n\nYou can feel something blocking your way east and it feels too tall to climb. Every other direction seems okay. Maybe. It's hard to tell.");
	
	return mhengaVanaeCombatZone();
}

public function mhengaUthraBirch():Boolean
{
	if (flags["UTHRA HARVEST DAY"] == undefined || flags["UTHRA HARVEST DAY"] + 2 <= days)
	{
		output("\n\nEven worse, an obsidian sap is seeping gruesomely from wound-like gaps in the tree surface. Not a single glimmer of light reflects off the eerily black substance, contrasting violently with your misty white surroundings.");
		
		addButton(0, "Harvest", mhengaHarvestUthra, undefined, "Harvest Tree", "Harvest sap from the Uthra Tree");
	}
	else
	{
		output("\n\nYou have harvested the obsidian colored sap from the ugly tree and no more flows from its surface. You'll have to give it time to produce some more.");
		
		addDisabledButton(0, "Harvest", "You have recently harvested sap from the Uthra Tree and must allow it to regenerate.");
	}
	
	output("\n\nThe roots of the deformed tree are large and pervasive, blocking passage in almost every direction. The only path left open to you is back down into the river lined gorge.");
	
	return false;
}

public function mhengaHarvestUthra():void
{
	clearOutput();
	flags["UTHRA HARVEST DAY"] = days;
	
	output("You gather what little of the sap leaking from the tree you can find into a small collection tube - a standard part of any rushers exploration kit - ensuring that you don't accidently get any on yourself in the process.");
	if (flags["CONSUMED_UTHRA_SAP"] == undefined) output(" No telling what this stuff could do to you without some kind of analysis.");
	else output(" Even safe in the knowledge that the substance isn't particularly dangerous, it'd be best not to accidently spread any around without intending to.");
	output("\n\n");
	
	quickLoot(new UthraSap());
	
	//clearMenu();
	//addButton(0, "Next", mainGameMenu);
}

public function mhengaVanaeFernDamage():Boolean
{
    if (rand(3) == 0 || pc.armor is EmptySlot)
    {
        var damage:int = rand(8);
        if (pc.armor is EmptySlot) damage = 8;
        else damage -= pc.armor.defense;
        if (damage < 0)
        {
        output("\n\nThe spiked ferns look pretty damn painful, but your thick armor is doing a fantastic job of keeping the jagged spikes from doing any damage.");
        }
        else if (damage < 2)
        {
            output("\n\nThe spiked ferns look pretty damn painful, but thankfully your armor is managing to deflect the worst of it and only allows the odd prick or slash to your [pc.legOrLegs] as you hike through the area. <b>(" + damage + ")</b>");
            pc.HP( -damage);
        }
        else if (damage < 4)
        {
            output("\n\nThe spiked ferns look pretty damn painful, your armor not exactly achieving much when it comes to providing protection to your lower extremeties. The sharp points of the ferns are doing a real number on your [pc.legOrLegs]. <b>(" + damage + ")</b>");
            pc.HP( -damage);
        }
        else if (damage < 8)
        {
            output("\n\nThe spiked ferns look pretty damn painful, and your armor is nigh-useless when it comes to providing any semblance of protection from the spiked menace infesting the undergrowth in these parts of the lowlands. <b>(" + damage + ")</b>");
            pc.HP( -damage);
        }
        else
        {
            output("\n\nYou're starting to wish you were wearing armor - hell, even some flimsy dress pants would go a long way to providing some measure of protection against the spiked menance infesting the undergrowth in these parts of the lowlands. With nothing to protect your [pc.legOrLegs] from repeated jabs and slashes, moving through the area is quickly taking a toll on your stamina, and your health. <b>(" + damage + ")</b>");
            pc.HP( -damage);
            pc.energy( -damage);
        }
    }
    return mhengaVanaeCombatZone();
}

public function mhengaVanaeAbandonedCamp():Boolean
{
	output("You walk into the remains of what was clearly a Xenogen research camp. The protective shield is down and the temporary habitation they were using has been wrecked. There are empty crates");
	if(flags["CLEARED_XENOGEN_CAMP_BODIES"] == undefined) output(" and bodies");
	output(" lying everywhere. Spears are jutting out of nearly everything.\n\nYou spot some empty cages that look as if they were designed for humanoid captives. Everything around here is utterly wrecked and you're not sure you'll find anything of value.");
	if(flags["SALVAGED VANAE CAMP"] != 2) addButton(0, "Salvage", mhengaSalvageFromCamp);
	else 
	{
		if(pc.credits >= 40) addButton(0,"Call Taxi",fastTravelToEsbeth,undefined,"Call Taxi","Call a taxi from the transit authority. It'll cost you 40 credits to ride back to Mhen'ga.");
		else addDisabledButton(0,"Call Taxi","Call Taxi","You can't afford the 40 credits for a taxi. Damn.");
	}
	addButton(4,"Sleep",sleepInRuinedCamp,undefined,"Sleep","The camp is a wreck, but if you cleaned it up, you might be able to bed down here.");
	return false;
}

public function fastTravelToEsbeth():void
{
	clearOutput();
	output("You squat down next to the bulky comm array and punch in the number of the local U.G.C. Scout base. A quick credit transfer later, and you've got a hover car racing toward you for pickup. A few minutes later it arrives, puttering down into the clearing in the middle of camp with doors open. The drone pilot waves you in, and soon whisks you away back to Esbeth.");
	pc.credits -= 40;
	currentLocation = "ESBETH TRAVEL AUTHORITY";
	generateMapForLocation(currentLocation);
	processTime(15);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function genericSleep(baseTime:int = 480):void
{
	var totalTime:int = baseTime + (rand(baseTime / 3) - (baseTime / 6));
	
	sleepHeal();
	processTime(totalTime);
	
	if ((pc.XPRaw >= pc.XPMax()) && pc.level < 8 && flags["LEVEL_UP_AVAILABLE"] == undefined)
	{
		(pc as PlayerCharacter).unspentStatPoints += 13;
		(pc as PlayerCharacter).unclaimedClassPerks += 1;
		(pc as PlayerCharacter).unclaimedGenericPerks += 1;
		
		pc.level++;
		pc.XPRaw = 0;
		pc.maxOutHP();
		
		// Enable the button
		userInterface.levelUpButton.Activate();
		
		eventBuffer += "\n\n" + logTimeStamp("good") + " A nights rest is just what you needed; you feel faster... stronger... harder....\n<b>Level Up is available!</b>";
	}
}

public function sleepInRuinedCamp():void
{
	clearOutput();
	if(flags["CLEARED_XENOGEN_CAMP_BODIES"] == undefined)
	{
		flags["CLEARED_XENOGEN_CAMP_BODIES"] = 1;
		output("The bodies lying around make the prospect of sleeping here... unpleasant, but then again, you're far enough from town that you'd rather sleep here than trudge all the way back. You spend several minutes dragging the mutilated bodies out of the camp and dump them into a ditch not far away. Best you can do under the circumstances.");
		output("\n\nYou clear out one of the tents and bunker down to sleep ");

		//Standard sleep messages, etc. 
	}
	//Repeat [Sleep]
	else
	{
		output("The camp is still clear enough, and the smell's not so bad anymore. You crawl into one of the tents and bunker down to sleep");
	}
	//Standard sleep messages, etc. 
	var minPass:int = 420 + rand(80) + 1
	output(" for about " + num2Text(Math.round(minPass/60)) + " hours.");
	sleepHeal();
	processTime(minPass);
	mimbraneSleepEvents();
	//Chance for a Vanae Attack! - can't be first time
	if (CodexManager.entryUnlocked("Vanae") && rand(4) == 0)
	{
		//PC doesn't have TamWolf, has encountered a vanae before. Vanae gets the first turn!
		if(!pc.hasTamWolf()) output("\n\nYou're awoken by a high, shrill warcry. Your eyes snap open, just as a throwing spear slams into the dirt beside your bedroll, tearing through the tent. You scramble to your [pc.feet], grabbing your equipment as your assailer leaps into view. <b>You've been ambushed by a vanae</b>!");
		//PC has Tam-wolf (broke or not)
		else
		{
			output("\n\nYou're awoken by a low, deep mechanical barking outside your tent, full of enough bass to make your [pc.ears] rattle. You grab your [pc.gear] and stumble out of the tent, wiping the sleep from your eyes. Tam-wolf is standing outside in a low, threatening posture, his steel ears low against his head. A vanae is standing just a short way away, held at bay by your robotic guard dog. Still, it doesn't look like she's backing off... you'll have to fight her.");
		}
		showName("FIGHT: VANAE\nHUNTRESS");
		showBust("VANAE_HUNTRESS");
		clearMenu();
		configHuntressFight();
		addButton(0, "Next", CombatManager.beginCombat);
		return;
	}
	if ((pc.XPRaw >= pc.XPMax()) && pc.level < 8 && flags["LEVEL_UP_AVAILABLE"] == undefined)
	{
		(pc as PlayerCharacter).unspentStatPoints += 13;
		(pc as PlayerCharacter).unclaimedClassPerks += 1;
		(pc as PlayerCharacter).unclaimedGenericPerks += 1;
		
		pc.level++;
		pc.XPRaw = 0;
		pc.maxOutHP();
		
		// Enable the button
		userInterface.levelUpButton.Activate();
		
		eventBuffer += "\n\n" + logTimeStamp("good") + " A nights rest is just what you needed; you feel faster... stronger... harder....\n<b>Level Up is available!</b>";
	}
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function configHuntressFight():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new HuntressVanae());
	CombatManager.victoryScene(vanaePCVictory);
	CombatManager.lossScene(vanaeHuntressPCDefeat);
	CombatManager.displayLocation("HUNTRESS");
}

public function mhengaSalvageFromCamp():void
{
	clearOutput();
	
	if (flags["SALVAGED VANAE CAMP"] == undefined || flags["SALVAGED VANAE CAMP"] == 0)
	{
		if (flags["SALVAGED VANAE CAMP"] == undefined) output("You find something of interest stashed in one of the many storage containers scattered around the camp. Gingerly lifting the lid of a heavily damaged container, you discover a set of some kind of augmented armor. "); // I have no idea what this item is supposed to look like.
		else output("You take the augmented armor you found from one of the storage containers at the camp.");
		
		output("\n\n");
		flags["SALVAGED VANAE CAMP"] = 1;
		var armor:AtmaArmor = new AtmaArmor();
		lootScreen = mhengaSalvageArmorCheck;
		itemCollect([armor]);
		return;
	}
	else
	{
		//Add to Salvage results, 2nd time
		//Remove "Salvage" option, replace with [Use Comms].
		flags["SALVAGED VANAE CAMP"] = 2;
		output("As you pick through the abandoned research camp, you spot something useful among the wreckage of what looks to be a burned-out hoverloader: a mid-range communications array, new in box. While not particularly valuable, and much too heavy to carry around with you, this array could easily cut through the jungle and send a signal back to Esbeth. You break it out of the box and boot it up. The array makes a happy chirping sound, announcing more loudly than you'd like that it is a top of the line Xenogen product brought to you courtesy of some dead, highly advanced race Xenogen looted whose name you're not sure you could replicate.\n\nWith the comms array set up, <b>you could probably call for retrieval from Esbeth now.</b>");
		processTime(3);
		clearMenu();
		addButton(0, "Next", mainGameMenu); 
	}
}
public function mhengaSalvageArmorCheck():void
{
	if(pc.armor is AtmaArmor || pc.hasItemByType(AtmaArmor))
	{
		mainGameMenu();
		return;
	}
	
	clearOutput();
	output("Unable to carry the suit with you, you put it back where you found it.");
	flags["SALVAGED VANAE CAMP"] = 0;
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function mhengaThickMistRoom1():Boolean
{
	output("The mist is incredibly thick here, obscuring almost everything around you. Every noise seems sharper and more imposing as you crunch blindly about, occasionally knocking into a tree or branch. Your");
	if (!pc.armor is EmptySlot) output(" [pc.armor] is");
	else 
	{
		output(" [pc.skinFurScales]");
		if(pc.hasScales() || pc.hasFeathers()) output(" are");
		else output(" is");
	}
	output(" damp from all the moisture in the air. Things are getting quite chilly.\n\nYou can hear a river to the west, which means you probably can't proceed that way. Everywhere else seems fine, you think...");
	
	return mhengaVanaeCombatZone();
}

// Can you handle the mango?
public function tryEncounterMango():Boolean
{
	var getChance:int = 100;
	
	if (flags["JUNGLE_STEP"] != 0 && rand(getChance) <= 1)
	{
		encounterMango();
		return true;
	}
	return false;
}
public function encounterMango(choice:String = "encounter"):void
{
	if(choice == "encounter")
	{
		clearOutput();
		showName("A FRUITY\nFIND!");
		
		output("On the foliage-covered floor,");
		if(flags["FOUND_MANGO"] == undefined) output(" a bright red-orange fruit catches your attention--it’s just sticking out there like a sore thumb. You pick it up and find that it’s actually a healthy-looking mango. It looks ripe enough to eat on the spot!");
		else if(flags["FOUND_MANGO"] == 1) output(" you find another red-orange mango that’s ripe for the taking. Lucky you!");
		else output(" you spot an unclaimed Mhen’gan mango looking quite ripe and delicious.");
		output(" Would you like to take it with you?");
		
		processTime(1);
		IncrementFlag("FOUND_MANGO");
		
		clearMenu();
		addButton(0, "Take It", encounterMango, "take it");
		addButton(1, "Leave It", encounterMango, "leave it");
	}
	else if(choice == "take it")
	{
		clearOutput();
		output("Licking your lips, you take a hold of the juicy fruit.");
		output("\n\n");
		
		quickLoot(new MhengaMango());
	}
	else if(choice == "leave it")
	{
		clearOutput();
		output("You decide to leave it where you found it, but just as soon as you finish the thought, a shadowy blur runs across the jungle floor with a quick <i>woosh!</i> You can barely make out the critter but it vanishes into the shrubbery as quickly as it came. Looking back, you find a small leaf fall on the spot where the fruit once was. You guess if you weren’t going to take it, something else would....");
		
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}
