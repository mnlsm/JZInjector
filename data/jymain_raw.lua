function IncludeFile()
  package.path = CONFIG.ScriptLuaPath
  
  szlzw = {}
  szlzw.MOD = 1
  require("jyconst")
  if CONFIG.MOD < 2 then
    require("oldevent")
  end
  if CONFIG.MOD == 1 then
    require("newevent")
  end
  if CONFIG.MOD > 1 then
    dofile(CONFIG.ScriptPath .. "../event.lrk")
  end
end

function SetGlobal()
  JY = {}
  JY.Status = GAME_INIT
  JY.Base = {}
  JY.PersonNum = 0
  JY.Person = {}
  JY.ThingNum = 0
  JY.Thing = {}
  JY.SceneNum = 0
  JY.Scene = {}
  JY.WugongNum = 0
  JY.Wugong = {}
  JY.ShopNum = 0
  JY.Shop = {}
  JY.Data_Base = nil
  JY.Data_Person = nil
  JY.Data_Thing = nil
  JY.Data_Scene = nil
  JY.Data_Wugong = nil
  JY.Data_Shop = nil
  JY.Data_GLTS = nil
  JY.MyCurrentPic = 0
  JY.MyPic = 0
  JY.MyTick = 0
  JY.MyTick2 = 0
  JY.EnterSceneXY = nil
  JY.oldMMapX = -1
  JY.oldMMapY = -1
  JY.oldMMapPic = -1
  JY.exitX = -1
  JY.exitY = -1
  JY.exitPic = -1
  JY.SubScene = -1
  JY.SubSceneX = 0
  JY.SubSceneY = 0
  JY.Darkness = 0
  JY.CurrentD = -1
  JY.OldDPass = -1
  JY.CurrentEventType = -1
  JY.oldSMapX = -1
  JY.oldSMapY = -1
  JY.oldSMapXoff = -1
  JY.oldSMapYoff = -1
  JY.oldSMapPic = -1
  JY.D_Valid = nil
  JY_D_Valld_Num = 0
  JY.D_PicChange = {}
  JY.NumD_PicChange = 0
  JY.CurrentThing = -1
  JY.MmapMusic = -1
  JY.CurrentMIDI = -1
  JY.EnableMusic = 1
  JY.EnableSound = 1
  JY.ThingUseFunction = {}
  JY.SceneNewEventFunction = {}
  WAR = {}
  xzqbpd = 3
  zdyx = {}
  for i = 1, CC.TeamNum do
    zdyx[i] = {}
    zdyx[i][1] = 0
    zdyx[i][2] = -1
  end
  Movex = 0
  Movey = 0
  if CC.BanBen == 0 then
    JY.ThingUseFunction[182] = Show_Position
  end
  oldcur_line = 0
  oldcur_x = 0
  oldcur_y = 0
  JY.SaveTime = 10
  JY.AtTime = lib.GetTime()
  JY.DiyTime = JY.AtTime + JY.SaveTime * 60000
  JY.SBZ = 0
  JY.DHSJ = lib.GetTime() + 5000
  JY.DHBZ = 0
  JY.ZLX = nil
  JY.ZLY = nil
  JY.ZLBZ = 0
  JY.ZLBZ1 = 0
  JY.ZLT = lib.GetTime()
  JY.ZLT1 = lib.GetTime()
  JY.ZLSHBZ = 0
  JY.ZUOBI = 0
  JY.ZBJK = 0
  JY.ZBJKSJ = lib.GetTime()
  JY.JSEXP = 0
  JY.MoveZTime = lib.GetTime()
  JY.WGXZWZ = {}
  JY.ZCWGCS = 0
  X50 = {}
  if CC.X50OPEN == 1 then
    for i = 0, 20000 do
      X50[i] = 0
    end
  end
  XB50 = {}
  X50STR = {}
  X50JMP = 0
  X50BL32 = {}
  BL32PD = 0
  JY.AQ = {}
  JY.AQNUM = 0
  JY.Selpstr = {}
  JY.YXND = 0
  JY.Huhuolq = 5
  JY.Huhuocs = 2
  JY.SETPD = 1
  AutoMoveTab = {
    [0] = 0
  }
  JY.AI = 0
  JY.GLTS = {}
  JY.Book = 0
  JY.MiniMap = 0
  JY.ATAI = {}
  for i = 1, 20 do
    JY.ATAI[i] = {}
    JY.ATAI[i][2] = 2
  end
  JY.AISET = 1
  JY.KT = 0
  JY.WGMC = ""
  JY.XTKG = 1
  JY.TXKG = 1
  JY.JZKG = 1
  JY.SCKG = 1
  JY.DEADKG = 1
  JY.MENUMSG = 0
  JY.SCTMP = 0
  JY.WD = 0
  JY.DEADPD = {}
  JY.WARWF = 0
  JY.WARDF = 0
  JY.OLDRKX = -1
  JY.OLDRKY = -1
end

function JY_Main()
  os.remove("debug.txt")
  xpcall(JY_Main_sub, myErrFun)
end

function myErrFun(err)
  lib.Debug(err)
  lib.Debug(debug.traceback())
end

function CleanMemory()
  if CONFIG.CleanMemory == 1 then
    collectgarbage("collect")
  end
end

function JY_Main_sub()
  IncludeFile()
  SetGlobalConst()
  SetGlobal()
  GenTalkIdx()
  setmetatable(_G, {
    __newindex = function(_, n)
      error("attempt read write to undeclared variable " .. n, 2)
    end,
    __index = function(_, n)
      error("attempt read read to undeclared variable " .. n, 2)
    end
  })
  lib.Debug("JY_Main start.")
  if CC.RB == 1 then
    ReadBin()
  end
  Game_Start()
  Game_Cycle()
end

function Game_Start()
  math.randomseed(os.time())
  lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRePeatInterval)
  JY.Status = GAME_START
  lib.PicInit(CC.PaletteFile)
  lib.FillColor(0, 0, 0, 0, 0)
  lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, 10, "png")
  Cls()
  PlayMIDI(16)
  lib.ShowSlow(50, 0)
  while true do
    Cls()
    WhoAmI()
    local menu = {
      {
        "\214\216\208\194\191\170\202\188",
        nil,
        1
      },
      {
        "\212\216\200\235\189\248\182\200",
        nil,
        1
      },
      {
        "\207\181\205\179\201\232\214\195",
        nil,
        1
      },
      {
        "\199\208\187\187\176\230\177\190",
        nil,
        1
      },
      {
        "\192\235\191\170\211\206\207\183",
        nil,
        1
      }
    }
    local menux = (CC.ScreenW - 5 * CC.StartMenuFontSize - 2 * CC.MenuBorderPixel) / 2
    local menuy = CC.StartMenuY - CC.StartMenuFontSize
    local menuReturn = ShowMenu(menu, #menu, 0, menux, menuy - CC.StartMenuFontSize * 0.6, 0, 0, 0, 0, CC.StartMenuFontSize * 1, C_STARTMENU, C_RED)
    if menuReturn == 1 then
      NewGame()
      Cls()
      DrawString(menux, menuy, "\199\235\201\212\186\242...", C_RED, CC.StartMenuFontSize * 1.3)
      ShowScreen()
      JY.SubScene = CC.NewGameSceneID
      JY.Scene[JY.SubScene]["\195\251\179\198"] = JY.Person[0].姓名 .. "\190\211"
      if CC.SceneNameRen == 1 then
        JY.Scene[JY.SubScene]["\195\251\179\198"] = CC.SceneName
      end
      JY.Base.人X1 = CC.NewGameSceneX
      JY.Base.人Y1 = CC.NewGameSceneY
      JY.MyPic = CC.NewPersonPic
      lib.ShowSlow(50, 1)
      JY.Status = GAME_SMAP
      JY.MmapMusic = -1
      CleanMemory()
      Init_SMap(0)
      if CC.BanBen == 0 then
        if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\185\219\191\180\191\170\202\188\182\175\187\173\163\191", C_WHITE, CC.DefaultFont) == true then
          oldCallEvent(CC.NewGameEvent)
          break
        end
        oldCallEvent(1018)
        break
      elseif CC.BanBen == 1 then
        local menu = {
          {
            "\183\231\198\189\192\203\190\178",
            nil,
            1
          },
          {
            "\183\231\198\240\212\198\211\191",
            nil,
            1
          },
          {
            "\190\170\204\206\186\167\192\203",
            nil,
            1
          }
        }
        local size = CC.StartMenuFontSize
        local menux = CC.ScreenW / 2 - CC.StartMenuFontSize * 3
        local tsy = CC.ScreenH / 2 - size * 5
        DrawStrBox(menux - size, tsy, "\209\161\212\241\211\206\207\183\196\209\182\200", C_GOLD, size)
        local r = ShowMenu(menu, #menu, 0, menux, CC.ScreenH / 2 - CC.StartMenuFontSize * 3, 0, 0, 1, 1, CC.StartMenuFontSize, C_GOLD, C_WHITE)
        if r == 1 or r == 0 then
          JY.YXND = 0
        elseif r == 2 then
          JY.YXND = 1
        elseif r == 3 then
          JY.YXND = 2
        end
        JY.Wugong[30]["\206\180\214\1703"] = JY.YXND
        Cls()
        if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\185\219\191\180\191\170\202\188\182\175\187\173\163\191", C_WHITE, CC.DefaultFont) == true then
          oldCallEvent(CC.NewGameEvent)
          break
        end
        oldCallEvent(1086)
        break
      elseif CC.BanBen == 2 then
        oldCallEvent(CC.NewGameEvent)
        break
      elseif CC.BanBen == 3 then
        oldCallEvent(CC.NewGameEvent)
        break
      elseif CC.BanBen == 3 then
        oldCallEvent(CC.NewGameEvent)
        break
      elseif CC.BanBen == 4 then
        oldCallEvent(CC.NewGameEvent)
        break
      elseif CC.BanBen == 5 then
        oldCallEvent(CC.NewGameEvent)
        break
      elseif CC.BanBen == 100 then
        oldCallEvent(301)
        JY.Person[35]["\185\165\187\247\193\166"] = 30
        JY.Person[35]["\199\225\185\166"] = 30
        JY.Person[35]["\183\192\211\249\193\166"] = 30
        JY.Person[100]["\185\165\187\247\193\166"] = 30
        JY.Person[100]["\199\225\185\166"] = 30
        JY.Person[100]["\183\192\211\249\193\166"] = 30
        JY.Person[104]["\185\165\187\247\193\166"] = 30
        JY.Person[104]["\199\225\185\166"] = 30
        JY.Person[104]["\183\192\211\249\193\166"] = 30
        JY.Person[105]["\185\165\187\247\193\166"] = 30
        JY.Person[105]["\199\225\185\166"] = 30
        JY.Person[105]["\183\192\211\249\193\166"] = 30
        break
      end
    elseif menuReturn == 2 then
      local r = SaveList()
      if 0 < r and existFile(CC.S_Filename[r]) and existFile(CC.D_Filename[r]) then
        DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * 2, CC.StartMenuY, "\199\235\201\212\186\242...", C_RED, CC.StartMenuFontSize * 1.3)
        ShowScreen()
        LoadRecord(r)
        if 0 < JY.Base.无用 then
          if JY.Status == GAME_MMAP then
            lib.UnloadMMap()
            lib.PicInit()
          end
          lib.ShowSlow(50, 1)
          JY.Status = GAME_SMAP
          JY.SubScene = JY.Base.无用
          JY.MmapMusic = -1
          JY.MyPic = GetMyPic()
          Init_SMap(1)
          Game_Cycle()
          break
        end
        if JY.Base.无用 == 0 then
          if JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X1"] - 1 and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y1"] or JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X2"] and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y2"] + 1 then
            if JY.Status == GAME_MMAP then
              lib.UnloadMMap()
              lib.PicInit()
            end
            lib.ShowSlow(50, 1)
            JY.Status = GAME_SMAP
            JY.SubScene = JY.Base.无用
            JY.MmapMusic = -1
            JY.MyPic = GetMyPic()
            Init_SMap(1)
            Game_Cycle()
            break
          end
          JY.SubScene = -1
          JY.Status = GAME_FIRSTMMAP
          break
        end
        JY.SubScene = -1
        JY.Status = GAME_FIRSTMMAP
        break
      end
    elseif menuReturn == 3 then
      JY.SETPD = 0
      System_Set()
    elseif menuReturn == 4 then
      JY.SETPD = 0
      YXQH()
    elseif menuReturn == 5 then
      os.exit()
    end
  end
  JY.SETPD = 1
  return 1
end

function NewGame()
  CC.NEWGAME = 1
  LoadRecord(0)
  if #CC.NewPersonName > 8 then
    CC.NewPersonName = "\208\236\208\161\207\192"
  end
  JY.Person[0].姓名 = CC.NewPersonName
  JY.Person[0].外号 = "\204\236\207\194\198\230\196\208\215\211"
  JY.Person[0]["\215\202\214\202"] = InputNum("\199\235\202\228\200\235\215\202\214\202", 1, 100)
  while true do
    JY.Person[0]["\196\218\193\166\208\212\214\202"] = Rnd(2)
    JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"] = Rnd(20) + 21
    JY.Person[0]["\185\165\187\247\193\166"] = Rnd(10) + 21
    JY.Person[0]["\183\192\211\249\193\166"] = Rnd(10) + 21
    JY.Person[0]["\199\225\185\166"] = Rnd(10) + 21
    JY.Person[0]["\210\189\193\198\196\220\193\166"] = Rnd(10) + 21
    JY.Person[0]["\211\195\182\190\196\220\193\166"] = Rnd(10) + 21
    JY.Person[0]["\189\226\182\190\196\220\193\166"] = Rnd(10) + 21
    JY.Person[0]["\191\185\182\190\196\220\193\166"] = Rnd(10) + 21
    JY.Person[0]["\200\173\213\198\185\166\183\242"] = Rnd(10) + 21
    JY.Person[0]["\211\249\189\163\196\220\193\166"] = Rnd(10) + 21
    JY.Person[0]["\203\163\181\182\188\188\199\201"] = Rnd(10) + 21
    JY.Person[0]["\204\216\202\226\177\248\198\247"] = Rnd(10) + 21
    JY.Person[0]["\176\181\198\247\188\188\199\201"] = Rnd(10) + 21
    JY.Person[0]["\201\250\195\252\212\246\179\164"] = Rnd(5) + 3
    JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"] = JY.Person[0]["\201\250\195\252\212\246\179\164"] * 3 + 29
    JY.Person[0].生命 = JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"]
    JY.Person[0]["\196\218\193\166"] = JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"]
    Cls()
    local fontsize = 1.5 * CC.NewGameFontSize
    local h = fontsize + 1 * CC.RowPixel
    local w = fontsize * 4
    local x1 = (CC.ScreenW - w * 5) / 2
    local y1 = 1 * CC.NewGameY + -100
    local i = 0
    
    local function DrawAttrib(str1, str2)
      if str2 == "\196\218\193\166" then
        if JY.Person[0]["\196\218\193\166"] == 40 then
          lib.FillColor(x1 + i * w, y1, x1 + i * w + fontsize * 3.5, y1 + fontsize, C_ORANGE)
          DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
          DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
        else
          DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
          DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
        end
      elseif str2 == "\201\250\195\252" then
        if JY.Person[0][str2] == 50 then
          lib.FillColor(x1 + i * w, y1, x1 + i * w + fontsize * 3.5, y1 + fontsize, C_ORANGE)
          DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
          DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
        else
          DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
          DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
        end
      elseif JY.Person[0][str2] == 30 then
        lib.FillColor(x1 + i * w, y1, x1 + i * w + fontsize * 3.5, y1 + fontsize, C_ORANGE)
        DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
        DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
      else
        DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
        DrawString(x1 + i * w + fontsize * 2, y1, string.format("%3d ", JY.Person[0][str2]), C_WHITE, fontsize)
      end
      i = i + 1
    end
    
    local function DrawAttrib1(str1, str2)
      DrawString(x1 + i * w, y1, str1, C_RED, fontsize)
      local ns = JY.Person[0][str2]
      if ns == 0 then
        DrawString(x1 + i * w + fontsize * 2, y1, " \210\245", RGB(208, 152, 208), fontsize)
      else
        DrawString(x1 + i * w + fontsize * 2, y1, " \209\244", C_GOLD, fontsize)
      end
      i = i + 1
    end
    
    if JY.Person[0].姓名 == "szlzw" then
      DrawString(CC.ScreenW / 2 - fontsize * 5, CC.ScreenH / 2 + fontsize * 2, "szlzw\163\172\196\227\210\209\190\173\179\172\201\241\193\203\163\161", C_GOLD, CC.StartMenuFontSize, 1)
      ShowScreen()
      WaitKey()
      JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"] = 40
      JY.Person[0]["\185\165\187\247\193\166"] = 30
      JY.Person[0]["\183\192\211\249\193\166"] = 30
      JY.Person[0]["\199\225\185\166"] = 30
      JY.Person[0]["\210\189\193\198\196\220\193\166"] = 30
      JY.Person[0]["\211\195\182\190\196\220\193\166"] = 30
      JY.Person[0]["\189\226\182\190\196\220\193\166"] = 30
      JY.Person[0]["\191\185\182\190\196\220\193\166"] = 30
      JY.Person[0]["\200\173\213\198\185\166\183\242"] = 30
      JY.Person[0]["\211\249\189\163\196\220\193\166"] = 30
      JY.Person[0]["\203\163\181\182\188\188\199\201"] = 30
      JY.Person[0]["\204\216\202\226\177\248\198\247"] = 30
      JY.Person[0]["\176\181\198\247\188\188\199\201"] = 30
      JY.Person[0]["\201\250\195\252\212\246\179\164"] = 7
      JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"] = JY.Person[0]["\201\250\195\252\212\246\179\164"] * 3 + 29
      JY.Person[0].生命 = JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"]
      JY.Person[0]["\196\218\193\166"] = JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"]
      JY.Person[0].外号 = "\179\172\201\241"
      JY.Person[0]["\196\218\193\166\208\212\214\202"] = 2
      if CC.JS == 1 then
        JY.Wugong[30]["\206\180\214\1701"] = 8
      end
      break
    else
      Cls()
      WhoAmI()
      DrawString(x1, y1, JY.Person[0].姓名 .. ",\202\244\208\212\194\250\210\226\194\240?", C_GOLD, fontsize)
      i = 0
      y1 = y1 + h
      DrawAttrib("\196\218\193\166", "\196\218\193\166")
      DrawAttrib("\185\165\187\247", "\185\165\187\247\193\166")
      DrawAttrib("\199\225\185\166", "\199\225\185\166")
      DrawAttrib("\183\192\211\249", "\183\192\211\249\193\166")
      DrawAttrib1("\196\218\185\166", "\196\218\193\166\208\212\214\202")
      i = 0
      y1 = y1 + h
      DrawAttrib("\201\250\195\252", "\201\250\195\252")
      DrawAttrib("\210\189\193\198", "\210\189\193\198\196\220\193\166")
      DrawAttrib("\211\195\182\190", "\211\195\182\190\196\220\193\166")
      DrawAttrib("\189\226\182\190", "\189\226\182\190\196\220\193\166")
      DrawAttrib("\215\202\214\202", "\215\202\214\202")
      i = 0
      y1 = y1 + h
      DrawAttrib("\200\173\213\198", "\200\173\213\198\185\166\183\242")
      DrawAttrib("\211\249\189\163", "\211\249\189\163\196\220\193\166")
      DrawAttrib("\203\163\181\182", "\203\163\181\182\188\188\199\201")
      DrawAttrib("\204\216\202\226", "\204\216\202\226\177\248\198\247")
      DrawAttrib("\176\181\198\247", "\176\181\198\247\188\188\199\201")
      ShowScreen()
      do
        local menu = {
          {
            "\202\199 ",
            nil,
            1
          },
          {
            "\183\241 ",
            nil,
            2
          }
        }
        local ok = ShowMenu2(menu, 2, 0, x1 + 10 * fontsize, CC.NewGameY + -110 + CC.MenuBorderPixel, 0, 0, 0, 0, fontsize, C_RED, C_WHITE)
        if ok == 1 then
          break
        end
      end
    end
  end
  if CC.BanBen == 1 and CC.JS == 1 and JY.Person[0].姓名 ~= "szlzw" then
    SelPerson()
  end
end

function ZCset()
  local zcsetnb = {}
  local zcsetstr = {}
  for i = 1, 2 do
    zcsetstr[i] = {}
  end
  if JY.ZCKG == 1 then
    zcsetnb[1] = 1
  else
    zcsetnb[1] = 0
  end
  if JY.JSKG == 1 then
    zcsetnb[2] = 1
  else
    zcsetnb[2] = 0
  end
  local rr = 1
  while true do
    if zcsetnb[1] == 0 then
      zcsetstr[1][1] = "\185\216\177\213 \215\212\180\180\206\228\185\166"
    else
      zcsetstr[1][1] = "\191\170\198\244 \215\212\180\180\206\228\185\166"
    end
    if zcsetnb[2] == 0 then
      zcsetstr[2][1] = "\185\216\177\213 \204\216\202\226\189\199\201\171"
    else
      zcsetstr[2][1] = "\191\170\198\244 \204\216\202\226\189\199\201\171"
    end
    local menu = {
      {
        zcsetstr[1][1],
        nil,
        1
      },
      {
        zcsetstr[2][1],
        nil,
        1
      }
    }
    local r = ShowMenu2_new(menu, #menu, 2, 12, -1, -1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\178\212\193\250\201\232\214\195", rr)
    rr = r
    if r == 0 then
      break
    end
    if r == 1 then
      if fksetnb[1] == 1 then
        fksetnb[1] = 0
        JY.ZCKG = 0
      else
        fksetnb[1] = 1
        JY.ZCKG = 1
      end
    elseif r == 2 then
      if fksetnb[2] == 1 then
        fksetnb[2] = 0
        JY.JSKG = 0
      else
        fksetnb[2] = 1
        JY.JSKG = 1
      end
    end
  end
end

function SelPerson()
  JY.Selpstr = {}
  local title = "\209\161\212\241\204\216\202\226\189\199\201\171"
  local str = "\200\173\176\212\163\186\200\173\205\183\211\178\178\197\202\199\181\192\192\237\161\163\204\216\188\188\163\186\198\198\183\192" .. "*\189\163\196\167\163\186\189\163\178\187\213\180\209\170\178\187\200\235\199\202\161\163\204\216\188\188\163\186\202\200\209\170" .. "*\181\182\179\213\163\186\206\202\202\192\188\228\199\233\206\170\186\206\206\239\161\163\204\216\188\188\163\186\177\216\201\177" .. "*\204\216\191\241\163\186\184\250\206\210\179\229\178\187\210\170\206\183\190\229\161\163\204\216\188\188\163\186\177\169\187\247" .. "*\201\241\214\250\163\186\204\236\201\241\180\205\211\232\206\210\193\166\193\191\161\163\204\216\188\188\163\186\187\164\204\229" .. "*\206\215\209\253\163\186\193\210\187\240\214\208\211\192\201\250\178\187\195\240\161\163\204\216\188\188\163\186\184\180\187\238" .. "*\182\190\205\245\163\186\206\222\182\190\183\199\213\201\183\242\203\249\206\170\161\163\204\216\188\188\163\186\223\253\182\190" .. "*\187\195\211\176\163\186\187\195\214\174\211\176\200\231\211\176\203\230\208\206\161\163\204\216\188\188\163\186\211\176\201\177"
  local btn = {
    "\200\173",
    "\189\163",
    "\181\182",
    "\204\216",
    "\214\250",
    "\206\215",
    "\182\190",
    "\211\176"
  }
  local num = #btn
  local r = JYMsgBox(title, str, btn, num, nil, 1)
  if r == 0 or r == 1 then
    JY.Selpstr[1] = {"\200\173\213\198\185\166\183\242", 1}
    JY.Selpstr[2] = {"\185\165\187\247\193\166", -1}
    JY.Selpstr[3] = {"\183\192\211\249\193\166", 2}
    JY.Selpstr[4] = {"\199\225\185\166", 2}
    JY.Person[0].外号 = "\200\173\176\212"
    JY.Wugong[30]["\206\180\214\1701"] = 1
    DrawStrBoxWaitKey("\200\173\176\212\161\250\198\198\183\192\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 2 then
    JY.Selpstr[1] = {"\211\249\189\163\196\220\193\166", 1}
    JY.Selpstr[2] = {"\185\165\187\247\193\166", 2}
    JY.Selpstr[3] = {"\183\192\211\249\193\166", -2}
    JY.Person[0].外号 = "\189\163\196\167"
    JY.Wugong[30]["\206\180\214\1701"] = 2
    DrawStrBoxWaitKey("\189\163\196\167\161\250\202\200\209\170\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 3 then
    JY.Selpstr[1] = {"\203\163\181\182\188\188\199\201", 1}
    JY.Selpstr[2] = {"\185\165\187\247\193\166", -1}
    JY.Selpstr[3] = {"\183\192\211\249\193\166", 2}
    JY.Selpstr[4] = {"\199\225\185\166", 2}
    JY.Person[0].外号 = "\181\182\179\213"
    JY.Wugong[30]["\206\180\214\1701"] = 3
    DrawStrBoxWaitKey("\181\182\179\213\161\250\210\187\187\247\177\216\201\177\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 4 then
    JY.Selpstr[1] = {"\204\216\202\226\177\248\198\247", 1}
    JY.Selpstr[2] = {"\183\192\211\249\193\166", 4}
    JY.Selpstr[3] = {"\199\225\185\166", -2}
    JY.Person[0].外号 = "\204\216\191\241"
    JY.Wugong[30]["\206\180\214\1701"] = 4
    DrawStrBoxWaitKey("\204\216\191\241\161\250\177\169\187\247\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 5 then
    JY.Selpstr[1] = {"\185\165\187\247\193\166", 3}
    JY.Selpstr[2] = {"\183\192\211\249\193\166", -2}
    JY.Selpstr[3] = {"\199\225\185\166", -2}
    JY.Selpstr[4] = {"\196\218\193\166\215\238\180\243\214\181", 50}
    JY.Person[0].外号 = "\201\241\214\250"
    JY.Wugong[30]["\206\180\214\1701"] = 5
    DrawStrBoxWaitKey("\201\241\214\250\161\250\204\236\201\241\187\164\204\229\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 6 then
    JY.Selpstr[1] = {"\210\189\193\198\196\220\193\166", 3}
    JY.Selpstr[2] = {"\211\195\182\190\196\220\193\166", 1}
    JY.Selpstr[3] = {"\191\185\182\190\196\220\193\166", 2}
    JY.Selpstr[4] = {"\185\165\187\247\193\166", -1}
    JY.Selpstr[5] = {"\199\225\185\166", 2}
    JY.Person[0].外号 = "\206\215\209\253"
    JY.Wugong[30]["\206\180\214\1701"] = 6
    DrawStrBoxWaitKey("\206\215\209\253\161\250\214\216\201\250\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 7 then
    JY.Selpstr[1] = {"\211\195\182\190\196\220\193\166", 3}
    JY.Selpstr[2] = {"\191\185\182\190\196\220\193\166", 3}
    JY.Selpstr[3] = {"\185\165\187\247\193\166", -1}
    JY.Selpstr[4] = {"\183\192\211\249\193\166", 2}
    JY.Person[0].外号 = "\182\190\205\245"
    JY.Wugong[30]["\206\180\214\1701"] = 7
    DrawStrBoxWaitKey("\182\190\205\245\161\250\180\227\182\190\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
  elseif r == 8 then
    JY.Selpstr[1] = {"\185\165\187\247\193\166", -1}
    JY.Selpstr[2] = {"\183\192\211\249\193\166", 2}
    JY.Selpstr[3] = {"\199\225\185\166", 2}
    JY.Person[0].外号 = "\187\195\211\176"
    JY.Wugong[30]["\206\180\214\1701"] = 9
    DrawStrBoxWaitKey("\187\195\211\176\161\250\211\176\201\177\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
  end
end

function Game_Cycle()
  lib.Debug("Start game cycle")
  while JY.Status ~= GAME_END do
    local t1 = lib.GetTime()
    JY.MyTick = JY.MyTick + 1
    if JY.MyTick % 20 == 0 then
      JY.MyCurrentPic = 0
    end
    if JY.MyTick % 1000 == 0 then
      JY.MyTick = 0
    end
    if JY.Status == GAME_FIRSTMMAP then
      CleanMemory()
      lib.ShowSlow(50, 1)
      JY.MmapMusic = 16
      JY.Status = GAME_MMAP
      Init_MMap()
      lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
      lib.ShowSlow(50, 0)
    elseif JY.Status == GAME_MMAP then
      Game_MMap()
    elseif JY.Status == GAME_SMAP then
      Game_SMap()
    end
    collectgarbage("step", 0)
    local t2 = lib.GetTime()
    if t2 - t1 < CC.Frame then
      lib.Delay(CC.Frame - (t2 - t1))
    end
  end
end

function YXQH()
  if JY.SETPD == 1 and DrawStrBoxYesNo(-1, -1, "\199\208\187\187\176\230\177\190\187\225\189\225\202\248\211\206\207\183\163\161\202\199\183\241\199\208\187\187\163\191", C_WHITE, CC.DefaultFont) == false then
    return
  end
  local menux = (CC.ScreenW - 5 * CC.StartMenuFontSize - 2 * CC.MenuBorderPixel) / 2
  local menuy = CC.StartMenuY - CC.StartMenuFontSize
  local menu3 = {
    {
      "\212\173    \176\230",
      nil,
      1
    },
    {
      "\178\212\193\250\214\240\200\213",
      nil,
      1
    },
    {
      "\212\217\213\189\189\173\186\254",
      nil,
      1
    },
    {
      "\204\168\205\229\207\231\195\241",
      nil,
      1
    },
    {
      "\204\236 \202\233 \189\217",
      nil,
      1
    },
    {
      "\178\212\193\2501028",
      nil,
      1
    }
  }
  local r11 = ShowMenu(menu3, #menu3, 0, menux, CC.ScreenH / 2 - CC.StartMenuFontSize * 3, 0, 0, 1, 1, CC.StartMenuFontSize, C_GOLD, C_WHITE)
  if 0 < r11 then
    local filecp = CONFIG.CurrentPath .. "set.ini"
    if existFile(filecp) then
      local file = io.open(filecp, "r")
      local str = {}
      local k = 1
      local ja
      for line in file:lines() do
        str[k] = line
        if str[k] ~= nil then
          if string.find(str[k], "CONFIG.MOD") then
            str[k] = "CONFIG.MOD = " .. r11 - 1
          end
          k = k + 1
        end
      end
      file = io.open(filecp, "w")
      for i = 1, k - 2 do
        file:write(str[i] .. "\n")
      end
      file:write(str[k - 1])
      file:close()
      DrawStrBoxWaitKey("\176\230\177\190\199\208\187\187\179\201\185\166\163\172\211\206\207\183\188\180\189\171\185\216\177\213\163\161\199\235\214\216\208\194\189\248\200\235", C_WHITE, CC.StartMenuFontSize)
    else
      DrawStrBoxWaitKey("\199\208\187\187\202\167\176\220\163\172\206\196\188\254\200\177\202\167\163\161\199\235\214\216\208\194\207\194\212\216\197\228\214\195\206\196\188\254", C_WHITE, CC.StartMenuFontSize)
    end
    os.exit()
  end
end

function Init_MMap()
  lib.PicInit()
  lib.LoadMMap(CC.MMapFile[1], CC.MMapFile[2], CC.MMapFile[3], CC.MMapFile[4], CC.MMapFile[5], CC.MWidth, CC.MHeight, JY.Base.人X, JY.Base.人Y)
  lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 0)
  lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)
  if CC.LoadThingPic == 1 then
    lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)
  end
  if CC.FK == 1 then
    lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 2)
  end
  JY.EnterSceneXY = nil
  JY.oldMMapX = -1
  JY.oldMMapY = -1
  PlayMIDI(JY.MmapMusic)
end

function Game_MMap()
  local direct = -1
  local keypress, ktype, mx, my = WaitKey(1)
  if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
    JY.MyTick = 0
    if keypress == VK_ESCAPE or ktype == 4 then
      MMenu()
      if JY.Status == GAME_FIRSTMMAP then
        return
      end
      JY.oldMMapX = -1
      JY.oldMMapY = -1
    elseif keypress == VK_UP then
      direct = 0
    elseif keypress == VK_DOWN then
      direct = 3
    elseif keypress == VK_LEFT then
      direct = 2
    elseif keypress == VK_RIGHT then
      direct = 1
    elseif keypress == VK_S then
      if CC.TP == 1 then
        Menu_Scene()
      else
        My_ChuangSong_List()
      end
    elseif keypress == VK_H then
      SaveRecord(11)
      JY.AtTime = lib.GetTime()
      JY.SBZ = 1
    elseif keypress == VK_RETURN then
      if JY.Base.人X == 138 and JY.Base.人Y == 138 and JY.Person[0].姓名 == "szlzw" then
        JY.WD = JY.WD + 1
      else
        JY.WD = 0
      end
      if JY.WD == 10 then
      end
    elseif ktype == 2 or ktype == 3 then
      local tmpx, tmpy = mx, my
      mx = mx - CC.ScreenW / 2
      my = my - CC.ScreenH / 2
      mx = mx / CC.XScale
      my = my / CC.YScale
      mx, my = (mx + my) / 2, (my - mx) / 2
      if 0 < mx then
        mx = mx + 0.99
      else
        mx = mx - 0.01
      end
      if 0 < my then
        my = my + 0.99
      else
        mx = mx - 0.01
      end
      mx = math.modf(mx) + JY.Base.人X
      my = math.modf(my) + JY.Base.人Y
      if ktype == 2 then
        if 0 < lib.GetMMap(mx, my, 3) then
          for i = 0, 4 do
            for j = 0, 4 do
              local xx, yy = mx - i, my - j
              local sid = CanEnterScene(xx, xx)
              if sid < 0 then
                xx, yy = mx + i, my + j
                sid = CanEnterScene(xx, yy)
              end
              if 0 <= sid then
                CC.MMapAdress[0] = sid
                CC.MMapAdress[1] = tmpx
                CC.MMapAdress[2] = tmpy
                CC.MMapAdress[3] = xx
                CC.MMapAdress[4] = yy
                i = 5
                break
              end
            end
          end
        else
          CC.MMapAdress[0] = nil
        end
      end
      if ktype == 3 or ktype == 2 and JY.KT == 1 then
        if CC.MMapAdress[0] ~= nil then
          mx = CC.MMapAdress[3] - JY.Base.人X
          my = CC.MMapAdress[4] - JY.Base.人Y
          CC.MMapAdress[0] = nil
        else
          AutoMoveTab = {
            [0] = 0
          }
          mx = mx - JY.Base.人X
          my = my - JY.Base.人Y
        end
        walkto(mx, my)
      end
    elseif ktype == 5 then
      if JY.KT == 0 then
        JY.KT = 1
      else
        JY.KT = 0
      end
    end
  end
  if AutoMoveTab[0] ~= 0 then
    if direct == -1 then
      direct = AutoMoveTab[AutoMoveTab[0]]
      AutoMoveTab[AutoMoveTab[0]] = nil
      AutoMoveTab[0] = AutoMoveTab[0] - 1
    end
  else
    AutoMoveTab = {
      [0] = 0
    }
  end
  local x, y
  
  local function CanMove(nd, nnd)
    local nx, ny = JY.Base.人X + CC.DirectX[nd + 1], JY.Base.人Y + CC.DirectY[nd + 1]
    if nnd ~= nil then
      nx, ny = nx + CC.DirectX[nnd + 1], ny + CC.DirectY[nnd + 1]
    end
    if CC.hx == nil and (lib.GetMMap(nx, ny, 3) == 0 and lib.GetMMap(nx, ny, 4) == 0 or CanEnterScene(nx, ny) ~= -1) then
      return true
    else
      return false
    end
  end
  
  local x, y
  if direct ~= -1 then
    AddMyCurrentPic()
    x = JY.Base.人X + CC.DirectX[direct + 1]
    y = JY.Base.人Y + CC.DirectY[direct + 1]
    JY.Base["\200\203\183\189\207\242"] = direct
  else
    x = JY.Base.人X
    y = JY.Base.人Y
  end
  JY.SubScene = CanEnterScene(x, y)
  if lib.GetMMap(x, y, 3) == 0 and lib.GetMMap(x, y, 4) == 0 then
    JY.Base.人X = x
    JY.Base.人Y = y
  end
  JY.Base.人X = limitX(JY.Base.人X, 10, CC.MWidth - 10)
  JY.Base.人Y = limitX(JY.Base.人Y, 10, CC.MHeight - 10)
  if CC.MMapBoat[lib.GetMMap(JY.Base.人X, JY.Base.人Y, 0)] == 1 then
    JY.Base["\179\203\180\172"] = 1
  else
    JY.Base["\179\203\180\172"] = 0
  end
  local pic = GetMyPic()
  if CONFIG.FastShowScreen == 1 then
    if JY.oldMMapX == JY.Base.人X and JY.oldMMapY == JY.Base.人Y then
      if 0 <= JY.oldMMapPic and JY.oldMMapPic ~= pic then
        local rr = ClipRect(Cal_PicClip(0, 0, JY.oldMMapPic, 0, 0, 0, pic, 0))
        if rr ~= nil then
          lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
          lib.DrawMMap(JY.Base.人X, JY.Base.人Y, pic)
        end
      end
    else
      lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
      lib.DrawMMap(JY.Base.人X, JY.Base.人Y, pic)
    end
  else
    lib.DrawMMap(JY.Base.人X, JY.Base.人Y, pic)
  end
  MSG()
  if CC.OpenTimmerRemind == 1 then
    DrawTimer()
  end
  AutoSave()
  ShowScreen(CONFIG.FastShowScreen)
  lib.SetClip(0, 0, 0, 0)
  JY.oldMMapX = JY.Base.人X
  JY.oldMMapY = JY.Base.人Y
  JY.oldMMapPic = pic
  if JY.OLDRKX ~= JY.Base.人X or JY.OLDRKY ~= JY.Base.人Y then
    JY.OLDRKX = -1
    JY.OLDRKY = -1
  end
  if 0 <= JY.SubScene and (JY.OLDRKX == -1 and JY.OLDRKY == -1 or keypress ~= -1 or ktype ~= nil and ktype ~= -1) then
    CleanMemory()
    lib.UnloadMMap()
    lib.PicInit()
    JY.Status = GAME_SMAP
    JY.MmapMusic = -1
    JY.MyPic = GetMyPic()
    JY.Base.人X1 = JY.Scene[JY.SubScene]["\200\235\191\218X"]
    JY.Base.人Y1 = JY.Scene[JY.SubScene]["\200\235\191\218Y"]
    JY.OLDRKX = JY.Base.人X
    JY.OLDRKY = JY.Base.人Y
    Init_SMap(1)
  end
end

function Init_SMap(showname)
  lib.PicInit()
  lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)
  lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)
  if CC.LoadThingPic == 1 then
    lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)
  end
  if CC.FK == 1 then
    lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 2)
  end
  PlayMIDI(JY.Scene[JY.SubScene]["\189\248\195\197\210\244\192\214"])
  JY.oldSMapX = -1
  JY.oldSMapY = -1
  JY.SubSceneX = 0
  JY.SubSceneY = 0
  JY.OldDPass = -1
  JY.D_Valid = nil
  DrawSMap()
  lib.ShowSlow(50, 0)
  Cls()
  ShowScreen()
  if showname == 1 then
    DrawStrBox(-1, 10, JY.Scene[JY.SubScene]["\195\251\179\198"], C_WHITE, CC.DefaultFont)
    ShowScreen()
    lib.Delay(500)
    Cls()
  end
end

function Game_SMap()
  DrawSMap(CONFIG.FastShowScreen)
  MSG()
  if CC.OpenTimmerRemind == 1 then
    DrawTimer()
  end
  AutoSave()
  ShowScreen(CONFIG.FastShowScreen)
  lib.SetClip(0, 0, 0, 0)
  local d_pass = GetS(JY.SubScene, JY.Base.人X1, JY.Base.人Y1, 3)
  if 0 <= d_pass then
    if d_pass ~= JY.OldDPass then
      EventExecute(d_pass, 3)
      JY.OldDPass = d_pass
      JY.oldSMapX = -1
      JY.oldSMapY = -1
      JY.D_Valid = nil
    end
  else
    JY.OldDPass = -1
  end
  local isout = 0
  if JY.Scene[JY.SubScene]["\179\246\191\218X1"] == JY.Base.人X1 and JY.Scene[JY.SubScene]["\179\246\191\218Y1"] == JY.Base.人Y1 or JY.Scene[JY.SubScene]["\179\246\191\218X2"] == JY.Base.人X1 and JY.Scene[JY.SubScene]["\179\246\191\218Y2"] == JY.Base.人Y1 or JY.Scene[JY.SubScene]["\179\246\191\218X3"] == JY.Base.人X1 and JY.Scene[JY.SubScene]["\179\246\191\218Y3"] == JY.Base.人Y1 then
    isout = 1
  end
  if isout == 1 then
    JY.Status = GAME_MMAP
    lib.PicInit()
    CleanMemory()
    if 0 > JY.MmapMusic then
      JY.MmapMusic = JY.Scene[JY.SubScene]["\179\246\195\197\210\244\192\214"]
    end
    Init_MMap()
    JY.SubScene = -1
    JY.oldSMapX = -1
    JY.oldSMapY = -1
    lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
    lib.ShowSlow(50, 0)
    return
  end
  if 0 <= JY.Scene[JY.SubScene]["\204\248\215\170\179\161\190\176"] and JY.Base.人X1 == JY.Scene[JY.SubScene]["\204\248\215\170\191\218X1"] and JY.Base.人Y1 == JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y1"] then
    JY.SubScene = JY.Scene[JY.SubScene]["\204\248\215\170\179\161\190\176"]
    lib.ShowSlow(50, 1)
    if JY.Scene[JY.SubScene]["\205\226\190\176\200\235\191\218X1"] == 0 and JY.Scene[JY.SubScene]["\205\226\190\176\200\235\191\218Y1"] == 0 then
      JY.Base.人X1 = JY.Scene[JY.SubScene]["\200\235\191\218X"]
      JY.Base.人Y1 = JY.Scene[JY.SubScene]["\200\235\191\218Y"]
    else
      JY.Base.人X1 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218X2"]
      JY.Base.人Y1 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y2"]
    end
    Init_SMap(1)
    return
  end
  local x, y
  local keypress, ktype, mx, my = WaitKey(1)
  local direct = -1
  if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
    JY.MyTick = 0
    if keypress == VK_ESCAPE or ktype == 4 then
      MMenu()
      JY.oldSMapX = -1
      JY.oldSMapY = -1
    elseif keypress == VK_UP then
      direct = 0
    elseif keypress == VK_DOWN then
      direct = 3
    elseif keypress == VK_LEFT then
      direct = 2
    elseif keypress == VK_RIGHT then
      direct = 1
    elseif keypress == VK_H then
      SaveRecord(11)
      JY.AtTime = lib.GetTime()
      JY.SBZ = 1
    elseif keypress == VK_S then
      TSInstruce()
    elseif keypress == VK_SPACE or keypress == VK_RETURN then
      if 0 <= JY.Base["\200\203\183\189\207\242"] then
        local d_num = GetS(JY.SubScene, JY.Base.人X1 + CC.DirectX[JY.Base["\200\203\183\189\207\242"] + 1], JY.Base.人Y1 + CC.DirectY[JY.Base["\200\203\183\189\207\242"] + 1], 3)
        if 0 <= d_num then
          EventExecute(d_num, 1)
          JY.oldSMapX = -1
          JY.oldSMapY = -1
          JY.D_Valid = nil
        end
      end
    elseif ktype == 3 or ktype == 2 and JY.KT == 1 then
      AutoMoveTab = {
        [0] = 0
      }
      local x0 = JY.Base.人X1
      local y0 = JY.Base.人Y1
      mx = mx + (x0 - y0) * CC.XScale - CC.ScreenW / 2
      my = my + (x0 + y0) * CC.YScale - CC.ScreenH / 2
      local xx = (mx / CC.XScale + my / CC.YScale) / 2
      local yy = (my / CC.YScale - mx / CC.XScale) / 2
      if 0 < xx - math.modf(xx) then
        xx = math.modf(xx + 1)
      end
      if 0 < yy - math.modf(yy) then
        yy = math.modf(yy + 1)
      end
      if 0 <= xx and xx < CC.SWidth and 0 <= yy and yy < CC.SHeight then
        walkto(xx - x0, yy - y0)
      end
    elseif ktype == 5 then
      if JY.KT == 0 then
        JY.KT = 1
      else
        JY.KT = 0
      end
    end
  end
  if JY.Status ~= GAME_SMAP then
    return
  end
  if AutoMoveTab[0] ~= 0 then
    if direct == -1 then
      direct = AutoMoveTab[AutoMoveTab[0]]
      AutoMoveTab[AutoMoveTab[0]] = nil
      AutoMoveTab[0] = AutoMoveTab[0] - 1
    end
  else
    AutoMoveTab = {
      [0] = 0
    }
    if CC.AutoMoveEvent[0] == 1 and 2 >= math.abs(CC.AutoMoveEvent[1] - JY.Base.人X1) and 2 >= math.abs(CC.AutoMoveEvent[2] - JY.Base.人Y1) then
      EventExecute(GetS(JY.SubScene, CC.AutoMoveEvent[1], CC.AutoMoveEvent[2], 3), 1)
      CC.AutoMoveEvent[0] = 0
    end
  end
  if direct ~= -1 then
    AddMyCurrentPic()
    x = JY.Base.人X1 + CC.DirectX[direct + 1]
    y = JY.Base.人Y1 + CC.DirectY[direct + 1]
    JY.Base["\200\203\183\189\207\242"] = direct
  else
    x = JY.Base.人X1
    y = JY.Base.人Y1
  end
  JY.MyPic = GetMyPic()
  DtoSMap()
  if SceneCanPass(x, y) == true then
    JY.Base.人X1 = x
    JY.Base.人Y1 = y
  end
  JY.Base.人X1 = limitX(JY.Base.人X1, 1, CC.SWidth - 2)
  JY.Base.人Y1 = limitX(JY.Base.人Y1, 1, CC.SHeight - 2)
end

function Cal_PicClip(dx1, dy1, pic1, id1, dx2, dy2, pic2, id2)
  local w1, h1, x1_off, y1_off = lib.PicGetXY(id1, pic1 * 2)
  local old_r = {}
  old_r.x1 = CC.XScale * (dx1 - dy1) + CC.ScreenW / 2 - x1_off
  old_r.y1 = CC.YScale * (dx1 + dy1) + CC.ScreenH / 2 - y1_off
  old_r.x2 = old_r.x1 + w1
  old_r.y2 = old_r.y1 + h1
  local w2, h2, x2_off, y2_off = lib.PicGetXY(id2, pic2 * 2)
  local new_r = {}
  new_r.x1 = CC.XScale * (dx2 - dy2) + CC.ScreenW / 2 - x2_off
  new_r.y1 = CC.YScale * (dx2 + dy2) + CC.ScreenH / 2 - y2_off
  new_r.x2 = new_r.x1 + w2
  new_r.y2 = new_r.y1 + h2
  return MergeRect(old_r, new_r)
end

function MergeRect(r1, r2)
  local res = {}
  res.x1 = math.min(r1.x1, r2.x1)
  res.y1 = math.min(r1.y1, r2.y1)
  res.x2 = math.max(r1.x2, r2.x2)
  res.y2 = math.max(r1.y2, r2.y2)
  return res
end

function ClipRect(r)
  if r.x1 >= CC.ScreenW or r.x2 <= 0 or r.y1 >= CC.ScreenH or 0 >= r.y2 then
    return nil
  else
    local res = {}
    res.x1 = limitX(r.x1, 0, CC.ScreenW)
    res.x2 = limitX(r.x2, 0, CC.ScreenW)
    res.y1 = limitX(r.y1, 0, CC.ScreenH)
    res.y2 = limitX(r.y2, 0, CC.ScreenH)
    return res
  end
end

function GetMyPic()
  local n
  if JY.Status == GAME_MMAP and JY.Base["\179\203\180\172"] == 1 then
    if JY.MyCurrentPic >= 4 then
      JY.MyCurrentPic = 0
    end
  elseif JY.MyCurrentPic > 6 then
    JY.MyCurrentPic = 1
  end
  if JY.Base["\179\203\180\172"] == 0 then
    n = CC.MyStartPic + JY.Base["\200\203\183\189\207\242"] * 7 + JY.MyCurrentPic
  else
    n = CC.BoatStartPic + JY.Base["\200\203\183\189\207\242"] * 4 + JY.MyCurrentPic
  end
  return n
end

function AddMyCurrentPic()
  JY.MyCurrentPic = JY.MyCurrentPic + 1
end

function CanEnterScene(x, y)
  if JY.EnterSceneXY == nil then
    Cal_EnterSceneXY()
  end
  local id = JY.EnterSceneXY[y * CC.MWidth + x]
  if id ~= nil then
    local e = JY.Scene[id]["\189\248\200\235\204\245\188\254"]
    if e == 0 then
      return id
    elseif e == 1 then
      return -1
    elseif e == 2 then
      for i = 1, CC.TeamNum do
        local pid = JY.Base["\182\211\206\233" .. i]
        if 0 <= pid and JY.Person[pid]["\199\225\185\166"] >= 70 then
          return id
        end
      end
    end
  end
  return -1
end

function Cal_EnterSceneXY()
  JY.EnterSceneXY = {}
  for id = 0, JY.SceneNum - 1 do
    local scene = JY.Scene[id]
    if 0 < scene["\205\226\190\176\200\235\191\218X1"] and scene["\205\226\190\176\200\235\191\218Y1"] then
      JY.EnterSceneXY[scene["\205\226\190\176\200\235\191\218Y1"] * CC.MWidth + scene["\205\226\190\176\200\235\191\218X1"]] = id
    end
    if 0 < scene["\205\226\190\176\200\235\191\218X2"] and scene["\205\226\190\176\200\235\191\218Y2"] then
      JY.EnterSceneXY[scene["\205\226\190\176\200\235\191\218Y2"] * CC.MWidth + scene["\205\226\190\176\200\235\191\218X2"]] = id
    end
  end
end

function MMenu()
  if JY.SCKG == 0 then
    JY.MENUMSG = 1
  end
  SCMSG()
  if JY.SCKG == 1 then
    Cls()
  end
  local menu = {
    {
      "\210\189\193\198",
      Menu_Doctor,
      1
    },
    {
      "\189\226\182\190",
      Menu_DecPoison,
      1
    },
    {
      "\206\239\198\183",
      Menu_Thing,
      1
    },
    {
      "\182\168\206\187",
      Menu_Map,
      0
    },
    {
      "\215\180\204\172",
      Menu_Status,
      1
    },
    {
      "\192\235\182\211",
      Menu_PersonExit,
      1
    },
    {
      "\207\181\205\179",
      Menu_System,
      1
    }
  }
  if JY.Status == GAME_MMAP then
    menu[4][3] = 1
    if JY.JZKG == 0 then
      menu[4][3] = 0
    end
  end
  local r = ShowMenu(menu, #menu, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if r == 0 or JY.SCKG == 1 then
    JY.MENUMSG = 0
  end
end

function Menu_Map()
  if JY.MiniMap == 0 then
    if CONFIG.Operation == 1 then
      JY.SCTMP = JY.SCKG
      JY.SCKG = 0
    end
    JY.MiniMap = 1
  else
    if CONFIG.Operation == 1 then
      JY.SCKG = JY.SCTMP
    end
    JY.MiniMap = 0
  end
  JY.MENUMSG = 0
  return 1
end

function Menu_System()
  local menu = {
    {
      "\182\193\200\161\189\248\182\200",
      Menu_ReadRecord,
      1
    },
    {
      "\177\163\180\230\189\248\182\200",
      Menu_SaveRecord,
      1
    },
    {
      "\185\216\177\213\210\244\192\214",
      Menu_SetMusic,
      1
    },
    {
      "\185\216\177\213\210\244\208\167",
      Menu_SetSound,
      1
    },
    {
      "\200\171\198\193\199\208\187\187",
      Menu_FullScreen,
      0
    },
    {
      "\207\181\205\179\185\165\194\212",
      TSInstruce,
      1
    },
    {
      "\194\237\179\181\180\171\203\205",
      My_ChuangSong_List,
      1
    },
    {
      "\185\166\196\220\188\211\199\191",
      Menu_App,
      1
    },
    {
      "\207\181\205\179\201\232\214\195",
      System_Set,
      1
    },
    {
      "\192\235\191\170\211\206\207\183",
      Menu_Exit,
      1
    }
  }
  if JY.EnableMusic == 0 then
    menu[3][1] = "\180\242\191\170\210\244\192\214"
  end
  if JY.EnableSound == 0 then
    menu[4][1] = "\180\242\191\170\210\244\208\167"
  end
  if JY.Status == GAME_SMAP then
    menu[7][3] = 0
  end
  local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if r == 0 then
    return 0
  elseif r < 0 then
    return 1
  end
end

function System_Set()
  local setstr = {}
  local setnb = {}
  local filecp = CONFIG.CurrentPath .. "set.ini"
  for i = 1, 8 do
    setstr[i] = {}
  end
  if existFile(filecp) then
    local file = io.open(filecp, "r")
    local str = {}
    local ss
    local k = 1
    local ja, ii, jj
    for line in file:lines() do
      str[k] = line
      if str[k] ~= nil then
        if string.find(str[k], "CONFIG.ZCOPEN") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          setstr[1][2] = str[k]
          setnb[1] = tonumber(string.sub(str[k], ii, jj))
        end
        if string.find(str[k], "CONFIG.JS") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          setstr[2][2] = str[k]
          setnb[2] = tonumber(string.sub(str[k], ii, jj))
        end
        if string.find(str[k], "CONFIG.Remind") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          setstr[3][2] = str[k]
          setnb[3] = tonumber(string.sub(str[k], ii, jj))
        end
        if string.find(str[k], "CONFIG.SaveTime") then
          for i = 1, 90 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          setstr[4][2] = str[k]
          if ii == nil then
            setnb[4] = 20
          else
            setnb[4] = tonumber(string.sub(str[k], ii, jj))
          end
        end
        if string.find(str[k], "CONFIG.ExpLevel") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          if ii == nil then
            setnb[5] = 0
          else
            setnb[5] = tonumber(string.sub(str[k], ii, jj))
          end
        end
        if string.find(str[k], "CONFIG.TP") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          if ii == nil then
            setnb[6] = 0
          else
            setnb[6] = tonumber(string.sub(str[k], ii, jj))
          end
        end
        if string.find(str[k], "CONFIG.MP3") then
          for i = 0, 1 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          if ii == nil then
            setnb[7] = 0
          else
            setnb[7] = tonumber(string.sub(str[k], ii, jj))
          end
        end
        if string.find(str[k], "CONFIG.Frame") then
          for i = 20, 60 do
            if string.find(str[k], tostring(i)) then
              ii, jj = string.find(str[k], tostring(i))
            end
          end
          setstr[8][2] = str[k]
          if ii == nil then
            setnb[8] = 20
          else
            setnb[8] = tonumber(string.sub(str[k], ii, jj))
          end
        end
        k = k + 1
      end
    end
    file:close()
  else
    return
  end
  local rr = 1
  while true do
    if setnb[1] == 0 then
      setstr[1][1] = "\215\212\180\180\206\228\185\166\210\209\185\216\177\213"
    else
      setstr[1][1] = "\215\212\180\180\206\228\185\166\210\209\191\170\198\244"
    end
    if setnb[2] == 0 then
      setstr[2][1] = "\204\216\202\226\189\199\201\171\210\209\185\216\177\213"
    else
      setstr[2][1] = "\204\216\202\226\189\199\201\171\210\209\191\170\198\244"
    end
    if setnb[3] == 0 then
      setstr[3][1] = "\185\246\182\175\208\197\207\162\210\209\185\216\177\213"
    else
      setstr[3][1] = "\185\246\182\175\208\197\207\162\210\209\191\170\198\244"
    end
    setstr[4][1] = "\215\212\182\175\180\230\181\181" .. string.format("%2d\183\214\214\211", setnb[4])
    if setnb[5] == 0 then
      setstr[5][1] = "\203\171\177\182\190\173\209\233\210\209\185\216\177\213"
    elseif setnb[5] == 1 then
      setstr[5][1] = "\203\171\177\182\190\173\209\233\210\209\191\170\198\244"
    else
      setstr[5][1] = "\203\171\177\182\190\173\209\233\210\209\185\216\177\213"
    end
    if setnb[6] == 0 then
      setstr[6][1] = "\180\171\203\205\199\208\187\187\163\186\177\224\186\197"
    else
      setstr[6][1] = "\180\171\203\205\199\208\187\187\163\186\184\189\189\252"
    end
    if setnb[7] == 0 then
      setstr[7][1] = "MP3\210\244\192\214 \210\209\185\216\177\213"
    else
      setstr[7][1] = "MP3\210\244\192\214 \210\209\191\170\198\244"
    end
    setstr[8][1] = "\211\206\207\183\209\211\179\217\163\186" .. string.format("%2d", setnb[8]) .. "ms"
    local menu = {
      {
        setstr[1][1],
        nil,
        1
      },
      {
        setstr[2][1],
        nil,
        1
      },
      {
        setstr[3][1],
        nil,
        1
      },
      {
        setstr[4][1],
        nil,
        1
      },
      {
        setstr[5][1],
        nil,
        1
      },
      {
        setstr[6][1],
        nil,
        1
      },
      {
        setstr[7][1],
        nil,
        1
      },
      {
        setstr[8][1],
        nil,
        1
      }
    }
    if CC.BanBen ~= 1 then
      menu[1] = nil
      menu[2] = nil
    end
    local r = ShowMenu2_new(menu, #menu, 2, 12, -1, -1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\207\181\205\179\201\232\214\195", rr)
    rr = r
    if r == 0 then
      if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\177\163\180\230\201\232\214\195\163\191", C_WHITE, CC.StartMenuFontSize) ~= false then
        if existFile(filecp) then
          local file = io.open(filecp, "r")
          local str = {}
          local k = 1
          local ja
          for line in file:lines() do
            str[k] = line
            if str[k] ~= nil then
              if string.find(str[k], "CONFIG.ZCOPEN") then
                str[k] = "CONFIG.ZCOPEN = " .. tostring(setnb[1])
              end
              if string.find(str[k], "CONFIG.JS") then
                str[k] = "CONFIG.JS = " .. tostring(setnb[2])
              end
              if string.find(str[k], "CONFIG.Remind") then
                str[k] = "CONFIG.Remind = " .. tostring(setnb[3])
              end
              if string.find(str[k], "CONFIG.SaveTime") then
                str[k] = "CONFIG.SaveTime = " .. tostring(setnb[4])
              end
              if string.find(str[k], "CONFIG.ExpLevel") then
                str[k] = "CONFIG.ExpLevel = " .. tostring(setnb[5])
              end
              if string.find(str[k], "CONFIG.TP") then
                str[k] = "CONFIG.TP = " .. tostring(setnb[6])
              end
              if string.find(str[k], "CONFIG.MP3") then
                str[k] = "CONFIG.MP3 = " .. tostring(setnb[7])
              end
              if string.find(str[k], "CONFIG.Frame") then
                str[k] = "CONFIG.Frame = " .. tostring(setnb[8])
              end
              k = k + 1
            end
          end
          file = io.open(filecp, "w")
          for i = 1, k - 2 do
            file:write(str[i] .. "\n")
          end
          file:write(str[k - 1])
          file:close()
        end
        if CC.BanBen == 1 then
          if setnb[1] == 0 then
            CC.ZCOPEN = 0
          else
            CC.ZCOPEN = 1
            if JY.SETPD == 1 then
              Cls()
              DrawStrBoxWaitKey("\215\212\180\180\206\228\185\166\161\250\191\170\198\244\179\201\185\166", C_WHITE, CC.DefaultFont)
            end
          end
          if JY.SETPD == 1 then
            ZCKG()
          end
          if setnb[2] == 0 then
            CC.JS = 0
          else
            CC.JS = 1
            if JY.SETPD == 1 then
              Cls()
              if JY.Person[0].外号 == "\200\173\176\212" then
                DrawStrBoxWaitKey("\200\173\176\212\161\250\198\198\183\192\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\189\163\196\167" then
                DrawStrBoxWaitKey("\189\163\196\167\161\250\202\200\209\170\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\181\182\179\213" then
                DrawStrBoxWaitKey("\181\182\179\213\161\250\210\187\187\247\177\216\201\177\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\204\216\191\241" then
                DrawStrBoxWaitKey("\204\216\191\241\161\250\177\169\187\247\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\201\241\214\250" then
                DrawStrBoxWaitKey("\201\241\214\250\161\250\204\236\201\241\187\164\204\229\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\206\215\209\253" then
                DrawStrBoxWaitKey("\206\215\209\253\161\250\214\216\201\250\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\182\190\205\245" then
                DrawStrBoxWaitKey("\182\190\205\245\161\250\180\227\182\190\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\187\195\211\176" then
                DrawStrBoxWaitKey("\187\195\211\176\161\250\211\176\201\177\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
              elseif JY.Person[0].外号 == "\179\172\201\241" then
                DrawStrBoxWaitKey("\179\172\201\241\161\250\177\228\201\237\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
              else
                DrawStrBoxWaitKey("\204\216\202\226\189\199\201\171\161\250\191\170\198\244\202\167\176\220", C_RED, CC.DefaultFont)
                CC.JS = 0
              end
            end
          end
        end
        if setnb[3] == 0 then
          CC.OpenTimmerRemind = 0
        else
          CC.OpenTimmerRemind = 1
        end
        if setnb[5] == 1 then
          CC.ExpCS = 2
        else
          CC.ExpCS = 1
        end
        if setnb[6] == 1 then
          CC.TP = 1
        else
          CC.TP = 0
        end
        if setnb[7] == 1 then
        else
        end
        CC.Frame = setnb[8]
      end
      break
    end
    if r == 1 then
      if setnb[1] == 0 then
        setnb[1] = 1
      else
        setnb[1] = 0
      end
    elseif r == 2 then
      if setnb[2] == 0 then
        setnb[2] = 1
      else
        setnb[2] = 0
      end
    elseif r == 3 then
      if setnb[3] == 0 then
        setnb[3] = 1
      else
        setnb[3] = 0
      end
    elseif r == 4 then
      Cls()
      local fontsize = CC.NewGameFontSize
      if JY.SETPD == 1 then
        DrawString(CC.ScreenW / 2 - fontsize * 6, CC.ScreenH - fontsize * 2, string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\206\170%d\183\214\214\211", JY.SaveTime), C_GOLD, CC.NewGameFontSize, 1)
        ShowScreen()
      end
      JY.SaveTime = InputNum("\215\212\182\175\180\230\181\181\188\228\184\244\163\168\183\214\214\211\163\169", 1, 90)
      JY.AtTime = lib.GetTime()
      JY.DiyTime = JY.AtTime + JY.SaveTime * 60000
      if CC.BanBen == 1 then
        CC.RUNSTR[CC.NUMBER] = string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\202\177\188\228\201\232\182\168\206\170%d\183\214\214\211 \191\201\212\218\161\176\185\166\196\220\188\211\199\191\161\177->\161\176\180\230\181\181\201\232\182\168\161\177\192\239\184\252\184\196", JY.SaveTime)
      else
        CC.RUNSTR[CC.NUMBER] = string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\202\177\188\228\201\232\182\168\206\170%d\183\214\214\211 \191\201\212\218\161\176\185\166\196\220\188\211\199\191\161\177->\161\176\180\230\181\181\201\232\182\168\161\177\192\239\184\252\184\196", JY.SaveTime)
      end
      Cls()
      setnb[4] = JY.SaveTime
    elseif r == 5 then
      if setnb[5] == 1 then
        setnb[5] = 0
      else
        setnb[5] = 1
      end
    elseif r == 6 then
      if setnb[6] == 1 then
        setnb[6] = 0
      else
        setnb[6] = 1
      end
    elseif r == 7 then
      if setnb[7] == 1 then
        setnb[7] = 0
      else
        setnb[7] = 1
      end
    elseif r == 8 then
      Cls()
      setnb[8] = InputNum("\211\206\207\183\209\211\179\217\202\177\188\228\163\168\186\193\195\235\163\169", 20, 60)
    end
  end
end

function Menu_FullScreen()
end

function Menu_SetMusic()
  if JY.EnableMusic == 0 then
    JY.EnableMusic = 1
    PlayMIDI(JY.CurrentMIDI)
  else
    JY.EnableMusic = 0
    lib.PlayMIDI("")
  end
  return 1
end

function Menu_SetSound()
  if JY.EnableSound == 0 then
    JY.EnableSound = 1
  else
    JY.EnableSound = 0
  end
  return 1
end

function Menu_ReadRecord()
  Cls()
  DrawStrBox(CC.ScreenW / 2 - CC.DefaultFont * 3, CC.DefaultFont * 2, "\182\193\200\161\189\248\182\200\193\208\177\237", C_ORANGE, CC.DefaultFont)
  local r = SaveList()
  if r == 0 then
    return 0
  elseif 0 < r and (true == existFile(CC.S_Filename[r]) or true == existFile(CC.D_Filename[r])) then
    DrawStrBox(CC.MainSubMenuX2, CC.MainSubMenuY, "\182\193\200\161\214\208......", C_WHITE, CC.StartMenuFontSize)
    ShowScreen()
    CleanMemory()
    LoadRecord(r)
    if 0 < JY.Base.无用 then
      if JY.Status == GAME_MMAP then
        lib.UnloadMMap()
        lib.PicInit()
      end
      lib.ShowSlow(50, 1)
      JY.Status = GAME_SMAP
      JY.SubScene = JY.Base.无用
      JY.MmapMusic = -1
      JY.MyPic = GetMyPic()
      Init_SMap(1)
      return 1, Game_Cycle()
    elseif JY.Base.无用 == 0 then
      if JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X1"] - 1 and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y1"] or JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X2"] and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y2"] + 1 then
        if JY.Status == GAME_MMAP then
          lib.UnloadMMap()
          lib.PicInit()
        end
        lib.ShowSlow(50, 1)
        JY.Status = GAME_SMAP
        JY.SubScene = JY.Base.无用
        JY.MmapMusic = -1
        JY.MyPic = GetMyPic()
        Init_SMap(1)
        return 1, Game_Cycle()
      else
        JY.SubScene = -1
        JY.Status = GAME_FIRSTMMAP
      end
    else
      JY.SubScene = -1
      JY.Status = GAME_FIRSTMMAP
    end
    return 1
  elseif false == existFile(CC.S_Filename[r]) or false == existFile(CC.D_Filename[r]) then
    DrawStrBox(-1, -1, "\191\213\180\230\181\181!", C_WHITE, CC.StartMenuFontSize)
    ShowScreen()
    WaitKey()
    Cls()
  end
end

function Menu_Start()
  if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\213\230\181\196\183\181\187\216\214\247\178\203\181\165\163\191", C_WHITE, CC.StartMenuFontSize) == false then
    return 1
  end
  return Game_Start()
end

function Menu_Exit()
  if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\213\230\181\196\210\170\192\235\191\170\211\206\207\183\163\191", C_WHITE, CC.StartMenuFontSize) == true then
    os.exit()
  end
  return 1
end

function Menu_SaveRecord()
  Cls()
  DrawStrBox(CC.ScreenW / 2 - CC.DefaultFont * 3, CC.DefaultFont * 2, "\177\163\180\230\189\248\182\200\193\208\177\237", C_ORANGE, CC.DefaultFont)
  local r = SaveList(1)
  if 0 < r then
    DrawStrBox(CC.MainSubMenuX2, CC.MainSubMenuY, "\199\235\201\212\186\242......", C_WHITE, CC.DefaultFont)
    ShowScreen()
    SaveRecord(r)
    Cls(CC.MainSubMenuX2, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
  elseif r == 0 then
    return 0
  end
  return 1
end

function Menu_App()
  local menu = {}
  menu = {
    {
      "\184\189\189\252\179\161\190\176",
      Menu_Scene,
      1
    },
    {
      "\194\237\179\181\230\228\213\190",
      Menu_Fly,
      1
    },
    {
      "\197\197\177\248\178\188\213\243",
      Menu_PBBZ,
      1
    },
    {
      "\206\228\185\166\214\216\197\197",
      Menu_WGCP,
      0
    },
    {
      "\180\230\181\181\199\229\192\237",
      Menu_CDQL,
      1
    },
    {
      "\180\230\181\181\201\232\214\195",
      Menu_CDSZ,
      1
    },
    {
      "\191\170\190\214\214\250\202\214",
      SeachItem,
      0
    },
    {
      "\183\192\191\168\201\232\214\195",
      Menu_FKSet,
      1
    },
    {
      "\199\208\187\187\176\230\177\190",
      YXQH,
      1
    }
  }
  if CC.BanBen == 1 then
    menu[7][3] = 1
  end
  if CC.BanBen == 0 then
    menu[4][3] = 1
  end
  if JY.Status == GAME_MMAP then
  elseif JY.Status == GAME_SMAP then
    menu[1][3] = 0
    menu[2][3] = 0
  end
  local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX2, CC.MainSubMenuY, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if r == 0 then
    return 0
  end
  return 1
end

function Menu_Fly()
  Cls()
  if JY.Status ~= GAME_MMAP then
    DrawStrBoxWaitKey("\206\222\183\168\212\218\179\161\190\176\196\218\202\185\211\195\163\161", C_WHITE, CC.StartMenuFontSize, 1)
    Cls()
    return 1
  end
  DrawStrBox(CC.MainSubMenuX2 + CC.StartMenuFontSize * 4 + CC.MenuBorderPixel * 3, CC.MainSubMenuY, "\199\235\209\161\212\241\210\170\200\165\181\196\181\216\183\189", C_WHITE, CC.StartMenuFontSize)
  local Address = {
    {
      1,
      23,
      53
    },
    {
      3,
      21,
      50
    },
    {
      40,
      26,
      43
    },
    {
      60,
      26,
      42
    },
    {
      61,
      23,
      49
    }
  }
  local menu = {}
  for i = 1, 5 do
    menu[i] = {
      JY.Scene[Address[i][1]]["\195\251\179\198"],
      nil,
      1
    }
  end
  local r = ShowMenu(menu, 5, 0, CC.MainSubMenuX2 + CC.StartMenuFontSize * 4 + CC.MenuBorderPixel * 3, CC.MainSubMenuY + CC.StartMenuFontSize * 2, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if 0 < r then
    lib.ShowSlow(50, 1)
    ChangeSMap(Address[r][1], Address[r][2], Address[r][3], 0)
    ChangeMMap(JY.Scene[JY.SubScene]["\205\226\190\176\200\235\191\218X1"], JY.Scene[JY.SubScene]["\205\226\190\176\200\235\191\218Y1"] + 1, 0)
    Cls()
    lib.ShowSlow(50, 0)
    Cls()
  elseif r == 0 then
    return 0
  end
  return 1
end

function Menu_Scene()
  Cls()
  if JY.Status ~= GAME_MMAP then
    DrawStrBoxWaitKey("\206\222\183\168\212\218\179\161\190\176\196\218\202\185\211\195\163\161", C_WHITE, CC.StartMenuFontSize, 1)
    Cls()
    return 1
  end
  local x = JY.Base.人X
  local y = JY.Base.人Y
  local x1 = x
  local y1 = y
  local menu = {}
  local menu1 = {}
  local menuxy = {}
  local oldscene = {}
  local scene
  local newscene = -1
  local scenenum = 1
  local snum = 16
  for i = 0, JY.SceneNum - 1 do
    if JY.Scene[i]["\189\248\200\235\204\245\188\254"] == 0 or JY.Scene[i]["\189\248\200\235\204\245\188\254"] == 2 then
      if JY.Scene[i]["\205\226\190\176\200\235\191\218X1"] ~= 0 or JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"] ~= 0 then
        menuxy[i] = {
          JY.Scene[i]["\195\251\179\198"],
          JY.Scene[i]["\205\226\190\176\200\235\191\218X1"],
          JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"]
        }
      elseif JY.Scene[i]["\205\226\190\176\200\235\191\218X2"] ~= 0 or JY.Scene[i]["\205\226\190\176\200\235\191\218Y2"] ~= 0 then
        menuxy[i] = {
          JY.Scene[i]["\195\251\179\198"],
          JY.Scene[i]["\205\226\190\176\200\235\191\218X2"],
          JY.Scene[i]["\205\226\190\176\200\235\191\218Y2"]
        }
      end
    end
  end
  for i = 0, 200 do
    for j = 0, JY.SceneNum - 1 do
      if menuxy[j] ~= nil and i >= math.abs(menuxy[j][2] - x) and i >= math.abs(menuxy[j][3] - y) then
        menu[scenenum] = {
          string.format("%-3d%-10s", j, menuxy[j][1]),
          nil,
          1
        }
        menu1[scenenum] = {
          menuxy[j][2],
          menuxy[j][3]
        }
        scenenum = scenenum + 1
        menuxy[j] = nil
      end
    end
  end
  local r = ShowMenu2_new(menu, scenenum, 4, 12, -1, -1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\199\235\209\161\212\241\184\189\189\252\179\161\190\176")
  if 0 < r then
    local x1 = menu1[r][1]
    local y1 = menu1[r][2]
    lib.ShowSlow(50, 1)
    local i = 1
    if lib.GetMMap(x1, y1 + i, 3) == 0 and lib.GetMMap(x1, y1 + i, 4) == 0 then
      JY.Base.人X = x1
      JY.Base.人Y = y1 + i
      JY.Base["\200\203\183\189\207\242"] = 0
    elseif lib.GetMMap(x1, y1 - i, 3) == 0 and lib.GetMMap(x1, y1 - i, 4) == 0 then
      JY.Base.人X = x1
      JY.Base.人Y = y1 - i
      JY.Base["\200\203\183\189\207\242"] = 3
    elseif lib.GetMMap(x1 + i, y1, 3) == 0 and lib.GetMMap(x1 + i, y1, 4) == 0 then
      JY.Base.人X = x1 + i
      JY.Base.人Y = y1
      JY.Base["\200\203\183\189\207\242"] = 2
    elseif lib.GetMMap(x1 - i, y1, 3) == 0 and lib.GetMMap(x1 - i, y1, 4) == 0 then
      JY.Base.人X = x1 - i
      JY.Base.人Y = y1
      JY.Base["\200\203\183\189\207\242"] = 1
    end
    Cls()
    lib.ShowSlow(50, 0)
    Cls()
    return 1
  elseif r == 0 then
    return 0
  end
end

function Menu_PBBZ()
  local menu = {}
  local maxnum = 0
  local perid = {}
  local newperid = {}
  for i = 1, CC.TeamNum - 1 do
    menu[i] = {}
    perid[i] = {}
    newperid[i] = {}
    if 0 > JY.Base["\182\211\206\233" .. i + 1] then
      break
    end
    menu[i][1] = JY.Person[JY.Base["\182\211\206\233" .. i + 1]].姓名
    menu[i][2] = nil
    menu[i][3] = 1
    perid[i] = JY.Base["\182\211\206\233" .. i + 1]
    maxnum = maxnum + 1
  end
  if maxnum == 0 then
    DrawStrBoxWaitKey("\214\187\202\163\207\194\196\227\210\187\184\246\200\203\193\203\163\161", C_WHITE, CC.StartMenuFontSize)
    Cls()
    return 1
  end
  local size = CC.StartMenuFontSize
  local h = CC.StartMenuFontSize + CC.RowPixel
  DrawStrBox(CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, CC.MainSubMenuY, "\199\235\214\216\208\194\178\188\213\243", C_WHITE, CC.StartMenuFontSize)
  local pb = 0
  while true do
    local r = ShowMenu(menu, maxnum, 0, CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, h * 2, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
    if 0 < r then
      pb = pb + 1
      newperid[pb] = perid[r]
      menu[r][3] = 0
      if maxnum <= pb then
        for i = 1, maxnum do
          JY.Base["\182\211\206\233" .. i + 1] = newperid[i]
        end
        break
      end
    elseif r == 0 then
      break
    end
  end
  Cls(CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
end

function Menu_WGCP()
  local size = CC.StartMenuFontSize
  local h = CC.StartMenuFontSize + CC.RowPixel
  local r = SelectTeamMenu(CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, CC.MainSubMenuY)
  if 0 < r then
    DrawStrBox(CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, CC.MainSubMenuY, "\199\235\214\216\197\197\206\228\185\166", C_WHITE, CC.StartMenuFontSize)
    local menu = {}
    local newwgid = {}
    local wgnum = 0
    local id = JY.Base["\182\211\206\233" .. r]
    for i = 1, 10 do
      menu[i] = {}
      newwgid[i] = {}
      if 0 < JY.Person[id]["\206\228\185\166" .. i] then
        local wgname = JY.Wugong[JY.Person[id]["\206\228\185\166" .. i]]["\195\251\179\198"]
        menu[i] = {
          wgname,
          nil,
          1,
          JY.Person[id]["\206\228\185\166" .. i],
          JY.Person[id]["\206\228\185\166\181\200\188\182" .. i]
        }
        wgnum = i
      else
        break
      end
    end
    local new = 0
    while true do
      if wgnum == 0 then
        DrawStrBoxWaitKey("\195\187\209\167\200\206\186\206\206\228\185\166\163\161", C_WHITE, CC.StartMenuFontSize)
        break
      end
      local rr = ShowMenu(menu, wgnum, 0, CC.MainSubMenuX2 + size * 4 + CC.RowPixel * 4, h * 2, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
      if 0 < rr then
        new = new + 1
        newwgid[new] = {
          menu[rr][4],
          menu[rr][5]
        }
        menu[rr][3] = 0
        if wgnum <= new then
          for i = 1, wgnum do
            JY.Person[id]["\206\228\185\166" .. i] = newwgid[i][1]
            JY.Person[id]["\206\228\185\166\181\200\188\182" .. i] = newwgid[i][2]
          end
          break
        end
      elseif rr == 0 then
        break
      end
    end
  end
  Cls(CC.MainSubMenuX2 + CC.RowPixel * 4, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
end

function Menu_Help()
  local title = "\207\181\205\179\185\165\194\212"
  local str = "\215\176\177\184\203\181\195\247\163\186\178\233\191\180\184\247\214\214\215\176\177\184\181\196\203\181\195\247\161\163" .. "*\206\228\185\166\203\181\195\247\163\186\178\233\191\180\184\247\214\214\206\228\185\166\181\196\203\181\195\247\161\163" .. "*\204\236\202\233\185\165\194\212\163\186\184\247\214\214\204\236\202\233\181\196\196\195\183\168\163\172\210\212\188\176\211\206\207\183\188\188\185\165\194\212\161\163"
  local btn = {
    "\215\176\177\184\203\181\195\247",
    "\206\228\185\166\203\181\195\247",
    "\204\236\202\233\185\165\194\212"
  }
  local num = #btn
  local r = JYMsgBox(title, str, btn, num, nil, 1)
  if r == 1 then
    ZBInstruce()
  elseif r == 2 then
    WuGongIntruce()
  elseif r == 3 then
    TSInstruce()
  end
  return 1
end

function Menu_CDSZ()
  Cls()
  local fontsize = CC.NewGameFontSize
  DrawString(CC.ScreenW / 2 - fontsize * 6, CC.ScreenH - fontsize * 2, string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\206\170%d\183\214\214\211", JY.SaveTime), C_GOLD, CC.NewGameFontSize, 1)
  ShowScreen()
  JY.SaveTime = InputNum("\215\212\182\175\180\230\181\181\188\228\184\244\163\168\183\214\214\211\163\169", 1, 120)
  JY.AtTime = lib.GetTime()
  JY.DiyTime = JY.AtTime + JY.SaveTime * 60000
  if CC.BanBen == 1 then
    CC.RUNSTR[CC.NUMBER] = string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\202\177\188\228\201\232\182\168\206\170%d\183\214\214\211 \191\201\212\218\161\176\185\166\196\220\188\211\199\191\161\177->\161\176\180\230\181\181\201\232\182\168\161\177\192\239\184\252\184\196", JY.SaveTime)
  else
    CC.RUNSTR[CC.NUMBER] = string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\202\177\188\228\201\232\182\168\206\170%d\183\214\214\211 \191\201\212\218\161\176\185\166\196\220\188\211\199\191\161\177->\161\176\180\230\181\181\201\232\182\168\161\177\192\239\184\252\184\196", JY.SaveTime)
  end
  Cls()
end

function Menu_CDQL()
  Cls()
  while true do
    DrawStrBox(CC.ScreenW / 2 - CC.DefaultFont * 3, CC.DefaultFont * 2, "\199\229\179\253\189\248\182\200\193\208\177\237", C_ORANGE, CC.DefaultFont)
    local r = SaveList()
    if r == 0 then
      break
    end
    if existFile(CC.S_Filename[r]) or existFile(CC.D_Filename[r]) then
      if DrawStrBoxYesNo(-1, -1, "\202\199\183\241\199\229\179\253\180\230\181\181\163\191", C_WHITE, CC.DefaultFont) then
        os.remove(CC.R_GRPFilename[r])
        os.remove(CC.S_Filename[r])
        os.remove(CC.D_Filename[r])
      end
      Cls()
    end
  end
end

function Menu_FKSet()
  local fksetnb = {}
  local fksetstr = {}
  for i = 1, 8 do
    fksetstr[i] = {}
  end
  if JY.XTKG == 1 then
    fksetnb[1] = 1
  else
    fksetnb[1] = 0
  end
  if JY.TXKG == 1 then
    fksetnb[2] = 1
  else
    fksetnb[2] = 0
  end
  if JY.JZKG == 1 then
    fksetnb[3] = 1
  else
    fksetnb[3] = 0
  end
  if JY.SCKG == 1 then
    fksetnb[4] = 1
  else
    fksetnb[4] = 0
  end
  if JY.DEADKG == 1 then
    fksetnb[5] = 1
  else
    fksetnb[5] = 0
  end
  local rr = 1
  while true do
    if fksetnb[1] == 0 then
      fksetstr[1][1] = "\185\216\177\213 \209\170\204\245\207\212\202\190"
    else
      fksetstr[1][1] = "\191\170\198\244 \209\170\204\245\207\212\202\190"
    end
    if fksetnb[2] == 0 then
      fksetstr[2][1] = "\185\216\177\213 \214\216\210\170\204\225\208\209"
    else
      fksetstr[2][1] = "\191\170\198\244 \214\216\210\170\204\225\208\209"
    end
    if fksetnb[3] == 0 then
      fksetstr[3][1] = "\185\216\177\213 \189\168\214\254\195\251\179\198"
    else
      fksetstr[3][1] = "\191\170\198\244 \189\168\214\254\195\251\179\198"
    end
    if fksetnb[4] == 0 then
      fksetstr[4][1] = "\185\216\177\213 \202\211\180\176\208\197\207\162"
    else
      fksetstr[4][1] = "\191\170\198\244 \202\211\180\176\208\197\207\162"
    end
    if fksetnb[5] == 0 then
      fksetstr[5][1] = "\185\216\177\213 \176\220\205\203\208\197\207\162"
    else
      fksetstr[5][1] = "\191\170\198\244 \176\220\205\203\208\197\207\162"
    end
    local menu = {
      {
        fksetstr[1][1],
        nil,
        1
      },
      {
        fksetstr[2][1],
        nil,
        1
      },
      {
        fksetstr[3][1],
        nil,
        1
      },
      {
        fksetstr[4][1],
        nil,
        1
      },
      {
        fksetstr[5][1],
        nil,
        1
      }
    }
    local r = ShowMenu2_new(menu, #menu, 2, 12, -1, -1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\183\192\191\168\201\232\214\195", rr)
    rr = r
    if r == 0 then
      break
    end
    if r == 1 then
      if fksetnb[1] == 1 then
        fksetnb[1] = 0
        JY.XTKG = 0
      else
        fksetnb[1] = 1
        JY.XTKG = 1
      end
    elseif r == 2 then
      if fksetnb[2] == 1 then
        fksetnb[2] = 0
        JY.TXKG = 0
      else
        fksetnb[2] = 1
        JY.TXKG = 1
      end
    elseif r == 3 then
      if fksetnb[3] == 1 then
        fksetnb[3] = 0
        JY.JZKG = 0
      else
        fksetnb[3] = 1
        JY.JZKG = 1
      end
    elseif r == 4 then
      if fksetnb[4] == 1 then
        fksetnb[4] = 0
        JY.SCKG = 0
      else
        fksetnb[4] = 1
        JY.SCKG = 1
      end
    elseif r == 5 then
      if fksetnb[5] == 1 then
        fksetnb[5] = 0
        JY.DEADKG = 0
      else
        fksetnb[5] = 1
        JY.DEADKG = 1
      end
    end
  end
end

function Show_Position()
  if JY.Status ~= GAME_MMAP then
    return 0
  end
  DrawStrBoxWaitKey(string.format("\181\177\199\176\206\187\214\195(%d,%d)", JY.Base.人X, JY.Base.人Y), C_ORANGE, CC.StartMenuFontSize)
  DrawStrBoxWaitKey(string.format("\196\227\207\214\212\218\181\196\198\183\181\194\214\184\202\253\206\170: %d", JY.Person[0]["\198\183\181\194"]), C_ORANGE, CC.StartMenuFontSize)
  DrawStrBoxWaitKey(string.format("\196\227\207\214\212\218\181\196\201\249\205\251\214\184\202\253\206\170: %d", JY.Person[0].声望), C_ORANGE, CC.StartMenuFontSize)
  return 1
end

function Menu_Status()
  local flag = 1
  local teamnum = GetTeamNum()
  local x = CC.MainMenuX
  local y = CC.MainMenuY
  local size = CC.DefaultFont
  local teamid = 1
  local menu = {}
  if JY.Status == GAME_WMAP then
    teamnum = 0
    for i = 0, WAR.PersonNum - 1 do
      if WAR.Person[i]["\206\210\183\189"] == true and WAR.Person[i].死亡 == false then
        local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
        teamnum = teamnum + 1
        menu[teamnum] = {
          string.format("%-8s %2d\188\182 %4d/%d", JY.Person[id].姓名, JY.Person[id]["\181\200\188\182"], JY.Person[id].生命, JY.Person[id]["\201\250\195\252\215\238\180\243\214\181"]),
          nil,
          1,
          id
        }
      end
    end
  else
    for i = 1, CC.TeamNum do
      local id = JY.Base["\182\211\206\233" .. i]
      if id < 0 then
        break
      end
      menu[i] = {
        string.format("%-8s %2d\188\182 %4d/%d", JY.Person[id].姓名, JY.Person[id]["\181\200\188\182"], JY.Person[id].生命, JY.Person[id]["\201\250\195\252\215\238\180\243\214\181"]),
        nil,
        1,
        id
      }
    end
  end
  local size = CC.DefaultFont
  local menux = size * 3
  local menuy = CC.ScreenH / 2 - #menu * size / 2
  local r1 = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, size, C_GOLD, C_WHITE)
  if r1 == 0 then
    return
  end
  teamid = r1
  while true do
    local id
    if JY.Status == GAME_WMAP then
      id = menu[teamid][4]
    else
      id = JY.Base["\182\211\206\233" .. teamid]
    end
    Cls()
    ShowPersonStatus_sub(id, flag)
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
    if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
      if keypress == VK_ESCAPE or ktype == 4 then
        Cls()
        break
      elseif keypress == VK_UP then
        teamid = teamid - 1
      elseif keypress == VK_DOWN then
        teamid = teamid + 1
      elseif keypress == VK_LEFT then
        teamid = teamid - 1
      elseif keypress == VK_RIGHT or ktype == 3 then
        teamid = teamid + 1
      end
      if teamnum < teamid then
        teamid = 1
      end
      if teamid < 1 then
        teamid = teamnum
      end
    end
  end
end

function Menu_EmyStatus()
  local teamid = 1
  local teamnum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i]["\206\210\183\189"] == false then
      teamnum = teamnum + 1
    end
  end
  local emenu = {}
  local teamnum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i]["\206\210\183\189"] == false and WAR.Person[i].死亡 == false then
      local eid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      teamnum = teamnum + 1
      emenu[teamnum] = {
        string.format("%-8s %2d\188\182 %4d/%d", JY.Person[eid].姓名, JY.Person[eid]["\181\200\188\182"], JY.Person[eid].生命, JY.Person[eid]["\201\250\195\252\215\238\180\243\214\181"]),
        nil,
        1,
        eid
      }
    end
  end
  local size = CC.DefaultFont
  local menux = size * 3
  local menuy = CC.ScreenH / 2 - #emenu * size / 2
  local r1 = ShowMenu(emenu, #emenu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, size, C_GOLD, C_WHITE)
  if r1 == 0 then
    return
  end
  teamid = r1
  while true do
    Cls()
    ShowPersonStatus_sub(emenu[teamid][4], 2)
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
    if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
      if keypress == VK_ESCAPE or ktype == 4 then
        Cls()
        break
      elseif keypress == VK_UP then
        teamid = teamid - 1
      elseif keypress == VK_DOWN then
        teamid = teamid + 1
      elseif keypress == VK_LEFT then
        teamid = teamid - 1
      elseif keypress == VK_RIGHT or ktype == 3 then
        teamid = teamid + 1
      end
      if teamnum < teamid then
        teamid = 1
      end
      if teamid < 1 then
        teamid = teamnum
      end
    end
  end
end

function Menu_PersonExit()
  DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "\210\170\199\243\203\173\192\235\182\211", C_WHITE, CC.StartMenuFontSize)
  local nexty = CC.MainSubMenuY + CC.SingleLineHeight
  local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
  if r == 1 then
    DrawStrBoxWaitKey("\177\167\199\184\163\161\195\187\211\208\196\227\211\206\207\183\189\248\208\208\178\187\207\194\200\165", C_WHITE, CC.StartMenuFontSize, 1)
    Cls()
  elseif 1 < r then
    local personid = JY.Base["\182\211\206\233" .. r]
    for i, v in ipairs(CC.PersonExit) do
      if personid == v[1] then
        oldCallEvent(v[2])
      end
    end
  end
  return 0
end

function SelectTeamMenu(x, y)
  local menu = {}
  for i = 1, CC.TeamNum do
    menu[i] = {
      "",
      nil,
      0
    }
    local id = JY.Base["\182\211\206\233" .. i]
    if 0 <= id then
      if 0 <= JY.Person[id].生命 then
        menu[i][1] = JY.Person[id].姓名
        menu[i][3] = 1
      end
      if JY.Status == GAME_WMAP and 0 >= JY.Person[id].生命 then
        menu[i][3] = 0
      end
    end
  end
  if JY.Status == GAME_WMAP then
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
  else
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  end
end

function GetTeamNum()
  local r = CC.TeamNum
  for i = 1, CC.TeamNum do
    if JY.Base["\182\211\206\233" .. i] < 0 then
      r = i - 1
      break
    end
  end
  return r
end

function ShowPersonStatus(teamid)
  local flag = 1
  local teamnum = GetTeamNum()
  if JY.Status == GAME_WMAP then
    teamnum = 0
    flag = 2
    for i = 0, WAR.PersonNum - 1 do
      if WAR.Person[i]["\206\210\183\189"] == true and WAR.Person[i].死亡 == false then
        teamnum = teamnum + 1
        wid[teamnum] = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      end
    end
  end
  while true do
    Cls()
    local id
    if JY.Status == GAME_WMAP then
      id = wid[teamid]
    else
      id = JY.Base["\182\211\206\233" .. teamid]
    end
    ShowPersonStatus_sub(id, flag)
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
    if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
      if keypress == VK_ESCAPE or ktype == 4 then
        break
      end
      if keypress == VK_UP then
        teamid = teamid - 1
      elseif keypress == VK_DOWN then
        teamid = teamid + 1
      elseif keypress == VK_LEFT then
        teamid = teamid - 1
      elseif keypress == VK_RIGHT then
        teamid = teamid + 1
      end
      teamid = limitX(teamid, 1, teamnum)
    end
  end
end

function ShowEmyPersonStatus(eid)
  local flag = 2
  local teamnum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i]["\206\210\183\189"] == false then
      teamnum = teamnum + 1
    end
  end
  while true do
    Cls()
    ShowPersonStatus_sub(eid, flag)
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
    if keypress ~= -1 or ktype ~= nil and ktype ~= -1 then
      if keypress == VK_ESCAPE or ktype == 4 then
        break
      end
      if keypress == VK_UP then
        teamid = teamid - 1
      elseif keypress == VK_DOWN then
        teamid = teamid + 1
      elseif keypress == VK_LEFT then
        teamid = teamid - 1
      elseif keypress == VK_RIGHT then
        teamid = teamid + 1
      end
      teamid = limitX(teamid, 1, teamnum)
    end
  end
end

function ShowPersonStatus_sub(id, flag)
  if flag == nil then
    flag = 1
  end
  local size = CC.DefaultFont
  local p = JY.Person[id]
  local width = 18 * size + 15
  local h = size + CC.PersonStateRowPixel
  local height = 13 * h + 10
  local dx = CC.ScreenW
  local dy = CC.ScreenH
  local headmax = 40 * CC.Zoom
  local i = 0
  local x1, y1, x2
  DrawBox(0, 0, CC.ScreenW, math.modf(h * 1.5), C_WHITE)
  DrawBox(0, math.modf(h * 1.5) + CC.PersonStateRowPixel, CC.ScreenW, h * 17, C_WHITE)
  x1 = CC.PersonStateRowPixel * 2
  y1 = CC.PersonStateRowPixel * 2
  local strll = 0
  if flag == 1 then
    local teamnum = GetTeamNum()
    if JY.Status == GAME_WMAP then
      for j = 0, WAR.PersonNum - 1 do
        if WAR.Person[j]["\206\210\183\189"] == true and WAR.Person[j].死亡 == false then
          local id1 = WAR.Person[j]["\200\203\206\239\177\224\186\197"]
          local name = JY.Person[id1].姓名
          if id == id1 then
            DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_WHITE, size)
          else
            DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_GOLD, size)
          end
          strll = strll + #name + 2
        end
      end
    else
      for j = 1, teamnum do
        local id1 = JY.Base["\182\211\206\233" .. j]
        local name = JY.Person[id1].姓名
        if id == id1 then
          DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_WHITE, size)
        else
          DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_GOLD, size)
        end
        strll = strll + #name + 2
      end
    end
  elseif flag == 2 then
    for j = 0, WAR.PersonNum - 1 do
      if WAR.Person[j]["\206\210\183\189"] == false and WAR.Person[j].死亡 == false then
        local id1 = WAR.Person[j]["\200\203\206\239\177\224\186\197"]
        local name = JY.Person[id1].姓名
        if id == id1 then
          DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_WHITE, size)
        else
          DrawString(x1 + size * strll / 2, y1 + h * i, string.format("%s", name), C_GOLD, size)
        end
        strll = strll + #name + 2
      end
    end
  end
  i = i + 2
  y1 = CC.PersonStateRowPixel * 2 + math.modf(h * 1.5)
  local y0 = math.modf(h * 1.5)
  if JY.Person[0].姓名 == "szlzw" then
    if existFile(CC.HeadPath .. CC.JSHead .. ".png") then
      JY.Person[0]["\205\183\207\241\180\250\186\197"] = CC.JSHead
    else
      JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
    end
  end
  if existFile(CC.HeadPath .. p["\205\183\207\241\180\250\186\197"] .. ".png") then
    local hid = p["\205\183\207\241\180\250\186\197"]
    local headw, headh = lib.GetPNGXY(1, hid * 2)
    local headx = CC.PersonStateRowPixel * 2 + size * 1.5
    local heady = CC.PersonStateRowPixel * 2 + size
    local hdmax = 0
    if headw > hdmax then
      hdmax = headw
    end
    if headh > hdmax then
      hdmax = headh
    end
    local zoom = math.modf(140 / hdmax * 100 * (CONFIG.Zoom / 100) * CC.Zoom / 2)
    lib.LoadPicture(CC.HeadPath .. p["\205\183\207\241\180\250\186\197"] .. ".png", x1 + headx, y0 + heady, zoom)
    JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
  else
    local headw, headh = lib.PicGetXY(1, p["\205\183\207\241\180\250\186\197"] * 2)
    local headx = ((11 * size - headw) / 2 + CC.PersonStateRowPixel) / (CONFIG.Zoom / 100)
    local heady = ((7 * h - headh) / 2 + CC.PersonStateRowPixel) / (CONFIG.Zoom / 100)
    lib.PicLoadCache(1, p["\205\183\207\241\180\250\186\197"] * 2, x1 + headx, y0 + heady, 1)
  end
  DrawString(x1 + size * 2, y1 + h * 5, p.姓名, C_WHITE, size)
  DrawString(x1, y1 + h * 6, string.format("%s", p.外号), C_GOLD, size)
  DrawString(x1 + 10 * size / 2, y1 + h * 6, string.format("%3d", p["\181\200\188\182"]), C_GOLD, size)
  DrawString(x1 + 13 * size / 2, y1 + h * 6, "\188\182", C_ORANGE, size)
  if p["\208\212\177\240"] == 0 then
    DrawString(x1 + 6.5 * size, y1 + h * 5, "\196\208", C_GOLD, size)
  elseif p["\208\212\177\240"] == 1 then
    DrawString(x1 + 6.5 * size, y1 + h * 5, "\197\174", C_GOLD, size)
  elseif p["\208\212\177\240"] == 2 then
    DrawString(x1 + 6.5 * size - size, y1 + h * 5, "\215\212\185\172", C_RED, size)
  end
  i = 6
  x2 = 4 * size
  
  local function DrawAttrib(str, color1, color2, v)
    v = v or 0
    DrawString(x1, y1 + h * i, str, color1, size)
    DrawString(x1 + x2, y1 + h * i, string.format("%10d", p[str] + v), color2, size)
    i = i + 1
  end
  
  local function DrawAttrib1(str, color1, color2, v)
    v = v or 0
    DrawString(x1, y1 + h * i, str, color1, size)
    if 0 < v then
      DrawString(x1 + x2, y1 + h * i, string.format(" +%2d", v), C_ORANGE, size)
      DrawString(x1 + x2, y1 + h * i, string.format("     \161\252%3d", p[str] + v), C_ORANGE, size)
    elseif v < 0 then
      DrawString(x1 + x2, y1 + h * i, string.format(" %2d", v), C_RED, size)
      DrawString(x1 + x2, y1 + h * i, string.format("     \161\253%3d", p[str] + v), C_RED, size)
    else
      DrawString(x1 + x2, y1 + h * i, string.format("       %3d", p[str] + v), color2, size)
    end
    i = i + 1
  end
  
  local function DrawAttrib2(str, color1, color2, v)
    v = v or 0
    DrawString(x1, y1 + h * i, str, color1, size)
    DrawString(x1 + x2 + size, y1 + h * i, string.format("%5d", p[str] + v), color2, size)
    i = i + 1
  end
  
  local color
  if p["\202\220\201\203\179\204\182\200"] < 33 then
    color = RGB(236, 200, 40)
  elseif p["\202\220\201\203\179\204\182\200"] < 66 then
    color = RGB(255, 192, 203)
  else
    color = RGB(232, 32, 44)
  end
  i = i + 1
  DrawString(x1, y1 + h * i, "\201\250\195\252", C_ORANGE, size)
  DrawString(x1 + 2 * size, y1 + h * i, string.format("%5d", p.生命), color, size)
  DrawString(x1 + 9 * size / 2, y1 + h * i, "/", C_GOLD, size)
  if p["\214\208\182\190\179\204\182\200"] == 0 then
    color = C_GOLD
  elseif p["\214\208\182\190\179\204\182\200"] < 50 then
    color = RGB(120, 208, 88)
  else
    color = RGB(56, 136, 36)
  end
  DrawString(x1 + 5 * size, y1 + h * i, string.format("%5s", p["\201\250\195\252\215\238\180\243\214\181"]), color, size)
  i = i + 1
  if p["\196\218\193\166\208\212\214\202"] == 0 then
    color = RGB(208, 152, 208)
  elseif p["\196\218\193\166\208\212\214\202"] == 1 then
    color = RGB(236, 200, 40)
  else
    color = RGB(236, 236, 236)
  end
  DrawString(x1, y1 + h * i, "\196\218\193\166", C_ORANGE, size)
  DrawString(x1 + 2 * size, y1 + h * i, string.format("%5d/%5d", p["\196\218\193\166"], p["\196\218\193\166\215\238\180\243\214\181"]), color, size)
  i = i + 1
  DrawAttrib2("\204\229\193\166", C_ORANGE, C_GOLD)
  DrawAttrib2("\190\173\209\233", C_ORANGE, C_GOLD)
  local tmp
  if p["\181\200\188\182"] >= CC.Level then
    tmp = "  ="
  else
    tmp = string.format("%5d", CC.Exp[p["\181\200\188\182"]])
  end
  DrawString(x1, y1 + h * i, "\201\253\188\182", C_ORANGE, size)
  DrawString(x1 + x2 + size, y1 + h * i, tmp, C_GOLD, size)
  local tmp1, tmp2, tmp3 = 0, 0, 0
  if p["\206\228\198\247"] > -1 then
    tmp1 = tmp1 + JY.Thing[p["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
    tmp2 = tmp2 + JY.Thing[p["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
    tmp3 = tmp3 + JY.Thing[p["\206\228\198\247"]]["\188\211\199\225\185\166"]
  end
  if -1 < p["\183\192\190\223"] then
    tmp1 = tmp1 + JY.Thing[p["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
    tmp2 = tmp2 + JY.Thing[p["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
    tmp3 = tmp3 + JY.Thing[p["\183\192\190\223"]]["\188\211\199\225\185\166"]
  end
  i = i + 1
  DrawString(x1, y1 + h * i, string.format("\182\190\163\186%3d", p["\214\208\182\190\179\204\182\200"]), RGB(120, 208, 88), size)
  DrawString(x1 + size * 4, y1 + h * i, string.format("\201\203\163\186%3d", p["\202\220\201\203\179\204\182\200"]), RGB(255, 192, 203), size)
  i = i + 1
  DrawString(x1, y1 + h * i, string.format("\191\185\163\186%3d", p["\191\185\182\190\196\220\193\166"]), RGB(120, 208, 88), size)
  DrawString(x1 + size * 4, y1 + h * i, "\178\171\163\186", C_GOLD, size)
  if p["\215\243\211\210\187\165\178\171"] == 1 then
    DrawString(x1 + size * 6.5, y1 + h * i, "\161\242", C_RED, size)
  else
    DrawString(x1 + size * 6.5, y1 + h * i, "\161\193", C_GOLD, size)
  end
  i = 0
  x1 = x1 + size * 17 / 2
  DrawAttrib1("\185\165\187\247\193\166", C_WHITE, C_GOLD, tmp1)
  DrawAttrib1("\183\192\211\249\193\166", C_WHITE, C_GOLD, tmp2)
  DrawAttrib1("\199\225\185\166", C_WHITE, C_GOLD, tmp3)
  DrawAttrib("\210\189\193\198\196\220\193\166", C_WHITE, C_GOLD)
  DrawAttrib("\211\195\182\190\196\220\193\166", C_WHITE, C_GOLD)
  DrawAttrib("\189\226\182\190\196\220\193\166", C_WHITE, C_GOLD)
  DrawAttrib("\200\173\213\198\185\166\183\242", C_WHITE, C_GOLD)
  DrawAttrib("\211\249\189\163\196\220\193\166", C_WHITE, C_GOLD)
  DrawAttrib("\203\163\181\182\188\188\199\201", C_WHITE, C_GOLD)
  DrawAttrib("\204\216\202\226\177\248\198\247", C_WHITE, C_GOLD)
  DrawAttrib("\176\181\198\247\188\188\199\201", C_WHITE, C_GOLD)
  DrawAttrib("\215\202\214\202", C_WHITE, C_GOLD)
  local zzdc, zzstr
  zzdc = math.modf(p["\215\202\214\202"] / 15)
  if zzdc == 6 then
    zzstr = "\210\187\181\181"
  elseif zzdc == 5 then
    zzstr = "\182\254\181\181"
  elseif zzdc == 4 then
    zzstr = "\200\253\181\181"
  elseif zzdc == 3 then
    zzstr = "\203\196\181\181"
  elseif zzdc == 2 then
    zzstr = "\206\229\181\181"
  elseif zzdc == 1 then
    zzstr = "\193\249\181\181"
  else
    zzstr = "\198\223\181\181"
  end
  DrawString(x1 + size * 5, y1 + h * (i - 1), zzstr, RGB(255, (7 - zzdc) * 30, (7 - zzdc) * 30), size)
  DrawString(x1, y1 + h * i, "\206\228\198\247:", C_ORANGE, size)
  if p["\206\228\198\247"] > -1 then
    DrawString(x1 + size * 3, y1 + h * i, JY.Thing[p["\206\228\198\247"]]["\195\251\179\198"], C_GOLD, size)
  end
  i = i + 1
  DrawString(x1, y1 + h * i, "\183\192\190\223:", C_ORANGE, size)
  if -1 < p["\183\192\190\223"] then
    DrawString(x1 + size * 3, y1 + h * i, JY.Thing[p["\183\192\190\223"]]["\195\251\179\198"], C_GOLD, size)
  end
  i = 0
  x1 = x1 + size * 10
  DrawString(x1, y1 + h * i, "\203\249\187\225\206\228\185\166   \188\182  \192\224  \196\218 \205\254\193\166", C_ORANGE, size)
  for j = 1, 10 do
    i = i + 1
    local wugong = p["\206\228\185\166" .. j]
    if 0 < wugong then
      local level = math.modf(p["\206\228\185\166\181\200\188\182" .. j] / 100) + 1
      local wgsh = 0
      local gjfw = 0
      local gjstr = ""
      local wgshlx = JY.Wugong[wugong]["\201\203\186\166\192\224\208\205"]
      local snl = 0
      local nlxh = JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"] * math.modf((level + 1) / 2)
      wgsh = JY.Wugong[wugong]["\185\165\187\247\193\166" .. level]
      gjfw = JY.Wugong[wugong]["\185\165\187\247\183\182\206\167"]
      if wgshlx == 1 then
        snl = JY.Wugong[wugong]["\201\177\196\218\193\166" .. level]
      end
      if gjfw == 0 then
        gjstr = "\161\241"
      elseif gjfw == 1 then
        gjstr = "\169\165"
      elseif gjfw == 2 then
        gjstr = "\169\239"
      elseif gjfw == 3 then
        gjstr = "\161\246"
      end
      DrawString(x1, y1 + h * i, string.format("%s", JY.Wugong[wugong]["\195\251\179\198"]), C_GOLD, size)
      DrawString(x1 + size * 11 / 2, y1 + h * i, string.format("%2d", level), C_WHITE, size)
      if wgshlx == 0 then
        DrawString(x1 + size * 7, y1 + h * i, string.format("%3s", gjstr), C_WHITE, size)
        DrawString(x1 + size * 11, y1 + h * i, string.format("%4d", wgsh), C_RED, size)
      elseif wgshlx == 1 then
        gjstr = "\161\241"
        DrawString(x1 + size * 7, y1 + h * i, string.format("%3s", gjstr), C_WHITE, size)
        DrawString(x1 + size * 11, y1 + h * i, string.format("%4d", snl), RGB(208, 152, 208), size)
      end
      DrawString(x1 + size * 9, y1 + h * i, string.format("%3d", nlxh), RGB(208, 152, 208), size)
    end
  end
  i = i + 1
  DrawString(x1, y1 + h * i, "\208\222\193\182\206\239\198\183", C_ORANGE, size)
  DrawString(x1 + size * 7, y1 + h * i, "\201\250\195\252\212\246\179\164" .. string.format("%4d", p["\201\250\195\252\212\246\179\164"]), C_ORANGE, size)
  DrawString(x1 + size * 7, y1 + h * (i + 1), "\206\228\209\167\179\163\202\182" .. string.format("%4d", p["\206\228\209\167\179\163\202\182"]), C_ORANGE, size)
  DrawString(x1 + size * 7, y1 + h * (i + 2), "\206\228\185\166\180\248\182\190" .. string.format("%4d", p["\185\165\187\247\180\248\182\190"]), M_Green, size)
  local thingid = p["\208\222\193\182\206\239\198\183"]
  if 0 < thingid then
    i = i + 1
    DrawString(x1 + size, y1 + h * i, JY.Thing[thingid]["\195\251\179\198"], C_GOLD, size)
    i = i + 1
    local n = TrainNeedExp(id)
    if n < math.huge then
      DrawString(x1 + size, y1 + h * i, string.format("%5d/%5d", p["\208\222\193\182\181\227\202\253"], n), C_GOLD, size)
    else
      DrawString(x1 + size, y1 + h * i, string.format("%5d/===", p["\208\222\193\182\181\227\202\253"]), C_GOLD, size)
    end
  else
    i = i + 2
  end
end

function TrainNeedExp(id)
  local thingid = JY.Person[id]["\208\222\193\182\206\239\198\183"]
  local r = 0
  if 0 <= thingid then
    if 0 <= JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
      local level = 0
      for i = 1, 10 do
        if JY.Person[id]["\206\228\185\166" .. i] == JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
          level = math.modf(JY.Person[id]["\206\228\185\166\181\200\188\182" .. i] / 100)
          break
        end
      end
      if level < 9 then
        r = (7 - math.modf(JY.Person[id]["\215\202\214\202"] / 15)) * JY.Thing[thingid]["\208\232\190\173\209\233"] * (level + 1)
      else
        r = math.huge
      end
    else
      r = (7 - math.modf(JY.Person[id]["\215\202\214\202"] / 15)) * JY.Thing[thingid]["\208\232\190\173\209\233"] * 2
    end
  end
  return r
end

function Menu_Doctor()
  DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "\203\173\210\170\202\185\211\195\210\189\202\245", C_WHITE, CC.StartMenuFontSize)
  local nexty = CC.MainSubMenuY + CC.SingleLineHeight
  DrawStrBox(CC.MainSubMenuX, nexty, "\210\189\193\198\196\220\193\166", C_ORANGE, CC.StartMenuFontSize)
  local menu1 = {}
  for i = 1, CC.TeamNum do
    menu1[i] = {
      "",
      nil,
      0
    }
    local id = JY.Base["\182\211\206\233" .. i]
    if 0 <= id and JY.Person[id]["\210\189\193\198\196\220\193\166"] >= 20 then
      menu1[i][1] = string.format("%-10s%4d  \204\229\193\166\163\186%3d", JY.Person[id].姓名, JY.Person[id]["\210\189\193\198\196\220\193\166"], JY.Person[id]["\204\229\193\166"])
      menu1[i][3] = 1
    end
  end
  local id1, id2
  nexty = nexty + CC.SingleLineHeight
  local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if 0 < r then
    id1 = JY.Base["\182\211\206\233" .. r]
    Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "\210\170\210\189\214\206\203\173", C_WHITE, CC.StartMenuFontSize)
    nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local menu2 = {}
    for i = 1, CC.TeamNum do
      menu2[i] = {
        "",
        nil,
        0
      }
      local id = JY.Base["\182\211\206\233" .. i]
      if 0 <= id then
        menu2[i][1] = string.format("%-10s %3d %4d/%4d", JY.Person[id].姓名, JY.Person[id]["\202\220\201\203\179\204\182\200"], JY.Person[id].生命, JY.Person[id]["\201\250\195\252\215\238\180\243\214\181"])
        menu2[i][3] = 1
      end
    end
    local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
    if 0 < r2 then
      id2 = JY.Base["\182\211\206\233" .. r2]
      local shoushang = JY.Person[id2]["\202\220\201\203\179\204\182\200"]
      local num = ExecDoctor(id1, id2)
      if 0 < num or shoushang > JY.Person[id2]["\202\220\201\203\179\204\182\200"] then
        AddPersonAttrib(id1, "\204\229\193\166", -2)
      end
      DrawStrBoxWaitKey(string.format("%s \202\220\201\203\179\204\182\200\188\245\201\217 %d \201\250\195\252\212\246\188\211 %d", JY.Person[id2].姓名, shoushang - JY.Person[id2]["\202\220\201\203\179\204\182\200"], num), C_ORANGE, CC.StartMenuFontSize)
    end
  end
  Cls()
  return 0
end

function ExecDoctor(id1, id2)
  if JY.Person[id1]["\204\229\193\166"] < 50 then
    return 0
  end
  local add = JY.Person[id1]["\210\189\193\198\196\220\193\166"]
  local value = JY.Person[id2]["\202\220\201\203\179\204\182\200"]
  if value > add / (CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] / 100) * 2 then
    return 0
  end
  if value < 25 then
    add = add * 4 / 5
  elseif value < 50 then
    add = add * 3 / 4
  elseif value < 75 then
    add = add * 2 / 3
  else
    add = add / 2
  end
  local ylsx = math.modf(CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)
  if 5 < ylsx then
    ylsx = 5
  end
  AddPersonAttrib(id2, "\202\220\201\203\179\204\182\200", math.modf(-add / ylsx))
  return AddPersonAttrib(id2, "\201\250\195\252", add * ylsx)
end

function Menu_DecPoison()
  DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "\203\173\210\170\176\239\200\203\189\226\182\190", C_WHITE, CC.StartMenuFontSize)
  local nexty = CC.MainSubMenuY + CC.SingleLineHeight
  DrawStrBox(CC.MainSubMenuX, nexty, "\189\226\182\190\196\220\193\166", C_ORANGE, CC.StartMenuFontSize)
  local menu1 = {}
  for i = 1, CC.TeamNum do
    menu1[i] = {
      "",
      nil,
      0
    }
    local id = JY.Base["\182\211\206\233" .. i]
    if 0 <= id and JY.Person[id]["\189\226\182\190\196\220\193\166"] >= 20 then
      menu1[i][1] = string.format("%-10s%4d  \204\229\193\166\163\186%3d", JY.Person[id].姓名, JY.Person[id]["\189\226\182\190\196\220\193\166"], JY.Person[id]["\204\229\193\166"])
      menu1[i][3] = 1
    end
  end
  local id1, id2
  nexty = nexty + CC.SingleLineHeight
  local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if 0 < r then
    id1 = JY.Base["\182\211\206\233" .. r]
    Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "\204\230\203\173\189\226\182\190", C_WHITE, CC.StartMenuFontSize)
    nexty = CC.MainSubMenuY + CC.SingleLineHeight
    DrawStrBox(CC.MainSubMenuX, nexty, "\214\208\182\190\179\204\182\200", C_WHITE, CC.StartMenuFontSize)
    nexty = nexty + CC.SingleLineHeight
    local menu2 = {}
    for i = 1, CC.TeamNum do
      menu2[i] = {
        "",
        nil,
        0
      }
      local id = JY.Base["\182\211\206\233" .. i]
      if 0 <= id then
        menu2[i][1] = string.format("%-10s%5d", JY.Person[id].姓名, JY.Person[id]["\214\208\182\190\179\204\182\200"])
        menu2[i][3] = 1
      end
    end
    local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
    if 0 < r2 then
      id2 = JY.Base["\182\211\206\233" .. r2]
      local num = ExecDecPoison(id1, id2)
      DrawStrBoxWaitKey(string.format("%s \214\208\182\190\179\204\182\200\188\245\201\217 %d", JY.Person[id2].姓名, num), C_ORANGE, CC.StartMenuFontSize)
    end
  end
  Cls()
  return 0
end

function ExecDecPoison(id1, id2)
  local add = JY.Person[id1]["\189\226\182\190\196\220\193\166"]
  local value = JY.Person[id2]["\214\208\182\190\179\204\182\200"]
  if value > math.modf(add / (CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] / 100)) * 2 then
    return 0
  end
  add = limitX(math.modf(add / (CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] / 100) / 3) + Rnd(10) - Rnd(10), 0, value)
  return -AddPersonAttrib(id2, "\214\208\182\190\179\204\182\200", -add)
end

function Menu_Thing()
  local menu = {
    {
      "\200\171\178\191\206\239\198\183",
      nil,
      1
    },
    {
      "\190\231\199\233\206\239\198\183",
      nil,
      1
    },
    {
      "\201\241\177\248\177\166\188\215",
      nil,
      1
    },
    {
      "\206\228\185\166\195\216\243\197",
      nil,
      1
    },
    {
      "\193\233\181\164\195\238\210\169",
      nil,
      1
    },
    {
      "\201\203\200\203\176\181\198\247",
      nil,
      1
    },
    {
      "\213\251\192\237\206\239\198\183",
      nil,
      1
    }
  }
  local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.StartMenuFontSize, C_ORANGE, C_WHITE)
  if r == 7 then
    local newthing = {}
    local i, j
    local thnum = 0
    for i = 0, CC.MyThingNum - 1 do
      if 0 > JY.Base["\206\239\198\183" .. i + 1] then
        thnum = i
        break
      end
    end
    local newnum = 0
    for i = 0, CC.MyThingNum do
      newthing[i] = {}
      for j = 0, CC.MyThingNum do
        if 0 > JY.Base["\206\239\198\183" .. j + 1] then
          break
        end
        if JY.Base["\206\239\198\183" .. j + 1] == i then
          newthing[newnum][1] = JY.Base["\206\239\198\183" .. j + 1]
          newthing[newnum][2] = JY.Base["\206\239\198\183\202\253\193\191" .. j + 1]
          newnum = newnum + 1
          break
        end
      end
      if newnum == thnum then
        break
      end
    end
    for newnum = 0, thnum - 1 do
      JY.Base["\206\239\198\183" .. newnum + 1] = newthing[newnum][1]
      JY.Base["\206\239\198\183\202\253\193\191" .. newnum + 1] = newthing[newnum][2]
    end
    DrawStrBoxWaitKey("\206\239\198\183\213\251\192\237\205\234\177\207", C_WHITE, CC.StartMenuFontSize)
    ShowScreen()
    Cls()
    return 0
  end
  local oldr = r
  if 0 < oldr then
    while true do
      local thing = {}
      local thingnum = {}
      for i = 0, CC.MyThingNum - 1 do
        thing[i] = -1
        thingnum[i] = 0
      end
      local num = 0
      for i = 0, CC.MyThingNum - 1 do
        local id = JY.Base["\206\239\198\183" .. i + 1]
        if 0 <= id then
          if r == 1 then
            thing[i] = id
            thingnum[i] = JY.Base["\206\239\198\183\202\253\193\191" .. i + 1]
          elseif JY.Thing[id].类型 == r - 2 then
            thing[num] = id
            thingnum[num] = JY.Base["\206\239\198\183\202\253\193\191" .. i + 1]
            num = num + 1
          end
        end
      end
      if 0 < oldr then
        local r = SelectThing(thing, thingnum)
        if r == -1 then
          break
        end
        if 0 <= r then
          UseThing(r)
          if JY.Thing[r].类型 == 0 or JY.Thing[r].类型 == 4 then
            return 1
          end
        end
      end
    end
  end
  return 0
end

function SelectThing(thing, thingnum)
  local xnum = CC.MenuThingXnum
  local ynum = CC.MenuThingYnum
  local w = CC.ThingPicWidth * xnum + (xnum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut
  local h = CC.ThingPicHeight * ynum + (ynum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut
  local dx = (CC.ScreenW - w) / 2
  local dy = (CC.ScreenH - h - 2 * (CC.ThingFontSize + 2 * CC.MenuBorderPixel + 8)) / 2 - CC.ThingFontSize * 2
  local y1_1, y1_2, y2_1, y2_2, y3_1, y3_2
  local cur_line = oldcur_line
  local cur_x = oldcur_x
  local cur_y = oldcur_y
  local cur_thing = -1
  local thnum = 0
  for i = 0, CC.MyThingNum - 1 do
    if 0 > JY.Base["\206\239\198\183" .. i + 1] then
      thnum = i
      break
    end
  end
  while true do
    Cls()
    y1_1 = dy
    y1_2 = y1_1 + CC.ThingFontSize + 2 * CC.MenuBorderPixel
    DrawBox(dx, y1_1, dx + w, y1_2, C_WHITE)
    y2_1 = y1_2 + CC.RowPixel
    y2_2 = y2_1 + CC.ThingFontSize + 2 * CC.MenuBorderPixel
    DrawBox(dx, y2_1, dx + w, y2_2, C_WHITE)
    y3_1 = y2_2 + CC.RowPixel
    y3_2 = y3_1 + h
    DrawBox(dx, y3_1, dx + w, y3_2, C_WHITE)
    for y = 0, ynum - 1 do
      for x = 0, xnum - 1 do
        local id = y * xnum + x + xnum * cur_line
        local boxcolor
        if x == cur_x and y == cur_y then
          boxcolor = C_WHITE
          if thing[id] ~= nil and 0 <= thing[id] then
            cur_thing = thing[id]
            local str = JY.Thing[thing[id]]["\195\251\179\198"]
            if (JY.Thing[thing[id]].类型 == 1 or JY.Thing[thing[id]].类型 == 2) and 0 <= JY.Thing[thing[id]]["\202\185\211\195\200\203"] then
              str = str .. "(" .. JY.Person[JY.Thing[thing[id]]["\202\185\211\195\200\203"]].姓名 .. ")"
            end
            str = string.format("%s X %d", str, thingnum[id])
            local str2 = JY.Thing[thing[id]]["\206\239\198\183\203\181\195\247"]
            if thing[id] == 182 then
              str2 = str2 .. string.format("(\200\203%3d,%3d)", JY.Base.人X, JY.Base.人Y)
            end
            DrawString(dx + CC.ThingGapOut, y1_1 + CC.MenuBorderPixel, str, C_GOLD, CC.ThingFontSize)
            DrawString(dx + CC.ThingGapOut, y2_1 + CC.MenuBorderPixel, str2, C_ORANGE, CC.ThingFontSize)
            DrawString(dx + CC.ThingGapOut + CC.ThingFontSize * 15, y1_1 + CC.MenuBorderPixel, string.format("\191\213\188\228 %d/800", thnum), C_GOLD, CC.ThingFontSize)
            local myfont = CC.DefaultFont * 0.9
            local mx, my = dx + 4 * myfont, y3_2 + CC.RowPixel
            local myflag = 0
            local myThing = JY.Thing[thing[id]]
            
            local function drawitem(ss, str, news)
              local mys
              if str == nil then
                mys = ss
              elseif myThing[ss] ~= 0 then
                if news == nil then
                  if myflag == 0 then
                    mys = string.format(str .. ":%+d", myThing[ss])
                  elseif myflag == 1 then
                    mys = string.format(str .. ":%d", myThing[ss])
                  end
                else
                  if myThing[ss] < 0 then
                    return
                  end
                  mys = string.format(str .. ":%s", news[myThing[ss]])
                end
              elseif myThing[ss] == 0 and ss == "\208\232\196\218\193\166\208\212\214\202" then
                mys = string.format(str .. ":%s", news[myThing[ss]])
              else
                return
              end
              local ccc = C_GOLD
              if ss == "\208\232\196\218\193\166\208\212\214\202" then
                if myThing[ss] == 0 then
                  ccc = RGB(208, 152, 208)
                elseif myThing[ss] == 1 then
                  ccc = C_ORANGE
                elseif myThing[ss] == 2 then
                  ccc = C_WHITE
                end
              end
              local mylen = myfont * string.len(mys) / 2 + 12
              if CC.ScreenW - dx < mx + mylen then
                my = my + myfont * 1.5
                mx = dx + 4 * myfont
              end
              if ss == "\208\232\196\218\193\166\208\212\214\202" and myThing[ss] == 2 then
              else
                DrawStrBox(mx, my, mys, ccc, myfont)
                mx = mx + mylen
              end
            end
            
            if 0 < myThing.类型 then
              drawitem("\188\211\201\250\195\252", "\201\250\195\252")
              drawitem("\188\211\201\250\195\252\215\238\180\243\214\181", "\201\250\195\252\215\238\180\243\214\181")
              drawitem("\188\211\214\208\182\190\189\226\182\190", "\214\208\182\190")
              drawitem("\188\211\204\229\193\166", "\204\229\193\166")
              if myThing["\184\196\177\228\196\218\193\166\208\212\214\202"] == 2 then
                drawitem("\210\245\209\244\181\247\186\205")
              end
              drawitem("\188\211\196\218\193\166", "\196\218\193\166")
              drawitem("\188\211\196\218\193\166\215\238\180\243\214\181", "\196\218\193\166\215\238\180\243\214\181")
              drawitem("\188\211\185\165\187\247\193\166", "\185\165\187\247")
              drawitem("\188\211\199\225\185\166", "\199\225\185\166")
              drawitem("\188\211\183\192\211\249\193\166", "\183\192\211\249")
              drawitem("\188\211\210\189\193\198\196\220\193\166", "\210\189\193\198")
              drawitem("\188\211\211\195\182\190\196\220\193\166", "\211\195\182\190")
              drawitem("\188\211\189\226\182\190\196\220\193\166", "\189\226\182\190")
              drawitem("\188\211\191\185\182\190\196\220\193\166", "\191\185\182\190")
              drawitem("\188\211\200\173\213\198\185\166\183\242", "\200\173\213\198")
              drawitem("\188\211\211\249\189\163\196\220\193\166", "\211\249\189\163")
              drawitem("\188\211\203\163\181\182\188\188\199\201", "\203\163\181\182")
              drawitem("\188\211\204\216\202\226\177\248\198\247", "\204\216\202\226")
              drawitem("\188\211\176\181\198\247\188\188\199\201", "\176\181\198\247")
              drawitem("\188\211\206\228\209\167\179\163\202\182", "\206\228\179\163")
              drawitem("\188\211\198\183\181\194", "\198\183\181\194")
              drawitem("\188\211\185\165\187\247\180\206\202\253", "\215\243\211\210", {
                [0] = "\183\241",
                "\202\199"
              })
              drawitem("\188\211\185\165\187\247\180\248\182\190", "\180\248\182\190")
              if mx ~= dx or my ~= y3_2 + CC.RowPixel then
                DrawStrBox(dx, y3_2 + 2, " \208\167\185\251:", C_RED, myfont)
              end
            end
            if myThing.类型 == 1 or myThing.类型 == 2 then
              if mx ~= dx then
                mx = dx + 4 * myfont
                my = my + myfont * 1.7
              end
              myflag = 1
              local my2 = my
              if -1 < myThing["\189\246\208\222\193\182\200\203\206\239"] then
                drawitem("\189\246\207\222:" .. JY.Person[myThing["\189\246\208\222\193\182\200\203\206\239"]].姓名)
              end
              drawitem("\208\232\196\218\193\166\208\212\214\202", "\210\245\209\244", {
                [0] = "\210\245",
                "\209\244"
              })
              drawitem("\208\232\196\218\193\166", "\196\218\193\166")
              drawitem("\208\232\185\165\187\247\193\166", "\185\165\187\247")
              drawitem("\208\232\199\225\185\166", "\199\225\185\166")
              drawitem("\208\232\211\195\182\190\196\220\193\166", "\211\195\182\190")
              drawitem("\208\232\210\189\193\198\196\220\193\166", "\210\189\193\198")
              drawitem("\208\232\189\226\182\190\196\220\193\166", "\189\226\182\190")
              drawitem("\208\232\200\173\213\198\185\166\183\242", "\200\173\213\198")
              drawitem("\208\232\211\249\189\163\196\220\193\166", "\211\249\189\163")
              drawitem("\208\232\203\163\181\182\188\188\199\201", "\203\163\181\182")
              drawitem("\208\232\204\216\202\226\177\248\198\247", "\204\216\202\226")
              drawitem("\208\232\176\181\198\247\188\188\199\201", "\176\181\198\247")
              drawitem("\208\232\215\202\214\202", "\215\202\214\202")
              drawitem("\208\232\190\173\209\233", "\208\222\193\182\190\173\209\233")
              if mx ~= dx or my ~= my2 then
                DrawStrBox(dx, my2, " \208\232\199\243:", C_RED, myfont)
              end
            end
            if myThing.类型 == 1 then
              local ia
              for ia = 1, CC.EONum do
                if CC.ExtraOffense[ia][1] == thing[id] then
                  mx = dx + 4 * myfont
                  my = my + myfont * 1.7
                  DrawStrBox(dx, my, " \212\246\199\191:", C_RED, myfont)
                  local wpid1 = thing[id]
                  local wgid1 = CC.ExtraOffense[ia][2]
                  local gjl1 = CC.ExtraOffense[ia][3]
                  local wgzq = JY.Wugong[wgid1]["\195\251\179\198"] .. "\163\186\161\252" .. gjl1
                  DrawStrBox(mx, my, wgzq, C_GOLD, myfont)
                end
              end
            end
            if JY.Thing[thing[id]].类型 == 2 and 0 < JY.Thing[thing[id]]["\193\183\179\246\206\228\185\166"] then
              do
                local wgid = JY.Thing[thing[id]]["\193\183\179\246\206\228\185\166"]
                local wgmc = JY.Wugong[wgid]["\195\251\179\198"]
                local wgshlx = JY.Wugong[wgid]["\201\203\186\166\192\224\208\205"]
                local wggjfw = JY.Wugong[wgid]["\185\165\187\247\183\182\206\167"]
                local wggjl = JY.Wugong[wgid]["\185\165\187\247\193\16610"]
                local wgydfw = JY.Wugong[wgid]["\210\198\182\175\183\182\206\16710"]
                local wgssfw = JY.Wugong[wgid]["\201\177\201\203\183\182\206\16710"]
                local wgjnl = JY.Wugong[wgid]["\188\211\196\218\193\16610"]
                local wgsnl = JY.Wugong[wgid]["\201\177\196\218\193\16610"]
                local gjstr = ""
                local nlxh = JY.Wugong[wgid]["\207\251\186\196\196\218\193\166\181\227\202\253"] * 5
                local wgmx
                if wggjfw == 0 then
                  gjstr = "\161\241"
                elseif wggjfw == 1 then
                  gjstr = "\169\165"
                elseif wggjfw == 2 then
                  gjstr = "\169\239"
                elseif wggjfw == 3 then
                  gjstr = "\161\246"
                end
                mx = dx + 4 * myfont
                my = my + myfont * 1.7
                DrawStrBox(dx, my, " \206\228\185\166:", C_RED, myfont)
                if wgshlx == 0 then
                  if wggjfw == 0 then
                    wgmx = string.format("%s %s \210\198%d\184\241 \207\251\186\196\196\218\193\166\163\186%d \205\254\193\166\163\186%d", wgmc, gjstr, wgydfw, nlxh, wggjl)
                    DrawStrBox(mx, my, wgmx, C_GOLD, myfont)
                  elseif wggjfw == 1 then
                    wgmx = string.format("%s %s %d\184\241 \207\251\186\196\196\218\193\166\163\186%d \205\254\193\166\163\186%d", wgmc, gjstr, wgydfw, nlxh, wggjl)
                    DrawStrBox(mx, my, wgmx, C_GOLD, myfont)
                  elseif wggjfw == 2 then
                    wgmx = string.format("%s %s %d\184\241 \207\251\186\196\196\218\193\166\163\186%d \205\254\193\166\163\186%d", wgmc, gjstr, wgydfw, nlxh, wggjl)
                    DrawStrBox(mx, my, wgmx, C_GOLD, myfont)
                  else
                    wgmx = string.format("%s %s \210\198%d\184\241 %dX%d \207\251\186\196\196\218\193\166\163\186%d \205\254\193\166\163\186%d", wgmc, gjstr, wgydfw, wgssfw + 1 + wgssfw, wgssfw + 1 + wgssfw, nlxh, wggjl)
                    DrawStrBox(mx, my, wgmx, C_GOLD, myfont)
                  end
                else
                  wgmx = string.format("%s \206\252\196\218\193\166\163\186%d \201\177\196\218\193\166\163\186%d", wgmc, wgjnl, wgsnl)
                  DrawStrBox(mx, my, wgmx, RGB(208, 152, 208), myfont)
                end
              end
            end
          else
            cur_thing = -1
          end
        else
          boxcolor = C_BLACK
        end
        local boxx = dx + CC.ThingGapOut + x * (CC.ThingPicWidth + CC.ThingGapIn)
        local boxy = y3_1 + CC.ThingGapOut + y * (CC.ThingPicHeight + CC.ThingGapIn)
        lib.DrawRect(boxx, boxy, boxx + CC.ThingPicWidth + 1, boxy + CC.ThingPicHeight + 1, boxcolor)
        if 0 <= thing[id] and CC.LoadThingPic == 1 then
          lib.PicLoadCache(2, thing[id] * 2, boxx + 1, boxy + 1, 1)
        elseif 0 <= thing[id] and CC.LoadThingPic == 0 and CC.FK == 0 then
          lib.PicLoadCache(0, (thing[id] + CC.StartThingPic) * 2, boxx + 1, boxy + 1, 1)
        elseif 0 <= thing[id] and CC.LoadThingPic == 0 and CC.FK == 1 then
          lib.PicLoadCache(2, (thing[id] + CC.StartThingPic) * 2, boxx + 1, boxy + 1, 1)
        end
      end
    end
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
    if keypress == VK_ESCAPE or ktype == 4 then
      cur_thing = -1
      oldcur_line = cur_line
      oldcur_x = cur_x
      oldcur_y = cur_y
      break
    elseif keypress == VK_RETURN or keypress == VK_SPACE then
      oldcur_line = cur_line
      oldcur_x = cur_x
      oldcur_y = cur_y
      break
    elseif keypress == VK_UP or ktype == 6 then
      if cur_y == 0 then
        if 0 < cur_line then
          cur_line = cur_line - 1
        end
      else
        cur_y = cur_y - 1
      end
    elseif keypress == VK_DOWN or ktype == 7 then
      if cur_y == ynum - 1 then
        if cur_line < math.modf(CC.MyThingNum / xnum) - ynum then
          cur_line = cur_line + 1
        end
      else
        cur_y = cur_y + 1
      end
    elseif keypress == VK_LEFT then
      if 0 < cur_x then
        cur_x = cur_x - 1
      else
        cur_x = xnum - 1
      end
    elseif keypress == VK_RIGHT then
      if cur_x == xnum - 1 then
        cur_x = 0
      else
        cur_x = cur_x + 1
      end
    elseif ktype == 2 or ktype == 3 then
      if dx < mx and y3_1 < my and mx < CC.ScreenW - dx and my < CC.ScreenH - y3_1 then
        cur_x = math.modf((mx - dx - CC.ThingGapOut / 2) / (CC.ThingPicWidth + CC.ThingGapIn))
        cur_y = math.modf((my - y3_1 - CC.ThingGapOut / 2) / (CC.ThingPicHeight + CC.ThingGapIn))
        if ktype == 3 then
          break
        end
      end
      if ktype == 2 then
        if my < CC.DefaultFont * 5 then
          if cur_y == 0 then
            if 0 < cur_line then
              cur_line = cur_line - 1
            end
          else
            cur_y = cur_y - 1
          end
          lib.Delay(100)
        elseif my > CC.ScreenH - CC.DefaultFont * 5 then
          if cur_y == ynum - 1 then
            if cur_line < math.modf(CC.MyThingNum / xnum) - ynum then
              cur_line = cur_line + 1
            end
          else
            cur_y = cur_y + 1
          end
          lib.Delay(100)
        end
      end
    end
  end
  Cls()
  return cur_thing
end

function SceneCanPass(x, y)
  local ispass = true
  if GetS(JY.SubScene, x, y, 1) > 0 then
    ispass = false
  end
  local d_data = GetS(JY.SubScene, x, y, 3)
  if 0 <= d_data and GetD(JY.SubScene, d_data, 0) ~= 0 then
    ispass = false
  end
  if CC.SceneWater[GetS(JY.SubScene, x, y, 0)] ~= nil then
    ispass = false
  end
  return ispass
end

function Cal_D_Valid()
  if JY.D_Valid ~= nil then
    return
  end
  local sceneid = JY.SubScene
  JY.D_Valid = {}
  JY.D_Valid_Num = 0
  for i = 0, CC.DNum - 1 do
    local x = GetD(sceneid, i, 9)
    local y = GetD(sceneid, i, 10)
    local v = GetS(sceneid, x, y, 3)
    if 0 <= v then
      JY.D_Valid[JY.D_Valid_Num] = i
      JY.D_Valid_Num = JY.D_Valid_Num + 1
    end
  end
end

function DtoSMap()
  local sceneid = JY.SubScene
  JY.NumD_PicChange = 0
  JY.D_PicChange = {}
  if JY.D_Valid == nil then
    Cal_D_Valid()
  end
  for k = 0, JY.D_Valid_Num - 1 do
    local i = JY.D_Valid[k]
    local p1 = GetD(sceneid, i, 5)
    if 0 < p1 then
      local p2 = GetD(JY.SubScene, i, 6)
      local p3 = GetD(JY.SubScene, i, 7)
      local delay = GetD(JY.SubScene, i, 8)
      if p1 >= p3 then
        if delay < JY.MyTick % 100 then
          p3 = p3 + 1
        end
      elseif JY.MyTick % 4 == 0 then
        p3 = p3 + 1
      end
      if p2 < p3 then
        p3 = p1
      end
      SetD(JY.SubScene, i, 7, p3)
    end
  end
end

function DrawSMap(fastdraw)
  local x0 = JY.SubSceneX + JY.Base.人X1 - 1
  local y0 = JY.SubSceneY + JY.Base.人Y1 - 1
  local x = limitX(x0, CC.SceneXMin, CC.SceneXMax) - JY.Base.人X1
  local y = limitX(y0, CC.SceneYMin, CC.SceneYMax) - JY.Base.人Y1
  lib.DrawSMap(JY.SubScene, JY.Base.人X1, JY.Base.人Y1, x, y, JY.MyPic)
end

function LoadRecord(id)
  local t1 = lib.GetTime()
  local data = Byte.create(24)
  Byte.loadfile(data, CC.R_IDXFilename[0], 0, 24)
  local idx = {}
  idx[0] = 0
  for i = 1, 6 do
    idx[i] = Byte.get32(data, 4 * (i - 1))
  end
  JY.Data_Base = Byte.create(idx[1] - idx[0])
  Byte.loadfile(JY.Data_Base, CC.R_GRPFilename[id], idx[0], idx[1] - idx[0])
  local meta_t = {
    __index = function(t, k)
      return GetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k)
    end,
    __newindex = function(t, k, v)
      SetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k, v)
    end
  }
  setmetatable(JY.Base, meta_t)
  JY.PersonNum = math.floor((idx[2] - idx[1]) / CC.PersonSize)
  JY.Data_Person = Byte.create(CC.PersonSize * JY.PersonNum)
  Byte.loadfile(JY.Data_Person, CC.R_GRPFilename[id], idx[1], CC.PersonSize * JY.PersonNum)
  for i = 0, JY.PersonNum - 1 do
    JY.Person[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k, v)
      end
    }
    setmetatable(JY.Person[i], meta_t)
  end
  JY.ThingNum = math.floor((idx[3] - idx[2]) / CC.ThingSize)
  JY.Data_Thing = Byte.create(CC.ThingSize * JY.ThingNum)
  Byte.loadfile(JY.Data_Thing, CC.R_GRPFilename[id], idx[2], CC.ThingSize * JY.ThingNum)
  for i = 0, JY.ThingNum - 1 do
    JY.Thing[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k, v)
      end
    }
    setmetatable(JY.Thing[i], meta_t)
  end
  JY.SceneNum = math.floor((idx[4] - idx[3]) / CC.SceneSize)
  JY.Data_Scene = Byte.create(CC.SceneSize * JY.SceneNum)
  Byte.loadfile(JY.Data_Scene, CC.R_GRPFilename[id], idx[3], CC.SceneSize * JY.SceneNum)
  for i = 0, JY.SceneNum - 1 do
    JY.Scene[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k, v)
      end
    }
    setmetatable(JY.Scene[i], meta_t)
  end
  JY.WugongNum = math.floor((idx[5] - idx[4]) / CC.WugongSize)
  JY.Data_Wugong = Byte.create(CC.WugongSize * JY.WugongNum)
  Byte.loadfile(JY.Data_Wugong, CC.R_GRPFilename[id], idx[4], CC.WugongSize * JY.WugongNum)
  for i = 0, JY.WugongNum - 1 do
    JY.Wugong[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k, v)
      end
    }
    setmetatable(JY.Wugong[i], meta_t)
  end
  JY.ShopNum = math.floor((idx[6] - idx[5]) / CC.ShopSize)
  JY.Data_Shop = Byte.create(CC.ShopSize * JY.ShopNum)
  Byte.loadfile(JY.Data_Shop, CC.R_GRPFilename[id], idx[5], CC.ShopSize * JY.ShopNum)
  for i = 0, JY.ShopNum - 1 do
    JY.Shop[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k, v)
      end
    }
    setmetatable(JY.Shop[i], meta_t)
  end
  loadglts(id)
  lib.LoadSMap(CC.S_Filename[id], CC.TempS_Filename, JY.SceneNum, CC.SWidth, CC.SHeight, CC.D_Filename[id], CC.DNum, 11)
  collectgarbage()
  JubenBugFix()
  lib.Debug(string.format("Loadrecord time=%d", lib.GetTime() - t1))
end

function LoadRecord2(id)
  local t1 = lib.GetTime()
  if CC.BanBen == 0 or CC.BanBen == 2 then
    CC.MyThingNum = 200
  elseif CC.BanBen == 1 then
    CC.MyThingNum = 300
  end
  local data = Byte.create(24)
  Byte.loadfile(data, CONFIG.DataPath .. "oldr.idx", 0, 24)
  local idx = {}
  idx[0] = 0
  for i = 1, 6 do
    idx[i] = Byte.get32(data, 4 * (i - 1))
  end
  JY.Data_Base = Byte.create(idx[1] - idx[0])
  Byte.loadfile(JY.Data_Base, CC.R_GRPFilename[id], idx[0], idx[1] - idx[0])
  local meta_t = {
    __index = function(t, k)
      return GetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k)
    end,
    __newindex = function(t, k, v)
      SetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k, v)
    end
  }
  setmetatable(JY.Base, meta_t)
  JY.PersonNum = math.floor((idx[2] - idx[1]) / CC.PersonSize)
  JY.Data_Person = Byte.create(CC.PersonSize * JY.PersonNum)
  Byte.loadfile(JY.Data_Person, CC.R_GRPFilename[id], idx[1], CC.PersonSize * JY.PersonNum)
  for i = 0, JY.PersonNum - 1 do
    JY.Person[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k, v)
      end
    }
    setmetatable(JY.Person[i], meta_t)
  end
  JY.ThingNum = math.floor((idx[3] - idx[2]) / CC.ThingSize)
  JY.Data_Thing = Byte.create(CC.ThingSize * JY.ThingNum)
  Byte.loadfile(JY.Data_Thing, CC.R_GRPFilename[id], idx[2], CC.ThingSize * JY.ThingNum)
  for i = 0, JY.ThingNum - 1 do
    JY.Thing[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k, v)
      end
    }
    setmetatable(JY.Thing[i], meta_t)
  end
  JY.SceneNum = math.floor((idx[4] - idx[3]) / CC.SceneSize)
  JY.Data_Scene = Byte.create(CC.SceneSize * JY.SceneNum)
  Byte.loadfile(JY.Data_Scene, CC.R_GRPFilename[id], idx[3], CC.SceneSize * JY.SceneNum)
  for i = 0, JY.SceneNum - 1 do
    JY.Scene[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k, v)
      end
    }
    setmetatable(JY.Scene[i], meta_t)
  end
  JY.WugongNum = math.floor((idx[5] - idx[4]) / CC.WugongSize)
  JY.Data_Wugong = Byte.create(CC.WugongSize * JY.WugongNum)
  Byte.loadfile(JY.Data_Wugong, CC.R_GRPFilename[id], idx[4], CC.WugongSize * JY.WugongNum)
  for i = 0, JY.WugongNum - 1 do
    JY.Wugong[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k, v)
      end
    }
    setmetatable(JY.Wugong[i], meta_t)
  end
  JY.ShopNum = math.floor((idx[6] - idx[5]) / CC.ShopSize)
  JY.Data_Shop = Byte.create(CC.ShopSize * JY.ShopNum)
  Byte.loadfile(JY.Data_Shop, CC.R_GRPFilename[id], idx[5], CC.ShopSize * JY.ShopNum)
  for i = 0, JY.ShopNum - 1 do
    JY.Shop[i] = {}
    local meta_t = {
      __index = function(t, k)
        return GetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k)
      end,
      __newindex = function(t, k, v)
        SetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k, v)
      end
    }
    setmetatable(JY.Shop[i], meta_t)
  end
  lib.LoadSMap(CC.S_Filename[id], CC.TempS_Filename, JY.SceneNum, CC.SWidth, CC.SHeight, CC.D_Filename[id], CC.DNum, 11)
  collectgarbage()
  JubenBugFix()
  lib.Debug(string.format("Loadrecord time=%d", lib.GetTime() - t1))
end

function SaveRecord(id)
  local t1 = lib.GetTime()
  local data = Byte.create(24)
  Byte.loadfile(data, CC.R_IDXFilename[0], 0, 24)
  local idx = {}
  idx[0] = 0
  for i = 1, 6 do
    idx[i] = Byte.get32(data, 4 * (i - 1))
  end
  os.remove(CC.R_GRPFilename[id])
  os.remove(CC.S_Filename[id])
  os.remove(CC.D_Filename[id])
  if JY.Status == GAME_SMAP then
    JY.Base.无用 = JY.SubScene
  else
    JY.Base.无用 = -1
  end
  Byte.savefile(JY.Data_Base, CC.R_GRPFilename[id], idx[0], idx[1] - idx[0])
  Byte.savefile(JY.Data_Person, CC.R_GRPFilename[id], idx[1], CC.PersonSize * JY.PersonNum)
  Byte.savefile(JY.Data_Thing, CC.R_GRPFilename[id], idx[2], CC.ThingSize * JY.ThingNum)
  Byte.savefile(JY.Data_Scene, CC.R_GRPFilename[id], idx[3], CC.SceneSize * JY.SceneNum)
  Byte.savefile(JY.Data_Wugong, CC.R_GRPFilename[id], idx[4], CC.WugongSize * JY.WugongNum)
  Byte.savefile(JY.Data_Shop, CC.R_GRPFilename[id], idx[5], CC.ShopSize * JY.ShopNum)
  lib.SaveSMap(CC.S_Filename[id], CC.D_Filename[id])
  saveglts(id)
  lib.Debug(string.format("SaveRecord time=%d", lib.GetTime() - t1))
end

function filelength(filename)
  local inp = io.open(filename, "rb")
  local l = inp:seek("end")
  inp:close()
  return l
end

function GetS(id, x, y, level)
  return lib.GetS(id, x, y, level)
end

function SetS(id, x, y, level, v)
  lib.SetS(id, x, y, level, v)
end

function GetD(Sceneid, id, i)
  return lib.GetD(Sceneid, id, i)
end

function SetD(Sceneid, id, i, v)
  lib.SetD(Sceneid, id, i, v)
end

function GetDataFromStruct(data, offset, t_struct, key)
  local t = t_struct[key]
  local r
  if t[2] == 0 then
    r = Byte.get16(data, t[1] + offset)
  elseif t[2] == 1 then
    r = Byte.getu16(data, t[1] + offset)
  elseif t[2] == 2 then
    if CC.SrcCharSet == 0 then
      r = lib.CharSet(Byte.getstr(data, t[1] + offset, t[3]), 0)
    else
      r = Byte.getstr(data, t[1] + offset, t[3])
    end
  end
  return r
end

function SetDataFromStruct(data, offset, t_struct, key, v)
  local t = t_struct[key]
  if t[2] == 0 then
    Byte.set16(data, t[1] + offset, v)
  elseif t[2] == 1 then
    Byte.setu16(data, t[1] + offset, v)
  elseif t[2] == 2 then
    local s
    if CC.SrcCharSet == 0 then
      s = lib.CharSet(v, 1)
    else
      s = v
    end
    Byte.setstr(data, t[1] + offset, t[3], s)
  end
end

function LoadData(t, t_struct, data)
  for k, v in pairs(t_struct) do
    if v[2] == 0 then
      t[k] = Byte.get16(data, v[1])
    elseif v[2] == 1 then
      t[k] = Byte.getu16(data, v[1])
    elseif v[2] == 2 then
      if CC.SrcCharSet == 0 then
        t[k] = lib.CharSet(Byte.getstr(data, v[1], v[3]), 0)
      else
        t[k] = Byte.getstr(data, v[1], v[3])
      end
    end
  end
end

function SaveData(t, t_struct, data)
  for k, v in pairs(t_struct) do
    if v[2] == 0 then
      Byte.set16(data, v[1], t[k])
    elseif v[2] == 1 then
      Byte.setu16(data, v[1], t[k])
    elseif v[2] == 2 then
      local s
      if CC.SrcCharSet == 0 then
        s = lib.CharSet(t[k], 1)
      else
        s = t[k]
      end
      Byte.setstr(data, v[1], v[3], s)
    end
  end
end

function limitX(x, minv, maxv)
  if x < minv then
    x = minv
  elseif maxv < x then
    x = maxv
  end
  return x
end

function RGB(r, g, b)
  return r * 65536 + g * 256 + b
end

function GetRGB(color)
  color = color % 16777216
  local r = math.floor(color / 65536)
  color = color % 65536
  local g = math.floor(color / 256)
  local b = color % 256
  return r, g, b
end

function WaitKey(flag)
  local key, ktype, mx, my = -1, -1, -1, -1
  if flag == 1 then
    key, ktype, mx, my = lib.GetKey()
    if key == -1 then
      lib.Delay(CC.Frame / 2)
    end
    return key, ktype, mx, my
  end
  while true do
    key, ktype, mx, my = lib.GetKey()
    if ktype == nil then
      ktype, mx, my = -1, -1, -1
    end
    if (ktype ~= -1 or key ~= -1) and ((flag == nil or flag == 0) and ktype ~= 2 or flag ~= nil and flag ~= 0) then
      break
    end
    lib.Delay(CC.Frame / 2)
  end
  return key, ktype, mx, my
end

function DrawBox(x1, y1, x2, y2, color)
  local s = 2 * CC.BoxLine
  lib.Background(x1, y1 + s, x1 + s, y2 - s, 128)
  lib.Background(x1 + s, y1, x2 - s, y2, 128)
  lib.Background(x2 - s, y1 + s, x2, y2 - s, 128)
  local r, g, b = GetRGB(color)
  DrawBox_1(x1 + 1, y1 + 1, x2, y2, RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
  DrawBox_1(x1, y1, x2 - 1, y2 - 1, color)
end

function DrawBox_1(x1, y1, x2, y2, color)
  local s = 2 * CC.BoxLine
  lib.DrawRect(x1 + s, y1, x2 - s, y1, color)
  lib.DrawRect(x2 - s, y1, x2 - s, y1 + s, color)
  lib.DrawRect(x2 - s, y1 + s, x2, y1 + s, color)
  lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
  lib.DrawRect(x2, y2 - s, x2 - s, y2 - s, color)
  lib.DrawRect(x2 - s, y2 - s, x2 - s, y2, color)
  lib.DrawRect(x2 - s, y2, x1 + s, y2, color)
  lib.DrawRect(x1 + s, y2, x1 + s, y2 - s, color)
  lib.DrawRect(x1 + s, y2 - s, x1, y2 - s, color)
  lib.DrawRect(x1, y2 - s, x1, y1 + s, color)
  lib.DrawRect(x1, y1 + s, x1 + s, y1 + s, color)
  lib.DrawRect(x1 + s, y1 + s, x1 + s, y1, color)
end

function DrawString(x, y, str, color, size)
  lib.DrawStr(x, y, str, color, size, CC.FontName, CC.SrcCharSet, CC.OSCharSet)
end

function DrawStrBox(x, y, str, color, size)
  local ll = #str
  local w = size * ll / 2 + 2 * CC.MenuBorderPixel
  local h = size + 2 * CC.MenuBorderPixel
  if x == -1 then
    x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
  end
  if y == -1 then
    y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
  end
  DrawBox(x, y, x + w - 1, y + h - 1, C_WHITE)
  DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel, str, color, size)
end

function DrawStrBoxYesNo(x, y, str, color, size)
  local ll = #str
  local w = size * ll / 2 + 2 * CC.MenuBorderPixel
  local h = size + 2 * CC.MenuBorderPixel
  if x == -1 then
    x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
  end
  if y == -1 then
    y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
  end
  DrawStrBox(x, y, str, color, size)
  local menu = {
    {
      "\200\183\182\168/\202\199",
      nil,
      1
    },
    {
      "\200\161\207\251/\183\241",
      nil,
      2
    }
  }
  local r = ShowMenu(menu, 2, 0, x + w - 4 * size - 2 * CC.MenuBorderPixel, y + h + CC.MenuBorderPixel, 0, 0, 1, 0, size, C_ORANGE, C_WHITE)
  if r == 1 then
    return true
  else
    return false
  end
end

function DrawStrBoxWaitKey(s, color, size)
  DrawStrBox(-1, -1, s, color, size)
  ShowScreen()
  WaitKey()
  Cls()
end

function Rnd(i)
  local r = math.random(i)
  return r - 1
end

function AddPersonAttrib(id, str, value)
  local oldvalue = JY.Person[id][str]
  local attribmax = math.huge
  if str == "\201\250\195\252" then
    attribmax = JY.Person[id]["\201\250\195\252\215\238\180\243\214\181"]
  elseif str == "\196\218\193\166" then
    attribmax = JY.Person[id]["\196\218\193\166\215\238\180\243\214\181"]
  elseif CC.PersonAttribMax[str] ~= nil then
    attribmax = CC.PersonAttribMax[str]
  end
  local newvalue = limitX(oldvalue + value, 0, attribmax)
  JY.Person[id][str] = newvalue
  local add = newvalue - oldvalue
  local showstr = ""
  if 0 < add then
    showstr = string.format("%s \212\246\188\211 %d", str, add)
  elseif add < 0 then
    showstr = string.format("%s \188\245\201\217 %d", str, -add)
  end
  return add, showstr
end

function PlayMIDI(id)
  JY.CurrentMIDI = id
  if JY.EnableMusic == 0 then
    return
  end
  if 0 <= id then
    lib.PlayMIDI(string.format(CC.MIDIFile, id + 1))
  end
end

function PlayWavAtk(id)
  if JY.EnableSound == 0 then
    return
  end
  if 0 <= id then
    lib.PlayWAV(string.format(CC.ATKFile, id))
  end
end

function PlayWavE(id)
  if JY.EnableSound == 0 then
    return
  end
  if 0 <= id then
    lib.PlayWAV(string.format(CC.EFile, id))
  end
end

function ShowScreen(flag)
  if JY.Darkness == 0 then
    if flag == nil then
      flag = 0
    end
    lib.ShowSurface(flag)
  end
end

function ShowMenu(menuItem, numItem, numShow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor, selectxm)
  if selectxm == nil then
    selectxm = 1
  end
  local w = 0
  local h = 0
  local i = 0
  local num = 0
  local newNumItem = 0
  local zbx = JY.Base.人X
  local zbY = JY.Base.人Y
  local newMenu = {}
  for i = 1, numItem do
    if 0 < menuItem[i][3] then
      newNumItem = newNumItem + 1
      newMenu[newNumItem] = {
        menuItem[i][1],
        menuItem[i][2],
        menuItem[i][3],
        i
      }
    end
  end
  if newNumItem == 0 then
    return 0
  end
  if numShow == 0 or numShow > newNumItem then
    num = newNumItem
  else
    num = numShow
  end
  local maxlength = 0
  if x2 == 0 and y2 == 0 then
    for i = 1, newNumItem do
      if maxlength < string.len(newMenu[i][1]) then
        maxlength = string.len(newMenu[i][1])
      end
    end
    w = size * maxlength / 2 + 2 * CC.MenuBorderPixel
    h = (size + CC.RowPixel) * num + CC.MenuBorderPixel
  else
    w = x2 - x1
    h = y2 - y1
  end
  local start = 1
  local current = 1
  for i = 1, newNumItem do
    if newMenu[i][3] == 2 then
      current = i
    end
  end
  if numShow ~= 0 then
    current = 1
  end
  current = current + selectxm - 1
  if newNumItem < current then
    current = 1
  end
  local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
  local surid2 = lib.SaveSur(x1, y1, x2, y2)
  local returnValue = 0
  if isBox == 1 then
    DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
  end
  while true do
    if num ~= 0 then
      if zbx == JY.Base.人X and zbY == JY.Base.人Y then
        ClsN()
        lib.LoadSur(surid, 0, 0)
      else
        lib.FreeSur(surid)
        Cls()
        surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
      end
      if isBox == 1 then
        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
      end
    end
    for i = start, start + num - 1 do
      local drawColor = color
      if i == current then
        drawColor = selectColor
        lib.Background(x1 + CC.MenuBorderPixel, y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel), x1 - CC.MenuBorderPixel + w, y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + size, 128, color)
      end
      DrawString(x1 + CC.MenuBorderPixel, y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel), newMenu[i][1], drawColor, size)
    end
    ShowScreen()
    local keyPress, ktype, mx, my = WaitKey(1)
    if keyPress == VK_ESCAPE or ktype == 4 then
      if isEsc == 1 then
        break
      end
    elseif keyPress == VK_DOWN or ktype == 7 then
      current = current + 1
      if current > start + num - 1 then
        start = start + 1
      end
      if newNumItem < current then
        start = 1
        current = 1
      end
    elseif keyPress == VK_UP or ktype == 6 then
      current = current - 1
      if start > current then
        start = start - 1
      end
      if current < 1 then
        current = newNumItem
        start = current - num + 1
      end
    elseif keyPress == VK_RIGHT then
      current = current + 10
      if current > start + num - 1 then
        start = start + 10
      end
      if newNumItem < current + start then
        current = newNumItem
        start = current - num + 1
      end
    elseif keyPress == VK_LEFT then
      current = current - 10
      if start > current then
        start = start - 10
      end
      if current < 1 then
        start = 1
        current = 1
      elseif num > current then
        start = 1
      end
    else
      local mk = false
      if (ktype == 2 or ktype == 3) and x1 <= mx and mx <= x1 + w and y1 <= my and my <= y1 + h then
        current = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
        mk = true
      end
      if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or ktype == 3 and mk then
        if newMenu[current][2] == nil then
          returnValue = newMenu[current][4]
          if zbx == JY.Base.人X and zbY == JY.Base.人Y then
            lib.LoadSur(surid2, x1, y1)
            break
          end
          lib.FreeSur(surid2)
          Cls()
          surid2 = lib.SaveSur(x1, y1, x2, y2)
          lib.LoadSur(surid2, x1, y1)
          break
        else
          local r = newMenu[current][2](newMenu, current)
          if r == 1 then
            returnValue = -newMenu[current][4]
            break
          end
          if zbx == JY.Base.人X and zbY == JY.Base.人Y then
            ClsN()
            lib.LoadSur(surid, 0, 0)
          else
            lib.FreeSur(surid)
            Cls()
            surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
            lib.LoadSur(surid, 0, 0)
          end
          if isBox == 1 then
            DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
          end
        end
      end
    end
  end
  lib.FreeSur(surid)
  lib.FreeSur(surid2)
  return returnValue
end

function ShowMenu2(menuItem, numItem, numShow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor)
  local w = 0
  local h = 0
  local i = 0
  local num = 0
  local newNumItem = 0
  local newMenu = {}
  for i = 1, numItem do
    if 0 < menuItem[i][3] then
      newNumItem = newNumItem + 1
      newMenu[newNumItem] = {
        menuItem[i][1],
        menuItem[i][2],
        menuItem[i][3],
        i
      }
    end
  end
  if numShow == 0 or numShow > newNumItem then
    num = newNumItem
  else
    num = numShow
  end
  local maxlength = 0
  if x2 == 0 and y2 == 0 then
    for i = 1, newNumItem do
      if maxlength < string.len(newMenu[i][1]) then
        maxlength = string.len(newMenu[i][1])
      end
    end
    w = (size * maxlength / 2 + CC.RowPixel) * num + CC.MenuBorderPixel
    h = size + 2 * CC.MenuBorderPixel
  else
    w = x2 - x1
    h = y2 - y1
  end
  local start = 1
  local current = 1
  for i = 1, newNumItem do
    if newMenu[i][3] == 2 then
      current = i
      break
    end
  end
  if numShow ~= 0 then
    current = 1
  end
  local surid = lib.SaveSur(x1, y1, x1 + w, y1 + h)
  local returnValue = 0
  if isBox == 1 then
    DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
  end
  while true do
    if numShow ~= 0 and isBox == 1 then
      DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
    end
    for i = start, start + num - 1 do
      local drawColor = color
      if i == current then
        drawColor = selectColor
      end
      DrawString(x1 + CC.MenuBorderPixel + (i - start) * (size * maxlength / 2 + CC.RowPixel), y1 + CC.MenuBorderPixel, newMenu[i][1], drawColor, size)
    end
    ShowScreen()
    local keyPress, ktype, mx, my = WaitKey(1)
    if keyPress == VK_ESCAPE or ktype == 4 then
      if isEsc == 1 then
        break
      end
    elseif keyPress == VK_RIGHT then
      current = current + 1
      if current > start + num - 1 then
        start = start + 1
      end
      if newNumItem < current then
        start = 1
        current = 1
      end
    elseif keyPress == VK_LEFT then
      current = current - 1
      if start > current then
        start = start - 1
      end
      if current < 1 then
        current = newNumItem
        start = current - num + 1
      end
    elseif keyPress == VK_SPACE or keyPress == VK_RETURN then
      if newMenu[current][2] == nil then
        returnValue = newMenu[current][4]
        break
      else
        local r = newMenu[current][2](newMenu, current)
        if r == 1 then
          returnValue = -newMenu[current][4]
          break
        elseif isBox == 1 then
          DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
        end
      end
    end
    lib.LoadSur(surid, x1, y1)
  end
  lib.LoadSur(surid, x1, y1)
  lib.FreeSur(surid)
  return returnValue
end

function UseThing(id)
  if JY.ThingUseFunction[id] == nil then
    return DefaultUseThing(id)
  else
    return JY.ThingUseFunction[id](id)
  end
end

function DefaultUseThing(id)
  if JY.Thing[id].类型 == 0 then
    return UseThing_Type0(id)
  elseif JY.Thing[id].类型 == 1 then
    return UseThing_Type1(id)
  elseif JY.Thing[id].类型 == 2 then
    return UseThing_Type2(id)
  elseif JY.Thing[id].类型 == 3 then
    return UseThing_Type3(id)
  elseif JY.Thing[id].类型 == 4 then
    return UseThing_Type4(id)
  end
end

function UseThing_Type0(id)
  if JY.SubScene >= 0 then
    local x = JY.Base.人X1 + CC.DirectX[JY.Base["\200\203\183\189\207\242"] + 1]
    local y = JY.Base.人Y1 + CC.DirectY[JY.Base["\200\203\183\189\207\242"] + 1]
    local d_num = GetS(JY.SubScene, x, y, 3)
    if 0 <= d_num then
      JY.CurrentThing = id
      EventExecute(d_num, 2)
      JY.CurrentThing = -1
      return 1
    else
      return 0
    end
  end
end

function UseThing_Type1(id)
  DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("\203\173\210\170\197\228\177\184%s?", JY.Thing[id]["\195\251\179\198"]), C_WHITE, CC.DefaultFont)
  local nexty = CC.MainSubMenuY + CC.SingleLineHeight
  local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
  if 0 < r then
    local personid = JY.Base["\182\211\206\233" .. r]
    if CanUseThing(id, personid) then
      if JY.Thing[id]["\215\176\177\184\192\224\208\205"] == 0 then
        if 0 <= JY.Thing[id]["\202\185\211\195\200\203"] then
          JY.Person[JY.Thing[id]["\202\185\211\195\200\203"]]["\206\228\198\247"] = -1
        end
        if 0 <= JY.Person[personid]["\206\228\198\247"] then
          JY.Thing[JY.Person[personid]["\206\228\198\247"]]["\202\185\211\195\200\203"] = -1
        end
        JY.Person[personid]["\206\228\198\247"] = id
      elseif JY.Thing[id]["\215\176\177\184\192\224\208\205"] == 1 then
        if 0 <= JY.Thing[id]["\202\185\211\195\200\203"] then
          JY.Person[JY.Thing[id]["\202\185\211\195\200\203"]]["\183\192\190\223"] = -1
        end
        if 0 <= JY.Person[personid]["\183\192\190\223"] then
          JY.Thing[JY.Person[personid]["\183\192\190\223"]]["\202\185\211\195\200\203"] = -1
        end
        JY.Person[personid]["\183\192\190\223"] = id
      end
      JY.Thing[id]["\202\185\211\195\200\203"] = personid
    else
      DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\197\228\177\184\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
      return 0
    end
  end
  return 1
end

function CanUseThing(id, personid)
  local str = ""
  if JY.Thing[id]["\189\246\208\222\193\182\200\203\206\239"] >= 0 and JY.Thing[id]["\189\246\208\222\193\182\200\203\206\239"] ~= personid then
    return false
  end
  if JY.Thing[id]["\208\232\196\218\193\166\208\212\214\202"] ~= 2 and JY.Person[personid]["\196\218\193\166\208\212\214\202"] ~= 2 and JY.Thing[id]["\208\232\196\218\193\166\208\212\214\202"] ~= JY.Person[personid]["\196\218\193\166\208\212\214\202"] then
    return false
  end
  if JY.Thing[id]["\208\232\196\218\193\166"] > JY.Person[personid]["\196\218\193\166\215\238\180\243\214\181"] then
    return false
  end
  if JY.Thing[id]["\208\232\185\165\187\247\193\166"] > JY.Person[personid]["\185\165\187\247\193\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\199\225\185\166"] > JY.Person[personid]["\199\225\185\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\211\195\182\190\196\220\193\166"] > JY.Person[personid]["\211\195\182\190\196\220\193\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\210\189\193\198\196\220\193\166"] > JY.Person[personid]["\210\189\193\198\196\220\193\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\189\226\182\190\196\220\193\166"] > JY.Person[personid]["\189\226\182\190\196\220\193\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\200\173\213\198\185\166\183\242"] > JY.Person[personid]["\200\173\213\198\185\166\183\242"] then
    return false
  end
  if JY.Thing[id]["\208\232\211\249\189\163\196\220\193\166"] > JY.Person[personid]["\211\249\189\163\196\220\193\166"] then
    return false
  end
  if JY.Thing[id]["\208\232\203\163\181\182\188\188\199\201"] > JY.Person[personid]["\203\163\181\182\188\188\199\201"] then
    return false
  end
  if JY.Thing[id]["\208\232\204\216\202\226\177\248\198\247"] > JY.Person[personid]["\204\216\202\226\177\248\198\247"] then
    return false
  end
  if JY.Thing[id]["\208\232\176\181\198\247\188\188\199\201"] > JY.Person[personid]["\176\181\198\247\188\188\199\201"] then
    return false
  end
  if 0 <= JY.Thing[id]["\208\232\215\202\214\202"] then
    if JY.Thing[id]["\208\232\215\202\214\202"] > JY.Person[personid]["\215\202\214\202"] then
      return false
    end
  elseif -JY.Thing[id]["\208\232\215\202\214\202"] < JY.Person[personid]["\215\202\214\202"] then
    return false
  end
  return true
end

function UseThing_Type2(id)
  local yes = 0
  if 0 <= JY.Thing[id]["\202\185\211\195\200\203"] and DrawStrBoxYesNo(-1, -1, "\180\203\206\239\198\183\210\209\190\173\211\208\200\203\208\222\193\182\163\172\202\199\183\241\187\187\200\203\208\222\193\182?", C_WHITE, CC.DefaultFont) == false then
    Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
    ShowScreen()
    return 0
  end
  Cls()
  DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("\203\173\210\170\208\222\193\182%s?", JY.Thing[id]["\195\251\179\198"]), C_WHITE, CC.DefaultFont)
  local nexty = CC.MainSubMenuY + CC.SingleLineHeight
  local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
  if 0 < r then
    local personid = JY.Base["\182\211\206\233" .. r]
    if CC.BanBen == 1 then
      if 0 <= JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
        if JY.Thing[id]["\193\183\179\246\206\228\185\166"] >= 114 and JY.Thing[id]["\193\183\179\246\206\228\185\166"] <= 118 then
          for i = 1, 10 do
            if JY.Person[personid]["\206\228\185\166" .. i] == JY.Thing[id]["\193\183\179\246\206\228\185\166"] - 1 then
              local zzsx = math.modf(JY.Person[personid]["\215\202\214\202"] / 15)
              if zzsx + 114 < JY.Thing[id]["\193\183\179\246\206\228\185\166"] and 0 < personid then
                DrawStrBoxWaitKey("\180\203\200\203\206\222\183\168\193\236\187\225\184\223\201\238\206\228\209\167", C_WHITE, CC.DefaultFont)
                return 0
              end
              if JY.Person[personid]["\206\228\185\166\181\200\188\182" .. i] >= 900 and (CanUseThing(id, personid) or JY.Person[personid]["\180\250\186\197"] == 76) then
                JY.Person[personid]["\206\228\185\166" .. i] = JY.Thing[id]["\193\183\179\246\206\228\185\166"]
                JY.Person[personid]["\206\228\185\166\181\200\188\182" .. i] = 400
                local wgid1 = JY.Thing[id]["\193\183\179\246\206\228\185\166"] - 1
                local wgid2 = JY.Thing[id]["\193\183\179\246\206\228\185\166"]
                local wgmc1 = JY.Wugong[wgid1]["\195\251\179\198"]
                local wgmc2 = JY.Wugong[wgid2]["\195\251\179\198"]
                if JY.Thing[id - 1]["\202\185\211\195\200\203"] == personid then
                  JY.Thing[id - 1]["\202\185\211\195\200\203"] = -1
                end
                if 0 <= JY.Person[personid]["\208\222\193\182\206\239\198\183"] then
                  local oldid = JY.Person[personid]["\208\222\193\182\206\239\198\183"]
                  JY.Thing[oldid]["\202\185\211\195\200\203"] = -1
                end
                JY.Person[personid]["\208\222\193\182\206\239\198\183"] = id
                DrawStrBoxWaitKey(wgmc1 .. " \201\253\214\193 " .. wgmc2, C_WHITE, CC.DefaultFont)
                return 1
              elseif CanUseThing(id, personid) or JY.Person[personid]["\180\250\186\197"] == 76 then
                DrawStrBoxWaitKey("\208\222\193\18210\188\182\191\201\201\253\214\193\207\194\210\187\214\216", C_WHITE, CC.DefaultFont)
                return 0
              else
                DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\208\222\193\182\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
                return 0
              end
            end
          end
          for i = 1, 10 do
            if 114 <= JY.Person[personid]["\206\228\185\166" .. i] then
              if JY.Person[personid]["\206\228\185\166" .. i] < JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
                DrawStrBoxWaitKey("\177\216\208\235\180\211\181\205\214\216\191\170\202\188\208\222\193\182", C_WHITE, CC.DefaultFont)
                return 0
              elseif JY.Person[personid]["\206\228\185\166" .. i] > JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
                DrawStrBoxWaitKey("\215\212\180\180\206\228\185\166\206\222\183\168\189\181\214\216\208\222\193\182", C_WHITE, CC.DefaultFont)
                return 0
              end
            end
          end
          local ka = 0
          for i = 1, 10 do
            if ka < JY.Person[personid]["\206\228\185\166" .. i] then
              ka = JY.Person[personid]["\206\228\185\166" .. i]
            end
          end
          if ka < 114 and JY.Thing[id]["\193\183\179\246\206\228\185\166"] ~= 114 then
            DrawStrBoxWaitKey("\177\216\208\235\180\211\181\205\214\216\191\170\202\188\208\222\193\182", C_WHITE, CC.DefaultFont)
            return 0
          end
        end
        for i = 1, 10 do
          if JY.Person[personid]["\206\228\185\166" .. i] == JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
            yes = 1
            break
          end
        end
        if yes == 0 and 0 < JY.Person[personid]["\206\228\185\16610"] then
          DrawStrBoxWaitKey("\210\187\184\246\200\203\214\187\196\220\208\222\193\18210\214\214\206\228\185\166", C_WHITE, CC.DefaultFont)
          return 0
        end
      end
      if CanUseThing(id, personid) or yes == 1 or JY.Person[personid]["\180\250\186\197"] == 76 then
        if JY.Thing[id]["\202\185\211\195\200\203"] == personid then
          return 0
        end
      else
        DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\208\222\193\182\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
        return 0
      end
      if CC.Shemale[id] == 1 then
        if JY.Person[personid]["\208\212\177\240"] == 0 or JY.Person[personid]["\180\250\186\197"] == 76 then
          Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
          if DrawStrBoxYesNo(-1, -1, "\208\222\193\182\180\203\202\233\177\216\208\235\207\200\187\211\181\182\215\212\185\172\163\172\202\199\183\241\200\212\210\170\208\222\193\182?", C_WHITE, CC.DefaultFont) == false then
            return 0
          elseif JY.Person[personid].姓名 == "szlzw" then
            say("\163\181\163\210\211\251\193\183\201\241\185\166\161\161\187\211\181\182\215\212\185\172")
            say("\163\178\213\226\204\171\178\210\193\203\176\201\163\161\207\200\191\180\191\180\212\217\203\181....\163\200\163\168\183\173\181\189\207\194\210\187\210\179\163\169")
            say("\163\181\163\210\200\244\178\187\215\212\185\172\161\161\210\178\191\201\193\183\185\166")
            say("\163\177\185\254\163\172\212\173\192\180\178\187\215\212\185\172\210\178\196\220\193\183\176\161\163\161\163\200\204\171\176\244\193\203\163\161\163\161\163\161")
          elseif JY.Person[personid]["\180\250\186\197"] == 76 then
            TalkEx("\213\226\195\216\188\174\196\209\178\187\181\185\206\210\163\161", 76, 0)
            TalkEx("\212\218\213\226\192\239\215\247\208\169\208\222\184\196\188\180\191\201\163\161", 76, 0)
            TalkEx("\186\195\193\203\163\172\195\187\202\178\195\180\178\187\202\202\163\161", 76, 0)
          else
            JY.Person[personid]["\208\212\177\240"] = 2
          end
        elseif JY.Person[personid]["\208\212\177\240"] == 1 then
          DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\208\222\193\182\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
          return 0
        end
      end
      if 0 <= JY.Person[personid]["\208\222\193\182\206\239\198\183"] then
        JY.Thing[JY.Person[personid]["\208\222\193\182\206\239\198\183"]]["\202\185\211\195\200\203"] = -1
      end
      if 0 <= JY.Thing[id]["\202\185\211\195\200\203"] then
        JY.Person[JY.Thing[id]["\202\185\211\195\200\203"]]["\208\222\193\182\206\239\198\183"] = -1
      end
      JY.Thing[id]["\202\185\211\195\200\203"] = personid
      JY.Person[personid]["\208\222\193\182\206\239\198\183"] = id
    else
      if 0 <= JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
        for i = 1, 10 do
          if JY.Person[personid]["\206\228\185\166" .. i] == JY.Thing[id]["\193\183\179\246\206\228\185\166"] then
            yes = 1
            break
          end
        end
        if yes == 0 and 0 < JY.Person[personid]["\206\228\185\16610"] then
          DrawStrBoxWaitKey("\210\187\184\246\200\203\214\187\196\220\208\222\193\18210\214\214\206\228\185\166", C_WHITE, CC.DefaultFont)
          return 0
        end
      end
      if CanUseThing(id, personid) or yes == 1 then
        if JY.Thing[id]["\202\185\211\195\200\203"] == personid then
          return 0
        end
      else
        DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\208\222\193\182\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
        return 0
      end
      if CC.Shemale[id] == 1 then
        if JY.Person[personid]["\208\212\177\240"] == 0 then
          Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
          if DrawStrBoxYesNo(-1, -1, "\208\222\193\182\180\203\202\233\177\216\208\235\207\200\187\211\181\182\215\212\185\172\163\172\202\199\183\241\200\212\210\170\208\222\193\182?", C_WHITE, CC.DefaultFont) == false then
            return 0
          elseif JY.Person[0].姓名 == "szlzw" then
            say("\163\181\163\210\211\251\193\183\201\241\185\166\161\161\187\211\181\182\215\212\185\172")
            say("\163\178\213\226\204\171\178\210\193\203\176\201\163\161\207\200\191\180\191\180\212\217\203\181....\163\200\163\168\183\173\181\189\207\194\210\187\210\179\163\169")
            say("\163\181\163\210\200\244\178\187\215\212\185\172\161\161\210\178\191\201\193\183\185\166", 0)
            say("\163\177\185\254\163\172\212\173\192\180\178\187\215\212\185\172\210\178\196\220\193\183\176\161\163\161\163\200\204\171\176\244\193\203\163\161\163\161\163\161")
          else
            JY.Person[personid]["\208\212\177\240"] = 2
          end
        elseif JY.Person[personid]["\208\212\177\240"] == 1 then
          DrawStrBoxWaitKey("\180\203\200\203\178\187\202\202\186\207\208\222\193\182\180\203\206\239\198\183", C_WHITE, CC.DefaultFont)
          return 0
        end
      end
      if 0 <= JY.Person[personid]["\208\222\193\182\206\239\198\183"] then
        JY.Thing[JY.Person[personid]["\208\222\193\182\206\239\198\183"]]["\202\185\211\195\200\203"] = -1
      end
      if 0 <= JY.Thing[id]["\202\185\211\195\200\203"] then
        JY.Person[JY.Thing[id]["\202\185\211\195\200\203"]]["\208\222\193\182\206\239\198\183"] = -1
      end
      JY.Thing[id]["\202\185\211\195\200\203"] = personid
      JY.Person[personid]["\208\222\193\182\206\239\198\183"] = id
    end
  end
  return 1
end

function UseThing_Type3(id)
  local usepersonid = -1
  if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then
    Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("\203\173\210\170\202\185\211\195%s?", JY.Thing[id]["\195\251\179\198"]), C_WHITE, CC.DefaultFont)
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if 0 < r then
      usepersonid = JY.Base["\182\211\206\233" .. r]
    end
  elseif JY.Status == GAME_WMAP then
    usepersonid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  end
  if 0 <= usepersonid then
    if UseThingEffect(id, usepersonid) == 1 then
      instruct_32(id, -1)
      WaitKey()
    else
      return 0
    end
  end
  return 1
end

function UseThingEffect(id, personid)
  local str = {}
  str[0] = string.format("\202\185\211\195 %s", JY.Thing[id]["\195\251\179\198"])
  local strnum = 1
  local addvalue
  if 0 < JY.Thing[id]["\188\211\201\250\195\252"] then
    local add = JY.Thing[id]["\188\211\201\250\195\252"] - math.modf(JY.Person[personid]["\202\220\201\203\179\204\182\200"] / 2) + Rnd(10)
    if add <= 0 then
      add = 5 + Rnd(5)
    end
    local sscd = math.modf(JY.Thing[id]["\188\211\201\250\195\252"] / 4)
    local smadd = 0
    if sscd > JY.Person[personid]["\202\220\201\203\179\204\182\200"] then
      sscd = JY.Person[personid]["\202\220\201\203\179\204\182\200"]
    end
    if JY.Person[personid].生命 + add > JY.Person[personid]["\201\250\195\252\215\238\180\243\214\181"] then
      smadd = JY.Person[personid]["\201\250\195\252\215\238\180\243\214\181"] - JY.Person[personid].生命
    else
      smadd = add
    end
    addvalue, str[strnum] = AddPersonAttrib(personid, "\201\250\195\252", smadd)
    if addvalue ~= 0 then
      strnum = strnum + 1
    end
    addvalue, str[strnum] = AddPersonAttrib(personid, "\202\220\201\203\179\204\182\200", -sscd)
    if addvalue ~= 0 then
      strnum = strnum + 1
    end
  end
  
  local function ThingAddAttrib(s)
    if JY.Thing[id]["\188\211" .. s] ~= 0 then
      addvalue, str[strnum] = AddPersonAttrib(personid, s, JY.Thing[id]["\188\211" .. s])
      if addvalue ~= 0 then
        strnum = strnum + 1
      end
    end
  end
  
  ThingAddAttrib("\201\250\195\252\215\238\180\243\214\181")
  if 0 > JY.Thing[id]["\188\211\214\208\182\190\189\226\182\190"] then
    addvalue, str[strnum] = AddPersonAttrib(personid, "\214\208\182\190\179\204\182\200", math.modf(JY.Thing[id]["\188\211\214\208\182\190\189\226\182\190"] / 2))
    if addvalue ~= 0 then
      strnum = strnum + 1
    end
  end
  ThingAddAttrib("\204\229\193\166")
  if JY.Thing[id]["\184\196\177\228\196\218\193\166\208\212\214\202"] == 2 then
    str[strnum] = "\196\218\193\166\195\197\194\183\184\196\206\170\210\245\209\244\186\207\210\187"
    strnum = strnum + 1
  end
  ThingAddAttrib("\196\218\193\166")
  ThingAddAttrib("\196\218\193\166\215\238\180\243\214\181")
  ThingAddAttrib("\185\165\187\247\193\166")
  ThingAddAttrib("\183\192\211\249\193\166")
  ThingAddAttrib("\199\225\185\166")
  ThingAddAttrib("\210\189\193\198\196\220\193\166")
  ThingAddAttrib("\211\195\182\190\196\220\193\166")
  ThingAddAttrib("\189\226\182\190\196\220\193\166")
  ThingAddAttrib("\191\185\182\190\196\220\193\166")
  ThingAddAttrib("\200\173\213\198\185\166\183\242")
  ThingAddAttrib("\211\249\189\163\196\220\193\166")
  ThingAddAttrib("\203\163\181\182\188\188\199\201")
  ThingAddAttrib("\204\216\202\226\177\248\198\247")
  ThingAddAttrib("\176\181\198\247\188\188\199\201")
  ThingAddAttrib("\206\228\209\167\179\163\202\182")
  ThingAddAttrib("\185\165\187\247\180\248\182\190")
  if JY.Person[personid]["\191\185\182\190\196\220\193\166"] > 100 then
    JY.Person[personid]["\191\185\182\190\196\220\193\166"] = 100
  end
  if 1 < strnum then
    local maxlength = 0
    for i = 0, strnum - 1 do
      if maxlength < #str[i] then
        maxlength = #str[i]
      end
    end
    Cls()
    local ww = maxlength * CC.DefaultFont / 2 + CC.MenuBorderPixel * 2
    local hh = strnum * CC.DefaultFont + (strnum - 1) * CC.RowPixel + 2 * CC.MenuBorderPixel
    local x = (CC.ScreenW - ww) / 2
    local y = (CC.ScreenH - hh) / 2
    DrawBox(x, y, x + ww, y + hh, C_WHITE)
    DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel, str[0], C_WHITE, CC.DefaultFont)
    for i = 1, strnum - 1 do
      DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel + (CC.DefaultFont + CC.RowPixel) * i, str[i], C_ORANGE, CC.DefaultFont)
    end
    ShowScreen()
    return 1
  else
    return 0
  end
end

function UseThing_Type4(id)
  if JY.Status == GAME_WMAP then
    return War_UseAnqi(id)
  end
  return 0
end

function EventExecute(id, flag)
  JY.CurrentD = id
  if JY.SceneNewEventFunction[JY.SubScene] == nil then
    oldEventExecute(flag)
  else
    JY.SceneNewEventFunction[JY.SubScene](flag)
  end
  JY.CurrentD = -1
  JY.Darkness = 0
end

function oldEventExecute(flag)
  local eventnum
  if flag == 1 then
    eventnum = GetD(JY.SubScene, JY.CurrentD, 2)
  elseif flag == 2 then
    eventnum = GetD(JY.SubScene, JY.CurrentD, 3)
  elseif flag == 3 then
    eventnum = GetD(JY.SubScene, JY.CurrentD, 4)
  end
  if 0 < eventnum then
    oldCallEvent(eventnum)
  end
end

function oldCallEvent(eventnum)
  local eventname = string.format("oldevent_%d", eventnum)
  _G[eventname]()
  if CC.BanBen < 2 then
    for i = 0, 13 do
      for j = 0, 99 do
        if CC.GLTS[i][j] == eventnum then
          JY.GLTS[i][j] = 1
        end
      end
    end
  end
end

function ChangeMMap(x, y, direct)
  JY.Base.人X = x
  JY.Base.人Y = y
  JY.Base["\200\203\183\189\207\242"] = direct
end

function ChangeSMap(sceneid, x, y, direct)
  JY.SubScene = sceneid
  JY.Base.人X1 = x
  JY.Base.人Y1 = y
  JY.Base["\200\203\183\189\207\242"] = direct
end

function Cls(x1, y1, x2, y2)
  if x1 == nil then
    x1 = 0
    y1 = 0
    x2 = CC.ScreenW
    y2 = CC.ScreenH
  end
  lib.SetClip(x1, y1, x2, y2)
  if JY.Status == GAME_START then
    lib.FillColor(0, 0, 0, 0, 0)
    local zoom = CC.ScreenW / 1280 * 100
    lib.LoadPicture(CC.FirstFile, 0, 0, zoom)
  elseif JY.Status == GAME_MMAP then
    lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
  elseif JY.Status == GAME_SMAP then
    DrawSMap()
  elseif JY.Status == GAME_WMAP then
    WarDrawMap(0)
  elseif JY.Status == GAME_DEAD then
    lib.FillColor(0, 0, 0, 0, 0)
    lib.LoadPicture(CC.DeadFile, -1, -1)
  end
  lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
end

function GenTalkString(str, n)
  local tmpstr = ""
  for s in string.gmatch(str .. "*", "(.-)%*") do
    tmpstr = tmpstr .. s
  end
  local newstr = ""
  while 0 < #tmpstr do
    local w = 0
    while w < #tmpstr do
      local v = string.byte(tmpstr, w + 1)
      if 128 <= v then
        w = w + 2
      else
        w = w + 1
      end
      if w >= 2 * n - 1 then
        break
      end
    end
    if w < #tmpstr then
      if w == 2 * n - 1 and string.byte(tmpstr, w + 1) < 128 then
        newstr = newstr .. string.sub(tmpstr, 1, w + 1) .. "*"
        tmpstr = string.sub(tmpstr, w + 2, -1)
      else
        newstr = newstr .. string.sub(tmpstr, 1, w) .. "*"
        tmpstr = string.sub(tmpstr, w + 1, -1)
      end
    else
      newstr = newstr .. tmpstr
      break
    end
  end
  return newstr
end

function Talk(s, personid)
  local flag
  if personid == 0 then
    flag = 1
  else
    flag = 0
  end
  TalkEx(s, JY.Person[personid]["\205\183\207\241\180\250\186\197"], flag)
end

function TalkEx(s, headid, flag)
  local picw = 73 * CC.Zoom
  local pich = 73 * CC.Zoom
  local talkxnum = 18
  local talkynum = 3
  local dx = 0
  local dy = 0
  local boxpicw = picw + CC.PersonStateRowPixel
  local boxpich = pich + CC.PersonStateRowPixel
  local boxtalkw = 24 * CC.DefaultFont + CC.PersonStateRowPixel * 2
  local boxtalkh = boxpich
  local talkBorder = (pich - talkynum * CC.DefaultFont) / (talkynum + 1)
  local xy = {
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = CC.ScreenH - dy - boxpich,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = CC.ScreenH - dy - boxpich,
      showhead = 1
    },
    {
      headx = dx,
      heady = dy,
      talkx = dx + boxpicw + 2,
      talky = dy,
      showhead = 0
    },
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = CC.ScreenH - dy - boxpich,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = CC.ScreenH - dy - boxpich,
      showhead = 1
    },
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = dy,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = dy,
      showhead = 1
    },
    {
      headx = dx,
      heady = CC.ScreenH - dy - boxpich,
      talkx = dx + boxpicw + 2,
      talky = CC.ScreenH - dy - boxpich,
      showhead = 1
    },
    [0] = {
      headx = dx,
      heady = dy,
      talkx = dx + boxpicw + 2,
      talky = dy,
      showhead = 1
    }
  }
  if flag < 0 or 5 < flag then
    flag = 0
  end
  if xy[flag].showhead == 0 then
    headid = -1
  end
  s = string.gsub(s, "\r", "")
  s = GenTalkString(s, 24)
  if CONFIG.KeyRepeat == 0 then
    lib.EnableKeyRepeat(0, CONFIG.KeyRepeatInterval)
  end
  local startp = 1
  local endp
  local dy = 0
  local name, namex
  while true do
    if dy == 0 then
      Cls()
      if 0 <= headid then
        DrawBox(xy[flag].headx, xy[flag].heady, xy[flag].headx + boxpicw, xy[flag].heady + boxpich, C_WHITE)
        local personid
        for personid = 0, 999 do
          if JY.Person[personid] ~= nil then
            if JY.Person[personid]["\205\183\207\241\180\250\186\197"] == headid then
              name = JY.Person[personid].姓名
              break
            end
          else
            break
          end
        end
        if (headid == 0 or headid == CC.JSHead) and JY.Person[0].姓名 == "szlzw" then
          if existFile(CC.HeadPath .. CC.JSHead .. ".png") then
            JY.Person[0]["\205\183\207\241\180\250\186\197"] = CC.JSHead
            headid = CC.JSHead
            name = JY.Person[0].姓名
          else
            JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
            headid = 0
          end
        end
        if name ~= nil then
          namex = (picw - string.len(name) * CC.DefaultFont / 2) / 2
        end
        if existFile(CC.HeadPath .. headid .. ".png") then
          local w, h = lib.GetPNGXY(1, headid * 2)
          local hdmax = 0
          if w > hdmax then
            hdmax = w
          end
          if h > hdmax then
            hdmax = h
          end
          local zoom = math.modf(70 * CC.Zoom / hdmax * 100 * (CONFIG.Zoom / 100))
          local x = (picw - w * zoom / 100 / (CONFIG.Zoom / 100)) / 2
          local y = (pich - h * zoom / 100 / (CONFIG.Zoom / 100)) / 2
          if picw < w or pich < h then
            x = (picw - 70 * CC.Zoom) / 2
            y = (pich - 70 * CC.Zoom) / 2
          end
          lib.LoadPicture(CC.HeadPath .. headid .. ".png", xy[flag].headx + x + CC.PersonStateRowPixel / 2, xy[flag].heady + y + CC.PersonStateRowPixel / 2, zoom)
          JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
        else
          local w, h = lib.PicGetXY(1, headid * 2)
          local x = (picw - w) / 2
          local y = (pich - h) / 2
          lib.PicLoadCache(1, headid * 2, xy[flag].headx + x + CC.PersonStateRowPixel / 2, xy[flag].heady + y + CC.PersonStateRowPixel / 2, 1)
        end
      end
      DrawBox(xy[flag].talkx, xy[flag].talky, xy[flag].talkx + boxtalkw, xy[flag].talky + boxtalkh, C_WHITE)
    end
    endp = string.find(s, "*", startp)
    if endp == nil then
      DrawString(xy[flag].talkx + 5, xy[flag].talky + 5 + talkBorder + dy * (CC.DefaultFont + talkBorder), string.sub(s, startp), C_WHITE, CC.DefaultFont)
      if name ~= nil then
        if flag ~= 0 then
          DrawString(xy[flag].headx + namex, xy[flag].heady - CC.DefaultFont - CC.MenuBorderPixel, name, C_ORANGE, CC.DefaultFont)
        else
          DrawString(xy[flag].headx + namex, pich + CC.DefaultFont / 2, name, C_ORANGE, CC.DefaultFont)
        end
      end
      ShowScreen()
      WaitKey()
      Cls()
      break
    else
      DrawString(xy[flag].talkx + 5, xy[flag].talky + 5 + talkBorder + dy * (CC.DefaultFont + talkBorder), string.sub(s, startp, endp - 1), C_WHITE, CC.DefaultFont)
      if name ~= nil then
        if flag ~= 0 then
          DrawString(xy[flag].headx + namex, xy[flag].heady - CC.DefaultFont - CC.MenuBorderPixel, name, C_ORANGE, CC.DefaultFont)
        else
          DrawString(xy[flag].headx + namex, pich + CC.DefaultFont / 2, name, C_ORANGE, CC.DefaultFont)
        end
      end
    end
    dy = dy + 1
    startp = endp + 1
    if talkynum <= dy then
      ShowScreen()
      WaitKey()
      Cls()
      dy = 0
    end
  end
  if CONFIG.KeyRepeat == 0 then
    lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRepeatInterval)
  end
  Cls()
end

function instruct_test(s)
  DrawStrBoxWaitKey(s, C_ORANGE, 24)
end

function instruct_0()
  Cls()
end

function instruct_1(talkid, headid, flag)
  local s = ReadTalk(talkid)
  if s == nil then
    return
  end
  TalkEx(s, headid, flag)
end

function GenTalkIdx()
  os.remove(CC.TalkIdxFile)
  local p = io.open(CC.TalkIdxFile, "w")
  p:close()
  p = io.open(CC.TalkGrpFile, "r")
  local num = 0
  for line in p:lines() do
    num = num + 1
  end
  p:seek("set", 0)
  local data = Byte.create(num * 4)
  for i = 0, num - 1 do
    local talk = p:read("*line")
    local offset = p:seek()
    Byte.set32(data, i * 4, offset)
  end
  p:close()
  Byte.savefile(data, CC.TalkIdxFile, 0, num * 4)
end

function ReadTalk(talkid)
  local idxfile = CC.TalkIdxFile
  local grpfile = CC.TalkGrpFile
  local length = filelength(idxfile)
  if talkid < 0 and talkid >= length / 4 then
    return
  end
  local data = Byte.create(8)
  local id1, id2
  if talkid == 0 then
    Byte.loadfile(data, idxfile, 0, 4)
    id1 = 0
    id2 = Byte.get32(data, 0)
  else
    Byte.loadfile(data, idxfile, (talkid - 1) * 4, 8)
    id1 = Byte.get32(data, 0)
    id2 = Byte.get32(data, 4)
  end
  local p = io.open(grpfile, "r")
  p:seek("set", id1)
  local talk = p:read("*line")
  p:close()
  return talk
end

function instruct_2(thingid, num)
  if BL32PD == 1 then
    if X50BL32[1] == 1 then
      thingid = X50BL32[2]
    elseif X50BL32[1] == 2 then
      num = X50BL32[2]
    end
    BL32PD = 0
  end
  if JY.Thing[thingid] == nil then
    return
  end
  instruct_32(thingid, num)
  if CC.LoadThingPic == 0 and CC.FK ~= 1 then
    lib.PicLoadCache(0, (thingid + CC.StartThingPic) * 2, CC.ScreenW / 2 - CC.DefaultFont, CC.ScreenH / 2 + CC.DefaultFont, 2, 200)
  elseif CC.LoadThingPic == 1 then
    lib.PicLoadCache(2, thingid * 2, CC.ScreenW / 2 + CC.DefaultFont, CC.ScreenH / 2 + CC.DefaultFont * 3, 2, 200)
  elseif CC.LoadThingPic == 0 and CC.FK == 1 then
    lib.PicLoadCache(2, (thingid + CC.StartThingPic) * 2, CC.ScreenW / 2 - CC.DefaultFont, CC.ScreenH / 2 + CC.DefaultFont, 2, 200)
  end
  DrawStrBoxWaitKey(string.format("\181\195\181\189\206\239\198\183:%s x %d", JY.Thing[thingid]["\195\251\179\198"], num), C_ORANGE, CC.DefaultFont)
  instruct_2_sub()
  local booknum = 0
  for i = 1, CC.BookNum do
    if instruct_18(CC.BookStart + i - 1) == true then
      booknum = booknum + 1
    end
  end
  JY.Book = booknum
  if booknum == CC.BookNum then
    CC.ExpLevel = 3
    CC.RUNSTR[CC.NUMBER + 1] = "\204\236\202\233\210\209\202\213\188\175\205\234\179\201\163\172\181\177\199\176\190\173\209\233\214\181\210\209\180\243\183\249\182\200\212\246\188\211\163\172\193\183\185\166\191\241\178\187\200\221\180\237\185\253\163\161"
  else
    CC.RUNSTR[CC.NUMBER + 1] = string.format("\204\236\202\233\210\209\202\213\188\175%d\177\190\163\172\202\213\188\175\205\23414\177\190\204\236\202\233\190\173\209\233\214\181\189\171\180\243\183\249\182\200\212\246\188\211\163\172\193\183\185\166\191\241\178\187\200\221\180\237\185\253\163\161", booknum)
    CC.ExpLevel = 1
  end
end

function instruct_2_sub()
  if JY.Person[0].声望 < 200 then
    return
  end
  if instruct_18(189) == true then
    return
  end
  local booknum = 0
  for i = 1, CC.BookNum do
    if instruct_18(CC.BookStart + i - 1) == true then
      booknum = booknum + 1
    end
  end
  if booknum == CC.BookNum then
    instruct_3(70, 11, -1, 1, 932, -1, -1, 7968, 7968, 7968, -2, -2, -2)
  end
end

function instruct_3(sceneid, id, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
  if BL32PD == 1 then
    if X50BL32[1] == 1 then
      sceneid = X50BL32[2]
    elseif X50BL32[1] == 2 then
      id = X50BL32[2]
    elseif X50BL32[1] == 3 then
      v0 = X50BL32[2]
    elseif X50BL32[1] == 4 then
      v1 = X50BL32[2]
    elseif X50BL32[1] == 5 then
      v2 = X50BL32[2]
    elseif X50BL32[1] == 6 then
      v3 = X50BL32[2]
    elseif X50BL32[1] == 7 then
      v4 = X50BL32[2]
    elseif X50BL32[1] == 8 then
      v5 = X50BL32[2]
    elseif X50BL32[1] == 9 then
      v6 = X50BL32[2]
    elseif X50BL32[1] == 10 then
      v7 = X50BL32[2]
    elseif X50BL32[1] == 11 then
      v8 = X50BL32[2]
    elseif X50BL32[1] == 12 then
      v9 = X50BL32[2]
    elseif X50BL32[1] == 13 then
      v10 = X50BL32[2]
    end
    BL32PD = 0
  end
  if sceneid == -2 then
    sceneid = JY.SubScene
  end
  if id == -2 then
    id = JY.CurrentD
  end
  if v0 ~= -2 then
    SetD(sceneid, id, 0, v0)
  end
  if v1 ~= -2 then
    SetD(sceneid, id, 1, v1)
  end
  if v2 ~= -2 then
    SetD(sceneid, id, 2, v2)
  end
  if v3 ~= -2 then
    SetD(sceneid, id, 3, v3)
  end
  if v4 ~= -2 then
    SetD(sceneid, id, 4, v4)
  end
  if v5 ~= -2 then
    SetD(sceneid, id, 5, v5)
  end
  if v6 ~= -2 then
    SetD(sceneid, id, 6, v6)
  end
  if v7 ~= -2 then
    SetD(sceneid, id, 7, v7)
  end
  if v8 ~= -2 then
    SetD(sceneid, id, 8, v8)
  end
  if v9 ~= -2 and v10 ~= -2 and 0 < v9 and 0 < v10 then
    SetS(sceneid, GetD(sceneid, id, 9), GetD(sceneid, id, 10), 3, -1)
    SetD(sceneid, id, 9, v9)
    SetD(sceneid, id, 10, v10)
    SetS(sceneid, GetD(sceneid, id, 9), GetD(sceneid, id, 10), 3, id)
  end
end

function instruct_4(thingid)
  if JY.CurrentThing == thingid then
    return true
  else
    return false
  end
end

function instruct_5()
  return DrawStrBoxYesNo(-1, -1, "\202\199\183\241\211\235\214\174\185\253\213\208(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_6(warid, tmp, tmp, flag)
  return WarMain(warid, flag)
end

function instruct_7()
  instruct_test("\214\184\193\2387\178\226\202\212")
end

function instruct_8(musicid)
  JY.MmapMusic = musicid
end

function instruct_9()
  Cls()
  return DrawStrBoxYesNo(-1, -1, "\202\199\183\241\210\170\199\243\188\211\200\235(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_10(personid)
  if JY.Person[personid] == nil then
    lib.Debug("instruct_10 error: person id not exist")
    return
  end
  local add = 0
  for i = 2, CC.TeamNum do
    if 0 > JY.Base["\182\211\206\233" .. i] then
      JY.Base["\182\211\206\233" .. i] = personid
      add = 1
      break
    end
  end
  if add == 0 then
    lib.Debug("instruct_10 error: \188\211\200\235\182\211\206\233\210\209\194\250")
    return
  end
  for i = 1, 4 do
    local id = JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i]
    local n = JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i]
    if 0 <= id and 0 < n then
      instruct_2(id, n)
      JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i] = -1
      JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i] = 0
    end
  end
end

function instruct_11()
  Cls()
  if CC.BanBen == 0 then
    return DrawStrBoxYesNo(-1, -1, "\202\199\183\241\215\161\203\222(Y/N)?", C_ORANGE, CC.DefaultFont)
  else
    return DrawStrBoxYesNo(-1, -1, "\202\199\183\241(Y/N)?", C_ORANGE, CC.DefaultFont)
  end
end

function instruct_12()
  for i = 1, CC.TeamNum do
    local id = JY.Base["\182\211\206\233" .. i]
    if 0 <= id and JY.Person[id]["\202\220\201\203\179\204\182\200"] < 33 and 0 >= JY.Person[id]["\214\208\182\190\179\204\182\200"] then
      JY.Person[id]["\202\220\201\203\179\204\182\200"] = 0
      AddPersonAttrib(id, "\204\229\193\166", math.huge)
      AddPersonAttrib(id, "\201\250\195\252", math.huge)
      AddPersonAttrib(id, "\196\218\193\166", math.huge)
    end
  end
end

function instruct_13()
  JY.Darkness = 0
  lib.ShowSlow(50, 0)
  Cls()
end

function instruct_14()
  JY.Darkness = 0
  lib.ShowSlow(50, 1)
  Cls()
end

function instruct_15()
  JY.Status = GAME_DEAD
  Cls()
  DrawString(CC.GameOverX, CC.GameOverY, JY.Person[0].姓名, RGB(0, 0, 0), CC.DefaultFont)
  local x = CC.ScreenW - 9 * CC.DefaultFont
  DrawString(x, 10, os.date("%Y-%m-%d %H:%M"), RGB(216, 20, 24), CC.DefaultFont)
  DrawString(x, 10 + CC.DefaultFont + CC.RowPixel, "\212\218\181\216\199\242\181\196\196\179\180\166", RGB(216, 20, 24), CC.DefaultFont)
  DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 2, "\181\177\181\216\200\203\191\218\181\196\202\167\215\217\202\253", RGB(216, 20, 24), CC.DefaultFont)
  DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 3, "\211\214\182\224\193\203\210\187\177\202\161\163\161\163\161\163", RGB(216, 20, 24), CC.DefaultFont)
  ShowScreen()
  while true do
    DrawStrBox(CC.ScreenW / 2 - CC.DefaultFont * 3, CC.DefaultFont * 2, "\182\193\200\161\189\248\182\200\193\208\177\237", C_ORANGE, CC.DefaultFont)
    local r = SaveList(15)
    if 0 < r and r <= 11 and existFile(CC.S_Filename[r]) and existFile(CC.D_Filename[r]) then
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * 2, CC.StartMenuY, "\199\235\201\212\186\242...", C_RED, CC.StartMenuFontSize * 1.3)
      ShowScreen()
      LoadRecord(r)
      if 0 < JY.Base.无用 then
        if JY.Status == GAME_MMAP then
          lib.UnloadMMap()
          lib.PicInit()
        end
        lib.ShowSlow(50, 1)
        JY.Status = GAME_SMAP
        JY.SubScene = JY.Base.无用
        JY.MmapMusic = -1
        JY.MyPic = GetMyPic()
        Init_SMap(1)
        Game_Cycle()
        break
      end
      if JY.Base.无用 == 0 then
        if JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X1"] - 1 and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y1"] or JY.Base.人X == JY.Scene[0]["\205\226\190\176\200\235\191\218X2"] and JY.Base.人Y == JY.Scene[0]["\205\226\190\176\200\235\191\218Y2"] + 1 then
          if JY.Status == GAME_MMAP then
            lib.UnloadMMap()
            lib.PicInit()
          end
          lib.ShowSlow(50, 1)
          JY.Status = GAME_SMAP
          JY.SubScene = JY.Base.无用
          JY.MmapMusic = -1
          JY.MyPic = GetMyPic()
          Init_SMap(1)
          Game_Cycle()
          break
        end
        JY.SubScene = -1
        JY.Status = GAME_FIRSTMMAP
        Game_Cycle()
        break
      end
      JY.SubScene = -1
      JY.Status = GAME_FIRSTMMAP
      Game_Cycle()
      break
    elseif 11 < r then
      os.exit()
    end
  end
end

function instruct_16(personid)
  local r = false
  for i = 1, CC.TeamNum do
    if personid == JY.Base["\182\211\206\233" .. i] then
      r = true
      break
    end
  end
  return r
end

function instruct_17(sceneid, level, x, y, v)
  if sceneid == -2 then
    sceneid = JY.SubScene
  end
  SetS(sceneid, x, y, level, v)
end

function instruct_18(thingid)
  for i = 1, CC.MyThingNum do
    if JY.Base["\206\239\198\183" .. i] == thingid then
      return true
    end
  end
  return false
end

function instruct_19(x, y)
  JY.Base.人X1 = x
  JY.Base.人Y1 = y
  JY.SubSceneX = 0
  JY.SubSceneY = 0
end

function instruct_20()
  if JY.Base["\182\211\206\233" .. CC.TeamNum] >= 0 then
    return true
  end
  return false
end

function instruct_21(personid)
  if BL32PD == 1 then
    if X50BL32[1] == 1 then
      personid = X50BL32[2]
    end
    BL32PD = 0
  end
  if JY.Person[personid] == nil then
    lib.Debug("instruct_21 error: personid not exist")
    return
  end
  local j = 0
  for i = 1, CC.TeamNum do
    if personid == JY.Base["\182\211\206\233" .. i] then
      j = i
      break
    end
  end
  if j == 0 then
    return
  end
  for i = j + 1, CC.TeamNum do
    JY.Base["\182\211\206\233" .. i - 1] = JY.Base["\182\211\206\233" .. i]
  end
  JY.Base["\182\211\206\233" .. CC.TeamNum] = -1
end

function instruct_22()
  for i = 1, CC.TeamNum do
    if JY.Base["\182\211\206\233" .. i] >= 0 then
      JY.Person[JY.Base["\182\211\206\233" .. i]]["\196\218\193\166"] = 0
    end
  end
end

function instruct_23(personid, value)
  JY.Person[personid]["\211\195\182\190\196\220\193\166"] = value
  AddPersonAttrib(personid, "\211\195\182\190\196\220\193\166", 0)
end

function instruct_24()
  instruct_test("\214\184\193\23824\178\226\202\212")
end

function instruct_25(x1, y1, x2, y2)
  local sign
  if y1 ~= y2 then
    if y2 < y1 then
      sign = -1
    else
      sign = 1
    end
    for i = y1 + sign, y2, sign do
      local t1 = lib.GetTime()
      JY.SubSceneY = JY.SubSceneY + sign
      DrawSMap()
      ShowScreen()
      local t2 = lib.GetTime()
      if t2 - t1 < CC.SceneMoveFrame then
        lib.Delay(CC.SceneMoveFrame - (t2 - t1))
      end
    end
  end
  if x1 ~= x2 then
    if x2 < x1 then
      sign = -1
    else
      sign = 1
    end
    for i = x1 + sign, x2, sign do
      local t1 = lib.GetTime()
      JY.SubSceneX = JY.SubSceneX + sign
      DrawSMap()
      ShowScreen()
      local t2 = lib.GetTime()
      if t2 - t1 < CC.SceneMoveFrame then
        lib.Delay(CC.SceneMoveFrame - (t2 - t1))
      end
    end
  end
end

function instruct_26(sceneid, id, v1, v2, v3)
  if sceneid == -2 then
    sceneid = JY.SubScene
  end
  local v = GetD(sceneid, id, 2)
  SetD(sceneid, id, 2, v + v1)
  v = GetD(sceneid, id, 3)
  SetD(sceneid, id, 3, v + v2)
  v = GetD(sceneid, id, 4)
  SetD(sceneid, id, 4, v + v3)
end

function instruct_27(id, startpic, endpic)
  local old1, old2, old3
  if id ~= -1 then
    old1 = GetD(JY.SubScene, id, 5)
    old2 = GetD(JY.SubScene, id, 6)
    old3 = GetD(JY.SubScene, id, 7)
  end
  Cls()
  ShowScreen()
  for i = startpic, endpic, 2 do
    local t1 = lib.GetTime()
    if id == -1 then
      JY.MyPic = i / 2
    else
      SetD(JY.SubScene, id, 5, i)
      SetD(JY.SubScene, id, 6, i)
      SetD(JY.SubScene, id, 7, i)
    end
    DtoSMap()
    DrawSMap()
    ShowScreen()
    local t2 = lib.GetTime()
    if t2 - t1 < CC.AnimationFrame then
      lib.Delay(CC.AnimationFrame - (t2 - t1))
    end
  end
  if id ~= -1 then
    SetD(JY.SubScene, id, 5, old1)
    SetD(JY.SubScene, id, 6, old2)
    SetD(JY.SubScene, id, 7, old3)
  end
end

function instruct_28(personid, vmin, vmax)
  local v = JY.Person[personid]["\198\183\181\194"]
  if vmin <= v and vmax >= v then
    return true
  else
    return false
  end
end

function instruct_29(personid, vmin, vmax)
  local v = JY.Person[personid]["\185\165\187\247\193\166"]
  if vmin <= v and vmax >= v then
    return true
  else
    return false
  end
end

function instruct_30(x1, y1, x2, y2)
  if x1 < x2 then
    for i = x1 + 1, x2 do
      local t1 = lib.GetTime()
      instruct_30_sub(1)
      local t2 = lib.GetTime()
      if t2 - t1 < CC.PersonMoveFrame then
        lib.Delay(CC.PersonMoveFrame - (t2 - t1))
      end
    end
  elseif x2 < x1 then
    for i = x2 + 1, x1 do
      local t1 = lib.GetTime()
      instruct_30_sub(2)
      local t2 = lib.GetTime()
      if t2 - t1 < CC.PersonMoveFrame then
        lib.Delay(CC.PersonMoveFrame - (t2 - t1))
      end
    end
  end
  if y1 < y2 then
    for i = y1 + 1, y2 do
      local t1 = lib.GetTime()
      instruct_30_sub(3)
      local t2 = lib.GetTime()
      if t2 - t1 < CC.PersonMoveFrame then
        lib.Delay(CC.PersonMoveFrame - (t2 - t1))
      end
    end
  elseif y2 < y1 then
    for i = y2 + 1, y1 do
      local t1 = lib.GetTime()
      instruct_30_sub(0)
      local t2 = lib.GetTime()
      if t2 - t1 < CC.PersonMoveFrame then
        lib.Delay(CC.PersonMoveFrame - (t2 - t1))
      end
    end
  end
end

function instruct_30_sub(direct)
  local x, y
  AddMyCurrentPic()
  x = JY.Base.人X1 + CC.DirectX[direct + 1]
  y = JY.Base.人Y1 + CC.DirectY[direct + 1]
  JY.Base["\200\203\183\189\207\242"] = direct
  JY.MyPic = GetMyPic()
  DtoSMap()
  if SceneCanPass(x, y) == true then
    JY.Base.人X1 = x
    JY.Base.人Y1 = y
  end
  JY.Base.人X1 = limitX(JY.Base.人X1, 1, CC.SWidth - 2)
  JY.Base.人Y1 = limitX(JY.Base.人Y1, 1, CC.SHeight - 2)
  DrawSMap()
  Cls()
  ShowScreen()
end

function instruct_31(num)
  if BL32PD == 1 then
    if X50BL32[1] == 1 then
      num = X50BL32[2]
    end
    BL32PD = 0
  end
  local r = false
  for i = 1, CC.MyThingNum do
    if JY.Base["\206\239\198\183" .. i] == CC.MoneyID then
      if num <= JY.Base["\206\239\198\183\202\253\193\191" .. i] then
        r = true
      end
      break
    end
  end
  return r
end

function instruct_32(thingid, num)
  if BL32PD == 1 then
    if X50BL32[1] == 1 then
      thingid = X50BL32[2]
    elseif X50BL32[1] == 2 then
      num = X50BL32[2]
    end
    BL32PD = 0
  end
  local p = 1
  for i = 1, CC.MyThingNum do
    if JY.Base["\206\239\198\183" .. i] == thingid then
      JY.Base["\206\239\198\183\202\253\193\191" .. i] = JY.Base["\206\239\198\183\202\253\193\191" .. i] + num
      p = i
      break
    elseif JY.Base["\206\239\198\183" .. i] == -1 then
      JY.Base["\206\239\198\183" .. i] = thingid
      JY.Base["\206\239\198\183\202\253\193\191" .. i] = num
      p = 1
      break
    end
  end
  if 0 >= JY.Base["\206\239\198\183\202\253\193\191" .. p] then
    for i = p + 1, CC.MyThingNum do
      JY.Base["\206\239\198\183" .. i - 1] = JY.Base["\206\239\198\183" .. i]
      JY.Base["\206\239\198\183\202\253\193\191" .. i - 1] = JY.Base["\206\239\198\183\202\253\193\191" .. i]
    end
    JY.Base["\206\239\198\183" .. CC.MyThingNum] = -1
    JY.Base["\206\239\198\183\202\253\193\191" .. CC.MyThingNum] = 0
  end
end

function instruct_33(personid, wugongid, flag)
  local add = 0
  for i = 1, 10 do
    if JY.Person[personid]["\206\228\185\166" .. i] == 0 then
      JY.Person[personid]["\206\228\185\166" .. i] = wugongid
      JY.Person[personid]["\206\228\185\166\181\200\188\182" .. i] = 0
      add = 1
      break
    end
  end
  if add == 0 then
    JY.Person[personid]["\206\228\185\16610"] = wugongid
    JY.Person[personid]["\206\228\185\166\181\200\188\18210"] = 0
  end
  if flag == 0 then
    DrawStrBoxWaitKey(string.format("%s \209\167\187\225\206\228\185\166 %s", JY.Person[personid].姓名, JY.Wugong[wugongid]["\195\251\179\198"]), C_ORANGE, CC.DefaultFont)
  end
end

function instruct_34(id, value)
  local add, str = AddPersonAttrib(id, "\215\202\214\202", value)
  DrawStrBoxWaitKey(JY.Person[id].姓名 .. str, C_ORANGE, CC.DefaultFont)
end

function instruct_35(personid, id, wugongid, wugonglevel)
  if 0 <= id then
    JY.Person[personid]["\206\228\185\166" .. id + 1] = wugongid
    JY.Person[personid]["\206\228\185\166\181\200\188\182" .. id + 1] = wugonglevel
  else
    local flag = 0
    for i = 1, 10 do
      if JY.Person[personid]["\206\228\185\166" .. i] == 0 then
        flag = 1
        JY.Person[personid]["\206\228\185\166" .. i] = wugongid
        JY.Person[personid]["\206\228\185\166\181\200\188\182" .. i] = wugonglevel
        return
      end
    end
    if flag == 0 then
      JY.Person[personid]["\206\228\185\166" .. 1] = wugongid
      JY.Person[personid]["\206\228\185\166\181\200\188\182" .. 1] = wugonglevel
      DrawStrBoxWaitKey(string.format("%s \209\167\187\225\206\228\185\166 %s", JY.Person[personid].姓名, JY.Wugong[wugongid]["\195\251\179\198"]), C_ORANGE, CC.DefaultFont)
    end
  end
end

function instruct_36(sex, id1, id2)
  if id1 == nil or id2 == nil then
    if JY.Person[0]["\208\212\177\240"] == sex then
      return true
    else
      return false
    end
  elseif 256 <= sex then
    if id1 == 0 and id2 < 0 or id1 == 0 and 0 < id2 then
      if X50JMP == 0 then
        return true
      else
        return false
      end
    elseif id1 < 0 and id2 == 0 or 0 < id1 and id2 == 0 then
      if X50JMP == 0 then
        return true
      else
        return false
      end
    end
  end
end

function instruct_37(v)
  AddPersonAttrib(0, "\198\183\181\194", v)
  if 0 < v then
    DrawStrBox(-1, 10, string.format("\198\183\181\194 +%d", v), C_GOLD, CC.DefaultFont)
    ShowScreen()
    lib.Delay(500)
  else
    DrawStrBox(-1, 10, string.format("\198\183\181\194 %d", v), C_RED, CC.DefaultFont)
    ShowScreen()
    lib.Delay(500)
  end
end

function instruct_38(sceneid, level, oldpic, newpic)
  if sceneid == -2 then
    sceneid = JY.SubScene
  end
  for i = 0, CC.SWidth - 1 do
    for j = 1, CC.SHeight - 1 do
      if GetS(sceneid, i, j, level) == oldpic then
        SetS(sceneid, i, j, level, newpic)
      end
    end
  end
end

function instruct_39(sceneid)
  JY.Scene[sceneid]["\189\248\200\235\204\245\188\254"] = 0
end

function instruct_40(v)
  JY.Base["\200\203\183\189\207\242"] = v
  JY.MyPic = GetMyPic()
end

function instruct_41(personid, thingid, num)
  local k = 0
  for i = 1, 4 do
    if JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i] == thingid then
      JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i] = JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i] + num
      k = i
      break
    end
  end
  if 0 < k and 0 >= JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. k] then
    for i = k + 1, 4 do
      JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i - 1] = JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i]
      JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i - 1] = JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i]
    end
    JY.Person[personid]["\208\175\180\248\206\239\198\183" .. 4] = -1
    JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. 4] = 0
  end
  if k == 0 then
    for i = 1, 4 do
      if JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i] == -1 then
        JY.Person[personid]["\208\175\180\248\206\239\198\183" .. i] = thingid
        JY.Person[personid]["\208\175\180\248\206\239\198\183\202\253\193\191" .. i] = num
        break
      end
    end
  end
end

function instruct_42()
  local r = false
  for i = 1, CC.TeamNum do
    if JY.Base["\182\211\206\233" .. i] >= 0 and JY.Person[JY.Base["\182\211\206\233" .. i]]["\208\212\177\240"] == 1 then
      r = true
    end
  end
  return r
end

function instruct_43(thingid)
  return instruct_18(thingid)
end

function instruct_44(id1, startpic1, endpic1, id2, startpic2, endpic2)
  local old1 = GetD(JY.SubScene, id1, 5)
  local old2 = GetD(JY.SubScene, id1, 6)
  local old3 = GetD(JY.SubScene, id1, 7)
  local old4 = GetD(JY.SubScene, id2, 5)
  local old5 = GetD(JY.SubScene, id2, 6)
  local old6 = GetD(JY.SubScene, id2, 7)
  for i = startpic1, endpic1, 2 do
    local t1 = lib.GetTime()
    if id1 == -1 then
      JY.MyPic = i / 2
    else
      SetD(JY.SubScene, id1, 5, i)
      SetD(JY.SubScene, id1, 6, i)
      SetD(JY.SubScene, id1, 7, i)
    end
    if id2 == -1 then
      JY.MyPic = i / 2
    else
      SetD(JY.SubScene, id2, 5, i - startpic1 + startpic2)
      SetD(JY.SubScene, id2, 6, i - startpic1 + startpic2)
      SetD(JY.SubScene, id2, 7, i - startpic1 + startpic2)
    end
    DtoSMap()
    DrawSMap()
    ShowScreen()
    local t2 = lib.GetTime()
    if t2 - t1 < CC.AnimationFrame then
      lib.Delay(CC.AnimationFrame - (t2 - t1))
    end
  end
  SetD(JY.SubScene, id1, 5, old1)
  SetD(JY.SubScene, id1, 6, old2)
  SetD(JY.SubScene, id1, 7, old3)
  SetD(JY.SubScene, id2, 5, old4)
  SetD(JY.SubScene, id2, 6, old5)
  SetD(JY.SubScene, id2, 7, old6)
end

function instruct_45(id, value)
  local add, str = AddPersonAttrib(id, "\199\225\185\166", value)
  DrawStrBoxWaitKey(JY.Person[id].姓名 .. str, C_ORANGE, CC.DefaultFont)
end

function instruct_46(id, value)
  local add, str = AddPersonAttrib(id, "\196\218\193\166\215\238\180\243\214\181", value)
  AddPersonAttrib(id, "\196\218\193\166", 0)
  DrawStrBoxWaitKey(JY.Person[id].姓名 .. str, C_ORANGE, CC.DefaultFont)
end

function instruct_47(id, value)
  local add, str = AddPersonAttrib(id, "\185\165\187\247\193\166", value)
  DrawStrBoxWaitKey(JY.Person[id].姓名 .. str, C_ORANGE, CC.DefaultFont)
end

function instruct_48(id, value)
  local add, str = AddPersonAttrib(id, "\201\250\195\252\215\238\180\243\214\181", value)
  AddPersonAttrib(id, "\201\250\195\252", 0)
  if instruct_16(id) == true then
    DrawStrBoxWaitKey(JY.Person[id].姓名 .. str, C_ORANGE, CC.DefaultFont)
  end
end

function instruct_49(personid, value)
  JY.Person[personid]["\196\218\193\166\208\212\214\202"] = value
end

function instruct_50(id1, id2, id3, id4, id5, id6, id7)
  if CC.BanBen ~= 2 then
    local num = 0
    if instruct_18(id1) == true then
      num = num + 1
    end
    if instruct_18(id2) == true then
      num = num + 1
    end
    if instruct_18(id3) == true then
      num = num + 1
    end
    if instruct_18(id4) == true then
      num = num + 1
    end
    if instruct_18(id5) == true then
      num = num + 1
    end
    if num == 5 then
      return true
    else
      return false
    end
  elseif CC.BanBen == 2 then
    if BL32PD == 1 then
      if X50BL32[1] == 1 then
        id1 = X50BL32[2]
      elseif X50BL32[1] == 2 then
        id2 = X50BL32[2]
      elseif X50BL32[1] == 3 then
        id3 = X50BL32[2]
      elseif X50BL32[1] == 4 then
        id4 = X50BL32[2]
      elseif X50BL32[1] == 5 then
        id5 = X50BL32[2]
      elseif X50BL32[1] == 6 then
        id6 = X50BL32[2]
      elseif X50BL32[1] == 7 then
        id7 = X50BL32[2]
      end
      BL32PD = 0
    end
    if id1 == 0 then
      X50[id2] = id3
    elseif id1 == 1 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      local idbl
      idbl = id4
      if XB50[idbl] == nil then
        XB50[idbl] = {}
      end
      if id2 == 0 then
        XB50[idbl][id5] = math.modf(id6)
      elseif id2 == 1 then
        XB50[idbl][X50[id5]] = math.modf(id6)
      elseif id2 == 2 then
        XB50[idbl][id5] = math.modf(X50[id6])
      elseif id2 == 3 then
        XB50[idbl][X50[id5]] = math.modf(X50[id6])
      end
    elseif id1 == 2 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      id2 = id2 % 2
      if id2 == 0 then
        X50[id6] = XB50[id4][id5]
      elseif id2 == 1 then
        X50[id6] = XB50[id4][X50[id5]]
      end
    elseif id1 == 3 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      id2 = id2 % 2
      local idbl
      if id2 == 0 then
        idbl = id6
      elseif id2 == 1 then
        idbl = X50[id6]
      end
      if id3 == 0 then
        X50[id4] = X50[id5] + idbl
      elseif id3 == 1 then
        X50[id4] = X50[id5] - idbl
      elseif id3 == 2 then
        X50[id4] = X50[id5] * idbl
      elseif id3 == 3 then
        X50[id4] = X50[id5] / idbl
      elseif id3 == 4 then
        X50[id4] = X50[id5] % idbl
      end
    elseif id1 == 4 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      if id2 == 0 then
        if id3 == 0 then
          if id5 > X50[id4] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 1 then
          if id5 >= X50[id4] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 2 then
          if X50[id4] == id5 then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 3 then
          if X50[id4] ~= id5 then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 4 then
          if id5 <= X50[id4] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 5 then
          if id5 < X50[id4] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 6 then
          X50JMP = 0
        elseif id3 == 7 then
          X50JMP = 1
        end
      elseif id2 == 1 then
        if id3 == 0 then
          if X50[id4] < X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 1 then
          if X50[id4] <= X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 2 then
          if X50[id4] == X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 3 then
          if X50[id4] ~= X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 4 then
          if X50[id4] >= X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 5 then
          if X50[id4] > X50[id5] then
            X50JMP = 0
          else
            X50JMP = 1
          end
        elseif id3 == 6 then
          X50JMP = 0
        elseif id3 == 7 then
          X50JMP = 1
        end
      end
    elseif id1 == 5 then
      X50 = {}
      XB50 = {}
      X50STR = {}
    elseif id1 == 6 then
      X50[id2] = 0
    elseif id1 == 7 then
    elseif id1 == 8 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      if id2 == 0 then
        X50STR[id4] = ReadTalk(id3)
        X50STR[id4] = string.gsub(X50STR[id4], "\r", "")
        X50STR[id4] = string.gsub(X50STR[id4], "*", "")
      elseif id2 == 1 then
        X50STR[id4] = ReadTalk(X50[id3])
        X50STR[id4] = string.gsub(X50STR[id4], "\r", "")
        X50STR[id4] = string.gsub(X50STR[id4], "*", "")
      end
    elseif id1 == 9 then
      if X50STR[id4] == "%d" then
        X50STR[id3] = tostring(X50[id5])
      end
    elseif id1 == 10 then
      X50[id3] = #X50STR[id2]
    elseif id1 == 11 then
      X50STR[id2] = X50STR[id3] .. X50STR[id4]
    elseif id1 == 12 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      local idbl
      if id2 == 0 then
        idbl = id4
      elseif id2 == 1 then
        idbl = X50[id4]
      end
      X50STR[id3] = ""
      for i = 0, idbl do
        X50STR[id3] = X50STR[id3] .. " "
      end
    elseif id1 == 16 then
      X50ZL16(id1, id2, id3, id4, id5, id6, id7)
    elseif id1 == 17 then
      X50ZL17(id1, id2, id3, id4, id5, id6, id7)
    elseif id1 == 18 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      if id2 == 0 then
        JY.Base["\182\211\206\233" .. id3 + 1] = id4
      elseif id2 == 1 then
        JY.Base["\182\211\206\233" .. X50[id3] + 1] = id4
      elseif id2 == 2 then
        JY.Base["\182\211\206\233" .. id3 + 1] = X50[id4]
      elseif id2 == 3 then
        JY.Base["\182\211\206\233" .. X50[id3] + 1] = X50[id4]
      end
    elseif id1 == 19 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      if id2 == 0 then
        X50[id4] = JY.Base["\182\211\206\233" .. id3 + 1]
      elseif id2 == 1 then
        X50[id4] = JY.Base["\182\211\206\233" .. X50[id3] + 1]
      end
    elseif id1 == 20 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      local idbl
      if id2 == 0 then
        idbl = id3
      elseif id2 == 1 then
        idbl = X50[id3]
      end
      if instruct_18(idbl) then
        for i = 1, CC.MyThingNum do
          if JY.Base["\206\239\198\183" .. i] == idbl then
            X50[id4] = JY.Base["\206\239\198\183\202\253\193\191" .. i]
            break
          end
        end
      else
        X50[id4] = 0
      end
    elseif id1 == 27 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      if id2 == 0 then
        if id3 == 0 then
          X50STR[id5] = JY.Person[id4].姓名
        elseif id3 == 1 then
          X50STR[id5] = JY.Thing[id4]["\195\251\179\198"]
        elseif id3 == 2 then
          X50STR[id5] = JY.Scene[id4]["\195\251\179\198"]
        elseif id3 == 3 then
          X50STR[id5] = JY.Wugong[id4]["\195\251\179\198"]
        end
      elseif id2 == 1 then
        if id3 == 0 then
          X50STR[id5] = JY.Person[X50[id4]].姓名
        elseif id3 == 1 then
          X50STR[id5] = JY.Thing[X50[id4]]["\195\251\179\198"]
        elseif id3 == 2 then
          X50STR[id5] = JY.Scene[X50[id4]]["\195\251\179\198"]
        elseif id3 == 3 then
          X50STR[id5] = JY.Wugong[X50[id4]]["\195\251\179\198"]
        end
      end
    elseif id1 == 32 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      id2 = id2 % 4
      id2 = id2 % 2
      if id2 == 0 then
        X50BL32[1] = id4
        X50BL32[2] = X50[id3]
        BL32PD = 1
      elseif id2 == 1 then
        X50BL32[1] = X50[id4]
        X50BL32[2] = X50[id3]
        BL32PD = 1
      end
    elseif id1 == 33 then
      local strlen = #X50STR[id3] / 4 * CC.DefaultFont
      DrawStrBox(CC.ScreenW / 2 - strlen, CC.ScreenH / 2 - CC.DefaultFont * 4, X50STR[id3], C_GOLD, CC.DefaultFont)
    elseif id1 == 36 then
      if string.find(X50STR[id3], "\163\217\163\175\163\206") ~= nil then
        if DrawStrBoxYesNo(-1, -1, string.gsub(X50STR[id3], "\r", ""), C_WHITE, CC.DefaultFont) then
          X50JMP = 0
        else
          X50JMP = 1
        end
      else
        DrawStrBoxWaitKey(string.gsub(X50STR[id3], "\r", ""), C_WHITE, CC.DefaultFont)
      end
    elseif id1 == 38 then
      if id2 == 0 then
        X50[id4] = Rnd(id3)
      elseif id2 == 1 then
        X50[id4] = Rnd(X50[id3])
      end
    elseif id1 == 39 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      local idbl1, idbl2, idbl3
      if id2 == 0 then
        idbl1 = id3
        idbl2 = id6
        idbl3 = id7
      elseif id2 == 1 then
        idbl1 = X50[id3]
        idbl2 = id6
        idbl3 = id7
      elseif id2 == 2 then
        idbl1 = id3
        idbl2 = X50[id6]
        idbl3 = id7
      elseif id2 == 3 then
        idbl1 = X50[id3]
        idbl2 = X50[id6]
        idbl3 = id7
      elseif id2 == 4 then
        idbl1 = id3
        idbl2 = id6
        idbl3 = X50[id7]
      elseif id2 == 5 then
        idbl1 = X50[id3]
        idbl2 = id6
        idbl3 = X50[id7]
      elseif id2 == 6 then
        idbl1 = id3
        idbl2 = X50[id6]
        idbl3 = X50[id7]
      elseif id2 == 7 then
        idbl1 = X50[id3]
        idbl2 = X50[id6]
        idbl3 = X50[id7]
      end
      local menu = {}
      local maxl = 0
      for i = 1, idbl1 do
        menu[i] = {
          string.gsub(X50STR[XB50[id4][i - 1]], "\r", ""),
          nil,
          1
        }
        if maxl < #X50STR[XB50[id4][i - 1]] then
          maxl = #X50STR[XB50[id4][i - 1]]
        end
      end
      local size = CC.DefaultFont
      local mx = CC.ScreenW / 2 - maxl / 4 * size
      local my = CC.ScreenH / 2 - size * 2
      local r = ShowMenu(menu, idbl1, 0, mx, my, 0, 0, 1, 1, size, C_ORANGE, C_WHITE)
      X50[id5] = r
      if r == 0 then
        Cls()
      end
    elseif id1 == 40 then
      id2 = id2 % 256
      id2 = id2 % 16
      id2 = id2 % 8
      local idbl1, idbl2, idbl3
      if id2 == 0 then
        idbl1 = id3
        idbl2 = id6
        idbl3 = id7
      elseif id2 == 1 then
        idbl1 = X50[id3]
        idbl2 = id6
        idbl3 = id7
      elseif id2 == 2 then
        idbl1 = id3
        idbl2 = X50[id6]
        idbl3 = id7
      elseif id2 == 3 then
        idbl1 = X50[id3]
        idbl2 = X50[id6]
        idbl3 = id7
      elseif id2 == 4 then
        idbl1 = id3
        idbl2 = id6
        idbl3 = X50[id7]
      elseif id2 == 5 then
        idbl1 = X50[id3]
        idbl2 = id6
        idbl3 = X50[id7]
      elseif id2 == 6 then
        idbl1 = id3
        idbl2 = X50[id6]
        idbl3 = X50[id7]
      elseif id2 == 7 then
        idbl1 = X50[id3]
        idbl2 = X50[id6]
        idbl3 = X50[id7]
      end
      local menu = {}
      local maxl = 0
      for i = 1, idbl1 do
        menu[i] = {
          string.gsub(X50STR[XB50[id4][i - 1]], "\r", ""),
          nil,
          1
        }
        if maxl < #X50STR[XB50[id4][i - 1]] then
          maxl = #X50STR[XB50[id4][i - 1]]
        end
      end
      local size = CC.DefaultFont
      local mx = CC.ScreenW / 2 - maxl / 4 * size
      local my = CC.ScreenH / 2 - size * 2
      local r = ShowMenu(menu, idbl1, 0, mx, my, 0, 0, 1, 1, size, C_ORANGE, C_WHITE)
      X50[id5] = r
      if r == 0 then
        Cls()
      end
    end
  end
end

function instruct_51()
  instruct_1(2547 + Rnd(18), 114, 0)
end

function instruct_52()
  DrawStrBoxWaitKey(string.format("\196\227\207\214\212\218\181\196\198\183\181\194\214\184\202\253\206\170: %d", JY.Person[0]["\198\183\181\194"]), C_ORANGE, CC.DefaultFont)
end

function instruct_53()
  DrawStrBoxWaitKey(string.format("\196\227\207\214\212\218\181\196\201\249\205\251\214\184\202\253\206\170: %d", JY.Person[0].声望), C_ORANGE, CC.DefaultFont)
end

function instruct_54()
  for i = 0, JY.SceneNum - 1 do
    JY.Scene[i]["\189\248\200\235\204\245\188\254"] = 0
  end
  JY.Scene[2]["\189\248\200\235\204\245\188\254"] = 2
  JY.Scene[38]["\189\248\200\235\204\245\188\254"] = 2
  JY.Scene[75]["\189\248\200\235\204\245\188\254"] = 1
  JY.Scene[80]["\189\248\200\235\204\245\188\254"] = 1
end

function instruct_55(id, num)
  if GetD(JY.SubScene, id, 2) == num then
    return true
  else
    return false
  end
end

function instruct_56(v)
  JY.Person[0].声望 = JY.Person[0].声望 + v
  instruct_2_sub()
end

function instruct_57()
  instruct_27(-1, 7664, 7674)
  for i = 0, 56, 2 do
    local t1 = lib.GetTime()
    if JY.MyPic < 3844 then
      JY.MyPic = (7676 + i) / 2
    end
    SetD(JY.SubScene, 2, 5, i + 7690)
    SetD(JY.SubScene, 2, 6, i + 7690)
    SetD(JY.SubScene, 2, 7, i + 7690)
    SetD(JY.SubScene, 3, 5, i + 7748)
    SetD(JY.SubScene, 3, 6, i + 7748)
    SetD(JY.SubScene, 3, 7, i + 7748)
    SetD(JY.SubScene, 4, 5, i + 7806)
    SetD(JY.SubScene, 4, 6, i + 7806)
    SetD(JY.SubScene, 4, 7, i + 7806)
    DtoSMap()
    DrawSMap()
    ShowScreen()
    local t2 = lib.GetTime()
    if t2 - t1 < CC.AnimationFrame then
      lib.Delay(CC.AnimationFrame - (t2 - t1))
    end
  end
end

function instruct_58()
  local group = 5
  local num1 = 6
  local num2 = 3
  local startwar = 102
  local flag = {}
  for i = 0, group - 1 do
    for j = 0, num1 - 1 do
      flag[j] = 0
    end
    for j = 1, num2 do
      local r
      while true do
        r = Rnd(num1)
        if flag[r] == 0 then
          flag[r] = 1
          break
        end
      end
      local warnum = r + i * num1
      WarLoad(warnum + startwar)
      instruct_1(2854 + warnum, JY.Person[WAR.Data.敌人1]["\205\183\207\241\180\250\186\197"], 0)
      instruct_0()
      if WarMain(warnum + startwar, 0) == true then
        instruct_0()
        instruct_13()
        TalkEx("\187\185\211\208\196\199\206\187\199\176\177\178\191\207\180\205\189\204\163\191", 0, 1)
        instruct_0()
      else
        instruct_15()
        return
      end
    end
    if i < group - 1 then
      TalkEx("\201\217\207\192\210\209\193\172\213\189\200\253\179\161\163\172*\191\201\207\200\208\221\207\162\212\217\213\189\163\174", 70, 0)
      instruct_0()
      instruct_14()
      lib.Delay(300)
      if JY.Person[0]["\202\220\201\203\179\204\182\200"] < 50 and 0 >= JY.Person[0]["\214\208\182\190\179\204\182\200"] then
        JY.Person[0]["\202\220\201\203\179\204\182\200"] = 0
        AddPersonAttrib(0, "\204\229\193\166", math.huge)
        AddPersonAttrib(0, "\196\218\193\166", math.huge)
        AddPersonAttrib(0, "\201\250\195\252", math.huge)
      end
      instruct_13()
      TalkEx("\206\210\210\209\190\173\208\221\207\162\185\187\193\203\163\172*\211\208\203\173\210\170\212\217\201\207\163\191", 0, 1)
      instruct_0()
    end
  end
  TalkEx("\189\211\207\194\192\180\187\187\203\173\163\191**\163\174\163\174\163\174\163\174*\163\174\163\174\163\174\163\174***\195\187\211\208\200\203\193\203\194\240\163\191", 0, 1)
  instruct_0()
  TalkEx("\200\231\185\251\187\185\195\187\211\208\200\203\210\170\179\246\192\180\207\242\213\226\206\187*\201\217\207\192\204\244\213\189\163\172\196\199\247\225\213\226\206\228\185\166\204\236\207\194*\181\218\210\187\214\174\195\251\163\172\206\228\193\214\195\203\214\247\214\174\206\187\163\172*\190\205\211\201\213\226\206\187\201\217\207\192\182\225\181\195\163\174***\163\174\163\174\163\174\163\174\163\174\163\174*\163\174\163\174\163\174\163\174\163\174\163\174*\163\174\163\174\163\174\163\174\163\174\163\174*\186\195\163\172\185\167\207\178\201\217\207\192\163\172\213\226\206\228\193\214\195\203\214\247*\214\174\206\187\190\205\211\201\201\217\207\192\187\241\181\195\163\172\182\248\213\226\176\209*\161\177\206\228\193\214\201\241\213\200\161\177\210\178\211\201\196\227\177\163\185\220\163\174", 70, 0)
  instruct_0()
  TalkEx("\185\167\207\178\201\217\207\192\163\161", 12, 0)
  instruct_0()
  TalkEx("\208\161\208\214\181\220\163\172\185\167\207\178\196\227\163\161", 64, 4)
  instruct_0()
  TalkEx("\186\195\163\172\189\241\196\234\181\196\206\228\193\214\180\243\187\225\181\189\180\203\210\209*\212\178\194\250\189\225\202\248\163\172\207\163\205\251\195\247\196\234\184\247\206\187\206\228*\193\214\205\172\181\192\196\220\212\217\181\189\206\210\187\170\201\189\210\187\211\206\163\174", 19, 0)
  instruct_0()
  instruct_14()
  for i = 24, 72 do
    instruct_3(-2, i, 0, 0, -1, -1, -1, -1, -1, -1, -2, -2, -2)
  end
  instruct_0()
  instruct_13()
  TalkEx("\192\250\190\173\199\167\208\193\205\242\191\224\163\172\206\210\214\213\236\182\180\242\176\220*\200\186\208\219\163\172\181\195\181\189\213\226\206\228\193\214\195\203\214\247\214\174\206\187*\188\176\201\241\213\200\163\174*\181\171\202\199\161\177\202\165\204\195\161\177\212\218\196\199\196\216\163\191*\206\170\202\178\247\225\195\187\200\203\184\230\203\223\206\210\163\172\196\209\181\192\180\243*\188\210\182\188\178\187\214\170\181\192\163\174*\213\226\187\225\182\249\211\214\211\208\181\196\213\210\193\203\163\174", 0, 1)
  instruct_0()
  instruct_2(143, 1)
end

function instruct_59()
  for i = CC.TeamNum, 2, -1 do
    if JY.Base["\182\211\206\233" .. i] >= 0 then
      instruct_21(JY.Base["\182\211\206\233" .. i])
    end
  end
  for i, v in ipairs(CC.AllPersonExit) do
    instruct_3(v[1], v[2], 0, 0, -1, -1, -1, -1, -1, -1, 0, -2, -2)
  end
end

function instruct_60(sceneid, id, num)
  if sceneid == -2 then
    sceneid = JY.SubScene
  end
  if id == -2 then
    id = JY.CurrentD
  end
  if GetD(sceneid, id, 5) == num then
    return true
  else
    return false
  end
end

function instruct_61()
  for i = 11, 24 do
    if GetD(JY.SubScene, i, 5) ~= 4664 then
      return false
    end
  end
  return true
end

function instruct_62(id1, startnum1, endnum1, id2, startnum2, endnum2)
  JY.MyPic = -1
  lib.LoadPicture(CONFIG.PicturePath .. "end.png", -1, -1)
  ShowScreen()
  PlayMIDI(24)
  lib.Delay(5000)
  WaitKey()
  os.exit()
end

function instruct_63(personid, sex)
  JY.Person[personid]["\208\212\177\240"] = sex
end

function instruct_64()
  local headid = 111
  local id = -1
  for i = 0, JY.ShopNum - 1 do
    if CC.ShopScene[i].sceneid == JY.SubScene then
      id = i
      break
    end
  end
  if id < 0 then
    return
  end
  TalkEx("\213\226\206\187\208\161\184\231\163\172\191\180\191\180\211\208\202\178\247\225\208\232\210\170*\181\196\163\172\208\161\177\166\206\210\194\244\181\196\182\171\206\247\188\219\199\174\190\248*\182\212\185\171\181\192\163\174", headid, 0)
  local menu = {}
  for i = 1, 5 do
    menu[i] = {}
    local thingid = JY.Shop[id]["\206\239\198\183" .. i]
    menu[i][1] = string.format("%-12s %5d", JY.Thing[thingid]["\195\251\179\198"], JY.Shop[id]["\206\239\198\183\188\219\184\241" .. i])
    menu[i][2] = nil
    if 0 < JY.Shop[id]["\206\239\198\183\202\253\193\191" .. i] then
      menu[i][3] = 1
    else
      menu[i][3] = 0
    end
  end
  local x1 = (CC.ScreenW - 9 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2
  local y1 = (CC.ScreenH - 5 * CC.DefaultFont - 4 * CC.RowPixel - 2 * CC.MenuBorderPixel) / 2
  local r = ShowMenu(menu, 5, 0, x1, y1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
  if 0 < r then
    if instruct_31(JY.Shop[id]["\206\239\198\183\188\219\184\241" .. r]) == false then
      TalkEx("\183\199\179\163\177\167\199\184\163\172*\196\227\201\237\201\207\181\196\199\174\203\198\186\245\178\187\185\187\163\174", headid, 0)
    else
      JY.Shop[id]["\206\239\198\183\202\253\193\191" .. r] = JY.Shop[id]["\206\239\198\183\202\253\193\191" .. r] - 1
      instruct_32(CC.MoneyID, -JY.Shop[id]["\206\239\198\183\188\219\184\241" .. r])
      instruct_32(JY.Shop[id]["\206\239\198\183" .. r], 1)
      TalkEx("\180\243\210\175\194\242\193\203\206\210\208\161\177\166\181\196\182\171\206\247\163\172*\177\163\214\164\190\248\178\187\225\225\187\218\163\174", headid, 0)
    end
  end
  for i, v in ipairs(CC.ShopScene[id].d_leave) do
    instruct_3(-2, v, 0, -2, -1, -1, 939, -1, -1, -1, -2, -2, -2)
  end
end

function instruct_65()
  local id = -1
  for i = 0, JY.ShopNum - 1 do
    if CC.ShopScene[i].sceneid == JY.SubScene then
      id = i
      break
    end
  end
  if id < 0 then
    return
  end
  instruct_3(-2, CC.ShopScene[id].d_shop, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)
  for i, v in ipairs(CC.ShopScene[id].d_leave) do
    instruct_3(-2, v, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)
  end
  local newid = id + 1
  if 5 <= newid then
    newid = 0
  end
  instruct_3(CC.ShopScene[newid].sceneid, CC.ShopScene[newid].d_shop, 1, -2, 938, -1, -1, 8256, 8256, 8256, -2, -2, -2)
end

function instruct_66(id)
  PlayMIDI(id)
end

function instruct_67(id)
  PlayWavAtk(id)
end

function WarSetGlobal()
  WAR = {}
  WAR.Data = {}
  WAR.SelectPerson = {}
  WAR.Person = {}
  for i = 0, 25 + (CC.TeamNum - 6) do
    WAR.Person[i] = {}
    WAR.Person[i]["\200\203\206\239\177\224\186\197"] = -1
    WAR.Person[i]["\206\210\183\189"] = true
    WAR.Person[i]["\215\248\177\234X"] = -1
    WAR.Person[i]["\215\248\177\234Y"] = -1
    WAR.Person[i].死亡 = true
    WAR.Person[i]["\200\203\183\189\207\242"] = -1
    WAR.Person[i]["\204\249\205\188"] = -1
    WAR.Person[i]["\204\249\205\188\192\224\208\205"] = 0
    WAR.Person[i]["\199\225\185\166"] = 0
    WAR.Person[i]["\210\198\182\175\178\189\202\253"] = 0
    WAR.Person[i].点数 = 0
    WAR.Person[i]["\190\173\209\233"] = 0
    WAR.Person[i]["\215\212\182\175\209\161\212\241\182\212\202\214"] = -1
  end
  WAR.PersonNum = 0
  WAR.AutoFight = 0
  WAR.CurID = -1
  WAR.ShowHead = 0
  WAR.Effect = 0
  WAR.EffectColor = {}
  WAR.EffectColor[2] = C_RED
  WAR.EffectColor[3] = RGB(112, 12, 112)
  WAR.EffectColor[4] = RGB(236, 200, 40)
  WAR.EffectColor[5] = RGB(96, 176, 64)
  WAR.EffectColor[6] = RGB(104, 192, 232)
  WAR.EffectXY = nil
  WAR.EffectXYNum = 0
end

function WarLoad(warid)
  WarSetGlobal()
  local data = Byte.create(CC.WarDataSize)
  Byte.loadfile(data, CC.WarFile, warid * CC.WarDataSize, CC.WarDataSize)
  LoadData(WAR.Data, CC.WarData_S, data)
end

function WarMain(warid, isexp)
  lib.Debug(string.format("war start. warid=%d", warid))
  WarLoad(warid)
  WarSelectTeam()
  WarSelectEnemy()
  CleanMemory()
  lib.PicInit()
  lib.ShowSlow(50, 1)
  WarLoadMap(WAR.Data["\181\216\205\188"])
  local haiba = {}
  for i = 0, CC.WarWidth - 1 do
    haiba[i] = {}
    for j = 0, CC.WarHeight - 1 do
      haiba[i][j] = lib.GetS(JY.SubScene, i, j, 4)
      lib.SetS(JY.SubScene, i, j, 4, 0)
    end
  end
  JY.Status = GAME_WMAP
  lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)
  lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)
  if CC.LoadThingPic == 1 then
    lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)
  end
  lib.PicLoadFile(CC.EffectFile[1], CC.EffectFile[2], 3)
  if CC.FK == 1 then
    lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 2)
  end
  PlayMIDI(WAR.Data.音乐)
  local first = 0
  local warStatus
  JY.ZDHH = 0
  JY.Huhuolq = 5
  JY.Huhuocs = 2
  if 0 < JY.YXND then
    JY.Huhuolq = 10
  end
  local bshh = 1
  if JY.Wugong[30]["\206\180\214\1701"] == 8 and JY.Wugong[30]["\206\180\214\1702"] == 6 then
    bshh = 2
  end
  local lev = JY.Person[0]["\181\200\188\182"]
  JY.Huhuocs = math.floor(lev / 15)
  if JY.YXND == 0 and JY.Person[0].姓名 == "szlzw" then
    JY.Huhuocs = 0
  end
  JY.WARWF = 0
  JY.WARDF = 0
  for i = 0, WAR.PersonNum - 1 do
    JY.DEADPD[i] = {}
    if WAR.Person[i].死亡 == false then
      if WAR.Person[i]["\206\210\183\189"] then
        JY.WARWF = JY.WARWF + 1
      else
        JY.WARDF = JY.WARDF + 1
      end
    end
  end
  while true do
    for i = 0, WAR.PersonNum - 1 do
      WAR.Person[i]["\204\249\205\188"] = WarCalPersonPic(i)
      if WAR.Person[i].死亡 == false then
        JY.DEADPD[i][1] = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
        JY.DEADPD[i][2] = 0
      end
    end
    JY.ZDHH = JY.ZDHH + 1
    WarPersonSort()
    CleanWarMap(2, -1)
    CleanWarMap(6, -2)
    WarSetPerson()
    local p = 0
    while p < WAR.PersonNum do
      WAR.Effect = 0
      if WAR.AutoFight == 1 then
        local keypress, ktype, mx, my = lib.GetKey()
        if keypress == VK_SPACE or keypress == VK_RETURN or keypress == VK_ESCAPE or ktype == 4 or ktype == 3 then
          WAR.AutoFight = 0
        end
      end
      if WAR.Person[p].死亡 == false then
        WAR.CurID = p
        if first == 0 then
          WarDrawMap(0)
          lib.ShowSlow(50, 0)
          ShowScreen()
          first = 1
        else
          WarDrawMap(0)
          WarShowHead()
          ShowScreen()
        end
        local r
        if WAR.Person[p]["\206\210\183\189"] == true then
          if WAR.AutoFight == 0 then
            r = War_Manual()
            if r == 0 then
              p = p - 1
            end
          else
            r = War_Auto()
          end
        else
          r = War_Auto()
        end
        warStatus = War_isEnd()
        for j = 0, WAR.PersonNum - 1 do
          if WAR.Person[j]["\200\203\206\239\177\224\186\197"] == 0 and 0 < JY.Huhuocs and 15 <= lev * bshh then
            if JY.Person[0].外号 == "\206\215\209\253" and 0 >= JY.Huhuolq and WAR.Person[j].死亡 == true and CC.JS == 1 then
              WAR.Person[j].死亡 = false
              JY.Person[0].生命 = math.modf(JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"] / 2)
              JY.Huhuolq = JY.Huhuolq * bshh
              warStatus = 0
              local xgstr = "\206\215\209\253\161\250\183\162\182\175\214\216\201\250\204\216\188\188\163\172\184\180\187\238\193\203\215\212\188\186\163\161"
              local xglen = #xgstr
              DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
              ShowScreen()
              lib.Delay(1500)
              WarSetPerson()
              JY.Huhuocs = JY.Huhuocs - 1
              JY.Huhuolq = JY.Huhuolq * bshh
            end
            if WAR.Person[j].外号 ~= "\206\215\209\253" then
              JY.Huhuolq = JY.Huhuolq * bshh
            end
          end
        end
        if math.abs(r) == 7 then
          p = p - 1
        end
        if 0 < warStatus then
          break
        end
      end
      p = p + 1
    end
    if 0 < warStatus then
      break
    end
    War_PersonLostLife()
    JY.Huhuolq = JY.Huhuolq - 1
    if 0 > JY.Huhuolq then
      JY.Huhuolq = 0
    end
  end
  local r
  WAR.ShowHead = 0
  if warStatus == 1 then
    DrawStrBoxWaitKey("\213\189\182\183\202\164\192\251", C_WHITE, CC.DefaultFont)
    r = true
  elseif warStatus == 2 then
    DrawStrBoxWaitKey("\213\189\182\183\202\167\176\220", C_WHITE, CC.DefaultFont)
    r = false
  end
  War_EndPersonData(isexp, warStatus)
  for i = 0, CC.WarWidth - 1 do
    for j = 0, CC.WarHeight - 1 do
      lib.SetS(JY.SubScene, i, j, 4, haiba[i][j])
    end
  end
  lib.ShowSlow(50, 1)
  if 0 <= JY.Scene[JY.SubScene]["\189\248\195\197\210\244\192\214"] then
    PlayMIDI(JY.Scene[JY.SubScene]["\189\248\195\197\210\244\192\214"])
  else
    PlayMIDI(0)
  end
  CleanMemory()
  lib.PicInit()
  lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)
  lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)
  if CC.LoadThingPic == 1 then
    lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)
  end
  if CC.FK == 1 then
    lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 2)
  end
  JY.Status = GAME_SMAP
  return r
end

function War_PersonLostLife()
  if CC.BanBen == 0 then
    for i = 0, WAR.PersonNum - 1 do
      local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      if WAR.Person[i].死亡 == false then
        if 0 < JY.Person[pid]["\202\220\201\203\179\204\182\200"] then
          local dec = math.modf(JY.Person[pid]["\202\220\201\203\179\204\182\200"] / 10)
          AddPersonAttrib(pid, "\201\250\195\252", -dec)
        end
        if 0 < JY.Person[pid]["\214\208\182\190\179\204\182\200"] then
          local dec = math.modf(JY.Person[pid]["\214\208\182\190\179\204\182\200"] / 10)
          AddPersonAttrib(pid, "\201\250\195\252", -dec)
        end
        if 0 >= JY.Person[pid].生命 then
          JY.Person[pid].生命 = 1
        end
      end
    end
  else
    for i = 0, WAR.PersonNum - 1 do
      local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      if WAR.Person[i].死亡 == false then
        if 0 < JY.Person[pid]["\202\220\201\203\179\204\182\200"] then
          local dec = math.modf(JY.Person[pid]["\202\220\201\203\179\204\182\200"] / 10)
          AddPersonAttrib(pid, "\201\250\195\252", math.modf(-dec * (CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)))
        end
        if 0 < JY.Person[pid]["\214\208\182\190\179\204\182\200"] then
          local dec = math.modf(JY.Person[pid]["\214\208\182\190\179\204\182\200"] / 1)
          local duyz = math.modf(CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)
          if 5 < duyz then
            duyz = 5
          end
          AddPersonAttrib(pid, "\201\250\195\252", -dec * duyz)
        end
        if 0 >= JY.Person[pid].生命 then
          JY.Person[pid].生命 = 1
        end
      end
    end
  end
end

function War_EndPersonData(isexp, warStatus)
  for i = 0, WAR.PersonNum - 1 do
    local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i]["\206\210\183\189"] == false then
      JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
      JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
      JY.Person[pid]["\204\229\193\166"] = CC.PersonAttribMax["\204\229\193\166"]
      JY.Person[pid]["\202\220\201\203\179\204\182\200"] = 0
      JY.Person[pid]["\214\208\182\190\179\204\182\200"] = 0
    end
  end
  for i = 0, WAR.PersonNum - 1 do
    local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i]["\206\210\183\189"] == true then
      if JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] then
        JY.Person[pid].生命 = JY.Person[pid].生命 + math.modf(JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 5)
        if JY.Person[pid].生命 > JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] then
          JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
        end
      end
      if JY.Person[pid]["\196\218\193\166"] < JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] then
        JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166"] + math.modf(JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] / 5)
        if JY.Person[pid]["\196\218\193\166"] > JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] then
          JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
        end
      end
      if JY.Person[pid]["\204\229\193\166"] < 100 then
        JY.Person[pid]["\204\229\193\166"] = JY.Person[pid]["\204\229\193\166"] + 20
        if JY.Person[pid]["\204\229\193\166"] > 100 then
          JY.Person[pid]["\204\229\193\166"] = 100
        end
      end
    end
  end
  if warStatus == 2 and isexp == 0 then
    return
  end
  local liveNum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i]["\206\210\183\189"] == true and 0 < JY.Person[WAR.Person[i]["\200\203\206\239\177\224\186\197"]].生命 then
      liveNum = liveNum + 1
    end
  end
  if CC.ExpLevel > 3 or 0 >= CC.ExpLevel then
    CC.ExpLevel = 1
  end
  if warStatus == 1 then
    for i = 0, WAR.PersonNum - 1 do
      local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      if WAR.Person[i]["\206\210\183\189"] == true and 0 < JY.Person[pid].生命 then
        if pid == 0 then
          WAR.Person[i]["\190\173\209\233"] = (WAR.Person[i]["\190\173\209\233"] + math.modf(WAR.Data["\190\173\209\233"] / liveNum)) * CC.ExpLevel * CC.ExpCS
        else
          WAR.Person[i]["\190\173\209\233"] = (WAR.Person[i]["\190\173\209\233"] + math.modf(WAR.Data["\190\173\209\233"] / liveNum)) * CC.ExpLevel * CC.ExpCS
        end
      end
    end
  end
  for i = 0, WAR.PersonNum - 1 do
    local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    AddPersonAttrib(pid, "\206\239\198\183\208\222\193\182\181\227\202\253", math.modf(WAR.Person[i]["\190\173\209\233"] * 8 / 10))
    if JY.Person[pid]["\206\239\198\183\208\222\193\182\181\227\202\253"] > 30000 or 0 > JY.Person[pid]["\206\239\198\183\208\222\193\182\181\227\202\253"] then
      JY.Person[pid]["\206\239\198\183\208\222\193\182\181\227\202\253"] = 30000
    end
    AddPersonAttrib(pid, "\208\222\193\182\181\227\202\253", math.modf(WAR.Person[i]["\190\173\209\233"] * 8 / 10))
    AddPersonAttrib(pid, "\190\173\209\233", WAR.Person[i]["\190\173\209\233"])
    if 30000 < JY.Person[pid]["\208\222\193\182\181\227\202\253"] or 0 > JY.Person[pid]["\208\222\193\182\181\227\202\253"] then
      JY.Person[pid]["\208\222\193\182\181\227\202\253"] = 30000
    end
    if WAR.Person[i]["\206\210\183\189"] == true then
      Cls()
      DrawStrBoxWaitKey(string.format("%s \187\241\181\195\190\173\209\233\181\227\202\253 %d", JY.Person[pid].姓名, WAR.Person[i]["\190\173\209\233"]), C_WHITE, CC.DefaultFont)
      JY.JSEXP = WAR.Person[i]["\190\173\209\233"]
      local r = War_AddPersonLevel(pid)
    end
    War_PersonTrainBook(pid)
    War_PersonTrainDrug(pid)
  end
end

function War_AddPersonLevel(pid)
  local tmplevel = JY.Person[pid]["\181\200\188\182"]
  if tmplevel >= CC.Level then
    return false
  end
  if JY.Person[pid]["\190\173\209\233"] < CC.Exp[tmplevel] then
    return false
  end
  while not (tmplevel >= CC.Level) do
    if JY.Person[pid]["\190\173\209\233"] >= CC.Exp[tmplevel] then
      if CC.FKUP == 1 then
        JY.Person[pid]["\190\173\209\233"] = JY.Person[pid]["\190\173\209\233"] - CC.Exp[tmplevel]
      end
      tmplevel = tmplevel + 1
    else
      break
    end
  end
  local levela = tmplevel - JY.Person[pid]["\181\200\188\182"]
  local sjq = {}
  sjq[0] = JY.Person[pid]["\181\200\188\182"]
  sjq[1] = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
  sjq[2] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
  sjq[3] = JY.Person[pid]["\185\165\187\247\193\166"]
  sjq[4] = JY.Person[pid]["\183\192\211\249\193\166"]
  sjq[5] = JY.Person[pid]["\199\225\185\166"]
  sjq[6] = JY.Person[pid]["\210\189\193\198\196\220\193\166"]
  sjq[7] = JY.Person[pid]["\211\195\182\190\196\220\193\166"]
  sjq[8] = JY.Person[pid]["\189\226\182\190\196\220\193\166"]
  sjq[9] = JY.Person[pid]["\200\173\213\198\185\166\183\242"]
  sjq[10] = JY.Person[pid]["\211\249\189\163\196\220\193\166"]
  sjq[11] = JY.Person[pid]["\203\163\181\182\188\188\199\201"]
  sjq[12] = JY.Person[pid]["\204\216\202\226\177\248\198\247"]
  sjq[13] = JY.Person[pid]["\176\181\198\247\188\188\199\201"]
  local rwsx = {}
  for i = 1, 13 do
    rwsx[i] = 0
  end
  if CC.FKUP == 0 then
    if JY.Person[pid].姓名 == "szlzw" then
      local leveladd = tmplevel - JY.Person[pid]["\181\200\188\182"]
      JY.Person[pid]["\181\200\188\182"] = JY.Person[pid]["\181\200\188\182"] + leveladd
      rwsx[1] = (JY.Person[pid]["\201\250\195\252\212\246\179\164"] + 2) * leveladd * 3
      AddPersonAttrib(pid, "\201\250\195\252\215\238\180\243\214\181", rwsx[1])
      JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
      JY.Person[pid]["\204\229\193\166"] = CC.PersonAttribMax["\204\229\193\166"]
      JY.Person[pid]["\202\220\201\203\179\204\182\200"] = 0
      JY.Person[pid]["\214\208\182\190\179\204\182\200"] = 0
      local cleveradd
      if JY.Person[pid]["\215\202\214\202"] < 30 then
        cleveradd = 1
      elseif JY.Person[pid]["\215\202\214\202"] < 50 then
        cleveradd = 1
      elseif JY.Person[pid]["\215\202\214\202"] < 70 then
        cleveradd = 2
      elseif JY.Person[pid]["\215\202\214\202"] < 90 then
        cleveradd = 2
      else
        cleveradd = 3
      end
      rwsx[2] = 7 * leveladd * 4
      AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", rwsx[2])
      JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
      local i = 0
      local zzadd = 0
      if JY.Person[0]["\215\202\214\202"] < 55 then
        zzadd = 1
      end
      for i = 1, leveladd do
        rwsx[3] = rwsx[3] + 4 - zzadd + Rnd(2)
        rwsx[4] = rwsx[4] + 4 - zzadd + Rnd(2)
        rwsx[5] = rwsx[5] + 4 - zzadd + Rnd(2)
        rwsx[6] = rwsx[6] + 2
        rwsx[7] = rwsx[7] + 2
        rwsx[8] = rwsx[8] + 2
        rwsx[9] = rwsx[9] + 2
        rwsx[10] = rwsx[10] + 2
        rwsx[11] = rwsx[11] + 2
        rwsx[12] = rwsx[12] + 2
        rwsx[13] = rwsx[13] + 2
      end
    else
      local leveladd = tmplevel - JY.Person[pid]["\181\200\188\182"]
      JY.Person[pid]["\181\200\188\182"] = JY.Person[pid]["\181\200\188\182"] + leveladd
      rwsx[1] = (JY.Person[pid]["\201\250\195\252\212\246\179\164"] + Rnd(3)) * leveladd * 3
      AddPersonAttrib(pid, "\201\250\195\252\215\238\180\243\214\181", rwsx[1])
      JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
      JY.Person[pid]["\204\229\193\166"] = CC.PersonAttribMax["\204\229\193\166"]
      JY.Person[pid]["\202\220\201\203\179\204\182\200"] = 0
      JY.Person[pid]["\214\208\182\190\179\204\182\200"] = 0
      local cleveradd
      if JY.Person[pid]["\215\202\214\202"] < 30 then
        cleveradd = 1
      elseif JY.Person[pid]["\215\202\214\202"] < 50 then
        cleveradd = 1
      elseif JY.Person[pid]["\215\202\214\202"] < 70 then
        cleveradd = 2
      elseif JY.Person[pid]["\215\202\214\202"] < 90 then
        cleveradd = 2
      else
        cleveradd = 3
      end
      rwsx[2] = (9 - cleveradd) * leveladd * 4
      AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", rwsx[2])
      JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
      local i = 0
      for i = 1, leveladd do
        rwsx[3] = rwsx[3] + Rnd(3) + cleveradd
        rwsx[4] = rwsx[4] + Rnd(3) + cleveradd
        rwsx[5] = rwsx[5] + Rnd(3) + cleveradd
        rwsx[6] = rwsx[6] + Rnd(2) + 1
        rwsx[7] = rwsx[7] + Rnd(2) + 1
        rwsx[8] = rwsx[8] + Rnd(2) + 1
        rwsx[9] = rwsx[9] + Rnd(2) + 1
        rwsx[10] = rwsx[10] + Rnd(2) + 1
        rwsx[11] = rwsx[11] + Rnd(2) + 1
        rwsx[12] = rwsx[12] + Rnd(2) + 1
        rwsx[13] = rwsx[13] + Rnd(2) + 1
        for j = 1, 10 do
          if JY.Selpstr[j] ~= nil and pid == 0 then
            AddPersonAttrib(pid, JY.Selpstr[j][1], JY.Selpstr[j][2])
          else
            break
          end
        end
      end
    end
  elseif JY.Person[pid].姓名 == "szlzw" then
    local leveladd = tmplevel - JY.Person[pid]["\181\200\188\182"]
    JY.Person[pid]["\181\200\188\182"] = JY.Person[pid]["\181\200\188\182"] + leveladd
    rwsx[1] = (JY.Person[pid]["\201\250\195\252\212\246\179\164"] + 2) * leveladd * 3
    AddPersonAttrib(pid, "\201\250\195\252\215\238\180\243\214\181", rwsx[1])
    JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
    JY.Person[pid]["\204\229\193\166"] = CC.PersonAttribMax["\204\229\193\166"]
    JY.Person[pid]["\202\220\201\203\179\204\182\200"] = 0
    JY.Person[pid]["\214\208\182\190\179\204\182\200"] = 0
    local cleveradd
    if JY.Person[pid]["\215\202\214\202"] <= 15 then
      cleveradd = 2
    elseif JY.Person[pid]["\215\202\214\202"] < 30 then
      cleveradd = 2
    elseif JY.Person[pid]["\215\202\214\202"] < 45 then
      cleveradd = 3
    elseif JY.Person[pid]["\215\202\214\202"] < 60 then
      cleveradd = 4
    elseif JY.Person[pid]["\215\202\214\202"] < 75 then
      cleveradd = 5
    elseif JY.Person[pid]["\215\202\214\202"] < 90 then
      cleveradd = 6
    else
      cleveradd = 7
    end
    rwsx[2] = (15 - cleveradd) * leveladd * 5
    AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", rwsx[2])
    JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
    for i = 1, leveladd do
      rwsx[3] = rwsx[3] + cleveradd
      rwsx[4] = rwsx[4] + cleveradd
      rwsx[5] = rwsx[5] + 4
      rwsx[6] = rwsx[6] + 2
      rwsx[7] = rwsx[7] + 2
      rwsx[8] = rwsx[8] + 2
      rwsx[9] = rwsx[9] + 2
      rwsx[10] = rwsx[10] + 2
      rwsx[11] = rwsx[11] + 2
      rwsx[12] = rwsx[12] + 2
      rwsx[13] = rwsx[13] + 2
    end
  else
    local leveladd = tmplevel - JY.Person[pid]["\181\200\188\182"]
    JY.Person[pid]["\181\200\188\182"] = JY.Person[pid]["\181\200\188\182"] + leveladd
    rwsx[1] = (JY.Person[pid]["\201\250\195\252\212\246\179\164"] + Rnd(3)) * leveladd * 3
    AddPersonAttrib(pid, "\201\250\195\252\215\238\180\243\214\181", rwsx[1])
    JY.Person[pid].生命 = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
    JY.Person[pid]["\204\229\193\166"] = CC.PersonAttribMax["\204\229\193\166"]
    JY.Person[pid]["\202\220\201\203\179\204\182\200"] = 0
    JY.Person[pid]["\214\208\182\190\179\204\182\200"] = 0
    local cleveradd
    if JY.Person[pid]["\215\202\214\202"] <= 15 then
      cleveradd = 2
    elseif JY.Person[pid]["\215\202\214\202"] < 30 then
      cleveradd = 2
    elseif JY.Person[pid]["\215\202\214\202"] < 45 then
      cleveradd = 3
    elseif JY.Person[pid]["\215\202\214\202"] < 60 then
      cleveradd = 4
    elseif JY.Person[pid]["\215\202\214\202"] < 75 then
      cleveradd = 5
    elseif JY.Person[pid]["\215\202\214\202"] < 90 then
      cleveradd = 6
    else
      cleveradd = 7
    end
    rwsx[2] = (12 - cleveradd) * leveladd * 4
    AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", rwsx[2])
    JY.Person[pid]["\196\218\193\166"] = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
    local i = 0
    for i = 1, leveladd do
      rwsx[3] = rwsx[3] + cleveradd
      rwsx[4] = rwsx[4] + cleveradd
      rwsx[5] = rwsx[5] + 3
      rwsx[6] = rwsx[6] + Rnd(2) + 1
      rwsx[7] = rwsx[7] + Rnd(2) + 1
      rwsx[8] = rwsx[8] + Rnd(2) + 1
      rwsx[9] = rwsx[9] + Rnd(2) + 1
      rwsx[10] = rwsx[10] + Rnd(2) + 1
      rwsx[11] = rwsx[11] + Rnd(2) + 1
      rwsx[12] = rwsx[12] + Rnd(2) + 1
      rwsx[13] = rwsx[13] + Rnd(2) + 1
      for j = 1, 10 do
        if JY.Selpstr[j] ~= nil and pid == 0 then
          AddPersonAttrib(pid, JY.Selpstr[j][1], JY.Selpstr[j][2])
        else
          break
        end
      end
    end
  end
  AddPersonAttrib(pid, "\185\165\187\247\193\166", rwsx[3])
  AddPersonAttrib(pid, "\183\192\211\249\193\166", rwsx[4])
  AddPersonAttrib(pid, "\199\225\185\166", rwsx[5])
  if JY.Person[pid]["\210\189\193\198\196\220\193\166"] >= 20 then
    AddPersonAttrib(pid, "\210\189\193\198\196\220\193\166", rwsx[6])
  end
  if JY.Person[pid]["\211\195\182\190\196\220\193\166"] >= 20 then
    AddPersonAttrib(pid, "\211\195\182\190\196\220\193\166", rwsx[7])
  end
  if JY.Person[pid]["\189\226\182\190\196\220\193\166"] >= 20 then
    AddPersonAttrib(pid, "\189\226\182\190\196\220\193\166", rwsx[8])
  end
  if JY.Person[pid]["\200\173\213\198\185\166\183\242"] >= 20 then
    AddPersonAttrib(pid, "\200\173\213\198\185\166\183\242", rwsx[9])
  end
  if JY.Person[pid]["\211\249\189\163\196\220\193\166"] >= 20 then
    AddPersonAttrib(pid, "\211\249\189\163\196\220\193\166", rwsx[10])
  end
  if JY.Person[pid]["\203\163\181\182\188\188\199\201"] >= 20 then
    AddPersonAttrib(pid, "\203\163\181\182\188\188\199\201", rwsx[11])
  end
  if JY.Person[pid]["\204\216\202\226\177\248\198\247"] >= 20 then
    AddPersonAttrib(pid, "\204\216\202\226\177\248\198\247", rwsx[12])
  end
  if JY.Person[pid]["\176\181\198\247\188\188\199\201"] >= 20 then
    AddPersonAttrib(pid, "\176\181\198\247\188\188\199\201", rwsx[13])
  end
  Cls()
  local size = CC.DefaultFont
  local x1 = CC.ScreenW / 2 - size * 7
  local ysize = size * 1.1
  local y1 = size
  local x2 = CC.ScreenW / 2 + size * 7
  local y2 = CC.ScreenH - y1
  DrawBox(x1, y1, x2, y2, C_WHITE)
  DrawString(x1 + size, y1 + ysize * 0, string.format("%-8s", JY.Person[pid].姓名), C_GOLD, size)
  DrawString(x1 + size * 6, y1 + ysize * 0, "\201\253\188\182\193\203", C_WHITE, size)
  if JY.Person[pid]["\181\200\188\182"] >= CC.Level then
    DrawString(x1 + size, y1 + ysize * 1, string.format("\181\200\188\182 %4d", JY.Person[pid]["\181\200\188\182"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 1, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 1, string.format("\181\200\188\182 %4d", sjq[0]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 1, string.format("\161\250 %4d", JY.Person[pid]["\181\200\188\182"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 1, string.format("\161\252%4d", levela), C_ORANGE, size)
  end
  DrawString(x1 + size, y1 + ysize * 2, string.format("\190\173\209\233 %4d", JY.Person[pid]["\190\173\209\233"] - JY.JSEXP), C_GOLD, size)
  DrawString(x1 + size * 6, y1 + ysize * 2, string.format("\161\250 %4d", JY.Person[pid]["\190\173\209\233"]), C_WHITE, size)
  DrawString(x1 + size * 10, y1 + ysize * 2, string.format("\161\252%4d", JY.JSEXP), C_ORANGE, size)
  if JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] >= CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] then
    DrawString(x1 + size, y1 + ysize * 3, string.format("\201\250\195\252 %4d", JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 3, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 3, string.format("\201\250\195\252 %4d", sjq[1]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 3, string.format("\161\250 %4d", JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 3, string.format("\161\252%4d", rwsx[1]), C_ORANGE, size)
  end
  if JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] >= CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] then
    DrawString(x1 + size, y1 + ysize * 4, string.format("\196\218\193\166 %4d", JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 4, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 4, string.format("\196\218\193\166 %4d", sjq[2]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 4, string.format("\161\250 %4d", JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 4, string.format("\161\252%4d", rwsx[2]), C_ORANGE, size)
  end
  if JY.Person[pid]["\185\165\187\247\193\166"] >= CC.PersonAttribMax["\185\165\187\247\193\166"] then
    DrawString(x1 + size, y1 + ysize * 5, string.format("\185\165\187\247 %4d", JY.Person[pid]["\185\165\187\247\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 5, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 5, string.format("\185\165\187\247 %4d", sjq[3]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 5, string.format("\161\250 %4d", JY.Person[pid]["\185\165\187\247\193\166"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 5, string.format("\161\252%4d", rwsx[3]), C_ORANGE, size)
  end
  if JY.Person[pid]["\183\192\211\249\193\166"] >= CC.PersonAttribMax["\183\192\211\249\193\166"] then
    DrawString(x1 + size, y1 + ysize * 6, string.format("\183\192\211\249 %4d", JY.Person[pid]["\183\192\211\249\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 6, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 6, string.format("\183\192\211\249 %4d", sjq[4]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 6, string.format("\161\250 %4d", JY.Person[pid]["\183\192\211\249\193\166"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 6, string.format("\161\252%4d", rwsx[4]), C_ORANGE, size)
  end
  if JY.Person[pid]["\199\225\185\166"] >= CC.PersonAttribMax["\199\225\185\166"] then
    DrawString(x1 + size, y1 + ysize * 7, string.format("\199\225\185\166 %4d", JY.Person[pid]["\199\225\185\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 7, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 7, string.format("\199\225\185\166 %4d", sjq[5]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 7, string.format("\161\250 %4d", JY.Person[pid]["\199\225\185\166"]), C_WHITE, size)
    DrawString(x1 + size * 10, y1 + ysize * 7, string.format("\161\252%4d", rwsx[5]), C_ORANGE, size)
  end
  if JY.Person[pid]["\210\189\193\198\196\220\193\166"] >= CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] then
    DrawString(x1 + size, y1 + ysize * 8, string.format("\210\189\193\198 %4d", JY.Person[pid]["\210\189\193\198\196\220\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 8, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 8, string.format("\210\189\193\198 %4d", sjq[6]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 8, string.format("\161\250 %4d", JY.Person[pid]["\210\189\193\198\196\220\193\166"]), C_WHITE, size)
    if rwsx[6] ~= 0 and JY.Person[pid]["\210\189\193\198\196\220\193\166"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 8, string.format("\161\252%4d", rwsx[6]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\211\195\182\190\196\220\193\166"] >= CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] then
    DrawString(x1 + size, y1 + ysize * 9, string.format("\211\195\182\190 %4d", JY.Person[pid]["\211\195\182\190\196\220\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 9, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 9, string.format("\211\195\182\190 %4d", sjq[7]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 9, string.format("\161\250 %4d", JY.Person[pid]["\211\195\182\190\196\220\193\166"]), C_WHITE, size)
    if rwsx[7] ~= 0 and JY.Person[pid]["\211\195\182\190\196\220\193\166"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 9, string.format("\161\252%4d", rwsx[7]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\189\226\182\190\196\220\193\166"] >= CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] then
    DrawString(x1 + size, y1 + ysize * 10, string.format("\189\226\182\190 %4d", JY.Person[pid]["\189\226\182\190\196\220\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 10, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 10, string.format("\189\226\182\190 %4d", sjq[8]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 10, string.format("\161\250 %4d", JY.Person[pid]["\189\226\182\190\196\220\193\166"]), C_WHITE, size)
    if rwsx[8] ~= 0 and JY.Person[pid]["\189\226\182\190\196\220\193\166"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 10, string.format("\161\252%4d", rwsx[8]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\200\173\213\198\185\166\183\242"] >= CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] then
    DrawString(x1 + size, y1 + ysize * 11, string.format("\200\173\213\198 %4d", JY.Person[pid]["\200\173\213\198\185\166\183\242"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 11, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 11, string.format("\200\173\213\198 %4d", sjq[9]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 11, string.format("\161\250 %4d", JY.Person[pid]["\200\173\213\198\185\166\183\242"]), C_WHITE, size)
    if rwsx[9] ~= 0 and JY.Person[pid]["\200\173\213\198\185\166\183\242"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 11, string.format("\161\252%4d", rwsx[9]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\211\249\189\163\196\220\193\166"] >= CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] then
    DrawString(x1 + size, y1 + ysize * 12, string.format("\211\249\189\163 %4d", JY.Person[pid]["\211\249\189\163\196\220\193\166"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 12, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 12, string.format("\211\249\189\163 %4d", sjq[10]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 12, string.format("\161\250 %4d", JY.Person[pid]["\211\249\189\163\196\220\193\166"]), C_WHITE, size)
    if rwsx[10] ~= 0 and JY.Person[pid]["\211\249\189\163\196\220\193\166"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 12, string.format("\161\252%4d", rwsx[10]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\203\163\181\182\188\188\199\201"] >= CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] then
    DrawString(x1 + size, y1 + ysize * 13, string.format("\203\163\181\182 %4d", JY.Person[pid]["\203\163\181\182\188\188\199\201"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 13, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 13, string.format("\203\163\181\182 %4d", sjq[11]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 13, string.format("\161\250 %4d", JY.Person[pid]["\203\163\181\182\188\188\199\201"]), C_WHITE, size)
    if rwsx[11] ~= 0 and JY.Person[pid]["\203\163\181\182\188\188\199\201"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 13, string.format("\161\252%4d", rwsx[11]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\204\216\202\226\177\248\198\247"] >= CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] then
    DrawString(x1 + size, y1 + ysize * 14, string.format("\204\216\202\226 %4d", JY.Person[pid]["\204\216\202\226\177\248\198\247"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 14, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 14, string.format("\204\216\202\226 %4d", sjq[12]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 14, string.format("\161\250 %4d", JY.Person[pid]["\204\216\202\226\177\248\198\247"]), C_WHITE, size)
    if rwsx[13] ~= 0 and JY.Person[pid]["\204\216\202\226\177\248\198\247"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 14, string.format("\161\252%4d", rwsx[12]), C_ORANGE, size)
    end
  end
  if JY.Person[pid]["\176\181\198\247\188\188\199\201"] >= CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] then
    DrawString(x1 + size, y1 + ysize * 15, string.format("\176\181\198\247 %4d", JY.Person[pid]["\176\181\198\247\188\188\199\201"]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 15, "\180\239\181\189\201\207\207\222", C_ORANGE, size)
  else
    DrawString(x1 + size, y1 + ysize * 15, string.format("\176\181\198\247 %4d", sjq[13]), C_GOLD, size)
    DrawString(x1 + size * 6, y1 + ysize * 15, string.format("\161\250 %4d", JY.Person[pid]["\176\181\198\247\188\188\199\201"]), C_WHITE, size)
    if rwsx[12] ~= 0 and JY.Person[pid]["\176\181\198\247\188\188\199\201"] >= 20 then
      DrawString(x1 + size * 10, y1 + ysize * 15, string.format("\161\252%4d", rwsx[13]), C_ORANGE, size)
    end
  end
  ShowScreen()
  WaitKey()
  return true
end

function War_PersonTrainBook(pid)
  local p = JY.Person[pid]
  local thingid = p["\208\222\193\182\206\239\198\183"]
  if thingid < 0 then
    return
  end
  local wugongid = JY.Thing[thingid]["\193\183\179\246\206\228\185\166"]
  local needpoint = TrainNeedExp(pid)
  local mijilev = 0
  while needpoint <= p["\208\222\193\182\181\227\202\253"] do
    if needpoint <= p["\208\222\193\182\181\227\202\253"] then
      AddPersonAttrib(pid, "\201\250\195\252\215\238\180\243\214\181", JY.Thing[thingid]["\188\211\201\250\195\252\215\238\180\243\214\181"])
      if JY.Thing[thingid]["\184\196\177\228\196\218\193\166\208\212\214\202"] == 2 then
        p["\196\218\193\166\208\212\214\202"] = 2
      end
      AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", JY.Thing[thingid]["\188\211\196\218\193\166\215\238\180\243\214\181"])
      AddPersonAttrib(pid, "\185\165\187\247\193\166", JY.Thing[thingid]["\188\211\185\165\187\247\193\166"])
      AddPersonAttrib(pid, "\199\225\185\166", JY.Thing[thingid]["\188\211\199\225\185\166"])
      AddPersonAttrib(pid, "\183\192\211\249\193\166", JY.Thing[thingid]["\188\211\183\192\211\249\193\166"])
      AddPersonAttrib(pid, "\210\189\193\198\196\220\193\166", JY.Thing[thingid]["\188\211\210\189\193\198\196\220\193\166"])
      AddPersonAttrib(pid, "\211\195\182\190\196\220\193\166", JY.Thing[thingid]["\188\211\211\195\182\190\196\220\193\166"])
      AddPersonAttrib(pid, "\189\226\182\190\196\220\193\166", JY.Thing[thingid]["\188\211\189\226\182\190\196\220\193\166"])
      AddPersonAttrib(pid, "\191\185\182\190\196\220\193\166", JY.Thing[thingid]["\188\211\191\185\182\190\196\220\193\166"])
      AddPersonAttrib(pid, "\200\173\213\198\185\166\183\242", JY.Thing[thingid]["\188\211\200\173\213\198\185\166\183\242"])
      AddPersonAttrib(pid, "\211\249\189\163\196\220\193\166", JY.Thing[thingid]["\188\211\211\249\189\163\196\220\193\166"])
      AddPersonAttrib(pid, "\203\163\181\182\188\188\199\201", JY.Thing[thingid]["\188\211\203\163\181\182\188\188\199\201"])
      AddPersonAttrib(pid, "\204\216\202\226\177\248\198\247", JY.Thing[thingid]["\188\211\204\216\202\226\177\248\198\247"])
      AddPersonAttrib(pid, "\176\181\198\247\188\188\199\201", JY.Thing[thingid]["\188\211\176\181\198\247\188\188\199\201"])
      AddPersonAttrib(pid, "\206\228\209\167\179\163\202\182", JY.Thing[thingid]["\188\211\206\228\209\167\179\163\202\182"])
      AddPersonAttrib(pid, "\198\183\181\194", JY.Thing[thingid]["\188\211\198\183\181\194"])
      AddPersonAttrib(pid, "\185\165\187\247\180\248\182\190", JY.Thing[thingid]["\188\211\185\165\187\247\180\248\182\190"])
      if JY.Thing[thingid]["\188\211\185\165\187\247\180\206\202\253"] == 1 then
        p["\215\243\211\210\187\165\178\171"] = 1
      end
      local xlmj = {}
      local xlmjstr = {}
      xlmjstr[1] = "\201\250\195\252\215\238\180\243\214\181"
      xlmjstr[2] = "\196\218\193\166\215\238\180\243\214\181"
      xlmjstr[3] = "\185\165\187\247\193\166"
      xlmjstr[4] = "\199\225\185\166"
      xlmjstr[5] = "\183\192\211\249\193\166"
      xlmjstr[6] = "\210\189\193\198\196\220\193\166"
      xlmjstr[7] = "\211\195\182\190\196\220\193\166"
      xlmjstr[8] = "\189\226\182\190\196\220\193\166"
      xlmjstr[9] = "\191\185\182\190\196\220\193\166"
      xlmjstr[10] = "\200\173\213\198\196\220\193\166"
      xlmjstr[11] = "\211\249\189\163\196\220\193\166"
      xlmjstr[12] = "\203\163\181\182\188\188\199\201"
      xlmjstr[13] = "\204\216\202\226\177\248\198\247"
      xlmjstr[14] = "\176\181\198\247\188\188\199\201"
      xlmjstr[15] = "\206\228\209\167\179\163\202\182"
      xlmjstr[16] = "\198\183\181\194"
      xlmjstr[17] = "\185\165\187\247\180\248\182\190"
      xlmjstr[18] = "\185\165\187\247\180\206\202\253"
      xlmjstr[19] = "\196\218\193\166\215\170\206\170\181\247\186\205"
      xlmj[1] = JY.Thing[thingid]["\188\211\201\250\195\252\215\238\180\243\214\181"]
      xlmj[2] = JY.Thing[thingid]["\188\211\196\218\193\166\215\238\180\243\214\181"]
      xlmj[3] = JY.Thing[thingid]["\188\211\185\165\187\247\193\166"]
      xlmj[4] = JY.Thing[thingid]["\188\211\199\225\185\166"]
      xlmj[5] = JY.Thing[thingid]["\188\211\183\192\211\249\193\166"]
      xlmj[6] = JY.Thing[thingid]["\188\211\210\189\193\198\196\220\193\166"]
      xlmj[7] = JY.Thing[thingid]["\188\211\211\195\182\190\196\220\193\166"]
      xlmj[8] = JY.Thing[thingid]["\188\211\189\226\182\190\196\220\193\166"]
      xlmj[9] = JY.Thing[thingid]["\188\211\191\185\182\190\196\220\193\166"]
      xlmj[10] = JY.Thing[thingid]["\188\211\200\173\213\198\185\166\183\242"]
      xlmj[11] = JY.Thing[thingid]["\188\211\211\249\189\163\196\220\193\166"]
      xlmj[12] = JY.Thing[thingid]["\188\211\203\163\181\182\188\188\199\201"]
      xlmj[13] = JY.Thing[thingid]["\188\211\204\216\202\226\177\248\198\247"]
      xlmj[14] = JY.Thing[thingid]["\188\211\176\181\198\247\188\188\199\201"]
      xlmj[15] = JY.Thing[thingid]["\188\211\206\228\209\167\179\163\202\182"]
      xlmj[16] = JY.Thing[thingid]["\188\211\198\183\181\194"]
      xlmj[17] = JY.Thing[thingid]["\188\211\185\165\187\247\180\248\182\190"]
      xlmj[18] = JY.Thing[thingid]["\188\211\185\165\187\247\180\206\202\253"]
      xlmj[19] = JY.Thing[thingid]["\184\196\177\228\196\218\193\166\208\212\214\202"]
      local size = CC.DefaultFont
      local x1 = CC.ScreenW / 2 - size * 7
      local ysize = size * 1.1
      local y1 = size * 4
      local x2 = CC.ScreenW / 2 + size * 7
      local y2 = CC.ScreenH - y1
      Cls()
      DrawBox(x1, y1, x2, y2, C_WHITE)
      DrawString(x1 + size, y1 + ysize * 0, string.format("%s", p.姓名), C_GOLD, size)
      p["\208\222\193\182\181\227\202\253"] = p["\208\222\193\182\181\227\202\253"] - needpoint
      mijilev = mijilev + 1
      if 0 <= wugongid then
        local oldwugong = 0
        for i = 1, 10 do
          if p["\206\228\185\166" .. i] == wugongid then
            oldwugong = 1
            p["\206\228\185\166\181\200\188\182" .. i] = p["\206\228\185\166\181\200\188\182" .. i] + 100
            if p["\208\222\193\182\181\227\202\253"] < TrainNeedExp(pid) and 10 > math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 then
              DrawString(x1 + size, y1 + ysize * 1, string.format("\208\222\193\182 %s \179\201\185\166", JY.Thing[thingid]["\195\251\179\198"]), C_WHITE, size)
              DrawString(x1 + size, y1 + ysize * 2, string.format("%s \180\211%d\188\182\201\253\214\193%d\188\182", JY.Wugong[wugongid]["\195\251\179\198"], math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev, math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1), C_WHITE, size)
              local wggjl1
              if 0 < math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev then
                wggjl1 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev]
              else
                wggjl1 = 0
              end
              local wggjl2 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1]
              DrawString(x1 + size, y1 + ysize * 3, string.format("\206\228\185\166\205\254\193\166 %d \161\250 %d", wggjl1, wggjl2), C_WHITE, size)
              local k = 1
              for j = 1, 18 do
                if 0 < xlmj[j] or xlmj[j] < 0 then
                  if 0 < xlmj[j] then
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s +%2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  else
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s  %2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  end
                  k = k + 1
                end
              end
            end
            local wgdj = math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1
            if 10 <= wgdj then
              DrawString(x1 + size, y1 + ysize * 1, string.format("\208\222\193\182 %s \179\201\185\166", JY.Thing[thingid]["\195\251\179\198"]), C_WHITE, size)
              DrawString(x1 + size, y1 + ysize * 2, string.format("%s \180\211%d\188\182\201\253\214\193%d\188\182", JY.Wugong[wugongid]["\195\251\179\198"], math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev, math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1), C_WHITE, size)
              local wggjl1
              if 0 < math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev then
                wggjl1 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev]
              else
                wggjl1 = 0
              end
              local wggjl2 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1]
              DrawString(x1 + size, y1 + ysize * 3, string.format("\206\228\185\166\205\254\193\166 %d \161\250 %d", wggjl1, wggjl2), C_WHITE, size)
              local k = 1
              for j = 1, 18 do
                if 0 < xlmj[j] or xlmj[j] < 0 then
                  if 0 < xlmj[j] then
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s +%2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  else
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s  %2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  end
                  k = k + 1
                end
              end
              ShowScreen()
              WaitKey()
              return
            end
            break
          end
        end
        if oldwugong == 0 then
          if 0 < p["\206\228\185\16610"] and 0 <= JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
            JY.ZUOBI = 1
            return
          end
          local k = 1
          for i = 1, 10 do
            if p["\206\228\185\166" .. i] == 0 then
              p["\206\228\185\166" .. i] = wugongid
              DrawString(x1 + size, y1 + ysize * 1, string.format("\208\222\193\182 %s \179\201\185\166", JY.Thing[thingid]["\195\251\179\198"]), C_WHITE, size)
              DrawString(x1 + size, y1 + ysize * 2, string.format("%s \180\211%d\188\182\201\253\214\193%d\188\182", JY.Wugong[wugongid]["\195\251\179\198"], math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev, math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1), C_WHITE, size)
              local wggjl1
              if 0 < math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev then
                wggjl1 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1 - mijilev]
              else
                wggjl1 = 0
              end
              local wggjl2 = JY.Wugong[wugongid]["\185\165\187\247\193\166" .. math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1]
              DrawString(x1 + size, y1 + ysize * 3, string.format("\206\228\185\166\205\254\193\166 %d \161\250 %d", wggjl1, wggjl2), C_WHITE, size)
              for j = 1, 18 do
                if 0 < xlmj[j] or xlmj[j] < 0 then
                  if 0 < xlmj[j] then
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s +%2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  else
                    DrawString(x1 + size, y1 + ysize * (3 + k), string.format("%-10s  %2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
                  end
                  k = k + 1
                end
              end
              break
            end
          end
          if xlmj[19] == 2 then
            DrawString(x1 + size, y1 + ysize * (3 + k), string.format(xlmjstr[19]), C_WHITE, size)
          end
        end
      elseif p["\208\222\193\182\181\227\202\253"] < TrainNeedExp(pid) then
        DrawString(x1 + size, y1 + ysize * 1, string.format("\208\222\193\182 %s \179\201\185\166", JY.Thing[thingid]["\195\251\179\198"]), C_WHITE, size)
        local k = 0
        for j = 1, 18 do
          if 0 < xlmj[j] or xlmj[j] < 0 then
            if 0 < xlmj[j] then
              DrawString(x1 + size, y1 + ysize * (2 + k), string.format("%-10s +%2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
            else
              DrawString(x1 + size, y1 + ysize * (2 + k), string.format("%-10s  %2d", xlmjstr[j], xlmj[j] * mijilev), C_WHITE, size)
            end
            k = k + 1
          end
        end
        if xlmj[19] == 2 then
          DrawString(x1 + size, y1 + ysize * (2 + k), string.format(xlmjstr[19]), C_WHITE, size)
        end
      end
      if p["\208\222\193\182\181\227\202\253"] < TrainNeedExp(pid) then
        ShowScreen()
        WaitKey()
      end
      needpoint = TrainNeedExp(pid)
    else
      return
    end
  end
end

function War_PersonTrainDrug(pid)
  local p = JY.Person[pid]
  local thingid = p["\208\222\193\182\206\239\198\183"]
  if thingid < 0 then
    return
  end
  if 0 >= JY.Thing[thingid]["\193\183\179\246\206\239\198\183\208\232\190\173\209\233"] then
    return
  end
  local needpoint = (7 - math.modf(p["\215\202\214\202"] / 15)) * JY.Thing[thingid]["\193\183\179\246\206\239\198\183\208\232\190\173\209\233"]
  if needpoint > p["\206\239\198\183\208\222\193\182\181\227\202\253"] then
    return
  end
  local haveMaterial = 0
  local MaterialNum = -1
  for i = 1, CC.MyThingNum do
    if JY.Base["\206\239\198\183" .. i] == JY.Thing[thingid]["\208\232\178\196\193\207"] then
      haveMaterial = 1
      MaterialNum = JY.Base["\206\239\198\183\202\253\193\191" .. i]
      break
    end
  end
  if haveMaterial == 1 then
    local enough = {}
    local canMake = 0
    for i = 1, 5 do
      if MaterialNum >= JY.Thing[thingid]["\208\232\210\170\206\239\198\183\202\253\193\191" .. i] and 0 <= JY.Thing[thingid]["\193\183\179\246\206\239\198\183" .. i] then
        canMake = 1
        enough[i] = 1
      else
        enough[i] = 0
      end
    end
    if canMake == 1 then
      local makeID
      local makenum = 0
      for i = 1, 5 do
        if 0 < JY.Thing[thingid]["\193\183\179\246\206\239\198\183" .. i] then
          makenum = makenum + 1
        end
      end
      while true do
        makeID = Rnd(5) + 1
        if enough[makeID] == 1 then
          break
        end
      end
      local newThingID = JY.Thing[thingid]["\193\183\179\246\206\239\198\183" .. makeID]
      if 0 <= newThingID then
        local wpnum = 0
        if instruct_18(newThingID) == true then
          wpnum = 1 + Rnd(3)
          instruct_32(newThingID, wpnum)
        else
          wpnum = 1 + Rnd(3)
          instruct_32(newThingID, wpnum)
        end
        Cls()
        DrawStrBoxWaitKey(string.format("%s \214\198\212\236\179\246%d\184\246%s %s-%d\163\172\202\163\211\224%d%s", p.姓名, wpnum, JY.Thing[newThingID]["\195\251\179\198"], JY.Thing[JY.Thing[thingid]["\208\232\178\196\193\207"]]["\195\251\179\198"], JY.Thing[thingid]["\208\232\210\170\206\239\198\183\202\253\193\191" .. makeID], MaterialNum - JY.Thing[thingid]["\208\232\210\170\206\239\198\183\202\253\193\191" .. makeID], JY.Thing[JY.Thing[thingid]["\208\232\178\196\193\207"]]["\195\251\179\198"]), C_WHITE, CC.DefaultFont)
        instruct_32(JY.Thing[thingid]["\208\232\178\196\193\207"], -JY.Thing[thingid]["\208\232\210\170\206\239\198\183\202\253\193\191" .. makeID])
        p["\206\239\198\183\208\222\193\182\181\227\202\253"] = p["\206\239\198\183\208\222\193\182\181\227\202\253"] - needpoint
      end
    end
  end
end

function War_isEnd()
  JY.WARWF = 0
  JY.WARDF = 0
  for i = 0, WAR.PersonNum - 1 do
    if 0 >= JY.Person[WAR.Person[i]["\200\203\206\239\177\224\186\197"]].生命 then
      WAR.Person[i].死亡 = true
    end
    if WAR.Person[i].死亡 == false then
      if WAR.Person[i]["\206\210\183\189"] then
        JY.WARWF = JY.WARWF + 1
      else
        JY.WARDF = JY.WARDF + 1
      end
    end
  end
  WarSetPerson()
  Cls()
  ShowScreen()
  local myNum = 0
  local EmenyNum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i].死亡 == false then
      if WAR.Person[i]["\206\210\183\189"] == true then
        myNum = 1
      else
        EmenyNum = 1
      end
    end
  end
  if EmenyNum == 0 then
    return 1
  end
  if myNum == 0 then
    return 2
  end
  return 0
end

function WarSelectTeam()
  WAR.PersonNum = 0
  while true do
    for i = 1, 6 do
      local id = WAR.Data["\215\212\182\175\209\161\212\241\178\206\213\189\200\203" .. i]
      if 0 <= id then
        WAR.Person[WAR.PersonNum]["\200\203\206\239\177\224\186\197"] = id
        WAR.Person[WAR.PersonNum]["\206\210\183\189"] = true
        WAR.Person[WAR.PersonNum]["\215\248\177\234X"] = WAR.Data["\206\210\183\189X" .. i]
        WAR.Person[WAR.PersonNum]["\215\248\177\234Y"] = WAR.Data["\206\210\183\189Y" .. i]
        WAR.Person[WAR.PersonNum].死亡 = false
        WAR.Person[WAR.PersonNum]["\200\203\183\189\207\242"] = 2
        WAR.PersonNum = WAR.PersonNum + 1
      end
    end
    if WAR.PersonNum > 0 then
      return
    end
    local warxrpd = 0
    for i = 1, CC.TeamNum do
      WAR.SelectPerson[i] = 0
      local id = JY.Base["\182\211\206\233" .. i]
      if 0 <= id then
        for j = 1, 6 do
          if WAR.Data["\202\214\182\175\209\161\212\241\178\206\213\189\200\203" .. j] == id then
            WAR.SelectPerson[i] = 1
            warxrpd = 1
          end
        end
      end
      WAR.SelectPerson[1] = 0
    end
    local menu = {}
    for i = 1, CC.TeamNum do
      menu[i] = {
        "",
        WarSelectMenu,
        0
      }
      local id = JY.Base["\182\211\206\233" .. i]
      if 0 <= id then
        menu[i][3] = 1
        local s = JY.Person[id].姓名
        if WAR.SelectPerson[i] == 1 then
          menu[i][1] = "\179\246\213\189  " .. s
        else
          menu[i][1] = "      " .. s
          for j = 1, CC.TeamNum do
            if zdyx[j][2] == id then
              WAR.SelectPerson[i] = 2
              menu[i][1] = "\179\246\213\189  " .. s
              warxrpd = 1
            end
          end
        end
      end
    end
    menu[CC.TeamNum + 1] = {
      "  \209\161\212\241\200\171\178\191",
      WarSelectMenu1,
      1
    }
    if warxrpd == 1 then
      menu[CC.TeamNum + 2] = {
        "  \191\170\202\188\213\189\182\183",
        nil,
        2
      }
    else
      menu[CC.TeamNum + 2] = {
        "  \191\170\202\188\213\189\182\183",
        nil,
        1
      }
    end
    Cls()
    local x = (CC.ScreenW - 7 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2
    DrawStrBox(x, 10, "\199\235\209\161\212\241\178\206\213\189\200\203\206\239", C_WHITE, CC.DefaultFont)
    local r = ShowMenu(menu, CC.TeamNum + 2, 0, x, 10 + CC.SingleLineHeight, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)
    Cls()
    for i = 1, CC.TeamNum do
      if 0 < WAR.SelectPerson[i] then
        WAR.Person[WAR.PersonNum]["\200\203\206\239\177\224\186\197"] = JY.Base["\182\211\206\233" .. i]
        WAR.Person[WAR.PersonNum]["\206\210\183\189"] = true
        if CC.TeamNum == 6 then
          WAR.Person[WAR.PersonNum]["\215\248\177\234X"] = WAR.Data["\206\210\183\189X" .. i]
          WAR.Person[WAR.PersonNum]["\215\248\177\234Y"] = WAR.Data["\206\210\183\189Y" .. i]
        elseif i <= 6 then
          WAR.Person[WAR.PersonNum]["\215\248\177\234X"] = WAR.Data["\206\210\183\189X" .. i]
          WAR.Person[WAR.PersonNum]["\215\248\177\234Y"] = WAR.Data["\206\210\183\189Y" .. i]
        else
          while true do
            local xkk = Rnd(5) - 2
            local ykk = Rnd(5) - 2
            local kkpd = true
            for j = 1, 20 do
              if WAR.Data["\181\208\183\189X" .. j] == WAR.Data["\206\210\183\189X" .. i - 6] + xkk and WAR.Data["\181\208\183\189Y" .. j] == WAR.Data["\206\210\183\189Y" .. i - 6] + ykk then
                kkpd = false
                break
              end
            end
            for j = 1, 6 do
              if WAR.Data["\206\210\183\189X" .. j] == WAR.Data["\206\210\183\189X" .. i - 6] + xkk and WAR.Data["\206\210\183\189Y" .. j] == WAR.Data["\206\210\183\189Y" .. i - 6] + ykk then
                kkpd = false
                break
              end
            end
            if kkpd then
              WAR.Person[WAR.PersonNum]["\215\248\177\234X"] = WAR.Data["\206\210\183\189X" .. i - 6] + xkk
              WAR.Person[WAR.PersonNum]["\215\248\177\234Y"] = WAR.Data["\206\210\183\189Y" .. i - 6] + ykk
              break
            end
          end
        end
        WAR.Person[WAR.PersonNum].死亡 = false
        WAR.Person[WAR.PersonNum]["\200\203\183\189\207\242"] = 2
        WAR.PersonNum = WAR.PersonNum + 1
        zdyx[i][1] = 2
        zdyx[i][2] = JY.Base["\182\211\206\233" .. i]
      else
        zdyx[i][1] = 0
        zdyx[i][2] = -1
        if WAR.PersonNum == 0 then
          WAR.SelectPerson[1] = 2
          zdyx[1][1] = 2
          zdyx[1][2] = JY.Base["\182\211\206\233" .. 1]
        end
      end
    end
    if WAR.PersonNum > 0 then
      xzqbpd = 3
      break
    end
  end
end

function WarSelectMenu(newmenu, newid)
  local id = newmenu[newid][4]
  if WAR.SelectPerson[id] == 0 then
    WAR.SelectPerson[id] = 2
  elseif WAR.SelectPerson[id] == 2 then
    WAR.SelectPerson[id] = 0
  end
  if WAR.SelectPerson[id] > 0 then
    newmenu[newid][1] = "\179\246\213\189  " .. string.sub(newmenu[newid][1], 7)
  else
    newmenu[newid][1] = "      " .. string.sub(newmenu[newid][1], 7)
  end
  return 0
end

function WarSelectMenu1(newmenu, newid)
  if xzqbpd == 0 then
    xzqbpd = 3
  elseif xzqbpd == 3 then
    xzqbpd = 0
  end
  for i = 1, newid - 1 do
    local id = JY.Base["\182\211\206\233" .. i]
    if 0 <= id then
      newmenu[i][3] = 1
    end
  end
  local zdnum = 0
  if xzqbpd == 0 then
    for i = 1, newid - 1 do
      if WAR.SelectPerson[i] ~= 1 and newmenu[i][3] ~= 0 then
        newmenu[i][1] = "\179\246\213\189  " .. string.sub(newmenu[i][1], 7)
        WAR.SelectPerson[i] = 2
      end
      if 0 < WAR.SelectPerson[i] then
        zdnum = zdnum + 1
      end
    end
    newmenu[zdnum + 1][1] = "  \200\161\207\251\200\171\178\191"
  else
    for i = 1, newid - 1 do
      if WAR.SelectPerson[i] ~= 1 and newmenu[i][3] ~= 0 then
        newmenu[i][1] = "      " .. string.sub(newmenu[i][1], 7)
        WAR.SelectPerson[i] = 0
        zdnum = zdnum + 1
      end
    end
    for i = 1, newid - 1 do
      if 0 < WAR.SelectPerson[i] then
        zdnum = zdnum + 1
      end
    end
    newmenu[zdnum + 1][1] = "  \209\161\212\241\200\171\178\191"
  end
  return 0
end

function WarSelectEnemy()
  for i = 1, 20 do
    if WAR.Data["\181\208\200\203" .. i] > 0 then
      WAR.Person[WAR.PersonNum]["\200\203\206\239\177\224\186\197"] = WAR.Data["\181\208\200\203" .. i]
      WAR.Person[WAR.PersonNum]["\206\210\183\189"] = false
      WAR.Person[WAR.PersonNum]["\215\248\177\234X"] = WAR.Data["\181\208\183\189X" .. i]
      WAR.Person[WAR.PersonNum]["\215\248\177\234Y"] = WAR.Data["\181\208\183\189Y" .. i]
      WAR.Person[WAR.PersonNum].死亡 = false
      WAR.Person[WAR.PersonNum]["\200\203\183\189\207\242"] = 1
      WAR.PersonNum = WAR.PersonNum + 1
    end
  end
end

function WarLoadMap(mapid)
  lib.Debug(string.format("load war map %d", mapid))
  lib.LoadWarMap(CC.WarMapFile[1], CC.WarMapFile[2], mapid, 7, CC.WarWidth, CC.WarHeight)
end

function GetWarMap(x, y, level)
  if 63 < x or x < 0 or 63 < y or y < 0 then
    return
  end
  return lib.GetWarMap(x, y, level)
end

function SetWarMap(x, y, level, v)
  if 63 < x or x < 0 or 63 < y or y < 0 then
    return
  end
  lib.SetWarMap(x, y, level, v)
end

function CleanWarMap(level, v)
  lib.CleanWarMap(level, v)
end

function WarDrawMap(flag, v1, v2, v3, v4, v5, ex, ey)
  local x = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  v4 = v4 or JY.SubScene
  v5 = v5 or -1
  if flag == 0 then
    lib.DrawWarMap(0, x, y, 0, 0, -1, v4)
  elseif flag == 1 then
    if v4 == 0 or v4 == 2 or v4 == 3 or v4 == 4 or v4 == 39 then
      lib.DrawWarMap(1, x, y, v1, v2, -1, v4)
    else
      lib.DrawWarMap(2, x, y, v1, v2, -1, v4)
    end
  elseif flag == 2 then
    lib.DrawWarMap(3, x, y, 0, 0, -1, v4)
  elseif flag == 4 then
    if ex == nil or ey == nil then
      ex = -1
      ey = -1
    end
    lib.DrawWarMap(4, x, y, v1, v2, v3, v4, v5, ex, ey)
  end
  if WAR.ShowHead == 1 then
    WarShowHead()
  end
  if JY.XTKG == 1 then
    ShowXT()
  end
  DrawBox(CC.ScreenW - CC.DefaultFont * 5 - 2 * CC.Zoom, 0, CC.ScreenW, CC.DefaultFont * 3 + 4 * CC.Zoom, C_WHITE)
  DrawString(CC.ScreenW - CC.DefaultFont * 5, 2 * CC.Zoom, string.format("\181\218%d\187\216\186\207", JY.ZDHH), C_WHITE, CC.DefaultFont)
  DrawString(CC.ScreenW - CC.DefaultFont * 5, CC.DefaultFont + 2 * CC.Zoom, string.format("\206\210\183\189\163\186%2d\200\203", JY.WARWF), C_GOLD, CC.DefaultFont)
  DrawString(CC.ScreenW - CC.DefaultFont * 5, CC.DefaultFont * 2 + 2 * CC.Zoom, string.format("\181\208\183\189\163\186%2d\200\203", JY.WARDF), C_RED, CC.DefaultFont)
end

function WarPersonSort()
  for i = 0, WAR.PersonNum - 1 do
    local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    local add = 0
    if JY.Person[id]["\206\228\198\247"] > -1 then
      add = add + JY.Thing[JY.Person[id]["\206\228\198\247"]]["\188\211\199\225\185\166"]
    end
    if -1 < JY.Person[id]["\183\192\190\223"] then
      add = add + JY.Thing[JY.Person[id]["\183\192\190\223"]]["\188\211\199\225\185\166"]
    end
    WAR.Person[i]["\199\225\185\166"] = JY.Person[id]["\199\225\185\166"] + add
    local move = math.modf(WAR.Person[i]["\199\225\185\166"] / 15) - math.modf(JY.Person[id]["\202\220\201\203\179\204\182\200"] / 40)
    if move < 0 then
      move = 0
    end
    WAR.Person[i]["\210\198\182\175\178\189\202\253"] = move
  end
  for i = 0, WAR.PersonNum - 2 do
    local maxid = i
    for j = i, WAR.PersonNum - 1 do
      if WAR.Person[j]["\199\225\185\166"] > WAR.Person[maxid]["\199\225\185\166"] then
        maxid = j
      end
    end
    WAR.Person[maxid], WAR.Person[i] = WAR.Person[i], WAR.Person[maxid]
  end
end

function WarSetPerson()
  CleanWarMap(2, -1)
  CleanWarMap(5, -1)
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i].死亡 == false then
      SetWarMap(WAR.Person[i]["\215\248\177\234X"], WAR.Person[i]["\215\248\177\234Y"], 2, i)
      SetWarMap(WAR.Person[i]["\215\248\177\234X"], WAR.Person[i]["\215\248\177\234Y"], 5, WAR.Person[i]["\204\249\205\188"])
    end
  end
end

function WarCalPersonPic(id)
  local n = 5106
  n = n + JY.Person[WAR.Person[id]["\200\203\206\239\177\224\186\197"]]["\205\183\207\241\180\250\186\197"] * 8 + WAR.Person[id]["\200\203\183\189\207\242"] * 2
  return n
end

function War_Manual()
  local r
  WAR.ShowHead = 1
  local movedtbs = WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"]
  local movedtx = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local movedty = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local movedtfx = WAR.Person[WAR.CurID]["\200\203\183\189\207\242"]
  local pic = WAR.Person[WAR.CurID]["\204\249\205\188"]
  while true do
    r = War_Manual_Sub()
    if r == 0 then
      local x = WAR.Person[WAR.CurID]["\215\248\177\234X"]
      local y = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
      SetWarMap(x, y, 2, -1)
      SetWarMap(x, y, 5, -1)
      WAR.Person[WAR.CurID]["\215\248\177\234X"] = movedtx
      WAR.Person[WAR.CurID]["\215\248\177\234Y"] = movedty
      WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = movedtfx
      WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] = movedtbs
      SetWarMap(movedtx, movedty, 2, WAR.CurID)
      SetWarMap(movedtx, movedty, 5, pic)
      WarDrawMap(0)
      ShowScreen()
    end
    if math.abs(r) ~= 1 and r ~= 0 then
      break
    end
  end
  WAR.ShowHead = 0
  return r
end

function War_Manual_Sub()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local menu = {
    {
      "\210\198\182\175",
      War_MoveMenu,
      1
    },
    {
      "\185\165\187\247",
      War_FightMenu,
      1
    },
    {
      "\211\195\182\190",
      War_PoisonMenu,
      1
    },
    {
      "\189\226\182\190",
      War_DecPoisonMenu,
      1
    },
    {
      "\210\189\193\198",
      War_DoctorMenu,
      1
    },
    {
      "\206\239\198\183",
      War_ThingMenu,
      1
    },
    {
      "\181\200\180\253",
      War_WaitMenu,
      1
    },
    {
      "\215\180\204\172",
      War_StatusMenu,
      1
    },
    {
      "\184\180\187\238",
      War_Huhuo,
      0
    },
    {
      "\177\228\201\237",
      War_Bianshen,
      0
    },
    {
      "\208\221\207\162",
      War_RestMenu,
      1
    },
    {
      "\215\212\182\175",
      War_AutoMenu,
      1
    }
  }
  if JY.Person[pid]["\204\229\193\166"] <= 5 or 0 >= WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] then
    menu[1][3] = 0
  end
  local minv = War_GetMinNeiLi(pid)
  if minv > JY.Person[pid]["\196\218\193\166"] or JY.Person[pid]["\204\229\193\166"] < 10 then
    menu[2][3] = 0
  end
  if JY.Person[pid]["\204\229\193\166"] < 10 or JY.Person[pid]["\211\195\182\190\196\220\193\166"] < 20 then
    menu[3][3] = 0
  end
  if JY.Person[pid]["\204\229\193\166"] < 10 or 20 > JY.Person[pid]["\189\226\182\190\196\220\193\166"] then
    menu[4][3] = 0
  end
  if JY.Person[pid]["\204\229\193\166"] < 50 or 20 > JY.Person[pid]["\210\189\193\198\196\220\193\166"] then
    menu[5][3] = 0
  end
  if pid == 0 and CC.BanBen == 1 then
    local lev = JY.Person[0]["\181\200\188\182"]
    local hhlev = 15
    if JY.Person[0].姓名 == "szlzw" then
      hhlev = 30
    end
    if CC.JS == 1 and JY.Person[0].外号 == "\206\215\209\253" and 0 >= JY.Huhuolq and 0 < JY.Huhuocs and lev >= hhlev then
      menu[9][3] = 1
    end
    if CC.JS == 1 and JY.Person[0].姓名 == "szlzw" and JY.YXND == 0 then
      menu[10][3] = 1
    end
    if CC.JS == 1 and JY.Person[0].姓名 == "szlzw" and JY.YXND == 1 and JY.Person[0]["\181\200\188\182"] > 9 then
      menu[10][3] = 1
    end
    if CC.JS == 1 and JY.Person[0].姓名 == "szlzw" and JY.YXND == 2 and JY.Person[0]["\181\200\188\182"] > 19 then
      menu[10][3] = 1
    end
  end
  Cls()
  return ShowMenu(menu, #menu, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.DefaultFont * 1.2, C_ORANGE, C_WHITE)
end

function War_XT()
  if JY.XTKG == 1 then
    JY.XTKG = 0
  else
    JY.XTKG = 1
  end
end

function War_GetMinNeiLi(pid)
  local minv = math.huge
  for i = 1, 10 do
    local tmpid = JY.Person[pid]["\206\228\185\166" .. i]
    if 0 < tmpid and minv > JY.Wugong[tmpid]["\207\251\186\196\196\218\193\166\181\227\202\253"] then
      minv = JY.Wugong[tmpid]["\207\251\186\196\196\218\193\166\181\227\202\253"]
    end
  end
  return minv
end

function WarShowHead(id)
  id = id or WAR.CurID
  if id < 0 then
    return
  end
  local pid = WAR.Person[id]["\200\203\206\239\177\224\186\197"]
  local p = JY.Person[pid]
  local h = CC.DefaultFont + CC.MenuBorderPixel
  local w = CC.DefaultFont + CC.MenuBorderPixel
  local headww = 65 * CC.Zoom
  local headhh = 65 * CC.Zoom
  local width = 2 * CC.MenuBorderPixel + 7.5 * h
  local height = 2 * CC.MenuBorderPixel + 7.5 * h + headhh
  local x1, y1
  local i = 1
  if WAR.Person[id]["\206\210\183\189"] == true then
    x1 = CC.ScreenW - width
    y1 = CC.ScreenH - height
  else
    x1 = 0
    y1 = 0
  end
  DrawBox(x1, y1, x1 + width, y1 + height, C_WHITE)
  local size = CC.DefaultFont
  local hid = p["\205\183\207\241\180\250\186\197"]
  if hid == 0 and JY.Person[0].姓名 == "szlzw" then
    if existFile(CC.HeadPath .. CC.JSHead .. ".png") then
      JY.Person[0]["\205\183\207\241\180\250\186\197"] = CC.JSHead
      hid = CC.JSHead
    else
      JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
      hid = 0
    end
  end
  if existFile(CC.HeadPath .. hid .. ".png") then
    local headw, headh = lib.GetPNGXY(1, hid * 2)
    local headx = CC.PersonStateRowPixel
    local heady = CC.PersonStateRowPixel
    local hdmax = 0
    if headw > hdmax then
      hdmax = headw
    end
    if headh > hdmax then
      hdmax = headh
    end
    local zoom = math.modf(70 * CC.Zoom / hdmax * 100 * (CONFIG.Zoom / 100))
    lib.LoadPicture(CC.HeadPath .. hid .. ".png", x1 + headx, y1 + heady, zoom)
    JY.Person[0]["\205\183\207\241\180\250\186\197"] = 0
  else
    local headw, headh = lib.PicGetXY(1, p["\205\183\207\241\180\250\186\197"] * 2)
    local headx = CC.PersonStateRowPixel
    local heady = CC.PersonStateRowPixel
    lib.PicLoadCache(1, p["\205\183\207\241\180\250\186\197"] * 2, x1 + headx, y1 + heady, 1)
  end
  DrawString(x1 + width - CC.DefaultFont * 4, y1, "\206\228\198\247", C_ORANGE, CC.DefaultFont)
  if 0 <= p["\206\228\198\247"] then
    local str1 = JY.Thing[p["\206\228\198\247"]]["\195\251\179\198"]
    DrawString(x1 + width - CC.DefaultFont * 4, y1 + h, str1, C_GOLD, CC.DefaultFont)
  else
    DrawString(x1 + width - CC.DefaultFont * 4, y1 + h, "\206\222", C_GOLD, CC.DefaultFont)
  end
  DrawString(x1 + width - CC.DefaultFont * 4, y1 + h * 2, "\183\192\190\223", C_ORANGE, CC.DefaultFont)
  if 0 <= p["\183\192\190\223"] then
    local str2 = JY.Thing[p["\183\192\190\223"]]["\195\251\179\198"]
    DrawString(x1 + width - CC.DefaultFont * 4, y1 + h * 3, str2, C_GOLD, CC.DefaultFont)
  else
    DrawString(x1 + width - CC.DefaultFont * 4, y1 + h * 3, "\206\222", C_GOLD, CC.DefaultFont)
  end
  x1 = x1 + CC.PersonStateRowPixel
  y1 = y1 + CC.PersonStateRowPixel * 2 + headhh
  DrawString(x1, y1, p.姓名, C_WHITE, CC.DefaultFont)
  DrawString(x1 + w * 5, y1, string.format("%2d\188\182", p["\181\200\188\182"]), C_GOLD, CC.DefaultFont)
  local color
  if p["\202\220\201\203\179\204\182\200"] < 33 then
    color = RGB(236, 200, 40)
  elseif p["\202\220\201\203\179\204\182\200"] < 66 then
    color = RGB(255, 192, 203)
  else
    color = RGB(232, 32, 44)
  end
  DrawString(x1, y1 + h, "\201\250\195\252", C_ORANGE, CC.DefaultFont)
  DrawString(x1 + w * 2, y1 + h, string.format("%4d", p.生命), color, CC.DefaultFont)
  DrawString(x1 + w * 4, y1 + h, "/", C_GOLD, CC.DefaultFont)
  if p["\214\208\182\190\179\204\182\200"] == 0 then
    color = C_GOLD
  elseif p["\214\208\182\190\179\204\182\200"] < 50 then
    color = RGB(120, 208, 88)
  else
    color = RGB(56, 136, 36)
  end
  DrawString(x1 + w * 4.5, y1 + h, string.format("%4d", p["\201\250\195\252\215\238\180\243\214\181"]), color, CC.DefaultFont)
  if p["\196\218\193\166\208\212\214\202"] == 0 then
    color = RGB(208, 152, 208)
  elseif p["\196\218\193\166\208\212\214\202"] == 1 then
    color = RGB(236, 200, 40)
  else
    color = RGB(236, 236, 236)
  end
  DrawString(x1, y1 + h * 2, "\196\218\193\166", C_ORANGE, CC.DefaultFont)
  DrawString(x1 + w * 2, y1 + h * 2, string.format("%4d/%4d", p["\196\218\193\166"], p["\196\218\193\166\215\238\180\243\214\181"]), color, CC.DefaultFont)
  DrawString(x1, y1 + h * 3, "\204\229\193\166", C_ORANGE, CC.DefaultFont)
  DrawString(x1 + w * 2, y1 + h * 3, string.format("%4d", p["\204\229\193\166"]), C_GOLD, CC.DefaultFont)
  DrawString(x1, y1 + h * 4, string.format("\201\203 %d", p["\202\220\201\203\179\204\182\200"]), RGB(255, 192, 203), CC.DefaultFont)
  DrawString(x1 + w * 4, y1 + h * 4, string.format("\182\190 %d", p["\214\208\182\190\179\204\182\200"]), RGB(120, 208, 88), CC.DefaultFont)
  local gjl = p["\185\165\187\247\193\166"]
  local fyl = p["\183\192\211\249\193\166"]
  local qg = p["\199\225\185\166"]
  if 0 <= p["\206\228\198\247"] then
    gjl = gjl + JY.Thing[p["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
    fyl = fyl + JY.Thing[p["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
    qg = qg + JY.Thing[p["\206\228\198\247"]]["\188\211\199\225\185\166"]
  end
  if 0 <= p["\183\192\190\223"] then
    gjl = gjl + JY.Thing[p["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
    fyl = fyl + JY.Thing[p["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
    qg = qg + JY.Thing[p["\183\192\190\223"]]["\188\211\199\225\185\166"]
  end
  DrawString(x1, y1 + h * 5, string.format("\185\165 %d", gjl), C_RED, CC.DefaultFont)
  DrawString(x1 + w * 4, y1 + h * 5, string.format("\183\192 %d", fyl), C_RED, CC.DefaultFont)
  DrawString(x1, y1 + h * 6, string.format("\199\225 %d", qg), C_RED, CC.DefaultFont)
  DrawString(x1 + w * 4, y1 + h * 6, string.format("\202\182 %d", p["\206\228\209\167\179\163\202\182"]), C_RED, CC.DefaultFont)
  if pid == 0 and JY.Person[pid].外号 == "\200\173\176\212" and CC.JS == 1 then
    local xgstr = "\200\173\176\212\161\250\198\198\183\192\201\203\186\166\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\189\163\196\167" and CC.JS == 1 then
    local xgstr = "\189\163\196\167\161\250\202\200\209\170\201\203\186\166\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\181\182\179\213" and CC.JS == 1 then
    local xgstr = "\181\182\179\213\161\250\210\187\187\247\177\216\201\177\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\204\216\191\241" and CC.JS == 1 then
    local xgstr = "\204\216\191\241\161\250\177\169\187\247\201\203\186\166\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\201\241\214\250" and CC.JS == 1 then
    local xgstr = "\201\241\214\250\161\250\204\236\201\241\187\164\204\229\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\206\215\209\253" and CC.JS == 1 then
    local xgstr = "\206\215\209\253\161\250\195\187\211\208\214\216\201\250\188\188\196\220"
    local lev = JY.Person[0]["\181\200\188\182"]
    local hhlev = 15
    if 0 < JY.YXND and JY.Person[0].姓名 == "szlzw" then
      hhlev = 30
    end
    if JY.Person[0].姓名 ~= "szlzw" then
      if 0 < JY.Huhuolq and 0 < JY.Huhuocs and lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\214\216\201\250\188\188\196\220" .. JY.Huhuolq .. "\187\216\186\207\186\243\188\164\187\238\163\172\202\163\211\224" .. JY.Huhuocs .. "\180\206"
      elseif JY.Huhuolq == 0 and 0 < JY.Huhuocs and lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\214\216\201\250\188\188\196\220\188\164\187\238\163\172\202\163\211\224" .. JY.Huhuocs .. "\180\206"
      elseif lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\210\209\211\195\205\234\214\216\201\250\188\188\196\220"
      elseif lev < hhlev then
        xgstr = "\206\215\209\253\161\250\196\220\193\166\178\187\215\227\206\222\183\168\188\164\187\238\214\216\201\250\188\188\196\220"
      end
    elseif 0 < JY.YXND then
      if 0 < JY.Huhuolq and 0 < JY.Huhuocs and lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\214\216\201\250\188\188\196\220" .. JY.Huhuolq .. "\187\216\186\207\186\243\188\164\187\238\163\172\202\163\211\224" .. JY.Huhuocs .. "\180\206"
      elseif JY.Huhuolq == 0 and 0 < JY.Huhuocs and lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\214\216\201\250\188\188\196\220\188\164\187\238\163\172\202\163\211\224" .. JY.Huhuocs .. "\180\206"
      elseif lev >= hhlev then
        xgstr = "\206\215\209\253\161\250\210\209\211\195\205\234\214\216\201\250\188\188\196\220"
      elseif lev < hhlev then
        xgstr = "\206\215\209\253\161\250\196\220\193\166\178\187\215\227\206\222\183\168\188\164\187\238\214\216\201\250\188\188\196\220"
      end
    end
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\182\190\205\245" and CC.JS == 1 then
    local xgstr = "\182\190\205\245\161\250\180\227\182\190\201\203\186\166\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  elseif pid == 0 and JY.Person[pid].外号 == "\187\195\211\176" and CC.JS == 1 then
    local xgstr = "\187\195\211\176\161\250\211\176\201\177\188\188\196\220\188\164\187\238"
    local xglen = #xgstr
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
  end
  if 0 < JY.YXND and JY.Person[0].姓名 == "szlzw" and JY.Person[pid].外号 == "\179\172\201\241" and CC.JS == 1 then
    if JY.YXND == 1 then
      if JY.Person[0]["\181\200\188\182"] > 9 then
        local xgstr = "\179\172\201\241\161\250\184\196\177\228\208\205\204\172\188\164\187\238"
        local xglen = #xgstr
        DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
      else
        local xgstr = "\179\172\201\241\161\250\196\220\193\166\178\187\215\227\206\222\183\168\184\196\177\228\208\205\204\172"
        local xglen = #xgstr
        DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
      end
    elseif JY.YXND == 2 then
      if JY.Person[0]["\181\200\188\182"] > 19 then
        local xgstr = "\179\172\201\241\161\250\184\196\177\228\208\205\204\172\188\164\187\238"
        local xglen = #xgstr
        DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
      else
        local xgstr = "\179\172\201\241\161\250\196\220\193\166\178\187\215\227\206\222\183\168\184\196\177\228\208\205\204\172"
        local xglen = #xgstr
        DrawString(CC.ScreenW / 2 - CC.DefaultFont * xglen / 4, CC.DefaultFont, xgstr, C_WHITE, CC.DefaultFont)
      end
    end
  end
end

function War_MoveMenu()
  WAR.ShowHead = 0
  if 0 >= WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] then
    return 0
  end
  War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"], 0)
  local r
  local x, y = War_SelectMove()
  if x ~= nil then
    War_MovePerson(x, y)
    r = 1
  else
    r = 0
  end
  WAR.ShowHead = 1
  Cls()
  return r
end

function War_CalMoveStep(id, stepmax, flag)
  CleanWarMap(3, 255)
  local x = WAR.Person[id]["\215\248\177\234X"]
  local y = WAR.Person[id]["\215\248\177\234Y"]
  local steparray = {}
  for i = 0, stepmax do
    steparray[i] = {}
    steparray[i].x = {}
    steparray[i].y = {}
  end
  SetWarMap(x, y, 3, 0)
  steparray[0].num = 1
  steparray[0].x[1] = x
  steparray[0].y[1] = y
  for i = 0, stepmax - 1 do
    War_FindNextStep(steparray, i, flag)
    if steparray[i + 1].num == 0 then
      break
    end
  end
  return steparray
end

function War_FindNextStep(steparray, step, flag)
  local num = 0
  local step1 = step + 1
  for i = 1, steparray[step].num do
    local x = steparray[step].x[i]
    local y = steparray[step].y[i]
    if x + 1 < CC.WarWidth - 1 then
      local v = GetWarMap(x + 1, y, 3)
      if v == 255 and War_CanMoveXY(x + 1, y, flag) == true then
        num = num + 1
        steparray[step1].x[num] = x + 1
        steparray[step1].y[num] = y
        SetWarMap(x + 1, y, 3, step1)
      end
    end
    if 0 < x - 1 then
      local v = GetWarMap(x - 1, y, 3)
      if v == 255 and War_CanMoveXY(x - 1, y, flag) == true then
        num = num + 1
        steparray[step1].x[num] = x - 1
        steparray[step1].y[num] = y
        SetWarMap(x - 1, y, 3, step1)
      end
    end
    if y + 1 < CC.WarHeight - 1 then
      local v = GetWarMap(x, y + 1, 3)
      if v == 255 and War_CanMoveXY(x, y + 1, flag) == true then
        num = num + 1
        steparray[step1].x[num] = x
        steparray[step1].y[num] = y + 1
        SetWarMap(x, y + 1, 3, step1)
      end
    end
    if 0 < y - 1 then
      local v = GetWarMap(x, y - 1, 3)
      if v == 255 and War_CanMoveXY(x, y - 1, flag) == true then
        num = num + 1
        steparray[step1].x[num] = x
        steparray[step1].y[num] = y - 1
        SetWarMap(x, y - 1, 3, step1)
      end
    end
  end
  steparray[step1].num = num
end

function War_CanMoveXY(x, y, flag)
  if x < 0 or 63 < x or y < 0 or 63 < y then
    return false
  end
  if 0 < GetWarMap(x, y, 1) then
    return false
  end
  if flag == 0 then
    if CC.WarWater[GetWarMap(x, y, 0)] ~= nil then
      return false
    end
    if 0 <= GetWarMap(x, y, 2) then
      return false
    end
  end
  return true
end

function War_SelectMove()
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local x = x0
  local y = y0
  while true do
    WAR.ShowHead = 0
    local x2 = x
    local y2 = y
    WarDrawMap(1, x, y)
    DrawString(CC.DefaultFont, CC.ScreenH - CC.DefaultFont * 3, string.format("%2d,%2d", x, y), C_GOLD, CC.DefaultFont)
    if 0 <= GetWarMap(x, y, 2) then
      WAR.ShowHead = 1
      WarShowHead(GetWarMap(x, y, 2))
    end
    ShowScreen()
    local key, ktype, mx, my = WaitKey(1)
    if key == VK_UP then
      y2 = y - 1
    elseif key == VK_DOWN then
      y2 = y + 1
    elseif key == VK_LEFT then
      x2 = x - 1
    elseif key == VK_RIGHT then
      x2 = x + 1
    elseif key == VK_SPACE or key == VK_RETURN or ktype == 3 then
      Movex, Movey = x, y
      return x, y
    elseif key == VK_ESCAPE or ktype == 4 then
      return nil
    elseif ktype == 2 then
      mx = mx - CC.ScreenW / 2
      my = my - CC.ScreenH / 2
      mx = mx / CC.XScale
      my = my / CC.YScale
      mx, my = (mx + my) / 2, (my - mx) / 2
      if 0 < mx then
        mx = mx + 0.99
      else
        mx = mx - 0.01
      end
      if 0 < my then
        my = my + 0.99
      else
        mx = mx - 0.01
      end
      mx = math.modf(mx)
      my = math.modf(my)
      for i = 0, 10 do
        if mx + i <= 63 and 63 < my + i then
          break
        end
        local hb = GetS(JY.SubScene, x0 + mx + i, y0 + my + i, 4)
        if math.abs(hb - CC.YScale * i * 2) < 5 then
          mx = mx + i
          my = my + i
        end
      end
      x2, y2 = mx + x0, my + y0
      x2 = limitX(x2, 0, 63)
      y2 = limitX(y2, 0, 63)
    end
    if GetWarMap(x2, y2, 3) < 128 then
      x = x2
      y = y2
    end
  end
end

function War_SelectMove1(v1, v2, v3)
  if v2 == nil then
    v2, v3 = 0, 0
  end
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local x = x0
  local y = y0
  local mvx = 0
  local mvy = 0
  local mvx3 = {}
  local mvy3 = {}
  local mvljx = {}
  local mvljy = {}
  local rsnum = 0
  for i = -v3, v3 do
    mvx3[i] = {}
    mvy3[i] = {}
    mvljx[i] = {}
    mvljy[i] = {}
    for j = -v3, v3 do
      mvx3[i][j] = j + i
      mvy3[i][j] = 0 - j + i
      mvljy[i][j] = y - j
      mvljx[i][j] = x + i
    end
  end
  while true do
    WAR.ShowHead = 0
    local x2 = x
    local y2 = y
    local mvx1 = mvx
    local mvy1 = mvy
    WarDrawMap(1, x, y)
    DrawString(CC.DefaultFont, CC.ScreenH - CC.DefaultFont * 3, string.format("%2d,%2d", x, y), C_GOLD, CC.DefaultFont)
    DrawString(CC.ScreenW / 2 - CC.DefaultFont * 5, CC.ScreenH - CC.DefaultFont * 4, JY.WGMC .. string.format(" \191\201\187\247\214\208%d\200\203", rsnum), C_WHITE, CC.DefaultFont)
    rsnum = 0
    if 0 <= GetWarMap(x, y, 2) then
      WAR.ShowHead = 1
      WarShowHead(GetWarMap(x, y, 2))
    end
    if v1 == 0 and 0 <= GetWarMap(x, y, 2) and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[GetWarMap(x, y, 2)]["\206\210\183\189"] then
      if CC.ScreenW >= 128 then
        ShowZhi(x, y)
      end
      rsnum = rsnum + 1
    end
    if v1 == 4 and 0 <= GetWarMap(x, y, 2) and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[GetWarMap(x, y, 2)]["\206\210\183\189"] then
      if CC.ScreenW >= 128 then
        ShowZhi(x, y)
      end
      rsnum = rsnum + 1
    end
    if v1 == 3 then
      for i = -v3, v3 do
        for j = -v3, v3 do
          if 0 <= GetWarMap(mvljx[i][j], mvljy[i][j], 2) then
            if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[GetWarMap(mvljx[i][j], mvljy[i][j], 2)]["\206\210\183\189"] then
              if CC.ScreenW >= 128 then
                ShowZhi(mvljx[i][j], mvljy[i][j])
              end
              rsnum = rsnum + 1
            end
          else
            lib.PicLoadCache(0, 0, CC.ScreenW / 2 + CC.XScale * mvx3[i][j], CC.ScreenH / 2 + CC.YScale * mvy3[i][j], 2, 100)
          end
        end
      end
    end
    ShowScreen()
    local key, ktype, mx, my = WaitKey(1)
    if key == VK_UP then
      y2 = y - 1
    elseif key == VK_DOWN then
      y2 = y + 1
    elseif key == VK_LEFT then
      x2 = x - 1
    elseif key == VK_RIGHT then
      x2 = x + 1
    elseif key == VK_SPACE or key == VK_RETURN then
      Movex, Movey = x, y
      return x, y
    elseif key == VK_ESCAPE or ktype == 4 then
      return nil
    elseif ktype == 2 or ktype == 3 then
      mx = mx - CC.ScreenW / 2
      my = my - CC.ScreenH / 2
      mx = mx / CC.XScale
      my = my / CC.YScale
      mx, my = (mx + my) / 2, (my - mx) / 2
      if 0 < mx then
        mx = mx + 0.99
      else
        mx = mx - 0.01
      end
      if 0 < my then
        my = my + 0.99
      else
        mx = mx - 0.01
      end
      mx = math.modf(mx)
      my = math.modf(my)
      for i = 0, 10 do
        if mx + i <= 63 and 63 < my + i then
          break
        end
        local hb = GetS(JY.SubScene, x0 + mx + i, y0 + my + i, 4)
        if 5 > math.abs(hb - CC.YScale * i * 2) then
          mx = mx + i
          my = my + i
        end
      end
      x2, y2 = mx + x0, my + y0
      x2 = limitX(x2, 0, 63)
      y2 = limitX(y2, 0, 63)
      if ktype == 3 then
        Movex, Movey = x, y
        return x, y
      end
    end
    if GetWarMap(x2, y2, 3) < 128 then
      x = x2
      y = y2
    end
    if v1 == 10 then
      if key == VK_UP then
        mvx1 = mvx1 + 1
        mvy1 = mvy1 - 1
      elseif key == VK_DOWN then
        mvx1 = mvx1 - 1
        mvy1 = mvy1 + 1
      elseif key == VK_LEFT then
        mvx1 = mvx1 - 1
        mvy1 = mvy1 - 1
      elseif key == VK_RIGHT then
        mvx1 = mvx1 + 1
        mvy1 = mvy1 + 1
      end
      if GetWarMap(x2, y2, 3) < 128 then
        mvx = mvx1
        mvy = mvy1
      end
    end
    if v1 == 3 then
      if key == VK_UP then
        if GetWarMap(x2, y2, 3) < 128 then
          mvx1 = mvx1 + 1
          mvy1 = mvy1 - 1
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 + j + i
              mvy3[i][j] = mvy1 - j + i
              mvljy[i][j] = y - j
              mvljx[i][j] = x + i
            end
          end
        end
      elseif key == VK_DOWN then
        if GetWarMap(x2, y2, 3) < 128 then
          mvx1 = mvx1 - 1
          mvy1 = mvy1 + 1
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 - j + i
              mvy3[i][j] = mvy1 + j + i
              mvljy[i][j] = y + j
              mvljx[i][j] = x + i
            end
          end
        end
      elseif key == VK_LEFT then
        mvx1 = mvx1 - 1
        mvy1 = mvy1 - 1
        if GetWarMap(x2, y2, 3) < 128 then
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 - j - i
              mvy3[i][j] = mvy1 - j + i
              mvljy[i][j] = y + i
              mvljx[i][j] = x - j
            end
          end
        end
      elseif key == VK_RIGHT then
        if GetWarMap(x2, y2, 3) < 128 then
          mvx1 = mvx1 + 1
          mvy1 = mvy1 + 1
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 + j + i
              mvy3[i][j] = mvy1 + j - i
              mvljy[i][j] = y - i
              mvljx[i][j] = x + j
            end
          end
        end
      elseif ktype == 2 then
        if mx < 0 then
          mvx1 = 0 - math.abs(mx)
          mvy1 = 0 - math.abs(mx)
        end
        if 0 < mx then
          mvx1 = 0 + mx
          mvy1 = 0 + mx
        end
        if my < 0 then
          mvx1 = mvx1 + math.abs(my)
          mvy1 = mvy1 - math.abs(my)
        end
        if 0 < my then
          mvx1 = mvx1 - my
          mvy1 = mvy1 + my
        end
        if 0 < mvx1 and 0 < mvy1 and GetWarMap(x2, y2, 3) < 128 then
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 + j + i
              mvy3[i][j] = mvy1 + j - i
              mvljy[i][j] = y - i
              mvljx[i][j] = x + j
            end
          end
        end
        if mvx1 < 0 and mvy1 < 0 and GetWarMap(x2, y2, 3) < 128 then
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 - j - i
              mvy3[i][j] = mvy1 - j + i
              mvljy[i][j] = y + i
              mvljx[i][j] = x - j
            end
          end
        end
        if 0 < mvx1 and mvy1 < 0 and GetWarMap(x2, y2, 3) < 128 then
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 + j + i
              mvy3[i][j] = mvy1 - j + i
              mvljy[i][j] = y - j
              mvljx[i][j] = x + i
            end
          end
        end
        if mvx1 < 0 and 0 < mvy1 and GetWarMap(x2, y2, 3) < 128 then
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 - j + i
              mvy3[i][j] = mvy1 + j + i
              mvljy[i][j] = y + j
              mvljx[i][j] = x + i
            end
          end
        end
        if my == 0 then
          mvx1 = 0 + mx
          mvy1 = 0 + mx
          if GetWarMap(x2, y2, 3) < 128 then
            for i = -v3, v3 do
              for j = -v3, v3 do
                mvx3[i][j] = mvx1 - j - i
                mvy3[i][j] = mvy1 - j + i
                mvljy[i][j] = y + i
                mvljx[i][j] = x - j
              end
            end
          end
        elseif mx == 0 and GetWarMap(x2, y2, 3) < 128 then
          mvx1 = 0 - my
          mvy1 = 0 + my
          for i = -v3, v3 do
            for j = -v3, v3 do
              mvx3[i][j] = mvx1 + j + i
              mvy3[i][j] = mvy1 - j + i
              mvljy[i][j] = y - j
              mvljx[i][j] = x + i
            end
          end
        end
      end
      if GetWarMap(x2, y2, 3) < 128 then
        mvx = mvx1
        mvy = mvy1
      end
    end
  end
end

function War_MovePerson(x, y)
  local movenum = GetWarMap(x, y, 3)
  WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] = WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] - movenum
  local movetable = {}
  for i = movenum, 1, -1 do
    movetable[i] = {}
    movetable[i].x = x
    movetable[i].y = y
    if GetWarMap(x - 1, y, 3) == i - 1 then
      x = x - 1
      movetable[i].direct = 1
    elseif GetWarMap(x + 1, y, 3) == i - 1 then
      x = x + 1
      movetable[i].direct = 2
    elseif GetWarMap(x, y - 1, 3) == i - 1 then
      y = y - 1
      movetable[i].direct = 3
    elseif GetWarMap(x, y + 1, 3) == i - 1 then
      y = y + 1
      movetable[i].direct = 0
    end
  end
  for i = 1, movenum do
    local t1 = lib.GetTime()
    SetWarMap(WAR.Person[WAR.CurID]["\215\248\177\234X"], WAR.Person[WAR.CurID]["\215\248\177\234Y"], 2, -1)
    SetWarMap(WAR.Person[WAR.CurID]["\215\248\177\234X"], WAR.Person[WAR.CurID]["\215\248\177\234Y"], 5, -1)
    WAR.Person[WAR.CurID]["\215\248\177\234X"] = movetable[i].x
    WAR.Person[WAR.CurID]["\215\248\177\234Y"] = movetable[i].y
    WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = movetable[i].direct
    WAR.Person[WAR.CurID]["\204\249\205\188"] = WarCalPersonPic(WAR.CurID)
    SetWarMap(WAR.Person[WAR.CurID]["\215\248\177\234X"], WAR.Person[WAR.CurID]["\215\248\177\234Y"], 2, WAR.CurID)
    SetWarMap(WAR.Person[WAR.CurID]["\215\248\177\234X"], WAR.Person[WAR.CurID]["\215\248\177\234Y"], 5, WAR.Person[WAR.CurID]["\204\249\205\188"])
    WarDrawMap(0)
    ShowScreen()
    local t2 = lib.GetTime()
    if t2 - t1 < 2 * CC.Frame then
      lib.Delay(2 * CC.Frame - (t2 - t1))
    end
  end
end

function War_FightMenu()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local gjfw = 0
  local gjstr = ""
  local numwugong = 0
  local menu = {}
  for i = 1, 10 do
    local tmp = JY.Person[pid]["\206\228\185\166" .. i]
    if 0 < tmp then
      gjfw = JY.Wugong[tmp]["\185\165\187\247\183\182\206\167"]
      if gjfw == 0 then
        gjstr = "\161\241"
      elseif gjfw == 1 then
        gjstr = "\169\165"
      elseif gjfw == 2 then
        gjstr = "\169\239"
      elseif gjfw == 3 then
        gjstr = "\161\246"
      end
      local level = {}
      local wgsh = {}
      local p = JY.Person[pid]
      local nlxh = 0
      local wgshlx = JY.Wugong[tmp]["\201\203\186\166\192\224\208\205"]
      local wgjnl, wgsnl, nldb
      level[i] = math.modf(p["\206\228\185\166\181\200\188\182" .. i] / 100) + 1
      nldb = math.modf((level[i] + 1) / 2)
      nlxh = JY.Wugong[tmp]["\207\251\186\196\196\218\193\166\181\227\202\253"] * nldb
      wgsh[i] = JY.Wugong[tmp]["\185\165\187\247\193\166" .. level[i]]
      if wgshlx == 0 then
        menu[i] = {
          string.format("%10s  %2d\188\182  %2s  \196\218\163\186%3d  \205\254\193\166\163\186%4d", JY.Wugong[tmp]["\195\251\179\198"], level[i], gjstr, nlxh, wgsh[i]),
          nil,
          1
        }
      elseif wgshlx == 1 then
        wgjnl = JY.Wugong[tmp]["\188\211\196\218\193\166" .. level[i]]
        wgsnl = JY.Wugong[tmp]["\201\177\196\218\193\166" .. level[i]]
        menu[i] = {
          string.format("%10s  %2d\188\182  %2s  \206\252\163\186%3d  \205\254\193\166\163\186%4d", JY.Wugong[tmp]["\195\251\179\198"], level[i], "\161\241", wgjnl, wgsnl),
          nil,
          1
        }
      end
      if JY.Wugong[tmp]["\207\251\186\196\196\218\193\166\181\227\202\253"] > JY.Person[pid]["\196\218\193\166"] then
        menu[i][3] = 0
      end
      numwugong = numwugong + 1
    else
      menu[i] = {
        "",
        nil,
        0
      }
    end
  end
  if numwugong == 0 then
    return 0
  end
  local r
  r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont * 1.2, C_ORANGE, C_WHITE, JY.WGXZWZ[pid])
  if r == 0 then
    return 0
  end
  JY.WGXZWZ[pid] = r
  WAR.ShowHead = 0
  local r2 = War_Fight_Sub(WAR.CurID, r)
  WAR.ShowHead = 1
  Cls()
  return r2
end

function War_AutoAnqi(id, x, y)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local step
  step = math.modf(JY.Person[pid]["\176\181\198\247\188\188\199\201"] / 15) + 1
  War_CalMoveStep(WAR.CurID, step, 1)
  if x == nil then
    Cls()
    return 0
  else
    return War_ExecuteMenu_Sub(x, y, 4, id)
  end
end

function War_Fight_Sub(id, wugongnum, x, y)
  local pid = WAR.Person[id]["\200\203\206\239\177\224\186\197"]
  local wugong, level, fightscope
  CleanWarMap(4, 0)
  if wugongnum == -1 then
    War_AutoAnqi(JY.AQID, x, y)
    return 1
  else
    wugong = JY.Person[pid]["\206\228\185\166" .. wugongnum]
    level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] / 100) + 1
    fightscope = JY.Wugong[wugong]["\185\165\187\247\183\182\206\167"]
  end
  if fightscope == 0 then
    if War_FightSelectType0(wugong, level, x, y) == false then
      return 0
    end
  elseif fightscope == 1 then
    if War_FightSelectType1(wugong, level, x, y) == false then
      return 0
    end
  elseif fightscope == 2 then
    if War_FightSelectType2(wugong, level, x, y) == false then
      return 0
    end
  elseif fightscope == 3 and War_FightSelectType3(wugong, level, x, y) == false then
    return 0
  end
  local fightnum = 1
  if JY.Person[pid]["\215\243\211\210\187\165\178\171"] == 1 then
    fightnum = 2
  end
  lib.PicLoadFile(string.format(CC.FightPicFile[1], JY.Person[pid]["\205\183\207\241\180\250\186\197"]), string.format(CC.FightPicFile[2], JY.Person[pid]["\205\183\207\241\180\250\186\197"]), 4)
  if fightnum == 2 then
    DrawStrBox(-1, -1, "\215\243\211\210\187\165\178\171\214\174\202\245", C_RED, CC.StartMenuFontSize)
    ShowScreen()
    lib.Delay(500)
  end
  Cls()
  local wglen = #JY.Wugong[wugong]["\195\251\179\198"]
  DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * 1.5 * wglen / 4, CC.ScreenH / 2 - CC.DefaultFont * 6, string.format(JY.Wugong[wugong]["\195\251\179\198"]), C_RED, CC.StartMenuFontSize * 1.5)
  ShowScreen()
  lib.Delay(500)
  for k = 1, fightnum do
    for i = 0, CC.WarWidth - 1 do
      for j = 0, CC.WarHeight - 1 do
        local effect = GetWarMap(i, j, 4)
        if 0 < effect then
          local emeny = GetWarMap(i, j, 2)
          if 0 <= emeny and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[emeny]["\206\210\183\189"] then
            if JY.Wugong[wugong]["\201\203\186\166\192\224\208\205"] == 0 then
              local NGHT = CONFIG.NGHT or 0
              if CC.BanBen == 0 then
                if NGHT == 0 then
                  WAR.Person[emeny].点数 = -War_WugongHurtLife(emeny, wugong, level)
                else
                  WAR.Person[emeny].点数 = -War_WugongHurtLife1(emeny, wugong, level)
                end
                WAR.Effect = 2
                SetWarMap(i, j, 4, 2)
              else
                if NGHT == 0 then
                  WAR.Person[emeny].点数 = -War_WugongHurtLife_CL(emeny, wugong, level)
                else
                  WAR.Person[emeny].点数 = -War_WugongHurtLife1_CL(emeny, wugong, level)
                end
                WAR.Effect = 2
                SetWarMap(i, j, 4, 2)
              end
            else
              WAR.Person[emeny].点数 = -War_WugongHurtNeili(emeny, wugong, level)
              SetWarMap(i, j, 4, 3)
              WAR.Effect = 3
            end
          end
        end
      end
    end
    x, y = Movex, Movey
    War_ShowFight(pid, wugong, JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"], level, x, y, JY.Wugong[wugong]["\206\228\185\166\182\175\187\173&\210\244\208\167"])
    for i = 0, WAR.PersonNum - 1 do
      WAR.Person[i].点数 = 0
    end
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + 2
    if JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] < 900 then
      JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] = JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] + Rnd(2) + 1
    end
    if math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] / 100) + 1 ~= level then
      level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] / 100) + 1
      DrawStrBox(-1, -1, string.format("%s \201\253\206\170 %d \188\182", JY.Wugong[wugong]["\195\251\179\198"], level), C_ORANGE, CC.DefaultFont)
      ShowScreen()
      lib.Delay(500)
      Cls()
      ShowScreen()
    end
    AddPersonAttrib(pid, "\196\218\193\166", -math.modf((level + 1) / 2) * JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"])
  end
  AddPersonAttrib(pid, "\204\229\193\166", -3)
  return 1
end

function DrawYY(x, y, pic, pic2, yy)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local xyz = x - x0
  local yyz = y - y0
  local mvx1 = 0
  local mvy1 = 0
  if yyz < 0 then
    mvx1 = mvx1 + 1 * math.abs(yyz)
    mvy1 = mvy1 - 1 * math.abs(yyz)
  end
  if 0 < yyz then
    mvx1 = mvx1 - 1 * math.abs(yyz)
    mvy1 = mvy1 + 1 * math.abs(yyz)
  end
  if xyz < 0 then
    mvx1 = mvx1 - 1 * math.abs(xyz)
    mvy1 = mvy1 - 1 * math.abs(xyz)
  end
  if 0 < xyz then
    mvx1 = mvx1 + 1 * math.abs(xyz)
    mvy1 = mvy1 + 1 * math.abs(xyz)
  end
  lib.PicLoadCache(0, 0, CC.ScreenW / 2 + CC.XScale * mvx1, CC.ScreenH / 2 + CC.YScale * mvy1, 2, yy)
end

function YYZhi(x, y, str, pic, pic2, yy, color, fontsize, xadd, yadd)
  if xadd == nil then
    xadd = 0
  end
  if yadd == nil then
    yadd = 0
  end
  local x0 = 0
  local y0 = 0
  if JY.Status == GAME_SMAP then
    x0 = JY.Base.人X1
    y0 = JY.Base.人Y1
    if x0 <= 7 then
      x0 = 8
    end
    if 52 <= x0 then
      x0 = 51
    end
    if y0 <= 7 then
      y0 = 8
    end
    if 52 <= y0 then
      y0 = 51
    end
  elseif JY.Status == GAME_WMAP then
    x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
    y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  elseif JY.Status == GAME_MMAP then
    x0 = JY.Base.人X
    y0 = JY.Base.人Y
  end
  local xyz = x - x0
  local yyz = y - y0
  local mvx1 = 0
  local mvy1 = 0
  if yyz < 0 then
    mvx1 = mvx1 + 1 * math.abs(yyz)
    mvy1 = mvy1 - 1 * math.abs(yyz)
  end
  if 0 < yyz then
    mvx1 = mvx1 - 1 * math.abs(yyz)
    mvy1 = mvy1 + 1 * math.abs(yyz)
  end
  if xyz < 0 then
    mvx1 = mvx1 - 1 * math.abs(xyz)
    mvy1 = mvy1 - 1 * math.abs(xyz)
  end
  if 0 < xyz then
    mvx1 = mvx1 + 1 * math.abs(xyz)
    mvy1 = mvy1 + 1 * math.abs(xyz)
  end
  local wx = CC.ScreenW / 2 + CC.XScale * mvx1 + xadd
  local hx = CC.ScreenH / 2 + CC.YScale * mvy1 + yadd
  if pic ~= nil and pic2 ~= nil then
    lib.PicLoadCache(pic, pic2, CC.ScreenW / 2 + CC.XScale * mvx1, CC.ScreenH / 2 + CC.YScale * mvy1, 2, yy)
  end
  if fontsize == nil then
    fontsize = CC.DefaultFont
  end
  if str ~= nil then
    DrawString(wx - string.len(str) / 4 * fontsize, hx - CC.YScale * 7, str, color, fontsize)
  end
end

function GJYY(x, y, lx, v1, v2, v3, v4, v5)
  local rsnum = 0
  if lx == 0 then
  end
  if lx == 1 then
    local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
    local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
    local lujinx = {}
    local lujiny = {}
    local mvljx = {}
    local mvljy = {}
    local mvx1 = 0
    local mvy1 = 0
    for i = 1, v1 do
      lujinx[i] = 0
      lujiny[i] = 0
      mvljx[i] = x0
      mvljy[i] = y0
    end
    if v2 == 0 then
      for i = 1, v1 do
        lujinx[i] = mvx1 + i
        lujiny[i] = mvy1 - i
        mvljy[i] = y0 - i
        mvljx[i] = x0
      end
    elseif v2 == 3 then
      for i = 1, v1 do
        lujinx[i] = mvx1 - i
        lujiny[i] = mvy1 + i
        mvljy[i] = y0 + i
        mvljx[i] = x0
      end
    elseif v2 == 2 then
      for i = 1, v1 do
        lujinx[i] = mvx1 - i
        lujiny[i] = mvy1 - i
        mvljx[i] = x0 - i
        mvljy[i] = y0
      end
    elseif v2 == 1 then
      for i = 1, v1 do
        lujinx[i] = mvx1 + i
        lujiny[i] = mvy1 + i
        mvljx[i] = x0 + i
        mvljy[i] = y0
      end
    end
    for i = 1, v1 do
      if 0 <= GetWarMap(mvljx[i], mvljy[i], 2) then
        if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[GetWarMap(mvljx[i], mvljy[i], 2)]["\206\210\183\189"] then
          if CC.ScreenW >= 128 then
            ShowZhi(mvljx[i], mvljy[i])
          end
          rsnum = rsnum + 1
        end
      else
        lib.PicLoadCache(0, 0, CC.ScreenW / 2 + CC.XScale * lujinx[i], CC.ScreenH / 2 + CC.YScale * lujiny[i], 2, 100)
      end
    end
  end
  if lx == 2 then
    local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
    local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
    local lujinx = {}
    local lujiny = {}
    local mvljx = {}
    local mvljy = {}
    local mvx1 = 0
    local mvy1 = 0
    for i = 1, 4 do
      lujinx[i] = {}
      lujiny[i] = {}
      mvljx[i] = {}
      mvljy[i] = {}
    end
    for i = 1, v1 do
      lujinx[1][i] = mvx1 + i
      lujiny[1][i] = mvy1 - i
      mvljy[1][i] = y0 - i
      mvljx[1][i] = x0
      lujinx[2][i] = mvx1 - i
      lujiny[2][i] = mvy1 + i
      mvljy[2][i] = y0 + i
      mvljx[2][i] = x0
      lujinx[3][i] = mvx1 - i
      lujiny[3][i] = mvy1 - i
      mvljx[3][i] = x0 - i
      mvljy[3][i] = y0
      lujinx[4][i] = mvx1 + i
      lujiny[4][i] = mvy1 + i
      mvljx[4][i] = x0 + i
      mvljy[4][i] = y0
    end
    local pdjs = true
    for j = 1, 4 do
      for i = 1, v1 do
        if 0 <= GetWarMap(mvljx[j][i], mvljy[j][i], 2) then
          if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[GetWarMap(mvljx[j][i], mvljy[j][i], 2)]["\206\210\183\189"] then
            if CC.ScreenW >= 128 then
              ShowZhi(mvljx[j][i], mvljy[j][i])
            end
            rsnum = rsnum + 1
          end
        else
          lib.PicLoadCache(0, 0, CC.ScreenW / 2 + CC.XScale * lujinx[j][i], CC.ScreenH / 2 + CC.YScale * lujiny[j][i], 2, 100)
        end
      end
    end
  end
  DrawString(CC.ScreenW / 2 - CC.DefaultFont * 5, CC.ScreenH - CC.DefaultFont * 4, JY.WGMC .. string.format("  \191\201\187\247\214\208%d\200\203", rsnum), C_WHITE, CC.DefaultFont)
end

function War_FightSelectType0(wugong, level, x1, y1)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  War_CalMoveStep(WAR.CurID, JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level], 1)
  if x1 == nil and y1 == nil then
    JY.WGMC = JY.Wugong[wugong]["\195\251\179\198"]
    x1, y1 = War_SelectMove1(0, JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level], 0)
    JY.WGMC = ""
  end
  if x1 == nil then
    Cls()
    JY.WGMC = ""
    return false
  end
  WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = War_Direct(x0, y0, x1, y1)
  SetWarMap(x1, y1, 4, 1)
  WAR.EffectXY = {}
  WAR.EffectXY[1] = {x1, y1}
  WAR.EffectXY[2] = {x1, y1}
end

function War_FightSelectType1(wugong, level, x, y)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local direct
  local move = JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level]
  WAR.EffectXY = {}
  if x == nil and y == nil then
    direct = WAR.Person[WAR.CurID]["\200\203\183\189\207\242"]
    Cls()
    GJYY(nil, nil, 1, move, direct)
    ShowScreen()
    local key, ktype, mx, my
    JY.WGMC = JY.Wugong[wugong]["\195\251\179\198"]
    while true do
      key, ktype, mx, my = WaitKey(1)
      if key == VK_UP then
        direct = 0
        Cls()
        GJYY(nil, nil, 1, move, direct)
      elseif key == VK_DOWN then
        direct = 3
        Cls()
        GJYY(nil, nil, 1, move, direct)
      elseif key == VK_LEFT then
        direct = 2
        Cls()
        GJYY(nil, nil, 1, move, direct)
      elseif key == VK_RIGHT then
        direct = 1
        Cls()
        GJYY(nil, nil, 1, move, direct)
      elseif key == VK_ESCAPE or ktype == 4 then
        direct = -1
        JY.WGMC = ""
        return false
      elseif ktype == 2 then
        mx = mx - CC.ScreenW / 2
        my = my - CC.ScreenH / 2
        mx = mx / CC.XScale
        my = my / CC.YScale
        mx, my = (mx + my) / 2, (my - mx) / 2
        if 0 < mx then
          mx = mx + 0.99
        else
          mx = mx - 0.01
        end
        if 0 < my then
          my = my + 0.99
        else
          mx = mx - 0.01
        end
        mx = math.modf(mx)
        my = math.modf(my)
        for i = 0, 10 do
          if mx + i <= 63 and 63 < my + i then
            break
          end
          local hb = GetS(JY.SubScene, x0 + mx + i, y0 + my + i, 4)
          if math.abs(hb - CC.YScale * i * 2) < 5 then
            mx = mx + i
            my = my + i
          end
        end
        if math.abs(mx) >= math.abs(my) then
          if 0 <= mx then
            direct = 1
            Cls()
            GJYY(nil, nil, 1, move, direct)
          elseif mx < 0 then
            direct = 2
            Cls()
            GJYY(nil, nil, 1, move, direct)
          end
        end
        if math.abs(my) > math.abs(mx) then
          if 0 <= my then
            direct = 3
            Cls()
            GJYY(nil, nil, 1, move, direct)
          elseif my < 0 then
            direct = 0
            Cls()
            GJYY(nil, nil, 1, move, direct)
          end
        end
      end
      if 0 <= direct and (key == VK_RETURN or key == VK_SPACE or ktype == 3) then
        break
      end
      ShowScreen()
    end
    JY.WGMC = ""
  else
    direct = War_Direct(x0, y0, x, y)
  end
  WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = direct
  for i = 1, move do
    if direct == 0 then
      SetWarMap(x0, y0 - i, 4, 1)
    elseif direct == 3 then
      SetWarMap(x0, y0 + i, 4, 1)
    elseif direct == 2 then
      SetWarMap(x0 - i, y0, 4, 1)
    elseif direct == 1 then
      SetWarMap(x0 + i, y0, 4, 1)
    end
  end
  if direct == 0 then
    WAR.EffectXY[1] = {
      x0,
      y0 - 1
    }
    WAR.EffectXY[2] = {
      x0,
      y0 - move
    }
  elseif direct == 3 then
    WAR.EffectXY[1] = {
      x0,
      y0 + 1
    }
    WAR.EffectXY[2] = {
      x0,
      y0 + move
    }
  elseif direct == 2 then
    WAR.EffectXY[1] = {
      x0 - 1,
      y0
    }
    WAR.EffectXY[2] = {
      x0 - move,
      y0
    }
  elseif direct == 1 then
    WAR.EffectXY[1] = {
      x0 + 1,
      y0
    }
    WAR.EffectXY[2] = {
      x0 + move,
      y0
    }
  end
end

function War_FightSelectType2(wugong, level)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local move = JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level]
  WAR.EffectXY = {}
  if WAR.AutoFight == 0 and WAR.Person[WAR.CurID]["\206\210\183\189"] == true then
    JY.WGMC = JY.Wugong[wugong]["\195\251\179\198"]
    local key, ktype, mx, my
    while true do
      Cls()
      GJYY(nil, nil, 2, move)
      ShowScreen()
      key, ktype, mx, my = WaitKey(1)
      Cls()
      if key == VK_ESCAPE or ktype == 4 then
        Cls()
        JY.WGMC = ""
        return false
      elseif key == VK_RETURN or key == VK_SPACE or ktype == 3 then
        Cls()
        break
      end
    end
    JY.WGMC = ""
  end
  local j = 1
  for i = 1, move do
    SetWarMap(x0, y0 - i, 4, 1)
    SetWarMap(x0, y0 + i, 4, 1)
    SetWarMap(x0 - i, y0, 4, 1)
    SetWarMap(x0 + i, y0, 4, 1)
  end
  WAR.EffectXY[1] = {
    x0 - move,
    y0
  }
  WAR.EffectXY[2] = {
    x0 + move,
    y0
  }
end

function War_FightSelectType3(wugong, level, x1, y1)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  War_CalMoveStep(WAR.CurID, JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level], 1)
  JY.WGMC = JY.Wugong[wugong]["\195\251\179\198"]
  if x1 == nil and y1 == nil then
    x1, y1 = War_SelectMove1(3, JY.Wugong[wugong]["\210\198\182\175\183\182\206\167" .. level], JY.Wugong[wugong]["\201\177\201\203\183\182\206\167" .. level])
  end
  if x1 == nil then
    Cls()
    JY.WGMC = ""
    return false
  end
  WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = War_Direct(x0, y0, x1, y1)
  local move = JY.Wugong[wugong]["\201\177\201\203\183\182\206\167" .. level]
  WAR.EffectXY = {}
  for i = -move, move do
    for j = -move, move do
      SetWarMap(x1 + i, y1 + j, 4, 1)
    end
  end
  WAR.EffectXY[1] = {
    x1 - 2 * move,
    y1
  }
  WAR.EffectXY[2] = {
    x1 + 2 * move,
    y1
  }
end

function War_Direct(x1, y1, x2, y2)
  local x = x2 - x1
  local y = y2 - y1
  if math.abs(y) > math.abs(x) then
    if 0 < y then
      return 3
    else
      return 0
    end
  elseif 0 < x then
    return 1
  else
    return 2
  end
end

function War_ShowFight(pid, wugong, wugongtype, level, x, y, eft)
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local fightdelay, fightframe, sounddelay
  if 0 <= wugongtype then
    fightdelay = JY.Person[pid]["\179\246\213\208\182\175\187\173\209\211\179\217" .. wugongtype + 1]
    fightframe = JY.Person[pid]["\179\246\213\208\182\175\187\173\214\161\202\253" .. wugongtype + 1]
    sounddelay = JY.Person[pid]["\206\228\185\166\210\244\208\167\209\211\179\217" .. wugongtype + 1]
  else
    fightdelay = 0
    fightframe = -1
    sounddelay = -1
  end
  if fightdelay == 0 or fightframe == 0 then
    fightdelay = JY.Person[pid]["\179\246\213\208\182\175\187\173\209\211\179\217" .. 2]
    fightframe = JY.Person[pid]["\179\246\213\208\182\175\187\173\214\161\202\253" .. 2]
    sounddelay = JY.Person[pid]["\206\228\185\166\210\244\208\167\209\211\179\217" .. 2]
    wugongtype = 1
  end
  local framenum = fightdelay + CC.Effect[eft]
  local startframe = 0
  if 0 <= wugongtype then
    for i = 0, wugongtype - 1 do
      startframe = startframe + 4 * JY.Person[pid]["\179\246\213\208\182\175\187\173\214\161\202\253" .. i + 1]
    end
  end
  local starteft = 0
  for i = 0, eft - 1 do
    starteft = starteft + CC.Effect[i]
  end
  WAR.Person[WAR.CurID]["\204\249\205\188\192\224\208\205"] = 0
  WAR.Person[WAR.CurID]["\204\249\205\188"] = WarCalPersonPic(WAR.CurID)
  WarSetPerson()
  WarDrawMap(0)
  ShowScreen()
  local fastdraw
  if CONFIG.FastShowScreen == 0 or CC.AutoWarShowHead == 1 then
    fastdraw = 0
  else
    fastdraw = 1
  end
  local oldpic = WAR.Person[WAR.CurID]["\204\249\205\188"] / 2
  local oldpic_type = 0
  local oldeft = -1
  for i = 0, framenum - 1 do
    local tstart = lib.GetTime()
    local mytype
    if 0 < fightframe then
      WAR.Person[WAR.CurID]["\204\249\205\188\192\224\208\205"] = 1
      mytype = 4
      if i < fightframe then
        WAR.Person[WAR.CurID]["\204\249\205\188"] = (startframe + WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] * fightframe + i) * 2
      end
    else
      WAR.Person[WAR.CurID]["\204\249\205\188\192\224\208\205"] = 0
      WAR.Person[WAR.CurID]["\204\249\205\188"] = WarCalPersonPic(WAR.CurID)
      mytype = 0
    end
    if i == sounddelay then
      PlayWavAtk(JY.Wugong[wugong]["\179\246\213\208\210\244\208\167"])
    end
    if i == fightdelay then
      PlayWavE(eft)
    end
    local pic = WAR.Person[WAR.CurID]["\204\249\205\188"] / 2
    if fastdraw == 1 then
      local rr = ClipRect(Cal_PicClip(0, 0, oldpic, oldpic_type, 0, 0, pic, mytype))
      if rr ~= nil then
        lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
      end
    else
    end
    oldpic = pic
    oldpic_type = mytype
    if i < fightdelay then
      WarDrawMap(4, pic * 2, mytype, -1)
    else
      starteft = starteft + 1
      if fastdraw == 1 then
        local clip1 = {}
        clip1 = Cal_PicClip(WAR.EffectXY[1][1] - x0, WAR.EffectXY[1][2] - y0, oldeft, 3, WAR.EffectXY[1][1] - x0, WAR.EffectXY[1][2] - y0, starteft, 3)
        local clip2 = {}
        clip2 = Cal_PicClip(WAR.EffectXY[2][1] - x0, WAR.EffectXY[2][2] - y0, oldeft, 3, WAR.EffectXY[2][1] - x0, WAR.EffectXY[2][2] - y0, starteft, 3)
        local clip = ClipRect(MergeRect(clip1, clip2))
        if clip ~= nil then
          lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
          WarDrawMap(4, pic * 2, mytype, starteft * 2, -1, 3)
        else
          WarDrawMap(4, pic * 2, mytype, starteft * 2, -1, 3)
        end
      else
        WarDrawMap(4, pic * 2, mytype, starteft * 2, -1, 3)
      end
      oldeft = starteft
    end
    ShowScreen(fastdraw)
    local tend = lib.GetTime()
    if tend - tstart < 1 * CC.Frame then
      lib.Delay(1 * CC.Frame - (tend - tstart))
    end
  end
  WAR.Person[WAR.CurID]["\204\249\205\188\192\224\208\205"] = 0
  WAR.Person[WAR.CurID]["\204\249\205\188"] = WarCalPersonPic(WAR.CurID)
  WarSetPerson()
  WarDrawMap(0)
  ShowScreen()
  lib.Delay(200)
  WarDrawMap(2)
  ShowScreen()
  lib.Delay(200)
  WarDrawMap(0)
  ShowScreen()
  local HitXY = {}
  local HitXYNum = 0
  for i = 0, WAR.PersonNum - 1 do
    local x1 = WAR.Person[i]["\215\248\177\234X"]
    local y1 = WAR.Person[i]["\215\248\177\234Y"]
    if WAR.Person[i].死亡 == false and 1 < GetWarMap(x1, y1, 4) then
      local n = WAR.Person[i].点数
      HitXY[HitXYNum] = {
        x1,
        y1,
        string.format("%+d", n)
      }
      HitXYNum = HitXYNum + 1
    end
  end
  if 0 < HitXYNum then
    local clips = {}
    for i = 0, HitXYNum - 1 do
      local dx = HitXY[i][1] - x0
      local dy = HitXY[i][2] - y0
      local ll = string.len(HitXY[i][3])
      local w = ll * CC.DefaultFont / 2 * (CONFIG.Zoom / 100 / CC.Zoom) + 1
      clips[i] = {
        x1 = CC.XScale * (dx - dy) + CC.ScreenW / 2,
        y1 = CC.YScale * (dx + dy) + CC.ScreenH / 2,
        x2 = CC.XScale * (dx - dy) + CC.ScreenW / 2 + w,
        y2 = CC.YScale * (dx + dy) + CC.ScreenH / 2 + CC.DefaultFont * (CONFIG.Zoom / 100 / CC.Zoom) + 1
      }
    end
    local clip = clips[0]
    for i = 1, HitXYNum - 1 do
      clip = MergeRect(clip, clips[i])
    end
    local area = (clip.x2 - clip.x1) * (clip.y2 - clip.y1)
    for i = 1, 15 do
      local tstart = lib.GetTime()
      local y_off = (i + 40) * CC.Zoom * (CONFIG.Zoom / 100 / CC.Zoom)
      if fastdraw == 1 and area < CC.ScreenW * CC.ScreenH / 2 then
        local tmpclip = {
          x1 = clip.x1,
          y1 = clip.y1 - y_off,
          x2 = clip.x2,
          y2 = clip.y2 - y_off
        }
        tmpclip = ClipRect(tmpclip)
        if tmpclip ~= nil then
          lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
          WarDrawMap(0)
          for j = 0, HitXYNum - 1 do
            DrawString(clips[j].x1, clips[j].y1 - y_off, HitXY[j][3], WAR.EffectColor[WAR.Effect], CC.DefaultFont * (CONFIG.Zoom / 100 / CC.Zoom))
          end
        end
      else
        WarDrawMap(0)
        for j = 0, HitXYNum - 1 do
          DrawString(clips[j].x1, clips[j].y1 - y_off, HitXY[j][3], WAR.EffectColor[WAR.Effect], CC.DefaultFont * (CONFIG.Zoom / 100 / CC.Zoom))
        end
      end
      ShowScreen(1)
      local tend = lib.GetTime()
      if tend - tstart < CC.Frame then
        lib.Delay(CC.Frame - (tend - tstart))
      end
    end
  end
  WarDrawMap(0)
  ShowScreen()
end

function War_WugongHurtLife(emenyid, wugong, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local eid = WAR.Person[emenyid]["\200\203\206\239\177\224\186\197"]
  local mywuxue = 0
  local emenywuxue = 0
  for i = 0, WAR.PersonNum - 1 do
    local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i].死亡 == false and JY.Person[id]["\206\228\209\167\179\163\202\182"] >= CC.WXCS then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[i]["\206\210\183\189"] then
        mywuxue = mywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      else
        emenywuxue = emenywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      end
    end
  end
  while math.modf((level + 1) / 2) * JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"] > JY.Person[pid]["\196\218\193\166"] do
    level = level - 1
    goto lbl_80
    do break end
    ::lbl_80::
  end
  if level <= 0 then
    level = 1
  end
  local phgjl = 0
  for i, v in ipairs(CC.ExtraOffense) do
    if v[1] == JY.Person[pid]["\206\228\198\247"] and v[2] == wugong then
      phgjl = v[3]
      break
    end
  end
  local wgwl = JY.Wugong[wugong]["\185\165\187\247\193\166" .. level]
  local jsgjl = JY.Person[pid]["\185\165\187\247\193\166"]
  local zbgjl = 0
  if 0 <= JY.Person[pid]["\206\228\198\247"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
  end
  if 0 <= JY.Person[pid]["\183\192\190\223"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
  end
  local jsfyl = JY.Person[eid]["\183\192\211\249\193\166"]
  local zbfyl = 0
  if 0 <= JY.Person[eid]["\206\228\198\247"] then
    zbfyl = zbfyl + JY.Thing[JY.Person[eid]["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
  end
  if 0 <= JY.Person[eid]["\183\192\190\223"] then
    zbfyl = zbfyl + JY.Thing[JY.Person[eid]["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
  end
  local hurt = (mywuxue * 2 + (jsgjl * 3 + wgwl) / 2 + zbgjl + phgjl - (emenywuxue * 2 + jsfyl + zbfyl) * 3) * 2 / 3 + Rnd(20) - Rnd(20)
  if hurt < 0 then
    hurt = Rnd(10) + 1
  end
  hurt = hurt + JY.Person[pid]["\204\229\193\166"] / 15 + JY.Person[eid]["\202\220\201\203\179\204\182\200"] / 20
  local offset = math.abs(WAR.Person[WAR.CurID]["\215\248\177\234X"] - WAR.Person[emenyid]["\215\248\177\234X"]) + math.abs(WAR.Person[WAR.CurID]["\215\248\177\234Y"] - WAR.Person[emenyid]["\215\248\177\234Y"])
  if offset < 10 then
    hurt = hurt * (100 - (offset - 1) * 3) / 100
  else
    hurt = hurt * 2 / 3
  end
  hurt = math.modf(hurt)
  if hurt <= 0 then
    hurt = Rnd(8) + 1
  end
  JY.Person[eid].生命 = JY.Person[eid].生命 - hurt
  WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + math.modf(hurt / 5)
  if 0 >= JY.Person[eid].生命 then
    JY.Person[eid].生命 = 0
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + JY.Person[eid]["\181\200\188\182"] * 10
    if JY.DEADKG == 1 then
      local did
      for i = 0, WAR.PersonNum - 1 do
        if JY.DEADPD[i][1] == eid then
          did = i
          break
        end
      end
      if JY.DEADPD[did][2] == 0 then
        local name1 = JY.Person[pid].姓名
        local name2 = JY.Person[eid].姓名
        local size = CC.DefaultFont * 1.5
        local str = name1 .. " \187\247\176\220 " .. name2
        local slen = string.len(str)
        if WAR.Person[WAR.CurID]["\206\210\183\189"] == false then
          DrawStrBox(-1, -1, str, C_RED, size)
        else
          DrawStrBox(-1, -1, str, C_GOLD, size)
        end
        ShowScreen()
        lib.Delay(500)
        Cls()
        JY.DEADPD[did][2] = 1
      end
    end
  end
  AddPersonAttrib(eid, "\202\220\201\203\179\204\182\200", math.modf(hurt / 10))
  local poisonnum = level * JY.Wugong[wugong]["\181\208\200\203\214\208\182\190\181\227\202\253"] + JY.Person[pid]["\185\165\187\247\180\248\182\190"] * 5
  if poisonnum > JY.Person[eid]["\191\185\182\190\196\220\193\166"] and JY.Person[eid]["\191\185\182\190\196\220\193\166"] < 90 then
    if CC.BanBen == 0 then
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 15))
    else
      local dkmax = JY.Person[eid]["\191\185\182\190\196\220\193\166"]
      if 75 < dkmax then
        dkmax = 75
      end
      poisonnum = math.modf(poisonnum * (100 - dkmax) / 100)
      if 1000 < poisonnum then
        poisonnum = 1000
      end
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 30))
    end
  end
  return hurt
end

function War_WugongHurtLife1(emenyid, wugong, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local eid = WAR.Person[emenyid]["\200\203\206\239\177\224\186\197"]
  local mywuxue = 0
  local emenywuxue = 0
  for i = 0, WAR.PersonNum - 1 do
    local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i].死亡 == false and JY.Person[id]["\206\228\209\167\179\163\202\182"] >= CC.WXCS then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[i]["\206\210\183\189"] then
        mywuxue = mywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      else
        emenywuxue = emenywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      end
    end
  end
  while math.modf((level + 1) / 2) * JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"] > JY.Person[pid]["\196\218\193\166"] do
    level = level - 1
    goto lbl_80
    do break end
    ::lbl_80::
  end
  if level <= 0 then
    level = 1
  end
  local phgjl = 0
  for i, v in ipairs(CC.ExtraOffense) do
    if v[1] == JY.Person[pid]["\206\228\198\247"] and v[2] == wugong then
      phgjl = v[3]
      break
    end
  end
  local wgwl = JY.Wugong[wugong]["\185\165\187\247\193\166" .. level]
  local jsgjl = JY.Person[pid]["\185\165\187\247\193\166"]
  local zbgjl = 0
  if 0 <= JY.Person[pid]["\206\228\198\247"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
  end
  if 0 <= JY.Person[pid]["\183\192\190\223"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
  end
  local jsfyl = JY.Person[eid]["\183\192\211\249\193\166"]
  local zbfyl = 0
  if 0 <= JY.Person[eid]["\206\228\198\247"] then
    zbfyl = zbfyl + JY.Thing[JY.Person[eid]["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
  end
  if 0 <= JY.Person[eid]["\183\192\190\223"] then
    zbfyl = zbfyl + JY.Thing[JY.Person[eid]["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
  end
  local hurt = (mywuxue * 2 + (jsgjl * 3 + wgwl) / 2 + zbgjl + phgjl - (emenywuxue * 2 + jsfyl + zbfyl) * 3) * 2 / 3 + Rnd(20) - Rnd(20)
  if hurt < 0 then
    hurt = (mywuxue * 2 + (jsgjl * 3 + wgwl) / 2 + zbgjl + phgjl) / 15 + Rnd(5) - Rnd(5)
  end
  hurt = hurt + JY.Person[pid]["\204\229\193\166"] / 15 + JY.Person[eid]["\202\220\201\203\179\204\182\200"] / 20
  local ngatt = 0
  local ngdef = 0
  local ngyz = math.modf((CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] + 1) / 1000)
  local ngcz = math.modf(JY.Person[pid]["\215\202\214\202"] / 15)
  local maxnl = math.modf(((9 - ngcz) * 30 + 410) * ngyz)
  if maxnl < JY.Person[pid]["\196\218\193\166"] then
    ngatt = ngatt + math.modf(maxnl / (20 - ngcz) / ngyz * 1.5)
  else
    ngatt = ngatt + math.modf(JY.Person[pid]["\196\218\193\166"] / (20 - ngcz) / ngyz * 1.5)
  end
  if maxnl < JY.Person[eid]["\196\218\193\166"] then
    ngdef = ngdef + math.modf(maxnl / (14 + ngcz) / ngyz)
  else
    ngdef = ngdef + math.modf(JY.Person[eid]["\196\218\193\166"] / (14 + ngcz) / ngyz)
  end
  hurt = hurt + ngatt - ngdef
  local offset = math.abs(WAR.Person[WAR.CurID]["\215\248\177\234X"] - WAR.Person[emenyid]["\215\248\177\234X"]) + math.abs(WAR.Person[WAR.CurID]["\215\248\177\234Y"] - WAR.Person[emenyid]["\215\248\177\234Y"])
  if offset < 10 then
    hurt = hurt * (100 - (offset - 1) * 3) / 100
  else
    hurt = hurt * 2 / 3
  end
  hurt = math.modf(hurt)
  if hurt <= 0 then
    hurt = Rnd(8) + 1
  end
  local htbs = math.modf((CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] + 1) / 10)
  local nllevel = math.modf(JY.Person[eid]["\196\218\193\166"] / htbs)
  if 5 < nllevel then
    nllevel = 5
  end
  if htbs <= JY.Person[eid]["\196\218\193\166"] then
    local htnum = nllevel * 4
    if htnum < JY.Person[eid]["\196\218\193\166"] then
      if hurt < htnum then
        JY.Person[eid]["\196\218\193\166"] = JY.Person[eid]["\196\218\193\166"] - hurt
        hurt = 0
      else
        JY.Person[eid]["\196\218\193\166"] = JY.Person[eid]["\196\218\193\166"] - htnum
        hurt = hurt - htnum
      end
    end
  end
  JY.Person[eid].生命 = JY.Person[eid].生命 - hurt
  WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + math.modf(hurt / 5)
  if 0 >= JY.Person[eid].生命 then
    JY.Person[eid].生命 = 0
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + JY.Person[eid]["\181\200\188\182"] * 10
  end
  AddPersonAttrib(eid, "\202\220\201\203\179\204\182\200", math.modf(hurt / 10))
  local poisonnum = level * JY.Wugong[wugong]["\181\208\200\203\214\208\182\190\181\227\202\253"] + JY.Person[pid]["\185\165\187\247\180\248\182\190"] * 5
  if poisonnum > JY.Person[eid]["\191\185\182\190\196\220\193\166"] + math.modf(JY.Person[eid]["\196\218\193\166"] / 100) and JY.Person[eid]["\191\185\182\190\196\220\193\166"] < 90 then
    if CC.BanBen == 0 then
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 15))
    else
      local dkmax = JY.Person[eid]["\191\185\182\190\196\220\193\166"]
      if 75 < dkmax then
        dkmax = 75
      end
      poisonnum = math.modf(poisonnum * (100 - dkmax) / 100)
      if 1000 < poisonnum then
        poisonnum = 1000
      end
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 20))
    end
  end
  return hurt
end

function War_WugongHurtLife_CL(emenyid, wugong, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local eid = WAR.Person[emenyid]["\200\203\206\239\177\224\186\197"]
  local mywuxue = 0
  local emenywuxue = 0
  for i = 0, WAR.PersonNum - 1 do
    local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i].死亡 == false and JY.Person[id]["\206\228\209\167\179\163\202\182"] > CC.WXCS then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[i]["\206\210\183\189"] then
        mywuxue = mywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      else
        emenywuxue = emenywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      end
    end
  end
  while math.modf((level + 1) / 2) * JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"] > JY.Person[pid]["\196\218\193\166"] do
    level = level - 1
    goto lbl_80
    do break end
    ::lbl_80::
  end
  if level <= 0 then
    level = 1
  end
  local fightnum = 0
  local wqph = 0
  for i, v in ipairs(CC.ExtraOffense) do
    if v[1] == JY.Person[pid]["\206\228\198\247"] and v[2] == wugong then
      wqph = v[3]
      break
    end
  end
  local wgwl = JY.Wugong[wugong]["\185\165\187\247\193\166" .. level]
  local jsgjl = JY.Person[pid]["\185\165\187\247\193\166"]
  local zbgjl = 0
  if 0 <= JY.Person[pid]["\206\228\198\247"] then
    zbgjl = JY.Thing[JY.Person[pid]["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
  end
  if 0 <= JY.Person[pid]["\183\192\190\223"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
    if CC.BanBen == 5 and JY.Thing[JY.Person[pid]["\183\192\190\223"]]["\180\250\186\197"] == 58 then
      jsgjl = jsgjl + 500
    end
  end
  local atadd = 1
  local yxnd = 0
  local txqh = 1.5
  local tsjs = 0
  if JY.YXND == 1 then
    yxnd = 0.15
    txqh = 1.25
  elseif JY.YXND == 2 then
    yxnd = 0.3
    txqh = 1
  end
  if CC.JS == 1 then
    tsjs = 0.25
  end
  if WAR.Person[WAR.CurID]["\206\210\183\189"] then
    atadd = 1
    fightnum = (wgwl / 3 + jsgjl + (zbgjl + wqph) * 2 / 3) * atadd + mywuxue * 1.2
  else
    atadd = 1 + JY.ZCWGCS / 20 + yxnd + tsjs
    fightnum = (wgwl / 3 + jsgjl + (zbgjl + wqph) * 2 / 3) * atadd + mywuxue * 1.2
  end
  local wglxsh, nlmax, neishang
  nlmax = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
  neishang = JY.Person[pid]["\202\220\201\203\179\204\182\200"]
  if JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 1 then
    wglxsh = JY.Person[pid]["\200\173\213\198\185\166\183\242"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 2 then
    wglxsh = JY.Person[pid]["\211\249\189\163\196\220\193\166"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 3 then
    wglxsh = JY.Person[pid]["\203\163\181\182\188\188\199\201"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 4 then
    wglxsh = JY.Person[pid]["\204\216\202\226\177\248\198\247"]
  end
  if CC.FKGS == 1 then
    fightnum = (jsgjl + mywuxue * 3 + wgwl / 3 + nlmax / 25 + wglxsh * 1.5) * (1 - neishang / 200) + wqph * 2 / 3 + zbgjl
    if CC.BanBen == 5 then
      fightnum = (jsgjl + mywuxue * 3 + wgwl / 3 + nlmax / 25 + wglxsh * 1.5) * (1 - neishang / 200) + wqph * 2 / 3 + zbgjl
    end
  end
  local defencenum = 0
  local zfyl = JY.Person[eid]["\183\192\211\249\193\166"]
  local zbfyl = 0
  local jsfyl = JY.Person[eid]["\183\192\211\249\193\166"]
  if 0 <= JY.Person[eid]["\206\228\198\247"] then
    zfyl = zfyl + JY.Thing[JY.Person[eid]["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
    zbfyl = JY.Thing[JY.Person[eid]["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
  end
  if 0 <= JY.Person[eid]["\183\192\190\223"] then
    zfyl = zfyl + JY.Thing[JY.Person[eid]["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
    zbfyl = zbfyl + JY.Thing[JY.Person[eid]["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
  end
  if WAR.Person[WAR.CurID]["\206\210\183\189"] == false then
    atadd = 1
    defencenum = zfyl * 2 * atadd + emenywuxue * 4
  else
    atadd = 1 + JY.ZCWGCS / 20 + yxnd + tsjs
    defencenum = zfyl * 2 * atadd + emenywuxue * 4
  end
  local wglxfy
  nlmax = JY.Person[eid]["\196\218\193\166\215\238\180\243\214\181"]
  neishang = JY.Person[eid]["\202\220\201\203\179\204\182\200"]
  if JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 1 then
    wglxfy = JY.Person[eid]["\200\173\213\198\185\166\183\242"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 2 then
    wglxfy = JY.Person[eid]["\211\249\189\163\196\220\193\166"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 3 then
    wglxfy = JY.Person[eid]["\203\163\181\182\188\188\199\201"]
  elseif JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 4 then
    wglxfy = JY.Person[eid]["\204\216\202\226\177\248\198\247"]
  end
  if CC.FKGS == 1 then
    defencenum = (jsfyl * 2 + emenywuxue * 3 + nlmax / 25 + wglxfy * 1.5) * (1 - neishang / 200) + zbfyl * 2
  end
  local bsxg = 1
  if pid == 0 and JY.Person[pid].姓名 == "szlzw" and JY.Wugong[30]["\206\180\214\1702"] ~= 0 and CC.JS == 1 then
    bsxg = 2
  end
  if eid == 0 and JY.Person[eid].姓名 == "szlzw" and JY.Wugong[30]["\206\180\214\1702"] ~= 0 and CC.JS == 1 then
    bsxg = 2
  end
  if pid == 0 and JY.Person[pid].外号 == "\200\173\176\212" and JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 1 and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[pid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev / 2 * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 30 <= gailv then
      gailv = 30
    end
    if gailv >= Rnd(100) + 1 then
      defencenum = defencenum - math.modf(defencenum / 2)
      local xgstr = JY.Person[pid].姓名 .. "\161\250\182\212 " .. JY.Person[eid].姓名 .. " \183\162\182\175\198\198\183\192\185\165\187\247"
      local xglen = #xgstr
      Cls()
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  local hurt = fightnum - defencenum
  if CC.FK == 1 then
    if hurt < fightnum / 15 then
      hurt = math.modf(fightnum / 15)
    end
  elseif hurt < fightnum / 10 and 0 < hurt then
    hurt = math.modf(fightnum / 7)
  elseif hurt < 0 then
    hurt = math.modf(fightnum / 7)
  end
  hurt = hurt + JY.Person[pid]["\204\229\193\166"] / 15 + JY.Person[eid]["\202\220\201\203\179\204\182\200"] / 20
  local offset = math.abs(WAR.Person[WAR.CurID]["\215\248\177\234X"] - WAR.Person[emenyid]["\215\248\177\234X"]) + math.abs(WAR.Person[WAR.CurID]["\215\248\177\234Y"] - WAR.Person[emenyid]["\215\248\177\234Y"])
  if offset < 10 then
    hurt = hurt * (100 - (offset - 1) * 3) / 100
  else
    hurt = hurt * 2 / 3
  end
  hurt = math.modf(hurt)
  if hurt <= 0 then
    hurt = Rnd(8) + 1
  end
  if pid == 0 and JY.Person[pid].外号 == "\189\163\196\167" and JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 2 and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[pid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev / 2 * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 30 <= gailv then
      gailv = 30
    end
    if gailv >= Rnd(100) + 1 then
      JY.Person[pid].生命 = JY.Person[pid].生命 + hurt + math.modf(hurt * lev / 100 + 1)
      if JY.Person[pid].生命 > CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] then
        JY.Person[pid].生命 = CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"]
      end
      local xgstr = JY.Person[pid].姓名 .. "\161\250\183\162\182\175\202\200\209\170\185\165\187\247\163\172\201\250\195\252\187\214\184\180 " .. math.modf(hurt * lev / 100 / bsxg + 1)
      local xglen = #xgstr
      Cls()
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(500)
    end
  end
  if pid == 0 and JY.Person[pid].外号 == "\187\195\211\176" and CC.JS == 1 then
    hurt = hurt + math.modf(hurt * JY.Person[pid]["\181\200\188\182"] / 200 * txqh / bsxg) + 1
    local xgstr = JY.Person[pid].姓名 .. "\161\250\183\162\182\175\211\176\215\211\185\165\187\247\163\172\201\203\186\166\212\246\188\211 " .. math.modf(hurt * JY.Person[pid]["\181\200\188\182"] / 200 * txqh / bsxg) + 1
    local xglen = #xgstr
    Cls()
    DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
    ShowScreen()
    lib.Delay(100)
  end
  if eid == 0 and JY.Person[eid].外号 == "\187\195\211\176" and CC.JS == 1 then
    local lev = JY.Person[eid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[eid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev / 2 * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 30 <= gailv then
      gailv = 30
    end
    if gailv >= Rnd(100) + 1 then
      hurt = 0
      local xgstr = JY.Person[eid].姓名 .. "\161\250\183\162\182\175\211\176\215\211\187\216\177\220\163\172" .. JY.Person[pid].姓名 .. " \181\196\185\165\187\247\206\222\208\167"
      local xglen = #xgstr
      Cls()
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  if pid == 0 and JY.Person[pid].外号 == "\181\182\179\213" and JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 3 and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[pid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev / 2 * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 30 <= gailv then
      gailv = 30
    end
    if gailv >= Rnd(100) + 1 then
      if JY.Person[eid].生命 * 3 / 2 < JY.Person[eid]["\201\250\195\252\215\238\180\243\214\181"] then
        if hurt < JY.Person[eid].生命 then
          hurt = JY.Person[eid].生命 + 1
        end
        local xgstr = "\181\182\179\213\161\250\182\212 " .. JY.Person[eid].姓名 .. " \210\187\187\247\177\216\201\177"
        local xglen = #xgstr
        DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
        ShowScreen()
        lib.Delay(1000)
      elseif hurt < math.modf(JY.Person[eid].生命 / 2) then
        hurt = math.modf(JY.Person[eid].生命 / 2)
        local xgstr = JY.Person[pid].姓名 .. "\161\250\182\212 " .. JY.Person[eid].姓名 .. " \183\162\182\175\213\182\182\207\201\203\186\166"
        local xglen = #xgstr
        Cls()
        DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
        ShowScreen()
        lib.Delay(1000)
      else
        hurt = JY.Person[eid].生命 + 1
        local xgstr = JY.Person[pid].姓名 .. "\161\250\182\212 " .. JY.Person[eid].姓名 .. " \183\162\182\175\210\187\187\247\177\216\201\177"
        local xglen = #xgstr
        Cls()
        DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
        ShowScreen()
        lib.Delay(1000)
      end
    end
  end
  if pid == 0 and JY.Person[pid].外号 == "\204\216\191\241" and JY.Wugong[wugong]["\206\228\185\166\192\224\208\205"] == 4 and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[pid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev / 2 * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 30 <= gailv then
      gailv = 30
    end
    if gailv >= Rnd(100) + 1 then
      hurt = hurt * 2
      local xgstr = JY.Person[pid].姓名 .. "\161\250\182\212 " .. JY.Person[eid].姓名 .. " \183\162\182\175\177\169\187\247\201\203\186\166"
      local xglen = #xgstr
      Cls()
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  if eid == 0 and JY.Person[eid].外号 == "\201\241\214\250" and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    local zizhi = 10 - math.modf((JY.Person[eid]["\215\202\214\202"] - 1) / 10)
    local gailv = math.modf(lev * txqh / bsxg) + zizhi + JY.ZCWGCS
    if 50 <= gailv then
      gailv = 50
    end
    hurt = hurt - math.modf(hurt * gailv / 100)
    local xgstr = JY.Person[eid].姓名 .. "\161\250\183\162\182\175\204\236\201\241\187\164\204\229\163\172\201\203\186\166\188\245\201\217 " .. math.modf(hurt * gailv / 100)
    local xglen = #xgstr
    Cls()
    DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
    ShowScreen()
    lib.Delay(300)
  end
  JY.Person[eid].生命 = JY.Person[eid].生命 - hurt
  WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + math.modf(hurt / 5)
  if 0 >= JY.Person[eid].生命 then
    JY.Person[eid].生命 = 0
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + JY.Person[eid]["\181\200\188\182"] * 10
    if JY.DEADKG == 1 then
      local did
      for i = 0, WAR.PersonNum - 1 do
        if JY.DEADPD[i][1] == eid then
          did = i
          break
        end
      end
      if JY.DEADPD[did][2] == 0 then
        local name1 = JY.Person[pid].姓名
        local name2 = JY.Person[eid].姓名
        local size = CC.DefaultFont * 1.5
        local str = name1 .. " \187\247\176\220 " .. name2
        local slen = string.len(str)
        if WAR.Person[WAR.CurID]["\206\210\183\189"] == false then
          DrawStrBox(-1, -1, str, C_RED, size)
        else
          DrawStrBox(-1, -1, str, C_GOLD, size)
        end
        ShowScreen()
        lib.Delay(500)
        Cls()
        JY.DEADPD[did][2] = 1
      end
    end
  end
  local smsx = math.modf(CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)
  AddPersonAttrib(eid, "\202\220\201\203\179\204\182\200", math.modf(hurt / 10 / smsx))
  local duye = 0
  if pid == 0 and JY.Person[pid].外号 == "\182\190\205\245" and CC.JS == 1 then
    local zizhi = 10 - math.modf((JY.Person[pid]["\215\202\214\202"] - 1) / 10)
    duye = math.modf(JY.Person[pid]["\181\200\188\182"] / bsxg * txqh) + zizhi + JY.ZCWGCS
    if 40 <= duye then
      duye = 40
    end
  end
  local poisonnum = level * JY.Wugong[wugong]["\181\208\200\203\214\208\182\190\181\227\202\253"] + JY.Person[pid]["\185\165\187\247\180\248\182\190"] * 3 + duye * 5
  if poisonnum > JY.Person[eid]["\191\185\182\190\196\220\193\166"] and JY.Person[eid]["\191\185\182\190\196\220\193\166"] < 90 then
    if CC.BanBen == 0 then
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 15))
    else
      local dkmax = JY.Person[eid]["\191\185\182\190\196\220\193\166"]
      if 75 < dkmax then
        dkmax = 75
      end
      poisonnum = math.modf(poisonnum * (100 - dkmax) / 100)
      if 1000 < poisonnum then
        poisonnum = 1000
      end
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 30))
    end
  end
  return hurt
end

function War_WugongHurtLife1_CL(emenyid, wugong, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local eid = WAR.Person[emenyid]["\200\203\206\239\177\224\186\197"]
  local mywuxue = 0
  local emenywuxue = 0
  for i = 0, WAR.PersonNum - 1 do
    local id = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
    if WAR.Person[i].死亡 == false and JY.Person[id]["\206\228\209\167\179\163\202\182"] > CC.WXCS then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[i]["\206\210\183\189"] then
        mywuxue = mywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      else
        emenywuxue = emenywuxue + JY.Person[id]["\206\228\209\167\179\163\202\182"]
      end
    end
  end
  while math.modf((level + 1) / 2) * JY.Wugong[wugong]["\207\251\186\196\196\218\193\166\181\227\202\253"] > JY.Person[pid]["\196\218\193\166"] do
    level = level - 1
    goto lbl_80
    do break end
    ::lbl_80::
  end
  if level <= 0 then
    level = 1
  end
  local fightnum = 0
  local wqph = 0
  for i, v in ipairs(CC.ExtraOffense) do
    if v[1] == JY.Person[pid]["\206\228\198\247"] and v[2] == wugong then
      wqph = v[3]
      break
    end
  end
  local wgwl = JY.Wugong[wugong]["\185\165\187\247\193\166" .. level]
  local jsgjl = JY.Person[pid]["\185\165\187\247\193\166"]
  local zbgjl = 0
  if 0 <= JY.Person[pid]["\206\228\198\247"] then
    zbgjl = JY.Thing[JY.Person[pid]["\206\228\198\247"]]["\188\211\185\165\187\247\193\166"]
  end
  if 0 <= JY.Person[pid]["\183\192\190\223"] then
    zbgjl = zbgjl + JY.Thing[JY.Person[pid]["\183\192\190\223"]]["\188\211\185\165\187\247\193\166"]
  end
  local atadd = 1
  if WAR.Person[WAR.CurID]["\206\210\183\189"] then
    fightnum = wgwl / 3 + jsgjl + (zbgjl + wqph) * 2 / 3 + mywuxue * 1.2
  else
    atadd = 1 + JY.ZCWGCS / 20
    fightnum = (wgwl / 3 + jsgjl + (zbgjl + wqph) * 2 / 3 + mywuxue * 1.2) * atadd
  end
  local defencenum = 0
  local zfyl = JY.Person[eid]["\183\192\211\249\193\166"]
  if 0 <= JY.Person[eid]["\206\228\198\247"] then
    zfyl = zfyl + JY.Thing[JY.Person[eid]["\206\228\198\247"]]["\188\211\183\192\211\249\193\166"]
  end
  if 0 <= JY.Person[eid]["\183\192\190\223"] then
    zfyl = zfyl + JY.Thing[JY.Person[eid]["\183\192\190\223"]]["\188\211\183\192\211\249\193\166"]
  end
  if WAR.Person[WAR.CurID]["\206\210\183\189"] == false then
    atadd = 1
    defencenum = (zfyl * 2 + emenywuxue * 4) * atadd
  else
    atadd = 1 + JY.ZCWGCS / 10
    defencenum = (zfyl * 2 + emenywuxue * 4) * atadd
  end
  local hurt = fightnum - defencenum
  if hurt < fightnum / 8 and 0 < hurt then
    hurt = fightnum / 8
    if 70 < hurt then
      hurt = 70
    end
  elseif hurt < 0 then
    hurt = fightnum / 8
    if 70 < hurt then
      hurt = 70
    end
  end
  hurt = hurt + JY.Person[pid]["\204\229\193\166"] / 15 + JY.Person[eid]["\202\220\201\203\179\204\182\200"] / 20
  local ngatt = 0
  local ngdef = 0
  local ngyz = math.modf((CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] + 1) / 1000)
  local ngcz = math.modf(JY.Person[pid]["\215\202\214\202"] / 15)
  local maxnl = math.modf(((9 - ngcz) * 30 + 410) * ngyz)
  if maxnl < JY.Person[pid]["\196\218\193\166"] then
    ngatt = ngatt + math.modf(maxnl / (20 - ngcz) / ngyz * 1.5)
  else
    ngatt = ngatt + math.modf(JY.Person[pid]["\196\218\193\166"] / (20 - ngcz) / ngyz * 1.5)
  end
  if maxnl < JY.Person[eid]["\196\218\193\166"] then
    ngdef = ngdef + math.modf(maxnl / (14 + ngcz) / ngyz)
  else
    ngdef = ngdef + math.modf(JY.Person[eid]["\196\218\193\166"] / (14 + ngcz) / ngyz)
  end
  hurt = hurt + ngatt - ngdef
  local offset = math.abs(WAR.Person[WAR.CurID]["\215\248\177\234X"] - WAR.Person[emenyid]["\215\248\177\234X"]) + math.abs(WAR.Person[WAR.CurID]["\215\248\177\234Y"] - WAR.Person[emenyid]["\215\248\177\234Y"])
  if offset < 10 then
    hurt = hurt * (100 - (offset - 1) * 3) / 100
  else
    hurt = hurt * 2 / 3
  end
  hurt = math.modf(hurt)
  if hurt <= 0 then
    hurt = Rnd(8) + 1
  end
  if pid == 0 and JY.Person[pid].外号 == "\200\173\176\212" and CC.JS == 1 then
    hurt = hurt + math.modf(hurt * JY.Person[pid]["\181\200\188\182"] / 200)
  end
  if eid == 0 and JY.Person[eid].外号 == "\189\163\196\167" and CC.JS == 1 then
    local lev = JY.Person[eid]["\181\200\188\182"]
    if Rnd(100) + 1 <= math.modf(lev / 2) then
      hurt = 0
      local xgstr = "\189\163\196\167\161\250\201\193\182\227\179\201\185\166"
      local xglen = #xgstr
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  if pid == 0 and JY.Person[pid].外号 == "\181\182\179\213" and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    if Rnd(100) + 1 <= math.modf(lev / 2) and JY.Person[eid].生命 * 2 < JY.Person[eid]["\201\250\195\252\215\238\180\243\214\181"] then
      if hurt < JY.Person[eid].生命 then
        hurt = JY.Person[eid].生命 + 1
      end
      local xgstr = "\181\182\179\213\161\250\210\187\187\247\177\216\201\177"
      local xglen = #xgstr
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  if pid == 0 and JY.Person[pid].外号 == "\204\216\191\241" and CC.JS == 1 then
    local lev = JY.Person[pid]["\181\200\188\182"]
    if Rnd(100) + 1 <= math.modf(lev / 2) then
      hurt = hurt + hurt
      local xgstr = "\204\216\191\241\161\250\177\169\187\247\179\201\185\166"
      local xglen = #xgstr
      DrawString(CC.ScreenW / 2 - CC.StartMenuFontSize * xglen / 4, CC.ScreenH / 2, xgstr, C_WHITE, CC.StartMenuFontSize)
      ShowScreen()
      lib.Delay(1000)
    end
  end
  if eid == 0 and JY.Person[eid].外号 == "\201\241\214\250" and CC.JS == 1 then
    hurt = hurt - math.modf(hurt * JY.Person[pid]["\181\200\188\182"] / 100)
  end
  local htbs = math.modf((CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] + 1) / 10)
  local nllevel = math.modf(JY.Person[eid]["\196\218\193\166"] / htbs)
  if 5 < nllevel then
    nllevel = 5
  end
  if htbs <= JY.Person[eid]["\196\218\193\166"] then
    local htnum = nllevel * 4
    if htnum < JY.Person[eid]["\196\218\193\166"] then
      if hurt < htnum then
        JY.Person[eid]["\196\218\193\166"] = JY.Person[eid]["\196\218\193\166"] - hurt
        hurt = 0
      else
        JY.Person[eid]["\196\218\193\166"] = JY.Person[eid]["\196\218\193\166"] - htnum
        hurt = hurt - htnum
      end
    end
  end
  JY.Person[eid].生命 = JY.Person[eid].生命 - hurt
  WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + math.modf(hurt / 5)
  if 0 > JY.Person[eid].生命 then
    JY.Person[eid].生命 = 0
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + JY.Person[eid]["\181\200\188\182"] * 10
  end
  AddPersonAttrib(eid, "\202\220\201\203\179\204\182\200", math.modf(hurt / 10))
  local poisonnum = level * JY.Wugong[wugong]["\181\208\200\203\214\208\182\190\181\227\202\253"] + JY.Person[pid]["\185\165\187\247\180\248\182\190"] * 5
  if poisonnum > JY.Person[eid]["\191\185\182\190\196\220\193\166"] + math.modf(JY.Person[eid]["\196\218\193\166"] / 1000) and JY.Person[eid]["\191\185\182\190\196\220\193\166"] < 90 then
    if CC.BanBen == 0 then
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 15))
    else
      local dkmax = JY.Person[eid]["\191\185\182\190\196\220\193\166"]
      if 75 < dkmax then
        dkmax = 75
      end
      poisonnum = math.modf(poisonnum * (100 - dkmax) / 100)
      if 1000 < poisonnum then
        poisonnum = 1000
      end
      AddPersonAttrib(eid, "\214\208\182\190\179\204\182\200", math.modf(poisonnum / 20))
    end
  end
  return hurt
end

function War_WugongHurtNeili(enemyid, wugong, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local eid = WAR.Person[enemyid]["\200\203\206\239\177\224\186\197"]
  local addvalue = JY.Wugong[wugong]["\188\211\196\218\193\166" .. level]
  local decvalue = JY.Wugong[wugong]["\201\177\196\218\193\166" .. level]
  if 3 < addvalue then
    AddPersonAttrib(pid, "\196\218\193\166\215\238\180\243\214\181", Rnd(math.modf(addvalue / 2)))
    AddPersonAttrib(pid, "\196\218\193\166", addvalue + Rnd(3) - Rnd(3))
  end
  return -AddPersonAttrib(eid, "\196\218\193\166", -(decvalue + Rnd(3) - Rnd(3)))
end

function War_PoisonMenu()
  WAR.ShowHead = 0
  local r = War_ExecuteMenu(1)
  WAR.ShowHead = 1
  Cls()
  return r
end

function War_PoisonHurt(pid, emenyid)
  if CC.BanBen == 0 then
    local v = math.modf((JY.Person[pid]["\211\195\182\190\196\220\193\166"] - JY.Person[emenyid]["\191\185\182\190\196\220\193\166"]) / 4)
    if v < 0 then
      v = 0
    end
    return AddPersonAttrib(emenyid, "\214\208\182\190\179\204\182\200", v)
  else
    local duxing, dunum
    if JY.Person[emenyid]["\191\185\182\190\196\220\193\166"] ~= 100 or CC.BanBen == 5 then
      if JY.Person[emenyid]["\191\185\182\190\196\220\193\166"] > 80 then
        duxing = 80
      else
        duxing = JY.Person[emenyid]["\191\185\182\190\196\220\193\166"]
      end
      dunum = math.modf(JY.Person[pid]["\211\195\182\190\196\220\193\166"] / (CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] / 100 / 2) * ((100 - duxing) / 100 / 2))
      if 35 < dunum then
        dunum = 35
      end
      if dunum < 0 then
        dunum = 0
      end
    else
      dunum = 0
    end
    return AddPersonAttrib(emenyid, "\214\208\182\190\179\204\182\200", dunum)
  end
end

function War_DecPoisonMenu()
  WAR.ShowHead = 0
  local r = War_ExecuteMenu(2)
  WAR.ShowHead = 1
  Cls()
  return r
end

function War_DoctorMenu()
  WAR.ShowHead = 0
  local r = War_ExecuteMenu(3)
  WAR.ShowHead = 1
  Cls()
  return r
end

function War_ExecuteMenu(flag, thingid)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local step
  if flag == 1 then
    step = math.modf(JY.Person[pid]["\211\195\182\190\196\220\193\166"] / 15) + 1
  elseif flag == 2 then
    step = math.modf(JY.Person[pid]["\189\226\182\190\196\220\193\166"] / 15) + 1
  elseif flag == 3 then
    step = math.modf(JY.Person[pid]["\210\189\193\198\196\220\193\166"] / 15) + 1
  elseif flag == 4 then
    step = math.modf(JY.Person[pid]["\176\181\198\247\188\188\199\201"] / 15) + 1
  end
  War_CalMoveStep(WAR.CurID, step, 1)
  local x1, y1 = War_SelectMove1(4)
  if x1 == nil then
    Cls()
    return 0
  else
    return War_ExecuteMenu_Sub(x1, y1, flag, thingid)
  end
end

function War_ExecuteMenu_Sub(x1, y1, flag, thingid)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  CleanWarMap(4, 0)
  WAR.Person[WAR.CurID]["\200\203\183\189\207\242"] = War_Direct(x0, y0, x1, y1)
  SetWarMap(x1, y1, 4, 1)
  lib.PicLoadFile(string.format(CC.FightPicFile[1], JY.Person[pid]["\205\183\207\241\180\250\186\197"]), string.format(CC.FightPicFile[2], JY.Person[pid]["\205\183\207\241\180\250\186\197"]), 4)
  local emeny = GetWarMap(x1, y1, 2)
  if 0 <= emeny then
    if flag == 1 then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[emeny]["\206\210\183\189"] then
        WAR.Person[emeny].点数 = War_PoisonHurt(pid, WAR.Person[emeny]["\200\203\206\239\177\224\186\197"])
        SetWarMap(x1, y1, 4, 5)
        WAR.Effect = 5
      end
    elseif flag == 2 then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[emeny]["\206\210\183\189"] then
        WAR.Person[emeny].点数 = ExecDecPoison(pid, WAR.Person[emeny]["\200\203\206\239\177\224\186\197"])
        SetWarMap(x1, y1, 4, 6)
        WAR.Effect = 6
      end
    elseif flag == 3 then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] == WAR.Person[emeny]["\206\210\183\189"] then
        WAR.Person[emeny].点数 = ExecDoctor(pid, WAR.Person[emeny]["\200\203\206\239\177\224\186\197"])
        SetWarMap(x1, y1, 4, 4)
        WAR.Effect = 4
      end
    elseif flag == 4 and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[emeny]["\206\210\183\189"] then
      WAR.Person[emeny].点数 = War_AnqiHurt(pid, WAR.Person[emeny]["\200\203\206\239\177\224\186\197"], thingid)
      SetWarMap(x1, y1, 4, 2)
      WAR.Effect = 2
    end
  end
  WAR.EffectXY = {}
  WAR.EffectXY[1] = {x1, y1}
  WAR.EffectXY[2] = {x1, y1}
  if flag == 1 then
    War_ShowFight(pid, 0, 0, 0, x1, y1, 30)
  elseif flag == 2 then
    War_ShowFight(pid, 0, 0, 0, x1, y1, 36)
  elseif flag == 3 then
    War_ShowFight(pid, 0, 0, 0, x1, y1, 0)
  elseif flag == 4 and 0 <= emeny then
    War_ShowFight(pid, 0, -1, 0, x1, y1, JY.Thing[thingid]["\176\181\198\247\182\175\187\173\177\224\186\197"])
  end
  for i = 0, WAR.PersonNum - 1 do
    WAR.Person[i].点数 = 0
  end
  if flag == 4 then
    if 0 <= emeny then
      if WAR.Person[WAR.CurID]["\206\210\183\189"] then
        instruct_32(thingid, -1)
        return 1
      else
        instruct_41(pid, thingid, -1)
        return 1
      end
    else
      return 0
    end
  else
    WAR.Person[WAR.CurID]["\190\173\209\233"] = WAR.Person[WAR.CurID]["\190\173\209\233"] + 1
    AddPersonAttrib(pid, "\204\229\193\166", -2)
  end
  return 1
end

function War_ThingMenu()
  WAR.ShowHead = 0
  local thing = {}
  local thingnum = {}
  for i = 0, CC.MyThingNum - 1 do
    thing[i] = -1
    thingnum[i] = 0
  end
  local num = 0
  for i = 0, CC.MyThingNum - 1 do
    local id = JY.Base["\206\239\198\183" .. i + 1]
    if 0 <= id and (JY.Thing[id].类型 == 3 or JY.Thing[id].类型 == 4) then
      thing[num] = id
      thingnum[num] = JY.Base["\206\239\198\183\202\253\193\191" .. i + 1]
      num = num + 1
    end
  end
  local r = SelectThing(thing, thingnum)
  Cls()
  local rr = 0
  if 0 <= r and UseThing(r) == 1 then
    rr = 1
  end
  WAR.ShowHead = 1
  return rr
end

function War_UseAnqi(id)
  return War_ExecuteMenu(4, id)
end

function War_AnqiHurt(pid, emenyid, thingid)
  local num
  if JY.Person[emenyid]["\202\220\201\203\179\204\182\200"] == 0 then
    num = JY.Thing[thingid]["\188\211\201\250\195\252"] / 4 - Rnd(5)
  elseif JY.Person[emenyid]["\202\220\201\203\179\204\182\200"] <= 33 then
    num = JY.Thing[thingid]["\188\211\201\250\195\252"] / 3 - Rnd(5)
  elseif JY.Person[emenyid]["\202\220\201\203\179\204\182\200"] <= 66 then
    num = JY.Thing[thingid]["\188\211\201\250\195\252"] / 2 - Rnd(5)
  else
    num = JY.Thing[thingid]["\188\211\201\250\195\252"] / 2 - Rnd(5)
  end
  if CC.BanBen == 0 then
    num = math.modf((num - JY.Person[pid]["\176\181\198\247\188\188\199\201"] * 2) / 3)
  else
    local fyaq = JY.Person[emenyid]["\183\192\211\249\193\166"] / CC.PersonAttribMax["\183\192\211\249\193\166"]
    if 0.75 < fyaq then
      fyaq = 0.75
    end
    local atk = JY.Person[pid]["\176\181\198\247\188\188\199\201"] / (CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] / 100) * (CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)
    num = math.modf(num - atk * (1 - fyaq))
    if 0 < num then
      num = -Rnd(20)
    end
  end
  if num > 100 * (CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999) then
    num = 100 * (CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)
  end
  AddPersonAttrib(emenyid, "\202\220\201\203\179\204\182\200", math.modf(-num / 4 / (CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] / 999)))
  local r = AddPersonAttrib(emenyid, "\201\250\195\252", math.modf(num))
  if 0 < JY.Thing[thingid]["\188\211\214\208\182\190\189\226\182\190"] then
    num = math.modf((JY.Thing[thingid]["\188\211\214\208\182\190\189\226\182\190"] + JY.Person[pid]["\176\181\198\247\188\188\199\201"]) / (CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] / 100) / 2)
    num = num - JY.Person[emenyid]["\191\185\182\190\196\220\193\166"]
    num = limitX(num, 0, CC.PersonAttribMax["\211\195\182\190\196\220\193\166"])
    AddPersonAttrib(emenyid, "\214\208\182\190\179\204\182\200", num)
  end
  return r
end

function War_RestMenu()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local v = 3 + Rnd(3)
  AddPersonAttrib(pid, "\204\229\193\166", v)
  if JY.Person[pid]["\204\229\193\166"] >= 30 then
    v = 3 + Rnd(math.modf(JY.Person[pid]["\204\229\193\166"] / 10) - 2) + math.modf(JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 100)
    AddPersonAttrib(pid, "\201\250\195\252", v)
    v = 3 + Rnd(math.modf(JY.Person[pid]["\204\229\193\166"] / 10) - 2) + math.modf(JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] / 33)
    AddPersonAttrib(pid, "\196\218\193\166", v)
  end
  return 1
end

function War_WaitMenu()
  for i = WAR.CurID, WAR.PersonNum - 2 do
    local tmp = WAR.Person[i + 1]
    WAR.Person[i + 1] = WAR.Person[i]
    WAR.Person[i] = tmp
  end
  WarSetPerson()
  for i = 0, WAR.PersonNum - 1 do
    WAR.Person[i]["\204\249\205\188"] = WarCalPersonPic(i)
  end
  return 1
end

function War_Huhuo()
  local menu = {}
  local menunum = 0
  for i = 0, WAR.PersonNum - 1 do
    menu[i + 1] = {
      JY.Person[WAR.Person[i]["\200\203\206\239\177\224\186\197"]].姓名,
      nil,
      0
    }
    if WAR.Person[i]["\206\210\183\189"] == true and WAR.Person[i].死亡 == true then
      menu[i + 1][3] = 1
      menunum = menunum + 1
    end
  end
  if menunum == 0 then
    DrawStrBoxWaitKey("\195\187\211\208\208\232\210\170\184\180\187\238\181\196\182\211\211\209\163\161", C_WHITE, CC.DefaultFont)
    return
  end
  Cls()
  local str = "\209\161\212\241\208\232\210\170\184\180\187\238\181\196\182\211\211\209"
  local size = CC.DefaultFont
  local x = CC.ScreenW / 2 - #str / 4 * size
  local y = CC.ScreenH / 2 - 5 * size
  DrawStrBox(x, y, str, C_GOLD, CC.DefaultFont)
  local r = ShowMenu(menu, WAR.PersonNum, 0, x + size * 3, y + size * 2, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
  Cls()
  if 0 < r then
    r = r - 1
    WAR.Person[r].死亡 = false
    local pid = WAR.Person[r]["\200\203\206\239\177\224\186\197"]
    JY.Person[pid].生命 = math.modf(JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 2)
    WarSetPerson()
    JY.Huhuocs = JY.Huhuocs - 1
    Cls()
    DrawStrBoxWaitKey(JY.Person[pid].姓名 .. " \184\180\187\238\163\172\188\211\200\235\213\189\182\183\163\161", C_WHITE, CC.DefaultFont)
    return 1
  else
    return
  end
end

function SetRevivePosition(id)
  local minDest = math.huge
  local x, y
  War_CalMoveStep(WAR.CurID, 100, 0)
  for i = 0, CC.WarWidth - 1 do
    for j = 0, CC.WarHeight - 1 do
      local dest = Byte.get16(WAR.Map3, (j * CC.WarWidth + i) * 2)
      if 0 < dest and dest < 128 then
        if minDest > dest then
          minDest = dest
          x = i
          y = j
        elseif minDest == dest and Rnd(2) == 0 then
          x = i
          y = j
        end
      end
    end
  end
  if minDest < math.huge then
    WAR.Person[id]["\215\248\177\234X"] = x
    WAR.Person[id]["\215\248\177\234Y"] = y
  end
end

function War_Bianshen()
  if DrawStrBoxYesNo(-1, -1, "\200\195\189\199\201\171\177\228\201\237\194\240\163\191", C_WHITE, CC.DefaultFont * 1.2) == false then
    Cls()
    return
  end
  Cls()
  if JY.Person[0].外号 == "\179\172\201\241" then
    local menu = {
      {
        "\200\173\176\212",
        nil,
        1
      },
      {
        "\189\163\196\167",
        nil,
        1
      },
      {
        "\181\182\179\213",
        nil,
        1
      },
      {
        "\204\216\191\241",
        nil,
        1
      },
      {
        "\201\241\214\250",
        nil,
        1
      },
      {
        "\206\215\209\253",
        nil,
        1
      },
      {
        "\182\190\205\245",
        nil,
        1
      },
      {
        "\187\185\212\173",
        nil,
        0
      },
      {
        "\187\195\211\176",
        nil,
        1
      }
    }
    local size = CC.StartMenuFontSize
    local menux = CC.ScreenW / 2 - CC.StartMenuFontSize
    local tsy = CC.ScreenH / 2 - size * 5
    DrawStrBox(menux - size * 2.5, tsy, "\209\161\212\241\177\228\201\237\208\205\204\172", C_GOLD, size)
    local r = ShowMenu(menu, #menu, 0, menux, CC.ScreenH / 2 - CC.StartMenuFontSize * 3, 0, 0, 1, 1, CC.StartMenuFontSize, C_GOLD, C_WHITE)
    if r == 0 then
      return
    elseif r == 1 then
      JY.Wugong[30]["\206\180\214\1702"] = 1
      JY.Person[0].外号 = "\200\173\176\212"
      DrawStrBoxWaitKey("\177\228\201\237\200\173\176\212\161\250\198\198\183\192\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 2 then
      JY.Wugong[30]["\206\180\214\1702"] = 2
      JY.Person[0].外号 = "\189\163\196\167"
      DrawStrBoxWaitKey("\177\228\201\237\189\163\196\167\161\250\202\200\209\170\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 3 then
      JY.Wugong[30]["\206\180\214\1702"] = 3
      JY.Person[0].外号 = "\181\182\179\213"
      DrawStrBoxWaitKey("\177\228\201\237\181\182\179\213\161\250\210\187\187\247\177\216\201\177\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 4 then
      JY.Wugong[30]["\206\180\214\1702"] = 4
      JY.Person[0].外号 = "\204\216\191\241"
      DrawStrBoxWaitKey("\177\228\201\237\204\216\191\241\161\250\177\169\187\247\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 5 then
      JY.Wugong[30]["\206\180\214\1702"] = 5
      JY.Person[0].外号 = "\201\241\214\250"
      DrawStrBoxWaitKey("\177\228\201\237\201\241\214\250\161\250\204\236\201\241\187\164\204\229\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 6 then
      JY.Wugong[30]["\206\180\214\1702"] = 6
      JY.Person[0].外号 = "\206\215\209\253"
      DrawStrBoxWaitKey("\177\228\201\237\206\215\209\253\161\250\214\216\201\250\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
      JY.Huhuocs = math.modf(JY.Person[0]["\181\200\188\182"] / 30)
    elseif r == 7 then
      JY.Wugong[30]["\206\180\214\1702"] = 7
      JY.Person[0].外号 = "\182\190\205\245"
      DrawStrBoxWaitKey("\177\228\201\237\182\190\205\245\161\250\180\227\182\190\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
    elseif r == 9 then
      JY.Wugong[30]["\206\180\214\1702"] = 9
      JY.Person[0].外号 = "\187\195\211\176"
      DrawStrBoxWaitKey("\177\228\201\237\187\195\211\176\161\250\211\176\201\177\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
    end
  else
    DrawStrBoxWaitKey("\187\214\184\180\208\205\204\172", C_WHITE, CC.DefaultFont)
    JY.Person[0].外号 = "\179\172\201\241"
    JY.Wugong[30]["\206\180\214\1702"] = 0
  end
  return 1
end

function War_StatusMenu()
  WAR.ShowHead = 0
  local menu = {
    {
      "\206\210\183\189\215\180\204\172",
      nil,
      1
    },
    {
      "\181\208\183\189\215\180\204\172",
      nil,
      1
    }
  }
  local size = CC.DefaultFont * 1.2
  local menux = size * 3
  local menuy = CC.ScreenH / 2 - size * 0.5
  local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, size, C_GOLD, C_WHITE)
  if r == 1 then
    Menu_Status()
  elseif r == 2 then
    Menu_EmyStatus()
  end
  WAR.ShowHead = 1
  Cls()
end

function War_AutoMenu()
  local atmenu = {}
  local j = 1
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local p = {}
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i]["\206\210\183\189"] then
      pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      p[j] = JY.Person[pid]
      JY.ATAI[j][1] = pid
      if JY.ATAI[j][2] == 1 then
        atmenu[j] = {
          "\198\213\205\168  " .. p[j].姓名,
          nil,
          1
        }
      elseif JY.ATAI[j][2] == 2 then
        atmenu[j] = {
          "\203\192\202\191  " .. p[j].姓名,
          nil,
          1
        }
      elseif JY.ATAI[j][2] == 3 then
        atmenu[j] = {
          "\187\236\215\211  " .. p[j].姓名,
          nil,
          1
        }
      elseif JY.ATAI[j][2] == 4 then
        atmenu[j] = {
          "\196\204\194\232  " .. p[j].姓名,
          nil,
          1
        }
      end
      if WAR.Person[i].死亡 == true then
        atmenu[j][3] = 0
      end
      j = j + 1
    end
  end
  atmenu[j] = {
    "  \200\171\204\229\201\232\214\195",
    nil,
    1
  }
  j = j + 1
  atmenu[j] = {
    "  \215\212\182\175\213\189\182\183",
    nil,
    1
  }
  local size = CC.DefaultFont
  local menux = CC.ScreenW / 2 - size * 5
  local tsy = CC.ScreenH / 2 - #atmenu * size / 2 - size * 1.5
  local rr = j
  while true do
    Cls()
    DrawStrBox(menux - size * 0.5, tsy, "\181\247\213\251\215\212\182\175\213\189\182\183AI", C_GOLD, size)
    local r = ShowMenu(atmenu, #atmenu, 0, menux, CC.ScreenH / 2 - #atmenu * size / 2, 0, 0, 1, 1, size, C_GOLD, C_WHITE, rr)
    if 0 < r and j > r then
      local lxmenu = {
        {
          "\198\213\205\168",
          nil,
          1
        },
        {
          "\203\192\202\191",
          nil,
          1
        },
        {
          "\187\236\215\211",
          nil,
          1
        }
      }
      local r1 = ShowMenu(lxmenu, #lxmenu, 0, menux + size * 2, CC.ScreenH / 2 - size * 3, 0, 0, 1, 1, size, C_GOLD, C_WHITE)
      if r ~= j - 1 then
        if r1 == 1 then
          atmenu[r] = {
            "\198\213\205\168  " .. p[r].姓名,
            nil,
            1
          }
          JY.ATAI[r][2] = r1
        elseif r1 == 2 then
          atmenu[r] = {
            "\203\192\202\191  " .. p[r].姓名,
            nil,
            1
          }
          JY.ATAI[r][2] = r1
        elseif r1 == 3 then
          atmenu[r] = {
            "\187\236\215\211  " .. p[r].姓名,
            nil,
            1
          }
          JY.ATAI[r][2] = r1
        elseif r1 == 4 then
          atmenu[r] = {
            "\196\204\194\232  " .. p[r].姓名,
            nil,
            1
          }
          JY.ATAI[r][2] = r1
        end
      elseif r == j - 1 then
        for i = 1, j - 2 do
          if r1 == 1 then
            atmenu[i] = {
              "\198\213\205\168  " .. p[i].姓名,
              nil,
              1
            }
            JY.ATAI[i][2] = r1
          elseif r1 == 2 then
            atmenu[i] = {
              "\203\192\202\191  " .. p[i].姓名,
              nil,
              1
            }
            JY.ATAI[i][2] = r1
          elseif r1 == 3 then
            atmenu[i] = {
              "\187\236\215\211  " .. p[i].姓名,
              nil,
              1
            }
            JY.ATAI[i][2] = r1
          elseif r1 == 4 then
            atmenu[i] = {
              "\196\204\194\232  " .. p[i].姓名,
              nil,
              1
            }
            JY.ATAI[i][2] = r1
          end
        end
      end
      rr = r
    else
      if r == j then
        break
      end
      if r == 0 then
        return
      end
    end
  end
  WAR.AutoFight = 1
  WAR.ShowHead = 0
  Cls()
  War_Auto()
  return 1
end

function War_Auto()
  WAR.ShowHead = 1
  WarDrawMap(0)
  ShowScreen()
  lib.Delay(CC.WarAutoDelay)
  WAR.ShowHead = 0
  if CC.AutoWarShowHead == 1 then
    WAR.ShowHead = 1
  end
  local autotype = War_Think()
  if autotype == 0 then
    War_AutoEscape()
    War_RestMenu()
  elseif autotype == 1 then
    War_AutoFight()
  elseif autotype == 2 then
    War_AutoEscape()
    War_AutoEatDrug(2)
  elseif autotype == 3 then
    War_AutoEscape()
    War_AutoEatDrug(3)
  elseif autotype == 4 then
    War_AutoEscape()
    War_AutoEatDrug(4)
  elseif autotype == 5 then
    War_AutoEscape()
    War_AutoDoctor()
  elseif autotype == 6 then
    War_AutoEscape()
    War_AutoEatDrug(6)
  elseif autotype == 7 then
    War_AutoAQ(JY.AQID)
  end
  return 0
end

function War_Think()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local r = -1
  if JY.Person[pid]["\204\229\193\166"] < 10 then
    r = War_ThinkDrug(4)
    if 0 <= r then
      return r
    end
    return 0
  end
  local aipd = 0
  if WAR.Person[WAR.CurID]["\206\210\183\189"] then
    for i = 1, 20 do
      if JY.ATAI[i][1] == pid then
        JY.AISET = JY.ATAI[i][2]
        break
      end
    end
    aipd = 1
  else
    JY.AISET = 1
  end
  if JY.AISET == 3 then
    if JY.Person[pid]["\202\220\201\203\179\204\182\200"] > 50 then
      r = War_ThinkDoctor()
      if 0 <= r then
        return r
      end
    end
    local rate = -1
    if JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 5 then
      rate = 100
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 4 then
      rate = 100
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 3 then
      rate = 80
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 2 then
      rate = 40
    end
    if rate > Rnd(100) then
      r = War_ThinkDoctor()
      if 0 <= r then
        return r
      end
    end
    return 0
  end
  if JY.AISET == 1 then
    if JY.Person[pid]["\202\220\201\203\179\204\182\200"] > 50 then
      r = War_ThinkDrug(2)
      if 0 <= r then
        return r
      end
    end
    local rate = -1
    if JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 5 then
      rate = 100
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 4 then
      rate = 100
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 3 then
      rate = 80
    elseif JY.Person[pid].生命 < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 2 then
      rate = 40
    end
    if rate > Rnd(100) then
      r = War_ThinkDrug(2)
      if 0 <= r then
        return r
      else
        r = War_ThinkDoctor()
        if 0 <= r then
          return r
        end
      end
    end
  end
  if JY.AISET == 1 then
    local rate = -1
    if JY.Person[pid]["\196\218\193\166"] < JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] / 5 then
      rate = 80
    elseif JY.Person[pid]["\196\218\193\166"] < JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"] / 4 then
      rate = 50
    end
    if rate > Rnd(100) then
      r = War_ThinkDrug(3)
      if 0 <= r then
        return r
      end
    end
  end
  if JY.AISET == 1 then
    local rate = -1
    if JY.Person[pid]["\214\208\182\190\179\204\182\200"] > CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] * 3 / 4 then
      rate = 100
    elseif JY.Person[pid]["\214\208\182\190\179\204\182\200"] > CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] / 2 then
      rate = 50
    elseif JY.Person[pid]["\214\208\182\190\179\204\182\200"] > CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] / 4 then
      rate = 25
    end
    if rate > Rnd(100) then
      r = War_ThinkDrug(6)
      if 0 <= r then
        return r
      end
    end
  end
  if JY.AISET == 1 or JY.AISET == 2 then
    local minNeili = War_GetMinNeiLi(pid)
    if minNeili <= JY.Person[pid]["\196\218\193\166"] then
      local dwpd = 0
      if WAR.Person[WAR.CurID]["\206\210\183\189"] then
        dwpd = 1
      end
      local j = 1
      local aqwp = {}
      local aqwpno = {}
      local aqmax = {}
      aqmax[1] = math.huge
      aqmax[2] = -1
      if dwpd == 1 then
        for i = 1, JY.AQNUM do
          if instruct_18(JY.AQ[i]) then
            aqwp[j] = JY.Thing[JY.AQ[i]]["\188\211\201\250\195\252"]
            aqwpno[j] = JY.AQ[i]
            if aqmax[1] > aqwp[j] then
              aqmax[1] = aqwp[j]
              aqmax[2] = aqwpno[j]
            end
            j = j + 1
          end
        end
        if j < 2 then
          r = 0
          JY.AQID = -1
        else
          if aqmax[1] > -3 then
            aqmax[1] = -4
          end
          if 50 > Rnd(100) and JY.Person[pid]["\176\181\198\247\188\188\199\201"] * 2 / 3 + math.modf(-aqmax[1] / 4) > JY.Person[pid]["\185\165\187\247\193\166"] + Rnd(math.modf(-aqmax[1] / 4)) then
            r = 7
            JY.AQID = aqmax[2]
            return r
          end
        end
      else
        for i = 1, JY.AQNUM do
          for k = 1, 4 do
            if JY.Person[pid]["\208\175\180\248\206\239\198\183" .. k] == JY.AQ[i] then
              aqwp[j] = JY.Thing[JY.AQ[i]]["\188\211\201\250\195\252"]
              aqwpno[j] = JY.AQ[i]
              if aqmax[1] > aqwp[j] then
                aqmax[1] = aqwp[j]
                aqmax[2] = aqwpno[j]
              end
              j = j + 1
            end
          end
        end
        if j < 2 then
          r = 0
          JY.AQID = -1
        else
          if aqmax[1] > -3 then
            aqmax[1] = -4
          end
          if JY.Person[pid]["\176\181\198\247\188\188\199\201"] * 2 / 3 + math.modf(-aqmax[1] / 4) > JY.Person[pid]["\185\165\187\247\193\166"] + Rnd(math.modf(-aqmax[1] / 4)) then
            r = 7
            JY.AQID = aqmax[2]
            return r
          end
        end
      end
      r = 1
      return r
    else
      r = 0
    end
  end
  if JY.AISET == 1 or JY.AISET == 2 then
    local dwpd = 0
    if WAR.Person[WAR.CurID]["\206\210\183\189"] then
      dwpd = 1
    end
    local j = 1
    local aqwp = {}
    local aqwpno = {}
    local aqmax = {}
    aqmax[1] = math.huge
    aqmax[2] = -1
    if dwpd == 1 then
      for i = 1, JY.AQNUM do
        if instruct_18(JY.AQ[i]) then
          aqwp[j] = JY.Thing[JY.AQ[i]]["\188\211\201\250\195\252"]
          aqwpno[j] = JY.AQ[i]
          if aqmax[1] > aqwp[j] then
            aqmax[1] = aqwp[j]
            aqmax[2] = aqwpno[j]
          end
          j = j + 1
        end
      end
      if j < 2 then
        r = 0
        JY.AQID = -1
      else
        r = 7
        JY.AQID = aqmax[2]
        return r
      end
    else
      for i = 1, JY.AQNUM do
        for k = 1, 4 do
          if JY.Person[pid]["\208\175\180\248\206\239\198\183" .. k] == JY.AQ[i] then
            aqwp[j] = JY.Thing[JY.AQ[i]]["\188\211\201\250\195\252"]
            aqwpno[j] = JY.AQ[i]
            if aqmax[1] > aqwp[j] then
              aqmax[1] = aqwp[j]
              aqmax[2] = aqwpno[j]
            end
            j = j + 1
          end
        end
      end
      if j < 2 then
        r = 0
        JY.AQID = -1
      else
        r = 7
        JY.AQID = aqmax[2]
        return r
      end
    end
  end
  return r
end

function War_ThinkDrug(flag)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local str
  local r = -1
  if flag == 2 then
    str = "\188\211\201\250\195\252"
  elseif flag == 3 then
    str = "\188\211\196\218\193\166"
  elseif flag == 4 then
    str = "\188\211\204\229\193\166"
  elseif flag == 6 then
    str = "\188\211\214\208\182\190\189\226\182\190"
  else
    return r
  end
  
  local function Get_Add(thingid)
    if flag == 6 then
      return -JY.Thing[thingid][str]
    else
      return JY.Thing[thingid][str]
    end
  end
  
  if WAR.Person[WAR.CurID]["\206\210\183\189"] == true then
    for i = 1, CC.MyThingNum do
      local thingid = JY.Base["\206\239\198\183" .. i]
      if 0 <= thingid and JY.Thing[thingid].类型 == 3 and 0 < Get_Add(thingid) then
        r = flag
        break
      end
    end
  else
    for i = 1, 4 do
      local thingid = JY.Person[pid]["\208\175\180\248\206\239\198\183" .. i]
      if 0 <= thingid and JY.Thing[thingid].类型 == 3 and 0 < Get_Add(thingid) then
        r = flag
        break
      end
    end
  end
  return r
end

function War_ThinkDoctor()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  if JY.Person[pid]["\204\229\193\166"] < 50 or JY.Person[pid]["\210\189\193\198\196\220\193\166"] < 20 then
    return -1
  end
  if JY.Person[pid]["\202\220\201\203\179\204\182\200"] > JY.Person[pid]["\210\189\193\198\196\220\193\166"] + 20 then
    return -1
  end
  local rate = -1
  local v = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] - JY.Person[pid].生命
  if JY.Person[pid]["\210\189\193\198\196\220\193\166"] < v / 4 then
    rate = 30
  elseif JY.Person[pid]["\210\189\193\198\196\220\193\166"] < v / 3 then
    rate = 50
  elseif JY.Person[pid]["\210\189\193\198\196\220\193\166"] < v / 2 then
    rate = 70
  else
    rate = 90
  end
  if rate > Rnd(100) then
    return 5
  end
  return -1
end

function War_AutoAQ(id)
  if id == -1 then
    War_AutoEscape()
    War_RestMenu()
    return
  end
  local r = War_AutoMove(-1)
  if r == 1 then
    War_AutoExecuteFight(-1)
  else
    War_RestMenu()
  end
end

function War_AutoFight()
  local wugongnum = War_AutoSelectWugong()
  if wugongnum <= 0 then
    War_AutoEscape()
    War_RestMenu()
    return
  end
  local r = War_AutoMove(wugongnum)
  if r == 1 then
    War_AutoExecuteFight(wugongnum)
  else
    War_RestMenu()
  end
end

function War_AutoSelectWugong()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local probability = {}
  local wugongnum = 10
  for i = 1, 10 do
    local wugongid = JY.Person[pid]["\206\228\185\166" .. i]
    if 0 < wugongid then
      if JY.Wugong[wugongid]["\201\203\186\166\192\224\208\205"] == 0 then
        if JY.Wugong[wugongid]["\207\251\186\196\196\218\193\166\181\227\202\253"] <= JY.Person[pid]["\196\218\193\166"] then
          local level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. i] / 100) + 1
          probability[i] = (JY.Person[pid]["\185\165\187\247\193\166"] * 3 + JY.Wugong[wugongid]["\185\165\187\247\193\166" .. level]) / 2
          local extranum = 0
          for j, v in ipairs(CC.ExtraOffense) do
            if v[1] == JY.Person[pid]["\206\228\198\247"] and v[2] == wugongid then
              extranum = v[3]
              break
            end
          end
          probability[i] = probability[i] + extranum
        else
          probability[i] = 0
        end
      else
        probability[i] = 10
      end
    else
      probability[i] = 0
    end
  end
  local mynum = 0
  local enemynum = 0
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i].死亡 == false then
      if WAR.Person[i]["\206\210\183\189"] == WAR.Person[WAR.CurID]["\206\210\183\189"] then
        mynum = mynum + 1
      else
        enemynum = enemynum + 1
      end
    end
  end
  local factor = 0
  if mynum < enemynum then
    factor = enemynum
  elseif enemynum < 2 then
    factor = 0
  else
    factor = enemynum / 2
  end
  local gjfwnum = {
    0,
    0,
    0,
    0
  }
  local dyz = 0
  for i = 1, wugongnum do
    local wugongid = JY.Person[pid]["\206\228\185\166" .. i]
    if 0 < probability[i] then
      local level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. i] / 100) + 1
      if JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 0 then
        if factor == 0 then
          dyz = 1
        else
          dyz = 0
        end
        probability[i] = probability[i] + probability[i] * dyz * 5 / 100
        if probability[i] > gjfwnum[1] then
          gjfwnum[1] = probability[i]
        else
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 1 then
        probability[i] = probability[i] + JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level] * factor * 20 * probability[i] / 1000 + probability[i] * dyz * 3 / 100
        if probability[i] > gjfwnum[2] then
          gjfwnum[2] = probability[i]
        else
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 2 then
        probability[i] = probability[i] + JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level] * factor * 40 * probability[i] / 1000 + probability[i] * dyz * 2 / 100
        if probability[i] > gjfwnum[3] then
          gjfwnum[3] = probability[i]
        else
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 3 then
        probability[i] = probability[i] + JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level] * factor * 30 * probability[i] / 1000 + JY.Wugong[wugongid]["\201\177\201\203\183\182\206\167" .. level] * 50 * factor * probability[i] / 1000 + probability[i] * dyz * 1 / 100
        if probability[i] > gjfwnum[4] then
          gjfwnum[4] = probability[i]
        else
          probability[i] = 0
        end
      end
    end
  end
  for i = 1, wugongnum do
    local wugongid = JY.Person[pid]["\206\228\185\166" .. i]
    if 0 < probability[i] then
      if JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 0 then
        if probability[i] < gjfwnum[1] then
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 1 then
        if probability[i] < gjfwnum[2] then
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 2 then
        if probability[i] < gjfwnum[3] then
          probability[i] = 0
        end
      elseif JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"] == 3 and probability[i] < gjfwnum[4] then
        probability[i] = 0
      end
    end
  end
  local maxoffense = 0
  for i = 1, wugongnum do
    if maxoffense < probability[i] then
      maxoffense = probability[i]
    end
  end
  for i = 1, wugongnum do
    if probability[i] < maxoffense * 2 / 3 then
      probability[i] = 0
    end
    if (enemynum < 2 or mynum > enemynum) and probability[i] < maxoffense * 9 / 10 then
      probability[i] = 0
    end
  end
  local s = {}
  local maxnum = 0
  for i = 1, wugongnum do
    s[i] = maxnum
    maxnum = maxnum + probability[i]
  end
  s[wugongnum + 1] = maxnum
  if maxnum == 0 then
    return -1
  end
  local v = Rnd(maxnum)
  local selectid = 0
  for i = 1, wugongnum do
    if v >= s[i] and v < s[i + 1] then
      selectid = i
      break
    end
  end
  return selectid
end

function War_AutoSelectEnemy()
  local enemyid = War_AutoSelectEnemy_near()
  WAR.Person[WAR.CurID]["\215\212\182\175\209\161\212\241\182\212\202\214"] = enemyid
  return enemyid
end

function War_AutoSelectEnemy_near()
  War_CalMoveStep(WAR.CurID, 100, 1)
  local maxDest = math.huge
  local nearid = -1
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[i]["\206\210\183\189"] and WAR.Person[i].死亡 == false then
      local step = GetWarMap(WAR.Person[i]["\215\248\177\234X"], WAR.Person[i]["\215\248\177\234Y"], 3)
      if maxDest > step then
        nearid = i
        maxDest = step
      end
    end
  end
  return nearid
end

function War_AutoMove(wugongnum)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local wugongid, level, wugongtype, movescope, fightscope, scope
  if wugongnum == -1 then
    scope = math.modf(JY.Person[pid]["\176\181\198\247\188\188\199\201"] / 15) + 1
    wugongid = -1
    wugongtype = 0
  else
    wugongid = JY.Person[pid]["\206\228\185\166" .. wugongnum]
    level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] / 100) + 1
    wugongtype = JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"]
    movescope = JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level]
    fightscope = JY.Wugong[wugongid]["\201\177\201\203\183\182\206\167" .. level]
    scope = movescope + fightscope
  end
  local x, y
  local move = 128
  local maxenemy = 0
  local movestep = War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"], 0)
  War_AutoCalMaxEnemyMap(wugongid, level)
  for i = 0, WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] do
    local step_num = movestep[i].num
    if step_num == 0 then
      break
    end
    for j = 1, step_num do
      local xx = movestep[i].x[j]
      local yy = movestep[i].y[j]
      local num = 0
      if wugongtype == 0 or wugongtype == 2 or wugongtype == 3 then
        num = GetWarMap(xx, yy, 4)
      elseif wugongtype == 1 then
        local v = GetWarMap(xx, yy, 4)
        if 0 < v then
          num = War_AutoCalMaxEnemy(xx, yy, wugongid, level)
        end
      end
      if maxenemy < num then
        maxenemy = num
        x = xx
        y = yy
        move = i
      elseif num == maxenemy and 0 < num and Rnd(3) == 0 then
        maxenemy = num
        x = xx
        y = yy
        move = i
      end
    end
  end
  if 0 < maxenemy then
    War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"], 0)
    War_MovePerson(x, y)
    return 1
  else
    x, y = War_GetCanFightEnemyXY(scope)
    local minDest = math.huge
    if x == nil then
      local enemyid = War_AutoSelectEnemy()
      War_CalMoveStep(WAR.CurID, 100, 0)
      for i = 0, CC.WarWidth - 1 do
        for j = 0, CC.WarHeight - 1 do
          local dest = GetWarMap(i, j, 3)
          if dest < 128 then
            local dx = math.abs(i - WAR.Person[enemyid]["\215\248\177\234X"])
            local dy = math.abs(j - WAR.Person[enemyid]["\215\248\177\234Y"])
            if minDest > dx + dy then
              minDest = dx + dy
              x = i
              y = j
            elseif minDest == dx + dy and Rnd(2) == 0 then
              x = i
              y = j
            end
          end
        end
      end
    else
      minDest = 0
    end
    if minDest < math.huge then
      while true do
        local i = GetWarMap(x, y, 3)
        if i <= WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"] then
          break
        end
        if GetWarMap(x - 1, y, 3) == i - 1 then
          x = x - 1
        elseif GetWarMap(x + 1, y, 3) == i - 1 then
          x = x + 1
        elseif GetWarMap(x, y - 1, 3) == i - 1 then
          y = y - 1
        elseif GetWarMap(x, y + 1, 3) == i - 1 then
          y = y + 1
        end
      end
      War_MovePerson(x, y)
    end
  end
  return 0
end

function War_GetCanFightEnemyXY(scope)
  local minStep = math.huge
  local newx, newy
  War_CalMoveStep(WAR.CurID, 100, 0)
  for x = 0, CC.WarWidth - 1 do
    for y = 0, CC.WarHeight - 1 do
      if 0 < GetWarMap(x, y, 4) then
        local step = GetWarMap(x, y, 3)
        if step < 128 then
          if minStep > step then
            minStep = step
            newx = x
            newy = y
          elseif minStep == step and Rnd(2) == 0 then
            newx = x
            newy = y
          end
        end
      end
    end
  end
  if minStep < math.huge then
    return newx, newy
  end
end

function War_AutoCalMaxEnemyMap(wugongid, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local wugongtype, movescope, fightscope
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  CleanWarMap(4, 0)
  if wugongid == -1 then
    movescope = math.modf(JY.Person[pid]["\176\181\198\247\188\188\199\201"] / 15) + 1
    wugongtype = 0
    fightscope = 0
  else
    wugongtype = JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"]
    movescope = JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level]
    fightscope = JY.Wugong[wugongid]["\201\177\201\203\183\182\206\167" .. level]
  end
  if wugongtype == 0 or wugongtype == 3 then
    for n = 0, WAR.PersonNum - 1 do
      if n ~= WAR.CurID and WAR.Person[n].死亡 == false and WAR.Person[n]["\206\210\183\189"] ~= WAR.Person[WAR.CurID]["\206\210\183\189"] then
        local xx = WAR.Person[n]["\215\248\177\234X"]
        local yy = WAR.Person[n]["\215\248\177\234Y"]
        local movestep = War_CalMoveStep(n, movescope, 1)
        for i = 1, movescope do
          local step_num = movestep[i].num
          if step_num == 0 then
            break
          end
          local v = 0
          for j = 1, step_num do
            if wugongtype == 0 then
              SetWarMap(movestep[i].x[j], movestep[i].y[j], 4, 1)
            elseif wugongtype == 3 then
              for aa = -fightscope, fightscope do
                for bb = -fightscope, fightscope do
                  local id = GetWarMap(movestep[i].x[j] + aa, movestep[i].y[j] + bb, 2)
                  if 0 <= id and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[id]["\206\210\183\189"] then
                    v = v + 1
                  end
                end
              end
              SetWarMap(movestep[i].x[j], movestep[i].y[j], 4, v + 1)
            end
          end
        end
      end
    end
  elseif wugongtype == 1 or wugongtype == 2 then
    for n = 0, WAR.PersonNum - 1 do
      if n ~= WAR.CurID and WAR.Person[n].死亡 == false and WAR.Person[n]["\206\210\183\189"] ~= WAR.Person[WAR.CurID]["\206\210\183\189"] then
        local xx = WAR.Person[n]["\215\248\177\234X"]
        local yy = WAR.Person[n]["\215\248\177\234Y"]
        for direct = 0, 3 do
          for i = 1, movescope do
            local xnew = xx + CC.DirectX[direct + 1] * i
            local ynew = yy + CC.DirectY[direct + 1] * i
            if 0 <= xnew and xnew < CC.WarWidth and 0 <= ynew and ynew < CC.WarHeight then
              local v = GetWarMap(xnew, ynew, 4)
              SetWarMap(xnew, ynew, 4, v + 1)
            end
          end
        end
      end
    end
  end
end

function War_AutoCalMaxEnemy(x, y, wugongid, level)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local wugongtype, movescope, fightscope
  local maxnum = 0
  local xmax, ymax
  if wugongid == -1 then
    movescope = math.modf(JY.Person[pid]["\176\181\198\247\188\188\199\201"] / 15) + 1
    wugongtype = 0
    fightscope = 0
  else
    wugongtype = JY.Wugong[wugongid]["\185\165\187\247\183\182\206\167"]
    movescope = JY.Wugong[wugongid]["\210\198\182\175\183\182\206\167" .. level]
    fightscope = JY.Wugong[wugongid]["\201\177\201\203\183\182\206\167" .. level]
  end
  if wugongtype == 0 or wugongtype == 3 then
    local movestep = War_CalMoveStep(WAR.CurID, movescope, 1)
    for i = 1, movescope do
      local step_num = movestep[i].num
      if step_num == 0 then
        break
      end
      for j = 1, step_num do
        local xx = movestep[i].x[j]
        local yy = movestep[i].y[j]
        local enemynum = 0
        for n = 0, WAR.PersonNum - 1 do
          if n ~= WAR.CurID and WAR.Person[n].死亡 == false and WAR.Person[n]["\206\210\183\189"] ~= WAR.Person[WAR.CurID]["\206\210\183\189"] then
            local x = math.abs(WAR.Person[n]["\215\248\177\234X"] - xx)
            local y = math.abs(WAR.Person[n]["\215\248\177\234Y"] - yy)
            if fightscope >= x and fightscope >= y then
              enemynum = enemynum + 1
            end
          end
        end
        if maxnum < enemynum then
          maxnum = enemynum
          xmax = xx
          ymax = yy
        end
      end
    end
  elseif wugongtype == 1 then
    for direct = 0, 3 do
      local enemynum = 0
      for i = 1, movescope do
        local xnew = x + CC.DirectX[direct + 1] * i
        local ynew = y + CC.DirectY[direct + 1] * i
        if 0 <= xnew and xnew < CC.WarWidth and 0 <= ynew and ynew < CC.WarHeight then
          local id = GetWarMap(xnew, ynew, 2)
          if 0 <= id and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[id]["\206\210\183\189"] then
            enemynum = enemynum + 1
          end
        end
      end
      if maxnum < enemynum then
        maxnum = enemynum
        xmax = x + CC.DirectX[direct + 1]
        ymax = y + CC.DirectY[direct + 1]
      end
    end
  elseif wugongtype == 2 then
    local enemynum = 0
    for direct = 0, 3 do
      for i = 1, movescope do
        local xnew = x + CC.DirectX[direct + 1] * i
        local ynew = y + CC.DirectY[direct + 1] * i
        if 0 <= xnew and xnew < CC.WarWidth and 0 <= ynew and ynew < CC.WarHeight then
          local id = GetWarMap(xnew, ynew, 2)
          if 0 <= id and WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[id]["\206\210\183\189"] then
            enemynum = enemynum + 1
          end
        end
      end
    end
    if 0 < enemynum then
      maxnum = enemynum
      xmax = x
      ymax = y
    end
  end
  return maxnum, xmax, ymax
end

function War_AutoExecuteFight(wugongnum)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  local wugongid, level
  if wugongnum == -1 then
    wugongid = -1
  else
    wugongid = JY.Person[pid]["\206\228\185\166" .. wugongnum]
    level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. wugongnum] / 100) + 1
  end
  local maxnum, x, y = War_AutoCalMaxEnemy(x0, y0, wugongid, level)
  if x ~= nil then
    War_Fight_Sub(WAR.CurID, wugongnum, x, y)
  end
end

function War_AutoEscape()
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  if JY.Person[pid]["\204\229\193\166"] <= 5 then
    return
  end
  local maxDest = 0
  local x, y
  War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID]["\210\198\182\175\178\189\202\253"], 0)
  for i = 0, CC.WarWidth - 1 do
    for j = 0, CC.WarHeight - 1 do
      if GetWarMap(i, j, 3) < 128 then
        local minDest = math.huge
        for k = 0, WAR.PersonNum - 1 do
          if WAR.Person[WAR.CurID]["\206\210\183\189"] ~= WAR.Person[k]["\206\210\183\189"] and WAR.Person[k].死亡 == false then
            local dx = math.abs(i - WAR.Person[k]["\215\248\177\234X"])
            local dy = math.abs(j - WAR.Person[k]["\215\248\177\234Y"])
            if minDest > dx + dy then
              minDest = dx + dy
            end
          end
        end
        if maxDest < minDest then
          maxDest = minDest
          x = i
          y = j
        end
      end
    end
  end
  if 0 < maxDest then
    War_MovePerson(x, y)
  end
end

function War_AutoEatDrug(flag)
  local pid = WAR.Person[WAR.CurID]["\200\203\206\239\177\224\186\197"]
  local life = JY.Person[pid].生命
  local maxlife = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
  local selectid
  local minvalue = math.huge
  local shouldadd, maxattrib, str
  if flag == 2 then
    maxattrib = JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
    shouldadd = maxattrib - JY.Person[pid].生命
    str = "\188\211\201\250\195\252"
  elseif flag == 3 then
    maxattrib = JY.Person[pid]["\196\218\193\166\215\238\180\243\214\181"]
    shouldadd = maxattrib - JY.Person[pid]["\196\218\193\166"]
    str = "\188\211\196\218\193\166"
  elseif flag == 4 then
    maxattrib = CC.PersonAttribMax["\204\229\193\166"]
    shouldadd = maxattrib - JY.Person[pid]["\204\229\193\166"]
    str = "\188\211\204\229\193\166"
  elseif flag == 6 then
    maxattrib = CC.PersonAttribMax["\214\208\182\190\179\204\182\200"]
    shouldadd = JY.Person[pid]["\214\208\182\190\179\204\182\200"]
    str = "\188\211\214\208\182\190\189\226\182\190"
  else
    return
  end
  
  local function Get_Add(thingid)
    if flag == 6 then
      return -JY.Thing[thingid][str] / 2
    else
      return JY.Thing[thingid][str]
    end
  end
  
  if WAR.Person[WAR.CurID]["\206\210\183\189"] == true then
    local extra = 0
    for i = 1, CC.MyThingNum do
      local thingid = JY.Base["\206\239\198\183" .. i]
      if 0 <= thingid then
        local add = Get_Add(thingid)
        if JY.Thing[thingid].类型 == 3 and 0 < add then
          local v = shouldadd - add
          if v < 0 then
            extra = 1
            break
          elseif minvalue > v then
            minvalue = v
            selectid = thingid
          end
        end
      end
    end
    if extra == 1 then
      minvalue = math.huge
      for i = 1, CC.MyThingNum do
        local thingid = JY.Base["\206\239\198\183" .. i]
        if 0 <= thingid then
          local add = Get_Add(thingid)
          if JY.Thing[thingid].类型 == 3 and 0 < add then
            local v = add - shouldadd
            if 0 <= v and minvalue > v then
              minvalue = v
              selectid = thingid
            end
          end
        end
      end
    end
    if UseThingEffect(selectid, pid) == 1 then
      instruct_32(selectid, -1)
    end
  else
    local extra = 0
    for i = 1, 4 do
      local thingid = JY.Person[pid]["\208\175\180\248\206\239\198\183" .. i]
      if 0 <= thingid then
        local add = Get_Add(thingid)
        if JY.Thing[thingid].类型 == 3 and 0 < add then
          local v = shouldadd - add
          if v < 0 then
            extra = 1
            break
          elseif minvalue > v then
            minvalue = v
            selectid = thingid
          end
        end
      end
    end
    if extra == 1 then
      minvalue = math.huge
      for i = 1, 4 do
        local thingid = JY.Person[pid]["\208\175\180\248\206\239\198\183" .. i]
        if 0 <= thingid then
          local add = Get_Add(thingid)
          if JY.Thing[thingid].类型 == 3 and 0 < add then
            local v = add - shouldadd
            if 0 <= v and minvalue > v then
              minvalue = v
              selectid = thingid
            end
          end
        end
      end
    end
    if UseThingEffect(selectid, pid) == 1 then
      instruct_41(pid, selectid, -1)
    end
  end
  lib.Delay(500)
end

function War_AutoDoctor()
  local x1 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
  local y1 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  War_ExecuteMenu_Sub(x1, y1, 3, -1)
end

function existFile(filename)
  local f = io.open(filename)
  if f == nil then
    return false
  end
  io.close(f)
  return true
end

function delaytime(dtime)
  lib.Delay(dtime)
end

function WhoAmI()
  local ztsize = CC.DefaultFont * 0.8
  if CC.BanBen == 1 then
    DrawString(1, 1, "\178\212\193\250\214\240\200\213\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    local str = "MOD\215\247\213\223\163\186\208\161\208\161\214\237"
    DrawString(1, ztsize * 6, str, C_RED, ztsize)
  elseif CC.BanBen == 0 then
    DrawString(1, 1, "\189\240\211\185\200\186\207\192\180\171\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    local str = "\204\168\205\229\186\211\194\229\185\164\215\247\202\210\179\246\198\183"
    DrawString(1, ztsize * 6, str, C_RED, ztsize)
  elseif CC.BanBen == 2 then
    DrawString(1, 1, "\212\217\213\189\189\173\186\254\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    local str = "MOD\215\247\213\223\163\186\196\207\185\172\195\206"
    DrawString(1, ztsize * 6, str, C_RED, ztsize)
  elseif CC.BanBen == 3 then
    DrawString(1, 1, "\204\168\205\229\207\231\195\241\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    local str = "MOD\215\247\213\223\163\186leo32145"
    DrawString(1, ztsize * 6, str, C_RED, ztsize)
  elseif CC.BanBen == 4 then
    DrawString(1, 1, "\204\236\202\233\189\2173.0\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    local str = "MOD\215\247\213\223\163\186henvgui1987"
    DrawString(1, ztsize * 6, str, C_RED, ztsize)
  elseif CC.BanBen == 5 then
    DrawString(1, 1, "\178\212\193\2501028\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
    DrawString(1, ztsize * 8, "MOD\215\247\213\223\163\186\196\189\200\221\208\254\185\167", C_RED, ztsize)
  elseif CC.BanBen == 100 then
    DrawString(1, 1, "\189\240\211\185\203\174\228\176\180\171\214\174\207\181\205\179\212\246\199\191\176\230", C_RED, ztsize)
  end
  DrawString(1, ztsize, "\212\246\199\191+\210\198\214\178: " .. "s" .. "z" .. "l" .. "z" .. "w", C_RED, ztsize)
  DrawString(1, ztsize * 2, "2015.11.01 patch for SDL2", C_RED, ztsize)
  DrawString(1, ztsize * 3, "\213\228\178\216\176\230", C_RED, ztsize)
  if CC.BanBen == 1 and CC.ZCOPEN == 1 then
    DrawString(1, ztsize * 4, "\215\212\180\180\206\228\185\166\198\170\161\250\191\170\198\244", C_RED, ztsize)
  end
  if CC.BanBen == 1 and CC.JS == 1 then
    DrawString(1, ztsize * 5, "\204\216\202\226\189\199\201\171\198\170\161\250\191\170\198\244", C_RED, ztsize)
  end
end

function MSG()
  if CC.ShowXY == 1 then
    local size = CC.DefaultFont
    local dtsize = CC.DefaultFont
    if JY.Status == GAME_MMAP then
      local sx = {}
      local sy = {}
      local mcstr = {}
      local mapsx = {}
      local mapsy = {}
      local mapmcstr = {}
      local mapcx, mapcy
      if JY.MiniMap == 1 and JY.JZKG == 1 then
        if CONFIG.Operation == 0 then
          lib.Background(0, 0, CC.ScreenW, CC.ScreenH, 224)
        else
          lib.Background(0, 0, CC.ScreenW, CC.ScreenH, 224)
        end
        mapcx = CC.ScreenW / 2 - CC.DefaultFont * 0.2
        mapcy = CC.ScreenH / 2 - CC.DefaultFont * 0.2
        DrawString(mapcx, mapcy, "\161\226", C_ORANGE, CC.DefaultFont * 0.3)
      end
      if JY.JZKG == 1 then
        for i = 0, JY.SceneNum - 1 do
          if (JY.Scene[i]["\189\248\200\235\204\245\188\254"] == 0 or JY.Scene[i]["\189\248\200\235\204\245\188\254"] == 2) and JY.Scene[i]["\205\226\190\176\200\235\191\218X1"] ~= 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"] ~= 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218X2"] ~= 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218Y2"] ~= 0 then
            sx[i] = JY.Scene[i]["\205\226\190\176\200\235\191\218X1"]
            sy[i] = JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"]
            mcstr[i] = JY.Scene[i]["\195\251\179\198"]
            if not (math.abs(sx[i] - JY.Base.人X) <= 30 and 30 >= math.abs(sy[i] - JY.Base.人Y)) or CONFIG.Operation == 1 and JY.MiniMap == 1 and JY.Status == GAME_MMAP then
            elseif JY.MoveZTime + 3000 >= lib.GetTime() then
              YYZhi(sx[i], sy[i], mcstr[i], 0, 0, 50, C_ORANGE, dtsize)
            elseif JY.MoveZTime + 3000 < lib.GetTime() and JY.MoveZTime + 6000 >= lib.GetTime() then
              YYZhi(sx[i], sy[i], mcstr[i], 0, 0, 50, C_GOLD, dtsize)
            else
              YYZhi(sx[i], sy[i], mcstr[i], 0, 0, 50, C_GOLD, dtsize)
              JY.MoveZTime = lib.GetTime()
            end
            if JY.MiniMap == 1 then
              mapsx[i] = JY.Scene[i]["\205\226\190\176\200\235\191\218X1"]
              mapsy[i] = JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"]
              mapmcstr[i] = JY.Scene[i]["\195\251\179\198"], 1, 2
              local mmsx = {}
              local mmsy = {}
              if math.abs(mapsx[i] - JY.Base.人X) <= 200 and math.abs(mapsy[i] - JY.Base.人Y) <= 200 then
                local jl = 3
                mmsx[i] = mapcx + (mapsx[i] - JY.Base.人X) * jl - (mapsy[i] - JY.Base.人Y) * jl
                mmsy[i] = mapcy + (mapsx[i] - JY.Base.人X) * jl + (mapsy[i] - JY.Base.人Y) * jl
                local strlen = #mapmcstr[i]
                local mapsize = CC.DefaultFont * 0.6
                local zhix = mmsx[i] - mapsize * strlen / 4
                local zhiy = mmsy[i] - mapsize * 0.4
                DrawString(zhix, zhiy, mapmcstr[i], RGB(120, 208, 88), mapsize)
                DrawString(mmsx[i], mmsy[i], "\161\241", C_RED, CC.DefaultFont * 0.2)
              end
            end
          end
        end
      end
    elseif JY.Status == GAME_SMAP then
      if JY.DHBZ == 0 then
        if JY.JZKG == 1 then
          local x1 = 0
          local y1 = 0
          if 0 < JY.Scene[JY.SubScene]["\179\246\191\218X2"] and 0 < JY.Scene[JY.SubScene]["\179\246\191\218Y2"] then
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X2"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y2"]
          elseif 0 < JY.Scene[JY.SubScene]["\179\246\191\218X1"] and 0 < JY.Scene[JY.SubScene]["\179\246\191\218Y1"] then
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X1"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y1"]
          else
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X3"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y3"]
          end
          local str1 = "\192\235\191\170" .. JY.Scene[JY.SubScene]["\195\251\179\198"]
          YYZhi(x1, y1, str1, 0, 0, 50, C_ORANGE, size)
          local x2 = 0
          local y2 = 0
          if 0 < JY.Scene[JY.SubScene]["\204\248\215\170\191\218X1"] and 0 < JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y1"] then
            x2 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218X1"]
            y2 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y1"]
            local tzcj = JY.Scene[JY.SubScene]["\204\248\215\170\179\161\190\176"]
            if JY.Scene[tzcj] ~= nil then
              local str2 = "\189\248\200\235" .. JY.Scene[tzcj]["\195\251\179\198"]
              YYZhi(x2, y2, str2, 0, 0, 50, C_ORANGE, size)
            end
          end
        end
        if JY.TXKG == 1 then
          if CC.BanBen == 0 then
            if JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
              YYZhi(19, 18, "\201\249\205\251\179\172\185\253200\188\199\181\195\187\216\188\210\163\161", nil, nil, nil, C_WHITE, size)
            end
          elseif CC.BanBen == 1 then
            if JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
              YYZhi(7, 21, "\206\229\193\189\210\248\215\211\187\185\206\210\195\187\163\191", nil, nil, nil, C_WHITE, size)
              YYZhi(8, 27, "\185\171\215\211\163\172\196\227\187\216\192\180\192\178\163\161", nil, nil, nil, C_WHITE, size)
              local yxndstr
              if JY.YXND == 0 then
                yxndstr = "\183\231\198\189\192\203\190\178"
              elseif JY.YXND == 1 then
                yxndstr = "\183\231\198\240\212\198\211\191"
              elseif JY.YXND == 2 then
                yxndstr = "\190\170\204\206\186\167\192\203"
              end
              if CC.ZCOPEN == 1 then
                YYZhi(18, 35, "\193\183\185\166\179\161", nil, nil, nil, C_ORANGE, size)
                YYZhi(18, 26, "\204\244\213\189\204\168", nil, nil, nil, C_ORANGE, size)
              end
            end
          elseif CC.BanBen == 2 and JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
            YYZhi(30, 42, "\193\182\181\164\194\175", nil, nil, nil, C_ORANGE, size)
            YYZhi(39, 41, "\180\242\204\250\194\175", nil, nil, nil, C_ORANGE)
          end
          if JY.DHSJ + 5000 < lib.GetTime() then
            JY.DHSJ = lib.GetTime() + 5000
          elseif JY.DHSJ < lib.GetTime() then
            JY.DHSJ = lib.GetTime() + 5000
            JY.DHBZ = 1
          end
        end
      elseif JY.DHBZ == 1 then
        if JY.JZKG == 1 then
          local x1 = 0
          local y1 = 0
          if 0 < JY.Scene[JY.SubScene]["\179\246\191\218X2"] and 0 < JY.Scene[JY.SubScene]["\179\246\191\218Y2"] then
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X2"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y2"]
          elseif 0 < JY.Scene[JY.SubScene]["\179\246\191\218X1"] and 0 < JY.Scene[JY.SubScene]["\179\246\191\218Y1"] then
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X1"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y1"]
          else
            x1 = JY.Scene[JY.SubScene]["\179\246\191\218X3"]
            y1 = JY.Scene[JY.SubScene]["\179\246\191\218Y3"]
          end
          local str1 = "\192\235\191\170" .. JY.Scene[JY.SubScene]["\195\251\179\198"]
          YYZhi(x1, y1, str1, 0, 0, 50, C_GOLD, size)
          local x2 = 0
          local y2 = 0
          if 0 < JY.Scene[JY.SubScene]["\204\248\215\170\191\218X1"] and 0 < JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y1"] then
            x2 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218X1"]
            y2 = JY.Scene[JY.SubScene]["\204\248\215\170\191\218Y1"]
            local tzcj = JY.Scene[JY.SubScene]["\204\248\215\170\179\161\190\176"]
            if JY.Scene[tzcj] ~= nil then
              local str2 = "\189\248\200\235" .. JY.Scene[tzcj]["\195\251\179\198"]
              YYZhi(x2, y2, str2, 0, 0, 50, C_GOLD, size)
            end
          end
        end
        if JY.TXKG == 1 then
          if CC.BanBen == 0 then
            if JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
              YYZhi(19, 18, "\201\249\205\251\179\172\185\253200\188\199\181\195\187\216\188\210\163\161", nil, nil, nil, C_WHITE, size)
            end
          elseif CC.BanBen == 1 then
            if JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
              if instruct_16(37) then
                instruct_3(-2, 7, -2, -2, 0, 0, 0, -2, -2, -2, -2, -2, -2)
                instruct_3(-2, 8, -2, -2, 0, 0, 0, -2, -2, -2, -2, -2, -2)
              end
              YYZhi(7, 21, "zzZ...zzZ...", nil, nil, nil, C_WHITE, size)
              YYZhi(8, 27, "\185\171\215\211\163\172\210\170\208\221\207\162\194\240\163\191", nil, nil, nil, C_WHITE, size)
              local yxndstr
              if JY.YXND == 0 then
                yxndstr = "\183\231\198\189\192\203\190\178"
              elseif JY.YXND == 1 then
                yxndstr = "\183\231\198\240\212\198\211\191"
              elseif JY.YXND == 2 then
                yxndstr = "\190\170\204\206\186\167\192\203"
              end
              if CC.ZCOPEN == 1 then
                YYZhi(18, 35, "\193\183\185\166\179\161", nil, nil, nil, C_ORANGE, size)
                YYZhi(18, 26, "\204\244\213\189\204\168", nil, nil, nil, C_ORANGE, size)
              end
            end
          elseif CC.BanBen == 2 and JY.Scene[JY.SubScene]["\180\250\186\197"] == 70 then
            YYZhi(30, 42, "\193\182\181\164\194\175", nil, nil, nil, C_ORANGE, size)
            YYZhi(39, 41, "\180\242\204\250\194\175", nil, nil, nil, C_ORANGE)
          end
          if JY.DHSJ + 5000 < lib.GetTime() then
            JY.DHSJ = lib.GetTime() + 5000
          elseif JY.DHSJ < lib.GetTime() then
            JY.DHSJ = lib.GetTime() + 5000
            JY.DHBZ = 0
          end
        end
      end
      local jj = 0
      if 2 > CC.BanBen then
        for i = 0, 80 do
          if 0 >= GetD(JY.SubScene, i, 9) or 0 >= GetD(JY.SubScene, i, 10) then
            break
          end
          if 0 < GetD(JY.SubScene, i, 2) or 0 < GetD(JY.SubScene, i, 3) or 0 < GetD(JY.SubScene, i, 4) then
            local dnum = {}
            local dtrue = false
            if RWPD(GetD(JY.SubScene, i, 2)) then
              YYZhi(GetD(JY.SubScene, i, 9), GetD(JY.SubScene, i, 10), "\161\239", nil, nil, nil, C_RED, size)
              dnum[jj] = {
                GetD(JY.SubScene, i, 2),
                GetD(JY.SubScene, i, 9),
                GetD(JY.SubScene, i, 10)
              }
              dtrue = true
            elseif RWPD(GetD(JY.SubScene, i, 3)) then
              YYZhi(GetD(JY.SubScene, i, 9), GetD(JY.SubScene, i, 10), "\161\239", nil, nil, nil, C_RED, size)
              dnum[jj] = {
                GetD(JY.SubScene, i, 3),
                GetD(JY.SubScene, i, 9),
                GetD(JY.SubScene, i, 10)
              }
              dtrue = true
            elseif RWPD(GetD(JY.SubScene, i, 4)) then
              YYZhi(GetD(JY.SubScene, i, 9), GetD(JY.SubScene, i, 10), "\161\239", nil, nil, nil, C_RED, size)
              dnum[jj] = {
                GetD(JY.SubScene, i, 4),
                GetD(JY.SubScene, i, 9),
                GetD(JY.SubScene, i, 10)
              }
              dtrue = true
            end
            if dtrue then
              local mapcx = CC.ScreenW / 2 - CC.DefaultFont * 0.2
              local mapcy = CC.ScreenH / 2 - CC.DefaultFont * 0.2
              local smsx = {}
              local smsy = {}
              local jl = 5
              local renx = JY.Base.人X1
              local reny = JY.Base.人Y1
              if renx < 7 then
                renx = 7
              elseif 50 < renx then
                renx = 50
              end
              if reny < 7 then
                reny = 7
              elseif 50 < reny then
                reny = 50
              end
              smsx[jj] = mapcx + (dnum[jj][2] - renx) * jl - (dnum[jj][3] - reny) * jl
              smsy[jj] = mapcy + (dnum[jj][2] - renx) * jl + (dnum[jj][3] - reny) * jl
              local strlen = string.len("\161\239")
              local mapsize = CC.DefaultFont * 0.8
              local zhix = smsx[jj] - mapsize * strlen / 4
              local zhiy = smsy[jj] - mapsize * 0.5
              DrawString(smsx[jj], smsy[jj], "\161\239", RGB(120, 208, 88), CC.DefaultFont * 0.4)
              jj = jj + 1
            end
          end
        end
      end
    end
    if JY.TXKG == 1 then
      if JY.ZLX == nil then
        JY.ZLX = JY.Base.人X
        JY.ZLY = JY.Base.人Y
      end
      if JY.ZLBZ == 0 or JY.ZLQH == 1 then
        if JY.Status == GAME_MMAP then
          JY.ZLX = JY.Base.人X
          JY.ZLY = JY.Base.人Y
          JY.ZLT = lib.GetTime() + 120000
          JY.ZLBZ = 1
        else
          JY.ZLX = JY.Base.人X1
          JY.ZLY = JY.Base.人Y1
          JY.ZLT = lib.GetTime() + 120000
          JY.ZLBZ = 1
        end
        JY.ZLQH = 0
      end
      if JY.Status == GAME_MMAP then
        if JY.ZLBZ == 1 and JY.ZLT < lib.GetTime() and JY.ZLX == JY.Base.人X and JY.ZLY == JY.Base.人Y then
          YYZhi(JY.Base.人X, JY.Base.人Y, "\213\190\186\220\190\195\192\178\163\161\191\201\210\212\200\195\206\210\182\175\210\187\182\175\194\240\163\191", nil, nil, nil, C_RED, size)
          JY.ZLSHBZ = 1
        elseif JY.ZLT < lib.GetTime() and (JY.ZLX ~= JY.Base.人X or JY.ZLY ~= JY.Base.人Y) then
          if JY.ZLBZ1 == 0 then
            JY.ZLT1 = lib.GetTime() + 5000
            JY.ZLBZ1 = 1
          end
          if JY.ZLBZ1 == 1 and JY.ZLT1 > lib.GetTime() and JY.ZLSHBZ == 1 then
            YYZhi(JY.Base.人X, JY.Base.人Y, "\215\220\203\227\196\220\182\175\193\203\163\172\192\219\190\205\208\221\207\162\210\187\207\194\176\201\163\161", nil, nil, nil, C_WHITE, size)
          else
            JY.ZLBZ1 = 0
            JY.ZLBZ = 0
            JY.ZLSHBZ = 0
          end
        end
      elseif JY.ZLBZ == 1 and JY.ZLT < lib.GetTime() and JY.ZLX == JY.Base.人X1 and JY.ZLY == JY.Base.人Y1 then
        YYZhi(JY.Base.人X1, JY.Base.人Y1, "\213\190\186\220\190\195\192\178\163\161\191\201\210\212\200\195\206\210\182\175\210\187\182\175\194\240\163\191", nil, nil, nil, C_RED, size)
        JY.ZLSHBZ = 1
      elseif JY.ZLT < lib.GetTime() and (JY.ZLX ~= JY.Base.人X1 or JY.ZLY ~= JY.Base.人Y1) then
        if JY.ZLBZ1 == 0 then
          JY.ZLT1 = lib.GetTime() + 5000
          JY.ZLBZ1 = 1
        end
        if JY.ZLBZ1 == 1 and JY.ZLT1 > lib.GetTime() and JY.ZLSHBZ == 1 then
          YYZhi(JY.Base.人X1, JY.Base.人Y1, "\215\220\203\227\196\220\182\175\193\203\163\172\192\219\190\205\208\221\207\162\210\187\207\194\176\201\163\161", nil, nil, nil, C_WHITE, size)
        else
          JY.ZLBZ1 = 0
          JY.ZLBZ = 0
          JY.ZLSHBZ = 0
        end
      end
    end
    SCMSG()
    if CONFIG.Operation ~= 1 or JY.MiniMap ~= 1 or JY.Status == GAME_MMAP then
    else
    end
  end
  if JY.ZBJKSJ < lib.GetTime() then
    JY.ZBJK = 1
    JY.ZBJKSJ = lib.GetTime() + 60000
  end
  if JY.ZBJK == 1 then
    local id = 0
    local clevel = JY.Person[id]["\181\200\188\182"]
    if CC.BanBen == 1 then
      if JY.Person[id]["\185\165\187\247\193\166"] > 200 + clevel * 30 or JY.Person[id]["\185\165\187\247\193\166"] > 600 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\183\192\211\249\193\166"] > 200 + clevel * 30 or 600 < JY.Person[id]["\183\192\211\249\193\166"] then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\199\225\185\166"] > 200 + clevel * 30 or 600 < JY.Person[id]["\199\225\185\166"] then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\200\173\213\198\185\166\183\242"] > 150 + clevel * 20 or JY.Person[id]["\200\173\213\198\185\166\183\242"] > 500 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\211\249\189\163\196\220\193\166"] > 150 + clevel * 20 or 500 < JY.Person[id]["\211\249\189\163\196\220\193\166"] then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\203\163\181\182\188\188\199\201"] > 150 + clevel * 20 or 500 < JY.Person[id]["\203\163\181\182\188\188\199\201"] then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\204\216\202\226\177\248\198\247"] > 150 + clevel * 20 or 500 < JY.Person[id]["\204\216\202\226\177\248\198\247"] then
        JY.ZUOBI = 1
      end
    elseif CC.BanBen == 0 then
      if JY.Person[id]["\185\165\187\247\193\166"] > 50 + clevel * 10 or JY.Person[id]["\185\165\187\247\193\166"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\183\192\211\249\193\166"] > 50 + clevel * 10 or JY.Person[id]["\183\192\211\249\193\166"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\199\225\185\166"] > 50 + clevel * 10 or JY.Person[id]["\199\225\185\166"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\200\173\213\198\185\166\183\242"] > 50 + clevel * 10 or JY.Person[id]["\200\173\213\198\185\166\183\242"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\211\249\189\163\196\220\193\166"] > 50 + clevel * 10 or JY.Person[id]["\211\249\189\163\196\220\193\166"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\203\163\181\182\188\188\199\201"] > 50 + clevel * 10 or JY.Person[id]["\203\163\181\182\188\188\199\201"] > 100 then
        JY.ZUOBI = 1
      end
      if JY.Person[id]["\204\216\202\226\177\248\198\247"] > 50 + clevel * 10 or JY.Person[id]["\204\216\202\226\177\248\198\247"] > 100 then
        JY.ZUOBI = 1
      end
    end
    JY.ZBJK = 0
  end
end

function SCMSG()
  if JY.SCKG == 1 or JY.MENUMSG == 1 then
    local menuxadd = 0
    local menuyadd = 0
    if JY.MENUMSG == 1 then
      menuxadd = CC.MainSubMenuX
      menuyadd = CC.MainSubMenuY
    end
    local i
    local id = {}
    local idnum
    for i = 0, CC.MyThingNum - 1 do
      id[i] = JY.Base["\206\239\198\183" .. i + 1]
      if id[i] == CC.MoneyID then
        idnum = JY.Base["\206\239\198\183\202\253\193\191" .. i + 1]
        if 30000 < idnum then
          JY.Base["\206\239\198\183\202\253\193\191" .. i + 1] = 30000
        end
        i = CC.MyThingNum
      end
    end
    local zcbl = 0
    if CC.ZCOPEN == 1 then
      zcbl = 1
    end
    local fontsize = CC.DefaultFont * 0.8
    DrawBox(menuxadd + 0, menuyadd + 0, menuxadd + fontsize * 12.2, menuyadd + fontsize * (4 + zcbl) * 1.1, C_WHITE)
    DrawString(menuxadd + 0, menuyadd + 0, string.format("%s", JY.Person[0].姓名), C_GOLD, fontsize)
    DrawString(menuxadd + fontsize * 4, menuyadd + 0, string.format("   %-2d\188\182", JY.Person[0]["\181\200\188\182"]), C_GOLD, fontsize)
    if JY.Person[0].生命 < JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"] then
      DrawString(menuxadd + fontsize * 7, menuyadd + 0, string.format(" %4d/%4d", JY.Person[0].生命, JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"]), RGB(255, 192, 203), fontsize)
    else
      DrawString(menuxadd + fontsize * 7, menuyadd + 0, string.format(" %4d/%4d", JY.Person[0].生命, JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"]), C_GOLD, fontsize)
    end
    if 0 < JY.Person[0]["\202\220\201\203\179\204\182\200"] then
      DrawString(menuxadd + 0, menuyadd + fontsize * 1.1, string.format("\196\218\201\203 %3d", JY.Person[0]["\202\220\201\203\179\204\182\200"]), RGB(255, 192, 203), fontsize)
    else
      DrawString(menuxadd + 0, menuyadd + fontsize * 1.1, string.format("\196\218\201\203 %3d", JY.Person[0]["\202\220\201\203\179\204\182\200"]), C_GOLD, fontsize)
    end
    if 0 < JY.Person[0]["\214\208\182\190\179\204\182\200"] then
      DrawString(menuxadd + CC.DefaultFont * 4.3, menuyadd + fontsize * 1.1, string.format("\214\208\182\190 %3d", JY.Person[0]["\214\208\182\190\179\204\182\200"]), RGB(120, 208, 88), fontsize)
    else
      DrawString(menuxadd + CC.DefaultFont * 4.3, menuyadd + fontsize * 1.1, string.format("\214\208\182\190 %3d", JY.Person[0]["\214\208\182\190\179\204\182\200"]), C_GOLD, fontsize)
    end
    if CC.BanBen == 0 then
      DrawString(menuxadd + 0, menuyadd + fontsize * 2.2, string.format("\198\183\181\194 %3s   \201\249\205\251 %3s", JY.Person[0]["\198\183\181\194"], JY.Person[0].声望), C_GOLD, fontsize)
    elseif CC.BanBen == 1 then
      local ndstr
      if JY.YXND == 0 then
        ndstr = "\183\231\198\189\192\203\190\178"
      elseif JY.YXND == 1 then
        ndstr = "\183\231\198\240\212\198\211\191"
      elseif JY.YXND == 2 then
        ndstr = "\190\170\204\206\186\167\192\203"
      end
      DrawString(menuxadd + 0, menuyadd + fontsize * 2.2, string.format("\198\183\181\194 %3s   ", JY.Person[0]["\198\183\181\194"]) .. ndstr, C_GOLD, CC.DefaultFont * 0.8)
    elseif CC.BanBen == 2 then
      DrawString(menuxadd + 0, menuyadd + fontsize * 2.2, string.format("\198\183\181\194 %3s   \206\228\179\163 %3s", JY.Person[0]["\198\183\181\194"], JY.Person[0]["\206\228\209\167\179\163\202\182"]), C_GOLD, CC.DefaultFont * 0.8)
    else
      DrawString(menuxadd + 0, menuyadd + fontsize * 2.2, string.format("\198\183\181\194 %3s   \201\249\205\251 %3s", JY.Person[0]["\198\183\181\194"], JY.Person[0].声望), C_GOLD, CC.DefaultFont * 0.8)
    end
    if idnum ~= nil then
      DrawString(menuxadd + 0, menuyadd + fontsize * 3.3, string.format("%s%5d", JY.Thing[CC.MoneyID]["\195\251\179\198"], idnum), C_GOLD, CC.DefaultFont * 0.8)
    end
    DrawString(menuxadd + CC.DefaultFont * 4.3, menuyadd + fontsize * 3.3, string.format("%s", os.date("%X", os.time())), C_GOLD, CC.DefaultFont * 0.8)
    DrawBox(menuxadd + 0, menuyadd + fontsize * (4 + zcbl) * 1.1, menuxadd + fontsize * 12.2, menuyadd + fontsize * (4 + zcbl + 1.1) * 1.1, C_WHITE)
    if JY.Status == GAME_MMAP then
      DrawString(menuxadd + 0, menuyadd + fontsize * (4 + zcbl + 0.1) * 1.1, string.format("\180\243\181\216\205\188\163\168%d,%d\163\169", JY.Base.人X, JY.Base.人Y), C_GOLD, CC.DefaultFont * 0.8)
    elseif JY.Status == GAME_SMAP then
      DrawString(menuxadd + 0, menuyadd + fontsize * (4 + zcbl + 0.1) * 1.1, string.format("%s\163\168%d,%d\163\169", JY.Scene[JY.SubScene]["\195\251\179\198"], JY.Base.人X1, JY.Base.人Y1), C_GOLD, fontsize)
    end
    DrawString(menuxadd + CC.DefaultFont * 6.8, menuyadd + fontsize * (4 + zcbl + 0.1) * 1.1, string.format("\204\236\202\233 %2d", JY.Book), C_GOLD, CC.DefaultFont * 0.8)
    if CC.ZCOPEN == 1 then
      if 0 < JY.ZCWGCS then
        local zcstr
        if JY.ZCWGCS == 1 then
          zcstr = "\210\187"
        elseif JY.ZCWGCS == 2 then
          zcstr = "\182\254"
        elseif JY.ZCWGCS == 3 then
          zcstr = "\200\253"
        elseif JY.ZCWGCS == 4 then
          zcstr = "\203\196"
        elseif JY.ZCWGCS == 5 then
          zcstr = "\206\229"
        end
        DrawString(menuxadd + 0, menuyadd + fontsize * 4.4, "\215\212\180\180\206\228\185\166   \181\218" .. zcstr .. "\214\216", C_GOLD, CC.DefaultFont * 0.8)
      else
        DrawString(menuxadd + 0, menuyadd + fontsize * 4.4, "\215\212\180\180\206\228\185\166   \206\222", C_GOLD, CC.DefaultFont * 0.8)
      end
    end
    if CC.JS == 1 and string.len(JY.Person[0].外号) == 4 then
      local str1 = string.sub(JY.Person[0].外号, 1, 2)
      local str2 = string.sub(JY.Person[0].外号, 3, 4)
      DrawString(menuxadd + CC.DefaultFont * 8, menuyadd + fontsize * 2.2, str1, C_ORANGE, CC.DefaultFont * 0.8)
      DrawString(menuxadd + CC.DefaultFont * 8, menuyadd + fontsize * 3.3, str2, C_ORANGE, CC.DefaultFont * 0.8)
    end
  end
end

function Split(szFullString, szSeparator)
  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
    if not nFindLastIndex then
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
      break
    else
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
      nFindStartIndex = nFindLastIndex + string.len(szSeparator)
      nSplitIndex = nSplitIndex + 1
    end
  end
  return nSplitIndex, nSplitArray
end

function copyfile(source, destination)
  local sourcefile = io.open(source, "r")
  local destinationfile = io.open(destination, "w")
  for line in sourcefile:lines() do
    destinationfile:write(line .. "\n")
  end
  sourcefile:close()
  destinationfile:close()
end

function SeachItem()
  local picid = 600
  instruct_0()
  if instruct_18(234) then
    say("\196\227\202\214\192\239\187\185\211\208\189\233\201\220\208\197\163\172\184\207\189\244\207\200\200\165\200\235\195\197", picid, 1, "\191\170\190\214\214\250\202\214")
  else
    local title = "\202\199\183\241\203\209\185\206\188\245\181\192\181\194\181\196\207\228\215\211"
    local str = "\202\199\163\186\203\209\185\206\214\174\186\243\181\192\181\194\188\245\203\196*\183\241\163\186\178\187\203\209\185\206\188\245\181\192\181\194\207\228\215\211*\183\197\198\250\163\186\178\187\202\185\211\195\215\212\182\175\203\209\185\206\185\166\196\220"
    local btn = {
      "\202\199",
      "\183\241",
      "\183\197\198\250"
    }
    local num = #btn
    local r = JYMsgBox(title, str, btn, num)
    if r == 3 then
      return
    end
    if 0 < GetD(0, 1, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(0, 2, 2) then
      instruct_32(0, 10)
      instruct_0()
      instruct_3(0, 2, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(0, 3, 2) then
      instruct_32(3, 10)
      instruct_0()
      instruct_3(0, 3, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(0, 5, 2) then
      instruct_32(19, 1)
      instruct_0()
      instruct_3(0, 5, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(9, 8, 2) then
      instruct_3(9, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(9, 5, 2) then
      instruct_3(9, 5, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
    end
    if 0 < GetD(9, 7, 2) then
      instruct_32(0, 10)
      instruct_0()
      instruct_3(9, 7, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(9, 6, 2) then
      instruct_32(3, 10)
      instruct_0()
      instruct_3(9, 6, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
    end
    if 0 < GetD(18, 4, 2) then
      instruct_3(18, 4, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(107, 1)
      instruct_0()
    end
    if 0 < GetD(20, 15, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(20, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(21, 13, 2) then
      instruct_3(21, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(21, 12, 2) then
      instruct_3(21, 12, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(213, 1)
      instruct_0()
    end
    if 0 < GetD(22, 1, 2) then
      instruct_3(22, 1, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
      instruct_32(174, 200)
      instruct_0()
    end
    if 0 < GetD(22, 2, 2) then
      instruct_3(22, 2, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(176, 1)
      instruct_0()
    end
    if 0 < GetD(22, 3, 2) then
      instruct_3(22, 3, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
      instruct_32(10, 5)
      instruct_0()
    end
    if 0 < GetD(22, 4, 2) then
      instruct_3(22, 4, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(6, 1)
      instruct_0()
    end
    if 0 < GetD(22, 6, 2) then
      instruct_3(22, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(22, 0, 2) then
      instruct_3(22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_0()
      instruct_32(201, 1)
      instruct_0()
    end
    if 0 < GetD(23, 2, 2) then
      instruct_3(23, 2, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(23, 3, 2) then
      instruct_3(23, 3, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(23, 4, 2) then
      instruct_3(23, 4, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(23, 5, 2) then
      instruct_3(23, 5, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(23, 9, 2) then
      instruct_3(23, 9, 1, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
      instruct_0()
      instruct_32(18, 2)
      instruct_0()
    end
    if 0 < GetD(24, 10, 2) then
      instruct_32(0, 10)
      instruct_0()
      instruct_3(24, 10, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(24, 13, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(24, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(28, 84, 2) then
      instruct_3(28, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(28, 18, 2) and r == 1 then
      instruct_3(28, 18, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(210, 15)
      instruct_0()
      instruct_37(-1)
    end
    if 0 < GetD(30, 1, 2) then
      instruct_3(30, 1, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(7, 3)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
    end
    if 0 < GetD(30, 2, 2) then
      instruct_3(30, 2, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(9, 10)
      instruct_0()
      instruct_32(10, 5)
      instruct_0()
    end
    if 0 < GetD(30, 3, 2) then
      instruct_3(30, 3, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(3, 10)
      instruct_0()
      instruct_32(4, 5)
      instruct_0()
    end
    if 0 < GetD(30, 4, 2) then
      instruct_3(30, 4, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(1, 5)
      instruct_0()
    end
    if 0 < GetD(30, 5, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(30, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(32, 4, 2) then
      instruct_3(32, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(33, 28, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(33, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(35, 11, 2) then
      instruct_3(35, 11, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(210, 10)
      instruct_0()
      instruct_32(10, 5)
      instruct_0()
    end
    if 0 < GetD(36, 6, 2) and r == 1 then
      instruct_3(36, 6, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(174, 200)
      instruct_0()
      instruct_32(1, 2)
      instruct_0()
      instruct_37(-1)
    end
    if 0 < GetD(37, 9, 2) then
      instruct_32(3, 10)
      instruct_0()
      instruct_3(37, 9, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
    end
    if 0 < GetD(37, 11, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(37, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(38, 8, 2) then
      instruct_3(38, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_0()
      instruct_32(15, 1)
      instruct_0()
    end
    if 0 < GetD(40, 32, 2) then
      instruct_3(40, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(43, 34, 2) then
      instruct_3(43, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(43, 14, 2) and r == 1 then
      instruct_3(43, 14, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(8, 2)
      instruct_0()
      instruct_37(-1)
    end
    if 0 < GetD(44, 3, 2) then
      instruct_3(44, 3, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
      instruct_32(174, 200)
      instruct_0()
    end
    if 0 < GetD(44, 4, 2) then
      instruct_3(44, 4, 0, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(2, 2)
      instruct_0()
    end
    if 0 < GetD(44, 5, 2) then
      instruct_3(44, 5, 0, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(6, 2)
      instruct_0()
    end
    if 0 < GetD(44, 6, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(44, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(46, 8, 2) then
      instruct_3(46, 8, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
      instruct_32(174, 200)
      instruct_0()
    end
    if 0 < GetD(46, 2, 2) then
      instruct_3(46, 2, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(30, 10)
      instruct_0()
    end
    if 0 < GetD(49, 3, 2) then
      instruct_3(49, 3, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(1, 3)
      instruct_0()
      instruct_32(2, 1)
      instruct_0()
      instruct_32(3, 10)
      instruct_0()
      instruct_32(4, 3)
      instruct_0()
      instruct_32(5, 2)
      instruct_0()
      instruct_32(6, 1)
      instruct_0()
      instruct_32(10, 3)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
    end
    if 0 < GetD(49, 4, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(49, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(50, 2, 2) then
      instruct_3(50, 2, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(209, 20)
      instruct_0()
    end
    if 0 < GetD(50, 3, 2) then
      instruct_3(50, 3, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(1, 3)
      instruct_0()
      instruct_32(4, 3)
      instruct_0()
    end
    if 0 < GetD(50, 4, 2) then
      instruct_3(50, 4, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
      instruct_0()
      instruct_32(8, 1)
      instruct_0()
      instruct_32(0, 5)
      instruct_0()
    end
    if 0 < GetD(50, 9, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(50, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(54, 1, 2) then
      instruct_3(54, 1, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(1, 3)
      instruct_0()
      instruct_32(2, 1)
      instruct_0()
      instruct_32(3, 10)
      instruct_0()
      instruct_32(4, 3)
      instruct_0()
      instruct_32(5, 2)
      instruct_0()
      instruct_32(6, 1)
      instruct_0()
      instruct_32(10, 3)
      instruct_0()
      instruct_32(209, 50)
      instruct_0()
    end
    if 0 < GetD(54, 33, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(54, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(54, 34, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(54, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(56, 4, 2) then
      instruct_3(56, 4, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(174, 200)
      instruct_0()
      instruct_32(0, 3)
      instruct_0()
    end
    if 0 < GetD(59, 31, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(59, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(59, 32, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(59, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(60, 11, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(60, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(64, 1, 2) then
      instruct_3(64, 1, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(174, 100)
      instruct_0()
      instruct_32(28, 10)
      instruct_0()
    end
    if 0 < GetD(64, 3, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(64, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(65, 4, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(65, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(68, 30, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(68, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(73, 8, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(73, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(73, 3, 2) then
      instruct_3(73, 3, 1, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
      instruct_0()
      instruct_32(0, 5)
      instruct_0()
      instruct_32(9, 3)
      instruct_0()
    end
    if 0 < GetD(75, 44, 2) then
      instruct_3(75, 44, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(220, 1)
      instruct_0()
    end
    if 0 < GetD(76, 3, 2) then
      instruct_3(76, 3, -2, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(3, 3)
      instruct_0()
    end
    if 0 < GetD(76, 4, 2) and r == 1 then
      instruct_3(76, 4, -2, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(28, 10)
      instruct_0()
      instruct_32(174, 500)
      instruct_0()
      instruct_37(-1)
      instruct_0()
    end
    if 0 < GetD(76, 6, 2) then
      instruct_3(76, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      instruct_32(210, 10)
      instruct_0()
    end
    if 0 < GetD(78, 1, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(78, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(78, 2, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(78, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(92, 17, 2) then
      instruct_3(92, 17, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(194, 1)
      instruct_0()
    end
    if 0 < GetD(94, 12, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(94, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(94, 13, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(94, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(95, 15, 2) then
      instruct_3(95, 15, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(17, 1)
      instruct_0()
      instruct_32(209, 100)
      instruct_0()
    end
    if 0 < GetD(96, 14, 2) then
      instruct_32(210, 10)
      instruct_0()
      instruct_3(96, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    if 0 < GetD(97, 1, 2) then
      instruct_3(97, 1, 1, 0, 0, 0, 0, 3500, 3500, 3500, -2, -2, -2)
      instruct_0()
      instruct_32(141, 1)
      instruct_0()
    end
    if 0 < GetD(98, 9, 2) then
      instruct_3(98, 9, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(196, 1)
      instruct_0()
    end
    if 0 < GetD(98, 10, 2) then
      instruct_3(98, 10, -2, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
      instruct_0()
      instruct_32(0, 10)
      instruct_0()
      instruct_32(3, 3)
      instruct_0()
    end
    if 0 < GetD(98, 11, 2) then
      instruct_3(98, 11, 0, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
      instruct_0()
      instruct_32(14, 2)
      instruct_0()
    end
    if 0 < GetD(102, 10, 2) then
      instruct_32(0, 10)
      instruct_0()
      instruct_3(102, 10, 0, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
    end
    if 0 < GetD(103, 10, 2) then
      instruct_3(103, 10, 1, 0, 0, 0, 0, 6698, 6698, 6698, -2, -2, -2)
      instruct_0()
      instruct_32(212, 1)
      instruct_0()
    end
    say("\215\163\196\227\186\195\212\203\163\161", picid, 1, "\191\170\190\214\214\250\202\214")
    instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  end
end

function JYMsgBox(title, str, button, num, headid, isEsc)
  local strArray = {}
  local xnum, ynum, width, height
  local picw, pich = 0, 0
  local x1, x2, y1, y2
  local size = CC.DefaultFont
  local xarr = {}
  
  local function between(x)
    for i = 1, num do
      if x > xarr[i] and x < xarr[i] + string.len(button[i]) * size / 2 then
        return i
      end
    end
    return 0
  end
  
  if headid ~= nil then
    headid = headid * 2
    picw, pich = lib.GetPNGXY(1, headid)
    picw = picw + CC.MenuBorderPixel * 2
    pich = pich + CC.MenuBorderPixel * 2
  end
  ynum, strArray = Split(str, "*")
  xnum = 0
  for i = 1, ynum do
    local len = string.len(strArray[i])
    if xnum < len then
      xnum = len
    end
  end
  if xnum < 12 then
    xnum = 12
  end
  width = CC.MenuBorderPixel * 2 + math.modf(size * xnum / 2) + picw
  height = CC.MenuBorderPixel * 2 + (size + CC.MenuBorderPixel) * ynum
  if pich > height then
    height = pich
  end
  y2 = height
  height = height + CC.MenuBorderPixel * 2 + size * 2
  x1 = (CC.ScreenW - width) / 2 + CC.MenuBorderPixel
  x2 = x1 + picw
  y1 = (CC.ScreenH - height) / 2 + CC.MenuBorderPixel + 2 + size * 0.7
  y2 = y2 + y1 - 5
  local select = 1
  Cls()
  DrawBoxTitle(width, height, title, C_GOLD)
  if headid ~= nil then
    lib.LoadPNG(1, headid, x1, y1, 1)
  end
  for i = 1, ynum do
    DrawString(x2, y1 + (CC.MenuBorderPixel + size) * (i - 1), strArray[i], C_WHITE, size)
  end
  local surid = lib.SaveSur((CC.ScreenW - width) / 2 - 4, (CC.ScreenH - height) / 2 - size, (CC.ScreenW + width) / 2 + 4, (CC.ScreenH + height) / 2 + 4)
  while true do
    Cls()
    lib.LoadSur(surid, (CC.ScreenW - width) / 2 - 4, (CC.ScreenH - height) / 2 - size)
    for i = 1, num do
      local color, bjcolor
      if i == select then
        color = M_Yellow
        bjcolor = M_DarkOliveGreen
      else
        color = M_DarkOliveGreen
      end
      xarr[i] = (CC.ScreenW - width) / 2 + width * i / (num + 1) - string.len(button[i]) * size / 4
      DrawStrBox2(xarr[i], y2, button[i], color, size, bjcolor)
    end
    ShowScreen()
    local key, ktype, mx, my = WaitKey(1)
    if key == VK_ESCAPE or ktype == 4 then
      if isEsc ~= nil and isEsc == 1 then
        select = -2
        break
      end
    elseif key == VK_LEFT or ktype == 6 then
      select = select - 1
      if select < 1 then
        select = num
      end
    elseif key == VK_RIGHT or ktype == 7 then
      select = select + 1
      if num < select then
        select = 1
      end
    else
      if key == VK_RETURN or key == VK_SPACE or ktype == 5 then
        break
      end
      if (ktype == 2 or ktype == 3) and x1 <= mx and mx <= x1 + width and y2 <= my and my <= y2 + 2 * CC.MenuBorderPixel + size then
        select = between(mx)
        if 0 < select and num >= select and ktype == 3 then
          break
        end
      end
    end
  end
  select = limitX(select, -2, num)
  lib.FreeSur(surid)
  Cls()
  return select
end

function DrawBoxTitle(width, height, str, color)
  local s = 4
  local x1, y1, x2, y2, tx1, tx2
  local fontsize = s + CC.DefaultFont
  local len = string.len(str) * fontsize / 2
  x1 = (CC.ScreenW - width) / 2
  x2 = (CC.ScreenW + width) / 2
  y1 = (CC.ScreenH - height) / 2
  y2 = (CC.ScreenH + height) / 2
  tx1 = (CC.ScreenW - len) / 2
  tx2 = (CC.ScreenW + len) / 2
  lib.Background(x1, y1 + s, x1 + s, y2 - s, 128)
  lib.Background(x1 + s, y1, x2 - s, y2, 128)
  lib.Background(x2 - s, y1 + s, x2, y2 - s, 128)
  lib.Background(tx1, y1 - fontsize / 2 + s, tx2, y1, 128)
  lib.Background(tx1 + s, y1 - fontsize / 2, tx2 - s, y1 - fontsize / 2 + s, 128)
  local r, g, b = GetRGB(color)
  DrawBoxTitle_sub(x1 + 1, y1 + 1, x2, y2, tx1 + 1, y1 - fontsize / 2 + 1, tx2, y1 + fontsize / 2, RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
  DrawBoxTitle_sub(x1, y1, x2 - 1, y2 - 1, tx1, y1 - fontsize / 2, tx2 - 1, y1 + fontsize / 2 - 1, color)
  DrawString(tx1 + 2 * s, y1 - (fontsize - s) / 2, str, color, CC.DefaultFont)
end

function DrawBoxTitle_sub(x1, y1, x2, y2, tx1, ty1, tx2, ty2, color)
  local s = 4
  lib.DrawRect(x1 + s, y1, tx1, y1, color)
  lib.DrawRect(tx2, y1, x2 - s, y1, color)
  lib.DrawRect(x2 - s, y1, x2 - s, y1 + s, color)
  lib.DrawRect(x2 - s, y1 + s, x2, y1 + s, color)
  lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
  lib.DrawRect(x2, y2 - s, x2 - s, y2 - s, color)
  lib.DrawRect(x2 - s, y2 - s, x2 - s, y2, color)
  lib.DrawRect(x2 - s, y2, x1 + s, y2, color)
  lib.DrawRect(x1 + s, y2, x1 + s, y2 - s, color)
  lib.DrawRect(x1 + s, y2 - s, x1, y2 - s, color)
  lib.DrawRect(x1, y2 - s, x1, y1 + s, color)
  lib.DrawRect(x1, y1 + s, x1 + s, y1 + s, color)
  lib.DrawRect(x1 + s, y1 + s, x1 + s, y1, color)
  DrawBox_1(tx1, ty1, tx2, ty2, color)
end

function DrawStrBox2(x, y, str, color, size, bjcolor)
  local strarray = {}
  local num, maxlen
  maxlen = 0
  num, strarray = Split(str, "*")
  for i = 1, num do
    local len = string.len(strarray[i])
    if maxlen < len then
      maxlen = len
    end
  end
  local w = size * maxlen / 2 + 2 * CC.MenuBorderPixel
  local h = 2 * CC.MenuBorderPixel + size * num
  if x == -1 then
    x = (CC.ScreenW - size / 2 * maxlen - 2 * CC.MenuBorderPixel) / 2
  end
  if y == -1 then
    y = (CC.ScreenH - size * num - 2 * CC.MenuBorderPixel) / 2
  end
  DrawBox2(x, y, x + w - 1, y + h - 1, C_WHITE, bjcolor)
  for i = 1, num do
    DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel + size * (i - 1), strarray[i], color, size)
  end
end

function DrawBox2(x1, y1, x2, y2, color, bjcolor)
  local s = 4
  bjcolor = bjcolor or 0
  if 0 <= bjcolor then
    lib.Background(x1, y1 + s, x1 + s, y2 - s, 128, bjcolor)
    lib.Background(x1 + s, y1, x2 - s, y2, 128, bjcolor)
    lib.Background(x2 - s, y1 + s, x2, y2 - s, 128, bjcolor)
  end
  if 0 <= color then
    local r, g, b = GetRGB(color)
    DrawBox_2(x1 + 1, y1, x2, y2, RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
    DrawBox_2(x1, y1, x2 - 1, y2 - 1, color)
  end
end

function DrawBox_2(x1, y1, x2, y2, color)
  local s = 4
  lib.DrawRect(x1 + s, y1, x2 - s, y1, color)
  lib.DrawRect(x2 - s, y1, x2 - s, y1 + s, color)
  lib.DrawRect(x2 - s, y1 + s, x2, y1 + s, color)
  lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
  lib.DrawRect(x2, y2 - s, x2 - s, y2 - s, color)
  lib.DrawRect(x2 - s, y2 - s, x2 - s, y2, color)
  lib.DrawRect(x2 - s, y2, x1 + s, y2, color)
  lib.DrawRect(x1 + s, y2, x1 + s, y2 - s, color)
  lib.DrawRect(x1 + s, y2 - s, x1, y2 - s, color)
  lib.DrawRect(x1, y2 - s, x1, y1 + s, color)
  lib.DrawRect(x1, y1 + s, x1 + s, y1 + s, color)
  lib.DrawRect(x1 + s, y1 + s, x1 + s, y1, color)
end

function say(s, pid, flag, name)
  local picw = 130
  local pich = 130
  local talkxnum = 18
  local talkynum = 3
  local dx = 2
  local dy = 2
  local boxpicw = picw + 10
  local boxpich = pich + 10
  local boxtalkw = talkxnum * CC.DefaultFont + 10
  local boxtalkh = boxpich - 27
  local headid = pid
  pid = pid or 0
  if (headid == 0 or headid == nil) and (name == nil or name == JY.Person[0].姓名) then
    headid = 280 + GetS(4, 5, 5, 5)
  end
  if flag == nil then
    if pid == 0 then
      flag = 1
    else
      flag = 0
    end
  end
  name = name or JY.Person[pid].姓名
  local talkBorder = (pich - talkynum * CC.DefaultFont) / (talkynum + 1)
  local xy = {
    [0] = {
      headx = dx,
      heady = dy,
      talkx = dx + boxpicw + 2,
      talky = dy + 27,
      namex = dx + boxpicw + 2,
      namey = dy,
      showhead = 1
    },
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = CC.ScreenH - dy - boxpich,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = CC.ScreenH - dy - boxpich + 27,
      namex = CC.ScreenW - 1 - dx - boxpicw - 96,
      namey = CC.ScreenH - dy - boxpich,
      showhead = 1
    },
    {
      headx = dx,
      heady = dy,
      talkx = dx + boxpicw - 43,
      talky = dy + 27,
      namex = dx + boxpicw + 2,
      namey = dy,
      showhead = 0
    },
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = CC.ScreenH - dy - boxpich,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = CC.ScreenH - dy - boxpich + 27,
      namex = CC.ScreenW - 1 - dx - boxpicw - 96,
      namey = CC.ScreenH - dy - boxpich,
      showhead = 1
    },
    {
      headx = CC.ScreenW - 1 - dx - boxpicw,
      heady = dy,
      talkx = CC.ScreenW - 1 - dx - boxpicw - boxtalkw - 2,
      talky = dy + 27,
      namex = CC.ScreenW - 1 - dx - boxpicw - 96,
      namey = dy,
      showhead = 1
    },
    {
      headx = dx,
      heady = CC.ScreenH - dy - boxpich,
      talkx = dx + boxpicw + 2,
      talky = CC.ScreenH - dy - boxpich + 27,
      namex = dx + boxpicw + 2,
      namey = CC.ScreenH - dy - boxpich,
      showhead = 1
    }
  }
  if flag < 0 or 5 < flag then
    flag = 0
  end
  if xy[flag].showhead == 0 then
    headid = -1
  end
  if CONFIG.KeyRepeat == 0 then
    lib.EnableKeyRepeat(0, CONFIG.KeyRepeatInterval)
  end
  
  local function readstr(str)
    local T1 = {
      "\163\176",
      "\163\177",
      "\163\178",
      "\163\179",
      "\163\180",
      "\163\181",
      "\163\182",
      "\163\183",
      "\163\184",
      "\163\185"
    }
    local T2 = {
      {
        "\163\210",
        C_RED
      },
      {
        "\163\199",
        C_GOLD
      },
      {
        "\163\194",
        C_BLACK
      },
      {
        "\163\215",
        C_WHITE
      },
      {
        "\163\207",
        C_ORANGE
      }
    }
    local T3 = {
      {
        "\163\200",
        CC.FontNameSong
      },
      {
        "\163\211",
        CC.FontNameHei
      },
      {
        "\163\198",
        CC.FontName
      }
    }
    for i = 0, 9 do
      if T1[i + 1] == str then
        return 1, i * 50
      end
    end
    for i = 1, 5 do
      if T2[i][1] == str then
        return 2, T2[i][2]
      end
    end
    for i = 1, 3 do
      if T3[i][1] == str then
        return 3, T3[i][2]
      end
    end
    return 0
  end
  
  local function mydelay(t)
    if t <= 0 then
      return
    end
    lib.ShowSurface(0)
    lib.Delay(t)
  end
  
  local page, cy, cx = 0, 0, 0
  local color, t, font = C_WHITE, 0, CC.FontName
  while 1 <= string.len(s) do
    if page == 0 then
      Cls()
      if 0 <= headid then
        DrawBox(xy[flag].headx, xy[flag].heady, xy[flag].headx + boxpicw, xy[flag].heady + boxpich, C_WHITE)
        DrawBox(xy[flag].namex, xy[flag].namey, xy[flag].namex + 96, xy[flag].namey + 24, C_WHITE)
        MyDrawString(xy[flag].namex, xy[flag].namex + 96, xy[flag].namey + 1, name, C_ORANGE, 21)
        local w, h = lib.GetPNGXY(1, headid * 2)
        local x = (picw - w) / 2
        local y = (pich - h) / 2
        lib.LoadPNG(1, headid * 2, xy[flag].headx + 5 + x, xy[flag].heady + 5 + y, 1)
      end
      DrawBox(xy[flag].talkx, xy[flag].talky, xy[flag].talkx + boxtalkw, xy[flag].talky + boxtalkh, C_WHITE)
      page = 1
    end
    local str
    str = string.sub(s, 1, 1)
    if str == "*" then
      str = "\163\200"
      s = string.sub(s, 2, -1)
    elseif string.byte(s, 1, 1) > 127 then
      str = string.sub(s, 1, 2)
      s = string.sub(s, 3, -1)
    else
      str = string.sub(s, 1, 1)
      s = string.sub(s, 2, -1)
    end
    if str == "\163\200" then
      cx = 0
      cy = cy + 1
      if cy == 3 then
        cy = 0
        page = 0
      end
    elseif str == "\163\208" then
      cx = 0
      cy = 0
      page = 0
    elseif str == "\163\240" then
      ShowScreen()
      WaitKey()
      lib.Delay(100)
    elseif str == "\163\206" then
      s = JY.Person[pid].姓名 .. s
    elseif str == "\163\238" then
      s = JY.Person[0].姓名 .. s
    else
      local kz1, kz2 = readstr(str)
      if kz1 == 1 then
        t = kz2
      elseif kz1 == 2 then
        color = kz2
      elseif kz1 == 3 then
        font = kz2
      else
        lib.DrawStr(xy[flag].talkx + CC.DefaultFont * cx + 5, xy[flag].talky + (CC.DefaultFont + talkBorder) * cy + talkBorder - 8, str, color, CC.DefaultFont, font, 0, 0, 255)
        mydelay(t)
        cx = cx + string.len(str) / 2
        if cx == talkxnum then
          cx = 0
          cy = cy + 1
          if cy == talkynum then
            cy = 0
            page = 0
          end
        end
      end
    end
    if page == 0 or 1 > string.len(s) then
      ShowScreen()
      WaitKey()
      lib.Delay(100)
    end
  end
  if CONFIG.KeyRepeat == 0 then
    lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRepeatInterval)
  end
  Cls()
end

function MyDrawString(x1, x2, y, str, color, size)
  local len = math.modf(string.len(str) * size / 4)
  local x = math.modf((x1 + x2) / 2) - len
  DrawString(x, y, str, color, size)
end

function JubenBugFix()
  local j = 1
  for i = 0, 10000 do
    if JY.Thing[i] == nil then
      JY.AQNUM = j - 1
      break
    elseif JY.Thing[i].类型 == 4 then
      JY.AQ[j] = i
      j = j + 1
    end
  end
  if CC.BanBen == 0 then
    JY.Scene[5]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[7]["\195\251\179\198"] = "\201\241\181\241\201\189\182\180"
    JY.Scene[10]["\195\251\179\198"] = "\214\169\214\235\201\189\182\180"
    JY.Scene[41]["\195\251\179\198"] = "\176\215\185\199\201\189\182\180"
    JY.Scene[65]["\195\251\179\198"] = "\204\198\202\171\201\189\182\180"
    JY.Scene[66]["\195\251\179\198"] = "\177\249\178\207\201\189\182\180"
    JY.Scene[67]["\195\251\179\198"] = "\192\165\194\216\201\189\182\180"
    JY.Scene[79]["\195\251\179\198"] = "\212\167\209\236\201\189\182\180"
  elseif CC.BanBen == 1 then
    JY.YXND = JY.Wugong[30]["\206\180\214\1703"]
    JY.Thing[88]["\195\251\179\198"] = "\208\235\195\214\201\189\201\241\213\198"
    JY.Thing[88]["\195\251\179\1982"] = "\208\235\195\214\201\189\201\241\213\198"
    JY.Thing[89]["\195\251\179\198"] = "\198\223\201\203\200\173\198\215"
    JY.Thing[89]["\195\251\179\1982"] = "\198\223\201\203\200\173\198\215"
    JY.Thing[110]["\195\251\179\1982"] = "\206\229\182\190\195\216\180\171"
    JY.Thing[178]["\195\251\179\198"] = "\180\243\188\244\181\182\181\182\183\168"
    JY.Thing[181]["\195\251\179\1982"] = "\198\229\197\204\213\208\202\189"
    JY.Thing[196]["\206\239\198\183\203\181\195\247"] = "\180\243\209\224\180\171\185\250\211\241\231\244"
    JY.Thing[197]["\206\239\198\183\203\181\195\247"] = "\180\243\209\224\187\202\181\219\202\192\207\174\205\188\177\237"
    JY.Thing[212]["\195\251\179\1982"] = "\185\227\193\234\201\162\199\217\199\250"
    for i = 311, 319 do
      JY.Person[i]["\205\183\207\241\180\250\186\197"] = 214
    end
    JY.Thing[139]["\208\232\203\163\181\182\188\188\199\201"] = 30
    JY.Thing[139]["\208\232\190\173\209\233"] = 35
    JY.Wugong[63]["\207\251\186\196\196\218\193\166\181\227\202\253"] = 5
    local wggjl = {
      30,
      60,
      90,
      120,
      150,
      190,
      230,
      260,
      300,
      350
    }
    local wgfw = {
      1,
      2,
      3,
      4,
      5,
      5,
      5,
      5,
      5,
      6
    }
    for i = 1, 10 do
      JY.Wugong[63]["\185\165\187\247\193\166" .. i] = wggjl[i]
      JY.Wugong[63]["\210\198\182\175\183\182\206\167" .. i] = wgfw[i]
    end
    if 0 < JY.Person[29]["\208\175\180\248\206\239\198\1831"] then
      JY.Person[29]["\208\175\180\248\206\239\198\183\202\253\193\1911"] = 1
    end
    JY.Person[114]["\206\228\209\167\179\163\202\182"] = 100
    JY.Person[114]["\185\165\187\247\193\166"] = 350
    JY.Person[114]["\183\192\211\249\193\166"] = 350
    JY.Person[141]["\185\165\187\247\193\166"] = 50
    JY.Person[141]["\199\225\185\166"] = 30
    if JY.YXND == 1 then
      JY.Person[114]["\206\228\209\167\179\163\202\182"] = 100
      JY.Person[114]["\185\165\187\247\193\166"] = 400
      JY.Person[114]["\183\192\211\249\193\166"] = 400
    elseif JY.YXND == 2 then
      JY.Person[114]["\206\228\209\167\179\163\202\182"] = 100
      JY.Person[114]["\185\165\187\247\193\166"] = 400
      JY.Person[114]["\183\192\211\249\193\166"] = 400
    end
    JY.Person[90].外号 = "\182\190\245\245\197\174"
    if GetD(84, 8, 2) == 18 then
      SetD(84, 8, 2, 0)
      SetD(84, 8, 3, 18)
    end
    JY.Thing[227]["\206\239\198\183\203\181\195\247"] = "\163\16844\163\17233\163\169"
    JY.Scene[5]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[7]["\195\251\179\198"] = "\201\241\181\241\201\189\182\180"
    JY.Scene[10]["\195\251\179\198"] = "\214\169\214\235\201\189\182\180"
    JY.Scene[41]["\195\251\179\198"] = "\176\215\185\199\201\189\182\180"
    JY.Scene[65]["\195\251\179\198"] = "\204\198\202\171\201\189\182\180"
    JY.Scene[79]["\195\251\179\198"] = "\212\167\209\236\201\189\182\180"
    JY.Scene[84]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[85]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Thing[235]["\189\246\208\222\193\182\200\203\206\239"] = -1
    if instruct_18(219) and instruct_18(147) then
      instruct_3(28, 12, -2, -2, -2, 303, -2, -2, -2, -2, -2, -2, -2)
    end
    instruct_3(1, 2, -2, -2, -2, -2, -2, 5404, 5404, 5404, -2, -2, -2)
    instruct_3(102, 13, -2, -2, -2, -2, -2, -2, -2, -2, -2, 20, 25)
    instruct_3(0, 0, -2, -2, 0, 0, 0, -2, -2, -2, -2, -2, -2)
    JY.Thing[190]["\208\232\178\196\193\207"] = 209
    ZCKG()
    if instruct_18(74) == false and CC.ZCOPEN == 1 then
      instruct_3(13, 6, -2, -2, 0, 0, 1090, -2, -2, -2, -2, 18, 28)
      instruct_3(13, 7, -2, -2, 0, 0, 1090, -2, -2, -2, -2, 18, 29)
      instruct_3(13, 4, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
      instruct_3(13, 3, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
      instruct_3(13, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
    end
    JY.Selpstr = {}
    if CC.JS == 1 then
      if JY.Person[0].姓名 ~= "szlzw" then
        if JY.Person[0].外号 == "\200\173\176\212" and JY.Wugong[30]["\206\180\214\1701"] == 1 then
          JY.Selpstr[1] = {"\200\173\213\198\185\166\183\242", 1}
          JY.Selpstr[2] = {"\185\165\187\247\193\166", -1}
          JY.Selpstr[3] = {"\183\192\211\249\193\166", 2}
          JY.Selpstr[4] = {"\199\225\185\166", 2}
          DrawStrBoxWaitKey("\200\173\176\212\161\250\198\198\183\192\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\189\163\196\167" and JY.Wugong[30]["\206\180\214\1701"] == 2 then
          JY.Selpstr[1] = {"\211\249\189\163\196\220\193\166", 1}
          JY.Selpstr[2] = {"\185\165\187\247\193\166", 2}
          JY.Selpstr[3] = {"\183\192\211\249\193\166", -2}
          DrawStrBoxWaitKey("\189\163\196\167\161\250\202\200\209\170\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\181\182\179\213" and JY.Wugong[30]["\206\180\214\1701"] == 3 then
          JY.Selpstr[1] = {"\203\163\181\182\188\188\199\201", 1}
          JY.Selpstr[2] = {"\185\165\187\247\193\166", -1}
          JY.Selpstr[3] = {"\183\192\211\249\193\166", 2}
          JY.Selpstr[4] = {"\199\225\185\166", 2}
          DrawStrBoxWaitKey("\181\182\179\213\161\250\210\187\187\247\177\216\201\177\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\204\216\191\241" and JY.Wugong[30]["\206\180\214\1701"] == 4 then
          JY.Selpstr[1] = {"\204\216\202\226\177\248\198\247", 1}
          JY.Selpstr[2] = {"\183\192\211\249\193\166", 4}
          JY.Selpstr[3] = {"\199\225\185\166", -2}
          DrawStrBoxWaitKey("\204\216\191\241\161\250\177\169\187\247\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\201\241\214\250" and JY.Wugong[30]["\206\180\214\1701"] == 5 then
          local lev = JY.Person[0]["\181\200\188\182"]
          JY.Selpstr[1] = {"\185\165\187\247\193\166", 3}
          JY.Selpstr[2] = {"\183\192\211\249\193\166", -2}
          JY.Selpstr[3] = {"\199\225\185\166", -2}
          JY.Selpstr[4] = {"\196\218\193\166\215\238\180\243\214\181", 50}
          DrawStrBoxWaitKey("\201\241\214\250\161\250\204\236\201\241\187\164\204\229\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\206\215\209\253" and JY.Wugong[30]["\206\180\214\1701"] == 6 then
          JY.Selpstr[1] = {"\210\189\193\198\196\220\193\166", 3}
          JY.Selpstr[2] = {"\211\195\182\190\196\220\193\166", 1}
          JY.Selpstr[3] = {"\191\185\182\190\196\220\193\166", 2}
          JY.Selpstr[4] = {"\185\165\187\247\193\166", -1}
          JY.Selpstr[5] = {"\199\225\185\166", 2}
          DrawStrBoxWaitKey("\206\215\209\253\161\250\214\216\201\250\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\182\190\205\245" and JY.Wugong[30]["\206\180\214\1701"] == 7 then
          JY.Selpstr[1] = {"\211\195\182\190\196\220\193\166", 3}
          JY.Selpstr[2] = {"\191\185\182\190\196\220\193\166", 3}
          JY.Selpstr[3] = {"\185\165\187\247\193\166", -1}
          JY.Selpstr[4] = {"\183\192\211\249\193\166", 2}
          DrawStrBoxWaitKey("\182\190\205\245\161\250\180\227\182\190\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 == "\187\195\211\176" and JY.Wugong[30]["\206\180\214\1701"] == 9 then
          JY.Selpstr[1] = {"\185\165\187\247\193\166", -1}
          JY.Selpstr[2] = {"\183\192\211\249\193\166", 2}
          JY.Selpstr[3] = {"\199\225\185\166", 2}
          DrawStrBoxWaitKey("\187\195\211\176\161\250\211\176\201\177\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
        else
          DrawStrBoxWaitKey("\204\216\202\226\189\199\201\171\161\250\191\170\198\244\202\167\176\220", C_RED, CC.DefaultFont)
          CC.JS = 0
        end
      elseif JY.Person[0].姓名 == "szlzw" and JY.Wugong[30]["\206\180\214\1701"] == 8 then
        if 0 < JY.YXND then
          if JY.YXND == 0 then
            DrawStrBoxWaitKey("\177\228\201\237\208\205\204\172\161\250\191\170\198\244", C_WHITE, CC.DefaultFont)
          elseif JY.YXND == 1 and JY.Person[0]["\181\200\188\182"] > 9 then
            DrawStrBoxWaitKey("\177\228\201\237\208\205\204\172\161\250\191\170\198\244", C_WHITE, CC.DefaultFont)
          elseif JY.YXND == 2 and JY.Person[0]["\181\200\188\182"] > 19 then
            DrawStrBoxWaitKey("\177\228\201\237\208\205\204\172\161\250\191\170\198\244", C_WHITE, CC.DefaultFont)
          end
        end
        if JY.Wugong[30]["\206\180\214\1702"] == 1 then
          JY.Person[0].外号 = "\200\173\176\212"
          DrawStrBoxWaitKey("\177\228\201\237\200\173\176\212\161\250\198\198\183\192\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 2 then
          JY.Person[0].外号 = "\189\163\196\167"
          DrawStrBoxWaitKey("\177\228\201\237\189\163\196\167\161\250\202\200\209\170\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 3 then
          JY.Person[0].外号 = "\181\182\179\213"
          DrawStrBoxWaitKey("\177\228\201\237\181\182\179\213\161\250\210\187\187\247\177\216\201\177\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 4 then
          JY.Person[0].外号 = "\204\216\191\241"
          DrawStrBoxWaitKey("\177\228\201\237\204\216\191\241\161\250\177\169\187\247\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 5 then
          JY.Person[0].外号 = "\201\241\214\250"
          DrawStrBoxWaitKey("\177\228\201\237\201\241\214\250\161\250\204\236\201\241\187\164\204\229\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 6 then
          JY.Person[0].外号 = "\206\215\209\253"
          DrawStrBoxWaitKey("\177\228\201\237\206\215\209\253\161\250\214\216\201\250\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 7 then
          JY.Person[0].外号 = "\182\190\205\245"
          DrawStrBoxWaitKey("\177\228\201\237\182\190\205\245\161\250\180\227\182\190\201\203\186\166\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Wugong[30]["\206\180\214\1702"] == 9 then
          JY.Person[0].外号 = "\187\195\211\176"
          DrawStrBoxWaitKey("\177\228\201\237\187\195\211\176\161\250\211\176\201\177\188\188\196\220\191\170\198\244", C_WHITE, CC.DefaultFont)
        elseif JY.Person[0].外号 ~= "\179\172\201\241" then
          DrawStrBoxWaitKey("\204\216\202\226\189\199\201\171\161\250\191\170\198\244\202\167\176\220", C_RED, CC.DefaultFont)
          CC.JS = 0
        end
      end
    end
  elseif CC.BanBen == 2 then
    JY.Scene[80]["\205\226\190\176\200\235\191\218X1"] = 247
    JY.Scene[80]["\205\226\190\176\200\235\191\218Y1"] = 234
    JY.Scene[80]["\205\226\190\176\200\235\191\218X2"] = 247
    JY.Scene[80]["\205\226\190\176\200\235\191\218Y2"] = 234
    JY.Scene[3]["\205\226\190\176\200\235\191\218X1"] = 78
    JY.Scene[3]["\205\226\190\176\200\235\191\218Y1"] = 138
    JY.Scene[3]["\205\226\190\176\200\235\191\218X2"] = 78
    JY.Scene[3]["\205\226\190\176\200\235\191\218Y2"] = 138
    instruct_3(69, 9, -2, -2, -2, -2, -2, 5106, 5116, 5106, -2, -2, -2)
    if instruct_18(236) == false then
      instruct_3(22, 8, -2, -2, 1215, -2, -2, -2, -2, -2, -2, -2, -2)
    else
      instruct_3(22, 8, -2, -2, 0, -2, -2, -2, -2, -2, -2, -2, -2)
    end
    JY.Thing[197].类型 = 2
    JY.Thing[37].类型 = 4
    JY.Thing[33]["\188\211\183\192\211\249\193\166"] = 2
    if instruct_18(46) == false then
      JY.Person[2]["\208\175\180\248\206\239\198\1831"] = 46
      JY.Person[2]["\208\175\180\248\206\239\198\183\202\253\193\1911"] = 1
    end
    JY.Thing[28]["\208\232\210\170\206\239\198\183\202\253\193\1911"] = 1
    JY.Thing[28]["\193\183\179\246\206\239\198\183\208\232\190\173\209\233"] = 1
    JY.Thing[49]["\193\183\179\246\206\239\198\183\208\232\190\173\209\233"] = 10
    if GetD(79, 2, 4) == 0 and JY.Wugong[1]["\185\165\187\247\193\16610"] == 1 then
      SetD(79, 2, 4, 1145)
      for i = 1, 10 do
        if JY.Person[0]["\206\228\185\166" .. i] == 1 then
          for j = i, 9 do
            JY.Person[0]["\206\228\185\166" .. j] = JY.Person[0]["\206\228\185\166" .. j + 1]
            JY.Person[0]["\206\228\185\166\181\200\188\182" .. j] = JY.Person[0]["\206\228\185\166\181\200\188\182" .. j + 1]
          end
        end
      end
    end
    if GetD(79, 2, 4) == 1145 and CONFIG.ZCWG ~= nil then
      JY.Wugong[1]["\195\251\179\198"] = CONFIG.ZCWG
    end
    JY.Wugong[1]["\195\251\179\198"] = CONFIG.ZCWG
  elseif CC.BanBen == 3 then
    JY.Scene[86]["\205\226\190\176\200\235\191\218X1"] = 349
    JY.Scene[86]["\205\226\190\176\200\235\191\218Y1"] = 339
    JY.Scene[86]["\205\226\190\176\200\235\191\218X2"] = 349
    JY.Scene[86]["\205\226\190\176\200\235\191\218Y2"] = 339
    JY.Scene[87]["\205\226\190\176\200\235\191\218X1"] = 270
    JY.Scene[87]["\205\226\190\176\200\235\191\218Y1"] = 426
    JY.Scene[87]["\205\226\190\176\200\235\191\218X2"] = 270
    JY.Scene[87]["\205\226\190\176\200\235\191\218Y2"] = 426
    JY.Scene[89]["\205\226\190\176\200\235\191\218X1"] = 57
    JY.Scene[89]["\205\226\190\176\200\235\191\218Y1"] = 224
    JY.Scene[89]["\205\226\190\176\200\235\191\218X2"] = 57
    JY.Scene[89]["\205\226\190\176\200\235\191\218Y2"] = 224
  elseif CC.BanBen == 4 then
    JY.Scene[127]["\205\226\190\176\200\235\191\218X1"] = 330
    JY.Scene[127]["\205\226\190\176\200\235\191\218Y1"] = 196
    JY.Scene[127]["\205\226\190\176\200\235\191\218X2"] = 330
    JY.Scene[127]["\205\226\190\176\200\235\191\218Y2"] = 196
    JY.Scene[120]["\205\226\190\176\200\235\191\218X1"] = 349
    JY.Scene[120]["\205\226\190\176\200\235\191\218Y1"] = 295
    JY.Scene[120]["\205\226\190\176\200\235\191\218X2"] = 349
    JY.Scene[120]["\205\226\190\176\200\235\191\218Y2"] = 295
    JY.Scene[108]["\205\226\190\176\200\235\191\218X1"] = 67
    JY.Scene[108]["\205\226\190\176\200\235\191\218Y1"] = 89
    JY.Scene[108]["\205\226\190\176\200\235\191\218X2"] = 67
    JY.Scene[108]["\205\226\190\176\200\235\191\218Y2"] = 89
    JY.Scene[123]["\179\246\191\218X1"] = 22
    JY.Scene[123]["\179\246\191\218Y1"] = 62
    JY.Scene[123]["\179\246\191\218X2"] = 23
    JY.Scene[123]["\179\246\191\218Y2"] = 62
    JY.Scene[128]["\205\226\190\176\200\235\191\218X1"] = 0
    JY.Scene[128]["\205\226\190\176\200\235\191\218Y1"] = 0
    JY.Scene[128]["\205\226\190\176\200\235\191\218X2"] = 0
    JY.Scene[128]["\205\226\190\176\200\235\191\218Y2"] = 0
    JY.Scene[128]["\179\246\191\218X1"] = 0
    JY.Scene[128]["\179\246\191\218Y1"] = 0
    JY.Scene[128]["\179\246\191\218X2"] = 0
    JY.Scene[128]["\179\246\191\218Y2"] = 0
    JY.Scene[128]["\179\246\191\218X3"] = 0
    JY.Scene[128]["\179\246\191\218Y3"] = 0
    JY.Scene[128]["\204\248\215\170\191\218X1"] = 62
    JY.Scene[128]["\204\248\215\170\191\218Y1"] = 61
    JY.Scene[128]["\204\248\215\170\191\218X2"] = 61
    JY.Scene[128]["\204\248\215\170\191\218Y2"] = 61
    JY.Scene[126]["\200\235\191\218X"] = 61
    JY.Scene[126]["\200\235\191\218Y"] = 31
    JY.Scene[126]["\179\246\191\218X1"] = 62
    JY.Scene[126]["\179\246\191\218Y1"] = 31
    JY.Scene[126]["\179\246\191\218X2"] = 62
    JY.Scene[126]["\179\246\191\218Y2"] = 31
    JY.Scene[46]["\205\226\190\176\200\235\191\218X1"] = 192
    JY.Scene[46]["\205\226\190\176\200\235\191\218Y1"] = 292
    JY.Scene[46]["\205\226\190\176\200\235\191\218X2"] = 192
    JY.Scene[46]["\205\226\190\176\200\235\191\218Y2"] = 292
  elseif CC.BanBen == 5 then
    JY.Thing[88]["\195\251\179\198"] = "\208\235\195\214\201\189\201\241\213\198"
    JY.Thing[88]["\195\251\179\1982"] = "\208\235\195\214\201\189\201\241\213\198"
    JY.Thing[89]["\195\251\179\198"] = "\198\223\201\203\200\173\198\215"
    JY.Thing[89]["\195\251\179\1982"] = "\198\223\201\203\200\173\198\215"
    JY.Thing[110]["\195\251\179\1982"] = "\206\229\182\190\195\216\180\171"
    JY.Thing[178]["\195\251\179\198"] = "\180\243\188\244\181\182\181\182\183\168"
    JY.Thing[181]["\195\251\179\1982"] = "\198\229\197\204\213\208\202\189"
    JY.Thing[196]["\206\239\198\183\203\181\195\247"] = "\180\243\209\224\180\171\185\250\211\241\231\244"
    JY.Thing[197]["\206\239\198\183\203\181\195\247"] = "\180\243\209\224\187\202\181\219\202\192\207\174\205\188\177\237"
    JY.Thing[212]["\195\251\179\1982"] = "\185\227\193\234\201\162\199\217\199\250"
    JY.Scene[5]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[7]["\195\251\179\198"] = "\201\241\181\241\201\189\182\180"
    JY.Scene[10]["\195\251\179\198"] = "\214\169\214\235\201\189\182\180"
    JY.Scene[41]["\195\251\179\198"] = "\176\215\185\199\201\189\182\180"
    JY.Scene[65]["\195\251\179\198"] = "\204\198\202\171\201\189\182\180"
    JY.Scene[79]["\195\251\179\198"] = "\212\167\209\236\201\189\182\180"
    JY.Scene[84]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[85]["\195\251\179\198"] = "\180\179\205\245\201\189\182\180"
    JY.Scene[85]["\205\226\190\176\200\235\191\218X1"] = 44
    JY.Scene[85]["\205\226\190\176\200\235\191\218Y1"] = 33
    JY.Scene[85]["\205\226\190\176\200\235\191\218X2"] = 44
    JY.Scene[85]["\205\226\190\176\200\235\191\218Y2"] = 33
    JY.Thing[227]["\206\239\198\183\203\181\195\247"] = "\163\16844\163\17233\163\169"
    if GetD(84, 8, 2) == 18 then
      SetD(84, 8, 2, 0)
      SetD(84, 8, 3, 18)
    end
  elseif CC.BanBen == 100 and JY.Person[0]["\190\173\209\233"] == 0 then
    JY.Person[35]["\185\165\187\247\193\166"] = 30
    JY.Person[35]["\199\225\185\166"] = 30
    JY.Person[35]["\183\192\211\249\193\166"] = 30
    JY.Person[100]["\185\165\187\247\193\166"] = 30
    JY.Person[100]["\199\225\185\166"] = 30
    JY.Person[100]["\183\192\211\249\193\166"] = 30
    JY.Person[104]["\185\165\187\247\193\166"] = 30
    JY.Person[104]["\199\225\185\166"] = 30
    JY.Person[104]["\183\192\211\249\193\166"] = 30
    JY.Person[105]["\185\165\187\247\193\166"] = 30
    JY.Person[105]["\199\225\185\166"] = 30
    JY.Person[105]["\183\192\211\249\193\166"] = 30
  end
  JY.ZBJKSJ = lib.GetTime() + 30000
  xzqbpd = 3
  zdyx = {}
  for i = 1, CC.TeamNum do
    zdyx[i] = {}
    zdyx[i][1] = 0
    zdyx[i][2] = -1
  end
  JY.WGXZWZ = {}
  if CONFIG.SaveTime ~= nil and 120 >= CONFIG.SaveTime and 0 < CONFIG.SaveTime then
    JY.SaveTime = CONFIG.SaveTime
  end
  JY.AtTime = lib.GetTime()
  JY.DiyTime = JY.AtTime + JY.SaveTime * 60000
  local fontsize = CC.NewGameFontSize
  DrawString(CC.ScreenW / 2 - fontsize * 6, CC.ScreenH - fontsize * 2, string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\206\170%d\183\214\214\211", JY.SaveTime), C_RED, CC.NewGameFontSize, 1)
  CC.RUNSTR[CC.NUMBER] = string.format("\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\202\177\188\228\201\232\182\168\206\170%d\183\214\214\211 \191\201\212\218\161\176\185\166\196\220\188\211\199\191\161\177->\161\176\180\230\181\181\201\232\182\168\161\177\192\239\184\252\184\196", JY.SaveTime)
  local booknum = 0
  for i = 1, CC.BookNum do
    if instruct_18(CC.BookStart + i - 1) == true then
      booknum = booknum + 1
    end
  end
  JY.Book = booknum
  if booknum == CC.BookNum then
    CC.ExpLevel = 3
    CC.RUNSTR[CC.NUMBER + 1] = "\204\236\202\233\210\209\202\213\188\175\205\234\179\201\163\172\181\177\199\176\190\173\209\233\214\181\210\209\180\243\183\249\182\200\212\246\188\211\163\172\193\183\185\166\191\241\178\187\200\221\180\237\185\253\163\161"
  else
    CC.RUNSTR[CC.NUMBER + 1] = string.format("\204\236\202\233\210\209\202\213\188\175%d\177\190\163\172\202\213\188\175\205\23414\177\190\204\236\202\233\190\173\209\233\214\181\189\171\180\243\183\249\182\200\212\246\188\211\163\172\193\183\185\166\191\241\178\187\200\221\180\237\185\253\163\161", booknum)
    CC.ExpLevel = 1
  end
  JY.SETPD = 1
  ShowScreen()
end

function ZCKG()
  if CC.ZCOPEN == 0 then
    instruct_3(70, 65, -2, -2, -1, -2, -2, -2, -2, -2, -2, -2, -2)
    instruct_3(70, 66, -2, -2, -1, -2, -2, -2, -2, -2, -2, -2, -2)
  else
    instruct_3(70, 65, -2, -2, 1089, -2, -2, -2, -2, -2, -2, -2, -2)
    if instruct_18(241) then
      instruct_3(70, 66, -2, -2, 1087, -2, -2, -2, -2, -2, -2, -2, -2)
    else
      instruct_3(70, 66, -2, -2, 1087, -2, -2, -2, -2, -2, -2, -2, -2)
    end
  end
  if CC.ZCOPEN == 1 or instruct_18(237) then
    for i = 1, 5 do
      if 0 < JY.Wugong[114 + i - 1]["\206\180\214\1701"] then
        JY.ZCWGCS = i
      else
        JY.ZCWGCS = i - 1
        break
      end
    end
    JY.Person[589]["\205\183\207\241\180\250\186\197"] = 30
    JY.Person[589]["\206\228\209\167\179\163\202\182"] = 0
    if 0 < JY.ZCWGCS then
      dugong()
    end
  end
end

function TSInstruce()
  local filemenu = {}
  local n = 0
  for i = 1, math.huge do
    if existFile(string.format("%s%d.txt", CONFIG.HelpPath, i)) then
      filemenu[i] = string.format("%s%d.txt", CONFIG.HelpPath, i)
      n = n + 1
    else
      break
    end
  end
  if existFile(CONFIG.CurrentPath .. "update.txt") then
    filemenu[n + 1] = CONFIG.CurrentPath .. "update.txt"
    n = n + 1
  end
  local menu = {}
  local maxlen = 0
  for i = 1, n do
    local file = io.open(filemenu[i], "r")
    local str = file:read("*l")
    if str == nil then
      str = " "
    end
    if maxlen < #str then
      maxlen = #str
    end
    str = string.gsub(str, "\r", "")
    menu[i] = {
      i .. str,
      nil,
      1
    }
    file:close()
  end
  local size = CC.DefaultFont
  local rr = 1
  while true do
    Cls()
    local r = ShowMenu2_new(menu, #menu, 3, 12, size, size, 0, 0, 1, 1, size, C_ORANGE, C_WHITE, nil, rr)
    if 0 < r then
      rr = r
      InstruceTS(r)
    else
      break
    end
  end
  Cls()
end

function TSGL(filename, id)
  Cls()
  local file = io.open(filename, "r")
  local str = {}
  local k = 1
  local ja
  local color = {}
  local ll = 0
  for line in file:lines() do
    str[k] = line
    if str[k] ~= nil then
      str[k] = string.gsub(str[k], "\r", "")
      local i1, j1 = string.find(str[k], "'%x+'", 1)
      if i1 ~= nil then
        local tsnum = tonumber(string.sub(str[k], i1 + 1, j1 - 1))
        if JY.GLTS[id - 1][tsnum] == 1 then
          color[k] = RGB(120, 208, 88)
          str[k] = string.gsub(str[k], "'%x+'", "\163\168\205\234\179\201\163\169", 1)
        else
          color[k] = C_WHITE
          str[k] = string.gsub(str[k], "'%x+'", "", 1)
        end
      end
      str[k] = GenTalkString(str[k], 25)
      k = k + 1
    end
  end
  file:close()
  local size = CC.DefaultFont
  local linenum = 50
  local maxlen = 15
  local w = linenum * size / 2 + size
  local h = maxlen * (size + CC.RowPixel) + 2 * CC.RowPixel
  local bx = (CC.ScreenW - w) / 2
  local by = (CC.ScreenH - h) / 2
  DrawBox(bx, by, bx + w, by + h, C_WHITE)
  for i = 1, k - 1 do
    local slen = string.len(str[i])
    local wz1, wz2 = string.find(str[i], "*")
    local swz1 = {}
    local swz2 = {}
    local s = {}
    for j = 1, 100 do
      if str[i] == nil then
        break
      end
      if swz1[j - 1] == nil then
        swz1[j - 1] = 0
      end
      swz1[j] = string.find(str[i], "*", j + swz1[j - 1])
      if swz1[j] ~= nil then
        s[j] = string.sub(str[i], 1 + swz1[j - 1], swz1[j] - 1)
      elseif swz1[j] == nil then
        if j == 1 then
          s[j] = str[i]
          break
        end
        s[j] = string.sub(str[i], 1 + swz1[j - 1], -1)
        break
      end
    end
    if color[i] == nil then
      color[i] = C_WHITE
    end
    color[1] = C_RED
    for jj = 1, 20 do
      if s[jj] ~= nil and s[jj] ~= "" then
        DrawString(bx + size * 0.5, by + (CC.RowPixel + size) * ll, s[jj], color[i], size)
        ll = ll + 1
        if 14 < ll then
          ShowScreen()
          local keyPress, ktype, mx, my = WaitKey()
          Cls()
          DrawBox(bx, by, bx + w, by + h, C_WHITE)
          ll = 0
        end
      else
        break
      end
    end
  end
  ShowScreen()
  local keyPress, ktype, mx, my = WaitKey()
end

function InstruceTS(id)
  local filename = string.format("%s%d.txt", CONFIG.HelpPath, id)
  if existFile(filename) == false then
    if existFile(string.format(CONFIG.CurrentPath .. "update.txt")) then
      filename = string.format(CONFIG.CurrentPath .. "update.txt")
    else
      return
    end
  end
  TSGL(filename, id)
end

function DrawTxt(filename, id)
  Cls()
  local file = io.open(filename, "r")
  local str = file:read("*a")
  file:close()
  str = string.gsub(str, "\r", "")
  local size = CC.DefaultFont
  local color = C_WHITE
  local linenum = 50
  local maxlen = 14
  local w = linenum * size / 2 + size
  local h = maxlen * (size + CC.RowPixel) + 2 * CC.RowPixel
  local bx = (CC.ScreenW - w) / 2
  local by = (CC.ScreenH - h) / 2
  DrawBox(bx, by, bx + w, by + h, C_WHITE)
  local x = bx + CC.RowPixel
  local y = by + CC.RowPixel
  local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
  local strcolor = AnalyString(str)
  local l = 0
  local row = 0
  for i, v in pairs(strcolor) do
    while v[1] ~= nil do
      local index = string.find(v[1], "\n")
      if linenum > l + #v[1] and index == nil then
        DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), v[1], v[2] or color, size)
        l = l + #v[1]
        if i == #strcolor then
          for j = 0, l do
            lib.SetClip(x, y, x + (j + 1) * size / 2, y + size + row * (size + CC.RowPixel))
            ShowScreen(1)
          end
          lib.SetClip(0, 0, 0, 0)
        end
        break
      else
        local tmp, pos1, pos2
        if index == nil then
          pos1 = linenum - l
          pos2 = pos1 + 1
        else
          pos1 = index - 1
          pos2 = pos1 + 2
          if pos1 > linenum - l then
            index = nil
            pos1 = linenum - l
            pos2 = pos1 + 1
          end
        end
        if pos1 > #v[1] then
          tmp = v[1]
          v[1] = nil
        else
          tmp = string.sub(v[1], 1, pos1)
          local flag = 0
          for i = 1, pos1 do
            if string.byte(tmp, i) <= 127 then
              flag = flag + 1
            end
          end
          if math.fmod(flag, 2) == 1 and index == nil and 127 < string.byte(tmp, -1) then
            tmp = string.sub(v[1], 1, pos1 - 1)
            pos2 = pos2 - 1
          end
          v[1] = string.sub(v[1], pos2)
        end
        DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), tmp, v[2] or color, size)
        l = l + #tmp
        for j = 0, l do
          lib.SetClip(x, y, x + j * size / 2, y + size + row * (size + CC.RowPixel))
          ShowScreen(1)
        end
        row = row + 1
        l = 0
      end
      lib.SetClip(0, 0, 0, 0)
      if row == maxlen then
        local keyPress, ktype, mx, my = WaitKey()
        if keyPress == VK_ESCAPE or ktype == 4 then
          break
        end
        row = 0
        Cls()
        lib.LoadSur(surid, 0, 0)
      end
      local i1, j1 = string.find(v[1], "'%x+'", 1)
      if i1 ~= nil then
        local tsnum = tonumber(string.sub(v[1], i1 + 1, j1 - 1))
        if JY.GLTS[id - 1][tsnum] == 1 then
          color = RGB(120, 208, 88)
          v[1] = string.gsub(v[1], "'%x+'", "\163\168\205\234\179\201\163\169", 1)
        else
          color = C_WHITE
          v[1] = string.gsub(v[1], "'%x+'", "", 1)
        end
      end
    end
  end
  lib.SetClip(0, 0, 0, 0)
  WaitKey()
  lib.FreeSur(surid)
end

function ZBInstruce()
  local flag = false
  Cls()
  repeat
    local x1 = CC.ScreenW / 4
    local y1 = CC.ScreenH / 4
    DrawStrBoxWaitKey("\206\180\205\234\201\198", C_WHITE, CC.DefaultFont)
    do break end
    local menu = {
      {
        "\213\230\206\228\189\163",
        nil,
        1
      },
      {
        "\176\215\194\237",
        nil,
        1
      },
      {
        "\208\254\204\250\189\163",
        nil,
        1
      },
      {
        "\210\208\204\236\189\163",
        nil,
        1
      },
      {
        "\205\192\193\250\181\182",
        nil,
        1
      },
      {
        "\200\237\206o\188\215",
        nil,
        1
      }
    }
    local numItem = #menu
    local size = CC.DefaultFont
    local r = ShowMenu(menu, numItem, 0, x1 + size * 3, y1 + size * 2, 0, 0, 1, 1, size, C_ORANGE, C_WHITE)
    if r == 0 then
      flag = true
    elseif r == 1 then
      say("\213\230\206\228\189\163\163\172\202\185\211\195\204\171\188\171\189\163\183\168\177\216\193\172\187\247", 232, 1, "\176\217\202\194\205\168")
    elseif r == 2 then
      say("\176\215\194\237\163\172\182\238\205\226\204\225\184\223\206\229\181\227\188\175\198\248\203\217\182\200", 232, 1, "\176\217\202\194\205\168")
    elseif r == 3 then
      say("\208\254\204\250\189\163\163\172\197\228\186\207\208\254\204\250\189\163\183\168\177\216\177\169\187\247\163\172\197\228\186\207\198\228\203\252\189\163\183\168\204\225\184\223\177\169\187\247\194\202", 232, 1, "\176\217\202\194\205\168")
    elseif r == 4 then
      say("\210\208\204\236\189\163\163\172\185\165\187\247\177\216\193\247\209\170\163\172\178\162\199\210\210\187\182\168\187\250\194\202\183\226\209\168", 232, 1, "\176\217\202\194\205\168")
    elseif r == 5 then
      say("\205\192\193\250\181\182\163\172\202\185\211\195\181\200\188\182\206\170\188\171\181\196\181\182\183\168\204\225\184\223\176\217\183\214\214\174\203\196\202\174\177\169\187\247\194\202\163\172\177\169\187\247\181\196\199\233\191\246\207\194\211\208\176\217\183\214\214\174\206\229\202\174\187\250\194\202\180\243\183\249\182\200\201\177\188\175\198\248\163\172\178\162\199\210\212\236\179\201\193\247\209\170\161\163\201\177\188\175\198\248\193\191\211\235\206\228\185\166\205\254\193\166\211\208\185\216", 232, 1, "\176\217\202\194\205\168")
    elseif r == 6 then
      say("\200\237\206o\188\215\163\172\202\220\181\189\200\173\207\181\206\228\185\166\185\165\187\247\202\177\183\180\201\228\210\187\182\168\181\196\201\203\186\166\163\172\202\220\181\189\183\199\200\173\207\181\206\228\185\166\185\165\187\247\202\177\188\245\201\217\201\203\186\166", 232, 1, "\176\217\202\194\205\168")
    end
  until flag
end

function WuGongIntruce()
  local menu = {}
  for i = 1, JY.WugongNum - 1 do
    menu[i] = {
      i .. JY.Wugong[i]["\195\251\179\198"],
      nil,
      0
    }
  end
  for i = 1, CC.MyThingNum do
    if JY.Base["\206\239\198\183" .. i] > -1 and 0 < JY.Base["\206\239\198\183\202\253\193\191" .. i] then
      local wg = JY.Thing[JY.Base["\206\239\198\183" .. i]]["\193\183\179\246\206\228\185\166"]
      if 0 < wg then
        menu[wg][3] = 1
      end
    else
      break
    end
  end
  for i = 1, CC.TeamNum do
    if 0 <= JY.Base["\182\211\206\233" .. i] then
      for j = 1, 10 do
        if 0 < JY.Person[JY.Base["\182\211\206\233" .. i]]["\206\228\185\166" .. j] then
          menu[JY.Person[JY.Base["\182\211\206\233" .. i]]["\206\228\185\166" .. j]][3] = 1
        else
          break
        end
      end
    else
      break
    end
  end
  local r = -1
  while true do
    Cls()
    r = ShowMenu2_new(menu, JY.WugongNum - 1, 4, 12, 10, (CC.ScreenH - 12 * (CC.DefaultFont + CC.RowPixel)) / 2 + 20, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\199\235\209\161\212\241\178\233\191\180\181\196\206\228\185\166", r)
    if 0 < r and r < JY.WugongNum then
      InstruceWuGong(r)
    else
      break
    end
  end
end

function InstruceWuGong(id)
  if id < 0 or id >= JY.WugongNum then
    QZXS("\206\228\185\166\206\180\214\170\180\237\206\243\163\172\206\222\183\168\178\233\191\180")
    return
  end
  local filename = string.format("%s%d.txt", CONFIG.WuGongPath, id)
  if existFile(filename) == false then
    QZXS("\180\203\206\228\185\166\206\180\176\252\186\172\200\206\186\206\203\181\195\247\163\172\199\235\215\212\208\208\215\193\196\165")
    return
  end
  DrawTxt(filename)
end

function QZXS(s)
  DrawStrBoxWaitKey(s, C_GOLD, CC.DefaultFont)
end

function AnalyString(str)
  local tlen = 0
  local strcolor = {}
  local f1, f2 = string.find(str, "<[A-R]>")
  if f1 ~= nil then
    while true do
      if 1 < f1 then
        local s1 = string.sub(str, 1, f1 - 1)
        table.insert(strcolor, {s1, nil})
        tlen = tlen + #s1
      end
      local match = string.match(str, "<([A-R])>")
      local f3, f4 = string.find(str, "</" .. match .. ">")
      if f3 ~= nil then
        local s2 = string.sub(str, f2 + 1, f3 - 1)
        table.insert(strcolor, {
          s2,
          CC.Color[match]
        })
        tlen = tlen + #s2
        if f4 + 1 >= #str then
          break
        end
        str = string.sub(str, f4 + 1, #str)
        f1, f2 = string.find(str, "<[A-R]>")
        if f1 == nil then
          table.insert(strcolor, {str, nil})
          break
        end
      else
        str = string.sub(str, f2 + 1, #str)
        table.insert(strcolor, {
          str,
          CC.Color[match]
        })
        break
      end
    end
  else
    table.insert(strcolor, {str, nil})
  end
  return strcolor
end

function ShowMenu2_new(menu, itemNum, numShow, showRow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor, str, selIndex, currentxz)
  local w = 0
  local h = 0
  local i, j = 0, 0
  local col = 0
  local row = 0
  Cls()
  local menuItem = {}
  local numItem = 0
  for i, v in pairs(menu) do
    if v[3] ~= 2 then
      numItem = numItem + 1
      menuItem[numItem] = {
        v[1],
        v[2],
        v[3],
        i
      }
    end
  end
  if numShow == 0 or numShow > numItem then
    col = numItem
    row = 1
  else
    col = numShow
    row = math.modf((numItem - 1) / col)
  end
  if showRow > row + 1 then
    showRow = row + 1
  end
  local maxlength = 0
  if x2 == 0 and y2 == 0 then
    for i = 1, numItem do
      if maxlength < string.len(menuItem[i][1]) then
        maxlength = string.len(menuItem[i][1])
      end
    end
    w = (size * maxlength / 2 + CC.RowPixel) * col + 2 * CC.MenuBorderPixel
    h = showRow * (size + CC.RowPixel) + 2 * CC.MenuBorderPixel
  else
    w = x2 - x1
    h = y2 - y1
  end
  if x1 == -1 then
    x1 = (CC.ScreenW - w) / 2
  end
  if y1 == -1 then
    y1 = (CC.ScreenH - h + size) / 2
  end
  local start = 0
  local curx = 1
  local cury = 0
  local current = curx + cury * numShow
  if selIndex ~= nil and 0 < selIndex then
    current = currentxz or selIndex
    curx = math.fmod(selIndex - 1, numShow) + 1
    cury = (selIndex - curx) / numShow
    if cury >= showRow / 2 then
      start = limitX(cury - showRow / 2, 0, row - showRow + 1)
    end
  end
  local returnValue = 0
  if str ~= nil then
    DrawStrBox(-1, y1 - size - 2 * CC.MenuBorderPixel, str, color, size)
  end
  local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
  if isBox == 1 then
    DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
  end
  while true do
    if col ~= 0 then
      lib.LoadSur(surid, 0, 0)
      if isBox == 1 then
        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
      end
    end
    for i = start, showRow + start - 1 do
      for j = 1, col do
        local n = i * col + j
        if numItem < n then
          break
        end
        local drawColor = color
        if menuItem[n][3] == 0 or menuItem[n][3] == 3 then
          drawColor = M_DimGray
        end
        local xx = x1 + (j - 1) * (size * maxlength / 2 + CC.RowPixel) + CC.MenuBorderPixel
        local yy = y1 + (i - start) * (size + CC.RowPixel) + CC.MenuBorderPixel
        if n == current then
          drawColor = selectColor
          lib.Background(xx, yy, xx + size * maxlength / 2, yy + size, 128, color)
        end
        DrawString(xx, yy, menuItem[n][1], drawColor, size)
      end
    end
    ShowScreen()
    local keyPress, ktype, mx, my = WaitKey(1)
    if keyPress == VK_ESCAPE or ktype == 4 then
      if isEsc == 1 then
        break
      end
    elseif keyPress == VK_DOWN or ktype == 7 then
      if numItem >= curx + (cury + 1) * col then
        cury = cury + 1
        if row < cury then
          cury = row
        elseif cury >= showRow / 2 and cury <= row - showRow / 2 + 1 and start <= row - showRow then
          start = start + 1
        end
      end
    elseif keyPress == VK_UP or ktype == 6 then
      cury = cury - 1
      if cury < 0 then
        cury = 0
      elseif cury >= showRow / 2 - 1 and cury < row - showRow / 2 and 0 < start then
        start = start - 1
      end
    elseif keyPress == VK_RIGHT then
      curx = curx + 1
      if col < curx then
        curx = 1
      elseif numItem < curx + cury * col then
        curx = 1
      end
    elseif keyPress == VK_LEFT then
      curx = curx - 1
      if curx < 1 then
        curx = col
        if numItem < curx + cury * col then
          curx = numItem - cury * col
        end
      end
    else
      local mk = false
      if (ktype == 2 or ktype == 3) and x1 <= mx and mx <= x1 + w and y1 <= my and my <= y1 + h then
        curx = math.modf((mx - x1 - CC.MenuBorderPixel) / (size * maxlength / 2 + CC.RowPixel)) + 1
        cury = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
        mk = true
      end
      if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or ktype == 3 and mk then
        current = curx + cury * col
        currentxz = current
        if menuItem[current][3] == 3 then
        elseif menuItem[current][2] == nil then
          returnValue = current
          break
        else
          local r = menuItem[current][2](menuItem, current)
          if r == 1 then
            returnValue = -current
            break
          else
            lib.LoadSur(surid, 0, 0)
            if isBox == 1 then
              DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE)
            end
          end
        end
      end
    end
    current = curx + cury * col
  end
  lib.FreeSur(surid)
  if 0 < returnValue then
    return menuItem[returnValue][4]
  else
    return returnValue
  end
end

function My_ChuangSong_List()
  local menu = {}
  for i = 0, JY.SceneNum - 1 do
    menu[i + 1] = {
      i .. JY.Scene[i]["\195\251\179\198"],
      nil,
      1
    }
    if JY.Scene[i]["\189\248\200\235\204\245\188\254"] ~= 0 or JY.Scene[i]["\205\226\190\176\200\235\191\218X1"] == 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218Y1"] == 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218X2"] == 0 and JY.Scene[i]["\205\226\190\176\200\235\191\218Y2"] == 0 then
      menu[i + 1][3] = 2
    end
  end
  menu[3] = {
    "2" .. JY.Scene[2]["\195\251\179\198"],
    nil,
    1
  }
  menu[39] = {
    "38" .. JY.Scene[38]["\195\251\179\198"],
    nil,
    1
  }
  local r = ShowMenu2_new(menu, JY.SceneNum, 4, 12, -1, -1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "\199\235\209\161\212\241\180\171\203\205\181\216\214\183")
  if r == 0 then
    Cls()
    return 0
  end
  if 0 < r then
    local sid = r - 1
    if JY.Scene[sid]["\189\248\200\235\204\245\188\254"] == 0 and JY.Scene[sid]["\205\226\190\176\200\235\191\218X1"] ~= 0 and JY.Scene[sid]["\205\226\190\176\200\235\191\218Y1"] ~= 0 and JY.Scene[sid]["\205\226\190\176\200\235\191\218X2"] ~= 0 and JY.Scene[sid]["\205\226\190\176\200\235\191\218Y2"] ~= 0 then
      New_Enter_SubScene(sid, -1, -1)
    elseif sid == 2 or sid == 38 then
      New_Enter_SubScene(sid, -1, -1)
    else
      say("\196\250\196\191\199\176\207\214\212\218\178\187\196\220\189\248\200\235\180\203\179\161\190\176", 232, 1, "\176\217\202\194\205\168")
      return 1
    end
  end
  return 1
end

function My_ChuangSong_Ex()
  local title = "\176\217\202\194\205\168\180\171\203\205\185\166\196\220"
  local str = "\213\226\202\199\210\187\184\246\186\220\183\189\177\227\181\196\194\237\179\181\180\171\203\205\207\181\205\179"
  local btn = {
    "\193\208\177\237",
    "\202\228\200\235",
    "\183\197\198\250"
  }
  local num = #btn
  local r = JYMsgBox(title, str, btn, num, 232, 1)
  if r == 1 then
    return My_ChuangSong_List()
  elseif r == 2 then
    Cls()
    local sid = InputNum("\199\235\202\228\200\235\179\161\190\176\180\250\194\235", 0, JY.SceneNum, 1)
    if sid ~= nil then
      if JY.Scene[sid]["\189\248\200\235\204\245\188\254"] == 0 and sid ~= 84 and sid ~= 83 and sid ~= 82 and sid ~= 13 then
        New_Enter_SubScene(sid, -1, -1)
      else
        say("\196\250\196\191\199\176\207\214\212\218\178\187\196\220\189\248\200\235\180\203\179\161\190\176", 232, 1, "\176\217\202\194\205\168")
        return 1
      end
    end
  end
end

function InputNum(str, minNum, maxNum, isEsc)
  local size = CC.DefaultFont
  local color = C_WHITE
  local ll = #str
  local w = size * ll / 2 + 2 * CC.MenuBorderPixel
  local h = size + 2 * CC.MenuBorderPixel
  local x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
  local y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
  DrawBox(x, y, x + w - 1, y + h - 1, C_WHITE)
  DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel, str, color, size)
  if maxNum < minNum then
    minNum, maxNum = maxNum, minNum
  end
  local help = "\201\207\207\194\188\211\188\245\210\187\163\172\215\243\211\210\188\211\188\245\202\174"
  if minNum ~= nil then
    help = help .. " \215\238\208\161" .. minNum
  end
  if minNum ~= nil then
    help = help .. " \215\238\180\243" .. maxNum
  end
  if isEsc ~= nil then
    help = help .. " ESC\200\161\207\251\202\228\200\235"
  end
  DrawString((CC.ScreenW - size * #help / 2) / 2, y - 2 * size, help, color, size)
  local sid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
  local num = 0
  if minNum ~= nil then
    num = minNum
  end
  while true do
    DrawString(CC.ScreenW / 2, y + h + size, num .. "", C_RED, size)
    ShowScreen()
    local key, ktype, mx, my = WaitKey(1)
    if key == VK_UP or ktype == 6 then
      if maxNum == nil or maxNum > num then
        num = num + 1
      end
    elseif key == VK_DOWN or ktype == 7 then
      if minNum == nil or minNum < num then
        num = num - 1
      end
    elseif key == VK_LEFT then
      if minNum == nil or num >= minNum + 10 then
        num = num - 10
      else
        num = minNum
      end
    elseif key == VK_RIGHT then
      if maxNum == nil or num <= maxNum - 10 then
        num = num + 10
      else
        num = maxNum
      end
    else
      if key == VK_SPACE or key == VK_RETURN or ktype == 3 then
        break
      end
      if (key == VK_ESCAPE or ktype == 4) and isEsc ~= nil then
        num = nil
        break
      end
    end
    ClsN()
    lib.LoadSur(sid, 0, 0)
  end
  lib.FreeSur(sid)
  return num
end

function My_Enter_SubScene(sceneid, x, y, direct)
  JY.SubScene = sceneid
  local flag = 1
  if x == -1 and y == -1 then
    JY.Base.人X1 = JY.Scene[sceneid]["\200\235\191\218X"]
    JY.Base.人Y1 = JY.Scene[sceneid]["\200\235\191\218Y"]
  else
    JY.Base.人X1 = x
    JY.Base.人Y1 = y
    flag = 0
  end
  if -1 < direct then
    JY.Base["\200\203\183\189\207\242"] = direct
  end
  if JY.Status == GAME_MMAP then
    CleanMemory()
    lib.UnloadMMap()
  end
  lib.ShowSlow(20, 1)
  JY.Status = GAME_SMAP
  JY.MmapMusic = -1
  JY.Base["\179\203\180\172"] = 0
  JY.MyPic = GetMyPic()
  local sid = JY.Scene[sceneid]["\204\248\215\170\179\161\190\176"]
  if sid < 0 or 0 >= JY.Scene[sid]["\205\226\190\176\200\235\191\218X1"] and 0 >= JY.Scene[sid]["\205\226\190\176\200\235\191\218Y1"] then
    JY.Base.人X = JY.Scene[sceneid]["\205\226\190\176\200\235\191\218X1"]
    JY.Base.人Y = JY.Scene[sceneid]["\205\226\190\176\200\235\191\218Y1"]
  else
    JY.Base.人X = JY.Scene[sid]["\205\226\190\176\200\235\191\218X1"]
    JY.Base.人Y = JY.Scene[sid]["\205\226\190\176\200\235\191\218Y1"]
  end
  Init_SMap(flag)
  if flag == 0 then
    DrawStrBox(-1, 10, JY.Scene[JY.SubScene]["\195\251\179\198"], C_WHITE, CC.DefaultFont)
    ShowScreen()
    WaitKey()
  end
  Cls()
end

function New_Enter_SubScene(sceneid, x, y)
  local x1 = JY.Scene[sceneid]["\205\226\190\176\200\235\191\218X1"]
  local y1 = JY.Scene[sceneid]["\205\226\190\176\200\235\191\218Y1"]
  lib.ShowSlow(50, 1)
  local i = 1
  if lib.GetMMap(x1, y1 + i, 3) == 0 and lib.GetMMap(x1, y1 + i, 4) == 0 then
    JY.Base.人X = x1
    JY.Base.人Y = y1 + i
    JY.Base["\200\203\183\189\207\242"] = 0
  elseif lib.GetMMap(x1, y1 - i, 3) == 0 and lib.GetMMap(x1, y1 - i, 4) == 0 then
    JY.Base.人X = x1
    JY.Base.人Y = y1 - i
    JY.Base["\200\203\183\189\207\242"] = 3
  elseif lib.GetMMap(x1 + i, y1, 3) == 0 and lib.GetMMap(x1 + i, y1, 4) == 0 then
    JY.Base.人X = x1 + i
    JY.Base.人Y = y1
    JY.Base["\200\203\183\189\207\242"] = 2
  elseif lib.GetMMap(x1 - i, y1, 3) == 0 and lib.GetMMap(x1 - i, y1, 4) == 0 then
    JY.Base.人X = x1 - i
    JY.Base.人Y = y1
    JY.Base["\200\203\183\189\207\242"] = 1
  end
  Cls()
  lib.ShowSlow(50, 0)
end

function ClsN(x1, y1, x2, y2)
  if x1 == nil then
    x1 = 0
    y1 = 0
    x2 = 0
    y2 = 0
  end
  lib.SetClip(x1, y1, x2, y2)
  lib.FillColor(0, 0, 0, 0, 0)
  lib.SetClip(0, 0, 0, 0)
end

function DrawTimer()
  if CC.OpenTimmerRemind ~= 1 then
    return
  end
  local t2 = lib.GetTime()
  if CC.Timer.status == 0 then
    if t2 - CC.Timer.stime > 10000 or CC.Timer.stime == 0 then
      CC.Timer.stime = t2
      CC.Timer.status = 1
      CC.Timer.str = CC.RUNSTR[math.random(#CC.RUNSTR)]
      CC.Timer.len = string.len(CC.Timer.str) / 2 + 3
    end
  else
    CC.Timer.fun(t2)
  end
end

function demostr(t)
  local tt = t - CC.Timer.stime
  tt = math.modf(tt / 25) % (CC.ScreenW + CC.Timer.len * CC.DefaultFont) * 1
  if runword(CC.Timer.str, M_Orange, CC.DefaultFont, 1, tt) == 1 and Rnd(2) == 1 then
    CC.Timer.status = 0
    CC.Timer.stime = t
  end
end

function runword(str, color, size, place, offset)
  offset = CC.ScreenW - offset
  local y1, y2
  if place == 0 then
    y1 = 0
    y2 = size
  elseif place == 1 then
    y1 = CC.ScreenH - size
    y2 = CC.ScreenH
  end
  lib.Background(0, y1, CC.ScreenW, y2, 128)
  if -offset > (CC.Timer.len - 1) * size then
    return 1
  end
  DrawString(offset, y1, str, color, size)
  return 0
end

function AutoSave()
  if lib.GetTime() > JY.DiyTime then
    JY.AtTime = lib.GetTime()
    JY.DiyTime = JY.AtTime + JY.SaveTime * 60000
    SaveRecord(11)
    JY.SBZ = 1
  end
  if JY.SBZ == 1 then
    local fontsize = CC.NewGameFontSize
    local i = math.modf((lib.GetTime() - JY.AtTime) / 500)
    if i == 0 or i == 2 or i == 4 or i == 6 or i == 8 or i == 10 or i == 12 or i == 14 or i == 16 or i == 18 or i == 20 then
      DrawString(CC.ScreenW / 2 - fontsize * 10, CC.ScreenH - fontsize * 3, string.format("\180\230\181\181\179\201\185\166\177\163\180\230\163\172\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\206\170%d\183\214\214\211", JY.SaveTime), C_RED, CC.NewGameFontSize, 1)
    else
      DrawString(CC.ScreenW / 2 - fontsize * 10, CC.ScreenH - fontsize * 3, string.format("\180\230\181\181\179\201\185\166\177\163\180\230\163\172\181\177\199\176\215\212\182\175\180\230\181\181\188\228\184\244\206\170%d\183\214\214\211", JY.SaveTime), C_WHITE, CC.NewGameFontSize, 1)
    end
    if JY.AtTime + 5000 < lib.GetTime() then
      JY.SBZ = 0
    end
  end
end

function X50ZL16(id1, id2, id3, id4, id5, id6, id7)
  id2 = id2 % 256
  id2 = id2 % 16
  id2 = id2 % 8
  local strbl, idbl1, idbl2, idbl3
  if id2 == 0 then
    idbl1 = id4
    idbl2 = id5
    idbl3 = id6
  elseif id2 == 1 then
    idbl1 = X50[id4]
    idbl2 = id5
    idbl3 = id6
  elseif id2 == 2 then
    idbl1 = id4
    idbl2 = X50[id5]
    idbl3 = id6
  elseif id2 == 3 then
    idbl1 = X50[id4]
    idbl2 = X50[id5]
    idbl3 = id6
  elseif id2 == 4 then
    idbl1 = id4
    idbl2 = id5
    idbl3 = X50[id6]
  elseif id2 == 5 then
    idbl1 = X50[id4]
    idbl2 = id5
    idbl3 = X50[id6]
  elseif id2 == 6 then
    idbl1 = id4
    idbl2 = X50[id5]
    idbl3 = X50[id6]
  elseif id2 == 7 then
    idbl1 = X50[id4]
    idbl2 = X50[id5]
    idbl3 = X50[id6]
  end
  if idbl1 < 0 then
    return
  end
  if id3 == 0 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\205\183\207\241\180\250\186\197"
    elseif idbl2 == 4 then
      strbl = "\201\250\195\252\212\246\179\164"
    elseif idbl2 == 6 then
      strbl = "\206\222\211\195"
    elseif idbl2 == 8 then
      strbl = "\208\213\195\251"
    elseif idbl2 == 18 then
      strbl = "\205\226\186\197"
    elseif idbl2 == 28 then
      strbl = "\208\212\177\240"
    elseif idbl2 == 30 then
      strbl = "\181\200\188\182"
    elseif idbl2 == 32 then
      strbl = "\190\173\209\233"
    elseif idbl2 == 34 then
      strbl = "\201\250\195\252"
    elseif idbl2 == 36 then
      strbl = "\201\250\195\252\215\238\180\243\214\181"
    elseif idbl2 == 38 then
      strbl = "\202\220\201\203\179\204\182\200"
    elseif idbl2 == 40 then
      strbl = "\214\208\182\190\179\204\182\200"
    elseif idbl2 == 42 then
      strbl = "\204\229\193\166"
    elseif idbl2 == 44 then
      strbl = "\206\239\198\183\208\222\193\182\181\227\202\253"
    elseif idbl2 == 46 then
      strbl = "\206\228\198\247"
    elseif idbl2 == 48 then
      strbl = "\183\192\190\223"
    elseif idbl2 == 80 then
      strbl = "\196\218\193\166\208\212\214\202"
    elseif idbl2 == 82 then
      strbl = "\196\218\193\166"
    elseif idbl2 == 84 then
      strbl = "\196\218\193\166\215\238\180\243\214\181"
    elseif idbl2 == 86 then
      strbl = "\185\165\187\247\193\166"
    elseif idbl2 == 88 then
      strbl = "\199\225\185\166"
    elseif idbl2 == 90 then
      strbl = "\183\192\211\249\193\166"
    elseif idbl2 == 92 then
      strbl = "\210\189\193\198\196\220\193\166"
    elseif idbl2 == 94 then
      strbl = "\211\195\182\190\196\220\193\166"
    elseif idbl2 == 96 then
      strbl = "\189\226\182\190\196\220\193\166"
    elseif idbl2 == 98 then
      strbl = "\191\185\182\190\196\220\193\166"
    elseif idbl2 == 100 then
      strbl = "\200\173\213\198\185\166\183\242"
    elseif idbl2 == 102 then
      strbl = "\211\249\189\163\196\220\193\166"
    elseif idbl2 == 104 then
      strbl = "\203\163\181\182\188\188\199\201"
    elseif idbl2 == 106 then
      strbl = "\204\216\202\226\177\248\198\247"
    elseif idbl2 == 108 then
      strbl = "\176\181\198\247\188\188\199\201"
    elseif idbl2 == 110 then
      strbl = "\206\228\209\167\179\163\202\182"
    elseif idbl2 == 112 then
      strbl = "\198\183\181\194"
    elseif idbl2 == 114 then
      strbl = "\185\165\187\247\180\248\182\190"
    elseif idbl2 == 116 then
      strbl = "\215\243\211\210\187\165\178\171"
    elseif idbl2 == 118 then
      strbl = "\201\249\205\251"
    elseif idbl2 == 120 then
      strbl = "\215\202\214\202"
    elseif idbl2 == 122 then
      strbl = "\208\222\193\182\206\239\198\183"
    elseif idbl2 == 124 then
      strbl = "\208\222\193\182\181\227\202\253"
    elseif idbl2 == 126 then
      strbl = "\206\228\185\1661"
    elseif idbl2 == 128 then
      strbl = "\206\228\185\1662"
    elseif idbl2 == 130 then
      strbl = "\206\228\185\1663"
    elseif idbl2 == 132 then
      strbl = "\206\228\185\1664"
    elseif idbl2 == 134 then
      strbl = "\206\228\185\1665"
    elseif idbl2 == 136 then
      strbl = "\206\228\185\1666"
    elseif idbl2 == 138 then
      strbl = "\206\228\185\1667"
    elseif idbl2 == 140 then
      strbl = "\206\228\185\1668"
    elseif idbl2 == 142 then
      strbl = "\206\228\185\1669"
    elseif idbl2 == 144 then
      strbl = "\206\228\185\16610"
    elseif idbl2 == 146 then
      strbl = "\206\228\185\166\181\200\188\1821"
    elseif idbl2 == 148 then
      strbl = "\206\228\185\166\181\200\188\1822"
    elseif idbl2 == 150 then
      strbl = "\206\228\185\166\181\200\188\1823"
    elseif idbl2 == 152 then
      strbl = "\206\228\185\166\181\200\188\1824"
    elseif idbl2 == 154 then
      strbl = "\206\228\185\166\181\200\188\1825"
    elseif idbl2 == 156 then
      strbl = "\206\228\185\166\181\200\188\1826"
    elseif idbl2 == 158 then
      strbl = "\206\228\185\166\181\200\188\1827"
    elseif idbl2 == 160 then
      strbl = "\206\228\185\166\181\200\188\1828"
    elseif idbl2 == 162 then
      strbl = "\206\228\185\166\181\200\188\1829"
    elseif idbl2 == 164 then
      strbl = "\206\228\185\166\181\200\188\18210"
    elseif idbl2 == 166 then
      strbl = "\208\175\180\248\206\239\198\1831"
    elseif idbl2 == 168 then
      strbl = "\208\175\180\248\206\239\198\1832"
    elseif idbl2 == 170 then
      strbl = "\208\175\180\248\206\239\198\1833"
    elseif idbl2 == 172 then
      strbl = "\208\175\180\248\206\239\198\1834"
    elseif idbl2 == 174 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1911"
    elseif idbl2 == 176 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1912"
    elseif idbl2 == 178 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1913"
    elseif idbl2 == 180 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1914"
    end
  elseif id3 == 1 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 22 then
      strbl = "\195\251\179\1982"
    elseif idbl2 == 42 then
      strbl = "\206\239\198\183\203\181\195\247"
    elseif idbl2 == 72 then
      strbl = "\193\183\179\246\206\228\185\166"
    elseif idbl2 == 74 then
      strbl = "\176\181\198\247\182\175\187\173\177\224\186\197"
    elseif idbl2 == 76 then
      strbl = "\202\185\211\195\200\203"
    elseif idbl2 == 78 then
      strbl = "\215\176\177\184\192\224\208\205"
    elseif idbl2 == 80 then
      strbl = "\207\212\202\190\206\239\198\183\203\181\195\247"
    elseif idbl2 == 82 then
      strbl = "\192\224\208\205"
    elseif idbl2 == 84 then
      strbl = "\206\180\214\1705"
    elseif idbl2 == 86 then
      strbl = "\206\180\214\1706"
    elseif idbl2 == 88 then
      strbl = "\206\180\214\1707"
    elseif idbl2 == 90 then
      strbl = "\188\211\201\250\195\252"
    elseif idbl2 == 92 then
      strbl = "\188\211\201\250\195\252\215\238\180\243\214\181"
    elseif idbl2 == 94 then
      strbl = "\188\211\214\208\182\190\189\226\182\190"
    elseif idbl2 == 96 then
      strbl = "\188\211\204\229\193\166"
    elseif idbl2 == 98 then
      strbl = "\184\196\177\228\196\218\193\166\208\212\214\202"
    elseif idbl2 == 100 then
      strbl = "\188\211\196\218\193\166"
    elseif idbl2 == 102 then
      strbl = "\188\211\196\218\193\166\215\238\180\243\214\181"
    elseif idbl2 == 104 then
      strbl = "\188\211\185\165\187\247\193\166"
    elseif idbl2 == 106 then
      strbl = "\188\211\199\225\185\166"
    elseif idbl2 == 108 then
      strbl = "\188\211\183\192\211\249\193\166"
    elseif idbl2 == 110 then
      strbl = "\188\211\210\189\193\198\196\220\193\166"
    elseif idbl2 == 112 then
      strbl = "\188\211\211\195\182\190\196\220\193\166"
    elseif idbl2 == 114 then
      strbl = "\188\211\189\226\182\190\196\220\193\166"
    elseif idbl2 == 116 then
      strbl = "\188\211\191\185\182\190\196\220\193\166"
    elseif idbl2 == 118 then
      strbl = "\188\211\200\173\213\198\185\166\183\242"
    elseif idbl2 == 120 then
      strbl = "\188\211\211\249\189\163\196\220\193\166"
    elseif idbl2 == 122 then
      strbl = "\188\211\203\163\181\182\188\188\199\201"
    elseif idbl2 == 124 then
      strbl = "\188\211\204\216\202\226\177\248\198\247"
    elseif idbl2 == 126 then
      strbl = "\188\211\176\181\198\247\188\188\199\201"
    elseif idbl2 == 128 then
      strbl = "\188\211\206\228\209\167\179\163\202\182"
    elseif idbl2 == 130 then
      strbl = "\188\211\198\183\181\194"
    elseif idbl2 == 132 then
      strbl = "\188\211\185\165\187\247\180\206\202\253"
    elseif idbl2 == 134 then
      strbl = "\188\211\185\165\187\247\180\248\182\190"
    elseif idbl2 == 136 then
      strbl = "\189\246\208\222\193\182\200\203\206\239"
    elseif idbl2 == 138 then
      strbl = "\208\232\196\218\193\166\208\212\214\202"
    elseif idbl2 == 140 then
      strbl = "\208\232\196\218\193\166"
    elseif idbl2 == 142 then
      strbl = "\208\232\185\165\187\247\193\166"
    elseif idbl2 == 144 then
      strbl = "\208\232\199\225\185\166"
    elseif idbl2 == 146 then
      strbl = "\208\232\211\195\182\190\196\220\193\166"
    elseif idbl2 == 148 then
      strbl = "\208\232\210\189\193\198\196\220\193\166"
    elseif idbl2 == 150 then
      strbl = "\208\232\189\226\182\190\196\220\193\166"
    elseif idbl2 == 152 then
      strbl = "\208\232\200\173\213\198\185\166\183\242"
    elseif idbl2 == 154 then
      strbl = "\208\232\211\249\189\163\196\220\193\166"
    elseif idbl2 == 156 then
      strbl = "\208\232\203\163\181\182\188\188\199\201"
    elseif idbl2 == 158 then
      strbl = "\208\232\204\216\202\226\177\248\198\247"
    elseif idbl2 == 160 then
      strbl = "\208\232\176\181\198\247\188\188\199\201"
    elseif idbl2 == 162 then
      strbl = "\208\232\215\202\214\202"
    elseif idbl2 == 164 then
      strbl = "\208\232\190\173\209\233"
    elseif idbl2 == 166 then
      strbl = "\193\183\179\246\206\239\198\183\208\232\190\173\209\233"
    elseif idbl2 == 168 then
      strbl = "\208\232\178\196\193\207"
    elseif idbl2 == 170 then
      strbl = "\193\183\179\246\206\239\198\1831"
    elseif idbl2 == 172 then
      strbl = "\193\183\179\246\206\239\198\1832"
    elseif idbl2 == 174 then
      strbl = "\193\183\179\246\206\239\198\1833"
    elseif idbl2 == 176 then
      strbl = "\193\183\179\246\206\239\198\1834"
    elseif idbl2 == 178 then
      strbl = "\193\183\179\246\206\239\198\1835"
    elseif idbl2 == 180 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1911"
    elseif idbl2 == 182 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1912"
    elseif idbl2 == 184 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1913"
    elseif idbl2 == 186 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1914"
    elseif idbl2 == 188 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1915"
    end
  elseif id3 == 2 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 12 then
      strbl = "\179\246\195\197\210\244\192\214"
    elseif idbl2 == 14 then
      strbl = "\189\248\195\197\210\244\192\214"
    elseif idbl2 == 16 then
      strbl = "\204\248\215\170\179\161\190\176"
    elseif idbl2 == 18 then
      strbl = "\189\248\200\235\204\245\188\254"
    elseif idbl2 == 20 then
      strbl = "\205\226\190\176\200\235\191\218X1"
    elseif idbl2 == 22 then
      strbl = "\205\226\190\176\200\235\191\218Y1"
    elseif idbl2 == 24 then
      strbl = "\205\226\190\176\200\235\191\218X2"
    elseif idbl2 == 26 then
      strbl = "\205\226\190\176\200\235\191\218Y2"
    elseif idbl2 == 28 then
      strbl = "\200\235\191\218X"
    elseif idbl2 == 30 then
      strbl = "\200\235\191\218Y"
    elseif idbl2 == 32 then
      strbl = "\179\246\191\218X1"
    elseif idbl2 == 34 then
      strbl = "\179\246\191\218X2"
    elseif idbl2 == 36 then
      strbl = "\179\246\191\218X3"
    elseif idbl2 == 38 then
      strbl = "\179\246\191\218Y1"
    elseif idbl2 == 40 then
      strbl = "\179\246\191\218Y2"
    elseif idbl2 == 42 then
      strbl = "\179\246\191\218Y3"
    elseif idbl2 == 44 then
      strbl = "\204\248\215\170\191\218X1"
    elseif idbl2 == 46 then
      strbl = "\204\248\215\170\191\218Y1"
    elseif idbl2 == 48 then
      strbl = "\204\248\215\170\191\218X2"
    elseif idbl2 == 50 then
      strbl = "\204\248\215\170\191\218Y2"
    end
  elseif id3 == 3 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 12 then
      strbl = "\206\180\214\1701"
    elseif idbl2 == 14 then
      strbl = "\206\180\214\1702"
    elseif idbl2 == 16 then
      strbl = "\206\180\214\1703"
    elseif idbl2 == 18 then
      strbl = "\206\180\214\1704"
    elseif idbl2 == 20 then
      strbl = "\206\180\214\1705"
    elseif idbl2 == 22 then
      strbl = "\179\246\213\208\210\244\208\167"
    elseif idbl2 == 24 then
      strbl = "\206\228\185\166\192\224\208\205"
    elseif idbl2 == 26 then
      strbl = "\206\228\185\166\182\175\187\173&\210\244\208\167"
    elseif idbl2 == 28 then
      strbl = "\201\203\186\166\192\224\208\205"
    elseif idbl2 == 30 then
      strbl = "\185\165\187\247\183\182\206\167"
    elseif idbl2 == 32 then
      strbl = "\207\251\186\196\196\218\193\166\181\227\202\253"
    elseif idbl2 == 34 then
      strbl = "\181\208\200\203\214\208\182\190\181\227\202\253"
    elseif idbl2 == 36 then
      strbl = "\185\165\187\247\193\1661"
    elseif idbl2 == 38 then
      strbl = "\185\165\187\247\193\1662"
    elseif idbl2 == 40 then
      strbl = "\185\165\187\247\193\1663"
    elseif idbl2 == 42 then
      strbl = "\185\165\187\247\193\1664"
    elseif idbl2 == 44 then
      strbl = "\185\165\187\247\193\1665"
    elseif idbl2 == 46 then
      strbl = "\185\165\187\247\193\1666"
    elseif idbl2 == 48 then
      strbl = "\185\165\187\247\193\1667"
    elseif idbl2 == 50 then
      strbl = "\185\165\187\247\193\1668"
    elseif idbl2 == 52 then
      strbl = "\185\165\187\247\193\1669"
    elseif idbl2 == 54 then
      strbl = "\185\165\187\247\193\16610"
    elseif idbl2 == 56 then
      strbl = "\210\198\182\175\183\182\206\1671"
    elseif idbl2 == 58 then
      strbl = "\210\198\182\175\183\182\206\1672"
    elseif idbl2 == 60 then
      strbl = "\210\198\182\175\183\182\206\1673"
    elseif idbl2 == 62 then
      strbl = "\210\198\182\175\183\182\206\1674"
    elseif idbl2 == 64 then
      strbl = "\210\198\182\175\183\182\206\1675"
    elseif idbl2 == 66 then
      strbl = "\210\198\182\175\183\182\206\1676"
    elseif idbl2 == 68 then
      strbl = "\210\198\182\175\183\182\206\1677"
    elseif idbl2 == 70 then
      strbl = "\210\198\182\175\183\182\206\1678"
    elseif idbl2 == 72 then
      strbl = "\210\198\182\175\183\182\206\1679"
    elseif idbl2 == 74 then
      strbl = "\210\198\182\175\183\182\206\16710"
    elseif idbl2 == 76 then
      strbl = "\201\177\201\203\183\182\206\1671"
    elseif idbl2 == 78 then
      strbl = "\201\177\201\203\183\182\206\1672"
    elseif idbl2 == 80 then
      strbl = "\201\177\201\203\183\182\206\1673"
    elseif idbl2 == 82 then
      strbl = "\201\177\201\203\183\182\206\1674"
    elseif idbl2 == 84 then
      strbl = "\201\177\201\203\183\182\206\1675"
    elseif idbl2 == 86 then
      strbl = "\201\177\201\203\183\182\206\1676"
    elseif idbl2 == 88 then
      strbl = "\201\177\201\203\183\182\206\1677"
    elseif idbl2 == 90 then
      strbl = "\201\177\201\203\183\182\206\1678"
    elseif idbl2 == 92 then
      strbl = "\201\177\201\203\183\182\206\1679"
    elseif idbl2 == 94 then
      strbl = "\201\177\201\203\183\182\206\16710"
    elseif idbl2 == 96 then
      strbl = "\188\211\196\218\193\1661"
    elseif idbl2 == 98 then
      strbl = "\188\211\196\218\193\1662"
    elseif idbl2 == 100 then
      strbl = "\188\211\196\218\193\1663"
    elseif idbl2 == 102 then
      strbl = "\188\211\196\218\193\1664"
    elseif idbl2 == 104 then
      strbl = "\188\211\196\218\193\1665"
    elseif idbl2 == 106 then
      strbl = "\188\211\196\218\193\1666"
    elseif idbl2 == 108 then
      strbl = "\188\211\196\218\193\1667"
    elseif idbl2 == 110 then
      strbl = "\188\211\196\218\193\1668"
    elseif idbl2 == 112 then
      strbl = "\188\211\196\218\193\1669"
    elseif idbl2 == 114 then
      strbl = "\188\211\196\218\193\16610"
    elseif idbl2 == 116 then
      strbl = "\201\177\196\218\193\1661"
    elseif idbl2 == 118 then
      strbl = "\201\177\196\218\193\1662"
    elseif idbl2 == 120 then
      strbl = "\201\177\196\218\193\1663"
    elseif idbl2 == 122 then
      strbl = "\201\177\196\218\193\1664"
    elseif idbl2 == 124 then
      strbl = "\201\177\196\218\193\1665"
    elseif idbl2 == 126 then
      strbl = "\201\177\196\218\193\1666"
    elseif idbl2 == 128 then
      strbl = "\201\177\196\218\193\1667"
    elseif idbl2 == 130 then
      strbl = "\201\177\196\218\193\1668"
    elseif idbl2 == 132 then
      strbl = "\201\177\196\218\193\1669"
    elseif idbl2 == 134 then
      strbl = "\201\177\196\218\193\16610"
    end
  end
  if id3 == 0 then
    JY.Person[idbl1][strbl] = idbl3
  elseif id3 == 1 then
    JY.Thing[idbl1][strbl] = idbl3
  elseif id3 == 2 then
    JY.Scene[idbl1][strbl] = idbl3
  elseif id3 == 3 then
    JY.Wugong[idbl1][strbl] = idbl3
  end
end

function X50ZL17(id1, id2, id3, id4, id5, id6, id7)
  id2 = id2 % 256
  id2 = id2 % 16
  id2 = id2 % 8
  id2 = id2 % 4
  local strbl, idbl1, idbl2
  if id2 == 0 then
    idbl1 = id4
    idbl2 = id5
  elseif id2 == 1 then
    idbl1 = X50[id4]
    idbl2 = id5
  elseif id2 == 2 then
    idbl1 = id4
    idbl2 = X50[id5]
  elseif id2 == 3 then
    idbl1 = X50[id4]
    idbl2 = X50[id5]
  end
  if idbl1 < 0 then
    return
  end
  if id3 == 0 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\205\183\207\241\180\250\186\197"
    elseif idbl2 == 4 then
      strbl = "\201\250\195\252\212\246\179\164"
    elseif idbl2 == 6 then
      strbl = "\206\222\211\195"
    elseif idbl2 == 8 then
      strbl = "\208\213\195\251"
    elseif idbl2 == 18 then
      strbl = "\205\226\186\197"
    elseif idbl2 == 28 then
      strbl = "\208\212\177\240"
    elseif idbl2 == 30 then
      strbl = "\181\200\188\182"
    elseif idbl2 == 32 then
      strbl = "\190\173\209\233"
    elseif idbl2 == 34 then
      strbl = "\201\250\195\252"
    elseif idbl2 == 36 then
      strbl = "\201\250\195\252\215\238\180\243\214\181"
    elseif idbl2 == 38 then
      strbl = "\202\220\201\203\179\204\182\200"
    elseif idbl2 == 40 then
      strbl = "\214\208\182\190\179\204\182\200"
    elseif idbl2 == 42 then
      strbl = "\204\229\193\166"
    elseif idbl2 == 44 then
      strbl = "\206\239\198\183\208\222\193\182\181\227\202\253"
    elseif idbl2 == 46 then
      strbl = "\206\228\198\247"
    elseif idbl2 == 48 then
      strbl = "\183\192\190\223"
    elseif idbl2 == 80 then
      strbl = "\196\218\193\166\208\212\214\202"
    elseif idbl2 == 82 then
      strbl = "\196\218\193\166"
    elseif idbl2 == 84 then
      strbl = "\196\218\193\166\215\238\180\243\214\181"
    elseif idbl2 == 86 then
      strbl = "\185\165\187\247\193\166"
    elseif idbl2 == 88 then
      strbl = "\199\225\185\166"
    elseif idbl2 == 90 then
      strbl = "\183\192\211\249\193\166"
    elseif idbl2 == 92 then
      strbl = "\210\189\193\198\196\220\193\166"
    elseif idbl2 == 94 then
      strbl = "\211\195\182\190\196\220\193\166"
    elseif idbl2 == 96 then
      strbl = "\189\226\182\190\196\220\193\166"
    elseif idbl2 == 98 then
      strbl = "\191\185\182\190\196\220\193\166"
    elseif idbl2 == 100 then
      strbl = "\200\173\213\198\185\166\183\242"
    elseif idbl2 == 102 then
      strbl = "\211\249\189\163\196\220\193\166"
    elseif idbl2 == 104 then
      strbl = "\203\163\181\182\188\188\199\201"
    elseif idbl2 == 106 then
      strbl = "\204\216\202\226\177\248\198\247"
    elseif idbl2 == 108 then
      strbl = "\176\181\198\247\188\188\199\201"
    elseif idbl2 == 110 then
      strbl = "\206\228\209\167\179\163\202\182"
    elseif idbl2 == 112 then
      strbl = "\198\183\181\194"
    elseif idbl2 == 114 then
      strbl = "\185\165\187\247\180\248\182\190"
    elseif idbl2 == 116 then
      strbl = "\215\243\211\210\187\165\178\171"
    elseif idbl2 == 118 then
      strbl = "\201\249\205\251"
    elseif idbl2 == 120 then
      strbl = "\215\202\214\202"
    elseif idbl2 == 122 then
      strbl = "\208\222\193\182\206\239\198\183"
    elseif idbl2 == 124 then
      strbl = "\208\222\193\182\181\227\202\253"
    elseif idbl2 == 126 then
      strbl = "\206\228\185\1661"
    elseif idbl2 == 128 then
      strbl = "\206\228\185\1662"
    elseif idbl2 == 130 then
      strbl = "\206\228\185\1663"
    elseif idbl2 == 132 then
      strbl = "\206\228\185\1664"
    elseif idbl2 == 134 then
      strbl = "\206\228\185\1665"
    elseif idbl2 == 136 then
      strbl = "\206\228\185\1666"
    elseif idbl2 == 138 then
      strbl = "\206\228\185\1667"
    elseif idbl2 == 140 then
      strbl = "\206\228\185\1668"
    elseif idbl2 == 142 then
      strbl = "\206\228\185\1669"
    elseif idbl2 == 144 then
      strbl = "\206\228\185\16610"
    elseif idbl2 == 146 then
      strbl = "\206\228\185\166\181\200\188\1821"
    elseif idbl2 == 148 then
      strbl = "\206\228\185\166\181\200\188\1822"
    elseif idbl2 == 150 then
      strbl = "\206\228\185\166\181\200\188\1823"
    elseif idbl2 == 152 then
      strbl = "\206\228\185\166\181\200\188\1824"
    elseif idbl2 == 154 then
      strbl = "\206\228\185\166\181\200\188\1825"
    elseif idbl2 == 156 then
      strbl = "\206\228\185\166\181\200\188\1826"
    elseif idbl2 == 158 then
      strbl = "\206\228\185\166\181\200\188\1827"
    elseif idbl2 == 160 then
      strbl = "\206\228\185\166\181\200\188\1828"
    elseif idbl2 == 162 then
      strbl = "\206\228\185\166\181\200\188\1829"
    elseif idbl2 == 164 then
      strbl = "\206\228\185\166\181\200\188\18210"
    elseif idbl2 == 166 then
      strbl = "\208\175\180\248\206\239\198\1831"
    elseif idbl2 == 168 then
      strbl = "\208\175\180\248\206\239\198\1832"
    elseif idbl2 == 170 then
      strbl = "\208\175\180\248\206\239\198\1833"
    elseif idbl2 == 172 then
      strbl = "\208\175\180\248\206\239\198\1834"
    elseif idbl2 == 174 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1911"
    elseif idbl2 == 176 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1912"
    elseif idbl2 == 178 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1913"
    elseif idbl2 == 180 then
      strbl = "\208\175\180\248\206\239\198\183\202\253\193\1914"
    end
  elseif id3 == 1 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 22 then
      strbl = "\195\251\179\1982"
    elseif idbl2 == 42 then
      strbl = "\206\239\198\183\203\181\195\247"
    elseif idbl2 == 72 then
      strbl = "\193\183\179\246\206\228\185\166"
    elseif idbl2 == 74 then
      strbl = "\176\181\198\247\182\175\187\173\177\224\186\197"
    elseif idbl2 == 76 then
      strbl = "\202\185\211\195\200\203"
    elseif idbl2 == 78 then
      strbl = "\215\176\177\184\192\224\208\205"
    elseif idbl2 == 80 then
      strbl = "\207\212\202\190\206\239\198\183\203\181\195\247"
    elseif idbl2 == 82 then
      strbl = "\192\224\208\205"
    elseif idbl2 == 84 then
      strbl = "\206\180\214\1705"
    elseif idbl2 == 86 then
      strbl = "\206\180\214\1706"
    elseif idbl2 == 88 then
      strbl = "\206\180\214\1707"
    elseif idbl2 == 90 then
      strbl = "\188\211\201\250\195\252"
    elseif idbl2 == 92 then
      strbl = "\188\211\201\250\195\252\215\238\180\243\214\181"
    elseif idbl2 == 94 then
      strbl = "\188\211\214\208\182\190\189\226\182\190"
    elseif idbl2 == 96 then
      strbl = "\188\211\204\229\193\166"
    elseif idbl2 == 98 then
      strbl = "\184\196\177\228\196\218\193\166\208\212\214\202"
    elseif idbl2 == 100 then
      strbl = "\188\211\196\218\193\166"
    elseif idbl2 == 102 then
      strbl = "\188\211\196\218\193\166\215\238\180\243\214\181"
    elseif idbl2 == 104 then
      strbl = "\188\211\185\165\187\247\193\166"
    elseif idbl2 == 106 then
      strbl = "\188\211\199\225\185\166"
    elseif idbl2 == 108 then
      strbl = "\188\211\183\192\211\249\193\166"
    elseif idbl2 == 110 then
      strbl = "\188\211\210\189\193\198\196\220\193\166"
    elseif idbl2 == 112 then
      strbl = "\188\211\211\195\182\190\196\220\193\166"
    elseif idbl2 == 114 then
      strbl = "\188\211\189\226\182\190\196\220\193\166"
    elseif idbl2 == 116 then
      strbl = "\188\211\191\185\182\190\196\220\193\166"
    elseif idbl2 == 118 then
      strbl = "\188\211\200\173\213\198\185\166\183\242"
    elseif idbl2 == 120 then
      strbl = "\188\211\211\249\189\163\196\220\193\166"
    elseif idbl2 == 122 then
      strbl = "\188\211\203\163\181\182\188\188\199\201"
    elseif idbl2 == 124 then
      strbl = "\188\211\204\216\202\226\177\248\198\247"
    elseif idbl2 == 126 then
      strbl = "\188\211\176\181\198\247\188\188\199\201"
    elseif idbl2 == 128 then
      strbl = "\188\211\206\228\209\167\179\163\202\182"
    elseif idbl2 == 130 then
      strbl = "\188\211\198\183\181\194"
    elseif idbl2 == 132 then
      strbl = "\188\211\185\165\187\247\180\206\202\253"
    elseif idbl2 == 134 then
      strbl = "\188\211\185\165\187\247\180\248\182\190"
    elseif idbl2 == 136 then
      strbl = "\189\246\208\222\193\182\200\203\206\239"
    elseif idbl2 == 138 then
      strbl = "\208\232\196\218\193\166\208\212\214\202"
    elseif idbl2 == 140 then
      strbl = "\208\232\196\218\193\166"
    elseif idbl2 == 142 then
      strbl = "\208\232\185\165\187\247\193\166"
    elseif idbl2 == 144 then
      strbl = "\208\232\199\225\185\166"
    elseif idbl2 == 146 then
      strbl = "\208\232\211\195\182\190\196\220\193\166"
    elseif idbl2 == 148 then
      strbl = "\208\232\210\189\193\198\196\220\193\166"
    elseif idbl2 == 150 then
      strbl = "\208\232\189\226\182\190\196\220\193\166"
    elseif idbl2 == 152 then
      strbl = "\208\232\200\173\213\198\185\166\183\242"
    elseif idbl2 == 154 then
      strbl = "\208\232\211\249\189\163\196\220\193\166"
    elseif idbl2 == 156 then
      strbl = "\208\232\203\163\181\182\188\188\199\201"
    elseif idbl2 == 158 then
      strbl = "\208\232\204\216\202\226\177\248\198\247"
    elseif idbl2 == 160 then
      strbl = "\208\232\176\181\198\247\188\188\199\201"
    elseif idbl2 == 162 then
      strbl = "\208\232\215\202\214\202"
    elseif idbl2 == 164 then
      strbl = "\208\232\190\173\209\233"
    elseif idbl2 == 166 then
      strbl = "\193\183\179\246\206\239\198\183\208\232\190\173\209\233"
    elseif idbl2 == 168 then
      strbl = "\208\232\178\196\193\207"
    elseif idbl2 == 170 then
      strbl = "\193\183\179\246\206\239\198\1831"
    elseif idbl2 == 172 then
      strbl = "\193\183\179\246\206\239\198\1832"
    elseif idbl2 == 174 then
      strbl = "\193\183\179\246\206\239\198\1833"
    elseif idbl2 == 176 then
      strbl = "\193\183\179\246\206\239\198\1834"
    elseif idbl2 == 178 then
      strbl = "\193\183\179\246\206\239\198\1835"
    elseif idbl2 == 180 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1911"
    elseif idbl2 == 182 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1912"
    elseif idbl2 == 184 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1913"
    elseif idbl2 == 186 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1914"
    elseif idbl2 == 188 then
      strbl = "\208\232\210\170\206\239\198\183\202\253\193\1915"
    end
  elseif id3 == 2 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 12 then
      strbl = "\179\246\195\197\210\244\192\214"
    elseif idbl2 == 14 then
      strbl = "\189\248\195\197\210\244\192\214"
    elseif idbl2 == 16 then
      strbl = "\204\248\215\170\179\161\190\176"
    elseif idbl2 == 18 then
      strbl = "\189\248\200\235\204\245\188\254"
    elseif idbl2 == 20 then
      strbl = "\205\226\190\176\200\235\191\218X1"
    elseif idbl2 == 22 then
      strbl = "\205\226\190\176\200\235\191\218Y1"
    elseif idbl2 == 24 then
      strbl = "\205\226\190\176\200\235\191\218X2"
    elseif idbl2 == 26 then
      strbl = "\205\226\190\176\200\235\191\218Y2"
    elseif idbl2 == 28 then
      strbl = "\200\235\191\218X"
    elseif idbl2 == 30 then
      strbl = "\200\235\191\218Y"
    elseif idbl2 == 32 then
      strbl = "\179\246\191\218X1"
    elseif idbl2 == 34 then
      strbl = "\179\246\191\218X2"
    elseif idbl2 == 36 then
      strbl = "\179\246\191\218X3"
    elseif idbl2 == 38 then
      strbl = "\179\246\191\218Y1"
    elseif idbl2 == 40 then
      strbl = "\179\246\191\218Y2"
    elseif idbl2 == 42 then
      strbl = "\179\246\191\218Y3"
    elseif idbl2 == 44 then
      strbl = "\204\248\215\170\191\218X1"
    elseif idbl2 == 46 then
      strbl = "\204\248\215\170\191\218Y1"
    elseif idbl2 == 48 then
      strbl = "\204\248\215\170\191\218X2"
    elseif idbl2 == 50 then
      strbl = "\204\248\215\170\191\218Y2"
    end
  elseif id3 == 3 then
    if idbl2 == 0 then
      strbl = "\180\250\186\197"
    elseif idbl2 == 2 then
      strbl = "\195\251\179\198"
    elseif idbl2 == 12 then
      strbl = "\206\180\214\1701"
    elseif idbl2 == 14 then
      strbl = "\206\180\214\1702"
    elseif idbl2 == 16 then
      strbl = "\206\180\214\1703"
    elseif idbl2 == 18 then
      strbl = "\206\180\214\1704"
    elseif idbl2 == 20 then
      strbl = "\206\180\214\1705"
    elseif idbl2 == 22 then
      strbl = "\179\246\213\208\210\244\208\167"
    elseif idbl2 == 24 then
      strbl = "\206\228\185\166\192\224\208\205"
    elseif idbl2 == 26 then
      strbl = "\206\228\185\166\182\175\187\173&\210\244\208\167"
    elseif idbl2 == 28 then
      strbl = "\201\203\186\166\192\224\208\205"
    elseif idbl2 == 30 then
      strbl = "\185\165\187\247\183\182\206\167"
    elseif idbl2 == 32 then
      strbl = "\207\251\186\196\196\218\193\166\181\227\202\253"
    elseif idbl2 == 34 then
      strbl = "\181\208\200\203\214\208\182\190\181\227\202\253"
    elseif idbl2 == 36 then
      strbl = "\185\165\187\247\193\1661"
    elseif idbl2 == 38 then
      strbl = "\185\165\187\247\193\1662"
    elseif idbl2 == 40 then
      strbl = "\185\165\187\247\193\1663"
    elseif idbl2 == 42 then
      strbl = "\185\165\187\247\193\1664"
    elseif idbl2 == 44 then
      strbl = "\185\165\187\247\193\1665"
    elseif idbl2 == 46 then
      strbl = "\185\165\187\247\193\1666"
    elseif idbl2 == 48 then
      strbl = "\185\165\187\247\193\1667"
    elseif idbl2 == 50 then
      strbl = "\185\165\187\247\193\1668"
    elseif idbl2 == 52 then
      strbl = "\185\165\187\247\193\1669"
    elseif idbl2 == 54 then
      strbl = "\185\165\187\247\193\16610"
    elseif idbl2 == 56 then
      strbl = "\210\198\182\175\183\182\206\1671"
    elseif idbl2 == 58 then
      strbl = "\210\198\182\175\183\182\206\1672"
    elseif idbl2 == 60 then
      strbl = "\210\198\182\175\183\182\206\1673"
    elseif idbl2 == 62 then
      strbl = "\210\198\182\175\183\182\206\1674"
    elseif idbl2 == 64 then
      strbl = "\210\198\182\175\183\182\206\1675"
    elseif idbl2 == 66 then
      strbl = "\210\198\182\175\183\182\206\1676"
    elseif idbl2 == 68 then
      strbl = "\210\198\182\175\183\182\206\1677"
    elseif idbl2 == 70 then
      strbl = "\210\198\182\175\183\182\206\1678"
    elseif idbl2 == 72 then
      strbl = "\210\198\182\175\183\182\206\1679"
    elseif idbl2 == 74 then
      strbl = "\210\198\182\175\183\182\206\16710"
    elseif idbl2 == 76 then
      strbl = "\201\177\201\203\183\182\206\1671"
    elseif idbl2 == 78 then
      strbl = "\201\177\201\203\183\182\206\1672"
    elseif idbl2 == 80 then
      strbl = "\201\177\201\203\183\182\206\1673"
    elseif idbl2 == 82 then
      strbl = "\201\177\201\203\183\182\206\1674"
    elseif idbl2 == 84 then
      strbl = "\201\177\201\203\183\182\206\1675"
    elseif idbl2 == 86 then
      strbl = "\201\177\201\203\183\182\206\1676"
    elseif idbl2 == 88 then
      strbl = "\201\177\201\203\183\182\206\1677"
    elseif idbl2 == 90 then
      strbl = "\201\177\201\203\183\182\206\1678"
    elseif idbl2 == 92 then
      strbl = "\201\177\201\203\183\182\206\1679"
    elseif idbl2 == 94 then
      strbl = "\201\177\201\203\183\182\206\16710"
    elseif idbl2 == 96 then
      strbl = "\188\211\196\218\193\1661"
    elseif idbl2 == 98 then
      strbl = "\188\211\196\218\193\1662"
    elseif idbl2 == 100 then
      strbl = "\188\211\196\218\193\1663"
    elseif idbl2 == 102 then
      strbl = "\188\211\196\218\193\1664"
    elseif idbl2 == 104 then
      strbl = "\188\211\196\218\193\1665"
    elseif idbl2 == 106 then
      strbl = "\188\211\196\218\193\1666"
    elseif idbl2 == 108 then
      strbl = "\188\211\196\218\193\1667"
    elseif idbl2 == 110 then
      strbl = "\188\211\196\218\193\1668"
    elseif idbl2 == 112 then
      strbl = "\188\211\196\218\193\1669"
    elseif idbl2 == 114 then
      strbl = "\188\211\196\218\193\16610"
    elseif idbl2 == 116 then
      strbl = "\201\177\196\218\193\1661"
    elseif idbl2 == 118 then
      strbl = "\201\177\196\218\193\1662"
    elseif idbl2 == 120 then
      strbl = "\201\177\196\218\193\1663"
    elseif idbl2 == 122 then
      strbl = "\201\177\196\218\193\1664"
    elseif idbl2 == 124 then
      strbl = "\201\177\196\218\193\1665"
    elseif idbl2 == 126 then
      strbl = "\201\177\196\218\193\1666"
    elseif idbl2 == 128 then
      strbl = "\201\177\196\218\193\1667"
    elseif idbl2 == 130 then
      strbl = "\201\177\196\218\193\1668"
    elseif idbl2 == 132 then
      strbl = "\201\177\196\218\193\1669"
    elseif idbl2 == 134 then
      strbl = "\201\177\196\218\193\16610"
    end
  end
  if id3 == 0 then
    X50[id6] = JY.Person[idbl1][strbl]
  elseif id3 == 1 then
    X50[id6] = JY.Thing[idbl1][strbl]
  elseif id3 == 2 then
    X50[id6] = JY.Scene[idbl1][strbl]
  elseif id3 == 3 then
    X50[id6] = JY.Wugong[idbl1][strbl]
  end
end

function walkto(xx, yy, x, y, flag)
  local x, y
  AutoMoveTab = {
    [0] = 0
  }
  if JY.Status == GAME_SMAP then
    x = x or JY.Base.人X1
    y = y or JY.Base.人Y1
  elseif JY.Status == GAME_MMAP then
    x = x or JY.Base.人X
    y = y or JY.Base.人Y
  end
  xx, yy = xx + x, yy + y
  if JY.Status == GAME_SMAP and SceneCanPass(xx, yy) == false then
    if 0 < GetS(JY.SubScene, xx, yy, 3) and 0 < GetD(JY.SubScene, GetS(JY.SubScene, xx, yy, 3), 2) then
      CC.AutoMoveEvent[1] = xx
      CC.AutoMoveEvent[2] = yy
      if SceneCanPass(xx + 1, yy) then
        xx = xx + 1
      elseif SceneCanPass(xx, yy + 1) then
        yy = yy + 1
      elseif SceneCanPass(xx, yy - 1) then
        yy = yy - 1
      elseif SceneCanPass(xx - 1, yy) then
        xx = xx - 1
      else
        return
      end
      CC.AutoMoveEvent[0] = 1
    else
      return
    end
  end
  if JY.Status == GAME_MMAP and (lib.GetMMap(xx, yy, 3) == 0 and lib.GetMMap(xx, yy, 4) == 0 or CanEnterScene(xx, yy) ~= -1) == false then
    return
  end
  local steparray = {}
  local stepmax
  local xy = {}
  if JY.Status == GAME_SMAP then
    for i = 0, CC.SWidth - 1 do
      xy[i] = {}
    end
  elseif JY.Status == GAME_MMAP then
    for i = 0, 479 do
      xy[i] = {}
    end
  end
  if flag ~= nil then
    stepmax = 640
  else
    stepmax = 240
  end
  for i = 0, stepmax do
    steparray[i] = {}
    steparray[i].x = {}
    steparray[i].y = {}
  end
  
  local function canpass(nx, ny)
    if JY.Status == GAME_SMAP and (nx > CC.SWidth - 1 or ny > CC.SWidth - 1 or nx < 0 or ny < 0) then
      return false
    end
    if JY.Status == GAME_MMAP and (479 < nx or 479 < ny or nx < 1 or ny < 1) then
      return false
    end
    if xy[nx][ny] == nil then
      if JY.Status == GAME_SMAP then
        if SceneCanPass(nx, ny) then
          return true
        end
      elseif JY.Status == GAME_MMAP and (lib.GetMMap(nx, ny, 3) == 0 and lib.GetMMap(nx, ny, 4) == 0 or CanEnterScene(nx, ny) ~= -1) then
        return true
      end
    end
    return false
  end
  
  local function FindNextStep(step)
    if step == stepmax then
      return
    end
    local step1 = step + 1
    local num = 0
    for i = 1, steparray[step].num do
      if steparray[step].x[i] == xx and steparray[step].y[i] == yy then
        return
      end
      if canpass(steparray[step].x[i] + 1, steparray[step].y[i]) then
        num = num + 1
        steparray[step1].x[num] = steparray[step].x[i] + 1
        steparray[step1].y[num] = steparray[step].y[i]
        xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
      end
      if canpass(steparray[step].x[i] - 1, steparray[step].y[i]) then
        num = num + 1
        steparray[step1].x[num] = steparray[step].x[i] - 1
        steparray[step1].y[num] = steparray[step].y[i]
        xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
      end
      if canpass(steparray[step].x[i], steparray[step].y[i] + 1) then
        num = num + 1
        steparray[step1].x[num] = steparray[step].x[i]
        steparray[step1].y[num] = steparray[step].y[i] + 1
        xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
      end
      if canpass(steparray[step].x[i], steparray[step].y[i] - 1) then
        num = num + 1
        steparray[step1].x[num] = steparray[step].x[i]
        steparray[step1].y[num] = steparray[step].y[i] - 1
        xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
      end
    end
    if 0 < num then
      steparray[step1].num = num
      FindNextStep(step1)
    end
  end
  
  steparray[0].num = 1
  steparray[0].x[1] = x
  steparray[0].y[1] = y
  xy[x][y] = 0
  FindNextStep(0)
  local movenum = xy[xx][yy]
  if movenum == nil then
    return
  end
  AutoMoveTab[0] = movenum
  for i = movenum, 1, -1 do
    if xy[xx - 1][yy] == i - 1 then
      xx = xx - 1
      AutoMoveTab[1 + movenum - i] = 1
    elseif xy[xx + 1][yy] == i - 1 then
      xx = xx + 1
      AutoMoveTab[1 + movenum - i] = 2
    elseif xy[xx][yy - 1] == i - 1 then
      yy = yy - 1
      AutoMoveTab[1 + movenum - i] = 3
    elseif xy[xx][yy + 1] == i - 1 then
      yy = yy + 1
      AutoMoveTab[1 + movenum - i] = 0
    end
  end
end

function saveglts(id)
  local filelen, bin, ts
  ts = CONFIG.DataPath .. string.format("save/t%d.grp", id)
  if existFile(ts) == false then
    bin = Byte.create(3000)
    Byte.savefile(bin, ts, 0, 3000)
  end
  filelen = filelength(ts)
  if filelen ~= 3000 then
    os.remove(ts)
    bin = Byte.create(3000)
    Byte.savefile(bin, ts, 0, 3000)
    filelen = filelength(ts)
  end
  JY.GLTS[14][0] = tonumber(os.date("%Y", os.time()))
  JY.GLTS[14][1] = tonumber(os.date("%m", os.time()))
  JY.GLTS[14][2] = tonumber(os.date("%d", os.time()))
  JY.GLTS[14][3] = tonumber(os.date("%H", os.time()))
  JY.GLTS[14][4] = tonumber(os.date("%M", os.time()))
  JY.GLTS[14][5] = tonumber(os.date("%S", os.time()))
  JY.GLTS[14][6] = JY.Book
  os.remove(ts)
  Byte.savefile(JY.Data_GLTS, ts, 0, 3000)
end

function loadglts(id)
  local filelen, bin, ts
  ts = CONFIG.DataPath .. string.format("save/t%d.grp", id)
  if id == 0 then
    os.remove(ts)
  end
  if existFile(ts) == false or id == 0 then
    bin = Byte.create(3000)
    Byte.savefile(bin, ts, 0, 3000)
  end
  filelen = 3000
  if filelen ~= 3000 then
    os.remove(ts)
    bin = Byte.create(3000)
    Byte.savefile(bin, ts, 0, 3000)
    filelen = filelength(ts)
  end
  if 0 < filelen then
    JY.Data_GLTS = Byte.create(filelen)
    Byte.loadfile(JY.Data_GLTS, ts, 0, filelen)
    for i = 0, 14 do
      JY.GLTS[i] = {}
      local meta_t = {
        __index = function(t, k)
          return GetDataFromStruct(JY.Data_GLTS, 200 * i, CC.GLTS_S, k)
        end,
        __newindex = function(t, k, v)
          SetDataFromStruct(JY.Data_GLTS, 200 * i, CC.GLTS_S, k, v)
        end
      }
      setmetatable(JY.GLTS[i], meta_t)
    end
    for i = 0, 13 do
      for j = 0, 99 do
        if 0 < JY.GLTS[i][j] then
          JY.GLTS[i][j] = 1
        else
          JY.GLTS[i][j] = 0
        end
      end
    end
  end
end

function SaveList(ins)
  local idxData = Byte.create(24)
  Byte.loadfile(idxData, CC.R_IDXFilename[0], 0, 24)
  local idx = {}
  idx[0] = 0
  for i = 1, 6 do
    idx[i] = Byte.get32(idxData, 4 * (i - 1))
  end
  local table_struct = {}
  table_struct.姓名 = {
    idx[1] + 8,
    2,
    10
  }
  table_struct["\181\200\188\182"] = {
    idx[1] + 30,
    0,
    2
  }
  table_struct.无用 = {
    idx[0] + 2,
    0,
    2
  }
  table_struct["\179\161\190\176\195\251\179\198"] = {
    idx[3] + 2,
    2,
    10
  }
  table_struct["\182\211\206\2331"] = {
    idx[0] + 24,
    0,
    2
  }
  local len = filelength(CC.R_GRPFilename[0])
  local data = Byte.create(len)
  local slen = filelength(CC.S_Filename[0])
  local sdata = Byte.create(slen)
  local tslen = 3000
  local tsdata = Byte.create(tslen)
  local menu = {}
  for i = 1, 11 do
    local name = ""
    local lv = ""
    local sname = ""
    local nd = ""
    local time = ""
    if existFile(string.format(CC.R_GRPFilename[i])) then
      Byte.loadfile(data, string.format(CC.R_GRPFilename[i]), 0, len)
      local pid = GetDataFromStruct(data, 0, table_struct, "\182\211\206\2331")
      name = GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "\208\213\195\251")
      lv = GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "\181\200\188\182") .. "\188\182"
      local wy = GetDataFromStruct(data, 0, table_struct, "\206\222\211\195")
      if wy == -1 then
        sname = "\180\243\181\216\205\188"
      else
        sname = GetDataFromStruct(data, wy * CC.SceneSize, table_struct, "\179\161\190\176\195\251\179\198") .. ""
      end
    end
    local str0 = ""
    local str1 = ""
    local str2 = ""
    local str3 = ""
    local str4 = ""
    local str5 = ""
    local str6 = ""
    if existFile(CONFIG.DataPath .. string.format("save/t%d.grp", i)) then
      str0 = "0000"
      str1 = "00"
      str2 = "00"
      str3 = "00"
      str4 = "00"
      str5 = "00"
      str6 = " 0"
      if filelength(CONFIG.DataPath .. string.format("save/t%d.grp", i)) == 3000 then
        Byte.loadfile(tsdata, CONFIG.DataPath .. string.format("save/t%d.grp", i), 0, tslen)
        local date0 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 0)
        local date1 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 1)
        local date2 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 2)
        local date3 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 3)
        local date4 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 4)
        local date5 = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 5)
        local mybook = GetDataFromStruct(tsdata, 2800, CC.GLTS_S, 6)
        if date0 == 0 then
          str0 = "000" .. tostring(date0)
        else
          str0 = tostring(date0)
        end
        if date1 < 10 then
          str1 = "0" .. tostring(date1)
        else
          str1 = tostring(date1)
        end
        if date2 < 10 then
          str2 = "0" .. tostring(date2)
        else
          str2 = tostring(date2)
        end
        if date3 < 10 then
          str3 = "0" .. tostring(date3)
        else
          str3 = tostring(date3)
        end
        if date4 < 10 then
          str4 = "0" .. tostring(date4)
        else
          str4 = tostring(date4)
        end
        if date5 < 10 then
          str5 = "0" .. tostring(date5)
        else
          str5 = tostring(date5)
        end
        menu[i] = {
          string.format("%2d: %-8s  %4s  %-8s  %2d\202\233  %4s/%2s/%2s %2s:%2s:%2s", i, name, lv, sname, mybook, str0, str1, str2, str3, str4, str5),
          nil,
          1
        }
      else
        menu[i] = {
          string.format("%2d: %-8s  %4s  %-8s  %2s\202\233  %4s/%2s/%2s %2s:%2s:%2s", i, name, lv, sname, str6, str0, str1, str2, str3, str4, str5),
          nil,
          1
        }
      end
    else
      menu[i] = {
        string.format("%2d: %-8s  %4s  %-8s  %2s\202\233  %4s/%2s/%2s %2s:%2s:%2s", i, name, lv, sname, str6, str0, str1, str2, str3, str4, str5),
        nil,
        1
      }
    end
  end
  local menux = (CC.ScreenW - 28 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2
  local menuy = (CC.ScreenH - 11 * (CC.DefaultFont + CC.RowPixel)) / 2
  if ins == nil then
    ins = 0
  end
  if ins == 15 then
    menu[12] = {
      "                   \187\216\188\210\203\175\190\245\200\165",
      nil,
      1
    }
  end
  if ins == 1 then
    menu[11][3] = 0
  end
  local r = ShowMenu(menu, #menu, #menu, menux, menuy, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
  CleanMemory()
  return r
end

function RWPD(did)
  if did <= 0 then
    return false
  end
  for i = 0, 13 do
    for j = 0, 99 do
      if CC.GLTS[i][j] == did then
        return true
      end
    end
  end
  return false
end

function XueTiao(x, y, xadd, yadd, minnum, maxnum, lmmax, color1, color2, yad)
  if color1 == nil then
    color1 = C_WHITE
  end
  if color2 == nil then
    color2 = RGB(200, 0, 0)
  end
  if yad == nil then
    yad = 0
  end
  local x0 = 0
  local y0 = 0
  if JY.Status == GAME_SMAP then
    x0 = JY.Base.人X1
    y0 = JY.Base.人Y1
    if x0 <= 7 then
      x0 = 8
    end
    if 52 <= x0 then
      x0 = 51
    end
    if y0 <= 7 then
      y0 = 8
    end
    if 52 <= y0 then
      y0 = 51
    end
  elseif JY.Status == GAME_WMAP then
    x0 = WAR.Person[WAR.CurID]["\215\248\177\234X"]
    y0 = WAR.Person[WAR.CurID]["\215\248\177\234Y"]
  elseif JY.Status == GAME_MMAP then
    x0 = JY.Base.人X
    y0 = JY.Base.人Y
  end
  local xyz = x - x0
  local yyz = y - y0
  local mvx1 = 0
  local mvy1 = 0
  if yyz < 0 then
    mvx1 = mvx1 + 1 * math.abs(yyz)
    mvy1 = mvy1 - 1 * math.abs(yyz)
  end
  if 0 < yyz then
    mvx1 = mvx1 - 1 * math.abs(yyz)
    mvy1 = mvy1 + 1 * math.abs(yyz)
  end
  if xyz < 0 then
    mvx1 = mvx1 - 1 * math.abs(xyz)
    mvy1 = mvy1 - 1 * math.abs(xyz)
  end
  if 0 < xyz then
    mvx1 = mvx1 + 1 * math.abs(xyz)
    mvy1 = mvy1 + 1 * math.abs(xyz)
  end
  local x1 = CC.ScreenW / 2 + CC.XScale * mvx1 - xadd / 2
  local y1 = CC.ScreenH / 2 + CC.YScale * mvy1 - CC.YScale * 8 + yad
  local x2 = x1 + math.modf(xadd * (maxnum / lmmax))
  local y2 = y1 + yadd
  if y2 - y1 < 3 then
    y2 = y1 + 3
  end
  if x2 - x1 < 3 then
    x2 = x1 + 3
  end
  lib.DrawRect(x1, y1, x2, y1, color1)
  lib.DrawRect(x1, y2, x2, y2, color1)
  lib.DrawRect(x1, y1, x1, y2, color1)
  lib.DrawRect(x2, y1, x2, y2, color1)
  local rr, gg, bb = GetRGB(color2)
  local bx2 = x1 + math.modf((x2 - x1) * (minnum / maxnum))
  local k = 0
  if rr > k then
    k = rr
  end
  if gg > k then
    k = gg
  end
  if bb > k then
    k = bb
  end
  local a1 = 0
  local a2 = 0
  local a3 = 0
  local bf = (k - k / 5) / (bx2 - x1 - 1)
  if k == rr then
    a1 = bf
  elseif k == gg then
    a2 = bf
  elseif k == bb then
    a3 = bf
  end
  for i = 1, bx2 - x1 - 1 do
    local r, g, b
    if 0 < a1 then
      r = (math.modf(rr / 5) + math.modf(i * a1)) % 256
    else
      r = rr
    end
    if 0 < a2 then
      g = (math.modf(gg / 5) + math.modf(i * a2)) % 256
    else
      g = gg
    end
    if 0 < a3 then
      b = (math.modf(bb / 5) + math.modf(i * a3)) % 256
    else
      b = bb
    end
    lib.DrawRect(x1 + i, y1 + 1, x1 + i, y2 - 1, RGB(rr, gg, bb))
  end
  if bx2 < x2 - 1 then
    lib.Background(bx2, y1 + 1, x2 - 1, y2 - 1, 128)
  end
end

function ShowXT()
  for i = 0, WAR.PersonNum - 1 do
    if WAR.Person[i].死亡 == false then
      local pid = WAR.Person[i]["\200\203\206\239\177\224\186\197"]
      local size = CC.DefaultFont * 0.8 * CONFIG.Zoom / 100 / 2
      local rwsm = JY.Person[pid].生命
      local rwsm1 = "/" .. JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
      local xx = WAR.Person[i]["\215\248\177\234X"]
      local yy = WAR.Person[i]["\215\248\177\234Y"]
      local xad = math.modf(size * 2.5)
      local yad = math.modf(size * 0.3)
      local yoff = math.modf(size * 0.8)
      if 0 < rwsm then
        if WAR.Person[i]["\206\210\183\189"] == false then
          XueTiao(xx, yy, xad, yad, JY.Person[pid].生命, JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"], CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"], nil, nil, yoff)
        else
          XueTiao(xx, yy, xad, yad, JY.Person[pid].生命, JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"], CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"], C_WHITE, RGB(0, 0, 200), yoff)
        end
      end
    end
  end
end

function ShowZhi(x, y)
  local pid = WAR.Person[GetWarMap(x, y, 2)]["\200\203\206\239\177\224\186\197"]
  local size = CC.DefaultFont * CONFIG.Zoom / 100 / 2
  local zhisize = math.modf(size * 0.6)
  local rwsm = JY.Person[pid].生命
  local rwsm1 = "/" .. JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"]
  local yoff = -math.modf(size * 0.6)
  YYZhi(x, y, nil, 0, 0, 180)
  if rwsm < JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] then
    if rwsm > JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 3 * 2 then
      YYZhi(x, y, string.format("%3d" .. rwsm1, rwsm), nil, nil, nil, C_GOLD, zhisize, 0, yoff)
    elseif rwsm > JY.Person[pid]["\201\250\195\252\215\238\180\243\214\181"] / 3 then
      YYZhi(x, y, string.format("%3d" .. rwsm1, rwsm), nil, nil, nil, C_SHOUSHANG2, zhisize, 0, yoff)
    else
      YYZhi(x, y, string.format("%3d" .. rwsm1, rwsm), nil, nil, nil, C_RED, zhisize, 0, yoff)
    end
  else
    YYZhi(x, y, string.format("%3d" .. rwsm1, rwsm), nil, nil, nil, C_GOLD, zhisize, 0, yoff)
  end
end

function ReadBin()
  local filelen, bin, leave, effect, match, levelup, v
  leave = CONFIG.DataPath .. "list/leave.bin"
  effect = CONFIG.DataPath .. "list/effect.bin"
  match = CONFIG.DataPath .. "list/match.bin"
  levelup = CONFIG.DataPath .. "list/levelup.bin"
  filelen = filelength(leave)
  if 0 < filelen then
    bin = Byte.create(filelen)
    Byte.loadfile(bin, leave, 0, filelen)
    CC.PersonExit = {}
    for i = 1, filelen / 2 do
      v = Byte.get16(bin, i * 2 - 2)
      CC.PersonExit[i] = {
        v,
        CC.Leave + i * 2 - 2
      }
    end
  end
  filelen = filelength(effect)
  if 0 < filelen then
    bin = Byte.create(filelen)
    Byte.loadfile(bin, effect, 0, filelen)
    CC.Effect = {}
    for i = 0, filelen / 2 - 1 do
      v = Byte.get16(bin, i * 2)
      CC.Effect[i] = v
    end
  end
  CC.Effect[0] = CC.Effect[0] - 1
  filelen = filelength(match)
  if 0 < filelen then
    bin = Byte.create(filelen)
    Byte.loadfile(bin, match, 0, filelen)
    CC.ExtraOffense = {}
    for i = 0, filelen / 3 - 1 do
      CC.ExtraOffense[i + 1] = {
        Byte.get16(bin, i * 6),
        Byte.get16(bin, i * 6 + 2),
        Byte.get16(bin, i * 6 + 4)
      }
    end
  end
  filelen = filelength(levelup)
  if 0 < filelen then
    bin = Byte.create(filelen)
    Byte.loadfile(bin, levelup, 0, filelen)
    CC.Exp = {}
    for i = 1, filelen / 2 do
      v = Byte.get16(bin, i * 2 - 2)
      CC.Exp[i] = v
    end
  end
end

function wdtest()
  JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"] = CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"]
  JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"] = CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"]
  JY.Person[0].生命 = JY.Person[0]["\201\250\195\252\215\238\180\243\214\181"]
  JY.Person[0]["\196\218\193\166"] = JY.Person[0]["\196\218\193\166\215\238\180\243\214\181"]
  JY.Person[0]["\185\165\187\247\193\166"] = CC.PersonAttribMax["\185\165\187\247\193\166"]
  JY.Person[0]["\183\192\211\249\193\166"] = CC.PersonAttribMax["\183\192\211\249\193\166"]
  JY.Person[0]["\199\225\185\166"] = CC.PersonAttribMax["\199\225\185\166"]
  JY.Person[0]["\210\189\193\198\196\220\193\166"] = CC.PersonAttribMax["\210\189\193\198\196\220\193\166"]
  JY.Person[0]["\211\195\182\190\196\220\193\166"] = CC.PersonAttribMax["\211\195\182\190\196\220\193\166"]
  JY.Person[0]["\189\226\182\190\196\220\193\166"] = CC.PersonAttribMax["\189\226\182\190\196\220\193\166"]
  JY.Person[0]["\191\185\182\190\196\220\193\166"] = CC.PersonAttribMax["\191\185\182\190\196\220\193\166"]
  JY.Person[0]["\200\173\213\198\185\166\183\242"] = CC.PersonAttribMax["\200\173\213\198\185\166\183\242"]
  JY.Person[0]["\211\249\189\163\196\220\193\166"] = CC.PersonAttribMax["\211\249\189\163\196\220\193\166"]
  JY.Person[0]["\203\163\181\182\188\188\199\201"] = CC.PersonAttribMax["\203\163\181\182\188\188\199\201"]
  JY.Person[0]["\204\216\202\226\177\248\198\247"] = CC.PersonAttribMax["\204\216\202\226\177\248\198\247"]
  JY.Person[0]["\176\181\198\247\188\188\199\201"] = CC.PersonAttribMax["\176\181\198\247\188\188\199\201"]
  JY.Person[0]["\206\228\209\167\179\163\202\182"] = CC.PersonAttribMax["\206\228\209\167\179\163\202\182"]
  JY.Person[0]["\201\250\195\252\212\246\179\164"] = 7
  JY.Person[0].外号 = "\179\172\201\241"
  JY.Person[0]["\196\218\193\166\208\212\214\202"] = 2
  JY.Person[0]["\202\220\201\203\179\204\182\200"] = 0
  JY.Person[0]["\214\208\182\190\179\204\182\200"] = 0
  local gjmax = 0
  local maxid = 1
  for i = 1, 1000 do
    if JY.Wugong[i] ~= nil then
      if JY.Wugong[i]["\185\165\187\247\183\182\206\167"] == 3 and gjmax < JY.Wugong[i]["\185\165\187\247\193\16610"] then
        gjmax = JY.Wugong[i]["\185\165\187\247\193\16610"]
        maxid = i
      end
    else
      break
    end
  end
  local add = 0
  for i = 1, 10 do
    if JY.Person[0]["\206\228\185\166" .. i] == 0 then
      JY.Person[0]["\206\228\185\166" .. i] = maxid
      JY.Person[0]["\206\228\185\166\181\200\188\182" .. i] = 900
      add = 1
      break
    end
  end
  if add == 0 then
    JY.Person[0]["\206\228\185\16610"] = maxid
    JY.Person[0]["\206\228\185\166\181\200\188\18210"] = 900
  end
  JY.SubScene = 56
  Init_MMap()
  oldCallEvent(256)
end
