package microenddownload
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import microenddownload.view.MicroendDownload;
   
   public class MicroendDownloadAwardsControl extends EventDispatcher
   {
      
      public static const SHOW:String = "show";
      
      private static var instance:MicroendDownloadAwardsControl;
       
      
      private var _callback:Function;
      
      private var _loadProgress:int = 0;
      
      private var _UILoadComplete:Boolean = false;
      
      private var _frameConfirm:MicroendDownload;
      
      public function MicroendDownloadAwardsControl(param1:inner){super();}
      
      public static function getInstance() : MicroendDownloadAwardsControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      private function show() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
