package guardCore
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import guardCore.analyzer.GuardCoreAnalyzer;
   import guardCore.analyzer.GuardCoreLevelAnayzer;
   import guardCore.data.GuardCoreInfo;
   import guardCore.data.GuardCoreLevelInfo;
   
   public class GuardCoreManager extends CoreManager
   {
      
      private static var _instance:GuardCoreManager;
       
      
      private var _list:Vector.<GuardCoreInfo>;
      
      private var _listLevel:Vector.<GuardCoreLevelInfo>;
      
      private var _minLevel:int;
      
      public function GuardCoreManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : GuardCoreManager
      {
         if(!_instance)
         {
            _instance = new GuardCoreManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["guardCore"],onComplete);
      }
      
      private function onComplete() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatComponentByStylename("guardCore.GuardCoreView");
         _loc1_.show();
      }
      
      public function analyzer(param1:GuardCoreAnalyzer) : void
      {
         _list = param1.list;
         checkMinLevel();
      }
      
      public function analyzerLevel(param1:GuardCoreLevelAnayzer) : void
      {
         _listLevel = param1.list;
      }
      
      public function getGuardCoreIsOpen(param1:int, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = _list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_list[_loc4_].Type == param2 && param1 >= _list[_loc4_].GainGrade)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function getGuardCoreInfo(param1:int, param2:int) : GuardCoreInfo
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = _list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_list[_loc4_].Type == param2 && param1 >= _list[_loc4_].GuardGrade)
            {
               if(_loc5_ == null || _loc5_.SkillGrade < _list[_loc4_].SkillGrade)
               {
                  _loc5_ = _list[_loc4_];
               }
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function getGuardCoreInfoBySkillGrade(param1:int, param2:int) : GuardCoreInfo
      {
         var _loc4_:int = 0;
         var _loc3_:int = _list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_list[_loc4_].Type == param2 && _list[_loc4_].SkillGrade == param1)
            {
               return _list[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getGuardCoreInfoByID(param1:int) : GuardCoreInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = _list.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_list[_loc3_].ID == param1)
            {
               return _list[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getGuardLevelInfo(param1:int) : GuardCoreLevelInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = _listLevel.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_listLevel[_loc3_].Grade == param1)
            {
               return _listLevel[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function checkMinLevel() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _list.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_minLevel == 0 || _list[_loc2_].GainGrade < _minLevel)
            {
               _minLevel = _list[_loc2_].GainGrade;
            }
            _loc2_++;
         }
      }
      
      public function get guardCoreMinLevel() : int
      {
         return _minLevel;
      }
      
      public function getSelfGuardCoreInfo() : GuardCoreInfo
      {
         return getGuardCoreInfoByID(PlayerManager.Instance.Self.guardCoreID);
      }
   }
}
