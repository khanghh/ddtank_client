package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class CollectionEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const COLLECTION_CHANGE:String = "collectionChange";
       
      
      public var kind:String;
      
      public var items:Array;
      
      public var location:int;
      
      public var oldLocation:int;
      
      public function CollectionEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:int = -1, param6:int = -1, param7:Array = null){super(null,null,null);}
      
      override public function toString() : String{return null;}
      
      override public function clone() : Event{return null;}
   }
}
