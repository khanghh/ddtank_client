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
      
      public function NumericStepper(param1:int = 0, param2:String = null)
      {
         super();
         this.numValue = param1;
         this.skin = param2;
         this.mouseChildren = this.mouseEnabled = true;
      }
      
      public function get changeHandler() : Handler
      {
         return this._changeHandler;
      }
      
      public function set changeHandler(param1:Handler) : void
      {
         this._changeHandler = param1;
      }
      
      public function get step() : int
      {
         return this._step;
      }
      
      public function set step(param1:int) : void
      {
         this._step = param1;
      }
      
      public function get minValue() : int
      {
         return this._minValue;
      }
      
      public function set minValue(param1:int) : void
      {
         this._minValue = param1;
         this.checkBtnStatus();
      }
      
      public function get maxValue() : int
      {
         return this._maxValue;
      }
      
      public function set maxValue(param1:int) : void
      {
         this._maxValue = param1;
         this.checkBtnStatus();
      }
      
      public function set skin(param1:String) : void
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split(",");
            if(_loc2_.length > 0)
            {
               this.subButtonSkin = _loc2_[0];
            }
            if(_loc2_.length > 1)
            {
               this.inputTextSkin = _loc2_[1];
            }
            if(_loc2_.length > 2)
            {
               this.addButtonSkin = _loc2_[2];
            }
         }
      }
      
      public function get skin() : String
      {
         return this._btnSub.skin + "," + this._input.skin + "," + this._btnAdd.skin;
      }
      
      override protected function preinitialize() : void
      {
         this._numValue = 1;
         this._minValue = 0;
         this._maxValue = 9999;
      }
      
      override protected function createChildren() : void
      {
         this._btnSub = new Button();
         addChild(this._btnSub);
         this._input = new TextInput();
         this._input.sizeGrid = "4,4,4,1";
         addChild(this._input);
         this._btnAdd = new Button();
         addChild(this._btnAdd);
         this.layout();
      }
      
      private function layout() : void
      {
         if(this._layoutType == LAYOUT_NORMAL)
         {
            this._input.x = this._btnSub.x + this._btnSub.width + this._space;
            this._btnAdd.x = this._input.x + this._input.width + this._space;
            this._input.y = (this._btnSub.height - this._input.height) / 2 + this._btnSub.y;
            this._btnAdd.y = (this._btnSub.height - this._btnAdd.height) / 2 + this._btnSub.y;
         }
         else if(this._layoutType == LAYOUT_RIGHT)
         {
            this._btnAdd.x = this._btnSub.x = this._input.x + this._input.width + this._space;
            this._btnAdd.y = this._input.y - this._btnAdd.height / 2;
            this._btnSub.y = this._input.y + this._input.height - this._btnSub.height / 2;
         }
      }
      
      override public function commitMeasure() : void
      {
         this.layout();
      }
      
      override protected function initialize() : void
      {
         this._input.text = this._numValue.toString();
         this._input.restrict = "0-9";
         this._input.align = "center";
         this._btnSub.clickHandler = new Handler(this.btnClick,[false]);
         this._btnAdd.clickHandler = new Handler(this.btnClick,[true]);
         this._input.addEventListener(Event.CHANGE,this.onTextFieldChange);
      }
      
      private function onTextFieldChange(param1:Event) : void
      {
         if(this._input.text == "")
         {
            this._input.text = "1";
         }
         if(parseInt(this._input.text) <= this.minValue)
         {
            this._input.text = this.minValue.toString();
         }
         else if(parseInt(this._input.text) >= this.maxValue)
         {
            this._input.text = this.maxValue.toString();
         }
         this.numValue = parseInt(this._input.text);
         this.checkBtnStatus();
      }
      
      private function btnClick(param1:Boolean) : void
      {
         if(param1)
         {
            this.numValue = this.numValue + this._step;
            this._btnSub.disabled = false;
         }
         else
         {
            this.numValue = this.numValue - this._step;
            this._btnAdd.disabled = false;
         }
         this.checkBtnStatus();
      }
      
      private function checkBtnStatus() : void
      {
         this._btnAdd.disabled = false;
         this._btnSub.disabled = false;
         if(this.numValue >= this._maxValue)
         {
            this._btnAdd.disabled = true;
         }
         if(this.numValue <= this._minValue)
         {
            this._btnSub.disabled = true;
         }
      }
      
      public function set subButtonSkin(param1:String) : void
      {
         this._btnSub.skin = param1;
         this._btnSub.stateNum = 1;
         this.commitMeasure();
      }
      
      public function get subButtonSkin() : String
      {
         return this._btnSub.skin;
      }
      
      public function set addButtonSkin(param1:String) : void
      {
         this._btnAdd.skin = param1;
         this._btnAdd.stateNum = 1;
         this.commitMeasure();
      }
      
      public function get addButtonSkin() : String
      {
         return this._btnAdd.skin;
      }
      
      public function set inputTextSkin(param1:String) : void
      {
         this._input.skin = param1;
         this.commitMeasure();
      }
      
      public function get inputTextSkin() : String
      {
         return this._input.skin;
      }
      
      public function set spacing(param1:int) : void
      {
         this._space = param1;
         this.commitMeasure();
      }
      
      public function get spacing() : int
      {
         return this._space;
      }
      
      public function get maxChars() : int
      {
         return this._input.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         this._input.maxChars = param1;
      }
      
      public function get stroke() : String
      {
         return this._input.stroke;
      }
      
      public function set stroke(param1:String) : void
      {
         this._input.stroke = param1;
      }
      
      public function get color() : Object
      {
         return this._input.color;
      }
      
      public function set color(param1:Object) : void
      {
         this._input.color = param1;
      }
      
      public function get font() : String
      {
         return this._input.font;
      }
      
      public function set font(param1:String) : void
      {
         this._input.font = param1;
      }
      
      public function get bold() : Object
      {
         return this._input.bold;
      }
      
      public function set bold(param1:Object) : void
      {
         this._input.bold = param1;
      }
      
      public function get margin() : String
      {
         return this._input.margin;
      }
      
      public function set margin(param1:String) : void
      {
         this._input.margin = param1;
      }
      
      public function get size() : Object
      {
         return this._input.size;
      }
      
      public function set size(param1:Object) : void
      {
         this._input.size = param1;
      }
      
      public function get inputWidth() : Number
      {
         return this._input.width;
      }
      
      public function set inputWidht(param1:Number) : void
      {
         this._input.width = param1;
         this.commitMeasure();
      }
      
      public function set numValue(param1:int) : void
      {
         this._numValue = param1;
         this.checkBtnStatus();
         this._input.text = this._numValue.toString();
         if(this._changeHandler)
         {
            this._changeHandler.executeWith([this._numValue]);
         }
      }
      
      public function get numValue() : int
      {
         return this._numValue;
      }
      
      public function get layoutType() : int
      {
         return this._layoutType;
      }
      
      public function set layoutType(param1:int) : void
      {
         this._layoutType = param1;
         this.layout();
      }
      
      override public function dispose() : void
      {
         this._input.removeEventListener(Event.CHANGE,this.onTextFieldChange);
         ObjectUtils.disposeObject(this._input);
         this._input = null;
         ObjectUtils.disposeObject(this._btnSub);
         this._btnSub = null;
         ObjectUtils.disposeObject(this._btnAdd);
         this._btnAdd = null;
      }
   }
}
