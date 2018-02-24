package braveDoor.view
{
   import BraveDoor.event.BraveDoorEvent;
   import braveDoor.BraveDoorControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.roomView.BaseRoomView;
   
   public class DuplicateTemRoomView extends BaseRoomView
   {
      
      private static const DUPLICATE_ICON_PATH:String = "asset.braveDoor.room.duplicateTitle";
       
      
      private var _itemList:SimpleTileList;
      
      private var _duplicateName:Bitmap;
      
      private var _startButton:BaseButton;
      
      private var _readyButton:BaseButton;
      
      private var _cancelButton:BaseButton;
      
      private var _exitButton:BaseButton;
      
      private var _inviteButton:BaseButton;
      
      private var _temItemView:DuplicateTemRoomItemView;
      
      private var _control:BraveDoorControl = null;
      
      public function DuplicateTemRoomView(param1:RoomInfo){super(null);}
      
      public function set control(param1:BraveDoorControl) : void{}
      
      override protected function initView() : void{}
      
      private function updateDuplicateName(param1:int) : void{}
      
      override protected function updateButtons() : void{}
      
      override protected function initPlayerItems() : void{}
      
      override protected function initEvents() : void{}
      
      override protected function __inviteClick(param1:MouseEvent) : void{}
      
      override protected function removeEvents() : void{}
      
      protected function __onStartLoad(param1:Event) : void{}
      
      protected function __onMapChanged(param1:RoomEvent) : void{}
      
      override protected function updateTimer() : void{}
      
      override protected function __updatePlayerItems(param1:RoomEvent) : void{}
      
      override protected function __updateState(param1:RoomEvent) : void{}
      
      override protected function __addPlayer(param1:RoomEvent) : void{}
      
      override protected function __removePlayer(param1:RoomEvent) : void{}
      
      override protected function __startClick(param1:MouseEvent) : void{}
      
      private function levCheck() : Boolean{return false;}
      
      override protected function __prepareClick(param1:MouseEvent) : void{}
      
      override protected function __cancelClick(param1:MouseEvent) : void{}
      
      override protected function __startHandler(param1:RoomEvent) : void{}
      
      protected function __exitClickHandler(param1:MouseEvent) : void{}
      
      override protected function kickHandler() : void{}
      
      override public function dispose() : void{}
   }
}
