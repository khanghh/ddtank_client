package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class WantTakeInFrame extends Frame
   {
       
      
      private var _tip:FilterFrameText;
      
      private var _input:TextInput;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function WantTakeInFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         enterEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.RecruitMemberFrame.titleText");
         _tip = ComponentFactory.Instance.creatComponentByStylename("consortion.WantTakeInFrame.tip");
         _input = ComponentFactory.Instance.creatComponentByStylename("consortion.WantTakeInFrame.input");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.WantTakeInFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.WantTakeInFrame.cancel");
         addToContent(_input);
         addToContent(_tip);
         addToContent(_ok);
         addToContent(_cancel);
         _tip.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.RecruitMemberFrame.tipTxt");
         _ok.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _ok.enable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         addEventListener("addedToStage",__addToStageHandler);
         _ok.addEventListener("click",__clickHandler);
         _cancel.addEventListener("click",__cancelHandler);
         _input.addEventListener("change",__inputChangeHandler);
         _input.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         removeEventListener("addedToStage",__addToStageHandler);
         _ok.removeEventListener("click",__clickHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         _input.removeEventListener("change",__inputChangeHandler);
         _input.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
         if(param1.responseCode == 2)
         {
            __clickHandler(null);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _input.setFocus();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_input.text != "")
         {
            SocketManager.Instance.out.sendConsortiaInvate(StringHelper.trim(_input.text));
            dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __inputChangeHandler(param1:Event) : void
      {
         StringHelper.checkTextFieldLength(_input.textField,14);
         if(_input.text != "")
         {
            _ok.enable = true;
         }
         else
         {
            _ok.enable = false;
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __clickHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _tip = null;
         _input = null;
         _ok = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
