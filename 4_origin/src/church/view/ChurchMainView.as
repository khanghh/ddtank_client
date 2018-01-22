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
      
      public function ChurchMainView(param1:ChurchRoomListController, param2:ChurchRoomListModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initialize();
      }
      
      protected function initialize() : void
      {
         _weddingRoomListNavView = new WeddingRoomListNavView(_controller,_model);
         _weddingRoomListView = new WeddingRoomListView(_controller,_model);
         _BG = ComponentFactory.Instance.creatCustomObject("background.churchroomlist.bg");
         addChild(_BG);
         _titleMainAsset = ComponentFactory.Instance.creatBitmap("asset.church.main.titleMainAsset");
         addChild(_titleMainAsset);
         _picPreviewAsset = ComponentFactory.Instance.creatComponentByStylename("church.main.picPreviewAsset");
         addChild(_picPreviewAsset);
         _cell = CellFactory.instance.createPersonalInfoCell(-1,ItemManager.Instance.getTemplateById(9022),true) as BagCell;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("church.view.WeddingRoomListItemView.cellPos");
         _cell.x = _loc1_.x;
         _cell.y = _loc1_.y;
         _cell.setContentSize(60,60);
         addChild(_cell);
         updateViewState();
         ChatManager.Instance.state = 3;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
      }
      
      public function changeState(param1:String) : void
      {
         if(_currentState == param1)
         {
            return;
         }
         _currentState = param1;
         updateViewState();
      }
      
      private function updateViewState() : void
      {
         var _loc1_:* = _currentState;
         if("btn panel" !== _loc1_)
         {
            if("room list" === _loc1_)
            {
               SocketManager.Instance.out.sendMarryRoomLogin();
               addChild(_weddingRoomListView);
               _weddingRoomListView.updateList();
               MainToolBar.Instance.backFunction = returnClick;
               if(_weddingRoomListNavView.parent)
               {
                  removeChild(_weddingRoomListNavView);
               }
            }
         }
         else
         {
            addChild(_weddingRoomListNavView);
            MainToolBar.Instance.backFunction = null;
            if(_weddingRoomListView.parent)
            {
               removeChild(_weddingRoomListView);
               _weddingRoomListView.updateList();
            }
         }
      }
      
      private function returnClick() : void
      {
         changeState("btn panel");
      }
      
      public function show() : void
      {
         _controller.addChild(this);
      }
      
      public function dispose() : void
      {
         _controller = null;
         _model = null;
         if(_titleMainAsset)
         {
            if(_titleMainAsset.bitmapData)
            {
               _titleMainAsset.bitmapData.dispose();
            }
            _titleMainAsset.bitmapData = null;
         }
         _titleMainAsset = null;
         _BG = null;
         if(_picPreviewAsset)
         {
            ObjectUtils.disposeObject(_picPreviewAsset);
         }
         _picPreviewAsset = null;
         if(_chatFrame)
         {
            ObjectUtils.disposeObject(_chatFrame);
         }
         _chatFrame = null;
         if(_weddingRoomListView)
         {
            ObjectUtils.disposeObject(_weddingRoomListView);
         }
         _weddingRoomListView = null;
         if(_weddingRoomListNavView)
         {
            ObjectUtils.disposeObject(_weddingRoomListNavView);
         }
         _weddingRoomListNavView = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
      }
   }
}
