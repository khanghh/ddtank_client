package morn.core.components
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Slider extends Component
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _allowBackClick:Boolean;
      
      protected var _max:Number = 100;
      
      protected var _min:Number = 0;
      
      protected var _tick:Number = 1;
      
      protected var _value:Number = 0;
      
      protected var _direction:String = "vertical";
      
      protected var _skin:String;
      
      protected var _back:Image;
      
      protected var _bar:Button;
      
      protected var _progressMask:Shape;
      
      protected var _label:Label;
      
      protected var _showLabel:Boolean = true;
      
      protected var _changeHandler:Handler;
      
      protected var _progressMargin:Array;
      
      protected var _barMargin:Array;
      
      protected var _isBarZero:Boolean;
      
      public function Slider(param1:String = null)
      {
         this._progressMargin = [0,0,0,0];
         this._barMargin = [0,0,0,0];
         super();
         this.skin = param1;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._back = new Image());
         addChild(this._bar = new Button());
         this._bar.stateNum = 1;
         this._bar.enableClickMoveDownEffect = false;
         addChild(this._label = new Label());
         this.initMask();
      }
      
      override protected function initialize() : void
      {
         this._bar.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDown);
         this._back.sizeGrid = this._bar.sizeGrid = "4,10,4,10";
         this.allowBackClick = true;
      }
      
      protected function onButtonMouseDown(param1:MouseEvent) : void
      {
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         if(this._direction == VERTICAL)
         {
            this._bar.startDrag(false,new Rectangle(this._bar.x,0,0,height - this._bar.height));
         }
         else
         {
            this._bar.startDrag(false,new Rectangle(0,this._bar.y,width - this.barWidth,0));
         }
         this.showValueText();
      }
      
      protected function showValueText() : void
      {
         if(this._showLabel)
         {
            this._label.text = this._value + "";
            if(this._direction == VERTICAL)
            {
               this._label.x = this._bar.x + 20;
               this._label.y = (this._bar.height - this._label.height) * 0.5 + this._bar.y;
            }
            else
            {
               this._label.y = this._bar.y - 20;
               this._label.x = (this.barWidth - this._label.width) * 0.5 + this._bar.x;
            }
         }
      }
      
      protected function hideValueText() : void
      {
         this._label.text = "";
      }
      
      protected function onStageMouseUp(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this._bar.stopDrag();
         this.hideValueText();
      }
      
      protected function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = this._value;
         if(this._direction == VERTICAL)
         {
            this._value = this._bar.y / (height - this._bar.height) * (this._max - this._min) + this._min;
         }
         else
         {
            this._value = this._bar.x / (width - this.barWidth) * (this._max - this._min) + this._min;
         }
         this._value = Math.round(this._value / this._tick) * this._tick;
         if(this._value != _loc2_)
         {
            this.showValueText();
            this.sendChangeEvent();
         }
         this.updateTexture();
         this.updateMask();
      }
      
      private function updateTexture() : void
      {
      }
      
      protected function sendChangeEvent() : void
      {
         this.updateTexture();
         this.updateMask();
         sendEvent(Event.CHANGE);
         if(this._changeHandler != null)
         {
            this._changeHandler.executeWith([this._value]);
         }
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
            this._back.url = this._skin;
            this._bar.skin = this._skin + "$bar";
            this.progressMargin = String(this._progressMargin);
            this.barMargin = String(this._barMargin);
            _contentWidth = this._back.width;
            _contentHeight = this._back.height;
            this.setBarPoint();
            this.updateTexture();
            this.updateMask();
         }
      }
      
      public function set barMargin(param1:String) : void
      {
         this._barMargin = StringUtils.fillArray(this._barMargin,param1,int);
         if(this._bar.bitmap)
         {
            this._bar.bitmap.x = this._barMargin[0] + this._barMargin[2];
            this._bar.bitmap.y = this._barMargin[1] + this._barMargin[3];
         }
      }
      
      public function get barMargin() : String
      {
         return String(this._barMargin);
      }
      
      public function set progressMargin(param1:String) : void
      {
         this._progressMargin = StringUtils.fillArray(this._progressMargin,param1,int);
      }
      
      public function get progressMargin() : String
      {
         return String(this._progressMargin);
      }
      
      protected function initMask() : void
      {
      }
      
      protected function updateMask() : void
      {
      }
      
      override protected function changeSize() : void
      {
         super.changeSize();
         this._back.width = width;
         this._back.height = height;
         this.setBarPoint();
      }
      
      protected function setBarPoint() : void
      {
         if(this._direction == VERTICAL)
         {
            this._bar.x = (this._back.width - this.barWidth) * 0.5;
         }
         else
         {
            this._bar.y = (this._back.height - this._bar.height) * 0.5;
         }
      }
      
      public function get sizeGrid() : String
      {
         return this._back.sizeGrid;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._back.sizeGrid = param1;
         this._bar.sizeGrid = param1;
      }
      
      protected function changeValue() : void
      {
         this._value = Math.round(this._value / this._tick) * this._tick;
         this._value = this._value > this._max?Number(this._max):this._value < this._min?Number(this._min):Number(this._value);
         if(this._direction == VERTICAL)
         {
            this._bar.y = (this._value - this._min) / (this._max - this._min) * (height - this._bar.height);
         }
         else
         {
            this._bar.x = (this._value - this._min) / (this._max - this._min) * (width - this.barWidth);
         }
      }
      
      public function setSlider(param1:Number, param2:Number, param3:Number) : void
      {
         this._value = -1;
         this._min = param1;
         this._max = param2 > param1?Number(param2):Number(param1);
         this.value = param3 < param1?Number(param1):param3 > param2?Number(param2):Number(param3);
      }
      
      public function get tick() : Number
      {
         return this._tick;
      }
      
      public function set tick(param1:Number) : void
      {
         this._tick = param1;
         callLater(this.changeValue);
      }
      
      public function get max() : Number
      {
         return this._max;
      }
      
      public function set max(param1:Number) : void
      {
         if(this._max != param1)
         {
            this._max = param1;
            callLater(this.changeValue);
         }
      }
      
      public function get min() : Number
      {
         return this._min;
      }
      
      public function set min(param1:Number) : void
      {
         if(this._min != param1)
         {
            this._min = param1;
            callLater(this.changeValue);
         }
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            this.changeValue();
            this.sendChangeEvent();
         }
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
      }
      
      public function get showLabel() : Boolean
      {
         return this._showLabel;
      }
      
      public function set showLabel(param1:Boolean) : void
      {
         this._showLabel = param1;
      }
      
      public function get allowBackClick() : Boolean
      {
         return this._allowBackClick;
      }
      
      public function set allowBackClick(param1:Boolean) : void
      {
         if(this._allowBackClick != param1)
         {
            this._allowBackClick = param1;
            if(this._allowBackClick)
            {
               this._back.addEventListener(MouseEvent.MOUSE_DOWN,this.onBackBoxMouseDown);
            }
            else
            {
               this._back.removeEventListener(MouseEvent.MOUSE_DOWN,this.onBackBoxMouseDown);
            }
         }
      }
      
      protected function onBackBoxMouseDown(param1:MouseEvent) : void
      {
         if(this._direction == VERTICAL)
         {
            this.value = this._back.mouseY / (height - this._bar.height) * (this._max - this._min) + this._min;
         }
         else
         {
            this.value = this._back.mouseX / (width - this.barWidth) * (this._max - this._min) + this._min;
         }
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
      
      public function get bar() : Button
      {
         return this._bar;
      }
      
      protected function get barWidth() : Number
      {
         if(this._isBarZero)
         {
            return 0;
         }
         return this._bar.width;
      }
      
      public function set isBarZero(param1:Boolean) : void
      {
         this._isBarZero = param1;
      }
      
      public function get changeHandler() : Handler
      {
         return this._changeHandler;
      }
      
      public function set changeHandler(param1:Handler) : void
      {
         this._changeHandler = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._back && this._back.dispose();
         this._bar && this._bar.dispose();
         this._label && this._label.dispose();
         this._back = null;
         this._bar = null;
         this._label = null;
         this._changeHandler = null;
         this._progressMargin = null;
         this._barMargin = null;
      }
   }
}
