package morn.core.components
{
   import flash.events.Event;
   
   [Event(name="scroll",type="morn.core.events.UIEvent")]
   public class TextArea extends TextInput
   {
       
      
      protected var _vScrollBar:VScrollBar;
      
      protected var _hScrollBar:HScrollBar;
      
      public function TextArea(text:String = "")
      {
         super(text);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 180;
         height = 150;
         _textField.wordWrap = true;
         _textField.multiline = true;
         _textField.addEventListener("scroll",onTextFieldScroll);
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         callLater(changeScroll);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         callLater(changeScroll);
      }
      
      protected function onTextFieldScroll(e:Event) : void
      {
         changeScroll();
         sendEvent("scroll");
      }
      
      public function get scrollBarSkin() : String
      {
         return _vScrollBar.skin;
      }
      
      public function set scrollBarSkin(value:String) : void
      {
         vScrollBarSkin = value;
      }
      
      public function get vScrollBarSkin() : String
      {
         return _vScrollBar.skin;
      }
      
      public function set vScrollBarSkin(value:String) : void
      {
         if(_vScrollBar == null)
         {
            _vScrollBar = new VScrollBar();
            addChild(new VScrollBar());
            _vScrollBar.addEventListener("change",onScrollBarChange);
            _vScrollBar.target = _textField;
            callLater(changeScroll);
         }
         _vScrollBar.skin = value;
      }
      
      public function get hScrollBarSkin() : String
      {
         return _hScrollBar.skin;
      }
      
      public function set hScrollBarSkin(value:String) : void
      {
         if(_hScrollBar == null)
         {
            _hScrollBar = new HScrollBar();
            addChild(new HScrollBar());
            _hScrollBar.addEventListener("change",onScrollBarChange);
            _hScrollBar.mouseWheelEnable = false;
            _hScrollBar.target = _textField;
            callLater(changeScroll);
         }
         _hScrollBar.skin = value;
      }
      
      public function get scrollBar() : VScrollBar
      {
         return _vScrollBar;
      }
      
      public function get vScrollBar() : VScrollBar
      {
         return _vScrollBar;
      }
      
      public function get hScrollBar() : HScrollBar
      {
         return _hScrollBar;
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
      
      protected function onScrollBarChange(e:Event) : void
      {
         if(e.currentTarget == _vScrollBar)
         {
            if(_textField.scrollV != _vScrollBar.value)
            {
               _textField.removeEventListener("scroll",onTextFieldScroll);
               _textField.scrollV = _vScrollBar.value;
               _textField.addEventListener("scroll",onTextFieldScroll);
               sendEvent("scroll");
            }
         }
         else if(_textField.scrollH != _hScrollBar.value)
         {
            _textField.removeEventListener("scroll",onTextFieldScroll);
            _textField.scrollH = _hScrollBar.value;
            _textField.addEventListener("scroll",onTextFieldScroll);
            sendEvent("scroll");
         }
      }
      
      private function changeScroll() : void
      {
         var vShow:Boolean = _vScrollBar && _textField.maxScrollV > 1;
         var hShow:Boolean = _hScrollBar && _textField.maxScrollH > 0;
         var showWidth:Number = !!vShow?_width - _vScrollBar.width:Number(_width);
         var showHeight:Number = !!hShow?_height - _hScrollBar.height:Number(_height);
         _textField.width = showWidth - _margin[0] - _margin[2];
         _textField.height = showHeight - _margin[1] - _margin[3];
         if(_vScrollBar)
         {
            _vScrollBar.x = _width - _vScrollBar.width - _margin[2];
            _vScrollBar.y = _margin[1];
            _vScrollBar.height = _height - (!!hShow?_hScrollBar.height:0) - _margin[1] - _margin[3];
            _vScrollBar.scrollSize = 1;
            _vScrollBar.thumbPercent = (_textField.numLines - _textField.maxScrollV + 1) / _textField.numLines;
            _vScrollBar.setScroll(1,_textField.maxScrollV,_textField.scrollV);
         }
         if(_hScrollBar)
         {
            _hScrollBar.x = _margin[0];
            _hScrollBar.y = _height - _hScrollBar.height - _margin[3];
            _hScrollBar.width = _width - (!!vShow?_vScrollBar.width:0) - _margin[0] - _margin[2];
            _hScrollBar.scrollSize = Math.max(showWidth * 0.033,1);
            _hScrollBar.thumbPercent = showWidth / Math.max(_textField.textWidth,showWidth);
            _hScrollBar.setScroll(0,maxScrollH,scrollH);
         }
      }
      
      public function scrollTo(line:int) : void
      {
         commitMeasure();
         _textField.scrollV = line;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _vScrollBar && _vScrollBar.dispose();
         _hScrollBar && _hScrollBar.dispose();
         _vScrollBar = null;
         _hScrollBar = null;
      }
   }
}
