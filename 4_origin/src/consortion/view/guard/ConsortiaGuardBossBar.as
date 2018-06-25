package consortion.view.guard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import uiUtils.ProgressBarUI;
   
   public class ConsortiaGuardBossBar extends Sprite implements Disposeable
   {
       
      
      private var _barUI:ProgressBarUI;
      
      private var _light:MovieClip;
      
      private var _text:FilterFrameText;
      
      private var _headIconBtn:MovieClip;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _location:Point;
      
      private var _isShowRank:Boolean;
      
      private var _type:int = 0;
      
      public function ConsortiaGuardBossBar(type:int)
      {
         super();
         _type = type;
         init();
      }
      
      private function init() : void
      {
         _barUI = ComponentFactory.Instance.creat("consortiaGuard.bossHpBar");
         addChild(_barUI);
         _headIconBtn = ClassUtils.CreatInstance("asset.consortiaGurad.bossHead" + _type);
         PositionUtils.setPos(_headIconBtn,"consortiaGuard.ConsortiaGuardBossBar.headIconBtnPos");
         addChild(_headIconBtn);
         var _loc1_:* = true;
         _headIconBtn.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _headIconBtn.mouseEnabled = _loc1_;
         _headIconBtn.buttonMode = _loc1_;
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaGurad.bossRankBtn");
         addChild(_rankBtn);
         _location = ComponentFactory.Instance.creatCustomObject("consortiaGuard.bossIconClickLocationPos" + _type);
         initEvent();
         update();
      }
      
      private function initEvent() : void
      {
         _headIconBtn.addEventListener("click",__onclickBoosIcon);
         _rankBtn.addEventListener("click",__onClickRank);
         _headIconBtn.addEventListener("mouseOut",__onOutHead);
         _headIconBtn.addEventListener("mouseOver",__onOverHead);
         ConsortiaGuardControl.Instance.addEventListener("updateBossState",__onUpdateBossState);
      }
      
      private function __onOutHead(event:MouseEvent) : void
      {
         _headIconBtn.filters = null;
      }
      
      private function __onOverHead(event:MouseEvent) : void
      {
         _headIconBtn.filters = SceneCharacterPlayerBase.MOUSE_ON_GLOW_FILTER;
      }
      
      private function __onClickRank(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var type:int = _type + 1;
         if(!_isShowRank)
         {
            SocketManager.Instance.out.sendConsortiaGuradBossRank(type);
         }
         else
         {
            ConsortiaGuardControl.Instance.dispatchEvent(new ConsortiaGuardEvent("hideBossRank"));
         }
      }
      
      private function __onUpdateBossState(e:ConsortiaGuardEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _barUI.maxProgress = ConsortiaGuardControl.Instance.model.getBossMaxHp(_type);
         _barUI.progress = ConsortiaGuardControl.Instance.model.getBossHp(_type);
         var isRage:* = ConsortiaGuardControl.Instance.model.getBossState(_type) == 2;
         if(isRage)
         {
            if(_light == null)
            {
               _light = ComponentFactory.Instance.creat("asset.consortiaGurad.ui.light");
               _light.mouseEnabled = false;
               _light.mouseChildren = false;
               addChild(_light);
            }
            _light.play();
            _light.visible = true;
         }
         else if(_light)
         {
            _light.stop();
            _light.visible = false;
         }
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      private function removeEvent() : void
      {
         _rankBtn.removeEventListener("click",__onClickRank);
         _headIconBtn.removeEventListener("click",__onclickBoosIcon);
         _headIconBtn.removeEventListener("mouseOut",__onOutHead);
         _headIconBtn.removeEventListener("mouseOver",__onOverHead);
         ConsortiaGuardControl.Instance.removeEventListener("updateBossState",__onUpdateBossState);
      }
      
      protected function __onclickBoosIcon(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortiaGuardControl.Instance.bossLocation(_location);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_headIconBtn);
         _headIconBtn = null;
         ObjectUtils.disposeObject(_barUI);
         _barUI = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
      }
      
      public function set isShowRank(value:Boolean) : void
      {
         _isShowRank = value;
      }
   }
}
