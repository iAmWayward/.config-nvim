# Neovim config

This configuration uses lazy.lua to load plugins from the `lua/plugins/` folder.

- the autoformatting function formats code when you save the file. It doesn't apply to .c and .h files so I don't annoy my coworkers with gigantic diffs. You may prefer to remove that logic, but it also might piss off your coworkers if they know how version control works.

- I don't know how ready-for-action the DAP tool is. I've been debugging a network issue for the past few months so I haven't had call to set breakpoints and that kind of thing.

- Some keymaps are still floating around in the plugin files. But most of them are defined in /config/keymaps.lua. I also set up which-key and legendary, since I am a noob.

- AI assistant has vim motions under <leader>a, you can use basically any provider. In your bashrc or fish.lua or whatever, add env variables like

OPENAI_API_KEY
DEEPSEEK_AI_KEY
ANTHROPIC_AI_KEY

and it has ollama set up too, bring your own server

- Toggle transparency with :Transparency toggle, just know most themes have small visual issues in transparent mode, which I'm trying to fix. And the ones that work in transparent mode are transparent all the time :D so I'm meaning to fix that when this other stuff is off my plate.

I think that's all the important disclaimers, Sorry if declaring multiple plugins per file is annoying, but word on the street is nvim loads faster that way so I'm working towards having maybe 3-4 files in /plugins

Highlight group 'NotifyBackground' has no background highlight
Please provide an RGB hex value or highlight group with a background value for 'background_colour' option.
This is the colour that will be used for 100% transparency.

```lua
require("notify").setup({
  background_colour = "#000000",
})
```

Defaulting to #000000
