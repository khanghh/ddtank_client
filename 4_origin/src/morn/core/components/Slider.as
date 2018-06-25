package morn.core.components
{
   import flash.display.Shape;
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
      
      public function Slider(skin:String = null)
      {
         _progressMargin = [0,0,0,0];
         _barMargin = [0,0,0,0];
         super();
         this.skin = skin;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         _back = new Image();
         addChild(new Image());
         _bar = new Button();
         addChild(new Button());
         _bar.stateNum = 1;
         _bar.enableClickMoveDownEffect = false;
         _label = new Label();
         addChild(new Label());
         initMask();
      }
      
      override protected function initialize() : void
      {
         _bar.addEventListener("mouseDown",onButtonMouseDown);
         var _loc1_:String = "4,10,4,10";
         _bar.sizeGrid = _loc1_;
         _back.sizeGrid = _loc1_;
         allowBackClick = true;
      }
      
      protected function onButtonMouseDown(e:MouseEvent) : void
      {
         App.stage.addEventListener("mouseUp",onStageMouseUp);
         App.stage.addEventListener("mouseMove",onStageMouseMove);
         if(_direction == "vertical")
         {
            _bar.startDrag(false,new Rectangle(_bar.x,0,0,height - _bar.height));
         }
         else
         {
            _bar.startDrag(false,new Rectangle(0,_bar.y,width - barWidth,0));
         }
         showValueText();
      }
      
      protected function showValueText() : void
      {
         if(_showLabel)
         {
            _label.text = _value + "";
            if(_direction == "vertical")
            {
               _label.x = _bar.x + 20;
               _label.y = (_bar.height - _label.height) * 0.5 + _bar.y;
            }
            else
            {
               _label.y = _bar.y - 20;
               _label.x = (barWidth - _label.width) * 0.5 + _bar.x;
            }
         }
      }
      
      protected function hideValueText() : void
      {
         _label.text = "";
      }
      
      protected function onStageMouseUp(e:MouseEvent) : void
      {
         App.stage.removeEventListener("mouseUp",onStageMouseUp);
         App.stage.removeEventListener("mouseMove",onStageMouseMove);
         _bar.stopDrag();
         hideValueText();
      }
      
      protected function onStageMouseMove(e:MouseEvent) : void
      {
         var oldValue:Number = _value;
         if(_direction == "vertical")
         {
            _value = _bar.y / (height - _bar.height) * (_max - _min) + _min;
         }
         else
         {
            _value = _bar.x / (width - barWidth) * (_max - _min) + _min;
         }
         _value = Math.round(_value / _tick) * _tick;
         if(_value != oldValue)
         {
            showValueText();
            sendChangeEvent();
         }
         updateTexture();
         updateMask();
      }
      
      private function updateTexture() : void
      {
      }
      
      protected function sendChangeEvent() : void
      {
         updateTexture();
         updateMask();
         sendEvent("change");
         if(_changeHandler != null)
         {
            _changeHandler.executeWith([_value]);
         }
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
            _back.url = _skin;
            _bar.skin = _skin + "$bar";
            progressMargin = String(_progressMargin);
            barMargin = String(_barMargin);
            _contentWidth = _back.width;
            _contentHeight = _back.height;
            setBarPoint();
            updateTexture();
            updateMask();
         }
      }
      
      public function set barMargin(value:String) : void
      {
         _barMargin = StringUtils.fillArray(_barMargin,value,int);
         if(_bar.bitmap)
         {
            _bar.bitmap.x = _barMargin[0] + _barMargin[2];
            _bar.bitmap.y = _barMargin[1] + _barMargin[3];
         }
      }
      
      public function get barMargin() : String
      {
         return String(_barMargin);
      }
      
      public function set progressMargin(value:String) : void
      {
         _progressMargin = StringUtils.fillArray(_progressMargin,value,int);
      }
      
      public function get progressMargin() : String
      {
         return String(_progressMargin);
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
         _back.width = width;
         _back.height = height;
         setBarPoint();
      }
      
      protected function setBarPoint() : void
      {
         if(_direction == "vertical")
         {
            _bar.x = (_back.width - barWidth) * 0.5;
         }
         else
         {
            _bar.y = (_back.height - _bar.height) * 0.5;
         }
      }
      
      public function get sizeGrid() : String
      {
         return _back.sizeGrid;
      }
      
      public function set sizeGrid(value:String) : void
      {
         _back.sizeGrid = value;
         _bar.sizeGrid = value;
      }
      
      protected function changeValue() : void
      {
         _value = Math.round(_value / _tick) * _tick;
         _value = _value > _max?_max:Number(_value < _min?_min:Number(_value));
         if(_direction == "vertical")
         {
            _bar.y = (_value - _min) / (_max - _min) * (height - _bar.height);
         }
         else
         {
            _bar.x = (_value - _min) / (_max - _min) * (width - barWidth);
         }
      }
      
      public function setSlider(min:Number, max:Number, value:Number) : void
      {
         _value = -1;
         _min = min;
         _max = max > min?max:Number(min);
         this.value = value < min?min:Number(value > max?max:Number(value));
      }
      
      public function get tick() : Number
      {
         return _tick;
      }
      
      public function set tick(value:Number) : void
      {
         _tick = value;
         callLater(changeValue);
      }
      
      public function get max() : Number
      {
         return _max;
      }
      
      public function set max(value:Number) : void
      {
         if(_max != value)
         {
            _max = value;
            callLater(changeValue);
         }
      }
      
      public function get min() : Number
      {
         return _min;
      }
      
      public function set min(value:Number) : void
      {
         if(_min != value)
         {
            _min = value;
            callLater(changeValue);
         }
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(num:Number) : void
      {
         if(_value != num)
         {
            _value = num;
            changeValue();
            sendChangeEvent();
         }
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function set direction(value:String) : void
      {
         _direction = value;
      }
      
      public function get showLabel() : Boolean
      {
         return _showLabel;
      }
      
      public function set showLabel(value:Boolean) : void
      {
         _showLabel = value;
      }
      
      public function get allowBackClick() : Boolean
      {
         return _allowBackClick;
      }
      
      public function set allowBackClick(value:Boolean) : void
      {
         if(_allowBackClick != value)
         {
            _allowBackClick = value;
            if(_allowBackClick)
            {
               _back.addEventListener("mouseDown",onBackBoxMouseDown);
            }
            else
            {
               _back.removeEventListener("mouseDown",onBackBoxMouseDown);
            }
         }
      }
      
      protected function onBackBoxMouseDown(e:MouseEvent) : void
      {
         if(_direction == "vertical")
         {
            value = _back.mouseY / (height - _bar.height) * (_max - _min) + _min;
         }
         else
         {
            value = _back.mouseX / (width - barWidth) * (_max - _min) + _min;
         }
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
      
      public function get bar() : Button
      {
         return _bar;
      }
      
      protected function get barWidth() : Number
      {
         if(_isBarZero)
         {
            return 0;
         }
         return _bar.width;
      }
      
      public function set isBarZero(value:Boolean) : void
      {
         _isBarZero = value;
      }
      
      public function get changeHandler() : Handler
      {
         return _changeHandler;
      }
      
      public function set changeHandler(value:Handler) : void
      {
         _changeHandler = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _back && _back.dispose();
         _bar && _bar.dispose();
         _label && _label.dispose();
         _back = null;
         _bar = null;
         _label = null;
         _changeHandler = null;
         _progressMargin = null;
         _barMargin = null;
      }
   }
}
