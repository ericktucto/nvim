local cmp_ai = require('cmp_ai.config')
cmp_ai:setup({
  raw_response_cb = function (response)
    -- the `response` parameter contains the raw response (JSON-like) object.

    vim.notify(vim.inspect(response)) -- show the response as a lua table

    vim.g.ai_raw_response = response  -- store the raw response in a global
    -- variable so that you can use it
    -- somewhere else (like statusline).
  end,
  max_lines = 1000,
  provider = 'OpenAI',
  provider_options = {
    model = 'gpt-4',
  },
  notify = true,
  notify_callback = function (msg)
    require('snacks.notify').notify(msg, {
      title = 'OpenAI',
      render = 'compact',
    })
  end,
  log_errors = true,
  run_on_every_keystroke = true,
  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
})
