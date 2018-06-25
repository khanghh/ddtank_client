package ddt.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class PlayerPropertyEvent extends Event
   {
      
      public static const PROPERTY_CHANGE:String = "propertychange";
       
      
      private var _changedProperties:Dictionary;
      
      private var _lastValue:Dictionary;
      
      public function PlayerPropertyEvent(type:String, changedProperties:Dictionary, lastValue:Dictionary = null)
      {
         _changedProperties = changedProperties;
         _lastValue = lastValue;
         super(type);
      }
      
      public function get changedProperties() : Dictionary
      {
         return _changedProperties;
      }
      
      public function get lastValue() : Dictionary
      {
         return _lastValue;
      }
   }
}
