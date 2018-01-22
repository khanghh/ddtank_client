package totem
{
   import ddt.data.Experience;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   import totem.data.TotemAddInfo;
   import totem.data.TotemDataAnalyz;
   import totem.data.TotemDataVo;
   
   public class TotemManager extends EventDispatcher
   {
      
      public static const INFO_VIEW:String = "infoview";
      
      public static const TOTEM_VIEW:String = "totemview";
      
      public static const SET_VISIBLE:String = "setvisible";
      
      private static var _instance:TotemManager;
       
      
      public var isBindInNoPrompt:Boolean;
      
      public var isDonotPromptActPro:Boolean = true;
      
      public var isSelectedActPro:Boolean;
      
      private var _dataList:Object;
      
      private var _dataList2:Object;
      
      private var cevent:CEvent;
      
      public function TotemManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : TotemManager
      {
         if(_instance == null)
         {
            _instance = new TotemManager();
         }
         return _instance;
      }
      
      public function showView(param1:String, param2:Object) : void
      {
         param2.type = "openview";
         cevent = new CEvent(param1,param2);
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createHonorUpTemplateLoader],loadUIModule);
      }
      
      private function loadUIModule() : void
      {
         AssetModuleLoader.addModelLoader("totem",6);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         dispatchEvent(cevent);
      }
      
      public function setVisible(param1:String, param2:Boolean) : void
      {
         dispatchEvent(new CEvent(param1,{
            "type":"setvisible",
            "visible":param2
         }));
      }
      
      public function closeView(param1:String) : void
      {
         dispatchEvent(new CEvent(param1,{"type":"closeView"}));
      }
      
      public function setup(param1:TotemDataAnalyz) : void
      {
         _dataList = param1.dataList;
         _dataList2 = param1.dataList2;
      }
      
      public function getCurInfoByLevel(param1:int) : TotemDataVo
      {
         return _dataList2[param1];
      }
      
      public function getCurInfoById(param1:int) : TotemDataVo
      {
         if(param1 == 0)
         {
            return new TotemDataVo();
         }
         return _dataList[param1];
      }
      
      public function getNextInfoByLevel(param1:int) : TotemDataVo
      {
         return _dataList2[param1 + 1];
      }
      
      public function getNextInfoById(param1:int) : TotemDataVo
      {
         var _loc2_:int = 0;
         if(param1 == 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = _dataList[param1].Point;
         }
         return _dataList2[_loc2_ + 1];
      }
      
      public function getAddInfo(param1:int, param2:int = 1) : TotemAddInfo
      {
         var _loc4_:TotemAddInfo = new TotemAddInfo();
         var _loc6_:int = 0;
         var _loc5_:* = _dataList;
         for each(var _loc3_ in _dataList)
         {
            if(_loc3_.Point <= param1 && _loc3_.Point >= param2)
            {
               _loc4_.Agility = _loc4_.Agility + _loc3_.AddAgility;
               _loc4_.Attack = _loc4_.Attack + _loc3_.AddAttack;
               _loc4_.Blood = _loc4_.Blood + _loc3_.AddBlood;
               _loc4_.Damage = _loc4_.Damage + _loc3_.AddDamage;
               _loc4_.Defence = _loc4_.Defence + _loc3_.AddDefence;
               _loc4_.Guard = _loc4_.Guard + _loc3_.AddGuard;
               _loc4_.Luck = _loc4_.Luck + _loc3_.AddLuck;
            }
         }
         return _loc4_;
      }
      
      public function getTotemPointLevel(param1:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         return _dataList[param1].Point;
      }
      
      public function get usableGP() : int
      {
         return PlayerManager.Instance.Self.GP - Experience.expericence[PlayerManager.Instance.Self.Grade - 1];
      }
      
      public function getCurrentLv(param1:int) : int
      {
         return int(param1 / 7);
      }
      
      public function updatePropertyAddtion(param1:int, param2:DictionaryData) : void
      {
         if(!param2["Attack"])
         {
            return;
         }
         var _loc3_:TotemAddInfo = getAddInfo(getCurInfoById(param1).Point);
         param2["Attack"]["Totem"] = _loc3_.Attack;
         param2["Defence"]["Totem"] = _loc3_.Defence;
         param2["Agility"]["Totem"] = _loc3_.Agility;
         param2["Luck"]["Totem"] = _loc3_.Luck;
         param2["HP"]["Totem"] = _loc3_.Blood;
         param2["Damage"]["Totem"] = _loc3_.Damage;
         param2["Armor"]["Totem"] = _loc3_.Guard;
      }
      
      public function getSamePageLocationList(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _dataList;
         for each(var _loc4_ in _dataList)
         {
            if(_loc4_.Page == param1 && _loc4_.Location == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc3_.sortOn("Layers",16);
         return _loc3_;
      }
   }
}
