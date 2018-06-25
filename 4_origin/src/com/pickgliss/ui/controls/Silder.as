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
      
      public function set bar($bar:DisplayObject) : void
      {
         if(_bar == $bar)
         {
            return;
         }
         _bar = $bar;
         onPropertiesChanged("bar");
      }
      
      public function set barStyle(value:String) : void
      {
         if(_barStyle == value)
         {
            return;
         }
         _barStyle = value;
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
      
      public function set maskShowAreaInnerRectString(value:String) : void
      {
         if(_maskShowAreaInnerRectString == value)
         {
            return;
         }
         _maskShowAreaInnerRectString = value;
         _maskShowAreaInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_maskShowAreaInnerRectString));
         onPropertiesChanged("maskShowAreaInnerRect");
      }
      
      public function get maximum() : int
      {
         return getModel().getMaximum();
      }
      
      public function set maximum(maximum:int) : void
      {
         if(getModel().getMaximum() == maximum)
         {
            return;
         }
         getModel().setMaximum(maximum);
         onPropertiesChanged("maximum");
      }
      
      public function get minimum() : int
      {
         return getModel().getMinimum();
      }
      
      public function set minimum(minimum:int) : void
      {
         if(getModel().getMinimum() == minimum)
         {
            return;
         }
         getModel().setMinimum(minimum);
         onPropertiesChanged("minimum");
      }
      
      public function get orientation() : int
      {
         return _orientation;
      }
      
      public function set orientation(ori:int) : void
      {
         if(_orientation == ori)
         {
            return;
         }
         _orientation = ori;
         onPropertiesChanged("orientation");
      }
      
      public function set progressBar($progressBar:DisplayObject) : void
      {
         if(_progressBar == $progressBar)
         {
            return;
         }
         _progressBar = $progressBar;
         onPropertiesChanged("progressBar");
      }
      
      public function set progressBarStyle(value:String) : void
      {
         if(_progressBarStyle == value)
         {
            return;
         }
         _progressBarStyle = value;
         progressBar = ComponentFactory.Instance.creat(_progressBarStyle);
      }
      
      public function removeStateListener(listener:Function) : void
      {
         removeEventListener("stateChange",listener);
      }
      
      public function setupModel(model:BoundedRangeModel) : void
      {
         if(_model)
         {
            _model.removeStateListener(__onModelChange);
         }
         else
         {
            _model = model;
         }
         _model.addStateListener(__onModelChange);
      }
      
      public function set thumb($thumb:BaseButton) : void
      {
         if(_thumb == $thumb)
         {
            return;
         }
         if(_thumb)
         {
            ObjectUtils.disposeObject(_thumb);
            _thumb.removeEventListener("mouseDown",__onThumbMouseDown);
         }
         _thumb = $thumb;
         _thumb.addEventListener("mouseDown",__onThumbMouseDown);
         onPropertiesChanged("thumb");
      }
      
      public function set thumbShowInnerRectString(value:String) : void
      {
         if(_thumbShowInnerRectString == value)
         {
            return;
         }
         _thumbShowInnerRectString = value;
         _thumbShowInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_thumbShowInnerRectString));
         onPropertiesChanged("thumbShowInnerRect");
      }
      
      public function set thumbStyle(stylename:String) : void
      {
         if(_thumbStyle == stylename)
         {
            return;
         }
         _thumbStyle = stylename;
         thumb = ComponentFactory.Instance.creat(_thumbStyle);
      }
      
      public function get value() : Number
      {
         return getModel().getValue();
      }
      
      public function set value($value:Number) : void
      {
         if(_value == $value)
         {
            return;
         }
         _value = $value;
         getModel().setValue(_value);
         onPropertiesChanged("value");
      }
      
      protected function __onModelChange(event:InteractiveEvent) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function __onSilderClick(event:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         event.updateAfterEvent();
      }
      
      protected function __onThumbMouseDown(event:MouseEvent) : void
      {
         var mp:Point = getMousePosition();
         var mx:int = mp.x;
         var my:int = mp.y;
         if(isVertical())
         {
            _thumbDownOffset = my - _thumb.y;
         }
         else
         {
            _thumbDownOffset = mx - _thumb.x;
         }
         _isDragging = true;
         StageReferance.stage.addEventListener("mouseUp",__onThumbMouseUp);
         StageReferance.stage.addEventListener("mouseMove",__onThumbMouseMoved);
      }
      
      protected function __onThumbMouseMoved(event:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         event.updateAfterEvent();
      }
      
      protected function __onThumbMouseUp(event:MouseEvent) : void
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
         var thumbMax:int = 0;
         var thumbPos:int = 0;
         var thumbMin:int = 0;
         var mp:Point = getMousePosition();
         var mx:int = mp.x;
         var my:int = mp.y;
         var thumbScrollRect:Rectangle = _thumbShowInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            thumbMin = thumbScrollRect.y;
            thumbMax = thumbScrollRect.y + thumbScrollRect.height;
            thumbPos = Math.min(thumbMax,Math.max(thumbMin,my - _thumbDownOffset));
         }
         else
         {
            thumbMin = thumbScrollRect.x;
            thumbMax = thumbScrollRect.x + thumbScrollRect.width;
            thumbPos = Math.min(thumbMax,Math.max(thumbMin,mx - _thumbDownOffset));
         }
         value = getValueWithThumbMaxMinPos(thumbMin,thumbMax,thumbPos);
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
         var rect:Rectangle = _maskShowAreaInnerRect.getInnerRect(_width,_height);
         _maskShape.x = rect.x;
         _maskShape.y = rect.y;
         var valuePercent:Number = calculateValuePercent();
         if(isVertical())
         {
            _maskShape.height = rect.height * valuePercent;
            _maskShape.width = rect.width;
         }
         else
         {
            _maskShape.width = rect.width * valuePercent;
            _maskShape.height = rect.height;
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
         var rangePos:int = 0;
         var startPos:int = 0;
         if(_thumbShowInnerRect == null)
         {
            return;
         }
         var rect:Rectangle = _thumbShowInnerRect.getInnerRect(_width,_height);
         var valuePercent:Number = calculateValuePercent();
         if(isVertical())
         {
            _thumb.x = rect.x;
            rangePos = rect.height;
            startPos = rect.y;
            _thumb.y = Math.round(valuePercent * rangePos) + startPos;
         }
         else
         {
            _thumb.y = rect.y;
            rangePos = rect.width;
            startPos = rect.x;
            _thumb.x = Math.round(valuePercent * rangePos) + startPos;
         }
         _thumb.tipData = _value;
      }
      
      private function calculateValuePercent() : Number
      {
         var valuePercent:* = NaN;
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
            valuePercent = Number((_value - minimum) / (maximum - minimum));
         }
         else
         {
            valuePercent = 1;
         }
         return valuePercent;
      }
      
      private function getValueWithThumbMaxMinPos(min:Number, max:Number, pos:Number) : Number
      {
         var range:Number = max - min;
         var percent:Number = (pos - min) / range;
         var valueRange:Number = maximum - minimum;
         return percent * valueRange + minimum;
      }
   }
}
