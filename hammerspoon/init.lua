hyper_key = { "cmd", "alt", "ctrl", "shift" }

-- Load PublicIP spoon and watch IPv4 address changes
hs.loadSpoon("PublicIP")

-- Shorter menubar for use with M1/2 macbook pros that have notch
spoon.PublicIP.terse = true

-- Get new state when loading configuration
spoon.PublicIP.refreshIP()

-- After detecting change wait 10 seconds until
-- new IP address becomes available
function networkChangedCallback(store, keys)
	hs.timer.doAfter(10, function()
		spoon.PublicIP.refreshIP()
	end)
end

-- Watch Network Service for IPv4 changes
n = hs.network.configuration.open()
n:monitorKeys("State:/Network/Service/.*/IPv4", true)
n:setCallback(networkChangedCallback)
n:start()

-- Lima Status spoon
-- hs.loadSpoon("LimaStatus")
-- spoon.LimaStatus.getLimaStatus()
-- hs.timer.doEvery(60, function()
--	spoon.LimaStatus.getLimaStatus()
-- end)

-- Bind hyper_key + \ to reload Hammerspoon config
hs.hotkey.bind(hyper_key, "\\", function()
	hs.reload()
end)

-- hs.loadSpoon("LimaControl")

-- Keybindings (customize to your liking)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "1", function()
	focusSafariWindow("Work")
end)

hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "2", function()
	focusSafariWindow("Personal")
end)

-- Function to focus a Safari window based on partial title match - not great not terrible
function focusSafariWindow(keyword)
	local safari = hs.application.get("Safari")
	if not safari then
		hs.alert("Safari is not running")
		return
	end

	local windows = safari:allWindows()
	for _, win in ipairs(windows) do
		if win:title():find(keyword) then
			win:focus()
			return
		end
	end

	hs.alert("No Safari window found with: " .. keyword)
end
