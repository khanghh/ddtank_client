package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ScrollPanel extends Component
   {
      
      public static const AUTO:int = 1;
      
      public static const OFF:int = 2;
      
      public static const ON:int = 0;
      
      public static const P_backgound:String = "backgound";
      
      public static const P_backgoundInnerRect:String = "backgoundInnerRect";
      
      public static const P_hScrollProxy:String = "hScrollProxy";
      
      public static const P_hScrollbar:String = "hScrollbar";
      
      public static const P_hScrollbarInnerRect:String = "hScrollbarInnerRect";
      
      public static const P_vScrollProxy:String = "vScrollProxy";
      
      public static const P_vScrollbar:String = "vScrollbar";
      
      public static const P_vScrollbarInnerRect:String = "vScrollbarInnerRect";
      
      public static const P_viewSource:String = "viewSource";
      
      public static const P_viewportInnerRect:String = "viewportInnerRect";
       
      
      protected var _backgound:DisplayObject;
      
      protected var _backgoundInnerRect:InnerRectangle;
      
      protected var _backgoundInnerRectString:String;
      
      protected var _backgoundStyle:String;
      
      protected var _hScrollProxy:int;
      
      protected var _hScrollbar:Scrollbar;
      
      protected var _hScrollbarInnerRect:InnerRectangle;
      
      protected var _hScrollbarInnerRectString:String;
      
      protected var _hScrollbarStyle:String;
      
      protected var _vScrollProxy:int;
      
      protected var _vScrollbar:Scrollbar;
      
      protected var _vScrollbarInnerRect:InnerRectangle;
      
      protected var _vScrollbarInnerRectString:String;
      
      protected var _vScrollbarStyle:String;
      
      protected var _viewSource:IViewprot;
      
      protected var _viewportInnerRect:InnerRectangle;
      
      protected var _viewportInnerRectString:String;
      
      protected var _isDisableMouseWheel:Boolean = false;
      
      public function ScrollPanel(param1:Boolean = true){super();}
      
      public function set backgound(param1:DisplayObject) : void{}
      
      public function set backgoundInnerRectString(param1:String) : void{}
      
      public function set backgoundStyle(param1:String) : void{}
      
      public function get displayObjectViewport() : DisplayObjectViewport{return null;}
      
      public function set disableMouseWheel(param1:Boolean) : void{}
      
      public function get disableMouseWheel() : Boolean{return false;}
      
      override public function dispose() : void{}
      
      public function getShowHScrollbarExtendHeight() : Number{return 0;}
      
      public function getVisibleRect() : IntRectangle{return null;}
      
      public function set hScrollProxy(param1:int) : void{}
      
      public function get hScrollbar() : Scrollbar{return null;}
      
      public function set hScrollbar(param1:Scrollbar) : void{}
      
      public function set hScrollbarInnerRectString(param1:String) : void{}
      
      public function set hScrollbarStyle(param1:String) : void{}
      
      public function set hUnitIncrement(param1:int) : void{}
      
      public function invalidateViewport(param1:Boolean = false) : void{}
      
      public function invalidateViewport_toTop(param1:Boolean = false) : void{}
      
      public function setView(param1:DisplayObject) : void{}
      
      public function set vScrollProxy(param1:int) : void{}
      
      public function get vScrollbar() : Scrollbar{return null;}
      
      public function set vScrollbar(param1:Scrollbar) : void{}
      
      public function set vScrollbarInnerRectString(param1:String) : void{}
      
      public function set vScrollbarStyle(param1:String) : void{}
      
      public function set vUnitIncrement(param1:int) : void{}
      
      public function get viewPort() : IViewprot{return null;}
      
      public function set viewPort(param1:IViewprot) : void{}
      
      public function set viewportInnerRectString(param1:String) : void{}
      
      protected function __onMouseWheel(param1:MouseEvent) : void{}
      
      public function setViewPosition(param1:int) : void{}
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void{}
      
      protected function __onViewportStateChanged(param1:InteractiveEvent) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function init() : void{}
      
      protected function initEvent() : void{}
      
      protected function layoutComponent() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function syncScrollPaneWithViewport() : void{}
      
      private function updateAutoHiddenScroll() : void{}
   }
}
