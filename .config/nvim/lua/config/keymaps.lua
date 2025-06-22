-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<C-G>", "<C-K>")

local smart_splits = require("smart-splits")
vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left)
vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down)
vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up)
vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right)

vim.keymap.set("n", "<M-h>", smart_splits.resize_left)
vim.keymap.set("n", "<M-j>", smart_splits.resize_down)
vim.keymap.set("n", "<M-k>", smart_splits.resize_up)
vim.keymap.set("n", "<M-l>", smart_splits.resize_right)
