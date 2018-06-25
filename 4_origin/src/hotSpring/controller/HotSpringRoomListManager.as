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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
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
      
      private function roomAddOrUpdate(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var roomVO:HotSpringRoomInfo = new HotSpringRoomInfo();
         roomVO.roomNumber = pkg.readInt();
         roomVO.roomID = pkg.readInt();
         roomVO.roomName = pkg.readUTF();
         roomVO.roomPassword = pkg.readUTF();
         roomVO.effectiveTime = pkg.readInt();
         roomVO.curCount = pkg.readInt();
         roomVO.playerID = pkg.readInt();
         roomVO.playerName = pkg.readUTF();
         roomVO.startTime = pkg.readDate();
         roomVO.roomIntroduction = pkg.readUTF();
         roomVO.roomType = pkg.readInt();
         roomVO.maxCount = pkg.readInt();
         roomVO.roomIsPassword = roomVO.roomPassword != "" && roomVO.roomPassword.length > 0;
         _model.roomAddOrUpdate(roomVO);
      }
      
      public function hotSpringEnter() : void
      {
         SocketManager.Instance.out.sendHotSpringEnter();
      }
      
      private function roomCreateSucceed(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var result:Boolean = pkg.readBoolean();
         if(!result)
         {
            return;
         }
         var roomVO:HotSpringRoomInfo = new HotSpringRoomInfo();
         roomVO.roomID = pkg.readInt();
         roomVO.roomName = pkg.readUTF();
         roomVO.roomPassword = pkg.readUTF();
         roomVO.effectiveTime = pkg.readInt();
         roomVO.curCount = pkg.readInt();
         roomVO.playerID = pkg.readInt();
         roomVO.playerName = pkg.readUTF();
         roomVO.startTime = pkg.readDate();
         roomVO.roomIntroduction = pkg.readUTF();
         roomVO.roomType = pkg.readInt();
         roomVO.maxCount = pkg.readInt();
         if(roomVO.roomPassword && roomVO.roomPassword != "" && roomVO.roomPassword.length > 0)
         {
            roomVO.roomIsPassword = true;
         }
         else
         {
            roomVO.roomIsPassword = false;
         }
         _model.roomSelf = roomVO;
      }
      
      private function roomListGet(event:CrazyTankSocketEvent) : void
      {
         var roomVO:* = null;
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var roomCount:int = pkg.readInt();
         for(i = 0; i < roomCount; )
         {
            roomVO = new HotSpringRoomInfo();
            roomVO.roomNumber = pkg.readInt();
            roomVO.roomID = pkg.readInt();
            roomVO.roomName = pkg.readUTF();
            roomVO.roomPassword = pkg.readUTF();
            roomVO.effectiveTime = pkg.readInt();
            roomVO.curCount = pkg.readInt();
            roomVO.playerID = pkg.readInt();
            roomVO.playerName = pkg.readUTF();
            roomVO.startTime = pkg.readDate();
            roomVO.roomIntroduction = pkg.readUTF();
            roomVO.roomType = pkg.readInt();
            roomVO.maxCount = pkg.readInt();
            _model.roomAddOrUpdate(roomVO);
            i++;
         }
      }
      
      private function roomRemove(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var roomID:int = pkg.readInt();
         _model.roomRemove(roomID);
      }
      
      public function roomEnterConfirm(roomID:int) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEnterConfirm(roomID);
      }
      
      public function roomEnter(roomID:int, inputPassword:String) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEnter(roomID,inputPassword);
      }
      
      public function quickEnterRoom() : void
      {
         SocketManager.Instance.out.sendHotSpringRoomQuickEnter();
      }
      
      public function roomCreate(roomVO:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomCreate(roomVO);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
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
