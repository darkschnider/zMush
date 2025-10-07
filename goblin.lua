zEffects = require "effects"
require("add_effect")
local trigFlags = 33 -- Enabled | RegularExpression

local shop_items = {}
local total_price = 0
local found_item_count = 0
function goblinStoreItem(name, line, wildcards)
    local item = tonumber(wildcards[1])
    local price = tonumber(wildcards[2])
    if item and price and price < 10000 then
        shop_items[item] = price
        total_price = total_price + price
        found_item_count = found_item_count + 1
        --print("Added item: " .. item .. " with price: " .. price)
    end
end

function goblinListEnd(name, line, wildcards)
    DeleteTrigger("luaListEnd")
    DeleteTrigger("luaStoreItem")
    print(found_item_count .. " shop items collected, would cost [" .. total_price .. "] to buy all of them.")
    --for item, price in pairs(shop_items) do
    --    print(item .. ": " .. price)
    --end

    --shop_items = {} -- Clear the table after processing
end

function goblinShopBuy(name, line, wildcards)
    local keys = {}
    for k in pairs(shop_items) do
        --print("Adding item to buy list: " .. k)
        table.insert(keys, k)
    end
    table.sort(keys, function(a, b) return a < b end)
    for i = #keys, 1, -1 do
        local k = keys[i]
        --print("Buying item: " .. k .. " for price: " .. shop_items[k])
        -- Change to Execute to run these commands instead of just making a note
        Execute("buy " .. k .. ";sell noeq")
    end
end

function goblinShopList(name, line, wildcards)
    AddTriggerEx("luaListEnd", "^`-------------------------------------------------------------'$", "", trigFlags, -1, 0, "", "goblinListEnd", sendto.world, 100)
    AddTriggerEx("luaStoreItem", "^\\|\\s*(\\d+)\\.\\|.*\\|\\s*(\\d+)\\|\\s*\\d+\\|$", "", trigFlags, -1, 0, "", "goblinStoreItem", sendto.script, 100)
    shop_items = {} -- Clear the table before starting
    total_price = 0
    found_item_count = 0
    Send("list")
end

DeleteTrigger("luaListEnd")
DeleteTrigger("luaStoreItem")
DeleteAlias("luaGoblinShopList")
AddAlias("luaGoblinShopList", "/glist", "", aliasEnabled, "goblinShopList")
DeleteAlias("luaGoblinShopBuy")
AddAlias("luaGoblinShopBuy", "/gbuy", "", aliasEnabled, "goblinShopBuy")
