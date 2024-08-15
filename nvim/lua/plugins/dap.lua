return {
  'nvim-lua/plenary.nvim',
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',

    config = function()
      local dap = require('dap')
      local job = require('plenary.job')
      local shared = require('shared')

      vim.fn.sign_define('DapBreakpoint', {
        text = '●',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '●',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '◆',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = '',
      })

      local function pick_executable()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })
        vim.notify(path)
        return path
      end

      local lldb_launch = {
        name = 'LLDB Launch',
        type = 'lldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local codelldb_launch = {
        name = 'CodeLLDB Launch',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local gdb_launch = {
        name = 'GDB Launch',
        type = 'gdb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local configs = { codelldb_launch, lldb_launch, gdb_launch }

      dap.configurations = {
        c = configs,
        cpp = configs,
        rust = configs,
      }

      local codelldb_path = 'codelldb'
      if shared.is_darwin() then
        codelldb_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb'
      end

      dap.adapters = {
        gdb = {
          type = 'executable',
          command = 'gdb',
          args = { '-i', 'dap' },
        },

        lldb = {
          type = 'executable',
          -- This is being renamed to lldb-dap
          command = 'lldb-vscode',
        },

        codelldb = {
          type = 'server',
          port = '${port}',
          executable = {
            command = codelldb_path,
            args = { '--port', '${port}' },
          },
        },
      }

      local function set_condition_breakpoint()
        vim.ui.input({
          prompt = 'Breakpoint condition: ',
        }, function(choice)
          dap.set_breakpoint(choice)
        end)
      end

      shared.map('n', '<F5>', dap.continue)
      shared.map('n', '<F9>', dap.terminate)
      shared.map('n', '<F10>', dap.step_over)
      shared.map('n', '<F11>', dap.step_into)
      shared.map('n', '<F12>', dap.step_out)
      shared.map('n', '<leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
      shared.map('n', '<leader>dC', dap.clear_breakpoints, 'clear breakpoints')
      shared.map('n', '<leader>dD', set_condition_breakpoint, 'breakpoint condition')
    end
  }
}
