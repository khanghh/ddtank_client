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
      
      public function MagpieBridgeManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __onOpen(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _isOpen = pkg.readBoolean();
         initIcon(_isOpen);
      }
      
      public function initIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("magpiebridge",flag);
      }
      
      protected function __onMagpieBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.enterMagpieBridge();
      }
      
      protected function __onEnterView(event:PkgEvent) : void
      {
         var i:int = 0;
         var data:* = null;
         _magpieModel.MapDataVec = new Vector.<MapItemData>();
         var pkg:PackageIn = event.pkg;
         _magpieModel.MapId = pkg.readInt() - 1;
         _magpieModel.NowPosition = pkg.readInt();
         _magpieModel.LastNum = pkg.readInt();
         _magpieModel.MagpieNum = pkg.readInt();
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            data = new MapItemData();
            data.type = pkg.readInt();
            data.tempID = pkg.readInt();
            _magpieModel.MapDataVec.push(data);
            i++;
         }
         StateManager.setState("magpiebridge");
      }
      
      public function get magpieModel() : MagpieModel
      {
         return _magpieModel;
      }
   }
}
