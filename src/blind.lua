SMODS.Blind {
    key = "man",
    loc_txt = {
        name = "The Man",
        text = {
        	"All Queens",
        	"are debuffed"
        },
    },
	dollars = 5,
	mult = 2,
	order = 1,
	boss = { min = 3, max = 10 },
	boss_colour = HEX("bcb502"),
	atlas = "blinds",
	pos = { x = 0, y = 0 },
	in_pool = function()
		local queen_count = 0
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].base.value == "Queen" then
					queen_count = queen_count + 1
				end
			end
		end
		return queen_count > 7 and G.GAME.round_resets.ante >= 2 --it can't show up as an ante 1 boss because that would be boring
	end,
	recalc_debuff = function(self, card, from_blind)
		return card.base.value == "Queen"
	end,
}

SMODS.Blind {
    key = "transphobe",
    loc_txt = {
        name = "The Transphobe",
        text = {
	        "Played Queens are",
        	"upgraded into Kings"
        },
    },
	dollars = 6,
	mult = 2,
	order = 2,
	boss = { min = 1, max = 10 },
	boss_colour = HEX("543117"),
	atlas = "blinds",
	pos = { x = 0, y = 1 },
	in_pool = function()
		local queen_count = 0
		local misandry = false
		local baron = false
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].base.value == "Queen" then
					queen_count = queen_count + 1
				end
			end
		end
		if next(SMODS.find_card("j_TWT_misandry")) then --this boss blind can only appear if you have the misandry joker, since it only really negatively affects this joker
			misandry = true
		end
		if next(SMODS.find_card("j_baron")) then --and it ALSO cant show up if you have baron. cause that would just make it too easy!
			baron = true
		end
		return queen_count > 11 and misandry and not baron
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		local flipped = { }
		for i = 1, #G.play.cards do
			if G.play.cards[i].base.value == "Queen" and not SMODS.has_no_suit(G.play.cards[i]) then
				flipped[i] = true
				local percent = 1.15 - (i-0.999)/(#G.play.cards-0.998)*0.3
				if G.play.cards[i].base.value == "Queen" then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.15,
						func = function()
							G.play.cards[i]:flip();
							play_sound('card1', percent);
							G.play.cards[i]:juice_up(0.3, 0.3);
							return true
						end
					}))
				end
			else
				flipped[i] = false
			end
		end
		delay(0.2)
		
		local _rank = "K"
		for i = 1, #G.play.cards do
			if G.play.cards[i].base.value == "Queen" then --this is intentional behavior, stone cards are stealth converted to kings if they are queens beneath the stone appearance
				G.E_MANAGER:add_event(Event({ --however, they aren't flipped so as to not reveal that they are queens underneath
					func = function()
						local suit_prefix = string.sub(G.play.cards[i].base.suit, 1, 1)..'_'
						local rank_suffix =_rank
						G.play.cards[i]:set_base(G.P_CARDS[suit_prefix..rank_suffix])
						return true
					end
				}))
			end
		end
		
		for i = 1, #G.play.cards do
			if flipped[i] then
				local percent = 0.85 + (1-0.999)/(#G.play.cards-0.998)*0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						G.play.cards[i]:flip();
						play_sound('tarot2', percent, 0.6);
						G.play.cards[i]:juice_up(0.3, 0.3);
						return true
					end
				}))
			end
		end
		return
	end
}

SMODS.Blind {
	key = "bush",
	loc_txt = {
		name = "The Flight",
		text = {
			"Scored Tower Cards",
			"always collapse"
		}
	},
	dollars = 5,
	mult = 2,
	order = 3,
	boss = { min = 4, max = 10 },
	boss_colour = HEX("0033a0"),
	atlas = "blinds",
	pos = { x = 0, y = 2 },
	in_pool = function()
		local tower_count = 0
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].config.center.name == "m_TWT_tower" then
					tower_count = tower_count + 1
				end
			end
		end
		return tower_count > 7 and G.GAME.round_resets.ante >= 2
	end,
    recalc_debuff = function(self, card, from_blind)
    	if card.config.center.name == "m_TWT_tower" then
    		if not card.ability.extra.nine_eleven then
				card.ability.extra.nine_eleven = true
			end
		end
		return false
	end,
	disable = function(self)
		for i = 1, #G.playing_cards do
			if G.playing_cards[i].config.center.name == "m_TWT_tower" then
				G.playing_cards[i].ability.extra.nine_eleven = false	
			end
		end
	end,
	defeat = function(self)
		for i = 1, #G.playing_cards do
			if G.playing_cards[i].config.center.name == "m_TWT_tower" then
				G.playing_cards[i].ability.extra.nine_eleven = false
			end
		end
	end
}

SMODS.Blind {
	key = "final_curse",
	loc_txt = {
		name = "Carmine Curse",
		text = {
			"-1 card selection limit"
		}
	},
	dollars = 10,
	mult = 1.7,
	order = 4,
	boss = {
		min = 3,
		max = 10,
		showdown = true
	},
	config = {
		minus = 1
	},
	boss_colour = HEX("DE3724"),
	atlas = "blinds",
	pos = { x = 0, y = 3 },
    set_blind = function(self)
    	G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - self.config.minus
	end,
	disable = function(self)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + self.config.minus
	end,
	defeat = function(self)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + self.config.minus
	end
}