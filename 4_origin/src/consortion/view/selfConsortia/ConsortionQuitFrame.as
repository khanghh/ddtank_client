package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ConsortionQuitFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _explain:FilterFrameText;
      
      private var _input:TextInput;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      private var _quitWord:FilterFrameText;
      
      public function ConsortionQuitFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.ExitConsortiaFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.bg");
         _explain = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.explain");
         _quitWord = ComponentFactory.Instance.creatComponentByStylename("consortion.quit.word");
         _input = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.input");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.cancel");
         addToContent(_bg);
         addToContent(_quitWord);
         _explain = ComponentFactory.Instance.creatComponentByStylename("consortion.quitFrame.explain");
         addToContent(_explain);
         addToContent(_input);
         addToContent(_ok);
         addToContent(_cancel);
         _explain.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.ExitConsortiaFrame.quit");
         _quitWord.text = LanguageMgr.GetTranslation("consortion.quit.word.text");
         _ok.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _ok.enable = false;
         _input.textField.maxChars = 8;
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
            quit();
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _input.setFocus();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         quit();
      }
      
      private function quit() : void
      {
         if(_input.text.toLowerCase() == "quit")
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SocketManager.Instance.out.sendConsortiaOut(PlayerManager.Instance.Self.ID);
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
         if(_input.text.toLowerCase() == "quit")
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
            SoundManager.instance.play("008");
            quit();
         }
         else if(param1.keyCode == 27)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _quitWord = null;
         _explain.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.ExitConsortiaFrame.quit");
         _explain = null;
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
