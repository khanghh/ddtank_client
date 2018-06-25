package wonderfulActivity.items{   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import ddt.manager.RouletteManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.views.IRightView;      public class LuckStoneView extends Sprite implements IRightView   {                   private var _btn:SimpleBitmapButton;            private var _back:Bitmap;            private var endData:Date;            private var nowdate:Date;            private var _timerTxt:FilterFrameText;            public function LuckStoneView() { super(); }
            public function setState(type:int, id:int) : void { }
            public function init() : void { }
            private function initTimer() : void { }
            private function stoneTimerHander() : void { }
            protected function mouseClickHander(event:MouseEvent) : void { }
            public function content() : Sprite { return null; }
            public function dispose() : void { }
   }}