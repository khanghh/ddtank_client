package ddt.manager
{
   import ddt.CoreManager;
   import ddt.data.HotSpringRoomInfo;
   import ddt.events.PkgEvent;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class HotSpringManager extends CoreManager
   {
      
      private static var _instance:HotSpringManager;
       
      
      private var _roomCurrently:HotSpringRoomInfo;
      
      private var _playerEffectiveTime:int;
      
      private var _playerEnterRoomTime:Date;
      
      private var _energyTotal:int;
      
      public var messageTip:String;
      
      private var _isRemoveLoading:Boolean = true;
      
      public function HotSpringManager()
      {
         super();
      }
      
      public static function get instance() : HotSpringManager
      {
         if(!_instance)
         {
            _instance = new HotSpringManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(202),roomEnterSucceed);
         SocketManager.Instance.addEventListener(PkgEvent.format(169),roomPlayerRemove);
      }
      
      public function roomPlayerRemove(event:PkgEvent = null) : void
      {
         var pkg:PackageIn = event.pkg;
         var msg:String = pkg.readUTF();
         roomCurrently = null;
         if(msg && msg != "" && msg.length > 0)
         {
            ChatManager.Instance.sysChatYellow(msg);
            MessageTipManager.getInstance().show(msg);
         }
         if(messageTip && messageTip != "" && messageTip.length > 0)
         {
            ChatManager.Instance.sysChatYellow(messageTip);
            MessageTipManager.getInstance().show(messageTip);
         }
      }
      
      public function showStateView() : void
      {
         var msg:* = null;
         if(PlayerManager.Instance.Self.Grade < 10)
         {
            msg = LanguageMgr.GetTranslation("tank.hotSpring.levelLimted");
            MessageTipManager.getInstance().show(msg,0,false,1);
         }
         else
         {
            StateManager.setState("hotSpringRoomList");
         }
      }
      
      public function get roomCurrently() : HotSpringRoomInfo
      {
         return _roomCurrently;
      }
      
      public function set roomCurrently(value:HotSpringRoomInfo) : void
      {
         _roomCurrently = value;
      }
      
      private function roomEnterSucceed(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var hotSpringRoomInfo:HotSpringRoomInfo = new HotSpringRoomInfo();
         hotSpringRoomInfo.roomID = pkg.readInt();
         hotSpringRoomInfo.roomNumber = pkg.readInt();
         hotSpringRoomInfo.roomName = pkg.readUTF();
         hotSpringRoomInfo.roomPassword = pkg.readUTF();
         hotSpringRoomInfo.effectiveTime = pkg.readInt();
         hotSpringRoomInfo.curCount = pkg.readInt();
         hotSpringRoomInfo.playerID = pkg.readInt();
         hotSpringRoomInfo.playerName = pkg.readUTF();
         hotSpringRoomInfo.startTime = pkg.readDate();
         hotSpringRoomInfo.roomIntroduction = pkg.readUTF();
         hotSpringRoomInfo.roomType = pkg.readInt();
         hotSpringRoomInfo.maxCount = pkg.readInt();
         _playerEnterRoomTime = pkg.readDate();
         _playerEffectiveTime = pkg.readInt();
         _energyTotal = pkg.readInt();
         roomCurrently = hotSpringRoomInfo;
         roomEnter();
      }
      
      private function roomEnter() : void
      {
         if(StateManager.getState("hotSpringRoom") == null)
         {
            _isRemoveLoading = false;
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsClose);
         }
         StateManager.setState("hotSpringRoom");
      }
      
      private function __loadingIsClose(event:Event) : void
      {
         _isRemoveLoading = true;
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsClose);
         SocketManager.Instance.out.sendHotSpringRoomPlayerRemove();
      }
      
      public function removeLoadingEvent() : void
      {
         if(!_isRemoveLoading)
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsClose);
         }
      }
      
      public function get energyTotal() : int
      {
         return _energyTotal;
      }
      
      public function set energyTotal(value:int) : void
      {
         _energyTotal = value;
      }
      
      public function get playerEffectiveTime() : int
      {
         return _playerEffectiveTime;
      }
      
      public function set playerEffectiveTime(value:int) : void
      {
         _playerEffectiveTime = value;
      }
      
      public function get playerEnterRoomTime() : Date
      {
         return _playerEnterRoomTime;
      }
      
      public function set playerEnterRoomTime(value:Date) : void
      {
         _playerEnterRoomTime = value;
      }
   }
}
