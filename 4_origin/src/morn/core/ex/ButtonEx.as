package morn.core.ex
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.components.AutoBitmap;
   import morn.core.components.Component;
   import morn.core.components.ISelect;
   import morn.core.components.Styles;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class ButtonEx extends Component implements ISelect
   {
      
      protected static var stateMap:Object = {
         "rollOver":1,
         "rollOut":0,
         "mouseDown":2,
         "mouseUp":1,
         "selected":2
      };
       
      
      protected var _content:Sprite;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _image:AutoBitmap;
      
      protected var _clickHandler:Handler;
      
      protected var _state:int;
      
      protected var _toggle:Boolean;
      
      protected var _selected:Boolean;
      
      protected var _skin:String;
      
      protected var _imageLabel:String;
      
      protected var _autoSize:Boolean = true;
      
      protected var _enableClickMoveDownEffect:Boolean = true;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      protected var _clickInterval:int;
      
      private var _lastClickTime:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      public function ButtonEx(param1:String = null, param2:String = "")
      {
         super();
         this.skin = param1;
         this.imageLabel = param2;
         buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         this._content = new Sprite();
         addChild(this._content);
         this._content.addChild(this._bitmap = new AutoBitmap());
      }
      
      override protected function initialize() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.onMouse);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouse);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouse);
         addEventListener(MouseEvent.CLICK,this.onMouse);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouse);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this._bitmap.sizeGrid = Styles.defaultSizeGrid;
      }
      
      protected function onMouse(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this._toggle == false && this._selected || _disabled)
         {
            return;
         }
         if(param1.type == MouseEvent.CLICK)
         {
            _loc2_ = getTimer();
            if(_loc2_ - this._lastClickTime >= this._clickInterval)
            {
               this._lastClickTime = _loc2_;
               if(this._toggle)
               {
                  this.selected = !this._selected;
               }
               if(this._clickHandler)
               {
                  this._clickHandler.execute();
               }
            }
            else if(this._showClickTooQuickTip)
            {
               App.stage.dispatchEvent(new UIEvent(UIEvent.APP_DDT_MSG,"您点击的频率太高，请稍后再试"));
            }
            return;
         }
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            if(this._enableRollOverLightEffect)
            {
               filters = [Styles.singleButtonFilter];
            }
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            if(this._enableRollOverLightEffect)
            {
               filters = null;
            }
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            if(this._enableClickMoveDownEffect)
            {
               this._content.x = 1;
               this._content.y = 1;
            }
         }
         if(this._selected == false)
         {
            this.state = stateMap[param1.type];
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         if(this._enableClickMoveDownEffect)
         {
            this._content.x = 0;
            this._content.y = 0;
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
            callLater(this.changeClips);
         }
      }
      
      protected function changeClips() : void
      {
         if(this._skin)
         {
            this._bitmap.clips = App.asset.getClips(this._skin,1,Styles.buttonStateNum);
         }
         if(this._image)
         {
            this._image.clips = App.asset.getClips(this._imageLabel,1,Styles.buttonStateNum);
         }
         if(this._autoSize)
         {
            _contentWidth = this._bitmap.width;
            _contentHeight = this._bitmap.height;
            this._image.x = (_contentWidth - this._image.width) / 2;
            this._image.y = (_contentHeight - this._image.height) / 2;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeClips);
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            this.state = !!this._selected?int(stateMap["selected"]):int(stateMap["rollOut"]);
            if(this._selected == false)
            {
               filters = null;
            }
            sendEvent(Event.CHANGE);
            sendEvent(Event.SELECT);
         }
      }
      
      protected function get state() : int
      {
         return this._state;
      }
      
      protected function set state(param1:int) : void
      {
         this._state = param1;
         callLater(this.changeState);
      }
      
      protected function changeState() : void
      {
         var _loc1_:int = this._state;
         if(this._bitmap)
         {
            this._bitmap.index = _loc1_;
         }
         if(this._image)
         {
            this._image.index = _loc1_;
         }
      }
      
      public function get toggle() : Boolean
      {
         return this._toggle;
      }
      
      public function set toggle(param1:Boolean) : void
      {
         this._toggle = param1;
      }
      
      override public function set disabled(param1:Boolean) : void
      {
         if(_disabled != param1)
         {
            this.state = !!this._selected?int(stateMap["selected"]):int(stateMap["rollOut"]);
            super.disabled = param1;
         }
      }
      
      public function get clickHandler() : Handler
      {
         return this._clickHandler;
      }
      
      public function set clickHandler(param1:Handler) : void
      {
         this._clickHandler = param1;
      }
      
      public function get sizeGrid() : String
      {
         if(this._bitmap.sizeGrid)
         {
            return this._bitmap.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,param1);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(this._autoSize)
         {
            this._bitmap.width = param1;
         }
         callLater(this.changeClips);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(this._autoSize)
         {
            this._bitmap.height = param1;
         }
         callLater(this.changeClips);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is Number || param1 is String)
         {
            this._imageLabel = String(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function get imageLabel() : String
      {
         return this._imageLabel;
      }
      
      public function set imageLabel(param1:String) : void
      {
         if(this._imageLabel == param1)
         {
            return;
         }
         this._imageLabel = param1;
         if(!this._image)
         {
            this._image = new AutoBitmap();
            this._content.addChild(this._image);
         }
         callLater(this.changeClips);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouse);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouse);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouse);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouse);
         removeEventListener(MouseEvent.CLICK,this.onMouse);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this._bitmap && this._bitmap.dispose();
         this._content = null;
         this._bitmap = null;
         this._clickHandler = null;
      }
      
      public function get enableClickMoveDownEffect() : Boolean
      {
         return this._enableClickMoveDownEffect;
      }
      
      public function set enableClickMoveDownEffect(param1:Boolean) : void
      {
         this._enableClickMoveDownEffect = param1;
      }
      
      public function get enableRollOverLightEffect() : Boolean
      {
         return this._enableRollOverLightEffect;
      }
      
      public function set enableRollOverLightEffect(param1:Boolean) : void
      {
         this._enableRollOverLightEffect = param1;
      }
      
      public function get clickInterval() : int
      {
         return this._clickInterval;
      }
      
      public function set clickInterval(param1:int) : void
      {
         this._clickInterval = param1;
      }
      
      public function get showClickTooQuickTip() : Boolean
      {
         return this._showClickTooQuickTip;
      }
      
      public function set showClickTooQuickTip(param1:Boolean) : void
      {
         this._showClickTooQuickTip = param1;
      }
   }
}
