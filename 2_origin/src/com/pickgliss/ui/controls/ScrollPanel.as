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
      
      public function ScrollPanel(creatDefauleViewport:Boolean = true)
      {
         super();
         if(creatDefauleViewport)
         {
            _viewSource = new DisplayObjectViewport();
            _viewSource.addStateListener(__onViewportStateChanged);
         }
      }
      
      public function set backgound(back:DisplayObject) : void
      {
         if(_backgound == back)
         {
            return;
         }
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = back;
         onPropertiesChanged("backgound");
      }
      
      public function set backgoundInnerRectString(value:String) : void
      {
         if(_backgoundInnerRectString == value)
         {
            return;
         }
         _backgoundInnerRectString = value;
         _backgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_backgoundInnerRectString));
         onPropertiesChanged("backgoundInnerRect");
      }
      
      public function set backgoundStyle(stylename:String) : void
      {
         if(_backgoundStyle == stylename)
         {
            return;
         }
         _backgoundStyle = stylename;
         backgound = ComponentFactory.Instance.creat(_backgoundStyle);
      }
      
      public function get displayObjectViewport() : DisplayObjectViewport
      {
         return _viewSource as DisplayObjectViewport;
      }
      
      public function set disableMouseWheel(value:Boolean) : void
      {
         if(_isDisableMouseWheel == value)
         {
            return;
         }
         _isDisableMouseWheel = value;
      }
      
      public function get disableMouseWheel() : Boolean
      {
         return _isDisableMouseWheel;
      }
      
      override public function dispose() : void
      {
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = null;
         if(_hScrollbar)
         {
            _hScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_hScrollbar);
         }
         _hScrollbar = null;
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = null;
         if(_viewSource)
         {
            ObjectUtils.disposeObject(_viewSource);
         }
         _viewSource = null;
         removeEventListener("mouseWheel",__onMouseWheel);
         super.dispose();
      }
      
      public function getShowHScrollbarExtendHeight() : Number
      {
         var rect:* = null;
         if(_height == 0 || _hScrollbarInnerRect == null)
         {
            return 0;
         }
         var viewPortRect:Rectangle = _viewportInnerRect.getInnerRect(_width,_height);
         var hbarRect:Rectangle = _hScrollbarInnerRect.getInnerRect(_width,_height);
         rect = viewPortRect.union(hbarRect);
         return viewPortRect.height - rect.height;
      }
      
      public function getVisibleRect() : IntRectangle
      {
         var vStartValue:int = 0;
         var hStartValue:int = 0;
         var vAmount:int = 0;
         var hAmount:int = 0;
         var viewSize:IntDimension = _viewSource.getViewSize();
         if(_hScrollbar == null)
         {
            hStartValue = 0;
            hAmount = viewSize.width;
         }
         else
         {
            hStartValue = _hScrollbar.scrollValue;
            hAmount = _hScrollbar.visibleAmount;
         }
         if(_vScrollbar == null)
         {
            vStartValue = 0;
            vAmount = viewSize.height;
         }
         else
         {
            vStartValue = _vScrollbar.scrollValue;
            vAmount = _vScrollbar.visibleAmount;
         }
         return new IntRectangle(hStartValue,vStartValue,hAmount,vAmount);
      }
      
      public function set hScrollProxy(proxy:int) : void
      {
         if(_hScrollProxy == proxy)
         {
            return;
         }
         _hScrollProxy = proxy;
         onPropertiesChanged("hScrollProxy");
      }
      
      public function get hScrollbar() : Scrollbar
      {
         return _hScrollbar;
      }
      
      public function set hScrollbar(bar:Scrollbar) : void
      {
         if(_hScrollbar == bar)
         {
            return;
         }
         if(_hScrollbar)
         {
            _hScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_hScrollbar);
         }
         _hScrollbar = bar;
         _hScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged("hScrollbar");
      }
      
      public function set hScrollbarInnerRectString(value:String) : void
      {
         if(_hScrollbarInnerRectString == value)
         {
            return;
         }
         _hScrollbarInnerRectString = value;
         _hScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_hScrollbarInnerRectString));
         onPropertiesChanged("hScrollbarInnerRect");
      }
      
      public function set hScrollbarStyle(stylename:String) : void
      {
         if(_hScrollbarStyle == stylename)
         {
            return;
         }
         _hScrollbarStyle = stylename;
         hScrollbar = ComponentFactory.Instance.creat(_hScrollbarStyle);
      }
      
      public function set hUnitIncrement(unitIncrement:int) : void
      {
         _viewSource.horizontalUnitIncrement = unitIncrement;
      }
      
      public function invalidateViewport(toBottom:Boolean = false) : void
      {
         var max:int = 0;
         var pt:* = null;
         if(_viewSource is DisplayObjectViewport)
         {
            if(toBottom)
            {
               displayObjectViewport.invalidateView();
               max = viewPort.getViewSize().height;
               pt = new IntPoint(0,max);
               viewPort.viewPosition = pt;
            }
            else
            {
               displayObjectViewport.invalidateView();
            }
         }
         else
         {
            trace("不允许对其他类型的viewport进行此操作");
         }
      }
      
      public function invalidateViewport_toTop(toTop:Boolean = false) : void
      {
         var max:int = 0;
         var pt:* = null;
         if(_viewSource is DisplayObjectViewport)
         {
            if(toTop)
            {
               displayObjectViewport.invalidateView();
               max = viewPort.getViewSize().height;
               pt = new IntPoint(0,0);
               viewPort.viewPosition = pt;
            }
            else
            {
               displayObjectViewport.invalidateView();
            }
         }
         else
         {
            trace("不允许对其他类型的viewport进行此操作");
         }
      }
      
      public function setView(view:DisplayObject) : void
      {
         if(_viewSource is DisplayObjectViewport)
         {
            displayObjectViewport.setView(view);
         }
         else
         {
            trace("不允许对其他类型的viewport进行此操作");
         }
      }
      
      public function set vScrollProxy(proxy:int) : void
      {
         if(_vScrollProxy == proxy)
         {
            return;
         }
         _vScrollProxy = proxy;
         onPropertiesChanged("vScrollProxy");
      }
      
      public function get vScrollbar() : Scrollbar
      {
         return _vScrollbar;
      }
      
      public function set vScrollbar(bar:Scrollbar) : void
      {
         if(_vScrollbar == bar)
         {
            return;
         }
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = bar;
         _vScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged("vScrollbar");
      }
      
      public function set vScrollbarInnerRectString(value:String) : void
      {
         if(_vScrollbarInnerRectString == value)
         {
            return;
         }
         _vScrollbarInnerRectString = value;
         _vScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_vScrollbarInnerRectString));
         onPropertiesChanged("vScrollbarInnerRect");
      }
      
      public function set vScrollbarStyle(stylename:String) : void
      {
         if(_vScrollbarStyle == stylename)
         {
            return;
         }
         _vScrollbarStyle = stylename;
         vScrollbar = ComponentFactory.Instance.creat(_vScrollbarStyle);
      }
      
      public function set vUnitIncrement(unitIncrement:int) : void
      {
         _viewSource.verticalUnitIncrement = unitIncrement;
      }
      
      public function get viewPort() : IViewprot
      {
         return _viewSource;
      }
      
      public function set viewPort(v:IViewprot) : void
      {
         if(_viewSource == v)
         {
            return;
         }
         if(_viewSource)
         {
            _viewSource.removeStateListener(__onViewportStateChanged);
            ObjectUtils.disposeObject(_viewSource);
         }
         _viewSource = v;
         _viewSource.addStateListener(__onViewportStateChanged);
         onPropertiesChanged("viewSource");
      }
      
      public function set viewportInnerRectString(value:String) : void
      {
         if(_viewportInnerRectString == value)
         {
            return;
         }
         _viewportInnerRectString = value;
         _viewportInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_viewportInnerRectString));
         onPropertiesChanged("viewportInnerRect");
      }
      
      protected function __onMouseWheel(event:MouseEvent) : void
      {
         var viewPos:* = null;
         if(!_isDisableMouseWheel)
         {
            viewPos = _viewSource.viewPosition.clone();
            viewPos.y = viewPos.y - event.delta * _viewSource.verticalUnitIncrement;
            _viewSource.viewPosition = viewPos;
            event.stopImmediatePropagation();
         }
      }
      
      public function setViewPosition(offset:int) : void
      {
         var viewPos:IntPoint = _viewSource.viewPosition.clone();
         viewPos.y = viewPos.y + offset * _viewSource.verticalUnitIncrement;
         _viewSource.viewPosition = viewPos;
      }
      
      protected function __onScrollValueChange(event:InteractiveEvent) : void
      {
         viewPort.scrollRectToVisible(getVisibleRect());
      }
      
      protected function __onViewportStateChanged(event:InteractiveEvent) : void
      {
         syncScrollPaneWithViewport();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_backgound)
         {
            addChild(_backgound);
         }
         if(_viewSource)
         {
            addChild(_viewSource.asDisplayObject());
         }
         if(_vScrollbar)
         {
            addChild(_vScrollbar);
         }
         if(_hScrollbar)
         {
            addChild(_hScrollbar);
         }
      }
      
      override protected function init() : void
      {
         initEvent();
         super.init();
      }
      
      protected function initEvent() : void
      {
         addEventListener("mouseWheel",__onMouseWheel);
      }
      
      protected function layoutComponent() : void
      {
         if(_vScrollbar)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_vScrollbar,_vScrollbarInnerRect,_width,_height);
         }
         if(_hScrollbar)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_hScrollbar,_hScrollbarInnerRect,_width,_height);
         }
         if(_backgound)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_backgound,_backgoundInnerRect,_width,_height);
         }
         if(_viewSource)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_viewSource.asDisplayObject(),_viewportInnerRect,_width,_height);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["vScrollbarInnerRect"] || _changedPropeties["hScrollbarInnerRect"] || _changedPropeties["vScrollbar"] || _changedPropeties["hScrollbar"] || _changedPropeties["viewportInnerRect"] || _changedPropeties["viewSource"])
         {
            layoutComponent();
         }
         if(_changedPropeties["viewSource"])
         {
            syncScrollPaneWithViewport();
         }
         if(_changedPropeties["vScrollProxy"] || _changedPropeties["hScrollProxy"])
         {
            if(_vScrollbar)
            {
               _vScrollbar.visible = _vScrollProxy == 0;
            }
            if(_hScrollbar)
            {
               _hScrollbar.visible = _hScrollProxy == 0;
            }
         }
      }
      
      protected function syncScrollPaneWithViewport() : void
      {
         var extentSize:* = null;
         var viewSize:* = null;
         var viewPosition:* = null;
         var max:int = 0;
         var value:int = 0;
         var extent:int = 0;
         if(_viewSource != null)
         {
            extentSize = _viewSource.getExtentSize();
            if(extentSize.width <= 0 || extentSize.height <= 0)
            {
               return;
            }
            viewSize = _viewSource.getViewSize();
            viewPosition = _viewSource.viewPosition;
            if(_vScrollbar != null)
            {
               extent = extentSize.height;
               max = viewSize.height;
               value = Math.max(0,Math.min(viewPosition.y,max - extent));
               _vScrollbar.unitIncrement = _viewSource.verticalUnitIncrement;
               _vScrollbar.blockIncrement = _viewSource.verticalBlockIncrement;
               _vScrollbar.getModel().setRangeProperties(value,extent,0,max,false);
            }
            if(_hScrollbar != null)
            {
               extent = extentSize.width;
               max = viewSize.width;
               value = Math.max(0,Math.min(viewPosition.x,max - extent));
               _hScrollbar.unitIncrement = _viewSource.horizontalUnitIncrement;
               _hScrollbar.blockIncrement = _viewSource.horizontalBlockIncrement;
               _hScrollbar.getModel().setRangeProperties(value,extent,0,max,false);
            }
            updateAutoHiddenScroll();
         }
      }
      
      private function updateAutoHiddenScroll() : void
      {
         var rect:* = null;
         var viewPortRect:* = null;
         var vbarRect:* = null;
         var hbarRect:* = null;
         if(_vScrollbar == null && _hScrollbar == null)
         {
            return;
         }
         if(_vScrollbar != null)
         {
            if(_vScrollProxy == 1)
            {
               _vScrollbar.visible = _vScrollbar.getThumbVisible();
            }
            if(_vScrollProxy == 1 && _vScrollbar.maximum == 0)
            {
               _vScrollbar.visible = false;
            }
         }
         if(_hScrollbar)
         {
            if(_hScrollProxy == 1)
            {
               _hScrollbar.visible = _hScrollbar.getThumbVisible();
            }
            if(_hScrollProxy == 1 && _hScrollbar.maximum == 0)
            {
               _hScrollbar.visible = false;
            }
         }
         if(_vScrollProxy == 1 || _hScrollProxy == 1)
         {
            viewPortRect = _viewportInnerRect.getInnerRect(_width,_height);
            if(_vScrollbarInnerRect)
            {
               vbarRect = _vScrollbarInnerRect.getInnerRect(_width,_height);
            }
            if(_hScrollbarInnerRect)
            {
               hbarRect = _hScrollbarInnerRect.getInnerRect(_width,_height);
            }
            if(_vScrollbar != null)
            {
               if(!_vScrollbar.getThumbVisible() || _vScrollbar.visible == false)
               {
                  rect = viewPortRect.union(vbarRect);
               }
            }
            if(_hScrollbar != null)
            {
               if(!_hScrollbar.getThumbVisible() || _hScrollbar.visible == false)
               {
                  if(rect)
                  {
                     rect = rect.union(hbarRect);
                  }
                  else
                  {
                     rect = viewPortRect.union(hbarRect);
                  }
               }
            }
            if(rect == null)
            {
               rect = viewPortRect;
            }
            _viewSource.x = rect.x;
            _viewSource.y = rect.y;
            _viewSource.width = rect.width;
            _viewSource.height = rect.height;
         }
      }
   }
}
