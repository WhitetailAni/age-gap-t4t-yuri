local function xor(first, second)
	return (first and not second) or (second and not first)
end

SMODS.PokerHand {
    key = "polycule",
    mult = 2,
    chips = 15,
    l_mult = 1.5,
    l_chips = 15,
    example = {
        { 'S_Q', true },
        { 'H_Q', true },
        { 'H_7', true },
        { 'C_K', false },
        { 'D_3', false }
    },
    loc_txt = {
        name = "Polycule",
        description = { "3 scoring cards, 2 must share the", "same rank and 2 must share the same suit" },
    },
    visible = true,
    evaluate = function(parts, hand)
        if #hand < 3 then return false end
        for i = 1, #hand - 2 do
            for j = i + 1, #hand - 1 do
                for k = j + 1, #hand do
                
                	--trust me, really, this is the best way i found i know it's horrible. i know it's awful. i know it's the worst thing ever.
                	--but can you think of a better way?
                
                	local card1 = hand[i]
                    local card2 = hand[j]
                	local card3 = hand[k]
                
                    local rank1 = card1.base.value
                    local rank2 = card2.base.value
                    local rank3 = card3.base.value

                    local suit1 = card1.base.suit
                    local suit2 = card2.base.suit
                    local suit3 = card3.base.suit
                    
                    local one_two_stone = SMODS.has_no_suit(card1) or SMODS.has_no_rank(card1) or SMODS.has_no_suit(card2) or SMODS.has_no_rank(card2)
                    local two_three_stone = SMODS.has_no_suit(card2) or SMODS.has_no_rank(card2) or SMODS.has_no_suit(card3) or SMODS.has_no_rank(card3)
                    local one_three_stone = SMODS.has_no_suit(card1) or SMODS.has_no_rank(card1) or SMODS.has_no_suit(card3) or SMODS.has_no_rank(card3)
                    
                    local suit_one_two_raw = (suit1 == suit2) 
                    local suit_two_three_raw = (suit2 == suit3)
                    local suit_one_three_raw = (suit1 == suit3)
                    
                    local wild_one = SMODS.has_any_suit(card1)
                    local wild_two = SMODS.has_any_suit(card2)
                    local wild_three = SMODS.has_any_suit(card3)
                    
                    local suit_one_two = (suit_one_two_raw or xor(wild_one, wild_two)) and not (suit_two_three_raw or suit_one_three_raw) and not one_two_stone and not (wild_one and wild_two)
                    local suit_two_three = (suit_two_three_raw or xor(wild_two, wild_three)) and not (suit_one_three_raw or suit_one_two_raw) and not two_three_stone and not (wild_two and wild_three)
                    local suit_one_three = (suit_one_three_raw or xor(wild_one, wild_three)) and not (suit_one_two_raw or suit_two_three_raw) and not one_three_stone and not (wild_one and wild_three)
                                        
                    local rank_one_two_raw = (rank1 == rank2)
                    local rank_two_three_raw = (rank2 == rank3)
                    local rank_one_three_raw = (rank1 == rank3)
                    
                    local rank_one_two = rank_one_two_raw and not (rank_two_three_raw or rank_one_three_raw)
                    local rank_two_three = rank_two_three_raw and not (rank_one_two_raw or rank_one_three_raw)
                    local rank_one_three = rank_one_three_raw and not (rank_one_two_raw or rank_two_three_raw)
                    
					local first_case = suit_one_two and rank_two_three
					local second_case = suit_two_three and rank_one_three
					local third_case = suit_one_three and rank_two_three
					local fourth_case = suit_one_two and rank_one_three
					local fifth_case = suit_one_three and rank_one_two
					local sixth_case = suit_two_three and rank_one_two
                    
                    if first_case or second_case or third_case or fourth_case or fifth_case or sixth_case then
                        return { { hand[i], hand[j], hand[k] } }
                    end
                end
            end
        end
        return false
    end,
}

