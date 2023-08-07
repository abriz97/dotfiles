-- inspects contents of an object.
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end


function StanHelp(function_name)
    local url = "https://mc-stan.org/docs/2_26/functions-reference/" .. function_name .. ".html"
    vim.fn.jobstart({"xdg-open", url})
end

vim.cmd("command! -nargs=1 StanHelp call v:lua.StanHelp(<f-args>)")
