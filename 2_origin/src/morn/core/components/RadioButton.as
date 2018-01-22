package morn.core.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RadioButton extends Button
   {
       
      
      protected var _value:Object;
      
      public function RadioButton(param1:String = null, param2:String = "")
      {
         super(param1,param2);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         _toggle = false;
         _autoSize = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _btnLabel.autoSize = "left";
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      override protected function changeLabelSize() : void
      {
         exeCallLater(changeClips);
         _btnLabel.x = _bitmap.width + _labelMargin[0];
         _btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeLabelSize);
      }
      
      protected function onClick(param1:Event) : void
      {
         selected = true;
      }
      
      public function get value() : Object
      {
         return this._value != null?this._value:label;
      }
      
      public function set value(param1:Object) : void
      {
         this._value = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._value = null;
      }
   }
}
