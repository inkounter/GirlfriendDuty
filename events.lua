-- Define the event handlers.

local thisAddonName, namespace = ...

local lastDifficultyId = 0

local eventHandler = {
    ["_tryFireAlert"] = function(self)
        -- Show the alert frame if we're not on cooldown.

        local cooldownExpiry = GirlfriendDutyDB.cooldownExpiry or 0

        if time() < cooldownExpiry then
            return
        end

        namespace.alertFrame:Show()
    end,

    ["_ADDON_LOADED"] = function(self, addonName)
        if thisAddonName ~= addonName then
            return
        end

        namespace.alertFrame:UnregisterEvent("ADDON_LOADED")

        GirlfriendDutyDB = GirlfriendDutyDB or {}

        if GirlfriendDutyDB.alertActive then
            -- The alert was active and was not dismissed before a
            -- relog/reload.  Show the alert frame.

            C_Timer.After(0.5, function() namespace.alertFrame:Show() end)
        end
    end,

    ["_UPDATE_INSTANCE_INFO"] = function(self)
        -- Fire the alert if we are no longer in an instance and we are not on
        -- cooldown.

        local difficultyId = select(3, GetInstanceInfo())
        if difficultyId == 0 and lastDifficultyId ~= 0 then
            self:_tryFireAlert()
        end
        lastDifficultyId = difficultyId
    end,

    ["_CHALLENGE_MODE_COMPLETED"] = function(self)
        -- Fire the alert if we are not on cooldown.

        self:_tryFireAlert()
    end,

    ["registerEvents"] = function(self)
        -- Register the events with the frame.

        local frame = namespace.alertFrame

        -- `UPDATE_INSTANCE_INFO` fires every time upon entering or leaving an
        -- instance.

        frame:RegisterEvent("ADDON_LOADED")
        frame:RegisterEvent("UPDATE_INSTANCE_INFO")
        frame:RegisterEvent("CHALLENGE_MODE_COMPLETED")

        frame:SetScript(
            "OnEvent",
            function(_frame, event, ...)
                self["_" .. event](self, ...)
            end
        )
    end,
}

eventHandler:registerEvents()
