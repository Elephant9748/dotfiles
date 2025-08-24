return {
        'junegunn/fzf.vim',
        dependencies = {
                { 'junegunn/fzf', build = './install --all' },
        },
        config = function()
                vim.g.fzf_layout = {  down= '~15%' }
        end,

}
