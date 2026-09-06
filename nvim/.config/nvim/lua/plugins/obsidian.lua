return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/vaults/personal/*.md",
    "BufReadPre " .. vim.fn.expand("~") .. "/vaults/uni/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/vaults/personal/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/vaults/uni/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "uni",
        path = "~/vaults/uni",
      },
    },

    -- see below for full list of options 👇
  },
}
