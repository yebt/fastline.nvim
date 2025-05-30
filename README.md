# fastline.nvim

**fastline.nvim** is a fast, modular, and highly extensible statusline for Neovim. Inspired by modeline.nvim, it is built for performance, customization, and efficient redraw control.

## 🚀 Features

* 🔧 Modular by design: define your statusline in `left`, `center`, and `right` sections.
* 🧱 User-defined modules (`providers`) support.
* ⚡ Efficient redraw system with event coalescing.
* 🧠 Supports Vim expressions (`%{...}`) and literal text with optional highlight.
* 🎨 Dynamic color switching based on current mode.
* 📦 Lightweight and dependency-free.

---

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "yourgithubuser/fastline.nvim",
  config = function()
    require("fastline").setup({
      -- your config here
    })
  end
}
```

---

## ⚙️ Basic Configuration

```lua
require("fastline").setup({
  sections = {
    left = {
      "mode",
      { text = " | ", hl = "FastlineSeparator" },
      { text = "%{&fileencoding}", hl = "FastlineEncoding" },
    },
    center = { "filename" },
    right = { "lsp", "git" },
  },
})
```

---

## 🧩 Adding Custom Modules

You can register your own modules using `fastline.register("name", function() ... end)`:

```lua
require("fastline").register("clock", function()
  return os.date("%H:%M")
end)
```

And then use them in your `setup`:

```lua
sections = {
  right = { "clock" },
}
```

---

## 🎨 Mode-Based Highlights

The built-in `mode` module changes its color depending on the current mode:

```lua
vim.api.nvim_set_hl(0, "FastlineModeNormal", { fg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "FastlineModeInsert", { fg = "#61afef", bold = true })
vim.api.nvim_set_hl(0, "FastlineModeVisual", { fg = "#c678dd", bold = true })
```

This is automatically handled inside the `mode.lua` module when mode changes are detected.

---

## 🔄 Efficient Redraw

Fastline coalesces redraws using an internal scheduler to avoid flickering or redundant updates when multiple UI changes occur together.

---

## 🧪 Advanced: Literal Fragments and Vim Expressions

You can directly include Vim expressions in the statusline:

```lua
{ text = "%{&fileformat}", hl = "FastlineInfo" }
```

Or insert static styled text:

```lua
{ text = " ⮞ ", hl = "FastlineArrow" }
```

---

## 📜 License

MIT

---

## 🙌 Acknowledgments

Based on the work of `modeline.nvim`, optimized for extensibility and performance. Thanks to the Neovim community!

