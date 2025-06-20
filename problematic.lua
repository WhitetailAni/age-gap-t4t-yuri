local lovely = require("lovely")

local path = SMODS.current_mod.path..'src/'
for _,v in pairs(NFS.getDirectoryItems(path)) do
	assert(SMODS.load_file('src/'..v))()
end

problematic = SMODS.current_mod
problematic.config_storage = {
	phobia = 1,
	orange_man = false
}
if NFS.read(SMODS.current_mod.path.."config.lua") then
    local file = STR_UNPACK(NFS.read(SMODS.current_mod.path.."config.lua"))
    problematic.config_file = file
    problematic.config_storage = file
end

function updateHands(value)
	if G and G.localization and G.localization.misc and G.localization.misc.poker_hands then
		if value then
			G.localization.misc.poker_hands['Flush Five'] = "Flush Fivesome"
			G.localization.misc.poker_hands['Flush House'] = "Dr. Greg House"
			G.localization.misc.poker_hands['Five of a Kind'] = "Fivesome"
			G.localization.misc.poker_hands['Straight Flush'] = "Lesbian Flush"
			G.localization.misc.poker_hands['Four of a Kind'] = "Foursome"
			G.localization.misc.poker_hands['Straight'] = "Lesbian"
			G.localization.misc.poker_hands['Three of a Kind'] = "Threesome"
			G.localization.misc.poker_hands['Pair'] = "Twosome"
			
			G.localization.descriptions.Joker.j_runner.text={
				"Gains {C:chips}+#2#{} Chips",
				"if played hand",
				"contains a {C:attention}Lesbian{}",
				"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
			}
			
			G.localization.descriptions.Edition.e_foil.name = "Feline"
			G.localization.descriptions.Edition.e_holo.name = "Homographic"
			G.localization.descriptions.Edition.e_polychrome.name = "Puppychrome"
			
			G.localization.descriptions.Tarot.c_wheel_of_fortune.text = {
				"{C:green}#1# in #2#{} chance to add",
				"{C:dark_edition}Feline{}, {C:dark_edition}Homographic{}, or",
				"{C:dark_edition}Puppychrome{} edition",
				"to a random {C:attention}Joker"
            }
            G.localization.descriptions.Spectral.c_aura.text = {
				"Add {C:dark_edition}Feline{}, {C:dark_edition}Homographic{},",
				"or {C:dark_edition}Puppychrome{} effect to",
				"{C:attention}1{} selected card in hand"
			}
			G.localization.descriptions.Spectral.c_hex.text = {
				"Add {C:dark_edition}Puppychrome{} to a",
				"random {C:attention}Joker{}, destroy",
				"all other Jokers"
            }
            
            G.localization.descriptions.Tag.tag_foil.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Feline"
			}
            G.localization.descriptions.Tag.tag_holo.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Homographic"
			}
            G.localization.descriptions.Tag.tag_polychrome.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Puppychrome"
			}
			
			G.localization.descriptions.Voucher.v_glow_up.text = {
				"{C:dark_edition}Feline{}, {C:dark_edition}Homographic{}, and",
				"{C:dark_edition}Puppychrome{} cards",
				"appear {C:attention}#1#X{} more often"
			}
			G.localization.descriptions.Voucher.v_hone.text = {
				"{C:dark_edition}Feline{}, {C:dark_edition}Homographic{}, and",
				"{C:dark_edition}Puppychrome{} cards",
				"appear {C:attention}#1#X{} more often"
			}
			
			G.localization.descriptions.Voucher.v_glow_up.unlock = {
				"Have at least {C:attention}#1#",
				"{C:attention}Joker{} cards with",
				"{C:dark_edition}Feline{}, {C:dark_edition}Homographic{}, or",
				"{C:dark_edition}Puppychrome{} edition"
			}
			
			G.localization.misc.labels.foil = "Feline"
			G.localization.misc.labels.holographic = "Homographic"
			G.localization.misc.labels.polychrome = "Puppychrome"
		else
			G.localization.misc.poker_hands['Flush Five'] = "Flush Five"
			G.localization.misc.poker_hands['Flush House'] = "Flush House"
			G.localization.misc.poker_hands['Five of a Kind'] = "Five of a Kind"
			G.localization.misc.poker_hands['Straight Flush'] = "Straight Flush"
			G.localization.misc.poker_hands['Four of a Kind'] = "Four of a Kind"
			G.localization.misc.poker_hands['Straight'] = "Straight"
			G.localization.misc.poker_hands['Three of a Kind'] = "Three of a Kind"
			G.localization.misc.poker_hands['Pair'] = "Pair"
			
			G.localization.descriptions.Joker.j_runner.text={
				"Gains {C:chips}+#2#{} Chips",
				"if played hand",
				"contains a {C:attention}Straight{}",
				"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
			}
			
			G.localization.descriptions.Edition.e_foil.name = "Foil"
			G.localization.descriptions.Edition.e_holo.name = "Holographic"
			G.localization.descriptions.Edition.e_polychrome.name = "Polychrome"
			
			G.localization.descriptions.Tarot.c_wheel_of_fortune.text = {
				"{C:green}#1# in #2#{} chance to add",
				"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
				"{C:dark_edition}Polychrome{} edition",
				"to a random {C:attention}Joker"
            }
            G.localization.descriptions.Spectral.c_aura.text = {
				"Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
				"or {C:dark_edition}Polychrome{} effect to",
				"{C:attention}1{} selected card in hand",
			}
			G.localization.descriptions.Spectral.c_hex.text = {
				"Add {C:dark_edition}Polychrome{} to a",
				"random {C:attention}Joker{}, destroy",
				"all other Jokers",
            }
            
            G.localization.descriptions.Tag.tag_foil.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Foil",
			}
            G.localization.descriptions.Tag.tag_holo.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Holographic",
			}
            G.localization.descriptions.Tag.tag_polychrome.text = {
				"Next base edition shop",
				"Joker is free and",
				"becomes {C:dark_edition}Polychrome",
			}
			
			G.localization.descriptions.Voucher.v_glow_up.text = {
				"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and",
				"{C:dark_edition}Polychrome{} cards",
				"appear {C:attention}#1#X{} more often",
			}
			G.localization.descriptions.Voucher.v_hone.text = {
				"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and",
				"{C:dark_edition}Polychrome{} cards",
				"appear {C:attention}#1#X{} more often",
			}
			
			G.localization.descriptions.Voucher.v_glow_up.unlock = {
				"Have at least {C:attention}#1#",
				"{C:attention}Joker{} cards with",
				"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
				"{C:dark_edition}Polychrome{} edition",
			}
			
			G.localization.misc.labels.foil = "Foil"
			G.localization.misc.labels.holographic = "Holographic"
			G.localization.misc.labels.polychrome = "Polychrome"
		end
	end
