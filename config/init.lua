local mash      = {"cmd", "alt", "ctrl"}
local mash_apps = {"cmd", "shift", "ctrl"}

hs.hotkey.bind(mash, "R", function()
  hs.reload()
  print('config reloaded')
end)

hs.fnutils.each({
  { key = "f", app = "Firefox" },
  { key = "e", app = "Emacs" },
  { key = "t", app = "Terminal" },
  { key = "v", app = "VLC" }
}, function(object)
    hs.hotkey.bind(mash_apps, object.key, function() hs.application.launchOrFocus(object.app) end) 
end)
