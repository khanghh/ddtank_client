package morn.core.components
{
   import flash.display.Shape;
   import flash.events.Event;
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
      
      public function ProgressBar(param1:String = null)
      {
         super();
         this.skin = param1;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._bg = new Image());
         addChild(this._bar = new Image());
         addChild(this._mark = new Shape());
         addChild(this._barLabel = new Label());
      }
      
      override protected function initialize() : void
      {
         this._barLabel.width = 200;
         this._barLabel.height = 18;
         this._barLabel.align = "center";
         this._barLabel.stroke = "0x004080";
         this._barLabel.color = 16777215;
         this._bar.mask = this._mark;
      }
      
      public function get skin() : String
      {
         return this._skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(this._skin != param1)
         {
            this._skin = param1;
            this._bg.url = this._skin;
            this._bar.url = this._skin + "$bar";
            _contentWidth = this._bg.width;
            _contentHeight = this._bg.height;
            callLater(this.changeLabelPoint);
            callLater(this.changeValue);
         }
      }
      
      protected function changeLabelPoint() : void
      {
         this._barLabel.x = !!isNaN(this._barLabelX)?Number((width - this._barLabel.width) * 0.5):Number(this._barLabelX);
         this._barLabel.y = !!isNaN(this._barLabelY)?Number((height - this._barLabel.height) * 0.5 - 2):Number(this._barLabelY);
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         if(this._value != param1)
         {
            param1 = param1 > 1?1:param1 < 0?0:Number(param1);
            this._value = param1;
            callLater(this.changeValue);
            sendEvent(Event.CHANGE);
            if(this._changeHandler != null)
            {
               this._changeHandler.executeWith([param1]);
            }
         }
      }
      
      protected function changeValue() : void
      {
         this._mark.graphics.clear();
         var _loc1_:Number = (Number(_width) || Number(this._bar.width)) * this.value;
         var _loc2_:Number = _loc1_ - this._barMaskOffsetX * 2;
         this._mark.graphics.beginFill(0);
         this._mark.graphics.drawRect(this._barMaskOffsetX,this._barMaskOffsetY,_loc2_ < 0?Number(_loc1_):Number(_loc2_),height);
         this._mark.graphics.endFill();
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         if(this._label != param1)
         {
            this._label = param1;
            this._barLabel.text = this._label;
         }
      }
      
      public function get bar() : Image
      {
         return this._bar;
      }
      
      public function get barLabel() : Label
      {
         return this._barLabel;
      }
      
      public function get sizeGrid() : String
      {
         return this._bg.sizeGrid;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._bg.sizeGrid = this._bar.sizeGrid = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._bg.width = _width;
         this._bar.width = _width;
         this._barLabel.width = _width;
         callLater(this.changeLabelPoint);
         callLater(this.changeValue);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._bg.height = _height;
         this._bar.height = _height;
         callLater(this.changeLabelPoint);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is Number || param1 is String)
         {
            this.value = Number(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function set barLabelX(param1:Number) : void
      {
         this._barLabelX = param1;
         callLater(this.changeLabelPoint);
      }
      
      public function get barLabelX() : Number
      {
         return this._barLabelX;
      }
      
      public function set barLabelY(param1:Number) : void
      {
         this._barLabelY = param1;
         callLater(this.changeLabelPoint);
      }
      
      public function get barLabelY() : Number
      {
         return this._barLabelY;
      }
      
      public function set barMaskOffsetX(param1:Number) : void
      {
         this._barMaskOffsetX = param1;
         callLater(this.changeValue);
      }
      
      public function get barMaskOffsetX() : Number
      {
         return this._barMaskOffsetX;
      }
      
      public function set barMaskOffsetY(param1:Number) : void
      {
         this._barMaskOffsetY = param1;
         callLater(this.changeValue);
      }
      
      public function get barMaskOffsetY() : Number
      {
         return this._barMaskOffsetY;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._bg && this._bg.dispose();
         this._bar && this._bar.dispose();
         this._barLabel && this._barLabel.dispose();
         this._bg = null;
         this._bar = null;
         this._barLabel = null;
         this._changeHandler = null;
      }
   }
}
