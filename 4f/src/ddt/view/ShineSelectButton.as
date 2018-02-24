package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class ShineSelectButton extends SelectedButton
   {
       
      
      private var _shineBg:DisplayObject;
      
      private var _textField:TextField;
      
      private var _timer:Timer;
      
      private var _delay:int = 200;
      
      public function ShineSelectButton(){super();}
      
      public function set delay(param1:int) : void{}
      
      public function set shineStyle(param1:String) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      public function set text(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      public function shine() : void{}
      
      public function stopShine() : void{}
      
      override public function dispose() : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
   }
}
