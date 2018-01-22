package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ConsortionTrasferFrame extends Frame
   {
       
      
      private var _input:TextInput;
      
      private var _explain:FilterFrameText;
      
      private var _hint:FilterFrameText;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function ConsortionTrasferFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.AlienationConsortiaFrame.titleText");
         _input = ComponentFactory.Instance.creatComponentByStylename("consortion.transferFrame.input");
         _explain = ComponentFactory.Instance.creatComponentByStylename("consortion.transferFrame.explain");
         _hint = ComponentFactory.Instance.creatComponentByStylename("consortion.transferFrame.hint");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.transferFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.transferFrame.cancel");
         addToContent(_input);
         addToContent(_explain);
         addToContent(_hint);
         addToContent(_ok);
         addToContent(_cancel);
         _ok.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _explain.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.AlienationConsortiaFrame.inputName");
         _hint.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.AlienationConsortiaFrame.info");
         _ok.enable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         addEventListener("response",__responseHandler);
         _ok.addEventListener("click",__okHandler);
         _cancel.addEventListener("click",__cancelHandler);
         _input.addEventListener("change",__changeHandler);
         _input.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         removeEventListener("response",__responseHandler);
         _ok.removeEventListener("click",__okHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         _input.removeEventListener("change",__changeHandler);
         _input.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _input.setFocus();
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
            __okHandler(null);
         }
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _ok.enable = false;
         var _loc4_:int = 0;
         var _loc3_:* = ConsortionModelManager.Instance.model.memberList;
         for each(var _loc2_ in ConsortionModelManager.Instance.model.memberList)
         {
            if(_loc2_.NickName == _input.text)
            {
               if(_input.text == PlayerManager.Instance.Self.NickName)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.AlienationConsortiaFrame.NickName"));
                  _ok.enable = false;
                  _input.text = "";
                  return;
               }
               if(_loc2_.Grade < 17)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.AlienationConsortiaFrame.Grade"));
                  _ok.enable = false;
                  _input.text = "";
                  return;
               }
               SocketManager.Instance.out.sendConsortiaChangeChairman(_input.text);
               _input.text = "";
               dispose();
               return;
            }
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(_input.text != "")
         {
            var _loc4_:int = 0;
            var _loc3_:* = ConsortionModelManager.Instance.model.memberList;
            for each(var _loc2_ in ConsortionModelManager.Instance.model.memberList)
            {
               if(_loc2_.NickName == _input.text)
               {
                  _ok.enable = true;
                  return;
               }
            }
         }
         _ok.enable = false;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_ok.enable)
            {
               __okHandler(null);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _input = null;
         _explain = null;
         _hint = null;
         _ok = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
