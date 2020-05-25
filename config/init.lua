local mash      = {"cmd", "shift", "ctrl"}
local mash_apps = {"cmd", "shift"}

hs.hotkey.bind(mash, "R", function()
  hs.reload()
  print('config reloaded')
end)

hs.fnutils.each({
  { key = "f", app = "Firefox" },
  { key = "t", app = "iTerm2" },
  { key = "e", app = "Emacs" },
  { key = "v", app = "VLC" }
}, function(object)
    hs.hotkey.bind(mash_apps, object.key, function() hs.application.launchOrFocus(object.app) end) 
end)
