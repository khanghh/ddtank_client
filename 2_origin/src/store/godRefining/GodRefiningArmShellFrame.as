package store.godRefining
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import store.godRefining.view.GodRefiningPreItemCell;
   
   public class GodRefiningArmShellFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _unloadBtn:BaseButton;
      
      private var _damageTitleTextArr:Vector.<FilterFrameText>;
      
      private var _damageContentTextArr:Vector.<FilterFrameText>;
      
      private var _levelText:FilterFrameText;
      
      private var _preItemCell:GodRefiningPreItemCell;
      
      public function GodRefiningArmShellFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("core.godRefiningArmShellFrame.title");
         autoExit = true;
         escEnable = true;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtcorei.armShellFrameBg");
         addToContent(_bg);
         _unloadBtn = ComponentFactory.Instance.creatComponentByStylename("core.godRefining.armShellUnloadBtn");
         addToContent(_unloadBtn);
         _damageTitleTextArr = new Vector.<FilterFrameText>();
         _damageContentTextArr = new Vector.<FilterFrameText>();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _damageTitleTextArr[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("core.godRefining.damageTitleText");
            _damageTitleTextArr[_loc1_].text = LanguageMgr.GetTranslation("store.godRefiningResetView.damageTitleTextMsg","普通武器");
            addToContent(_damageTitleTextArr[_loc1_]);
            _damageContentTextArr[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("core.godRefining.damageContentText");
            _damageContentTextArr[_loc1_].text = "+20%";
            addToContent(_damageContentTextArr[_loc1_]);
            if(_loc1_ == 1)
            {
               _damageTitleTextArr[_loc1_].y = _damageTitleTextArr[_loc1_].y + 30;
               _damageContentTextArr[_loc1_].y = _damageContentTextArr[_loc1_].y + 30;
            }
            _loc1_++;
         }
         _levelText = ComponentFactory.Instance.creatComponentByStylename("core.godRefining.levelText");
         _levelText.text = LanguageMgr.GetTranslation("store.godRefiningResetView.levelTextMsg",5);
         addToContent(_levelText);
         _preItemCell = new GodRefiningPreItemCell();
         PositionUtils.setPos(_preItemCell,"core.godRefining.preItemCellPos");
         addToContent(_preItemCell);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         _unloadBtn.addEventListener("click",__unloadBtnHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __unloadBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _unloadBtn.removeEventListener("click",__unloadBtnHandler);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _bg = null;
         _unloadBtn = null;
         _damageTitleTextArr = null;
         _damageContentTextArr = null;
         _levelText = null;
         _preItemCell = null;
         super.dispose();
      }
   }
}
