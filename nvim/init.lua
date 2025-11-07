vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)

vim.o.termguicolors = true
vim.o.guicursor = "a:block-blinkon0,i-r:hor20"

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.list = true
vim.o.listchars = "tab:  "

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = "menuone,noselect"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.autoread = true

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

local state = {
    buf = -1,
    win = -1,
}

vim.keymap.set({ "t", "i", "n" }, "<C-t>", function()
    local screen_width = vim.o.columns
    local screen_height = vim.o.lines

    local width = math.floor(screen_width * 0.8)
    local height = math.floor(screen_height * 0.7)

    -- Calculate the position to center the window
    local row = math.floor((screen_height - height - 4) / 2)
    local col = math.floor((screen_width - width) / 2)

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    if not vim.api.nvim_win_is_valid(state.win) then
        state.win = vim.api.nvim_open_win(state.buf, true, {
            relative = "editor",
            row = row,
            col = col,
            width = width,
            height = height,
            style = "minimal",
            border = "rounded",
        })

        vim.api.nvim_set_option_value(
            "winhl",
            "Normal:TelescopeNormal,FloatBorder:TelescopeBorder",
            { win = state.win }
        )

        if vim.api.nvim_get_option_value("buftype", { buf = state.buf }) ~= "terminal" then
            vim.cmd.terminal()
        else
            vim.cmd.startinsert()
        end
    else
        vim.api.nvim_win_hide(state.win)
    end
end)

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "",
    command = "startinsert",
})

vim.api.nvim_create_autocmd("TermOpen", {
    command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

vim.api.nvim_create_autocmd("CursorHold", {
    command = "checktime",
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        {
            "typicode/bg.nvim",
        },
        {
            "rebelot/kanagawa.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },
        {
            "nvim-telescope/telescope.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            lazy = true,
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        {
            "j-hui/fidget.nvim",
            tag = "v1.6.1",
            opts = {},
        },
        {
            "stevearc/conform.nvim",
            event = "VeryLazy",
        },
        {
            "tpope/vim-commentary",
            keys = {
                { "gc" },
                { "gc", mode = "v" },
            },
        },
        {
            "tpope/vim-surround",
            keys = {
                "cs",
                "ds",
            },
            dependencies = {
                "tpope/vim-repeat",
            },
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true,
        },
    },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "spellfile",
            },
        },
    },
})

vim.o.background = "dark"
vim.cmd.colorscheme("kanagawa-dragon")

require("telescope").setup({
    defaults = require("telescope.themes").get_ivy({
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
            n = {

                ["j"] = false,
                ["k"] = false,
                ["<C-N>"] = "move_selection_next",
                ["<C-P>"] = "move_selection_previous",
            },
        },
        prompt_prefix = "Search: ",
        selection_caret = "* ",
    }),
})

pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>?", builtin.oldfiles)
vim.keymap.set("n", "<leader>gf", builtin.git_files)
vim.keymap.set("n", "<C-h>", builtin.find_files)
vim.keymap.set("n", "<leader>sg", builtin.live_grep)
vim.keymap.set("v", "<leader>sg", builtin.grep_string)
vim.keymap.set("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
vim.keymap.set("n", "<leader>sh", builtin.help_tags)

vim.lsp.config['luals'] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/busted/library",
                    "${3rd}/luv/library",
                },
            },
        },
    },
}

vim.lsp.config['nixd'] = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
}

vim.lsp.config['rust-analyzer'] = {
    cmd = { "rust-analyzer" },
    root_markers = { "cargo.json" },
    filetypes = { "rust" },
}

vim.lsp.enable({ "luals", "nixd", "rust-analyzer" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        local opts = { buffer = e.buf }
        local telescope = require("telescope.builtin")

        vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
        vim.keymap.set("n", "gD", function()
            telescope.lsp_definitions({ jump_type = "split" })
        end, opts)
        vim.keymap.set("n", "gr", telescope.lsp_references, opts)
        vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
        vim.keymap.set("n", "<C-l>", telescope.lsp_document_symbols, opts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.code_action, opts)

        vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = false,
        })

        vim.keymap.set("n", "<C-k>", function()
            vim.diagnostic.open_float(nil, { focus = false })
        end, opts)

        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = e.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = e.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
