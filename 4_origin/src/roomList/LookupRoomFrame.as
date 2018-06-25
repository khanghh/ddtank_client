package roomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.IMEManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class LookupRoomFrame extends BaseAlerFrame implements Disposeable
   {
       
      
      private var _idInputText:TextInput;
      
      private var _passInputText:TextInput;
      
      private var _idText:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      public function LookupRoomFrame()
      {
         super();
         initContainer();
         initEvent();
      }
      
      private function initContainer() : void
      {
         this.escEnable = true;
         this.enterEnable = true;
         var _alertInfo:AlertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.search");
         info = _alertInfo;
         _idInputText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.idinput");
         _idInputText.text = "";
         _idInputText.textField.restrict = "0-9";
         _idInputText.textField.wordWrap = false;
         _idInputText.textField.autoSize = "none";
         _idInputText.textField.width = 135;
         addToContent(_idInputText);
         _passInputText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.passinput");
         _passInputText.text = "";
         _passInputText.textField.restrict = "0-9 A-Z a-z";
         addToContent(_passInputText);
         _idText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.id");
         addToContent(_idText);
         _idText.text = LanguageMgr.GetTranslation("ddt.roomlist.lookupframe.id");
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.lookupRoomFrame.selectBtn");
         addToContent(_checkBox);
         _checkBox.text = LanguageMgr.GetTranslation("ddt.roomlist.lookupframe.password");
         checkEnable();
      }
      
      private function initEvent() : void
      {
         _checkBox.addEventListener("click",__checkBoxClick);
         addEventListener("response",__frameEvent);
         addEventListener("addedToStage",__addStage);
         _idInputText.addEventListener("keyDown",__onkeyDown);
         _passInputText.addEventListener("keyDown",__onkeyDown);
      }
      
      private function __onkeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            SoundManager.instance.play("008");
            submit();
         }
      }
      
      private function __addStage(event:Event) : void
      {
         IMEManager.disable();
         if(_idInputText)
         {
            _idInputText.setFocus();
         }
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               hide();
               break;
            case 2:
            case 3:
            case 4:
               submit();
         }
      }
      
      protected function submit() : void
      {
         if(stage)
         {
            if(_idInputText.text == "")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.id"));
               return;
            }
            if(StateManager.currentStateType == "dungeon")
            {
               SocketManager.Instance.out.sendGameLogin(2,-1,int(_idInputText.text),_passInputText.text);
            }
            else
            {
               SocketManager.Instance.out.sendGameLogin(1,-1,int(_idInputText.text),_passInputText.text);
            }
         }
         hide();
      }
      
      protected function hide() : void
      {
         dispose();
      }
      
      private function __checkBoxClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _passInputText.text = "";
         checkEnable();
      }
      
      private function checkEnable() : void
      {
         if(_checkBox.selected)
         {
            _passInputText.setFocus();
            _passInputText.mouseChildren = true;
            _passInputText.mouseEnabled = true;
         }
         else
         {
            _idInputText.setFocus();
            _passInputText.mouseChildren = false;
            _passInputText.mouseEnabled = false;
         }
      }
      
      override public function dispose() : void
      {
         _checkBox.removeEventListener("click",__checkBoxClick);
         removeEventListener("response",__frameEvent);
         removeEventListener("addedToStage",__addStage);
         _idInputText.removeEventListener("keyDown",__onkeyDown);
         _passInputText.removeEventListener("keyDown",__onkeyDown);
         _checkBox.dispose();
         _idInputText.dispose();
         _passInputText.dispose();
         super.dispose();
      }
   }
}
