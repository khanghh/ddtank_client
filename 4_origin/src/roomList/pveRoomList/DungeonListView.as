package roomList.pveRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import trainer.view.NewHandContainer;
   
   public class DungeonListView extends Frame implements Disposeable
   {
       
      
      private var _leaf:Bitmap;
      
      private var _dungeonListBGView:DungeonListBGView;
      
      private var _playerList:DungeonRoomListPlayerListView;
      
      private var _model:DungeonListModel;
      
      private var _controlle:DungeonListController;
      
      public function DungeonListView()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      public function initView(param1:DungeonListController, param2:DungeonListModel) : void
      {
         titleText = LanguageMgr.GetTranslation("tank.hall.ChooseHallView.dungeon");
         _controlle = param1;
         _model = param2;
         _dungeonListBGView = new DungeonListBGView(_controlle,_model);
         PositionUtils.setPos(_dungeonListBGView,"asset.ddtdungeonList.bgview.pos");
         addChild(_dungeonListBGView);
         _playerList = new DungeonRoomListPlayerListView(_model.getPlayerList());
         _playerList.type = 2;
         PositionUtils.setPos(_playerList,"dungeonList.playerListPos");
         addChild(_playerList);
         _leaf = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.pve.leaf");
         addChild(_leaf);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               DungeonListController.instance.hide();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_dungeonListBGView)
         {
            _dungeonListBGView.dispose();
            _dungeonListBGView = null;
         }
         if(_playerList && _playerList.parent)
         {
            _playerList.dispose();
            _playerList = null;
         }
         if(_leaf)
         {
            _leaf.bitmapData.dispose();
            _leaf = null;
         }
         _model = null;
         if(_controlle)
         {
            _controlle.dispose();
            _controlle = null;
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         NewHandContainer.Instance.clearArrowByID(130);
      }
   }
}
