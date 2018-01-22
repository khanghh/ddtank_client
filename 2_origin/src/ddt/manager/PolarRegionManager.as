package ddt.manager
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import flash.events.IEventDispatcher;
   import flash.utils.getTimer;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class PolarRegionManager extends CoreManager
   {
      
      private static var _instance:PolarRegionManager;
       
      
      public var ShowFlag:Boolean;
      
      private var _last_creat:uint;
      
      public var isOpen:Boolean;
      
      private var _hall:HallStateView;
      
      public function PolarRegionManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : PolarRegionManager
      {
         if(!_instance)
         {
            _instance = new PolarRegionManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ShowFlag = false;
         SocketManager.Instance.addEventListener(PkgEvent.format(305,0),__onOpenIcon);
      }
      
      protected function __onOpenIcon(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         isOpen = _loc2_.readBoolean();
         if(isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("polarRegion.open.text"));
         }
         else
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("polarRegion.close.text"));
         }
         HallIconManager.instance.updateSwitchHandler("PolarFuzion",isOpen);
      }
      
      override protected function start() : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _last_creat >= 2000)
         {
            ShowFlag = true;
            _last_creat = getTimer();
            GameInSocketOut.sendCreateRoom(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRvpRoomView.PolarRegion"),68,3);
         }
      }
   }
}
