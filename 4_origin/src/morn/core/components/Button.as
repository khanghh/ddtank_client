package morn.core.components
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Button extends Component implements ISelect
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
      
      protected var _btnLabel:Label;
      
      protected var _clickHandler:Handler;
      
      protected var _labelColors:Array;
      
      protected var _labelMargin:Array;
      
      protected var _state:int;
      
      protected var _toggle:Boolean;
      
      protected var _selected:Boolean;
      
      protected var _skin:String;
      
      protected var _autoSize:Boolean = true;
      
      protected var _stateNum:int;
      
      protected var _threeURLs:Array;
      
      protected var _twoURLs:Array;
      
      protected var _imageLabel:String;
      
      protected var _imageLabelSizeGrid:String;
      
      protected var _imageLabelSkins:Array;
      
      protected var _imageLabelClip:AutoBitmap;
      
      protected var _imageLabelX:int;
      
      protected var _imageLabelY:int;
      
      protected var _imageLabelRect:Rectangle;
      
      protected var _enableClickMoveDownEffect:Boolean = true;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      protected var _clickInterval:int;
      
      private var _lastClickTime:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      public function Button(param1:String = null, param2:String = "")
      {
         this._labelColors = Styles.buttonLabelColors;
         this._labelMargin = Styles.buttonLabelMargin;
         this._stateNum = Styles.buttonStateNum;
         super();
         this.skin = param1;
         this.label = param2;
         buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         this._content = new Sprite();
         addChild(this._content);
         this._content.addChild(this._bitmap = new AutoBitmap());
         this._content.addChild(this._btnLabel = new Label());
      }
      
      override protected function initialize() : void
      {
         this._btnLabel.align = "center";
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
      
      public function set threeURLs(param1:String) : void
      {
         this._threeURLs = param1.split(",");
         callLater(this.changeState);
      }
      
      public function set twoURLs(param1:String) : void
      {
         this._twoURLs = param1.split(",");
         callLater(this.changeState);
      }
      
      public function set checkButtonSkin(param1:String) : void
      {
         this.skin = "";
         this._twoURLs = [param1,param1 + "$select"];
         callLater(this.changeState);
      }
      
      public function get label() : String
      {
         return this._btnLabel.text;
      }
      
      public function set label(param1:String) : void
      {
         if(this._btnLabel.text != param1)
         {
            this._btnLabel.text = param1;
            callLater(this.changeState);
         }
      }
      
      public function set labelHtml(param1:String) : void
      {
         this._btnLabel.htmlText = param1;
         callLater(this.changeState);
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
            callLater(this.changeLabelSize);
         }
      }
      
      protected function changeClips() : void
      {
         var _loc1_:Vector.<BitmapData> = null;
         var _loc2_:int = 0;
         if(this._skin)
         {
            this._bitmap.clips = App.asset.getClips(this._skin,1,this._stateNum);
         }
         if(this._imageLabel)
         {
            _loc1_ = new Vector.<BitmapData>();
            _loc2_ = 0;
            while(_loc2_ < this._imageLabelSkins.length)
            {
               _loc1_.push(App.asset.getBitmapData(this._imageLabelSkins[_loc2_]));
               _loc2_++;
            }
            this._imageLabelClip.clips = _loc1_;
         }
         if(this._autoSize)
         {
            _contentWidth = this._bitmap.width;
            _contentHeight = this._bitmap.height;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeClips);
      }
      
      protected function changeLabelSize() : void
      {
         exeCallLater(this.changeClips);
         this._btnLabel.width = width - this._labelMargin[0] - this._labelMargin[2];
         this._btnLabel.height = ObjectUtils.getTextField(this._btnLabel.format).height;
         this._btnLabel.x = this._labelMargin[0];
         this._btnLabel.y = (height - this._btnLabel.height) * 0.5 + this._labelMargin[1] - this._labelMargin[3];
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
         if(this._stateNum == 2)
         {
            _loc1_ = _loc1_ < 2?int(_loc1_):1;
         }
         else if(this._stateNum == 1 && !this._threeURLs && !this._twoURLs)
         {
            _loc1_ = 0;
         }
         if(this._threeURLs)
         {
            this.skin = this._threeURLs[_loc1_];
         }
         else if(this._twoURLs)
         {
            _loc1_ = _loc1_ == 1?0:_loc1_ == 2?1:0;
            this.skin = this._twoURLs[_loc1_];
         }
         else
         {
            if(!this.bitmap)
            {
               return;
            }
            this._bitmap.index = _loc1_;
         }
         if(this._imageLabel)
         {
            this._imageLabelClip.index = _loc1_;
         }
         if(this._stateNum == 1)
         {
            this._btnLabel.color = this._labelColors[0];
         }
         else
         {
            this._btnLabel.color = this._labelColors[this._state];
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
      
      public function get labelColors() : String
      {
         return String(this._labelColors);
      }
      
      public function set labelColors(param1:String) : void
      {
         this._labelColors = StringUtils.fillArray(this._labelColors,param1);
         callLater(this.changeState);
      }
      
      public function get labelMargin() : String
      {
         return String(this._labelMargin);
      }
      
      public function set labelMargin(param1:String) : void
      {
         this._labelMargin = StringUtils.fillArray(this._labelMargin,param1,int);
         callLater(this.changeLabelSize);
      }
      
      public function get labelStroke() : String
      {
         return this._btnLabel.stroke;
      }
      
      public function set labelStroke(param1:String) : void
      {
         this._btnLabel.stroke = param1;
      }
      
      public function get labelSize() : Object
      {
         return this._btnLabel.size;
      }
      
      public function set labelSize(param1:Object) : void
      {
         this._btnLabel.size = param1;
         callLater(this.changeLabelSize);
      }
      
      public function get labelBold() : Object
      {
         return this._btnLabel.bold;
      }
      
      public function set labelBold(param1:Object) : void
      {
         this._btnLabel.bold = param1;
         callLater(this.changeLabelSize);
      }
      
      public function get letterSpacing() : Object
      {
         return this._btnLabel.letterSpacing;
      }
      
      public function set letterSpacing(param1:Object) : void
      {
         this._btnLabel.letterSpacing = param1;
         callLater(this.changeLabelSize);
      }
      
      public function get labelFont() : String
      {
         return this._btnLabel.font;
      }
      
      public function set labelFont(param1:String) : void
      {
         this._btnLabel.font = param1;
         callLater(this.changeLabelSize);
      }
      
      public function get labelLeading() : Object
      {
         return this._btnLabel.leading;
      }
      
      public function set labelLeading(param1:Object) : void
      {
         this._btnLabel.leading = param1;
         callLater(this.changeLabelSize);
      }
      
      public function get clickHandler() : Handler
      {
         return this._clickHandler;
      }
      
      public function set clickHandler(param1:Handler) : void
      {
         this._clickHandler = param1;
      }
      
      public function get btnLabel() : Label
      {
         return this._btnLabel;
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
         callLater(this.changeLabelSize);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(this._autoSize)
         {
            this._bitmap.height = param1;
         }
         callLater(this.changeLabelSize);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is Number || param1 is String)
         {
            this.label = String(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function get stateNum() : int
      {
         return this._stateNum;
      }
      
      public function set stateNum(param1:int) : void
      {
         if(this._stateNum != param1)
         {
            this._stateNum = param1 < 1?1:param1 > 3?3:int(param1);
            callLater(this.changeClips);
         }
      }
      
      public function get imageLabel() : String
      {
         return this._imageLabel;
      }
      
      public function set imageLabel(param1:String) : void
      {
         if(!this._imageLabelClip)
         {
            this._content.addChild(this._imageLabelClip = new AutoBitmap());
         }
         this._imageLabelSkins = param1.split(",");
         this._imageLabel = param1;
         callLater(this.changeClips);
      }
      
      public function get imageLabelX() : int
      {
         return this._imageLabelX;
      }
      
      public function set imageLabelX(param1:int) : void
      {
         this._imageLabelX = param1;
         this._imageLabelClip.x = param1;
      }
      
      public function get imageLabelY() : int
      {
         return this._imageLabelY;
      }
      
      public function set imageLabelY(param1:int) : void
      {
         this._imageLabelY = param1;
         this._imageLabelClip.y = param1;
      }
      
      public function get bitmap() : AutoBitmap
      {
         return this._bitmap;
      }
      
      public function get imageLabelClip() : AutoBitmap
      {
         return this._imageLabelClip;
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
         this._btnLabel && this._btnLabel.dispose();
         this._content = null;
         this._bitmap = null;
         this._btnLabel = null;
         this._clickHandler = null;
         this._labelColors = null;
         this._labelMargin = null;
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
      
      public function get imageLabelSizeGrid() : String
      {
         if(this._imageLabelClip.sizeGrid)
         {
            return this._imageLabelClip.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set imageLabelSizeGrid(param1:String) : void
      {
         this._imageLabelClip.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,param1);
      }
      
      public function get imageLabelRect() : String
      {
         if(this._imageLabelRect)
         {
            return this._imageLabelRect.x + "," + this._imageLabelRect.y + "," + this._imageLabelRect.width + "," + this._imageLabelRect.height;
         }
         return null;
      }
      
      public function set imageLabelRect(param1:String) : void
      {
         var _loc2_:Array = StringUtils.fillArray([0,0,0,0],param1);
         if(!this._imageLabelRect)
         {
            this._imageLabelRect = new Rectangle();
         }
         this._imageLabelRect.setTo(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
         this._imageLabelClip.x = this._imageLabelRect.x;
         this._imageLabelClip.y = this._imageLabelRect.y;
         if(this._imageLabelRect.width != 0)
         {
            this._imageLabelClip.width = this._imageLabelRect.width;
         }
         if(this._imageLabelRect.height != 0)
         {
            this._imageLabelClip.height = this._imageLabelRect.height;
         }
      }
   }
}
