package nationDay
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import nationDay.model.NationModel;
   import nationDay.view.NationalDayView;
   import road7th.comm.PackageIn;
   
   public class NationDayControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:NationDayControl;
       
      
      private var _nationView:NationalDayView;
      
      public function NationDayControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : NationDayControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      public function sendPkg() : void{}
      
      protected function __onGetNationInfo(param1:PkgEvent) : void{}
      
      public function show() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showNationDayFrame() : void{}
      
      public function hide() : void{}
   }
}
