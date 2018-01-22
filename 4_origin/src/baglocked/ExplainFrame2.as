package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExplainFrame2 extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _explainMap:Bitmap;
      
      private var _btnBG:ScaleBitmapImage;
      
      private var _delPassBtn:TextButton;
      
      private var _setPassBtn:TextButton;
      
      private var _updatePassBtn:TextButton;
      
      private var _phoneServiceBtn:TextButton;
      
      private var _appealBtn:TextButton;
      
      private var _unLockBtn:SimpleBitmapButton;
      
      public function ExplainFrame2()
      {
         super();
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.BagLockedHelpFrame.titleText");
         _explainMap = ComponentFactory.Instance.creat("baglocked.pwdExplanation");
         addToContent(_explainMap);
         _btnBG = ComponentFactory.Instance.creatComponentByStylename("baglocked.btnBG");
         addToContent(_btnBG);
         _setPassBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.setPassBtn2");
         _setPassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.setting");
         addToContent(_setPassBtn);
         _delPassBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.delPassBtn2");
         _delPassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.delete");
         addToContent(_delPassBtn);
         _updatePassBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.updatePassBtn2");
         _updatePassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.modify");
         addToContent(_updatePassBtn);
         _phoneServiceBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.phoneServiceBtn");
         _phoneServiceBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneService");
         _appealBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.appealBtn");
         _appealBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.appeal");
         _unLockBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.unlockedBtn");
         addToContent(_unLockBtn);
         _setPassBtn.visible = !PlayerManager.Instance.Self.bagPwdState;
         _delPassBtn.visible = !_setPassBtn.visible;
         _unLockBtn.enable = PlayerManager.Instance.Self.bagLocked;
         _updatePassBtn.enable = PlayerManager.Instance.Self.bagPwdState;
         _phoneServiceBtn.enable = false;
         addEvent();
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
      
      private function __setPassBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         BagLockedController.Instance.checkBindCase = 1;
         SocketManager.Instance.out.checkPhoneBind();
      }
      
      private function __delPassBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openDeletePwdFrame();
         _bagLockedController.closeExplainFrame();
      }
      
      private function __removeLockBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
         BaglockedManager.Instance.show();
      }
      
      private function __updatePassBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openUpdatePassFrame();
         _bagLockedController.closeExplainFrame();
      }
      
      protected function __appealBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openAppealFrame();
         _bagLockedController.closeExplainFrame();
      }
      
      protected function __phoneServiceBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openPhoneServiceFrame();
         _bagLockedController.closeExplainFrame();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _setPassBtn.addEventListener("click",__setPassBtnClick);
         _delPassBtn.addEventListener("click",__delPassBtnClick);
         _unLockBtn.addEventListener("click",__removeLockBtnClick);
         _updatePassBtn.addEventListener("click",__updatePassBtnClick);
         _appealBtn.addEventListener("click",__appealBtnClick);
         _phoneServiceBtn.addEventListener("click",__phoneServiceBtnClick);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _setPassBtn.removeEventListener("click",__setPassBtnClick);
         _delPassBtn.removeEventListener("click",__delPassBtnClick);
         _unLockBtn.removeEventListener("click",__removeLockBtnClick);
         _updatePassBtn.removeEventListener("click",__updatePassBtnClick);
         _appealBtn.removeEventListener("click",__appealBtnClick);
         _phoneServiceBtn.addEventListener("click",__phoneServiceBtnClick);
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController = null;
         if(_explainMap)
         {
            ObjectUtils.disposeObject(_explainMap);
         }
         _explainMap = null;
         if(_btnBG)
         {
            ObjectUtils.disposeObject(_btnBG);
         }
         _btnBG = null;
         if(_setPassBtn)
         {
            ObjectUtils.disposeObject(_setPassBtn);
         }
         _setPassBtn = null;
         if(_delPassBtn)
         {
            ObjectUtils.disposeObject(_delPassBtn);
         }
         _delPassBtn = null;
         if(_updatePassBtn)
         {
            ObjectUtils.disposeObject(_updatePassBtn);
         }
         _updatePassBtn = null;
         if(_phoneServiceBtn)
         {
            ObjectUtils.disposeObject(_phoneServiceBtn);
         }
         _phoneServiceBtn = null;
         if(_appealBtn)
         {
            ObjectUtils.disposeObject(_appealBtn);
         }
         _appealBtn = null;
         if(_unLockBtn)
         {
            ObjectUtils.disposeObject(_unLockBtn);
         }
         _unLockBtn = null;
         super.dispose();
      }
      
      public function get phoneServiceBtn() : TextButton
      {
         return _phoneServiceBtn;
      }
   }
}
