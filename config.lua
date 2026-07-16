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
