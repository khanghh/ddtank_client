package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class PropertyChangeEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.5.0.20967";
      
      public static const PROPERTY_CHANGE:String = "propertyChange";
       
      
      public var kind:String;
      
      public var newValue:Object;
      
      public var oldValue:Object;
      
      public var property:Object;
      
      public var source:Object;
      
      public function PropertyChangeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null){super(null,null,null);}
      
      public static function createUpdateEvent(param1:Object, param2:Object, param3:Object, param4:Object) : PropertyChangeEvent{return null;}
      
      override public function clone() : Event{return null;}
   }
}
