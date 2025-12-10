-- PlantUML file type settings
vim.bo.syntax = "plantuml"
vim.bo.filetype = "plantuml"

-- Compile PlantUML
vim.keymap.set("n", "<leader>pc", ":!plantuml %<CR>", 
  { buffer = true, silent = true, desc = "Compile PlantUML" })

-- Compile and Preview PlantUML (macOS)
vim.keymap.set("n", "<leader>pp", ":!plantuml % && open -a Preview %:r.png<CR>",
  { buffer = true, silent = true, desc = "Compile and preview PlantUML" })
