package com.pickgliss.ui.controls
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   [Event(name="change",type="flash.events.Event")]
   public class BaseButton extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_backgoundRotation:String = "backgoundRotation";
      
      public static const P_pressEnable:String = "pressEnable";
      
      public static const P_transparentEnable:String = "transparentEnable";
      
      public static const P_autoSizeAble:String = "autoSizeAble";
      
      public static const P_stopMovieAtLastFrame:String = "stopMovieAtLastFrame";
       
      
      private var _offsetCount:int;
      
      protected var _PNGHitArea:Sprite;
      
      protected var _back:DisplayObject;
      
      protected var _backStyle:String;
      
      protected var _backgoundRotation:int;
      
      protected var _currentFrameIndex:int = 1;
      
      protected var _enable:Boolean = true;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _pressEnable:Boolean;
      
      protected var _stopMovieAtLastFrame:Boolean;
      
      private var _displacementEnable:Boolean = true;
      
      private var _pressStartTimer:Timer;
      
      private var _pressStepTimer:Timer;
      
      protected var _transparentEnable:Boolean;
      
      protected var _autoSizeAble:Boolean = true;
      
      private var _useLogID:int = 0;
      
      private var _focusFrameStyle:String;
      
      public var _focusFrame:Bitmap;
      
      private var _autoFrame:Boolean = true;
      
      public function BaseButton()
      {
         super();
         init();
         addEvent();
      }
      
      public function get autoFrame() : Boolean
      {
         return _autoFrame;
      }
      
      public function set autoFrame(param1:Boolean) : void
      {
         _autoFrame = param1;
      }
      
      public function get focusFrameStyle() : String
      {
         return _focusFrameStyle;
      }
      
      public function set focusFrameStyle(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         var _loc2_:Array = param1.split("|");
         if(_loc2_.length > 0)
         {
            _focusFrame = ComponentFactory.Instance.creatBitmap(_loc2_[0]);
            _focusFrame.visible = false;
         }
         if(_loc2_.length > 2)
         {
            _focusFrame.x = _loc2_[1];
            _focusFrame.y = _loc2_[2];
         }
         else
         {
            _focusFrame.x = -5;
            _focusFrame.y = -3;
         }
         addChild(_focusFrame);
      }
      
      public function set useLogID(param1:int) : void
      {
         _useLogID = param1;
      }
      
      public function get useLogID() : int
      {
         return _useLogID;
      }
      
      public function get frameFilter() : Array
      {
         return _frameFilter;
      }
      
      public function set frameFilter(param1:Array) : void
      {
         _frameFilter = param1;
      }
      
      public function set autoSizeAble(param1:Boolean) : void
      {
         if(_autoSizeAble == param1)
         {
            return;
         }
         _autoSizeAble = param1;
         onPropertiesChanged("autoSizeAble");
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(param1:String) : void
      {
         if(param1 == _backStyle)
         {
            return;
         }
         _backStyle = param1;
         backgound = ComponentFactory.Instance.creat(_backStyle);
         onPropertiesChanged("backStyle");
      }
      
      public function set backgound(param1:DisplayObject) : void
      {
         if(_back == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_back);
         _back = param1;
         _width = _back.width;
         _height = _back.height;
         onPropertiesChanged("backStyle");
      }
      
      public function get backgound() : DisplayObject
      {
         return _back;
      }
      
      public function set backgoundRotation(param1:int) : void
      {
         if(_backgoundRotation == param1)
         {
            return;
         }
         _backgoundRotation = param1;
         onPropertiesChanged("backgoundRotation");
      }
      
      public function get displacement() : Boolean
      {
         return _displacementEnable;
      }
      
      public function set displacement(param1:Boolean) : void
      {
         _displacementEnable = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            _back.filters = null;
         }
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_PNGHitArea);
         _PNGHitArea = null;
         _back = null;
         _frameFilter = null;
         _pressStepTimer = null;
         _pressStartTimer = null;
         super.dispose();
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         mouseEnabled = _enable;
         if(_enable)
         {
            setFrame(1);
         }
         else
         {
            setFrame(4);
         }
         updatePosition();
      }
      
      private function updatePosition() : void
      {
         x = x + ComponentSetting.DISPLACEMENT_OFFSET * -_offsetCount;
         y = y + ComponentSetting.DISPLACEMENT_OFFSET * -_offsetCount;
         _offsetCount = 0;
      }
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function set pressEnable(param1:Boolean) : void
      {
         if(_pressEnable == param1)
         {
            return;
         }
         _pressEnable = param1;
         onPropertiesChanged("pressEnable");
      }
      
      public function get transparentEnable() : Boolean
      {
         return _transparentEnable;
      }
      
      public function set transparentEnable(param1:Boolean) : void
      {
         if(_transparentEnable == param1)
         {
            return;
         }
         _transparentEnable = param1;
         onPropertiesChanged("transparentEnable");
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         if(!_enable)
         {
            param1.stopImmediatePropagation();
         }
         else if(_useLogID != 0 && ComponentSetting.SEND_USELOG_ID != null)
         {
            ComponentSetting.SEND_USELOG_ID(_useLogID);
         }
      }
      
      protected function adaptHitArea() : void
      {
         _PNGHitArea.x = _back.x;
         _PNGHitArea.y = _back.y;
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("click",__onMouseClick);
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
         addEventListener("mouseDown",__onMousedown);
      }
      
      public function set stopMovieAtLastFrame(param1:Boolean) : void
      {
         if(_stopMovieAtLastFrame == param1)
         {
            return;
         }
         _stopMovieAtLastFrame = param1;
         onPropertiesChanged("stopMovieAtLastFrame");
      }
      
      public function get stopMovieAtLastFrame() : Boolean
      {
         return _stopMovieAtLastFrame;
      }
      
      protected function drawHitArea() : void
      {
         if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
         if(_back == null)
         {
            return;
         }
         if(_transparentEnable)
         {
            _PNGHitArea = PNGHitAreaFactory.drawHitArea(DisplayUtils.getDisplayBitmapData(_back));
            hitArea = _PNGHitArea;
            _PNGHitArea.alpha = 0;
            adaptHitArea();
            addChild(_PNGHitArea);
         }
         else if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
      }
      
      override protected function init() : void
      {
         super.init();
         mouseChildren = false;
         buttonMode = true;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         super.onProppertiesUpdate();
         if(_changedPropeties["pressEnable"])
         {
            if(_pressEnable == true)
            {
               _pressStartTimer = new Timer(ComponentSetting.BUTTON_PRESS_START_TIME,1);
               _pressStepTimer = new Timer(ComponentSetting.BUTTON_PRESS_STEP_TIME);
            }
         }
         if(_changedPropeties["backStyle"] && _autoSizeAble)
         {
            if(_back && (_back.width > 0 || _back.height > 0))
            {
               _width = _back.width;
               _height = _back.height;
            }
         }
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            if(_back)
            {
               _back.width = _width;
               _back.height = _height;
            }
         }
         if(_changedPropeties["backgoundRotation"])
         {
            if(_back)
            {
               _back.rotation = _backgoundRotation;
               _loc3_ = _back.getRect(this);
               _back.x = -_loc3_.x;
               _back.y = -_loc3_.y;
            }
         }
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["backStyle"] || _changedPropeties["backgoundRotation"] || _changedPropeties["transparentEnable"])
         {
            drawHitArea();
         }
         setFrame(_currentFrameIndex);
         if(_changedPropeties["stopMovieAtLastFrame"] && _stopMovieAtLastFrame)
         {
            _loc2_ = _back as MovieClip;
            if(_loc2_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.numChildren)
               {
                  _loc1_ = _loc2_.getChildAt(_loc4_) as MovieClip;
                  if(_loc1_)
                  {
                     _loc1_.gotoAndStop(_loc1_.totalFrames);
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__onMouseClick);
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseup);
         removeEventListener("mouseDown",__onMousedown);
         if(_pressStartTimer)
         {
            _pressStartTimer.removeEventListener("timer",__onPressedStart);
         }
         if(_pressStepTimer)
         {
            _pressStepTimer.removeEventListener("timer",__onPressStepTimer);
         }
      }
      
      public function setFrame(param1:int) : void
      {
         if(_autoFrame)
         {
            _currentFrameIndex = param1;
            DisplayUtils.setFrame(_back,_currentFrameIndex);
         }
         if(_frameFilter == null || param1 <= 0 || param1 > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[param1 - 1];
      }
      
      protected function __onMouseRollout(param1:MouseEvent) : void
      {
         if(_enable && !param1.buttonDown)
         {
            setFrame(1);
         }
         if(_focusFrame)
         {
            _focusFrame.visible = false;
         }
      }
      
      protected function __onMouseRollover(param1:MouseEvent) : void
      {
         if(_enable && !param1.buttonDown)
         {
            setFrame(2);
         }
         if(_focusFrame)
         {
            _focusFrame.visible = true;
         }
      }
      
      private function __onMousedown(param1:MouseEvent) : void
      {
         if(_enable)
         {
            setFrame(3);
         }
         if(_focusFrame)
         {
            _focusFrame.visible = false;
         }
         if(_displacementEnable && _offsetCount < 1)
         {
            x = x + ComponentSetting.DISPLACEMENT_OFFSET;
            y = y + ComponentSetting.DISPLACEMENT_OFFSET;
            _offsetCount = Number(_offsetCount) + 1;
         }
         StageReferance.stage.addEventListener("mouseUp",__onMouseup);
         if(_pressEnable)
         {
            __onPressStepTimer(null);
            _pressStartTimer.addEventListener("timer",__onPressedStart);
            _pressStartTimer.start();
         }
      }
      
      private function __onMouseup(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onMouseup);
         if(!_enable)
         {
            return;
         }
         if(_displacementEnable && _offsetCount > -1)
         {
            x = x - ComponentSetting.DISPLACEMENT_OFFSET;
            y = y - ComponentSetting.DISPLACEMENT_OFFSET;
            _offsetCount = Number(_offsetCount) - 1;
         }
         if(!(param1.target is DisplayObject))
         {
            setFrame(1);
         }
         if(param1.target == this)
         {
            setFrame(2);
         }
         else
         {
            setFrame(1);
         }
         if(_pressEnable)
         {
            _pressStartTimer.stop();
            _pressStepTimer.stop();
            _pressStepTimer.removeEventListener("timer",__onPressStepTimer);
         }
      }
      
      private function __onPressStepTimer(param1:TimerEvent) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      private function __onPressedStart(param1:TimerEvent) : void
      {
         _pressStartTimer.removeEventListener("timer",__onPressedStart);
         _pressStartTimer.reset();
         _pressStartTimer.stop();
         _pressStepTimer.start();
         _pressStepTimer.addEventListener("timer",__onPressStepTimer);
      }
   }
}
