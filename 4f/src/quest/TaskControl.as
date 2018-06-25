package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestInfo;   import ddt.events.CEvent;   import flash.events.Event;      public class TaskControl   {            private static var _mainFrame:TaskMainFrame;            private static var _instance:TaskControl;                   public function TaskControl() { super(); }
            public static function get instance() : TaskControl { return null; }
            public function setup() : void { }
            private function __taskFrameShowHandler(event:Event) : void { }
            private function __taskFrameHideHandler(event:Event) : void { }
            private function __taskJumpToQuestHandler(event:CEvent) : void { }
            private function __taskGotoQuestHandler(event:CEvent) : void { }
            public function get MainFrame() : TaskMainFrame { return null; }
            public function set MainFrame(value:TaskMainFrame) : void { }
   }}