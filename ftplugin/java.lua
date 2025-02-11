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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

local config = {
	capabilities = capabilities,
    cmd = {
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/home/gregb/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/home/gregb/.local/share/jdtls/config_linux',
    '-data', '/home/gregb/.local/share/jdtls/data/'
	},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	  settings = {

		-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- https://sookocheff.com/post/vim/neovim-java-ide/
		java = {
			completion = {
				enabled = true,
				guessMethodArguments = true,
				filteredTypes = {
				  "com.sun.*",
				  "io.micrometer.shaded.*",
				  "java.awt.*",
				  "jdk.*", "sun.*",
				},
			}
		}
	  },

	  init_options = {
		bundles = {}
	  },
	on_attach = function(client)
	  client.server_capabilities.semanticTokensProvider = nil -- Disable lsp highlighting 
	end
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


-- run maven test on gmt
vim.keymap.set('n', 'gmt', function() 
	vim.cmd(':2TermExec cmd="./mvnw -Djasypt.encryptor.password=$JASYPT_ENCRYPTOR_PASSWORD clean test | tee test.txt"')
	vim.cmd(':2TermExec cmd="exit"')
end)
