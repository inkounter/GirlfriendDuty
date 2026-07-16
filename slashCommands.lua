-- Add slash commands.

local thisAddonName, namespace = ...

SLASH_GIRLFRIENDDUTY1 = "/gfd"
SlashCmdList["GIRLFRIENDDUTY"] = function(msg)
    if msg == "test" or msg == "" then
        namespace.alertFrame:Show()
        print("|cffFF3377[Girlfriend Duty]|r: Test alert displayed.")
    elseif msg == "clear" then
        GirlfriendDutyDB.cooldownExpiry = 0
        GirlfriendDutyDB.alertActive = nil
        namespace.alertFrame:Hide()
        print("|cffFF3377[Girlfriend Duty]|r: Cooldown cleared.")
    else
        print("|cffFF3377[Girlfriend Duty]|r commands:")
        print("  /gfd test - Trigger test alert")
        print("  /gfd clear - Clear the 2-hour cooldown")
    end
end
