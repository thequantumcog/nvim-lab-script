local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

-- Helper to get the current date

ls.add_snippets('all', {
  s('todo', {
    t '# TODO: ',
    i(0), -- The description
  }),
})
