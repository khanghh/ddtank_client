package witchBlessing
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import witchBlessing.data.WitchBlessingModel;
   
   public class WitchBlessingManager extends EventDispatcher
   {
      
      private static var _instance:WitchBlessingManager;
      
      public static const WITCHBLESSING_SHOWFRAME:String = "witchblessingshowframe";
      
      public static const WITCHBLESSING_HIDE:String = "witchblessinghide";
      
      public static var loadComplete:Boolean = false;
       
      
      private var _model:WitchBlessingModel;
      
      public function WitchBlessingManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : WitchBlessingManager{return null;}
      
      public function setup() : void{}
      
      public function get model() : WitchBlessingModel{return null;}
      
      public function isOpen() : Boolean{return false;}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function __witchBlessingHandle(param1:CrazyTankSocketEvent) : void{}
      
      private function enterView(param1:PackageIn) : void{}
      
      public function testEnter() : void{}
      
      public function isOpenIcon(param1:PackageIn) : void{}
      
      public function onClickIcon() : void{}
      
      private function showMainView() : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __completeShow(param1:UIModuleEvent) : void{}
      
      public function hide() : void{}
   }
}
