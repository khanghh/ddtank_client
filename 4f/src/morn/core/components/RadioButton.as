package morn.core.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RadioButton extends Button
   {
       
      
      protected var _value:Object;
      
      public function RadioButton(param1:String = null, param2:String = ""){super(null,null);}
      
      override protected function preinitialize() : void{}
      
      override protected function initialize() : void{}
      
      override protected function changeLabelSize() : void{}
      
      override public function commitMeasure() : void{}
      
      protected function onClick(param1:Event) : void{}
      
      public function get value() : Object{return null;}
      
      public function set value(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
