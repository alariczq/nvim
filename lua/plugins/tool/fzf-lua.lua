local with_suffix = function(name)
  return name .. _Icons.fzflua.suffix
end

return {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  keys = function()
    local f = require "fzf-lua"
    local Util = require "lazyvim.util"
    return {
      { "<leader>f<leader>", f.resume, desc = "FzfLua resume" },
      { "<leader>fl", f.builtin, desc = "FzfLua builtin" },
      {
        "<leader>ff",
        function()
          f.git_files { cwd = Util.root() }
        end,
        desc = "FzfLua git files",
      },
      {
        "<leader>fg",
        function()
          f.live_grep_glob { cwd = Util.root() }
        end,
        desc = "FzfLua live grep",
      },
      {
        "<leader><leader>",
        function()
          f.files { cwd = Util.root() }
        end,
        desc = "FzfLua files",
      },
      { "<leader>,", f.buffers, desc = "FzfLua buffers" },
    }
  end,
  opts = function()
    local actions = require "fzf-lua.actions"

    return {
      winopts = {
        height = 0.85,
        width = 0.90,
        row = 0.35,
        col = 0.5,
        border = "rounded",
        preview = {
          default = "builtin",
          border = "border",
          wrap = "nowrap",
          hidden = "nohidden",
          vertical = "down:45%",
          horizontal = "right:65%",
        },
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--info"] = "right",
        ["--pointer"] = _Icons.fzflua.pointer,
        ["--scrollbar"] = _Icons.fzflua.scrollbar,
        ["--height"] = "100%",
        ["--marker"] = _Icons.fzflua.marker,
        ["--layout"] = "reverse",
        ["--border"] = "none",
      },
      hls = {
        normal = "Normal",
        border = "FzfLuaBorder",
        title = "FloatTitle",
        preview_normal = "Normal",
        preview_border = "FzfLuaBorder",
        preview_title = "FloatTitle",
      },
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Statement" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bg", "Normal" },
        ["separator"] = { "fg", "FzfLuaBorder" },
        ["scrollbar"] = { "fg", "FzfLuaBorder" },
        ["border"] = { "fg", "FzfLuaBorder" },
      },

      keymap = {
        builtin = {
          ["<C-S-H>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-d"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        files = {
          ["default"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-l"] = actions.file_sel_to_ll,
        },
        buffers = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
        highlights = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },

      builtin = {
        prompt = with_suffix "Builtin",
      },

      previewers = {
        codeaction_native = {
          pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
        },
      },

      buffers = {
        prompt = with_suffix "Buffers",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        show_unloaded = true, -- show unloaded buffers
        cwd_only = false, -- buffers for the cwd only
        actions = {
          ["ctrl-x"] = { fn = actions.buf_del, reload = true },
        },
      },

      tabs = {
        prompt = with_suffix "Tabs",
        tab_marker = "",
      },

      files = {
        prompt = with_suffix "Files",
      },

      oldfiles = {
        prompt = with_suffix "History",
        cwd_only = false,
        stat_file = true, -- verify files exist on disk
        include_current_session = false, -- include bufs from current session
      },
      commands = {
        prompt = with_suffix "Commands",
      },

      grep = {
        prompt = with_suffix "Rg",
        input_prompt = with_suffix "Grep For",
        search = "",
        actions = {
          -- actions inherit from 'actions.files' and merge
          -- this action toggles between 'grep' and 'live_grep'
          ["ctrl-g"] = { actions.grep_lgrep },
          -- uncomment to enable '.gitignore' toggle for grep
          ["ctrl-r"] = { actions.toggle_ignore },
          ["ctrl-x"] = {
            function(selected, opts)
              vim.print(selected, opts)
              require("trouble").open(selected)
            end,
          },
        },
      },

      git = {
        icons = {
          ["A"] = { icon = _Icons.fzflua.git.added, color = "green" },
          ["M"] = { icon = _Icons.fzflua.git.modified, color = "yellow" },
          ["D"] = { icon = _Icons.fzflua.git.deleted, color = "red" },
        },

        files = {
          prompt = with_suffix "GitFiles",
        },
      },

      changes = {
        prompt = with_suffix "Changes",
      },

      diagnostics = {
        prompt = with_suffix "Diagnostics",
      },

      highlights = {
        prompt = with_suffix "Highlights",
      },

      lsp = {
        prompt_postfix = _Icons.fzflua.suffix,
        cwd_only = false,
        symbols = {
          prompt_postfix = _Icons.fzflua.suffix,
          symbol_icons = _Icons.kinds,
        },
        finder = {
          prompt = with_suffix "LSP Finder",
        },
        code_actions = {
          prompt = with_suffix "Code Actions",
          previewer = "codeaction_native",
        },
      },
    }
  end,

  config = function(_, opts)
    local fzf = require "fzf-lua"
    fzf.setup(opts)
    fzf.register_ui_select()
  end,
}
