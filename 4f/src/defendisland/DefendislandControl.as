package defendisland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import defendisland.view.DefendislandFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DefendislandControl extends EventDispatcher
   {
      
      private static var _instance:DefendislandControl;
       
      
      public var _frame:DefendislandFrame;
      
      public function DefendislandControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DefendislandControl{return null;}
      
      public function setup() : void{}
      
      private function __showHandler(param1:Event) : void{}
      
      public function __hideHandler(param1:Event) : void{}
   }
}
