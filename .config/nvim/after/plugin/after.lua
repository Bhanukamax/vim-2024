-- Convenient key bind functions
local tmap = function(key, cb) vim.keymap.set('t',key, cb) end
local nmap = function(key, cb) vim.keymap.set('n',key, cb) end

-- Tman
local tman = require('tman')

nmap('<A-`>', function() tman.toggleLast { insert = true } end)
tmap('<A-`>', tman.toggleLast)

-- Tree-sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" , "rust"},
    sync_install = false,
    auto_install = true,
    -- ignore_install = { "javascript" },
    indent = { enable = true, disable = { 'ruby' } },
    highlight = {
        enable = true,
        -- disable = { "c", "rust" },
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
}
