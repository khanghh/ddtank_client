package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IOrientable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class Scrollbar extends Component implements IOrientable
   {
      
      public static const HORIZONTAL:int = 1;
      
      public static const P_decreaseButton:String = "decreaseButton";
      
      public static const P_decreaseButtonInnerRect:String = "decreaseButtonInnerRect";
      
      public static const P_increaseButton:String = "increaseButton";
      
      public static const P_increaseButtonInnerRect:String = "increaseButtonInnerRect";
      
      public static const P_maximum:String = "maximum";
      
      public static const P_minimum:String = "minimum";
      
      public static const P_orientation:String = "orientation";
      
      public static const P_scrollValue:String = "scrollValue";
      
      public static const P_thumb:String = "thumb";
      
      public static const P_thumbAreaInnerRect:String = "thumbAreaInnerRect";
      
      public static const P_thumbMinSize:String = "thumbMinSize";
      
      public static const P_track:String = "track";
      
      public static const P_trackInnerRect:String = "trackInnerRect";
      
      public static const P_valueIsAdjusting:String = "valueIsAdjusting";
      
      public static const P_visibleAmount:String = "visibleAmount";
      
      public static const VERTICAL:int = 0;
       
      
      protected var _blockIncrement:int = 20;
      
      protected var _currentTrackClickDirction:int = 0;
      
      protected var _decreaseButton:BaseButton;
      
      protected var _decreaseButtonInnerRect:InnerRectangle;
      
      protected var _decreaseButtonInnerRectString:String;
      
      protected var _decreaseButtonStyle:String;
      
      protected var _increaseButton:BaseButton;
      
      protected var _increaseButtonInnerRect:InnerRectangle;
      
      protected var _increaseButtonInnerRectString:String;
      
      protected var _increaseButtonStyle:String;
      
      protected var _isDragging:Boolean;
      
      protected var _model:BoundedRangeModel;
      
      protected var _orientation:int;
      
      protected var _thumb:BaseButton;
      
      protected var _thumbAreaInnerRect:InnerRectangle;
      
      protected var _thumbAreaInnerRectString:String;
      
      protected var _thumbDownOffset:int;
      
      protected var _thumbMinSize:int;
      
      protected var _thumbRect:Rectangle;
      
      protected var _thumbStyle:String;
      
      protected var _track:DisplayObject;
      
      protected var _trackClickTimer:Timer;
      
      protected var _trackInnerRect:InnerRectangle;
      
      protected var _trackInnerRectString:String;
      
      protected var _trackStyle:String;
      
      protected var _unitIncrement:int = 2;
      
      public function Scrollbar()
      {
         super();
      }
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void
      {
         addEventListener("stateChange",param1,false,param2);
      }
      
      public function get blockIncrement() : int
      {
         return _blockIncrement;
      }
      
      public function set blockIncrement(param1:int) : void
      {
         _blockIncrement = param1;
      }
      
      public function set decreaseButton(param1:BaseButton) : void
      {
         if(_decreaseButton == param1)
         {
            return;
         }
         if(_decreaseButton)
         {
            _decreaseButton.removeEventListener("change",__increaseButtonClicked);
         }
         ObjectUtils.disposeObject(_decreaseButton);
         _decreaseButton = param1;
         if(_decreaseButton)
         {
            _decreaseButton.pressEnable = true;
         }
         if(_decreaseButton)
         {
            _decreaseButton.addEventListener("change",__increaseButtonClicked);
         }
         onPropertiesChanged("decreaseButton");
      }
      
      public function set decreaseButtonInnerRectString(param1:String) : void
      {
         if(_decreaseButtonInnerRectString == param1)
         {
            return;
         }
         _decreaseButtonInnerRectString = param1;
         _decreaseButtonInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_decreaseButtonInnerRectString));
         onPropertiesChanged("decreaseButtonInnerRect");
      }
      
      public function set decreaseButtonStyle(param1:String) : void
      {
         if(_decreaseButtonStyle == param1)
         {
            return;
         }
         _decreaseButtonStyle = param1;
         decreaseButton = ComponentFactory.Instance.creat(_decreaseButtonStyle);
      }
      
      override public function dispose() : void
      {
         if(_thumb)
         {
            _thumb.removeEventListener("mouseDown",__onThumbDown);
         }
         ObjectUtils.disposeObject(_thumb);
         _thumb = null;
         if(_decreaseButton)
         {
            _decreaseButton.removeEventListener("change",__decreaseButtonClicked);
         }
         ObjectUtils.disposeObject(_decreaseButton);
         _decreaseButton = null;
         if(_increaseButton)
         {
            _increaseButton.removeEventListener("change",__increaseButtonClicked);
         }
         ObjectUtils.disposeObject(_increaseButton);
         _increaseButton = null;
         StageReferance.stage.removeEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMoved);
         if(_track && _track is InteractiveObject)
         {
            _track.removeEventListener("mouseDown",__onTrackClickStart);
            _track.removeEventListener("mouseUp",__onTrackClickStop);
            _track.removeEventListener("mouseOut",__onTrackClickStop);
            _trackClickTimer.stop();
            _trackClickTimer.removeEventListener("timer",__onTrackPressed);
         }
         ObjectUtils.disposeObject(_track);
         _track = null;
         _trackClickTimer = null;
         super.dispose();
      }
      
      public function set downButtonStyle(param1:String) : void
      {
         if(_decreaseButtonStyle == param1)
         {
            return;
         }
         _decreaseButtonStyle = param1;
         increaseButton = ComponentFactory.Instance.creat(_decreaseButtonStyle);
      }
      
      public function getModel() : BoundedRangeModel
      {
         return _model;
      }
      
      public function getThumbVisible() : Boolean
      {
         return _thumb.visible;
      }
      
      public function set increaseButton(param1:BaseButton) : void
      {
         if(_increaseButton == param1)
         {
            return;
         }
         if(_increaseButton)
         {
            _increaseButton.removeEventListener("change",__decreaseButtonClicked);
         }
         ObjectUtils.disposeObject(_increaseButton);
         _increaseButton = param1;
         if(_increaseButton)
         {
            _increaseButton.pressEnable = true;
         }
         if(_increaseButton)
         {
            _increaseButton.addEventListener("change",__decreaseButtonClicked);
         }
         onPropertiesChanged("increaseButton");
      }
      
      public function set increaseButtonInnerRectString(param1:String) : void
      {
         if(_increaseButtonInnerRectString == param1)
         {
            return;
         }
         _increaseButtonInnerRectString = param1;
         _increaseButtonInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_increaseButtonInnerRectString));
         onPropertiesChanged("increaseButtonInnerRect");
      }
      
      public function set increaseButtonStyle(param1:String) : void
      {
         if(_increaseButtonStyle == param1)
         {
            return;
         }
         _increaseButtonStyle = param1;
         increaseButton = ComponentFactory.Instance.creat(_increaseButtonStyle);
      }
      
      public function isVertical() : Boolean
      {
         return _orientation == 0;
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
      
      public function removeStateListener(param1:Function) : void
      {
         removeEventListener("stateChange",param1);
      }
      
      public function get scrollValue() : int
      {
         return getModel().getValue();
      }
      
      public function set scrollValue(param1:int) : void
      {
         getModel().setValue(param1);
         onPropertiesChanged("scrollValue");
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
            _thumb.removeEventListener("mouseDown",__onThumbDown);
         }
         ObjectUtils.disposeObject(_thumb);
         _thumb = param1;
         if(_thumb)
         {
            _thumb.addEventListener("mouseDown",__onThumbDown);
         }
         onPropertiesChanged("thumb");
      }
      
      public function set thumbAreaInnerRectString(param1:String) : void
      {
         if(_thumbAreaInnerRectString == param1)
         {
            return;
         }
         _thumbAreaInnerRectString = param1;
         _thumbAreaInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_thumbAreaInnerRectString));
         onPropertiesChanged("thumbAreaInnerRect");
      }
      
      public function get thumbMinSize() : int
      {
         return _thumbMinSize;
      }
      
      public function set thumbMinSize(param1:int) : void
      {
         if(_thumbMinSize == param1)
         {
            return;
         }
         _thumbMinSize = param1;
         onPropertiesChanged("thumbMinSize");
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
      
      public function set track(param1:DisplayObject) : void
      {
         if(_track == param1)
         {
            return;
         }
         if(_track && _track is InteractiveObject)
         {
            _track.removeEventListener("mouseDown",__onTrackClickStart);
            _track.removeEventListener("mouseUp",__onTrackClickStop);
            _track.removeEventListener("mouseOut",__onTrackClickStop);
         }
         ObjectUtils.disposeObject(_track);
         _track = param1;
         if(_track is InteractiveObject)
         {
            InteractiveObject(_track).mouseEnabled = true;
         }
         _track.addEventListener("mouseDown",__onTrackClickStart);
         _track.addEventListener("mouseUp",__onTrackClickStop);
         _track.addEventListener("mouseOut",__onTrackClickStop);
         onPropertiesChanged("track");
      }
      
      public function set trackInnerRectString(param1:String) : void
      {
         if(_trackInnerRectString == param1)
         {
            return;
         }
         _trackInnerRectString = param1;
         _trackInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_trackInnerRectString));
         onPropertiesChanged("trackInnerRect");
      }
      
      public function set trackStyle(param1:String) : void
      {
         if(_trackStyle == param1)
         {
            return;
         }
         _trackStyle = param1;
         track = ComponentFactory.Instance.creat(_trackStyle);
      }
      
      public function get unitIncrement() : int
      {
         return _unitIncrement;
      }
      
      public function set unitIncrement(param1:int) : void
      {
         _unitIncrement = param1;
      }
      
      public function get valueIsAdjusting() : Boolean
      {
         return getModel().getValueIsAdjusting();
      }
      
      public function set valueIsAdjusting(param1:Boolean) : void
      {
         if(getModel().getValueIsAdjusting() == param1)
         {
            return;
         }
         getModel().setValueIsAdjusting(param1);
         onPropertiesChanged("valueIsAdjusting");
      }
      
      public function get visibleAmount() : int
      {
         return getModel().getExtent();
      }
      
      public function set visibleAmount(param1:int) : void
      {
         if(getModel().getExtent() == param1)
         {
            return;
         }
         getModel().setExtent(param1);
         onPropertiesChanged("visibleAmount");
      }
      
      protected function __decreaseButtonClicked(param1:Event) : void
      {
         scrollByIncrement(_unitIncrement);
      }
      
      protected function __increaseButtonClicked(param1:Event) : void
      {
         scrollByIncrement(-_unitIncrement);
      }
      
      protected function __onModelChange(param1:InteractiveEvent) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void
      {
         if(!_isDragging)
         {
            updatePosByScrollvalue();
         }
      }
      
      protected function __onThumbDown(param1:MouseEvent) : void
      {
         valueIsAdjusting = true;
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
         StageReferance.stage.addEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.addEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function __onThumbMoved(param1:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         param1.updateAfterEvent();
      }
      
      protected function __onThumbUp(param1:MouseEvent) : void
      {
         _isDragging = false;
         StageReferance.stage.removeEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function __onTrackClickStart(param1:MouseEvent) : void
      {
         _currentTrackClickDirction = getValueWithPosition(getMousePosition()) > scrollValue?1:-1;
         scrollToAimPoint(getMousePosition());
         _trackClickTimer.addEventListener("timer",__onTrackPressed);
         _track.addEventListener("mouseUp",__onTrackClickStop);
         _track.addEventListener("mouseOut",__onTrackClickStop);
         _trackClickTimer.start();
      }
      
      protected function __onTrackClickStop(param1:MouseEvent) : void
      {
         _trackClickTimer.stop();
         _trackClickTimer.removeEventListener("timer",__onTrackPressed);
         _track.removeEventListener("mouseUp",__onTrackClickStop);
         _track.removeEventListener("mouseOut",__onTrackClickStop);
      }
      
      protected function __onTrackPressed(param1:TimerEvent) : void
      {
         scrollToAimPoint(getMousePosition());
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_track)
         {
            addChild(_track);
         }
         if(_increaseButton)
         {
            addChild(_increaseButton);
         }
         if(_decreaseButton)
         {
            addChild(_decreaseButton);
         }
         if(_thumb)
         {
            addChild(_thumb);
         }
      }
      
      protected function getValueWithPosition(param1:Point) : int
      {
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         var _loc2_:int = 0;
         var _loc5_:int = param1.x;
         var _loc7_:int = param1.y;
         var _loc3_:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            _loc2_ = _loc3_.y;
            _loc4_ = _loc3_.y + _loc3_.height - _thumbRect.height;
            _loc6_ = _loc7_;
         }
         else
         {
            _loc2_ = _loc3_.x;
            _loc4_ = _loc3_.x + _loc3_.width - _thumbRect.width;
            _loc6_ = _loc5_;
         }
         return getValueWithThumbMaxMinPos(_loc2_,_loc4_,_loc6_);
      }
      
      override protected function init() : void
      {
         setupModel(new BoundedRangeModel());
         _thumbRect = new Rectangle();
         _trackClickTimer = new Timer(ComponentSetting.BUTTON_PRESS_STEP_TIME);
         addStateListener(__onScrollValueChange);
         super.init();
      }
      
      protected function layoutComponent() : void
      {
         DisplayUtils.layoutDisplayWithInnerRect(_increaseButton,_increaseButtonInnerRect,_width,_height);
         DisplayUtils.layoutDisplayWithInnerRect(_decreaseButton,_decreaseButtonInnerRect,_width,_height);
         DisplayUtils.layoutDisplayWithInnerRect(_track,_trackInnerRect,_width,_height);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["decreaseButtonInnerRect"] || _changedPropeties["increaseButtonInnerRect"] || _changedPropeties["trackInnerRect"] || _changedPropeties["thumbAreaInnerRect"])
         {
            layoutComponent();
         }
         if(_changedPropeties["maximum"] || _changedPropeties["minimum"] || _changedPropeties["scrollValue"] || _changedPropeties["valueIsAdjusting"] || _changedPropeties["visibleAmount"] || _changedPropeties["thumbAreaInnerRect"] || _changedPropeties["thumbMinSize"] || _changedPropeties["thumb"])
         {
            updatePosByScrollvalue();
         }
      }
      
      protected function scrollByIncrement(param1:int) : void
      {
         scrollValue = scrollValue + param1;
      }
      
      protected function scrollThumbToCurrentMousePosition() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Point = getMousePosition();
         var _loc5_:int = _loc1_.x;
         var _loc7_:int = _loc1_.y;
         var _loc3_:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            _loc2_ = _loc3_.y;
            _loc4_ = _loc3_.y + _loc3_.height - _thumbRect.height;
            _loc6_ = Math.min(_loc4_,Math.max(_loc2_,_loc7_ - _thumbDownOffset));
            setThumbPosAndSize(_thumbRect.x,_loc6_,_thumbRect.width,_thumbRect.height);
         }
         else
         {
            _loc2_ = _loc3_.x;
            _loc4_ = _loc3_.x + _loc3_.width - _thumbRect.width;
            _loc6_ = Math.min(_loc4_,Math.max(_loc2_,_loc5_ - _thumbDownOffset));
            setThumbPosAndSize(_loc6_,_thumbRect.y,_thumbRect.width,_thumbRect.height);
         }
         var _loc8_:int = getValueWithThumbMaxMinPos(_loc2_,_loc4_,_loc6_);
         scrollValue = _loc8_;
      }
      
      protected function scrollToAimPoint(param1:Point) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = getValueWithPosition(param1);
         if(_loc3_ > scrollValue && _currentTrackClickDirction > 0)
         {
            _loc2_ = blockIncrement;
         }
         else if(_loc3_ < scrollValue && _currentTrackClickDirction < 0)
         {
            _loc2_ = -blockIncrement;
         }
         else
         {
            return;
         }
         scrollByIncrement(_loc2_);
      }
      
      protected function setThumbPosAndSize(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:* = param1;
         _thumb.x = _loc5_;
         _thumbRect.x = _loc5_;
         _loc5_ = param2;
         _thumb.y = _loc5_;
         _thumbRect.y = _loc5_;
         _loc5_ = param3;
         _thumb.width = _loc5_;
         _thumbRect.width = _loc5_;
         _loc5_ = param4;
         _thumb.height = _loc5_;
         _thumbRect.height = _loc5_;
      }
      
      protected function updatePosByScrollvalue() : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = minimum;
         var _loc5_:int = visibleAmount;
         var _loc4_:int = maximum - _loc1_;
         var _loc6_:int = scrollValue;
         var _loc9_:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(_loc4_ <= 0)
         {
            _thumb.visible = false;
            return;
         }
         if(isVertical())
         {
            _loc8_ = _loc9_.height;
            _loc2_ = Math.floor(_loc8_ * (_loc5_ / _loc4_));
            _thumb.visible = _loc2_ > 0 && _loc2_ < _loc9_.height;
         }
         else
         {
            _loc8_ = _loc9_.width;
            _loc2_ = Math.floor(_loc8_ * (_loc5_ / _loc4_));
            _thumb.visible = _loc2_ < _loc9_.width;
         }
         var _loc10_:* = _thumb.visible;
         _decreaseButton.mouseEnabled = _loc10_;
         _increaseButton.mouseEnabled = _loc10_;
         if(_loc8_ > thumbMinSize)
         {
            _loc2_ = Math.max(_loc2_,thumbMinSize);
            _loc10_ = _thumb.visible;
            _decreaseButton.mouseEnabled = _loc10_;
            _increaseButton.mouseEnabled = _loc10_;
            var _loc3_:int = _loc8_ - _loc2_;
            if(_loc4_ - _loc5_ == 0)
            {
               _loc7_ = 0;
            }
            else
            {
               _loc7_ = Math.round(_loc3_ * ((_loc6_ - _loc1_) / (_loc4_ - _loc5_)));
            }
            if(isVertical())
            {
               setThumbPosAndSize(_loc9_.x,_loc7_ + _loc9_.y,_loc9_.width,_loc2_);
            }
            else
            {
               setThumbPosAndSize(_loc9_.x + _loc7_,_loc9_.y,_loc2_,_loc9_.height);
            }
            return;
         }
         _thumb.visible = false;
      }
      
      private function getValueWithThumbMaxMinPos(param1:int, param2:int, param3:int) : int
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(param3 >= param2)
         {
            _loc9_ = _model.getMaximum() - _model.getExtent();
         }
         else
         {
            _loc8_ = _model.getMaximum() - _model.getExtent();
            _loc5_ = _loc8_ - _model.getMinimum();
            _loc7_ = param3 - param1;
            _loc4_ = param2 - param1;
            _loc6_ = Math.round(_loc7_ / _loc4_ * _loc5_);
            _loc9_ = _loc6_ + _model.getMinimum();
         }
         return _loc9_;
      }
   }
}
