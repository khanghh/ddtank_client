package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IOrientable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Silder extends Component implements IOrientable
   {
      
      public static const P_bar:String = "bar";
      
      public static const P_maskShowAreaInnerRect:String = "maskShowAreaInnerRect";
      
      public static const P_maximum:String = "maximum";
      
      public static const P_minimum:String = "minimum";
      
      public static const P_orientation:String = "orientation";
      
      public static const P_progressBar:String = "progressBar";
      
      public static const P_thumb:String = "thumb";
      
      public static const P_thumbShowInnerRect:String = "thumbShowInnerRect";
      
      public static const P_value:String = "value";
       
      
      protected var _bar:DisplayObject;
      
      protected var _barStyle:String;
      
      protected var _isDragging:Boolean;
      
      protected var _maskShape:Shape;
      
      protected var _maskShowAreaInnerRect:InnerRectangle;
      
      protected var _maskShowAreaInnerRectString:String;
      
      protected var _model:BoundedRangeModel;
      
      protected var _orientation:int = -1;
      
      protected var _progressBar:DisplayObject;
      
      protected var _progressBarStyle:String;
      
      protected var _thumb:BaseButton;
      
      protected var _thumbDownOffset:int;
      
      protected var _thumbShowInnerRect:InnerRectangle;
      
      protected var _thumbShowInnerRectString:String;
      
      protected var _thumbStyle:String;
      
      protected var _value:Number;
      
      public function Silder()
      {
         super();
      }
      
      public function set bar(param1:DisplayObject) : void
      {
         if(_bar == param1)
         {
            return;
         }
         _bar = param1;
         onPropertiesChanged("bar");
      }
      
      public function set barStyle(param1:String) : void
      {
         if(_barStyle == param1)
         {
            return;
         }
         _barStyle = param1;
         bar = ComponentFactory.Instance.creat(_barStyle);
      }
      
      override public function dispose() : void
      {
         removeEventListener("click",__onSilderClick);
         StageReferance.stage.removeEventListener("mouseUp",__onThumbMouseUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMouseMoved);
         if(_thumb)
         {
            _thumb.addEventListener("mouseDown",__onThumbMouseDown);
         }
         ObjectUtils.disposeObject(_thumb);
         ObjectUtils.disposeObject(_bar);
         ObjectUtils.disposeObject(_progressBar);
         ObjectUtils.disposeObject(_maskShape);
         super.dispose();
      }
      
      public function getModel() : BoundedRangeModel
      {
         return _model;
      }
      
      public function isVertical() : Boolean
      {
         return _orientation == 0;
      }
      
      public function set maskShowAreaInnerRectString(param1:String) : void
      {
         if(_maskShowAreaInnerRectString == param1)
         {
            return;
         }
         _maskShowAreaInnerRectString = param1;
         _maskShowAreaInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_maskShowAreaInnerRectString));
         onPropertiesChanged("maskShowAreaInnerRect");
      }
      
      public function get maximum() : int
      {
         return getModel().getMaximum();
      }
      
      public function set maximum(param1:int) : void
      {
         if(getModel().getMaximum() == param1)
         {
            return;
         }
         getModel().setMaximum(param1);
         onPropertiesChanged("maximum");
      }
      
      public function get minimum() : int
      {
         return getModel().getMinimum();
      }
      
      public function set minimum(param1:int) : void
      {
         if(getModel().getMinimum() == param1)
         {
            return;
         }
         getModel().setMinimum(param1);
         onPropertiesChanged("minimum");
      }
      
      public function get orientation() : int
      {
         return _orientation;
      }
      
      public function set orientation(param1:int) : void
      {
         if(_orientation == param1)
         {
            return;
         }
         _orientation = param1;
         onPropertiesChanged("orientation");
      }
      
      public function set progressBar(param1:DisplayObject) : void
      {
         if(_progressBar == param1)
         {
            return;
         }
         _progressBar = param1;
         onPropertiesChanged("progressBar");
      }
      
      public function set progressBarStyle(param1:String) : void
      {
         if(_progressBarStyle == param1)
         {
            return;
         }
         _progressBarStyle = param1;
         progressBar = ComponentFactory.Instance.creat(_progressBarStyle);
      }
      
      public function removeStateListener(param1:Function) : void
      {
         removeEventListener("stateChange",param1);
      }
      
      public function setupModel(param1:BoundedRangeModel) : void
      {
         if(_model)
         {
            _model.removeStateListener(__onModelChange);
         }
         else
         {
            _model = param1;
         }
         _model.addStateListener(__onModelChange);
      }
      
      public function set thumb(param1:BaseButton) : void
      {
         if(_thumb == param1)
         {
            return;
         }
         if(_thumb)
         {
            ObjectUtils.disposeObject(_thumb);
            _thumb.removeEventListener("mouseDown",__onThumbMouseDown);
         }
         _thumb = param1;
         _thumb.addEventListener("mouseDown",__onThumbMouseDown);
         onPropertiesChanged("thumb");
      }
      
      public function set thumbShowInnerRectString(param1:String) : void
      {
         if(_thumbShowInnerRectString == param1)
         {
            return;
         }
         _thumbShowInnerRectString = param1;
         _thumbShowInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_thumbShowInnerRectString));
         onPropertiesChanged("thumbShowInnerRect");
      }
      
      public function set thumbStyle(param1:String) : void
      {
         if(_thumbStyle == param1)
         {
            return;
         }
         _thumbStyle = param1;
         thumb = ComponentFactory.Instance.creat(_thumbStyle);
      }
      
      public function get value() : Number
      {
         return getModel().getValue();
      }
      
      public function set value(param1:Number) : void
      {
         if(_value == param1)
         {
            return;
         }
         _value = param1;
         getModel().setValue(_value);
         onPropertiesChanged("value");
      }
      
      protected function __onModelChange(param1:InteractiveEvent) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function __onSilderClick(param1:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         param1.updateAfterEvent();
      }
      
      protected function __onThumbMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = getMousePosition();
         var _loc3_:int = _loc2_.x;
         var _loc4_:int = _loc2_.y;
         if(isVertical())
         {
            _thumbDownOffset = _loc4_ - _thumb.y;
         }
         else
         {
            _thumbDownOffset = _loc3_ - _thumb.x;
         }
         _isDragging = true;
         StageReferance.stage.addEventListener("mouseUp",__onThumbMouseUp);
         StageReferance.stage.addEventListener("mouseMove",__onThumbMouseMoved);
      }
      
      protected function __onThumbMouseMoved(param1:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         param1.updateAfterEvent();
      }
      
      protected function __onThumbMouseUp(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onThumbMouseUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMouseMoved);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bar)
         {
            addChild(_bar);
         }
         if(_progressBar)
         {
            addChild(_progressBar);
            addChild(_maskShape);
         }
         if(_thumb)
         {
            addChild(_thumb);
         }
      }
      
      override protected function init() : void
      {
         setupModel(new BoundedRangeModel());
         setupMask();
         addEventListener("click",__onSilderClick);
         super.init();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            updateSize();
         }
         if(_changedPropeties["value"] || _changedPropeties["thumbShowInnerRect"] || _changedPropeties["maskShowAreaInnerRect"] || _changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["maximum"] || _changedPropeties["minimum"])
         {
            updateThumbPos();
            updateMask();
            if(_bar)
            {
               _bar.width = _width;
               _bar.height = _height;
            }
         }
      }
      
      protected function scrollThumbToCurrentMousePosition() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Point = getMousePosition();
         var _loc5_:int = _loc1_.x;
         var _loc7_:int = _loc1_.y;
         var _loc3_:Rectangle = _thumbShowInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            _loc2_ = _loc3_.y;
            _loc4_ = _loc3_.y + _loc3_.height;
            _loc6_ = Math.min(_loc4_,Math.max(_loc2_,_loc7_ - _thumbDownOffset));
         }
         else
         {
            _loc2_ = _loc3_.x;
            _loc4_ = _loc3_.x + _loc3_.width;
            _loc6_ = Math.min(_loc4_,Math.max(_loc2_,_loc5_ - _thumbDownOffset));
         }
         value = getValueWithThumbMaxMinPos(_loc2_,_loc4_,_loc6_);
      }
      
      protected function setupMask() : void
      {
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(16711680,1);
         _maskShape.graphics.drawRect(0,0,100,100);
         _maskShape.graphics.endFill();
      }
      
      protected function updateMask() : void
      {
         if(_maskShowAreaInnerRect == null)
         {
            return;
         }
         var _loc2_:Rectangle = _maskShowAreaInnerRect.getInnerRect(_width,_height);
         _maskShape.x = _loc2_.x;
         _maskShape.y = _loc2_.y;
         var _loc1_:Number = calculateValuePercent();
         if(isVertical())
         {
            _maskShape.height = _loc2_.height * _loc1_;
            _maskShape.width = _loc2_.width;
         }
         else
         {
            _maskShape.width = _loc2_.width * _loc1_;
            _maskShape.height = _loc2_.height;
         }
         if(_maskShape)
         {
            _progressBar.mask = _maskShape;
         }
      }
      
      protected function updateSize() : void
      {
         _bar.width = _width;
         _bar.height = _height;
         if(_progressBar)
         {
            _progressBar.width = _width;
            _progressBar.height = _height;
         }
      }
      
      protected function updateThumbPos() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_thumbShowInnerRect == null)
         {
            return;
         }
         var _loc4_:Rectangle = _thumbShowInnerRect.getInnerRect(_width,_height);
         var _loc1_:Number = calculateValuePercent();
         if(isVertical())
         {
            _thumb.x = _loc4_.x;
            _loc2_ = _loc4_.height;
            _loc3_ = _loc4_.y;
            _thumb.y = Math.round(_loc1_ * _loc2_) + _loc3_;
         }
         else
         {
            _thumb.y = _loc4_.y;
            _loc2_ = _loc4_.width;
            _loc3_ = _loc4_.x;
            _thumb.x = Math.round(_loc1_ * _loc2_) + _loc3_;
         }
         _thumb.tipData = _value;
      }
      
      private function calculateValuePercent() : Number
      {
         var _loc1_:* = NaN;
         if(_value < minimum || isNaN(_value))
         {
            _value = minimum;
         }
         if(_value > maximum)
         {
            _value = maximum;
         }
         if(maximum > minimum)
         {
            _loc1_ = Number((_value - minimum) / (maximum - minimum));
         }
         else
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      private function getValueWithThumbMaxMinPos(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc5_:Number = param2 - param1;
         var _loc4_:Number = (param3 - param1) / _loc5_;
         var _loc6_:Number = maximum - minimum;
         return _loc4_ * _loc6_ + minimum;
      }
   }
}
