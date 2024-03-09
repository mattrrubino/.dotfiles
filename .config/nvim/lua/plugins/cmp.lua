local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = { border = "rounded" },
          documentation = { border = "rounded" },
        },
        formatting = {
          format = function(entry, vim_item)
            if entry.source.name ~= "nvim_lsp_signature_help" then
              vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            else
              vim_item.kind = ""
            end
            return vim_item
          end,
        },
        mapping = {
          ['<C-k>'] = cmp.mapping.complete(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            { "i", "s" }
          ),
          ["<S-Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
            { "i", "s" }
          ),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
      })

      local npairs = require('nvim-autopairs')
      npairs.setup()

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')

      local match_angle_bracket = function()
        local line = vim.api.nvim_get_current_line()
        local x = vim.api.nvim_win_get_cursor(0)[2]

        local is_include = string.match(line, "#include")
        local is_template = string.match(line, "template")
        local is_template_parameters = x > 0 and string.match(line:sub(x, x), "[a-zA-Z]")

        return is_include or is_template or is_template_parameters or false
      end

      local bracket = require('nvim-autopairs.rules.basic').bracket_creator(npairs.config)
      npairs.add_rule(bracket('<', '>'):with_pair(match_angle_bracket))

      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' } }
      npairs.add_rules {
        Rule(' ', ' ')
            :with_pair(function(opts)
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
                brackets[4][1] .. brackets[4][2]
              }, pair)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local context = opts.line:sub(col - 1, col + 2)
              return vim.tbl_contains({
                brackets[1][1] .. '  ' .. brackets[1][2],
                brackets[2][1] .. '  ' .. brackets[2][2],
                brackets[3][1] .. '  ' .. brackets[3][2],
                brackets[4][1] .. '  ' .. brackets[4][2]
              }, context)
            end)
      }

      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
              :with_pair(cond.none())
              :with_move(function(opts) return opts.char == bracket[2] end)
              :with_del(cond.none())
              :use_key(bracket[2])
              :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
        }
      end
    end,
  }
}
