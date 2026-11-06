-- Add slash commands.

local thisAddonName, namespace = ...

SLASH_GIRLFRIENDDUTY1 = "/gfd"
SlashCmdList["GIRLFRIENDDUTY"] = function(msg)
    if msg == "test" or msg == "" then
        namespace.alertFrame:fireAlert()
    elseif msg == "clear" then
        GirlfriendDutyDB.cooldownExpiry = 0
        GirlfriendDutyDB.alertActive = nil
        namespace.alertFrame:Hide()
        namespace.updateTimerData()
    elseif msg == "suspend" then
        GirlfriendDutyDB.cooldownExpiry = time() + 12 * 3600
        GirlfriendDutyDB.alertActive = nil
        namespace.alertFrame:Hide()
        namespace.updateTimerData()
    else
        local timer = tonumber(msg)
        if timer ~= nil then
            GirlfriendDutyDB.cooldownDuration = timer * 60
            GirlfriendDutyDB.cooldownExpiry = time() + GirlfriendDutyDB.cooldownDuration * 60
            namespace.alertFrame.subtitle:updateCooldown()
            namespace.updateTimerData()
        else
            print("|cffFF3377[Girlfriend Duty]|r commands:")
            print("  /gfd test - Trigger test alert")
            print("  /gfd clear - Clear the cooldown")
            print("  /gfd suspend - Set the timer to 12 hours from now")
            print("  /gfd <floatNumber> - Set timer to the specified number of hours, and reset the cooldown")
        end
    end
end
