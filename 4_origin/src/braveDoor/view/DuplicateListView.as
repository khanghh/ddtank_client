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
      
      public function DuplicateListView()
      {
         super();
      }
      
      public function initView(control:BraveDoorControl, model:BraveDoorListModel) : void
      {
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("braveDoor.chatButton");
         _chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         _control = control;
         _data = model;
         switchRoomView();
         addChildAt(_chatBtn,1);
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_control)
         {
            _control.addEventListener("switchRoomView",__switchRoom_Handler);
         }
         _chatBtn.addEventListener("click",__chatClick);
      }
      
      private function removeEvent() : void
      {
         if(_control)
         {
            _control.removeEventListener("switchRoomView",__switchRoom_Handler);
         }
         _chatBtn.removeEventListener("click",__chatClick);
      }
      
      private function __chatClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      private function __switchRoom_Handler(evt:BraveDoorEvent) : void
      {
         var type:int = evt.data;
         switch(int(type) - 1)
         {
            case 0:
               switchRoomView();
               break;
            case 1:
               switchTemView();
         }
      }
      
      private function switchRoomView() : void
      {
         disposeTemView();
         if(_roomView == null)
         {
            _roomView = new DuplicateRoomView(_data);
            _roomView.control = _control;
            addChildAt(_roomView,0);
         }
         if(!_roomView.visible)
         {
            _roomView.visible = true;
         }
         _roomView.update();
      }
      
      private function switchTemView() : void
      {
         disposeRoomView();
         _roomInfo = RoomManager.Instance.current;
         if(_temView == null)
         {
            _temView = new DuplicateTemRoomView(_roomInfo);
            _temView.control = _control;
            addChildAt(_temView,0);
         }
         if(!_temView.visible)
         {
            _temView.visible = true;
         }
      }
      
      private function disposeTemView() : void
      {
         if(_temView)
         {
            ObjectUtils.disposeObject(_temView);
            _temView = null;
         }
      }
      
      private function disposeRoomView() : void
      {
         if(_roomView)
         {
            ObjectUtils.disposeObject(_roomView);
         }
         _roomView = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeRoomView();
         disposeTemView();
         _control = null;
         _data = null;
         if(_chatBtn)
         {
            ObjectUtils.disposeObject(_chatBtn);
         }
         _chatBtn = null;
      }
   }
}
