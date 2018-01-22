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
      
      public function HotSpringRoomListManager(){super();}
      
      override public function prepare() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function roomAddOrUpdate(param1:CrazyTankSocketEvent) : void{}
      
      public function hotSpringEnter() : void{}
      
      private function roomCreateSucceed(param1:CrazyTankSocketEvent) : void{}
      
      private function roomListGet(param1:CrazyTankSocketEvent) : void{}
      
      private function roomRemove(param1:CrazyTankSocketEvent) : void{}
      
      public function roomEnterConfirm(param1:int) : void{}
      
      public function roomEnter(param1:int, param2:String) : void{}
      
      public function quickEnterRoom() : void{}
      
      public function roomCreate(param1:HotSpringRoomInfo) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
