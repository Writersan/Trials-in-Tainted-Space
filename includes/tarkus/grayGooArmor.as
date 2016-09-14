﻿import classes.Items.Armor.GooArmor;

/* Gray Goo Armor */

public function showGrayGooArmor(nude:Boolean = false, special:String = "none"):void
{
	showBust(novaBustDisplay(nude, special));
	if(flags["ANNO_NOVA_UPDATE"] >= 2) showName("\n" + goo.short.toUpperCase());
	else if(hasGooArmorOnSelf()) showName("GOO\nARMOR");
	else showName("\nGRAY GOO");
}
public function novaBustDisplay(nude:Boolean = false, special:String = "none"):String
{
	var bustName:String = "";
	
	if(chars["GOO"].hairStyle == "ponytail")
	{
		bustName = "GRAY_GOO_PRIME";
	}
	else if(chars["GOO"].hairStyle == "loose")
	{
		bustName = "GRAY_GOO";
	}
	else
	{
		bustName = "NOVA";
		if(nude)
		{
			bustName += "_NUDE";
			switch(special)
			{
				case "tits": bustName += "_0"; break;
				case "cock": bustName += "_1"; break;
			}
		}
	}
	
	return bustName;
}

public function deck13MakeGoo():void
{
	clearOutput();
	author("Savin");
	showName("GOO\nCONTAINER");

	output("You step up to the one vat of gray goo remaining on the deck. It’s humming slightly, churning as it produces and maintains a little sea of goop. There’s a spigot about six feet off the deck, controlled by a dark computer monitor that looks like it belongs in a museum. You walk over and push the screen. Nothing happens.");
	
	output("\n\nPoke. Nothing again.");
	
	output("\n\nYou grumble and pull your Codex out, hoping your device can sync with the goo cannister. You flip the Codex on and search for nearby networks. Again, nothing close enough to be the goo. Shit. You drop down");
	if (pc.hasKnees()) output(" to a [pc.knee]");
	output(" and start looking for an old-school data port. Sure enough, there’s one hidden underneath the console. You pull a universal cable from your Codex, and thankfully manage to slot it into the port. The Codex takes over from there, booting up the ancient computer and interfacing for you. The Bell-Isle/Grunmann logo appears, followed by a button-press command prompt, which the Codex translates onto its touch screen. That’s better. You tap through a few commands, instructing the machine to print you out a great big pile of gray goo.");
	
	output("\n\nThe device hums to life and starts working, squirting out goo like ice cream from its spigot. You watch as it squirts and thrums, depositing gallons of murky silvery goop onto the deck, looking more like a puddle than a person for now. A few seconds later, though, the vat shuts off, and the goo starts squirming and re-shaping itself. It only takes a moment for the big gray blob to turn into a big, bouncy gray girl. She looks just like the creatures");
	if (flags["TARKUS_DESTROYED"] != undefined) output(" once");
	output(" found outside of Novahome, with inhumanly exaggerated hips and ass and a pair of tits that look like silver-sheened watermelons standing impossibly perky on her chest. Her ample assets jiggle and bounce as she looks around, surveying her surroundings with wide eyes full of wonder.");
	
	output("\n\n<i>“Hi!”</i> the newly-made goo says, adopting a huge grin as you take a step toward her. <i>“Wow! You’re super");
	if (pc.isFeminine()) output(" pretty");
	else output(" handsome");
	output("! Are we going to be friends?”</i>");
	
	output("\n\nWell, that’s not exactly what you were expecting from the fuck-happy creatures that escaped the <i>Nova</i>. Still, you nod and say that you are. The gray goo swells up, making a high-pitch squealing sound and hugging herself. <i>“Yaaaaaay! Best friends forever and ever and ever!”</i> she giggles, beaming at you. <i>“Oh! I’m... uh... um... I need a name!”</i>");
	
	CodexManager.unlockEntry("BI/G");
	
	clearMenu();
	addButton(0, "Next", deck13MakeGooII);
}
public function deck13MakeGooII():void
{
	clearOutput();
	author("Savin");
	showBust(novaBustDisplay());
	showName("GOO\nCONTAINER");
	
	output("<b>Enter the Gray Goo’s name:</b>");
	this.displayInput();

	clearMenu();
	addButton(0, "Next", nameThaGoo);
}

public function nameThaGoo():void
{
	if (userInterface.textInput.text.length == 0)
	{
		deck13MakeGooII();
		output("\n\n\n<b>You must enter a name.</b>");
		return;
	}
	// Illegal characters check. Just in case...
	if (hasIllegalInput(userInterface.textInput.text))
	{
		deck13MakeGooII();
		output("\n\n\n<b>To prevent complications, please avoid using code in the name.</b>");
		return;
	}
	if (userInterface.textInput.text.length > 14)
	{
		deck13MakeGooII();
		output("\n\n\n<b>You must enter a name no more than fourteen characters long.</b>");
		return;
	}

	goo.short = userInterface.textInput.text;
	this.removeInput();

	processTime(5+rand(3));
	flags["ANNO_NOVA_UPDATE"] = 2;

	nameThaGooII();
}
public function nameThaGooII():void
{
	clearOutput();
	author("Savin");
	showBust(novaBustDisplay());
	showName("GOO\nCONTAINER");

	output("<i>“[goo.name]?”</i> you suggest.");
	
	output("\n\n<i>“Wow! That’s awesome. I’m soooo " + indefiniteArticle(chars["GOO"].short) + ",”</i> [goo.name] announces, bouncing giddily. <i>“You’re the bestest friend in the whoooole wide universe. It’s the best name EVER!”</i>");
	
	output("\n\nShe lunges at you! For a moment, you’re afraid for your life (or at least, your sexual integrity)... but thankfully her arms settle around your shoulders, and [goo.name] pulls herself");
	if (pc.tallness > goo.tallness + 6) output(" up");
	else if (pc.tallness < goo.tallness - 6) output(" down");
	output(" into a tight hug, squeezing her massive tits against you. You chuckle nervously and pat the goo on the head, your fingers coming away slightly wet and sticky.");
	
	output("\n\nAfter a moment, she peels herself off of you and grins. <i>“So, um, what’s </i>your<i> name?”</i>");
	
	output("\n\n<i>“[pc.name]. [pc.name] Steele,”</i> you answer, extending a hand.");
	
	output("\n\nShe stares at your hand quizzically. Slowly, [goo.name] leans in and wraps her big cock-pillow lips around one of your fingers and sucks on it. The sensation is cool, wet, with just enough suckling pressure to send a shiver of pleasure through your arm. You gently push her off you, and instead offer her Anno’s thumb drive to suckle on.");
	
	output("\n\n<i>“What’s that?”</i> she coos, cocking her head to the side. You tell her it’s loaded with extra programming for her. <i>“No waaaay, is it going to make me super smart and stuff?”</i>");
	
	output("\n\nYou nod. <i>“It sure is.”</i>");
	
	output("\n\n<i>“Yaaaaaaaaaaaay!”</i> she cheers, plucking the drive out of your hand and swallowing it.");
	
	output("\n\nWell shit. [goo.name] beams at you, giggling to herself as you stare at her. Looks like that plan just went out the window.");
	
	output("\n\n<i>“I don’t feel any different,”</i> she pouts, absently cupping one of her huge breasts. <i>“Oh well! Hey, wanna... I dunno, wanna fuck?”</i>");
	
	output("\n\nTime to put this new gray goo to the test.");
	if (pc.libido() >= 66) output(" As much as you would like to see what she’s capable of, you need to make sure she’s not as forcefully amorous as her sisters.");
	output(" <i>“Not right now,”</i> you tell her.");
	
	output("\n\n[goo.name] shrugs. <i>“Kay! Um... what do you wanna do?”</i>");
	
	output("\n\nYou smile, relieved, and ask if [goo.name] would like to come with you back to your ship.");
	
	output("\n\n<i>“Oh wow! A SPACE SHIP!? That’s awesome. I wanna see. I wanna see!”</i>");
	
	output("\n\nLaughing, you take [goo.name]’s hand and lead her up toward the hangar.");

	currentLocation = shipLocation;
	
	processTime(45+rand(15));

	addButton(0, "Next", mainGameMenu);
}

public function grayGooAtBarSetup(slot:int = 8):void
{
	output("\n\nOf all the things, there’s a gray goo-girl bouncing around the bar, her eyes saucer-like and full of wonder as she stares at the myr and other aliens.");
	addButton(slot, "Gray Goo", grayGooAtBar);
}
public function grayGooAtBar():void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor();

	output("<i>“Oh, hi!”</i> she says, perking up as you approach. <i>“Holy wow, it’s really you!”</i>");
	
	output("\n\nYou cock an eyebrow. <i>“Do I know you?”</i>");
	
	output("\n\n<i>“Sure you do! Um, well, maybe? You’ve totally </i>seen<i> me, anyway. I’m Nova!”</i> she grins, shifting her form momentarily to that of the tall, slender, handsome woman you met on Deck 13 of the <i>Nova</i>, dressed in a facsimile of an officer’s uniform. The goo squirms and shifts back to her normally buxom form and giggles playfully. <i>“Recognize me now?”</i>");
	
	output("\n\nWait, wasn’t she going to be getting a new cyber body?");
	
	output("\n\n<i>“</i>She<i> sure did,”</i> the goo-girl laughs, <i>“Captain what’s-her-butt and her crew are all off getting their fancy new bodies. Which means I got to wake up after she left! The nice people in lab coats said I should go find somebody to take care of me, sooooo I’m looking for someone really nice to be my friend! Oh! Do you want to be my friend? Pretty please? You were so nice to all my friends already...”</i>");

	processTime(5+rand(3));

	// [Sure] [Not now]
	clearMenu();
	addButton(0, "Sure", grayGooAtBarSure, undefined, "Sure", "Tell the goo-girl you’ll take her with you. Considering what she was able to do when you fought her, maybe you can get some use out of her in battle...");
	addButton(1, "Not Now", grayGooAtBarNotNow);
}
public function grayGooAtBarSure():void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor();

	goo.short = "Nova";

	output("<i>“Sure. I’m [pc.name],”</i> you say, extending a hand to the goo.");
	
	output("\n\n<i>“Yaaaaaaaaay!”</i> she cheers, leaping onto you and giving you a huge, wet hug, pressing her massive tits against your chest. <i>“Bestest friends forever and ever and ever!”</i> ");
	
	output("\n\nYou chuckle and pat the goo on the head, your fingers coming away slightly wet and sticky. She slips back out of your grasp, going straight through your arm. <i>“You can call me Nova! I guess. I dunno, that’s what all the people that used to live in my head called me. Oh well! Hey, since we’re super best friends, wanna... I dunno, wanna fuck?”</i>");
	
	output("\n\n");
	if (pc.lust() >= pc.lustMax() * 0.75) output("As much as you really could use a little relief.... ");
	output("<i>“Not right now,”</i> you say. Might as well make sure she isn’t going to force herself on you.");
	
	output("\n\n[goo.name] shrugs. <i>“Kay! Um... what do best friends do other than fuck all the time?”</i>");
	
	output("\n\nYou smile, relieved, and ask if [goo.name] would like to come with you back to your ship.");
	
	output("\n\n<i>“Oh wow! A SPACE SHIP!? That’s awesome. I wanna see. I wanna see!”</i>");
	
	output("\n\nLaughing, you take [goo.name]’s hand and lead her up toward the hangar.");

	currentLocation = shipLocation;
	
	flags["ANNO_NOVA_UPDATE"] = 2;

	processTime(45+rand(15));

	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
public function grayGooAtBarNotNow():void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor();
	
	output("<i>“Sorry,”</i> you say, taking a step back from the over-eager pile of goo.");
	
	output("\n\nShe visibly deflates. <i>“Aww. Nobody around here wants to be friends with me,”</i> the goo groans.");

	processTime(1);

	// {Back to bar menu}
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function grayGooArrivesAtShip():void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor();
	
	output("<i>“So, [goo.name], think you can help me out with something?”</i> you ask as you make your way aboard. The gray girl’s eyes are wide with awe as she surveys your ship, squirming around and poking her head right up next to several of your computer systems, poking at the door mechanics, or bending way over to look at something on the floor. Or to show off her big, jiggling booty... hard to tell. You tap her on the back to get her attention, and repeat your request.");
	
	output("\n\n<i>“Oh! Sure, bestest buddy. Anything you want!”</i> she says with a grin, bouncing up uncomfortably close to you. She presents her tits to you and wiggles her behind, clearly expecting your desire to be entirely sexual.");
	
	output("\n\nNot quite. You ask her what she’d think about working with you on your quest. Specifically, coming with you when you’re out fighting. Maybe you could wear her as armor... gray goo is incredibly tough, after all.");
	
	output("\n\n<i>“Hehe, I knew you just wanted to get inside of me!”</i> [goo.name] teases, lunging at you and wrapping her arms around you. You shiver as the cool gray goo envelops you, squirming wetly around your body as [goo.name] conforms to your body. Goo drains around your [pc.face], plating your cheeks like a crash helmet with a pair of big, silver eyes planted just over your own. After a moment, you feel your [pc.gear] being pulled off of you, thrown to the ground as goo runs across your bare skin.");
	
	output("\n\n<i>“Is this okay?”</i> [goo.name] asks, squirming around you. <i>“It’s super comfy, huh?”</i>");
	
	output("\n\nYou have to admit, it actually <i>is</i> very comfortable. Nice and cool, and the goo flows around you like a full-body glove... that just happens to be hardened against weapons fire whenever you need it to be. You tell [goo.name] that this is going to work out just fine... especially if she’s as eager to help you between fights as well.");
	
	output("\n\n<i>“I was hoping you’d ask!”</i> she giggles, shifting herself around your [pc.crotch].");
	
	flags["ANNO_NOVA_UPDATE"] = 3;
	
	processTime(10+rand(5));
	
	output("\n\n<b>You");
	
	if(!(pc.armor is EmptySlot))
	{
		output(" have swapped your [pc.armor] and");
		eventQueue.push(function():void {
			clearOutput();
			clearMenu();
			var oldArmor:ItemSlotClass = pc.armor;
			oldArmor.onRemove(pc);
			quickLoot(oldArmor);
			pc.armor = new GooArmor();
		});
	}
	else pc.armor = new GooArmor();
	
	output(" are now wearing [goo.name] as armor!</b>");
	
	clearMenu();
	if(pc.lust() >= 33)
	{
		addButton(0, "Goo Dicks", gooDickFap, undefined, "Goo Dicks", "Have [goo.name] fill all of your holes and fuck you.");
		if (pc.hasCock()) addButton(1, "GooSleeve", grayGooCockSleeve, undefined, "Goo Cocksleeve", "Have [goo.name] jack you off.");
		else addDisabledButton(1, "GooSleeve", "Goo Cocksleeve", "You don’t have the proper anatomy for that...");
	}
	else
	{
		addDisabledButton(0, "Goo Dicks", "Goo Dicks", "You’re not horny enough for that...\n\n<i>(You can access this later in the Masturbate menu while wearing [goo.name].)</i>")
		if (pc.hasCock()) addDisabledButton(1, "GooSleeve", "Goo Cocksleeve", "You’re not horny enough for that...\n\n<i>(You can access this later in the Masturbate menu while wearing [goo.name].)</i>")
		else addDisabledButton(1, "GooSleeve", "Goo Cocksleeve", "You don’t have the proper anatomy for that...")
	}
	addButton(2, "No Sex", gooFapNope, undefined, "No Sex", "You are not in the mood to sex [goo.name] at this time.");
}

