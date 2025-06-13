local runtask = require("runtask")
local array = require("common.array")
local notify = require("common.notify")
local mapper = require("common.mapper").map

---@param lines string[]
---@param filetype string
local function showOnPopup(lines, filetype)
  if filetype == nil then filetype = "json" end
  vim.schedule(function ()
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "80%",
        height = "60%",
      },
    })

    -- mount/open the component
    popup:mount()

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function ()
      popup:unmount()
    end)

    -- set content
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
    vim.bo[popup.bufnr].filetype = filetype
  end)
end

runtask.setup({
  on_start = function ()
    notify.simple("Ejecutando script")
  end,
  on_exit = function (output)
    notify.simple("Termino el script")
    if
        array.len(output.content) == 0
        or (array.len(output.content) == 1 and output.content[1] == "")
    then
      return
    end
    local filetype = "markdown"
    if output.type == "json" then
      filetype = "json"
    end
    showOnPopup(output.content, filetype)
  end,
})

mapper(
  'n',
  '<Leader>o',
  function ()
    runtask:run()
  end
)
