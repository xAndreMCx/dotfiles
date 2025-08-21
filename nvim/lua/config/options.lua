-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Basic
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = 'auto:2-9'
-- vim.opt.colorcolumn = '120'
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.cmdheight = 1 -- Command line height
vim.opt.showmode = false
-- TODO: find out what these settings do
-- vim.opt.showmatch = true
-- vim.opt.matchtime = 2 -- ds
-- vim.opt.completeopt = 'menuone,noinsert,noselect' -- Completion options
-- vim.opt.pumheight = 10 -- Popup menu height
-- vim.opt.pumblend = 10 -- Popup menu transparency
-- vim.opt.lazyredraw = true -- Don't redraw during macros
-- vim.opt.synmaxcol = 300 -- Syntax highlighting limit

-- File handling
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 250 -- ms
vim.opt.timeoutlen = 300 -- ms
-- vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
-- vim.opt.autowrite = false

-- Behavior
vim.opt.hidden = true
vim.opt.errorbells = false
-- vim.opt.backspace = 'indent,eol,start'
vim.opt.iskeyword:append('-')
vim.opt.path:append('**')
vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Cursor settings
-- vim.opt.guicursor =
--   'n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- Folding
-- vim.opt.foldmethod = 'expr'
-- vim.wo.vim.foldexpr = 'v:lua.vim.lsp.foldexpr()'
-- vim.opt.foldlevel = 99

-- Command line completion
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore:append({ '*.o', '*.obj', '*.pyc', '*.class', '*.jar' })

-- Better diff options
-- vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000 -- ms
vim.opt.maxmempattern = 20000 -- KB
