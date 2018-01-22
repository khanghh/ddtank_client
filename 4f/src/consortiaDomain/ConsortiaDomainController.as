package consortiaDomain
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ConsortiaDomainController extends EventDispatcher
   {
      
      private static var _instance:ConsortiaDomainController;
       
      
      private var _mgr:ConsortiaDomainManager;
      
      public function ConsortiaDomainController(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ConsortiaDomainController{return null;}
      
      public function setup() : void{}
      
      protected function onComplete(param1:Event) : void{}
      
      public function disposeRewardSelectFrame() : void{}
   }
}
