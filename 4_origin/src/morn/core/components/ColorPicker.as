package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ColorPicker extends Component
   {
       
      
      protected var _gridSize:int = 11;
      
      protected var _panelBgColor:uint = 16777215;
      
      protected var _panelBorderColor:uint = 0;
      
      protected var _panelTextColor:uint = 0;
      
      protected var _panelTextBgColor:uint = 15724527;
      
      protected var _colorPanel:Box;
      
      protected var _colorTiles:Sprite;
      
      protected var _colorBlock:Shape;
      
      protected var _colorField:TextField;
      
      protected var _colorButton:Button;
      
      protected var _colors:Array;
      
      protected var _selectedColor:int = -1;
      
      protected var _changeHandler:Handler;
      
      public function ColorPicker()
      {
         this._colors = [];
         super();
         mouseChildren = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._colorPanel && this._colorPanel.dispose();
         this._colorButton && this._colorButton.dispose();
         this._colorPanel = null;
         this._colorTiles = null;
         this._colorBlock = null;
         this._colorField = null;
         this._colorButton = null;
         this._colors = null;
         this._changeHandler = null;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._colorButton = new Button());
         this._colorPanel = new Box();
         this._colorPanel.setSize(230,166);
         this._colorPanel.addChild(this._colorTiles = new Sprite());
         this._colorPanel.addChild(this._colorBlock = new Shape());
         this._colorPanel.addChild(this._colorField = new TextField());
      }
      
      override protected function initialize() : void
      {
         this._colorButton.addEventListener(MouseEvent.CLICK,this.onColorButtonClick);
         this._colorBlock.x = this._colorBlock.y = 5;
         this._colorField.x = 60;
         this._colorField.y = 5;
         this._colorField.width = 50;
         this._colorField.height = 20;
         this._colorField.border = true;
         this._colorField.background = true;
         this._colorField.type = TextFieldType.INPUT;
         this._colorField.addEventListener(Event.CHANGE,this.onColorFieldChange);
         this._colorField.addEventListener(KeyboardEvent.KEY_DOWN,this.onColorFieldKeyDown);
         this._colorTiles.x = 5;
         this._colorTiles.y = 30;
         this._colorTiles.addEventListener(MouseEvent.MOUSE_MOVE,this.onColorTilesMouseMove);
         this._colorTiles.addEventListener(MouseEvent.CLICK,this.onColorTilesClick);
         this.panelBgColor = this._panelBgColor;
      }
      
      protected function changePanel() : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:Graphics = this._colorPanel.graphics;
         _loc1_.clear();
         _loc1_.beginFill(this._panelBgColor);
         _loc1_.drawRect(0,0,230,166);
         _loc1_.endFill();
         _loc1_.lineStyle(1,this._panelBorderColor);
         _loc1_.drawRect(0,0,230,166);
         this.drawBlock(this._selectedColor);
         this._colorField.borderColor = this._panelBorderColor;
         this._colorField.backgroundColor = this._panelTextBgColor;
         this._colorField.textColor = this._panelTextColor;
         _loc1_ = this._colorTiles.graphics;
         _loc1_.clear();
         var _loc2_:Array = [0,3355443,6710886,10066329,13421772,16777215,16711680,65280,255,16776960,65535,16711935];
         var _loc3_:int = 0;
         while(_loc3_ < 12)
         {
            _loc4_ = 0;
            while(_loc4_ < 20)
            {
               if(_loc4_ == 0)
               {
                  _loc5_ = _loc2_[_loc3_];
               }
               else if(_loc4_ == 1)
               {
                  _loc5_ = 0;
               }
               else
               {
                  _loc5_ = (((_loc3_ * 3 + _loc4_ / 6) % 3 << 0) + (_loc3_ / 6 << 0) * 3) * 51 << 16 | _loc4_ % 6 * 51 << 8 | (_loc3_ << 0) % 6 * 51;
               }
               this._colors.push(_loc5_);
               _loc6_ = _loc4_ * this._gridSize;
               _loc7_ = _loc3_ * this._gridSize;
               _loc1_.beginFill(0);
               _loc1_.drawRect(_loc6_,_loc7_,this._gridSize,this._gridSize);
               _loc1_.endFill();
               _loc1_.beginFill(_loc5_);
               _loc1_.drawRect(_loc6_ + 1,_loc7_ + 1,this._gridSize - 1,this._gridSize - 1);
               _loc1_.endFill();
               _loc4_++;
            }
            _loc3_++;
         }
         _loc1_.lineStyle(1,0,1,true);
         _loc1_.moveTo(this._gridSize * 20,0);
         _loc1_.lineTo(this._gridSize * 20,this._gridSize * 12);
         _loc1_.moveTo(0,this._gridSize * 12);
         _loc1_.lineTo(this._gridSize * 20,this._gridSize * 12);
      }
      
      private function onColorButtonClick(param1:MouseEvent) : void
      {
         if(this._colorPanel.parent)
         {
            this.close();
         }
         else
         {
            this.open();
         }
      }
      
      public function open() : void
      {
         var _loc1_:Point = localToGlobal(new Point());
         var _loc2_:Number = _loc1_.x + this._colorPanel.width <= App.stage.stageWidth?Number(_loc1_.x):Number(App.stage.stageWidth - this._colorPanel.width);
         var _loc3_:Number = _loc1_.y + this._colorButton.height;
         _loc3_ = _loc3_ + this._colorPanel.height <= App.stage.stageHeight?Number(_loc3_):Number(_loc1_.y - this._colorPanel.height);
         this._colorPanel.setPosition(_loc2_,_loc3_);
         App.stage.addChild(this._colorPanel);
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.removeColorBox);
      }
      
      public function close() : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.removeColorBox);
         this._colorPanel.remove();
      }
      
      private function removeColorBox(param1:Event = null) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(!this._colorButton.contains(_loc2_) && !this._colorPanel.contains(_loc2_))
         {
            this.close();
         }
      }
      
      private function onColorFieldKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            if(Boolean(this._colorField.text) && this._colorField.text != "-1")
            {
               this.selectedColor = uint("0x" + this._colorField.text);
            }
            else
            {
               this.selectedColor = -1;
            }
            this.close();
            param1.stopPropagation();
         }
      }
      
      private function onColorFieldChange(param1:Event) : void
      {
         if(Boolean(this._colorField.text) && this._colorField.text != "-1")
         {
            this.drawBlock(int("0x" + this._colorField.text));
         }
         else
         {
            this.drawBlock(-1);
         }
      }
      
      private function onColorTilesClick(param1:MouseEvent) : void
      {
         this.selectedColor = this.getColorByMouse();
         this.close();
      }
      
      private function onColorTilesMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:uint = this.getColorByMouse();
         this._colorField.text = _loc2_.toString(16);
         this.drawBlock(_loc2_);
      }
      
      protected function getColorByMouse() : uint
      {
         var _loc1_:int = this._colorTiles.mouseX / this._gridSize;
         var _loc2_:int = this._colorTiles.mouseY / this._gridSize;
         return this._colors[_loc2_ * 20 + _loc1_];
      }
      
      private function drawColorButton(param1:int) : void
      {
         var _loc2_:Graphics = this._colorButton.graphics;
         _loc2_.clear();
         var _loc3_:uint = param1 != -1?uint(param1):uint(16777215);
         _loc2_.beginFill(_loc3_);
         _loc2_.drawRect(0,0,this._colorButton.width,this._colorButton.height);
         _loc2_.endFill();
         if(param1 == -1)
         {
            _loc2_.lineStyle(1,16711680);
            _loc2_.lineTo(this._colorButton.width,this._colorButton.height);
         }
      }
      
      private function drawBlock(param1:int) : void
      {
         var _loc2_:Graphics = this._colorBlock.graphics;
         _loc2_.clear();
         var _loc3_:uint = param1 != -1?uint(param1):uint(16777215);
         _loc2_.beginFill(_loc3_);
         _loc2_.drawRect(0,0,50,20);
         _loc2_.endFill();
         _loc2_.lineStyle(1,this._panelBorderColor);
         _loc2_.drawRect(0,0,50,20);
         if(param1 == -1)
         {
            _loc2_.lineStyle(1,16711680);
            _loc2_.lineTo(50,20);
         }
      }
      
      public function get selectedColor() : int
      {
         return this._selectedColor;
      }
      
      public function set selectedColor(param1:int) : void
      {
         if(this._selectedColor != param1)
         {
            this._selectedColor = param1;
            this._colorField.text = param1.toString(16);
            this.drawBlock(param1);
            callLater(this.changeColor);
            if(this._changeHandler)
            {
               this._changeHandler.executeWith([this._selectedColor]);
            }
            sendEvent(Event.CHANGE);
         }
      }
      
      public function get changeHandler() : Handler
      {
         return this._changeHandler;
      }
      
      public function set changeHandler(param1:Handler) : void
      {
         this._changeHandler = param1;
      }
      
      public function get skin() : String
      {
         return this._colorButton.skin;
      }
      
      public function set skin(param1:String) : void
      {
         this._colorButton.skin = param1;
         callLater(this.changeColor);
      }
      
      private function changeColor() : void
      {
         this.drawColorButton(this._selectedColor);
      }
      
      public function get panelBgColor() : uint
      {
         return this._panelBgColor;
      }
      
      public function set panelBgColor(param1:uint) : void
      {
         this._panelBgColor = param1;
         callLater(this.changePanel);
      }
      
      public function get panelBorderColor() : uint
      {
         return this._panelBorderColor;
      }
      
      public function set panelBorderColor(param1:uint) : void
      {
         this._panelBorderColor = param1;
         callLater(this.changePanel);
      }
      
      public function get panelTextColor() : uint
      {
         return this._panelTextColor;
      }
      
      public function set panelTextColor(param1:uint) : void
      {
         this._panelTextColor = param1;
         callLater(this.changePanel);
      }
      
      public function get panelTextBgColor() : uint
      {
         return this._panelTextBgColor;
      }
      
      public function set panelTextBgColor(param1:uint) : void
      {
         this._panelTextBgColor = param1;
         callLater(this.changePanel);
      }
   }
}
