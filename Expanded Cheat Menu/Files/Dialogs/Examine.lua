-- See LICENSE for terms

local g_Classes = g_Classes
if g_Classes.Examine then
  return
end

-- see about hiding list when moving dialog

local Concat
local DialogAddCaption
local DialogAddCloseX
local DialogUpdateMenuitems
local Dump
local RetButtonTextSize
local RetCheckTextSize
local RetName
local RetSortTextAssTable
local ShowMe
local T
local TableConcat
--now we can local just the funcs, and ignore the settings that may be changed later on (maybe i should have two globals, settings and funcs)
do
  local ChoGGi = ChoGGi
  Concat = ChoGGi.ComFuncs.Concat
  DialogAddCaption = ChoGGi.ComFuncs.DialogAddCaption
  DialogAddCloseX = ChoGGi.ComFuncs.DialogAddCloseX
  DialogUpdateMenuitems = ChoGGi.ComFuncs.DialogUpdateMenuitems
  Dump = ChoGGi.ComFuncs.Dump
  RetButtonTextSize = ChoGGi.ComFuncs.RetButtonTextSize
  RetCheckTextSize = ChoGGi.ComFuncs.RetCheckTextSize
  RetName = ChoGGi.ComFuncs.RetName
  RetSortTextAssTable = ChoGGi.ComFuncs.RetSortTextAssTable
  ShowMe = ChoGGi.ComFuncs.ShowMe
  T = ChoGGi.ComFuncs.Trans
  TableConcat = ChoGGi.ComFuncs.TableConcat
end

local pairs,type,tostring,tonumber,getmetatable,rawget,string,table,debug,utf8 = pairs,type,tostring,tonumber,getmetatable,rawget,string,table,debug,utf8

local CmpLower = CmpLower
local CreateRealTimeThread = CreateRealTimeThread
local GetStateName = GetStateName
local IsPoint = IsPoint
local IsValid = IsValid
local IsValidEntity = IsValidEntity
local Min = Min
local OpenExamine = OpenExamine
local point = point
local RGBA = RGBA
local Sleep = Sleep
local ValueToLuaCode = ValueToLuaCode
local XDestroyRolloverWindow = XDestroyRolloverWindow

local terrain_GetHeight = terrain.GetHeight

