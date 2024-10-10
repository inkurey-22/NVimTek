# NVimTek
A simple NeoVim plugin to generate EPITECH headers

## Features

- Automatically retrieves the project name from your Git repository.
- Prompts for a file description and inserts it into the header.
- Supports custom header formats based on file type:
  - C header files (`.h`) with header guards.
  - `Makefiles` with specific formatting.
  - General file types with a standard format.
- Automatically sets a visual column at 80 characters for coding standards.

## Installation

### vim-plug
Add the following to your `init.lua`
```
Plug 'inkurey-22/NVimTek'
```
Then use the command
```
:PlugInstall
```

### packer.nvim
Add this to your `packer` configuration :
```
use 'inkurey-22/NVimTek'
```
Then use the command
```
:PackerSync
```
### Other
Or simply download the zip of the repo and put the `NVimTek` folder into your `~/.config/nvim/lua/`

## Usage
The plugin provides a single command : `:Header`, which inserts the appropriate
EPITECH header at the top of the file.
It will :
- Retrieve the project name from the Git repository (or use `curry` as placeholder).
- Prompt you for a file description
- And insert the header.

The filetype supported are :
- `.h`, where it will also insert the header guards (`#ifndef`, `#define` and `#endif`)
- `Makefile`, for the specific Makefile header
- And all other files where it will insert the classic header.

## More ?
I'll maybe put the shebang (`#!/bin/bash`) soon if I have the motivation
