local atlasedition = {
	object_type = "Atlas",
	key = "atlaseditiondeck",
	path = "atlaseditiondeck.png",
	px = 71,
	py = 95,
}

Cryptid.edeck_sprites = {
	edition = {
		order = 1,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		foil = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 0 } },
		holo = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 0 } },
		polychrome = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 0 } },
		negative = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 0 } },
		cry_glitched = { atlas = "cry_atlaseditiondeck", pos = { x = 4, y = 0 } },
		cry_mosaic = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 1 } },
		cry_oversat = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 1 } },
		cry_glass = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 1 } },
		cry_gold = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 1 } },
		cry_blur = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 2 } },
		cry_noisy = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 2 } },
		cry_astral = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 2 } },
		cry_m = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 2 } },
	},
	enhancement = {
		order = 2,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		m_bonus = { atlas = "cry_atlasdeck", pos = { x = 3, y = 3 } },
		m_mult = { atlas = "cry_atlasdeck", pos = { x = 2, y = 3 } },
		m_wild = { atlas = "cry_atlasdeck", pos = { x = 5, y = 3 } },
		m_glass = { atlas = "cry_atlasdeck", pos = { x = 4, y = 3 } },
		m_steel = { atlas = "cry_atlasdeck", pos = { x = 8, y = 4 } },
		m_stone = { atlas = "cry_atlasdeck", pos = { x = 6, y = 4 } },
		m_gold = { atlas = "cry_atlasdeck", pos = { x = 7, y = 4 } },
		m_lucky = { atlas = "cry_atlasdeck", pos = { x = 6, y = 3 } },
		m_cry_echo = { atlas = "cry_atlasdeck", pos = { x = 1, y = 5 } },
		m_cry_light = { atlas = "cry_atlasdeck", pos = { x = 7, y = 3 } },
	},
	sticker = {
		order = 3,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		eternal = { atlas = "cry_atlasdeck", pos = { x = 6, y = 0 } },
		perishable = { atlas = "cry_atlasdeck", pos = { x = 7, y = 0 } },
		rental = { atlas = "cry_atlasdeck", pos = { x = 8, y = 0 } },
		pinned = { atlas = "cry_atlasdeck", pos = { x = 7, y = 1 } },
		banana = { atlas = "cry_atlasdeck", pos = { x = 6, y = 1 } },
		cry_rigged = { atlas = "cry_atlasdeck", pos = { x = 8, y = 1 } },
		cry_absolute = { atlas = "cry_atlasdeck", pos = { x = 8, y = 2 } },
		cry_possessed = { atlas = "cry_atlasdeck", pos = { x = 7, y = 2 } },
		cry_flickering = { atlas = "cry_atlasdeck", pos = { x = 6, y = 2 } },
	},
	suit = {
		order = 4,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		Diamonds = { atlas = "cry_atlasdeck", pos = { x = 2, y = 1 } },
		Hearts = { atlas = "cry_atlasdeck", pos = { x = 3, y = 1 } },
		Spades = { atlas = "cry_atlasdeck", pos = { x = 4, y = 1 } },
		Clubs = { atlas = "cry_atlasdeck", pos = { x = 5, y = 1 } },
	},
	seal = {
		order = 5,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		Gold = { atlas = "cry_atlasdeck", pos = { x = 3, y = 2 } },
		Red = { atlas = "cry_atlasdeck", pos = { x = 0, y = 2 } },
		Blue = { atlas = "cry_atlasdeck", pos = { x = 2, y = 2 } },
		Purple = { atlas = "cry_atlasdeck", pos = { x = 1, y = 2 } },
		cry_azure = { atlas = "cry_atlasdeck", pos = { x = 8, y = 3 } },
		cry_green = { atlas = "cry_atlasdeck", pos = { x = 3, y = 5 } },
	},
}

Cryptid.edeck_atlas_update = function(self)
	local sprite = Cryptid.edeck_sprites[self.edeck_type]
	if not sprite then
		error(self.edeck_type)
	end
	local enh_info = { Cryptid.enhanced_deck_info(G.cry_edeck_center and self or {}) }
	sprite = sprite[enh_info[sprite.order]] or sprite.default
	self.atlas, self.pos = sprite.atlas, sprite.pos
	return sprite
end

