package morn.core.components
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
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
      
      public function Button(skin:String = null, label:String = "")
      {
         _labelColors = Styles.buttonLabelColors;
         _labelMargin = Styles.buttonLabelMargin;
         _stateNum = Styles.buttonStateNum;
         super();
         this.skin = skin;
         this.label = label;
         buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         _content = new Sprite();
         addChild(_content);
         _bitmap = new AutoBitmap();
         _content.addChild(new AutoBitmap());
         _btnLabel = new Label();
         _content.addChild(new Label());
      }
      
      override protected function initialize() : void
      {
         _btnLabel.align = "center";
         addEventListener("rollOver",onMouse);
         addEventListener("rollOut",onMouse);
         addEventListener("mouseDown",onMouse);
         addEventListener("click",onMouse);
         addEventListener("mouseUp",onMouse);
         App.stage.addEventListener("mouseUp",onStageMouseUp);
         _bitmap.sizeGrid = Styles.defaultSizeGrid;
      }
      
      protected function onMouse(e:MouseEvent) : void
      {
         var nowTime:int = 0;
         if(_toggle == false && _selected || _disabled)
         {
            return;
         }
         if(e.type == "click")
         {
            nowTime = getTimer();
            if(nowTime - _lastClickTime >= _clickInterval)
            {
               _lastClickTime = nowTime;
               if(_toggle)
               {
                  selected = !_selected;
               }
               if(_clickHandler)
               {
                  _clickHandler.execute();
               }
            }
            else if(_showClickTooQuickTip)
            {
               App.stage.dispatchEvent(new UIEvent("APP_DDT_MSG","您点击的频率太高，请稍后再试"));
            }
            return;
         }
         if(e.type == "rollOver")
         {
            if(_enableRollOverLightEffect)
            {
               filters = [Styles.singleButtonFilter];
            }
         }
         else if(e.type == "rollOut")
         {
            if(_enableRollOverLightEffect)
            {
               filters = null;
            }
         }
         else if(e.type == "mouseDown")
         {
            if(_enableClickMoveDownEffect)
            {
               _content.x = 1;
               _content.y = 1;
            }
         }
         if(_selected == false)
         {
            state = stateMap[e.type];
         }
      }
      
      private function onStageMouseUp(e:MouseEvent) : void
      {
         if(_enableClickMoveDownEffect)
         {
            _content.x = 0;
            _content.y = 0;
         }
      }
      
      public function set threeURLs(str:String) : void
      {
         _threeURLs = str.split(",");
         callLater(changeState);
      }
      
      public function set twoURLs(str:String) : void
      {
         _twoURLs = str.split(",");
         callLater(changeState);
      }
      
      public function set checkButtonSkin(str:String) : void
      {
         skin = "";
         _twoURLs = [str,str + "$select"];
         callLater(changeState);
      }
      
      public function get label() : String
      {
         return _btnLabel.text;
      }
      
      public function set label(value:String) : void
      {
         if(_btnLabel.text != value)
         {
            _btnLabel.text = value;
            callLater(changeState);
         }
      }
      
      public function set labelHtml(value:String) : void
      {
         _btnLabel.htmlText = value;
         callLater(changeState);
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
            callLater(changeClips);
            callLater(changeLabelSize);
         }
      }
      
      protected function changeClips() : void
      {
         var vec:* = undefined;
         var i:int = 0;
         if(_skin)
         {
            _bitmap.clips = App.asset.getClips(_skin,1,_stateNum);
         }
         if(_imageLabel)
         {
            vec = new Vector.<BitmapData>();
            for(i = 0; i < _imageLabelSkins.length; )
            {
               vec.push(App.asset.getBitmapData(_imageLabelSkins[i]));
               i++;
            }
            _imageLabelClip.clips = vec;
         }
         if(_autoSize)
         {
            _contentWidth = _bitmap.width;
            _contentHeight = _bitmap.height;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeClips);
      }
      
      protected function changeLabelSize() : void
      {
         exeCallLater(changeClips);
         _btnLabel.width = width - _labelMargin[0] - _labelMargin[2];
         _btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height;
         _btnLabel.x = _labelMargin[0];
         _btnLabel.y = (height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected != value)
         {
            _selected = value;
            state = !!_selected?stateMap["selected"]:stateMap["rollOut"];
            if(_selected == false)
            {
               filters = null;
            }
            sendEvent("change");
            sendEvent("select");
         }
      }
      
      protected function get state() : int
      {
         return _state;
      }
      
      protected function set state(value:int) : void
      {
         _state = value;
         callLater(changeState);
      }
      
      protected function changeState() : void
      {
         var index:int = _state;
         if(_stateNum == 2)
         {
            index = index < 2?index:1;
         }
         else if(_stateNum == 1 && !_threeURLs && !_twoURLs)
         {
            index = 0;
         }
         if(_threeURLs)
         {
            skin = _threeURLs[index];
         }
         else if(_twoURLs)
         {
            index = index == 1?0:Number(index == 2?1:0);
            skin = _twoURLs[index];
         }
         else
         {
            if(!bitmap)
            {
               return;
            }
            _bitmap.index = index;
         }
         if(_imageLabel)
         {
            _imageLabelClip.index = index;
         }
         if(_stateNum == 1)
         {
            _btnLabel.color = _labelColors[0];
         }
         else
         {
            _btnLabel.color = _labelColors[_state];
         }
      }
      
      public function get toggle() : Boolean
      {
         return _toggle;
      }
      
      public function set toggle(value:Boolean) : void
      {
         _toggle = value;
      }
      
      override public function set disabled(value:Boolean) : void
      {
         if(_disabled != value)
         {
            state = !!_selected?stateMap["selected"]:stateMap["rollOut"];
            .super.disabled = value;
         }
      }
      
      public function get labelColors() : String
      {
         return String(_labelColors);
      }
      
      public function set labelColors(value:String) : void
      {
         _labelColors = StringUtils.fillArray(_labelColors,value);
         callLater(changeState);
      }
      
      public function get labelMargin() : String
      {
         return String(_labelMargin);
      }
      
      public function set labelMargin(value:String) : void
      {
         _labelMargin = StringUtils.fillArray(_labelMargin,value,int);
         callLater(changeLabelSize);
      }
      
      public function get labelStroke() : String
      {
         return _btnLabel.stroke;
      }
      
      public function set labelStroke(value:String) : void
      {
         _btnLabel.stroke = value;
      }
      
      public function get labelSize() : Object
      {
         return _btnLabel.size;
      }
      
      public function set labelSize(value:Object) : void
      {
         _btnLabel.size = value;
         callLater(changeLabelSize);
      }
      
      public function get labelBold() : Object
      {
         return _btnLabel.bold;
      }
      
      public function set labelBold(value:Object) : void
      {
         _btnLabel.bold = value;
         callLater(changeLabelSize);
      }
      
      public function get letterSpacing() : Object
      {
         return _btnLabel.letterSpacing;
      }
      
      public function set letterSpacing(value:Object) : void
      {
         _btnLabel.letterSpacing = value;
         callLater(changeLabelSize);
      }
      
      public function get labelFont() : String
      {
         return _btnLabel.font;
      }
      
      public function set labelFont(value:String) : void
      {
         _btnLabel.font = value;
         callLater(changeLabelSize);
      }
      
      public function get labelLeading() : Object
      {
         return _btnLabel.leading;
      }
      
      public function set labelLeading(value:Object) : void
      {
         _btnLabel.leading = value;
         callLater(changeLabelSize);
      }
      
      public function get clickHandler() : Handler
      {
         return _clickHandler;
      }
      
      public function set clickHandler(value:Handler) : void
      {
         _clickHandler = value;
      }
      
      public function get btnLabel() : Label
      {
         return _btnLabel;
      }
      
      public function get sizeGrid() : String
      {
         if(_bitmap.sizeGrid)
         {
            return _bitmap.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set sizeGrid(value:String) : void
      {
         _bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,value);
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         if(_autoSize)
         {
            _bitmap.width = value;
         }
         callLater(changeLabelSize);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         if(_autoSize)
         {
            _bitmap.height = value;
         }
         callLater(changeLabelSize);
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is Number || value is String)
         {
            label = String(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get stateNum() : int
      {
         return _stateNum;
      }
      
      public function set stateNum(value:int) : void
      {
         if(_stateNum != value)
         {
            _stateNum = value < 1?1:value > 3?3:value;
            callLater(changeClips);
         }
      }
      
      public function get imageLabel() : String
      {
         return _imageLabel;
      }
      
      public function set imageLabel(value:String) : void
      {
         if(!_imageLabelClip)
         {
            _imageLabelClip = new AutoBitmap();
            _content.addChild(new AutoBitmap());
         }
         _imageLabelSkins = value.split(",");
         _imageLabel = value;
         callLater(changeClips);
      }
      
      public function get imageLabelX() : int
      {
         return _imageLabelX;
      }
      
      public function set imageLabelX(value:int) : void
      {
         _imageLabelX = value;
         _imageLabelClip.x = value;
      }
      
      public function get imageLabelY() : int
      {
         return _imageLabelY;
      }
      
      public function set imageLabelY(value:int) : void
      {
         _imageLabelY = value;
         _imageLabelClip.y = value;
      }
      
      public function get bitmap() : AutoBitmap
      {
         return _bitmap;
      }
      
      public function get imageLabelClip() : AutoBitmap
      {
         return _imageLabelClip;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("rollOver",onMouse);
         removeEventListener("rollOut",onMouse);
         removeEventListener("mouseDown",onMouse);
         removeEventListener("mouseUp",onMouse);
         removeEventListener("click",onMouse);
         App.stage.removeEventListener("mouseUp",onStageMouseUp);
         _bitmap && _bitmap.dispose();
         _btnLabel && _btnLabel.dispose();
         _content = null;
         _bitmap = null;
         _btnLabel = null;
         _clickHandler = null;
         _labelColors = null;
         _labelMargin = null;
      }
      
      public function get enableClickMoveDownEffect() : Boolean
      {
         return _enableClickMoveDownEffect;
      }
      
      public function set enableClickMoveDownEffect(value:Boolean) : void
      {
         _enableClickMoveDownEffect = value;
      }
      
      public function get enableRollOverLightEffect() : Boolean
      {
         return _enableRollOverLightEffect;
      }
      
      public function set enableRollOverLightEffect(value:Boolean) : void
      {
         _enableRollOverLightEffect = value;
      }
      
      public function get clickInterval() : int
      {
         return _clickInterval;
      }
      
      public function set clickInterval(value:int) : void
      {
         _clickInterval = value;
      }
      
      public function get showClickTooQuickTip() : Boolean
      {
         return _showClickTooQuickTip;
      }
      
      public function set showClickTooQuickTip(value:Boolean) : void
      {
         _showClickTooQuickTip = value;
      }
      
      public function get imageLabelSizeGrid() : String
      {
         if(_imageLabelClip.sizeGrid)
         {
            return _imageLabelClip.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set imageLabelSizeGrid(value:String) : void
      {
         _imageLabelClip.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,value);
      }
      
      public function get imageLabelRect() : String
      {
         if(_imageLabelRect)
         {
            return _imageLabelRect.x + "," + _imageLabelRect.y + "," + _imageLabelRect.width + "," + _imageLabelRect.height;
         }
         return null;
      }
      
      public function set imageLabelRect(value:String) : void
      {
         var imageLabelRectArr:Array = StringUtils.fillArray([0,0,0,0],value);
         if(!_imageLabelRect)
         {
            _imageLabelRect = new Rectangle();
         }
         _imageLabelRect.setTo(imageLabelRectArr[0],imageLabelRectArr[1],imageLabelRectArr[2],imageLabelRectArr[3]);
         _imageLabelClip.x = _imageLabelRect.x;
         _imageLabelClip.y = _imageLabelRect.y;
         if(_imageLabelRect.width != 0)
         {
            _imageLabelClip.width = _imageLabelRect.width;
         }
         if(_imageLabelRect.height != 0)
         {
            _imageLabelClip.height = _imageLabelRect.height;
         }
      }
   }
}
