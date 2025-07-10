return {
  "olimorris/onedarkpro.nvim",
  opts = {
    options = {
      transparency = true, -- Enable transparency
    },
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "NONE",
      variables = "NONE",
    },
    colors = {
      -- You can override specific colors here if needed
    },
    highlights = {
      -- Make the main background transparent
      Normal = { bg = "NONE" },
      NormalFloat = { bg = "NONE" },
      NormalNC = { bg = "NONE" },
      SignColumn = { bg = "NONE" },
      -- Keep line numbers background transparent
      LineNr = { bg = "NONE" },
      LineNrAbove = { bg = "NONE" },
      LineNrBelow = { bg = "NONE" },
      -- Make splits transparent
      VertSplit = { bg = "NONE" },
      WinSeparator = { bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("onedarkpro").setup(opts)
    vim.cmd "colorscheme onedark"
  end,
}
