package com.pickgliss.ui.controls{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.text.TextField;      public class NumberSelecter extends Component   {            public static const P_back:String = "P_back";            public static const P_upStyle:String = "P_upStyle";            public static const P_downStyle:String = "P_downStyle";            public static const P_targetFieldStyle:String = "P_targetFieldStyle";                   private var _back:DisplayObject;            private var _backStyle:String;            private var _upDisplay:DisplayObject;            private var _upStyle:String;            private var _downDisplay:DisplayObject;            private var _downStyle:String;            private var _targetField:TextField;            private var _targetFieldStyle:String;            private var _currentValue:Number;            private var _increment:Number = 1;            protected var _valueLimit:Point;            public function NumberSelecter() { super(); }
            public function set valueLimit(value:String) : void { }
            public function get currentValue() : Number { return 0; }
            public function get increment() : Number { return 0; }
            public function set increment(value:Number) : void { }
            public function get targetFieldStyle() : String { return null; }
            public function set targetFieldStyle(stylename:String) : void { }
            public function set targetField(targetField:TextField) : void { }
            public function get upStyle() : String { return null; }
            public function set upStyle(stylename:String) : void { }
            public function set upDisplay(upDisplay:DisplayObject) : void { }
            public function get downStyle() : String { return null; }
            public function set downStyle(stylename:String) : void { }
            public function set downDisplay(downDisplay:DisplayObject) : void { }
            public function get downDisplay() : DisplayObject { return null; }
            public function get upDisplay() : DisplayObject { return null; }
            override protected function addChildren() : void { }
            private function __fieldChange(event:Event) : void { }
            override protected function onProppertiesUpdate() : void { }
            private function setReduceBtnState() : void { }
            protected function __targetFieldChange(event:Event) : void { }
            private function __onMouseWheel(event:MouseEvent) : void { }
            public function set back(display:DisplayObject) : void { }
            public function set backStyle(stylename:String) : void { }
            public function validate(e:FocusEvent = null) : void { }
            public function set currentValue(value:Number) : void { }
            private function setText(value:int) : void { }
            override public function dispose() : void { }
   }}