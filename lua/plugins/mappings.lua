return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        i = {
          -- 编辑模式下的左右下上
          ["<C-h>"] = { "<Left>", desc = "Move left" },
          ["<C-l>"] = { "<Right>", desc = "Move right" },
          ["<C-j>"] = { "<Down>", desc = "Move down" },
          ["<C-k>"] = { "<Up>", desc = "Move up" },
        },
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close buffer from tabline",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["<Leader>uY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
        },
      },
    },
  },
}
