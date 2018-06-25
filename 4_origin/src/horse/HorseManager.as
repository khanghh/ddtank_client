package horse
{
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horse.analyzer.HorsePicCherishAnalyzer;
   import horse.analyzer.HorseSkillDataAnalyzer;
   import horse.analyzer.HorseSkillElementDataAnalyzer;
   import horse.analyzer.HorseSkillGetDataAnalyzer;
   import horse.analyzer.HorseTemplateDataAnalyzer;
   import horse.data.HorseEvent;
   import horse.data.HorsePicCherishVo;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import horse.data.HorseSkillVo;
   import horse.data.HorseTemplateVo;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class HorseManager extends EventDispatcher
   {
      
      public static const MountSitList:Array = [6,7,8,9,118,119,130,137,140];
      
      public static const MountStandShakeList:Array = [4,5,6,7,8,9,103,137];
      
      public static const MountSaddleShakeList:Array = [9,137];
      
      public static const KeepMovingMountsArr:Array = [117];
      
      public static const UP_HORSE_SKILL:String = "upHorseSkill";
      
      public static const CHANGE_HORSE:String = "horseChangeHorse";
      
      public static const CHANGE_HORSE_BYPICCHERISH:String = "changeHorseByPicCherish";
      
      public static const UP_HORSE_STEP_1:String = "horseUpHorseStep1";
      
      public static const UP_HORSE_STEP_2:String = "horseUpHorseStep2";
      
      public static const CHANGE_SKILL:String = "changeSkill";
      
      public static const UP_SKILL:String = "horseUpSkill";
      
      public static const TAKE_UP_DOWN_SKILL:String = "horseTakeUpDownSkill";
      
      public static const PRE_NEXT_EFFECT:String = "horsePreNextEffect";
      
      public static const REFRESH_CUR_EFFECT:String = "horseRefreshCurEffect";
      
      public static const GUIDE_6_TO_7:String = "horseGuide6To7";
      
      public static const SHOWNEWSKILLVIEW:String = "showNewSkillView";
      
      public static const HORSE_OPENVIEW:String = "horseOpenView";
      
      public static const HORSE_HIDEVIEW:String = "horseHideView";
      
      private static var _instance:HorseManager;
       
      
      public var isHasLevelUp:Boolean = false;
      
      public var maxLevel:int = 89;
      
      private var _curUseHorse:int = 0;
      
      private var _curLevel:int = 0;
      
      private var _curExp:int = 0;
      
      private var _tempExp:int = 0;
      
      private var _curHasSkillList:Vector.<HorseSkillExpVo>;
      
      private var _curUseSkillList:DictionaryData;
      
      private var _curHasBattleSkillList:Vector.<HorseSkillExpVo>;
      
      private var _curUseBattleSkillList:DictionaryData;
      
      private var _horseTemplateList:Vector.<HorseTemplateVo>;
      
      private var _horseSkillGetList:DictionaryData;
      
      private var _horseSkillGetIdList:DictionaryData;
      
      private var _horseSkillGetSortArray:Array;
      
      private var _horseSkillList:DictionaryData;
      
      private var _horseSkillElementList:DictionaryData;
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      public var updateCherishPropertyFunc:Function;
      
      public var isSkipFromBagView:Boolean;
      
      public var skipHorsePicCherishId:int;
      
      public var isNeedPlayGetNewSkillCartoon:Boolean;
      
      public var isUpFloatCartoonComplete:Boolean;
      
      public function HorseManager(target:IEventDispatcher = null)
      {
         _curHasSkillList = new Vector.<HorseSkillExpVo>();
         _curUseSkillList = new DictionaryData();
         _curHasBattleSkillList = new Vector.<HorseSkillExpVo>();
         _curUseBattleSkillList = new DictionaryData();
         super(target);
      }
      
      public static function get instance() : HorseManager
      {
         if(_instance == null)
         {
            _instance = new HorseManager();
         }
         return _instance;
      }
      
      public function isSkillHasEquip(skillId:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _curUseSkillList;
         for each(var tmpId in _curUseSkillList)
         {
            if(tmpId == skillId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isEqualSkillHasEquip(skillId:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _curUseBattleSkillList;
         for each(var tmpId in _curUseBattleSkillList)
         {
            if(tmpId == skillId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get curUseSkillList() : DictionaryData
      {
         return _curUseSkillList;
      }
      
      public function get takeUpSkillPlace() : int
      {
         if(!_curUseSkillList.hasKey(1))
         {
            return 1;
         }
         if(!_curUseSkillList.hasKey(2))
         {
            return 2;
         }
         if(!_curUseSkillList.hasKey(3))
         {
            return 3;
         }
         return 0;
      }
      
      public function get takeUpEqualSkillPlace() : int
      {
         if(!_curUseBattleSkillList[1] > 0)
         {
            return 1;
         }
         if(!_curUseBattleSkillList[2] > 0)
         {
            return 2;
         }
         if(!_curUseBattleSkillList[3] > 0)
         {
            return 3;
         }
         return 0;
      }
      
      public function get horseSkillGetArray() : Array
      {
         return _horseSkillGetList.list;
      }
      
      public function get curHasSkillList() : Vector.<HorseSkillExpVo>
      {
         return _curHasSkillList;
      }
      
      public function get curExp() : int
      {
         return _curExp;
      }
      
      public function get curHasBattleSkillList() : Vector.<HorseSkillExpVo>
      {
         return _curHasBattleSkillList;
      }
      
      public function get curUseBattleSkillList() : DictionaryData
      {
         return _curUseBattleSkillList;
      }
      
      public function get tempExp() : int
      {
         return _tempExp;
      }
      
      public function get curLevel() : int
      {
         return _curLevel;
      }
      
      public function get curUseHorse() : int
      {
         return _curUseHorse;
      }
      
      public function get curHorseTemplateInfo() : HorseTemplateVo
      {
         return _horseTemplateList[_curLevel];
      }
      
      public function get nextHorseTemplateInfo() : HorseTemplateVo
      {
         if(_curLevel >= maxLevel)
         {
            return null;
         }
         return _horseTemplateList[_curLevel + 1];
      }
      
      public function getHorseTemplateInfoByLevel(level:int) : HorseTemplateVo
      {
         if(level < 0 || level > maxLevel)
         {
            return null;
         }
         return _horseTemplateList[level];
      }
      
      public function getHorseSkillGetInfoById(skillId:int) : HorseSkillGetVo
      {
         return _horseSkillGetIdList[skillId];
      }
      
      public function getHorseSkillName(type:int, level:int) : String
      {
         var skillInfo:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = _horseSkillGetIdList;
         for each(var info in _horseSkillGetIdList)
         {
            if(info.Type == type && info.Level == level)
            {
               skillInfo = info;
               break;
            }
         }
         return _horseSkillList[skillInfo.SkillID].Name;
      }
      
      public function getHorseSkillInfoById(skillId:int) : HorseSkillVo
      {
         return _horseSkillList[skillId];
      }
      
      public function getLevelBySkillId(skillId:int) : int
      {
         var level:int = -1;
         var _loc5_:int = 0;
         var _loc4_:* = _horseTemplateList;
         for each(var tmp in _horseTemplateList)
         {
            if(tmp.SkillID == skillId)
            {
               level = tmp.Grade;
               break;
            }
         }
         return level;
      }
      
      public function horseTemplateDataSetup(data:HorseTemplateDataAnalyzer) : void
      {
         _horseTemplateList = data.horseTemplateList;
      }
      
      public function horseSkillGetDataSetup(data:HorseSkillGetDataAnalyzer) : void
      {
         var i:int = 0;
         var j:int = 0;
         var skillId:int = 0;
         var k:int = 0;
         _horseSkillGetIdList = data.horseSkillGetIdList;
         var tmpDataList:DictionaryData = data.horseSkillGetList;
         var skillIdList:Array = [];
         var tmplen:int = _horseTemplateList.length;
         for(i = 0; i < tmplen; )
         {
            if(_horseTemplateList[i].SkillID > 0)
            {
               skillIdList.push(_horseTemplateList[i].SkillID);
            }
            i++;
         }
         var typeIdList:Array = [];
         var tmplen2:int = skillIdList.length;
         for(j = 0; j < tmplen2; )
         {
            skillId = skillIdList[j];
            var _loc14_:int = 0;
            var _loc13_:* = tmpDataList;
            for(var tmpType in tmpDataList)
            {
               if(tmpDataList[tmpType][0].SkillID == skillId)
               {
                  typeIdList.push(tmpDataList[tmpType][0].Type);
                  break;
               }
            }
            j++;
         }
         var tmplen3:int = typeIdList.length;
         _horseSkillGetList = new DictionaryData();
         for(k = 0; k < tmplen3; )
         {
            _horseSkillGetList.add(typeIdList[k],tmpDataList[typeIdList[k]]);
            k++;
         }
      }
      
      public function horseSkillDataSetup(data:HorseSkillDataAnalyzer) : void
      {
         _horseSkillList = data.horseSkillList;
      }
      
      public function horseSkillElementDataSetup(data:HorseSkillElementDataAnalyzer) : void
      {
         _horseSkillElementList = data.horseSkillElementList;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(260),pkgHandler);
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 1)
         {
            case 0:
               initAllData(pkg);
               break;
            case 1:
               changeHorse(pkg);
               break;
            case 2:
               upHorse(pkg);
               break;
            case 3:
               getSkillHandler(pkg);
               break;
            case 4:
               upSkillHandler(pkg);
               break;
            case 5:
               takeUpDownSkillHandler(pkg);
               break;
            case 6:
               activeHandler(pkg);
               break;
            case 7:
               picCherishInfo(pkg);
               break;
            case 8:
               initBattleHorseSkill(pkg);
               break;
            case 9:
               takeUpDownEqualSkill(pkg);
         }
      }
      
      private function takeUpDownSkillHandler(pkg:PackageIn) : void
      {
         var skillId:int = pkg.readInt();
         var status:int = pkg.readInt();
         if(status > 0)
         {
            _curUseSkillList.add(status,skillId);
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _curUseSkillList;
            for(var key in _curUseSkillList)
            {
               if(_curUseSkillList[key] == skillId)
               {
                  _curUseSkillList.remove(key);
                  break;
               }
            }
         }
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
      
      private function upSkillHandler(pkg:PackageIn) : void
      {
         var oldSkillId:int = pkg.readInt();
         var newSkillId:int = pkg.readInt();
         var exp:int = pkg.readInt();
         var _loc8_:int = 0;
         var _loc7_:* = _curHasSkillList;
         for each(var tmp in _curHasSkillList)
         {
            if(tmp.skillId == oldSkillId)
            {
               tmp.skillId = newSkillId;
               tmp.exp = exp;
               break;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _curUseSkillList;
         for(var tmp2 in _curUseSkillList)
         {
            if(_curUseSkillList[tmp2] == oldSkillId)
            {
               _curUseSkillList.add(tmp2,newSkillId);
               break;
            }
         }
         dispatchEvent(new Event("horseUpSkill"));
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
      
      private function getSkillHandler(pkg:PackageIn) : void
      {
         var tmp:HorseSkillExpVo = new HorseSkillExpVo();
         tmp.skillId = pkg.readInt();
         tmp.exp = pkg.readInt();
         _curHasSkillList.push(tmp);
         isNeedPlayGetNewSkillCartoon = true;
         dispatchEvent(new Event("showNewSkillView"));
      }
      
      private function upHorse(pkg:PackageIn) : void
      {
         isHasLevelUp = pkg.readBoolean();
         _curLevel = pkg.readInt();
         _curExp = pkg.readInt();
         isUpFloatCartoonComplete = false;
         dispatchEvent(new Event("horseUpHorseStep1"));
      }
      
      private function changeHorse(pkg:PackageIn) : void
      {
         _curUseHorse = pkg.readInt();
         updateHorse();
         if(_curUseHorse > 100)
         {
            dispatchEvent(new Event("changeHorseByPicCherish"));
         }
         PlayerManager.Instance.Self.MountsType = _curUseHorse;
      }
      
      private function updateHorse() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = PlayerManager.Instance.Self.horsePicCherishDic;
         for(var key in PlayerManager.Instance.Self.horsePicCherishDic)
         {
            PlayerManager.Instance.Self.horsePicCherishDic[key].isUsed = int(key) == _curUseHorse;
         }
         dispatchEvent(new HorseEvent("horseChangeHorse"));
      }
      
      private function initAllData(pkg:PackageIn) : void
      {
         var i:int = 0;
         var tmp:* = null;
         var status:int = 0;
         _curUseHorse = pkg.readInt();
         _curLevel = pkg.readInt();
         _curExp = pkg.readInt();
         pkg.readInt();
         var count:int = pkg.readInt();
         _curHasSkillList = new Vector.<HorseSkillExpVo>();
         _curUseSkillList = new DictionaryData();
         for(i = 0; i < count; )
         {
            tmp = new HorseSkillExpVo();
            tmp.skillId = pkg.readInt();
            tmp.exp = pkg.readInt();
            _curHasSkillList.push(tmp);
            status = pkg.readInt();
            if(status > 0)
            {
               _curUseSkillList.add(status,tmp.skillId);
            }
            i++;
         }
      }
      
      public function getHorseLevelByExp(value:int) : int
      {
         var i:int = 0;
         var level:int = 0;
         if(_horseTemplateList[_horseTemplateList.length - 1].Experience <= value)
         {
            return _horseTemplateList.length - 1;
         }
         i = 0;
         while(i < _horseTemplateList.length)
         {
            if(_horseTemplateList[i].Experience > value)
            {
               level = i - 1;
               break;
            }
            i++;
         }
         return level;
      }
      
      private function picCherishInfo(pkg:PackageIn) : void
      {
         var i:int = 0;
         var id:int = 0;
         var isUsed:* = false;
         var beginDate:* = null;
         var valid:int = 0;
         var time:Number = NaN;
         var obj:* = null;
         PlayerManager.Instance.Self.horsePicCherishDic.clear();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            isUsed = pkg.readInt() == 1;
            beginDate = pkg.readDate();
            valid = pkg.readInt();
            time = 86400000 * valid + beginDate.getTime();
            if(valid != 0 && time < TimeManager.Instance.Now().getTime())
            {
               if(isUsed)
               {
                  SocketManager.Instance.out.sendHorseChangeHorse(0);
               }
            }
            else
            {
               obj = {
                  "id":id,
                  "isUsed":isUsed,
                  "beginDate":beginDate,
                  "valid":valid
               };
               PlayerManager.Instance.Self.horsePicCherishDic[id] = obj;
            }
            i++;
         }
      }
      
      private function activeHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var isUsed:* = pkg.readInt() == 1;
         var beginDate:Date = pkg.readDate();
         var valid:int = pkg.readInt();
         var obj:Object = {
            "id":id,
            "isUsed":isUsed,
            "beginDate":beginDate,
            "valid":valid
         };
         PlayerManager.Instance.Self.horsePicCherishDic[id] = obj;
         if(updateCherishPropertyFunc != null)
         {
            updateCherishPropertyFunc();
         }
         dispatchEvent(new Event("changeHorseByPicCherish"));
      }
      
      public function horsePicCherishDataSetup(data:HorsePicCherishAnalyzer) : void
      {
         _horsePicCherishList = data.horsePicCherishList;
      }
      
      public function getHorsePicCherishData() : Vector.<HorsePicCherishVo>
      {
         return _horsePicCherishList;
      }
      
      public function show() : void
      {
         if(PlayerManager.Instance.Self.Grade < 12)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.notOpen",12));
            return;
         }
         if(!TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(568)))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.notOpen2"));
            return;
         }
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createHorseTemplateDataLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createHorseSkillGetDataLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createHorsePicCherishDataLoader());
         AssetModuleLoader.addModelLoader("horse",6);
         AssetModuleLoader.addModelLoader("horseAmulet",6);
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.startCodeLoader(dispatchShow);
      }
      
      private function dispatchShow() : void
      {
         dispatchEvent(new Event("horseOpenView"));
      }
      
      public function closeFrame() : void
      {
         dispatchEvent(new Event("horseHideView"));
      }
      
      public function get horseSkillGetIdList() : DictionaryData
      {
         return _horseSkillGetIdList;
      }
      
      public function get horseTemplateList() : Vector.<HorseTemplateVo>
      {
         return _horseTemplateList;
      }
      
      public function getIsSit(type:int) : Boolean
      {
         return HorseManager.MountSitList.indexOf(type) != -1;
      }
      
      public function getIsShakeRide(type:int) : Boolean
      {
         return HorseManager.MountStandShakeList.indexOf(type) != -1;
      }
      
      public function getIsKeepMovingRide(type:int) : Boolean
      {
         return HorseManager.KeepMovingMountsArr.indexOf(type) != -1;
      }
      
      public function getIsSaddleShake(type:int) : Boolean
      {
         return HorseManager.MountSaddleShakeList.indexOf(type) != -1;
      }
      
      private function initBattleHorseSkill(pkg:PackageIn) : void
      {
         var j:int = 0;
         var tmp:* = null;
         var i:int = 0;
         var skillId:int = 0;
         _curHasBattleSkillList = new Vector.<HorseSkillExpVo>();
         var len:int = pkg.readInt();
         for(j = 0; j < len; )
         {
            tmp = new HorseSkillExpVo();
            tmp.skillId = pkg.readInt();
            _curHasBattleSkillList.push(tmp);
            j++;
         }
         _curUseBattleSkillList = new DictionaryData();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            skillId = pkg.readInt();
            _curUseBattleSkillList.add(i + 1,skillId);
            i++;
         }
      }
      
      private function takeUpDownEqualSkill(pkg:PackageIn) : void
      {
         var skillId:int = pkg.readInt();
         var place:int = pkg.readInt();
         _curUseBattleSkillList.add(place,skillId);
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
   }
}
