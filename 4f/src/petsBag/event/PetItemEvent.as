package petsBag.event
{
   import flash.events.Event;
   
   public class PetItemEvent extends Event
   {
      
      public static const ITEM_CLICK:String = "itemclick";
      
      public static const DOUBLE_CLICK:String = "doubleclick";
      
      public static const LOCK_CHANGED:String = "lockChanged";
      
      public static const DRAGSTART:String = "dragStart";
      
      public static const DRAGSTOP:String = "dragStop";
      
      public static const EAT_PETS_COMPLETE:String = "eat_pets_complete";
       
      
      public var data:Object;
      
      public var ctrlKey:Boolean;
      
      public function PetItemEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false){super(null,null,null);}
   }
}
