-- Add slash commands.

local thisAddonName, namespace = ...

SLASH_GIRLFRIENDDUTY1 = "/gfd"
SlashCmdList["GIRLFRIENDDUTY"] = function(msg)
    if msg == "test" or msg == "" then
        GirlfriendDutyDB.suspend = false
        namespace.alertFrame:fireAlert()
    elseif msg == "clear" then
        GirlfriendDutyDB.cooldownExpiry = 0
        GirlfriendDutyDB.alertActive = nil
        GirlfriendDutyDB.suspend = false
        namespace.alertFrame:Hide()
        namespace.updateTimerData()
    elseif msg == "suspend" then
        GirlfriendDutyDB.cooldownExpiry = 0
        GirlfriendDutyDB.alertActive = nil
        GirlfriendDutyDB.suspend = true
        namespace.alertFrame:Hide()
        namespace.updateTimerData()
    else
        print("|cffFF3377[Girlfriend Duty]|r commands:")
        print("  /gfd test - Trigger test alert")
        print("  /gfd clear - Clear the cooldown and suspension")
        print("  /gfd suspend - Disable until next login")
    end
end
