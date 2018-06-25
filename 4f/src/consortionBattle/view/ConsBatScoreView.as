package consortionBattle.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import consortionBattle.event.ConsBatEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.comm.PackageIn;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ConsBatScoreView extends Sprite implements Disposeable   {                   private var _moveOutBtn:SimpleBitmapButton;            private var _moveInBtn:SimpleBitmapButton;            private var _playerBtn:SelectedButton;            private var _consortiaBtn:SelectedButton;            private var _playerBg:Bitmap;            private var _consortiaBg:Bitmap;            private var _btnGroup:SelectedButtonGroup;            private var _list:ListPanel;            private var _selfScoreTxt:FilterFrameText;            private var _consortiaScoreList:Array;            private var _playerScoreList:Array;            private var _timer:TimerJuggler;            public function ConsBatScoreView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function updateScore(event:ConsBatEvent) : void { }
            private function __changeHandler(event:Event) : void { }
            private function timerHandler(event:Event) : void { }
            private function __soundPlay(event:MouseEvent) : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function inHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}