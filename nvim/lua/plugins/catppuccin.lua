return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  priority = 1000,
  opts = {
    -- latte, frappe, macchiato, mocha
    flavour = 'frappe',
    integrations = {
      which_key = true,
      leap = true,
      harpoon = true,
    },
  }
}
