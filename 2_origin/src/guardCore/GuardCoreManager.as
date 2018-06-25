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
      
      public function GuardCoreManager(target:IEventDispatcher = null)
      {
         super(target);
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
         var view:* = ComponentFactory.Instance.creatComponentByStylename("guardCore.GuardCoreView");
         view.show();
      }
      
      public function analyzer(analyzer:GuardCoreAnalyzer) : void
      {
         _list = analyzer.list;
         checkMinLevel();
      }
      
      public function analyzerLevel(analyzer:GuardCoreLevelAnayzer) : void
      {
         _listLevel = analyzer.list;
      }
      
      public function getGuardCoreIsOpen(grade:int, type:int) : Boolean
      {
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(_list[i].Type == type && grade >= _list[i].GainGrade)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function getGuardCoreInfo(guardGrade:int, type:int) : GuardCoreInfo
      {
         var info:* = null;
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(_list[i].Type == type && guardGrade >= _list[i].GuardGrade)
            {
               if(info == null || info.SkillGrade < _list[i].SkillGrade)
               {
                  info = _list[i];
               }
            }
            i++;
         }
         return info;
      }
      
      public function getGuardCoreInfoBySkillGrade(skillGrade:int, type:int) : GuardCoreInfo
      {
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(_list[i].Type == type && _list[i].SkillGrade == skillGrade)
            {
               return _list[i];
            }
            i++;
         }
         return null;
      }
      
      public function getGuardCoreInfoByID(id:int) : GuardCoreInfo
      {
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(_list[i].ID == id)
            {
               return _list[i];
            }
            i++;
         }
         return null;
      }
      
      public function getGuardLevelInfo(guardGrade:int) : GuardCoreLevelInfo
      {
         var i:int = 0;
         var len:int = _listLevel.length;
         for(i = 0; i < len; )
         {
            if(_listLevel[i].Grade == guardGrade)
            {
               return _listLevel[i];
            }
            i++;
         }
         return null;
      }
      
      private function checkMinLevel() : void
      {
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(_minLevel == 0 || _list[i].GainGrade < _minLevel)
            {
               _minLevel = _list[i].GainGrade;
            }
            i++;
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
