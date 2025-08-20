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
