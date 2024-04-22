return {
    {

        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        ft = "http",
        opts = {
            rocks = { "fzy", "pathlib.nvim ~> 1.0", "lua-curl" }, -- specifies a list of rocks to install
            --     luarocks_build_args = { "--with-lua=.luarocks/config.lua" }, -- extra options to pass to luarocks's configuration script
        },
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "luarocks.nvim" },
        keys = {
            {
                "<leader>rr", "<cmd>Rest run<cr>", "Run request under the cursor",
            },
            {
                "<leader>rl", "<cmd>Rest run last<cr>", "Re-run latest request",
            },
        },
        config = function()
            local rest = require("rest-nvim")
            rest.setup {
                client = 'curl',
                result = {
                    split = {
                        horizontal = false,
                        in_place = true,
                    },
                },
            }
        end,

    }
}
