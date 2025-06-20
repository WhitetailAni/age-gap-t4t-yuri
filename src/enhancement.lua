SMODS.Enhancement {
	key = "tower",
	atlas = "upgrades",
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "Tower Card",
		text = {
			"Randomly gives {C:attention}#6#{} of the",
			"following when scored",
			"{C:chips}+#1#{} Chips",
			"{X:chips,C:white}X#2#{} Chips",
			"{C:mult}+#3#{} Mult",
			"{X:mult,C:white}X#4#{} Mult",
			"{C:money}$#5#{}",
			"Card collapses after scoring"
		}
	},
	config = {
		extra = {
			chips = 20,
			x_chips = 2,
			mult = 10,
			x_mult = 1.5,
			bigbucks = 10,
			count = 2,
			die = false,
			nine_eleven = false
		},
		dont_duplicate = {
			lower = 6,
			upper = 6
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.x_chips, card.ability.extra.mult, card.ability.extra.x_mult, card.ability.extra.bigbucks, card.ability.extra.count } }
    end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local xchips = false
			for i = 1, card.ability.extra.count do
				local rand = pseudorandom("towers")
				
				local zeroth = 0
				local first = 1 / 6
				local second = 2 / 6
				local third = 3 / 6
				local fourth = 4 / 6
				local fifth = 5 / 6
				local sixth = 1
				
				if card.ability.dont_duplicate.lower ~= 6 and card.ability.dont_duplicate.upper ~= 6 then
					while card.ability.dont_duplicate.lower < rand and rand < card.ability.dont_duplicate.upper do
						rand = pseudorandom("towers")
					end
				end
				--this makes sure that the second effect cannot be the same as the first.
				--however if the card is glitched/oversaturated by cryptid or something (making count higher than 2), effects can repeat
				if zeroth < rand and rand < first then
					card.ability.dont_duplicate.lower = zeroth
					card.ability.dont_duplicate.upper = first
					
					SMODS.calculate_effect({ chips = card.ability.extra.chips }, card)
				elseif first < rand and rand < second then
					card.ability.dont_duplicate.lower = first
					card.ability.dont_duplicate.upper = second
					
					xchips = true
				elseif second < rand and rand < third then
					card.ability.dont_duplicate.lower = second
					card.ability.dont_duplicate.upper = third
					
					SMODS.calculate_effect({ mult = card.ability.extra.mult }, card)
				elseif third < rand and rand < fourth then
					card.ability.dont_duplicate.lower = third
					card.ability.dont_duplicate.upper = fourth
					
					SMODS.calculate_effect({ xmult = card.ability.extra.x_mult }, card)
				elseif fourth < rand and rand < fifth then
					card.ability.dont_duplicate.lower = fourth
					card.ability.dont_duplicate.upper = fifth
					
					SMODS.calculate_effect({ dollars = card.ability.extra.bigbucks }, card)
				elseif fifth < rand and rand < sixth then
					card.ability.dont_duplicate.lower = fifth
					card.ability.dont_duplicate.upper = sixth
					card.ability.extra.die = true
				end
			end
			if xchips then
				return {
					message = "X"..card.ability.extra.x_chips.." Chips",
					colour = G.C.CHIPS,
					Xchip_mod = card.ability.extra.x_chips
				}
			end
		elseif context.destroying_card then
			if card.ability.extra.die or card.ability.extra.nine_eleven then
				return {
					message = "Collapse!",
					remove = true
				}
			end
		elseif context.after then
			if pseudorandom("nine_eleven") < G.GAME.probabilities.normal/100000 and not die then
				return {
					message = "Must be in a blue state.",
					colour = G.C.MULT
				}
			end
		end
	end
}

--this is exclusive to the orange man setting
SMODS.Enhancement {
	key = "orange",
	atlas = "decks",
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "orange man bad",
		text = { "orange man bad" }
	},
	in_pool = function(self, args)
		return false
	end,
	replace_base_card = true,
	overrides_base_rank = true --this prevents it from showing up in grim/incantation/familiar
}