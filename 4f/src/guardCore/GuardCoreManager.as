package guardCore{   import com.pickgliss.ui.ComponentFactory;   import ddt.CoreManager;   import ddt.manager.PlayerManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.IEventDispatcher;   import guardCore.analyzer.GuardCoreAnalyzer;   import guardCore.analyzer.GuardCoreLevelAnayzer;   import guardCore.data.GuardCoreInfo;   import guardCore.data.GuardCoreLevelInfo;      public class GuardCoreManager extends CoreManager   {            private static var _instance:GuardCoreManager;                   private var _list:Vector.<GuardCoreInfo>;            private var _listLevel:Vector.<GuardCoreLevelInfo>;            private var _minLevel:int;            public function GuardCoreManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : GuardCoreManager { return null; }
            override protected function start() : void { }
            private function onComplete() : void { }
            public function analyzer(analyzer:GuardCoreAnalyzer) : void { }
            public function analyzerLevel(analyzer:GuardCoreLevelAnayzer) : void { }
            public function getGuardCoreIsOpen(grade:int, type:int) : Boolean { return false; }
            public function getGuardCoreInfo(guardGrade:int, type:int) : GuardCoreInfo { return null; }
            public function getGuardCoreInfoBySkillGrade(skillGrade:int, type:int) : GuardCoreInfo { return null; }
            public function getGuardCoreInfoByID(id:int) : GuardCoreInfo { return null; }
            public function getGuardLevelInfo(guardGrade:int) : GuardCoreLevelInfo { return null; }
            private function checkMinLevel() : void { }
            public function get guardCoreMinLevel() : int { return 0; }
            public function getSelfGuardCoreInfo() : GuardCoreInfo { return null; }
   }}