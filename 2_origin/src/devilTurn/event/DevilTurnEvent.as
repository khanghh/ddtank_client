package devilTurn.event
{
   import flash.events.Event;
   
   public class DevilTurnEvent extends Event
   {
      
      public static const UPDATE_RANK_LIST:String = "updateranklist";
      
      public static const UPDATE_INFO:String = "updateinfo";
      
      public static const UPDATE_JACKPOT:String = "updatejackpot";
      
      public static const UPDATE_BOX_INFO:String = "updateboxinfo";
      
      public static const UPDATE_ACTIVITY_STATE:String = "updateActivityState";
       
      
      private var _data:Object;
      
      public function DevilTurnEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
