require("full-border"):setup {
	type = ui.Border.ROUNDED,
}

-- Only using this for vim-style `:set rnu` relative line numbers.
-- Its keypress-based motion feature is NOT enabled anywhere in keymap.toml,
-- since that's the part that was hanging -- this setup() call is pure
-- rendering, no key-waiting involved, so it's safe on its own.
require("relative-motions"):setup {
	show_numbers = "relative",
}
