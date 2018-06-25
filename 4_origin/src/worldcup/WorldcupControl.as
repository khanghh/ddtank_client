package worldcup
{
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import worldcup.view.WorldCupMainView;
   
   public class WorldcupControl
   {
      
      private static var _instance:WorldcupControl;
       
      
      public var mainFrame:WorldCupMainView;
      
      public function WorldcupControl()
      {
         super();
      }
      
      public static function get instance() : WorldcupControl
      {
         if(!_instance)
         {
            _instance = new WorldcupControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WorldcupManager.instance.addEventListener(WorldcupManager.OPEN_VIEW,__openViewHandler);
      }
      
      private function __openViewHandler(evt:CEvent) : void
      {
         disposeMainview();
         mainFrame = new WorldCupMainView();
         LayerManager.Instance.addToLayer(mainFrame,3,true,1);
      }
      
      public function disposeMainview() : void
      {
         if(mainFrame)
         {
            mainFrame.dispose();
            mainFrame = null;
         }
      }
   }
}
