package braveDoor.view
{
   import BraveDoor.event.BraveDoorEvent;
   import braveDoor.BraveDoorControl;
   import braveDoor.data.BraveDoorListModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class DuplicateListView extends Sprite implements Disposeable
   {
       
      
      private var _control:BraveDoorControl;
      
      private var _data:BraveDoorListModel;
      
      private var _roomView:DuplicateRoomView = null;
      
      private var _temView:DuplicateTemRoomView;
      
      private var _chatBtn:BaseButton;
      
      private var _roomInfo:RoomInfo;
      
      public function DuplicateListView(){super();}
      
      public function initView(param1:BraveDoorControl, param2:BraveDoorListModel) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __chatClick(param1:MouseEvent) : void{}
      
      private function __switchRoom_Handler(param1:BraveDoorEvent) : void{}
      
      private function switchRoomView() : void{}
      
      private function switchTemView() : void{}
      
      private function disposeTemView() : void{}
      
      private function disposeRoomView() : void{}
      
      public function dispose() : void{}
   }
}