SMODS.PokerHand {
    key = "greaterpolycule",
    mult = 20,
    chips = 200,
    l_mult = 5,
    l_chips = 75,
    example = {
        { 'H_Q', true },
        { 'H_Q', true },
        { 'H_Q', true },
        { 'H_Q', true },
        { 'H_Q', true }
    },
    loc_txt = {
        name = "Greater Polycule",
        description = { "Five Queens with the same suit." },
    },
    visible = false,
    evaluate = function(parts, hand)
    if #hand < 5 or #hand > 5 then return false end
        for i = 1, #hand - 4 do
            for j = i + 1, #hand - 3 do
                for k = j + 1, #hand - 2 do
                    for l = k + 1, #hand - 1 do
                        for m = l + 1, #hand do
                        	local index_array = { i, j, k, l, m }
                        
                        	local card1 = hand[i]
                        	local card2 = hand[j]
                        	local card3 = hand[k]
                        	local card4 = hand[l]
                        	local card5 = hand[m]
                        
                            local rank1 = card1.base.value
                            local rank2 = card2.base.value
                            local rank3 = card3.base.value
                            local rank4 = card4.base.value
                            local rank5 = card5.base.value
                            
                            local suit1 = card1.base.suit
                            local suit2 = card2.base.suit
                            local suit3 = card3.base.suit
                            local suit4 = card4.base.suit
                            local suit5 = card5.base.suit
                            
                            local selection = { card1, card2, card3, card4, card5 }
                            local pecking_order = { rank1, rank2, rank3, rank4, rank5 }
                            local management_office = { suit1, suit2, suit3, suit4, suit5 }
                            local wild = { false, false, false, false, false }
                            
							for i = 1, 5 do --makes sure all queens, and no stones
								if pecking_order[i] ~= "Queen" or SMODS.has_no_rank(selection[i]) or SMODS.has_no_suit(selection[i]) then
									return { }
								end
							end
							
							for i = 1, #management_office do
								if SMODS.has_any_suit(selection[i]) then
									wild[i] = true
								end
							end
							
							local first = "Error"
							local found = false
							for i = 1, #management_office do
								if found then
									break
								end
								if not wild[i] then
									found = true
									first = management_office[i]
								end
							end
							for i = 1, #management_office do
								if not wild[i] and management_office[i] ~= first then
									return { }
								end
							end
							return { hand }
                        end
                    end
                end
            end
        end
        return false
    end,
}

if (SMODS.Mods["Cryptid"] or {}).can_load then
	SMODS.PokerHand {
		key = "matriarchy",
		mult = 2000000,
		chips = 20000000,
		l_mult = 200000,
		l_chips = 2000000,
		example = {
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true },
			{ 'H_Q', true }
		},
		loc_txt = {
			name = "Matriarchy",
			description = { "The power of girls is unbounded.", "Fifty-two Queens of the same suit" },
		},
		visible = false,
		evaluate = function(parts, hand)
		if #hand < 52 then return false end --its not my problem if you cant play 52 cards!
			local first_suit = hand[1].base.suit
			for i = 1, #hand do
				if hand[i].base.value ~= "Queen" or SMODS.has_no_rank(hand[i]) then
					return { }
				end
	
				if hand[i].base.suit ~= first_suit and not SMODS.has_any_suit(hand[i]) then
					return { }
				end
			end
			return { hand }
		end,
	}
end