public function gooFapNope():void
{
	clearOutput();
	showGrayGooArmor();
	
	output("With that, you");
	if(pc.isBimbo()) output(" giggle back and tell [goo.name] that you two will be the bestest of friends! You blurt, <i>“Like, we should <b>totally</b> get facials together, okay?”</i>");
	else if(pc.isBro()) output(" grunt and comment that [goo.name] is welcome to help you take a load off anytime she wants--that is, if she can handle you.");
	else if(pc.isMischievous()) output(" jokingly warn [goo.name] not to try anything funny.");
	else if(pc.isAss()) output(" sternly warn [goo.name] not to get all up in your personal business.");
	else output(" thank [goo.name] for being so cooperative.");
	// Extra goo notes for having goo followers!
	if(celiseIsCrew())
	{
		if(pc.isBimbo()) output(" And maybe you can invite another yummy goo-mate to join the party too!");
		else if(pc.isBro()) output(" But of course, if she needs help, you’re sure you can find another goo that could lend a hand too...");
		else if(pc.isMischievous()) output(" You then take a pause. Hm, you might be developing some kind of goo fetish here...");
		else if(pc.isAss()) output(" And as long as she doesn’t make trouble with the other goo, you guess it’ll be fine to have her around.");
		else output(" It would definitely be nice to have another goo-form around the place, you ponder.");
	}
	output("\n\n<i>“Mm-hm!”</i> she excitedly responds, though she is obviously too focused on your crotch to communicate with actual words at the moment.");
	
	pc.lust(5);
	if(pc.hasPerk("Inhuman Desire")) pc.lust(5);
	if(pc.hasPerk("Fuck Sense")) pc.lust(5);
	if(pc.isTreated()) pc.lust(5);
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
public function gooDickFap(fromCrew:Boolean = false):void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor(true, "cock");
	
	output("You");
	if(!fromCrew)
	{
		if(pc.armor is GooArmor)
		{
			output(" pat your");
			if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) && !pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) output(" own goo-coated");
			else output(" naked and exposed");
			output(" backside and");
		}
		else if(pc.hasItemByName("Goo Armor")) output(" open your inventory and");
		else if(InShipInterior() && pc.hasItemInStorage(new GooArmor())) output(" open your storage and");
	}
	output(" ask [goo.name] if she’s up for a little fun. Wordlessly, the goo surrounding you squirms and writhes across your [pc.skinFurScales], caressing your [pc.nipples] and [pc.crotch] in ways that make your [pc.knees] tremble.");
	if (!(pc.lowerUndergarment is EmptySlot) || !(pc.upperUndergarment is EmptySlot))
	{
		output(" Tendrils of goo peel off your");
		if (!(pc.lowerUndergarment is EmptySlot)) output(" [pc.lowerGarment]");
		if (!(pc.lowerUndergarment is EmptySlot) && !(pc.upperUndergarment is EmptySlot)) output(" and");
		if (!(pc.upperUndergarment is EmptySlot)) output(" [pc.upperGarment]");
		output(", taking time to");
		if (pc.hasCock() || pc.hasVagina())
		{
			if (pc.hasCock()) output(" envelop your [pc.cocks]");
			if (pc.hasCock() && pc.hasVagina()) output(" and");
			if (pc.hasVagina()) output(" tease the bud of your [pc.clit]");
		}
		else
		{
			output(" tease the pliant flesh of your asshole")
		}
	}
	else
	{
		output(" [goo.name] takes the time to");
		if (pc.hasCock() || pc.hasVagina())
		{
			if (pc.hasCock()) output(" envelop your [pc.cocks]");
			if (pc.hasVagina() && pc.hasCock()) output(" and");
			if (pc.hasVagina()) output(" tease the bud of your [pc.clit]");
		}
		else
		{
			output(" tease the pliant flesh of your asshole")
		}
	}
	output(", making you gasp and groan with pleasure. You shimmy down onto the ground, getting comfortable as [goo.name] massages you all over. You feel a slight pressure on your [pc.lips], and notice goo congregating around your mouth. She slips right between your lips and floods your mouth. You don’t have a choice in the matter, but have your mouth forced open as [goo.name] forms herself a big, thick cock for you to suck on. You give the playful goo-girl what she wants, and are instantly rewarded by a squirming all across your body as she clearly enjoys your gentle suckling. The goo-cock even starts to thrust before long!");
	
	output("\n\nBehind you, the gooey bodysuit shifts, and suddenly you feel a harsh <i>smack</i> right on your [pc.butt]. You yelp, but find your voice utterly muffled by the goo shoved in your gob. Looking back, you see that most of [goo.name] has sloughed off of you, forming a half-person shape behind you with her hand raised up to smack your ass. You take it, moaning as she playfully abuses your backside.");
	
	output("\n\n<i>“Like it when I’m rough?”</i> she teases, slipping a few fingers between your [pc.legs]");
	if (pc.hasVagina()) output(" and into your [pc.cunt]");
	else if (pc.hasCock()) output(" and wrap them around your half-hard [pc.cockBiggest]");
	if (pc.hasVagina() || pc.hasCock()) output(" and starts to tease her fingertips around your [pc.asshole], just short of penetration");
	else output(" and starts to probe around your [pc.asshole], just short of penetration");
	output(". Now that’s more like it... you push back against her hand, cooing as her long, wet digits explore your");
	if (pc.hasVagina() || pc.hasCock()) output(" sex");
	if (pc.hasVagina() && pc.hasCock()) output("es");
	if (!pc.hasVagina() && !pc.hasCock()) output(" ass");
	output(". <i>“You totally do, dontcha?”</i>");
	
	output("\n\nYou wink at her, wrapping your [pc.tongue] around her gooey prick. Her body quivers in delight, and");
	if (pc.hasVagina()) output(" her fingers reach deeper into you - far deeper than a human ever could, probing to the depths of your womb and back again, finding every sensitive spot along your inner walls and giving them just enough attention to make you squeal.");
	if (pc.hasCock() && !pc.hasVagina()) output(" s");
	if (pc.hasCock() && pc.hasVagina()) output(" S"); 
	if (pc.hasCock()) output("he starts to pump your shaft, wrapping your wang in a silken cocksheath of goo that squirms and writhes around your length.");
	output(" The finger pressing against your [pc.asshole] finally pops in, flooding into your bowels in a wave of cold wetness that has you moaning like a whore and arching your back against the gooey babe. The gooey anal-probe quickly expands once it’s secured a beach-head in your backside, stretching you wonderfully wide and filling you with so much of her chilly goo.");
	
	output("\n\nThe fingers lodged in your");
	if (pc.hasVagina()) output(" cunt and");
	output(" ass");
	output(" begin to expand and change shape, merging together into a");
	if (!pc.hasVagina()) output(" big, thick cock");
	else output(" pair of big, thick cocks");
	output(" to fuck you with. Your eyes go wide, mouth twisting into a silent scream of ecstasy, feeling the cock");
	if (pc.hasVagina()) output("s");
	output(" swelling up inside your straining hole");
	if (pc.hasVagina()) output("s");
	output(".");
	
	var tLooseness:Number;

	if (pc.hasVagina()) tLooseness = pc.gapestVaginaLooseness();
	if (pc.ass.looseness() > tLooseness) tLooseness = pc.ass.looseness();

	output("\n\n<i>“Mmm, you’re");
	if (tLooseness >= 4) output(" nice and loose for me!”</i> [goo.name] giggles, shifting her goo like a hand caressing your asscheeks. <i>“Been finding some big, fat cocks to sit on? Or are you just loosening up until I can fit, like, all the way inside you?”</i>");
	else if (tLooseness <= 1) output(" sooooo, like, tight and squeezy!”</i> the goo giggles, pumping her slick hips against your [pc.butt]. <i>“We’re gonna have to loosen you up a little!”</i>");
	else
	{
		output(" all kinds of amazing back here!”</i> [goo.name] grins, wiggling her dick");
		if (pc.hasVagina()) output("s");
		output(" inside you. <i>“Tight enough to be super squeezy, but loose enough to ram sooooo much in you!”</i>");
	}
	
	output("\n\n[goo.name] sure seems to be enjoying herself... as are you. The feeling of that much goo straining your body, opening you wide to her advances, keeps you gridlocked in moans and cries of desperate pleasure. Her facsimilie hips buck against your ass, pounding her swollen dick");
	if (pc.hasVagina()) output("s");
	output(" deeper and harder into you.");
	if (pc.hairLength >= 3) output(" Seeing you looking, [goo.name] grins and pulls your hair, making your back arch low to the ground.");
	output(" Now that’s the stuff...");
	
	output("\n\n<i>“Are you gonna cum for me?”</i> [goo.name] asks, slamming herself in to the hilt - and filling you with goo until your gut seems to grow like it’s");
	if (pc.isPregnant()) output(" even more");
	output(" pregnant. <i>“You totally are! Come on and");
	if (pc.hasCock()) output(" blow your load all over me!");
	else if (pc.hasVagina()) output(" squirt those pussyjuices all over me!");
	else output(" cum already!");
	output(" I am sooo ready for a snack.”</i>");
	
	output("\n\nThe way she’s treating you, the poor goo must be starving for ");
	if (!pc.hasCock()) output("fem-");
	output("cum!");
	
	output("\n\n[goo.name] leans forward, squeezing her big, squishy tits against your back and wrapping her arms around your [pc.chest] and holding you tight... and putting her in a better position to rapid-fire hammer your ass");
	if (pc.hasVagina()) output(" and pussy");
	output(", pounding you with fast, hard strokes. The gooey prick in your mouth begins to throb and sputter, drooling gray faux-spunk onto your [pc.tongue] in simulated orgasm - [goo.name]’s really going all out to give you the complete fucked-into-submission experience!");
	
	output("\n\nYou groan appreciatively around her twitching goo-cock, feeling your body approaching climax. With a final cry, surrendering to the pleasure, your [pc.asshole]");
	if (pc.hasVagina()) output(" and cunt");
	output(" contract");
	if (!pc.hasVagina()) output("s");
	output(" around [goo.name]’s gooey cock");
	if (pc.hasVagina()) output("s");
	if (pc.hasCock())
	{
		output(", and your [pc.cocks] erupt");
		if (pc.cocks.length == 1) output("s");
		output(" in a geyser of jizz within");
		if (pc.cocks.length == 1) output(" its");
		else output(" their");
		output(" gooy confines");
	}
	output(". Your eyes cross, body going limp as you’re fucked hard, filled with gooey jizz and forced to reciprocate in kind");
	if (pc.hasCock() && pc.hasVagina()) output(", feeding your amorous goo-girl with your ejaculate");
	output(".");
	
	output("\n\nBy the time she’s done with you, you’re nothing but an insensate mess on the ground, squirming and twitching as [goo.name] pounds you raw, screaming triumphantly as she brings you to climax.");
	
	output("\n\n<i>“Whoo! That was awesome!”</i> [goo.name] cheers, sliding out of you - and almost making you cum again from the sheer, alien pleasure of it. <i>“You are </i>such<i> a great fuck, [pc.name]! We gotta do this again and again and again!”</i>");
	
	output("\n\nYou might need to catch your breath first...");

	if(pc.hasVagina()) pc.loadInCunt(goo,0);
	pc.loadInAss(goo);
	processTime(20);

	pc.orgasm();

	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
