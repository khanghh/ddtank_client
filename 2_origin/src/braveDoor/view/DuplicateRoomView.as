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
      
      public function DuplicateRoomView(param1:BraveDoorListModel)
      {
         _data = param1;
         super();
         initView();
         initEvent();
      }
      
      public function set control(param1:BraveDoorControl) : void
      {
         if(_control)
         {
            _control.removeEventListener("updateSelectDuplicate",_updateDuplidateHandler);
         }
         _control = param1;
         if(_control)
         {
            _control.addEventListener("updateSelectDuplicate",_updateDuplidateHandler);
         }
      }
      
      protected function initView() : void
      {
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateRoom.nextBtn");
         addChild(_nextBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateRoom.preBtn");
         addChild(_preBtn);
         _createRoom = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateRoom.createRoomBtn");
         addChild(_createRoom);
         _fastAdd = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateRoom.fastAddBtn");
         addChild(_fastAdd);
         _itemList = ComponentFactory.Instance.creat("braveDoor.duplicateRoom.roomItemList",[1]);
         _itemList.x = 716;
         _itemList.y = 99;
         addChild(_itemList);
         updateBtnState(false);
      }
      
      protected function initEvent() : void
      {
         _data.addEventListener("BraveDoorRoomListUpdate",__updateRoom);
         _createRoom.addEventListener("click",__createRoom_Handler);
         _fastAdd.addEventListener("click",__fastAddHandler);
         _nextBtn.addEventListener("click",__pageDownHandler);
         _preBtn.addEventListener("click",__pageDownHandler);
      }
      
      private function removeEvent() : void
      {
         _data.removeEventListener("BraveDoorRoomListUpdate",__updateRoom);
         _createRoom.removeEventListener("click",__createRoom_Handler);
         _fastAdd.removeEventListener("click",__fastAddHandler);
         _nextBtn.removeEventListener("click",__pageDownHandler);
         _preBtn.removeEventListener("click",__pageDownHandler);
         if(_control)
         {
            _control.removeEventListener("updateSelectDuplicate",_updateDuplidateHandler);
         }
      }
      
      private function __pageDownHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendUpdateRoomList(7,-2);
      }
      
      private function _updateDuplidateHandler(param1:BraveDoorEvent) : void
      {
         __createRoom_Handler(null);
      }
      
      private function __fastAddHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGameLogin(7,49);
      }
      
      private function __createRoom_Handler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _last_creat >= 2000)
         {
            _last_creat = getTimer();
            GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)],49,3);
         }
      }
      
      private function __updateRoom(param1:Event) : void
      {
         upadteRoomItem();
         if(_itemList != null && _itemList.numChildren > 0)
         {
            updateBtnState(true);
         }
      }
      
      private function updateBtnState(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _fastAdd.enable = _loc2_;
         _loc2_ = _loc2_;
         _preBtn.enable = _loc2_;
         _nextBtn.enable = _loc2_;
      }
      
      private function upadteRoomItem() : void
      {
         var _loc1_:* = null;
         _tempRoomData = currentDataList;
         if(_tempRoomData == null)
         {
            return;
         }
         if(_itemList.numChildren > 0)
         {
            _itemList.disposeAllChildren();
         }
         var _loc4_:int = 0;
         var _loc3_:* = _tempRoomData;
         for each(var _loc2_ in _tempRoomData)
         {
            if(_loc2_)
            {
               _loc1_ = new DuplicateRoomItemView(_loc2_);
               if(_loc2_.isPlaying)
               {
                  _loc1_.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               }
               else
               {
                  _loc1_.filters = null;
               }
               _loc1_.addEventListener("click",__itemClick,false,0,true);
               _itemList.addChild(_loc1_);
            }
         }
      }
      
      public function update() : void
      {
         __updateRoom(null);
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DuplicateRoomItemView = param1.currentTarget as DuplicateRoomItemView;
         if(!_loc2_.info.isPlaying)
         {
            gotoIntoRoom(_loc2_.info);
         }
         else
         {
            MessageTipManager.getInstance().show("Phòng đã bắt đầu trò chơi!");
         }
      }
      
      public function gotoIntoRoom(param1:RoomInfo) : void
      {
         SocketManager.Instance.out.sendGameLogin(7,-1,param1.ID,"");
      }
      
      public function get currentDataList() : Array
      {
         if(_data != null)
         {
            return _data.getRoomList().list;
         }
         return null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_createRoom)
         {
            ObjectUtils.disposeObject(_createRoom);
         }
         _createRoom = null;
         if(_fastAdd)
         {
            ObjectUtils.disposeObject(_fastAdd);
         }
         _fastAdd = null;
         if(_itemList)
         {
            _itemList.disposeAllChildren();
            removeChild(_itemList);
         }
         _itemList = null;
         _data = null;
         _control = null;
      }
   }
}
