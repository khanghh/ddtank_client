package worldboss.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.view.DailyButtunBar;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import worldboss.WorldBossManager;   import worldboss.event.WorldBossRoomEvent;      public class WorldBossHideBtn extends Sprite implements Disposeable   {                   private var _btn:SimpleBitmapButton;            private var _isOverTip:Boolean = false;            private var _isOverBtn:Boolean = false;            private var _isShow:Boolean = true;            public function WorldBossHideBtn() { super(); }
            private function initView() : void { }
            private function refreshBtnStatus() : void { }
            private function selectedChangeHandler(event:Event) : void { }
            private function initEvent() : void { }
            private function clickHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}