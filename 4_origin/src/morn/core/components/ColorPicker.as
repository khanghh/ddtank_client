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
         _colors = [];
         super();
         mouseChildren = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _colorPanel && _colorPanel.dispose();
         _colorButton && _colorButton.dispose();
         _colorPanel = null;
         _colorTiles = null;
         _colorBlock = null;
         _colorField = null;
         _colorButton = null;
         _colors = null;
         _changeHandler = null;
      }
      
      override protected function createChildren() : void
      {
         _colorButton = new Button();
         addChild(new Button());
         _colorPanel = new Box();
         _colorPanel.setSize(230,166);
         _colorTiles = new Sprite();
         _colorPanel.addChild(new Sprite());
         _colorBlock = new Shape();
         _colorPanel.addChild(new Shape());
         _colorField = new TextField();
         _colorPanel.addChild(new TextField());
      }
      
      override protected function initialize() : void
      {
         _colorButton.addEventListener("click",onColorButtonClick);
         var _loc1_:int = 5;
         _colorBlock.y = _loc1_;
         _colorBlock.x = _loc1_;
         _colorField.x = 60;
         _colorField.y = 5;
         _colorField.width = 50;
         _colorField.height = 20;
         _colorField.border = true;
         _colorField.background = true;
         _colorField.type = "input";
         _colorField.addEventListener("change",onColorFieldChange);
         _colorField.addEventListener("keyDown",onColorFieldKeyDown);
         _colorTiles.x = 5;
         _colorTiles.y = 30;
         _colorTiles.addEventListener("mouseMove",onColorTilesMouseMove);
         _colorTiles.addEventListener("click",onColorTilesClick);
         panelBgColor = _panelBgColor;
      }
      
      protected function changePanel() : void
      {
         var i:int = 0;
         var j:int = 0;
         var color:* = 0;
         var x:int = 0;
         var y:int = 0;
         var g:Graphics = _colorPanel.graphics;
         g.clear();
         g.beginFill(_panelBgColor);
         g.drawRect(0,0,230,166);
         g.endFill();
         g.lineStyle(1,_panelBorderColor);
         g.drawRect(0,0,230,166);
         drawBlock(_selectedColor);
         _colorField.borderColor = _panelBorderColor;
         _colorField.backgroundColor = _panelTextBgColor;
         _colorField.textColor = _panelTextColor;
         g = _colorTiles.graphics;
         g.clear();
         var mainColors:Array = [0,3355443,6710886,10066329,13421772,16777215,16711680,65280,255,16776960,65535,16711935];
         for(i = 0; i < 12; )
         {
            for(j = 0; j < 20; )
            {
               if(j == 0)
               {
                  color = uint(mainColors[i]);
               }
               else if(j == 1)
               {
                  color = uint(0);
               }
               else
               {
                  color = uint((((i * 3 + j / 6) % 3 << 0) + (i / 6 << 0) * 3) * 51 << 16 | j % 6 * 51 << 8 | (i << 0) % 6 * 51);
               }
               _colors.push(color);
               x = j * _gridSize;
               y = i * _gridSize;
               g.beginFill(0);
               g.drawRect(x,y,_gridSize,_gridSize);
               g.endFill();
               g.beginFill(color);
               g.drawRect(x + 1,y + 1,_gridSize - 1,_gridSize - 1);
               g.endFill();
               j++;
            }
            i++;
         }
         g.lineStyle(1,0,1,true);
         g.moveTo(_gridSize * 20,0);
         g.lineTo(_gridSize * 20,_gridSize * 12);
         g.moveTo(0,_gridSize * 12);
         g.lineTo(_gridSize * 20,_gridSize * 12);
      }
      
      private function onColorButtonClick(e:MouseEvent) : void
      {
         if(_colorPanel.parent)
         {
            close();
         }
         else
         {
            open();
         }
      }
      
      public function open() : void
      {
         var p:Point = localToGlobal(new Point());
         var px:Number = p.x + _colorPanel.width <= App.stage.stageWidth?p.x:Number(App.stage.stageWidth - _colorPanel.width);
         var py:Number = p.y + _colorButton.height;
         py = py + _colorPanel.height <= App.stage.stageHeight?py:Number(p.y - _colorPanel.height);
         _colorPanel.setPosition(px,py);
         App.stage.addChild(_colorPanel);
         App.stage.addEventListener("mouseDown",removeColorBox);
      }
      
      public function close() : void
      {
         App.stage.removeEventListener("mouseDown",removeColorBox);
         _colorPanel.remove();
      }
      
      private function removeColorBox(e:Event = null) : void
      {
         var target:DisplayObject = e.target as DisplayObject;
         if(!_colorButton.contains(target) && !_colorPanel.contains(target))
         {
            close();
         }
      }
      
      private function onColorFieldKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            if(_colorField.text && _colorField.text != "-1")
            {
               selectedColor = uint("0x" + _colorField.text);
            }
            else
            {
               selectedColor = -1;
            }
            close();
            e.stopPropagation();
         }
      }
      
      private function onColorFieldChange(e:Event) : void
      {
         if(_colorField.text && _colorField.text != "-1")
         {
            drawBlock(int("0x" + _colorField.text));
         }
         else
         {
            drawBlock(-1);
         }
      }
      
      private function onColorTilesClick(e:MouseEvent) : void
      {
         selectedColor = getColorByMouse();
         close();
      }
      
      private function onColorTilesMouseMove(e:MouseEvent) : void
      {
         var color:uint = getColorByMouse();
         _colorField.text = color.toString(16);
         drawBlock(color);
      }
      
      protected function getColorByMouse() : uint
      {
         var x:int = _colorTiles.mouseX / _gridSize;
         var y:int = _colorTiles.mouseY / _gridSize;
         return _colors[y * 20 + x];
      }
      
      private function drawColorButton(color:int) : void
      {
         var g:Graphics = _colorButton.graphics;
         g.clear();
         var showColor:uint = color != -1?color:16777215;
         g.beginFill(showColor);
         g.drawRect(0,0,_colorButton.width,_colorButton.height);
         g.endFill();
         if(color == -1)
         {
            g.lineStyle(1,16711680);
            g.lineTo(_colorButton.width,_colorButton.height);
         }
      }
      
      private function drawBlock(color:int) : void
      {
         var g:Graphics = _colorBlock.graphics;
         g.clear();
         var showColor:uint = color != -1?color:16777215;
         g.beginFill(showColor);
         g.drawRect(0,0,50,20);
         g.endFill();
         g.lineStyle(1,_panelBorderColor);
         g.drawRect(0,0,50,20);
         if(color == -1)
         {
            g.lineStyle(1,16711680);
            g.lineTo(50,20);
         }
      }
      
      public function get selectedColor() : int
      {
         return _selectedColor;
      }
      
      public function set selectedColor(value:int) : void
      {
         if(_selectedColor != value)
         {
            _selectedColor = value;
            _colorField.text = value.toString(16);
            drawBlock(value);
            callLater(changeColor);
            if(_changeHandler)
            {
               _changeHandler.executeWith([_selectedColor]);
            }
            sendEvent("change");
         }
      }
      
      public function get changeHandler() : Handler
      {
         return _changeHandler;
      }
      
      public function set changeHandler(value:Handler) : void
      {
         _changeHandler = value;
      }
      
      public function get skin() : String
      {
         return _colorButton.skin;
      }
      
      public function set skin(value:String) : void
      {
         _colorButton.skin = value;
         callLater(changeColor);
      }
      
      private function changeColor() : void
      {
         drawColorButton(_selectedColor);
      }
      
      public function get panelBgColor() : uint
      {
         return _panelBgColor;
      }
      
      public function set panelBgColor(value:uint) : void
      {
         _panelBgColor = value;
         callLater(changePanel);
      }
      
      public function get panelBorderColor() : uint
      {
         return _panelBorderColor;
      }
      
      public function set panelBorderColor(value:uint) : void
      {
         _panelBorderColor = value;
         callLater(changePanel);
      }
      
      public function get panelTextColor() : uint
      {
         return _panelTextColor;
      }
      
      public function set panelTextColor(value:uint) : void
      {
         _panelTextColor = value;
         callLater(changePanel);
      }
      
      public function get panelTextBgColor() : uint
      {
         return _panelTextBgColor;
      }
      
      public function set panelTextBgColor(value:uint) : void
      {
         _panelTextBgColor = value;
         callLater(changePanel);
      }
   }
}
