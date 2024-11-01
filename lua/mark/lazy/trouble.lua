return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle("diagnostics")
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({ mode = "diagnostics", skip_groups = true, jump = true });
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").prev({ mode = "diagnostics", skip_groups = true, jump = true });
            end)
        end
    },
}
