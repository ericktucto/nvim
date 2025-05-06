--[[
      if server_name == "phpactor" then
        -- CONFIG PHPCS
        local phpcs_rules = vim.fn.stdpath("config") .. "/lib/phpcs/phpcs.xml"
        local phpcs_path = vim.fn.stdpath("config") .. "/lib/phpcs/vendor/bin/phpcs"
        --phpcs.args = { "-q", "--standard=" .. phpcs_rules, "--report=json", "-" }
        options = {
          init_options = {
            ["php_code_sniffer.enabled"] = true,
            ["php_code_sniffer.bin"] = phpcs_path,
            ["php_code_sniffer.args"] = { "--standard=" .. phpcs_rules },
          }
        }
      end
      ]]
return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = {
    "composer.json",
    ".phpactor.json",
    ".phpactor.yml",
    ".git",
  },
}
