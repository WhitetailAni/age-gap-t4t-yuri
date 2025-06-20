SMODS.Consumable {
	set = "Spectral",
	key = "projesterone",
	order = 24,
	pos = { x = 0, y = 2 },
	cost = 7,
	config = {
		mod_conv = "m_stone",
		extra = {
			odds = 7
		}
	},
	atlas = "cards",
	loc_txt = {
 		name = "Projesterone",
 		text = {
 			"Converts all cards in",
 			"hand to {C:attention}Queens{}, but",
 			"each card has a {C:green}#1# in #2#{}",
 			"chance to be enhanced",
 			"into a {C:attention}Stone Card{}",
 			"{C:red}-1{} hand size" }
 	},
 	loc_vars = function(self, info_queue, card)
 		info_queue[#info_queue + 1] = { set = "Other", key = "TWT_prog" }
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('card1', percent);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
		delay(0.2)
		local _rank = "Q"
		for i = 1, #G.hand.cards do
			G.E_MANAGER:add_event(Event({func = function()
				local card = G.hand.cards[i]
				local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
				local rank_suffix =_rank
				card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
			return true end }))
			if pseudorandom("progesterone") < G.GAME.probabilities.normal/card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.cards[i]:set_ability(G.P_CENTERS[card.ability.consumeable.mod_conv]);
						return true
					end
				}))
			end
		end
		G.hand:change_size(-1)
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('tarot2', percent, 0.6);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
		delay(0.5)
	end
}

SMODS.Consumable {
	set = "Spectral",
	key = "spironolactone",
	order = 25,
	pos = { x = 1, y = 2 },
	cost = 7,
	config = {
		divide_by = 3,
		mod_conv = "m_gold"
	},
	atlas = "cards",
	loc_txt = {
 		name = "Spironolactone",
 		text = {
 			"Enhances all cards in",
 			"hand to {C:attention}Gold Cards{},",
 			"next ante's Boss Blind is {C:attention}The",
 			"{C:attention}Man{} and money is halved"
 		}
 	},
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	loc_vars = function(self, info_queue, card)
 		info_queue[#info_queue + 1] = { set = "Other", key = "TWT_spiro" }
    end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.cards do --flips cards
			local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('card1', percent);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do --enhances cards
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.cards[i]:set_ability(G.P_CENTERS[card.ability.consumeable.mod_conv]);
					return true
				end
			}))
		end
		for i = 1, #G.hand.cards do --unflips cards
			local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('tarot2', percent, 0.6);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
		delay(0.2)
		
		G.GAME.perscribed_bosses[G.GAME.round_resets.ante + 1] = "bl_TWT_man"
		
		ease_dollars(-(G.GAME.dollars / 2), true)
		
		delay(0.5)
	end
}

SMODS.Consumable {
	set = "Spectral",
	key = "ritalin",
	effect = "Enhance",
	order = 26,
	pos = { x = 2, y = 2 },
	config = {
		explode = 1,
		bonus = 35,
	},
	cost = 4,
	atlas = "cards",
	loc_txt = {
 		name = "Ritalin",
 		text = {
 			"Destroy {C:attention}#1# random card in",
 			"your hand, remove enhancements",
 			"from remaining cards in hand",
 			"in exchange for {C:chips}+#2#{} bonus Chips",
 			"on enhanced cards"
 		},
 	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.explode, card.ability.bonus } }
    end,
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		local fall_guy = pseudorandom_element(G.hand.cards, pseudoseed('ritalin'))
		--flip cards		
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('card1', percent);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
		delay(0.2)
		
		for i = 1, #G.hand.cards do
			if G.hand.cards[i].config.center and (G.hand.cards[i].config.center.name ~= "Default Base") and not G.hand.cards[i].vampired then 
				--removes enhancement, adds chips
				G.hand.cards[i]:set_ability(G.P_CENTERS.c_base, nil, true)
				G.hand.cards[i].ability.perma_bonus = G.hand.cards[i].ability.perma_bonus or 0
				G.hand.cards[i].ability.perma_bonus = G.hand.cards[i].ability.perma_bonus + card.ability.bonus
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand.cards[i]:juice_up()
						return true
					end
				}))
			end
		end
		
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip();
					play_sound('tarot2', percent, 0.6);
					G.hand.cards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
		end
        delay(0.2)
        
        G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function() 
				if fall_guy.ability.name == 'Glass Card' then 
					fall_guy:shatter()
				else
					fall_guy:start_dissolve(nil, true)
				end
				return true
			end
		}))
		delay(0.5)
	end
}

SMODS.Consumable {
	set = "Spectral",
	key = "scalar",
	order = 27,
	pos = { x = 3, y = 2 },
	cost = 4,
	config = {
		extra = {
			plus_hand_size = 3,
			minus_hand = 1,
			minus_discard = 1
		}
	},
	atlas = "cards",
	loc_txt = {
 		name = "Scalar",
 		text = {
 			"{C:blue}+#1#{} hand size,",
 			"permanently",
 			"lose {C:red}#2#{} hand",
 			"and {C:red}#3#{} discard"
 		}
 	},
 	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.plus_hand_size, card.ability.extra.minus_hand, card.ability.extra.minus_discard } }
    end,
	can_use = function(self, card)
		return true
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		G.hand:change_size(card.ability.extra.plus_hand_size)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.minus_hand
		ease_hands_played(-card.ability.extra.minus_hand)
		
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.minus_discard
		ease_discard(-card.ability.extra.minus_discard)
	end
}

SMODS.Consumable {
	set = "Spectral",
	key = "cable",
	order = 28,
	pos = { x = 4, y = 2 },
	cost = 7,
	config = {
		extra = {
			max_highlighted = 1,
			seal = "TWT_nb"
		}
	},
	atlas = "cards",
	loc_txt = {
 		name = "Cable",
 		text = {
 			"Adds a {C:purple}Nonbinary Seal{}",
 			"to {C:attention}#1#{} selected",
 			"card in your hand"
 		}
 	},
 	loc_vars = function(self, info_queue, card)
 		info_queue[#info_queue + 1] = { set = "Other", key = "TWT_nb_seal" }
 		info_queue[#info_queue + 1] = { set = "Other", key = "TWT_nb_seal_name" }
        return { vars = { card.ability.extra.max_highlighted + G.GAME.select_more } }
    end,
	can_use = function(self, card)
		return #G.hand.highlighted + G.GAME.select_more == 1
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			func = function()
            	play_sound('tarot1')
            	card:juice_up(0.3, 0.5)
            	return true
            end
        }))
        
        for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:set_seal(card.ability.extra.seal, nil, true)
					return true
				end
			}))
        end
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
        	trigger = 'after',
        	delay = 0.2,
        	func = function()
        		G.hand:unhighlight_all();
        		return true
        	end
        }))
	end
}