--[[
SMODS.PokerHand {
    key = "constituency",
    mult = 0.4,
    chips = 4,
    l_mult = 0.2,
    l_chips = 2.5,
    example = {
        { 'H_K', true },
        { 'D_K', true },
        { 'C_J', true },
        { 'S_J', true },
        { 'D_J', true }
    },
    loc_txt = {
        name = "Constituency",
        description = {
        	"A Three of a Kind and a Pair",
        	"with only Kings and Jacks"
        },
    },
    visible = true,
    evaluate = function(parts, hand)
    if #hand < 5 then return false end
        for i = 1, #hand - 4 do
            for j = i + 1, #hand - 3 do
                for k = j + 1, #hand - 2 do
                    for l = k + 1, #hand - 1 do
                        for m = l + 1, #hand do
                        	local index_array = { i, j, k, l, m }
                        
                        	local card1 = hand[i]
                        	local card2 = hand[j]
                        	local card3 = hand[k]
                        	local card4 = hand[l]
                        	local card5 = hand[m]
                        
                            local rank1 = card1.base.value
                            local rank2 = card2.base.value
                            local rank3 = card3.base.value
                            local rank4 = card4.base.value
                            local rank5 = card5.base.value=
                            
                            local selection = { card1, card2, card3, card4, card5 }
                            local pecking_order = { rank1, rank2, rank3, rank4, rank5 }
                            
							for i = 1, 5 do --makes sure all kings/jacks, and no stones
								if pecking_order[i] ~= "King" or pecking_order ~= "Jack" or SMODS.has_no_rank(selection[i]) then
									return { }
								end
							end
							
							local king_count = 0
							local jack_count = 0
							for i = 1, #pecking_order do
								if pecking_order[i] == "King" then
									king_count = king_count + 1
								end
								if pecking_order[i] == "Jack" then
									jack_count = jack_count + 1
								end
							end
							if king_count >= 4 or jack_count >= 4 then
								return { }
							end
							return { hand }
                        end
                    end
                end
            end
        end
        return false
    end,
}

SMODS.PokerHand {
    key = "reformedconstituency",
    mult = 1.4,
    chips = 14,
    l_mult = 0.4,
    l_chips = 4,
    example = {
        { 'C_K', true },
        { 'C_K', true },
        { 'C_K', true },
        { 'C_J', true },
        { 'C_J', true }
    },
    loc_txt = {
        name = "Reformed Constituency",
        description = {
        	"A Three of a Kind and a Pair",
        	"with only Kings and Jacks",
        	"and all cards sharing the same suit"
        },
    },
    visible = true,
    evaluate = function(parts, hand)
    if #hand < 5 then return false end
        for i = 1, #hand - 4 do
            for j = i + 1, #hand - 3 do
                for k = j + 1, #hand - 2 do
                    for l = k + 1, #hand - 1 do
                        for m = l + 1, #hand do
                        	local index_array = { i, j, k, l, m }
                        
                        	local card1 = hand[i]
                        	local card2 = hand[j]
                        	local card3 = hand[k]
                        	local card4 = hand[l]
                        	local card5 = hand[m]
                        
                            local rank1 = card1.base.value
                            local rank2 = card2.base.value
                            local rank3 = card3.base.value
                            local rank4 = card4.base.value
                            local rank5 = card5.base.value
                            
                            local suit1 = card1.base.suit
                            local suit2 = card2.base.suit
                            local suit3 = card3.base.suit
                            local suit4 = card4.base.suit
                            local suit5 = card5.base.suit
                            
                            local selection = { card1, card2, card3, card4, card5 }
                            local pecking_order = { rank1, rank2, rank3, rank4, rank5 }
                            local management_office = { suit1, suit2, suit3, suit4, suit5 }
                            
							for i = 1, 5 do --makes sure all kings/jacks, and no stones
								if pecking_order[i] ~= "King" or pecking_order ~= "Jack" or SMODS.has_no_rank(selection[i]) then
									return { }
								end
							end
							
							local king_count = 0
							local jack_count = 0
							for i = 1, #pecking_order do
								if pecking_order[i] == "King" then
									king_count = king_count + 1
								end
								if pecking_order[i] == "Jack" then
									jack_count = jack_count + 1
								end
							end
							if king_count >= 4 or jack_count >= 4 then
								return { }
							end
							
							local first = management_office[1]
							for i = 2, #management_office do
								if not SMODS.has_any_suit(selection[i]) and management_office[i] ~= first then
									return { }
								end
							end
							
							return { hand }
                        end
                    end
                end
            end
        end
        return false
    end,
}

SMODS.PokerHand {
    key = "brick",
    mult = 1,
    chips = 10,
    l_mult = 1,
    l_chips = 15,
    example = {
        { 'H_S', true }
    },
    loc_txt = {
        name = "Brick",
        description = { "A single Stone Card and nothing else" },
    },
    visible = false,
    evaluate = function(parts, hand)
    if #hand > 1 then return false end --its not my problem if you cant play 52 cards!
    	if not SMODS.has_no_rank(hand[1]) and SMODS.has_no_suit(hand[1]) then
        	return { }
        end
        return { hand }
    end,
}

]]--