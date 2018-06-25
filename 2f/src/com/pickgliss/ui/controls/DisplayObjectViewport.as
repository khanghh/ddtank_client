package com.pickgliss.ui.controls{   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.geom.IntDimension;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.geom.IntRectangle;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.IViewprot;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Shape;      public class DisplayObjectViewport extends Component implements IViewprot   {            public static const P_horizontalBlockIncrement:String = "horizontalBlockIncrement";            public static const P_horizontalUnitIncrement:String = "horizontalUnitIncrement";            public static const P_verticalBlockIncrement:String = "verticalBlockIncrement";            public static const P_verticalUnitIncrement:String = "verticalUnitIncrement";            public static const P_view:String = "view";            public static const P_viewPosition:String = "viewPosition";                   protected var _horizontalBlockIncrement:int;            protected var _horizontalUnitIncrement:int;            protected var _maskShape:Shape;            protected var _mouseActiveObjectShape:Shape;            protected var _verticalBlockIncrement:int;            protected var _verticalUnitIncrement:int;            protected var _viewHeight:int;            protected var _viewPosition:IntPoint;            protected var _viewWidth:int;            private var _view:DisplayObject;            public function DisplayObjectViewport() { super(); }
            public function addStateListener(listener:Function, priority:int = 0, useWeakReference:Boolean = false) : void { }
            override public function dispose() : void { }
            public function getExtentSize() : IntDimension { return null; }
            public function getViewSize() : IntDimension { return null; }
            public function getViewportPane() : Component { return null; }
            public function get horizontalBlockIncrement() : int { return 0; }
            public function set horizontalBlockIncrement(increment:int) : void { }
            public function get horizontalUnitIncrement() : int { return 0; }
            public function set horizontalUnitIncrement(increment:int) : void { }
            public function removeStateListener(listener:Function) : void { }
            public function scrollRectToVisible(contentRect:IntRectangle) : void { }
            public function setView(view:DisplayObject) : void { }
            public function setViewportTestSize(s:IntDimension) : void { }
            public function get verticalBlockIncrement() : int { return 0; }
            public function set verticalBlockIncrement(increment:int) : void { }
            public function get verticalUnitIncrement() : int { return 0; }
            public function set verticalUnitIncrement(increment:int) : void { }
            public function get viewPosition() : IntPoint { return null; }
            public function set viewPosition(p:IntPoint) : void { }
            public function invalidateView() : void { }
            override protected function addChildren() : void { }
            protected function creatMaskShape() : void { }
            protected function fireStateChanged(programmatic:Boolean = true) : void { }
            protected function getViewMaxPos() : IntPoint { return null; }
            override protected function init() : void { }
            override protected function onProppertiesUpdate() : void { }
            protected function restrictionViewPos(p:IntPoint) : IntPoint { return null; }
            protected function updatePos() : void { }
            protected function updateShowMask() : void { }
            private function __onResize(event:ComponentEvent) : void { }
   }}