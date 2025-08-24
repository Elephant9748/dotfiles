local M = {}

M.on_attach = function(client, bufnr)
	local keymap = vim.keymap.set
	local opts = {
		noremap = true, -- prevent recursive mapping
		silent = true, -- don't print the command to the cli
		buffer = bufnr, -- restrict the keymap to the local buffer number
	}

	-- -- native neovim keymaps
	-- keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- goto definition
	-- keymap("n", "<leader>gS", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts) -- goto definition in split
	-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Code actions
	-- keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- Rename symbol
	-- keymap("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float({ scope = 'line' })<CR>", opts) -- Line diagnostics (float)
	-- keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Cursor diagnostics
	-- keymap("n", "<leader>pd", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- previous diagnostic
	-- keymap("n", "<leader>nd", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- next diagnostic
	-- keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- hover documentation
	--
	-- -- fzf-lua keymaps
	-- keymap("n", "<leader>gd", "<cmd>FzfLua lsp_finder<CR>", opts) -- LSP Finder (definition + references)
	-- keymap("n", "<leader>gr", "<cmd>FzfLua lsp_references<CR>", opts) -- Show all references to the symbol under the cursor
	-- keymap("n", "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", opts) -- Jump to the type definition of the symbol under the cursor
	-- keymap("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<CR>", opts) -- List all symbols (functions, classes, etc.) in the current file
	-- keymap("n", "<leader>ws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts) -- Search for any symbol across the entire project/workspace
	-- keymap("n", "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- Go to implementation

    vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n","gT", vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set("n","<leader>i", vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n","<leader>ds", "<cmd>Telescope diagnostics<cr>", {buffer=0})
    vim.keymap.set("n","<leader>f", "<cmd>Telescope git_files<cr>", {buffer=0})
    vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
    vim.keymap.set("n", "tc", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>", {buffer=0})
    -- vim.keymap.set("n", "<leader>1", "<cmd>move +1<cr>", {buffer=0})
    -- vim.keymap.set("n", "<leader>2", "<cmd>move -2<cr>", {buffer=0})
    vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {buffer=0})
    vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {buffer=0})
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    -- asbjornHaland
    vim.keymap.set("n", "<leader>y", "\"+y")
    vim.keymap.set("v", "<leader>y", "\"+y")
    vim.keymap.set("n", "<leader>Y", "\"+Y")

    --
    vim.keymap.set("i", "<C-c>", "<Esc>")
    vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
    vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

    -- stop semantic_token current buffer
    vim.keymap.set("n","<leader>h", "<cmd>lua =vim.lsp.semantic_tokens.stop(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
    -- vim.keymap.set("n","<leader>q", "<cmd>lua =vim.api.nvim_buf_get_number(0)<cr>", {buffer=0})

    -- start semantic_token current buffer
    vim.keymap.set("n","<leader>H", "<cmd>lua =vim.lsp.semantic_tokens.start(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})


	-- Order Imports (if supported by the client LSP)
	-- if client.supports_method("textDocument/codeAction") then
	-- 	keymap("n", "<leader>oi", function()
	-- 		vim.lsp.buf.code_action({
	-- 			context = {
	-- 				only = { "source.organizeImports" },
	-- 				diagnostics = {},
	-- 			},
	-- 			apply = true,
	-- 			bufnr = bufnr,
	-- 		})
	-- 		-- format after changing import order
	-- 		vim.defer_fn(function()
	-- 			vim.lsp.buf.format({ bufnr = bufnr })
	-- 		end, 50) -- slight delay to allow for the import order to go first
	-- 	end, opts)
	-- end
end

return M
