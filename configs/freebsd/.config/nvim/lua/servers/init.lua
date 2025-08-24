local on_attach = require("utils.lsp").on_attach
local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP
require("servers.rust")(lspconfig, capabilities, on_attach)
require("servers.luau")(lspconfig, capabilities, on_attach)
require("servers.pyright")(lspconfig, capabilities, on_attach)
require("servers.svelte")(lspconfig, lspconfig_util, capabilities, on_attach)
