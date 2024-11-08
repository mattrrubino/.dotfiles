return {
  {
    "NTBBloodbath/galaxyline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local gl = require("galaxyline")
      local gls = gl.section
      gl.short_line_list = { "LuaTree", "vista", "dbui" }

      local colors = {
        bg = "#000000",
        text = "#ffffff",
        yellow = "#fabd2f",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#afd700",
        orange = "#FF8800",
        purple = "#5d4d7a",
        magenta = "#d16d9e",
        grey = "#c0c0c0",
        blue = "#0087d7",
        red = "#ec5f67",
      }

      local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
          return true
        end
        return false
      end

      gls.left[2] = {
        ViMode = {
          provider = function()
            local alias = {
              n = "NORMAL",
              i = "INSERT",
              c = "COMMAND",
              v = "VISUAL",
              V = "VISUAL LINE",
              [""] = "VISUAL BLOCK",
            }
            return alias[vim.fn.mode()]
          end,
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[3] = {
        FileIcon = {
          provider = "FileIcon",
          condition = buffer_not_empty,
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[4] = {
        FileName = {
          provider = { "FileName", "FileSize" },
          condition = buffer_not_empty,
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }

      gls.left[5] = {
        GitIcon = {
          provider = function()
            return "  "
          end,
          condition = buffer_not_empty,
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[6] = {
        GitBranch = {
          provider = "GitBranch",
          condition = buffer_not_empty,
          highlight = { colors.text, colors.bg },
        },
      }

      local checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
          return true
        end
        return false
      end

      gls.left[7] = {
        DiffAdd = {
          provider = "DiffAdd",
          condition = checkwidth,
          icon = " ",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[8] = {
        DiffModified = {
          provider = "DiffModified",
          condition = checkwidth,
          icon = " ",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[9] = {
        DiffRemove = {
          provider = "DiffRemove",
          condition = checkwidth,
          icon = " ",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[10] = {
        LeftEnd = {
          provider = function()
            return ""
          end,
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[11] = {
        DiagnosticError = {
          provider = "DiagnosticError",
          icon = "  ",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[12] = {
        Space = {
          provider = function()
            return " "
          end,
          highlight = { colors.text, colors.bg },
        },
      }
      gls.left[13] = {
        DiagnosticWarn = {
          provider = "DiagnosticWarn",
          icon = "  ",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.right[1] = {
        FileFormat = {
          provider = "FileFormat",
          highlight = { colors.text, colors.bg },
        },
      }
      gls.right[2] = {
        LineInfo = {
          provider = "LineColumn",
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }

      gls.short_line_left[1] = {
        BufferType = {
          provider = "FileTypeName",
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }

      gls.short_line_right[1] = {
        BufferIcon = {
          provider = "BufferIcon",
          separator = " | ",
          separator_highlight = { colors.text, colors.bg },
          highlight = { colors.text, colors.bg },
        },
      }
    end,
  }
}
