package braveDoor.view
{
   import BraveDoor.event.BraveDoorEvent;
   import braveDoor.BraveDoorControl;
   import braveDoor.data.BraveDoorListModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import room.model.RoomInfo;
   import roomList.RoomListEnumerate;
   
   public class DuplicateRoomView extends Sprite implements Disposeable
   {
       
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _itemList:SimpleTileList;
      
      private var _createRoom:BaseButton;
      
      private var _fastAdd:BaseButton;
      
      private var _control:BraveDoorControl;
      
      private var _data:BraveDoorListModel;
      
      private var _last_creat:uint;
      
      private var _tempRoomData:Array;
      
      public function DuplicateRoomView(param1:BraveDoorListModel){super();}
      
      public function set control(param1:BraveDoorControl) : void{}
      
      protected function initView() : void{}
      
      protected function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __pageDownHandler(param1:MouseEvent) : void{}
      
      private function _updateDuplidateHandler(param1:BraveDoorEvent) : void{}
      
      private function __fastAddHandler(param1:MouseEvent) : void{}
      
      private function __createRoom_Handler(param1:MouseEvent) : void{}
      
      private function __updateRoom(param1:Event) : void{}
      
      private function updateBtnState(param1:Boolean) : void{}
      
      private function upadteRoomItem() : void{}
      
      public function update() : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      public function gotoIntoRoom(param1:RoomInfo) : void{}
      
      public function get currentDataList() : Array{return null;}
      
      public function dispose() : void{}
   }
}
