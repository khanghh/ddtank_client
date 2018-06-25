package morn.core.components{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.tip.ITip;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import morn.core.events.UIEvent;   import morn.core.handlers.Handler;   import morn.core.utils.ObjectUtils;   import morn.editor.core.IComponent;      [Event(name="resize",type="flash.events.Event")]   [Event(name="move",type="morn.core.events.UIEvent")]   [Event(name="showTip",type="morn.core.events.UIEvent")]   [Event(name="hideTip",type="morn.core.events.UIEvent")]   public class Component extends Sprite implements IComponent, Disposeable, ITipedDisplay, ITip   {            public static const P_height:String = "height";            public static const P_tipData:String = "tipData";            public static const P_tipDirction:String = "tipDirction";            public static const P_tipGap:String = "tipGap";            public static const P_tipStyle:String = "tipStyle";            public static const P_width:String = "width";                   protected var _width:Number;            protected var _height:Number;            protected var _contentWidth:Number = 0;            protected var _contentHeight:Number = 0;            protected var _disabled:Boolean;            protected var _tag:Object;            protected var _comXml:XML;            protected var _comJSON:Object;            protected var _dataSource:Object;            protected var _toolTip:Object;            protected var _mouseChildren:Boolean;            protected var _top:Number;            protected var _bottom:Number;            protected var _left:Number;            protected var _right:Number;            protected var _centerX:Number;            protected var _centerY:Number;            protected var _layOutEabled:Boolean;            protected var _tipWidth:int;            protected var _tipHeight:int;            protected var _disposeHandler:Handler;            protected var _stylename:String;            protected var _changeCount:int = 0;            protected var _tipData:Object;            protected var _tipDirctions:String = "4,5,6,7,0,1,2,3";            protected var _tipGapV:int;            protected var _tipGapH:int;            protected var _tipStyle:String;            protected var _changedPropeties:Dictionary;            public function Component() { super(); }
            public function get stylename() : String { return null; }
            public function set stylename(value:String) : void { }
            protected function preinitialize() : void { }
            protected function createChildren() : void { }
            protected function initialize() : void { }
            public function callLater(method:Function, args:Array = null) : void { }
            public function exeCallLater(method:Function) : void { }
            public function sendEvent(type:String, data:* = null) : void { }
            public function remove() : void { }
            public function removeChildByName(name:String) : void { }
            public function setPosition(x:Number, y:Number) : void { }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            override public function get width() : Number { return 0; }
            public function get displayWidth() : Number { return 0; }
            protected function get measureWidth() : Number { return 0; }
            override public function set width(value:Number) : void { }
            override public function get height() : Number { return 0; }
            public function get displayHeight() : Number { return 0; }
            protected function get measureHeight() : Number { return 0; }
            override public function set height(value:Number) : void { }
            override public function get x() : Number { return 0; }
            override public function get y() : Number { return 0; }
            override public function set scaleX(value:Number) : void { }
            override public function set scaleY(value:Number) : void { }
            public function commitMeasure() : void { }
            protected function changeSize() : void { }
            public function setSize(width:Number, height:Number) : void { }
            public function set scale(value:Number) : void { }
            public function get scale() : Number { return 0; }
            public function get disabled() : Boolean { return false; }
            public function set disabled(value:Boolean) : void { }
            override public function set mouseChildren(value:Boolean) : void { }
            public function get tag() : Object { return null; }
            public function set tag(value:Object) : void { }
            public function showBorder(color:uint = 16711680) : void { }
            public function get comXml() : XML { return null; }
            public function set comXml(value:XML) : void { }
            public function get comJSON() : Object { return null; }
            public function set comJSON(value:Object) : void { }
            public function get dataSource() : Object { return null; }
            public function set dataSource(value:Object) : void { }
            public function get toolTip() : Object { return null; }
            public function set toolTip(value:Object) : void { }
            private function onRollMouse(e:MouseEvent) : void { }
            public function get top() : Number { return 0; }
            public function set top(value:Number) : void { }
            public function get bottom() : Number { return 0; }
            public function set bottom(value:Number) : void { }
            public function get left() : Number { return 0; }
            public function set left(value:Number) : void { }
            public function get right() : Number { return 0; }
            public function set right(value:Number) : void { }
            public function get centerX() : Number { return 0; }
            public function set centerX(value:Number) : void { }
            public function get centerY() : Number { return 0; }
            public function set centerY(value:Number) : void { }
            private function set layOutEabled(value:Boolean) : void { }
            private function onRemoved(e:Event) : void { }
            private function onAdded(e:Event) : void { }
            private function onResize(e:Event) : void { }
            protected function resetPosition() : void { }
            override public function set doubleClickEnabled(value:Boolean) : void { }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            override public function addChildAt(child:DisplayObject, index:int) : DisplayObject { return null; }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            protected function onPropertiesChanged(propName:String = null) : void { }
            protected function invalidate() : void { }
            public function draw() : void { }
            protected function onProppertiesUpdate() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            protected function updateTransform() : void { }
            public function get disposeHandler() : Handler { return null; }
            public function set disposeHandler(value:Handler) : void { }
            public function dispose() : void { }
   }}