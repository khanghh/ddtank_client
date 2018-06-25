package com.pickgliss.ui.core{   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.utils.ObjectUtils;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.geom.Point;   import flash.utils.Dictionary;      [Event(name="propertiesChanged",type="com.pickgliss.events.ComponentEvent")]   [Event(name="dispose",type="com.pickgliss.events.ComponentEvent")]   public class Component extends Sprite implements Disposeable, ITipedDisplay   {            public static const P_height:String = "height";            public static const P_tipData:String = "tipData";            public static const P_tipDirction:String = "tipDirction";            public static const P_tipGap:String = "tipGap";            public static const P_tipStyle:String = "tipStyle";            public static const P_width:String = "width";                   protected var _bitmapdata:BitmapData;            protected var _changeCount:int = 0;            protected var _changedPropeties:Dictionary;            protected var _height:Number = 0;            protected var _id:int = -1;            protected var _tipData:Object;            protected var _tipDirction:String;            protected var _tipGapV:int;            protected var _tipGapH:int;            protected var _tipStyle:String;            protected var _width:Number = 0;            public var stylename:String;            public function Component() { super(); }
            public function asDisplayObject() : DisplayObject { return null; }
            public function beginChanges() : void { }
            public function commitChanges() : void { }
            public function getMousePosition() : Point { return null; }
            public function dispose() : void { }
            public function draw() : void { }
            public function getBitmapdata(reflesh:Boolean = false) : BitmapData { return null; }
            override public function get height() : Number { return 0; }
            override public function set height(h:Number) : void { }
            public function get id() : int { return 0; }
            public function set id(value:int) : void { }
            public function move(xpos:Number, ypos:Number) : void { }
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
            override public function get width() : Number { return 0; }
            override public function set width(w:Number) : void { }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            protected function addChildren() : void { }
            protected function init() : void { }
            protected function invalidate() : void { }
            protected function onPropertiesChanged(propName:String = null) : void { }
            protected function onProppertiesUpdate() : void { }
            public function get displayWidth() : Number { return 0; }
            public function get displayHeight() : Number { return 0; }
            protected function onPosChanged() : void { }
   }}