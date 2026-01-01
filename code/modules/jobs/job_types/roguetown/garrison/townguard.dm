/datum/job/roguetown/guardsman
	title = "Watchman"
	f_title = "Watchwoman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS // same as town guard
	disallowed_races = list(
		/datum/species/lamia,
	)
	tutorial = "Whether dragged out of your home by the bailiff or a fresh volunteer seeking to defend your home, you've found yourself on the lowest position of the garrison. Break up petty crimes, solve minor disputes, and try to keep the peace best you can. Maybe one day you can be one of those manor guards..."
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/guardsman
	advclass_cat_rolls = list(CTAG_WATCH = 20)

	give_bank_account = 16
	min_pq = 1 //Introductory guard role, but still requires knowledge of escalation.
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_guard.ogg'
	social_rank = SOCIAL_RANK_PEASANT
/datum/outfit/job/guardsman
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/guardsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "watchman tabard ([index])"

/datum/outfit/job/guardsman
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/stabard/guard
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers		//Would seperate to leather bracers for archer for dodge but - funnily, armor class doesn't exist on bracers.
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/signal_horn = 1)

/*Design philosophy: Men and women, conscripted or volunteered, fresh or recently transferred from civilian life, are undertrained and underequipped, and deployed to guard the town.*/
/datum/advclass/watchman/footsman
	name = "Watch Footman"
	tutorial = "You are a footman of the Town Watch. With cudgel and spear in hand, you are the ender of barfights and chaser of pickpockets, the manner of gates and the first defense the town has against invasion."
	outfit = /datum/outfit/job/guardsman/footsman

	category_tags = list(CTAG_WATCH)

	traits_applied = list(TRAIT_MEDIUMARMOR)

	subclass_stats = list(
		STATKEY_STR = 2,// seems kinda lame but remember guardsman bonus!!
		STATKEY_INT = 1,
		STATKEY_CON = 1,
		STATKEY_END = 1
	)

	subclass_skills = list( // weaponskills used to be expert, but we're bringing them down to jman across the board. no more versatility!
	/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN, 
	/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/whipsflails = SKILL_LEVEL_APPRENTICE,
	/datum/skill/combat/slings = SKILL_LEVEL_NOVICE,
	/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT, // wrestling stays relevant, unarmed goes down. You Have Weapons. Use Them.
	/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
	/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
	/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
	/datum/skill/misc/tracking = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/guardsman/footsman/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/roguetown/helmet
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	beltr = /obj/item/rogueweapon/mace/cudgel
	backr = /obj/item/rogueweapon/shield/wood		//Maybe give a buckler? Gave wood because 40 coverage is better than 10 but dunno.
	backr = /obj/item/storage/backpack/rogue/satchel/black
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather/black
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/rope/chain = 1)
	H.verbs |= /mob/proc/haltyell

/datum/advclass/watchman/archer
	name = "Watch Archer"
	tutorial = "You are an archer of the Town Watch. Perhaps you were once a hunter, regardless, you've been trained with the bow and told to set your sights both outward to the unknown woods and inward to the streets of your home."
	outfit = /datum/outfit/job/guardsman/archer

	category_tags = list(CTAG_WATCH)

	//Garrison ranged/speed class. Time to go wild
	// traits_applied = list(TRAIT_DODGEEXPERT) (removing this per request, can be tweaked later if needed)
	traits_applied = list(TRAIT_MEDIUMARMOR) // given so they can't have arcyne potential. sorry! you can still dodge if you want.
	subclass_stats = list(
		STATKEY_SPD = 3,// +1 spd so they can use their missing DE a little better
		STATKEY_PER = 2,
		STATKEY_END = 1
	)
	// extra_context = "Chooses between Light Armor (Dodge Expert) & Medium Armor." (why does this exist? you don't choose anything anymore.)

	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN, 		// Still have a cugel.
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,		//Only effects draw and reload time.
		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,			//Only effects draw times.
		/datum/skill/combat/slings = SKILL_LEVEL_MASTER,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, // A little better; run fast, weak boy.
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN, // lowered to jman. you're a bowman with a dagger, not a brawler. use your speed.
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)


/datum/outfit/job/guardsman/archer/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/roguetown/roguehood/red		//To-do: Make a guard hood come in kingdom's colors.
	armor = /obj/item/clothing/suit/roguetown/armor/leather		//So they get default-dodge expert usage.
	beltr = /obj/item/quiver/bolts
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backr = /obj/item/storage/backpack/rogue/satchel/black
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather/black
	gloves = /obj/item/clothing/gloves/roguetown/leather
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/rope/chain = 1)
	H.verbs |= /mob/proc/haltyell

// Added to baliff under assumption townguard.dm will not be enabled.
// /mob/proc/haltyell()
//	set name = "HALT!"
//	set category = "Noises"
//	emote("haltyell")