public function grayGooCockSleeve(fromCrew:Boolean = false):void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor(true, "tits");

	output("You reach down to your pent-up [pc.cock] and give yourself a stroke through the gooey coating hugging your body. Grinning, you");
	if(!fromCrew)
	{
		if(pc.armor is GooArmor) { /* Fine here! */ }
		else if(pc.hasItemByName("Goo Armor")) output(" open your inventory and");
		else if(InShipInterior() && pc.hasItemInStorage(new GooArmor())) output(" open your storage and");
	}
	output(" ask [goo.name] if she’s up for a little fun.");
	
	output("\n\nThe answer comes as a squirming, writhing sensation of cool, wet goo around your [pc.cock]. You suck in a sharp breath, almost collapsing as your gooey bodysuit gives her response. When you hobble a little nearer to the ground, some of the goo starts to drain off of your upper body, splattering to the ground and congealing into a humanoid shape. [goo.name]’s face forms, overtop a pair of gigantic tits that would make a New Texan porn-star jealous, and wraps her hands around them with a couple of inviting pats.");
	
	output("\n\n<i>“I thought you’d never ask!”</i> [goo.name] giggles, jiggling her goopy tits at you. <i>“");
	if (flags["GOOARMOR_SLEEVE_FUCK"] != undefined) output("Well, again, anyway. ");
	output("I just knew you’d wanna play with my big ol’ tits! C’mon and put that [pc.cock] of yours right between ‘em and gimme some cum!”</i>");
	
	output("\n\nConsidering she’s already got your prick wrapped up in squirming goo, that seems like an odd request. Still, you start to move your [pc.hips] towards the wide, deep cleavage between [goo.name]’s tits and find that the gray sheathe around your [pc.cock] moves with you, running like cool lube around your schlong all the way. [goo.name] giggles as your dick slips in between her jiggling boobs, still encased in goo that blends seamlessly into [goo.name]’s chest. It looks like you’ve got a wet little goo-pussy open between her tits, ready for you to fuck. You slide in deeper, hips thrusting your prick down into her welcoming torso, and she giggles and wraps her tremendous tits around your shaft as you go, all the better to enhance your pleasure.");
	
	output("\n\nYou start to fuck the gooey cock-sleeve, hammering your [pc.hips] into [goo.name]’s cleavage. <i>“Ooh, yeah, fuck me </i>rough<i>!”</i> she cheers, clapping her hands together - which just makes a wet patting sound. [goo.name] gives you a toothy smile and wiggles her bubbly assets, making the goo encasing your dick slosh around. Fucking goo never gets old, such a strange and alien sensation, like thrusting into a sea of lube that’s just tight enough to try and milk the cum out of you.");
	
	output("\n\nWhile you’re busy fucking the hole between [goo.name]’s tits, the goo still hugging tight to your lower body shifts and squirms. You start to feel a very slight pressure welling up against your [pc.asshole], and your eyes quickly go wide. [goo.name] gives you a cheeky grin, moving her tits faster around your shaft as the pressure grows more and more urgent against your backside.");

	clearMenu();
	addButton(0, "Allow It", grayGooCockSleeveII, true);
	addButton(1, "Deny Her", grayGooCockSleeveII, false);
}
public function grayGooCockSleeveII(allowIt:Boolean = false):void
{
	clearOutput();
	author("Savin");
	showGrayGooArmor(true, "tits");
	
	if (allowIt)
	{
		output("With a gasp, you feel the slender tendril of goo slip inside you. [goo.name] keeps it short and small, focusing more on control than just filling you with goo-cock. She hones in on the tiny little bulb of your prostate with unerring accuracy, putting just enough pressure on it to make your [pc.cock] leap and start to leak. The moment a drop of pre-cum pours into her, your gooey companion coos happily, licking her lips hungrily.");
	}
	else
	{
		output("You give [goo.name] a very stern look and tell her to <i>“Stop that!”</i>");
		
		output("\n\n<i>“Aww!”</i> she groans, easing the pressure off your behind. <i>“I guess I’ll just have to work harder on that [pc.cock] of yours!”</i>");
		
		output("\n\nAnd does she ever. Her tits start flying around your shaft, and her whole chest contorts around your thrusting cock. She’s like a vacuum sucking on you, ready to drain every drop from your [pc.balls]. It doesn’t take more than a moment for pre to start pouring out of your cock, heralding the inevitable. The moment the first droplet stains her gray body, your gooey companion coos happily, licking her lips hungrily.");
	}

	output("\n\nUnder this kind of treatment, you’re not going to last much longer. You clench down, trying to hold back, but [goo.name]’s sucking, writhing motions are as intense as an expert whore’s, purpose-built to suck every drop of cum from you. There’s not a lot you can do to keep it from happening - just to try and give as good as you get, making sure [goo.name] has every bit as much enjoyment from your lovemaking as you do. She squeals delightedly as you redouble your efforts, wiggling and moaning with every thrust.");
	
	output("\n\nA few moments later, and you reach your limit. With a grunt of effort, you feel your [pc.cock] swell for a moment, then unload into the goo-girl’s expectant hole. She shrieks in pleasure, smiling at you inhumanly wide as you pump her full of spunk, filling her gooey innards with [pc.cumNoun].");
	
	output("\n\nWith a heavy sigh, you roll off the sated goo-girl, watching as your spunk sinks away into the hungry gray goo.");
	
	output("\n\n<i>“Oooh, you’ve been saving that up for me, haven’t you?”</i> [goo.name] giggles, running a finger around her well-fucked chest pussy. <i>“Delicious!”</i>");
	
	output("\n\nYou give her a grin and");
	if(pc.armor is GooArmor) output(" extend an arm to her, inviting your gooey bodysuit to envelop you once again");
	else if(pc.hasItemByName("Goo Armor")) output(" open your inventory, inviting your gooey friend to return");
	else if(InShipInterior() && pc.hasItemInStorage(new GooArmor())) output(" open your storage, inviting your gooey friend to return");
	else output(" let your gooey friend on her way");
	output(". Back to business!");

	processTime(20);

	pc.orgasm();

	if (flags["GOOARMOR_SLEEVE_FUCK"] == undefined) flags["GOOARMOR_SLEEVE_FUCK"] = 0;
	flags["GOOARMOR_SLEEVE_FUCK"]++;

	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function grayGooSpessSkype():void
{
	// Nova is not alive or does not have cybernetic body!
	if(flags["DECK13_GRAY_PRIME_DECISION"] != 1) return;
	
	if (hasGooArmor() && flags["ANNO_NOVA_UPDATE"] == 3 && flags["GRAYGOO_SPESS_SKYPE"] == undefined && rand(5) == 0)
	{
		flags["GRAYGOO_SPESS_SKYPE"] = 1;
		eventQueue.push(grayGooSpessSkypeScene);
	}
}
public function grayGooSpessSkypeScene():void
{
	clearOutput();
	showName("\n" + goo.short.toUpperCase());
	showBust("GRAY_GOO_PRIME");
	
	output("The sound of talking beckons you awake. You blink your eyes open, and see that your cabin’s holoterminal is open, flashing brightly... and [goo.name] is parked in your chair, her body molded in an even more human form than normal. She looks like the old [goo.name] you encountered on Deck 13, complete with uniform and long hair pulled back in a ponytail, sitting on her legs and talking happily at the computer screen.");
	
	output("\n\n<i>“I’m having so much fun!”</i> she grins, jiggling excitedly at the screen. <i>“Space is amazing. There are so many cool people and weird places and adventures. So many adventures! I never thought I’d be, like, a real life adventurer. Well, kind of. [pc.name] is the real adventurer, but [pc.heShe]’s been nice enough to let me tag along.”</i>");
	
	output("\n\nYou hear a noble, reserved laugh from the screen, and a woman’s voice answer. <i>“That’s lovely, [goo.name]. I’m glad you’re being taken care of.”</i>");
	
	output("\n\n<i>“How’s the new body? Everything where it’s supposed to be?”</i> [goo.name] teases, making her big ol’ tits bounce.");
	
	output("\n\n<i>“I am... fully functional, yes,”</i> the voice says with another laugh. <i>“The new body’s quite nice, actually. I do admit, I miss the flexibility and convenience we used to have, but I shouldn’t complain. Sometimes I even forget that I’m not... me.”</i>");
	
	output("\n\n[goo.name] pouts. <i>“Aww, don’t be like that. You’re gonna make </i>me<i> sad. Oh, didn’t you get that super duper awesome job, anyway?”</i>");
	
	output("\n\n<i>“I did!”</i> the woman says, her tone changing immediately. <i>“Steele Tech offered me a captain’s post aboard one of their transports. They said I had sufficient ‘prior experience.’ Ha! Still, it’s something to do. Most of the crew is still in re-education classes to bring them up to speed on all the advances in the last few centuries.”</i>");
	
	output("\n\n[goo.name] beams. <i>“Super cool! I guess I can still call you ‘captain,’ then?”</i>");
	
	output("\n\n<i>“I suppose you can,”</i> the woman laughs. <i>“Ah, speaking of which, looks like my XO is at the door. I have to run, [goo.name]. I’ll call you back soon.”</i>");
	
	output("\n\n<i>“Aw. Okay! See you later, Captain Morrow. Love you. Bye.”</i>");
	
	output("\n\nThe screen flicks off to back, and like breathing a sigh, [goo.name] resumes her less-human gooey form. She scoots back over to where you’ve dumped your equipment and collapses into an amorphous pile, awaiting you. Smiling to yourself, you roll back over and go to sleep again...");
	
	addButton(0, "Next", mainGameMenu);
}

public function pcGooClone(attacker:Creature, target:Creature):void
{
	output("<i>“Go get ‘em, [goo.name]!”</i> you shout.");
	if(attacker.armor.defense <= 1)
	{
		output(" She hesitantly wriggles around you, uncertain whether she should leave you completely defenseless. It seems you won’t have enough armor if she leaves you now, so you might as well do the teasing yourself!");
	}
	else
	{
		output(" She cheers and leaps off of you, half her gooey mass plopping down beside you and reforming into a miniature, big-tittied dancing goo-girl. The mini-goo bounces around, showing off her tits or bending over, flashing her ass and crotch at " + target.a + target.short + ".");
		
		var defenseDown:Number = 5;
		if((attacker.armor.defense - defenseDown) < 1)
		{
			//output(" Unfortunately, due to the lack of material, this leaves your armor defenseless!");
			defenseDown = (attacker.armor.defense - 1);
		}
		
		target.lust(3 + rand(3));
		
		attacker.createStatusEffect("Reduced Goo", defenseDown, 0, 0, 0, false, "Icon_DefDown", chars["GOO"].short + " has split from your frame and is busy teasing your foes - but it’s reduced your defense!", true, 0);
		attacker.armor.defense -= attacker.statusEffectv1("Reduced Goo");
		target.createStatusEffect("Gray Goo Clone", 0, 0, 0, 0, false, "Icon_LustUp", chars["GOO"].short + " is busy distracting your foes!", true, 0);
	}
}
public function pcRecallGoo():void
{
	clearOutput();
	
	// Attacker will be the caster, target are going to basically be null-elements
	var foes:Array = CombatManager.getHostileCharacters();
	for (var i:uint = 0; i < foes.length; i++)
	{
		if (foes[i].hasStatusEffect("Gray Goo Clone"))
		{
			foes[i].removeStatusEffect("Gray Goo Clone");
			break;
		}
	}
	
	output("<i>“Come on back, [goo.name]!”</i> you shout. In the blink of an eye, your body is wrapped in a thick covering of gray goo, cool and wet and comforting.");
	pc.armor.defense += pc.statusEffectv1("Reduced Goo");
	pc.removeStatusEffect("Reduced Goo");
	
	CombatManager.processCombat();
}

public function gooArmorIsCrew():Boolean
{
	if(flags["GOO_ARMOR_ON_SHIP"] != undefined) return flags["GOO_ARMOR_ON_SHIP"];
	return false;
}
public function hasGooArmor():Boolean
{
    if(InShipInterior() && (pc.hasItemInStorage(new GooArmor()) || gooArmorIsCrew())) return true;
    return hasGooArmorOnSelf();
}
public function hasGooArmorOnSelf():Boolean
{
    if(pc.armor is GooArmor || pc.hasItemByName("Goo Armor")) return true;
    return false;
}
public function hasGooArmorUpgrade(upgrade:String = "none", bInv:Boolean = true):Boolean
{
	var hasUpgrade:Boolean = false;
	if(pc.armor is GooArmor)
	{
		switch(upgrade)
		{
			case "ganrael": if(pc.armor.resistances.hasFlag(DamageFlag.MIRRORED)) hasUpgrade = true; break;
		}
	}
	if(bInv)
	{
		for(var i:int = 0; i < pc.inventory.length; i++)
		{
			if(pc.inventory[i].shortName == "Goo Armor")
			{
				switch(upgrade)
				{
					case "ganrael": if(pc.inventory[i].resistances.hasFlag(DamageFlag.MIRRORED)) hasUpgrade = true; break;
				}
			}
		}
	}
    return hasUpgrade;
}
public function gooArmorDefense(def:Number = 0):Number
{
	var gooDef:int = 0;
	var i:int = 0;
	
	// Armor
	if(pc.armor is GooArmor)
	{
		if(def != 0) pc.armor.defense += def;
		gooDef = pc.armor.defense;
	}
	// Inventory
	for(i = 0; i < pc.inventory.length; i++)
	{
		if(pc.inventory[i].shortName == "Goo Armor")
		{
			if(def != 0) pc.inventory[i].defense += def;
			gooDef = pc.inventory[i].defense;
		}
	}
	// Ship Storage
	for(i = 0; i < pc.ShipStorageInventory.length; i++)
	{
		if(pc.ShipStorageInventory[i].shortName == "Goo Armor")
		{
			if(def != 0) pc.ShipStorageInventory[i].defense += def;
			gooDef = pc.ShipStorageInventory[i].defense;
		}
	}
	// Nova Armor
	if(goo.armor is GooArmor)
	{
		if(def != 0) goo.armor.defense += def;
		gooDef = goo.armor.defense;
	}
	
	return gooDef;
}
public function gooArmorInStorageBlurb(store:Boolean = true):String
{
	showBust(novaBustDisplay());
	
	var halp:Array = [];
	
	if(store)
	{
		halp.push("<i>“Heey! Who turned out the lights?”</i>");
		halp.push("<i>“Oof! What happened?”</i>");
		halp.push("<i>“Hey, it’s dark all of a sudden!”</i>");
		halp.push("<i>“Um... Hello...?”</i>");
	}
	else
	{
		halp.push("<i>“Phew, it was getting stuffy in there!”</i>");
		halp.push("<i>“[pc.name], it’s you!”</i>");
		halp.push("<i>“Ohmygosh--You came back!”</i>");
		halp.push("<i>“Surprise, it’s me again!”</i>");
	}
	
	return RandomInCollection(halp);
}

// Menu Function Replacers
public function gooArmorClearOutput(fromCrew:Boolean = true):void
{
	if(!fromCrew) clearOutput2();
	else clearOutput();
}
public function gooArmorOutput(fromCrew:Boolean = true, msg:String = ""):void
{
	if(!fromCrew) output2(msg);
	else output(msg);
}
public function gooArmorClearMenu(fromCrew:Boolean = true):void
{
	if(!fromCrew) clearGhostMenu();
	else clearMenu();
}
public function gooArmorAddButton(fromCrew:Boolean = true, slot:int = 0, cap:String = "", func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null):void
{
	if(!fromCrew) addGhostButton(slot, cap, func, arg, ttHeader, ttBody);
	else addButton(slot, cap, func, arg, ttHeader, ttBody);
}
public function gooArmorAddDisabledButton(fromCrew:Boolean = true, slot:int = 0, cap:String = "", ttHeader:String = null, ttBody:String = null):void
{
	if(!fromCrew) addDisabledGhostButton(slot, cap, ttHeader, ttBody);
	else addDisabledButton(slot, cap, ttHeader, ttBody);
}

// Crew Menu Text
public function gooArmorOnSelfBonus(btnSlot:int = 0, fromCrew:Boolean = true):String
{
	var bonusText:String = "";
	
	if(gooArmorIsCrew())
	{
		bonusText += RandomInCollection([
			"\n\n[goo.name] can be found wandering around your ship, looking about with attentive curiousity.",
			"\n\nYou catch [goo.name] poking her head through some of the open cabinets and storage units, taking a peek at their contents.",
			"\n\nYou hear some light, sing-songy humming close-by and spot [goo.name] skipping about the ship quite happily.",
			"\n\nYou see [goo.name] standing at a nearby console, pressing some buttons and viewing the screen with great interest."
		]);
		gooArmorAddButton(fromCrew, btnSlot, chars["GOO"].short, approachGooArmorCrew, [true, fromCrew], chars["GOO"].short, "Interact with your silvery shape-shifting crew member.");
	}
	else if(hasGooArmorOnSelf())
	{
		if(pc.armor is GooArmor) bonusText += "\n\n[goo.name] wiggles around your body, making you aware of her presence.";
		else bonusText += "\n\nMuffled giggles can be heard near you. Glancing at your inventory, you find [goo.name] happily jiggling inside.";
		
		if(inCombat()) gooArmorAddDisabledButton(fromCrew, btnSlot, chars["GOO"].short, chars["GOO"].short, "You can’t right now--you’re in combat!");
		else if(!fromCrew && !kGAMECLASS.canSaveAtCurrentLocation) gooArmorAddDisabledButton(fromCrew, btnSlot, chars["GOO"].short, chars["GOO"].short, "You can’t seem to do anything with her at the moment.");
		else gooArmorAddButton(fromCrew, btnSlot, chars["GOO"].short, approachGooArmorCrew, [true, fromCrew], chars["GOO"].short, "Interact with your silvery shape-shifting armor.");
	}
	else if(InShipInterior() && pc.hasItemInStorage(new GooArmor()))
	{
		bonusText += RandomInCollection([
			"\n\nYou can try to fish [goo.name] from your storage if you want to do anything with her...",
			"\n\nYou can hear some mumbling coming from the storage room... is [goo.name] still in there?",
			"\n\nSome muffled chatter can be heard in the storage room nearby. Is [goo.name] talking to herself?"
		]);
		
		gooArmorAddDisabledButton(fromCrew, btnSlot, chars["GOO"].short, chars["GOO"].short, "You can’t do anything with her while she is stored away.");
	}
	
	return bonusText;
}

// Interactions w/ Goo Armor
public function approachGooArmorCrew(arg:Array):void
{
	var introText:Boolean = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	if(introText)
	{
		if(gooArmorIsCrew())
		{
			txt += "You approach [goo.name] and attempt to get her attention.";
			if(pc.isBimbo()) txt += " <i>“How’s my totes-fave B.F.F. doing?”</i> you ask, giving her a big hug.";
			else if(pc.isNice()) txt += " <i>“Everything okay there, [goo.name]?”</i> you ask, waving.";
			else txt += " <i>“Hey, goo-face! How goes?”</i> you say, giving the girl a nudge.";
			txt += "\n\nShe turns to you. <i>“Oh hey, [pc.name]! Just super! And, like, how are you?”</i> she responds.";
		}
		else
		{
			if(pc.isBimbo()) txt += "<i>“Wakey, wakey, girlfriend!”</i> you squeal";
			else if(pc.isNice()) txt += "<i>“Are you awake, [goo.name]?”</i> you ask";
			else txt += "<i>“Up and at ‘em, goo-for-brains!”</i> you shout";
			if(pc.armor is GooArmor) txt += ", tugging on your steel gray outfit.";
			else txt += ", rustling through your inventory.";
			txt += "\n\nLike a natural reflex, your gooey companion";
			if(pc.armor is GooArmor) txt += " lifts herself from your torso just barely while staying firmly attached.";
			else
			{
				txt += " springs out from her compartment and forms herself right next to you.";
				if(InShipInterior())
				{
					txt += " She gives you an excited wave, then proceeds to wander about the ship";
					if((crew(true, true) - 1) > 0) txt += ", admiring the rest of your crew";
					txt += ".";
				}
			}
			if((pc.armor is GooArmor) || !InShipInterior()) txt += " <i>“Heya, [pc.name]! Like, what’s up?”</i> she responds.";
		}
		
		processTime(1);
	}
	else
	{
		if((pc.armor is GooArmor) || !InShipInterior()) txt += "[goo.name] tilts her head and gives you a bright smile, anticipating what you’ll do next.";
		else txt += "[goo.name] flashes you a bright smile and continues to wander around the ship with great interest.";
	}
	
	gooArmorOutput(fromCrew, txt);
	
	approachGooArmorCrewMenu(fromCrew);
	return;
}
public function approachGooArmorCrewMenu(fromCrew:Boolean = true):void
{
	// Options
	gooArmorClearMenu(fromCrew);
	gooArmorAddButton(fromCrew, 0, "Talk", gooArmorCrewOption, ["talk", fromCrew], "Talk", "Chat a bit with [goo.name].");
	if(flags["GOO_ARMOR_CUSTOMIZE"] == undefined) gooArmorAddDisabledButton(fromCrew, 1, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 3 ? " She may be more confident if you are a higher level." : " Maybe try" + ((pc.armor is GooArmor) ? " taking her off first, then" : "") + " talking to her" + (InShipInterior() ? "" : " while in your ship") + " for a bit?"));
	else gooArmorAddButton(fromCrew, 1, "Customize", gooArmorCrewOption, ["customize", fromCrew], "Customize " + ((pc.armor is GooArmor) ? "Suit" : "Appearance"), ((pc.armor is GooArmor) ? "See if [goo.name] can change how she looks on you." : "See if [goo.name] can change her form for you."));
	if(pc.lust() >= 33)
	{
		if(rooms[currentLocation].hasFlag(GLOBAL.NOFAP)) gooArmorAddDisabledButton(fromCrew, 2, "Sex", "Sex", "Masturbating here would be impossible.");
		else if(rooms[currentLocation].hasFlag(GLOBAL.FAPPING_ILLEGAL)) gooArmorAddDisabledButton(fromCrew, 2, "Sex", "Sex", "Public masturbation is illegal here. Trying to masturbate would almost certainly land you in jail.");
		else if(rooms[currentLocation].hasFlag(GLOBAL.PUBLIC) && pc.exhibitionism() < 33 && pc.libido() < 70) gooArmorAddDisabledButton(fromCrew, 2, "Sex", "Sex", "You cannot have sex with [goo.name] at this time!");
		else gooArmorAddButton(fromCrew, 2, "Sex", gooArmorCrewOption, ["sex", fromCrew], "Sex", "Have some sexy fun-time with [goo.name].");
	}
	else gooArmorAddDisabledButton(fromCrew, 2, "Sex", "Sex", "You are not aroused enough for this.");
	
	if(flags["GOO_ARMOR_HEAL_LEVEL"] == undefined) gooArmorAddDisabledButton(fromCrew, 5, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 7 ? " She may be more confident if you are a higher level." : " Maybe try" + (pc.hasItem(new GrayMicrobots(), 10) ? "" : " stocking up and") + " carrying some drinkable health items," + ((pc.armor is GooArmor) ? " taking her off," : " and") + " then talking to her" + (InShipInterior() ? "" : " while in your ship") + "?"));
	else if(pc.HP() >= pc.HPMax()) gooArmorAddDisabledButton(fromCrew, 5, "Heal", "Restore Health", "You are already at full health!");
	else if(gooArmorDefense() < 2) gooArmorAddDisabledButton(fromCrew, 5, "Heal", "Restore Health", "[goo.name]’s defense is too low to use her healing ability.");
	else if(pc.hasStatusEffect("Goo Armor Healed")) gooArmorAddDisabledButton(fromCrew, 5, "Heal", "Restore Health", "[goo.name] has already healed you in the past hour. She may need some time to recover before trying it again.");
	else gooArmorAddButton(fromCrew, 5, "Heal", gooArmorCrewOption, ["heal", fromCrew], "Restore Health", "Ask [goo.name] to help mend your wounds.");
	
	if(fromCrew && flags["GOO_ARMOR_ON_SHIP"] == undefined)
	{
		if(InShipInterior()) gooArmorAddButton(fromCrew, 4, "Stay", gooArmorCrewOption, ["stay", fromCrew], "Stay Here, " + chars["GOO"].short + ".", "Ask [goo.name] to stay on your ship.");
		else gooArmorAddDisabledButton(fromCrew, 4, "Stay", "Stay Here, " + chars["GOO"].short + ".", "This is probably not a good place to leave [goo.name] wandering around... Maybe you should head inside your ship first?");
	}
	else if(fromCrew && InShipInterior())
	{
		if(!pc.hasArmor() || pc.inventory.length < pc.inventorySlots()) gooArmorAddButton(fromCrew, 4, "Take", gooArmorCrewOption, ["take", fromCrew], "Take " + chars["GOO"].short, "Ask [goo.name] to tag along with you.");
		else gooArmorAddDisabledButton(fromCrew, 4, "Take", "Take " + chars["GOO"].short, "You don’t have any extra room to take her! Try emptying your inventory or taking off your outfit first.");
	}
	
	gooArmorAddButton(fromCrew, 14, (fromCrew ? "Leave" : "Back"), gooArmorCrewOption, ["leave", fromCrew]);
}

