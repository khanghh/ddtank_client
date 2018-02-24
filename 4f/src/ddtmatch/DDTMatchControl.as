package ddtmatch
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddtmatch.manager.DDTMatchManager;
   import ddtmatch.view.DDTMatchMainFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DDTMatchControl extends EventDispatcher
   {
      
      private static var _instance:DDTMatchControl;
       
      
      private var _mainFrame:DDTMatchMainFrame;
      
      public function DDTMatchControl(){super();}
      
      public static function get instance() : DDTMatchControl{return null;}
      
      public function setup() : void{}
      
      private function __showFrameHandler(param1:Event) : void{}
   }
}
