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
      
      public function roomPlayerRemove(param1:PkgEvent = null) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:String = _loc2_.readUTF();
         roomCurrently = null;
         if(_loc3_ && _loc3_ != "" && _loc3_.length > 0)
         {
            ChatManager.Instance.sysChatYellow(_loc3_);
            MessageTipManager.getInstance().show(_loc3_);
         }
         if(messageTip && messageTip != "" && messageTip.length > 0)
         {
            ChatManager.Instance.sysChatYellow(messageTip);
            MessageTipManager.getInstance().show(messageTip);
         }
      }
      
      public function showStateView() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade < 10)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.hotSpring.levelLimted");
            MessageTipManager.getInstance().show(_loc1_,0,false,1);
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
      
      public function set roomCurrently(param1:HotSpringRoomInfo) : void
      {
         _roomCurrently = param1;
      }
      
      private function roomEnterSucceed(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:HotSpringRoomInfo = new HotSpringRoomInfo();
         _loc2_.roomID = _loc3_.readInt();
         _loc2_.roomNumber = _loc3_.readInt();
         _loc2_.roomName = _loc3_.readUTF();
         _loc2_.roomPassword = _loc3_.readUTF();
         _loc2_.effectiveTime = _loc3_.readInt();
         _loc2_.curCount = _loc3_.readInt();
         _loc2_.playerID = _loc3_.readInt();
         _loc2_.playerName = _loc3_.readUTF();
         _loc2_.startTime = _loc3_.readDate();
         _loc2_.roomIntroduction = _loc3_.readUTF();
         _loc2_.roomType = _loc3_.readInt();
         _loc2_.maxCount = _loc3_.readInt();
         _playerEnterRoomTime = _loc3_.readDate();
         _playerEffectiveTime = _loc3_.readInt();
         _energyTotal = _loc3_.readInt();
         roomCurrently = _loc2_;
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
      
      private function __loadingIsClose(param1:Event) : void
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
      
      public function set energyTotal(param1:int) : void
      {
         _energyTotal = param1;
      }
      
      public function get playerEffectiveTime() : int
      {
         return _playerEffectiveTime;
      }
      
      public function set playerEffectiveTime(param1:int) : void
      {
         _playerEffectiveTime = param1;
      }
      
      public function get playerEnterRoomTime() : Date
      {
         return _playerEnterRoomTime;
      }
      
      public function set playerEnterRoomTime(param1:Date) : void
      {
         _playerEnterRoomTime = param1;
      }
   }
}
