package horse.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameRightBottomItemCell;
   import ddtDeed.DeedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import horse.HorseControl;
   import horse.HorseManager;
   import road7th.utils.MovieClipWrapper;
   import shop.manager.ShopBuyManager;
   import trainer.view.NewHandContainer;
   
   public class HorseFrameRightBottomView extends Sprite implements Disposeable
   {
       
      
      private var _levelUpBtn:SimpleBitmapButton;
      
      private var _freeUpBtn:SimpleBitmapButton;
      
      private var _freeUpTxt:FilterFrameText;
      
      private var _scb:SelectedCheckButton;
      
      private var _itemCell:HorseFrameRightBottomItemCell;
      
      private var _lastUpClickTime:int = 0;
      
      private var _isPlayingFloatCartoon:Boolean;
      
      protected var _toLinkTxt:FilterFrameText;
      
      public function HorseFrameRightBottomView(){super();}
      
      private function guideHandler() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function refreshFreeTipTxt(param1:Event = null) : void{}
      
      private function upSuccessHandler(param1:Event) : void{}
      
      private function judgeLevelUpBtn() : void{}
      
      private function playCompleteHandler(param1:Event) : void{}
      
      private function levelUpHandler(param1:MouseEvent) : void{}
      
      private function buyConfirm(param1:FrameEvent) : void{}
      
      private function __toLinkTxtHandler(param1:TextEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
