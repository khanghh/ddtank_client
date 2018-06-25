package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.DesktopManager;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.PathManager;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import quest.TaskManager;
   
   public class ExitPromptControl
   {
      
      private static var _instance:ExitPromptControl;
       
      
      private var _exitPromptView:ExitPromptFrame;
      
      private var _isExitToLogin:String;
      
      public function ExitPromptControl()
      {
         super();
      }
      
      public static function get Instance() : ExitPromptControl
      {
         if(_instance == null)
         {
            _instance = new ExitPromptControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ExitPromptManager.Instance.addEventListener("exitOpenView0",__onOpenView0);
         ExitPromptManager.Instance.addEventListener("exitOpenView1",__onOpenView1);
      }
      
      private function __onOpenView1(event:Event) : void
      {
         showView("1");
      }
      
      private function __onOpenView0(event:Event) : void
      {
         if(!_exitPromptView)
         {
            showView();
         }
      }
      
      private function showView(str:String = "0") : void
      {
         _isExitToLogin = str;
         _exitPromptView = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame");
         _exitPromptView.show();
         _exitPromptView.addEventListener("submit",_submitExit);
         _exitPromptView.addEventListener("close",_closeExit);
      }
      
      private function _submitExit(e:Event) : void
      {
         if(_exitPromptView)
         {
            _exitPromptView.dispose();
         }
         _exitPromptView = null;
         if(DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("ExitGameToLogin",_isExitToLogin,PathManager.solveLogin());
         }
         else if(ExternalInterface.available)
         {
            ExternalInterface.call("closeWindow",_isExitToLogin,PathManager.solveLogin());
         }
      }
      
      private function _closeExit(e:Event) : void
      {
         if(_exitPromptView)
         {
            _exitPromptView.dispose();
         }
         _exitPromptView = null;
      }
      
      public function changeJSQuestVar() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setDailyTask",String(TaskManager.instance.getAvailableQuests(2).list.length));
            ExternalInterface.call("setDailyActivity",String(TaskManager.instance.getAvailableQuests(3).list.length));
         }
      }
   }
}
