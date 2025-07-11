return {
  {
    "javiorfo/nvim-soil",
    lazy = true,
    ft = "plantuml",
    dependencies = { "javiorfo/nvim-nyctophilia" },
    opts = {
      puml_jar = "~/plantuml.jar",
    },
    image = {
        darkmode = false, -- Enable or disable darkmode
        format = "png", -- Choose between png or svg

        -- This is a default implementation of using nsxiv to open the resultant image
        -- Edit the string to use your preferred app to open the image (as if it were a command line)
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        execute_to_open = function(img)
            vim.notify("Opening image: " .. img, vim.log.levels.INFO)
            return "nsxiv -b " .. img
        end
    }
  },
}
