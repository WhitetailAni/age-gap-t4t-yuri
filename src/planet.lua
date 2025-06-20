SMODS.Consumable {
    set = "Planet",
    key = "AshTwin",
    pos = { x = 0, y = 1 },
    atlas = "cards",
    config = { hand_type = "TWT_polycule" },
    cost = 3,
    loc_txt = {
        name = "Ash Twin",
        text = {
			"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
        	"{C:attention}#1#{}",
        	"{C:mult}+#3#{} Mult and",
        	"{C:chips}+#4# Chips{}"
        }
    },
    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
        level_up_hand(card, card.ability.consumeable.hand_type)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    loc_vars = function(self, info_queue, center)
        local levelone = G.GAME.hands["TWT_polycule"].level or 1
        local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
        if levelone == 1 then
            planetcolourone = G.C.UI.TEXT_DARK
        end
        return {
            vars = {
            	"Polycule",
                G.GAME.hands["TWT_polycule"].level,
				G.GAME.hands["TWT_polycule"].l_mult,
				G.GAME.hands["TWT_polycule"].l_chips,
                colours = { planetcolourone },
            },
        }
    end
}

SMODS.Consumable {
    set = "Planet",
    key = "EmberTwin",
    pos = { x = 1, y = 1 },
    atlas = "cards",
    config = { hand_type = "TWT_greaterpolycule", softlock = true },
    cost = 3,
    loc_txt = {
        name = "Ember Twin",
        text = {
			"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
        	"{C:attention}#1#{}",
        	"{C:mult}+#3#{} Mult and",
        	"{C:chips}+#4# Chips{}"
        }
    },
    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
        level_up_hand(card, card.ability.consumeable.hand_type)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    loc_vars = function(self, info_queue, center)
        local levelone = G.GAME.hands["TWT_greaterpolycule"].level or 1
        local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
        if levelone == 1 then
            planetcolourone = G.C.UI.TEXT_DARK
        end
        return {
            vars = {
            	"Greater Polycule",--localize("TWT_greaterpolycule"),
                G.GAME.hands["TWT_greaterpolycule"].level,
				G.GAME.hands["TWT_greaterpolycule"].l_mult,
				G.GAME.hands["TWT_greaterpolycule"].l_chips,
                colours = { planetcolourone },
            },
        }
    end
}
if (SMODS.Mods["Cryptid"] or {}).can_load then
	SMODS.Consumable {
		set = "Planet",
		key = "Eye",
		pos = { x = 11, y = 1 },
		atlas = "cards",
		config = { hand_type = "TWT_matriarchy", softlock = true },
		cost = 5,
		loc_txt = {
			name = "The Eye of the Universe",
			text = {
				"{S:0.8}{C:purple}({S:0.8,V:1}lvl.#2#{S:0.8}{C:purple}){} {C:purple}Level up{}",
				"{C:attention}#1#{}",
				"{C:mult}+#3#{} {C:purple}Mult and{}",
				"{C:chips}+#4# Chips{}"
			}
		},
		use = function(self, card, area, copier)
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
			level_up_hand(card, card.ability.consumeable.hand_type)
			update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
		end,
		loc_vars = function(self, info_queue, center)
			info_queue[#info_queue + 1] = { set = "Other", key = "TWT_eye" }
			local levelone = G.GAME.hands["TWT_matriarchy"].level or 1
			local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
			if levelone == 1 then
				planetcolourone = G.C.UI.TEXT_DARK
			end
			return {
				vars = {
					"Matriarchy", --localize("TWT_matriarchy"),
					G.GAME.hands["TWT_matriarchy"].level,
					G.GAME.hands["TWT_matriarchy"].l_mult,
					G.GAME.hands["TWT_matriarchy"].l_chips,
					colours = { planetcolourone },
				},
			}
		end
	}
end

--[[
SMODS.Consumable {
    set = "Planet",
    name = "timberhearth",
    key = "TimberHearth",
    pos = { x = 2, y = 1 },
    atlas = "cards",
    config = { hand_type = "TWT_constituency" },
    cost = 3,
    loc_txt = {
        name = "Timber Hearth",
        text = {
			"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
        	"{C:attention}#1#{}",
        	"{C:mult}+#3#{} Mult and",
        	"{C:chips}+#4# Chips{}"
        }
    },
    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
        level_up_hand(card, card.ability.consumeable.hand_type)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    loc_vars = function(self, info_queue, center)
        local levelone = G.GAME.hands["TWT_constituency"].level or 1
        local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
        if levelone == 1 then
            planetcolourone = G.C.UI.TEXT_DARK
        end
        return {
            vars = {
            	"Constituency",
                G.GAME.hands["TWT_constituency"].level,
				G.GAME.hands["TWT_constituency"].l_mult,
				G.GAME.hands["TWT_constituency"].l_chips,
                colours = { planetcolourone },
            },
        }
    end
}

SMODS.Consumable {
    set = "Planet",
    name = "brittlehollow",
    key = "BrittleHollow",
    pos = { x = 3, y = 1 },
    atlas = "cards",
    config = { hand_type = "TWT_reformedconstituency" },
    cost = 3,
    loc_txt = {
        name = "Brittle Hollow",
        text = {
			"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
        	"{C:attention}#1#{}",
        	"{C:mult}+#3#{} Mult and",
        	"{C:chips}+#4# Chips{}"
        }
    },
    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
        level_up_hand(card, card.ability.consumeable.hand_type)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    loc_vars = function(self, info_queue, center)
        local levelone = G.GAME.hands["TWT_reformedconstituency"].level or 1
        local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
        if levelone == 1 then
            planetcolourone = G.C.UI.TEXT_DARK
        end
        return {
            vars = {
            	"Constituency",
                G.GAME.hands["TWT_reformedconstituency"].level,
				G.GAME.hands["TWT_reformedconstituency"].l_mult,
				G.GAME.hands["TWT_reformedconstituency"].l_chips,
                colours = { planetcolourone },
            },
        }
    end
}

SMODS.Consumable {
    set = "Planet",
    name = "attlerock",
    key = "Attlerock",
    pos = { x = 2, y = 1 },
    atlas = "cards",
    config = { hand_type = "TWT_brick" },
    cost = 3,
    loc_txt = {
        name = "The Attlerock",
        text = {
			"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
        	"{C:attention}#1#{}",
        	"{C:mult}+#3#{} Mult and",
        	"{C:chips}+#4# Chips{}"
        }
    },
    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, { handname=localize(card.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[card.ability.consumeable.hand_type].chips, mult = G.GAME.hands[card.ability.consumeable.hand_type].mult, level=G.GAME.hands[card.ability.consumeable.hand_type].level })
        level_up_hand(card, card.ability.consumeable.hand_type)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    loc_vars = function(self, info_queue, center)
        local levelone = G.GAME.hands[card.ability.consumeable.hand_type].level or 1
        local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
        if levelone == 1 then
            planetcolourone = G.C.UI.TEXT_DARK
        end
        return {
            vars = {
            	"Brick",
                G.GAME.hands[card.ability.consumeable.hand_type].level,
				G.GAME.hands[card.ability.consumeable.hand_type].l_mult,
				G.GAME.hands[card.ability.consumeable.hand_type].l_chips,
                colours = { planetcolourone },
            },
        }
    end
}

]]--