local Util = require "lazyvim.util"
local keymaps_set = require("util").keymaps_set

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3

if vim.g.vscode then
  require "config.vscode"
end

keymaps_set {
  -- { "<C-p>", "", mode = "i" },
  { "<C-n>", "", mode = "i" },
  { "<C-d>", "", mode = "c" },
  { "<Tab>", "", mode = "c" },
  { "<cmd>undo<CR>", "<D-z>", mode = { "n", "i" } },
  { "<cmd>redo<CR>", "<D-Z>", mode = { "n", "i" } },

  -- Clear search with <esc>
  { "<esc>", "<cmd>noh<cr><esc>", mode = { "i", "n" }, desc = "Escape and clear hlsearch" },

  { "[o", [[<cmd>execute "normal! O"<CR>]], desc = "Put a blank line in the previous line" },
  { "]o", [[<cmd>execute "normal! o"<CR>]], desc = "Put a blank line in the next line" },

  -- better up/down
  { "j", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, expr = true },
  { "<Down>", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, expr = true },
  { "k", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, expr = true },
  { "<Up>", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, expr = true },
  { "<C-w>c", "<Cmd>BufRemove<CR>", desc = "Remove buffer and close window" },
  -- { "j", [[v:count ? (v:count >= 3 ? "m'" . v:count : '') . 'j' : 'gj']], mode = "n", expr = true },
  -- { "k", [[v:count ? (v:count >= 3 ? "m'" . v:count : '') . 'k' : 'gk']], mode = "n", expr = true },

  -- Move to window using the <ctrl> hjkl keys
  -- { "<C-h>", "<cmd>wincmd h<CR>", desc = "Go to left window" },
  -- { "<C-j>", "<cmd>wincmd j<CR>", desc = "Go to lower window" },
  -- { "<C-k>", "<cmd>wincmd k<CR>", desc = "Go to upper window" },
  -- { "<C-l>", "<cmd>wincmd l<CR>", desc = "Go to right window" },

  -- Move Lines
  { "<A-j>", "<cmd>m .+1<cr>==", desc = "Move down" },
  { "<A-k>", "<cmd>m .-2<cr>==", desc = "Move up" },
  { "<A-j>", "<esc><cmd>m .+1<cr>==gi", desc = "Move down", mode = "i" },
  { "<A-k>", "<esc><cmd>m .-2<cr>==gi", desc = "Move up", mode = "i" },
  { "<A-j>", ":m '>+1<cr>gv=gv", desc = "Move down", mode = "v" },
  { "<A-k>", ":m '<-2<cr>gv=gv", desc = "Move up", mode = "v" },

  -- buffers
  -- { "<S-h>", "<cmd>bprevious<cr>", desc = "Prev buffer" },
  -- { "<S-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
  -- { "[b", "<cmd>bprevious<cr>", desc = "Prev buffer" },
  -- { "]b", "<cmd>bnext<cr>", desc = "Next buffer" },
  { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
  { "<leader>bd", "<cmd>lua require('mini.bufremove').delete()<cr>", desc = "Delete Buffer" },
  { "<leader>`", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  {
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    desc = "Redraw / clear hlsearch / diff update",
  },

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  { "n", "'Nn'[v:searchforward].'zv'", expr = true, desc = "Next search result" },
  { "n", "'Nn'[v:searchforward]", mode = "x", expr = true, desc = "Next search result" },
  { "n", "'Nn'[v:searchforward]", mode = "o", expr = true, desc = "Next search result" },
  { "N", "'nN'[v:searchforward].'zv'", expr = true, desc = "Prev search result" },
  { "N", "'nN'[v:searchforward]", mode = "x", expr = true, desc = "Prev search result" },
  { "N", "'nN'[v:searchforward]", mode = "o", expr = true, desc = "Prev search result" },

  { "<leader>clr", "<cmd>LspRestart<CR>", desc = "Lsp Restart" },
  { "<leader>cls", "<cmd>LspStart<CR>", desc = "Lsp Start" },
  { "<leader>clx", "<cmd>LspStop<CR>", desc = "Lsp Stop" },
  { "<leader>cll", "<cmd>LspLog<CR>", desc = "Lsp Log" },

  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },

  -- Add undo break-points
  { ",", ",<c-g>u", mode = "i" },
  { ".", ".<c-g>u", mode = "i" },
  { ";", ";<c-g>u", mode = "i" },

  -- better indenting
  { "<", "<gv", mode = "v" },
  { ">", ">gv", mode = "v" },

  -- save file
  { "<C-s>", "<cmd>w<cr><esc>", mode = { "i", "x", "n", "s" }, desc = "Save file" },
  { "<C-q><C-q>", "<cmd>qa<cr>", mode = "n", desc = "Quit all" },

  { "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" },
  { "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },

  {
    "<leader><tab><tab>",
    [[<cmd>if expand("%") != "" | tabnew % | else | tabnew | endif <CR>]],
    desc = "New Tab",
  },
  { "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
  { "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close Tab" },
  { "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" },

  { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },

  {
    "<leader>oo",
    "<Cmd>OpenBob<CR>",
    mode = { "v", "n" },
    desc = "Open Bob translator",
    cond = vim.fn.executable "osascript" == 1,
  },
}
