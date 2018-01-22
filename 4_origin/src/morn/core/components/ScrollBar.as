package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class ScrollBar extends Component
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _scrollSize:Number = 1;
      
      protected var _skin:String;
      
      protected var _upButton:Button;
      
      protected var _downButton:Button;
      
      protected var _slider:Slider;
      
      protected var _changeHandler:Handler;
      
      protected var _thumbPercent:Number = 1;
      
      protected var _target:InteractiveObject;
      
      protected var _touchScrollEnable:Boolean;
      
      protected var _mouseWheelEnable:Boolean;
      
      protected var _lastPoint:Point;
      
      protected var _lastOffset:Number = 0;
      
      protected var _autoHide:Boolean = true;
      
      protected var _showButtons:Boolean = true;
      
      protected var _sliderOffset:Number = 1.5;
      
      public function ScrollBar(param1:String = null)
      {
         this._touchScrollEnable = Config.touchScrollEnable;
         this._mouseWheelEnable = Config.mouseWheelEnable;
         super();
         this.skin = param1;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._slider = new Slider());
         addChild(this._upButton = new Button());
         addChild(this._downButton = new Button());
         this._upButton.stateNum = 1;
         this._upButton.enableClickMoveDownEffect = false;
         this._downButton.stateNum = 1;
         this._downButton.enableClickMoveDownEffect = false;
      }
      
      override protected function initialize() : void
      {
         this._slider.showLabel = false;
         this._slider.addEventListener(Event.CHANGE,this.onSliderChange);
         this._slider.setSlider(0,0,0);
         this._upButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDown);
         this._downButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDown);
      }
      
      protected function onSliderChange(param1:Event) : void
      {
         sendEvent(Event.CHANGE);
         if(this._changeHandler != null)
         {
            this._changeHandler.executeWith([this.value]);
         }
      }
      
      protected function onButtonMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.currentTarget == this._upButton;
         this.slide(_loc2_);
         App.timer.doOnce(Styles.scrollBarDelayTime,this.startLoop,[_loc2_]);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
      }
      
      protected function startLoop(param1:Boolean) : void
      {
         App.timer.doFrameLoop(1,this.slide,[param1]);
      }
      
      protected function slide(param1:Boolean) : void
      {
         if(param1)
         {
            this.value = this.value - this._scrollSize;
         }
         else
         {
            this.value = this.value + this._scrollSize;
         }
      }
      
      protected function onStageMouseUp(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         App.timer.clearTimer(this.startLoop);
         App.timer.clearTimer(this.slide);
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
            this._slider.skin = this._skin;
            callLater(this.changeScrollBar);
         }
      }
      
      protected function changeScrollBar() : void
      {
         this._upButton.visible = this._showButtons;
         this._downButton.visible = this._showButtons;
         if(this._showButtons)
         {
            this._upButton.skin = this._skin + "$up";
            this._downButton.skin = this._skin + "$down";
         }
         if(this._slider.direction == VERTICAL)
         {
            this._slider.y = this._upButton.height;
            this._slider.x = this._sliderOffset;
         }
         else
         {
            this._slider.x = this._upButton.width;
            this._slider.y = this._sliderOffset;
         }
         this.resetPositions();
      }
      
      protected function resetButtonPosition() : void
      {
         if(this._slider.direction == VERTICAL)
         {
            this._downButton.y = this._slider.y + this._slider.height;
            _contentWidth = this._slider.width;
            _contentHeight = this._downButton.y + this._downButton.height;
         }
         else
         {
            this._downButton.x = this._slider.x + this._slider.width;
            _contentWidth = this._downButton.x + this._downButton.width;
            _contentHeight = this._slider.height;
         }
      }
      
      override protected function changeSize() : void
      {
         super.changeSize();
         this.resetPositions();
      }
      
      private function resetPositions() : void
      {
         if(this._slider.direction == VERTICAL)
         {
            this._slider.height = height - this._upButton.height - this._downButton.height;
         }
         else
         {
            this._slider.width = width - this._upButton.width - this._downButton.width;
         }
         this.resetButtonPosition();
      }
      
      public function setScroll(param1:Number, param2:Number, param3:Number) : void
      {
         exeCallLater(this.changeSize);
         this._slider.setSlider(param1,param2,param3);
         this._upButton.disabled = param2 <= 0;
         this._downButton.disabled = param2 <= 0;
         this._slider.bar.visible = param2 > 0;
         visible = !(this._autoHide && param2 <= param1);
      }
      
      public function get max() : Number
      {
         return this._slider.max;
      }
      
      public function set max(param1:Number) : void
      {
         this._slider.max = param1;
      }
      
      public function get min() : Number
      {
         return this._slider.min;
      }
      
      public function set min(param1:Number) : void
      {
         this._slider.min = param1;
      }
      
      public function get value() : Number
      {
         return this._slider.value;
      }
      
      public function set value(param1:Number) : void
      {
         this._slider.value = param1;
      }
      
      public function get direction() : String
      {
         return this._slider.direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._slider.direction = param1;
      }
      
      public function get sizeGrid() : String
      {
         return this._slider.sizeGrid;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._slider.sizeGrid = param1;
      }
      
      public function get scrollSize() : Number
      {
         return this._scrollSize;
      }
      
      public function set scrollSize(param1:Number) : void
      {
         this._scrollSize = param1;
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
      
      public function get thumbPercent() : Number
      {
         return this._thumbPercent;
      }
      
      public function set thumbPercent(param1:Number) : void
      {
         exeCallLater(this.changeSize);
         this._thumbPercent = param1;
         if(this._slider.direction == VERTICAL)
         {
            this._slider.bar.height = Math.max(int(this._slider.height * param1),Styles.scrollBarMinNum);
         }
         else
         {
            this._slider.bar.width = Math.max(int(this._slider.width * param1),Styles.scrollBarMinNum);
         }
      }
      
      public function get target() : InteractiveObject
      {
         return this._target;
      }
      
      public function set target(param1:InteractiveObject) : void
      {
         if(this._target)
         {
            this._target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onTargetMouseDown);
         }
         this._target = param1;
         if(param1)
         {
            if(this._mouseWheelEnable)
            {
               this._target.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            }
            if(this._touchScrollEnable)
            {
               this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.onTargetMouseDown);
            }
         }
      }
      
      public function get touchScrollEnable() : Boolean
      {
         return this._touchScrollEnable;
      }
      
      public function set touchScrollEnable(param1:Boolean) : void
      {
         this._touchScrollEnable = param1;
         this.target = this._target;
      }
      
      public function get mouseWheelEnable() : Boolean
      {
         return this._mouseWheelEnable;
      }
      
      public function set mouseWheelEnable(param1:Boolean) : void
      {
         this._mouseWheelEnable = param1;
         this.target = this._target;
      }
      
      public function get autoHide() : Boolean
      {
         return this._autoHide;
      }
      
      public function set autoHide(param1:Boolean) : void
      {
         this._autoHide = param1;
      }
      
      public function get showButtons() : Boolean
      {
         return this._showButtons;
      }
      
      public function set showButtons(param1:Boolean) : void
      {
         this._showButtons = param1;
      }
      
      public function get changeHandler() : Handler
      {
         return this._changeHandler;
      }
      
      public function set changeHandler(param1:Handler) : void
      {
         this._changeHandler = param1;
      }
      
      protected function onTargetMouseDown(param1:MouseEvent) : void
      {
         App.timer.clearTimer(this.tweenMove);
         if(!this.contains(param1.target as DisplayObject))
         {
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp2);
            App.stage.addEventListener(Event.ENTER_FRAME,this.onStageEnterFrame);
            this._lastPoint = new Point(App.stage.mouseX,App.stage.mouseY);
         }
      }
      
      protected function onStageEnterFrame(param1:Event) : void
      {
         this._lastOffset = this._slider.direction == VERTICAL?Number(App.stage.mouseY - this._lastPoint.y):Number(App.stage.mouseX - this._lastPoint.x);
         if(Math.abs(this._lastOffset) >= 1)
         {
            this._lastPoint.x = App.stage.mouseX;
            this._lastPoint.y = App.stage.mouseY;
            this.value = this.value - this._lastOffset;
         }
      }
      
      protected function onStageMouseUp2(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp2);
         App.stage.removeEventListener(Event.ENTER_FRAME,this.onStageEnterFrame);
         this._lastOffset = this._slider.direction == VERTICAL?Number(App.stage.mouseY - this._lastPoint.y):Number(App.stage.mouseX - this._lastPoint.x);
         if(Math.abs(this._lastOffset) > 50)
         {
            this._lastOffset = this._lastOffset > 0?50:-50;
         }
         App.timer.doFrameLoop(1,this.tweenMove);
      }
      
      private function tweenMove() : void
      {
         this._lastOffset = this._lastOffset * 0.92;
         this.value = this.value - this._lastOffset;
         if(Math.abs(this._lastOffset) < 0.5)
         {
            App.timer.clearTimer(this.tweenMove);
         }
      }
      
      public function set sliderOffset(param1:Number) : void
      {
         this._sliderOffset = param1;
      }
      
      public function get sliderOffset() : Number
      {
         return this._sliderOffset;
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
         this.value = this.value + (param1.delta < 0?3:-3) * this._scrollSize;
         if(this.value < this.max && this.value > this.min)
         {
            param1.stopPropagation();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         App.timer.clearTimer(this.tweenMove);
         this._upButton && this._upButton.dispose();
         this._downButton && this._downButton.dispose();
         this._slider && this._slider.dispose();
         this._upButton = null;
         this._downButton = null;
         this._slider = null;
         this._changeHandler = null;
         this._target = null;
         this._lastPoint = null;
      }
      
      public function get slider() : Slider
      {
         return this._slider;
      }
      
      public function set slider(param1:Slider) : void
      {
         this._slider = param1;
      }
      
      public function get downButton() : Button
      {
         return this._downButton;
      }
      
      public function set downButton(param1:Button) : void
      {
         this._downButton = param1;
      }
      
      public function get upButton() : Button
      {
         return this._upButton;
      }
      
      public function set upButton(param1:Button) : void
      {
         this._upButton = param1;
      }
   }
}
