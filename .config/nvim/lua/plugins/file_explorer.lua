return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- No es estrictamente necesario, pero recomendado
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    priority = 1000,
    config = function()
      -- Configuración de NeoTree
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
          }
        }
      })
    end,
    -- Usamos "lazy" como condición de carga para cargarlo solo cuando se presione la tecla <leader>ft
    lazy = false,
  }
}

