package com.pickgliss.ui.controls{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.geom.IntDimension;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.geom.IntRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.IViewprot;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.geom.Rectangle;      public class ScrollPanel extends Component   {            public static const AUTO:int = 1;            public static const OFF:int = 2;            public static const ON:int = 0;            public static const P_backgound:String = "backgound";            public static const P_backgoundInnerRect:String = "backgoundInnerRect";            public static const P_hScrollProxy:String = "hScrollProxy";            public static const P_hScrollbar:String = "hScrollbar";            public static const P_hScrollbarInnerRect:String = "hScrollbarInnerRect";            public static const P_vScrollProxy:String = "vScrollProxy";            public static const P_vScrollbar:String = "vScrollbar";            public static const P_vScrollbarInnerRect:String = "vScrollbarInnerRect";            public static const P_viewSource:String = "viewSource";            public static const P_viewportInnerRect:String = "viewportInnerRect";                   protected var _backgound:DisplayObject;            protected var _backgoundInnerRect:InnerRectangle;            protected var _backgoundInnerRectString:String;            protected var _backgoundStyle:String;            protected var _hScrollProxy:int;            protected var _hScrollbar:Scrollbar;            protected var _hScrollbarInnerRect:InnerRectangle;            protected var _hScrollbarInnerRectString:String;            protected var _hScrollbarStyle:String;            protected var _vScrollProxy:int;            protected var _vScrollbar:Scrollbar;            protected var _vScrollbarInnerRect:InnerRectangle;            protected var _vScrollbarInnerRectString:String;            protected var _vScrollbarStyle:String;            protected var _viewSource:IViewprot;            protected var _viewportInnerRect:InnerRectangle;            protected var _viewportInnerRectString:String;            protected var _isDisableMouseWheel:Boolean = false;            public function ScrollPanel(creatDefauleViewport:Boolean = true) { super(); }
            public function set backgound(back:DisplayObject) : void { }
            public function set backgoundInnerRectString(value:String) : void { }
            public function set backgoundStyle(stylename:String) : void { }
            public function get displayObjectViewport() : DisplayObjectViewport { return null; }
            public function set disableMouseWheel(value:Boolean) : void { }
            public function get disableMouseWheel() : Boolean { return false; }
            override public function dispose() : void { }
            public function getShowHScrollbarExtendHeight() : Number { return 0; }
            public function getVisibleRect() : IntRectangle { return null; }
            public function set hScrollProxy(proxy:int) : void { }
            public function get hScrollbar() : Scrollbar { return null; }
            public function set hScrollbar(bar:Scrollbar) : void { }
            public function set hScrollbarInnerRectString(value:String) : void { }
            public function set hScrollbarStyle(stylename:String) : void { }
            public function set hUnitIncrement(unitIncrement:int) : void { }
            public function invalidateViewport(toBottom:Boolean = false) : void { }
            public function invalidateViewport_toTop(toTop:Boolean = false) : void { }
            public function setView(view:DisplayObject) : void { }
            public function set vScrollProxy(proxy:int) : void { }
            public function get vScrollbar() : Scrollbar { return null; }
            public function set vScrollbar(bar:Scrollbar) : void { }
            public function set vScrollbarInnerRectString(value:String) : void { }
            public function set vScrollbarStyle(stylename:String) : void { }
            public function set vUnitIncrement(unitIncrement:int) : void { }
            public function get viewPort() : IViewprot { return null; }
            public function set viewPort(v:IViewprot) : void { }
            public function set viewportInnerRectString(value:String) : void { }
            protected function __onMouseWheel(event:MouseEvent) : void { }
            public function setViewPosition(offset:int) : void { }
            protected function __onScrollValueChange(event:InteractiveEvent) : void { }
            protected function __onViewportStateChanged(event:InteractiveEvent) : void { }
            override protected function addChildren() : void { }
            override protected function init() : void { }
            protected function initEvent() : void { }
            protected function layoutComponent() : void { }
            override protected function onProppertiesUpdate() : void { }
            protected function syncScrollPaneWithViewport() : void { }
            private function updateAutoHiddenScroll() : void { }
   }}