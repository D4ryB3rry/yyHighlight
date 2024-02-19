
# yyHighlight

`yyHighlight` is a Neovim plugin written in Lua, designed to enhance the yanking (copying) experience by temporarily highlighting the yanked text. This visual feedback helps users to see exactly what text has been copied, supporting both single-line and multi-line yanks.

## Features

- **Visual Feedback**: Highlights yanked text, making it easier to see what has been copied.
- **Configurable**: Allows customization of highlight duration and color.
- **Support for Multi-line Yanks**: Works with single-line (`yy`) and multi-line (`2yy`, `3yy`, etc.) yank operations.

## Requirements

- Neovim (0.5.0 or newer)

## Installation

### Using lazy.nvim

To install `yyHighlight` with `lazy.nvim`, add the following to your Neovim configuration:

```lua
require("lazy").setup({
  {"username/yyHighlight", lazy = false},
})
```

Replace `username/yyHighlight` with the actual GitHub username and repository if you're hosting it on GitHub, or adjust the path accordingly if it's hosted elsewhere.

### Manual Installation

For a manual installation, clone this repository to your Neovim configuration directory and source it from your `init.lua` or `init.vim`.

## Configuration

After installing the plugin, you can configure it by calling the `setup` function. Here is an example configuration with default settings:

```lua
require('yyHighlight').setup({
    highlight_group = "MyHighlight",  -- Highlight group name
    highlight_color = "Green",        -- Highlight color
    highlight_duration = 5000         -- Highlight duration in milliseconds
})
```

### Customizing Highlight Color and Duration

You can customize the color and duration of the highlight by modifying the `setup` configuration:

```lua
require('yyHighlight').setup({
    highlight_color = "#FFD700",  -- Example: Gold color
    highlight_duration = 3000     -- Highlight for 3 seconds
})
```

## Usage

`yyHighlight` works automatically after installation and configuration. Simply use the yank command (`yy`, `2yy`, etc.) as you normally would, and the yanked text will be highlighted.

## Contributing

Contributions to `yyHighlight` are welcome! Feel free to open issues or submit pull requests with improvements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
