function ISJoypadListBox:fill()
	local listBox = self
	listBox:clear()
	listBox:setScrollHeight(0)
    local width = getTextManager():MeasureStringX(UIFont.Massive, getText("IGUI_Controller_TakeOverPlayer", i)) + 20
    listBox.javaObject:setWidth(width)
	for i=1,getMaxActivePlayers() do
		local playerObj = getSpecificPlayer(i-1)
		if JoypadState.players[i] == nil and playerObj and playerObj:isAlive() then
			listBox:addItem(getText("IGUI_Controller_TakeOverPlayer", i), { cmd = "takeover", playerNum = i-1 })
		end
	end
	if not isDemo() then
		if Core.isLastStand() then
			listBox:addItem(getText("IGUI_Controller_AddNewPlayer"), { cmd = "addnew" })
			local players = LastStandPlayerSelect:getAllSavedPlayers()
			for _,player in ipairs(players) do
				local inUse = false
				for playerNum=0,getNumActivePlayers()-1 do
					local playerObj = getSpecificPlayer(playerNum)
					if playerObj and not playerObj:isDead() then
						if playerObj:getDescriptor():getForename() == player.forename and playerObj:getDescriptor():getSurname() == player.surname then
							inUse = true
							break
						end
					end
				end
				if not inUse then
					local label = getText("IGUI_Controller_AddSavedPlayer", player.forename, player.surname)
					listBox:addItem(label, { cmd = "addsaved", player = player })
				end
			end
		elseif isClient() and not getServerOptions():getBoolean("AllowCoop") then
			
		else
			local players = IsoPlayer.getAllSavedPlayers()
			if not isClient() or (players:size() < 3) then
				listBox:addItem(getText("IGUI_Controller_AddNewPlayer"), { cmd = "addnew" })
			end
			for n=1,players:size() do
				local playerObj = players:get(n-1)
				if not playerObj:isSaveFileInUse() and playerObj:isSaveFileIPValid() then
					local label = getText("IGUI_Controller_AddSavedPlayer", playerObj:getDescriptor():getForename(), playerObj:getDescriptor():getSurname())
					listBox:addItem(label, { cmd = "addsaved", player = playerObj })
				end
			end
		end
	end
	listBox:addItem(getText("UI_Cancel"), { cmd = "cancel" })
	listBox.selected = 1
	listBox:setHeight(math.min(listBox:getScrollHeight(), getCore():getScreenHeight()))
end
