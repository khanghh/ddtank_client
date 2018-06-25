package quest{   import ddt.CoreManager;   import flash.events.Event;      public class QuestBubbleManager extends CoreManager   {            public static const QUESTBUBBLE_SHOW:String = "QuestBubbleShow";            public static const QUESTBUBBLE_HIDE:String = "QuestBubbleHide";            private static var _instance:QuestBubbleManager;                   public const SHOWTASKTIP:String = "show_task_tip";            public function QuestBubbleManager() { super(); }
            public static function get Instance() : QuestBubbleManager { return null; }
            override protected function start() : void { }
            public function dispose() : void { }
   }}