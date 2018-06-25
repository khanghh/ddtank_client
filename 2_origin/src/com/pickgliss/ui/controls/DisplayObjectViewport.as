package com.pickgliss.ui.controls
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class DisplayObjectViewport extends Component implements IViewprot
   {
      
      public static const P_horizontalBlockIncrement:String = "horizontalBlockIncrement";
      
      public static const P_horizontalUnitIncrement:String = "horizontalUnitIncrement";
      
      public static const P_verticalBlockIncrement:String = "verticalBlockIncrement";
      
      public static const P_verticalUnitIncrement:String = "verticalUnitIncrement";
      
      public static const P_view:String = "view";
      
      public static const P_viewPosition:String = "viewPosition";
       
      
      protected var _horizontalBlockIncrement:int;
      
      protected var _horizontalUnitIncrement:int;
      
      protected var _maskShape:Shape;
      
      protected var _mouseActiveObjectShape:Shape;
      
      protected var _verticalBlockIncrement:int;
      
      protected var _verticalUnitIncrement:int;
      
      protected var _viewHeight:int;
      
      protected var _viewPosition:IntPoint;
      
      protected var _viewWidth:int;
      
      private var _view:DisplayObject;
      
      public function DisplayObjectViewport()
      {
         _horizontalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
         _horizontalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
         _verticalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
         _verticalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
         super();
      }
      
      public function addStateListener(listener:Function, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         addEventListener("stateChange",listener);
      }
      
      override public function dispose() : void
      {
         if(_view is Component)
         {
            Component(_view).removeEventListener("propertiesChanged",__onResize);
         }
         ObjectUtils.disposeObject(_view);
         _view = null;
         if(_mouseActiveObjectShape)
         {
            ObjectUtils.disposeObject(_mouseActiveObjectShape);
         }
         _mouseActiveObjectShape = null;
         if(_maskShape)
         {
            ObjectUtils.disposeObject(_maskShape);
         }
         _maskShape = null;
         super.dispose();
      }
      
      public function getExtentSize() : IntDimension
      {
         return new IntDimension(_width,_height);
      }
      
      public function getViewSize() : IntDimension
      {
         return new IntDimension(_viewWidth,_viewHeight);
      }
      
      public function getViewportPane() : Component
      {
         return this;
      }
      
      public function get horizontalBlockIncrement() : int
      {
         return _horizontalBlockIncrement;
      }
      
      public function set horizontalBlockIncrement(increment:int) : void
      {
         if(_horizontalBlockIncrement == increment)
         {
            return;
         }
         _horizontalBlockIncrement = increment;
         onPropertiesChanged("horizontalBlockIncrement");
      }
      
      public function get horizontalUnitIncrement() : int
      {
         return _horizontalUnitIncrement;
      }
      
      public function set horizontalUnitIncrement(increment:int) : void
      {
         if(_horizontalUnitIncrement == increment)
         {
            return;
         }
         _horizontalUnitIncrement = increment;
         onPropertiesChanged("horizontalUnitIncrement");
      }
      
      public function removeStateListener(listener:Function) : void
      {
         removeEventListener("stateChange",listener);
      }
      
      public function scrollRectToVisible(contentRect:IntRectangle) : void
      {
         viewPosition = new IntPoint(contentRect.x,contentRect.y);
      }
      
      public function setView(view:DisplayObject) : void
      {
         if(_view == view)
         {
            return;
         }
         if(_view is Component)
         {
            Component(_view).removeEventListener("propertiesChanged",__onResize);
         }
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = view;
         if(_view is Component)
         {
            Component(_view).addEventListener("propertiesChanged",__onResize);
         }
         onPropertiesChanged("view");
      }
      
      public function setViewportTestSize(s:IntDimension) : void
      {
      }
      
      public function get verticalBlockIncrement() : int
      {
         return _verticalBlockIncrement;
      }
      
      public function set verticalBlockIncrement(increment:int) : void
      {
         if(_verticalBlockIncrement == increment)
         {
            return;
         }
         _verticalBlockIncrement = increment;
         onPropertiesChanged("verticalBlockIncrement");
      }
      
      public function get verticalUnitIncrement() : int
      {
         return _verticalUnitIncrement;
      }
      
      public function set verticalUnitIncrement(increment:int) : void
      {
         if(_verticalUnitIncrement == increment)
         {
            return;
         }
         _verticalUnitIncrement = increment;
         onPropertiesChanged("verticalUnitIncrement");
      }
      
      public function get viewPosition() : IntPoint
      {
         return _viewPosition;
      }
      
      public function set viewPosition(p:IntPoint) : void
      {
         if(_viewPosition.equals(p))
         {
            return;
         }
         _viewPosition.setLocation(p);
         onPropertiesChanged("viewPosition");
      }
      
      public function invalidateView() : void
      {
         onPropertiesChanged("view");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_mouseActiveObjectShape);
         addChild(_maskShape);
      }
      
      protected function creatMaskShape() : void
      {
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(16711680,1);
         _maskShape.graphics.drawRect(0,0,100,100);
         _maskShape.graphics.endFill();
         _mouseActiveObjectShape = new Shape();
         _mouseActiveObjectShape.graphics.beginFill(16711680,0);
         _mouseActiveObjectShape.graphics.drawRect(0,0,100,100);
         _mouseActiveObjectShape.graphics.endFill();
      }
      
      protected function fireStateChanged(programmatic:Boolean = true) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function getViewMaxPos() : IntPoint
      {
         var showSize:IntDimension = getExtentSize();
         var viewSize:IntDimension = getViewSize();
         var p:IntPoint = new IntPoint(viewSize.width - showSize.width,viewSize.height - showSize.height);
         if(p.x < 0)
         {
            p.x = 0;
         }
         if(p.y < 0)
         {
            p.y = 0;
         }
         return p;
      }
      
      override protected function init() : void
      {
         creatMaskShape();
         _viewPosition = new IntPoint(0,0);
         super.init();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["height"] || _changedPropeties["width"])
         {
            updateShowMask();
         }
         if(_changedPropeties["view"] || _changedPropeties["viewPosition"])
         {
            _viewWidth = _view.width;
            _viewHeight = _view.height;
            addChild(_view);
            _view.mask = _maskShape;
            updatePos();
            fireStateChanged();
         }
      }
      
      protected function restrictionViewPos(p:IntPoint) : IntPoint
      {
         var maxPos:IntPoint = getViewMaxPos();
         p.x = Math.max(0,Math.min(maxPos.x,p.x));
         p.y = Math.max(0,Math.min(maxPos.y,p.y));
         return p;
      }
      
      protected function updatePos() : void
      {
         restrictionViewPos(_viewPosition);
         _view.x = -_viewPosition.x;
         _view.y = -_viewPosition.y;
      }
      
      protected function updateShowMask() : void
      {
         var _loc1_:* = _width;
         _maskShape.width = _loc1_;
         _mouseActiveObjectShape.width = _loc1_;
         _loc1_ = _height;
         _maskShape.height = _loc1_;
         _mouseActiveObjectShape.height = _loc1_;
      }
      
      private function __onResize(event:ComponentEvent) : void
      {
         if(event.changedProperties["height"] || event.changedProperties["width"])
         {
            onPropertiesChanged("view");
         }
      }
   }
}
