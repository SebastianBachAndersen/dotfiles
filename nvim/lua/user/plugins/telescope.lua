vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})


local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then return tail end
	return string.format("%s\t\t%s", tail, parent)
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>f', function() require('telescope.builtin').find_files() end },
    { '<leader>F', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' }) end },
    { '<leader>b', function() require('telescope.builtin').buffers() end },
    { '<leader>g', function() require('telescope').extensions.live_grep_args.live_grep_args() end },
    { '<leader>h', function() require('telescope.builtin').oldfiles() end },
    { '<leader>s', function() require('telescope.builtin').lsp_document_symbols() end },
  },
  config = function ()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        path_display = filenameFirst,
        prompt_prefix = '   ',
        selection_caret = '  ',
        layout_config = {
          prompt_position = 'top',
        },
        preview = {
          timeout = 200,
        },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
          },
        },
        file_ignore_patterns = { '.git/' },
      },
      extensions = {
        live_grep_args = {
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = false,
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = 'History',
        },
        lsp_references = {
          previewer = true,
        },
        lsp_definitions = {
          previewer = true,
        },
        lsp_document_symbols = {
          symbol_width = 55,
        },
      },
    })

    require('telescope').load_extension('fzf')
  end,
}
