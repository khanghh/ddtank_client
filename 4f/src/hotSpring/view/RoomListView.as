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
      
      public function RoomListView(param1:HotSpringRoomListManager, param2:HotSpringRoomListModel, param3:int = 1, param4:int = 8){super();}
      
      private function initialize() : void{}
      
      private function setEvent() : void{}
      
      public function setRoomList(param1:HotSpringRoomListEvent = null) : void{}
      
      private function rootListItemClick(param1:MouseEvent) : void{}
      
      private function removeRoomList() : void{}
      
      public function get pageIndex() : int{return 0;}
      
      public function set pageIndex(param1:int) : void{}
      
      public function get pageCount() : int{return 0;}
      
      public function dispose() : void{}
   }
}
