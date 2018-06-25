package consortion.view.guard{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import consortion.guard.ConsortiaGuardControl;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import starling.display.player.FightPlayerVo;      public class ConsortiaGuardReviveView extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _promptlyRevive:SimpleBitmapButton;            private var _timeCD:MovieClip;            private var _totalCount:int;            private var _timer:Timer;            private var _fightPlayerVo:FightPlayerVo;            private var _alertFrame:BaseAlerFrame;            public function ConsortiaGuardReviveView() { super(); }
            private function initView() : void { }
            public function show(vo:FightPlayerVo) : void { }
            private function __onTimer(e:TimerEvent) : void { }
            private function revive(value:Boolean) : void { }
            private function updateTime(surplus:Number) : void { }
            private function setFormat(value:int) : String { return null; }
            private function __onReviveClick(e:MouseEvent) : void { }
            protected function __onSelectCheckClick(e:MouseEvent) : void { }
            private function __onAlertFrame(e:FrameEvent) : void { }
            private function disposeFrame() : void { }
            public function dispose() : void { }
   }}