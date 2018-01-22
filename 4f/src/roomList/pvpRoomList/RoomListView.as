package roomList.pvpRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   
   public class RoomListView extends Frame implements Disposeable
   {
       
      
      private var _roomListBg:RoomListBGView;
      
      private var _playerList:RoomListPlayerListView;
      
      private var _model:RoomListModel;
      
      private var _controller:RoomListController;
      
      public function RoomListView(){super();}
      
      private function initEvent() : void{}
      
      public function initView(param1:RoomListController, param2:RoomListModel) : void{}
      
      public function get roomListBg() : RoomListBGView{return null;}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
