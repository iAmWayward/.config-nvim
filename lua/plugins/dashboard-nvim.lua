return {
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            -- Function to generate a dynamic header
            local function generate_header()
                local day = os.date("%A") -- Get the day of the week
                local hour = tonumber(os.date("%H")) -- Get the current hour
                local greeting = ""

                if hour < 12 then
                    greeting = "Good Morning!"
                elseif hour < 18 then
                    greeting = "Good Afternoon!"
                else
                    greeting = "Good Evening!"
                end

                return {
                    greeting,
                    "Today is " .. day,
                }
            end

            -- Dashboard setup
            require('dashboard').setup({
                theme = 'hyper', -- Ensure theme is explicitly set
                disable_at_vimenter = true,
                config = {
                    header = generate_header(),
                    week_header = {
                        enable = true,
                        concat = " - Let's Code!",
                    },
                    disable_move = false,
                    shortcut = {
                        {
                            desc = "  Find File",
                            group = "DashboardShortCut",
                            action = "Telescope find_files",
                            key = "f"
                        },
                        {
                            desc

= " Recent Files", group = "DashboardShortCut", action = "Telescope oldfiles", key = "r" }, { desc = " Config", group = "DashboardShortCut", action = "edit ~/.config/nvim/init.lua", key = "c" }, }, footer = { "Have a productive session!", }, }, }) end, dependencies = { 'nvim-tree/nvim-web-devicons' } } }
