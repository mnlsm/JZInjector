function SetGlobalConst()
  VK_ESCAPE = 27
  
  VK_Y = 121
  VK_N = 110
  VK_H = 104
  VK_S = 115
  VK_SPACE = 32
  VK_RETURN = 13
  VK_UP = 1073741906
  VK_DOWN = 1073741905
  VK_LEFT = 1073741904
  VK_RIGHT = 1073741903
  if CONFIG.Operation == 1 then
    VK_SPACE = VK_RETURN
  end
  C_STARTMENU = RGB(132, 0, 4)
  C_RED = RGB(216, 20, 24)
  C_WHITE = RGB(236, 236, 236)
  C_ORANGE = RGB(252, 148, 16)
  C_GOLD = RGB(236, 200, 40)
  C_BLACK = RGB(0, 0, 0)
  C_STARTMENU = RGB(132, 0, 4)
  C_RED = RGB(216, 20, 24)
  C_WHITE = RGB(236, 236, 236)
  C_ORANGE = RGB(252, 148, 16)
  C_GOLD = RGB(236, 200, 40)
  C_BLACK = RGB(0, 0, 0)
  M_Black = RGB(0, 0, 0)
  M_Sienna = RGB(160, 82, 45)
  M_DarkOliveGreen = RGB(85, 107, 47)
  M_DarkGreen = RGB(0, 100, 0)
  M_DarkSlateBlue = RGB(72, 61, 139)
  M_Navy = RGB(0, 0, 128)
  M_Indigo = RGB(75, 0, 130)
  M_DarkSlateGray = RGB(47, 79, 79)
  M_DarkRed = RGB(139, 0, 0)
  M_DarkOrange = RGB(255, 140, 0)
  M_Olive = RGB(128, 128, 0)
  M_Green = RGB(0, 128, 0)
  M_Teal = RGB(0, 128, 128)
  M_Blue = RGB(0, 0, 255)
  M_SlateGray = RGB(112, 128, 144)
  M_DimGray = RGB(105, 105, 105)
  M_Red = RGB(255, 0, 0)
  M_SandyBrown = RGB(244, 164, 96)
  M_YellowGreen = RGB(154, 205, 50)
  M_SeaGreen = RGB(46, 139, 87)
  M_MediumTurquoise = RGB(72, 209, 204)
  M_RoyalBlue = RGB(65, 105, 225)
  M_Purple = RGB(128, 0, 128)
  M_Gray = RGB(128, 128, 128)
  M_Magenta = RGB(255, 0, 255)
  M_Orange = RGB(255, 165, 0)
  M_Yellow = RGB(255, 255, 0)
  M_Lime = RGB(0, 255, 0)
  M_Cyan = RGB(0, 255, 255)
  M_DeepSkyBlue = RGB(0, 191, 255)
  M_DarkOrchid = RGB(153, 50, 204)
  M_Silver = RGB(192, 192, 192)
  M_Pink = RGB(255, 192, 203)
  M_Wheat = RGB(245, 222, 179)
  M_LemonChiffon = RGB(255, 250, 205)
  M_PaleGreen = RGB(152, 251, 152)
  M_PaleTurquoise = RGB(175, 238, 238)
  M_LightBlue = RGB(173, 216, 230)
  M_Plum = RGB(221, 160, 221)
  M_White = RGB(255, 255, 255)
  C_SHOUSHANG1 = RGB(236, 200, 40)
  C_SHOUSHANG2 = RGB(255, 192, 203)
  C_SHOUSHANG3 = RGB(255, 192, 203)
  GAME_START = 0
  GAME_FIRSTMMAP = 1
  GAME_MMAP = 2
  GAME_FIRSTSMAP = 3
  GAME_SMAP = 4
  GAME_WMAP = 5
  GAME_DEAD = 6
  GAME_END = 7
  CC = {}
  CC.SrcCharSet = 0
  CC.OSCharSet = CONFIG.OSCharSet
  CC.FontName = CONFIG.FontName
  CC.ScreenW = CONFIG.Width
  CC.ScreenH = CONFIG.Height
  CC.ScreenW = lib.GetScreenW()
  CC.ScreenH = lib.GetScreenH()
  CC.BanBen = 0
  if CONFIG.MOD ~= nil then
    CC.BanBen = CONFIG.MOD
  end
  CC.BoxLine = CC.ScreenH / 360
  CC.Zoom = CONFIG.Zoom / 100
  if CONFIG.Zoom ~= math.modf(CONFIG.Height / 360 * 10) * 10 then
    CC.Zoom = math.modf(CONFIG.Height / 360 * 10) * 10 / 100
  end
  CC.Zoom = math.modf(CONFIG.Height / 360 * 10) * 10 / 100
  CC.TempS_Filename = CONFIG.DataPath .. "allsinbk.grp"
  CC.D_Filename = {
    [0] = CONFIG.DataPath .. "alldef.grp"
  }
  CC.R_IDXFilename = {
    [0] = CONFIG.DataPath .. "ranger.idx"
  }
  CC.R_GRPFilename = {
    [0] = CONFIG.DataPath .. "ranger.grp"
  }
  CC.S_Filename = {
    [0] = CONFIG.DataPath .. "allsin.grp"
  }
  for i = 1, 11 do
    CC.R_IDXFilename[i] = CONFIG.DataPath .. string.format("save/r%d.idx", i)
    CC.R_GRPFilename[i] = CONFIG.DataPath .. string.format("save/r%d.grp", i)
    CC.S_Filename[i] = CONFIG.DataPath .. string.format("save/s%d.grp", i)
    CC.D_Filename[i] = CONFIG.DataPath .. string.format("save/d%d.grp", i)
  end
  CC.PaletteFile = CONFIG.DataPath .. "mmap.col"
  if 1 >= CC.ScreenW then
    if CC.BanBen == 0 then
      CC.FirstFile = CONFIG.PicturePath .. "YB1.png"
    elseif CC.BanBen == 1 then
      CC.FirstFile = CONFIG.PicturePath .. "CL1.png"
    elseif CC.BanBen == 2 then
      CC.FirstFile = CONFIG.PicturePath .. "ZZJH1.png"
    elseif CC.BanBen == 3 then
      CC.FirstFile = CONFIG.PicturePath .. "PTT1.png"
    elseif CC.BanBen == 4 then
      CC.FirstFile = CONFIG.PicturePath .. "TSJ1.png"
    elseif CC.BanBen == 5 then
      CC.FirstFile = CONFIG.PicturePath .. "CL10281.png"
    end
  elseif CC.BanBen == 0 then
    CC.FirstFile = CONFIG.PicturePath .. "YB.png"
  elseif CC.BanBen == 1 then
    CC.FirstFile = CONFIG.PicturePath .. "CL.png"
  elseif CC.BanBen == 2 then
    CC.FirstFile = CONFIG.PicturePath .. "ZZJH.png"
  elseif CC.BanBen == 3 then
    CC.FirstFile = CONFIG.PicturePath .. "PTT.png"
  elseif CC.BanBen == 4 then
    CC.FirstFile = CONFIG.PicturePath .. "TSJ.png"
  elseif CC.BanBen == 5 then
    CC.FirstFile = CONFIG.PicturePath .. "CL1028.png"
  end
  CC.DeadFile = CONFIG.PicturePath .. "dead.png"
  CC.MMapFile = {
    CONFIG.DataPath .. "earth.002",
    CONFIG.DataPath .. "surface.002",
    CONFIG.DataPath .. "building.002",
    CONFIG.DataPath .. "buildx.002",
    CONFIG.DataPath .. "buildy.002"
  }
  CC.MMAPPicFile = {
    CONFIG.DataPath .. "mmap.idx",
    CONFIG.DataPath .. "mmap.grp"
  }
  CC.SMAPPicFile = {
    CONFIG.DataPath .. "smap.idx",
    CONFIG.DataPath .. "smap.grp"
  }
  CC.WMAPPicFile = {
    CONFIG.DataPath .. "wmap.idx",
    CONFIG.DataPath .. "wmap.grp"
  }
  CC.EffectFile = {
    CONFIG.DataPath .. "eft.idx",
    CONFIG.DataPath .. "eft.grp"
  }
  CC.FightPicFile = {
    CONFIG.DataPath .. "fight/fight%03d.idx",
    CONFIG.DataPath .. "fight/fight%03d.grp"
  }
  CC.HeadPicFile = {
    CONFIG.DataPath .. "hdgrp.idx",
    CONFIG.DataPath .. "hdgrp.grp"
  }
  CC.ThingPicFile = {
    CONFIG.DataPath .. "thing.idx",
    CONFIG.DataPath .. "thing.grp"
  }
  CC.MIDIFile = CONFIG.SoundPath .. "game%02d.mid"
  CC.ATKFile = CONFIG.SoundPath .. "atk%02d.wav"
  CC.EFile = CONFIG.SoundPath .. "e%02d.wav"
  if CONFIG.MP3 == 1 then
    CC.MIDIFile = CONFIG.CurrentPath .. "sound/" .. "game%02d.mp3"
  else
    CC.MIDIFile = CONFIG.SoundPath .. "game%02d.mid"
  end
  CC.WarFile = CONFIG.DataPath .. "war.sta"
  CC.WarMapFile = {
    CONFIG.DataPath .. "warfld.idx",
    CONFIG.DataPath .. "warfld.grp"
  }
  CC.TalkIdxFile = CONFIG.ScriptPath .. "oldtalk.idx"
  CC.TalkGrpFile = CONFIG.ScriptPath .. "oldtalk.grp"
  if 1 < CC.BanBen then
    CC.KRP = CONFIG.DataPath .. "kdef.grp"
    CC.KDX = CONFIG.DataPath .. "kdef.idx"
    CC.TRP = CONFIG.DataPath .. "talk.grp"
    CC.TDX = CONFIG.DataPath .. "talk.idx"
  end
  CC.HeadPath = CONFIG.HeadPath
  CC.HeadNum = 400
  CC.TeamNum = 6
  CC.MyThingNum = 886
  if CC.BanBen == 5 then
    CC.TeamNum = 12
  end
  CC.Base_S = {}
  CC.Base_S["\179\203\180\172"] = {
    0,
    0,
    2
  }
  CC.Base_S.无用 = {
    2,
    0,
    2
  }
  CC.Base_S.人X = {
    4,
    0,
    2
  }
  CC.Base_S.人Y = {
    6,
    0,
    2
  }
  CC.Base_S.人X1 = {
    8,
    0,
    2
  }
  CC.Base_S.人Y1 = {
    10,
    0,
    2
  }
  CC.Base_S["\200\203\183\189\207\242"] = {
    12,
    0,
    2
  }
  CC.Base_S["\180\172X"] = {
    14,
    0,
    2
  }
  CC.Base_S["\180\172Y"] = {
    16,
    0,
    2
  }
  CC.Base_S["\180\172X1"] = {
    18,
    0,
    2
  }
  CC.Base_S["\180\172Y1"] = {
    20,
    0,
    2
  }
  CC.Base_S["\180\172\183\189\207\242"] = {
    22,
    0,
    2
  }
  for i = 1, CC.TeamNum do
    CC.Base_S["\182\211\206\233" .. i] = {
      24 + 2 * (i - 1),
      0,
      2
    }
  end
  for i = 1, CC.MyThingNum do
    CC.Base_S["\206\239\198\183" .. i] = {
      36 + 4 * (i - 1) + 2 * (CC.TeamNum - 6),
      0,
      2
    }
    CC.Base_S["\206\239\198\183\202\253\193\191" .. i] = {
      36 + 4 * (i - 1) + 2 + 2 * (CC.TeamNum - 6),
      0,
      2
    }
  end
  CC.Timer = {
    stime = 0,
    status = 0,
    str = "",
    len = 0,
    fun = demostr
  }
  if CC.BanBen == 0 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\193\183\185\166\181\227\205\198\188\246 \179\245\198\218\184\247\195\197\197\201\202\216\195\197\200\203 \214\208\198\218\189\240\187\168\198\197\198\197/\189\240\194\214\203\194 \186\243\198\218\190\205\213\210\192\207\205\231\205\175\176\201",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 6
  elseif CC.BanBen == 1 then
    CC.RUNSTR = {
      "\181\208\200\203\187\225\184\249\190\221\215\212\180\180\206\228\185\166\181\196\214\216\202\253\214\240\189\165\212\246\199\191",
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\193\183\185\166\181\227\205\198\188\246 \179\245\198\218\199\224\179\199\197\201->\201\217\193\214\203\194->\214\216\209\244\185\172 \214\208\198\218\189\240\193\250\176\239 \186\243\198\218\190\205\213\210\192\207\205\231\205\175\176\201",
      "\181\177\180\239\181\189\210\187\182\168\181\196\204\245\188\254\202\177 \191\201\210\212\215\212\180\180\206\228\185\166",
      "\208\194\212\246\176\203\184\246\204\216\202\226\179\245\202\188\189\199\201\171\191\201\185\169\209\161\212\241 \200\173\176\212 \189\163\196\167 \181\182\179\213 \204\216\191\241 \201\241\214\250 \206\215\209\253 \182\190\205\245 \187\195\211\176",
      "\181\177\199\176\203\249\211\195MOD\206\170\178\212\193\250\214\240\200\213\163\172MOD\215\247\213\223\206\170 \208\161\208\161\214\237",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 10
  elseif CC.BanBen == 2 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\179\245\198\218\191\201\207\200\188\211\200\235\195\197\197\201 \189\211\239\218\215\172\199\174 \205\218\191\243\180\242\212\236\206\228\198\247 \185\254\200\248\191\203\181\196\203\213\198\213\202\199\179\245\198\218\178\187\180\237\181\196\193\183\185\166\181\227",
      "\181\177\199\176\203\249\211\195MOD\206\170\212\217\213\189\189\173\186\254\163\172MOD\215\247\213\223\206\170 \196\207\185\172\195\206",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 7
  elseif CC.BanBen == 3 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\181\177\199\176\203\249\211\195MOD\206\170\204\168\205\229\207\231\195\241\176\230\163\172MOD\215\247\213\223\206\170 leo32145",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 6
  elseif CC.BanBen == 4 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\181\177\199\176\203\249\211\195MOD\206\170\204\236\202\233\189\217\163\172MOD\215\247\213\223\206\170 henvgui1987",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 6
  elseif CC.BanBen == 5 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 5
  elseif CC.BanBen == 6 then
    CC.RUNSTR = {
      "\199\235\190\161\191\201\196\220\182\224\197\224\209\248\210\187\208\169\182\211\211\209",
      "\201\232\214\195\206\196\188\254\195\251\206\170\161\176set.ini\161\177  \191\201\210\212\212\218\192\239\195\230\184\252\184\196\214\247\189\199\208\213\195\251\186\205\210\187\208\169\179\163\211\195\181\196\201\232\214\195",
      "\183\201\209\169\193\172\204\236\201\228\176\215\194\185  \208\166\202\233\201\241\207\192\210\208\177\204\212\167  \196\170\206\202\190\253\215\211\176\174\196\196\176\227  \199\227\199\233\215\168\215\162\200\186\207\192\180\171",
      "\211\206\207\183\192\239\176\180S\188\252\206\170\180\171\203\205\185\166\196\220\163\172H\188\252\206\170\215\212\182\175\180\230\181\181",
      ""
    }
    CC.NUMBER = 5
  end
  if CONFIG.Remind == nil then
    CONFIG.Remind = 0
  end
  if CONFIG.Remind == 0 then
    CC.OpenTimmerRemind = 0
  elseif CONFIG.Remind == 1 then
    CC.OpenTimmerRemind = 1
  end
  CC.AutoMoveEvent = {
    [0] = 0
  }
  CC.MMapAdress = {}
  CC.PersonSize = 182
  CC.Person_S = {}
  CC.Person_S["\180\250\186\197"] = {
    0,
    0,
    2
  }
  CC.Person_S["\205\183\207\241\180\250\186\197"] = {
    2,
    0,
    2
  }
  CC.Person_S["\201\250\195\252\212\246\179\164"] = {
    4,
    0,
    2
  }
  CC.Person_S.无用 = {
    6,
    0,
    2
  }
  CC.Person_S.姓名 = {
    8,
    2,
    10
  }
  CC.Person_S.外号 = {
    18,
    2,
    10
  }
  CC.Person_S["\208\212\177\240"] = {
    28,
    0,
    2
  }
  CC.Person_S["\181\200\188\182"] = {
    30,
    0,
    2
  }
  CC.Person_S["\190\173\209\233"] = {
    32,
    1,
    2
  }
  CC.Person_S.生命 = {
    34,
    0,
    2
  }
  CC.Person_S["\201\250\195\252\215\238\180\243\214\181"] = {
    36,
    0,
    2
  }
  CC.Person_S["\202\220\201\203\179\204\182\200"] = {
    38,
    0,
    2
  }
  CC.Person_S["\214\208\182\190\179\204\182\200"] = {
    40,
    0,
    2
  }
  CC.Person_S["\204\229\193\166"] = {
    42,
    0,
    2
  }
  CC.Person_S["\206\239\198\183\208\222\193\182\181\227\202\253"] = {
    44,
    0,
    2
  }
  CC.Person_S["\206\228\198\247"] = {
    46,
    0,
    2
  }
  CC.Person_S["\183\192\190\223"] = {
    48,
    0,
    2
  }
  for i = 1, 5 do
    CC.Person_S["\179\246\213\208\182\175\187\173\214\161\202\253" .. i] = {
      50 + 2 * (i - 1),
      0,
      2
    }
    CC.Person_S["\179\246\213\208\182\175\187\173\209\211\179\217" .. i] = {
      60 + 2 * (i - 1),
      0,
      2
    }
    CC.Person_S["\206\228\185\166\210\244\208\167\209\211\179\217" .. i] = {
      70 + 2 * (i - 1),
      0,
      2
    }
  end
  CC.Person_S["\196\218\193\166\208\212\214\202"] = {
    80,
    0,
    2
  }
  CC.Person_S["\196\218\193\166"] = {
    82,
    0,
    2
  }
  CC.Person_S["\196\218\193\166\215\238\180\243\214\181"] = {
    84,
    0,
    2
  }
  CC.Person_S["\185\165\187\247\193\166"] = {
    86,
    0,
    2
  }
  CC.Person_S["\199\225\185\166"] = {
    88,
    0,
    2
  }
  CC.Person_S["\183\192\211\249\193\166"] = {
    90,
    0,
    2
  }
  CC.Person_S["\210\189\193\198\196\220\193\166"] = {
    92,
    0,
    2
  }
  CC.Person_S["\211\195\182\190\196\220\193\166"] = {
    94,
    0,
    2
  }
  CC.Person_S["\189\226\182\190\196\220\193\166"] = {
    96,
    0,
    2
  }
  CC.Person_S["\191\185\182\190\196\220\193\166"] = {
    98,
    0,
    2
  }
  CC.Person_S["\200\173\213\198\185\166\183\242"] = {
    100,
    0,
    2
  }
  CC.Person_S["\211\249\189\163\196\220\193\166"] = {
    102,
    0,
    2
  }
  CC.Person_S["\203\163\181\182\188\188\199\201"] = {
    104,
    0,
    2
  }
  CC.Person_S["\204\216\202\226\177\248\198\247"] = {
    106,
    0,
    2
  }
  CC.Person_S["\176\181\198\247\188\188\199\201"] = {
    108,
    0,
    2
  }
  CC.Person_S["\206\228\209\167\179\163\202\182"] = {
    110,
    0,
    2
  }
  CC.Person_S["\198\183\181\194"] = {
    112,
    0,
    2
  }
  CC.Person_S["\185\165\187\247\180\248\182\190"] = {
    114,
    0,
    2
  }
  CC.Person_S["\215\243\211\210\187\165\178\171"] = {
    116,
    0,
    2
  }
  CC.Person_S.声望 = {
    118,
    0,
    2
  }
  CC.Person_S["\215\202\214\202"] = {
    120,
    0,
    2
  }
  CC.Person_S["\208\222\193\182\206\239\198\183"] = {
    122,
    0,
    2
  }
  CC.Person_S["\208\222\193\182\181\227\202\253"] = {
    124,
    0,
    2
  }
  for i = 1, 10 do
    CC.Person_S["\206\228\185\166" .. i] = {
      126 + 2 * (i - 1),
      0,
      2
    }
    CC.Person_S["\206\228\185\166\181\200\188\182" .. i] = {
      146 + 2 * (i - 1),
      0,
      2
    }
  end
  for i = 1, 4 do
    CC.Person_S["\208\175\180\248\206\239\198\183" .. i] = {
      166 + 2 * (i - 1),
      0,
      2
    }
    CC.Person_S["\208\175\180\248\206\239\198\183\202\253\193\191" .. i] = {
      174 + 2 * (i - 1),
      0,
      2
    }
  end
  CC.ThingSize = 190
  CC.Thing_S = {}
  CC.Thing_S["\180\250\186\197"] = {
    0,
    0,
    2
  }
  CC.Thing_S["\195\251\179\198"] = {
    2,
    2,
    20
  }
  CC.Thing_S["\195\251\179\1982"] = {
    22,
    2,
    20
  }
  CC.Thing_S["\206\239\198\183\203\181\195\247"] = {
    42,
    2,
    30
  }
  CC.Thing_S["\193\183\179\246\206\228\185\166"] = {
    72,
    0,
    2
  }
  CC.Thing_S["\176\181\198\247\182\175\187\173\177\224\186\197"] = {
    74,
    0,
    2
  }
  CC.Thing_S["\202\185\211\195\200\203"] = {
    76,
    0,
    2
  }
  CC.Thing_S["\215\176\177\184\192\224\208\205"] = {
    78,
    0,
    2
  }
  CC.Thing_S["\207\212\202\190\206\239\198\183\203\181\195\247"] = {
    80,
    0,
    2
  }
  CC.Thing_S.类型 = {
    82,
    0,
    2
  }
  CC.Thing_S["\206\180\214\1705"] = {
    84,
    0,
    2
  }
  CC.Thing_S["\206\180\214\1706"] = {
    86,
    0,
    2
  }
  CC.Thing_S["\206\180\214\1707"] = {
    88,
    0,
    2
  }
  CC.Thing_S["\188\211\201\250\195\252"] = {
    90,
    0,
    2
  }
  CC.Thing_S["\188\211\201\250\195\252\215\238\180\243\214\181"] = {
    92,
    0,
    2
  }
  CC.Thing_S["\188\211\214\208\182\190\189\226\182\190"] = {
    94,
    0,
    2
  }
  CC.Thing_S["\188\211\204\229\193\166"] = {
    96,
    0,
    2
  }
  CC.Thing_S["\184\196\177\228\196\218\193\166\208\212\214\202"] = {
    98,
    0,
    2
  }
  CC.Thing_S["\188\211\196\218\193\166"] = {
    100,
    0,
    2
  }
  CC.Thing_S["\188\211\196\218\193\166\215\238\180\243\214\181"] = {
    102,
    0,
    2
  }
  CC.Thing_S["\188\211\185\165\187\247\193\166"] = {
    104,
    0,
    2
  }
  CC.Thing_S["\188\211\199\225\185\166"] = {
    106,
    0,
    2
  }
  CC.Thing_S["\188\211\183\192\211\249\193\166"] = {
    108,
    0,
    2
  }
  CC.Thing_S["\188\211\210\189\193\198\196\220\193\166"] = {
    110,
    0,
    2
  }
  CC.Thing_S["\188\211\211\195\182\190\196\220\193\166"] = {
    112,
    0,
    2
  }
  CC.Thing_S["\188\211\189\226\182\190\196\220\193\166"] = {
    114,
    0,
    2
  }
  CC.Thing_S["\188\211\191\185\182\190\196\220\193\166"] = {
    116,
    0,
    2
  }
  CC.Thing_S["\188\211\200\173\213\198\185\166\183\242"] = {
    118,
    0,
    2
  }
  CC.Thing_S["\188\211\211\249\189\163\196\220\193\166"] = {
    120,
    0,
    2
  }
  CC.Thing_S["\188\211\203\163\181\182\188\188\199\201"] = {
    122,
    0,
    2
  }
  CC.Thing_S["\188\211\204\216\202\226\177\248\198\247"] = {
    124,
    0,
    2
  }
  CC.Thing_S["\188\211\176\181\198\247\188\188\199\201"] = {
    126,
    0,
    2
  }
  CC.Thing_S["\188\211\206\228\209\167\179\163\202\182"] = {
    128,
    0,
    2
  }
  CC.Thing_S["\188\211\198\183\181\194"] = {
    130,
    0,
    2
  }
  CC.Thing_S["\188\211\185\165\187\247\180\206\202\253"] = {
    132,
    0,
    2
  }
  CC.Thing_S["\188\211\185\165\187\247\180\248\182\190"] = {
    134,
    0,
    2
  }
  CC.Thing_S["\189\246\208\222\193\182\200\203\206\239"] = {
    136,
    0,
    2
  }
  CC.Thing_S["\208\232\196\218\193\166\208\212\214\202"] = {
    138,
    0,
    2
  }
  CC.Thing_S["\208\232\196\218\193\166"] = {
    140,
    0,
    2
  }
  CC.Thing_S["\208\232\185\165\187\247\193\166"] = {
    142,
    0,
    2
  }
  CC.Thing_S["\208\232\199\225\185\166"] = {
    144,
    0,
    2
  }
  CC.Thing_S["\208\232\211\195\182\190\196\220\193\166"] = {
    146,
    0,
    2
  }
  CC.Thing_S["\208\232\210\189\193\198\196\220\193\166"] = {
    148,
    0,
    2
  }
  CC.Thing_S["\208\232\189\226\182\190\196\220\193\166"] = {
    150,
    0,
    2
  }
  CC.Thing_S["\208\232\200\173\213\198\185\166\183\242"] = {
    152,
    0,
    2
  }
  CC.Thing_S["\208\232\211\249\189\163\196\220\193\166"] = {
    154,
    0,
    2
  }
  CC.Thing_S["\208\232\203\163\181\182\188\188\199\201"] = {
    156,
    0,
    2
  }
  CC.Thing_S["\208\232\204\216\202\226\177\248\198\247"] = {
    158,
    0,
    2
  }
  CC.Thing_S["\208\232\176\181\198\247\188\188\199\201"] = {
    160,
    0,
    2
  }
  CC.Thing_S["\208\232\215\202\214\202"] = {
    162,
    0,
    2
  }
  CC.Thing_S["\208\232\190\173\209\233"] = {
    164,
    0,
    2
  }
  CC.Thing_S["\193\183\179\246\206\239\198\183\208\232\190\173\209\233"] = {
    166,
    0,
    2
  }
  CC.Thing_S["\208\232\178\196\193\207"] = {
    168,
    0,
    2
  }
  for i = 1, 5 do
    CC.Thing_S["\193\183\179\246\206\239\198\183" .. i] = {
      170 + 2 * (i - 1),
      0,
      2
    }
    CC.Thing_S["\208\232\210\170\206\239\198\183\202\253\193\191" .. i] = {
      180 + 2 * (i - 1),
      0,
      2
    }
  end
  CC.SceneSize = 52
  CC.Scene_S = {}
  CC.Scene_S["\180\250\186\197"] = {
    0,
    0,
    2
  }
  CC.Scene_S["\195\251\179\198"] = {
    2,
    2,
    10
  }
  CC.Scene_S["\179\246\195\197\210\244\192\214"] = {
    12,
    0,
    2
  }
  CC.Scene_S["\189\248\195\197\210\244\192\214"] = {
    14,
    0,
    2
  }
  CC.Scene_S["\204\248\215\170\179\161\190\176"] = {
    16,
    0,
    2
  }
  CC.Scene_S["\189\248\200\235\204\245\188\254"] = {
    18,
    0,
    2
  }
  CC.Scene_S["\205\226\190\176\200\235\191\218X1"] = {
    20,
    0,
    2
  }
  CC.Scene_S["\205\226\190\176\200\235\191\218Y1"] = {
    22,
    0,
    2
  }
  CC.Scene_S["\205\226\190\176\200\235\191\218X2"] = {
    24,
    0,
    2
  }
  CC.Scene_S["\205\226\190\176\200\235\191\218Y2"] = {
    26,
    0,
    2
  }
  CC.Scene_S["\200\235\191\218X"] = {
    28,
    0,
    2
  }
  CC.Scene_S["\200\235\191\218Y"] = {
    30,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218X1"] = {
    32,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218X2"] = {
    34,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218X3"] = {
    36,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218Y1"] = {
    38,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218Y2"] = {
    40,
    0,
    2
  }
  CC.Scene_S["\179\246\191\218Y3"] = {
    42,
    0,
    2
  }
  CC.Scene_S["\204\248\215\170\191\218X1"] = {
    44,
    0,
    2
  }
  CC.Scene_S["\204\248\215\170\191\218Y1"] = {
    46,
    0,
    2
  }
  CC.Scene_S["\204\248\215\170\191\218X2"] = {
    48,
    0,
    2
  }
  CC.Scene_S["\204\248\215\170\191\218Y2"] = {
    50,
    0,
    2
  }
  CC.WugongSize = 136
  CC.Wugong_S = {}
  CC.Wugong_S["\180\250\186\197"] = {
    0,
    0,
    2
  }
  CC.Wugong_S["\195\251\179\198"] = {
    2,
    2,
    10
  }
  CC.Wugong_S["\206\180\214\1701"] = {
    12,
    0,
    2
  }
  CC.Wugong_S["\206\180\214\1702"] = {
    14,
    0,
    2
  }
  CC.Wugong_S["\206\180\214\1703"] = {
    16,
    0,
    2
  }
  CC.Wugong_S["\206\180\214\1704"] = {
    18,
    0,
    2
  }
  CC.Wugong_S["\206\180\214\1705"] = {
    20,
    0,
    2
  }
  CC.Wugong_S["\179\246\213\208\210\244\208\167"] = {
    22,
    0,
    2
  }
  CC.Wugong_S["\206\228\185\166\192\224\208\205"] = {
    24,
    0,
    2
  }
  CC.Wugong_S["\206\228\185\166\182\175\187\173&\210\244\208\167"] = {
    26,
    0,
    2
  }
  CC.Wugong_S["\201\203\186\166\192\224\208\205"] = {
    28,
    0,
    2
  }
  CC.Wugong_S["\185\165\187\247\183\182\206\167"] = {
    30,
    0,
    2
  }
  CC.Wugong_S["\207\251\186\196\196\218\193\166\181\227\202\253"] = {
    32,
    0,
    2
  }
  CC.Wugong_S["\181\208\200\203\214\208\182\190\181\227\202\253"] = {
    34,
    0,
    2
  }
  for i = 1, 10 do
    CC.Wugong_S["\185\165\187\247\193\166" .. i] = {
      36 + 2 * (i - 1),
      0,
      2
    }
    CC.Wugong_S["\210\198\182\175\183\182\206\167" .. i] = {
      56 + 2 * (i - 1),
      0,
      2
    }
    CC.Wugong_S["\201\177\201\203\183\182\206\167" .. i] = {
      76 + 2 * (i - 1),
      0,
      2
    }
    CC.Wugong_S["\188\211\196\218\193\166" .. i] = {
      96 + 2 * (i - 1),
      0,
      2
    }
    CC.Wugong_S["\201\177\196\218\193\166" .. i] = {
      116 + 2 * (i - 1),
      0,
      2
    }
  end
  CC.ShopSize = 30
  CC.Shop_S = {}
  for i = 1, 5 do
    CC.Shop_S["\206\239\198\183" .. i] = {
      0 + 2 * (i - 1),
      0,
      2
    }
    CC.Shop_S["\206\239\198\183\202\253\193\191" .. i] = {
      10 + 2 * (i - 1),
      0,
      2
    }
    CC.Shop_S["\206\239\198\183\188\219\184\241" .. i] = {
      20 + 2 * (i - 1),
      0,
      2
    }
  end
  CC.ShopScene = {}
  CC.ShopScene[0] = {
    sceneid = 1,
    d_shop = 16,
    d_leave = {17, 18}
  }
  CC.ShopScene[1] = {
    sceneid = 3,
    d_shop = 14,
    d_leave = {15, 16}
  }
  CC.ShopScene[2] = {
    sceneid = 40,
    d_shop = 20,
    d_leave = {21, 22}
  }
  CC.ShopScene[3] = {
    sceneid = 60,
    d_shop = 16,
    d_leave = {17, 18}
  }
  CC.ShopScene[4] = {
    sceneid = 61,
    d_shop = 9,
    d_leave = {
      10,
      11,
      12
    }
  }
  CC.MWidth = 480
  CC.MHeight = 480
  CC.SWidth = 64
  CC.SHeight = 64
  CC.DNum = 200
  CC.XScale = CONFIG.XScale
  CC.YScale = CONFIG.YScale
  if CONFIG.Frame == nil or CONFIG.Frame > 60 or 20 > CONFIG.Frame then
    CC.Frame = 40
  else
    CC.Frame = CONFIG.Frame
  end
  CC.SceneMoveFrame = CC.Frame * 2
  CC.PersonMoveFrame = CC.Frame * 2
  CC.AnimationFrame = CC.Frame * 3
  CC.WarAutoDelay = 300
  CC.DirectX = {
    0,
    1,
    -1,
    0
  }
  CC.DirectY = {
    -1,
    0,
    0,
    1
  }
  CC.MyStartPic = 2501
  CC.BoatStartPic = 3715
  CC.Level = 30
  CC.Exp = {
    50,
    150,
    300,
    500,
    750,
    1050,
    1400,
    1800,
    2250,
    2750,
    3850,
    5050,
    6350,
    7750,
    9250,
    10850,
    12550,
    14350,
    16750,
    18250,
    21400,
    24700,
    28150,
    31750,
    35500,
    39400,
    43450,
    47650,
    52000,
    60000
  }
  CC.MMapBoat = {}
  local tmpBoat = {
    {358, 362},
    {374, 380},
    {458, 464},
    {506, 610},
    {1016, 1022}
  }
  for i, v in ipairs(tmpBoat) do
    for j = v[1], v[2], 2 do
      CC.MMapBoat[j] = 1
    end
  end
  CC.SceneWater = {}
  local tmpWater = {
    {358, 362},
    {374, 380},
    {458, 464},
    {506, 610},
    {818, 824},
    {838, 838},
    {934, 936},
    {1016, 1022},
    {1324, 1348}
  }
  for i, v in ipairs(tmpWater) do
    for j = v[1], v[2], 2 do
      CC.SceneWater[j] = 1
    end
  end
  CC.WarWater = {}
  local tmpWater = {
    {358, 362},
    {374, 380},
    {458, 464},
    {506, 610},
    {818, 824},
    {838, 838},
    {934, 936},
    {1016, 1022},
    {1324, 1348}
  }
  for i, v in ipairs(tmpWater) do
    for j = v[1], v[2], 2 do
      CC.WarWater[j] = 1
    end
  end
  CC.PersonExit = {
    {1, 950},
    {2, 952},
    {9, 954},
    {16, 956},
    {17, 958},
    {25, 960},
    {28, 962},
    {29, 964},
    {35, 966},
    {36, 968},
    {37, 970},
    {38, 972},
    {44, 974},
    {45, 976},
    {47, 978},
    {48, 980},
    {49, 982},
    {51, 984},
    {53, 986},
    {54, 988},
    {58, 990},
    {59, 992},
    {61, 994},
    {63, 996},
    {76, 998}
  }
  CC.AllPersonExit = {
    {0, 0},
    {49, 2},
    {4, 1},
    {44, 0},
    {44, 1},
    {37, 5},
    {30, 0},
    {59, 0},
    {40, 3},
    {56, 1},
    {1, 7},
    {1, 8},
    {1, 10},
    {40, 7},
    {40, 8},
    {77, 0},
    {54, 0},
    {62, 3},
    {62, 4},
    {60, 2},
    {60, 15},
    {52, 1},
    {61, 0},
    {61, 8},
    {78, 0},
    {18, 0},
    {18, 1},
    {69, 0},
    {69, 1},
    {45, 0},
    {52, 2},
    {42, 6},
    {42, 7},
    {8, 8},
    {7, 6},
    {80, 1}
  }
  CC.BookNum = 14
  CC.BookStart = 144
  CC.MoneyID = 174
  CC.Shemale = {
    [78] = 1,
    [93] = 1
  }
  CC.Effect = {
    [0] = 9,
    14,
    17,
    9,
    13,
    17,
    17,
    17,
    18,
    19,
    19,
    15,
    13,
    10,
    10,
    15,
    21,
    16,
    9,
    11,
    8,
    9,
    8,
    8,
    7,
    8,
    8,
    9,
    12,
    19,
    11,
    14,
    12,
    17,
    8,
    11,
    9,
    13,
    10,
    19,
    14,
    17,
    19,
    14,
    21,
    16,
    13,
    18,
    14,
    17,
    17,
    16,
    7
  }
  CC.ExtraOffense = {
    {
      106,
      57,
      100
    },
    {
      107,
      49,
      50
    },
    {
      108,
      49,
      50
    },
    {
      110,
      54,
      80
    },
    {
      115,
      63,
      50
    },
    {
      116,
      67,
      70
    },
    {
      119,
      68,
      100
    }
  }
  CC.EONum = 7
  CC.NewPersonName = "\208\236\208\161\207\192"
  if CONFIG.PlayName ~= nil then
    CC.NewPersonName = CONFIG.PlayName
  end
  CC.NewGameSceneID = 70
  CC.NewGameSceneX = 19
  CC.NewGameSceneY = 20
  CC.NewGameEvent = 691
  CC.NewPersonPic = 3445
  CC.PersonAttribMax = {}
  CC.PersonAttribMax["\190\173\209\233"] = 60000
  CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
  CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
  CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 999
  CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
  CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
  CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 999
  CC.PersonAttribMax["\204\229\193\166"] = 100
  CC.PersonAttribMax["\185\165\187\247\193\166"] = 100
  CC.PersonAttribMax["\183\192\211\249\193\166"] = 100
  CC.PersonAttribMax["\199\225\185\166"] = 100
  CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 100
  CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 100
  CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 100
  CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
  CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 100
  CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 100
  CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 100
  CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 100
  CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 100
  CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
  CC.PersonAttribMax["\198\183\181\194"] = 100
  CC.PersonAttribMax["\215\202\214\202"] = 100
  CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
  CC.WarDataSize = 186
  CC.WarData_S = {}
  CC.WarData_S["\180\250\186\197"] = {
    0,
    0,
    2
  }
  CC.WarData_S["\195\251\179\198"] = {
    2,
    2,
    10
  }
  CC.WarData_S["\181\216\205\188"] = {
    12,
    0,
    2
  }
  CC.WarData_S["\190\173\209\233"] = {
    14,
    0,
    2
  }
  CC.WarData_S.音乐 = {
    16,
    0,
    2
  }
  for i = 1, 6 do
    CC.WarData_S["\202\214\182\175\209\161\212\241\178\206\213\189\200\203" .. i] = {
      18 + (i - 1) * 2,
      0,
      2
    }
    CC.WarData_S["\215\212\182\175\209\161\212\241\178\206\213\189\200\203" .. i] = {
      30 + (i - 1) * 2,
      0,
      2
    }
    CC.WarData_S["\206\210\183\189X" .. i] = {
      42 + (i - 1) * 2,
      0,
      2
    }
    CC.WarData_S["\206\210\183\189Y" .. i] = {
      54 + (i - 1) * 2,
      0,
      2
    }
  end
  for i = 1, 20 do
    CC.WarData_S["\181\208\200\203" .. i] = {
      66 + (i - 1) * 2,
      0,
      2
    }
    CC.WarData_S["\181\208\183\189X" .. i] = {
      106 + (i - 1) * 2,
      0,
      2
    }
    CC.WarData_S["\181\208\183\189Y" .. i] = {
      146 + (i - 1) * 2,
      0,
      2
    }
  end
  CC.WarWidth = 64
  CC.WarHeight = 64
  CC.ShowXY = 1
  CC.RowPixel = 3 * math.modf(CC.ScreenH / 720)
  CC.MenuBorderPixel = 2 * math.modf(CC.ScreenH / 720)
  if CONFIG.Type == 0 then
    CC.DefaultFont = 16
    CC.StartMenuFontSize = 16
    CC.NewGameFontSize = 16
    CC.MainMenuX = 10
    CC.MainMenuY = 10
    CC.GameOverX = 90
    CC.GameOverY = 65
    CC.PersonStateRowPixel = 1
  elseif CONFIG.Type == 1 then
    if CONFIG.Height * 1.6 > CONFIG.Width then
      CC.DefaultFont = math.modf(CC.ScreenH / 24)
      CC.StartMenuFontSize = math.modf(CC.ScreenH / 20)
      CC.NewGameFontSize = math.modf(CC.ScreenH / 24)
      CC.MainMenuX = 10
      CC.MainMenuY = 10
      CC.GameOverX = 255
      CC.GameOverY = 165
      CC.PersonStateRowPixel = math.modf(CC.ScreenH / 120)
    else
      CC.DefaultFont = math.modf(CC.ScreenH / 20)
      CC.StartMenuFontSize = math.modf(CC.ScreenH / 15)
      CC.NewGameFontSize = math.modf(CC.ScreenH / 20)
      CC.MainMenuX = 10
      CC.MainMenuY = 10
      CC.GameOverX = 255
      CC.GameOverY = 165
      CC.PersonStateRowPixel = math.modf(CC.ScreenH / 120)
    end
    if CONFIG.Width == 480 then
      CC.DefaultFont = math.modf(CC.ScreenH / 21)
      CC.StartMenuFontSize = math.modf(CC.ScreenH / 18)
      CC.NewGameFontSize = math.modf(CC.ScreenH / 21)
      CC.MainMenuX = 10
      CC.MainMenuY = 10
      CC.GameOverX = 255
      CC.GameOverY = 165
      CC.PersonStateRowPixel = math.modf(CC.ScreenH / 120)
    end
  end
  CC.StartMenuY = CC.ScreenH - 3 * (CC.StartMenuFontSize + CC.RowPixel) - CC.DefaultFont
  CC.NewGameY = CC.ScreenH - 4 * (CC.NewGameFontSize + CC.RowPixel) - CC.DefaultFont / 2
  CC.MainSubMenuX = CC.MainMenuX + 2 * CC.MenuBorderPixel + 2 * CC.StartMenuFontSize + 5
  CC.MainSubMenuY = CC.MainMenuY
  CC.MainSubMenuX2 = CC.MainSubMenuX + 2 * CC.MenuBorderPixel + 4 * CC.StartMenuFontSize + 5
  CC.SingleLineHeight = CC.StartMenuFontSize + 2 * CC.MenuBorderPixel + 5
  if CONFIG.Type == 0 then
    CC.ThingFontSize = 16
    CC.ThingPicWidth = math.modf(40 * (CONFIG.Zoom / 100))
    CC.ThingPicHeight = math.modf(40 * (CONFIG.Zoom / 100))
    CC.MenuThingXnum = math.modf(5 / (CONFIG.Zoom / 100))
    CC.MenuThingYnum = math.modf(3 / (CONFIG.Zoom / 100))
    CC.ThingGapOut = 10
    CC.ThingGapIn = 5
  elseif CONFIG.Type == 1 then
    local picmax = 40
    if CONFIG.MOD == 5 then
      picmax = 40
    end
    if CONFIG.Height * 1.6 > CONFIG.Width then
      CC.ThingFontSize = math.modf(CC.ScreenH / 24)
      CC.ThingPicWidth = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.ThingPicHeight = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.MenuThingXnum = math.modf(CC.ScreenW / 60 / (CONFIG.Zoom / 100))
      CC.MenuThingYnum = math.modf(CC.ScreenH / 120 / (CONFIG.Zoom / 100))
      CC.ThingGapOut = 10
      CC.ThingGapIn = 10
    else
      CC.ThingFontSize = math.modf(CC.ScreenH / 20)
      CC.ThingPicWidth = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.ThingPicHeight = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.MenuThingXnum = math.modf(CC.ScreenW / 60 / (CONFIG.Zoom / 100))
      CC.MenuThingYnum = math.modf(CC.ScreenH / 120 / (CONFIG.Zoom / 100))
      CC.ThingGapOut = 10
      CC.ThingGapIn = 10
    end
    if CONFIG.Width == 480 then
      CC.ThingFontSize = math.modf(CC.ScreenH / 20)
      CC.ThingPicWidth = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.ThingPicHeight = math.modf(picmax * (CONFIG.Zoom / 100))
      CC.MenuThingXnum = math.modf(CC.ScreenW / 60 / (CONFIG.Zoom / 100))
      CC.MenuThingYnum = math.modf(CC.ScreenH / 120 / (CONFIG.Zoom / 100))
      CC.ThingGapOut = 5
      CC.ThingGapIn = 5
    end
  end
  if CONFIG.Type == 0 then
    CC.SceneXMin = 12
    CC.SceneYMin = 12
    CC.SceneXMax = 45
    CC.SceneYMax = 45
  elseif CONFIG.Type == 1 then
    CC.SceneXMin = 7
    CC.SceneYMin = 7
    CC.SceneXMax = 50
    CC.SceneYMax = 50
  end
  CC.SceneFlagPic = {2749, 2846}
  if CONFIG.FastShowScreen == 0 then
    CC.ShowFlag = 1
    if CONFIG.Type == 1 then
      CC.AutoWarShowHead = 1
    else
      CC.AutoWarShowHead = 0
    end
  else
    CC.ShowFlag = 0
    CC.AutoWarShowHead = 0
  end
  CC.LoadThingPic = 0
  CC.StartThingPic = 3501
  CC.SceneNameRen = 0
  CC.SceneName = ""
  CC.ExpLevel = 1
  CC.TP = 1
  CC.WXCS = 80
  CC.ZCOPEN = 0
  CC.JS = 0
  CC.ZCWG = CONFIG.ZCWG
  CC.X50OPEN = 0
  CC.FK = 0
  CC.FKUP = 0
  CC.RB = 0
  CC.FKGS = 0
  CC.NEWGAME = 0
  CC.GLTSSize = 200
  CC.GLTS_S = {}
  for j = 0, 99 do
    CC.GLTS_S[j] = {
      j * 2,
      0,
      2
    }
  end
  CC.GLTS = {}
  for i = 0, 14 do
    CC.GLTS[i] = {}
    for j = 0, 99 do
      CC.GLTS[i][j] = 0
    end
  end
  if CONFIG.ExpLevel ~= nil then
    CC.ExpCS = CONFIG.ExpLevel + 1
  end
  if 2 < CC.ExpCS or 1 > CC.ExpCS then
    CC.ExpCS = 1
  end
  if CONFIG.TP ~= nil then
    CC.TP = CONFIG.TP
  end
  if CONFIG.NGHT == nil then
    CONFIG.NGHT = 0
  end
  CONFIG.NGHT = 0
  if CONFIG.MHTX == nil then
    CONFIG.MHTX = 0
  end
  if CC.BanBen ~= 1 then
    CC.JS = 0
  elseif CONFIG.JS == nil then
    CC.JS = 1
  else
    CC.JS = CONFIG.JS
  end
  if CC.BanBen == 0 then
    CC.JSHead = 115
    CC.GLTS[0] = {
      22,
      10,
      30,
      28,
      41,
      32,
      33
    }
    CC.GLTS[1] = {
      10,
      867,
      54
    }
    CC.GLTS[2] = {
      602,
      603,
      644
    }
    CC.GLTS[3] = {
      476,
      486,
      401,
      453,
      573,
      530,
      594,
      515,
      531
    }
    CC.GLTS[4] = {
      409,
      417,
      426,
      419,
      411,
      423,
      466,
      420,
      469
    }
    CC.GLTS[5] = {656, 0}
    CC.GLTS[6] = {
      609,
      616,
      611
    }
    CC.GLTS[7] = {
      239,
      249,
      242,
      284,
      195,
      209,
      264,
      275,
      320,
      321,
      322
    }
    CC.GLTS[8] = {
      620,
      631,
      622
    }
    CC.GLTS[9] = {
      399,
      396,
      409,
      436,
      443,
      440
    }
    CC.GLTS[10] = {
      372,
      335,
      343,
      363
    }
    CC.GLTS[11] = {
      68,
      71,
      90,
      82,
      61,
      91,
      65,
      109,
      95,
      105,
      115
    }
    CC.GLTS[12] = {
      635,
      640,
      636
    }
    CC.GLTS[13] = {
      918,
      56,
      651
    }
    for i = 0, 14 do
      for j = 0, 99 do
        if CC.GLTS[i][j] == nil then
          CC.GLTS[i][j] = 0
        end
      end
    end
  elseif CC.BanBen == 1 then
    CC.PersonExit = {
      {1, 100},
      {2, 102},
      {4, 104},
      {9, 106},
      {16, 108},
      {17, 110},
      {25, 112},
      {28, 114},
      {29, 116},
      {30, 118},
      {35, 120},
      {36, 122},
      {37, 124},
      {38, 126},
      {44, 128},
      {45, 130},
      {47, 132},
      {48, 134},
      {49, 136},
      {51, 138},
      {52, 140},
      {53, 142},
      {54, 144},
      {55, 146},
      {56, 148},
      {58, 150},
      {59, 152},
      {63, 154},
      {66, 156},
      {72, 158},
      {73, 160},
      {74, 162},
      {75, 164},
      {76, 166},
      {77, 168},
      {78, 170},
      {79, 172},
      {80, 174},
      {81, 176},
      {82, 178},
      {83, 180},
      {84, 182},
      {85, 184},
      {86, 186},
      {87, 188},
      {88, 190},
      {89, 192},
      {90, 194},
      {91, 196},
      {92, 198}
    }
    CC.ExtraOffense = {
      {
        52,
        75,
        100
      },
      {
        45,
        67,
        100
      },
      {
        37,
        41,
        100
      },
      {
        49,
        80,
        200
      },
      {
        44,
        63,
        150
      },
      {
        40,
        40,
        150
      },
      {
        36,
        45,
        100
      }
    }
    CC.EONum = 7
    CC.JSHead = 267
    CC.GLTS[0] = {
      1,
      3,
      5,
      8,
      10,
      11,
      15,
      16,
      32,
      33
    }
    CC.GLTS[1] = {18, 0}
    CC.GLTS[2] = {
      38,
      41,
      41,
      49,
      42,
      49
    }
    CC.GLTS[3] = {
      520,
      521,
      523,
      529,
      547,
      556,
      565,
      566,
      570,
      301,
      573,
      585
    }
    CC.GLTS[4] = {
      456,
      458,
      462,
      466,
      467,
      468,
      469,
      479,
      480,
      483,
      486,
      496,
      498,
      500,
      494,
      501,
      502,
      503,
      504,
      505,
      507,
      507,
      507,
      510
    }
    CC.GLTS[5] = {
      52,
      52,
      52,
      55,
      52,
      55
    }
    CC.GLTS[6] = {
      62,
      89,
      63,
      94,
      95,
      90
    }
    CC.GLTS[7] = {
      740,
      744,
      745,
      749,
      754,
      755,
      757,
      759,
      760,
      772,
      777,
      783,
      922,
      794,
      804,
      805,
      883,
      884,
      884,
      887,
      890,
      898,
      901,
      901,
      908,
      911,
      913,
      915,
      916
    }
    CC.GLTS[8] = {
      232,
      233,
      240,
      242,
      241,
      241,
      243
    }
    CC.GLTS[9] = {
      926,
      217,
      214,
      223,
      227,
      229,
      229,
      227
    }
    CC.GLTS[10] = {
      366,
      369,
      375,
      379,
      382,
      385,
      392,
      416,
      422,
      422,
      423,
      425,
      428
    }
    CC.GLTS[11] = {
      249,
      256,
      257,
      266,
      268,
      279,
      280,
      281,
      282,
      284,
      285,
      277,
      255,
      257,
      291,
      295,
      297,
      298,
      299,
      300,
      302,
      303
    }
    CC.GLTS[12] = {
      316,
      321,
      322,
      325,
      326,
      344,
      345,
      346,
      346,
      347,
      348,
      351,
      353,
      354,
      357,
      358,
      360
    }
    CC.GLTS[13] = {
      200,
      202,
      207,
      208,
      200,
      202,
      207,
      208
    }
    for i = 0, 14 do
      for j = 0, 99 do
        if CC.GLTS[i][j] == nil then
          CC.GLTS[i][j] = 0
        end
      end
    end
    CC.MyThingNum = 886
    for i = 1, CC.MyThingNum do
      CC.Base_S["\206\239\198\183" .. i] = {
        36 + 4 * (i - 1),
        0,
        2
      }
      CC.Base_S["\206\239\198\183\202\253\193\191" .. i] = {
        36 + 4 * (i - 1) + 2,
        0,
        2
      }
    end
    CC.PersonAttribMax = {}
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 600
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 600
    CC.PersonAttribMax["\199\225\185\166"] = 600
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 300
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 600
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 600
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 600
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 600
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 300
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
    CC.NewPersonName = "\208\236\208\161\207\192"
    if CONFIG.PlayName ~= nil then
      CC.NewPersonName = CONFIG.PlayName
    end
    CC.NewGameSceneID = 70
    CC.NewGameSceneX = 16
    CC.NewGameSceneY = 31
    CC.NewGameEvent = 691
    CC.NewPersonPic = 2515
    CC.LoadThingPic = 0
    CC.StartThingPic = 4131
    CC.SceneNameRen = 1
    CC.SceneName = "\208\161\180\229"
    CC.WXCS = 80
    if CONFIG.ZCOPEN == 1 then
      CC.ZCOPEN = 1
    end
  elseif CC.BanBen == 2 then
    CC.Level = 60
    CC.FK = 1
    CC.FKUP = 1
    CC.FKGS = 0
    CC.RB = 1
    CC.Leave = 1
    CC.PersonExit = {
      {92, 1},
      {36, 3},
      {119, 5},
      {106, 7},
      {105, 9},
      {2, 11},
      {48, 13},
      {98, 15},
      {39, 17},
      {112, 19},
      {111, 21},
      {87, 23},
      {40, 25},
      {42, 27},
      {41, 29},
      {91, 31},
      {107, 33},
      {16, 35},
      {17, 37},
      {1, 39},
      {63, 41},
      {99, 43},
      {81, 45},
      {28, 47},
      {51, 49},
      {76, 51},
      {53, 53},
      {110, 55},
      {45, 57},
      {29, 59},
      {77, 61},
      {35, 63},
      {230, 65},
      {268, 67},
      {117, 69},
      {322, 71},
      {323, 73},
      {324, 75},
      {73, 77}
    }
    CC.Effect = {
      [0] = 9,
      14,
      17,
      9,
      13,
      17,
      17,
      17,
      18,
      19,
      19,
      15,
      13,
      10,
      10,
      15,
      21,
      16,
      9,
      11,
      8,
      9,
      8,
      8,
      7,
      8,
      8,
      9,
      12,
      19,
      11,
      14,
      12,
      17,
      8,
      11,
      9,
      13,
      10,
      19,
      14,
      17,
      19,
      14,
      21,
      16,
      13,
      18,
      14,
      17,
      17,
      16,
      7,
      11,
      8,
      7,
      14,
      17,
      9,
      13,
      17,
      4,
      14,
      18,
      20,
      12,
      7,
      8,
      13,
      15
    }
    CC.ExtraOffense = {
      {
        132,
        71,
        100
      },
      {
        134,
        47,
        100
      },
      {
        135,
        45,
        100
      },
      {
        131,
        52,
        100
      },
      {
        130,
        40,
        100
      },
      {
        165,
        94,
        1000
      },
      {
        190,
        70,
        100
      }
    }
    CC.EONum = 7
    CC.JSHead = 252
    CC.MyThingNum = 886
    for i = 1, CC.MyThingNum do
      CC.Base_S["\206\239\198\183" .. i] = {
        36 + 4 * (i - 1),
        0,
        2
      }
      CC.Base_S["\206\239\198\183\202\253\193\191" .. i] = {
        36 + 4 * (i - 1) + 2,
        0,
        2
      }
    end
    CC.PersonAttribMax = {}
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 800
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 800
    CC.PersonAttribMax["\199\225\185\166"] = 800
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 300
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 800
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 800
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 800
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 800
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 300
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
    CC.NewPersonName = "\208\236\208\161\207\192"
    if CONFIG.PlayName ~= nil then
      CC.NewPersonName = CONFIG.PlayName
    end
    CC.NewGameSceneID = 70
    CC.NewGameSceneX = 54
    CC.NewGameSceneY = 13
    CC.NewGameEvent = 691
    CC.NewPersonPic = 3445
    CC.LoadThingPic = 0
    CC.StartThingPic = 4420
    CC.WXCS = 10
    CC.X50OPEN = 0
  elseif CC.BanBen == 3 then
    CC.Level = 60
    CC.FK = 1
    CC.FKUP = 1
    CC.FKGS = 1
    CC.RB = 1
    CC.Leave = 1050
    CC.PersonExit = {
      {1, 1050},
      {2, 1052},
      {9, 1054},
      {95, 1056},
      {114, 1058},
      {25, 1060},
      {50, 1062},
      {29, 1064},
      {35, 1066},
      {36, 1068},
      {37, 1070},
      {38, 1072},
      {44, 1074},
      {45, 1076},
      {47, 1078},
      {48, 1080},
      {49, 1082},
      {51, 1084},
      {53, 1086},
      {54, 1088},
      {58, 1090},
      {59, 1092},
      {61, 1094},
      {63, 1096},
      {76, 1098},
      {115, 1100},
      {56, 1102},
      {55, 1104},
      {17, 1106},
      {28, 1108},
      {30, 1110},
      {16, 1112},
      {73, 1114},
      {52, 1116},
      {74, 1118},
      {66, 1120},
      {39, 1122},
      {40, 1124},
      {41, 1126},
      {42, 1128},
      {72, 1130}
    }
    CC.ExtraOffense = {
      {
        106,
        57,
        300
      },
      {
        202,
        104,
        600
      },
      {
        108,
        49,
        200
      },
      {
        110,
        54,
        200
      },
      {
        115,
        63,
        200
      },
      {
        116,
        67,
        150
      },
      {
        119,
        90,
        500
      }
    }
    CC.JSHead = 204
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 999
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 999
    CC.PersonAttribMax["\199\225\185\166"] = 999
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 500
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 999
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 999
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 999
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 999
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 500
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
  elseif CC.BanBen == 4 then
    CC.Level = 60
    CC.FK = 1
    CC.FKUP = 1
    CC.FKGS = 1
    CC.RB = 1
    CC.Leave = 100
    CC.JSHead = 373
    CC.PersonExit = {
      {1, 100},
      {2, 102},
      {4, 104},
      {9, 106},
      {16, 108},
      {17, 110},
      {25, 112},
      {28, 114},
      {29, 116},
      {30, 118},
      {35, 120},
      {36, 122},
      {37, 124},
      {38, 126},
      {44, 128},
      {45, 130},
      {47, 132},
      {48, 134},
      {49, 136},
      {51, 138},
      {52, 140},
      {53, 142},
      {54, 144},
      {55, 146},
      {56, 148},
      {58, 150},
      {59, 152},
      {63, 154},
      {66, 156},
      {72, 158},
      {73, 160},
      {74, 162},
      {75, 164},
      {76, 166},
      {77, 168},
      {78, 170},
      {79, 172},
      {80, 174},
      {81, 176},
      {82, 178},
      {83, 180},
      {84, 182},
      {85, 184},
      {86, 186},
      {87, 188},
      {88, 190},
      {89, 192},
      {90, 194},
      {91, 196},
      {92, 198},
      {589, 200},
      {590, 202},
      {591, 204},
      {592, 206},
      {593, 208},
      {594, 210},
      {595, 212},
      {596, 214},
      {97, 216},
      {597, 218},
      {50, 220},
      {598, 222},
      {599, 224},
      {600, 226},
      {601, 228},
      {103, 230},
      {602, 232},
      {603, 234},
      {604, 236},
      {605, 238},
      {606, 240},
      {607, 242},
      {608, 244},
      {609, 246},
      {610, 248},
      {93, 250},
      {611, 252}
    }
    CC.ExtraOffense = {
      {
        52,
        75,
        100
      },
      {
        45,
        67,
        100
      },
      {
        37,
        41,
        100
      },
      {
        49,
        80,
        200
      },
      {
        44,
        63,
        150
      },
      {
        40,
        40,
        150
      },
      {
        36,
        45,
        100
      }
    }
    CC.Effect = {
      [0] = 10,
      14,
      17,
      9,
      13,
      17,
      17,
      17,
      18,
      19,
      19,
      15,
      13,
      10,
      10,
      15,
      21,
      16,
      9,
      11,
      8,
      9,
      8,
      8,
      7,
      8,
      8,
      9,
      12,
      19,
      11,
      14,
      12,
      17,
      8,
      11,
      9,
      13,
      10,
      19,
      14,
      17,
      19,
      14,
      21,
      16,
      13,
      18,
      14,
      17,
      17,
      16,
      7,
      14,
      14,
      14,
      8,
      8,
      8,
      8,
      8,
      15,
      14,
      7,
      7,
      10,
      9,
      9,
      9,
      9,
      9,
      19,
      19,
      19,
      19,
      18,
      18,
      18,
      12,
      12,
      12,
      12,
      14,
      14,
      14,
      16,
      16,
      10,
      10,
      10,
      8,
      15,
      17,
      17,
      14,
      14,
      9,
      9,
      18,
      13,
      8,
      17,
      9,
      16,
      21,
      14,
      13,
      12,
      14,
      16,
      20,
      19,
      14,
      19,
      20,
      12,
      12,
      12,
      12,
      12,
      12,
      12,
      12,
      12,
      12,
      9,
      7,
      15,
      10,
      11,
      11,
      13,
      6,
      10,
      10,
      13,
      10,
      10,
      19,
      16,
      14,
      14,
      15,
      12,
      7,
      9,
      13,
      11,
      12,
      13,
      21,
      21,
      12,
      12,
      6,
      12,
      20,
      6,
      12,
      21,
      15,
      14,
      13,
      13,
      7,
      15,
      14,
      14,
      15,
      12,
      15,
      16,
      14,
      20,
      13,
      15,
      13,
      13,
      11,
      16,
      16,
      15,
      16,
      8,
      16,
      16,
      19,
      10,
      14,
      16,
      18,
      12,
      12,
      7,
      8,
      13,
      17,
      15,
      17,
      26
    }
    CC.PersonAttribMax = {}
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 999
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 999
    CC.PersonAttribMax["\199\225\185\166"] = 999
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 500
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 800
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 800
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 800
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 800
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 500
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
    CC.SceneNameRen = 1
    CC.SceneName = "\206\228\193\214\214\174\188\210"
    CC.NewPersonName = "\208\236\208\161\207\192"
    if CONFIG.PlayName ~= nil then
      CC.NewPersonName = CONFIG.PlayName
    end
    CC.NewGameSceneID = 70
    CC.NewGameSceneX = 16
    CC.NewGameSceneY = 31
    CC.NewGameEvent = 691
    CC.NewPersonPic = 2515
    CC.LoadThingPic = 0
    CC.StartThingPic = 4131
    CC.ThingPicFile = {
      CONFIG.DataPath .. "zwb",
      CONFIG.DataPath .. "zwa"
    }
    CC.Shemale = {
      [99] = 1,
      [315] = 1
    }
  elseif CC.BanBen == 5 then
    CC.RB = 1
    CC.Level = 60
    CC.Leave = 100
    CC.JSHead = 300
    CC.FK = 1
    CC.FKUP = 1
    CC.FKGS = 1
    CC.PersonAttribMax = {}
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 999
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 999
    CC.PersonAttribMax["\199\225\185\166"] = 999
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 500
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 500
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 999
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 999
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 999
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 999
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 500
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
    CC.NewPersonName = "\208\236\208\161\207\192"
    if CONFIG.PlayName ~= nil then
      CC.NewPersonName = CONFIG.PlayName
    end
    CC.NewGameSceneID = 70
    CC.NewGameSceneX = 16
    CC.NewGameSceneY = 31
    CC.NewGameEvent = 691
    CC.NewPersonPic = 2515
    CC.LoadThingPic = 0
    CC.StartThingPic = 4131
    CC.SceneNameRen = 1
    CC.SceneName = "\208\161\180\229"
    CC.WXCS = 80
  elseif CC.BanBen == 100 then
    CC.PersonAttribMax = {}
    CC.PersonAttribMax["\190\173\209\233"] = 60000
    CC.PersonAttribMax["\206\239\198\183\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\208\222\193\182\181\227\202\253"] = 60000
    CC.PersonAttribMax["\201\250\195\252\215\238\180\243\214\181"] = 999
    CC.PersonAttribMax["\202\220\201\203\179\204\182\200"] = 100
    CC.PersonAttribMax["\214\208\182\190\179\204\182\200"] = 100
    CC.PersonAttribMax["\196\218\193\166\215\238\180\243\214\181"] = 9999
    CC.PersonAttribMax["\204\229\193\166"] = 100
    CC.PersonAttribMax["\185\165\187\247\193\166"] = 800
    CC.PersonAttribMax["\183\192\211\249\193\166"] = 800
    CC.PersonAttribMax["\199\225\185\166"] = 800
    CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = 300
    CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = 300
    CC.PersonAttribMax["\191\185\182\190\196\220\193\166"] = 100
    CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = 500
    CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = 500
    CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = 500
    CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = 500
    CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = 300
    CC.PersonAttribMax["\206\228\209\167\179\163\202\182"] = 100
    CC.PersonAttribMax["\198\183\181\194"] = 100
    CC.PersonAttribMax["\215\202\214\202"] = 100
    CC.PersonAttribMax["\185\165\187\247\180\248\182\190"] = 100
    CC.NewGameSceneID = 0
    CC.NewGameSceneX = 19
    CC.NewGameSceneY = 20
    CC.NewGameEvent = 301
    CC.NewPersonPic = 3445
    CC.StartThingPic = 5720
    CC.MIDIFile = CONFIG.SoundPath .. "%02d.mid"
  end
end
