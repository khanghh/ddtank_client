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
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void
      {
         addEventListener("stateChange",param1);
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
      
      public function set horizontalBlockIncrement(param1:int) : void
      {
         if(_horizontalBlockIncrement == param1)
         {
            return;
         }
         _horizontalBlockIncrement = param1;
         onPropertiesChanged("horizontalBlockIncrement");
      }
      
      public function get horizontalUnitIncrement() : int
      {
         return _horizontalUnitIncrement;
      }
      
      public function set horizontalUnitIncrement(param1:int) : void
      {
         if(_horizontalUnitIncrement == param1)
         {
            return;
         }
         _horizontalUnitIncrement = param1;
         onPropertiesChanged("horizontalUnitIncrement");
      }
      
      public function removeStateListener(param1:Function) : void
      {
         removeEventListener("stateChange",param1);
      }
      
      public function scrollRectToVisible(param1:IntRectangle) : void
      {
         viewPosition = new IntPoint(param1.x,param1.y);
      }
      
      public function setView(param1:DisplayObject) : void
      {
         if(_view == param1)
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
         _view = param1;
         if(_view is Component)
         {
            Component(_view).addEventListener("propertiesChanged",__onResize);
         }
         onPropertiesChanged("view");
      }
      
      public function setViewportTestSize(param1:IntDimension) : void
      {
      }
      
      public function get verticalBlockIncrement() : int
      {
         return _verticalBlockIncrement;
      }
      
      public function set verticalBlockIncrement(param1:int) : void
      {
         if(_verticalBlockIncrement == param1)
         {
            return;
         }
         _verticalBlockIncrement = param1;
         onPropertiesChanged("verticalBlockIncrement");
      }
      
      public function get verticalUnitIncrement() : int
      {
         return _verticalUnitIncrement;
      }
      
      public function set verticalUnitIncrement(param1:int) : void
      {
         if(_verticalUnitIncrement == param1)
         {
            return;
         }
         _verticalUnitIncrement = param1;
         onPropertiesChanged("verticalUnitIncrement");
      }
      
      public function get viewPosition() : IntPoint
      {
         return _viewPosition;
      }
      
      public function set viewPosition(param1:IntPoint) : void
      {
         if(_viewPosition.equals(param1))
         {
            return;
         }
         _viewPosition.setLocation(param1);
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
      
      protected function fireStateChanged(param1:Boolean = true) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function getViewMaxPos() : IntPoint
      {
         var _loc3_:IntDimension = getExtentSize();
         var _loc1_:IntDimension = getViewSize();
         var _loc2_:IntPoint = new IntPoint(_loc1_.width - _loc3_.width,_loc1_.height - _loc3_.height);
         if(_loc2_.x < 0)
         {
            _loc2_.x = 0;
         }
         if(_loc2_.y < 0)
         {
            _loc2_.y = 0;
         }
         return _loc2_;
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
      
      protected function restrictionViewPos(param1:IntPoint) : IntPoint
      {
         var _loc2_:IntPoint = getViewMaxPos();
         param1.x = Math.max(0,Math.min(_loc2_.x,param1.x));
         param1.y = Math.max(0,Math.min(_loc2_.y,param1.y));
         return param1;
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
      
      private function __onResize(param1:ComponentEvent) : void
      {
         if(param1.changedProperties["height"] || param1.changedProperties["width"])
         {
            onPropertiesChanged("view");
         }
      }
   }
}
