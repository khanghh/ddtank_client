package morn.core.components
{
   import flash.events.Event;
   import morn.core.events.UIEvent;
   
   [Event(name="scroll",type="morn.core.events.UIEvent")]
   public class TextArea extends TextInput
   {
       
      
      protected var _vScrollBar:VScrollBar;
      
      protected var _hScrollBar:HScrollBar;
      
      public function TextArea(param1:String = "")
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.width = 180;
         this.height = 150;
         _textField.wordWrap = true;
         _textField.multiline = true;
         _textField.addEventListener(Event.SCROLL,this.onTextFieldScroll);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         callLater(this.changeScroll);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         callLater(this.changeScroll);
      }
      
      protected function onTextFieldScroll(param1:Event) : void
      {
         this.changeScroll();
         sendEvent(UIEvent.SCROLL);
      }
      
      public function get scrollBarSkin() : String
      {
         return this._vScrollBar.skin;
      }
      
      public function set scrollBarSkin(param1:String) : void
      {
         this.vScrollBarSkin = param1;
      }
      
      public function get vScrollBarSkin() : String
      {
         return this._vScrollBar.skin;
      }
      
      public function set vScrollBarSkin(param1:String) : void
      {
         if(this._vScrollBar == null)
         {
            addChild(this._vScrollBar = new VScrollBar());
            this._vScrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
            this._vScrollBar.target = _textField;
            callLater(this.changeScroll);
         }
         this._vScrollBar.skin = param1;
      }
      
      public function get hScrollBarSkin() : String
      {
         return this._hScrollBar.skin;
      }
      
      public function set hScrollBarSkin(param1:String) : void
      {
         if(this._hScrollBar == null)
         {
            addChild(this._hScrollBar = new HScrollBar());
            this._hScrollBar.addEventListener(Event.CHANGE,this.onScrollBarChange);
            this._hScrollBar.mouseWheelEnable = false;
            this._hScrollBar.target = _textField;
            callLater(this.changeScroll);
         }
         this._hScrollBar.skin = param1;
      }
      
      public function get scrollBar() : VScrollBar
      {
         return this._vScrollBar;
      }
      
      public function get vScrollBar() : VScrollBar
      {
         return this._vScrollBar;
      }
      
      public function get hScrollBar() : HScrollBar
      {
         return this._hScrollBar;
      }
      
      public function get maxScrollV() : int
      {
         return _textField.maxScrollV;
      }
      
      public function get scrollV() : int
      {
         return _textField.scrollV;
      }
      
      public function get maxScrollH() : int
      {
         return _textField.maxScrollH;
      }
      
      public function get scrollH() : int
      {
         return _textField.scrollH;
      }
      
      protected function onScrollBarChange(param1:Event) : void
      {
         if(param1.currentTarget == this._vScrollBar)
         {
            if(_textField.scrollV != this._vScrollBar.value)
            {
               _textField.removeEventListener(Event.SCROLL,this.onTextFieldScroll);
               _textField.scrollV = this._vScrollBar.value;
               _textField.addEventListener(Event.SCROLL,this.onTextFieldScroll);
               sendEvent(UIEvent.SCROLL);
            }
         }
         else if(_textField.scrollH != this._hScrollBar.value)
         {
            _textField.removeEventListener(Event.SCROLL,this.onTextFieldScroll);
            _textField.scrollH = this._hScrollBar.value;
            _textField.addEventListener(Event.SCROLL,this.onTextFieldScroll);
            sendEvent(UIEvent.SCROLL);
         }
      }
      
      private function changeScroll() : void
      {
         var _loc1_:Boolean = this._vScrollBar && _textField.maxScrollV > 1;
         var _loc2_:Boolean = this._hScrollBar && _textField.maxScrollH > 0;
         var _loc3_:Number = !!_loc1_?Number(_width - this._vScrollBar.width):Number(_width);
         var _loc4_:Number = !!_loc2_?Number(_height - this._hScrollBar.height):Number(_height);
         _textField.width = _loc3_ - _margin[0] - _margin[2];
         _textField.height = _loc4_ - _margin[1] - _margin[3];
         if(this._vScrollBar)
         {
            this._vScrollBar.x = _width - this._vScrollBar.width - _margin[2];
            this._vScrollBar.y = _margin[1];
            this._vScrollBar.height = _height - (!!_loc2_?this._hScrollBar.height:0) - _margin[1] - _margin[3];
            this._vScrollBar.scrollSize = 1;
            this._vScrollBar.thumbPercent = (_textField.numLines - _textField.maxScrollV + 1) / _textField.numLines;
            this._vScrollBar.setScroll(1,_textField.maxScrollV,_textField.scrollV);
         }
         if(this._hScrollBar)
         {
            this._hScrollBar.x = _margin[0];
            this._hScrollBar.y = _height - this._hScrollBar.height - _margin[3];
            this._hScrollBar.width = _width - (!!_loc1_?this._vScrollBar.width:0) - _margin[0] - _margin[2];
            this._hScrollBar.scrollSize = Math.max(_loc3_ * 0.033,1);
            this._hScrollBar.thumbPercent = _loc3_ / Math.max(_textField.textWidth,_loc3_);
            this._hScrollBar.setScroll(0,this.maxScrollH,this.scrollH);
         }
      }
      
      public function scrollTo(param1:int) : void
      {
         commitMeasure();
         _textField.scrollV = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._vScrollBar && this._vScrollBar.dispose();
         this._hScrollBar && this._hScrollBar.dispose();
         this._vScrollBar = null;
         this._hScrollBar = null;
      }
   }
}
