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

      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
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

      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
      }

      dap.configurations["php"] = {
        {
          type = "php",
          request = "launch",
          name = "Listen for xdebug",
          port = "9003",
        },
      }
    end,
  },
  {
    "leoluz/nvim-dap-go",
    event = "BufReadPre *.go",
    config = true,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "BufReadPre",
    opts = {
      automatic_setup = true,
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "BufReadPre *.js *.ts",
    init = function()
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })
      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "microsoft/vscode-js-debug",
    event = "BufReadPre *.js *.ts",
    build = "npm ci --legacy-peer-deps && npm run compile",
  },
}
