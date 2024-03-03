local function sonokai_setup()
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
    vim.cmd [[
    let s:configuration = sonokai#get_configuration()
    let s:palette = sonokai#get_palette(s:configuration.style, s:configuration.colors_override)

    call sonokai#highlight('LightGrey', ['#b2b5b8', '246'], ['NONE', 'NONE'])
    highlight! link TSPunctBracket LightGrey
    highlight! link TSPunctDelimiter LightGrey
    highlight! link LineNr LightGrey
    call sonokai#highlight('LightGreen', ['#c5ebc3', '240'], ['NONE', 'NONE'])
    highlight! link LineNrAbove LightGreen
    call sonokai#highlight('LightRed', ['#ebc3c3', '240'], ['NONE', 'NONE'])
    highlight! link LineNrBelow LightRed

    call sonokai#highlight('FgCmpItem',     s:palette.black, s:palette.fg)
    call sonokai#highlight('GreyCmpItem',   s:palette.black, s:palette.grey)
    call sonokai#highlight('RedCmpItem',    s:palette.black, s:palette.red)
    call sonokai#highlight('OrangeCmpItem', s:palette.black, s:palette.orange)
    call sonokai#highlight('YellowCmpItem', s:palette.black, s:palette.yellow)
    call sonokai#highlight('GreenCmpItem',  s:palette.black, s:palette.green)
    call sonokai#highlight('BlueCmpItem',   s:palette.black, s:palette.blue)
    call sonokai#highlight('PurpleCmpItem', s:palette.black, s:palette.purple)

    highlight! link CmpItemAbbr              Fg
    highlight! link CmpItemAbbrDeprecated    GreyCmpItem
    highlight! link CmpItemMenu              Fg
    highlight! link CmpItemKind              BlueCmpItem
    highlight! link CmpItemKindText          FgCmpItem
    highlight! link CmpItemKindMethod        GreenCmpItem
    highlight! link CmpItemKindFunction      GreenCmpItem
    highlight! link CmpItemKindConstructor   GreenCmpItem
    highlight! link CmpItemKindField         GreenCmpItem
    highlight! link CmpItemKindVariable      OrangeCmpItem
    highlight! link CmpItemKindClass         BlueCmpItem
    highlight! link CmpItemKindInterface     BlueCmpItem
    highlight! link CmpItemKindModule        BlueCmpItem
    highlight! link CmpItemKindProperty      OrangeCmpItem
    highlight! link CmpItemKindUnit          PurpleCmpItem
    highlight! link CmpItemKindValue         PurpleCmpItem
    highlight! link CmpItemKindEnum          BlueCmpItem
    highlight! link CmpItemKindKeyword       RedCmpItem
    highlight! link CmpItemKindSnippet       YellowCmpItem
    highlight! link CmpItemKindColor         YellowCmpItem
    highlight! link CmpItemKindFile          YellowCmpItem
    highlight! link CmpItemKindReference     YellowCmpItem
    highlight! link CmpItemKindFolder        YellowCmpItem
    highlight! link CmpItemKindEnumMember    PurpleCmpItem
    highlight! link CmpItemKindConstant      OrangeCmpItem
    highlight! link CmpItemKindStruct        BlueCmpItem
    highlight! link CmpItemKindEvent         RedCmpItem
    highlight! link CmpItemKindOperator      RedCmpItem
    highlight! link CmpItemKindTypeParameter BlueCmpItem

    call sonokai#highlight('MonokaiBase8', ['#e3e3e1', 'NONE'], s:palette.none)
    call sonokai#highlight('MonokaiBase7', ['#b1b1b1', 'NONE'], s:palette.none)
    call sonokai#highlight('MonokaiBase7Underline', ['#b1b1b1', 'NONE'], s:palette.none, 'underline')
    highlight! link IndentBlanklineContextChar MonokaiBase7
    " highlight! link IndentBlanklineContextStart MonokaiBase7Underline
    highlight IndentBlanklineContextStart guisp=#b1b1b1 gui=underline 
    ]]
  end

  vim.api.nvim_create_augroup('SonokaiCustom', {clear=true})
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = 'SonokaiCustom',
    pattern = 'sonokai',
    callback = customSonokaiHighlighting
  })

  -- vim.cmd[[colorscheme sonokai]]
  vim.cmd.colorscheme 'sonokai'

  -- Include custom highlights directly after the colorscheme is created
  package.path = package.path .. ";../?.lua"
  require('highlights')
end

return {
  'sainnhe/sonokai',
  config = sonokai_setup,
  -- lazy = true,
}
