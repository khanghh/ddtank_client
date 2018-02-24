package church.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import church.controller.ChurchRoomListController;
   import church.model.ChurchRoomListModel;
   import church.view.weddingRoomList.WeddingRoomListNavView;
   import church.view.weddingRoomList.WeddingRoomListView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.view.MainToolBar;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ChurchMainView extends Sprite implements Disposeable
   {
      
      public static const NAV_PANEL:String = "btn panel";
      
      public static const ROOM_LIST:String = "room list";
       
      
      private var _controller:ChurchRoomListController;
      
      private var _model:ChurchRoomListModel;
      
      private var _titleMainAsset:Bitmap;
      
      private var _picPreviewAsset:MutipleImage;
      
      private var _chatFrame:Sprite;
      
      private var _weddingRoomListView:WeddingRoomListView;
      
      private var _weddingRoomListNavView:WeddingRoomListNavView;
      
      private var _currentState:String = "btn panel";
      
      private var _cell:BagCell;
      
      private var _BG:DisplayObject;
      
      private var _bg:Bitmap;
      
      public function ChurchMainView(param1:ChurchRoomListController, param2:ChurchRoomListModel){super();}
      
      protected function initialize() : void{}
      
      public function changeState(param1:String) : void{}
      
      private function updateViewState() : void{}
      
      private function returnClick() : void{}
      
      public function show() : void{}
      
      public function dispose() : void{}
   }
}
