package consortiaDomain
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ConsortiaDomainController extends EventDispatcher
   {
      
      private static var _instance:ConsortiaDomainController;
       
      
      private var _mgr:ConsortiaDomainManager;
      
      public function ConsortiaDomainController(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ConsortiaDomainController
      {
         if(_instance == null)
         {
            _instance = new ConsortiaDomainController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _mgr = ConsortiaDomainManager.instance;
         _mgr.addEventListener("complete",onComplete);
      }
      
      protected function onComplete(event:Event) : void
      {
      }
      
      public function disposeRewardSelectFrame() : void
      {
      }
   }
}
