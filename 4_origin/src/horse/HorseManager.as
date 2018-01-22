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
      
      public static const CHANGE_HORSE:String = "horseChangeHorse";
      
      public static const CHANGE_HORSE_BYPICCHERISH:String = "changeHorseByPicCherish";
      
      public static const UP_HORSE_STEP_1:String = "horseUpHorseStep1";
      
      public static const UP_HORSE_STEP_2:String = "horseUpHorseStep2";
      
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
      
      public function HorseManager(param1:IEventDispatcher = null)
      {
         _curHasSkillList = new Vector.<HorseSkillExpVo>();
         _curUseSkillList = new DictionaryData();
         _curHasBattleSkillList = new Vector.<HorseSkillExpVo>();
         _curUseBattleSkillList = new DictionaryData();
         super(param1);
      }
      
      public static function get instance() : HorseManager
      {
         if(_instance == null)
         {
            _instance = new HorseManager();
         }
         return _instance;
      }
      
      public function isSkillHasEquip(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _curUseSkillList;
         for each(var _loc2_ in _curUseSkillList)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isEqualSkillHasEquip(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _curUseBattleSkillList;
         for each(var _loc2_ in _curUseBattleSkillList)
         {
            if(_loc2_ == param1)
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
      
      public function getHorseTemplateInfoByLevel(param1:int) : HorseTemplateVo
      {
         if(param1 < 0 || param1 > maxLevel)
         {
            return null;
         }
         return _horseTemplateList[param1];
      }
      
      public function getHorseSkillGetInfoById(param1:int) : HorseSkillGetVo
      {
         return _horseSkillGetIdList[param1];
      }
      
      public function getHorseSkillName(param1:int, param2:int) : String
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = _horseSkillGetIdList;
         for each(var _loc3_ in _horseSkillGetIdList)
         {
            if(_loc3_.Type == param1 && _loc3_.Level == param2)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         return _horseSkillList[_loc4_.SkillID].Name;
      }
      
      public function getHorseSkillInfoById(param1:int) : HorseSkillVo
      {
         return _horseSkillList[param1];
      }
      
      public function getLevelBySkillId(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc5_:int = 0;
         var _loc4_:* = _horseTemplateList;
         for each(var _loc3_ in _horseTemplateList)
         {
            if(_loc3_.SkillID == param1)
            {
               _loc2_ = _loc3_.Grade;
               break;
            }
         }
         return _loc2_;
      }
      
      public function horseTemplateDataSetup(param1:HorseTemplateDataAnalyzer) : void
      {
         _horseTemplateList = param1.horseTemplateList;
      }
      
      public function horseSkillGetDataSetup(param1:HorseSkillGetDataAnalyzer) : void
      {
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         _horseSkillGetIdList = param1.horseSkillGetIdList;
         var _loc5_:DictionaryData = param1.horseSkillGetList;
         var _loc2_:Array = [];
         var _loc3_:int = _horseTemplateList.length;
         _loc12_ = 0;
         while(_loc12_ < _loc3_)
         {
            if(_horseTemplateList[_loc12_].SkillID > 0)
            {
               _loc2_.push(_horseTemplateList[_loc12_].SkillID);
            }
            _loc12_++;
         }
         var _loc4_:Array = [];
         var _loc11_:int = _loc2_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc11_)
         {
            _loc6_ = _loc2_[_loc8_];
            var _loc14_:int = 0;
            var _loc13_:* = _loc5_;
            for(var _loc10_ in _loc5_)
            {
               if(_loc5_[_loc10_][0].SkillID == _loc6_)
               {
                  _loc4_.push(_loc5_[_loc10_][0].Type);
                  break;
               }
            }
            _loc8_++;
         }
         var _loc7_:int = _loc4_.length;
         _horseSkillGetList = new DictionaryData();
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _horseSkillGetList.add(_loc4_[_loc9_],_loc5_[_loc4_[_loc9_]]);
            _loc9_++;
         }
      }
      
      public function horseSkillDataSetup(param1:HorseSkillDataAnalyzer) : void
      {
         _horseSkillList = param1.horseSkillList;
      }
      
      public function horseSkillElementDataSetup(param1:HorseSkillElementDataAnalyzer) : void
      {
         _horseSkillElementList = param1.horseSkillElementList;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(260),pkgHandler);
      }
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         switch(int(_loc2_) - 1)
         {
            case 0:
               initAllData(_loc3_);
               break;
            case 1:
               changeHorse(_loc3_);
               break;
            case 2:
               upHorse(_loc3_);
               break;
            case 3:
               getSkillHandler(_loc3_);
               break;
            case 4:
               upSkillHandler(_loc3_);
               break;
            case 5:
               takeUpDownSkillHandler(_loc3_);
               break;
            case 6:
               activeHandler(_loc3_);
               break;
            case 7:
               picCherishInfo(_loc3_);
               break;
            case 8:
               initBattleHorseSkill(_loc3_);
               break;
            case 9:
               takeUpDownEqualSkill(_loc3_);
         }
      }
      
      private function takeUpDownSkillHandler(param1:PackageIn) : void
      {
         var _loc3_:int = param1.readInt();
         var _loc2_:int = param1.readInt();
         if(_loc2_ > 0)
         {
            _curUseSkillList.add(_loc2_,_loc3_);
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _curUseSkillList;
            for(var _loc4_ in _curUseSkillList)
            {
               if(_curUseSkillList[_loc4_] == _loc3_)
               {
                  _curUseSkillList.remove(_loc4_);
                  break;
               }
            }
         }
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
      
      private function upSkillHandler(param1:PackageIn) : void
      {
         var _loc6_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         var _loc2_:int = param1.readInt();
         var _loc8_:int = 0;
         var _loc7_:* = _curHasSkillList;
         for each(var _loc5_ in _curHasSkillList)
         {
            if(_loc5_.skillId == _loc6_)
            {
               _loc5_.skillId = _loc4_;
               _loc5_.exp = _loc2_;
               break;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _curUseSkillList;
         for(var _loc3_ in _curUseSkillList)
         {
            if(_curUseSkillList[_loc3_] == _loc6_)
            {
               _curUseSkillList.add(_loc3_,_loc4_);
               break;
            }
         }
         dispatchEvent(new Event("horseUpSkill"));
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
      
      private function getSkillHandler(param1:PackageIn) : void
      {
         var _loc2_:HorseSkillExpVo = new HorseSkillExpVo();
         _loc2_.skillId = param1.readInt();
         _loc2_.exp = param1.readInt();
         _curHasSkillList.push(_loc2_);
         isNeedPlayGetNewSkillCartoon = true;
         if(isUpFloatCartoonComplete)
         {
            dispatchEvent(new Event("showNewSkillView"));
         }
      }
      
      private function upHorse(param1:PackageIn) : void
      {
         isHasLevelUp = param1.readBoolean();
         _curLevel = param1.readInt();
         _curExp = param1.readInt();
         isUpFloatCartoonComplete = false;
         dispatchEvent(new Event("horseUpHorseStep1"));
      }
      
      private function changeHorse(param1:PackageIn) : void
      {
         _curUseHorse = param1.readInt();
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
         for(var _loc1_ in PlayerManager.Instance.Self.horsePicCherishDic)
         {
            PlayerManager.Instance.Self.horsePicCherishDic[_loc1_].isUsed = int(_loc1_) == _curUseHorse;
         }
         dispatchEvent(new Event("horseChangeHorse"));
      }
      
      private function initAllData(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         _curUseHorse = param1.readInt();
         _curLevel = param1.readInt();
         _curExp = param1.readInt();
         param1.readInt();
         var _loc2_:int = param1.readInt();
         _curHasSkillList = new Vector.<HorseSkillExpVo>();
         _curUseSkillList = new DictionaryData();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new HorseSkillExpVo();
            _loc4_.skillId = param1.readInt();
            _loc4_.exp = param1.readInt();
            _curHasSkillList.push(_loc4_);
            _loc3_ = param1.readInt();
            if(_loc3_ > 0)
            {
               _curUseSkillList.add(_loc3_,_loc4_.skillId);
            }
            _loc5_++;
         }
      }
      
      public function getHorseLevelByExp(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_horseTemplateList[_horseTemplateList.length - 1].Experience <= param1)
         {
            return _horseTemplateList.length - 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _horseTemplateList.length)
         {
            if(_horseTemplateList[_loc3_].Experience > param1)
            {
               _loc2_ = _loc3_ - 1;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function picCherishInfo(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = false;
         var _loc8_:* = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc7_:* = null;
         PlayerManager.Instance.Self.horsePicCherishDic.clear();
         var _loc6_:int = param1.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc2_ = param1.readInt();
            _loc5_ = param1.readInt() == 1;
            _loc8_ = param1.readDate();
            _loc3_ = param1.readInt();
            _loc4_ = 86400000 * _loc3_ + _loc8_.getTime();
            if(_loc3_ != 0 && _loc4_ < TimeManager.Instance.Now().getTime())
            {
               if(_loc5_)
               {
                  SocketManager.Instance.out.sendHorseChangeHorse(0);
               }
            }
            else
            {
               _loc7_ = {
                  "id":_loc2_,
                  "isUsed":_loc5_,
                  "beginDate":_loc8_,
                  "valid":_loc3_
               };
               PlayerManager.Instance.Self.horsePicCherishDic[_loc2_] = _loc7_;
            }
            _loc9_++;
         }
      }
      
      private function activeHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc4_:* = param1.readInt() == 1;
         var _loc6_:Date = param1.readDate();
         var _loc3_:int = param1.readInt();
         var _loc5_:Object = {
            "id":_loc2_,
            "isUsed":_loc4_,
            "beginDate":_loc6_,
            "valid":_loc3_
         };
         PlayerManager.Instance.Self.horsePicCherishDic[_loc2_] = _loc5_;
         if(updateCherishPropertyFunc != null)
         {
            updateCherishPropertyFunc();
         }
         dispatchEvent(new Event("changeHorseByPicCherish"));
      }
      
      public function horsePicCherishDataSetup(param1:HorsePicCherishAnalyzer) : void
      {
         _horsePicCherishList = param1.horsePicCherishList;
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
      
      public function getIsSit(param1:int) : Boolean
      {
         return HorseManager.MountSitList.indexOf(param1) != -1;
      }
      
      public function getIsShakeRide(param1:int) : Boolean
      {
         return HorseManager.MountStandShakeList.indexOf(param1) != -1;
      }
      
      public function getIsKeepMovingRide(param1:int) : Boolean
      {
         return HorseManager.KeepMovingMountsArr.indexOf(param1) != -1;
      }
      
      public function getIsSaddleShake(param1:int) : Boolean
      {
         return HorseManager.MountSaddleShakeList.indexOf(param1) != -1;
      }
      
      private function initBattleHorseSkill(param1:PackageIn) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         _curHasBattleSkillList = new Vector.<HorseSkillExpVo>();
         var _loc5_:int = param1.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = new HorseSkillExpVo();
            _loc3_.skillId = param1.readInt();
            _curHasBattleSkillList.push(_loc3_);
            _loc6_++;
         }
         _curUseBattleSkillList = new DictionaryData();
         var _loc2_:int = param1.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            _curUseBattleSkillList.add(_loc7_ + 1,_loc4_);
            _loc7_++;
         }
      }
      
      private function takeUpDownEqualSkill(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         _curUseBattleSkillList.add(_loc3_,_loc2_);
         dispatchEvent(new Event("horseTakeUpDownSkill"));
      }
   }
}
