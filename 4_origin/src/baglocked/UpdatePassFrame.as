package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class UpdatePassFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _ddtbaglock:ScaleBitmapImage;
      
      private var _deselectBtn5:TextButton;
      
      private var _text5_1:FilterFrameText;
      
      private var _text5_2:FilterFrameText;
      
      private var _text5_3:FilterFrameText;
      
      private var _text5_4:FilterFrameText;
      
      private var _text5_5:FilterFrameText;
      
      private var _textInput5_1:TextInput;
      
      private var _textInput5_2:TextInput;
      
      private var _textInput5_3:TextInput;
      
      private var _updateBtn:TextButton;
      
      public function UpdatePassFrame()
      {
         super();
      }
      
      public function __onTextEnter(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_updateBtn.enable)
            {
               __updateBtnClick(null);
            }
         }
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController = null;
         ObjectUtils.disposeObject(_text5_1);
         _text5_1 = null;
         ObjectUtils.disposeObject(_text5_2);
         _text5_2 = null;
         ObjectUtils.disposeObject(_text5_3);
         _text5_3 = null;
         ObjectUtils.disposeObject(_text5_4);
         _text5_4 = null;
         ObjectUtils.disposeObject(_text5_5);
         _text5_5 = null;
         ObjectUtils.disposeObject(_textInput5_1);
         _textInput5_1 = null;
         ObjectUtils.disposeObject(_textInput5_2);
         _textInput5_2 = null;
         ObjectUtils.disposeObject(_textInput5_3);
         _textInput5_3 = null;
         ObjectUtils.disposeObject(_updateBtn);
         _updateBtn = null;
         ObjectUtils.disposeObject(_deselectBtn5);
         _deselectBtn5 = null;
         ObjectUtils.disposeObject(_ddtbaglock);
         _ddtbaglock = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _text5_5.text = LanguageMgr.GetTranslation("baglocked.DelPassFrame.operationAlertInfo",PlayerManager.Instance.Self.leftTimes);
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.modifyTitle");
         _ddtbaglock = ComponentFactory.Instance.creatComponentByStylename("ddtbaglocked.BG2");
         addToContent(_ddtbaglock);
         _text5_1 = ComponentFactory.Instance.creat("baglocked.text5_1");
         _text5_1.text = LanguageMgr.GetTranslation("baglocked.UpdatePassFrame.Text5");
         addToContent(_text5_1);
         _text5_2 = ComponentFactory.Instance.creat("baglocked.text5_2");
         _text5_2.text = LanguageMgr.GetTranslation("baglocked.UpdatePassFrame.Text6");
         addToContent(_text5_2);
         _text5_3 = ComponentFactory.Instance.creat("baglocked.text5_3");
         _text5_3.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo2");
         addToContent(_text5_3);
         _text5_4 = ComponentFactory.Instance.creat("baglocked.text5_4");
         _text5_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo3");
         addToContent(_text5_4);
         _text5_5 = ComponentFactory.Instance.creat("baglocked.text5_5");
         addToContent(_text5_5);
         _textInput5_1 = ComponentFactory.Instance.creat("baglocked.textInput5_1");
         addToContent(_textInput5_1);
         _textInput5_2 = ComponentFactory.Instance.creat("baglocked.textInput5_2");
         addToContent(_textInput5_2);
         _textInput5_3 = ComponentFactory.Instance.creat("baglocked.textInput5_3");
         addToContent(_textInput5_3);
         _updateBtn = ComponentFactory.Instance.creat("baglocked.updateBtn");
         _updateBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.modifyBtn");
         addToContent(_updateBtn);
         _deselectBtn5 = ComponentFactory.Instance.creat("baglocked.deselectBtn5");
         _deselectBtn5.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_deselectBtn5);
         _textInput5_1.textField.tabIndex = 0;
         _textInput5_2.textField.tabIndex = 1;
         _textInput5_3.textField.tabIndex = 2;
         _updateBtn.enable = false;
         addEvent();
      }
      
      private function __deselectBtn5Click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.closeUpdatePassFrame();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      private function __textChange(param1:Event) : void
      {
         if(_textInput5_1.textField.length >= 6 && _textInput5_2.textField.length >= 6 && _textInput5_3.textField.length >= 6 && PlayerManager.Instance.Self.leftTimes > 0)
         {
            _updateBtn.enable = true;
         }
         else
         {
            _updateBtn.enable = false;
         }
      }
      
      private function __updateBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_textInput5_2.text == _textInput5_3.text)
         {
            if(PlayerManager.Instance.Self.leftTimes <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.operationTimesOut"));
               _updateBtn.enable = false;
               return;
            }
            PlayerManager.Instance.Self.leftTimes--;
            _loc2_ = PlayerManager.Instance.Self.leftTimes <= 0?"0":String(PlayerManager.Instance.Self.leftTimes);
            _text5_5.text = LanguageMgr.GetTranslation("baglocked.DelPassFrame.operationAlertInfo",_loc2_);
            _bagLockedController.bagLockedInfo.psw = _textInput5_1.text;
            _bagLockedController.bagLockedInfo.newPwd = _textInput5_2.text;
            _bagLockedController.updatePassFrameController();
            refreshBtnsState();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.diffrent"));
         }
      }
      
      private function __updateSuccessHandler(param1:BagEvent) : void
      {
         _bagLockedController.closeUpdatePassFrame();
      }
      
      private function refreshBtnsState() : void
      {
         if(PlayerManager.Instance.Self.leftTimes <= 0)
         {
            _updateBtn.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textInput5_1.textField.addEventListener("change",__textChange);
         _textInput5_1.textField.addEventListener("keyDown",__onTextEnter);
         _textInput5_2.textField.addEventListener("change",__textChange);
         _textInput5_2.textField.addEventListener("keyDown",__onTextEnter);
         _textInput5_3.textField.addEventListener("change",__textChange);
         _textInput5_3.textField.addEventListener("keyDown",__onTextEnter);
         _updateBtn.addEventListener("click",__updateBtnClick);
         _deselectBtn5.addEventListener("click",__deselectBtn5Click);
         PlayerManager.Instance.Self.addEventListener("updateSuccess",__updateSuccessHandler);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textInput5_1.textField.removeEventListener("change",__textChange);
         _textInput5_1.textField.removeEventListener("keyDown",__onTextEnter);
         _textInput5_2.textField.removeEventListener("change",__textChange);
         _textInput5_2.textField.removeEventListener("keyDown",__onTextEnter);
         _textInput5_3.textField.removeEventListener("change",__textChange);
         _textInput5_3.textField.removeEventListener("keyDown",__onTextEnter);
         _updateBtn.removeEventListener("click",__updateBtnClick);
         _deselectBtn5.removeEventListener("click",__deselectBtn5Click);
         PlayerManager.Instance.Self.removeEventListener("updateSuccess",__updateSuccessHandler);
      }
   }
}
