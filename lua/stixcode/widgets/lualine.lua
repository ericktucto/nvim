local sections_left = require("stixcode.widgets.lualine.sections.left")
local sections_right = require("stixcode.widgets.lualine.sections.right")

require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "|", right = "|" },
  },
  sections = {
    lualine_a = sections_left.a,
    lualine_b = sections_left.b,
    lualine_c = sections_left.c,
    lualine_x = sections_right.x,
    lualine_y = sections_right.y,
    lualine_z = sections_right.z,
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
})
