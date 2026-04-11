#include "pch.h"
#include "framework.h"
#include "injector_impl.h"
#include "Common.h"

const char* k_init_lua_code0 = R"(
    jyqxz_trace_log = 0;
    jyqxz_baoxi_dengji = 0;
    jyqxz_baoxi_wugong = 0;
    jyqxz_baoxi_maxvalue = 0;
    jyqxz_baoxi_use_clever = 0;
    jyqxz_adjust_wupin = 0;
    jyqxz_baoxi_maxvalue_dict = {};
    jyqxz_person_cheatdata_dict = {};

    jyqxz_trace_data_on_load = 1;

    function War_PrintTrace(str)
        if jyqxz_trace_log > 0 then
            lib.Debug(str);
        end
    end        
    
    function traceAllPersonData()
       War_PrintTrace("----traceAllPersonData Begin------");
       for k, v in pairs(JY.Person) do
           if type(k) == "number" and k == math.floor(k) and k > 0 then
              War_PrintTrace(string.format("result.push_back(std::make_pair<std::wstring, int>(L\"%s\", 0x%02X));",
                  v["\208\213\195\251"], k));
           end
       end  
       War_PrintTrace("----traceAllPersonData End------");     
    end   

    function traceAllWuPinData()
       War_PrintTrace("----traceAllWuPinData Begin------");
       for k, v in pairs(JY.Thing) do
          War_PrintTrace(string.format("s_datas[%d] = L\"%s\";", 
              k,
              v["\195\251\179\198"]
           ));
       end  
       War_PrintTrace("----traceAllWuPinData End------");     
    end 

    function traceAllWuGongData()
       War_PrintTrace("----traceAllWuGongData Begin------");
       for k, v in pairs(JY.Wugong) do
          War_PrintTrace(string.format("s_datas[%d] = L\"%s\";", 
              k,
              v["\195\251\179\198"]
           ));
       end  
       War_PrintTrace("----traceAllWuGongData End------");     
    end 

    function War_IsPersonInTeam(pid)
        local result = 0;
        local teamnum = GetTeamNum();
        for i = 1, teamnum do
            if JY.Base["\182\211\206\233" .. i] == pid then
                result = 1;
                break;
            end
        end
        if result < 1 then
            War_PrintTrace(string.format("npc_person, pid = 0x%04x", pid));
        end
        return result;
    end

    function GetTeamPersons()
      local persons = {};
      for i = 1, CC.TeamNum do
        persons["duiyou"..i] = JY.Base["\182\211\206\233" .. i];
        if JY.Base["\182\211\206\233" .. i] < 0 then
           persons["duiyou"..i] = -1;
        end
      end
      return persons
    end
 
    function War_AdjustPersonPropMinValue(pid)
        local min_value = 25;  
        if JY.Person[pid]["\210\189\193\198\196\220\193\166"] < min_value then
           JY.Person[pid]["\210\189\193\198\196\220\193\166"] = min_value; 
        end
        if JY.Person[pid]["\211\195\182\190\196\220\193\166"] < min_value then
           JY.Person[pid]["\211\195\182\190\196\220\193\166"] = min_value; 
        end
        if JY.Person[pid]["\189\226\182\190\196\220\193\166"] < min_value then
           JY.Person[pid]["\189\226\182\190\196\220\193\166"] = min_value; 
        end
        if JY.Person[pid]["\200\173\213\198\185\166\183\242"] < min_value then
           JY.Person[pid]["\200\173\213\198\185\166\183\242"] = min_value; 
        end
        if JY.Person[pid]["\211\249\189\163\196\220\193\166"] < min_value then
           JY.Person[pid]["\211\249\189\163\196\220\193\166"] = min_value; 
        end    
        if JY.Person[pid]["\203\163\181\182\188\188\199\201"] < min_value then
           JY.Person[pid]["\203\163\181\182\188\188\199\201"] = min_value; 
        end    
        if JY.Person[pid]["\204\216\202\226\177\248\198\247"] < min_value then
           JY.Person[pid]["\204\216\202\226\177\248\198\247"] = min_value; 
        end    
        if JY.Person[pid]["\176\181\198\247\188\188\199\201"] < min_value then
           JY.Person[pid]["\176\181\198\247\188\188\199\201"] = min_value; 
        end 
    end

    function Fucker_AdjustPropsMaxValue()
        if rawget(jyqxz_baoxi_maxvalue_dict, "gongji") == nil then
            jyqxz_baoxi_maxvalue_dict["gongji"] = CC.PersonAttribMax["\185\165\187\247\193\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "fangyu") == nil then
            jyqxz_baoxi_maxvalue_dict["fangyu"] = CC.PersonAttribMax["\183\192\211\249\193\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "qinggong") == nil then
            jyqxz_baoxi_maxvalue_dict["qinggong"] = CC.PersonAttribMax["\199\225\185\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "yiliao") == nil then
            jyqxz_baoxi_maxvalue_dict["yiliao"] = CC.PersonAttribMax["\210\189\193\198\196\220\193\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "yongdu") == nil then
            jyqxz_baoxi_maxvalue_dict["yongdu"] = CC.PersonAttribMax["\211\195\182\190\196\220\193\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "jiedu") == nil then
            jyqxz_baoxi_maxvalue_dict["jiedu"] = CC.PersonAttribMax["\189\226\182\190\196\220\193\166"];  
        end    
        if rawget(jyqxz_baoxi_maxvalue_dict, "quanzhang") == nil then
            jyqxz_baoxi_maxvalue_dict["quanzhang"] = CC.PersonAttribMax["\200\173\213\198\185\166\183\242"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "yujian") == nil then
            jyqxz_baoxi_maxvalue_dict["yujian"] = CC.PersonAttribMax["\211\249\189\163\196\220\193\166"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "shuadao") == nil then
            jyqxz_baoxi_maxvalue_dict["shuadao"] = CC.PersonAttribMax["\203\163\181\182\188\188\199\201"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "teshu") == nil then
            jyqxz_baoxi_maxvalue_dict["teshu"] = CC.PersonAttribMax["\204\216\202\226\177\248\198\247"];  
        end
        if rawget(jyqxz_baoxi_maxvalue_dict, "anqi") == nil then
            jyqxz_baoxi_maxvalue_dict["anqi"] = CC.PersonAttribMax["\176\181\198\247\188\188\199\201"];  
        end
        local multi = 1.0;
        if jyqxz_baoxi_maxvalue >= 1 then
            multi = 1.25;
        end 
        if jyqxz_baoxi_maxvalue >= 2 then
            multi = 1.50;
        end 
        CC.PersonAttribMax["\185\165\187\247\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["gongji"]);
        CC.PersonAttribMax["\183\192\211\249\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["fangyu"]);
        CC.PersonAttribMax["\199\225\185\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["qinggong"]);
    
        CC.PersonAttribMax["\210\189\193\198\196\220\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["yiliao"]);
        CC.PersonAttribMax["\211\195\182\190\196\220\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["yongdu"]);  
        CC.PersonAttribMax["\189\226\182\190\196\220\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["jiedu"]);  

        CC.PersonAttribMax["\200\173\213\198\185\166\183\242"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["quanzhang"]);  
        CC.PersonAttribMax["\211\249\189\163\196\220\193\166"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["yujian"]);  
        CC.PersonAttribMax["\203\163\181\182\188\188\199\201"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["shuadao"]);  
        CC.PersonAttribMax["\204\216\202\226\177\248\198\247"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["teshu"]);  
        CC.PersonAttribMax["\176\181\198\247\188\188\199\201"] = math.floor(multi * jyqxz_baoxi_maxvalue_dict["anqi"]);  

        War_PrintTrace(string.format("maxvalue_gongji = %d", jyqxz_baoxi_maxvalue_dict["gongji"]));
        War_PrintTrace(string.format("maxvalue_fangyu = %d", jyqxz_baoxi_maxvalue_dict["fangyu"]));
        War_PrintTrace(string.format("maxvalue_qinggong = %d", jyqxz_baoxi_maxvalue_dict["qinggong"]));
        War_PrintTrace(string.format("maxvalue_yiliao = %d", jyqxz_baoxi_maxvalue_dict["yiliao"]));
        War_PrintTrace(string.format("maxvalue_yongdu = %d", jyqxz_baoxi_maxvalue_dict["yongdu"]));
        War_PrintTrace(string.format("maxvalue_jiedu = %d", jyqxz_baoxi_maxvalue_dict["jiedu"]));
        War_PrintTrace(string.format("maxvalue_quanzhang = %d", jyqxz_baoxi_maxvalue_dict["quanzhang"]));
        War_PrintTrace(string.format("maxvalue_yujian = %d", jyqxz_baoxi_maxvalue_dict["yujian"]));
        War_PrintTrace(string.format("maxvalue_shuadao = %d", jyqxz_baoxi_maxvalue_dict["shuadao"]));
        War_PrintTrace(string.format("maxvalue_teshu = %d", jyqxz_baoxi_maxvalue_dict["teshu"]));
        War_PrintTrace(string.format("maxvalue_anqi = %d", jyqxz_baoxi_maxvalue_dict["anqi"]));
        War_PrintTrace(string.format("maxvalue_multi = %d", 100 * multi));

        return; 
    end


    Raw_LoadRecord = LoadRecord;
    LoadRecord = function(id)
        War_PrintTrace("LoadRecord Called");
        Raw_LoadRecord(id);
        if jyqxz_trace_data_on_load > 0 then
           return;
        end
        local data = Byte.create(24)
        Byte.loadfile(data, CC.R_IDXFilename[0], 0, 24)
        local idx = {}
        idx[0] = 0
        for i = 1, 6 do
          idx[i] = Byte.get32(data, 4 * (i - 1))
        end
        War_PrintTrace(string.format("idx[0]=0, idx[1]=%f, idx[2]=%f, idx[3]=%f, idx[4]=%f, idx[5]=%f, idx[6]=%f" 
              ,idx[1], idx[2], idx[3], idx[4], idx[5], idx[6]));
        War_PrintTrace(string.format("JY.PersonNum = %f, CC.PersonSize=%f", JY.PersonNum, CC.PersonSize));
        War_PrintTrace(string.format("JY.ThingNum = %f, CC.ThingSize=%f", JY.ThingNum, CC.ThingSize));
        War_PrintTrace(string.format("JY.SceneNum = %f, CC.SceneSize=%f", JY.SceneNum, CC.SceneSize));
        War_PrintTrace(string.format("JY.WugongNum = %f, CC.WugongSize=%f", JY.WugongNum, CC.WugongSize));
        War_PrintTrace(string.format("JY.ShopNum = %f, CC.ShopSize=%f", JY.ShopNum, CC.ShopSize));
        War_PrintTrace("----------------------------------------------------------------------------------------------");

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
        War_PrintTrace(string.format("thnum = %f, newnum=%f", thnum, newnum));
        for newnum = 0, thnum - 1 do
    --      JY.Base["\206\239\198\183" .. newnum + 1] = newthing[newnum][1]
    --      JY.Base["\206\239\198\183\202\253\193\191" .. newnum + 1] = newthing[newnum][2]
          War_PrintTrace(string.format("index=%d, id=%02X, count=%d", newnum + 1, newthing[newnum][1], newthing[newnum][2]));
        end
        War_PrintTrace("----------------------------------------------------------------------------------------------");
        traceAllPersonData();
        traceAllWuPinData();
        traceAllWuGongData();
        jyqxz_trace_data_on_load = jyqxz_trace_data_on_load + 1;
    end


)";

const char* k_init_lua_code = R"(

Raw_War_AddPersonLevel = War_AddPersonLevel;
War_AddPersonLevel = function(pid)
    War_PrintTrace("War_AddPersonLevel called");
    if War_IsPersonInTeam(pid) < 1 then        
        return Raw_War_AddPersonLevel(pid);
    end
    local tmplevel = JY.Person[pid]["\181\200\188\182"];
    local tmp_clever = JY.Person[pid]["\215\202\214\202"]
    local use_clever = tmp_clever
    local tmpExp = {};
    if jyqxz_baoxi_use_clever > 0 then
        use_clever = 100;
    end
    War_PrintTrace(string.format("tmp_clever=%d, use_clever=%d", tmp_clever, use_clever));
    if jyqxz_baoxi_dengji < 1 then
        JY.Person[pid]["\215\202\214\202"] = use_clever;
        for i = 1, CC.Level do
          tmpExp[i] = CC.Exp[i];
          CC.Exp[i] = math.modf(CC.Exp[i] / 100);  
        end
        local result = Raw_War_AddPersonLevel(pid);
        JY.Person[pid]["\215\202\214\202"] = tmp_clever;
        for i = 1, CC.Level do
          CC.Exp[i] = tmpExp[i];
        end
        return result; 
    end
    War_PrintTrace(string.format("tmplevel=%d", tmplevel));
    War_PrintTrace(string.format("CC.Level=%d", CC.Level));  
    War_PrintTrace(string.format("GetTeamNum()=%d", GetTeamNum()));  
    War_PrintTrace(string.format("War_IsPersonInTeam(%d)=%d", pid, War_IsPersonInTeam(pid)));  
    if tmplevel >= CC.Level then
        tmplevel = CC.Level;
        JY.Person[pid]["\181\200\188\182"] = CC.Level - 1;
        if jyqxz_baoxi_dengji > 1 or JY.Person[pid]["\181\200\188\182"] < 1 then
            JY.Person[pid]["\181\200\188\182"] = 1;
        end
        if jyqxz_baoxi_dengji > 2 then
            War_AdjustPersonPropMinValue(pid) 
        end
    end
    for i = 1, CC.Level do
      tmpExp[i] = CC.Exp[i];
      CC.Exp[i] = math.modf(CC.Exp[i] / 100);  
    end
    JY.Person[pid]["\215\202\214\202"] = use_clever;
    local raw_ret = Raw_War_AddPersonLevel(pid);
    JY.Person[pid]["\215\202\214\202"] = tmp_clever;
    for i = 1, CC.Level do
      CC.Exp[i] = tmpExp[i];
    end
    if tmplevel >= CC.Level then
        JY.Person[pid]["\181\200\188\182"] = tmplevel;
        if pid == 0 and JY.Person[pid]["\185\165\187\247\193\166"] > jyqxz_baoxi_maxvalue_dict["gongji"] then
            JY.Person[pid]["\185\165\187\247\193\166"] = jyqxz_baoxi_maxvalue_dict["gongji"];
        end
    end
    return raw_ret;
end      

Raw_War_PersonTrainBook = War_PersonTrainBook;
War_PersonTrainBook = function(pid)
    War_PrintTrace(string.format("War_PersonTrainBook called 0, pid=%s", pid));
    if War_IsPersonInTeam(pid) < 1 then        
        Raw_War_PersonTrainBook(pid);
        return; 
    end
    local tmp_clever = JY.Person[pid]["\215\202\214\202"]; 
    local use_clever = tmp_clever
    if jyqxz_baoxi_use_clever > 0 then
        use_clever = 100;
    end
    War_PrintTrace(string.format("War_PersonTrainBook called 1, pid=%s, tmp_clever=%d, use_clever=%d", pid, tmp_clever, use_clever)); 
    if jyqxz_baoxi_wugong < 1 then
        JY.Person[pid]["\215\202\214\202"] = use_clever;
        Raw_War_PersonTrainBook(pid);
        JY.Person[pid]["\215\202\214\202"] = tmp_clever;
        return; 
    end
    War_PrintTrace(string.format("War_PersonTrainBook called 2, pid=%s", pid)); 
    local p = JY.Person[pid]
    local thingid = p["\208\222\193\182\206\239\198\183"]
    if thingid < 0 then
        Raw_War_PersonTrainBook(pid);
        return; 
    end
    War_PrintTrace(string.format("War_PersonTrainBook called 3, pid=%s, thingid=%d", pid, thingid)); 
    local pos = -1; 
    local level = 0
    local old_level_data = -1
    local old_wugong_id = 0
    if 0 <= JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
        local wugong_count = 0
        for i = 1, 10 do
          if JY.Person[pid]["\206\228\185\166" .. i] > 0  then
              wugong_count = wugong_count + 1
              if JY.Person[pid]["\206\228\185\166" .. i] == JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
                  wugong_count = wugong_count - 1
              end   
          end
        end
        if wugong_count >= 10 then
            pos = 1;
            level = 9;
            old_wugong_id = JY.Person[pid]["\206\228\185\166" .. pos]
        end
        --[[
        for i = 1, 10 do
            if JY.Person[pid]["\206\228\185\166" .. i] == JY.Thing[thingid]["\193\183\179\246\206\228\185\166"] then
                level = math.modf(JY.Person[pid]["\206\228\185\166\181\200\188\182" .. i] / 100)
                pos = i;
                break
            end
        end
        ]]--
        if level >= 9 and pos > 0 then
            old_level_data = JY.Person[pid]["\206\228\185\166\181\200\188\182" .. pos];
            JY.Person[pid]["\206\228\185\166\181\200\188\182" .. pos] = 0;
            JY.Person[pid]["\206\228\185\166" .. pos] = JY.Thing[thingid]["\193\183\179\246\206\228\185\166"];
        end               
    end   
    War_PrintTrace(string.format("War_PersonTrainBook called 4, pid=%s, pos=%d, level=%d, tmp_clever=%d", pid, pos, level, tmp_clever)); 
    JY.Person[pid]["\215\202\214\202"] = use_clever;
    Raw_War_PersonTrainBook(pid);
    JY.Person[pid]["\215\202\214\202"] = tmp_clever;
    if level >= 9 and pos > 0 and old_wugong_id > 0 then
       JY.Person[pid]["\206\228\185\166\181\200\188\182" .. pos] = old_level_data;
       JY.Person[pid]["\206\228\185\166" .. pos] = old_wugong_id;
    end
end

Raw_TrainNeedExp = TrainNeedExp;
TrainNeedExp = function(pid)
    --War_PrintTrace(string.format("TrainNeedExp called 0, pid=%s, jyqxz_baoxi_wugong=%d", pid, jyqxz_baoxi_wugong));
    if War_IsPersonInTeam(pid) < 1 then        
        return Raw_TrainNeedExp(pid);
    end
    if jyqxz_baoxi_wugong < 2 then        
        return Raw_TrainNeedExp(pid);
    end
    local thingid = JY.Person[pid]["\208\222\193\182\206\239\198\183"];
    local exp = JY.Thing[thingid]["\208\232\190\173\209\233"];
    --War_PrintTrace(string.format("TrainNeedExp called 1, pid=%s,thingid=%d,exp=%d,raw_exp=%d", pid, thingid, exp, JY.Thing[thingid]["\208\232\190\173\209\233"]));
    JY.Thing[thingid]["\208\232\190\173\209\233"] = (exp / 10) + 1;    
    local r = Raw_TrainNeedExp(pid);
    --War_PrintTrace(string.format("TrainNeedExp called 2, pid=%s,thingid=%d,exp=%d,raw_exp=%d", pid, thingid, exp, JY.Thing[thingid]["\208\232\190\173\209\233"]));
    JY.Thing[thingid]["\208\232\190\173\209\233"] = exp; 
    --War_PrintTrace(string.format("TrainNeedExp called 3, pid=%s,thingid=%d,exp=%d,raw_exp=%d", pid, thingid, exp, JY.Thing[thingid]["\208\232\190\173\209\233"]));
    return r;     
end

function Fucker_AdjustWuPins()
    War_PrintTrace("Fucker_AdjustWuPins Begin, CC.BanBen=%d, jyqxz_adjust_wupin=%d", 
        CC.BanBen, jyqxz_adjust_wupin);
    if jyqxz_adjust_wupin < 1 then
        return;
    end
    --YB
    if CC.BanBen == 0 then
        Fucker_AdjustWuPin(174, 9999);
        Fucker_AdjustWuPin(19, 9999);
        Fucker_AdjustWuPin(29, 9999);
        Fucker_AdjustWuPin(32, 9999);
        Fucker_AdjustWuPin(102, 9999);
        Fucker_AdjustWuPin(171, 9999);
        return;
    end 
    
    --CL
    if CC.BanBen == 1 then
        Fucker_AdjustWuPin(174, 9999);
        Fucker_AdjustWuPin(12, 9999);
        Fucker_AdjustWuPin(32, 9999);
        Fucker_AdjustWuPin(209, 9999);
        Fucker_AdjustWuPin(210, 9999);
        return;
    end

    --ZZJH
    if CC.BanBen == 2 then
        Fucker_AdjustWuPin(174, 9999);
        Fucker_AdjustWuPin(199, 5000);
        Fucker_AdjustWuPin(20, 9999);
        Fucker_AdjustWuPin(40, 9999);
        Fucker_AdjustWuPin(11, 9999);
        Fucker_AdjustWuPin(15, 9999);
        return;
    end

    --XMB
    if CC.BanBen == 3 then
        --for i = 0, JY.ThingNum do
        --    Fucker_AdjustWuPin(i, 1);
        --end
        Fucker_AdjustWuPin(174, 9999); 
        Fucker_AdjustWuPin(19, 9999); 
        Fucker_AdjustWuPin(31, 9999); 
        Fucker_AdjustWuPin(102, 9999); 
        Fucker_AdjustWuPin(171, 9999); 
        Fucker_AdjustWuPin(172, 9999); 
        Fucker_AdjustWuPin(186, 200); 
        return;
    end

    --TSJ
    if CC.BanBen == 4 then
        Fucker_AdjustWuPin(174, 9999); 
        Fucker_AdjustWuPin(12, 9999); 
        Fucker_AdjustWuPin(17, 9999); 
        Fucker_AdjustWuPin(32, 9999); 
        Fucker_AdjustWuPin(209, 9999); 
        Fucker_AdjustWuPin(210, 9999); 
        return;
    end
    
    --CL1028
    if CC.BanBen == 5 then
        Fucker_AdjustWuPin(0xae, 9999);
        Fucker_AdjustWuPin(0xd1, 9999);
        Fucker_AdjustWuPin(0xd2, 9999);
        Fucker_AdjustWuPin(0x0c, 9999);
        Fucker_AdjustWuPin(32, 9999);
        return;
    end 
    War_PrintTrace("Fucker_AdjustWuPins End");
end

function Fucker_AdjustWuPin(id, count)
    local thnum = 0
    for i = 0, CC.MyThingNum - 1 do
      if id == JY.Base["\206\239\198\183" .. i + 1] then
         JY.Base["\206\239\198\183\202\253\193\191" .. i + 1] = count;
         return;
      end
      if 0 > JY.Base["\206\239\198\183" .. i + 1] then
        thnum = i;
        break;
      end
    end
    JY.Base["\206\239\198\183" .. thnum + 1] = id;
    JY.Base["\206\239\198\183\202\253\193\191" .. thnum + 1] = count;
end

function Fucker_GetEnvData()
    local result = {};

    result.BanBen = CC.BanBen;
    result.Status = JY.Status;
    result.WugongNum = JY.WugongNum 

    return result;
end

function Fucker_GetPersonData(pid)
   local result = {};
   local p = JY.Person[pid];
   result["xlid"] = p["\208\222\193\182\206\239\198\183"];
   result["wuchang"] = p["\206\228\209\167\179\163\202\182"];
   for i = 1, 10 do
     result["wugong"..i] = p["\206\228\185\166" .. i];
   end 
   result["duiyou_count"] = CC.TeamNum; 
   for i = 1, CC.TeamNum do
        result["duiyou"..i] = JY.Base["\182\211\206\233" .. i];
        if JY.Base["\182\211\206\233" .. i] < 0 then
            result["duiyou"..i] = -1;
        end
   end
   War_PrintTrace(string.format("Fucker_GetPersonData called, pid=%d, result.xlid=%d"
       , pid, result["xlid"])); 
   return result;
end

function Fucker_UpdatePersonData(person_cheatdata)
   local p = JY.Person[person_cheatdata.pid]
   p["\208\222\193\182\206\239\198\183"] = person_cheatdata.xlid;
   p["\206\228\209\167\179\163\202\182"] = person_cheatdata.wuchang;
   for i = 1, 10 do
      p["\206\228\185\166" .. i] = person_cheatdata["wugong"..i];
      p["\206\228\185\166\181\200\188\182" .. i] = 999;
      if p["\206\228\185\166" .. i] == 0 then
          p["\206\228\185\166\181\200\188\182" .. i] = 0;
      end
   end
end


    War_PrintTrace("k_init_lua_code called")
)";


const char* k_update_lua_code = R"(
    jyqxz_trace_log = $001;
    jyqxz_baoxi_dengji = $002;
    jyqxz_baoxi_wugong = $003;
    jyqxz_baoxi_maxvalue = $004;
    jyqxz_baoxi_use_clever = 1;

    Fucker_AdjustPropsMaxValue();
)";

const char* k_update_person_data_code = R"(
    jyqxz_person_cheatdata_dict = {};

    jyqxz_person_cheatdata_dict.pid = $000;
    jyqxz_person_cheatdata_dict.xlid = $100;
    jyqxz_person_cheatdata_dict.wuchang = $101; 

    jyqxz_person_cheatdata_dict.wugong1 = $200;
    jyqxz_person_cheatdata_dict.wugong2 = $201;
    jyqxz_person_cheatdata_dict.wugong3 = $202;
    jyqxz_person_cheatdata_dict.wugong4 = $203;
    jyqxz_person_cheatdata_dict.wugong5 = $204;
    jyqxz_person_cheatdata_dict.wugong6 = $205;
    jyqxz_person_cheatdata_dict.wugong7 = $206;
    jyqxz_person_cheatdata_dict.wugong8 = $207;
    jyqxz_person_cheatdata_dict.wugong9 = $208;
    jyqxz_person_cheatdata_dict.wugong10 = $209;

    Fucker_UpdatePersonData(jyqxz_person_cheatdata_dict);

    jyqxz_person_cheatdata_dict = {};

    jyqxz_adjust_wupin = $300;
    Fucker_AdjustWuPins(); 

)";
