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
       
      
      public function TaskControl()
      {
         super();
      }
      
      public static function get instance() : TaskControl
      {
         if(_instance == null)
         {
            _instance = new TaskControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         TaskManager.instance.addEventListener("taskFrameShow",__taskFrameShowHandler);
         TaskManager.instance.addEventListener("taskFrameHide",__taskFrameHideHandler);
         TaskManager.instance.addEventListener("taskJumpToQuest",__taskJumpToQuestHandler);
         TaskManager.instance.addEventListener("taskGotoQuest",__taskGotoQuestHandler);
      }
      
      private function __taskFrameShowHandler(event:Event) : void
      {
         MainFrame.open();
      }
      
      private function __taskFrameHideHandler(event:Event) : void
      {
         ObjectUtils.disposeObject(_mainFrame);
      }
      
      private function __taskJumpToQuestHandler(event:CEvent) : void
      {
         var info:QuestInfo = event.data as QuestInfo;
         MainFrame.jumpToQuest(info);
      }
      
      private function __taskGotoQuestHandler(event:CEvent) : void
      {
         var info:QuestInfo = event.data as QuestInfo;
         MainFrame.open();
         MainFrame.gotoQuest(info);
      }
      
      public function get MainFrame() : TaskMainFrame
      {
         if(!_mainFrame)
         {
            _mainFrame = ComponentFactory.Instance.creat("QuestFrame");
         }
         return _mainFrame;
      }
      
      public function set MainFrame(value:TaskMainFrame) : void
      {
         _mainFrame = value;
      }
   }
}
