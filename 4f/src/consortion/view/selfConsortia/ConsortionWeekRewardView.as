package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaWeekRewardPlayerVo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionWeekRewardView extends Sprite implements Disposeable
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _list:ListPanel;
      
      private var _lineI:Image;
      
      private var _lineII:Image;
      
      private var _lineIII:Image;
      
      private var _helpText:FilterFrameText;
      
      private var _helpBg:Bitmap;
      
      private var _backBtn:SimpleBitmapButton;
      
      public function ConsortionWeekRewardView(){super();}
      
      private function init() : void{}
      
      private function initList() : void{}
      
      private function compareFunction(param1:ConsortiaPlayerInfo, param2:ConsortiaPlayerInfo) : int{return 0;}
      
      private function onClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
