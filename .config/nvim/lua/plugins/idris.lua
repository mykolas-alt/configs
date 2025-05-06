return {
  {
    "idris-community/idris2-nvim",
    -- Optionally, you can choose to lazy-load it based on events or filetypes:
    ft = "idris2",
    opts = {
      client = {
        hover = {
          use_split = true, -- Persistent split instead of popups for hover
          split_size = "30%", -- Size of persistent split, if used
          auto_resize_split = false, -- Should resize split to use minimum space
          split_position = "bottom", -- bottom, top, left or right
          with_history = false, -- Show history of hovers instead of only last
          use_as_popup = false, -- Close the split on cursor movement
        },
      },
      server = {}, -- Options passed to lspconfig idris2 configuration
      autostart_semantic = true, -- Should start and refresh semantic highlight automatically
      code_action_post_hook = function(action)
        vim.cmd("silent write")
      end, -- Function to execute after a code action is performed:
      use_default_semantic_hl_groups = false, -- Set default highlight groups for semantic tokens
      default_regexp_syntax = true, -- Enable default highlight groups for traditional syntax based highlighting
    },
  },
}
