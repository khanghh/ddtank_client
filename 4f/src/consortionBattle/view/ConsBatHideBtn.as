package consortionBattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.setTimeout;      public class ConsBatHideBtn extends Sprite implements Disposeable   {                   private var _btn:SimpleBitmapButton;            private var _tip:ConsBatHideTip;            private var _isOverTip:Boolean = false;            private var _isOverBtn:Boolean = false;            public function ConsBatHideBtn() { super(); }
            private function initView() : void { }
            private function refreshBtnStatus() : void { }
            private function selectedChangeHandler(event:Event) : void { }
            private function initEvent() : void { }
            private function clickHandler(event:MouseEvent) : void { }
            private function overHandler(event:MouseEvent) : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function delayRemoveTip() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}