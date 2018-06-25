package dice.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import dice.controller.DiceController;   import dice.event.DiceEvent;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;      public class DiceStartView extends Sprite implements Disposeable   {                   private var _type:int;            private var _result:int;            private var _leftArr:Array;            private var _rightArr:Array;            private var _rule:Array;            private var _left:int;            private var _right:int;            public function DiceStartView() { super(); }
            public function play(type:int, result:int) : void { }
            private function __onEnterFrame(event:Event) : void { }
            public function removeAllMovie() : void { }
            private function preInitialize() : void { }
            public function dispose() : void { }
   }}