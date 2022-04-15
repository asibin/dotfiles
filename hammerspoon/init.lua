app_binds = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(app_binds, "w", function()
  hs.application.open('Safari')
end)

hs.hotkey.bind(app_binds, "t", function()
  hs.application.open('/Applications/iTerm.app')
end)

hs.loadSpoon("PublicIP")

function networkChangedCallback(store, keys)
    hs.timer.doAfter(10, function()
    spoon.PublicIP.refreshIP()
  end)
end

n = hs.network.configuration.open()
n:monitorKeys("State:/Network/Service/.*/IPv4", true)
n:setCallback(networkChangedCallback)
n:start()


