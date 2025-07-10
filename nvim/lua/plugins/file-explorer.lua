return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      "<leader>ge",
      function() require("neo-tree.command").execute { source = "git_status", toggle = true } end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function() require("neo-tree.command").execute { source = "buffers", toggle = true } end,
      desc = "Buffer Explorer",
    },
  },
  deactivate = function() vim.cmd [[Neotree close]] end,
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start Neo-tree with directory",
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then require "neo-tree" end
        end
      end,
    })
  end,
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "trouble", "qf", "outline" },
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    -- Hide headers for all sources
    hide_root_node = true,
    retain_hidden_root_indent = false,
    -- Remove the tabline (File, Bufs, Git buttons)
    source_selector = {
      winbar = false,
      statusline = false,
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      -- Show root directory name only (e.g., "nvim" instead of "~/.config/nvim")
      components = {
        name = function(config, node, state)
          local name = node.name
          if node.type == "directory" and node:get_depth() == 1 then
            -- For root directory, show only the basename
            name = vim.fn.fnamemodify(node.path, ":t")
          end
          return {
            text = name,
            highlight = config.highlight or "NeoTreeFileName",
          }
        end,
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        hide_by_name = {},
        hide_by_pattern = {},
        always_show = {
          ".gitignore",
          ".env",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = "none",
        ["<cr>"] = "open",
        ["l"] = "open",
        ["<esc>"] = "cancel",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["h"] = "close_node",
        ["z"] = "close_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
      file_size = {
        enabled = true,
        required_width = 64,
      },
      type = {
        enabled = true,
        required_width = 122,
      },
      last_modified = {
        enabled = true,
        required_width = 88,
      },
      created = {
        enabled = true,
        required_width = 110,
      },
      symlink_target = {
        enabled = false,
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          -- Close neo-tree when a file is opened
          require("neo-tree.command").execute { action = "close" }
        end,
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then require("neo-tree.sources.git_status").refresh() end
      end,
    })
  end,
}
