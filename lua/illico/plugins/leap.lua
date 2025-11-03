return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		local leap = require("leap")

		-- Set up leap with default mappings
		leap.add_default_mappings()

		-- Configure leap to search in all windows
		leap.opts.safe_labels = {}

		-- Search in all directions (entire buffer, not just after cursor)
		vim.keymap.set({ "n", "x", "o" }, "s", function()
			require("leap").leap({
				target_windows = { vim.fn.win_getid() },
			})
		end)

		vim.keymap.set({ "n", "x", "o" }, "S", function()
			require("leap").leap({
				target_windows = { vim.fn.win_getid() },
				backward = true,
			})
		end)

		-- Highlight characters as you type
		leap.opts.highlight_unlabeled_phase_one_targets = true

		-- Remove the limit on how many characters you can type
		leap.opts.max_phase_one_targets = nil

		-- Highly recommended: define a preview filter to reduce visual noise
		-- and the blinking effect after the first keypress
		-- Exclude whitespace and the middle of alphabetic words from preview:
		--   foobar[baaz] = quux
		--   ^----^^^--^^-^-^--^
		leap.opts.preview_filter = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		-- Define equivalence classes for brackets and quotes, in addition to
		-- the default whitespace group:
		leap.opts.equivalence_classes = {
			" \t\r\n",
			"([{",
			")]}",
			"'\"`",
		}

		-- Use the traversal keys to repeat the previous motion without
		-- explicitly invoking Leap:
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")
	end,
}
