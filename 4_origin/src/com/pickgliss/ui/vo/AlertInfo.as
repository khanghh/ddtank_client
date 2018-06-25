package com.pickgliss.ui.vo
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class AlertInfo extends EventDispatcher
   {
      
      public static const CANCEL_LABEL:String = "Hủy bỏ";
      
      public static const SUBMIT_LABEL:String = "Đồng ý";
       
      
      private var _type:int;
      
      private var _selectBtnY:int;
      
      private var _customPos:Point;
      
      private var _autoButtonGape:Boolean = true;
      
      private var _autoDispose:Boolean = false;
      
      private var _bottomGap:int;
      
      private var _buttonGape:int;
      
      private var _cancelLabel:String = "Hủy bỏ";
      
      private var _data:Object;
      
      private var _enableHtml:Boolean;
      
      private var _enterEnable:Boolean = true;
      
      private var _escEnable:Boolean = true;
      
      private var _frameCenter:Boolean = true;
      
      private var _moveEnable:Boolean = true;
      
      private var _mutiline:Boolean;
      
      private var _showCancel:Boolean = true;
      
      private var _showSubmit:Boolean = true;
      
      private var _submitEnabled:Boolean = true;
      
      private var _cancelEnabled:Boolean = true;
      
      private var _submitLabel:String = "Đồng ý";
      
      private var _textShowHeight:int;
      
      private var _textShowWidth:int;
      
      private var _title:String;
      
      private var _logText:String;
      
      private var _soundID;
      
      public function AlertInfo($title:String = "", $submitLabel:String = "Đồng ý", $cancelLabel:String = "Hủy bỏ", $showSubmit:Boolean = true, $showCancel:Boolean = true, $data:Object = null, $center:Boolean = true, $movable:Boolean = true, $enableEnter:Boolean = true, $enableEsc:Boolean = true, $bottomGap:int = 20, $buttonGape:int = 30, $autoDispose:Boolean = false, $type:int = 0)
      {
         _buttonGape = ComponentSetting.ALERT_BUTTON_GAPE;
         super();
         title = $title;
         type = $type;
         submitLabel = $submitLabel;
         cancelLabel = $cancelLabel;
         showSubmit = $showSubmit;
         showCancel = $showCancel;
         data = $data;
         frameCenter = $center;
         moveEnable = $movable;
         enterEnable = $enableEnter;
         escEnable = $enableEsc;
         bottomGap = $bottomGap;
         buttonGape = $buttonGape;
         autoDispose = $autoDispose;
      }
      
      public function get autoButtonGape() : Boolean
      {
         return _autoButtonGape;
      }
      
      public function set autoButtonGape(value:Boolean) : void
      {
         if(_autoButtonGape == value)
         {
            return;
         }
         _autoButtonGape = value;
         fireChange();
      }
      
      public function get autoDispose() : Boolean
      {
         return _autoDispose;
      }
      
      public function set autoDispose(value:Boolean) : void
      {
         if(_autoDispose == value)
         {
            return;
         }
         _autoDispose = value;
         fireChange();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         if(_type == value)
         {
            return;
         }
         _type = value;
         fireChange();
      }
      
      public function get bottomGap() : int
      {
         return _bottomGap;
      }
      
      public function set bottomGap(value:int) : void
      {
         if(_bottomGap == value)
         {
            return;
         }
         _bottomGap = value;
         fireChange();
      }
      
      public function get buttonGape() : int
      {
         return _buttonGape;
      }
      
      public function set buttonGape(value:int) : void
      {
         if(_buttonGape == value)
         {
            return;
         }
         _buttonGape = value;
         fireChange();
      }
      
      public function get cancelLabel() : String
      {
         return _cancelLabel;
      }
      
      public function set cancelLabel(value:String) : void
      {
         if(_cancelLabel == value)
         {
            return;
         }
         _cancelLabel = value;
         fireChange();
      }
      
      public function get submitEnabled() : Boolean
      {
         return _submitEnabled;
      }
      
      public function set submitEnabled(val:Boolean) : void
      {
         if(_submitEnabled != val)
         {
            _submitEnabled = val;
            fireChange();
         }
      }
      
      public function get cancelEnabled() : Boolean
      {
         return _cancelEnabled;
      }
      
      public function set cancelEnabled(val:Boolean) : void
      {
         if(_cancelEnabled != val)
         {
            _cancelEnabled = val;
            fireChange();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(value:Object) : void
      {
         if(_data == value)
         {
            return;
         }
         _data = value;
         fireChange();
      }
      
      public function get enableHtml() : Boolean
      {
         return _enableHtml;
      }
      
      public function set enableHtml(value:Boolean) : void
      {
         if(_enableHtml == value)
         {
            return;
         }
         _enableHtml = value;
         fireChange();
      }
      
      public function get enterEnable() : Boolean
      {
         return _enterEnable;
      }
      
      public function set enterEnable(value:Boolean) : void
      {
         if(_enterEnable == value)
         {
            return;
         }
         _enterEnable = value;
         fireChange();
      }
      
      public function get escEnable() : Boolean
      {
         return _escEnable;
      }
      
      public function set escEnable(value:Boolean) : void
      {
         if(_escEnable == value)
         {
            return;
         }
         _escEnable = value;
         fireChange();
      }
      
      public function get frameCenter() : Boolean
      {
         return _frameCenter;
      }
      
      public function set frameCenter(value:Boolean) : void
      {
         if(_frameCenter == value)
         {
            return;
         }
         _frameCenter = value;
         fireChange();
      }
      
      public function get moveEnable() : Boolean
      {
         return _moveEnable;
      }
      
      public function set moveEnable(value:Boolean) : void
      {
         if(_moveEnable == value)
         {
            return;
         }
         _moveEnable = value;
         fireChange();
      }
      
      public function get mutiline() : Boolean
      {
         return _mutiline;
      }
      
      public function set mutiline(value:Boolean) : void
      {
         if(_mutiline == value)
         {
            return;
         }
         _mutiline = value;
         fireChange();
      }
      
      public function get showCancel() : Boolean
      {
         return _showCancel;
      }
      
      public function set showCancel(value:Boolean) : void
      {
         if(_showCancel == value)
         {
            return;
         }
         _showCancel = value;
         fireChange();
      }
      
      public function get showSubmit() : Boolean
      {
         return _showSubmit;
      }
      
      public function set showSubmit(value:Boolean) : void
      {
         if(_showSubmit == value)
         {
            return;
         }
         _showSubmit = value;
         fireChange();
      }
      
      public function get submitLabel() : String
      {
         return _submitLabel;
      }
      
      public function set submitLabel(value:String) : void
      {
         if(_submitLabel == value)
         {
            return;
         }
         _submitLabel = value;
         fireChange();
      }
      
      public function get textShowHeight() : int
      {
         return _textShowHeight;
      }
      
      public function set textShowHeight(value:int) : void
      {
         if(_textShowHeight == value)
         {
            return;
         }
         _textShowHeight = value;
         fireChange();
      }
      
      public function get textShowWidth() : int
      {
         return _textShowWidth;
      }
      
      public function set textShowWidth(value:int) : void
      {
         if(_textShowWidth == value)
         {
            return;
         }
         _textShowWidth = value;
         fireChange();
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(value:String) : void
      {
         if(_title == value)
         {
            return;
         }
         _title = value;
         fireChange();
      }
      
      public function get sound() : *
      {
         return _soundID;
      }
      
      public function set sound(soundid:*) : void
      {
         if(_soundID == soundid)
         {
            return;
         }
         _soundID = soundid;
         fireChange();
      }
      
      private function fireChange() : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      public function get customPos() : Point
      {
         return _customPos;
      }
      
      public function set customPos(value:Point) : void
      {
         _customPos = value;
      }
      
      public function get logText() : String
      {
         return _logText;
      }
      
      public function set logText(value:String) : void
      {
         _logText = value;
      }
      
      public function get selectBtnY() : int
      {
         return _selectBtnY;
      }
      
      public function set selectBtnY(value:int) : void
      {
         _selectBtnY = value;
      }
   }
}
