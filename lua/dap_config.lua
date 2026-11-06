local dap = require("dap")

dap.adapters.gdb = {
   type = "executable",
   command = "gdb",
   args = { "--interpreter=dap", "--command=init.gdb" }
}

dap.configurations.c = {
   {
      name = "Launch",
      type = "gdb",
      request = "launch",
      command = "gdb",
      args = {},
   }
}

local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
   dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
   dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
   dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
   dapui.close()
end

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
dap.configurations.rs = dap.configurations.c
dap.configurations.asm = dap.configurations.c
dap.configurations.s = dap.configurations.c
