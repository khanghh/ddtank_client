package im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class AddFriendFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const MAX_CHAES:int = 14;
       
      
      protected var _inputText:FilterFrameText;
      
      protected var _explainText:FilterFrameText;
      
      protected var _hintText:FilterFrameText;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _name:String;
      
      public function AddFriendFrame()
      {
         super();
         initContainer();
         initEvent();
      }
      
      protected function initContainer() : void
      {
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.view.im.AddFriendFrame.add");
         _alertInfo.enterEnable = true;
         _alertInfo.escEnable = true;
         _alertInfo.submitEnabled = false;
         info = _alertInfo;
         var bg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("im.addFriendInputBG");
         addToContent(bg);
         _inputText = ComponentFactory.Instance.creat("textinput");
         _inputText.maxChars = 14;
         addToContent(_inputText);
         _explainText = ComponentFactory.Instance.creat("IM.TextStyle");
         _explainText.text = LanguageMgr.GetTranslation("tank.view.im.AddFriendFrame.name");
         addToContent(_explainText);
         _hintText = ComponentFactory.Instance.creat("IM.TextStyleII");
         _hintText.text = LanguageMgr.GetTranslation("tank.view.im.AddBlackListFrame.chat");
         addToContent(_hintText);
         _name = "";
      }
      
      private function initEvent() : void
      {
         addEventListener("addedToStage",__setFocus);
         addEventListener("response",__frameEvent);
         _inputText.addEventListener("keyDown",__fieldKeyDown);
         _inputText.addEventListener("change",__inputTextChange);
         ChatManager.Instance.output.contentField.addEventListener("nicknameClickToOutside",__onNameClick);
      }
      
      private function __inputTextChange(evt:Event = null) : void
      {
         if(_inputText.text != "")
         {
            submitButtonEnable = true;
         }
         else
         {
            submitButtonEnable = false;
         }
         _name = _inputText.text;
      }
      
      private function __onNameClick(e:ChatEvent) : void
      {
         _inputText.text = String(e.data);
         __inputTextChange(null);
      }
      
      protected function __fieldKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            if(_name == "" || _name == null)
            {
               return;
            }
            submit();
            SoundManager.instance.play("008");
         }
         else if(event.keyCode == 27)
         {
            hide();
            SoundManager.instance.play("008");
         }
         event.stopImmediatePropagation();
         event.stopPropagation();
      }
      
      private function __frameEvent(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
               hide();
               SoundManager.instance.play("008");
               break;
            default:
               hide();
               SoundManager.instance.play("008");
               break;
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               submit();
         }
      }
      
      protected function submit() : void
      {
         if(_name == "" || _name == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IMControl.addNullFriend"));
            return;
         }
         hide();
         IMManager.Instance.addFriend(_name);
      }
      
      protected function hide() : void
      {
         dispose();
      }
      
      private function __setFocus(evt:Event) : void
      {
         IMManager.IS_SHOW_SUB = true;
         _inputText.setFocus();
      }
      
      override public function dispose() : void
      {
         if(_inputText)
         {
            _inputText.removeEventListener("keyDown",__fieldKeyDown);
         }
         ChatManager.Instance.output.contentField.removeEventListener("nicknameClickToOutside",__onNameClick);
         super.dispose();
         removeEventListener("addedToStage",__setFocus);
         removeEventListener("response",__frameEvent);
         if(_inputText)
         {
            _inputText.dispose();
            _inputText = null;
         }
         if(_explainText)
         {
            _explainText.dispose();
            _explainText = null;
         }
         if(_hintText)
         {
            _hintText.dispose();
            _hintText = null;
         }
         _alertInfo = null;
         IMManager.IS_SHOW_SUB = false;
      }
   }
}
