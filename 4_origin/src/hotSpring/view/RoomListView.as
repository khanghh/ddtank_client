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
      
      public function RoomListView(param1:HotSpringRoomListManager, param2:HotSpringRoomListModel, param3:int = 1, param4:int = 8)
      {
         super();
         _controller = param1;
         _model = param2;
         _pageIndex = param3;
         _pageSize = param4;
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
      
      public function setRoomList(param1:HotSpringRoomListEvent = null) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         removeRoomList();
         if(!_model.roomList || _model.roomList.length <= 0)
         {
            return;
         }
         var _loc2_:Array = _model.roomList.list.slice(_pageIndex * _pageSize - _pageSize,_pageIndex * _pageSize <= _model.roomList.length?_pageIndex * _pageSize:_model.roomList.length);
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_;
         for each(var _loc5_ in _loc2_)
         {
            _loc4_ = new RoomListItemView(_model,_loc5_);
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("asset.HotSpringMainView.roomListItemBtn");
            _loc3_.backgound = _loc4_;
            _loc3_.mouseChildren = true;
            _loc4_.addEventListener("click",rootListItemClick);
            _list.spacing = 2.2;
            _list.addChild(_loc3_);
         }
         _list.refreshChildPos();
         dispatchEvent(new HotSpringRoomListEvent("roomListUpdateView"));
      }
      
      private function rootListItemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc2_:HotSpringRoomInfo = param1.currentTarget.roomVO;
         if(_loc2_.roomType == 1 || _loc2_.roomType == 2)
         {
            _controller.roomEnterConfirm(_loc2_.roomID);
         }
      }
      
      private function removeRoomList() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _list.numChildren)
         {
            (_list.getChildAt(_loc1_) as BaseButton).backgound.removeEventListener("click",rootListItemClick);
            (_list.getChildAt(_loc1_) as BaseButton).dispose();
            _loc1_++;
         }
         _list.disposeAllChildren();
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function set pageIndex(param1:int) : void
      {
         _pageIndex = param1;
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
