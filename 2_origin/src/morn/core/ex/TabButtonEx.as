package morn.core.ex
{
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import morn.core.components.Component;
   import morn.core.components.ISelect;
   import morn.core.components.Image;
   import morn.core.components.Styles;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   
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
      
      public function TabButtonEx()
      {
         this._offsets = [0,0];
         super();
      }
      
      override protected function createChildren() : void
      {
         addChild(this._tabItemBg = new Image());
         addChild(this._tabItemBg2 = new Image());
      }
      
      override protected function initialize() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.onMouse);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouse);
         addEventListener(MouseEvent.CLICK,this.onMouse);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouse);
         buttonMode = true;
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
            if(this._selected == false)
            {
               filters = null;
            }
            callLater(this.changeState);
         }
      }
      
      public function set skin(param1:String) : void
      {
         if(this._skin != param1)
         {
            this._skin = param1;
            this.changeSkins();
            callLater(this.changeState);
         }
      }
      
      public function set offsets(param1:String) : void
      {
         if(String(this._offsets) != param1)
         {
            this._offsets = param1.split(",");
            callLater(this.changeState);
         }
      }
      
      public function set toggle(param1:Boolean) : void
      {
         this._toggle = param1;
      }
      
      public function set showClickTooQuickTip(param1:Boolean) : void
      {
         this._showClickTooQuickTip = param1;
      }
      
      public function set enableRollOverLightEffect(param1:Boolean) : void
      {
         this._enableRollOverLightEffect = param1;
      }
      
      public function set clickInterval(param1:int) : void
      {
         this._clickInterval = param1;
      }
      
      protected function changeState() : void
      {
         var _loc1_:int = 0;
         if(this._skins)
         {
            this._tabItemBg2.visible = Boolean(this._skins[0].length == 2);
            _loc1_ = !!this._selected?1:0;
            this._tabItemBg.skin = this._skins[_loc1_][0];
            if(this._tabItemBg2.visible)
            {
               this._tabItemBg2.skin = this._skins[_loc1_][1];
            }
            this._tabItemBg2.x = int(this._offsets[0]);
            this._tabItemBg2.y = int(this._offsets[1]);
         }
      }
      
      protected function changeSkins() : void
      {
         this._skins = [];
         var _loc1_:Array = this._skin.split(",");
         this._skins.push(_loc1_[0].split("|"));
         this._skins.push(_loc1_[1].split("|"));
      }
      
      public function get clickHandler() : Handler
      {
         return this._clickHandler;
      }
      
      public function set clickHandler(param1:Handler) : void
      {
         this._clickHandler = param1;
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
      }
      
      public function set text(param1:String) : void
      {
      }
      
      public function set stroke(param1:String) : void
      {
      }
      
      public function set size(param1:int) : void
      {
      }
      
      public function set color(param1:uint) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouse);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouse);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouse);
         removeEventListener(MouseEvent.CLICK,this.onMouse);
         this._tabItemBg && this._tabItemBg.dispose();
         this._tabItemBg2 && this._tabItemBg2.dispose();
         super.dispose();
      }
   }
}
