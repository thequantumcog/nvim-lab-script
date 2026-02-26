return {
	{
		"SirVer/ultisnips",
		config = function()
			-- Neovim Lua configuration for UltiSnips
			vim.g.UltiSnipsExpandTrigger = "<C-s>"
			vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
			vim.defer_fn(function()
				pcall(vim.api.nvim_del_keymap, "i", "<Tab>")
				pcall(vim.api.nvim_del_keymap, "s", "<Tab>")
			end, 0)
		end,
	},
	"honza/vim-snippets",
}
