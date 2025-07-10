return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- Normal mode mappings
      n = {
        -- Move lines up and down with Alt+j/k
        ["<A-j>"] = { ":m .+1<CR>==", desc = "Move line down" },
        ["<A-k>"] = { ":m .-2<CR>==", desc = "Move line up" },

        -- Go to previous buffer with leader leader
        ["<Leader><Leader>"] = { "<cmd>b#<cr>", desc = "Previous buffer" },

        -- Move cursor left/right with Alt+h/l (optional - for consistency)
        ["<A-h>"] = { "5h", desc = "Move cursor left fast" },
        ["<A-l>"] = { "5l", desc = "Move cursor right fast" },
      },

      -- Visual mode mappings
      v = {
        -- Move selected text up and down with Alt+j/k
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },

        -- Move selected text left/right with Alt+h/l
        ["<A-h>"] = { "<gv", desc = "Move selection left" },
        ["<A-l>"] = { ">gv", desc = "Move selection right" },
      },

      -- Insert mode mappings
      i = {
        -- Move lines up and down with Alt+j/k even in insert mode
        ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" },
        ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" },
      },
    },
  },
}
