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
      
      public function GuardCoreManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : GuardCoreManager{return null;}
      
      override protected function start() : void{}
      
      private function onComplete() : void{}
      
      public function analyzer(param1:GuardCoreAnalyzer) : void{}
      
      public function analyzerLevel(param1:GuardCoreLevelAnayzer) : void{}
      
      public function getGuardCoreIsOpen(param1:int, param2:int) : Boolean{return false;}
      
      public function getGuardCoreInfo(param1:int, param2:int) : GuardCoreInfo{return null;}
      
      public function getGuardCoreInfoBySkillGrade(param1:int, param2:int) : GuardCoreInfo{return null;}
      
      public function getGuardCoreInfoByID(param1:int) : GuardCoreInfo{return null;}
      
      public function getGuardLevelInfo(param1:int) : GuardCoreLevelInfo{return null;}
      
      private function checkMinLevel() : void{}
      
      public function get guardCoreMinLevel() : int{return 0;}
      
      public function getSelfGuardCoreInfo() : GuardCoreInfo{return null;}
   }
}
