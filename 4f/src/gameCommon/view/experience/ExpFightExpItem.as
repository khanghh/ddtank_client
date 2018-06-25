package gameCommon.view.experience{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import gameCommon.GameControl;      public class ExpFightExpItem extends Sprite implements Disposeable   {                   protected var _bg:Bitmap;            protected var _titleBitmap:Bitmap;            protected var _itemType:String;            protected var _typeTxts:Vector.<ExpTypeTxt>;            protected var _numTxt:ExpCountingTxt;            protected var _step:int;            protected var _value:Number;            protected var _valueArr:Array;            public function ExpFightExpItem(arr:Array) { super(); }
            protected function init() : void { }
            public function createView() : void { }
            protected function createNumTxt() : void { }
            private function __updateText(event:Event = null) : void { }
            protected function __onTextChange(event:Event) : void { }
            public function get targetValue() : Number { return 0; }
            public function dispose() : void { }
   }}