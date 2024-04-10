return {
  {
    "kevinhwang91/nvim-fundo",
    lazy = false, -- note: this plugin is not lazy loaded
    opts = {},
    build = function() require("fundo").install() end,
  },

  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
      "UndotreeFocus",
      "UndotreeShow",
      "UndotreeHide",
      "UndotreePersistUndo",
    },
    keys = {
      {
        "<leader>muu",
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle Undotree",
      },
      {
        "<leader>mup",
        "<cmd>UndotreePersistUndo<CR>",
        desc = "Undotree Persist Undo",
      },
    },
    opts = {
      HelpLine = 0,
      DiffAutoOpen = 0,
      HighlightChangedWithSign = 0,
      TreeNodeShape = "",
    },
    config = function(_, opts)
      for k, v in pairs(opts) do
        vim.g["undotree_" .. k] = v
      end
    end,
  },
}
