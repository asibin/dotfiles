hyper_keys = {"cmd", "alt", "ctrl", "shift"}

-- Application launchers
app_bindings = {
  { 'q', 'iTerm' },
  { 'w', 'Safari' },
  { 't', 'Postman' },
  { 'p', 'Enpass' },
  { 's', 'Spotify' },
  { 'd', 'IntelliJ IDEA' },
  { 'f', 'Finder' },
  { 'c', 'Telegram' },
  { 'm', 'Microsoft Outlook' },
}

for i, app in ipairs(app_bindings) do
  hs.hotkey.bind(hyper_keys, app[1], function()
    hs.application.launchOrFocus(app[2])
  end)
end

-- Load PublicIP spoon and watch interfaces
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


-- Bind hyper_keys + R to reload Hammerspoon config
hs.hotkey.bind(hyper_keys, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

