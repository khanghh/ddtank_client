package magpieBridge
{
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtBuried.data.MapItemData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import magpieBridge.data.MagpieModel;
   import road7th.comm.PackageIn;
   
   public class MagpieBridgeManager extends EventDispatcher
   {
      
      private static var _instance:MagpieBridgeManager;
       
      
      private var _magpieModel:MagpieModel;
      
      private var _isOpen:Boolean;
      
      private var _hallView:HallStateView;
      
      private var _magpieBtn:MovieClip;
      
      public function MagpieBridgeManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : MagpieBridgeManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      protected function __onOpen(param1:PkgEvent) : void{}
      
      public function initIcon(param1:Boolean) : void{}
      
      protected function __onMagpieBtnClick(param1:MouseEvent) : void{}
      
      protected function __onEnterView(param1:PkgEvent) : void{}
      
      public function get magpieModel() : MagpieModel{return null;}
   }
}