public function gooArmorTalkButton(btnSlot:int):void
{
	if(!hasGooArmor()) return;
	
	var activate:Boolean = false;
	
	if(pc.level >= 4 && flags["GOO_ARMOR_SWIMSUIT"] == undefined && InRoomWithFlag(GLOBAL.POOL) && !(pc.armor is GooArmor) && pc.inSwimwear(true)) activate = true;
	
	if(activate) addButton(btnSlot, chars["GOO"].short, gooArmorCrewOption, ["talk", true, true], "Talk with " + chars["GOO"].short,"Maybe have a chat with [goo.name]?");
	return;
}
public function gooArmorCrewOption(arg:Array):void
{
	var response:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var exitMain:Boolean = (arg.length > 2 ? arg[2] : false);
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	gooArmorClearMenu(fromCrew);
	
	switch(response)
	{
		case "talk":
			showGrayGooArmor();
			
			// Level 3
			if(pc.level >= 3 && flags["GOO_ARMOR_CUSTOMIZE"] == undefined && InShipInterior() && !(pc.armor is GooArmor) && rand(4) == 0)
			{
				clearBust();
				
				txt += "Sensing your approach, [goo.name] quickly morphs into a shapeless blob and scoots a couple steps away from you. She suddenly reforms with her back turned to you, appearing in a slightly different guise than her normal self. Her hair is not in the loose, wavy fashion it normally is, but instead, it is tied in a low ponytail. The silvery companion doesn’t turn around, so you can’t tell if something is wrong.";
				txt += "\n\nAfter a brief moment, you call to her. <i>“" + (pc.isBimbo() ? "Umm... [goo.name]?" : "Is something wrong, [goo.name]?") + "”</i> She doesn’t respond, but only wriggles a little... and your ears maybe catch a slight giggle? In any case, it seems like she wants you to approach her instead... So you do.";
				
				processTime(1);
				
				gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["morph 0", fromCrew, exitMain]);
			}
			// Level 4
			else if(pc.level >= 4 && flags["GOO_ARMOR_SWIMSUIT"] == undefined && InRoomWithFlag(GLOBAL.POOL) && !(pc.armor is GooArmor) && pc.inSwimwear(true))
			{
				txt += "You tap [goo.name] for a chat but she is too busy looking around the pool area, wide-eyed.";
				txt += "\n\n<i>“Wooow. Look at this place!”</i> She is enamored by the water and turns to you, noticing your swimwear. <i>“You’re gonna go swimming?”</i>";
				txt += "\n\nYou nod and tell her you are.";
				txt += "\n\n<i>“Like, can I join, too?”</i>";
				txt += "\n\nShe’s waterproof, you think to yourself. <i>“Sure, why not?”</i>";
				txt += "\n\n<i>“Yay!”</i> With that, she jumps with excitement. <i>“Ooh, let me get dressed first!”</i> She shuffles in place, peeling off her pretend goo clothing. <i>“And no peeking...”</i> she winks, <i>“... unless you want to!”</i>";
				txt += "\n\nWith some concentration, [goo.name]’s form rearranges itself and a new shape appears around the surface of her body. Two string-like blobs appear on each of her jiggly breasts, barely covering her silvery nipples, creating a kind of loose bikini top.";
				if(chars["GOO"].legCount <= 1) txt += " Her lower body splits into two, forming shapely legs that";
				else if(chars["GOO"].legCount == 2) txt += " Her shapely legs spread apart slightly to";
				else txt += " Her legs merge into one central blob, then the mass quickly splits into two, forming shapely legs that";
				txt += " make room for the bottom half of her bikini to squeeze into. Her bikini bottom then divides and extends to merge with the strings of her top, converting her swimsuit into an extra-lewd slingkini.";
				txt += "\n\n<i>“So, how do you like it?”</i> She twirls. <i>“I think it’s quite sexy!”</i> You give her outfit a once-over. ‘Sexy’ is an understatement--if she wore anything skimpier, she’d be a full-blown exhibitionist!";
				txt += "\n\nYou take a moment to test the water from the pool’s edge and proceed to walk right in until you are submerged up to the top of your chest. You turn around and invite [goo.name] in.";
				
				processTime(2);
				
				gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["swimsuit 0", fromCrew, exitMain]);
			}
			// Level 5
			else if(pc.level >= 5 && flags["GOO_ARMOR_CUSTOMIZE"] == 0 && InShipInterior() && !(pc.armor is GooArmor) && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				txt += "Spotting you with head gear, [goo.name] gets incredibly curious. <i>“Ooo, neat. What’s this do?”</i> she asks, poking it with a gooey finger.";
				txt += "\n\nYou tell her it’s a helmet that protects you from inhaling dangerous gasses and protects against other fluids as well. You also add that it may also help in breathing underwater if the rest of the suit is fully sealed, pressurized, and hooked up to a rebreather.";
				txt += "\n\n<i>“Awesome! You think I can make something like that?”</i> She presses her face against the front, obscuring your view with her flattened face.";
				txt += "\n\n<i>“" + (pc.isBimbo() ? "Yeah, you should, like, totally go for it!" : "Hm... Sure, why not?") + "”</i> you say, finding this as an ideal opportunity for her to learn.";
				txt += "\n\n<i>“Yay!”</i> The gray goo girl leaps up at you to rest herself on your shoulders. The majority of her mass is wrapped around your dome, making you wobble a bit as your vision is masked in complete darkness. After a minute or two, there is a muffled <i>“Okay, I think I’ve got it!”</i> and then she launches herself off you, making you stagger back.";
				txt += "\n\nWhen your vision returns, you find [goo.name] in a half-kneeling pose on the floor, her arms bent and hands balled in a determined fashion, her face in deep concentration. As you [pc.move] towards her, her head is suddenly engulfed in a shapeless silvery blob. The blob then inflates into a more orb-like shape. [goo.name] then stands up to face you.";
				txt += "\n\n<i>“H-How can you see through this thing?”</i> But just as she says that, her microbots get to work in adjusting their composition to make the surface of the new ‘helmet’ optically transparent in the visible light spectrum. The silver-gray color then gradually dissolves, leaving behind a very solid but clear window. <i>“Oh, there we go--I mean, I meant to do that!”</i> She says in response, her bubbly face now completely visible behind the simulated glass.";
				
				processTime(3);
				
				gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["helmet 0", fromCrew, exitMain]);
			}
			// Level 7
			else if(pc.level >= 7 && flags["GOO_ARMOR_HEAL_LEVEL"] == undefined && InShipInterior() && !(pc.armor is GooArmor) && pc.hasItemByName("Goo Armor") && pc.hasItem(new GrayMicrobots(), 10))
			{
				txt += "You approach [goo.name] for a chat, but find her face suddenly blanche (that is, if she wasn’t already a full coat of solid silver-gray).";
				txt += "\n\n<i>“" + (pc.isBimbo() ? "Hey girl" : "Oh, [goo.name]") + ", something wrong?”</i> You ask, noticing her ill expression.";
				txt += "\n\nShe responds, with an unnatural heaving noise. Then the sound of bubbling and gurgling rumbles through her tummy. <i>“Umm... I don’t feel so good...”</i> She finally exhales, clutching her midsection.";
				txt += "\n\n<i>“Wh-what happened?”</i>";
				txt += "\n\n<i>“Please don’t get mad at me, [pc.name]...”</i> She begs a caveat.";
				txt += "\n\n" + (pc.isAss() ? "You swing your arms in the air. <i>C’mon out with it already! What happened?”</i>" : "You nod and assure her you won’t, whatever it is.") + " You just want to know what’s wrong with her.";
				txt += "\n\nGurgle. <i>“W-well... like...”</i> Bubble. <i>“... you know those energy drinks you keep in your pack?”</i>";
				txt += "\n\nEnergy drinks? What energy drinks?";
				txt += "\n\n<i>“I-I wanted to taste them... and they were </i>too<i> yummy... and... and I drank a whole, whole bunch! I couldn’t help myself! I’m SOOOO sorry!”</i> She blurts, hands now covering her mouth. The gurgling seems to have instantly stopped after the climax of her confession. <i>“Hm?”</i>";
				txt += "\n\nYou double-check your inventory and notice it being a bit lighter than you remember. Open and mostly-empty canisters roll out, one by one, and fall to the hard floor. You squat down to investigate. Hm. It seems [goo.name] has been drinking - or in her case, assimilating - the gray microbots you’ve been holding in your inventory... You stand up to let [goo.name] know exactly what she drank, but as you turn to her, an unnoticed puddle of gray microbots forces you to slip and lose your balance. You go head first toward a nearby wall and your vision goes black.";
				txt += "\n\n<i>“[pc.name]!”</i>";
				
				processTime(2);
				pc.HP(-10);
				
				gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["healing 0", fromCrew, exitMain]);
			}
			// Level 9
			else if(9999 == 0 && pc.level >= 9 && flags["GOO_ARMOR_CUSTOMIZE"] == 1 && InShipInterior() && !(pc.armor is GooArmor) && (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)))
			{
				txt += "9999 - Text.";
				txt += "\n\n9999 - Text.";
				
				gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["expose 0", fromCrew, exitMain]);
			}
			// Generic Talks
			else
			{
				txt += "You spend a little time making small talk with the cute goo girl. While her conversation might not be the most in-depth, it is fulfilling enough not to be completely vapid. The subject shifts between";
				
				var talks:Array = [];
				talks.push(" her likes and dislikes");
				talks.push(" her favorite foods");
				talks.push(" your performance on the field");
				talks.push(" what she likes most about Captain Victoria Morrow");
				if(flags["NALEEN_SNUGGLED"] != undefined) talks.push(" how snuggly the naleen huntress is");
				if(flags["MET_VANAE_MAIDEN"] != undefined || flags["MET_VANAE_HUNTRESS"] != undefined) talks.push(" a vanae’s favorite color");
				if(flags["MET_SEXBOT_FEMALE_ON_TARKUS"] != undefined || flags["MET_SEXBOT_MALE_ON_TARKUS"] != undefined) talks.push(" what sexbots dream about when they sleep");
				if(flags["MET_GRAY_GOO"] != undefined) talks.push(" the potential size of her extended family");
				if(flags["MET_NYREA_ALPHA"] != undefined || flags["MET_NYREA_BETA"] != undefined) talks.push(" how weird nyrea anatomy is");
				if(CodexManager.entryUnlocked("Zil") && CodexManager.entryUnlocked("Gold Myr")) talks.push(" the difference between myr and zil honey");
				txt += RandomInCollection(talks);
				
				txt += " and leads into";
				
				var chats:Array = [];
				var msg:String = "";
				
				msg = " the various encounters she’s seen on your adventure.";
				msg += "\n\n<i>“... and I’ve learned so much from that. That’s why it’s great tagging along with you!”</i> she confesses.";
				msg += "\n\n" + (pc.isBimbo() ? "You give your silver girlfriend a great big hug, squeezing her so hard you swear she could burst into candy and rainbows at any moment. She’s always been so positive!" : "You thank her for the much needed compliment. In a universe where things can get dark fast, you are glad there is some positivity to help balance things out.");
				chats.push(msg);
				
				msg = " a topic about some parasitic creature.";
				msg += "\n\n<i>“... and you should be careful around them, or they’ll go up your butt and never come out!”</i> she concludes.";
				msg += "\n\n" + (pc.isBimbo() ? "Yikes, that sound both exciting and possibly painful!" : "You shrug, not sure where she made that observation, but that does sound like a good enough reason to be careful!");
				chats.push(msg);
				
				msg = " what planets she would like to travel to next.";
				msg += "\n\n<i>“... I think so, too! Yep. Ice Cream Planet... or Frozen Yogurt. Whatever!”</i> she imagines.";
				msg += "\n\n" + (pc.isBimbo() ? "Mmm, that does sound totally yummy! Then after that, Beach Planet!" : "You laugh. She must really like ice cream!");
				if(!pc.hasStatusEffect("Bitterly Cold")) chats.push(msg);
				
				msg = " the freezing weather.";
				msg += "\n\n<i>“... but it’s soooo " + (!pc.hasHeatBelt() ? "c-c-c-cooooooold..." : "cold here!") + "”</i> she whines, then huffs, <i>“" + (!pc.hasHeatBelt() ? "d-d-" : "") + "do you think Ice Cream Planet will be this " + (!pc.hasHeatBelt() ? "c-" : "") + "cold?”</i>";
				msg += "\n\n" + (pc.isBimbo() ? "<i>“I hope not! Besides, this weather is, like, " + (pc.felineScore() >= 3 ? "purr-" : "per") + "fect for wearing more fur, right?”</i> you answer" + (!pc.hasHeatBelt() ? ", hoping to cheer the poor slime-girl up" : " in hopes of appealing to her fashion sense") + "." : "You manage to chuckle a little. It seems " + (!pc.hasHeatBelt() ? "the poor goo-girl" : "she") + " is better suited for warmer climates.");
				if(pc.hasStatusEffect("Bitterly Cold")) chats.push(msg);
				
				msg = " how ausars speak. She tries to imitate different dialects of the ausar language, failing horribly.";
				msg += "\n\n<i>“... I know right? I can’t really tell the difference either!”</i> she replies.";
				msg += "\n\n" + (pc.isBimbo() ? "Like, at least she tried her best! Maybe you two should take a trip to Ausaril some time to learn!" : "You don’t blame her, their language is tricky to foreigners if their tongue isn’t trained for it.");
				chats.push(msg);
				
				msg = " a previous public debate in U.G.C. politics.";
				msg += "\n\n<i>“... and I don’t know much about that foreign gobbly-gook she keeps talking about, but she looks like a total bitch! I mean, have you heard her laugh?”</i> she comments.";
				msg += "\n\n" + (pc.isBimbo() ? "<i>“Oh, totally, that senator has the most bitchiest bitch-face ever, ugh!”</i> you agree, remembering that almost-demonic laugh during the debate." : "While the senator’s politics don’t really mesh with yours, you can agree with [goo.name] on one thing: that senator needs some mods to fix her face for sure--and her voice. Lady laughs like a banshee.");
				if(!pc.isNice()) chats.push(msg);
				
				msg = " a recent charity to help fund research for a remedy to some rare SSTD.";
				msg += "\n\n<i>“... and yeah, I would totally help if I could earn the credits. You think I can give blowjobs for donations?”</i> she ponders.";
				msg += "\n\n" + (pc.isBimbo() ? "<i>“Oh, that would be, like, the best fundraiser ever--I’ll even join you! Double the effort, double the earnings!”</i> you agree, letting the thought linger a little more while you two hatch a hypothetical plan...." : "Hypothetically indulging her silly idea, if given the right circumstances, you could probably send her to a red-light district to shake her money maker and then send the proceeds to the fundraiser....");
				if(pc.isNice()) chats.push(msg);
				
				msg = " a questionable mod being advertised on the holo-boards.";
				msg += "\n\n<i>“... and I dunno, changing yourself into that might not be a good idea, right?”</i> she asks.";
				msg += "\n\n" + (pc.isBimbo() ? "You think about it, but you can’t make an opinion one way or the other. You guess it’s just up to the user to decide!" : "She’s probably right, but you find it humorous that she is concerned about change when she’s a goo-girl who changes form constantly.");
				chats.push(msg);
				
				msg = " a legend about pastry golems.";
				msg += "\n\n<i>“... ooOooOoo--and maybe chocolate! Hm, I wonder what their filling tastes like? Probably yummy!”</i> she comments.";
				msg += "\n\n" + (pc.isBimbo() ? "She’s so silly! Like, no way, how can cupcakes come to life?" : "What a silly idea! There’s no such thing as a cupcake--... is there?");
				if(silly) chats.push(msg);
				
				msg = " a plan to surprise Celise at her next birthday.";
				msg += "\n\n<i>“... and that’s when we throw her a big party and everything, yah?”</i> she asks.";
				msg += "\n\nYou " + (pc.isBimbo() ? "giggle back and nod in agreement. That totally sounds fun!" : "nod, agreeing with her--that does sound like it’d be a lot of fun.");
				if(celiseIsCrew()) chats.push(msg);
				
				msg = " an idea involving Reaha and settling here on New Texas.";
				msg += "\n\n<i>“... and we can have a big farm to put her in!”</i> she illustrates with her hands. <i>“Hmm... I really don’t know what I can be. What do you think she’ll like better: a chicken, a pig, or a horse?”</i> ";
				msg += "\n\n" + (pc.isBimbo() ? "You think it over and tell [goo.name] she would probably look super cute if she changed herself into a chubbly little piggy girl!" : "You don’t really know what Reaha would prefer, but if you were to hazard a guess... maybe the goo-girl could turn herself into a horse - of course!");
				if(reahaIsCrew() && getPlanetName() == "New Texas" && !InShipInterior()) chats.push(msg);
				
				msg = " Anno’s grooming habits.";
				msg += "\n\n<i>“... and that’s what I think would help if she looked into it more. Oh, I wonder how fluffy her tail can get...”</i> she ponders.";
				msg += "\n\n" + (pc.isBimbo() ? "The two of you secretly plot a way to change the snow-colored ausar’s shampoo to try to get her super fluffy!" : "You bet Anno can get it pretty fluffy if she used the right conditioners... or mods.");
				if(annoIsCrew() && InShipInterior()) chats.push(msg);
				
				msg = " a discussion about a particular product.";
				msg += "\n\n<i>“... like, BIG-big! Hmmm... do you think [bess.name] would know if JoyCo sells something that?”</i> she asks.";
				msg += "\n\n" + (pc.isBimbo() ? "Wow, that’s pretty big! You pout while pondering... You don’t think they have any <i>that</i> big. But maybe you could call in and make a request!" : "You are pretty sure those are a part of JoyCo’s line-up somewhere... just not anywhere near <i>that</i> big.");
				if(flags["BESS_FULLY_CONFIGURED"] != undefined && bessIsCrew()) chats.push(msg);
				
				msg = " some comments about Yammi’s cooking--namely her desserts.";
				msg += "\n\n<i>“... Oh, yesssssss! She makes the yummiest milkshakes and sundaes, too!”</i> she exclaims.";
				msg += "\n\n" + (pc.isBimbo() ? "You lick your [pc.lips] in response, mentally drooling at the thought. Sounds like a good reason to throw an at-home ice cream party!" : "All this talk is gving you quite a craving for some homemade meals, that’s for sure!.");
				if(yammiIsCrew() && flags["YAMMI_TALK"] >= 2) chats.push(msg);
				
				msg = " some factoids about ancient, New Texan creatures.";
				msg += "\n\n<i>“... oooh, like dinosaurs?”</i> she asks, wide-eyed. She then morphs herself into her own interpretation of a prehistoric varmint and attempts to chase your own varmint around. <i>“RAWR! I’m gonna get you!”</i>";
				msg += "\n\nYour blue pet playfully tackles the silver goo-dino and gives her a couple loving licks, which instantenously reverts her form back and she gives it a great big hug." + (pc.isBimbo() ? " They are having so much fun together!" : " Those two seem to be getting along very well!");
				if(varmintIsTame() && hasVarmintBuddy() && InRoomWithFlag(GLOBAL.OUTDOOR)) chats.push(msg);
				
				txt += RandomInCollection(chats);
				
				processTime(15 + rand (16));
				if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
				else approachGooArmorCrewMenu(fromCrew);
			}
			break;
		case "customize":
			showGrayGooArmor();
			
			txt += "Deciding to go for some customization,";
			
			// Armor changes
			if(pc.armor is GooArmor)
			{
				txt += " you";
				if(pc.isBimbo()) txt += " poke your bestest friend";
				else if(pc.isNice()) txt += " pat your goo friend";
				else txt += " tap your silver companion";
				txt += " for some attention.";
				txt += "\n\n[goo.name] wriggles around you and responds, <i>“Thinking about changing how I look on you?”</i>";
				if(pc.isBimbo()) txt += "\n\n<i>“Yaah! For realsies!”</i> you nod eagerly.";
				else txt += "\n\nYou confirm that you do.";
				
				if(flags["GOO_ARMOR_CUSTOMIZE"] == undefined || flags["GOO_ARMOR_CUSTOMIZE"] < 2)
				{
					txt += "\n\n<i>“Sure thing, just name it!”</i>";
				}
				else
				{
					txt += "\n\n<i>“Oh boy, do I have some options for you! Do you wanna look like a totally";
					if(rand(3) == 0) txt += " hot space-knight";
					else if(rand(2) == 0) txt += " bangin’ spacer " + pc.mf("bro", "chick");
					else txt += " fuckable rusher";
					txt += "? Would you rather";
					if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += " cover up your sexy bits";
					else if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) && rand(2) == 0) txt += " prance around like a silver-covered " + (!silly ? "butt-slut" : "analmancer");
					else if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) && rand(2) == 0) txt += " sashay with your " + (pc.hasGenitals() ? (pc.hasCock() ? "yummy hot-rod" : "lady lips") : "crotch") + " exposed";
					else if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) && rand(2) == 0) txt += " go out there " + (pc.hasBreasts() ? "sharing your honeydews with the world" : "like a bare-chested hunk");
					else txt += " run around in something more revealing";
					txt += "? Your choice!”</i>";
				}
				txt += " With that, she quickly slaps onto your body and reverts back into her suit-like appearance.";
				txt += "\n\nYou press a button on " + (InShipInterior() ? "a nearby console which projects a mirror designed" : "your codex which activates a holo-projected mirror and you size it") + " to show your full frame.";
				txt += "\n\n" + gooArmorDetails();
				
				processTime(2);
				
				gooArmorChangeArmorMenu(fromCrew);
				gooArmorAddButton(fromCrew, 14, "Back", gooArmorChangeArmor, ["back", fromCrew]);
			}
			// Appearance changes
			else
			{
				txt += " you look your";
				if(pc.isBimbo()) txt += " bestest friend";
				else if(pc.isNice()) txt += " goo friend";
				else txt += " silver companion";
				txt += " up and down, thinking.";
				txt += "\n\n[goo.name] looks back and responds, <i>“Looking for a change?”</i>";
				txt += "\n\nYou nod, pondering some more.";
				txt += "\n\n<i>“Totally [pc.name], just name it! What do you think I should change into?”</i>";
				
				processTime(1);
				
				if(chars["GOO"].hairStyle != "null") gooArmorAddButton(fromCrew, 0, "Normal", gooArmorChangeBody, ["null", fromCrew], "Appear Normal", "Change to look like her normal self.");
				else gooArmorAddDisabledButton(fromCrew, 0, "Normal");
				if(chars["GOO"].hairStyle != "loose") gooArmorAddButton(fromCrew, 1, "Gray Goo", gooArmorChangeBody, ["loose", fromCrew], "Appear Like a Gray Goo", "Change to look like the common gray goo that roam the wilds of Tarkus.");
				else gooArmorAddDisabledButton(fromCrew, 1, "Gray Goo");
				if(chars["GOO"].hairStyle != "ponytail") gooArmorAddButton(fromCrew, 2, "Capt. Morrow", gooArmorChangeBody, ["ponytail", fromCrew], "Appear Like Victoria Morrow", "Change to look like the Captain of the ship she originated from.");
				else gooArmorAddDisabledButton(fromCrew, 2, "Capt. Morrow");
				gooArmorAddButton(fromCrew, 14, "Back", gooArmorChangeBody, ["back", fromCrew]);
			}
			break;
		case "sex":
			showGrayGooArmor(true);
			
			txt += "<i>“Ooo, feeling frisky, are we?”</i> [goo.name]";
			if(pc.armor is GooArmor) txt += " teases you as she rubs and tightens her mass around your body";
			else txt += " swirls herself around you and gives you a playful <i>boop</i> on the nose";
			txt += ". <i>“Well I’m, like, totally in the mood for some fun if </i>you<i> are...”</i>";
			txt += "\n\nWhat would you like to have her do?";
			
			gooArmorAddButton(fromCrew, 0, "Goo Dicks", gooDickFap, true, "Goo Dicks", "Have [goo.name] fill all of your holes and fuck you.");
			if(pc.hasCock()) gooArmorAddButton(fromCrew, 1, "GooSleeve", grayGooCockSleeve, true, "Goo Cocksleeve", "Have [goo.name] jack you off.");
			else gooArmorAddDisabledButton(fromCrew, 1, "GooSleeve", "Goo Cocksleeve", "You don’t have the proper anatomy for that...");
			gooArmorAddButton(fromCrew, 14, "Back", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "heal":
			showGrayGooArmor();
			
			var hpQ:Number = pc.HPQ();
			
			txt += "Looking at your";
			if(hpQ > 75) txt += " light wounds";
			else if(hpQ > 50) txt += " wounds";
			else if(hpQ > 25) txt += " semi-serious wounds";
			else if(hpQ > 10) txt += " heavy wounds";
			else txt += " life-threatening wounds";
			txt += ", you ask if [goo.name] can give you some medical attention.";
			txt += "\n\nShe swirls herself around you to take a look. <i>“";
			if(hpQ > 75) txt += "Ah, silly, that’s just a scratch!";
			else if(hpQ > 50) txt += "Okay, [pc.name], show me where it hurts...";
			else if(hpQ > 25) txt += "Ouch, that must hurt! I hope you’re okay, [pc.name]!";
			else if(hpQ > 10) txt += "Oh, [pc.name], you should really go into urgent care for that...";
			else txt += "Ohmygosh, [pc.name]! You should really go to an emergency med center, quick!";
			txt += "”</i> she says as she quickly assesses the damage. <i>“";
			if(hpQ > 75) txt += "You’re just a " + (pc.tallness < 48 ? "little" : "big") + " baby, aren’t you?";
			else if(hpQ > 50) txt += "... and I’ll kiss it to make it feel better!";
			else if(hpQ > 25) txt += "Here, let me see if I can help!";
			else if(hpQ > 10) txt += "I’ll do my best to help anyway!";
			else txt += "I’m not sure how much I can help, but I’ll try my best!";
			txt += "”</i> And with that, her index finger morphs into a tendril and heads past your [pc.lips] and into your mouth.";
			txt += "\n\nYou feel several drops of microbots flow underneath your [pc.tongue] and travel down your throat. In no time, your body shudders as the tiny machines get to work and your cuts and bruises quickly mend and heal over.";
			txt += "\n\nWhen she does all she can for you, [goo.name] retracts her tendril and returns to meet you face to face, then gives you a light peck on the forehead. <i>“";
			txt += RandomInCollection([
				"Remember to be more careful out there, okay?",
				"Don’t get yourself hurt again!",
				"I hope that helps!"
			]);
			txt += "”</i>";
			
			processTime(3 + rand (2));
			pc.HP(50 * flags["GOO_ARMOR_HEAL_LEVEL"]);
			pc.createStatusEffect("Goo Armor Healed", 0, 0, 0, 0, true, "", "", false, 60, 0xFFFFFF);
			
			// Defense Debuff
			if(!pc.hasStatusEffect("Goo Armor Defense Drain"))
			{
				pc.createStatusEffect("Goo Armor Defense Drain", 2, 0, 0, 0, false, "DefenseDown", "Using " + chars["GOO"].short + "’s healing ability has left her in a weaker state than normal.", false, 1440, 0xFFFFFF);
				gooArmorDefense(-2);
				txt += "\n\nYou notice that asking [goo.name] to heal you takes its toll on her strength, temporarily weakening her just a bit.";
			}
			else
			{
				pc.setStatusMinutes("Goo Armor Defense Drain", 1440);
				pc.addStatusValue("Goo Armor Defense Drain", 1, 2);
				gooArmorDefense(-2);
				txt += "\n\nYou feel [goo.name]’s strength being sapped again. You should be careful not to over-do it...";
			}
			
			gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "stay":
			showGrayGooArmor();
			
			txt += "You ask [goo.name] to stay on your ship as a crewmember.";
			if(pc.armor is GooArmor)
			{
				txt += "\n\nThe goo-girl looks at you in the eyes, sliding her bottom half around your [pc.lowerBody] a bit. <i>“Aww, really?”</i>";
				txt += "\n\nYou " + (pc.isAss() ? "half-grimace and point to the storage box, signaling to her the alternative" : "nod, telling her to make herself at home") + ".";
				txt += "\n\nShe anxiously bites her silvery lower lip, obviously nervous about leaving you. <i>“Okay, if that’s what you want... then I’ll man the ship for you when you’re, like, away and stuff!”</i> Then she leans in for a hug. <i>“Just promise me you’ll be extra careful out there, okay?”</i>";
				txt += "\n\nWith that, she loosens her embrace, arches her back, and leaps off your body towards the air. Her amorphous mass streams to the ground in a parabolic fashion, flattening into a silver puddle, then reforms itself from it. When she fully emerges, something shiny catches her attention and she is happily [goo.moving] off in its direction.";
			}
			else
			{
				txt += "\n\nThe goo-girl melts in place, obviously disappointed in the request. <i>“Are ya sure about that?”</i>";
				txt += "\n\nYou " + (pc.isNice() ? "tell her you’re sure and that she’ll be safer if she stays on the ship" : "nonchalantly ask her if she’d rather stay in storage instead") + ".";
				txt += "\n\nIn response, she fully emerges from her silver puddle, facing away from you, bends forward a little and shakes her curvy hips and jiggly buttcheeks teasingly in your direction. Turning around, she gives you a puckered face of indignation. <i>“Fine, but like, don’t get yourself hurt and stuff because I’m not there to help you.”</i> Her face relaxes and she give you a smile. <i>“I’ll be here when you get back, okay?”</i>";
				txt += "\n\nYou " + (pc.isBimbo() ? "give a light giggle" : "exhale a chuckle") + ", then ruffle her gooey, silver hair. She’s such a loyal " + (pc.isNice() ? "friend" : "companion") + ".";
			}
			txt += "\n\n(<b>[goo.name] has joined your crew!</b>)";
			txt += "\n\n";
			
			processTime(1);
			break;
		case "take":
			showGrayGooArmor();
			
			if(!pc.hasArmor())
			{
				if(silly && pc.isBimbo() && pc.hasBreasts())
				{
					txt += "With a serious face, you look at your gooey friend and command, <i>“" + chars["GOO"].short.toUpperCase() + ", GRAB MY BOOBS.”</i>";
					txt += "\n\nShe takes her hand and places it on your right-most breast, then squeezes. <i>HONK!</i>";
					txt += "\n\nIn sync, you both chorus the word, <i>“ADVENTURE...!”</i>";
					txt += "\n\nThe console monitors around you flicker different colors to simulate a discothèque-like rainbow for added emphasis. [goo.name] quickly engulfs herself around your body, changing into your fitted armor, then popping her top half out to meet you as the light show finally stops and everything returns to normal.";
					txt += "\n\nThe two of you look at each other for a good few seconds, then burst into high-pitched giggles.";
				}
				else
				{
					txt += "You ask [goo.name] if she would be interested in joining you.";
					txt += "\n\nHer eyes light up. <i>“Like, of course, bestest buddy!”</i> She leaps up on the spot and spreads herself out wide, only to engulf your body with her mass, giving you a big squishy, gooey hug - even taking some extra motions to rub and grope you in more sensitive areas. She quickly reforms herself into the suit you normally wear her as, then she pops her upper body from you and you can see the overjoyed look on her face. <i>“So, where are we off to next? I’m, like, totally ready for the next adventure!”</i>";
				}
				pc.lust(5);
			}
			else
			{
				txt += "You ask [goo.name] if she would be interested in joining you as you open your inventory to make room for her.";
				txt += "\n\nHer face brightens as she turns to you. <i>“Oh, yay!”</i> She leaps up on the spot and gives you a great big, gooey hug. <i>“Like, I’m ready when you are! Just let me know when you’re heading out, okay?”</i>";
			}
			txt += "\n\n(<b>[goo.name] is no longer on your crew. You are now";
			if(!pc.hasArmor()) txt += " wearing her as your armor";
			else txt += " carrying her along with you";
			txt += ".</b>)";
			txt += "\n\n";
			
			processTime(1);
			break;
		case "leave":
			showGrayGooArmor();
			
			if(gooArmorIsCrew())
			{
				txt += "You decide to let [goo.name] do her thing and tell her that you’re going to tend to some other things.";
				txt += "\n\n<i>“Aye-aye, Captain!”</i> she says with her chest out in a sturdy salute.";
			}
			else
			{
				if(exitMain) txt += "[goo.name] smiles as she";
				else txt += "<i>“Aww, okay!”</i> [goo.name] says as she";
				if(pc.armor is GooArmor)
				{
					txt += " wraps herself around your body and adopting her armor-like appearance, shuffling a bit in your sensitive areas to make sure she’s got you covered where it matters.";
					pc.lust(2 + rand(4));
				}
				else txt += " gives you a quick hug before reforming herself back into your inventory head-first, struggling a bit before finally squeezing in her wide rump with a slick <i>plop!</i>";
			}
			
			processTime(1);
			
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", mainGameMenu);
			else if(!fromCrew) gooArmorAddButton(fromCrew, 0, "Next", backToAppearance, pc);
			else gooArmorAddButton(fromCrew, 0, "Next", crew);
			break;
		default:
			if(fromCrew) crew();
			else backToAppearance(pc);
			break;
	}
	
	gooArmorOutput(fromCrew, txt);
	
	// Item handling.
	switch(response)
	{
		case "stay":
			// Give goo armor to Nova.
			if(pc.armor is GooArmor)
			{
				goo.armor = pc.armor;
				pc.armor = new EmptySlot();
			}
			else
			{
				var getArmor:ItemSlotClass = new GooeyCoverings();
				getArmor.defense = 2;
				getArmor.hasRandomProperties = true;
				
				for(var i:int = 0; i < pc.inventory.length; i++)
				{
					if(pc.inventory[i].shortName == "Goo Armor")
					{
						getArmor = pc.inventory[i];
						pc.inventory.splice(i, 1);
					}
				}
				goo.armor = getArmor;
			}
			
			flags["GOO_ARMOR_ON_SHIP"] = true;
			
			gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "take":
			// Get the goo armor.
			var newArmor:ItemSlotClass = goo.armor;
			
			// Swap Nova armor back to old armor.
			goo.armor = new GooeyCoverings();
			goo.armor.defense = 2;
			goo.armor.hasRandomProperties = true;
			
			// Reclaim goo armor.
			if(!pc.hasArmor()) pc.armor = newArmor;
			else quickLoot(newArmor);
			
			flags["GOO_ARMOR_ON_SHIP"] = undefined;
			
			gooArmorClearMenu(fromCrew);
			gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
	}
}
public function gooArmorCrewTalk(arg:Array):void
{
	var response:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var exitMain:Boolean = (arg.length > 2 ? arg[2] : false);
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	gooArmorClearMenu(fromCrew);
	
	switch(response)
	{
		case "morph 0":
			showBust("GRAY_GOO_PRIME");
			
			txt += "You inch towards her little by little and place your hand on her shoulder. She quickly turns around to face you.";
			txt += "\n\n<i>“Oh, hello. Nice to see you... [pc.fullName]?”</i> [goo.name] looks at you but with a different yet familiar face. She has adopted the appearance of Victoria Morrow";
			if(flags["GRAYGOO_SPESS_SKYPE"] != undefined) txt += ", just like the night you witnessed her chatting with the Captain herself";
			txt += "... Her speech inflections seem much more reserved and less bubbly than usual. <i>“Are you looking for someone?”</i>";
			txt += "\n\n<i>“U" + (pc.isBimbo() ? "mmmmmmmmm" : "h") + "... you?”</i> you respond.";
			txt += "\n\nLooking at your reaction, [goo.name] suppresses a soft giggle with one hand to maintain her modesty. <i>“I’m sorry, I’m afraid you are mistaken. Who is this ‘[goo.name]’? A stowaway, perhaps?”</i> Her eyes scan yours. <i>“I can try helping you look for her--we take lost persons cases quite seriously on the </i>NOVA<i>.”</i>";
			txt += "\n\n<i>“" + (pc.isAss() ? "Listen, I don’t ha--" : "Hm, are y--") + "...”</i> You reconsider your answer. Clearly she is role playing with you, so you might as well play along...";
			if(pc.isBimbo()) txt += " <i>“Oh yaaah, that’s right. My B.F.F. has, like, totally disappeared on me. We were supposed to go get ice cream, catch a movie, and have the bestest girls’-night-out ever... But I can’t find her anywhere! I was going to surprise her with something super-duper sexy afterwards, but I guess I gotta, like, hold off on it and stuff...”</i>";
			else if(pc.isAss() || pc.isMischievous()) txt += " <i>“You’re damn right, woman--There’s a stowaway on board and we need to kick her out before she starts a mutiny up in here. Perhaps you’ve seen her. She has a big perky face, huuuge tits - as big as her head! - and a butt that won’t stop jiggling. Oh, and she’s some kind of meta-morphing, shape-shifting mutant, so she could be anyone... I bet she could even control minds!”</i>";
			else txt += " <i>“Captain Morrow, thank goodness I found you! My... my friend, she’s gone missing and I don’t know where to find her!”</i> You wipe the imaginary sweat from your forehead. <i>“One moment, she was with me; the next moment, gone. I think the snatchers might have gotten to her. I mean, I know it’s probably just an urban legend, but I’m worried. What if... what if snatchers are real? I need to find her before it’s too late!”</i>";
			txt += "\n\n<i>“Oh my...”</i> ‘Captain Morrow’ gasps, her eyes wide and brows tilted in deep concern. <i>“We must find her quick!”</i>";
			txt += "\n\nThe two of you spend a small moment opening compartments, looking under shelves, and flipping through security cam channels but can’t ‘find’ signs of [goo.name] anywhere.";
			txt += "\n\nAfter exhausting all methods of search, Morrow drops to her knees.";
			if(pc.isBimbo()) txt += "\n\n<i>“Oh no... She’s totally going to miss out.”</i> You scrunch your face and pout your lips, acting as if you are about to cry.";
			else if(pc.isAss() || pc.isMischievous()) txt += "\n\n<i>“She’s probably got to them. All of them. This ship’s been compromised!”</i> Your face turns into an angry scowl of defeat, exaggerated to make sure she can read it.";
			else txt += "\n\n<i>“She’s... she’s gone.”</i> You cover your face with your hands, preparing to go into full sobbing mode with an imaginary waterfall of tears.";
			txt += "\n\nMorrow’s silvery face begins to break character and she is convinced so much by you that she really believes what you’re saying. Suddenly, she springs onto you with a gooey hug, practically squeezing the life out of you, her legs melting and pooling around your body to add to the embrace.";
			txt += "\n\n<i>“Here I am! Look! See?”</i> Easing her glomp attack, she lifts her head and looks honestly into your eyes. Her face quickly contorts and smoothly shifts back to her [goo.name]-face. <i>“It’s me!”</i>";
			
			processTime(32);
			gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["morph 1", fromCrew, exitMain]);
			break;
		case "morph 1":
			txt += "With the reappearance of [goo.name], you " + (pc.isAss() ? "pat her off you and wince" : "return the hug and give her a smile") + ". Her morphing herself like that gives you an idea. Curious, you ask about her ability to hold different shapes and if she would be willing to change into anything you ask.";
			txt += "\n\n<i>“Sure thing, [pc.name]!”</i> she exclaims as she swirls off your body to face you standing. <i>“Buuut, I might have trouble remembering different forms if you ask for too much. I think Captain Morrow is super pretty, but I really like how I look right now!”</i> She gives you a wink. <i>“And I don’t mind if you ask me to change, okay?”</i>";
			txt += "\n\nYou nod, then ask her if she can do the same when you are wearing her.";
			txt += "\n\n<i>“Mmm... that’s a bit harder, but I can try!”</i> she says pondering. <i>“When you wear me, I just kinda cover everything to make sure I stay on and stuff. I’m afraid, if I change into something else for a long period of time, I might fall off and get lost!”</i>";
			txt += "\n\nYou take a moment to think, then ask: if you brought her an outfit, if she would be willing to duplicate its shape like she did Victoria’s shape.";
			txt += "\n\n<i>“Ooo... I see. Then, if you really want something specific, like a covering for your face or an opening for your butt, gimme something that fits you and I’ll try to copy it!”</i>";
			txt += "\n\n" + (pc.isBimbo() ? "Neat! Y" : "Cool, y") + "ou’ll try to remember that for next time.";
			txt += "\n\n<b>You can now Customize [goo.name]’s appearance!</b>";
			
			flags["GOO_ARMOR_CUSTOMIZE"] = 0;
			processTime(3);
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
			else gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "swimsuit 0":
			txt += "The goo-girl dips the tip of her toe into the water and quickly retracts back. <i>“Oooh, cold!”</i> The sensitivity in her temperature sensors must be turned up, you note. When she sees you enjoying the water, she huffs her worries away. Not wanting to be left out, she takes a few steps back... then makes a dash towards the pool and jumps straight into the air. <i>“CANNONBALL!”</i>";
			txt += "\n\nShe morphs herself into an actual ball shape and shifts her mass to crash right down into the water. Though she safely lands a few feet away from you, the magnitude of the splash is so great, it lifts you up off your [pc.feet]. When you";
			if(pc.hasFeet()) txt += " find your footing and";
			txt += " touch the pool bottom again, your silver friend surfaces next to you, remorphed back into her bikini-clad self.";
			txt += "\n\n<i>“Ahhh... This really is nice, isn’t it, [pc.name]?”</i> she coos. When she turns to you she finds you completely soaked... and you haven’t even started swimming yet! <i>“Oops! I totally over-did it, didn’t I?”</i>";
			txt += "\n\nYou answer her question by sweeping your arms from behind you and letting loose two handfuls of cool water right at her face, payback for the drenching she gave you.";
			txt += "\n\n<i>“Ack!”</i> she squeaks, then lets out a joyful giggle and splashes back.";
			txt += "\n\nThe two of you splash-fight for a bit, which eventually leads to some friendly, competitive swimming. When you are all swimmed out, you take some time to relax with [goo.name] and chat a little. She talks about all the different swimsuits she’s seen so far and the ones she likes the most. She also offers <i>be</i> your swimsuit if you ever need one. That definitely would come in handy, you think.";
			txt += "\n\nStepping out of the pool, you approach the shower to rinse yourself off. However, all [goo.name] does is shake like a wet ausar and she is instantly dry, also having reshaped back to her previous form. Before you can get to your gear and dry yourself, you feel two big smacks, one on each of your [pc.butts]. Arching your back in surprise, you turn around to find [goo.name], her hands behind her, looking at you and smiling innocently. She’s so naughty!";
			txt += "\n\n<b>[goo.name] has learned how to change into swimwear!</b>";
			
			flags["GOO_ARMOR_SWIMSUIT"] = 1;
			processTime(45);
			pc.energy(30);
			pc.shower();
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
			else gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "helmet 0":
			txt += "<i>“So, does it" + (pc.isBimbo() ? ", like," : "") + " work?”</i> you ask surveying her new headwear.";
			txt += "\n\n<i>“Of course it does!”</i> she says, overconfidently and slightly dampened. <i>“Why wouldn’t--...”</i> Her voice cuts off.";
			txt += "\n\n" + (pc.isBimbo() ? "Uh-oh" : "Oh no") + ". What’s happening?";
			txt += "\n\n[goo.name]’s face shows signs of panic as she struggles to loosen her gooey collar, but to no effect. Like a fish gasping for air, her mouth gapes and closes over and over, yet no sound comes from her helmet.";
			txt += "\n\nGoodness, she needs air, quick! This was a stupid idea. But you have no clue how help the poor girl besides shouting, <i>“[goo.name]! Take it off! Take it off!”</i>";
			txt += "\n\nShe can’t hear you. She falls to her [goo.knees] and futilely smacks the floor a few times before finally looking up at you. Her eyes are wide with desperation. She crawls towards you, climbs your torso, and deperately clings to your shoulders. You hold onto her for support.";
			txt += "\n\nHer gaze softens as she seems to take in her last breaths of air.";
			txt += "\n\nHer eyelids slowly fall... then close.";
			txt += "\n\n.....";
			txt += "\n\nWith her still body in your arms, you look away.";
			txt += "\n\n";
			
			processTime(5);
			gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewTalk, ["helmet 1", fromCrew, exitMain]);
			break;
		case "helmet 1":
			txt += "A sudden woosh of air hits your face and you reflexively turn back to meet an unhelmeted [goo.name]... Whose silver-gray face is staring back at you, wearing an incredibly wide smile.";
			txt += "\n\n<i>“Just kidding!”</i> she squeaks.";
			txt += "\n\nWhat. She was totally miming the whole time. She had you worried!";
			txt += "\n\n<i>“I don’t need to breathe, silly!”</i> she giggles, sliding off you. She stands and experimentally reforms and pops her new bubble helmet a few times, toggling it on and off like testing a freshly-installed light switch.";
			txt += "\n\nWell it looks like she’s picked up an extra ability now, though you hope she’ll take <i>your</i> ability to breathe into consideration when she combines it with the suit....";
			txt += "\n\n<b>[goo.name] has learned how to create a helmet!</b>";
			
			flags["GOO_ARMOR_CUSTOMIZE"] = 1;
			processTime(2);
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
			else gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "expose 0":
			txt += "9999 - Text.";
			txt += "\n\n9999 - Text.";
			txt += "\n\n<b>[goo.name] has learned how to make exposed armor</b>--although it may come with some minor drawbacks!";
			
			flags["GOO_ARMOR_CUSTOMIZE"] = 2;
			processTime(2);
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
			else gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
		case "healing 0":
			txt += "Your sight quickly returns and you find yourself clutched in [goo.name]’s silvery mass.";
			txt += "\n\n<i>“[pc.name]... are you okay?”</i>";
			txt += "\n\nYou hope so. You don’t feel any pain, so the fall must have not been major. You run your hand across your [pc.face] just to make sure. No odd bumps on your forehead. Eyes, still intact. Nose, not dislocated. And--! You suck in a long string of air through your teeth. The pain, it stings. Your lower lip, you must have busted it falling down.";
			txt += "\n\n<i>“Oh no, you’re bleeding!”</i> [goo.name] lightly panics.";
			txt += "\n\nMaking sure not to cause another potential accident, you ask her to calm down a bit and tell her where the first-aid kit is on your ship.";
			txt += "\n\n<i>“Oooh, poor thing...”</i> She ignores you, too invested in examining your wound.";
			txt += "\n\nAs she rubs your [pc.lips], you feel a distinct tingle - not of pain, but a cooling sensation... Wait a minute...";
			txt += "\n\nAs the feeling evaporates, you gently remove [goo.name]’s hand and (carefully) run to the restroom, leaving your silver-gray companion to tilt her head in confusion. You splash your face in water and view yourself in the mirror. No cut, no scars. Your lower lip has fully healed and that was a fresh wound only a minute ago! You towel off and return to [goo.name].";
			txt += "\n\nLooking up at you, she scans your bloodless face and happily gasps. <i>“You’re okay!”</i> She lauches herself into you with a big gooey hug.";
			txt += "\n\nYou tell her of what she drank and how it possibly granted her microbots a new ability. Seeing this as good news, and knowing that you are fine, makes her hug even tighter.";
			txt += "\n\n<i>“S-so I’m not in trouble, am I?”</i> she asks, concerned, while loosening her squeeze.";
			txt += "\n\nYou ruffle her slimey silver hair.";
			txt += "\n\n<b>[goo.name] has learned how to heal minor injuries!</b>";
			
			processTime(15);
			flags["GOO_ARMOR_HEAL_LEVEL"] = 1;
			
			for(var i:int = 0; i < 10; i++)
			{
				pc.destroyItem(new GrayMicrobots());
			}
			pc.HP(10);
			
			if(exitMain) gooArmorAddButton(fromCrew, 0, "Next", gooArmorCrewOption, ["leave", fromCrew, exitMain]);
			else gooArmorAddButton(fromCrew, 0, "Next", approachGooArmorCrew, [false, fromCrew]);
			break;
	}
	
	gooArmorOutput(fromCrew, txt);
}
public function gooArmorChangeBody(arg:Array):void
{
	var newStyle:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	
	if(newStyle == "back")
	{
		txt += "On second thought, you refrain from suggesting anything new to [goo.name]’s appearance.";
		txt += "\n\n<i>“Holding out on me, aren’t ya?”</i> she teases, wagging her pointed hand and cusping her hip with the other. <i>“Well, if you want me to doll up, just ask okay?”</i>";
	}
	else
	{
		switch(newStyle)
		{
			case "null":
				txt += "You suggest that [goo.name] change herself back to her normal form.";
				txt += "\n\n<i>“Mmm, my preferred look!”</i> The goo girl lightly giggles and begins her transformation. She does not simply change her form--rather she gives you a sultry wink, inviting you to see each shift in her shape. Tendrils of silver-gray goo dance around her as the surface of her amorphous skin ripples. Her mass sinks inwards only to blossom back out into a hyperfeminine silhouette. She traces her gooey hands across her body, making a show of it. Hypnotized, you watch every change she makes.";
				if(chars["GOO"].legCount != 1) txt += " The tendrils swirl around her lower body, her [goo.legs] melding together into one, making her appear to be sitting on a flower bulb before resting into a recognizable goo base.";
				txt += " Her wavy hair, plump lips and generous curves make her appear like some kind of silvery goddess with the way the light bounces off her form. As her";
				if(chars["GOO"].legCount == 1) txt += " swirling";
				else txt += " gooey";
				txt += " tendrils relax back into her body, she gives her ass a loud smack, breaking you from your entranced daze. <i>“You like this form better, right?”</i>";
				txt += "\n\nYou take a moment to soak in her new look.";
				chars["GOO"].legCount = 1;
				chars["GOO"].legType = GLOBAL.TYPE_GOOEY;
				chars["GOO"].legFlags = [GLOBAL.FLAG_AMORPHOUS];
				pc.lust(5);
				break;
			case "loose":
				txt += "You suggest that [goo.name] change herself into the shape of her natural element: the gray goo of Tarkus.";
				txt += "\n\n<i>“Okay, just for you!”</i> The goo girl responds. Starting from the top of her head downwards, she begins to melt. Her hair, her eyes and face, her body... it would be pretty creepy-looking if she weren’t already a silver blob of goo, though. Her slow melting subsides when she becomes a puddle on the floor. She stays that way for a while, making you curious if that is her final form, but just as you tip over to peek, the gray puddle comes to life! It bubbles and shakes as a form begins to acsend from it. You can hear [goo.name] vocalize some heavy breathing as she emerges from her tiny lake, trying to be intimidating. Her form, as curvy as ever, drips with flowing liquid microbots, dropping off her into the lake only to be recycled back into her body as her lower body completes its formation. Her arms are poised in a sinister fashion, fingers tickling the air. Her face wears a menacing smile as she “err”s and “raw”s.";
				txt += "\n\nYou shake your head in this girl’s attempt at being monstrous.";
				txt += "\n\n<i>“Just kidding!”</i> she says, breaking character. <i>“Ee-hee... I hope no one confuses me for being a hostile goo though!”</i>";
				txt += "\n\nYou take a moment to review her new look.";
				chars["GOO"].legCount = 1;
				chars["GOO"].legType = GLOBAL.TYPE_GOOEY;
				chars["GOO"].legFlags = [GLOBAL.FLAG_AMORPHOUS];
				break;
			case "ponytail":
				txt += "You suggest that [goo.name] change herself to look more like Captain Victoria Morrow.";
				txt += "\n\n<i>“Like, you want me to look more like " + (chars["GOO"].short.toLowerCase() == "nova" ? "Victoria" : "Nova") + "?”</i> The goo girl attempts her best imitation by covering her mouth with one hand and giving a soft, modest giggle. Her shapeshifting begins at her head, reforming the look of her eyes, lips, cheeks and hair until she appears like a mirror reflection of Captain Morrow herself. The changing wave of goo slides down the rest of her body like a thick condom ring down the longitudinal plane of a penis shaft. Her mass makes her limbs a bit more defined, yet smooth and lean.";
				if(chars["GOO"].legCount != 2) txt += " By the time the wave reaches to the floor below her, her lower body has shifted into a pair of smooth, shapely legs, capped off with comfy-looking shoes. Looking back up, h";
				else txt += " H";
				txt += "er body seems to have formed a kind of tight spacer uniform, each shoulder bearing a Bell-Isle/Grunmann patch. The outfit is wide open, letting her still bouncy tits and crotch display openly in the air.";
				txt += "\n\n<i>“Oops!”</i> [goo.name] squeaks as she notices her lewd exposure and tries to adopt a more conservative look. A tiny “zipper handle” appears below her pussy and proceeds to close up her silver gray-colored uniform, covering the naked areas in its path--traveling from the bulge of her camel toe, sliding across her navel, and stops just below her now half-covered tits. It struggles a bit, making the tightly-compressed muffin-top of breast flesh quake in response. With a cute huff, the goo exhales and the zipper wins the battle, shooting up her cleavage and sealing the round chest globes in a taut encasing, slowing its journey at the base of the neck collar. With that, she looks at you and smiles, trying hard to get into character. <i>“So who’s the " + (crew(true) > 0 ? "crew" : "ship") + "’s captain now?”</i>";
				txt += "\n\nYou take a moment to admire her new look.";
				chars["GOO"].legCount = 2;
				chars["GOO"].legType = GLOBAL.TYPE_GOOEY;
				chars["GOO"].legFlags = [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_SMOOTH, GLOBAL.FLAG_GOOEY];
				break;
		}
		chars["GOO"].hairStyle = newStyle;
		txt += "\n\nAfter she finishes her transformation, she spins and gives you a full turn-around demonstration. <i>“How’s this look?”</i> Regardless of her new form, there is still some jiggle in her step. It looks like while she can change minute details in her appearance, she can’t completely escape her bouncy bimbo-like body!";
		
		processTime(5);
	}
	
	showGrayGooArmor();
	gooArmorOutput(fromCrew, txt);
	
	approachGooArmorCrewMenu(fromCrew);
}
public function gooArmorDetails():String
{
	var msg:String = "";
	
	// Status: "Goo Armor Design"
	// v1: armor type
	// v2: armor patterns
	// v3: helmet type
	// v4: N/A
	// tooltip: emblem design
	pc.createStatusEffect("Goo Armor Design", 0, 0, 0, 0, true, "", "none", false, 0, 0xFFFFFF);
	
	msg += "Your suit of armor is silvery-gray";
	switch(pc.statusEffectv1("Goo Armor Design"))
	{
		case 1: msg += ", with hints of armor-like protrusions"; break;
		case 2: msg += ", with large sections of armor-like pieces"; break;
		case 3: msg += ", with a simulated surface of folded cloth"; break;
		case 4: msg += ", with an appearance of smooth, tight latex"; break;
		case 5: msg += ", shaped into your favorite-style swimwear"; break;
	}
	if(pc.getStatusTooltip("Goo Armor Design") != "" && pc.getStatusTooltip("Goo Armor Design") != "none")
	{
		msg += " and has " + indefiniteArticle(pc.getStatusTooltip("Goo Armor Design")) + " emblazoned on each shoulder";
	}
	msg += ".";
	switch(pc.statusEffectv2("Goo Armor Design"))
	{
		case 1: msg += " Across the surface, the suit is patterned with a grid of hexagonal tiles."; break;
		case 2: msg += " There is a distinct glistening silver trim bordering the edges."; break;
		case 3: msg += " Lines of shining silver trace the surface in a design very similar to a printed circuit board."; break;
		case 4: msg += " Portions of the suit are accentuated in linear markings, traveling " + (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR) ? "across different anatomical seams" : "from the arms and neck downward") + "."; break;
	}
	if(pc.armor.resistances.hasFlag(DamageFlag.MIRRORED))
	{
		if(pc.statusEffectv1("Goo Armor Design") != 0 || pc.statusEffectv2("Goo Armor Design") != 0) msg += " Overall, it";
		else msg += " It";
		msg += " has a crystalline shine to it, adopted from an encounter with a ganrael.";
	}
	if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) && !pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) && !pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) && !pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS))
	{
		if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
		{
			msg += " The outfit itself is completely closed, much like a body suit should be";
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				switch(pc.statusEffectv3("Goo Armor Design"))
				{
					case 1: msg += " and is topped with a fashionable helmet that fits snugly around your head"; break;
					case 2: msg += " and is topped with an intimidating-looking pressure helmet that protects your head from harm"; break;
					case 3: msg += " and is topped with a bubble-shaped space helmet that covers the entirety of your head"; break;
					case 4: msg += " and is topped with a smoothly-mirrored, featureless helmet that shrouds your visage in mystery"; break;
				}
			}
			msg += ".";
		}
	}
	else
	{
		msg += " Unlike a " + (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR) ? "proper swim" : "full body ") + "suit, your outfit leaves your";
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) msg += " " + (pc.hasBreasts() ? "tits" : "chest") + ", " + (rand(2) == 0 ? "groin" : "crotch") + " and " + (rand(2) == 0 ? "ass" : "butt") + (rand(2) == 0 ? "hole" : " cheeks");
		else
		{
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST))
			{
				msg += " " + (pc.hasBreasts() ? "tits" : "chest");
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) msg += ",";
				else if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) msg += " and";
			}
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN))
			{
				msg += " " + (rand(2) == 0 ? "groin" : "crotch");
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) msg += " and";
			}
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) msg += " " + (rand(2) == 0 ? "ass" : "butt") + (rand(2) == 0 ? "hole" : " cheeks");
		}
		msg += " exposed to the elements";
		if
		(	((pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && pc.upperUndergarment.shortName != "")
		||	((pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && pc.lowerUndergarment.shortName != "")
		)
		{
			msg += "--that is, if not for the";
			if((pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && pc.upperUndergarment.shortName != "")
			{
				msg += " [pc.upperUndergarment]";
				if( pc.lowerUndergarment.shortName != "") msg += " and";
			}
			if((pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && pc.lowerUndergarment.shortName != "") msg += " [pc.lowerUndergarment]";
			msg += " you are wearing underneath";
		}
		msg += ".";
	}
	
	return msg;
}
public function gooArmorChangeArmorMenu(fromCrew:Boolean = true):void
{
	gooArmorClearMenu(fromCrew);
	
	if(pc.statusEffectv1("Goo Armor Design") == 0)
		gooArmorAddButton(fromCrew, 0, "Style", gooArmorChangeDesign, ["style", fromCrew], "Create Style", "Ask to define the style of the suit.");
	else
		gooArmorAddButton(fromCrew, 0, "Style", gooArmorChangeDesign, ["style", fromCrew], "Change Style", "Ask to change the style of the suit.");
	if(pc.statusEffectv2("Goo Armor Design") == 0)
		gooArmorAddButton(fromCrew, 1, "Pattern", gooArmorChangeDesign, ["pattern", fromCrew], "Create Pattern", "Ask to define the pattern on the suit.");
	else
		gooArmorAddButton(fromCrew, 1, "Pattern", gooArmorChangeDesign, ["pattern", fromCrew], "Change Pattern", "Ask to change the pattern on the suit.");
	if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
		gooArmorAddDisabledButton(fromCrew, 2, "Emblem", "Emblem", "Your suit does not have shoulder coverings to apply an emblem to.");
	else if(pc.getStatusTooltip("Goo Armor Design") == "" || pc.getStatusTooltip("Goo Armor Design") == "none")
		gooArmorAddButton(fromCrew, 2, "Emblem", gooArmorChangeDesign, ["emblem", fromCrew], "Create Emblem", "Ask to display an emblem on the suit.");
	else
		gooArmorAddButton(fromCrew, 2, "Emblem", gooArmorChangeDesign, ["emblem", fromCrew], "Change Emblem", "Ask to change the emblem on the suit.");
	if(flags["GOO_ARMOR_CUSTOMIZE"] >= 1)
	{
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
			gooArmorAddDisabledButton(fromCrew, 3, "Helmet", "Helmet", "Your suit cannot acquire a helmet while being a swimsuit" + (silly ? "--that’s unfashionable!" : "."));
		else if(pc.statusEffectv3("Goo Armor Design") == 0)
			gooArmorAddButton(fromCrew, 3, "Helmet", gooArmorChangeDesign, ["helmet", fromCrew], "Create Helmet", "Ask to create a helmet for the suit.");
		else
			gooArmorAddButton(fromCrew, 3, "Helmet", gooArmorChangeDesign, ["helmet", fromCrew], "Change Helmet", "Ask to change the suit’s helmet design.");
	}
	else gooArmorAddDisabledButton(fromCrew, 3, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 5 ? " She may be more confident if you are a higher level." : " Maybe try talking to her while" + (InShipInterior() ? "" : " in your ship and") + " wearing an airtight suit?"));
	
	if(flags["GOO_ARMOR_CUSTOMIZE"] == undefined || flags["GOO_ARMOR_CUSTOMIZE"] < 2)
	{
		gooArmorAddDisabledButton(fromCrew, 5, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 9 ? " She may be more confident if you are a higher level." : " Maybe try talking to her while" + (InShipInterior() ? "" : " in your ship and") + " wearing something exposing your chest?"));
		gooArmorAddDisabledButton(fromCrew, 6, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 9 ? " She may be more confident if you are a higher level." : " Maybe try talking to her while" + (InShipInterior() ? "" : " in your ship and") + " wearing something exposing your crotch?"));
		gooArmorAddDisabledButton(fromCrew, 7, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 9 ? " She may be more confident if you are a higher level." : " Maybe try talking to her while" + (InShipInterior() ? "" : " in your ship and") + " wearing something exposing your ass?"));
	}
	else
	{
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			gooArmorAddButton(fromCrew, 5, "Chest", gooArmorChangeArmor, ["chest", fromCrew], "Cover Chest", "Ask to modify the suit to cover your chest.");
		else
		{
			if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, 5, "Chest", "Expose Chest", "[goo.name] does not have enough armor to do this!");
			else gooArmorAddButton(fromCrew, 5, "Chest", gooArmorChangeArmor, ["chest", fromCrew], "Expose Chest", "Ask to modify the suit to expose your chest.");
		}
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			gooArmorAddButton(fromCrew, 6, "Crotch", gooArmorChangeArmor, ["crotch", fromCrew], "Cover Crotch", "Ask to modify the suit to cover your crotch.");
		else
		{
			if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, 6, "Crotch", "Expose Crotch", "[goo.name] does not have enough armor to do this!");
			else gooArmorAddButton(fromCrew, 6, "Crotch", gooArmorChangeArmor, ["crotch", fromCrew], "Expose Crotch", "Ask to modify the suit to expose your crotch.");
		}
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			gooArmorAddButton(fromCrew, 7, "Ass", gooArmorChangeArmor, ["ass", fromCrew], "Cover Ass", "Ask to modify the suit to cover your ass.");
		else
		{
			if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, 7, "Ass", "Expose Ass", "[goo.name] does not have enough armor to do this!");
			else gooArmorAddButton(fromCrew, 7, "Ass", gooArmorChangeArmor, ["ass", fromCrew], "Expose Ass", "Ask to modify the suit to expose your ass.");
		}
	}
	
	if(!gooArmorCheck()) gooArmorAddButton(fromCrew, 13, "Repair", gooArmorChangeArmor, ["repair", fromCrew], "Self Repair", "Something seem’s off about [goo.name]. Ask her to repair herself!");
	
	gooArmorAddButton(fromCrew, 14, "Finish", gooArmorChangeArmor, ["finish", fromCrew]);
}
// Checks goo armor status for repairs.
public function gooArmorCheck(repair:Boolean = false):Boolean
{
	if(!(pc.armor is GooArmor) || !pc.armor.hasRandomProperties) return true;
	
	// Make sure suit is in normal form first.
	if
	(	pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)
	||	pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR)
	||	pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)
	||	pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)
	) return true;
	
	// Make sure there isn't any active status effects affecting the armor's stats.
	if
	(	pc.hasStatusEffect("Reduced Goo")
	||	pc.hasStatusEffect("Goo Armor Defense Drain")
	) return true;
	
	// Base stats and upgrades:
	var baseDefense:Number = 6;
	var baseSexiness:Number = 5;
	// Ganrael
	if(hasGooArmorUpgrade("ganrael", false))
	{
		baseDefense += 2;
	}
	
	// To repair
	if(repair)
	{
		pc.armor.defense = baseDefense;
		pc.armor.sexiness = baseSexiness;
	}
	// To check
	if(pc.armor.defense == baseDefense && pc.armor.sexiness == baseSexiness) return true;
	return false;
}
// Checks and changes armor flags and stats accordingly for exposure.
public function gooArmorChangePart(part:String = "null", expose:Boolean = false):void
{
	if(!(pc.armor is GooArmor) || !pc.armor.hasRandomProperties) return;
	
	switch(part)
	{
		case "chest":
			if(!expose)
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST);
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
				{
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
					pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL);
				}
				pc.armor.defense += 2;
				pc.armor.sexiness -= 1;
			}
			else
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
				pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST);
				pc.armor.defense -= 2;
				pc.armor.sexiness += 1;
			}
			break;
		case "crotch":
			if(!expose)
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
				{
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST);
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
					pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL);
				}
				pc.armor.defense += 2;
				pc.armor.sexiness -= 1;
			}
			else
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
				pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				pc.armor.defense -= 2;
				pc.armor.sexiness += 1;
			}
			break;
		case "ass":
			if(!expose)
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
				{
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST);
					pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
					pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL);
				}
				pc.armor.defense += 2;
				pc.armor.sexiness -= 1;
			}
			else
			{
				pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
				pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				pc.armor.defense -= 2;
				pc.armor.sexiness += 1;
			}
			break;
	}
	
	// Convert expuser flags to full if all exist.
	if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS))
	{
		pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST);
		pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
		pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
		pc.armor.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL);
	}
	gooArmorCheckAirtight();
}
// Checks and changes armor flags and stats accordingly for swimwear.
public function gooArmorCheckSwimwear():String
{
	var msg:String = "";
	var swimwear:Boolean = pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR);
	var defToggle:Boolean = true;
	
	if(pc.statusEffectv1("Goo Armor Design") == 5)
	{
		pc.setStatusValue("Goo Armor Design", 3, 0);
		pc.setStatusTooltip("Goo Armor Design", "none");
		pc.armor.addFlag(GLOBAL.ITEM_FLAG_SWIMWEAR);
	}
	else
	{
		pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_SWIMWEAR);
	}
	
	if(swimwear != pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
	{
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
		{
			if(defToggle)
			{
				msg += "Having less coverage on your body lowers your suit’s armor rating a bit, but at least you can swim in it!";
				pc.armor.defense -= 2;
			}
		}
		else
		{
			if(defToggle)
			{
				msg += "No longer exposing your limbs to danger, your suit’s armor rating returns to normal.";
				pc.armor.defense += 2;
			}
		}
	}
	
	pc.armor.hasRandomProperties = true;
	
	return msg;
}
// Checks and changes armor flags and stats accordingly for helmet.
public function gooArmorCheckAirtight():String
{
	var msg:String = "";
	var airtight:Boolean = pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
	var defToggle:Boolean = true;
	
	// Airtight check
	if
	(	!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)
	&&	!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST)
	&&	!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN)
	&&	!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)
	&&	!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR)
	&&	pc.statusEffectv3("Goo Armor Design") > 0
	)
	{
		pc.armor.addFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
	}
	else
	{
		pc.armor.deleteFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
	}
	
	if(airtight != pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
	{
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
		{
			msg += "<b>Your suit is now airtight!</b>";
			if(defToggle)
			{
				msg += " However, the armor displaced to form a helmet will make your suit a little weaker in combat.";
				pc.armor.defense -= 2;
			}
		}
		else
		{
			msg += "<b>Your suit is no longer airtight!</b>";
			if(defToggle)
			{
				msg += " The exclusion of a helmet will make your suit more armored in combat now.";
				pc.armor.defense += 2;
			}
		}
	}
	
	pc.armor.hasRandomProperties = true;
	
	return msg;
}
public function gooArmorChangeArmor(arg:Array):void
{
	var toggle:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	if(toggle == "back")
	{
		txt += "You decide you don’t need anything adjusted on your suit just yet.";
		txt += "\n\n<i>“Okay, feel free to ask anytime!”</i> [goo.name] says as the mass of her lower body glides across yours.";
		gooArmorOutput(fromCrew, txt);
		
		gooArmorClearMenu(fromCrew);
		approachGooArmorCrewMenu(fromCrew);
		return;
	}
	if(toggle == "repair")
	{
		txt += "You feel something is off about your suit and let [goo.name] know about it.";
		txt += "\n\n<i>“Hm, that’s strange...”</i> she sounds, shifting herself around a few times.";
		txt += "\n\n<i>“I’m calculating the data now...”</i>";
		if(!gooArmorCheck())
		{
			txt += "\n\n<i>“Anomalies detected...”</i>";
			txt += "\n\n<i>“Repairing defects...”</i>";
			
			gooArmorCheck(true);
			processTime(5);
			
			txt += "\n\n<i>“... aaaand done!”</i>";
			txt += "\n\nWith that, you feel your armor is back to it’s normal self again. <i>“Thanks, [goo.name]!”</i>";
		}
		else
		{
			txt += "\n\n<i>“... No anomalies detected! No need for repairs, silly!”</i>";
			txt += "\n\nAh, it must have been a false alarm...";
		}
		
		gooArmorOutput(fromCrew, txt);
		processTime(2);
		
		gooArmorClearMenu(fromCrew);
		approachGooArmorCrewMenu(fromCrew);
		return;
	}
	if(toggle == "finish")
	{
		txt += "You give yourself a once over in the mirror, and when you see what you like you let the goo-girl know you’re finished.";
		txt += "\n\n<i>“Like, I made you look";
		if(pc.isChestExposed() || pc.isCrotchExposed() || pc.isAssExposed())
		{
			var tooLewd:Array = [];
			tooLewd.push(" so totally fucking hot right now!" + (pc.exhibitionism() < 33 ? " Think you’ll get used to showing off your body more?" : " You’re definitely my star exhibitionist!"));
			if(pc.isChestExposed()) tooLewd.push(" ready for some titfucking" + (pc.canTitFuck() ? "!" : "... well, if" + (pc.hasBreasts() ? " your boobs were big enough" : " you had tits") + " that is.") + " Just remember to share the goods when they come!");
			else tooLewd.push(" like such a tease. You can do with some more fucking, right?");
			
			txt += RandomInCollection(tooLewd);
		}
		else if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += "--huh. You do look a little weird wearing underwear underneath all that hot bod...";
		else if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST)) txt += ", uh--well you’d look better if you let your chest breathe a little!";
		else if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN)) txt += " like some kind of fetish superhero for underwear!";
		else if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) txt += " like--hm, you really want to protect your booty, don’t ya?";
		else
		{
			txt += " like a";
			if(pc.statusEffectv1("Goo Armor Design") == 2 || pc.statusEffectv3("Goo Armor Design") == 2) txt += " total badass";
			else if(pc.statusEffectv1("Goo Armor Design") == 1 || pc.statusEffectv2("Goo Armor Design") == 3 || pc.statusEffectv3("Goo Armor Design") == 3) txt += " totally cool space ace";
			else txt += "n awesome rusher";
			txt += " if I say so myself!";
		}
		txt += "”</i> your [pc.belly]--er, [goo.name] comments, gliding herself a bit more around you. She takes a moment to memorize the new shape and pops back out to meet you face to face.";
		
		gooArmorOutput(fromCrew, txt);
		processTime(1);
		
		gooArmorClearMenu(fromCrew);
		approachGooArmorCrewMenu(fromCrew);
		return;
	}
	
	var expose:Boolean = false;
	var airtight:Boolean = pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT);
	pc.armor.hasRandomProperties = true;
	
	txt += "As she shifts around your body, you feel the surface of your [pc.belly] tingle--and then a voice eminating from it.";
	
	switch(toggle)
	{
		case "chest":
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			{
				txt += "\n\n<i>“So, you want to cover your " + (pc.biggestTitSize() < 3 ? "chest" : "sisters") + ", huh?”</i> [goo.name] bellows from underneath you.";
				if(pc.biggestTitSize() < 3) txt += " With rapid efficiency, the silvery goo-girl gets to work and makes a protective layer of liquid microbots to cover your chest. <i>“All done!”</i> she says with an approving giggle.";
				else
				{
					txt += " The silvery goo-girl then gets to work and makes a protective layer of liquid microbots to cover your breasts.";
					if(pc.biggestTitSize() < 10) txt += " <i>“Nice and perky...”</i> She wraps herself around your tits with ease. <i>“Ever decide that you might wanna, like, y’know, go bigger? You’d look so much hotter!”</i> she comments after finishing her work.";
					else if(pc.biggestTitSize() < 30) txt += " <i>“Yes, just how I like ‘em, big and juicy!”</i> She joyfully engulfs your mammaries, covering every inch with glee. <i>“I’d gladly protect these knockers any day!”</i>";
					else if(pc.biggestTitSize() < 60) txt += " <i>“Oooh, so big! Come to mamma!”</i> She greedily hugs your mammaries with every inch of her mass as she can, spreading herself out for full effect. <i>“I hope that’s not too tight for ya!”</i>";
					else if(pc.biggestTitSize() < 120) txt += " <i>“Yeah, baby, it’s my lucky day! Just look at these chest pillows! Gimme! Gimme!”</i> She expands to meet your size and paints your tits in silver-gray. <i>“This is heaven!”</i>";
					else if(pc.biggestTitSize() < 240) txt += " Struggling to cover all your titflesh, she exclaims, <i>“[pc.name]! What have you done to your tits! Like, ohmygosh!”</i> Fortunately, she expands herself enough to cover all your sweater meat. <i>“Is there such a thing as too much boobage? Nope!”</i>";
					else txt += " <i>“I must, I must, I must cover this bust!”</i> she chants as she tries her best to engulf the vast surface area of each tit. <i>“This must be, like, a world record or something!" + (silly ? " Boy, you sure are taking the title to heart!" : " </i>Phew!<i>") + "”</i>";
					if(pc.bRows() == 2) txt += " She continues this for the next row until it is completely covered.";
					else if(pc.bRows() > 2) txt += " She continues this for the other rows until they are completely covered.";
				}
				txt += "\n\nThis makes you feel a little more protected now with the extra coverage, though the world will miss out on your [pc.chest].";
				txt += "\n\n<b>Your chest is now covered!</b>";
			}
			else
			{
				txt += "\n\n9999 - Text.";
				txt += "\n\nWith your [pc.chest] exposed, your sexual presence is more noticeable, but at the cost of some defense if you were to really get into trouble.";
				txt += "\n\n<b>Your chest is now exposed!</b>";
				expose = true;
			}
			break;
		case "crotch":
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			{
				txt += "\n\n9999 - Text.";
				txt += "\n\nNow that you’ve covered your";
				if(pc.hasGenitals() && pc.hasStatusEffect("Genital Slit") && pc.lust() < 33) txt += " genital slit";
				else txt += " [pc.crotch]";
				txt += ", you feel a little less defenseless.";
				txt += "\n\n<b>Your groin is now covered!</b>";
			}
			else
			{
				txt += "\n\n9999 - Text.";
				txt += "\n\nHaving your";
				if(pc.hasGenitals() && pc.hasStatusEffect("Genital Slit") && pc.lust() < 33) txt += " genital slit visible to the public";
				else txt += " [pc.crotch] bathe in the open air";
				txt += " will certainly increase your physical appeal, but that may prove troublesome if you are in a bind.";
				txt += "\n\n<b>Your groin is now exposed!</b>";
				expose = true;
			}
			break;
		case "ass":
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			{
				txt += "\n\n9999 - Text.";
				txt += "\n\nPatching up that area makes you feel protected, especially from incoming penetrative attacks.";
				txt += "\n\n<b>Your asshole is now covered!</b>";
			}
			else
			{
				txt += "\n\n9999 - Text.";
				txt += "\n\nWhile this allows others to admire your [pc.butts], it removes a significant amount of armor to do so, giving easier access to your " + (!silly ? "butthole" : "heinie-hole") + "!";
				txt += "\n\n<b>Your asshole is now exposed!</b>";
				expose = true;
			}
			break;
	}
	
	if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT) && expose) txt += " The exposure also claims your suit’s ability to be fully sealed.";
	
	gooArmorChangePart(toggle, expose);
	
	if(airtight != pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
	{
		if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) txt += " <b>Your suit is now airtight!</b>";
		else txt += " <b>Your suit is no longer airtight!</b>";
	}
	
	txt += "\n\n" + gooArmorDetails();
	gooArmorOutput(fromCrew, txt);
	
	processTime(2);
	gooArmorChangeArmorMenu(fromCrew);
}
public function gooArmorChangeDesign(arg:Array):void
{
	var toggle:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	var btn:Number = 0;
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	gooArmorClearMenu(fromCrew);
	
	switch(toggle)
	{
		case "style":
			txt += "<i>“" + (pc.statusEffectv1("Goo Armor Design") == 0 ? "Ah, looking for a specific style" : "So, what style would you like your suit to have") + "?”</i>";
			
			if(pc.statusEffectv1("Goo Armor Design") != 0) gooArmorAddButton(fromCrew, btn++, "None", gooArmorChangeStyle, [0, fromCrew], "No Style", "Remove the suit’s current appearance.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "None");
			if(pc.statusEffectv1("Goo Armor Design") != 1) gooArmorAddButton(fromCrew, btn++, "L.Armor", gooArmorChangeStyle, [1, fromCrew], "Light Armor", "Change the suit’s appearance to look like light armor.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "L.Armor");
			if(pc.statusEffectv1("Goo Armor Design") != 2) gooArmorAddButton(fromCrew, btn++, "H.Armor", gooArmorChangeStyle, [2, fromCrew], "Heavy Armor", "Change the suit’s appearance to look like heavy armor.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "H.Armor");
			if(pc.statusEffectv1("Goo Armor Design") != 3) gooArmorAddButton(fromCrew, btn++, "Clothes", gooArmorChangeStyle, [3, fromCrew], "Clothing", "Change the suit’s appearance to look like normal clothing.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Clothes");
			if(pc.statusEffectv1("Goo Armor Design") != 4) gooArmorAddButton(fromCrew, btn++, "Latex", gooArmorChangeStyle, [4, fromCrew], "Latex", "Change the suit’s appearance to look like tight latex.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Latex");
			if(flags["GOO_ARMOR_SWIMSUIT"] == undefined) gooArmorAddDisabledButton(fromCrew, btn++, "Locked", "Locked", "[goo.name] hasn’t learned how to do this yet..." + (pc.level < 4 ? " She may be more confident if you are a higher level." : " Maybe try talking to her while" + (InRoomWithFlag(GLOBAL.POOL) ? "" : " at a pool and") + " wearing an outfit made for swimming?"));
			else if(pc.statusEffectv1("Goo Armor Design") != 5)
			{
				if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, btn++, "Swimwear", "Swimwear", "[goo.name]’s defense is too low to change into swimwear.");
				else gooArmorAddButton(fromCrew, btn++, "Swimwear", gooArmorChangeStyle, [5, fromCrew], "Swimwear", "Change the suit’s appearance to look like something you can swim in.");
			}
			else gooArmorAddDisabledButton(fromCrew, btn++, "Swimwear");
			break;
		case "pattern":
			txt += "<i>“" + (pc.statusEffectv2("Goo Armor Design") == 0 ? "Ooh, I love patterns!" : "Wanna make your suit look pretty?") + "”</i>";
			
			if(pc.statusEffectv2("Goo Armor Design") != 0) gooArmorAddButton(fromCrew, btn++, "None", gooArmorChangePattern, [0, fromCrew], "No Pattern", "Remove the suit’s current pattern.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "None");
			if(pc.statusEffectv2("Goo Armor Design") != 1) gooArmorAddButton(fromCrew, btn++, "Hexagon", gooArmorChangePattern, [1, fromCrew], "Hexagonal Tiles", "Change the suit’s pattern to look like hexagonal tiles.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Hexagon");
			if(pc.statusEffectv2("Goo Armor Design") != 2) gooArmorAddButton(fromCrew, btn++, "Trim", gooArmorChangePattern, [2, fromCrew], "Silver Trim", "Change the suit’s pattern to have a silvery trim on the edges.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Trim");
			if(pc.statusEffectv2("Goo Armor Design") != 3) gooArmorAddButton(fromCrew, btn++, "Circuits", gooArmorChangePattern, [3, fromCrew], "Circuits", "Change the suit’s pattern to look like a printed circuit board.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Circuits");
			if(pc.statusEffectv2("Goo Armor Design") != 4) gooArmorAddButton(fromCrew, btn++, "Lines", gooArmorChangePattern, [4, fromCrew], "Linear Markings", "Change the suit’s pattern to look like linear markings.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "Lines");
			break;
		case "emblem":
			if(pc.getStatusTooltip("Goo Armor Design") == "" || pc.getStatusTooltip("Goo Armor Design") == "none") txt += "<i>“You want an emblem, huh? Is that like a tattoo?”</i>";
			else txt += "<i>“Represent!”</i>";
			
			gooArmorEmblemMenu([fromCrew, 0]);
			break;
		case "helmet":
			txt += "<i>“" + (pc.statusEffectv3("Goo Armor Design") == 0 ? "Would you like a helmet" : "Wanna change your helmet") + "?”</i>";
			
			if(pc.statusEffectv3("Goo Armor Design") != 0) gooArmorAddButton(fromCrew, btn++, "None", gooArmorChangeHelmet, [0, fromCrew], "No Helmet", "Remove the suit’s helmet.");
			else gooArmorAddDisabledButton(fromCrew, btn++, "None");
			if(pc.statusEffectv3("Goo Armor Design") != 1)
			{
				if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, btn++, "Stylish", "Stylish", "[goo.name]’s defense is too low to apply a helmet.");
				else gooArmorAddButton(fromCrew, btn++, "Stylish", gooArmorChangeHelmet, [1, fromCrew], "Stylish Helmet", "Change the suit’s helmet to look like head gear worn by a snazzy spacer.");
			}
			else gooArmorAddDisabledButton(fromCrew, btn++, "Stylish");
			if(pc.statusEffectv3("Goo Armor Design") != 2)
			{
				if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, btn++, "Fierce", "Fierce", "[goo.name]’s defense is too low to apply a helmet.");
				else gooArmorAddButton(fromCrew, btn++, "Fierce", gooArmorChangeHelmet, [2, fromCrew], "Intimidating Helmet", "Change the suit’s helmet to look menacing to your opponents.");
			}
			else gooArmorAddDisabledButton(fromCrew, btn++, "Fierce");
			if(pc.statusEffectv3("Goo Armor Design") != 3)
			{
				if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, btn++, "Retro", "Retro", "[goo.name]’s defense is too low to apply a helmet.");
				else gooArmorAddButton(fromCrew, btn++, "Retro", gooArmorChangeHelmet, [3, fromCrew], "Bubble Helmet", "Change the suit’s helmet to look like something that came from the ancient terran gray-toned films.");
			}
			else gooArmorAddDisabledButton(fromCrew, btn++, "Retro");
			if(pc.statusEffectv3("Goo Armor Design") != 4)
			{
				if(pc.armor.defense < 2) gooArmorAddDisabledButton(fromCrew, btn++, "Mystery", "Mystery", "[goo.name]’s defense is too low to apply a helmet.");
				else gooArmorAddButton(fromCrew, btn++, "Mystery", gooArmorChangeHelmet, [4, fromCrew], "Mysterious Mask", "Change the suit’s helmet to look like a mirrored mask and keep your face anonymous.");
			}
			else gooArmorAddDisabledButton(fromCrew, btn++, "Mystery");
			break;
	}
	
	gooArmorOutput(fromCrew, txt);
	
	gooArmorAddButton(fromCrew, 14, "Back", gooArmorChangeArmorMenu, fromCrew);
}
public function gooArmorEmblemMenu(arg:Array):void
{
	var fromCrew:Boolean = arg[0];
	var offset:int = arg[1];
	
	gooArmorClearMenu(fromCrew);
	
	var i:int = 0;
	var btnSlot:int = 0;
	var emblemList:Array = [
		["None", "none"],
		["BI/G", "Bell-Isle/Grunmann patch"],
		["Steele", "Steele Tech logo"],
	];
	// Push other emblems in the list for unlocking!
	if(9999 == 0) emblemList.push(["None", "none"]);
	
	for(i = (fromCrew ? 0 : offset); i < (fromCrew ? emblemList.length : (offset + 10)); i++)
	{
		if(!fromCrew && i >= emblemList.length) break;
		if(fromCrew && btnSlot >= 14 && (btnSlot + 1) % 15 == 0)
		{
			gooArmorAddButton(fromCrew, btnSlot, "Back", gooArmorChangeArmorMenu, fromCrew);
			btnSlot++;
		}
		
		if(pc.getStatusTooltip("Goo Armor Design") != emblemList[i][1]) gooArmorAddButton(fromCrew, btnSlot, emblemList[i][0], gooArmorChangeEmblem, [emblemList[i][1], fromCrew], StringUtil.toDisplayCase(emblemList[i][1]), (emblemList[i][1] == "none" ? "Remove the current emblem." : "Change the emblem to " + indefiniteArticle(emblemList[i][1]) + "."));
		else gooArmorAddDisabledButton(fromCrew, btnSlot, emblemList[i][0]);
		btnSlot++;
		
		if(fromCrew && emblemList.length > 14 && (i + 1) == emblemList.length)
		{
			while((btnSlot + 1) % 15 != 0) { btnSlot++; }
			gooArmorAddButton(fromCrew, btnSlot, "Back", gooArmorChangeArmorMenu, fromCrew);
		}
		if(!fromCrew)
		{
			if(offset >= 10) gooArmorAddButton(fromCrew, 10, "Prev Pg.", gooArmorEmblemMenu, [fromCrew, (offset - 10)], "Previous Page", "View more emblems.");
			if(offset + 10 < emblemList.length) gooArmorAddButton(fromCrew, 12, "Next Pg.", gooArmorEmblemMenu, [fromCrew, (offset + 10)], "Next Page", "View more emblems.");
		}
	}
	
	gooArmorAddButton(fromCrew, 14, "Back", gooArmorChangeArmorMenu, fromCrew);
}
public function gooArmorChangeStyle(arg:Array):void
{
	var style:int = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	var airtight:String = "";
	var swimwear:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	txt += "<i>“" + (rand(2) == 0 ? "No problem!" : "Okay, I’ll try my best!") + "”</i>";
	if(style != 0)
	{
		txt += " [goo.name]";
		if(pc.statusEffectv1("Goo Armor Design") != 0) txt += " reshapes herself around you until the suit is completely featureless, then she prepares";
		else txt += " prepares herself";
		txt += " to make changes based on your suggestion.";
		processTime(3);
	}
	else processTime(1);
	
	switch(style)
	{
		case 0:
			txt += " Without much effort, [goo.name] alters her shape until your outfit becomes the usual shape, with no specific features that really stand out.";
			break;
		case 1:
			txt += " Small plates, straps, and other ornaments form around your suit, making you appear to be fully prepared for anything. Although you know it doesn’t change the armor rating in the least, it still looks pretty cool.";
			txt += "\n\n<i>“Yep, I think it looks pretty cool, too!”</i> the voice eminating from your belly agrees.";
			break;
		case 2:
			txt += " Large pieces of armor flare out from your suit, giving you a bulkier look. Huge pauldrons and arm guards form at your sides";
			if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) && !pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += ", " + (pc.bRows() == 1 ? "a" : num2Text(pc.bRows())) + " breastplate" + (pc.bRows() == 1 ? "" : "s") + " at your front";
			txt += ", adding to the size. Although you know it doesn’t change the armor rating at all, from afar, it makes you appear to be some kind of knight or tank" + (silly ? "... or a tank-knight" : "") + ".";
			txt += "\n\n<i>“Space marines, eat your heart out!”</i> exclaims your tummy.";
			break;
		case 3:
			txt += " Natural-looking seams and folds appear on your suit, the texture dulling a bit to simulate the look of your favorite fabric. The goo travels across your body";
			if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			{
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST)) txt += ", " + (pc.hasBreasts() ? "breasts" : "chest");
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN)) txt += ", crotch";
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) txt += ", ass";
			}
			txt += " and wraps your limbs in faux-cloth material.";
			txt += "\n\n<i>“Is this casual enough for you?”</i> asks your midriff.";
			break;
		case 4:
			txt += " The suit’s silvery surface becomes extra glossy, simulating the texture of latex. All over your body, the goo compresses and constricts, making the plastic appearance more convincing.";
			if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL))
			{
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST)) txt += " It tightens over your " + (pc.biggestTitSize() >= 3 ? "breasts, pressing your jugs close to your chest, yet keeping them in their own snuggly-fitting cups" : "chest, accentuating its form") + ".";
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN))
				{
					txt += " Your crotch is sealed in tightly";
					if(pc.hasGenitals() || (pc.balls > 0 && pc.ballSize() > 3))
					{
						txt += ", leaving behind a visible ";
						var buldges:int = pc.cockTotal();
						if(pc.ballSize() > 3) buldges += pc.balls;
						if(buldges > 0) txt += (buldges == 1 ? "buldge" : (buldges == 2 ? "pair" : "set") + " of buldges");
						else txt += (pc.totalVaginas() == 1 ? "camel toe" : (pc.totalVaginas() == 2 ? "pair" : "set") + " of camel toes");
					}
					if(pc.libido() > 50) txt += "--and a zipper forms below, just for the added lewdness";
					txt += ".";
				}
				if(!pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS)) txt += " Like some kind of lewd binding, the latex-goo tightens around your [pc.butts], keeping them nicely packed together.";
			}
			else txt += " It leaves all of your sensitive bits exposed however, like some kind of fetishized catsuit.";
			txt += "\n\n<i>“Oh, [pc.name], you look so sexy right now...”</i> comments your tummy.";
			break;
		case 5:
			txt += " The body suit’s surface shrinks on your torso, the sleeves";
			if(pc.getStatusTooltip("Goo Armor Design") == "" || pc.getStatusTooltip("Goo Armor Design") == "none")
			{
				if(pc.statusEffectv3("Goo Armor Design") != 0) txt += ",";
				else txt += " and";
				txt += " emblems";
			}
			if(pc.statusEffectv3("Goo Armor Design") != 0)
			{
				txt += " and helmet";
				if(pc.getStatusTooltip("Goo Armor Design") == "" || pc.getStatusTooltip("Goo Armor Design") == "none") txt += ", all";
			}
			txt += " disappearing. Not soon after,";
			if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS))
			{
				txt += " by leaving your";
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_CHEST) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += ", " + (pc.hasBreasts() ? "breasts" : "chest");
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += ", crotch";
				if(pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS) || pc.armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) txt += ", ass";
				txt += ", arms and " + (pc.legCount == 1 ? "[pc.legNoun]" : "[pc.legsNoun]") + " exposed,";
			}
			else txt += " by keeping your arms and " + (pc.legCount == 1 ? "[pc.legNoun]" : "[pc.legsNoun]") + " uncovered,";
			txt += " your armor looks more suitable for swimming in.";
			txt += "\n\n<i>“Beach day or pool party?”</i> your tummy eagerly asks.";
			break;
		default:
			txt += " Ripples of change shoot across it and the suit shifts and morphs gradually, getting closer and closer to the design you have chosen. Of course it isn’t a perfectly matching duplicate, given that [goo.name] has added her own touches, but it’s pretty darn close enough.";
			txt += "\n\n<i>“Aaaand finished!”</i> announces the voice coming from your middle.";
			break;
	}
	
	pc.setStatusValue("Goo Armor Design", 1, style);
	swimwear = gooArmorCheckSwimwear();
	airtight = gooArmorCheckAirtight();
	
	if(swimwear.length > 0) txt += "\n\n" + swimwear;
	if(airtight.length > 0) txt += "\n\n" + airtight;
	
	txt += "\n\n" + gooArmorDetails();
	gooArmorOutput(fromCrew, txt);
	
	gooArmorChangeArmorMenu(fromCrew);
}
public function gooArmorChangePattern(arg:Array):void
{
	var style:int = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	txt += "<i>“" + (rand(2) == 0 ? "Alrighty!" : "Gotcha. Here goes!") + "”</i>";
	if(style != 0)
	{
		txt += " [goo.name]";
		if(pc.statusEffectv2("Goo Armor Design") != 0) txt += " wipes the previous pattern and";
		txt += " wriggles a bit in preperation.";
		processTime(3);
	}
	else processTime(1);
	
	switch(style)
	{
		case 0:
			txt += " [goo.name] doesn’t even wriggle and the pattern you had decorating your suit quickly vanishes.";
			break;
		case 1:
			txt += " One by one, lines draw hexagonal tiles on certain parts of your suit, giving it a very modern flavor.";
			break;
		case 2:
			txt += " Like a marker, polished silver trim is drawn along the edges of your suit, giving it an elegant yet simple look.";
			break;
		case 3:
			txt += " Lines of silver are drawn on your suit, bending in angles and ending either off the edge or capped with a dot or circle shape. This circuit board pattern makes your suit look very tech-oriented.";
			break;
		case 4:
			txt += " " + (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR) ? "L" : "Eminating from the collar, l") + "ines are drawn downward and across certain anatomical seams along your suit, segmenting it into major portions yet still retaining the one-piece look.";
			break;
		default:
			txt += " Gradually, the new pattern you requested emerges on the surface of the suit until your suit is covered in the new design.";
			break;
	}
	
	pc.setStatusValue("Goo Armor Design", 2, style);
	
	txt += "\n\n" + gooArmorDetails();
	gooArmorOutput(fromCrew, txt);
	
	gooArmorChangeArmorMenu(fromCrew);
}
public function gooArmorChangeEmblem(arg:Array):void
{
	var style:String = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	if(style == "Bell-Isle/Grunmann patch")
	{
		txt += "[goo.name]’s head pops from you, <i>“So what’ll it be?”</i>";
		txt += "\n\nYou ask if she can give you a Bell-Isle/Grunmann patch to go along with your suit.";
		txt += "<i>“Oh, that’s easy, peasy... Just watch!”</i> In an instant, the recognizable logo is etched onto your armor, one on each shoulder. Looks like she knows that one pretty well!";
		processTime(1);
	}
	else if(style != "none")
	{
		txt += "[goo.name]’s head pops from you, <i>“Sure, whatcha got there?”</i>";
		txt += "\n\nYou press a button on your " + (InShipInterior() ? "dash to display" : "codex to project") + " the " + style + " and let her view it for a moment.";
		txt += "\n\n[goo.name] makes some concentrating noises, storing the details in her memory. When she’s confident she has it, she confirms, <i>“Got it!”</i>";
		txt += "\n\nIt takes a little time, but she manages to get the design printed, one on each shoulder.";
		processTime(3);
	}
	else
	{
		txt += "<i>“Aw, okay!”</i> Removing the " + pc.getStatusTooltip("Goo Armor Design") + " on your shoulders is as easy as blinking for [goo.name]. When she finishes, she exclaims, <i>“There! All done!”</i>";
		processTime(1);
	}
	
	pc.setStatusTooltip("Goo Armor Design", style);
	
	txt += "\n\n" + gooArmorDetails();
	gooArmorOutput(fromCrew, txt);
	
	gooArmorChangeArmorMenu(fromCrew);
}
public function gooArmorChangeHelmet(arg:Array):void
{
	var style:int = arg[0];
	var fromCrew:Boolean = arg[1];
	var txt:String = "";
	var airtight:String = "";
	
	gooArmorClearOutput(fromCrew);
	author("Jacques00");
	showGrayGooArmor();
	
	txt += "<i>“" + (rand(2) == 0 ? "Okay, I’m on it!" : "Let’s see here...") + "”</i>";
	if(style != 0)
	{
		txt += " [goo.name] quickly engulfs your head with her gooey matter. Your vision is eclipsed in black for a few seconds before the microbots blocking your eyes begin to clear up, creating a transparent layer and allowing you to see your reflection in the mirror.";
		processTime(3);
	}
	else processTime(1);
	
	switch(style)
	{
		case 0:
			txt += " The helmet on your head quickly opens opens up and rapidly dissolves, melding back into the suit from which it came. After making some final aesthetic adjustments, [goo.name] squeals in approval. <i>“Now just remember to be careful out there!”</i>";
			break;
		case 1:
			txt += "\n\nThe surface of your new head gear becomes more defined until it changes into something similar to a sports speeder’s helmet, but with some noticeable accents. Something tells you that if [goo.name] wasn’t completely silver-gray, the surface would be colored bright pink and decked with heart-shaped stickers.";
			txt += "\n\n<i>“How do you like that? Nice and stylish!”</i>";
			break;
		case 2:
			txt += "\n\nThe helmet’s form twists and shifts, with edges and sharp points appearing across its surface. The viewable area narrows until your reflection shows that it has become a linear slit masking your eyes. The helmet itself is flush with the shape of your head, allowing it to move in sync without wobbling. In the right lighting, at the right angle, you can almost see a piercing glow eminating from your eye slit.";
			txt += "\n\n<i>“Ooh, yeah. Now you look super scary!”</i>";
			break;
		case 3:
			txt += "\n\nThe entire dome inflates into a spherical shape, forming a very distinctive bubble that steadily continues to grow larger. When it reaches the approriate size for you, the rest of the orb’s silvery gray tint dissolves away, leaving behind a glass-like surface. You exprimentally tap it a few times and determine that it sounds very much like glass too--and hopefully a lot more durable!";
			txt += "\n\n<i>“Is this how ancient spacers looked? I like it!”</i>";
			break;
		case 4:
			txt += "\n\nThe helmet’s surface smoothes out and warps to match the dimensions of your head, then the transparency re-shades itself in a silver, reflexive film - painting the entire front to form a smooth, featureless mask. No one can see your face even though you can see through it just fine. This definitely gives you a very anonymous appearance.";
			txt += "\n\n<i>“Ooo, mysterious!”</i>";
			break;
		default:
			txt += "\n\nThe blob shifts and changes to the desired shape you suggested. You find that [goo.name] pays very close attention to detail, even though she gets carried away with her own unique flourishes. When all is said and done, you find that your suit now possesses a newly designed helmet.";
			txt += "\n\n<i>“There ya go and I hope you like it!”</i>";
			break;
	}
	if(style != 0) txt += " She then retracts the helmet back so you can breathe the unfiltered air again. She’ll have your new helmet ready again when you need it most.";
	
	pc.setStatusValue("Goo Armor Design", 3, style);
	airtight = gooArmorCheckAirtight();
	
	if(airtight.length > 0) txt += "\n\n" + airtight;
	
	txt += "\n\n" + gooArmorDetails();
	gooArmorOutput(fromCrew, txt);
	
	gooArmorChangeArmorMenu(fromCrew);
}





