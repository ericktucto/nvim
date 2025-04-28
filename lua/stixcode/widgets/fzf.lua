local mapper = require("common.mapper").map
local fzf = require("fzf-lua")
local fzf_fn = require("stixcode.widgets.fzf.fn")

-- ESTA FUNCION LISTA MIS PROYECTOS
function Projects()
  coroutine.wrap(function ()
    local fzf = require("fzf")
    local projects = require('project_nvim').get_recent_projects()
    local result = fzf.fzf(projects, "--ansi --layout=reverse --prompt='Elige un proyecto >>> '", { border = false })
    if result then
      require('project_nvim.project').set_pwd(result[1], "stixcode")
      vim.fn["NERDTreeCWD"]()
    else
      print("Hubo un fallo")
    end
  end)()
end

-- Search file
mapper('', '<c-p>', function () fzf.files({ resume = true }) end)

-- Searching on stage (git)
mapper("", "<Leader>s", function () fzf.git_status({}) end)

-- Searching changes on current file
mapper("", "<Leader>S", fzf_fn.list_hunks)

-- Searching buffer
mapper("", "<Leader>p", function () fzf.buffers({}) end)

-- Search word in project
-- mapper("n", "<Leader>f", "<cmd>:FWord<CR>")

-- { "<Leader>k", "<cmd>lua Projects()<CR>", desc = "Abrir proyecto..." },
