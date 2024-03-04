return {
  "folke/which-key.nvim",

  opts = function()
    ---@type Options
    return {
      window = {
        winblend = 20,
      },

      plugins = { spelling = true },

      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>m"] = { name = "+misc" },
        ["<leader>ml"] = { name = "+lsp" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    }
  end,
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
