package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddQiYuan.DDQiYuanManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.getTimer;      public class DDQiYuanIcon extends Sprite implements Disposeable   {                   private var _activityIcon:MovieClip;            private var _lastClickTime:int = 0;            public function DDQiYuanIcon() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function showDDQiYuanFrame(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}