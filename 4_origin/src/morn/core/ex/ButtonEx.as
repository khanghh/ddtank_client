package morn.core.ex
{
   import flash.display.Sprite;
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
      
      public function ButtonEx(skin:String = null, imageLabel:String = "")
      {
         super();
         this.skin = skin;
         this.imageLabel = imageLabel;
         buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         _content = new Sprite();
         addChild(_content);
         _bitmap = new AutoBitmap();
         _content.addChild(new AutoBitmap());
      }
      
      override protected function initialize() : void
      {
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
         }
      }
      
      protected function changeClips() : void
      {
         if(_skin)
         {
            _bitmap.clips = App.asset.getClips(_skin,1,Styles.buttonStateNum);
         }
         if(_image)
         {
            _image.clips = App.asset.getClips(_imageLabel,1,Styles.buttonStateNum);
         }
         if(_autoSize)
         {
            _contentWidth = _bitmap.width;
            _contentHeight = _bitmap.height;
            _image.x = (_contentWidth - _image.width) / 2;
            _image.y = (_contentHeight - _image.height) / 2;
         }
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeClips);
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
         if(_bitmap)
         {
            _bitmap.index = index;
         }
         if(_image)
         {
            _image.index = index;
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
      
      public function get clickHandler() : Handler
      {
         return _clickHandler;
      }
      
      public function set clickHandler(value:Handler) : void
      {
         _clickHandler = value;
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
         callLater(changeClips);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         if(_autoSize)
         {
            _bitmap.height = value;
         }
         callLater(changeClips);
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is Number || value is String)
         {
            _imageLabel = String(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get imageLabel() : String
      {
         return _imageLabel;
      }
      
      public function set imageLabel(value:String) : void
      {
         if(_imageLabel == value)
         {
            return;
         }
         _imageLabel = value;
         if(!_image)
         {
            _image = new AutoBitmap();
            _content.addChild(_image);
         }
         callLater(changeClips);
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
         _content = null;
         _bitmap = null;
         _clickHandler = null;
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
   }
}
