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
      
      public function DDTMatchControl()
      {
         super();
      }
      
      public static function get instance() : DDTMatchControl
      {
         if(!_instance)
         {
            _instance = new DDTMatchControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DDTMatchManager.instance.addEventListener("showMainView",__showFrameHandler);
      }
      
      private function __showFrameHandler(e:Event) : void
      {
         _mainFrame = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.mainframe");
         LayerManager.Instance.addToLayer(_mainFrame,3,true,1);
      }
   }
}
