package GodSyah
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class SyahControl extends EventDispatcher
   {
      
      private static var _instance:SyahControl;
       
      
      public function SyahControl(param1:SyahInstance){super();}
      
      public static function get instance() : SyahControl{return null;}
      
      public function setup() : void{}
      
      private function __showMainViewHandler(param1:Event) : void{}
      
      private function __hideMainViewHandler(param1:Event) : void{}
   }
}

class SyahInstance
{
    
   
   function SyahInstance(){super();}
}