end

SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK
		},
		nodes = {
			create_option_cycle({
				label = "fear selector",
				scale = 0.8,
				w = 6,
				options = { "heterophobia", "homophobia" },
				opt_callback = "twt_hand_replace",
				current_option = problematic.config_file.funny_names,
				opt_callback = "problematic_update_hands"
			}),
			create_toggle({
				label = "orange man",
				ref_table = problematic.config_storage,
				ref_value = "orange_man",
				callback = function(_set_toggle)
					NFS.write(lovely.mod_dir .. "/problematic/config.lua", STR_PACK(problematic.config_storage))
					SMODS.restart_game()
				end
			}),
		}
	}
end

G.FUNCS.problematic_update_hands = function(e)
	updateHands(e.to_key == 1)
	problematic.config_storage.phobia = e.to_key
	NFS.write(lovely.mod_dir .. "/problematic/config.lua", STR_PACK(problematic.config_storage))
end

updateHands(problematic.config_file.phobia == 1)

SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 28,
    py = 28
}

SMODS.Atlas {
    key = "cards",
    path = "cards.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "blinds",
    path = "blinds.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34,
    frames = 21
}

SMODS.Atlas {
    key = "upgrades",
    path = "upgrades.png",
    px = 71,
    py = 95 --future me
}

SMODS.Atlas {
    key = "vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "seals",
    path = "seals.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95
}

if problematic.config_file.orange_man then
	SMODS.Back {
		key = "aristocracy",
		pos = { x = 1, y = 3 },
		config = { 
			ante_scaling = 1.5,
			ante_win = 10,
			king_count = 5,
			queen_count = 3
		},
		loc_txt = {
			name = "Aristocratic Deck",
			text={
				"Start run with only",
				"{C:attention}Face Cards{} in your deck",
				--"in your deck",
				"{C:mult}X#1#{} base blind size,",
				"winning ante is {C:attention}#2#"
			},
		},
		loc_vars = function(self, info_queue, card)
			return { vars = { self.config.ante_scaling, self.config.ante_win } }
		end,
		unlocked = false,
		atlas = "decks",
		pos = { x = 0, y = 0 },
		unlock_condition = {
			type = 'win_stake',
			stake = 8
		},
		apply = function(self)
			G.GAME.win_ante = 10
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.perscribed_bosses[8] = "bl_final_vessel" --sshhhhh
					local king = "King"
					local queen = "Queen"
					local jack = "Jack"
					local counts = {
						heart = {
							king = 0,
							queen = 0
						},
						spade = {
							king = 0,
							queen = 0
						},
						club = {
							king = 0,
							queen = 0
						},
						diamond = {
							king = 0,
							queen = 0
						}
					}
					for i = 1, #G.playing_cards do
						local card = G.playing_cards[i]
						if card.base.suit == "Hearts" then
							if counts.heart.king >= self.config.king_count then
								if counts.heart.queen >= self.config.queen_count then
									SMODS.change_base(card, nil, jack)
								else
									counts.heart.queen = counts.heart.queen + 1
									SMODS.change_base(card, nil, queen)
								end
							else
								counts.heart.king = counts.heart.king + 1
								SMODS.change_base(card, nil, king)
							end
						elseif card.base.suit == "Spades" then
							if counts.spade.king >= self.config.king_count then
								if counts.spade.queen >= self.config.queen_count then
									SMODS.change_base(card, nil, jack)
								else
									SMODS.change_base(card, nil, queen)
								end
							else
								counts.spade.king = counts.spade.king + 1
								SMODS.change_base(card, nil, king)
							end
						elseif card.base.suit == "Clubs" then
							if counts.club.king >= self.config.king_count then
								if counts.club.queen >= self.config.queen_count then
									SMODS.change_base(card, nil, jack)
								else
									counts.club.queen = counts.club.queen + 1
									SMODS.change_base(card, nil, queen)
								end
							else
								counts.club.king = counts.club.king + 1
								SMODS.change_base(card, nil, king)
							end
						elseif card.base.suit == "Diamonds" then
							if counts.diamond.king >= self.config.king_count then
								if counts.diamond.queen >= self.config.queen_count then
									SMODS.change_base(card, nil, jack)
								else
									counts.diamond.queen = counts.diamond.queen + 1
									SMODS.change_base(card, nil, queen)
								end
							else
								counts.diamond.king = counts.diamond.king + 1
								SMODS.change_base(card, nil, king)
							end
						end
					end
					return true
				end
			}))
		end
	}
end

SMODS.Rarity {
	key = "lesbian",
	loc_txt = {
		name = "Lesbian"
	},
	badge_colour = HEX('EF7627'),
	default_weight = 100,
}