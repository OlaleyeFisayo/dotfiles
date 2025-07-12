return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local astro = require "astrocore"
        maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")
        if vim.fn.executable "git" == 1 and vim.fn.executable "lazygit" == 1 then
          maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
          local lazygit = {
            callback = function()
              local worktree = astro.file_worktree()
              local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                or ""
              astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "float" }
            end,
            desc = "ToggleTerm lazygit",
          }
          maps.n["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc }
          maps.n["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc }
        end
        if vim.fn.executable "node" == 1 then
          maps.n["<Leader>tn"] = { function() astro.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
        end
        local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
        if vim.fn.has "win32" == 1 and vim.fn.executable(gdu) ~= 1 then gdu = "gdu_windows_amd64.exe" end
        if vim.fn.executable(gdu) == 1 then
          maps.n["<Leader>tu"] =
            { function() astro.toggle_term_cmd { cmd = gdu, direction = "float" } end, desc = "ToggleTerm gdu" }
        end
        if vim.fn.executable "btm" == 1 then
          maps.n["<Leader>tt"] =
            { function() astro.toggle_term_cmd { cmd = "btm", direction = "float" } end, desc = "ToggleTerm btm" }
        end
        local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
        if python then
          maps.n["<Leader>tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" }
        end
        maps.n["<Leader>t1"] = { "<Cmd>1ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.t["<Leader>t1"] = { "<Cmd>1ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<Leader>t2"] = { "<Cmd>2ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.t["<Leader>t2"] = { "<Cmd>2ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<Leader>t3"] = { "<Cmd>3ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.t["<Leader>t3"] = { "<Cmd>3ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<Leader>t4"] = { "<Cmd>4ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.t["<Leader>t4"] = { "<Cmd>4ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<C-n>"] = { "<Cmd>5ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.t["<C-n>"] = { "<Cmd>5ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.commands then opts.commands = {} end
        if not opts.window then opts.window = {} end
        if not opts.window.mappings then opts.window.mappings = {} end

        local function toggleterm_in_direction(state, direction)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("toggleterm.terminal").Terminal:new({ dir = path, direction = direction }):toggle()
        end
        local prefix = "T"
        ---@diagnostic disable-next-line: assign-type-mismatch
        opts.window.mappings[prefix] =
          { "show_help", nowait = false, config = { title = "New Terminal", prefix_key = prefix } }
        for suffix, direction in pairs { f = "float", h = "horizontal", v = "vertical" } do
          local command = "toggleterm_" .. direction
          opts.commands[command] = function(state) toggleterm_in_direction(state, direction) end
          opts.window.mappings[prefix .. suffix] = command
        end
      end,
    },
  },
  opts = {
    highlights = {
      Normal = { link = "Normal" },
      NormalNC = { link = "NormalNC" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
      StatusLine = { link = "StatusLine" },
      StatusLineNC = { link = "StatusLineNC" },
      WinBar = { link = "WinBar" },
      WinBarNC = { link = "WinBarNC" },
    },
    size = 10,
    ---@param t Terminal
    on_create = function(t)
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.signcolumn = "no"
      if t.hidden then
        local function toggle() t:toggle() end
        vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
      end
    end,
    shading_factor = 2,
    float_opts = { border = "rounded" },
  },
}
