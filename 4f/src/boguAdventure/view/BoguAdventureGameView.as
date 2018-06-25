package boguAdventure.view{   import baglocked.BaglockedManager;   import boguAdventure.BoguAdventureControl;   import boguAdventure.cell.BoguAdventureCell;   import boguAdventure.event.BoguAdventureEvent;   import boguAdventure.model.BoguAdventureCellInfo;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.ui.Mouse;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;      public class BoguAdventureGameView extends Sprite   {                   private var _reviveBtn:SimpleBitmapButton;            private var _awardBtn:SimpleBitmapButton;            private var _arardBtnEffect:IEffect;            private var _resetBtn:SimpleBitmapButton;            private var _freeResetBtn:SimpleBitmapButton;            private var _signBtn:SimpleBitmapButton;            private var _findMineBtn:SimpleBitmapButton;            private var _helpView:BoguAdventureHelpFrame;            private var _mouseStyle:Bitmap;            private var _control:BoguAdventureControl;            private var _map:BoguAdventureMap;            private var _changeView:BoguAdventureChangeView;            private var _hpBox:HBox;            private var _openCountBg:Bitmap;            private var _openCountText:FilterFrameText;            private var _limitResetText:FilterFrameText;            private var _resetNumText:FilterFrameText;            public function BoguAdventureGameView(control:BoguAdventureControl) { super(); }
            private function init() : void { }
            public function updateView() : void { }
            private function __onAllEvent(e:BoguAdventureEvent) : void { }
            private function updateCell(index:int, type:int, result:int, playAction:Boolean = false) : void { }
            private function openCell(cell:BoguAdventureCell, playAction:Boolean) : void { }
            private function updateMap() : void { }
            private function updateReset() : void { }
            private function __onReviveClick(e:MouseEvent) : void { }
            private function __onReviveAffirmRevive(e:FrameEvent) : void { }
            protected function onCheckReviveComplete() : void { }
            private function __onAwardClick(e:MouseEvent) : void { }
            private function __onResetClick(e:MouseEvent) : void { }
            private function __onResetTip(e:FrameEvent) : void { }
            private function __onResetAffirmRevive(e:FrameEvent) : void { }
            protected function onCheckResetComplete() : void { }
            private function __onFindMineClick(e:MouseEvent) : void { }
            private function __onFindAffirmRevive(e:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            private function __onSignClick(e:MouseEvent) : void { }
            private function __onKeyDown(e:KeyboardEvent) : void { }
            private function __onStageClick(e:MouseEvent) : void { }
            private function changeMouseStyle(value:Boolean) : void { }
            private function signCell(value:BoguAdventureCell) : void { }
            private function updateHp() : void { }
            private function playActionComplete(data:Object) : void { }
            private function updateOpenCount() : void { }
            private function createEffect() : void { }
            private function clearEffect() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}