local vscode = require "vscode"

local action = function(name, opts)
  return function() vscode.action(name, opts) end
end

local keymaps_set = require("util").keymaps_set

keymaps_set {
  {
    "zc",
    action "editor.fold",
  },
  {
    "zo",
    action "editor.unfold",
  },
  {
    "za",
    action "editor.toggleFold",
  },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
}
