package boguAdventure.view
{
   import baglocked.BaglockedManager;
   import boguAdventure.BoguAdventureControl;
   import boguAdventure.cell.BoguAdventureCell;
   import boguAdventure.event.BoguAdventureEvent;
   import boguAdventure.model.BoguAdventureCellInfo;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class BoguAdventureGameView extends Sprite
   {
       
      
      private var _reviveBtn:SimpleBitmapButton;
      
      private var _awardBtn:SimpleBitmapButton;
      
      private var _arardBtnEffect:IEffect;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _freeResetBtn:SimpleBitmapButton;
      
      private var _signBtn:SimpleBitmapButton;
      
      private var _findMineBtn:SimpleBitmapButton;
      
      private var _helpView:BoguAdventureHelpFrame;
      
      private var _mouseStyle:Bitmap;
      
      private var _control:BoguAdventureControl;
      
      private var _map:BoguAdventureMap;
      
      private var _changeView:BoguAdventureChangeView;
      
      private var _hpBox:HBox;
      
      private var _openCountBg:Bitmap;
      
      private var _openCountText:FilterFrameText;
      
      private var _limitResetText:FilterFrameText;
      
      private var _resetNumText:FilterFrameText;
      
      public function BoguAdventureGameView(param1:BoguAdventureControl){super();}
      
      private function init() : void{}
      
      public function updateView() : void{}
      
      private function __onAllEvent(param1:BoguAdventureEvent) : void{}
      
      private function updateCell(param1:int, param2:int, param3:int, param4:Boolean = false) : void{}
      
      private function openCell(param1:BoguAdventureCell, param2:Boolean) : void{}
      
      private function updateMap() : void{}
      
      private function updateReset() : void{}
      
      private function __onReviveClick(param1:MouseEvent) : void{}
      
      private function __onReviveAffirmRevive(param1:FrameEvent) : void{}
      
      protected function onCheckReviveComplete() : void{}
      
      private function __onAwardClick(param1:MouseEvent) : void{}
      
      private function __onResetClick(param1:MouseEvent) : void{}
      
      private function __onResetTip(param1:FrameEvent) : void{}
      
      private function __onResetAffirmRevive(param1:FrameEvent) : void{}
      
      protected function onCheckResetComplete() : void{}
      
      private function __onFindMineClick(param1:MouseEvent) : void{}
      
      private function __onFindAffirmRevive(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __onSignClick(param1:MouseEvent) : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      private function __onStageClick(param1:MouseEvent) : void{}
      
      private function changeMouseStyle(param1:Boolean) : void{}
      
      private function signCell(param1:BoguAdventureCell) : void{}
      
      private function updateHp() : void{}
      
      private function playActionComplete(param1:Object) : void{}
      
      private function updateOpenCount() : void{}
      
      private function createEffect() : void{}
      
      private function clearEffect() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
