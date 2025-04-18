local util = require "util"
local api = vim.api

local function augroup(name) return api.nvim_create_augroup("user_" .. name, { clear = true }) end
local function lazyvim_augroup(name) return api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end

util.define_autocmds {
  {
    "FileType",
    {
      group = "_hide_dap_repl",
      pattern = "dap-repl",
      command = "set nobuflisted",
    },
  },

  {
    "FileType",
    {
      group = "_buffer_mappings",
      pattern = {
        "qf",
        "help",
        "man",
        "vim",
        "git",
        "checkhealth",
        "floaterm",
        "lspinfo",
        "dap-float",
        "neotest-summary",
        "neotest-output",
        "neotest-output-panel",
        "dbout",
        "DressingSelect",
        "PlenaryTestPopup",
        "Jaq",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
    },
  },

  {
    "FileType",
    {
      group = augroup "set_window_highlight_with_filetype",
      pattern = { "neotest-output" },
      callback = function() vim.wo.winhighlight = "NormalFloat:Normal" end,
    },
  },

  {
    "FileType",
    {
      group = augroup "markdown_with_wrap",
      pattern = { "markdown" },
      callback = function()
        vim.opt_local.spell = false
        vim.opt_local.wrap = true
      end,
    },
  },

  {
    "FileType",
    {
      group = lazyvim_augroup "wrap_spell", -- override the lazyvim augroup
      pattern = { "gitcommit" },
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
      end,
    },
  },

  {
    "FileType",
    {
      group = augroup "jaq_settings",
      pattern = {
        "Jaq",
      },
      callback = function(event)
        vim.api.nvim_buf_set_var(0, "miniindentscope_disable", true)
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = event.buf, silent = true })
      end,
    },
  },

  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = { "lua" },
      desc = "fix gf functionality inside .lua files",
      callback = function()
        ---@diagnostic disable: assign-type-mismatch
        -- credit: https://github.com/sam4llis/nvim-lua-gf
        vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
        vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
        vim.opt_local.suffixesadd:prepend ".lua"
        vim.opt_local.suffixesadd:prepend "init.lua"

        for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
          vim.opt_local.path:append(path .. "/lua")
        end
      end,
    },
  },

  {
    { "BufLeave", "FocusLost" },
    {
      callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand "%" ~= "" and vim.bo.buftype == "" then
          vim.api.nvim_command "silent w"
        end
      end,
    },
  },

  {
    { "FileType" },
    {
      group = augroup "json_conceal",
      pattern = { "json", "jsonc", "json5" },
      callback = function() vim.opt_local.conceallevel = 0 end,
    },
  },

  {
    "TermOpen",
    {
      group = augroup "terminal_nonum",
      command = "setlocal nonumber norelativenumber foldcolumn=1 stc=",
    },
  },

  {
    "VimResized",
    {
      group = augroup "resize",
      pattern = "*",
      callback = function() require("bufresize").resize() end,
    },
  },
  {
    "BufEnter",
    {
      group = augroup "only_for_vscode",
      callback = function()
        if vim.g.vscode then
          vim.cmd [[ syntax off ]]
          vim.cmd [[ set nospell ]]
        end
      end,
    },
  },
}
