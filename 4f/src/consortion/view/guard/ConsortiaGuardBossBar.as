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
      
      public function ConsortiaGuardBossBar(param1:int){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __onOutHead(param1:MouseEvent) : void{}
      
      private function __onOverHead(param1:MouseEvent) : void{}
      
      private function __onClickRank(param1:MouseEvent) : void{}
      
      private function __onUpdateBossState(param1:ConsortiaGuardEvent) : void{}
      
      private function update() : void{}
      
      public function set type(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      protected function __onclickBoosIcon(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
      
      public function set isShowRank(param1:Boolean) : void{}
   }
}
