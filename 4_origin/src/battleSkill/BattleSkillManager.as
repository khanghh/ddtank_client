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
      
      public function BattleSkillManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function loadTempleResource(callBack:Function) : void
      {
         callBack = callBack;
         if(_skillTemplateList != null && _skillUpdateTempList != null)
         {
            callBack();
            return;
         }
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
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(132,8),battleSkillInfo_Handler);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,6),updateBattleSkill_Handler);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,7),bringBattleSkill_Handler);
      }
      
      private function battleSkillInfo_Handler(evt:PkgEvent) : void
      {
         var skillId:int = 0;
         var skillPlace:int = 0;
         var i:int = 0;
         clearSkillCacheData();
         var pkg:PackageIn = evt.pkg;
         var skillNum:int = pkg.readInt();
         for(i = 0; i < skillNum; )
         {
            skillId = pkg.readInt();
            skillPlace = pkg.readInt();
            _activatedSkillList.push(skillId);
            if(skillPlace > 0)
            {
               _bringSkillList[skillPlace] = skillId;
            }
            i++;
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.BATTLESKILL_INFO));
      }
      
      private function updateBattleSkill_Handler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var skillId:int = pkg.readInt();
         var index:int = _activatedSkillList.indexOf(skillId);
         if(index != -1)
         {
            _activatedSkillList.splice(index,1);
         }
         _activatedSkillList.push(skillId);
         var _loc7_:int = 0;
         var _loc6_:* = _bringSkillList;
         for(var p in _bringSkillList)
         {
            if(_bringSkillList[p] == curUpSkillId)
            {
               _bringSkillList[p] = skillId;
               break;
            }
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.UPDATE_SKILL,skillId));
      }
      
      private function bringBattleSkill_Handler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var skillArr:Array = [];
         var skillId:int = pkg.readInt();
         var place:int = pkg.readInt();
         skillArr.push(skillId);
         skillArr.push(place);
         if(place == 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _bringSkillList;
            for(var p in _bringSkillList)
            {
               if(_bringSkillList[p] == skillId)
               {
                  _bringSkillList[p] = 0;
                  break;
               }
            }
         }
         else
         {
            _bringSkillList[place] = skillId;
         }
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.BRIGHT_SKILL,skillArr));
      }
      
      public function isEquipFull(skillId:int) : int
      {
         var starIndex:int = !!isInitiaveSkill(skillId)?1:4;
         var endIndex:int = starIndex + 2;
         var newPlace:* = 0;
         starIndex;
         while(starIndex <= endIndex)
         {
            if(_bringSkillList[starIndex] <= 0)
            {
               newPlace = starIndex;
               break;
            }
            starIndex++;
         }
         return newPlace;
      }
      
      public function isSkillHasEquip(skillId:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _bringSkillList;
         for(var place in _bringSkillList)
         {
            if(_bringSkillList[place] == skillId)
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
         var i:int = 0;
         var dic:DictionaryData = new DictionaryData();
         if(_bringSkillList)
         {
            for(i = 1; i <= 3; )
            {
               dic[i] = _bringSkillList[i];
               i++;
            }
         }
         return dic;
      }
      
      public function getActivatedSkillArr() : Array
      {
         return _activatedSkillList;
      }
      
      public function getBattleSKillInfoBySkillID(skillId:int) : BattleSkillSkillInfo
      {
         var allSkill:Array = _initiativeSkillList.concat(_passiveSkillList);
         var _loc5_:int = 0;
         var _loc4_:* = allSkill;
         for each(var info in allSkill)
         {
            if(info.SkillID == skillId)
            {
               return info;
            }
         }
         return null;
      }
      
      public function isActivateBySkillID(skillId:int) : Boolean
      {
         return _activatedSkillList.indexOf(skillId) != -1;
      }
      
      public function getActivateSkillInfoByType(type:int) : BattleSkillSkillInfo
      {
         var info:* = null;
         var i:int = 0;
         for(i = 0; i < _activatedSkillList.length; )
         {
            info = getBattleSKillInfoBySkillID(_activatedSkillList[i]);
            if(info.Type == type)
            {
               return info;
            }
            i++;
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
      
      public function loadSkillTemplateList(anlyzer:BattleSkillSkillTemplateAnalyzer) : void
      {
         _skillTemplateList = anlyzer.list;
         skillSort();
      }
      
      public function loadSkillUpdateTemplateList(anlyzer:BattleSKillUpdateTemplateAnalyzer) : void
      {
         _skillUpdateTempList = anlyzer.list;
      }
      
      public function getUpMaterialArr(skillId:int) : BattleSkillUpdateInfo
      {
         var info:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _skillUpdateTempList;
         for each(var upInfo in _skillUpdateTempList)
         {
            if(upInfo.SkillID == skillId)
            {
               info = upInfo;
               break;
            }
         }
         return info;
      }
      
      public function getNextlevelSkillInfo(skillId:int) : BattleSkillSkillInfo
      {
         var tempInfo:* = null;
         var skillInfo:BattleSkillSkillInfo = getBattleSKillInfoBySkillID(skillId);
         var _loc6_:int = 0;
         var _loc5_:* = _skillTemplateList;
         for each(var info in _skillTemplateList)
         {
            if(skillInfo.NextID == info.SkillID)
            {
               tempInfo = info;
            }
         }
         return tempInfo;
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
         var sortArr:Array = ServerConfigManager.instance.getBattleSkillDefaultActivate();
         var _loc4_:int = 0;
         var _loc3_:* = _skillTemplateList;
         for each(var info in _skillTemplateList)
         {
            if(isInitiaveSkill(info.SkillID))
            {
               if(sortArr.indexOf(info.SkillID.toString()) == -1)
               {
                  _initiativeSkillList.push(info);
               }
               else
               {
                  _initiativeSkillList.unshift(info);
               }
            }
            else if(isPassivitySkill(info.SkillID))
            {
               _passiveSkillList.push(info);
            }
         }
      }
      
      private function clearSkillCacheData() : void
      {
         var i:int = 0;
         _activatedSkillList = [];
         _bringSkillList = new Dictionary();
         for(i = 1; i <= 6; )
         {
            _bringSkillList[i] = 0;
            i++;
         }
      }
      
      private function isInitiaveSkill(skillId:int) : Boolean
      {
         var horseSkillInfo:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(skillId);
         return horseSkillInfo && horseSkillInfo.Probability == -1;
      }
      
      private function isPassivitySkill(skillId:int) : Boolean
      {
         var horseSkillInfo:HorseSkillVo = HorseManager.instance.getHorseSkillInfoById(skillId);
         return horseSkillInfo && horseSkillInfo.Probability == 10000;
      }
      
      public function sendUpSkill(skillId:int) : void
      {
         curUpSkillId = skillId;
         GameInSocketOut.sendUpdateBattleSkill(skillId);
      }
   }
}
