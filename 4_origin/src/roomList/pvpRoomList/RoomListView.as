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
      
      public function RoomListView()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      public function initView(controller:RoomListController, model:RoomListModel) : void
      {
         titleText = LanguageMgr.GetTranslation("tank.hall.ChooseHallView.roomList");
         _model = model;
         _controller = controller;
         _roomListBg = new RoomListBGView(_controller,_model);
         addToContent(_roomListBg);
         _playerList = new RoomListPlayerListView(_model.getPlayerList());
         PositionUtils.setPos(_playerList,"roomList.playerListPos");
         addToContent(_playerList);
      }
      
      public function get roomListBg() : RoomListBGView
      {
         return _roomListBg;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               RoomListController.instance.hide();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_controller)
         {
            _controller.dispose();
            _controller = null;
         }
         if(_roomListBg)
         {
            _roomListBg.dispose();
            _roomListBg = null;
         }
         if(_playerList)
         {
            _playerList.dispose();
            _playerList = null;
         }
         super.dispose();
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
