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
      
      public function ScrollBar(skin:String = null)
      {
         _touchScrollEnable = Config.touchScrollEnable;
         _mouseWheelEnable = Config.mouseWheelEnable;
         super();
         this.skin = skin;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         _slider = new Slider();
         addChild(new Slider());
         _upButton = new Button();
         addChild(new Button());
         _downButton = new Button();
         addChild(new Button());
         _upButton.stateNum = 1;
         _upButton.enableClickMoveDownEffect = false;
         _downButton.stateNum = 1;
         _downButton.enableClickMoveDownEffect = false;
      }
      
      override protected function initialize() : void
      {
         _slider.showLabel = false;
         _slider.addEventListener("change",onSliderChange);
         _slider.setSlider(0,0,0);
         _upButton.addEventListener("mouseDown",onButtonMouseDown);
         _downButton.addEventListener("mouseDown",onButtonMouseDown);
      }
      
      protected function onSliderChange(e:Event) : void
      {
         sendEvent("change");
         if(_changeHandler != null)
         {
            _changeHandler.executeWith([value]);
         }
      }
      
      protected function onButtonMouseDown(e:MouseEvent) : void
      {
         var isUp:* = e.currentTarget == _upButton;
         slide(isUp);
         App.timer.doOnce(Styles.scrollBarDelayTime,startLoop,[isUp]);
         App.stage.addEventListener("mouseUp",onStageMouseUp);
      }
      
      protected function startLoop(isUp:Boolean) : void
      {
         App.timer.doFrameLoop(1,slide,[isUp]);
      }
      
      protected function slide(isUp:Boolean) : void
      {
         if(isUp)
         {
            value = value - _scrollSize;
         }
         else
         {
            value = value + _scrollSize;
         }
      }
      
      protected function onStageMouseUp(e:MouseEvent) : void
      {
         App.stage.removeEventListener("mouseUp",onStageMouseUp);
         App.timer.clearTimer(startLoop);
         App.timer.clearTimer(slide);
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
            _slider.skin = _skin;
            callLater(changeScrollBar);
         }
      }
      
      protected function changeScrollBar() : void
      {
         _upButton.visible = _showButtons;
         _downButton.visible = _showButtons;
         if(_showButtons)
         {
            _upButton.skin = _skin + "$up";
            _downButton.skin = _skin + "$down";
         }
         if(_slider.direction == "vertical")
         {
            _slider.y = _upButton.height;
            _slider.x = _sliderOffset;
         }
         else
         {
            _slider.x = _upButton.width;
            _slider.y = _sliderOffset;
         }
         resetPositions();
      }
      
      protected function resetButtonPosition() : void
      {
         if(_slider.direction == "vertical")
         {
            _downButton.y = _slider.y + _slider.height;
            _contentWidth = _slider.width;
            _contentHeight = _downButton.y + _downButton.height;
         }
         else
         {
            _downButton.x = _slider.x + _slider.width;
            _contentWidth = _downButton.x + _downButton.width;
            _contentHeight = _slider.height;
         }
      }
      
      override protected function changeSize() : void
      {
         super.changeSize();
         resetPositions();
      }
      
      private function resetPositions() : void
      {
         if(_slider.direction == "vertical")
         {
            _slider.height = height - _upButton.height - _downButton.height;
         }
         else
         {
            _slider.width = width - _upButton.width - _downButton.width;
         }
         resetButtonPosition();
      }
      
      public function setScroll(min:Number, max:Number, value:Number) : void
      {
         exeCallLater(changeSize);
         _slider.setSlider(min,max,value);
         _upButton.disabled = max <= 0;
         _downButton.disabled = max <= 0;
         _slider.bar.visible = max > 0;
         visible = !(_autoHide && max <= min);
      }
      
      public function get max() : Number
      {
         return _slider.max;
      }
      
      public function set max(value:Number) : void
      {
         _slider.max = value;
      }
      
      public function get min() : Number
      {
         return _slider.min;
      }
      
      public function set min(value:Number) : void
      {
         _slider.min = value;
      }
      
      public function get value() : Number
      {
         return _slider.value;
      }
      
      public function set value(value:Number) : void
      {
         _slider.value = value;
      }
      
      public function get direction() : String
      {
         return _slider.direction;
      }
      
      public function set direction(value:String) : void
      {
         _slider.direction = value;
      }
      
      public function get sizeGrid() : String
      {
         return _slider.sizeGrid;
      }
      
      public function set sizeGrid(value:String) : void
      {
         _slider.sizeGrid = value;
      }
      
      public function get scrollSize() : Number
      {
         return _scrollSize;
      }
      
      public function set scrollSize(value:Number) : void
      {
         _scrollSize = value;
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
      
      public function get thumbPercent() : Number
      {
         return _thumbPercent;
      }
      
      public function set thumbPercent(value:Number) : void
      {
         exeCallLater(changeSize);
         _thumbPercent = value;
         if(_slider.direction == "vertical")
         {
            _slider.bar.height = Math.max(int(_slider.height * value),Styles.scrollBarMinNum);
         }
         else
         {
            _slider.bar.width = Math.max(int(_slider.width * value),Styles.scrollBarMinNum);
         }
      }
      
      public function get target() : InteractiveObject
      {
         return _target;
      }
      
      public function set target(value:InteractiveObject) : void
      {
         if(_target)
         {
            _target.removeEventListener("mouseWheel",onMouseWheel);
            _target.removeEventListener("mouseDown",onTargetMouseDown);
         }
         _target = value;
         if(value)
         {
            if(_mouseWheelEnable)
            {
               _target.addEventListener("mouseWheel",onMouseWheel);
            }
            if(_touchScrollEnable)
            {
               _target.addEventListener("mouseDown",onTargetMouseDown);
            }
         }
      }
      
      public function get touchScrollEnable() : Boolean
      {
         return _touchScrollEnable;
      }
      
      public function set touchScrollEnable(value:Boolean) : void
      {
         _touchScrollEnable = value;
         target = _target;
      }
      
      public function get mouseWheelEnable() : Boolean
      {
         return _mouseWheelEnable;
      }
      
      public function set mouseWheelEnable(value:Boolean) : void
      {
         _mouseWheelEnable = value;
         target = _target;
      }
      
      public function get autoHide() : Boolean
      {
         return _autoHide;
      }
      
      public function set autoHide(value:Boolean) : void
      {
         _autoHide = value;
      }
      
      public function get showButtons() : Boolean
      {
         return _showButtons;
      }
      
      public function set showButtons(value:Boolean) : void
      {
         _showButtons = value;
      }
      
      public function get changeHandler() : Handler
      {
         return _changeHandler;
      }
      
      public function set changeHandler(value:Handler) : void
      {
         _changeHandler = value;
      }
      
      protected function onTargetMouseDown(e:MouseEvent) : void
      {
         App.timer.clearTimer(tweenMove);
         if(!this.contains(e.target as DisplayObject))
         {
            App.stage.addEventListener("mouseUp",onStageMouseUp2);
            App.stage.addEventListener("enterFrame",onStageEnterFrame);
            _lastPoint = new Point(App.stage.mouseX,App.stage.mouseY);
         }
      }
      
      protected function onStageEnterFrame(e:Event) : void
      {
         _lastOffset = _slider.direction == "vertical"?App.stage.mouseY - _lastPoint.y:Number(App.stage.mouseX - _lastPoint.x);
         if(Math.abs(_lastOffset) >= 1)
         {
            _lastPoint.x = App.stage.mouseX;
            _lastPoint.y = App.stage.mouseY;
            value = value - _lastOffset;
         }
      }
      
      protected function onStageMouseUp2(e:MouseEvent) : void
      {
         App.stage.removeEventListener("mouseUp",onStageMouseUp2);
         App.stage.removeEventListener("enterFrame",onStageEnterFrame);
         _lastOffset = _slider.direction == "vertical"?App.stage.mouseY - _lastPoint.y:Number(App.stage.mouseX - _lastPoint.x);
         if(Math.abs(_lastOffset) > 50)
         {
            _lastOffset = _lastOffset > 0?50:-50;
         }
         App.timer.doFrameLoop(1,tweenMove);
      }
      
      private function tweenMove() : void
      {
         _lastOffset = _lastOffset * 0.92;
         value = value - _lastOffset;
         if(Math.abs(_lastOffset) < 0.5)
         {
            App.timer.clearTimer(tweenMove);
         }
      }
      
      public function set sliderOffset(value:Number) : void
      {
         _sliderOffset = value;
      }
      
      public function get sliderOffset() : Number
      {
         return _sliderOffset;
      }
      
      protected function onMouseWheel(e:MouseEvent) : void
      {
         value = value + (e.delta < 0?3:-3) * _scrollSize;
         if(value < max && value > min)
         {
            e.stopPropagation();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         App.timer.clearTimer(tweenMove);
         _upButton && _upButton.dispose();
         _downButton && _downButton.dispose();
         _slider && _slider.dispose();
         _upButton = null;
         _downButton = null;
         _slider = null;
         _changeHandler = null;
         _target = null;
         _lastPoint = null;
      }
      
      public function get slider() : Slider
      {
         return _slider;
      }
      
      public function set slider(value:Slider) : void
      {
         _slider = value;
      }
      
      public function get downButton() : Button
      {
         return _downButton;
      }
      
      public function set downButton(value:Button) : void
      {
         _downButton = value;
      }
      
      public function get upButton() : Button
      {
         return _upButton;
      }
      
      public function set upButton(value:Button) : void
      {
         _upButton = value;
      }
   }
}
