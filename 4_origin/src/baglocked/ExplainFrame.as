package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExplainFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _delPassBtn:TextButton;
      
      private var _explainMap:Sprite;
      
      private var _removeLockBtn:TextButton;
      
      private var _setPassBtn:TextButton;
      
      private var _updatePassBtn:TextButton;
      
      private var _ddtbagLocked:Scale9CornerImage;
      
      private var _btnSetting:SimpleBitmapButton;
      
      private var _pswNeededSelecterFrame:BagLockPSWNeededSelecterFrame;
      
      public function ExplainFrame()
      {
         super();
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController = null;
         ObjectUtils.disposeObject(_explainMap);
         _explainMap = null;
         ObjectUtils.disposeObject(_setPassBtn);
         _setPassBtn = null;
         ObjectUtils.disposeObject(_delPassBtn);
         _delPassBtn = null;
         ObjectUtils.disposeObject(_removeLockBtn);
         _removeLockBtn = null;
         ObjectUtils.disposeObject(_updatePassBtn);
         _updatePassBtn = null;
         ObjectUtils.disposeObject(_ddtbagLocked);
         _ddtbagLocked = null;
         if(_pswNeededSelecterFrame != null)
         {
            _pswNeededSelecterFrame.removeEventListener("response",__onSelecterFrameResponse);
            ObjectUtils.disposeObject(_pswNeededSelecterFrame);
            _pswNeededSelecterFrame = null;
         }
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.BagLockedHelpFrame.titleText");
         _ddtbagLocked = ComponentFactory.Instance.creatComponentByStylename("ddtbaglocked.BG1");
         addToContent(_ddtbagLocked);
         _explainMap = ComponentFactory.Instance.creatCustomObject("baglocked.explainText");
         addToContent(_explainMap);
         _setPassBtn = ComponentFactory.Instance.creat("baglocked.setPassBtn");
         _setPassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.setting");
         addToContent(_setPassBtn);
         _delPassBtn = ComponentFactory.Instance.creat("baglocked.delPassBtn");
         _delPassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.delete");
         addToContent(_delPassBtn);
         _removeLockBtn = ComponentFactory.Instance.creat("baglocked.removeLockBtn");
         _removeLockBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.unlock");
         addToContent(_removeLockBtn);
         _updatePassBtn = ComponentFactory.Instance.creat("baglocked.updatePassBtn");
         _updatePassBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.modify");
         addToContent(_updatePassBtn);
         _btnSetting = ComponentFactory.Instance.creat("baglocked.settingBtn");
         addToContent(_btnSetting);
         _btnSetting.addEventListener("click",onSettingClick);
         _setPassBtn.visible = !PlayerManager.Instance.Self.bagPwdState;
         _delPassBtn.visible = !_setPassBtn.visible;
         _removeLockBtn.enable = PlayerManager.Instance.Self.bagLocked;
         _updatePassBtn.enable = PlayerManager.Instance.Self.bagPwdState;
         _pswNeededSelecterFrame = ComponentFactory.Instance.creat("baglocked.pswNeededSelecter");
         _pswNeededSelecterFrame.addEventListener("response",__onSelecterFrameResponse);
         addEvent();
      }
      
      protected function onSettingClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LayerManager.Instance.addToLayer(_pswNeededSelecterFrame,2,true,1);
         _pswNeededSelecterFrame.refresh();
      }
      
      private function __onSelecterFrameResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
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
         if(PlayerManager.Instance.Self.questionOne == "")
         {
            _bagLockedController.openSetPassFrame1();
         }
         else
         {
            _bagLockedController.openSetPassFrameNew();
         }
         _bagLockedController.closeExplainFrame();
      }
      
      private function __delPassBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openDelPassFrame();
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
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _setPassBtn.addEventListener("click",__setPassBtnClick);
         _delPassBtn.addEventListener("click",__delPassBtnClick);
         _removeLockBtn.addEventListener("click",__removeLockBtnClick);
         _updatePassBtn.addEventListener("click",__updatePassBtnClick);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _setPassBtn.removeEventListener("click",__setPassBtnClick);
         _delPassBtn.removeEventListener("click",__delPassBtnClick);
         _removeLockBtn.removeEventListener("click",__removeLockBtnClick);
         _updatePassBtn.removeEventListener("click",__updatePassBtnClick);
      }
   }
}
