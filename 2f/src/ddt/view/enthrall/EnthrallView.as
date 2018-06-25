package ddt.view.enthrall{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.ScaleFrameImage;   import ddt.manager.EnthrallManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class EnthrallView extends Component   {            public static const HALL_VIEW_STATE:uint = 0;            public static const ROOMLIST_VIEW_STATE:uint = 1;            public static const GAME_VIEW_STATE:uint = 2;                   private var _enthrall:ScaleFrameImage;            private var _enthrallBall:ScaleFrameImage;            private var _info:TimeTip;            private var _approveBtn:SimpleBitmapButton;            private var _manager:EnthrallManager;            public function EnthrallView() { super(); }
            public function set manager(manager:EnthrallManager) : void { }
            private function initUI() : void { }
            private function addEvent() : void { }
            private function popFrame(evt:MouseEvent) : void { }
            public function update() : void { }
            private function __changeHandler(evt:Event) : void { }
            private function __mouseOverHandler(evt:MouseEvent) : void { }
            private function upGameTimeStatus() : void { }
            private function getTimeTxt(time:Number) : String { return null; }
            private function __mouseOutHandler(evt:MouseEvent) : void { }
            private function setViewState(time:Number) : void { }
            public function show(view:EnthrallView) : void { }
            public function changeBtn(showBtn:Boolean) : void { }
            public function changeToGameState(flag:Boolean) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            public function get enthrall() : ScaleFrameImage { return null; }
   }}