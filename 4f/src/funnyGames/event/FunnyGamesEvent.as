package funnyGames.event
{
   import flash.events.Event;
   
   public class FunnyGamesEvent extends Event
   {
      
      public static const RANK_REWARD_UPDATE:String = "rankRewardUpdate";
      
      public static const RANK_UPDATE:String = "rankUpdate";
       
      
      private var _data:Object;
      
      public function FunnyGamesEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : Object{return null;}
   }
}
