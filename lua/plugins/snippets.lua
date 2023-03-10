local function generate_php_namespace(_, _, _)
  local buf_path = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
  local buf_dir = buf_path:sub(0, buf_path:find("/[^/]*$"))
  local path = vim.fs.normalize(vim.fs.find("composer.json", {
    upward = true,
    type = "file",
  })[1])
  local root = path:sub(0, path:find("/[^/]*$"))
  local segments = vim.split(buf_dir:gsub(root, ""), "/", {
    plain = true,
  })
  local namespace_path = ""
  for index, value in ipairs(segments) do
    if index ~= 1 and index ~= vim.tbl_count(segments) then
      namespace_path = namespace_path .. "\\"
    end
    namespace_path = namespace_path .. value:gsub("^%l", string.upper)
  end
  return namespace_path
end

return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local f = ls.function_node
      local i = ls.insert_node
      ls.add_snippets("php", {
        s("ns", {
          t("namespace "),
          f(generate_php_namespace, {}),
          t(";"),
        }),
        s("strict", {
          t("declare(strict_types=1);"),
        }),
      })

      ls.add_snippets("rust", {
        s("amain", {
          t({ "#[tokio::main]", "async fn main() {", "    " }),
          i(0),
          t({ "", "}" }),
        }),
      })
    end,
    opts = function(_, opts)
      opts.history = false
      opts.region_check_events = "CursorMoved"
      opts.delete_check_events = "TextChanged"
    end,
    keys = function()
      return {
        {
          "<tab>",
          function()
            return require("luasnip").locally_jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
        {
          "<tab>",
          function()
            require("luasnip").jump(1)
          end,
          mode = "s",
        },
        {
          "<s-tab>",
          function()
            require("luasnip").jump(-1)
          end,
          mode = { "i", "s" },
        },
      }
    end,
  },
}
