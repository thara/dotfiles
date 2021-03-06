-- ウインドウをフルにリサイズ
hs.hotkey.bind({"ctrl"}, "0", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- ウインドウを中央に配置
-- hs.hotkey.bind({"ctrl"}, "8", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.w = max.w - 200
--   f.h = max.h - 160
--   win:setFrame(f)

--   hs.window.focusedWindow():centerOnScreen(nil, true)
-- end)

-- ウインドウを中央に配置 2
hs.hotkey.bind({"ctrl"}, "9", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = 1400
  f.h = max.h - 100
  win:setFrame(f)

  hs.window.focusedWindow():centerOnScreen(nil, true)
end)

-- 80x40
hs.hotkey.bind({"ctrl"}, "8", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = 900
  f.h = max.h - 100
  win:setFrame(f)
end)

hs.hotkey.bind({"command"}, "2", function()
  hs.application.launchOrFocus("Terminal")
end)

hs.hotkey.bind({"command"}, "1", function()
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"command"}, "3", function()
  hs.application.launchOrFocus("Slack")
end)
