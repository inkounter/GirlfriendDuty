-- Publish the remaining alert cooldown to `LibDataBroker`.

local thisAddonName, namespace = ...

local LDB = LibStub and LibStub("LibDataBroker-1.1", true)

-- Build the initial text for the broker label.
local function GetTimerText()
    local remainingCooldown = (GirlfriendDutyDB.cooldownExpiry or 0) - time()
    if GirlfriendDutyDB.alertActive or remainingCooldown <= 0 then
        return "|cffff0000DUE|r"
    end

    return namespace.formatTime(remainingCooldown / 60)
end

local updateTimerData
local timerData = LDB:NewDataObject(
    "GirlfriendDuty",
    {
        type    = "data source",
        label   = "GFDuty",
        text    = GetTimerText(),
        icon    = "interface/icons/inv_valentinesboxofchocolates02.blp",
        OnClick = (
            function()
                local GirlfriendDutyDB = GirlfriendDutyDB
                GirlfriendDutyDB.cooldownExpiry = (
                    time() + GirlfriendDutyDB.cooldownDuration * 60
                )
                updateTimerData()
            end
        ),
    }
)

-- Refresh the broker text every few seconds via an OnUpdate ticker.
local timerFrame = CreateFrame("Frame")
local elapsed = 0

updateTimerData = function()
    elapsed = 0
    timerData.text = GetTimerText()
end

timerFrame:SetScript(
    "OnUpdate",
    function(_, timeDelta)
        elapsed = elapsed + timeDelta
        if elapsed < 5 then return end
        updateTimerData()
    end
)

namespace.updateTimerData = updateTimerData
