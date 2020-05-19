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
hs.hotkey.bind({"ctrl"}, "8", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 100
  f.y = max.y + 80
  f.w = max.w - 200
  f.h = max.h - 160
  win:setFrame(f)
end)

-- ウインドウを中央に配置 2
hs.hotkey.bind({"ctrl"}, "9", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 300
  f.y = max.y + 50
  f.w = 1400
  f.h = max.h - 100
  win:setFrame(f)
end)

-- ウインドウを中央に配置 3
hs.hotkey.bind({"ctrl"}, "7", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 500
  f.y = max.y + 50
  f.w = 1000
  f.h = max.h - 100
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl"}, "1", function()
  hs.application.launchOrFocus("Terminal")
end)

hs.hotkey.bind({"ctrl"}, "2", function()
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"ctrl"}, "3", function()
  hs.application.launchOrFocus("Slack")
end)
