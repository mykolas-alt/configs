return {
  "mrcjkb/haskell-tools.nvim",
  version = "^6",
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  dependencies = {
    { "nvim-telescope/telescope.nvim", optional = true },
  },
  config = function()
    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("ht")
    end
  end,
}
