function start_attack()
    local is_in_combat = GetVariable("in_combat")
    if not is_in_combat then
        SetVariable("in_combat", "true")
    end
    local attack_method = GetVariable("start_attack_method")
    local attack_sksp = GetVariable("start_attack_sksp")
    local target = GetVariable("target")
    Send(attack_method .. " '" .. attack_sksp .. "' " .. target)
end

function do_attack()
    local is_in_combat = GetVariable("in_combat")
    if not is_in_combat then
        SetVariable("in_combat", "true")
    end
    local attack_method = GetVariable("attack_method")
    local attack_sksp = GetVariable("attack_sksp")
    local target = GetVariable("target")
    Send(attack_method .. " '" .. attack_sksp .. "' " .. target)
end

function attack_all()
    local is_in_combat = GetVariable("in_combat")
    if not is_in_combat then
        SetVariable("in_combat", "true")
    end
    local attack_method = GetVariable("attack_method")
    local attack_sksp = GetVariable("attack_sksp")
    local target = GetVariable("target")
    Send("kill all " .. target)
    Send(attack_method .. " '" .. attack_sksp .. "' " .. target)
end

function stop_attack()
    local is_in_combat = GetVariable("in_combat")
    if is_in_combat then
        SetVariable("in_combat", "false")
        Send("cast stop")
    end
end

-- Something hideously ugly arrives from below.
-- A pair of menacing guards arrive from below.