-- only call T once
local str_Examine = T(302535920000069--[[Examine--]])
local str_Data = T(302535920001057--[[Data--]])
local str_unknownname = T(302535920000063--[[unknown name--]])
local str_Gototext = T(302535920000044--[[Goto text--]])
local str_Tools = T(302535920000239--[[Tools--]])
local str_Dump = T(302535920000004--[[Dump--]])
local str_View = T(302535920000048--[[View--]])
local str_Object = T(298035641454--[[Object--]])
local str_DumpText = Concat(str_Dump," ",T(1000145--[[Text--]]))
local str_DumpTextDes = T(302535920000046--[[dumps text to AppData/DumpedExamine.lua--]])
local str_DumpObject = Concat(str_Dump," ",str_Object)
local str_DumpObjectDes = T(302535920001027--[[dumps object to AppData/DumpedExamineObject.lua

This can take time on something like the "Building" metatable--]])
local str_ViewText = Concat(str_View," ",T(1000145--[[Text--]]))
local str_ViewTextDes = T(302535920000047--[[View text, and optionally dumps text to AppData/DumpedExamine.lua (don't use this option on large text).--]])
local str_ViewObject = Concat(str_View," ",str_Object)
local str_ViewObjectDes = T(302535920000049--[["View text, and optionally dumps object to AppData/DumpedExamineObject.lua

This can take time on something like the ""Building"" metatable (don't use this option on large text)"--]])
local str_EditObject = Concat(T(327465361219 --[[Edit--]])," ",str_Object)
local str_EditObjectDes = T(302535920000050--[[Opens object in Object Manipulator.--]])
local str_ExecCode = T(302535920000323--[[Exec Code--]])
local str_ExecCodeDes = T(302535920000052--[["Execute code (using console for output). ChoGGi.CurObj is whatever object is opened in examiner.
Which you can then mess around with some more in the console."--]])
local str_Functions = T(302535920001239--[[Functions--]])
local str_FunctionsDes = T(302535920001240--[[Show all functions of this object and parents/ancestors.--]])
local str_Parents = T(302535920000520--[[Parents--]])
local str_ParentsDes = T(302535920000553--[[Examine parent and ancestor objects.--]])
local str_Ancestors = T(302535920000525--[[Ancestors--]])
local str_Attaches = T(302535920000053--[[Attaches--]])
local str_AttachesDes = T(302535920000054--[[Any objects attached to this object.--]])
local str_AttachesDes2 = T(302535920000070--[[Shows list of attachments. This %s has: %s.--]])
local str_Next = T(1000232--[[Next--]])
local str_NextDes = T(302535920000045--[["Scrolls down one line or scrolls between text in ""Go to text"".

Right-click to scroll to top."--]])
local str_NextDes2 = T(302535920000043--[[Scrolls to text entered (press Enter to scroll between found text, Up arrow to scroll to top).--]])
local str_Destroy = T(697--[[Destroy--]])
local str_DestroyQues = T(302535920000414--[[Are you sure you wish to destroy it?--]])
local str_Refresh = T(1000220--[[Refresh--]])
local str_ShowIt = T(302535920000058--[[[ShowIt]--]])
local str_ClearMarkers = T(302535920000059--[[[Clear Markers]--]])
local str_Transp = T(302535920000064--[[[Transp]--]])
local str_DestroyIt = T(302535920000060--[[[Destroy It!]--]])
local str_Handle = T(302535920000955--[[Handle--]])
local str_AutoRefresh = T(302535920000084--[[Auto-Refresh--]])
local str_AutoRefreshDes = T(302535920001257--[[Auto-refresh list every second.--]])


-- 1 above console log
local zorder = 2000001

transp_mode = rawget(_G, "transp_mode") or false
local HLEnd = "</h></color>"
-- probably best not to change this class name (if other people use it)
DefineClass.Examine = {
  __parents = {"FrameWindow"},
  ZOrder = zorder,
  onclick_handles = {},
  obj = false,
  show_times = "relative",
  offset = 1,
  page = 1,
}

function Examine:Init()
  local ChoGGi = ChoGGi
  local const = const
  local terminal = terminal

  --element pos is based on
  self:SetPos(point(0,0))

  local dialog_width = 500
  local dialog_height = 600
  self:SetSize(point(dialog_width,dialog_height))
  self:SetMinSize(point(50, 50))
  self:SetMovable(true)
  self:SetTranslate(false)

  local border = 4
  local element_y
  local element_x
  dialog_width = dialog_width - border * 2
  local dialog_left = border

  DialogAddCloseX(self)
  DialogAddCaption(self,{
    prefix = Concat(str_Examine,": "),
    pos = point(25, border),
    size = point(dialog_width-self.idCloseX:GetSize():x(), 22)
  })

  element_y = self.idCaption:GetPos():y() + self.idCaption:GetSize():y()

  self.idLinks = g_Classes.StaticText:new(self)
  self.idLinks:SetPos(point(dialog_left, element_y))
  self.idLinks:SetSize(point(dialog_width, 20))
  --~ box(left,top, right, bottom)
  self.idLinks:SetHSizing("Resize")
  self.idLinks:SetBackgroundColor(RGBA(0, 0, 0, 16))
  self.idLinks:SetFontStyle("Editor12Bold")
  function self.idLinks.OnHyperLink(_, link, _, box, pos, button)
    self.onclick_handles[tonumber(link)](box, pos, button)
  end
  self.idLinks:AddInterpolation({
    type = const.intAlpha,
    startValue = 255,
    flags = const.intfIgnoreParent
  })

  local title = str_AutoRefresh
  local button_size = RetCheckTextSize(title)
  self.idAutoRefresh = g_Classes.CheckButton:new(self)
  self.idAutoRefresh:SetPos(point(dialog_width - button_size:x() + 20, element_y + 1))
  self.idAutoRefresh:SetSize(button_size)
  self.idAutoRefresh:SetImage("CommonAssets/UI/Controls/Button/CheckButton.tga")
  self.idAutoRefresh:SetHSizing("AnchorToRight")
  self.idAutoRefresh:SetText(title)
  self.idAutoRefresh:SetHint(str_AutoRefreshDes)
  self.idAutoRefresh:SetButtonSize(point(16, 16))
  --add check for auto-refresh
  function self.idAutoRefresh.button.OnButtonPressed()
    self.refreshing = self.idAutoRefresh:GetState()
    CreateRealTimeThread(function()
      while self.refreshing do
        if self.obj then
          self:SetObj(self.obj)
        end
        Sleep(1000)
      end
    end)
  end

  element_y = border / 2 + self.idLinks:GetPos():y() + self.idLinks:GetSize():y()

  --todo: better text control (fix weird ass text controls)
  self.idFilter = g_Classes.SingleLineEdit:new(self)
  self.idFilter:SetPos(point(dialog_left, element_y))
  self.idFilter:SetSize(point(dialog_width, 26))
  self.idFilter:SetHSizing("Resize")
  self.idFilter:SetBackgroundColor(RGBA(0, 0, 0, 16))
  self.idFilter:SetFontStyle("Editor12Bold")
  self.idFilter:SetHint(str_NextDes2)
  self.idFilter:SetTextHAlign("center")
  self.idFilter:SetTextVAlign("center")
  self.idFilter:SetBackgroundColor(RGBA(0, 0, 0, 100))
  self.idFilter.display_text = str_Gototext
  -- blocks the transp toggle
--~   self.idFilter:AddInterpolation({
--~     type = const.intAlpha,
--~     startValue = 255,
--~     flags = const.intfIgnoreParent
--~   })
  function self.idFilter.OnValueChanged(_, value)
    self:FindNext(value)
  end
  --improved text handling (orig used StaticText.OnKbdKeyDown...)
  function self.idFilter:OnKbdKeyDown(char, vk)
    if vk == const.vkEnter then
      self.parent:FindNext(self:GetText())
      return "break"
    elseif vk == const.vkUp then
      self.parent.idText:SetTextOffset(point(0,0))
      return "break"
    elseif vk == const.vkEsc then
      self.parent.idCloseX:Press()
      return "break"
    else
      g_Classes.SingleLineEdit.OnKbdKeyDown(self, char, vk)
    end
  end

  element_y = border + self.idFilter:GetPos():y() + self.idFilter:GetSize():y()

  title = str_Tools
  self.idTools = g_Classes.Button:new(self)
  self.idTools:SetPos(point(dialog_left+5, element_y))
  self.idTools:SetSize(RetButtonTextSize(title))
  self.idTools:SetText(title)
  self.idToolsMenu = g_Classes.ComboBox:new(self)
  self.idToolsMenu:SetPos(self.idTools:GetPos() + point(0,10))
  --height doesn't matter, but width sure does
  self.idToolsMenu:SetSize(point(100, 0))
  self.idToolsMenu:SetVisible(false)
  self.idToolsMenu:SetItemsLimit(25)
  --so it doesn't block clicking when it's closed
  self.idToolsMenu:SetZOrder(0)

  function self.idTools.OnButtonPressed()
    DialogUpdateMenuitems(self.idToolsMenu)
    --combo makes this 1000000, we need more to be on top of examine
    self.idToolsMenu.drop_dialog:SetZOrder(zorder+1)
  end

  local menuitem_DumpText = str_DumpText
  local menuitem_DumpObject = str_DumpObject
  local menuitem_ViewText = str_ViewText
  local menuitem_ViewObject = str_ViewObject
  local menuitem_EditObject = str_EditObject
  local menuitem_ExecCode = str_ExecCode
  local menuitem_Functions = str_Functions

  function self.idToolsMenu.OnComboClose(menu,idx)
    --close hint
    XDestroyRolloverWindow(true)
    if self.idToolsMenu.list.rollover then
      local text = menu.items[idx].text
      if text == menuitem_ViewText then
        local str = self:totextex(self.obj)
        --remove html tags
        str = str:gsub("<[/%s%a%d]*>","")
        local dialog = g_Classes.ChoGGi_MultiLineText:new({}, terminal.desktop,{
          checkbox = true,
          zorder = zorder,
          text = str,
          hint_ok = str_ViewTextDes,
          func = function(answer,overwrite)
            if answer then
              Dump(Concat("\n",str),overwrite,"DumpedExamine","lua")
            end
          end,
        })
        dialog:Open()
      elseif text == menuitem_ViewObject then
        local str = ValueToLuaCode(self.obj)
        local dialog = g_Classes.ChoGGi_MultiLineText:new({}, terminal.desktop,{
          checkbox = true,
          zorder = zorder,
          text = str,
          hint_ok = str_ViewObjectDes,
          func = function(answer,overwrite)
            if answer then
              Dump(Concat("\n",str),overwrite,"DumpedExamineObject","lua")
            end
          end,
        })
        dialog:Open()
      elseif text == menuitem_DumpText then
        local str = self:totextex(self.obj)
        --remove html tags
        str = str:gsub("<[/%s%a%d]*>","")
        Dump(Concat("\n",str),nil,"DumpedExamine","lua")
      elseif text == menuitem_DumpObject then
        local str = ValueToLuaCode(self.obj)
        Dump(Concat("\n",str),nil,"DumpedExamineObject","lua")
      elseif text == menuitem_EditObject then
        ChoGGi.ComFuncs.OpenInObjectManipulator(self.obj,self)
      elseif text == menuitem_ExecCode then
        ChoGGi.ComFuncs.OpenInExecCodeDlg(self.obj,self)
      elseif text == menuitem_Functions then

        local menu_added = {}
        local menu_list_items = {}
        -- adds class name then list of functions below
        local function BuildFuncList(obj_name,prefix)
          prefix = prefix or ""
          local class = _G[obj_name]
          local skip = true
          for Key,_ in pairs(class) do
            if type(class[Key]) == "function" then
              menu_list_items[Concat(prefix,obj_name,".",Key,": ")] = class[Key]
              skip = false
            end
          end
          if not skip then
            menu_list_items[Concat(prefix,obj_name)] = "\n\n\n"
          end
        end
        local function ProcessList(list,prefix)
          for i = 1, #list do
            -- CObject and Object are pretty much the same (Object has a couple more funcs)
            if not menu_added[list[i]] and list[i] ~= "CObject" then
              menu_added[list[i]] = true
              BuildFuncList(list[i],prefix)
            end
          end
        end

        ProcessList(self.parents,Concat(" ",str_Parents,": "))
        ProcessList(self.ancestors,Concat(str_Ancestors,": "))
        -- add examiner object with some spaces so it's at the top
        BuildFuncList(self.obj.class,"  ")

        OpenExamine(menu_list_items,self)

      end

    end
  end
  --setup menu items
  self.idToolsMenu:SetContent({
    {
      text = Concat("   ---- ",str_Tools),
      rollover = "-"
    },
    {
      text = menuitem_DumpText,
      rollover = str_DumpTextDes,
    },
    {
      text = menuitem_DumpObject,
      rollover = str_DumpObjectDes,
    },

    {
      text = menuitem_ViewText,
      rollover = str_ViewTextDes,
    },
    {
      text = menuitem_ViewObject,
      rollover = str_ViewObjectDes,
    },
    {
      text = "   ---- ",
      rollover = "-",
    },
    {
      text = menuitem_Functions,
      rollover = str_FunctionsDes,
    },
    {
      text = menuitem_EditObject,
      rollover = str_EditObjectDes,
    },
    {
      text = menuitem_ExecCode,
      rollover = str_ExecCodeDes,
    },
  }, true)

  element_x = 10 + self.idTools:GetPos():x() + self.idTools:GetSize():x()
  title = str_Parents
  self.idParents = g_Classes.Button:new(self)
  self.idParents:SetPos(point(element_x, element_y))
  self.idParents:SetSize(RetButtonTextSize(title))
  self.idParents:SetText(title)
  self.idParents:SetHint(str_ParentsDes)

  self.idParentsMenu = g_Classes.ComboBox:new(self)
  self.idParentsMenu:SetPos(self.idParents:GetPos() + point(0,10))
  --height doesn't matter, but width sure does
  self.idParentsMenu:SetSize(point(250, 0))
  self.idParentsMenu:SetVisible(false)
  self.idParentsMenu:SetItemsLimit(25)
  --so it doesn't block clicking when it's closed
  self.idParentsMenu:SetZOrder(0)

  function self.idParents.OnButtonPressed()
    DialogUpdateMenuitems(self.idParentsMenu)
    self.idParentsMenu.drop_dialog:SetZOrder(zorder+1)
  end

  function self.idParentsMenu.OnComboClose(menu,index)
    --close hint
    XDestroyRolloverWindow(true)
    if self.idParentsMenu.list.rollover then
      local text = menu.items[index].text
      if not text:find("-") then
        OpenExamine(_G[text],self)
      end
    end
  end

  element_x = 10 + self.idParents:GetPos():x() + self.idParents:GetSize():x()

  title = str_Attaches
  self.idAttaches = g_Classes.Button:new(self)
  self.idAttaches:SetPos(point(element_x, element_y))
  self.idAttaches:SetSize(RetButtonTextSize(title))
  self.idAttaches:SetText(title)
  self.idAttaches:SetHint(str_AttachesDes)
  self.idAttachesMenu = g_Classes.ComboBox:new(self)
  self.idAttachesMenu:SetPos(self.idAttaches:GetPos() + point(0,10))
  --height doesn't matter, but width sure does
  self.idAttachesMenu:SetSize(point(250, 0))
  self.idAttachesMenu:SetVisible(false)
  self.idAttachesMenu:SetItemsLimit(25)
  --so it doesn't block clicking when it's closed
  self.idAttachesMenu:SetZOrder(0)

  function self.idAttaches.OnButtonPressed()
    DialogUpdateMenuitems(self.idAttachesMenu)
    --combo makes this 1000000, we need more to be on top of examine
    self.idAttachesMenu.drop_dialog:SetZOrder(zorder+1)
  end

  function self.idAttachesMenu.OnComboClose(menu,idx)
    --close hint
    XDestroyRolloverWindow(true)
    if self.idAttachesMenu.list.rollover then
      local item = menu.items[idx]
      if not item.text:find("-") then
        OpenExamine(item.obj,self)
      end
    end
  end

  title = str_Next
  button_size = RetCheckTextSize(title)
  self.idNext = g_Classes.Button:new(self)
  self.idNext:SetSize(RetButtonTextSize(title))
  self.idNext:SetPos(point(dialog_width - button_size:x() - border, element_y))
  self.idNext:SetText(title)
  --self.idNext:SetTextColorDisabled(RGBA(127, 127, 127, 255))
  self.idNext:SetHSizing("AnchorToRight")
  self.idNext:SetHint(str_NextDes)
  function self.idNext.OnButtonPressed()
    self:FindNext(self.idFilter:GetText())
  end
  function self.idNext.OnRButtonPressed()
    self.idText:SetTextOffset(point(0,0))
  end

  element_y = border + self.idTools:GetPos():y() + self.idTools:GetSize():y()

  self.idText = g_Classes.StaticText:new(self)
  self.idText:SetPos(point(dialog_left, element_y))
  self.idText:SetSize(point(dialog_width, dialog_height-element_y-border-1))
  self.idText:SetHSizing("Resize")
  self.idText:SetVSizing("Resize")
  self.idText:SetBackgroundColor(RGBA(0, 0, 0, 50))
  self.idText:SetFontStyle("Editor12Bold")
  self.idText:SetScrollBar(true)
  self.idText:SetScrollAutohide(true)
  function self.idText.OnHyperLink(_, link, _, box, pos, button)
    self.onclick_handles[tonumber(link)](box, pos, button)
  end
  self.idText:AddInterpolation({
    type = const.intAlpha,
    startValue = 255,
    flags = const.intfIgnoreParent
  })
  element_y = border + self.idText:GetPos():y() + self.idText:GetSize():y()

  --so elements move when dialog re-sizes
  self:InitChildrenSizing()

  --look at them sexy internals
  self.transp_mode = transp_mode
  self:SetTranspMode(self.transp_mode)

--~   CreateRealTimeThread(function()
  DelayedCall(1, function()
    self:SetPos(point(100,100))
  end)
end

function Examine:FindNext(filter)
  local drawBuffer = self.idText.draw_cache
  local current_y = -self.idText.text_offset:y()
  local min_match, closest_match = false, false
  for y, list_draw_info in pairs(drawBuffer) do
    for i = 1, #list_draw_info do
      local draw_info = list_draw_info[i]
      if draw_info.text and draw_info.text:lower():find(filter:lower(), 0, true) then
        if not min_match or y < min_match then
          min_match = y
        end
        if y > current_y and (not closest_match or y < closest_match) then
          closest_match = y
        end
      end
    end
  end
  if min_match or closest_match then
    self.idText:SetTextOffset(point(0, -(closest_match or min_match)))
  end
end

function Examine:SetTranspMode(transp_mode)
  self.idText.scroll:ClearModifiers()
  self:ClearModifiers()
  if transp_mode then
    self.idText.scroll:AddInterpolation({
      type = const.intAlpha,
      startValue = 64,
      flags = const.intfIgnoreParent
    })
    self:AddInterpolation({
      type = const.intAlpha,
      startValue = 32
    })
  end
end
--

local function Examine_valuetotextex(_, _, button,o,self)
  if button == "left" then
    OpenExamine(o, self)
  elseif IsValid(o) then
    ShowMe(o)
  end
end
local function ShowPoint_valuetotextex(o)
  ShowMe(o)
end
function Examine:valuetotextex(o)
  local objlist = objlist
  local obj_type = type(o)
  local is_table = obj_type == "table"

  if obj_type == "function" then
    local debug_info = debug.getinfo(o, "Sn")
    return Concat(
      self:HyperLink(function(_,_,button)
        Examine_valuetotextex(_,_,button,o,self)
      end),
      tostring(debug_info.name or debug_info.name_what or str_unknownname),
      "@",
      debug_info.short_src,
      "(",
      debug_info.linedefined,
      ")",
      HLEnd
    )
  elseif IsValid(o) then
    return Concat(
      self:HyperLink(function(_,_,button)
        Examine_valuetotextex(_,_,button,o,self)
      end),
      o.class,
      HLEnd,
      "@",
      self:valuetotextex(o:GetPos())
    )
  elseif IsPoint(o) then
    return Concat(
      self:HyperLink(function()
        ShowPoint_valuetotextex(o)
      end),
      "(",o:x(),",",o:y(),",",o:z() or terrain_GetHeight(o),")",
      HLEnd
    )
  end

  if is_table then
    local meta_type = getmetatable(o)
    if meta_type and meta_type == objlist then
      local res = {
        self:HyperLink(function(_,_,button)
          Examine_valuetotextex(_,_,button,o,self)
        end),
        "objlist",
        HLEnd,
        "{",
      }
      for i = 1, Min(#o, 3) do
        res[#res+1] = i
        res[#res+1] = " = "
        res[#res+1] = self:valuetotextex(o[i])
      end
      if #o > 3 then
        res[#res+1] = "..."
      end
      res[#res+1] = ", "
      res[#res+1] = "}"
      return TableConcat(res)
    else
      -- regular table
      local table_data

      if #o > 0 then
        table_data = #o
      elseif next(o) then
        table_data = str_Data
      else
        table_data = 0
      end

      return Concat(
        self:HyperLink(function(_,_,button)
          Examine_valuetotextex(_,_,button,o,self)
        end),
        Concat(RetName(o)," (len: ",table_data,")"),
        HLEnd
      )
    end

  elseif obj_type == "thread" then
    return Concat(
      self:HyperLink(function(_,_,button)
        Examine_valuetotextex(_,_,button,o,self)
      end),
      tostring(o),
      HLEnd
    )
  elseif obj_type == "string" then
    return Concat(
      "'",
      o,
      "'"
    )
  elseif obj_type == "userdata" then
    local str = T(o)
    -- might as well just return the userdata instead of these
    if str == "stripped" or str:find("Missing locale string id") then
      str = o
    end
    return Concat(
      "'",
      str,
      -- <left> is needed for descriptions that stick stuff on the right (well needed for the stuff after it)
      -- igi > infopanel > something with a colonist spec
      "'<left>"
    )
  end

--~   return tostring(o)
  return o
end

function Examine:HyperLink(f, custom_color)
  self.onclick_handles[#self.onclick_handles+1] = f
  return Concat(
    (custom_color or "<color 150 170 250>"),
    "<h ",
    #self.onclick_handles,
    " 230 195 50>"
  )
end

--~ local filters = {
--~   Short = {
--~     "StateObject1"
--~   },
--~   TraceCall = {"Call"},
--~   Long = {
--~     "StateObject1",
--~     "StateObject2"
--~   },
--~   General = {false}
--~ }
--~ function Examine:filtersmarttable(e)
--~   local LocalStorage = LocalStorage
--~   local format_text = tostring(e[2])
--~   local t = string.match(format_text, "^%[(.*)%]")
--~   if t then
--~     if LocalStorage.trace_config ~= nil then
--~       local filter = filters[LocalStorage.trace_config] or filters.General
--~       if not table.find(filter, t) then
--~         return false
--~       end
--~     end
--~     format_text = string.sub(format_text, 3 + #t)
--~   end
--~   return format_text, e
--~ end
--~ function Examine:evalsmarttable(format_text, e)
--~   local touched = {}
--~   local i = 0
--~   format_text = string.gsub(format_text, "{(%d-)}", function(s)
--~     if #s == 0 then
--~       i = i + 1
--~     else
--~       i = tonumber(s)
--~     end
--~     touched[i + 1] = true
--~     return Concat(
--~       "<color 255 255 128>",self:valuetotextex(e[i + 2]),"</color>"
--~     )
--~   end)
--~   for i = 2, #e do
--~     if not touched[i] then
--~       format_text = Concat(
--~         format_text," <color 255 255 128>[",self:valuetotextex(e[i]),"]</color>"
--~       )
--~     end
--~   end
--~   return format_text
--~ end

---------------------------------------------------------------------------------------------------------------------
local function ExamineThreadLevel_totextex(level, info, o,self)
  local data = {}
  local l = 1
  while true do
    local name, val = debug.getlocal(o, level, l)
    if name then
      data[name] = val
      l = l + 1
    else
      break
    end
  end
  for i = 1, info.nups do
    local name, val = debug.getupvalue(info.func, i)
    if name ~= nil and val ~= nil then
      data[Concat(name,"(up)")] = val
    end
  end
  return function()
    OpenExamine(data, self)
  end
end
local function Examine_totextex(o,self)
  OpenExamine(o, self)
end
function Examine:totextex(o)
  local res = {}
  local sort = {}
  local obj_metatable = getmetatable(o)
  local obj_type = type(o)
  local is_table = obj_type == "table"

  if is_table then

    for k, v in pairs(o) do
      res[#res+1] = Concat(
        self:valuetotextex(k),
        " = ",
        self:valuetotextex(v)
      )
      if type(k) == "number" then
        sort[res[#res]] = k
      end
    end

  elseif obj_type == "thread" then

    local info, level = true, 0
    while true do
      info = debug.getinfo(o, level, "Slfun")
      if info then
        res[#res+1] = Concat(
          self:HyperLink(function(level, info)
            ExamineThreadLevel_totextex(level, info, o,self)
          end),
          self:HyperLink(ExamineThreadLevel_totextex(level, info, o,self)),
          info.short_src,
          "(",
          info.currentline,
          ") ",
          (info.name or info.name_what or str_unknownname),
          HLEnd
        )
      else
        res[#res+1] = Concat("<color 255 255 255>\nThread info: ",
          "\nIsValidThread: ",IsValidThread(o),
          "\nGetThreadStatus: ",GetThreadStatus(o),
          "\nIsGameTimeThread: ",IsGameTimeThread(o),
          "\nIsRealTimeThread: ",IsRealTimeThread(o),
          "\nThreadHasFlags: ",ThreadHasFlags(o),
          "</color>"
        )
        break
      end
      level = level + 1
    end

  elseif obj_type == "function" then

    local i = 1
    while true do
      local k, v = debug.getupvalue(o, i)
      if k then
        res[#res+1] = Concat(
          self:valuetotextex(k),
          " = ",
          self:valuetotextex(v)
        )
      else
        res[#res+1] = self:valuetotextex(o)
        break
      end
      i = i + 1
    end --while

  end

  table.sort(res, function(a, b)
    if sort[a] and sort[b] then
      return sort[a] < sort[b]
    end
    if sort[a] or sort[b] then
      return sort[a] and true
    end
    return CmpLower(a, b)
  end)

--~   if is_table and obj_metatable == g_traceMeta and obj_metatable == g_traceMeta then
--~     local items = 1
--~     for i = 1, #o do
--~       if not (items >= self.page * 150) then
--~         local format_text, e = self:filtersmarttable(o[i])
--~         if format_text then
--~           items = items + 1
--~           if items >= (self.page - 1) * 150 then
--~             local t = self:evalsmarttable(format_text, e)
--~             if t then
--~               if self.show_times ~= "relative" then
--~                 t = Concat("<color 255 255 0>",tostring(e[1]),"</color>:",t)
--~               else
--~                 t = Concat("<color 255 255 0>",tostring(e[1] - GameTime()),"</color>:",t)
--~               end
--~               res[#res+1] = Concat(
--~                 t,
--~                 "<vspace 8>"
--~               )
--~             end
--~           end
--~         end
--~       end
--~     end
--~   end
  if IsValid(o) and o:IsKindOf("CObject") then

    table.insert(res,1,Concat(
      "<center>--",
      self:HyperLink(function()
        Examine_totextex(obj_metatable,self)
      end),
      o.class,
      HLEnd,
      "@",
      self:valuetotextex(o:GetPos()),
      "--<vspace 6><left>"
    ))

    if o:IsValidPos() and IsValidEntity(o.entity) and 0 < o:GetAnimDuration() then
      local pos = o:GetVisualPos() + o:GetStepVector() * o:TimeToAnimEnd() / o:GetAnimDuration()
      table.insert(res, 2, Concat(
        GetStateName(o:GetState()),
        ", step:",
        self:HyperLink(function()
          ShowMe(pos)
        end),
        tostring(o:GetStepVector(o:GetState(),0)),
        HLEnd
      ))
    end

  elseif is_table and obj_metatable then
--~     if obj_metatable == g_traceMeta then
--~       table.insert(res, 1, Concat(
--~         "<center>--",
--~         T(302535920000056--[[Trace Log--]]),
--~         "--<vspace 6><left>"
--~       ))
--~       if self.show_times == "relative" then
--~           table.insert(res, 1, Concat(
--~             "<center>--",
--~             T(302535920000057--[[relative times--]]),
--~             "--<vspace 6><left>"
--~           ))
--~       end
--~     else
      table.insert(res, 1, Concat(
        "<center>--",
        self:valuetotextex(obj_metatable),
        ": metatable--<vspace 6><left>"
      ))
--~     end
  end

  -- add strings/numbers to the body
  if obj_type == "number" or obj_type == "string" or obj_type == "boolean" then
    res[#res+1] = tostring(o)
  elseif obj_type == "userdata" then
    local str = T(o)
    -- might as well just return the userdata instead of these
    if str == "stripped" or str:find("Missing locale string id") then
      str = o
    end
    res[#res+1] = tostring(str)
  -- add some extra info for funcs
  elseif obj_type == "function" then
    local dbg_value = "\ndebug.getinfo: "
    local dbg_table = debug.getinfo(o) or empty_table
    for key,value in pairs(dbg_table) do
      dbg_value = Concat(dbg_value,"\n",key,": ",value)
    end
    res[#res+1] = dbg_value
  end

  return TableConcat(res,"\n")
end
---------------------------------------------------------------------------------------------------------------------
--menu
local function Show_menu(o)
  if IsValid(o) then
    ShowMe(o)
  else
    for k, v in pairs(o) do
      if IsPoint(k) or IsValid(k) then
        ShowMe(k)
      end
      if IsPoint(v) or IsValid(v) then
        ShowMe(v)
      end
    end
  end
end
local function ClearShowMe_menu()
  ChoGGi.ComFuncs.ClearShowMe()
end
--~ local function ShowLog_menu(o,self)
--~   OpenExamine(o.trace_log, self)
--~ end
local function Destroy_menu(o,self)
  local z = self.ZOrder
  self:SetZOrder(1)
  ChoGGi.ComFuncs.QuestionBox(
    str_DestroyQues,
    function(answer)
      self:SetZOrder(z)
      if answer and IsValid(o) then
    --~     o:delete()
        ChoGGi.CodeFuncs.DeleteObject(o)
      end
    end,
    str_Destroy
  )
end
--~ local function Assign_menu(_, _, button,name,o,self)
--~   return function(button)
--~     if button == "left" then
--~       rawset(_G, name, o)
--~       self.idLinks:SetText(self:menu(o))
--~     elseif button == "right" then
--~       ShowMe(rawget(_G, name), RGB(0, 0, 255))
--~       OpenExamine(rawget(_G, name), self)
--~     end
--~   end
--~ end
--~ local function ShowTime_menu(o,self)
--~   if self.show_times then
--~     if self.show_times == "relative" then
--~       self.show_times = "absolute"
--~     else
--~       self.show_times = false
--~     end
--~   else
--~     self.show_times = "relative"
--~   end
--~   if self.obj then
--~     self:SetObj(self.obj)
--~   end
--~ end
local function Refresh_menu(_,self)
  if self.obj then
    self:SetObj(self.obj)
  end
end
local function SetTransp_menu(_,self)
  self.transp_mode = not self.transp_mode
  self:SetTranspMode(self.transp_mode)
end
--~ local function Switch_menu(t,o,self)
--~   return function()
--~     LocalStorage.trace_config = t
--~     SaveLocalStorage()
--~     self:SetObj(self.obj)
--~   end, LocalStorage.trace_config == t and "<color 0 255 0>"
--~ end
--~ local function Prev_menu(o,self)
--~   self.page = Max(1, self.page - 1)
--~   --self:SetObj(self.obj)
--~ end
--~ local function Next_menu(o,self)
--~   self.page = self.page + 1
--~   --self:SetObj(self.obj)
--~ end
function Examine:menu(o)
--~   local obj_metatable = getmetatable(o)
  local obj_type = type(o)
  local res = {"  "}
  res[#res+1] = self:HyperLink(function()
    Refresh_menu(o,self)
  end)
  res[#res+1] = "["
  res[#res+1] = str_Refresh
  res[#res+1] = "]"
  res[#res+1] = HLEnd
  res[#res+1] = " "
  if IsValid(o) and obj_type == "table" then
    res[#res+1] = self:HyperLink(function()
      Show_menu(o)
    end)
    res[#res+1] = str_ShowIt
    res[#res+1] = HLEnd
    res[#res+1] = " "
  end
  res[#res+1] = self:HyperLink(ClearShowMe_menu)
  res[#res+1] = str_ClearMarkers
  res[#res+1] = HLEnd
  res[#res+1] = " "
  res[#res+1] = self:HyperLink(function()
    SetTransp_menu(o,self)
  end)
  res[#res+1] = str_Transp
  res[#res+1] = HLEnd
  if IsValid(o) then
    res[#res+1] = " "
    res[#res+1] = self:HyperLink(function()
      Destroy_menu(o,self)
    end)
    res[#res+1] = str_DestroyIt
    res[#res+1] = HLEnd
    res[#res+1] = " "
--~     if o:HasMember("trace_log") then
--~       res[#res+1] = self:HyperLink(function()
--~         ShowLog_menu(o,self)
--~       end)
--~       res[#res+1] = T(302535920000061--[[[Log]--]])
--~       res[#res+1] = HLEnd
--~       res[#res+1] = " "
--~     end
  end
--~   if obj_type == "table" and obj_metatable == g_traceMeta then
--~     res[#res+1] = self:HyperLink(function()
--~       ShowTime_menu(o,self)
--~     end)
--~     res[#res+1] = T(302535920000062--[[[Times]--]])
--~     res[#res+1] = HLEnd
--~     res[#res+1] = " "
--~   end
  --res[#res+1] = "\n"
--~   if obj_type == "table" and obj_metatable == g_traceMeta then
--~     res[#res+1] = "\n"
--~     res[#res+1] = self:HyperLink(function()
--~       Switch_menu("Short",o,self)
--~     end)
--~     res[#res+1] = "["
--~     res[#res+1] = T(302535920000065--[[Short--]])
--~     res[#res+1] = "]</color>"
--~     res[#res+1] = HLEnd
--~     res[#res+1] = " "
--~     res[#res+1] = self:HyperLink(function()
--~       Switch_menu("Long",o,self)
--~     end)
--~     res[#res+1] = "["
--~     res[#res+1] = T(302535920000066--[[Long--]])
--~     res[#res+1] = "]</color>"
--~     res[#res+1] = HLEnd
--~     res[#res+1] = " "
--~     res[#res+1] = self:HyperLink(function()
--~       Switch_menu("TraceCall",o,self)
--~     end)
--~     res[#res+1] = "["
--~     res[#res+1] = T(302535920000067--[[TraceCall--]])
--~     res[#res+1] = "]</color>"
--~     res[#res+1] = HLEnd
--~     res[#res+1] = " "
--~     res[#res+1] = self:HyperLink(function()
--~       Switch_menu(false,o,self)
--~     end)
--~     res[#res+1] = "["
--~     res[#res+1] = T(1000111--[[General--]])
--~     res[#res+1] = "]</color>"
--~     res[#res+1] = HLEnd
--~     res[#res+1] = self:HyperLink(function()
--~       Prev_menu(false,o,self)
--~     end)
--~     res[#res+1] = "[-]"
--~     res[#res+1] = HLEnd
--~     res[#res+1] = self.page
--~     res[#res+1] = self:HyperLink(function()
--~       Next_menu(false,o,self)
--~     end)
--~     res[#res+1] = "[+]"
--~     res[#res+1] = HLEnd
--~   else
--~     res[#res+1] = "\n  "
--~     res[#res+1] = T(302535920000228--[[Assign to--]])
--~     res[#res+1] = ": "
--~     for i = 1, 3 do
--~       local name = Concat("o",i)
--~       res[#res+1] = self:HyperLink(function()
--~       --rawget(_G, name) == o and "<color 0 255 0>"
--~         Assign_menu(_, _, button,name,o,self)
--~       end)
--~       res[#res+1] = "["
--~       res[#res+1] = name
--~       res[#res+1] = "]"
--~       res[#res+1] = HLEnd
--~       res[#res+1] = "</color> "
--~     end
--~   end
  return TableConcat(res)
end

-- used to build parents/ancestors menu
local pmenu_list_items
local pmenu_skip_dupes
local function BuildParents(self,list,list_type,title,sort_type)
  if list and next(list) then
    list = RetSortTextAssTable(list,sort_type)
    self[list_type] = list
    pmenu_list_items[#pmenu_list_items+1] = {text = Concat("   ---- ",title)}
    for i = 1, #list do
      -- no sense in having an item in parents and ancestors
      if not pmenu_skip_dupes[list[i]] then
        pmenu_skip_dupes[list[i]] = true
        pmenu_list_items[#pmenu_list_items+1] = {text = list[i]}
      end
    end
  end
end
function Examine:SetObj(o)
  local ChoGGi = ChoGGi

  if ChoGGi.Testing then
    ChoGGi.ComFuncs.TickStart("Examine:SetObj")
  end
  self.onclick_handles = {}
  self.obj = o
  self.idText:SetText(self:totextex(o))
  self.idLinks:SetText(self:menu(o))

  local is_table = type(o) == "table"
  local name = RetName(o)

  --update attaches button with attaches amount
  local attaches = is_table and type(o.GetAttaches) == "function" and o:GetAttaches()
  local attach_amount = attaches and #attaches or 0
  self.idAttaches:SetHint(str_AttachesDes2:format(name,attach_amount))
  if is_table then

    --add object name to title
    if type(o.handle) == "number" then
      self.idCaption:SetText(Concat(name," (",o.handle,")"))
    else
      --limit length so we don't cover up close button (only for objlist, everything else is short enough)
      self.idCaption:SetText(utf8.sub(name, 1, 50))
    end

    -- reset menu list
    pmenu_list_items = {}
    pmenu_skip_dupes = {}
    -- build menu list
    BuildParents(self,o.__parents,"parents",str_Parents)
    BuildParents(self,o.__ancestors,"ancestors",str_Ancestors,true)
    -- if anything was added to the list then add to the menu
    if #pmenu_list_items > 0 then
      self.idParentsMenu:SetContent(pmenu_list_items, true)
    else
      --no parents or ancestors, so hide the button
      self.idParents:SetVisible()
    end

    --attaches menu
    if attaches and attach_amount > 0 then

      local spacer_text = str_Attaches
      local list_items = {
        {
          text = Concat("   ---- ",spacer_text),
          rollover = spacer_text
        }
      }

      for i = 1, #attaches do
        local hint = attaches[i].handle or type(attaches[i].GetPos) == "function" and Concat("Pos: ",attaches[i]:GetPos())
        if type(hint) == "number" then
          hint = Concat(str_Handle,": ",hint)
        end
        list_items[#list_items+1] = {
          text = RetName(attaches[i]),
          rollover = hint or attaches[i].class,
          obj = attaches[i],
        }
      end

      self.idAttachesMenu:SetContent(list_items, true)

    else
      self.idAttaches:SetVisible()
    end

  else
    self.idCaption:SetText(utf8.sub(name, 1, 50))
  end

  if ChoGGi.Testing then
    ChoGGi.ComFuncs.TickEnd("Examine:SetObj")
  end
end

--~ function Examine:SetText(text)
--~   if ChoGGi.Testing then
--~     print("Examine:SetText(text)",Examine:SetText(text))
--~   end
--~   self.onclick_handles = {}
--~   self.obj = false
--~   self.idText:SetText(text)
--~   self.idLinks:SetText(self:menu())
--~ end

function Examine:Done(result)
  g_Classes.Dialog.Done(self,result)
end
