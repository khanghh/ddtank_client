package giftSystem.element{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ChooseNum extends Sprite implements Disposeable   {            public static const NUMBER_IS_CHANGE:String = "numberIsChange";                   private var _leftBtn:BaseButton;            private var _rightBtn:BaseButton;            private var _numShow:TextInput;            private var _number:int;            public function ChooseNum() { super(); }
            public function set number(value:int) : void { }
            public function get number() : int { return 0; }
            private function initView() : void { }
            private function drawSprit() : Sprite { return null; }
            private function initEvent() : void { }
            private function __rightClick(event:MouseEvent) : void { }
            private function __leftClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            protected function __numberChange(event:Event) : void { }
   }}