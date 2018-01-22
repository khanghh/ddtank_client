package rescue
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import rescue.data.RescueResultInfo;
   import rescue.views.RescueMainFrame;
   import rescue.views.RescueResultFrame;
   import road7th.comm.PackageIn;
   
   public class RescueControl
   {
      
      private static var _instance:RescueControl;
       
      
      private var _frame:RescueMainFrame;
      
      private var _resultFrame:RescueResultFrame;
      
      public var isNoPrompt:Boolean;
      
      public var isBand:Boolean;
      
      public var curSceneId:int;
      
      public function RescueControl(){super();}
      
      public static function get instance() : RescueControl{return null;}
      
      public function setup() : void{}
      
      protected function __fightResultHandler(param1:PkgEvent) : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      protected function createRescueMainFrame() : void{}
   }
}
