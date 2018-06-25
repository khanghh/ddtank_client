package com.pickgliss.ui.controls{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.IOrientable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;      public class Silder extends Component implements IOrientable   {            public static const P_bar:String = "bar";            public static const P_maskShowAreaInnerRect:String = "maskShowAreaInnerRect";            public static const P_maximum:String = "maximum";            public static const P_minimum:String = "minimum";            public static const P_orientation:String = "orientation";            public static const P_progressBar:String = "progressBar";            public static const P_thumb:String = "thumb";            public static const P_thumbShowInnerRect:String = "thumbShowInnerRect";            public static const P_value:String = "value";                   protected var _bar:DisplayObject;            protected var _barStyle:String;            protected var _isDragging:Boolean;            protected var _maskShape:Shape;            protected var _maskShowAreaInnerRect:InnerRectangle;            protected var _maskShowAreaInnerRectString:String;            protected var _model:BoundedRangeModel;            protected var _orientation:int = -1;            protected var _progressBar:DisplayObject;            protected var _progressBarStyle:String;            protected var _thumb:BaseButton;            protected var _thumbDownOffset:int;            protected var _thumbShowInnerRect:InnerRectangle;            protected var _thumbShowInnerRectString:String;            protected var _thumbStyle:String;            protected var _value:Number;            public function Silder() { super(); }
            public function set bar($bar:DisplayObject) : void { }
            public function set barStyle(value:String) : void { }
            override public function dispose() : void { }
            public function getModel() : BoundedRangeModel { return null; }
            public function isVertical() : Boolean { return false; }
            public function set maskShowAreaInnerRectString(value:String) : void { }
            public function get maximum() : int { return 0; }
            public function set maximum(maximum:int) : void { }
            public function get minimum() : int { return 0; }
            public function set minimum(minimum:int) : void { }
            public function get orientation() : int { return 0; }
            public function set orientation(ori:int) : void { }
            public function set progressBar($progressBar:DisplayObject) : void { }
            public function set progressBarStyle(value:String) : void { }
            public function removeStateListener(listener:Function) : void { }
            public function setupModel(model:BoundedRangeModel) : void { }
            public function set thumb($thumb:BaseButton) : void { }
            public function set thumbShowInnerRectString(value:String) : void { }
            public function set thumbStyle(stylename:String) : void { }
            public function get value() : Number { return 0; }
            public function set value($value:Number) : void { }
            protected function __onModelChange(event:InteractiveEvent) : void { }
            protected function __onSilderClick(event:MouseEvent) : void { }
            protected function __onThumbMouseDown(event:MouseEvent) : void { }
            protected function __onThumbMouseMoved(event:MouseEvent) : void { }
            protected function __onThumbMouseUp(event:MouseEvent) : void { }
            override protected function addChildren() : void { }
            override protected function init() : void { }
            override protected function onProppertiesUpdate() : void { }
            protected function scrollThumbToCurrentMousePosition() : void { }
            protected function setupMask() : void { }
            protected function updateMask() : void { }
            protected function updateSize() : void { }
            protected function updateThumbPos() : void { }
            private function calculateValuePercent() : Number { return 0; }
            private function getValueWithThumbMaxMinPos(min:Number, max:Number, pos:Number) : Number { return 0; }
   }}