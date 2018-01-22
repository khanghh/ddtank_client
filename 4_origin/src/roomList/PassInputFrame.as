package roomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class PassInputFrame extends BaseAlerFrame implements Disposeable
   {
       
      
      private var _passInputText:TextInput;
      
      private var _explainText:FilterFrameText;
      
      private var _ID:int;
      
      public function PassInputFrame()
      {
         super();
         initContainer();
         initEvent();
      }
      
      private function initContainer() : void
      {
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         info = _loc1_;
         _passInputText = ComponentFactory.Instance.creat("asset.ddtroomlist.passinputFrame.input");
         _passInputText.text = "";
         _passInputText.textField.restrict = "0-9 A-Z a-z";
         addToContent(_passInputText);
         _explainText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomlist.passinputFrame.explain");
         _explainText.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo1");
         addToContent(_explainText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEvent);
         addEventListener("addedToStage",__addStage);
         _passInputText.addEventListener("change",__input);
         _passInputText.addEventListener("keyDown",__KeyDown);
      }
      
      private function __KeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            submit();
         }
      }
      
      private function __addStage(param1:Event) : void
      {
         if(_passInputText)
         {
            submitButtonEnable = false;
            _passInputText.setFocus();
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               hide();
               break;
            case 2:
            case 3:
            case 4:
               submit();
         }
      }
      
      private function submit() : void
      {
         SoundManager.instance.play("008");
         if(_passInputText.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIPassInput.write"));
            return;
         }
         if(StateManager.currentStateType == "roomlist")
         {
            SocketManager.Instance.out.sendGameLogin(1,-1,_ID,_passInputText.text);
         }
         else if(StateManager.currentStateType == "dungeon")
         {
            SocketManager.Instance.out.sendGameLogin(2,-1,_ID,_passInputText.text);
         }
         else
         {
            SocketManager.Instance.out.sendGameLogin(4,-1,_ID,_passInputText.text);
         }
         hide();
      }
      
      public function get ID() : int
      {
         return _ID;
      }
      
      public function set ID(param1:int) : void
      {
         _ID = param1;
      }
      
      private function hide() : void
      {
         dispose();
      }
      
      private function __input(param1:Event) : void
      {
         if(_passInputText.text != "")
         {
            submitButtonEnable = true;
         }
         else
         {
            submitButtonEnable = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _passInputText.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
