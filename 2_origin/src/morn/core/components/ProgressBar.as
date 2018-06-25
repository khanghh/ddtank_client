package morn.core.components
{
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ProgressBar extends Component
   {
       
      
      protected var _bg:Image;
      
      protected var _bar:Image;
      
      protected var _skin:String;
      
      protected var _value:Number = 0.5;
      
      protected var _label:String;
      
      protected var _barLabel:Label;
      
      protected var _barLabelX:Number;
      
      protected var _barLabelY:Number;
      
      protected var _changeHandler:Handler;
      
      protected var _mark:Shape;
      
      protected var _barMaskOffsetX:Number = 0;
      
      protected var _barMaskOffsetY:Number = 0;
      
      public function ProgressBar(skin:String = null)
      {
         super();
         this.skin = skin;
      }
      
      override protected function createChildren() : void
      {
         _bg = new Image();
         addChild(new Image());
         _bar = new Image();
         addChild(new Image());
         _mark = new Shape();
         addChild(new Shape());
         _barLabel = new Label();
         addChild(new Label());
      }
      
      override protected function initialize() : void
      {
         _barLabel.width = 200;
         _barLabel.height = 18;
         _barLabel.align = "center";
         _barLabel.stroke = "0x004080";
         _barLabel.color = 16777215;
         _bar.mask = _mark;
      }
      
      public function get skin() : String
      {
         return _skin;
      }
      
      public function set skin(value:String) : void
      {
         if(_skin != value)
         {
            _skin = value;
            _bg.url = _skin;
            _bar.url = _skin + "$bar";
            _contentWidth = _bg.width;
            _contentHeight = _bg.height;
            callLater(changeLabelPoint);
            callLater(changeValue);
         }
      }
      
      protected function changeLabelPoint() : void
      {
         _barLabel.x = !!isNaN(_barLabelX)?(width - _barLabel.width) * 0.5:Number(_barLabelX);
         _barLabel.y = !!isNaN(_barLabelY)?(height - _barLabel.height) * 0.5 - 2:Number(_barLabelY);
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(num:Number) : void
      {
         if(_value != num)
         {
            num = num > 1?1:Number(num < 0?0:Number(num));
            _value = num;
            callLater(changeValue);
            sendEvent("change");
            if(_changeHandler != null)
            {
               _changeHandler.executeWith([num]);
            }
         }
      }
      
      protected function changeValue() : void
      {
         _mark.graphics.clear();
         var w:Number = (_width || Number(_bar.width)) * value;
         var offsetW:Number = w - _barMaskOffsetX * 2;
         _mark.graphics.beginFill(0);
         _mark.graphics.drawRect(_barMaskOffsetX,_barMaskOffsetY,offsetW < 0?w:Number(offsetW),height);
         _mark.graphics.endFill();
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function set label(value:String) : void
      {
         if(_label != value)
         {
            _label = value;
            _barLabel.text = _label;
         }
      }
      
      public function get bar() : Image
      {
         return _bar;
      }
      
      public function get barLabel() : Label
      {
         return _barLabel;
      }
      
      public function get sizeGrid() : String
      {
         return _bg.sizeGrid;
      }
      
      public function set sizeGrid(value:String) : void
      {
         var _loc2_:* = value;
         _bar.sizeGrid = _loc2_;
         _bg.sizeGrid = _loc2_;
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _bg.width = _width;
         _bar.width = _width;
         _barLabel.width = _width;
         callLater(changeLabelPoint);
         callLater(changeValue);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _bg.height = _height;
         _bar.height = _height;
         callLater(changeLabelPoint);
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is Number || value is String)
         {
            this.value = Number(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function set barLabelX(value:Number) : void
      {
         _barLabelX = value;
         callLater(changeLabelPoint);
      }
      
      public function get barLabelX() : Number
      {
         return _barLabelX;
      }
      
      public function set barLabelY(value:Number) : void
      {
         _barLabelY = value;
         callLater(changeLabelPoint);
      }
      
      public function get barLabelY() : Number
      {
         return _barLabelY;
      }
      
      public function set barMaskOffsetX(value:Number) : void
      {
         _barMaskOffsetX = value;
         callLater(changeValue);
      }
      
      public function get barMaskOffsetX() : Number
      {
         return _barMaskOffsetX;
      }
      
      public function set barMaskOffsetY(value:Number) : void
      {
         _barMaskOffsetY = value;
         callLater(changeValue);
      }
      
      public function get barMaskOffsetY() : Number
      {
         return _barMaskOffsetY;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bg && _bg.dispose();
         _bar && _bar.dispose();
         _barLabel && _barLabel.dispose();
         _bg = null;
         _bar = null;
         _barLabel = null;
         _changeHandler = null;
      }
   }
}
