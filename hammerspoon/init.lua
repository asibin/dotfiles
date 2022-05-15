hyper_keys = {"cmd", "alt", "ctrl", "shift"}

-- Application launchers
app_bindings = {
  { 'q', 'iTerm' },
  { 'w', 'Safari' },
  { 't', 'Postman' },
  { 'p', 'Enpass' },
  { 'm', 'Spotify' },
  { 's', 'Slack' },
  { 'd', 'IntelliJ IDEA' },
  { 'f', 'Finder' },
  { 'j', 'Joplin.app' },
  { 'c', 'Telegram' },
  { 'o', 'Microsoft Outlook' },
  { 'r', 'Google Chrome' },
}

for i, app in ipairs(app_bindings) do
  hs.hotkey.bind(hyper_keys, app[1], function()
    hs.application.launchOrFocus(app[2])
  end)
end

-- Load PublicIP spoon and watch IPv4 address changes
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


-- Bind hyper_keys + \ to reload Hammerspoon config
hs.hotkey.bind(hyper_keys, "\\", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

