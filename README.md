# Neovim Coding-Ready IDE

This README assumes almost no knowledge of (neo)vi(m) on the part of the reader.

## Quick Start

```bash
cd ~/.config
git clone https://github.com/AlphaNumericPencil/.config-nvim nvim
```

### Setup MCP for AI Assistant

```bash

sudo npm install -g mcp-hub@latest # MCP hub for AI

sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:justkidding/Fedora_Rawhide/home:justkidding.repo

sudo dnf install ueberzugpp ImageMagick-devel
```


## Keybindings

- The <leader> key is spacebar by default

- You can view keybindings within neovim by pressing Ctrl+p.

- All the normal vim keybindings have been preserved.

### Basic Movement
In vim, movement should be done with hjkl. These four keys are in your "home row" and
should be right beneath your fingers on your right hand when your hands are neutral on
the keyboard. Thus, movement left/up/down/right can be done with aboslutely minimal movement.

### Intermediate Movement


Vim uses "Motions" to accomplish most actions. You can understand most of them with memonic devices.
For example, `a` is for "after." Therefore, pressing `a` in `normal` mode will put the editor into 
`Insert` mode in the space **after** where the cursor is. `A` will put you in `Insert` mode
**after** the current line.

- `i` = Insert (before) 

- `C` = Ctrl

- `M` = Alt (Meta key)

- `<CR>` = carriage return

- `<leader>` = Special key for user-defined motions. It is unbound in vim by default.

So `C-r` means "Press Ctrl and r at the same time"
while "Cr" means "Press capital C then r in sequence."

## Description

This config utilizes `buffers` to act as tabs within a given vim tab.
Using this method will help you stay organized when working with
multiple projects by allowing you to have multiple tabs from the
same project stored in a higher tab.

Because of this, you must use `<leader>q` to close a buffer rather
than `:q`, which will close all the buffers along with the tab itself.

- **The `<leader>` key is bound to spacebar.** Feel free to change this.

### Important Motions (keybindings)

- `<leader>o` File Tree Toggle

- `<leader>O` Outline Toggle (very useful)

- `C-\` Toggle terminal

- `C-p` Show keybindings

- `K` Show documentation

- `gd` Hover definition ([g]o to [d]efinition)

- `gD` Go to definition

- `za` Toggle Fold/Collapse code under cursor

- `xX` Toggle diagnostics for this buffer

- `xx` Toggle diagnostics for entire project

#### Appearance Motions

- `<leader>t` toggle transparency
- `<leader>T` Change theme

The rest should hopefully be fairly straightforward.

## Setup

### Linux

```bash
sudo (dnf install neovim || apt install neovim || pacman -S neovim) # Use your distro package manager.
```

Then,

```bash
cd ~/.config && git clone https://github.com/AlphaNumericPencil/.config-nvim.git nvim
```

### Windows

1. Download a random exe from the internet which purports to be neovim.
   Or something, I guess.
1. `git clone https://github.com/AlphaNumericPencil/.config-nvim.git $env:LOCALAPPDATA\nvim`

### All Platforms

Launch with the `nvim` command and then type `:Lazy update`.

Colon will launch the command pallete. Once you type the
command and hit `<Enter>`. The plugins should install without
issue. Exit neovim and relaunch.

#### Code Companion

The AI assistant has vim motions under `<leader>a`. You can
use the vast majority of providers. In your bashrc or fish.lua,
just add env variables like

OPENAI_API_KEY
DEEPSEEK_AI_KEY
ANTHROPIC_AI_KEY

Ollama is set up too. Bring your own server

### Additional Notes

This config uses `/configs/lazy.lua` to load plugins from the `lua/plugins/` folder.

Keymaps are defined in `lua/configs/keymaps`
CodeCompanion is configured in `lua/config/code-companion`

- the auto-formatting function will format code when you save the file.
  It does not format .c and .h files because I don't want to annoy my coworkers.
  You may prefer to remove that exclusionary logic, or you can
  modify it to disable formatting for other languages.

- I don't know how ready-for-action the DAP tool is. I've been debugging
  a network issue for the past few months, so I haven't had call to set
  breakpoints and that kind of thing.

- Some keymaps are still floating around in the plugin files.
  That being said, most are defined in /config/keymaps.lua..

\\<https://github.com/ravitemer/mcphub.nvim#avante-integration>
