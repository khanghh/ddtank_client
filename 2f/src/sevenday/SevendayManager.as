package sevenday{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestInfo;   import ddt.loader.LoaderCreate;   import ddt.manager.GameSocketOut;   import ddt.manager.PlayerManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import quest.TaskManager;   import sevenday.view.SevendayMainFrame;      public class SevendayManager extends EventDispatcher   {            public static const QUEST_LIST_1:Array = [3201,3202,3203,3204,3205,3206,3207];            public static const QUEST_LIST_2:Array = [3208,3209,3210,3211,3212,3213,3214];            private static var _instance:SevendayManager;                   private var _sevendaysocket:GameSocketOut;            private var _time:Date;            private var _day:int;            private var _hour:int;            private var _autoOpenViewState:int = 2;            private var _frame:SevendayMainFrame;            public function SevendayManager($inner:inner) { super(null); }
            public static function get instance() : SevendayManager { return null; }
            public function show() : void { }
            private function showFrame() : void { }
            public function hideFrame() : void { }
            public function isNotAllAchieved(id:int = 0) : Boolean { return false; }
            private function updateTime() : void { }
            public function get isSevenday() : Boolean { return false; }
            public function get day() : int { return 0; }
            public function get hour() : int { return 0; }
            public function checkAutoShow() : void { }
            public function checkIcon() : void { }
   }}class inner{          function inner() { super(); }
}