package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.CEvent;
   import flash.events.Event;
   
   public class TaskControl
   {
      
      private static var _mainFrame:TaskMainFrame;
      
      private static var _instance:TaskControl;
       
      
      public function TaskControl(){super();}
      
      public static function get instance() : TaskControl{return null;}
      
      public function setup() : void{}
      
      private function __taskFrameShowHandler(param1:Event) : void{}
      
      private function __taskFrameHideHandler(param1:Event) : void{}
      
      private function __taskJumpToQuestHandler(param1:CEvent) : void{}
      
      private function __taskGotoQuestHandler(param1:CEvent) : void{}
      
      public function get MainFrame() : TaskMainFrame{return null;}
      
      public function set MainFrame(param1:TaskMainFrame) : void{}
   }
}
