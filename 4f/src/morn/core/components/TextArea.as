package morn.core.components
{
   import flash.events.Event;
   import morn.core.events.UIEvent;
   
   [Event(name="scroll",type="morn.core.events.UIEvent")]
   public class TextArea extends TextInput
   {
       
      
      protected var _vScrollBar:VScrollBar;
      
      protected var _hScrollBar:HScrollBar;
      
      public function TextArea(param1:String = ""){super(null);}
      
      override protected function initialize() : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      protected function onTextFieldScroll(param1:Event) : void{}
      
      public function get scrollBarSkin() : String{return null;}
      
      public function set scrollBarSkin(param1:String) : void{}
      
      public function get vScrollBarSkin() : String{return null;}
      
      public function set vScrollBarSkin(param1:String) : void{}
      
      public function get hScrollBarSkin() : String{return null;}
      
      public function set hScrollBarSkin(param1:String) : void{}
      
      public function get scrollBar() : VScrollBar{return null;}
      
      public function get vScrollBar() : VScrollBar{return null;}
      
      public function get hScrollBar() : HScrollBar{return null;}
      
      public function get maxScrollV() : int{return 0;}
      
      public function get scrollV() : int{return 0;}
      
      public function get maxScrollH() : int{return 0;}
      
      public function get scrollH() : int{return 0;}
      
      protected function onScrollBarChange(param1:Event) : void{}
      
      private function changeScroll() : void{}
      
      public function scrollTo(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
