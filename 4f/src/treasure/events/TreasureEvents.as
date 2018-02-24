package treasure.events
{
   import flash.events.Event;
   
   public class TreasureEvents extends Event
   {
      
      public static const ENTER_TREASURE:String = "enterTreasure";
      
      public static const BEREPAIR_FRIEND_FARM_SEND:String = "beRepairFriendFarmSend";
      
      public static const RETURN_TREASURE:String = "returnTreasure";
      
      public static const BEGIN_GAME:String = "beginGame";
      
      public static const END_GAME:String = "endGame";
      
      public static const DIG:String = "dig";
      
      public static const FIELD_CHANGE:String = "fieldChange";
       
      
      private var _info:Object = null;
      
      public function TreasureEvents(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get info() : Object{return null;}
      
      public function set info(param1:Object) : void{}
   }
}
