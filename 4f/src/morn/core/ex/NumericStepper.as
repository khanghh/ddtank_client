package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import morn.core.components.Button;
   import morn.core.components.Component;
   import morn.core.components.TextInput;
   import morn.core.handlers.Handler;
   
   public class NumericStepper extends Component
   {
      
      public static const LAYOUT_NORMAL:int = 1;
      
      public static const LAYOUT_RIGHT:int = 2;
       
      
      private var _numValue:int = 0;
      
      private var _step:int = 1;
      
      private var _space:int = 0;
      
      private var _input:TextInput = null;
      
      private var _btnSub:Button = null;
      
      private var _btnAdd:Button = null;
      
      private var _changeHandler:Handler = null;
      
      private var _maxValue:int = 2147483647;
      
      private var _minValue:int = -2147483648;
      
      private var _layoutType:int = 1;
      
      public function NumericStepper(param1:int = 0, param2:String = null){super();}
      
      public function get changeHandler() : Handler{return null;}
      
      public function set changeHandler(param1:Handler) : void{}
      
      public function get step() : int{return 0;}
      
      public function set step(param1:int) : void{}
      
      public function get minValue() : int{return 0;}
      
      public function set minValue(param1:int) : void{}
      
      public function get maxValue() : int{return 0;}
      
      public function set maxValue(param1:int) : void{}
      
      public function set skin(param1:String) : void{}
      
      public function get skin() : String{return null;}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      private function layout() : void{}
      
      override public function commitMeasure() : void{}
      
      override protected function initialize() : void{}
      
      private function onTextFieldChange(param1:Event) : void{}
      
      private function btnClick(param1:Boolean) : void{}
      
      private function checkBtnStatus() : void{}
      
      public function set subButtonSkin(param1:String) : void{}
      
      public function get subButtonSkin() : String{return null;}
      
      public function set addButtonSkin(param1:String) : void{}
      
      public function get addButtonSkin() : String{return null;}
      
      public function set inputTextSkin(param1:String) : void{}
      
      public function get inputTextSkin() : String{return null;}
      
      public function set spacing(param1:int) : void{}
      
      public function get spacing() : int{return 0;}
      
      public function get maxChars() : int{return 0;}
      
      public function set maxChars(param1:int) : void{}
      
      public function get stroke() : String{return null;}
      
      public function set stroke(param1:String) : void{}
      
      public function get color() : Object{return null;}
      
      public function set color(param1:Object) : void{}
      
      public function get font() : String{return null;}
      
      public function set font(param1:String) : void{}
      
      public function get bold() : Object{return null;}
      
      public function set bold(param1:Object) : void{}
      
      public function get margin() : String{return null;}
      
      public function set margin(param1:String) : void{}
      
      public function get size() : Object{return null;}
      
      public function set size(param1:Object) : void{}
      
      public function get inputWidth() : Number{return 0;}
      
      public function set inputWidht(param1:Number) : void{}
      
      public function set numValue(param1:int) : void{}
      
      public function get numValue() : int{return 0;}
      
      public function get layoutType() : int{return 0;}
      
      public function set layoutType(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
