package battleSkill
{
   import battleSkill.analyzer.BattleSKillUpdateTemplateAnalyzer;
   import battleSkill.analyzer.BattleSkillSkillTemplateAnalyzer;
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import battleSkill.info.BattleSkillUpdateInfo;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class BattleSkillManager extends CoreManager
   {
      
      private static var _manager:BattleSkillManager;
       
      
      private var _skillTemplateList:Vector.<BattleSkillSkillInfo>;
      
      private var _skillUpdateTempList:Vector.<BattleSkillUpdateInfo>;
      
      private var _initiativeSkillList:Array = null;
      
      private var _passiveSkillList:Array = null;
      
      private var _activatedSkillList:Array;
      
      private var _bringSkillList:Dictionary;
      
      public var curUpSkillId:int;
      
      public function BattleSkillManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : BattleSkillManager
      {
         if(_manager == null)
         {
            _manager = new BattleSkillManager();
         }
         return _manager;
      }
      
      override protected function start() : void
      {
         loadresource();
      }
      
      private function loadresource() : void
      {
         new HelperUIModuleLoad().loadUIModule(["battleSkill"],function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
               loadTempleResource(function():*
               {
                  var /*UnknownSlot*/:* = function():void
                  {
                     dispatchEvent(new BattleSkillEvent(BattleSkillEvent.OPEN_SKILL_VIEW,null));
                  };
                  return function():void
                  {
                     dispatchEvent(new BattleSkillEvent(BattleSkillEvent.OPEN_SKILL_VIEW,null));
                  };
               }());
            };
            return function():void
            {
               loadTempleResource(function():*
               {
                  var /*UnknownSlot*/:* = function():void
                  {
                     dispatchEvent(new BattleSkillEvent(BattleSkillEvent.OPEN_SKILL_VIEW,null));
                  };
                  return function():void
                  {
                     dispatchEvent(new BattleSkillEvent(BattleSkillEvent.OPEN_SKILL_VIEW,null));
                  };
               }());
            };
         }());
      }
      
      public function setup() : void
      {
         _initiativeSkillList = [];
         _passiveSkillList = [];
         clearSkillCacheData();
         initEvent();
      }
      
      public function loadTempleResource(param1:Function) : void
      {
         callBack = param1;
         if(_skillTemplateList != null && _skillUpdateTempList != null)
         {
            return;
            §§push(callBack());
         }
         else
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createBattleSkillUpdateTemplate],function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  skillSort();
               };
               return function():void
               {
                  skillSort();
               };
            }());
            return;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(132,8),battleSkillInfo_Handler);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,6),updateBattleSkill_Handler);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,7),bringBattleSkill_Handler);
      }
      
      private function battleSkillInfo_Handler(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         clearSkillCacheData();
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _activatedSkillList.push(_loc5_);
            if(_loc3_ > 0)
            {
               _bringSkillList[_loc3_] = _loc5_;
            }
            _loc6_++;
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.BATTLESKILL_INFO));
      }
      
      private function updateBattleSkill_Handler(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         var _loc2_:int = _activatedSkillList.indexOf(_loc5_);
         if(_loc2_ != -1)
         {
            _activatedSkillList.splice(_loc2_,1);
         }
         _activatedSkillList.push(_loc5_);
         var _loc7_:int = 0;
         var _loc6_:* = _bringSkillList;
         for(var _loc3_ in _bringSkillList)
         {
            if(_bringSkillList[_loc3_] == curUpSkillId)
            {
               _bringSkillList[_loc3_] = _loc5_;
               break;
            }
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.UPDATE_SKILL,_loc5_));
      }
      
      private function bringBattleSkill_Handler(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Array = [];
         var _loc5_:int = _loc4_.readInt();
         var _loc6_:int = _loc4_.readInt();
         _loc2_.push(_loc5_);
         _loc2_.push(_loc6_);
         if(_loc6_ == 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _bringSkillList;
            for(var _loc3_ in _bringSkillList)
            {
               if(_bringSkillList[_loc3_] == _loc5_)
               {
                  _bringSkillList[_loc3_] = 0;
                  break;
               }
            }
         }
         else
         {
            _bringSkillList[_loc6_] = _loc5_;
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.BRIGHT_SKILL,_loc2_));
      }
      
      public function isEquipFull(param1:int) : int
      {
         var _loc2_:int = !!isInitiaveSkill(param1)?1:4;
         var _loc4_:int = _loc2_ + 2;
         var _loc3_:* = 0;
         _loc2_;
         while(_loc2_ <= _loc4_)
         {
            if(_bringSkillList[_loc2_] <= 0)
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function isSkillHasEquip(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _bringSkillList;
         for(var _loc2_ in _bringSkillList)
         {
            if(_bringSkillList[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getBringSkillList() : Dictionary
      {
         return _bringSkillList;
      }
      
      public function get curUseSkillList() : DictionaryData
      {
         var _loc2_:int = 0;
         var _loc1_:DictionaryData = new DictionaryData();
         if(_bringSkillList)
         {
            _loc2_ = 1;
            while(_loc2_ <= 3)
            {
               _loc1_[_loc2_] = _bringSkillList[_loc2_];
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function getActivatedSkillArr() : Array
      {
         return _activatedSkillList;
      }
      
      public function getBattleSKillInfoBySkillID(param1:int) : BattleSkillSkillInfo
      {
         var _loc2_:Array = _initiativeSkillList.concat(_passiveSkillList);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.SkillID == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function isActivateBySkillID(param1:int) : Boolean
      {
         return _activatedSkillList.indexOf(param1) != -1;
      }
      
      public function getActivateSkillInfoByType(param1:int) : BattleSkillSkillInfo
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _activatedSkillList.length)
         {
            _loc3_ = getBattleSKillInfoBySkillID(_activatedSkillList[_loc2_]);
            if(_loc3_.Type == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getInitiativeSkillList() : Array
      {
         if(_initiativeSkillList == null || _initiativeSkillList.length <= 0)
         {
            skillSort();
         }
         return _initiativeSkillList;
      }
      
      public function getPassiveSkillList() : Array
      {
         if(_passiveSkillList == null || _passiveSkillList.length <= 0)
         {
            skillSort();
         }
         return _passiveSkillList;
      }
      
      public function loadSkillTemplateList(param1:BattleSkillSkillTemplateAnalyzer) : void
      {
         _skillTemplateList = param1.list;
         skillSort();
      }
      
      public function loadSkillUpdateTemplateList(param1:BattleSKillUpdateTemplateAnalyzer) : void
      {
         _skillUpdateTempList = param1.list;
      }
      
      public function getUpMaterialArr(param1:int) : BattleSkillUpdateInfo
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _skillUpdateTempList;
         for each(var _loc2_ in _skillUpdateTempList)
         {
            if(_loc2_.SkillID == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getNextlevelSkillInfo(param1:int) : BattleSkillSkillInfo
      {
         var _loc2_:* = null;
         var _loc4_:BattleSkillSkillInfo = getBattleSKillInfoBySkillID(param1);
         var _loc6_:int = 0;
         var _loc5_:* = _skillTemplateList;
         for each(var _loc3_ in _skillTemplateList)
         {
            if(_loc4_.NextID == _loc3_.SkillID)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function skillSort() : void
      {
         if(_skillTemplateList == null)
         {
            return;
         }
         if(_initiativeSkillList && _initiativeSkillList.length > 0)
         {
            _initiativeSkillList = [];
         }
         if(_passiveSkillList && _passiveSkillList.length > 0)
         {
            _passiveSkillList = [];
         }
         var _loc1_:Array = ServerConfigManager.instance.getBattleSkillDefaultActivate();
         var _loc4_:int = 0;
         var _loc3_:* = _skillTemplateList;
         for each(var _loc2_ in _skillTemplateList)
         {
            if(isInitiaveSkill(_loc2_.SkillID))
            {
               if(_loc1_.indexOf(_loc2_.SkillID.toString()) == -1)
               {
                  _initiativeSkillList.push(_loc2_);
               }
               else
               {
                  _initiativeSkillList.unshift(_loc2_);
               }
            }
            else if(isPassivitySkill(_loc2_.SkillID))
            {
               _passiveSkillList.push(_loc2_);
            }
         }
      }
      
      private function clearSkillCacheData() : void
      {
         var _loc1_:int = 0;
         _activatedSkillList = [];
         _bringSkillList = new Dictionary();
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            _bringSkillList[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      private function isInitiaveSkill(param1:int) : Boolean
      {
         var _loc2_:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(param1);
         return _loc2_ && _loc2_.Probability == -1;
      }
      
      private function isPassivitySkill(param1:int) : Boolean
      {
         var _loc2_:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(param1);
         return _loc2_ && _loc2_.Probability == 10000;
      }
      
      public function sendUpSkill(param1:int) : void
      {
         curUpSkillId = param1;
         GameInSocketOut.sendUpdateBattleSkill(param1);
      }
   }
}
