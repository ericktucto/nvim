local lsp = {}

function lsp:all()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  return vim.diagnostic.get(0, { lnum = row - 1 })
end

function lsp:top()
  local diagnostics = lsp:all()
  if #diagnostics > 0 then
    local top = diagnostics[1]
    -- find the top diagnostic
    for _, d in ipairs(diagnostics) do
      if d.severity < top.severity then
        top = d
      end
    end
    return top
  else
    return nil
  end
end

local nvimbattery = {
  function()
    return require("battery").get_status_line()
  end,
}

local default_options = {
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "|", right = "|" }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'filename', path = 1, symbols = { modified = ' ', readonly = ' ' } },
    },
    lualine_c = {
      {
        'diagnostics',
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {error = ' ', warn = ' ', info = ' ', hint = '󰌵 '},
        colored = true,
        update_in_insert = true,
        always_visible = false,   -- Show diagnostics even if there are none.
      },
        -- {'NearestMethodOrFunction'}
    },
    lualine_x = {},
    lualine_y = {
      {
        'diff',
      },
      'branch',
      nvimbattery
    },
    lualine_z = {{'location', padding = 1}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}
local opts = function (_, opts)
  opts = vim.tbl_deep_extend("force", opts, default_options)

  -- diagnostics's message obtained to
  -- https://github.com/nvim-lualine/lualine.nvim/discussions/911
  local utils = require("lualine.utils.utils")
  local highlight = require("lualine.highlight")
  local diagnostics_message = require("lualine.component"):extend()
  diagnostics_message.default = {
    colors = {
      error = utils.extract_color_from_hllist(
        { "fg", "sp" },
        { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
        "#e32636"
      ),
      warning = utils.extract_color_from_hllist(
        { "fg", "sp" },
        { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
        "#ffa500"
      ),
      info = utils.extract_color_from_hllist(
        { "fg", "sp" },
        { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
        "#ffffff"
      ),
      hint = utils.extract_color_from_hllist(
        { "fg", "sp" },
        { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
        "#273faf"
      ),
    },
  }
  function diagnostics_message:init(options)
    diagnostics_message.super:init(options)
    self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
    self.highlights = { error = "", warn = "", info = "", hint = "" }
    self.highlights.error = highlight.create_component_highlight_group(
      { fg = self.options.colors.error },
      "diagnostics_message_error",
      self.options
    )
    self.highlights.warn = highlight.create_component_highlight_group(
      { fg = self.options.colors.warn },
      "diagnostics_message_warn",
      self.options
    )
    self.highlights.info = highlight.create_component_highlight_group(
      { fg = self.options.colors.info },
      "diagnostics_message_info",
      self.options
    )
    self.highlights.hint = highlight.create_component_highlight_group(
      { fg = self.options.colors.hint },
      "diagnostics_message_hint",
      self.options
    )
  end

  function diagnostics_message:update_status(_)
    local diagnostic = lsp:top()

    if diagnostic == nil then return "" end

    local icons = { ' ', ' ', ' ', '󰌵 '}
    local hl = {
      self.highlights.error,
      self.highlights.warn,
      self.highlights.info,
      self.highlights.hint,
    }
    return highlight.component_format_highlight(hl[diagnostic.severity])
      .. icons[diagnostic.severity]
      .. " "
      .. utils.stl_escape(diagnostic.message)
  end

  table.insert(opts.sections.lualine_c, {
    diagnostics_message,
  })
  return opts
end
require("lualine").setup(opts(nil, {}))
