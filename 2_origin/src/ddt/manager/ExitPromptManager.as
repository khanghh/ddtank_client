package ddt.manager
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import quest.TaskManager;
   
   public class ExitPromptManager extends EventDispatcher
   {
      
      public static const EXIT_OPENVIEW_0:String = "exitOpenView0";
      
      public static const EXIT_OPENVIEW_1:String = "exitOpenView1";
      
      private static var _instance:ExitPromptManager;
       
      
      public function ExitPromptManager()
      {
         super();
      }
      
      public static function get Instance() : ExitPromptManager
      {
         if(_instance == null)
         {
            _instance = new ExitPromptManager();
         }
         return _instance;
      }
      
      public function init() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("swfExitPrompt",receivedFromJavaScript);
         }
      }
      
      public function showView() : void
      {
         dispatchEvent(new Event("exitOpenView1"));
      }
      
      public function receivedFromJavaScript(param1:String = "") : void
      {
         dispatchEvent(new Event("exitOpenView0"));
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
