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
      
      public function AlertInfo(param1:String = "", param2:String = "Đồng ý", param3:String = "Hủy bỏ", param4:Boolean = true, param5:Boolean = true, param6:Object = null, param7:Boolean = true, param8:Boolean = true, param9:Boolean = true, param10:Boolean = true, param11:int = 20, param12:int = 30, param13:Boolean = false, param14:int = 0){super();}
      
      public function get autoButtonGape() : Boolean{return false;}
      
      public function set autoButtonGape(param1:Boolean) : void{}
      
      public function get autoDispose() : Boolean{return false;}
      
      public function set autoDispose(param1:Boolean) : void{}
      
      public function get type() : int{return 0;}
      
      public function set type(param1:int) : void{}
      
      public function get bottomGap() : int{return 0;}
      
      public function set bottomGap(param1:int) : void{}
      
      public function get buttonGape() : int{return 0;}
      
      public function set buttonGape(param1:int) : void{}
      
      public function get cancelLabel() : String{return null;}
      
      public function set cancelLabel(param1:String) : void{}
      
      public function get submitEnabled() : Boolean{return false;}
      
      public function set submitEnabled(param1:Boolean) : void{}
      
      public function get cancelEnabled() : Boolean{return false;}
      
      public function set cancelEnabled(param1:Boolean) : void{}
      
      public function get data() : Object{return null;}
      
      public function set data(param1:Object) : void{}
      
      public function get enableHtml() : Boolean{return false;}
      
      public function set enableHtml(param1:Boolean) : void{}
      
      public function get enterEnable() : Boolean{return false;}
      
      public function set enterEnable(param1:Boolean) : void{}
      
      public function get escEnable() : Boolean{return false;}
      
      public function set escEnable(param1:Boolean) : void{}
      
      public function get frameCenter() : Boolean{return false;}
      
      public function set frameCenter(param1:Boolean) : void{}
      
      public function get moveEnable() : Boolean{return false;}
      
      public function set moveEnable(param1:Boolean) : void{}
      
      public function get mutiline() : Boolean{return false;}
      
      public function set mutiline(param1:Boolean) : void{}
      
      public function get showCancel() : Boolean{return false;}
      
      public function set showCancel(param1:Boolean) : void{}
      
      public function get showSubmit() : Boolean{return false;}
      
      public function set showSubmit(param1:Boolean) : void{}
      
      public function get submitLabel() : String{return null;}
      
      public function set submitLabel(param1:String) : void{}
      
      public function get textShowHeight() : int{return 0;}
      
      public function set textShowHeight(param1:int) : void{}
      
      public function get textShowWidth() : int{return 0;}
      
      public function set textShowWidth(param1:int) : void{}
      
      public function get title() : String{return null;}
      
      public function set title(param1:String) : void{}
      
      public function get sound() : *{return null;}
      
      public function set sound(param1:*) : void{}
      
      private function fireChange() : void{}
      
      public function get customPos() : Point{return null;}
      
      public function set customPos(param1:Point) : void{}
      
      public function get logText() : String{return null;}
      
      public function set logText(param1:String) : void{}
      
      public function get selectBtnY() : int{return 0;}
      
      public function set selectBtnY(param1:int) : void{}
   }
}
