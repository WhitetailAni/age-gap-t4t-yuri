SMODS.Joker {
	key = "gay",
	loc_txt = {
		name = "Gay Joker",
		text = {
			"{C:chips}+#1#{} Chips if played",
			"hand contains",
			"a {C:attention}Polycule{}"
		}
	},
	config = {
		extra = {
			chips = 90
		}
	},
	rarity = 1,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "jokers",
	pos = { x = 1, y = 0 },
	cost = 3,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["TWT_polycule"]) then
			return {
				message = localize { type = "variable", key = "a_chips", vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips
			}
		end
	end
}

SMODS.Joker {
	key = "lesbian",
	loc_txt = {
		name = "Lesbian Joker",
		text = {
			"{C:mult}+#1#{} Mult if played",
			"hand contains",
			"a {C:attention}Polycule{}"
		}
	},
	config = {
		extra = {
			mult = 9
		}
	},
	rarity = 1,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "jokers",
	pos = { x = 0, y = 0 },
	cost = 3,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["TWT_polycule"]) then
			return {
				message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult } },
				mult_mod = card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker {
    key = "problematic",
    loc_txt = {
        name = "Problematic",
        text = {
            "Gives {C:mult}+Mult{} equal to the",
            "difference in rank between",
            "the lowest and highest scoring",
            "scoring cards. If the difference",
            "is {C:attention}#1#{} or played hand contains a",
            "{C:attention}Two Pair{}, gives {X:mult,C:white}XMult{} instead.",
            --"{C:inactive}(Difference is currently {C:mult}+#2#{C:inactive})"
        }
    },
    config = {
    	extra = {
    		low = 14,
    		high = 2,
    		gap = 8
    	},
    },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    atlas = "jokers",
    pos = { x = 0, y = 1 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
    	local today = os.date("*t")
		local old = {
			year = 1998,
			month = 3,
			day = 12
		}
		local young = {
			year = 2006,
			month = 3,
			day = 28
		}
		
		local old_age = today.year - old.year
		local young_age = today.year - young.year
		
		if today.month < old.month or 
		   (today.month == old.month and today.day < old.day) then
			old_age = old_age - 1
		end
		if today.month < young.month or 
		   (today.month == young.month and today.day < young.day) then
			young_age = young_age - 1
		end
		card.ability.extra.gap = old_age - young_age
    	return { vars = {
        		card.ability.extra.gap
        	}
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
        	card.ability.extra.high = 2
            card.ability.extra.low = 14
        
        elseif context.individual and context.cardarea == G.play and not context.blueprint and not SMODS.has_no_rank(context.other_card) then
            local value = context.other_card:get_id()
            if value < card.ability.extra.low and value > card.ability.extra.high then
                card.ability.extra.high = value
                card.ability.extra.low = value
            end
            if value > card.ability.extra.high then
                card.ability.extra.high = value
            end
            if value < card.ability.extra.low then
                card.ability.extra.low = value
            end
        elseif context.joker_main then
            local gap = card.ability.extra.high - card.ability.extra.low
            if gap == 0 then
                return {
                    message = "Nothing ever happens..."
                }
            elseif next(context.poker_hands["Two Pair"]) or (gap == card.ability.extra.gap) then
                return {
                    message = localize { type = "variable", key = "a_xmult", vars = { gap } },
                    Xmult_mod = gap
                }
            else
                return {
                    message = localize { type = "variable", key = "a_mult", vars = { gap } },
                    mult_mod = gap
                }
            end
        end
    end
}

SMODS.Joker {
    key = "misandry",
    loc_txt = {
        name = "Misandry",
        text = {
        	"For each {C:attention}King{} or {C:attention}Jack{} discarded",
        	"this round, {C:attention}Queens{} permanently",
            "gain {C:chips}+#1#{} Chips when scored",
			"{C:inactive}(Currently adds {C:chips}+#2#{C:inactive} Chips)"
        },
        unlock = {
        	"Have no {C:attention}Kings{} or {C:attention}Jacks{}",
        	"remaining in your deck"
        }
    },
    --unlocked = false,
    --stupid thing wont work
    --[[check_for_unlock = function(self, args)
    	if G.deck ~= nil then
    		if G.deck.cards ~= nil then
				if #G.deck.cards > 0 then
					local no_men = true
					print("count")
					for i = 1, #G.deck.cards do
						local value = G.deck.cards[i].base.value
						print(value)
						if value == "Jack" or value == "King" then
							no_men = false
						else
							print("there are no men")
						end
					end
					if men then
						print("true")
					else
						print("false")
					end
					print(" ")
					return men
				end
			end
    	end
    end,]]--
    config = { extra = { added = 22, pool = 0 } },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    atlas = "jokers",
    pos = { x = 1, y = 1 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.added, card.ability.extra.pool } }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not SMODS.has_no_rank(context.other_card) then
            local value = context.other_card.base.value
            if value == "Jack" or value == "King" then
                if card.ability.extra.pool == nil then
                    card.ability.extra.pool = card.ability.extra.added
                else
                    card.ability.extra.pool = card.ability.extra.pool + card.ability.extra.added
                end
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        elseif context.individual and context.cardarea == G.play and not SMODS.has_no_rank(context.other_card) then
            local value = context.other_card.base.value
            if value == "Queen" and card.ability.extra.pool > 0 then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus =
                    context.other_card.ability.perma_bonus + card.ability.extra.pool
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        elseif context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.pool = 0
            return {
                message = localize("k_reset"),
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker {
	key = "celeste",
	loc_txt = {
		name = "Mountain Climber",
		text = {
			"When an {C:attention}Egg{} is sold, convert",
			"{C:attention}#1#{} random card held in hand",
			"to a {C:attention}Queen{} for every {C:money}$#2#{}",
			"of sell value the {C:attention}Egg{} had",
			--"(Currently )"
		}
	},
	config = {
		estrogen = 1,
		divider = 3
	},
	rarity = 2,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "jokers",
	pos = { x = 1, y = 2 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.estrogen, card.ability.divider } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card.config.center.key == "j_egg" then
			if #G.hand.cards > 0 then
				local hand_size = G.hand.config.card_limit
				local selected = { }
				for i = 1, #G.hand.cards do
					selected[i] = "c"
				end
				local count = math.floor((context.card.sell_cost / card.ability.divider) * card.ability.estrogen)
				if count > #G.hand.cards then
					count = #G.hand.cards
				end
				for i = 1, count do
					local card_index = math.floor(pseudorandom("madeline") * #G.hand.cards) + 1
					while selected[card_index] == "pt" do
						card_index = math.floor(pseudorandom("madeline") * #G.hand.cards) + 1
					end
					selected[card_index] = "pt"
				end
				
				for i = 1, #G.hand.cards do
					if selected[i] == "pt" then
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
				end
				delay(0.2)
				
				for i = 1, #G.hand.cards do
					if selected[i] == "pt" then
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.1,
							func = function()
								local suit_prefix = string.sub(G.hand.cards[i].base.suit, 1, 1)..'_'
								G.hand.cards[i]:set_base(G.P_CARDS[suit_prefix.."Q"])
								return true
							end
						}))
					end
				end
				
				for i = 1, #G.hand.cards do
					if selected[i] == "pt" then
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
				end
				delay(0.2)
				
				return {
					message = "Converted!",
					colour = G.C.CHIPS,
					playing_cards_created = { true }
				}
			end
		end
	end
}

SMODS.Joker {
    key = "punch_card",
    loc_txt = {
        name = "Punch Card",
        text = {
        	"For every {C:attention}#1# {C:inactive}[#2#]{} Blinds",
        	"skipped or defeated this",
            "run, sell this card to",
            "{C:attention}simulate{} skipping #3# Blind",
            "{C:inactive}(Currently {C:attention}#4#{C:inactive} #5#){}"
        }
    },
    config = {
    	wiggle_active = false,
    	extra = {
    		threshold = 3,
    		skipped = 0,
    		blind_count = 1
    	}
    },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    atlas = "jokers",
    pos = { x = 2, y = 1 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
    	info_queue[#info_queue + 1] = { set = "Other", key = "TWT_punch_card_idea" }
    	info_queue[#info_queue + 1] = { set = "Other", key = "TWT_punch_card_art" }
    
    	local fifth = ""
    	local count = math.floor(card.ability.extra.skipped / card.ability.extra.threshold) * card.ability.extra.blind_count
    	if count == 1 then
    		fifth = "Blind"
    	else
    		fifth = "Blinds"
    	end
        return {
        	vars = {
        		card.ability.extra.threshold,
        		card.ability.extra.skipped,
        		card.ability.extra.blind_count,
        		count,
        		fifth
        	}
        }
    end,
    load = function(self, card, card_table, other_card)
    	if card_table.ability.extra.skipped >= card_table.ability.extra.threshold then
			card_table.ability.wiggle_active = true
			local wiggle = function(card)
				return (card_table.ability.extra.skipped >= card_table.ability.extra.threshold)
			end
			juice_card_until(card, wiggle, true)
		end
    end,
    calculate = function(self, card, context)
    	if not context.blueprint then
			if context.skip_blind or (context.end_of_round and context.cardarea == G.jokers) then
				card.ability.extra.skipped = card.ability.extra.skipped + 1
				return {
					message = "Punch!",
					colour = G.C.IMPORTANT
				}
			elseif context.selling_self then
				local count = math.floor(card.ability.extra.skipped / card.ability.extra.threshold) * card.ability.extra.blind_count
				for i = 1, count do --card lifted basically directly from pickle in cryptid
					local tag = Tag(get_next_tag_key("twt_punch_card"))
					if tag.name == "Orbital Tag" then
						local _poker_hands = {}
						for k, v in pairs(G.GAME.hands) do
							if v.visible then
								_poker_hands[#_poker_hands + 1] = k
							end
						end
						tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("twt_punch_card_orbital"))
					end
					if tag.name == "Boss Tag" then
						i = i - 1 --reroll tags can break if a booster pack tag is generated
					else
						add_tag(tag)
					end
					G.GAME.skips = G.GAME.skips + 1
					
					card.ability.extra.skipped = card.ability.extra.skipped - 3
				end
				
				--these must be outside of the loop otherwise it looks strange
				local throwbacks = SMODS.find_card("j_throwback")
				for i = 1, #throwbacks do
					local throwback = throwbacks[i]
					G.E_MANAGER:add_event(
						Event({
							func = function() 
								card_eval_status_text(throwback, 'extra', nil, nil, nil, {
									message = localize{type = 'variable', key = 'a_xmult', vars = { throwback.ability.x_mult } },
									colour = G.C.RED,
									card = throwback
								}) 
								return true
							end
						})
					)
				end
				
				return {
					message = "Redeem!",
					colour = G.C.IMPORTANT
				}
			end
		end
		
		if card.ability.extra.skipped >= card.ability.extra.threshold and not card.ability.wiggle_active then
			print("gm")
			card.ability.wiggle_active = true
			local wiggle = function(card)
				return (card.ability.extra.skipped >= card.ability.extra.threshold)
			end
			juice_card_until(card, wiggle, true)
		end
    end
}

SMODS.Joker {
	key = "dyke",
	loc_txt = {
		name = "The Dykes",
		text = {
			"{X:mult,C:white}X#1#{} Mult if played",
			"hand contains",
			"a {C:attention}Polycule{}"
		},
		unlock = {
			"Win a run",
			"without playing",
			"a {C:attention}Polycule{}"
		},
	},
	config = { extra = { xmult = 2.5 } },
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "TWT_polycule" },
	rarity = 3,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "jokers",
	pos = { x = 0, y = 2 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["TWT_polycule"]) then
			return {
				message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } },
				Xmult_mod = card.ability.extra.xmult
			}
		end
	end
}

SMODS.Joker {
	key = "joker",
	loc_txt = {
		name = "Joker?",
		text = {
			"??????????"
		},
		unlock = {
			"In one hand,",
			"earn at least",
			"{C:attention}1e11{} chips"
		},
	},
	config = { extra = { mult = 1 } },
	unlocked = false,
	unlock_condition = {
		type = 'chip_score',
		chips = 100000000000
	},
	rarity = "TWT_lesbian",
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "jokers",
	pos = { x = 0, y = 3 },
	cost = 100,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	--[[set_ability = function(self, card, initial, delay_sprites)
		card:set_edition("e_negative", true)
	end,]]
	add_to_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			local joker = G.jokers.cards[i]
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							self = nil
							return true;
						end
					})) 
					return true
				end
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult } },
				mult_mod = card.ability.extra.mult
			}
		elseif context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
			for i = 1, #G.jokers.cards do
				local carb = G.jokers.cards[i]
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						carb.T.r = -0.2
						carb:juice_up(0.3, 0.4)
						carb.states.drag.is = true
						carb.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(carb)
								carb:remove()
								self = nil
								return true;
							end
						})) 
						return true
					end
				}))
			end
			return {
				message = "Died of lupus..."
			}
		end
	end
}