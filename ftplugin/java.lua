require("java").setup {
    rename = {
        enable = true, -- enable the functionality for renaming java files
        nvimtree = true, -- enable nvimtree integration
        write_and_close = false -- automatically write and close modified (previously unopened) files after refactoring a java file
    },
    snippets = {
        enable = true -- enable the functionality for java snippets
    },
    root_markers = { -- markers for detecting the package path (the package path should start *after* the marker)
        "main/java/",
        "test/java/"
    }
}

local config = {
    cmd = {'/home/gregb/.local/share/nvim/mason/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)

vim.keymap.set('n', 'goi', function() require'jdtls'.organize_imports() end)
vim.keymap.set('n', 'gev', function() require'jdtls'.extract_variable() end)
vim.keymap.set('n', 'gem', function() require'jdtls'.extract_method() end)
vim.keymap.set('n', 'gec', function() require'jdtls'.extract_constant() end)
-- vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
-- nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
-- vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
-- vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
