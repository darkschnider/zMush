function start_attack()
    local is_in_combat = GetVariable("in_combat")
    if not is_in_combat then
        SetVariable("in_combat", true)
        
    end
end