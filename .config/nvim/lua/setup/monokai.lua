local monokai = require('monokai')
monokai.setup {
  palette = {
    base5 = '#606569',
    },
}

-- Include custom highlights directly after the colorscheme is created
package.path = package.path .. ";../?.lua"
require('highlights')
