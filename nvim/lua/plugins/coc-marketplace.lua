return {
  "fannheyward/coc-marketplace",
  dependencies = { "neoclide/coc.nvim" },
  config = function()
    -- Custom Mason-like interface
    local function create_coc_manager()
      local nui_menu = require("nui.menu")
      local nui_popup = require("nui.popup")
      -- Create the main menu
      local menu_items = {
        { text = "📦 Install Language Server", action = "install" },
        { text = "🗑️  Uninstall Language Server", action = "uninstall" },
        { text = "🔄 Update All Extensions", action = "update" },
        { text = "📋 List Installed Extensions", action = "list" },
        { text = "🛠️  Configure Extensions", action = "config" },
        { text = "❓ Search Marketplace", action = "search" },
      }

      local menu = nui_menu({
        position = "50%",
        size = {
          width = 50,
          height = 10,
        },
        border = {
          style = "rounded",
          text = {
            top = " COC Manager ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      }, {
        lines = vim.tbl_map(function(item)
          return nui_menu.item(item.text, { action = item.action })
        end, menu_items),
        on_close = function()
          -- Handle menu close
        end,
        on_submit = function(item)
          if item.action == "install" then
            vim.cmd("CocList marketplace")
          elseif item.action == "uninstall" then
            vim.cmd("CocList extensions")
          elseif item.action == "update" then
            vim.cmd("CocCommand extensions.forceUpdateAll")
          elseif item.action == "list" then
            vim.cmd("CocList extensions")
          elseif item.action == "config" then
            vim.cmd("CocConfig")
          elseif item.action == "search" then
            vim.cmd("CocList marketplace")
          end
        end,
      })

      return menu
    end

    -- Create user command for Mason-like interface
    vim.api.nvim_create_user_command("CocManager", function()
      local menu = create_coc_manager()
      menu:mount()
    end, {})

    -- Create keybinding
    vim.keymap.set("n", "<leader>cm", "<cmd>CocManager<cr>", { desc = "Open COC Manager" })
  end,
}
