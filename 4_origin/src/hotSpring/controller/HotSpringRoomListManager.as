package hotSpring.controller
{
   import ddt.data.HotSpringRoomInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import hotSpring.model.HotSpringRoomListModel;
   import hotSpring.view.HotSpringMainView;
   import road7th.comm.PackageIn;
   
   public class HotSpringRoomListManager extends BaseStateView
   {
       
      
      private var _view:HotSpringMainView;
      
      private var _model:HotSpringRoomListModel;
      
      public function HotSpringRoomListManager()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _model = HotSpringRoomListModel.Instance;
         if(_view)
         {
            _view.hide();
            _view.dispose();
         }
         _view = null;
         _view = new HotSpringMainView(this,_model);
         setEvent();
         _view.show();
         MainToolBar.Instance.show();
      }
      
      private function setEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(173),roomAddOrUpdate);
         SocketManager.Instance.addEventListener(PkgEvent.format(175),roomCreateSucceed);
         SocketManager.Instance.addEventListener(PkgEvent.format(197),roomListGet);
         SocketManager.Instance.addEventListener(PkgEvent.format(174),roomRemove);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(173),roomAddOrUpdate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(175),roomCreateSucceed);
         SocketManager.Instance.removeEventListener(PkgEvent.format(197),roomListGet);
         SocketManager.Instance.removeEventListener(PkgEvent.format(174),roomRemove);
      }
      
      private function roomAddOrUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:HotSpringRoomInfo = new HotSpringRoomInfo();
         _loc3_.roomNumber = _loc2_.readInt();
         _loc3_.roomID = _loc2_.readInt();
         _loc3_.roomName = _loc2_.readUTF();
         _loc3_.roomPassword = _loc2_.readUTF();
         _loc3_.effectiveTime = _loc2_.readInt();
         _loc3_.curCount = _loc2_.readInt();
         _loc3_.playerID = _loc2_.readInt();
         _loc3_.playerName = _loc2_.readUTF();
         _loc3_.startTime = _loc2_.readDate();
         _loc3_.roomIntroduction = _loc2_.readUTF();
         _loc3_.roomType = _loc2_.readInt();
         _loc3_.maxCount = _loc2_.readInt();
         _loc3_.roomIsPassword = _loc3_.roomPassword != "" && _loc3_.roomPassword.length > 0;
         _model.roomAddOrUpdate(_loc3_);
      }
      
      public function hotSpringEnter() : void
      {
         SocketManager.Instance.out.sendHotSpringEnter();
      }
      
      private function roomCreateSucceed(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:HotSpringRoomInfo = new HotSpringRoomInfo();
         _loc4_.roomID = _loc3_.readInt();
         _loc4_.roomName = _loc3_.readUTF();
         _loc4_.roomPassword = _loc3_.readUTF();
         _loc4_.effectiveTime = _loc3_.readInt();
         _loc4_.curCount = _loc3_.readInt();
         _loc4_.playerID = _loc3_.readInt();
         _loc4_.playerName = _loc3_.readUTF();
         _loc4_.startTime = _loc3_.readDate();
         _loc4_.roomIntroduction = _loc3_.readUTF();
         _loc4_.roomType = _loc3_.readInt();
         _loc4_.maxCount = _loc3_.readInt();
         if(_loc4_.roomPassword && _loc4_.roomPassword != "" && _loc4_.roomPassword.length > 0)
         {
            _loc4_.roomIsPassword = true;
         }
         else
         {
            _loc4_.roomIsPassword = false;
         }
         _model.roomSelf = _loc4_;
      }
      
      private function roomListGet(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new HotSpringRoomInfo();
            _loc4_.roomNumber = _loc3_.readInt();
            _loc4_.roomID = _loc3_.readInt();
            _loc4_.roomName = _loc3_.readUTF();
            _loc4_.roomPassword = _loc3_.readUTF();
            _loc4_.effectiveTime = _loc3_.readInt();
            _loc4_.curCount = _loc3_.readInt();
            _loc4_.playerID = _loc3_.readInt();
            _loc4_.playerName = _loc3_.readUTF();
            _loc4_.startTime = _loc3_.readDate();
            _loc4_.roomIntroduction = _loc3_.readUTF();
            _loc4_.roomType = _loc3_.readInt();
            _loc4_.maxCount = _loc3_.readInt();
            _model.roomAddOrUpdate(_loc4_);
            _loc5_++;
         }
      }
      
      private function roomRemove(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _model.roomRemove(_loc3_);
      }
      
      public function roomEnterConfirm(param1:int) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEnterConfirm(param1);
      }
      
      public function roomEnter(param1:int, param2:String) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEnter(param1,param2);
      }
      
      public function quickEnterRoom() : void
      {
         SocketManager.Instance.out.sendHotSpringRoomQuickEnter();
      }
      
      public function roomCreate(param1:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomCreate(param1);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         MainToolBar.Instance.hide();
         dispose();
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "hotSpringRoomList";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_view)
         {
            _view.hide();
            _view.dispose();
         }
         _view = null;
         if(_model)
         {
            _model.dispose();
         }
         _model = null;
      }
   }
}
