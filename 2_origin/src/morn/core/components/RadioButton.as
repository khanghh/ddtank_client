package morn.core.components
{
   import flash.events.Event;
   
   public class RadioButton extends Button
   {
       
      
      protected var _value:Object;
      
      public function RadioButton(skin:String = null, label:String = "")
      {
         super(skin,label);
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
         addEventListener("click",onClick);
      }
      
      override protected function changeLabelSize() : void
      {
         exeCallLater(changeClips);
         _btnLabel.x = _bitmap.width + _labelMargin[0];
         _btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeLabelSize);
      }
      
      protected function onClick(e:Event) : void
      {
         selected = true;
      }
      
      public function get value() : Object
      {
         return _value != null?_value:label;
      }
      
      public function set value(obj:Object) : void
      {
         _value = obj;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _value = null;
      }
   }
}
