-- Enable user configuration.

local thisAddonName, namespace = ...

local LibEditMode = LibStub("LibEditMode")

local defaultPosition = {
    point = "CENTER",
    x = 0,
    y = 200,
}

local function onPositionChanged(_frame, layoutName, point, x, y)
    GirlfriendDutyDB[layoutName].point = point
    GirlfriendDutyDB[layoutName].x = x
    GirlfriendDutyDB[layoutName].y = y
end

LibEditMode:RegisterCallback(
    "enter",
    function() namespace.alertFrame:Show() end
)

LibEditMode:RegisterCallback(
    "exit",
    function()
        if not GirlfriendDutyDB["alertActive"] then
          namespace.alertFrame:Hide()
        end
    end
)

LibEditMode:RegisterCallback(
    "layout",
    function(layoutName)
        GirlfriendDutyDB = GirlfriendDutyDB or {}

        if not GirlfriendDutyDB[layoutName] then
            GirlfriendDutyDB[layoutName] = CopyTable(defaultPosition)
        end

        local alertFrame = namespace.alertFrame

        alertFrame:ClearAllPoints()
        alertFrame:SetPoint(
            GirlfriendDutyDB[layoutName].point,
            GirlfriendDutyDB[layoutName].x,
            GirlfriendDutyDB[layoutName].y
        )
    end
)

LibEditMode:AddFrame(namespace.alertFrame, onPositionChanged, defaultPosition)

LibEditMode:AddFrameSettings(
    namespace.alertFrame,
    {
        {
            name = "Cooldown duration",

            kind = LibEditMode.SettingType.Slider,

            default = 90,

            get = function(_layoutName)
                return GirlfriendDutyDB.cooldownDuration
            end,

            set = function(_layoutName, value)
                GirlfriendDutyDB.cooldownDuration = value
                namespace.alertFrame.subtitle:updateCooldown()
            end,

            minValue = 10,
            maxValue = 480,
            valueStep = 10,
            formatter = namespace.formatTime,
        }
    }
)
