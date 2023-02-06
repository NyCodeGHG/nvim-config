local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.8.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so" -- MacOS: This may be .dylib

return {
  {
    "Pocco81/dap-buddy.nvim",
    event = "BufReadPre",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    event = "BufReadPre",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "BufReadPre",
    config = true,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    event = "BufReadPre",
    init = function()
      require("telescope").load_extension("dap")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    init = function()
      local dap = require("dap")
      local dapui = require("dapui")

      if vim.g.colors_name == "catppuccin" then
        local sign = vim.fn.sign_define

        sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      end

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local wk = require("which-key")

      local keymap = {
        d = {
          name = "Debug",
          R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
          E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
          C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
          U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
          b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
          c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
          d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
          e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
          g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
          h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
          S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
          i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
          o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
          p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
          q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
          r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
          s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
          t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
          x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
          u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        },
      }
      wk.register(keymap, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
      })

      local keymap_v = {
        name = "Debug",
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      }
      wk.register(keymap_v, {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
      })
    end,
  },
}
