local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep -- repeat node
-- local l = extras.lambda
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
local snippet_collection = require "luasnip.session.snippet_collection"

ls.config.set_config {

  history = true,
  updateevents = "TextChanged,TextChangedI",
  delete_check_events="TextChanged,TextChangedI"

}

require("luasnip.loaders.from_vscode").lazy_load()

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/setup/luasnip.lua<CR>")

snippet_collection.clear_snippets "c"
ls.add_snippets("c", {
  s("pf", fmt(
[[PetscErrorCode {}({}) {{
  PetscFunctionBeginUser;
  {}

  PetscFunctionReturn(PETSC_SUCCESS);
}}]], {i(1, "func"), i(2, "void arg"), i(0)})),

  s("pc", fmt("PetscCall({});", {i(1, "...")})),

  s("cdqf", fmt(
[[CEED_QFUNCTION({})(void *ctx, CeedInt Q, const CeedScalar *const *in, CeedScalar *const *out) {{
  {}
  return 0;
}}]],
  { i(1, "QF_Name"), i(0) } )),

  s("cdqfsh", fmt(
[[CEED_QFUNCTION_HELPER {} {}(void *ctx, CeedInt Q, const CeedScalar *const *in, CeedScalar *const *out, StateVariable state_var) {{
  {}
}}]],
  { i(1, "void"), i(2, "QFHelper_State"), i(0) } )),

  s("cdqfh", fmt(
[[CEED_QFUNCTION_HELPER {} {}({}) {{
  {}
}}]],
  { i(1, "void"), i(2, "QFHelper"), i(3, "void arg"), i(0) } )),

})
