package com.pickgliss.ui.controls.alert{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class BaseAlerFrame extends Frame   {            public static const P_buttonToBottom:String = "buttonToBottom";            public static const P_cancelButton:String = "submitButton";            public static const P_info:String = "info";            public static const P_submitButton:String = "submitButton";                   protected var _buttonToBottom:int;            protected var _cancelButton:BaseButton;            protected var _cancelButtonStyle:String;            protected var _info:AlertInfo;            protected var _sound;            protected var _submitButton:BaseButton;            protected var _submitButtonStyle:String;            protected var _isBand:Boolean;            protected var _isShowTheLog:Boolean;            protected var _selectedCheckBtn:SelectedCheckButton;            public function BaseAlerFrame() { super(); }
            public function set buttonToBottom(value:int) : void { }
            public function set cancelButtonEnable(value:Boolean) : void { }
            public function set cancelButtonStyle(stylename:String) : void { }
            override public function dispose() : void { }
            public function get info() : AlertInfo { return null; }
            public function get isBand() : Boolean { return false; }
            public function set isBand(b:Boolean) : void { }
            public function set info(value:AlertInfo) : void { }
            public function setIsShowTheLog(value:Boolean, logText:String) : void { }
            protected function creatTheLog() : void { }
            public function set submitButtonEnable(value:Boolean) : void { }
            public function set submitButtonStyle(stylename:String) : void { }
            protected function __onCancelClick(event:MouseEvent) : void { }
            override protected function __onCloseClick(event:MouseEvent) : void { }
            override protected function __onKeyDown(event:KeyboardEvent) : void { }
            protected function __onSubmitClick(event:MouseEvent) : void { }
            override protected function addChildren() : void { }
            override protected function onProppertiesUpdate() : void { }
            override protected function onResponse(type:int) : void { }
            protected function updatePos() : void { }
            private function __onInfoChanged(event:InteractiveEvent) : void { }
            public function get selectedCheckButton() : SelectedCheckButton { return null; }
   }}