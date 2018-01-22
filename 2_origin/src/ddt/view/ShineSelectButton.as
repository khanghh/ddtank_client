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
      
      public function ShineSelectButton()
      {
         _timer = new Timer(_delay);
         super();
      }
      
      public function set delay(param1:int) : void
      {
         _delay = param1;
      }
      
      public function set shineStyle(param1:String) : void
      {
         if(_shineBg)
         {
            ObjectUtils.disposeObject(_shineBg);
         }
         _shineBg = ComponentFactory.Instance.creat(param1);
         _shineBg.visible = false;
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = ComponentFactory.Instance.creat(param1);
      }
      
      public function set text(param1:String) : void
      {
         if(_textField)
         {
            _textField.text = param1;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_shineBg)
         {
            addChild(_shineBg);
         }
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      public function shine() : void
      {
         _timer.reset();
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
      }
      
      public function stopShine() : void
      {
         if(_timer && _timer.running)
         {
            _timer.reset();
            _timer.removeEventListener("timer",__onTimer);
            _timer.stop();
            _shineBg.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         if(_shineBg)
         {
            ObjectUtils.disposeObject(_shineBg);
            _shineBg = null;
         }
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
            _textField = null;
         }
         super.dispose();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         _shineBg.visible = _timer.currentCount % 2 == 1;
      }
   }
}
