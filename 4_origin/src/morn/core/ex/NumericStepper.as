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
      
      public function NumericStepper(value:int = 0, skin:String = null)
      {
         super();
         this.numValue = value;
         this.skin = skin;
         var _loc3_:Boolean = true;
         this.mouseEnabled = _loc3_;
         this.mouseChildren = _loc3_;
      }
      
      public function get changeHandler() : Handler
      {
         return _changeHandler;
      }
      
      public function set changeHandler(value:Handler) : void
      {
         _changeHandler = value;
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(value:int) : void
      {
         _step = value;
      }
      
      public function get minValue() : int
      {
         return _minValue;
      }
      
      public function set minValue(value:int) : void
      {
         _minValue = value;
         checkBtnStatus();
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function set maxValue(value:int) : void
      {
         _maxValue = value;
         checkBtnStatus();
      }
      
      public function set skin(value:String) : void
      {
         var arr:* = null;
         if(value != null)
         {
            arr = value.split(",");
            if(arr.length > 0)
            {
               subButtonSkin = arr[0];
            }
            if(arr.length > 1)
            {
               inputTextSkin = arr[1];
            }
            if(arr.length > 2)
            {
               addButtonSkin = arr[2];
            }
         }
      }
      
      public function get skin() : String
      {
         return _btnSub.skin + "," + _input.skin + "," + _btnAdd.skin;
      }
      
      override protected function preinitialize() : void
      {
         _numValue = 1;
         _minValue = 0;
         _maxValue = 9999;
      }
      
      override protected function createChildren() : void
      {
         _btnSub = new Button();
         addChild(_btnSub);
         _input = new TextInput();
         _input.sizeGrid = "4,4,4,1";
         addChild(_input);
         _btnAdd = new Button();
         addChild(_btnAdd);
         layout();
      }
      
      private function layout() : void
      {
         if(_layoutType == 1)
         {
            _input.x = _btnSub.x + _btnSub.width + _space;
            _btnAdd.x = _input.x + _input.width + _space;
            _input.y = (_btnSub.height - _input.height) / 2 + _btnSub.y;
            _btnAdd.y = (_btnSub.height - _btnAdd.height) / 2 + _btnSub.y;
         }
         else if(_layoutType == 2)
         {
            var _loc1_:* = _input.x + _input.width + _space;
            _btnSub.x = _loc1_;
            _btnAdd.x = _loc1_;
            _btnAdd.y = _input.y - _btnAdd.height / 2;
            _btnSub.y = _input.y + _input.height - _btnSub.height / 2;
         }
      }
      
      override public function commitMeasure() : void
      {
         layout();
      }
      
      override protected function initialize() : void
      {
         _input.text = _numValue.toString();
         _input.restrict = "0-9";
         _input.align = "center";
         _btnSub.clickHandler = new Handler(btnClick,[false]);
         _btnAdd.clickHandler = new Handler(btnClick,[true]);
         _input.addEventListener("change",onTextFieldChange);
      }
      
      private function onTextFieldChange(evt:Event) : void
      {
         if(_input.text == "")
         {
            _input.text = "1";
         }
         if(parseInt(_input.text) <= minValue)
         {
            _input.text = minValue.toString();
         }
         else if(parseInt(_input.text) >= maxValue)
         {
            _input.text = maxValue.toString();
         }
         numValue = parseInt(_input.text);
         checkBtnStatus();
      }
      
      private function btnClick(isAdd:Boolean) : void
      {
         if(isAdd)
         {
            numValue = numValue + _step;
            _btnSub.disabled = false;
         }
         else
         {
            numValue = numValue - _step;
            _btnAdd.disabled = false;
         }
         checkBtnStatus();
      }
      
      private function checkBtnStatus() : void
      {
         _btnAdd.disabled = false;
         _btnSub.disabled = false;
         if(numValue >= _maxValue)
         {
            _btnAdd.disabled = true;
         }
         if(numValue <= _minValue)
         {
            _btnSub.disabled = true;
         }
      }
      
      public function set subButtonSkin(value:String) : void
      {
         _btnSub.skin = value;
         _btnSub.stateNum = 1;
         commitMeasure();
      }
      
      public function get subButtonSkin() : String
      {
         return _btnSub.skin;
      }
      
      public function set addButtonSkin(value:String) : void
      {
         _btnAdd.skin = value;
         _btnAdd.stateNum = 1;
         commitMeasure();
      }
      
      public function get addButtonSkin() : String
      {
         return _btnAdd.skin;
      }
      
      public function set inputTextSkin(value:String) : void
      {
         _input.skin = value;
         commitMeasure();
      }
      
      public function get inputTextSkin() : String
      {
         return _input.skin;
      }
      
      public function set spacing(value:int) : void
      {
         _space = value;
         commitMeasure();
      }
      
      public function get spacing() : int
      {
         return _space;
      }
      
      public function get maxChars() : int
      {
         return _input.maxChars;
      }
      
      public function set maxChars(value:int) : void
      {
         _input.maxChars = value;
      }
      
      public function get stroke() : String
      {
         return _input.stroke;
      }
      
      public function set stroke(value:String) : void
      {
         _input.stroke = value;
      }
      
      public function get color() : Object
      {
         return _input.color;
      }
      
      public function set color(value:Object) : void
      {
         _input.color = value;
      }
      
      public function get font() : String
      {
         return _input.font;
      }
      
      public function set font(value:String) : void
      {
         _input.font = value;
      }
      
      public function get bold() : Object
      {
         return _input.bold;
      }
      
      public function set bold(value:Object) : void
      {
         _input.bold = value;
      }
      
      public function get margin() : String
      {
         return _input.margin;
      }
      
      public function set margin(value:String) : void
      {
         _input.margin = value;
      }
      
      public function get size() : Object
      {
         return _input.size;
      }
      
      public function set size(value:Object) : void
      {
         _input.size = value;
      }
      
      public function get inputWidth() : Number
      {
         return _input.width;
      }
      
      public function set inputWidht(value:Number) : void
      {
         _input.width = value;
         commitMeasure();
      }
      
      public function set numValue(value:int) : void
      {
         _numValue = value;
         checkBtnStatus();
         _input.text = _numValue.toString();
         if(_changeHandler)
         {
            _changeHandler.executeWith([_numValue]);
         }
      }
      
      public function get numValue() : int
      {
         return _numValue;
      }
      
      public function get layoutType() : int
      {
         return _layoutType;
      }
      
      public function set layoutType(value:int) : void
      {
         _layoutType = value;
         layout();
      }
      
      override public function dispose() : void
      {
         _input.removeEventListener("change",onTextFieldChange);
         ObjectUtils.disposeObject(_input);
         _input = null;
         ObjectUtils.disposeObject(_btnSub);
         _btnSub = null;
         ObjectUtils.disposeObject(_btnAdd);
         _btnAdd = null;
      }
   }
}
