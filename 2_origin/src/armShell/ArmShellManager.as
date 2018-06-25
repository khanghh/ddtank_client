package armShell
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import flash.events.IEventDispatcher;
   
   public class ArmShellManager extends CoreManager
   {
      
      public static const SHOWARMSHELLFRAME:String = "showArmShellFrame";
      
      private static var _instance:ArmShellManager;
       
      
      public function ArmShellManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ArmShellManager
      {
         if(_instance == null)
         {
            _instance = new ArmShellManager();
         }
         return _instance;
      }
      
      public function showArmShellFrame() : void
      {
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("showArmShellFrame"));
      }
   }
}
