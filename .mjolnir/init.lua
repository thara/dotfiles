-- Load Extensions
local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
-- User packages
local hints = require "mjolnir.th.hints"

local key_app_map = {
  D = "Dash",
  C = "Google Chrome",
  O = "Opera",
  T = "iTerm",
  S = "Slack"
}

-- アプリの起動とフォーカス
for key, app in pairs(key_app_map) do
  hotkey.bind({"cmd", "ctrl"}, key, function()
    application.launchorfocus(app)
  end)
end

local roundrobin = function(funcs)
  local i = 1
  return function()
    funcs[i]()
    i = i % #funcs + 1
  end
end

-- ウインドウを {左半分, 右半分, フル} にリサイズ
hotkey.bind({"ctrl"}, "9", roundrobin({
  function() window.focusedwindow():movetounit({x=0, y=0, w=0.5, h=1}) end,
  function() window.focusedwindow():movetounit({x=0.5, y=0, w=0.5, h=1}) end,
  function() window.focusedwindow():movetounit({x=0, y=0, w=1, h=1}) end
}))

-- 同一アプリケーション内のウインドウ移動
hotkey.bind({"alt"}, "o", function()
  local current_window = window.focusedwindow()
  local windows = current_window:application():allwindows()
  table.sort(windows, function(a, b) return a:id() < b:id() end)
  local index = fnutils.indexof(windows, current_window)
  if not index then return end
  for i = 1, #windows do
    if windows[(index + i) % #windows + 1]:focus() then break end
  end
end)



hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x + 10
  win:setframe(f)
end)

-- Mjolnir Window Hints Module
-- http://thume.ca/howto/2014/12/02/using-mjolnir-an-extensible-osx-window-manager/
hotkey.bind({"cmd"}, "e", hints.windowHints)

-- This switches between windows of the focused app
hotkey.bind({"ctrl", "cmd"}, "j", function() hints.appHints(window.focusedwindow():application()) end)

-- You can also use this with appfinder to switch to windows of a specific app
-- local appfinder = require "mjolnir.cmsj.appfinder"
-- hotkey.bind({"ctrl","cmd"},"k",function() hints.appHints(appfinder.app_from_name("Emacs")) end)
