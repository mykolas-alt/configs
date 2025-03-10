return {
  "snacks.nvim",
  opts = {
    animate = {
      duration = { step = 15, total = 250 },
      easing = "linear",
    },
    -- faster animation when repeating scroll after delay
    animate_repeat = {
      delay = 100, -- delay in ms before using the repeat animation
      duration = { step = 5, total = 50 },
      easing = "linear",
    },
  },
}