local e_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Edition Deck",
	key = "e_deck",
	order = 20,
	pos = { x = 5, y = 2 },
	loc_vars = function(self, info_queue, center)
		local aaa = Cryptid.enhanced_deck_info(G.cry_edeck_center and self or {})
		return { vars = { localize({ type = "name_text", set = "Edition", key = "e_" .. aaa }) } }
	end,
	edeck_type = "edition",
	config = { cry_no_edition_price = true },
	apply = function(self)
		local aaa = Cryptid.enhanced_deck_info({})
		G.GAME.modifiers.cry_force_edition = aaa
		--Ban Edition tags (They will never redeem)
		for k, v in pairs(G.P_TAGS) do
			if v.config and v.config.edition then
				G.GAME.banned_keys[k] = true
			end
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					G.playing_cards[c]:set_edition(aaa, true, true)
				end
				return true
			end,
		}))
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "discover_amount" then
			if G.DISCOVER_TALLIES.editions.tally / G.DISCOVER_TALLIES.editions.of >= 1 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local et_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Enhancement Deck",
	key = "et_deck",
	order = 21,
	pos = { x = 5, y = 2 },
	edeck_type = "enhancement",
	config = {},
	loc_vars = function(self, info_queue, center)
		local _, bbb = Cryptid.enhanced_deck_info(self)
		return { vars = { localize({ type = "name_text", set = "Enhanced", key = bbb }) } }
	end,
	apply = function(self)
		local aaa, bbb = Cryptid.enhanced_deck_info(self)
		G.GAME.modifiers.cry_force_enhancement = bbb
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					G.playing_cards[c]:set_ability(G.P_CENTERS[bbb])
				end
				return true
			end,
		}))
	end,
	draw = cry_edeck_draw,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_vacuum" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local sk_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Sticker Deck",
	key = "sk_deck",
	order = 22,
	pos = { x = 5, y = 2 },
	edeck_type = "sticker",
	config = {},
	loc_vars = function(self, info_queue, center)
		local _, _, ccc = Cryptid.enhanced_deck_info(self)
		if ccc == "pinned" then
			ccc = "pinned_left"
		end
		return { vars = { localize({ type = "name_text", set = "Other", key = ccc }) } }
	end,
	apply = function(self)
		local aaa, bbb, ccc = Cryptid.enhanced_deck_info(self)
		G.GAME.modifiers.cry_force_sticker = ccc
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					G.playing_cards[c].config.center.eternal_compat = true
					G.playing_cards[c].config.center.perishable_compat = true
					if SMODS.Stickers[ccc] and SMODS.Stickers[ccc].apply then
						SMODS.Stickers[ccc]:apply(G.playing_cards[c], true)
					else
						G.playing_cards[c]["set_" .. ccc](G.playing_cards[c], true)
					end
				end
				return true
			end,
		}))
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_lock" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local st_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Suit Deck",
	key = "st_deck",
	config = {},
	order = 23,
	pos = { x = 5, y = 2 },
	edeck_type = "suit",
	loc_vars = function(self, info_queue, center)
		local _, _, _, ddd = Cryptid.enhanced_deck_info(self)
		return { vars = { localize(ddd, "suits_plural") } }
	end,
	apply = function(self)
		local aaa, bbb, ccc, ddd = Cryptid.enhanced_deck_info(self)
		if ddd == "Spades" then
			G.GAME.bosses_used["bl_goad"] = 1e308
		elseif ddd == "Hearts" then
			G.GAME.bosses_used["bl_head"] = 1e308
		elseif ddd == "Clubs" then
			G.GAME.bosses_used["bl_club"] = 1e308
		elseif ddd == "Diamonds" then
			G.GAME.bosses_used["bl_window"] = 1e308
		end
		G.GAME.modifiers.cry_force_suit = ddd
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					G.playing_cards[c]:change_suit(ddd)
				end
				return true
			end,
		}))
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_replica" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local sl_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Seal Deck",
	key = "sl_deck",
	order = 24,
	pos = { x = 5, y = 2 },
	config = {},
	edeck_type = "seal",
	loc_vars = function(self, info_queue, center)
		local _, _, _, _, eee = Cryptid.enhanced_deck_info(self)
		return { vars = { localize({ type = "name_text", set = "Other", key = eee:lower() .. "_seal" }) } }
	end,
	apply = function(self)
		local aaa, bbb, ccc, ddd, eee = Cryptid.enhanced_deck_info(self)
		G.GAME.modifiers.cry_force_seal = eee
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					G.playing_cards[c]:set_seal(eee, true)
				end
				return true
			end,
		}))
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_typhoon" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}

