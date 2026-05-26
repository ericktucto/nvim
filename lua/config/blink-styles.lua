-- blink-styles.lua
-- Estilos para blink.cmp: íconos con bloque de color + kind en cursiva.
-- Uso:
--   1) Guarda este archivo en: ~/.config/nvim/lua/blink-styles.lua
--   2) En tu config de blink.cmp, después del setup:
--        require("blink-styles").setup()
--
-- Nota importante:
-- Para que la selección NO opaque el bloque del ícono, en tu blink.cmp setup usa:
--
-- completion = {
--   menu = {
--     draw = {
--       cursorline_priority = 0,
--       -- ...
--     },
--   },
-- }

local M = {}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
  -- =========================
  -- MENÚ PRINCIPAL
  -- =========================

  hl("BlinkCmpMenu", {
    bg = "#1e1e2e",
    fg = "#cdd6f4",
  })

  hl("BlinkCmpMenuBorder", {
    fg = "#cdd6f4",
    bg = "#1e1e2e",
  })

  -- Fila seleccionada.
  -- Deja un fondo sutil para no tapar el bloque de color del ícono.
  --[[
  hl("BlinkCmpMenuSelection", {
    dim = true
  })
  ]]

  -- =========================
  -- DOCUMENTACIÓN
  -- =========================

  hl("BlinkCmpDoc", {
    bg = "#181825",
    fg = "#cdd6f4",
  })

  hl("BlinkCmpDocBorder", {
    fg = "#89dceb",
    bg = "#181825",
  })

  hl("BlinkCmpDocSeparator", {
    fg = "#89dceb",
    bg = "#181825",
  })

  hl("BlinkCmpDocCursorLine", {
    bg = "#313244",
  })

  -- =========================
  -- LABEL / TEXTO CENTRAL
  -- =========================

  hl("BlinkCmpLabel", {
    fg = "#cdd6f4",
  })

  hl("BlinkCmpLabelDeprecated", {
    fg = "#6c7086",
    strikethrough = true,
  })

  hl("BlinkCmpLabelMatch", {
    fg = "#89b4fa",
    bold = true,
  })

  hl("BlinkCmpLabelDescription", {
    fg = "#a6adc8",
  })

  hl("BlinkCmpLabelDetail", {
    fg = "#a6adc8",
  })

  -- =========================
  -- KIND DERECHO: (Property), (Snippet), etc.
  -- Este grupo NO debe tener background.
  -- =========================

  hl("BlinkCmpKindText", {
    fg = "#cba6f7",
    italic = true,
  })

  -- Compatibilidad por si usas BlinkCmpKind directamente
  hl("BlinkCmpKind", {
    fg = "#cba6f7",
    italic = true,
  })

  -- =========================
  -- BLOQUES DE ÍCONOS
  -- Usa estos grupos en tu componente kind_icon:
  --   BlinkCmpKindIcon .. ctx.kind
  -- =========================

  -- Fallbacks comunes
  hl("BlinkCmpKindIconText", {
    bg = "#94e2d5",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconValue", {
    bg = "#94e2d5",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconUnit", {
    bg = "#94e2d5",
    fg = "#11111b",
    bold = true,
  })

  -- Snippets / Emmet abbreviation
  hl("BlinkCmpKindIconSnippet", {
    bg = "#d9ad5b",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconEmmet", {
    bg = "#d9ad5b",
    fg = "#ffffff",
    bold = true,
  })

  -- Properties / Fields / Attributes
  hl("BlinkCmpKindIconProperty", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconField", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconVariable", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconConstant", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconEnumMember", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  -- Methods / Functions / Constructors
  hl("BlinkCmpKindIconMethod", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconFunction", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  hl("BlinkCmpKindIconConstructor", {
    bg = "#b85865",
    fg = "#ffffff",
    bold = true,
  })

  -- Keywords
  hl("BlinkCmpKindIconKeyword", {
    bg = "#a6e3a1",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconOperator", {
    bg = "#a6e3a1",
    fg = "#11111b",
    bold = true,
  })

  -- Classes / Interfaces / Structs / Modules
  hl("BlinkCmpKindIconClass", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconInterface", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconStruct", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconModule", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconEnum", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconTypeParameter", {
    bg = "#fab387",
    fg = "#11111b",
    bold = true,
  })

  -- Files / Folders / Paths
  hl("BlinkCmpKindIconFile", {
    bg = "#89b4fa",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconFolder", {
    bg = "#89b4fa",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconReference", {
    bg = "#89b4fa",
    fg = "#11111b",
    bold = true,
  })

  -- Events / Colors
  hl("BlinkCmpKindIconEvent", {
    bg = "#f9e2af",
    fg = "#11111b",
    bold = true,
  })

  hl("BlinkCmpKindIconColor", {
    bg = "#f9e2af",
    fg = "#11111b",
    bold = true,
  })

  -- Codeium
  hl("BlinkCmpKindIconCodeium", {
    bg = "#1e66f5",
    fg = "#ffffff",
    bold = true,
  })
end

-- Reaplica los colores si cambias de colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function ()
    M.setup()
  end,
})

return M
