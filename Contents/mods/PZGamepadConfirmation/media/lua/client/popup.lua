---------------------------------------------
-- create new panel with default ISPanel methods
---------------------------------------------

HelloPanel = ISPanel:derive("HelloPanel")

---------------------------------------------
-- add text to panel
---------------------------------------------

function HelloPanel:render()
    ISPanel.render(self)

    self:drawTextCentre(
        "Hello World",
        self.width  /  2,
        (self.height /  2) - 10,
        1, 1, 1, 1,
        UIFont.Medium
    )
end

---------------------------------------------
-- create HelloTable if it doesn't exist
---------------------------------------------

HelloTable = HelloTable or {}

---------------------------------------------
-- declare variables for arguments
---------------------------------------------

-- size

HelloTable.panelWidth = getCore():getScreenWidth() / 2
HelloTable.panelHeight = getCore():getScreenHeight() / 2

-- location

HelloTable.panelX = (
    (getCore():getScreenWidth() / 2) -
    (HelloTable.panelWidth / 2)
)

HelloTable.panelY = (
    (getCore():getScreenHeight() / 2) -
    (HelloTable.panelHeight / 2)
)

---------------------------------------------
-- instantiate new HelloPanel
---------------------------------------------

HelloTable.panel = HelloPanel:new(
    HelloTable.panelX,
    HelloTable.panelY,
    HelloTable.panelWidth,
    HelloTable.panelHeight
)

---------------------------------------------
-- show & hide HelloPanel
---------------------------------------------

HelloTable.showPanel = function()
    HelloTable.panel:setVisible(true)
    HelloTable.panel:addToUIManager()
end

HelloTable.hidePanel = function()
    HelloTable.panel:setVisible(false)
    HelloTable.panel:removeFromUIManager()
end
