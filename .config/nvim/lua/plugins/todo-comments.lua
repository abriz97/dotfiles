local todocomments = require "todo-comments"

-- Movement

vim.keymap.set("n", "]t", function()
  todocomments.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  todocomments.jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  todocomments.jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })

-- 
