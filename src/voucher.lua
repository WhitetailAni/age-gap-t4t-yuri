SMODS.Voucher {
	key = "closet",
	loc_txt = {
 		name = "Closet",
 		text = { "{C:inactive}Self-discovery is a{}", "{C:inactive}journey, I suppose.{}" },
 	},
 	config = {
 		more = 1
 	},
    requires = { "v_blank" },
    redeem = function(self)
  		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + self.config.more
	end,
	unredeem = function(self)
  		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - self.config.more
		if G.hand.config.highlighted_limit < 5 then
			G.hand.config.highlighted_limit = 5
		end
		G.hand:unhighlight_all()
	end,
 	atlas = "vouchers",
 	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = false,
	cost = 10,
 	order = 1
}

SMODS.Voucher {
	key = "diy",
	loc_txt = {
 		name = "DIY",
 		text = {
 			"Increases consumable",
 			"card selection limits by {C:attention}#1#{}",
 			"{C:inactive}(Does not work with other mods!){}"
 		},
 		unlock = {
			"Redeem Closet",
			"{C:attention}5{} total times",
			"{C:inactive}(#2#){}"
		},
 	},
 	config = {
 		more = 1
 	},
 	--[[unlocked = false,
 	unlock_condition = { type = "TWT_closet_redeems", extra = 5 },]]--
 	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.more,  } }
    end,
    requires = { "v_TWT_closet" },
    redeem = function(self)
    	G.GAME.select_more = G.GAME.select_more + self.config.more
	end,
	unredeem = function(self)
		G.GAME.select_more = G.GAME.select_more - self.config.more
	end,
 	atlas = "vouchers",
 	pos = { x = 1, y = 0 },
	unlocked = true,
	discovered = false,
	cost = 25,
 	order = 2
}