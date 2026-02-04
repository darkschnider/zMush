----
-- Vulnerability tracking system
----

require "do_announce"

-- Initialize vulns table
vulns = vulns or {}
vuln_timers = vuln_timers or {}

----
-- Clears all vulns.
----
function reset_vulns()
  vulns = {}
  vuln_timers = {}
  DeleteTimerGroup("LUA Vuln Timers")
end

----
-- Defines a vuln.
--
-- @param key The key which matches this vuln
-- @param dtype The damage types that the vuln affects
-- @param name The name of this vuln
-- @param duration Duration of this vuln in seconds
----
function def_vuln(key, dtype, name, duration)
  if not key or key == "" then
    ColourNote("red", "", "Error: key must be provided for vuln")
    return
  end
  if not name or name == "" then
    ColourNote("red", "", "Error: name must be provided for vuln")
    return
  end
  
  vulns[key] = {
    name = name,
    dtype = dtype or "",
    duration = duration or 0
  }
end

----
-- Turns on the vuln specified.
--
-- @param key The key of the vuln to enable
----
function vuln_up(key)
  if not vulns[key] then
    ColourNote("red", "", "Error: key did not match a vuln")
    return
  end
  
  local vuln = vulns[key]
  ColourNote("green", "", string.format("[UP] %s (%s vuln)", vuln.name, vuln.dtype))
  do_announce({d="party"}, "UP: " .. vuln.name .. " (" .. vuln.dtype .. " vuln)")
  
  -- Clear any existing timers for this vuln
  if vuln_timers[key] then
    if vuln_timers[key].falling then
      DeleteTimer(vuln_timers[key].falling)
    end
    if vuln_timers[key].down then
      DeleteTimer(vuln_timers[key].down)
    end
  end
  vuln_timers[key] = {}
  
  if vuln.duration > 5 then
    -- Timer for warning 5 seconds before it falls
    local falling_timer_id = "vuln_falling_" .. key
    local retval = AddTimer(falling_timer_id, 0, 0, vuln.duration - 5, 'vuln_falling("' .. key .. '", 5)', timer_flag.Enabled + timer_flag.OneShot + timer_flag.Replace, "")
    SetTimerOption(falling_timer_id, "send_to", sendto.script)
    SetTimerOption(falling_timer_id, "group", "LUA Vuln Timers")
    vuln_timers[key].falling = falling_timer_id
    
    -- Timer for when it falls
    local down_timer_id = "vuln_down_" .. key
    AddTimer(down_timer_id, 0, 0, vuln.duration, 'vuln_down("' .. key .. '")', timer_flag.Enabled + timer_flag.OneShot + timer_flag.Replace, "")
    SetTimerOption(down_timer_id, "send_to", sendto.script)
    SetTimerOption(down_timer_id, "group", "LUA Vuln Timers")
    vuln_timers[key].down = down_timer_id
  end
end
  
----
-- Warns when vuln is falling
--
-- @param key The key of the vuln to warn for
-- @param when The time when this vuln will fall (in seconds)
----
function vuln_falling(key, when)
  if not vulns[key] then
    return
  end
  
  local vuln = vulns[key]
  ColourNote("yellow", "", string.format("%s (%s vuln) falls in %d seconds!", 
                                          vuln.name, vuln.dtype, when))
  do_announce({d="party"},  string.format("%s (%s vuln) falls in %d seconds!", 
                                          vuln.name, vuln.dtype, when))
end

----
-- Turns off the vuln specified.
--
-- @param key The key of the vuln to disable
----
function vuln_down(key)
  if not vulns[key] then
    return
  end
  
  local vuln = vulns[key]
  ColourNote("red", "", string.format("[DOWN] %s (%s vuln)", vuln.name, vuln.dtype))
  do_announce({d="party"}, "DOWN: " .. vuln.name .. " (" .. vuln.dtype .. " vuln)")
  
  -- Clean up timers
  if vuln_timers[key] then
    if vuln_timers[key].falling then
      DeleteTimer(vuln_timers[key].falling)
    end
    if vuln_timers[key].down then
      DeleteTimer(vuln_timers[key].down)
    end
    vuln_timers[key] = {}
  end
end

----
-- Clear timers when enemy is killed
----
function on_enemy_killed_abjurer()
  for key, _ in pairs(vulns) do
    if vuln_timers[key] then
      if vuln_timers[key].falling then
        DeleteTimer(vuln_timers[key].falling)
      end
      if vuln_timers[key].down then
        DeleteTimer(vuln_timers[key].down)
      end
      vuln_timers[key] = {}
    end
  end
end

-- Always reset on load
reset_vulns()
