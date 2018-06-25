package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class BagLockedGetFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _certainBtn:TextButton;
      
      private var _deselectBtn:TextButton;
      
      private var _forgetPwdBtn:TextButton;
      
      private var _text4_0:FilterFrameText;
      
      private var _text4_1:FilterFrameText;
      
      private var _textInput4:TextInput;
      
      public function BagLockedGetFrame()
      {
         super();
      }
      
      public function __onTextEnter(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         if(event.keyCode == 13)
         {
            if(_certainBtn.enable)
            {
               __certainBtnClick(null);
            }
         }
         else if(event.keyCode == 27)
         {
            SoundManager.instance.play("008");
            _bagLockedController.closeBagLockedGetFrame();
            BaglockedManager.Instance.dispatchEvent(new SetPassEvent("cancelBtn"));
         }
      }
      
      public function set bagLockedController(value:BagLockedController) : void
      {
         _bagLockedController = value;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController.clearBagLockedGetFrame();
         _bagLockedController = null;
         ObjectUtils.disposeObject(_text4_0);
         _text4_0 = null;
         ObjectUtils.disposeObject(_text4_1);
         _text4_1 = null;
         ObjectUtils.disposeObject(_textInput4);
         _textInput4 = null;
         ObjectUtils.disposeObject(_certainBtn);
         _certainBtn = null;
         ObjectUtils.disposeObject(_deselectBtn);
         _deselectBtn = null;
         if(_forgetPwdBtn)
         {
            ObjectUtils.disposeObject(_forgetPwdBtn);
         }
         _forgetPwdBtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,1,true,1);
         addEventListener("keyDown",__getFocus);
      }
      
      override protected function __onAddToStage(event:Event) : void
      {
         super.__onAddToStage(event);
         _textInput4.setFocus();
      }
      
      private function getFocus() : void
      {
         if(_textInput4)
         {
            _textInput4.setFocus();
         }
      }
      
      private function __getFocus(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         if(parent && this)
         {
            _textInput4.setFocus();
         }
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.unlock");
         _text4_0 = ComponentFactory.Instance.creat("baglocked.text4_0");
         _text4_0.text = LanguageMgr.GetTranslation("baglocked.BagLockedGetFrame.Text4");
         addToContent(_text4_0);
         _text4_1 = ComponentFactory.Instance.creat("baglocked.text4_1");
         _text4_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo1");
         addToContent(_text4_1);
         _textInput4 = ComponentFactory.Instance.creat("baglocked.textInput4");
         addToContent(_textInput4);
         _certainBtn = ComponentFactory.Instance.creat("baglocked.certainBtn");
         _certainBtn.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_certainBtn);
         _deselectBtn = ComponentFactory.Instance.creat("baglocked.deselectBtn");
         _deselectBtn.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_deselectBtn);
         if(BaglockedManager.LOCK_SETTING >= 0)
         {
            _forgetPwdBtn = ComponentFactory.Instance.creat("baglocked.forgetPwdBtn");
            _forgetPwdBtn.text = LanguageMgr.GetTranslation("baglocked.unlockFrame.forgetPwd");
            addToContent(_forgetPwdBtn);
            PositionUtils.setPos(_certainBtn,"bagLocked.centainRePos");
            PositionUtils.setPos(_deselectBtn,"bagLocked.cancelRePos");
         }
         _textInput4.textField.tabIndex = 0;
         _certainBtn.enable = false;
         addEvent();
      }
      
      private function __certainBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         removeEventListener("keyDown",__getFocus);
         _bagLockedController.bagLockedInfo.psw = _textInput4.text;
         _bagLockedController.BagLockedGetFrameController();
      }
      
      private function __deselectBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.closeBagLockedGetFrame();
         BaglockedManager.Instance.dispatchEvent(new SetPassEvent("cancelBtn"));
      }
      
      private function __clearSuccessHandler(event:BagEvent) : void
      {
         _bagLockedController.closeBagLockedGetFrame();
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.closeBagLockedGetFrame();
               BaglockedManager.Instance.dispatchEvent(new SetPassEvent("cancelBtn"));
         }
      }
      
      private function __textChange(event:Event) : void
      {
         if(_textInput4.text != "")
         {
            _certainBtn.enable = true;
         }
         else
         {
            _certainBtn.enable = false;
         }
      }
      
      protected function __forgetPwdBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(BaglockedManager.LOCK_SETTING))
         {
            case 0:
               _bagLockedController.openDeletePwdFrame();
               _bagLockedController.clearBagLockedGetFrame();
               break;
            case 1:
               _bagLockedController.openDelPassFrame();
               _bagLockedController.clearBagLockedGetFrame();
            default:
               _bagLockedController.openDelPassFrame();
               _bagLockedController.clearBagLockedGetFrame();
         }
         dispose();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textInput4.textField.addEventListener("change",__textChange);
         _textInput4.textField.addEventListener("keyDown",__onTextEnter,false,1000);
         _certainBtn.addEventListener("click",__certainBtnClick);
         _deselectBtn.addEventListener("click",__deselectBtnClick);
         if(_forgetPwdBtn)
         {
            _forgetPwdBtn.addEventListener("click",__forgetPwdBtnClick);
         }
         PlayerManager.Instance.Self.addEventListener("clearSuccess",__clearSuccessHandler);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textInput4.textField.removeEventListener("change",__textChange);
         _textInput4.textField.removeEventListener("keyDown",__onTextEnter);
         _certainBtn.removeEventListener("click",__certainBtnClick);
         _deselectBtn.removeEventListener("click",__deselectBtnClick);
         if(_forgetPwdBtn)
         {
            _forgetPwdBtn.removeEventListener("click",__forgetPwdBtnClick);
         }
         PlayerManager.Instance.Self.removeEventListener("clearSuccess",__clearSuccessHandler);
      }
   }
}
