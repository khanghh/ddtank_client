package com.pickgliss.ui.controls
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class NumberSelecter extends Component
   {
      
      public static const P_back:String = "P_back";
      
      public static const P_upStyle:String = "P_upStyle";
      
      public static const P_downStyle:String = "P_downStyle";
      
      public static const P_targetFieldStyle:String = "P_targetFieldStyle";
       
      
      private var _back:DisplayObject;
      
      private var _backStyle:String;
      
      private var _upDisplay:DisplayObject;
      
      private var _upStyle:String;
      
      private var _downDisplay:DisplayObject;
      
      private var _downStyle:String;
      
      private var _targetField:TextField;
      
      private var _targetFieldStyle:String;
      
      private var _currentValue:Number;
      
      private var _increment:Number = 1;
      
      protected var _valueLimit:Point;
      
      public function NumberSelecter()
      {
         super();
      }
      
      public function set valueLimit(param1:String) : void
      {
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = int(_loc2_[1]) < 0?2147483647:int(_loc2_[1]);
         _valueLimit = new Point(_loc2_[0],_loc3_);
         currentValue = _valueLimit.x;
      }
      
      public function get currentValue() : Number
      {
         return _currentValue;
      }
      
      public function get increment() : Number
      {
         return _increment;
      }
      
      public function set increment(param1:Number) : void
      {
         _increment = param1;
      }
      
      public function get targetFieldStyle() : String
      {
         return _targetFieldStyle;
      }
      
      public function set targetFieldStyle(param1:String) : void
      {
         if(param1 == _upStyle)
         {
            return;
         }
         _targetFieldStyle = param1;
         targetField = ComponentFactory.Instance.creat(_targetFieldStyle);
      }
      
      public function set targetField(param1:TextField) : void
      {
         if(_targetField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_targetField);
         _targetField = param1;
         onPropertiesChanged("P_targetFieldStyle");
      }
      
      public function get upStyle() : String
      {
         return _upStyle;
      }
      
      public function set upStyle(param1:String) : void
      {
         if(param1 == _upStyle)
         {
            return;
         }
         _upStyle = param1;
         upDisplay = ComponentFactory.Instance.creat(_upStyle);
      }
      
      public function set upDisplay(param1:DisplayObject) : void
      {
         if(_upDisplay == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_upDisplay);
         _upDisplay = param1;
         onPropertiesChanged("P_upStyle");
      }
      
      public function get downStyle() : String
      {
         return _downStyle;
      }
      
      public function set downStyle(param1:String) : void
      {
         if(param1 == _downStyle)
         {
            return;
         }
         _downStyle = param1;
         downDisplay = ComponentFactory.Instance.creat(_downStyle);
      }
      
      public function set downDisplay(param1:DisplayObject) : void
      {
         if(_downDisplay == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_downDisplay);
         _downDisplay = param1;
         onPropertiesChanged("P_downStyle");
      }
      
      public function get downDisplay() : DisplayObject
      {
         return _downDisplay;
      }
      
      public function get upDisplay() : DisplayObject
      {
         return _upDisplay;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_back)
         {
            addChild(_back);
         }
         if(_targetField && !(_targetField.parent is TextInput))
         {
            addChild(_targetField);
         }
         if(_upDisplay)
         {
            addChild(_upDisplay);
         }
         if(_downDisplay)
         {
            addChild(_downDisplay);
         }
         setReduceBtnState();
      }
      
      private function __fieldChange(param1:Event) : void
      {
         if(!_targetField)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_upDisplay !== _loc2_)
         {
            if(_downDisplay === _loc2_)
            {
               currentValue = currentValue + _increment;
            }
         }
         else
         {
            currentValue = currentValue - _increment;
         }
         setText(_currentValue);
         validate();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["P_upStyle"] || _changedPropeties["P_downStyle"])
         {
            if(_upDisplay)
            {
               _width = Math.max(_upDisplay.x + _upDisplay.width,_width);
               _height = Math.max(_upDisplay.y + _upDisplay.height,_height);
               _upDisplay.addEventListener("click",__fieldChange);
            }
            if(_downDisplay)
            {
               _width = Math.max(_downDisplay.x + _downDisplay.width,_width);
               _height = Math.max(_downDisplay.y + _downDisplay.height,_height);
               _downDisplay.addEventListener("click",__fieldChange);
            }
         }
         if(_changedPropeties["P_targetFieldStyle"])
         {
            _targetField.restrict = "0-9";
            setText(_valueLimit.x);
            _targetField.addEventListener("focusOut",validate);
            _targetField.addEventListener("mouseWheel",__onMouseWheel);
            _targetField.addEventListener("change",__targetFieldChange);
         }
         super.onProppertiesUpdate();
      }
      
      private function setReduceBtnState() : void
      {
         if(_upDisplay)
         {
            if(currentValue <= _valueLimit.x)
            {
               (_upDisplay as BaseButton).enable = false;
               _upDisplay.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               (_upDisplay as BaseButton).enable = true;
               _upDisplay.filters = null;
            }
         }
         if(_downDisplay)
         {
            if(currentValue >= _valueLimit.y)
            {
               (_downDisplay as BaseButton).enable = false;
               _downDisplay.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               (_downDisplay as BaseButton).enable = true;
               _downDisplay.filters = null;
            }
         }
      }
      
      protected function __targetFieldChange(param1:Event) : void
      {
         if(_targetField.text.length <= 0)
         {
            currentValue = _valueLimit.x;
            setText(_currentValue);
         }
         validate();
      }
      
      private function __onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta < 0)
         {
            currentValue = currentValue + _increment;
         }
         else
         {
            currentValue = currentValue - _increment;
         }
         setText(_currentValue);
         validate();
      }
      
      public function set back(param1:DisplayObject) : void
      {
         if(_back == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_back);
         _back = param1;
         onPropertiesChanged("P_back");
      }
      
      public function set backStyle(param1:String) : void
      {
         if(_backStyle == param1)
         {
            return;
         }
         _backStyle = param1;
         back = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function validate(param1:FocusEvent = null) : void
      {
         if(!_targetField.text == "")
         {
            currentValue = Number(_targetField.text);
         }
         if(_currentValue > _valueLimit.y)
         {
            currentValue = _valueLimit.y;
         }
         if(_currentValue < _valueLimit.x)
         {
            currentValue = _valueLimit.x;
         }
         setText(_currentValue);
         if(!param1)
         {
            StageReferance.stage.focus = _targetField;
         }
         setReduceBtnState();
      }
      
      public function set currentValue(param1:Number) : void
      {
         if(_currentValue == param1)
         {
            return;
         }
         _currentValue = param1;
         setText(_currentValue);
         dispatchEvent(new Event("change"));
      }
      
      private function setText(param1:int) : void
      {
         _targetField.text = String(param1);
         _targetField.setSelection(_targetField.length,_targetField.length);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_targetField);
         _targetField = null;
         ObjectUtils.disposeObject(_upDisplay);
         _upDisplay = null;
         ObjectUtils.disposeObject(_downDisplay);
         _downDisplay = null;
      }
   }
}
