package morn.core.ex
{
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.components.Component;
   import morn.core.components.ISelect;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.Styles;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.core.utils.StringUtils;
   
   public class TabButtonEx extends Component implements ISelect
   {
       
      
      protected var _selected:Boolean;
      
      protected var _clickHandler:Handler;
      
      protected var _tabItemBg:Image;
      
      protected var _tabItemBg2:Image;
      
      protected var _offsets:Array;
      
      protected var _skin:String;
      
      protected var _skins:Array;
      
      protected var _toggle:Boolean;
      
      protected var _lastClickTime:int;
      
      protected var _clickInterval:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      protected var _btnLabel:Label;
      
      protected var _labelMargin:Array;
      
      protected var _labelColors:Array;
      
      protected var _autoSize:Boolean = true;
      
      public function TabButtonEx()
      {
         _offsets = [0,0];
         _labelMargin = Styles.buttonLabelMargin;
         _labelColors = Styles.buttonLabelColors;
         super();
      }
      
      override protected function createChildren() : void
      {
         _tabItemBg = new Image();
         addChild(new Image());
         _tabItemBg2 = new Image();
         addChild(new Image());
         _btnLabel = new Label();
         addChild(new Label());
      }
      
      override protected function initialize() : void
      {
         _btnLabel.align = "center";
         addEventListener("rollOver",onMouse);
         addEventListener("rollOut",onMouse);
         addEventListener("click",onMouse);
         addEventListener("mouseUp",onMouse);
         buttonMode = true;
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
            if(_selected == false)
            {
               filters = null;
            }
            callLater(changeState);
         }
      }
      
      public function set skin(value:String) : void
      {
         if(_skin != value)
         {
            _skin = value;
            changeSkins();
            callLater(changeState);
            callLater(changeLabelSize);
         }
      }
      
      protected function changeLabelSize() : void
      {
         _btnLabel.width = width - _labelMargin[0] - _labelMargin[2];
         _btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height;
         _btnLabel.x = _labelMargin[0];
         _btnLabel.y = (height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
      }
      
      public function set offsets(value:String) : void
      {
         if(String(_offsets) != value)
         {
            _offsets = value.split(",");
            callLater(changeState);
         }
      }
      
      public function set toggle(value:Boolean) : void
      {
         _toggle = value;
      }
      
      public function set showClickTooQuickTip(value:Boolean) : void
      {
         _showClickTooQuickTip = value;
      }
      
      public function set enableRollOverLightEffect(value:Boolean) : void
      {
         _enableRollOverLightEffect = value;
      }
      
      public function set clickInterval(value:int) : void
      {
         _clickInterval = value;
      }
      
      protected function changeState() : void
      {
         var index:int = 0;
         if(_skins)
         {
            _tabItemBg2.visible = _skins[0].length == 2;
            index = !!_selected?1:0;
            _tabItemBg.skin = _skins[index][0];
            if(_tabItemBg2.visible)
            {
               _tabItemBg2.skin = _skins[index][1];
            }
            _tabItemBg2.x = int(_offsets[0]);
            _tabItemBg2.y = int(_offsets[1]);
            _btnLabel.color = _labelColors[0];
         }
      }
      
      protected function changeSkins() : void
      {
         _skins = [];
         var skins:Array = _skin.split(",");
         _skins.push(skins[0].split("|"));
         _skins.push(skins[1].split("|"));
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
      
      public function get clickHandler() : Handler
      {
         return _clickHandler;
      }
      
      public function set clickHandler(value:Handler) : void
      {
         _clickHandler = value;
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
      
      public function get btnLabel() : Label
      {
         return _btnLabel;
      }
      
      override public function dispose() : void
      {
         removeEventListener("rollOver",onMouse);
         removeEventListener("rollOut",onMouse);
         removeEventListener("mouseUp",onMouse);
         removeEventListener("click",onMouse);
         _tabItemBg && _tabItemBg.dispose();
         _tabItemBg2 && _tabItemBg2.dispose();
         _btnLabel && _btnLabel.dispose();
         super.dispose();
         _tabItemBg = null;
         _tabItemBg2 = null;
         _btnLabel = null;
      }
   }
}
