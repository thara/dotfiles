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
