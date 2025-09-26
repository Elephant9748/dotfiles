local on_attach = require("utils.lsp").on_attach
local lspconfig_util = require("lspconfig.util")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP
require("servers.rust")(capabilities, on_attach)
require("servers.luau")(capabilities, on_attach)
require("servers.pyright")(capabilities, on_attach)
require("servers.svelte")(lspconfig_util, capabilities, on_attach)
