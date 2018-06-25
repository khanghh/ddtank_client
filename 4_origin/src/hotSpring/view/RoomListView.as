package hotSpring.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.HotSpringRoomInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hotSpring.controller.HotSpringRoomListManager;
   import hotSpring.event.HotSpringRoomListEvent;
   import hotSpring.model.HotSpringRoomListModel;
   
   public class RoomListView extends Sprite implements Disposeable
   {
       
      
      private var _controller:HotSpringRoomListManager;
      
      private var _model:HotSpringRoomListModel;
      
      private var _roomListItem:RoomListItemView;
      
      private var _pageCount:int;
      
      private var _pageIndex:int = 1;
      
      private var _pageSize:int = 7;
      
      private var _list:VBox;
      
      public function RoomListView(controller:HotSpringRoomListManager, model:HotSpringRoomListModel, pageIndex:int = 1, pageSize:int = 8)
      {
         super();
         _controller = controller;
         _model = model;
         _pageIndex = pageIndex;
         _pageSize = pageSize;
         initialize();
      }
      
      private function initialize() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.roomListVBox");
         addChild(_list);
         setRoomList();
         setEvent();
      }
      
      private function setEvent() : void
      {
         _model.addEventListener("roomListUpdate",setRoomList);
      }
      
      public function setRoomList(evt:HotSpringRoomListEvent = null) : void
      {
         var roomListItem:* = null;
         var btn:* = null;
         removeRoomList();
         if(!_model.roomList || _model.roomList.length <= 0)
         {
            return;
         }
         var pageList:Array = _model.roomList.list.slice(_pageIndex * _pageSize - _pageSize,_pageIndex * _pageSize <= _model.roomList.length?_pageIndex * _pageSize:_model.roomList.length);
         var i:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = pageList;
         for each(var roomVO in pageList)
         {
            roomListItem = new RoomListItemView(_model,roomVO);
            btn = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.roomListItemBtn");
            btn.backgound = roomListItem;
            btn.mouseChildren = true;
            roomListItem.addEventListener("click",rootListItemClick);
            _list.spacing = 2.2;
            _list.addChild(btn);
         }
         _list.refreshChildPos();
         dispatchEvent(new HotSpringRoomListEvent("roomListUpdateView"));
      }
      
      private function rootListItemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         var roomVO:HotSpringRoomInfo = evt.currentTarget.roomVO;
         if(roomVO.roomType == 1 || roomVO.roomType == 2)
         {
            _controller.roomEnterConfirm(roomVO.roomID);
         }
      }
      
      private function removeRoomList() : void
      {
         var i:int = 0;
         for(i = 0; i < _list.numChildren; )
         {
            (_list.getChildAt(i) as BaseButton).backgound.removeEventListener("click",rootListItemClick);
            (_list.getChildAt(i) as BaseButton).dispose();
            i++;
         }
         _list.disposeAllChildren();
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function set pageIndex(value:int) : void
      {
         _pageIndex = value;
         setRoomList();
      }
      
      public function get pageCount() : int
      {
         _pageCount = _model.roomList.length / _pageSize;
         if(_model.roomList.length % _pageSize > 0)
         {
            _pageCount = _pageCount + 1;
         }
         return _pageCount;
      }
      
      public function dispose() : void
      {
         _model.removeEventListener("roomListUpdate",setRoomList);
         removeRoomList();
         _controller = null;
         _model = null;
         if(_list)
         {
            _list.disposeAllChildren();
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
