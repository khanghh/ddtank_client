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
      
      public function MagpieBridgeManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : MagpieBridgeManager
      {
         if(!_instance)
         {
            _instance = new MagpieBridgeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _magpieModel = new MagpieModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(276,11),__onOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(276,1),__onEnterView);
      }
      
      protected function __onOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _isOpen = _loc2_.readBoolean();
         initIcon(_isOpen);
      }
      
      public function initIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("magpiebridge",param1);
      }
      
      protected function __onMagpieBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.enterMagpieBridge();
      }
      
      protected function __onEnterView(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         _magpieModel.MapDataVec = new Vector.<MapItemData>();
         var _loc4_:PackageIn = param1.pkg;
         _magpieModel.MapId = _loc4_.readInt() - 1;
         _magpieModel.NowPosition = _loc4_.readInt();
         _magpieModel.LastNum = _loc4_.readInt();
         _magpieModel.MagpieNum = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = new MapItemData();
            _loc2_.type = _loc4_.readInt();
            _loc2_.tempID = _loc4_.readInt();
            _magpieModel.MapDataVec.push(_loc2_);
            _loc5_++;
         }
         StateManager.setState("magpiebridge");
      }
      
      public function get magpieModel() : MagpieModel
      {
         return _magpieModel;
      }
   }
}
