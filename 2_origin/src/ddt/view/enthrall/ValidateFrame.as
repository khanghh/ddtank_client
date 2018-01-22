package ddt.view.enthrall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class ValidateFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameInput:FilterFrameText;
      
      private var _idInput:FilterFrameText;
      
      private var _errorText:FilterFrameText;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      public function ValidateFrame()
      {
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         addEventListener("focusIn",__focusIn);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         removeEventListener("focusIn",__focusIn);
      }
      
      private function __focusIn(param1:FocusEvent) : void
      {
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creat("asset.core.view.enthrall.ValidateFrameBG");
         addToContent(_bg);
         _nameInput = ComponentFactory.Instance.creat("core.view.enthrall.ValidateNameInput");
         addToContent(_nameInput);
         _idInput = ComponentFactory.Instance.creat("core.view.enthrall.ValidateIDInput");
         _idInput.restrict = "0-9 xX";
         _idInput.maxChars = 18;
         addToContent(_idInput);
         _errorText = ComponentFactory.Instance.creat("core.view.enthrall.ValidateErrorText");
         addToContent(_errorText);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _okBtn.y = _bg.y + _bg.height + 6;
         _okBtn.x = 185;
         _okBtn.text = LanguageMgr.GetTranslation("tank.view.enthrallCheckFrame.checkBtn");
         _okBtn.addEventListener("click",__check);
         addToContent(_okBtn);
         _errorText.text = "";
         titleText = LanguageMgr.GetTranslation("tank.view.enthrallCheckFrame.checkTitle");
      }
      
      private function __check(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_nameInput.text == null || _nameInput.text == "")
         {
            _errorText.text = LanguageMgr.GetTranslation("ddt.enthrall.emptyName");
         }
         else if(StringHelper.cidCheck(_idInput.text))
         {
            if(StringHelper.cageCheck(_idInput.text.slice(6,14)))
            {
               SocketManager.Instance.out.sendCIDInfo(_nameInput.text,_idInput.text.toUpperCase());
               clear();
            }
            else
            {
               _errorText.text = LanguageMgr.GetTranslation("ddt.enthrall.invalidID2");
            }
         }
         else
         {
            _errorText.text = LanguageMgr.GetTranslation("ddt.enthrall.invalidID1");
         }
      }
      
      private function clear() : void
      {
         _nameInput.text = "";
         _idInput.text = "";
         _errorText.text = "";
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               hide();
         }
      }
      
      public function hide() : void
      {
         clear();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         hide();
         removeEvent();
         super.dispose();
      }
   }
}
