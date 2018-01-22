package halloween
{
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class HalloweenManager extends EventDispatcher
   {
      
      public static const OPENVIEW:String = "openView";
      
      private static var _instance:HalloweenManager;
       
      
      private var _open:Boolean;
      
      private var _hallView:HallStateView;
      
      public function HalloweenManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : HalloweenManager
      {
         if(_instance == null)
         {
            _instance = new HalloweenManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(283,1),__onHalloweenOpen);
      }
      
      protected function __onHalloweenOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _open = _loc2_.readBoolean();
         showHalloweenNpc();
      }
      
      public function creatHalloweenNpc(param1:HallStateView) : void
      {
         _hallView = param1;
         showHalloweenNpc();
      }
      
      private function showHalloweenNpc() : void
      {
         if(!_hallView)
         {
         }
      }
      
      public function show() : void
      {
         dispatchEvent(new Event("openView"));
      }
      
      public function deleteHallView() : void
      {
         _hallView = null;
      }
   }
}
