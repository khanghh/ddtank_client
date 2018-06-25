package morn.core.ex{   import com.pickgliss.utils.ObjectUtils;   import flash.events.Event;   import morn.core.components.Button;   import morn.core.components.Component;   import morn.core.components.TextInput;   import morn.core.handlers.Handler;      public class NumericStepper extends Component   {            public static const LAYOUT_NORMAL:int = 1;            public static const LAYOUT_RIGHT:int = 2;                   private var _numValue:int = 0;            private var _step:int = 1;            private var _space:int = 0;            private var _input:TextInput = null;            private var _btnSub:Button = null;            private var _btnAdd:Button = null;            private var _changeHandler:Handler = null;            private var _maxValue:int = 2147483647;            private var _minValue:int = -2147483648;            private var _layoutType:int = 1;            public function NumericStepper(value:int = 0, skin:String = null) { super(); }
            public function get changeHandler() : Handler { return null; }
            public function set changeHandler(value:Handler) : void { }
            public function get step() : int { return 0; }
            public function set step(value:int) : void { }
            public function get minValue() : int { return 0; }
            public function set minValue(value:int) : void { }
            public function get maxValue() : int { return 0; }
            public function set maxValue(value:int) : void { }
            public function set skin(value:String) : void { }
            public function get skin() : String { return null; }
            override protected function preinitialize() : void { }
            override protected function createChildren() : void { }
            private function layout() : void { }
            override public function commitMeasure() : void { }
            override protected function initialize() : void { }
            private function onTextFieldChange(evt:Event) : void { }
            private function btnClick(isAdd:Boolean) : void { }
            private function checkBtnStatus() : void { }
            public function set subButtonSkin(value:String) : void { }
            public function get subButtonSkin() : String { return null; }
            public function set addButtonSkin(value:String) : void { }
            public function get addButtonSkin() : String { return null; }
            public function set inputTextSkin(value:String) : void { }
            public function get inputTextSkin() : String { return null; }
            public function set spacing(value:int) : void { }
            public function get spacing() : int { return 0; }
            public function get maxChars() : int { return 0; }
            public function set maxChars(value:int) : void { }
            public function get stroke() : String { return null; }
            public function set stroke(value:String) : void { }
            public function get color() : Object { return null; }
            public function set color(value:Object) : void { }
            public function get font() : String { return null; }
            public function set font(value:String) : void { }
            public function get bold() : Object { return null; }
            public function set bold(value:Object) : void { }
            public function get margin() : String { return null; }
            public function set margin(value:String) : void { }
            public function get size() : Object { return null; }
            public function set size(value:Object) : void { }
            public function get inputWidth() : Number { return 0; }
            public function set inputWidht(value:Number) : void { }
            public function set numValue(value:int) : void { }
            public function get numValue() : int { return 0; }
            public function get layoutType() : int { return 0; }
            public function set layoutType(value:int) : void { }
            override public function dispose() : void { }
   }}