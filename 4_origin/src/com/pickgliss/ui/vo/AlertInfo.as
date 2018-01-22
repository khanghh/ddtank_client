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
      
      public function AlertInfo(param1:String = "", param2:String = "Đồng ý", param3:String = "Hủy bỏ", param4:Boolean = true, param5:Boolean = true, param6:Object = null, param7:Boolean = true, param8:Boolean = true, param9:Boolean = true, param10:Boolean = true, param11:int = 20, param12:int = 30, param13:Boolean = false, param14:int = 0)
      {
         _buttonGape = ComponentSetting.ALERT_BUTTON_GAPE;
         super();
         title = param1;
         type = param14;
         submitLabel = param2;
         cancelLabel = param3;
         showSubmit = param4;
         showCancel = param5;
         data = param6;
         frameCenter = param7;
         moveEnable = param8;
         enterEnable = param9;
         escEnable = param10;
         bottomGap = param11;
         buttonGape = param12;
         autoDispose = param13;
      }
      
      public function get autoButtonGape() : Boolean
      {
         return _autoButtonGape;
      }
      
      public function set autoButtonGape(param1:Boolean) : void
      {
         if(_autoButtonGape == param1)
         {
            return;
         }
         _autoButtonGape = param1;
         fireChange();
      }
      
      public function get autoDispose() : Boolean
      {
         return _autoDispose;
      }
      
      public function set autoDispose(param1:Boolean) : void
      {
         if(_autoDispose == param1)
         {
            return;
         }
         _autoDispose = param1;
         fireChange();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
         fireChange();
      }
      
      public function get bottomGap() : int
      {
         return _bottomGap;
      }
      
      public function set bottomGap(param1:int) : void
      {
         if(_bottomGap == param1)
         {
            return;
         }
         _bottomGap = param1;
         fireChange();
      }
      
      public function get buttonGape() : int
      {
         return _buttonGape;
      }
      
      public function set buttonGape(param1:int) : void
      {
         if(_buttonGape == param1)
         {
            return;
         }
         _buttonGape = param1;
         fireChange();
      }
      
      public function get cancelLabel() : String
      {
         return _cancelLabel;
      }
      
      public function set cancelLabel(param1:String) : void
      {
         if(_cancelLabel == param1)
         {
            return;
         }
         _cancelLabel = param1;
         fireChange();
      }
      
      public function get submitEnabled() : Boolean
      {
         return _submitEnabled;
      }
      
      public function set submitEnabled(param1:Boolean) : void
      {
         if(_submitEnabled != param1)
         {
            _submitEnabled = param1;
            fireChange();
         }
      }
      
      public function get cancelEnabled() : Boolean
      {
         return _cancelEnabled;
      }
      
      public function set cancelEnabled(param1:Boolean) : void
      {
         if(_cancelEnabled != param1)
         {
            _cancelEnabled = param1;
            fireChange();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         fireChange();
      }
      
      public function get enableHtml() : Boolean
      {
         return _enableHtml;
      }
      
      public function set enableHtml(param1:Boolean) : void
      {
         if(_enableHtml == param1)
         {
            return;
         }
         _enableHtml = param1;
         fireChange();
      }
      
      public function get enterEnable() : Boolean
      {
         return _enterEnable;
      }
      
      public function set enterEnable(param1:Boolean) : void
      {
         if(_enterEnable == param1)
         {
            return;
         }
         _enterEnable = param1;
         fireChange();
      }
      
      public function get escEnable() : Boolean
      {
         return _escEnable;
      }
      
      public function set escEnable(param1:Boolean) : void
      {
         if(_escEnable == param1)
         {
            return;
         }
         _escEnable = param1;
         fireChange();
      }
      
      public function get frameCenter() : Boolean
      {
         return _frameCenter;
      }
      
      public function set frameCenter(param1:Boolean) : void
      {
         if(_frameCenter == param1)
         {
            return;
         }
         _frameCenter = param1;
         fireChange();
      }
      
      public function get moveEnable() : Boolean
      {
         return _moveEnable;
      }
      
      public function set moveEnable(param1:Boolean) : void
      {
         if(_moveEnable == param1)
         {
            return;
         }
         _moveEnable = param1;
         fireChange();
      }
      
      public function get mutiline() : Boolean
      {
         return _mutiline;
      }
      
      public function set mutiline(param1:Boolean) : void
      {
         if(_mutiline == param1)
         {
            return;
         }
         _mutiline = param1;
         fireChange();
      }
      
      public function get showCancel() : Boolean
      {
         return _showCancel;
      }
      
      public function set showCancel(param1:Boolean) : void
      {
         if(_showCancel == param1)
         {
            return;
         }
         _showCancel = param1;
         fireChange();
      }
      
      public function get showSubmit() : Boolean
      {
         return _showSubmit;
      }
      
      public function set showSubmit(param1:Boolean) : void
      {
         if(_showSubmit == param1)
         {
            return;
         }
         _showSubmit = param1;
         fireChange();
      }
      
      public function get submitLabel() : String
      {
         return _submitLabel;
      }
      
      public function set submitLabel(param1:String) : void
      {
         if(_submitLabel == param1)
         {
            return;
         }
         _submitLabel = param1;
         fireChange();
      }
      
      public function get textShowHeight() : int
      {
         return _textShowHeight;
      }
      
      public function set textShowHeight(param1:int) : void
      {
         if(_textShowHeight == param1)
         {
            return;
         }
         _textShowHeight = param1;
         fireChange();
      }
      
      public function get textShowWidth() : int
      {
         return _textShowWidth;
      }
      
      public function set textShowWidth(param1:int) : void
      {
         if(_textShowWidth == param1)
         {
            return;
         }
         _textShowWidth = param1;
         fireChange();
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         if(_title == param1)
         {
            return;
         }
         _title = param1;
         fireChange();
      }
      
      public function get sound() : *
      {
         return _soundID;
      }
      
      public function set sound(param1:*) : void
      {
         if(_soundID == param1)
         {
            return;
         }
         _soundID = param1;
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
      
      public function set customPos(param1:Point) : void
      {
         _customPos = param1;
      }
      
      public function get logText() : String
      {
         return _logText;
      }
      
      public function set logText(param1:String) : void
      {
         _logText = param1;
      }
      
      public function get selectBtnY() : int
      {
         return _selectBtnY;
      }
      
      public function set selectBtnY(param1:int) : void
      {
         _selectBtnY = param1;
      }
   }
}
