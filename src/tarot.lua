SMODS.Consumable {
	set = "Tarot",
	key = "estrogen",
	effect = "Card Conversion",
	order = 22,
	pos = { x = 0, y = 0 },
	config = {
		max_highlighted = 2
	},
	cost = 3,
	atlas = "cards",
	loc_txt = {
 		name = "Estrogen",
 		text = {
 			"Converts up to",
 			"{C:attention}#1#{} selected cards",
 			"to {C:attention}Queens{}"
 		},
 	},
 	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted + G.GAME.select_more } }
    end,
	can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted + G.GAME.select_more and #G.hand.highlighted > 0
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		--ease_dollars(1000000000000000000000000, true)
		for i = 1, #G.hand.highlighted do --flips cards
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		G.hand.highlighted[i]:flip();
            		play_sound('card1', percent);
            		G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		return true
            	end
            }))
        end
        delay(0.2)
		for i = 1, #G.hand.highlighted do --converts cards
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					local suit_prefix = string.sub(G.hand.highlighted[i].base.suit, 1, 1)..'_'
					G.hand.highlighted[i]:set_base(G.P_CARDS[suit_prefix.."Q"])
					return true
				end
			}))
		end  
		for i = 1, #G.hand.highlighted do --unflips cards
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		G.hand.highlighted[i]:flip();
            		play_sound('tarot2', percent, 0.6);
            		G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		return true
            	end
            }))
        end
        G.E_MANAGER:add_event(Event({
        	trigger = 'after',
        	delay = 0.2,
        	func = function()
        		G.hand:unhighlight_all();
        		return true
        	end
        })) --unselects cards
        delay(0.5)
	end
}

SMODS.Consumable {
	set = "Tarot",
	key = "ffs",
	effect = "Enhance",
	order = 23,
	pos = { x = 1, y = 0 },
	config = {
		mod_conv = "m_wild",
		max_highlighted = 2
	},
	cost = 3,
	atlas = "cards",
	loc_txt = {
 		name = "The Surgeon",
 		text = {
 			"Enhances {C:attention}#1#{}",
 			"selected Queens into",
			"{C:attention}Wild Cards{}",
			"{C:inactive}(To cure lupus!){}"
 		},
 	},
 	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted + G.GAME.select_more } }
    end,
	can_use = function(self, card)
		if #G.hand.highlighted <= card.ability.max_highlighted + G.GAME.select_more and #G.hand.highlighted > 0 then
			for i = 1, #G.hand.highlighted do
				if G.hand.highlighted[i].base.value ~= "Queen" or SMODS.has_no_rank(G.hand.highlighted[i]) then
					return false
				end
			end
			return true
		end
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.highlighted do --flips cards
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		G.hand.highlighted[i]:flip();
            		play_sound('card1', percent);
            		G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		return true
            	end
            }))
        end
        delay(0.2)
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.consumeable.mod_conv]);
					return true
				end
			}))
		end 
		for i = 1, #G.hand.highlighted do --unflips cards
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		 G.hand.highlighted[i]:flip();
            		 play_sound('tarot2', percent, 0.6);
            		 G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		 return true
            	end
            }))
        end
        G.E_MANAGER:add_event(Event({
        	trigger = 'after',
        	delay = 0.2,
        	func = function()
        		G.hand:unhighlight_all();
        	return true
        end })) --unselects cards
        delay(0.5)
	end
}

SMODS.Consumable {
	set = "Tarot",
	key = "towers",
	effect = "Enhance",
	order = 24,
	pos = { x = 2, y = 0 },
	config = {
		mod_conv = "m_TWT_tower",
		max_highlighted = 2
	},
	cost = 3,
	atlas = "cards",
	loc_txt = {
 		name = "The Towers",
 		text = {
 			"Enhances {C:attention}#1#{}",
 			"selected cards into",
 			"{C:attention}Tower Cards{}"
 		},
 	},
 	loc_vars = function(self, info_queue, card)
 		--if not center then --tooltip
		--elseif not center.added_to_deck then
			info_queue[#info_queue + 1] = G.P_CENTERS.m_TWT_tower
		--end
        return { vars = { card.ability.max_highlighted + G.GAME.select_more } }
    end,
	can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted + G.GAME.select_more and #G.hand.highlighted > 0
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.highlighted do --flips cards
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		G.hand.highlighted[i]:flip();
            		play_sound('card1', percent);
            		G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		return true
            	end
            }))
        end
        delay(0.2)
		for i = 1, #G.hand.highlighted do --enhances cards
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.consumeable.mod_conv]);
					return true
				end
			}))
		end 
		for i = 1, #G.hand.highlighted do --unflips cards
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		 G.hand.highlighted[i]:flip();
            		 play_sound('tarot2', percent, 0.6);
            		 G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		 return true
            	end
            }))
        end
        G.E_MANAGER:add_event(Event({
        	trigger = 'after',
        	delay = 0.2,
        	func = function()
        		G.hand:unhighlight_all();
        	return true
        end })) --unselects cards
        delay(0.5)
	end
}

SMODS.Consumable {
	set = "Tarot",
	key = "weakness",
	effect = "Enhance",
	order = 25,
	pos = { x = 3, y = 0 },
	config = {
		decrease = 1,
		max_highlighted = 2
	},
	cost = 3,
	atlas = "cards",
	loc_txt = {
 		name = "Weakness",
 		text = {
 			"Decreases rank of",
 			"up to {C:attention}#1#{} selected",
 			"cards by {C:attention}#2#{}"
 		},
 	},
 	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted + G.GAME.select_more, card.ability.decrease } }
    end,
	can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted + G.GAME.select_more and #G.hand.highlighted > 0
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.highlighted do --flips cards
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		G.hand.highlighted[i]:flip();
            		play_sound('card1', percent);
            		G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		return true
            	end
            }))
        end
        delay(0.2)
        
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					local card = G.hand.highlighted[i]
					local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
					local rank_suffix = card.base.id == 2 and 14 or math.min(card.base.id-1, 14)
					if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
					elseif rank_suffix == 10 then rank_suffix = 'T'
					elseif rank_suffix == 11 then rank_suffix = 'J'
					elseif rank_suffix == 12 then rank_suffix = 'Q'
					elseif rank_suffix == 13 then rank_suffix = 'K'
					elseif rank_suffix == 14 then rank_suffix = 'A'
					end
					card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
					return true
				end
			}))
		end  
		
		for i = 1, #G.hand.highlighted do --unflips cards
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            	trigger = 'after',
            	delay = 0.15,
            	func = function()
            		 G.hand.highlighted[i]:flip();
            		 play_sound('tarot2', percent, 0.6);
            		 G.hand.highlighted[i]:juice_up(0.3, 0.3);
            		 return true
            	end
            }))
        end
        G.E_MANAGER:add_event(Event({
        	trigger = 'after',
        	delay = 0.2,
        	func = function()
        		G.hand:unhighlight_all();
        	return true
        end })) --unselects cards
        delay(0.5)
	end
}