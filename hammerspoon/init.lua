hyper_key = {"cmd", "alt", "ctrl", "shift"}

-- Application launchers
app_bindings = {
  { 'q', 'iTerm' },
  { 'w', 'Brave Browser' },
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
  hs.hotkey.bind(hyper_key, app[1], function()
    hs.application.launchOrFocus(app[2])
  end)
end

-- Load PublicIP spoon and watch IPv4 address changes
hs.loadSpoon("PublicIP")

-- Shorter menubar for use with M1 macbooks that have notch 
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


-- Bind hyper_key + \ to reload Hammerspoon config
hs.hotkey.bind(hyper_key, "\\", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

