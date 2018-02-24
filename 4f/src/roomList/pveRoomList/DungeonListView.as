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
      
      public function DungeonListView(){super();}
      
      private function initEvent() : void{}
      
      public function initView(param1:DungeonListController, param2:DungeonListModel) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
