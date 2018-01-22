package zodiac
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ZodiacControl extends EventDispatcher
   {
      
      private static var _instance:ZodiacControl;
       
      
      private var _frame:ZodiacFrame;
      
      public var inRolling:Boolean = false;
      
      public function ZodiacControl(param1:ZodiacInstance){super();}
      
      public static function get instance() : ZodiacControl{return null;}
      
      public function setup() : void{}
      
      private function __showMainViewHandler(param1:Event) : void{}
      
      private function __hideMainViewhandler(param1:Event) : void{}
      
      private function __updataIndexHandler(param1:Event) : void{}
      
      private function __updataMessageHandler(param1:Event) : void{}
      
      public function setCurrentIndexView(param1:int) : void{}
      
      public function getCurrentIndex() : int{return 0;}
   }
}

class ZodiacInstance
{
    
   
   function ZodiacInstance(){super();}
}