return {
	name = "Enhanced Decks",
	init = function()
		local sa = Card.set_ability
		function Card:set_ability(center, y, z)
			if not G.SETTINGS.paused and Cryptid.safe_get(center, "name") == "Default Base" then -- scuffed
				return sa(
					self,
					(not self.no_forced_enhancement and G.GAME.modifiers.cry_force_enhancement)
							and G.P_CENTERS[G.GAME.modifiers.cry_force_enhancement]
						or center,
					y,
					z
				)
			else
				return sa(self, center, y, z)
			end
		end
		local se = Card.set_edition
		function Card:set_edition(edition, y, z, force)
			if not force and not G.SETTINGS.paused then
				return se(
					self,
					(not self.no_forced_edition and G.GAME.modifiers.cry_force_edition)
							and { [G.GAME.modifiers.cry_force_edition] = true }
						or edition,
					y,
					z
				)
			end
			return se(self, edition, y, z)
		end
		local ss = Card.set_seal
		function Card:set_seal(seal, y, z)
			return ss(
				self,
				not self.no_forced_seal and not G.SETTINGS.paused and G.GAME.modifiers.cry_force_seal or seal,
				y,
				z
			)
		end
		local cs = Card.change_suit
		function Card:change_suit(new_suit)
			return cs(
				self,
				not self.no_forced_suit and not G.SETTINGS.paused and G.GAME.modifiers.cry_force_suit or new_suit
			)
		end
		local ccl = Card.click
		function Card:click()
			ccl(self)
			if
				Galdur
					and Cryptid.safe_get(Galdur, "run_setup", "current_page") == 1
					and (self.edeck_select or (self.area == Cryptid.safe_get(Galdur, "run_setup", "selected_deck_area") and Cryptid.safe_get(
						self,
						"config",
						"center",
						"edeck_type"
					)))
				or not Galdur
					and (Cryptid.safe_get(G.GAME, "viewed_back", "effect", "center", "edeck_type") and (self.back == "viewed_back" or self.edeck_select))
			then
				if not G.cry_edeck_select then
					G.cry_edeck_select = true
					G.cry_edeck_center = Galdur and self.config.center or G.GAME.viewed_back.effect.center
					Cryptid.enhancement_config_UI(Galdur and self.config.center or G.GAME.viewed_back.effect.center, 1)
				else
					if self.edeck_select then
						G.PROFILES[G.SETTINGS.profile]["cry_edeck_" .. self.config.center.edeck_type] =
							self.edeck_select
					end
					G.FUNCS.overlay_menu({
						definition = G.UIDEF.run_setup("main_menu_play"),
					})
					G.cry_edeck_select = nil
					G.cry_edeck_center = nil
				end
			end
		end
		function Cryptid.enhancement_config_UI(center, actual_page)
			local count_per_page = 6
			if not center.edeck_type then
				return
			end
			G.SETTINGS.paused = true
			G.your_collection = {}
			G.your_collection[1] = CardArea(
				G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
				G.ROOM.T.h,
				5.3 * G.CARD_W,
				1.03 * G.CARD_H,
				{ card_limit = 5, type = "title", highlight_limit = 0, collection = true }
			)
			local deck_tables = {
				n = G.UIT.R,
				config = { align = "cm", padding = 0, no_fill = true },
				nodes = {
					{ n = G.UIT.O, config = { object = G.your_collection[1] } },
				},
			}

			local pool_table = {
				edition = G.P_CENTER_POOLS.Edition,
				enhancement = G.P_CENTER_POOLS.Enhanced,
				sticker = SMODS.Stickers,
				suit = SMODS.Suits,
				seal = G.P_SEALS,
			}
			local editions = {}
			for i, v in pairs(pool_table[center.edeck_type]) do
				if v.key ~= "e_base" and not v.no_edeck then
					editions[#editions + 1] =
						{ index = i, center = (center.edeck_type == "edition" and v.key:sub(3)) or v.key }
				end
			end
			local page = (actual_page and actual_page * count_per_page or count_per_page) - (count_per_page - 1)
			local max_pages = math.floor(#editions / count_per_page)
			if max_pages * count_per_page < #editions then --idk why this is needed but it is
				max_pages = max_pages + 1
			end
			local modification_options = {}
			for i = 1, max_pages do
				table.insert(
					modification_options,
					localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_pages)
				)
			end
			for i = page, math.min(page + count_per_page - 1, #editions) do
				local _center = Cryptid.deep_copy(center)
				_center.config["cry_force_" .. center.edeck_type] = editions[i].center
				Cryptid.edeck_atlas_update(_center)
				local card = Cryptid.generic_card(_center)
				card.edeck_select = editions[i].center
				G.your_collection[1]:emplace(card)
			end

			INIT_COLLECTION_CARD_ALERTS()

			local t = create_UIBox_generic_options({
				--infotip = localize("cry_gameset_explanation"),
				back_func = "setup_run",
				snap_back = true,
				contents = {
					{
						n = G.UIT.R,
						config = { align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
						nodes = { deck_tables },
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							create_option_cycle({
								options = modification_options,
								w = 4.5,
								cycle_shoulders = true,
								opt_callback = "edeck_page",
								current_option = actual_page,
								colour = G.C.RED,
								no_pips = true,
								focus_args = { snap_to = true, nav = "wide" },
							}),
						},
					},
				},
			})
			G.FUNCS.overlay_menu({
				definition = t,
			})
		end
		G.FUNCS.edeck_page = function(args)
			Cryptid.enhancement_config_UI(G.cry_edeck_center, args.cycle_config.current_option)
		end
	end,
	items = { e_deck, et_deck, sk_deck, st_deck, sl_deck, atlasedition },
}
