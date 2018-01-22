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
      
      public function MicroendDownloadAwardsControl(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : MicroendDownloadAwardsControl
      {
         if(!instance)
         {
            instance = new MicroendDownloadAwardsControl(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         MicroendDownloadAwardsManager.getInstance().addEventListener("microendDownloadOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:Event) : void
      {
         if(!_frameConfirm)
         {
            AssetModuleLoader.addModelLoader("firstRecharge",6);
            AssetModuleLoader.addModelLoader("microenddownload",6);
            AssetModuleLoader.startCodeLoader(show);
         }
         else
         {
            show();
         }
      }
      
      private function show() : void
      {
         _frameConfirm = ComponentFactory.Instance.creatComponentByStylename("microenddownload.firstView");
         LayerManager.Instance.addToLayer(_frameConfirm,3,true,1);
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
