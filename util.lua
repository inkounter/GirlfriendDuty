-- Define some basic utilities.

local thisAddonName, namespace = ...

namespace.formatTime = function(totalMinutes)
    local hours = totalMinutes / 60
    local minutes = totalMinutes % 60
    if hours > 0 then
        return string.format("%dh %dm", hours, minutes)
    else
        return string.format("%dm", minutes)
    end
end

