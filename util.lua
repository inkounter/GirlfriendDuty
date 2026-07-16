-- Define some basic utilities.

local thisAddonName, namespace = ...

namespace.formatTime = function(totalMinutes)
    local hours = totalMinutes / 60
    local minutes = totalMinutes % 60
    return string.format("%dh %dm", hours, minutes)
end

