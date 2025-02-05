function getopts(option_string, options)
    --print("getopts: " .. option_string)
    --tprint(options)
    -- Simulate the getopts function
    local opts = {}
    for opt in option_string:gmatch("[^:]+") do
        --print("getopts: " .. opt)
        --opts[opt] = options[opt] or (for flag in opt do opts[flag] = options[opt] end)
        if not options[opt] then
            --print("getopts: " .. opt .. " is nil, treating this as a flag")
            for flag in opt:gmatch(".") do
                if flag ~= "#" then
                    if options[flag] then
                        --print("getopts: " .. flag .. " is set to " .. options[flag])
                        opts[flag] = options[flag]
                    else
                        --print("getopts: " .. flag .. " is not set, setting to false")
                        opts[flag] = false
                    end
                    --opts[flag] = options[opt] or false
                end
            end
        else
            opts[opt] = options[opt]
        end
    end
    --tprint(opts)
    return opts
end
