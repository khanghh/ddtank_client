package kingBless
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import kingBless.view.KingBlessMainFrame;
   
   public class KingBlessControl extends EventDispatcher
   {
      
      private static var _instance:KingBlessControl;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function KingBlessControl(){super();}
      
      public static function get instance() : KingBlessControl{return null;}
      
      public function setup() : void{}
      
      public function __onShowView(param1:Event) : void{}
   }
}
