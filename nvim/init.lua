local set = vim.keymap.set
local cmd = vim.cmd
local o = vim.opt

o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.swapfile = false
o.hlsearch = true
o.scrolloff = 1
o.startofline = false
o.mouse = "a"
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.showcmd = true
o.showmatch = true
o.history = 1000
o.wildmenu = true
o.undofile = true
o.undodir  = vim.fn.expand("~/.config/nvim/undo")
o.wildmode = "longest:full,full"
o.wildignore = "*.docx,*.we*,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.svg,*.flv,*.img,*.xlsx"
o.clipboard = "unnamedplus"
o.termguicolors = true
o.backup = false
o.signcolumn = "yes"
o.writebackup = false
o.cmdheight = 0
o.laststatus = 0
vim.g.mapleader = " "

cmd([[syntax on]])
cmd([[filetype plugin indent on]])
cmd("cnoreabbrev q q!")
cmd("cnoreabbrev Q qall!")
cmd("cnoreabbrev w w!")
cmd("cnoreabbrev wq wq!")


function BuildMake()
  local ext = vim.fn.expand("%:e")

  if vim.fn.filereadable("Makefile") == 1 then
    vim.o.makeprg = "make"
  elseif ext == "c" then
    vim.o.makeprg = "cc -o %:r  % && ./%:r"

  elseif ext == "py" then
    vim.o.makeprg = "python3 %"
  elseif ext == "rs" then
    vim.o.makeprg = "cargo run"
  else
    vim.o.makeprg = ""
  end
  cmd("make")
end



set({"n","i","v"}, "<C-a>", "ggVG")
set({"n","i","v"}, "<A-j>", ":m .+1<CR>==")
set({"n","v"}, "<C-e>", ":source ~/.config/nvim/init.lua <CR>")
set("n", "<S-j>", ":m .+1<CR>==")
set("n", "<S-k>", ":m .-2<CR>==")
set("v", "<S-j>", ":m '>+1<CR>gv=gv")
set("v", "<S-k>", ":m '<-2<CR>gv=gv")
set({"n","i"}, "<A-k>", ":m .-2<CR>==")
set("n", "<leader>j", ":%s//g<Left><Left>")
set("v", "<leader>j", ":s//g<Left><Left>")
set({"v","n"}, "<A-j>", ":m '>+1<CR>gv=gv")
set({"v","n"}, "<A-k>", ":m '<-2<CR>gv=gv")
set({"v","n"}, "gj", "G")
set({"v","n"}, "gk", "gg")
set({"n","v"}, "te", ":tabedit ")
set({"n","v"}, "<Tab>", ":tabnext<CR>")
set("v", "<", "<gv")
set("v", ">", ">gv")
set({"n","v"}, "<S-Tab>", ":tabprev<CR>")
set({"n","v"}, "E", ":e ")
set({"n","v"}, "vs", ":vsplit ")
set("n", "<A-/>", require("Comment.api").toggle.linewise.current)
set("v", "<A-/>", function() vim.api.nvim_feedkeys("gc", "x", false) end)
set({"v","n"}, "<C-_>" ,":lua BuildMake() <CR>")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
		require("gruvbox").setup({
			undercurl = true,
			bold = true,
			italic = { strings = true, comments = true, operators = false, folds = true },
			inverse = true,
			contrast = "hard",
			transparent_mode = true,
			-- sign_column = "yes",  -- this makes gruvbox control the signcolumn bg
		})

        cmd("colorscheme gruvbox")
        require('Comment').setup()
        require('colorizer').setup()
    end,
})

require("colorizer").setup({"*"}, {
    RGB = true, RRGGBB = true, names = true, RRGGBBAA = true,
    rgb_fn = true, hsl_fn = true, css = true, css_fn = true,
    mode = 'background',
})

local cmp = require("cmp")
cmp.setup({
  window = {
	completion = cmp.config.window.bordered({
	  border = {"╭","─","╮","│","╯","─","╰","│"},
	  winhighlight = "Normal:NormalFloat,FloatBorder:White,CursorLine:PmenuSel,Search:None",
	}),
	documentation = cmp.config.window.bordered({
		border = {"╭","─","╮","│","╯","─","╰","│"},
		winhighlight = "Normal:NormalFloat,FloatBorder:White,CursorLine:PmenuSel,Search:None",
	}),
  },
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	})
})

-- Enable LSP capabilities for nvim-cmp
local servers = { "pyright", "clangd","html","cssls" }
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Iterate over servers and setup each
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities
  }
end
