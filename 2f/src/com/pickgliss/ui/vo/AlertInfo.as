package com.pickgliss.ui.vo{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentSetting;   import flash.events.EventDispatcher;   import flash.geom.Point;      public class AlertInfo extends EventDispatcher   {            public static const CANCEL_LABEL:String = "Hủy bỏ";            public static const SUBMIT_LABEL:String = "Đồng ý";                   private var _type:int;            private var _selectBtnY:int;            private var _customPos:Point;            private var _autoButtonGape:Boolean = true;            private var _autoDispose:Boolean = false;            private var _bottomGap:int;            private var _buttonGape:int;            private var _cancelLabel:String = "Hủy bỏ";            private var _data:Object;            private var _enableHtml:Boolean;            private var _enterEnable:Boolean = true;            private var _escEnable:Boolean = true;            private var _frameCenter:Boolean = true;            private var _moveEnable:Boolean = true;            private var _mutiline:Boolean;            private var _showCancel:Boolean = true;            private var _showSubmit:Boolean = true;            private var _submitEnabled:Boolean = true;            private var _cancelEnabled:Boolean = true;            private var _submitLabel:String = "Đồng ý";            private var _textShowHeight:int;            private var _textShowWidth:int;            private var _title:String;            private var _logText:String;            private var _soundID;            public function AlertInfo($title:String = "", $submitLabel:String = "Đồng ý", $cancelLabel:String = "Hủy bỏ", $showSubmit:Boolean = true, $showCancel:Boolean = true, $data:Object = null, $center:Boolean = true, $movable:Boolean = true, $enableEnter:Boolean = true, $enableEsc:Boolean = true, $bottomGap:int = 20, $buttonGape:int = 30, $autoDispose:Boolean = false, $type:int = 0) { super(); }
            public function get autoButtonGape() : Boolean { return false; }
            public function set autoButtonGape(value:Boolean) : void { }
            public function get autoDispose() : Boolean { return false; }
            public function set autoDispose(value:Boolean) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get bottomGap() : int { return 0; }
            public function set bottomGap(value:int) : void { }
            public function get buttonGape() : int { return 0; }
            public function set buttonGape(value:int) : void { }
            public function get cancelLabel() : String { return null; }
            public function set cancelLabel(value:String) : void { }
            public function get submitEnabled() : Boolean { return false; }
            public function set submitEnabled(val:Boolean) : void { }
            public function get cancelEnabled() : Boolean { return false; }
            public function set cancelEnabled(val:Boolean) : void { }
            public function get data() : Object { return null; }
            public function set data(value:Object) : void { }
            public function get enableHtml() : Boolean { return false; }
            public function set enableHtml(value:Boolean) : void { }
            public function get enterEnable() : Boolean { return false; }
            public function set enterEnable(value:Boolean) : void { }
            public function get escEnable() : Boolean { return false; }
            public function set escEnable(value:Boolean) : void { }
            public function get frameCenter() : Boolean { return false; }
            public function set frameCenter(value:Boolean) : void { }
            public function get moveEnable() : Boolean { return false; }
            public function set moveEnable(value:Boolean) : void { }
            public function get mutiline() : Boolean { return false; }
            public function set mutiline(value:Boolean) : void { }
            public function get showCancel() : Boolean { return false; }
            public function set showCancel(value:Boolean) : void { }
            public function get showSubmit() : Boolean { return false; }
            public function set showSubmit(value:Boolean) : void { }
            public function get submitLabel() : String { return null; }
            public function set submitLabel(value:String) : void { }
            public function get textShowHeight() : int { return 0; }
            public function set textShowHeight(value:int) : void { }
            public function get textShowWidth() : int { return 0; }
            public function set textShowWidth(value:int) : void { }
            public function get title() : String { return null; }
            public function set title(value:String) : void { }
            public function get sound() : * { return null; }
            public function set sound(soundid:*) : void { }
            private function fireChange() : void { }
            public function get customPos() : Point { return null; }
            public function set customPos(value:Point) : void { }
            public function get logText() : String { return null; }
            public function set logText(value:String) : void { }
            public function get selectBtnY() : int { return 0; }
            public function set selectBtnY(value:int) : void { }
   }}