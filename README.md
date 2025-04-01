# Neovim config

This configuration uses lazy.lua to load plugins from the `lua/plugins/` folder.

Highlight group 'NotifyBackground' has no background highlight
Please provide an RGB hex value or highlight group with a background value for 'background_colour' option.
This is the colour that will be used for 100% transparency.

```lua
require("notify").setup({
  background_colour = "#000000",
})
```

Defaulting to #000000
