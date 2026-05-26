return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    { "<leader>rc", function() require("remote-sshfs.api").connect() end, desc = "Remote Connect" },
    { "<leader>rd", function() require("remote-sshfs.api").disconnect() end, desc = "Remote Disconnect" },
    { "<leader>re", function() require("remote-sshfs.api").edit() end, desc = "Remote Edit SSH Config" },
    { "<leader>rf", function() require("remote-sshfs.api").find_files() end, desc = "Remote Find Files" },
    { "<leader>rg", function() require("remote-sshfs.api").live_grep() end, desc = "Remote Live Grep" },
  },
}
