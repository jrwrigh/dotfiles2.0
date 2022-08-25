vim.g.sonokai_style = 'atlantis'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_colors_override = { 
  black       = {'#1c1e1f', '237'},
  bg0         = {'#273136', '235'},
  bg1         = {'#313b42', '236'},
  bg2         = {'#353f46', '236'},
  bg3         = {'#3a444b', '237'},
  bg4         = {'#414b53', '237'},
  bg_red      = {'#ff6d7e', '203'},
  diff_red    = {'#55393d', '52'},
  bg_green    = {'#a2e57b', '107'},
  diff_green  = {'#394634', '22'},
  bg_blue     = {'#7cd5f1', '110'},
  diff_blue   = {'#354157', '17'},
  diff_yellow = {'#4e432f', '54'},
  fg          = {'#f8f8f0', '250'},
  red         = {'#f92672', '203'},
  orange      = {'#fd971f', '215'},
  yellow      = {'#e6db74', '179'},
  green       = {'#a6e22e', '107'},
  blue        = {'#66d9ef', '110'},
  purple      = {'#ae81ff', '176'},
  grey        = {'#82878b', '246'},
  grey_dim    = {'#55626d', '240'},
  none        = {'NONE',    'NONE'}
}

local classic = {
  name = 'monokai',
  base0 = '#222426',
  base1 = '#272a30',
  base2 = '#26292C',
  base3 = '#2E323C',
  base4 = '#333842',
  base5 = '#4d5154',
  base6 = '#9ca0a4',
  base7 = '#b1b1b1',
  base8 = '#e3e3e1',
  border = '#a1b5b1',
  brown = '#504945',
  white = '#f8f8f0',
  grey = '#8F908A',
  black = '#000000',
  pink = '#f92672',
  green = '#a6e22e',
  aqua = '#66d9ef',
  red    = '#e95678',
  orange = '#fd971f',
  yellow = '#e6db74',
  purple = '#ae81ff',
  diff_add = '#3d5213',
  diff_remove = '#4a0f23',
  diff_change = '#27406b',
  diff_text = '#23324d',
}

local function customSonokaiHighlighting()
  vim.cmd[[call sonokai#highlight('LightGrey', ['#b2b5b8', '246'], ['NONE', 'NONE'])]]
  vim.cmd [[highlight! link TSPunctBracket LightGrey]]
  vim.cmd [[highlight! link TSPunctDelimiter LightGrey]]
end

vim.api.nvim_create_augroup('SonokaiCustom', {clear=true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SonokaiCustom',
  pattern = 'sonokai',
  callback = customSonokaiHighlighting
})

vim.cmd[[colorscheme sonokai]]
