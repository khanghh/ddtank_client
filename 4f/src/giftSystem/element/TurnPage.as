package giftSystem.element{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class TurnPage extends Sprite implements Disposeable   {            public static const CURRENTPAGE_CHANGE:String = "currentPageChange";                   private var _numShow:FilterFrameText;            private var _leftBtn:BaseButton;            private var _rightBtn:BaseButton;            private var _firstBtn:BaseButton;            private var _endBtn:BaseButton;            private var _numBG:Scale9CornerImage;            private var _current:int;            private var _total:int;            public function TurnPage() { super(); }
            public function set current(value:int) : void { }
            public function get current() : int { return 0; }
            public function set total(value:int) : void { }
            public function get total() : int { return 0; }
            private function initView() : void { }
            private function drawSprit() : Sprite { return null; }
            private function initEvent() : void { }
            private function __rightClick(event:MouseEvent) : void { }
            private function __endClick(evnet:MouseEvent) : void { }
            private function __leftClick(event:MouseEvent) : void { }
            private function __firtClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}