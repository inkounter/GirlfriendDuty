-- Define the frames.

local addonName, namespace = ...

-- Notification frame
local alertFrame = CreateFrame(
    "Button",
    "GirlfriendDutyFrame",
    UIParent,
    "BackdropTemplate"
)
alertFrame:Hide()
alertFrame:SetSize(350, 75)
alertFrame:RegisterForClicks("AnyUp")

alertFrame:SetPoint(
    "CENTER",
    UIParent,
    "CENTER",
    0,
    0
)

namespace.alertFrame = alertFrame

-- Styling the alert frame
local alertBackdrop = {
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 12,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
alertFrame:SetBackdrop(alertBackdrop)
alertFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
alertFrame:SetBackdropBorderColor(0.8, 0.2, 0.2, 0.8)

-- Alert title text
local title = alertFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", alertFrame, "TOP", 0, -15)
local fontName, fontSize, fontFlags = title:GetFont()
title:SetFont(fontName, 26, "OUTLINE")
title:SetText("Girlfriend Duty")
title:SetTextColor(1.0, 0.2, 0.5) -- Pink/rose color
alertFrame.title = title

-- Alert subtitle text
local subtitle = alertFrame:CreateFontString(
    nil,
    "OVERLAY",
    "GameFontHighlightSmall"
)
subtitle:SetPoint("BOTTOM", alertFrame, "BOTTOM", 0, 12)
subtitle:SetText("Click to dismiss (2-hour cooldown)")
subtitle:SetTextColor(0.6, 0.6, 0.6)
alertFrame.subtitle = subtitle

-- Alert Frame Hover effects
alertFrame:SetScript("OnEnter", function(self)
    self:SetBackdropColor(0.12, 0.12, 0.12, 0.95)
    self:SetBackdropBorderColor(1.0, 0.3, 0.3, 1.0)
    self.title:SetTextColor(1.0, 0.3, 0.6)
end)

alertFrame:SetScript("OnLeave", function(self)
    self:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
    self:SetBackdropBorderColor(0.8, 0.2, 0.2, 0.8)
    self.title:SetTextColor(1.0, 0.2, 0.5)
end)

-- Alert Frame Click action
alertFrame:SetScript("OnClick", function(self)
    self:Hide()
    GirlfriendDutyDB.alertActive = nil
    GirlfriendDutyDB.cooldownExpiry = time() + 7200
end)

alertFrame:SetScript(
    "OnShow",
    function(self)
        GirlfriendDutyDB.alertActive = true
        PlaySound(8960, "Master")   -- Play ready check sound
    end
)
