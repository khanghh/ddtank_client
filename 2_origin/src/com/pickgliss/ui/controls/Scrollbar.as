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
      
      public function addStateListener(listener:Function, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         addEventListener("stateChange",listener,false,priority);
      }
      
      public function get blockIncrement() : int
      {
         return _blockIncrement;
      }
      
      public function set blockIncrement(blockIncrement:int) : void
      {
         _blockIncrement = blockIncrement;
      }
      
      public function set decreaseButton(display:BaseButton) : void
      {
         if(_decreaseButton == display)
         {
            return;
         }
         if(_decreaseButton)
         {
            _decreaseButton.removeEventListener("change",__increaseButtonClicked);
         }
         ObjectUtils.disposeObject(_decreaseButton);
         _decreaseButton = display;
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
      
      public function set decreaseButtonInnerRectString(value:String) : void
      {
         if(_decreaseButtonInnerRectString == value)
         {
            return;
         }
         _decreaseButtonInnerRectString = value;
         _decreaseButtonInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_decreaseButtonInnerRectString));
         onPropertiesChanged("decreaseButtonInnerRect");
      }
      
      public function set decreaseButtonStyle(stylename:String) : void
      {
         if(_decreaseButtonStyle == stylename)
         {
            return;
         }
         _decreaseButtonStyle = stylename;
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
      
      public function set downButtonStyle(stylename:String) : void
      {
         if(_decreaseButtonStyle == stylename)
         {
            return;
         }
         _decreaseButtonStyle = stylename;
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
      
      public function set increaseButton(display:BaseButton) : void
      {
         if(_increaseButton == display)
         {
            return;
         }
         if(_increaseButton)
         {
            _increaseButton.removeEventListener("change",__decreaseButtonClicked);
         }
         ObjectUtils.disposeObject(_increaseButton);
         _increaseButton = display;
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
      
      public function set increaseButtonInnerRectString(value:String) : void
      {
         if(_increaseButtonInnerRectString == value)
         {
            return;
         }
         _increaseButtonInnerRectString = value;
         _increaseButtonInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_increaseButtonInnerRectString));
         onPropertiesChanged("increaseButtonInnerRect");
      }
      
      public function set increaseButtonStyle(stylename:String) : void
      {
         if(_increaseButtonStyle == stylename)
         {
            return;
         }
         _increaseButtonStyle = stylename;
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
      
      public function removeStateListener(listener:Function) : void
      {
         removeEventListener("stateChange",listener);
      }
      
      public function get scrollValue() : int
      {
         return getModel().getValue();
      }
      
      public function set scrollValue(v:int) : void
      {
         getModel().setValue(v);
         onPropertiesChanged("scrollValue");
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
      
      public function set thumb(display:BaseButton) : void
      {
         if(_thumb == display)
         {
            return;
         }
         if(_thumb)
         {
            _thumb.removeEventListener("mouseDown",__onThumbDown);
         }
         ObjectUtils.disposeObject(_thumb);
         _thumb = display;
         if(_thumb)
         {
            _thumb.addEventListener("mouseDown",__onThumbDown);
         }
         onPropertiesChanged("thumb");
      }
      
      public function set thumbAreaInnerRectString(value:String) : void
      {
         if(_thumbAreaInnerRectString == value)
         {
            return;
         }
         _thumbAreaInnerRectString = value;
         _thumbAreaInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_thumbAreaInnerRectString));
         onPropertiesChanged("thumbAreaInnerRect");
      }
      
      public function get thumbMinSize() : int
      {
         return _thumbMinSize;
      }
      
      public function set thumbMinSize(value:int) : void
      {
         if(_thumbMinSize == value)
         {
            return;
         }
         _thumbMinSize = value;
         onPropertiesChanged("thumbMinSize");
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
      
      public function set track(display:DisplayObject) : void
      {
         if(_track == display)
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
         _track = display;
         if(_track is InteractiveObject)
         {
            InteractiveObject(_track).mouseEnabled = true;
         }
         _track.addEventListener("mouseDown",__onTrackClickStart);
         _track.addEventListener("mouseUp",__onTrackClickStop);
         _track.addEventListener("mouseOut",__onTrackClickStop);
         onPropertiesChanged("track");
      }
      
      public function set trackInnerRectString(value:String) : void
      {
         if(_trackInnerRectString == value)
         {
            return;
         }
         _trackInnerRectString = value;
         _trackInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_trackInnerRectString));
         onPropertiesChanged("trackInnerRect");
      }
      
      public function set trackStyle(stylename:String) : void
      {
         if(_trackStyle == stylename)
         {
            return;
         }
         _trackStyle = stylename;
         track = ComponentFactory.Instance.creat(_trackStyle);
      }
      
      public function get unitIncrement() : int
      {
         return _unitIncrement;
      }
      
      public function set unitIncrement(unitIncrement:int) : void
      {
         _unitIncrement = unitIncrement;
      }
      
      public function get valueIsAdjusting() : Boolean
      {
         return getModel().getValueIsAdjusting();
      }
      
      public function set valueIsAdjusting(b:Boolean) : void
      {
         if(getModel().getValueIsAdjusting() == b)
         {
            return;
         }
         getModel().setValueIsAdjusting(b);
         onPropertiesChanged("valueIsAdjusting");
      }
      
      public function get visibleAmount() : int
      {
         return getModel().getExtent();
      }
      
      public function set visibleAmount(extent:int) : void
      {
         if(getModel().getExtent() == extent)
         {
            return;
         }
         getModel().setExtent(extent);
         onPropertiesChanged("visibleAmount");
      }
      
      protected function __decreaseButtonClicked(event:Event) : void
      {
         scrollByIncrement(_unitIncrement);
      }
      
      protected function __increaseButtonClicked(event:Event) : void
      {
         scrollByIncrement(-_unitIncrement);
      }
      
      protected function __onModelChange(event:InteractiveEvent) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function __onScrollValueChange(event:InteractiveEvent) : void
      {
         if(!_isDragging)
         {
            updatePosByScrollvalue();
         }
      }
      
      protected function __onThumbDown(event:MouseEvent) : void
      {
         valueIsAdjusting = true;
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
         StageReferance.stage.addEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.addEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function __onThumbMoved(event:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
         event.updateAfterEvent();
      }
      
      protected function __onThumbUp(event:MouseEvent) : void
      {
         _isDragging = false;
         StageReferance.stage.removeEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function __onTrackClickStart(event:MouseEvent) : void
      {
         _currentTrackClickDirction = getValueWithPosition(getMousePosition()) > scrollValue?1:-1;
         scrollToAimPoint(getMousePosition());
         _trackClickTimer.addEventListener("timer",__onTrackPressed);
         _track.addEventListener("mouseUp",__onTrackClickStop);
         _track.addEventListener("mouseOut",__onTrackClickStop);
         _trackClickTimer.start();
      }
      
      protected function __onTrackClickStop(event:MouseEvent) : void
      {
         _trackClickTimer.stop();
         _trackClickTimer.removeEventListener("timer",__onTrackPressed);
         _track.removeEventListener("mouseUp",__onTrackClickStop);
         _track.removeEventListener("mouseOut",__onTrackClickStop);
      }
      
      protected function __onTrackPressed(event:TimerEvent) : void
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
      
      protected function getValueWithPosition(point:Point) : int
      {
         var thumbMax:int = 0;
         var thumbPos:* = 0;
         var thumbMin:int = 0;
         var mx:int = point.x;
         var my:int = point.y;
         var thumbScrollRect:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            thumbMin = thumbScrollRect.y;
            thumbMax = thumbScrollRect.y + thumbScrollRect.height - _thumbRect.height;
            thumbPos = my;
         }
         else
         {
            thumbMin = thumbScrollRect.x;
            thumbMax = thumbScrollRect.x + thumbScrollRect.width - _thumbRect.width;
            thumbPos = mx;
         }
         return getValueWithThumbMaxMinPos(thumbMin,thumbMax,thumbPos);
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
      
      protected function scrollByIncrement(value:int) : void
      {
         scrollValue = scrollValue + value;
      }
      
      protected function scrollThumbToCurrentMousePosition() : void
      {
         var thumbMax:int = 0;
         var thumbPos:int = 0;
         var thumbMin:int = 0;
         var mp:Point = getMousePosition();
         var mx:int = mp.x;
         var my:int = mp.y;
         var thumbScrollRect:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(isVertical())
         {
            thumbMin = thumbScrollRect.y;
            thumbMax = thumbScrollRect.y + thumbScrollRect.height - _thumbRect.height;
            thumbPos = Math.min(thumbMax,Math.max(thumbMin,my - _thumbDownOffset));
            setThumbPosAndSize(_thumbRect.x,thumbPos,_thumbRect.width,_thumbRect.height);
         }
         else
         {
            thumbMin = thumbScrollRect.x;
            thumbMax = thumbScrollRect.x + thumbScrollRect.width - _thumbRect.width;
            thumbPos = Math.min(thumbMax,Math.max(thumbMin,mx - _thumbDownOffset));
            setThumbPosAndSize(thumbPos,_thumbRect.y,_thumbRect.width,_thumbRect.height);
         }
         var scrollBarValue:int = getValueWithThumbMaxMinPos(thumbMin,thumbMax,thumbPos);
         scrollValue = scrollBarValue;
      }
      
      protected function scrollToAimPoint(pt:Point) : void
      {
         var currentIncrement:int = 0;
         var scrollContinueDestination:int = getValueWithPosition(pt);
         if(scrollContinueDestination > scrollValue && _currentTrackClickDirction > 0)
         {
            currentIncrement = blockIncrement;
         }
         else if(scrollContinueDestination < scrollValue && _currentTrackClickDirction < 0)
         {
            currentIncrement = -blockIncrement;
         }
         else
         {
            return;
         }
         scrollByIncrement(currentIncrement);
      }
      
      protected function setThumbPosAndSize(posX:int, posY:int, sizeW:int, sizeH:int) : void
      {
         var _loc5_:* = posX;
         _thumb.x = _loc5_;
         _thumbRect.x = _loc5_;
         _loc5_ = posY;
         _thumb.y = _loc5_;
         _thumbRect.y = _loc5_;
         _loc5_ = sizeW;
         _thumb.width = _loc5_;
         _thumbRect.width = _loc5_;
         _loc5_ = sizeH;
         _thumb.height = _loc5_;
         _thumbRect.height = _loc5_;
      }
      
      protected function updatePosByScrollvalue() : void
      {
         var trackLength:int = 0;
         var thumbLength:int = 0;
         var thumbPos:int = 0;
         var min:int = minimum;
         var extent:int = visibleAmount;
         var range:int = maximum - min;
         var value:int = scrollValue;
         var thumbRect:Rectangle = _thumbAreaInnerRect.getInnerRect(_width,_height);
         if(range <= 0)
         {
            _thumb.visible = false;
            return;
         }
         if(isVertical())
         {
            trackLength = thumbRect.height;
            thumbLength = Math.floor(trackLength * (extent / range));
            _thumb.visible = thumbLength > 0 && thumbLength < thumbRect.height;
         }
         else
         {
            trackLength = thumbRect.width;
            thumbLength = Math.floor(trackLength * (extent / range));
            _thumb.visible = thumbLength < thumbRect.width;
         }
         var _loc10_:* = _thumb.visible;
         _decreaseButton.mouseEnabled = _loc10_;
         _increaseButton.mouseEnabled = _loc10_;
         if(trackLength > thumbMinSize)
         {
            thumbLength = Math.max(thumbLength,thumbMinSize);
            _loc10_ = _thumb.visible;
            _decreaseButton.mouseEnabled = _loc10_;
            _increaseButton.mouseEnabled = _loc10_;
            var thumbRange:int = trackLength - thumbLength;
            if(range - extent == 0)
            {
               thumbPos = 0;
            }
            else
            {
               thumbPos = Math.round(thumbRange * ((value - min) / (range - extent)));
            }
            if(isVertical())
            {
               setThumbPosAndSize(thumbRect.x,thumbPos + thumbRect.y,thumbRect.width,thumbLength);
            }
            else
            {
               setThumbPosAndSize(thumbRect.x + thumbPos,thumbRect.y,thumbLength,thumbRect.height);
            }
            return;
         }
         _thumb.visible = false;
      }
      
      private function getValueWithThumbMaxMinPos(thumbMin:int, thumbMax:int, thumbPos:int) : int
      {
         var scrollBarValue:int = 0;
         var valueMax:int = 0;
         var valueRange:int = 0;
         var thumbValue:int = 0;
         var thumbRange:int = 0;
         var value:int = 0;
         if(thumbPos >= thumbMax)
         {
            scrollBarValue = _model.getMaximum() - _model.getExtent();
         }
         else
         {
            valueMax = _model.getMaximum() - _model.getExtent();
            valueRange = valueMax - _model.getMinimum();
            thumbValue = thumbPos - thumbMin;
            thumbRange = thumbMax - thumbMin;
            value = Math.round(thumbValue / thumbRange * valueRange);
            scrollBarValue = value + _model.getMinimum();
         }
         return scrollBarValue;
      }
   }
}
